// analyticsSecurity.ts
// Request-level protections for POST /api/analytics/track:
//   * streaming body-size enforcement
//   * structured, privacy-safe outcome logging
//
// Abuse protection for this endpoint deliberately does NOT include an
// Origin/Referer/Sec-Fetch-Site rejection policy: the endpoint exposes no
// private data and performs no privileged action, so protection relies on
// strict payload validation, request-size limits, bot filtering, session
// validation, rate limiting, and database constraints instead. The referrer
// is still sanitized (origin-only) before storage.
//
// HTTP-semantics rationale (see route.ts): requests rejected here are either
// malformed or abusive — they get honest 4xx codes because the browser client
// (src/lib/analytics.ts) is fire-and-forget: sendBeacon() ignores responses
// and the fetch fallback swallows every error, so a 4xx can never disrupt a
// visitor. Internal failures (Supabase down, RPC error) still return
// 200 {ok:false}: they are our fault, not the client's, and must not look
// like something the client should react to.

const MAX_BODY_BYTES = 4096; // 4 KB — analytics events are ~300 bytes.

export const ANALYTICS_MAX_BODY_BYTES = MAX_BODY_BYTES;

/* ------------------------------------------------------------ body size */

export type BodyReadResult =
  | { ok: true; text: string }
  | { ok: false; reason: "too_large" | "unreadable" };

/**
 * Reads the request body enforcing a byte ceiling while streaming, so an
 * oversized chunked or headerless body is aborted mid-stream instead of being
 * buffered. The Content-Length header, when present, short-circuits before any
 * body bytes are read — but is never trusted as the only defense because
 * clients can omit or falsify it.
 */
export async function readBodyWithLimit(
  request: Request,
  maxBytes: number = MAX_BODY_BYTES,
): Promise<BodyReadResult> {
  const contentLength = request.headers.get("content-length");
  if (contentLength) {
    const declared = Number(contentLength);
    if (Number.isFinite(declared) && declared > maxBytes) {
      return { ok: false, reason: "too_large" };
    }
  }

  const body = request.body;
  if (!body) return { ok: true, text: "" };

  const reader = body.getReader();
  const chunks: Uint8Array[] = [];
  let received = 0;

  try {
    for (;;) {
      const { done, value } = await reader.read();
      if (done) break;
      if (value) {
        received += value.byteLength;
        if (received > maxBytes) {
          await reader.cancel();
          return { ok: false, reason: "too_large" };
        }
        chunks.push(value);
      }
    }
  } catch {
    return { ok: false, reason: "unreadable" };
  }

  const combined = new Uint8Array(received);
  let offset = 0;
  for (const chunk of chunks) {
    combined.set(chunk, offset);
    offset += chunk.byteLength;
  }
  return { ok: true, text: new TextDecoder().decode(combined) };
}

/* ------------------------------------------------------------ observability */

export type AnalyticsOutcome =
  | "accepted"
  | "deduplicated"
  | "rejected_validation"
  | "rejected_size"
  | "rate_limited"
  | "database_error"
  | "unexpected_error";

export type AnalyticsLogFields = {
  analytics_event_type: string | null;
  outcome: AnalyticsOutcome;
  reason_code?: string;
  duration_ms: number;
  has_session_id: boolean;
  has_ip_hash: boolean;
  rate_limit_provider?: string;
  rate_limit_degraded?: boolean;
};

/**
 * Structured, single-line JSON logging. Privacy rules: never logs raw IPs,
 * raw session IDs, entity UUIDs, search queries, referrers, user agents,
 * database error messages, or payloads — only booleans, enums, and timings.
 *
 * Volume control: rejections and errors always log (they are the abuse /
 * debugging signal and should be rare in healthy traffic); accepted and
 * deduplicated events log only when ANALYTICS_DEBUG=true.
 */
export function logAnalyticsOutcome(fields: AnalyticsLogFields): void {
  const isError =
    fields.outcome === "database_error" || fields.outcome === "unexpected_error";
  const isRejection =
    fields.outcome === "rejected_validation" ||
    fields.outcome === "rejected_size" ||
    fields.outcome === "rate_limited";
  const debugEnabled = process.env.ANALYTICS_DEBUG === "true";

  if (!isError && !isRejection && !debugEnabled) return;

  const line = JSON.stringify({
    source: "analytics_track",
    environment: process.env.VERCEL_ENV ?? process.env.NODE_ENV ?? "unknown",
    ...fields,
  });

  if (isError) console.error(line);
  else if (isRejection) console.warn(line);
  else console.log(line);
}
