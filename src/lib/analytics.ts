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
  | {
      event_type: "search";
      query: string;
      results_count: number;
      source?: string;
    }
  | {
      event_type: "platform_click";
      recording_id: string;
      platform: string;
      url?: string;
      source?: string;
    };

function sendAnalyticsEvent(event: AnalyticsEvent) {
  if (typeof window === "undefined") return;

  try {
    const body = JSON.stringify(event);

    if (typeof navigator.sendBeacon === "function") {
      const queued = navigator.sendBeacon(
        "/api/analytics/track",
        new Blob([body], { type: "application/json" }),
      );
      if (queued) return;
    }

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

export function trackSearch(query: string, resultsCount: number) {
  const normalizedQuery = query.trim();
  if (!normalizedQuery || !Number.isInteger(resultsCount) || resultsCount < 0) return;

  sendAnalyticsEvent({
    event_type: "search",
    query: normalizedQuery,
    results_count: resultsCount,
  });
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
