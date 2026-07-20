import { NextResponse } from "next/server";
import type { SupabaseClient } from "@supabase/supabase-js";
import { getSupabaseServiceClient } from "@/lib/adminAccess";
import {
  EVENT_TYPES,
  textValue,
  buildEventMetadata,
  validateEventPayload,
  persistEvent,
  isBot,
} from "@/lib/analyticsValidation";
import {
  readBodyWithLimit,
  logAnalyticsOutcome,
  type AnalyticsOutcome,
} from "@/lib/analyticsSecurity";
import {
  getRateLimitStore,
  checkRateLimit,
  sessionLimitForEventType,
  eventLimitClass,
  ANALYTICS_RATE_LIMITS,
  type RateLimitStore,
} from "@/lib/analyticsRateLimit";

/**
 * Public analytics ingestion endpoint.
 *
 * Abuse protection stack (no origin policy by design — this endpoint exposes
 * no private data and performs no privileged action): bot filtering, strict
 * per-event payload validation, session-ID validation, body-size limits,
 * best-effort rate limiting, and database FK/dedup constraints.
 *
 * HTTP semantics — why some responses are non-200:
 * The browser tracker (src/lib/analytics.ts) is strictly fire-and-forget:
 * sendBeacon() never reads the response and the fetch fallback swallows every
 * rejection, so no status code can interrupt or alter a visitor's action.
 * That makes it safe to be honest with abusive or malformed requests:
 *   400 — invalid payload (client bug or probing)
 *   413 — oversized body (aborted mid-stream, never parsed, never hits Supabase)
 *   429 — rate limited (with Retry-After)
 * Internal failures (Supabase/RPC errors, including FK rejection of a
 * valid-but-nonexistent entity UUID) still return 200 {ok:false}: they are
 * handled server-side and must not look like a client signal.
 * Accepted events return 200 {ok:true} — processing completes synchronously
 * before the response, so 202 would be inaccurate.
 */

type TrackDeps = {
  getClient: () => SupabaseClient;
  rateLimitStore: RateLimitStore;
};

const ok = () => NextResponse.json({ ok: true }, { status: 200 });
const okFailed = () => NextResponse.json({ ok: false }, { status: 200 });
const badRequest = () => NextResponse.json({ ok: false }, { status: 400 });
const payloadTooLarge = () => NextResponse.json({ ok: false }, { status: 413 });
const rateLimited = () =>
  NextResponse.json(
    { ok: false },
    {
      status: 429,
      headers: { "Retry-After": String(ANALYTICS_RATE_LIMITS.windowSeconds) },
    },
  );

/** PostgreSQL foreign-key violation (valid-format UUID for a nonexistent entity). */
const PG_FOREIGN_KEY_VIOLATION = "23503";

/**
 * Pure request handler with injectable dependencies (tests supply a mock
 * Supabase client and an isolated rate-limit store; production uses the
 * real service client and the process-local store).
 */
