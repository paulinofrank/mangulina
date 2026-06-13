"use client";

import { useEffect, useRef } from "react";
import { trackSearch } from "@/lib/analytics";

type SearchAnalyticsProps = {
  query: string;
  resultsCount: number;
};

export default function SearchAnalytics({ query, resultsCount }: SearchAnalyticsProps) {
  const trackedKey = useRef<string | null>(null);

  useEffect(() => {
    const key = `${query}:${resultsCount}`;
    if (trackedKey.current === key) return;

    trackedKey.current = key;
    trackSearch(query, resultsCount);
  }, [query, resultsCount]);

  return null;
}
