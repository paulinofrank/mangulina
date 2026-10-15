import type { GlobalSearchResponse, SearchResult } from "./searchTypes";
import { SEARCH_ALGORITHM_VERSION } from "./searchMatching";

export class SearchDegradedError extends Error {
  constructor(public readonly results: GlobalSearchResponse) { super("Search enrichment unavailable."); }
}

/** Runs outside the shared result cache. No exception becomes a no-match. */
export async function recoverSearchFailure(fallback: () => Promise<SearchResult[]>): Promise<GlobalSearchResponse> {
  let artists: SearchResult[] = [];
  try { artists = await fallback(); } catch { /* Both sources unavailable. */ }
  return { artists, songs: [], releases: [], search: {
    outcome: artists.length ? "degraded" : "error", version: SEARCH_ALGORITHM_VERSION,
  } };
}