export async function handleTrackRequest(
  request: Request,
  deps: TrackDeps,
): Promise<NextResponse> {
  const startedAt = Date.now();
  let eventType: string | null = null;
  let hasSessionId = false;
  let hasIpHash = false;

  const log = (outcome: AnalyticsOutcome, reasonCode?: string) =>
    logAnalyticsOutcome({
      analytics_event_type: eventType,
      outcome,
      reason_code: reasonCode,
      duration_ms: Date.now() - startedAt,
      has_session_id: hasSessionId,
      has_ip_hash: hasIpHash,
      rate_limit_provider: deps.rateLimitStore.provider,
    });

  try {
    // 1. Drop crawler/bot traffic silently (not logged — pure noise).
    if (isBot(request)) {
      return ok();
    }

    // 2. Body size — streamed with a 4096-byte ceiling; oversized bodies are
    //    aborted mid-stream, never parsed, and never reach Supabase.
    const bodyResult = await readBodyWithLimit(request);
    if (!bodyResult.ok) {
      log("rejected_size", bodyResult.reason);
      return bodyResult.reason === "too_large" ? payloadTooLarge() : badRequest();
    }

    // 3. JSON parse + basic shape.
    let body: Record<string, unknown>;
    try {
      const parsed: unknown = JSON.parse(bodyResult.text || "null");
      if (!parsed || typeof parsed !== "object" || Array.isArray(parsed)) {
        log("rejected_validation", "not_an_object");
        return badRequest();
      }
      body = parsed as Record<string, unknown>;
    } catch {
      log("rejected_validation", "invalid_json");
      return badRequest();
    }

    // 4. Event type.
    eventType = textValue(body.event_type, 40);
    if (!eventType || !EVENT_TYPES.has(eventType)) {
      log("rejected_validation", "unknown_event_type");
      return badRequest();
    }

    // 5. Metadata (salted IP hash, sanitized referrer, validated session ID).
    const metadata = buildEventMetadata(request, body);
    hasSessionId = metadata.session_id !== null;
    hasIpHash = metadata.ip_hash !== null;

    // Session ID is required for every event and must match a format the
    // client actually generates. The raw identifier is never logged.
    if (!metadata.session_id) {
      log("rejected_validation", "invalid_session_id");
      return badRequest();
    }

    // 6. Event-specific payload validation (required fields, no unknown
    //    fields, conservative limits). No database access before this passes.
    const validation = validateEventPayload(eventType, body);
    if (!validation.ok) {
      log("rejected_validation", validation.reason);
      return badRequest();
    }

    // 7. Rate limits. Two dimensions, checked only for structurally valid
    //    requests so garbage can't consume counter capacity:
    //    * per hashed IP across all event types (broad flood protection)
    //    * per session per event class (single-browser abuse)
    //    When the salt/IP is unavailable, the IP dimension is skipped and the
    //    session dimension still applies (reduced protection is visible in
    //    logs via has_ip_hash + rate_limit_provider). The response never
    //    reveals which limit was hit.
    if (metadata.ip_hash) {
      const ipCheck = await checkRateLimit(
        deps.rateLimitStore,
        `ip:${metadata.ip_hash}`,
        ANALYTICS_RATE_LIMITS.allEventsPerIpHashPerMinute,
      );
      if (!ipCheck.allowed) {
        log("rate_limited", "ip");
        return rateLimited();
      }
    }
    const sessionCheck = await checkRateLimit(
      deps.rateLimitStore,
      `sess:${metadata.session_id}:${eventLimitClass(eventType)}`,
      sessionLimitForEventType(eventType),
    );
    if (!sessionCheck.allowed) {
      log("rate_limited", "session");
      return rateLimited();
    }

    // 8. Persist. View events return the RPC's boolean (inserted vs.
    //    deduplicated) — logged for observability, not exposed publicly.
    const result = await persistEvent(deps.getClient(), validation.event, metadata);
    log(result.inserted === false ? "deduplicated" : "accepted");
    return ok();
  } catch (error) {
    // Internal failure: never disrupt the visitor, never leak details.
    // A foreign-key violation is the safe database rejection of a
    // valid-format UUID that references no real entity — classified with its
    // own reason code, without logging the UUID or the PostgreSQL message.
    const pgCode =
      typeof error === "object" && error !== null && "code" in error
        ? String((error as { code: unknown }).code)
        : null;
    const isDbShaped =
      typeof error === "object" && error !== null && "message" in error;
    log(
      isDbShaped ? "database_error" : "unexpected_error",
      pgCode === PG_FOREIGN_KEY_VIOLATION ? "entity_not_found" : undefined,
    );
    return okFailed();
  }
}

export async function POST(request: Request) {
  return handleTrackRequest(request, {
    getClient: getSupabaseServiceClient,
    rateLimitStore: getRateLimitStore(),
  });
}
