"use client";

import { useEffect, useRef } from "react";
import {
  trackArtistView,
  trackGenreView,
  trackRecordingView,
  trackReleaseView,
} from "@/lib/analytics";

type AnalyticsPageViewProps =
  | { eventType: "artist_view"; entityId: string }
  | { eventType: "recording_view"; entityId: string }
  | { eventType: "release_view"; entityId: string }
  | { eventType: "genre_view"; entityId: string };

export default function AnalyticsPageView({ eventType, entityId }: AnalyticsPageViewProps) {
  const tracked = useRef(false);

  useEffect(() => {
    if (tracked.current) return;
    tracked.current = true;

    if (eventType === "artist_view") trackArtistView(entityId);
    if (eventType === "recording_view") trackRecordingView(entityId);
    if (eventType === "release_view") trackReleaseView(entityId);
    if (eventType === "genre_view") trackGenreView(entityId);
  }, [entityId, eventType]);

  return null;
}
