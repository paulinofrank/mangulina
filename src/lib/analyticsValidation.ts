import { createHash } from "crypto";
import type { SupabaseClient } from "@supabase/supabase-js";

const UUID_PATTERN =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

// Legacy visitor-ID fallback emitted by src/lib/analytics.ts when
// crypto.randomUUID is unavailable: `v_${Date.now()}_${Math.random().toString(36).slice(2)}`.
// Accepted so IDs already stored in visitors' localStorage keep deduplicating.
const LEGACY_SESSION_PATTERN = /^v_\d{12,14}_[a-z0-9]{1,16}$/;

const CONTROL_CHARS_GLOBAL = /[\u0000-\u001F\u007F]/g;
const CONTROL_CHARS = /[\u0000-\u001F\u007F]/;

export const EVENT_TYPES = new Set([
  "artist_view",
  "recording_view",
  "release_view",
  "genre_view",
  "page_view",
  "search",
  "platform_click",
]);

type RequestBody = Record<string, unknown>;

/**
 * Validates and normalizes a text value from the request body.
 * Strips control characters, trims, and truncates to maxLength.
 * @returns Normalized string or null if absent/invalid/empty
 */
export function textValue(value: unknown, maxLength: number): string | null {
  if (typeof value !== "string") return null;
  const normalized = value.replace(CONTROL_CHARS_GLOBAL, "").trim();
  return normalized ? normalized.slice(0, maxLength) : null;
}

/**
 * Validates UUID format from request body
 * @returns Valid UUID string or null if invalid
 */
export function uuidValue(value: unknown): string | null {
  if (typeof value !== "string") return null;
  // No truncation before validation: an over-long value is malformed input,
  // not a UUID with trailing noise to be silently repaired.
  const normalized = value.trim();
  return UUID_PATTERN.test(normalized) ? normalized : null;
}

/**
 * Validates a visitor session identifier. Accepts only the two formats the
 * client actually generates (crypto.randomUUID(), or the legacy `v_…`
 * fallback). Free-form text is rejected before any database access so
 * malformed identifiers cannot pollute per-session deduplication.
 * Never substitutes a server-generated ID — that would break stable dedup.
 * @returns The validated session ID or null
 */
export function sessionIdValue(value: unknown): string | null {
  if (typeof value !== "string") return null;
  const normalized = value.trim();
  if (!normalized || normalized.length > 100) return null;
  if (CONTROL_CHARS.test(normalized)) return null;
  if (UUID_PATTERN.test(normalized)) return normalized;
  if (LEGACY_SESSION_PATTERN.test(normalized)) return normalized;
  return null;
}

/**
 * Sanitizes referrer URL to prevent tracking personal data.
 * Keeps only the origin — paths, query strings, and fragments are dropped.
 * Non-HTTP(S) schemes are rejected.
 */
export function sanitizeReferrer(value: string | null): string | null {
  if (!value) return null;

  try {
    const referrer = new URL(value);
    if (referrer.protocol !== "http:" && referrer.protocol !== "https:")
      return null;
    return referrer.origin.slice(0, 500);
  } catch {
    return null;
  }
}

/**
 * Detects if request is from a bot/crawler
 */
export function isBot(request: Request): boolean {
  const userAgent = request.headers.get("user-agent")?.toLowerCase() ?? "";

  const botPatterns = [
    "googlebot",
    "bingbot",
    "slurp",
    "duckduckbot",
    "baiduspider",
    "yandexbot",
    "discordbot",
    "twitterbot",
    "facebookexternalhit",
    "whatsapp",
    "linkedinbot",
    "curl",
    "wget",
    "python",
    "scrapy",
    "robots",
    "crawler",
    "spider",
    "bot",
  ];

  return botPatterns.some(pattern => userAgent.includes(pattern));
}

/**
 * Extracts IP address from request headers. Used ONLY as hash input —
 * raw IPs are never stored or logged anywhere in this pipeline.
 */
