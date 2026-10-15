import type { SearchMetadata } from "./searchTypes";

export type SearchEventDetails = {
  search_outcome?: SearchMetadata["outcome"];
  search_action?: "results" | "suggestion_displayed" | "suggestion_selected";
  search_version?: string;
  suggestion_text?: string;
};

export type PageViewEvent = {
  event_type: "page_view";
  path: string;
  page_type?: string;
  entity_id?: string;
  entity_slug?: string;
  referrer?: string;
  source?: string;
};

export type AnalyticsEvent =
  | { event_type: "artist_view"; artist_id: string; source?: string }
  | { event_type: "recording_view"; recording_id: string; source?: string }
  | { event_type: "release_view"; release_id: string; source?: string }
  | { event_type: "genre_view"; genre_slug: string; source?: string }
  | PageViewEvent
  | ({
      event_type: "search";
      query: string;
      results_count: number | null;
      source?: string;
    } & SearchEventDetails)
  | {
      event_type: "platform_click";
      recording_id: string;
      platform: string;
      url?: string;
      source?: string;
    };

/**
 * Gets or creates a stable, anonymous visitor ID for this browser.
 *
 * Stored in localStorage (not sessionStorage) so it persists across tabs and
 * browser restarts — this is what makes "one view per visitor per day"
 * deduplication possible (the per-day bucket is applied server-side). The ID
 * is an opaque random value: no login, no IP, no personal data.
 *
 * Falls back to memory storage if localStorage is unavailable (private mode).
 */
const VISITOR_ID_KEY = "mangulina_visitor_id";
let fallbackSessionId: string | null = null;

function generateVisitorId(): string {
  try {
    if (typeof crypto !== "undefined" && typeof crypto.randomUUID === "function") {
      return crypto.randomUUID();
    }
  } catch {
    // crypto unavailable, fall through to Math.random
  }
  return `v_${Date.now()}_${Math.random().toString(36).slice(2)}`;
}

function getSessionId(): string | null {
  if (typeof window === "undefined") return fallbackSessionId || null;

  try {
    if (window.localStorage) {
      let visitorId = window.localStorage.getItem(VISITOR_ID_KEY);
      if (!visitorId) {
        visitorId = generateVisitorId();
        window.localStorage.setItem(VISITOR_ID_KEY, visitorId);
      }
      return visitorId;
    }
  } catch {
    // localStorage might be disabled or in private mode
  }

  // Fallback: generate and cache in memory for this page session
  if (!fallbackSessionId) {
    fallbackSessionId = generateVisitorId();
  }
  return fallbackSessionId;
}

function sendAnalyticsEvent(event: AnalyticsEvent) {
  if (typeof window === "undefined") return;

  // Only track when analytics is explicitly enabled. Set
  // NEXT_PUBLIC_ENABLE_ANALYTICS="true" in the production environment ONLY so
  // that local dev, 127.0.0.1, LAN testing, and Vercel preview deployments
  // never write into the production analytics tables.
  if (process.env.NEXT_PUBLIC_ENABLE_ANALYTICS !== "true") {
    return;
  }

  try {
    const sessionId = getSessionId();
    const body = JSON.stringify({
      ...event,
      session_id: sessionId, // Add session ID for device-level tracking
    });

    // sendBeacon is most reliable for events before navigation
    if (typeof navigator.sendBeacon === "function") {
      try {
        const queued = navigator.sendBeacon(
          "/api/analytics/track",
          new Blob([body], { type: "application/json" }),
        );
        if (queued) return;
      } catch {
        // sendBeacon failed, fall through to fetch
      }
    }

    // Fallback to fetch with keepalive
    void fetch("/api/analytics/track", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body,
      keepalive: true,
    }).catch(() => undefined);
  } catch {
    // Analytics must never interrupt the visitor's action.
  }
}

export function trackArtistView(artistId: string) {
  if (artistId.trim()) sendAnalyticsEvent({ event_type: "artist_view", artist_id: artistId });
}

export function trackRecordingView(recordingId: string) {
  if (recordingId.trim()) {
    sendAnalyticsEvent({ event_type: "recording_view", recording_id: recordingId });
  }
}

export function trackReleaseView(releaseId: string) {
  if (releaseId.trim()) sendAnalyticsEvent({ event_type: "release_view", release_id: releaseId });
}

export function trackGenreView(genreSlug: string) {
  if (genreSlug.trim()) sendAnalyticsEvent({ event_type: "genre_view", genre_slug: genreSlug });
}

export function trackPageView(event: Omit<PageViewEvent, "event_type">) {
  const path = event.path.trim();
  if (!path) return;

  sendAnalyticsEvent({ ...event, event_type: "page_view", path });
}

const recentSearchEvents = new Map<string, number>();

export function trackSearch(query: string, resultsCount: number | null, details: SearchEventDetails = {}) {
  const normalizedQuery = query.trim();
  if (!normalizedQuery || (resultsCount !== null && (!Number.isInteger(resultsCount) || resultsCount < 0))) return;
  const key = JSON.stringify([normalizedQuery, resultsCount, details]);
  const now = Date.now();
  if (now - (recentSearchEvents.get(key) ?? 0) < 30_000) return;
  for (const [eventKey, timestamp] of recentSearchEvents) if (now - timestamp >= 30_000) recentSearchEvents.delete(eventKey);
  recentSearchEvents.set(key, now);

  sendAnalyticsEvent({
    event_type: "search",
    query: normalizedQuery,
    results_count: resultsCount,
    ...details,
  });
}

export function trackSearchSuggestion(query: string, search: SearchMetadata, action: "suggestion_displayed" | "suggestion_selected") {
  if (!search.suggestion) return;
  trackSearch(query, null, { search_outcome: search.outcome, search_action: action, search_version: search.version, suggestion_text: search.suggestion.text });
}

export function trackPlatformClick(recordingId: string, platform: string, url?: string) {
  const normalizedRecordingId = recordingId.trim();
  const normalizedPlatform = platform.trim();
  if (!normalizedRecordingId || !normalizedPlatform) return;

  sendAnalyticsEvent({
    event_type: "platform_click",
    recording_id: normalizedRecordingId,
    platform: normalizedPlatform,
    url: url?.trim() || undefined,
  });
}
