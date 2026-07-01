import { NextResponse } from "next/server";
import { createHash } from "crypto";
import { getSupabaseServiceClient } from "@/lib/adminAccess";

const UUID_PATTERN =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;

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
 * Validates and normalizes a text value from request body
 * @param value - The value to validate
 * @param maxLength - Maximum allowed string length
 * @returns Trimmed string or null if invalid
 */
export function textValue(value: unknown, maxLength: number): string | null {
  if (typeof value !== "string") return null;
  const normalized = value.trim();
  return normalized ? normalized.slice(0, maxLength) : null;
}

/**
 * Validates UUID format from request body
 * @param value - The value to validate
 * @returns Valid UUID string or null if invalid
 */
export function uuidValue(value: unknown): string | null {
  const normalized = textValue(value, 36);
  return normalized && UUID_PATTERN.test(normalized) ? normalized : null;
}

/**
 * Sanitizes referrer URL to prevent tracking personal data
 * Keeps only protocol and origin, strips paths
 * @param value - Referrer URL string
 * @returns Sanitized origin or null if invalid
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
 * @param request - The incoming request
 * @returns true if bot detected, false otherwise
 */
export function isBot(request: Request): boolean {
  const userAgent = request.headers.get("user-agent")?.toLowerCase() ?? "";

  // Common bot patterns
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
 * Extracts IP address from request headers
 * @param request - The incoming request
 * @returns IP address string or null if not found
 */
export function getRequestIp(request: Request): string | null {
  const forwardedFor = request.headers.get("x-forwarded-for")?.split(",")[0]?.trim();
  return forwardedFor || request.headers.get("x-real-ip")?.trim() || null;
}

/**
 * Creates a SHA256 hash of IP + salt for privacy-preserving analytics
 * @param request - The incoming request
 * @returns IP hash or null if salt not configured or IP not found
 */
export function hashIp(request: Request): string | null {
  const salt = process.env.ANALYTICS_IP_HASH_SALT;
  const ip = getRequestIp(request);
  if (!salt || !ip) return null;

  return createHash("sha256").update(`${salt}:${ip}`).digest("hex");
}

/**
 * Returns a standardized error response
 * @param error - Error message to send to client
 * @returns NextResponse with 400 status
 */
export function invalid(error: string) {
  return NextResponse.json({ ok: false, error }, { status: 400 });
}

/**
 * Builds common metadata object for analytics events
 * @param request - The incoming request
 * @param body - Request body that may contain custom metadata
 * @returns Metadata object with source, referrer, user_agent, ip_hash
 */
export function buildEventMetadata(
  request: Request,
  body: RequestBody,
): Record<string, unknown> {
  return {
    source: textValue(body.source, 100),
    referrer: sanitizeReferrer(
      textValue(body.referrer, 500) ?? request.headers.get("referer"),
    ),
    user_agent: textValue(request.headers.get("user-agent"), 500),
    ip_hash: hashIp(request),
    session_id: textValue(body.session_id, 100), // Device-level tracking
  };
}

/**
 * Common RPC params shared by every record_*_view function.
 * Dedup (one view per session per day) and the atomic counter increment are
 * enforced inside the database function — see
 * 20260630000000_atomic_dedup_view_tracking.sql.
 */
function viewRpcParams(metadata: Record<string, unknown>) {
  return {
    p_session: (metadata.session_id as string | null) ?? null,
    p_source: (metadata.source as string | null) ?? null,
    p_referrer: (metadata.referrer as string | null) ?? null,
    p_user_agent: (metadata.user_agent as string | null) ?? null,
    p_ip_hash: (metadata.ip_hash as string | null) ?? null,
  };
}

/**
 * Processes artist view event. Insert + dedup + counter increment happen
 * atomically inside record_artist_view (idempotent per session per day).
 */
export async function processArtistViewEvent(
  data: RequestBody,
  metadata: Record<string, unknown>,
): Promise<void> {
  const artistId = uuidValue(data.artist_id);
  if (!artistId) throw new Error("Invalid artist_id");

  const supabase = getSupabaseServiceClient();
  const { error } = await supabase.rpc("record_artist_view", {
    p_artist_id: artistId,
    ...viewRpcParams(metadata),
  });
  if (error) throw error;
}

/**
 * Processes recording view event (atomic dedup + counter increment).
 */
export async function processRecordingViewEvent(
  data: RequestBody,
  metadata: Record<string, unknown>,
): Promise<void> {
  const recordingId = uuidValue(data.recording_id);
  if (!recordingId) throw new Error("Invalid recording_id");

  const supabase = getSupabaseServiceClient();
  const { error } = await supabase.rpc("record_recording_view", {
    p_recording_id: recordingId,
    ...viewRpcParams(metadata),
  });
  if (error) throw error;
}

/**
 * Processes release view event (atomic dedup + counter increment).
 */
export async function processReleaseViewEvent(
  data: RequestBody,
  metadata: Record<string, unknown>,
): Promise<void> {
  const releaseId = uuidValue(data.release_id);
  if (!releaseId) throw new Error("Invalid release_id");

  const supabase = getSupabaseServiceClient();
  const { error } = await supabase.rpc("record_release_view", {
    p_release_id: releaseId,
    ...viewRpcParams(metadata),
  });
  if (error) throw error;
}

/**
 * Processes genre view event (atomic dedup; genres have no counter today).
 */
export async function processGenreViewEvent(
  data: RequestBody,
  metadata: Record<string, unknown>,
): Promise<void> {
  const genreSlug = textValue(data.genre_slug, 160);
  if (!genreSlug) throw new Error("Invalid genre_slug");

  const supabase = getSupabaseServiceClient();
  const { error } = await supabase.rpc("record_genre_view", {
    p_genre_slug: genreSlug,
    ...viewRpcParams(metadata),
  });
  if (error) throw error;
}

/**
 * Processes page view event
 */
export async function processPageViewEvent(
  data: RequestBody,
  metadata: Record<string, unknown>,
): Promise<void> {
  const path = textValue(data.path, 500);
  if (!path) throw new Error("Invalid path");

  const rawEntityId = textValue(data.entity_id, 36);
  const entityId = uuidValue(data.entity_id);
  if (rawEntityId && !entityId) throw new Error("Invalid entity_id");

  const supabase = getSupabaseServiceClient();

  const { error } = await supabase.from("page_view_events").insert({
    path,
    page_type: textValue(data.page_type, 100),
    entity_id: entityId,
    entity_slug: textValue(data.entity_slug, 200),
    referrer: metadata.referrer,
    source: metadata.source,
    user_agent: metadata.user_agent,
  });
  if (error) throw error;
}

/**
 * Processes search event
 */
export async function processSearchEvent(
  data: RequestBody,
  metadata: Record<string, unknown>,
): Promise<void> {
  const query = textValue(data.query, 300);
  const resultsCount = data.results_count;

  if (!query) throw new Error("Invalid query");
  if (!Number.isInteger(resultsCount) || Number(resultsCount) < 0) {
    throw new Error("Invalid results_count");
  }

  const supabase = getSupabaseServiceClient();

  const { error } = await supabase.from("search_events").insert({
    query,
    results_count: Number(resultsCount),
    ...metadata,
  });
  if (error) throw error;
}

/**
 * Processes platform click event
 */
export async function processPlatformClickEvent(
  data: RequestBody,
  metadata: Record<string, unknown>,
): Promise<void> {
  const recordingId = uuidValue(data.recording_id);
  const platform = textValue(data.platform, 100);
  const url = textValue(data.url, 1000);

  if (!recordingId) throw new Error("Invalid recording_id");
  if (!platform) throw new Error("Invalid platform");

  const supabase = getSupabaseServiceClient();

  const { error } = await supabase.from("platform_click_events").insert({
    recording_id: recordingId,
    platform,
    url,
    ...metadata,
  });
  if (error) throw error;
}