export function getRequestIp(request: Request): string | null {
  const forwardedFor = request.headers.get("x-forwarded-for")?.split(",")[0]?.trim();
  return forwardedFor || request.headers.get("x-real-ip")?.trim() || null;
}

/**
 * Creates a SHA256 hash of IP + salt for privacy-preserving analytics.
 * @returns IP hash, or null if the salt is not configured or no IP was found
 */
export function hashIp(request: Request): string | null {
  const salt = process.env.ANALYTICS_IP_HASH_SALT;
  const ip = getRequestIp(request);
  if (!salt || !ip) return null;

  return createHash("sha256").update(`${salt}:${ip}`).digest("hex");
}

/* ------------------------------------------------------------- metadata */

export type EventMetadata = {
  source: string | null;
  referrer: string | null;
  user_agent: string | null;
  ip_hash: string | null;
  session_id: string | null;
};

/**
 * Builds common metadata for analytics events. Empty strings normalize to
 * null; the referrer is reduced to its origin; the session ID is format-
 * validated (invalid values become null and are rejected by the route).
 */
export function buildEventMetadata(
  request: Request,
  body: RequestBody,
): EventMetadata {
  return {
    source: textValue(body.source, 100),
    referrer: sanitizeReferrer(
      textValue(body.referrer, 500) ?? request.headers.get("referer"),
    ),
    user_agent: textValue(request.headers.get("user-agent"), 500),
    ip_hash: hashIp(request),
    session_id: sessionIdValue(body.session_id),
  };
}

/* ------------------------------------------------------ event validation */

export type ValidatedEvent =
  | { event_type: "artist_view"; artist_id: string }
  | { event_type: "recording_view"; recording_id: string }
  | { event_type: "release_view"; release_id: string }
  | { event_type: "genre_view"; genre_slug: string }
  | { event_type: "search"; query: string; results_count: number }
  | {
      event_type: "platform_click";
      recording_id: string;
      platform: string;
      url: string | null;
    }
  | {
      event_type: "page_view";
      path: string;
      page_type: string;
      entity_id: string | null;
      entity_slug: string | null;
    };

export type EventValidationResult =
  | { ok: true; event: ValidatedEvent }
  | { ok: false; reason: string };

const GENRE_SLUG_PATTERN = /^[a-z0-9][a-z0-9_-]{0,159}$/i;
const PLATFORM_PATTERN = /^[a-z0-9][a-z0-9_-]{0,99}$/i;
const PAGE_TYPE_PATTERN = /^[a-z0-9][a-z0-9_-]{0,99}$/i;
const MAX_RESULTS_COUNT = 1_000_000;

// Fields every event may carry, plus the fields each type may carry.
// Anything outside the union is rejected so unexpected fields can never
// flow toward a database insert.
const COMMON_FIELDS = new Set(["event_type", "session_id", "source", "referrer"]);
const TYPE_FIELDS: Record<string, ReadonlySet<string>> = {
  artist_view: new Set(["artist_id"]),
  recording_view: new Set(["recording_id"]),
  release_view: new Set(["release_id"]),
  genre_view: new Set(["genre_slug"]),
  search: new Set(["query", "results_count"]),
  platform_click: new Set(["recording_id", "platform", "url"]),
  page_view: new Set(["path", "page_type", "entity_id", "entity_slug"]),
};

function invalidField(reason: string): EventValidationResult {
  return { ok: false, reason };
}

/**
 * Validates that a request body is a well-formed event of the given type:
 * required fields present and correctly shaped, no unknown fields, and
 * conservative limits on every text field. Pure function — no I/O.
 */
