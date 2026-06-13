import { createHash } from "crypto";
import { NextResponse } from "next/server";
import { getSupabaseServiceClient } from "@/lib/adminAccess";

const UUID_PATTERN =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;
const EVENT_TYPES = new Set([
  "artist_view",
  "recording_view",
  "release_view",
  "genre_view",
  "search",
  "platform_click",
]);

type RequestBody = Record<string, unknown>;

function textValue(value: unknown, maxLength: number) {
  if (typeof value !== "string") return null;
  const normalized = value.trim();
  return normalized ? normalized.slice(0, maxLength) : null;
}

function uuidValue(value: unknown) {
  const normalized = textValue(value, 36);
  return normalized && UUID_PATTERN.test(normalized) ? normalized : null;
}

function sanitizeReferrer(value: string | null) {
  if (!value) return null;

  try {
    const referrer = new URL(value);
    if (referrer.protocol !== "http:" && referrer.protocol !== "https:") return null;
    return `${referrer.origin}${referrer.pathname}`.slice(0, 500);
  } catch {
    return null;
  }
}

function getRequestIp(request: Request) {
  const forwardedFor = request.headers.get("x-forwarded-for")?.split(",")[0]?.trim();
  return forwardedFor || request.headers.get("x-real-ip")?.trim() || null;
}

function hashIp(request: Request) {
  const salt = process.env.ANALYTICS_IP_HASH_SALT;
  const ip = getRequestIp(request);
  if (!salt || !ip) return null;

  return createHash("sha256").update(`${salt}:${ip}`).digest("hex");
}

function invalid(error: string) {
  return NextResponse.json({ ok: false, error }, { status: 400 });
}

export async function POST(request: Request) {
  let body: RequestBody;

  try {
    const parsed: unknown = await request.json();
    if (!parsed || typeof parsed !== "object" || Array.isArray(parsed)) {
      return invalid("Request body must be a JSON object.");
    }
    body = parsed as RequestBody;
  } catch {
    return invalid("Invalid JSON body.");
  }

  const eventType = textValue(body.event_type, 40);
  if (!eventType || !EVENT_TYPES.has(eventType)) {
    return invalid("Invalid event_type.");
  }

  const metadata = {
    source: textValue(body.source, 100),
    referrer: sanitizeReferrer(request.headers.get("referer")),
    user_agent: textValue(request.headers.get("user-agent"), 500),
    ip_hash: hashIp(request),
  };
  const supabase = getSupabaseServiceClient();

  try {
    if (eventType === "artist_view") {
      const artistId = uuidValue(body.artist_id);
      if (!artistId) return invalid("artist_id must be a valid UUID.");

      const { error } = await supabase
        .from("artist_view_events")
        .insert({ artist_id: artistId, ...metadata });
      if (error) throw error;

      const { error: incrementError } = await supabase.rpc("increment_artist_views", {
        p_artist_id: artistId,
      });
      if (incrementError) throw incrementError;
    }

    if (eventType === "recording_view") {
      const recordingId = uuidValue(body.recording_id);
      if (!recordingId) return invalid("recording_id must be a valid UUID.");

      const { error } = await supabase
        .from("recording_view_events")
        .insert({ recording_id: recordingId, ...metadata });
      if (error) throw error;

      const { error: incrementError } = await supabase.rpc("increment_recording_views", {
        p_recording_id: recordingId,
      });
      if (incrementError) throw incrementError;
    }

    if (eventType === "release_view") {
      const releaseId = uuidValue(body.release_id);
      if (!releaseId) return invalid("release_id must be a valid UUID.");

      const { error } = await supabase
        .from("release_view_events")
        .insert({ release_id: releaseId, ...metadata });
      if (error) throw error;
    }

    if (eventType === "genre_view") {
      const genreSlug = textValue(body.genre_slug, 160);
      if (!genreSlug) return invalid("genre_slug is required.");

      const { error } = await supabase
        .from("genre_view_events")
        .insert({ genre_slug: genreSlug, ...metadata });
      if (error) throw error;
    }

    if (eventType === "search") {
      const query = textValue(body.query, 300);
      const resultsCount = body.results_count;
      if (!query) return invalid("query is required.");
      if (!Number.isInteger(resultsCount) || Number(resultsCount) < 0) {
        return invalid("results_count must be a non-negative integer.");
      }

      const { error } = await supabase.from("search_events").insert({
        query,
        results_count: Number(resultsCount),
        ...metadata,
      });
      if (error) throw error;
    }

    if (eventType === "platform_click") {
      const recordingId = uuidValue(body.recording_id);
      const platform = textValue(body.platform, 100);
      const url = textValue(body.url, 1000);
      if (!recordingId) return invalid("recording_id must be a valid UUID.");
      if (!platform) return invalid("platform is required.");

      const { error } = await supabase.from("platform_click_events").insert({
        recording_id: recordingId,
        platform,
        url,
        ...metadata,
      });
      if (error) throw error;
    }

    return NextResponse.json({ ok: true });
  } catch (error) {
    console.error("Analytics tracking failed:", error);
    return NextResponse.json(
      { ok: false, error: "Unable to record analytics event." },
      { status: 500 },
    );
  }
}
