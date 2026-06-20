import { NextResponse } from "next/server";
import {
  EVENT_TYPES,
  textValue,
  uuidValue,
  buildEventMetadata,
  invalid,
  processArtistViewEvent,
  processRecordingViewEvent,
  processReleaseViewEvent,
  processGenreViewEvent,
  processPageViewEvent,
  processSearchEvent,
  processPlatformClickEvent,
} from "@/lib/analyticsValidation";

type RequestBody = Record<string, unknown>;

/**
 * Handles analytics event tracking from client-side events.
 * Validates, sanitizes, and persists analytics data to Supabase.
 * Returns 200 OK regardless of success/failure to not break client behavior.
 */
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

  const metadata = buildEventMetadata(request, body);

  // Map of event types to their handler functions
  const handlers: Record<string, (data: RequestBody, metadata: Record<string, unknown>) => Promise<void>> = {
    artist_view: processArtistViewEvent,
    recording_view: processRecordingViewEvent,
    release_view: processReleaseViewEvent,
    genre_view: processGenreViewEvent,
    page_view: processPageViewEvent,
    search: processSearchEvent,
    platform_click: processPlatformClickEvent,
  };

  try {
    const handler = handlers[eventType];
    if (!handler) return invalid("Invalid event_type.");

    await handler(body, metadata);
    return NextResponse.json({ ok: true });
  } catch (error) {
    console.error("Analytics tracking failed:", error instanceof Error ? error.message : error);
    // Return 200 OK so client doesn't retry; analytics must never interrupt user actions
    return NextResponse.json({ ok: false }, { status: 200 });
  }
}
