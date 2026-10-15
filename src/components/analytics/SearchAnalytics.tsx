"use client";

import { useEffect, useRef } from "react";
import { trackSearch } from "@/lib/analytics";
import type { SearchMetadata } from "@/lib/searchTypes";

type SearchAnalyticsProps = {
  query: string;
  resultsCount: number;
  search?: SearchMetadata;
};

export default function SearchAnalytics({ query, resultsCount, search }: SearchAnalyticsProps) {
  const trackedKey = useRef<string | null>(null);

  useEffect(() => {
    const key = `${query}:${resultsCount}:${search?.outcome}`;
    if (trackedKey.current === key) return;

    trackedKey.current = key;
    trackSearch(query, resultsCount, search ? { search_outcome: search.outcome, search_action: "results", search_version: search.version } : {});
  }, [query, resultsCount, search]);

  return null;
}