export function validateEventPayload(
  eventType: string,
  body: RequestBody,
): EventValidationResult {
  const allowedTypeFields = TYPE_FIELDS[eventType];
  if (!allowedTypeFields) return invalidField("unknown_event_type");

  for (const key of Object.keys(body)) {
    if (!COMMON_FIELDS.has(key) && !allowedTypeFields.has(key)) {
      return invalidField("unexpected_field");
    }
  }

  switch (eventType) {
    case "artist_view": {
      const artistId = uuidValue(body.artist_id);
      if (!artistId) return invalidField("invalid_artist_id");
      return { ok: true, event: { event_type: "artist_view", artist_id: artistId } };
    }
    case "recording_view": {
      const recordingId = uuidValue(body.recording_id);
      if (!recordingId) return invalidField("invalid_recording_id");
      return {
        ok: true,
        event: { event_type: "recording_view", recording_id: recordingId },
      };
    }
    case "release_view": {
      const releaseId = uuidValue(body.release_id);
      if (!releaseId) return invalidField("invalid_release_id");
      return {
        ok: true,
        event: { event_type: "release_view", release_id: releaseId },
      };
    }
    case "genre_view": {
      const genreSlug = textValue(body.genre_slug, 160);
      if (!genreSlug || !GENRE_SLUG_PATTERN.test(genreSlug)) {
        return invalidField("invalid_genre_slug");
      }
      return { ok: true, event: { event_type: "genre_view", genre_slug: genreSlug } };
    }
    case "search": {
      const query = textValue(body.query, 300);
      if (!query) return invalidField("invalid_query");
      const resultsCount = body.results_count;
      if (
        typeof resultsCount !== "number" ||
        !Number.isInteger(resultsCount) ||
        resultsCount < 0 ||
        resultsCount > MAX_RESULTS_COUNT
      ) {
        return invalidField("invalid_results_count");
      }
      return {
        ok: true,
        event: { event_type: "search", query, results_count: resultsCount },
      };
    }
    case "platform_click": {
      const recordingId = uuidValue(body.recording_id);
      if (!recordingId) return invalidField("invalid_recording_id");
      const platform = textValue(body.platform, 100);
      if (!platform || !PLATFORM_PATTERN.test(platform)) {
        return invalidField("invalid_platform");
      }
      // url is optional; an unparseable or non-HTTP(S) value is dropped (not
      // fatal) so the click itself is still counted.
      let url: string | null = null;
      const rawUrl = textValue(body.url, 1000);
      if (rawUrl) {
        try {
          const parsed = new URL(rawUrl);
          if (parsed.protocol === "http:" || parsed.protocol === "https:") {
            url = rawUrl;
          }
        } catch {
          url = null;
        }
      }
      return {
        ok: true,
        event: {
          event_type: "platform_click",
          recording_id: recordingId,
          platform,
          url,
        },
      };
    }
    case "page_view": {
      const path = textValue(body.path, 500);
      if (!path || !path.startsWith("/")) return invalidField("invalid_path");
      // Internal admin/auth surfaces are excluded client-side; enforce
      // server-side too so they can never enter public analytics.
      if (path.startsWith("/admin") || path.startsWith("/auth")) {
        return invalidField("internal_path");
      }
      const pageType = textValue(body.page_type, 100);
      if (!pageType || !PAGE_TYPE_PATTERN.test(pageType)) {
        return invalidField("invalid_page_type");
      }
      const rawEntityId = textValue(body.entity_id, 36);
      const entityId = uuidValue(body.entity_id);
      if (rawEntityId && !entityId) return invalidField("invalid_entity_id");
      const entitySlug = textValue(body.entity_slug, 200);
      return {
        ok: true,
        event: {
          event_type: "page_view",
          path,
          page_type: pageType,
          entity_id: entityId,
          entity_slug: entitySlug,
        },
      };
    }
    default:
      return invalidField("unknown_event_type");
  }
}

/* ---------------------------------------------------------- persistence */

export type PersistResult = {
  /**
   * For view events: true = new row inserted, false = deduplicated by the
   * database (same entity + session + Dominican day). Null for direct-insert
   * events, which have no dedup semantics.
   */
  inserted: boolean | null;
};

/**
 * Common RPC params shared by every record_*_view function. Dedup (one view
 * per session per day) and the atomic counter increment are enforced inside
 * the database function — see 20260630000000_atomic_dedup_view_tracking.sql.
 */
function viewRpcParams(metadata: EventMetadata) {
  return {
    p_session: metadata.session_id,
    p_source: metadata.source,
    p_referrer: metadata.referrer,
    p_user_agent: metadata.user_agent,
    p_ip_hash: metadata.ip_hash,
  };
}

/**
 * Persists a validated event. View events go through their atomic
 * SECURITY DEFINER RPCs (insert + dedup + counter in one call) and surface
 * the RPC's boolean so callers can log accepted vs. deduplicated. Search,
 * platform-click, and page-view events are direct inserts built from
 * explicitly validated fields only.
 *
 * Entity-existence notes (no extra queries needed):
 *  * View RPCs insert into tables with FK constraints — a valid-but-
 *    nonexistent UUID raises an FK violation, the RPC throws, no orphan row
 *    and no counter update occur.
 *  * platform_click_events has an FK to recordings — same safe failure.
 *  * page_view_events.entity_id has no FK by design (it is an opaque
 *    analytics dimension) — a nonexistent UUID becomes a harmless orphan
 *    value in the event log.
 *
 * @throws on any database error (caller maps to database_error outcome)
 */
export async function persistEvent(
  client: SupabaseClient,
  event: ValidatedEvent,
  metadata: EventMetadata,
): Promise<PersistResult> {
  switch (event.event_type) {
    case "artist_view": {
      const { data, error } = await client.rpc("record_artist_view", {
        p_artist_id: event.artist_id,
        ...viewRpcParams(metadata),
      });
      if (error) throw error;
      return { inserted: typeof data === "boolean" ? data : null };
    }
    case "recording_view": {
      const { data, error } = await client.rpc("record_recording_view", {
        p_recording_id: event.recording_id,
        ...viewRpcParams(metadata),
      });
      if (error) throw error;
      return { inserted: typeof data === "boolean" ? data : null };
    }
    case "release_view": {
      const { data, error } = await client.rpc("record_release_view", {
        p_release_id: event.release_id,
        ...viewRpcParams(metadata),
      });
      if (error) throw error;
      return { inserted: typeof data === "boolean" ? data : null };
    }
    case "genre_view": {
      const { data, error } = await client.rpc("record_genre_view", {
        p_genre_slug: event.genre_slug,
        ...viewRpcParams(metadata),
      });
      if (error) throw error;
      return { inserted: typeof data === "boolean" ? data : null };
    }
    case "search": {
      const { error } = await client.from("search_events").insert({
        query: event.query,
        results_count: event.results_count,
        source: metadata.source,
        referrer: metadata.referrer,
        user_agent: metadata.user_agent,
        ip_hash: metadata.ip_hash,
        session_id: metadata.session_id,
      });
      if (error) throw error;
      return { inserted: null };
    }
    case "platform_click": {
      const { error } = await client.from("platform_click_events").insert({
        recording_id: event.recording_id,
        platform: event.platform,
        url: event.url,
        source: metadata.source,
        referrer: metadata.referrer,
        user_agent: metadata.user_agent,
        ip_hash: metadata.ip_hash,
        session_id: metadata.session_id,
      });
      if (error) throw error;
      return { inserted: null };
    }
    case "page_view": {
      const { error } = await client.from("page_view_events").insert({
        path: event.path,
        page_type: event.page_type,
        entity_id: event.entity_id,
        entity_slug: event.entity_slug,
        referrer: metadata.referrer,
        source: metadata.source,
        user_agent: metadata.user_agent,
        session_id: metadata.session_id,
      });
      if (error) throw error;
      return { inserted: null };
    }
  }
}
