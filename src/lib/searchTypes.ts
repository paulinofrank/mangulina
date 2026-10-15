export type SearchResult = {
  type: "artist" | "song" | "release";
  id: string;
  title: string;
  slug: string | null;
  subtitle: string | null;
  year: number | null;
  cover_url: string | null;
  artist_name?: string | null;
  release_title?: string | null;
  aliases?: string[];
};

export type SearchOutcome = "normal" | "recovered" | "no_match" | "error" | "degraded";
export type SearchMetadata = {
  outcome: SearchOutcome;
  version: string;
  suggestion?: { text: string; id: string; type: SearchResult["type"]; slug: string | null };
};

export type GlobalSearchResponse = {
  artists: SearchResult[];
  songs: SearchResult[];
  releases: SearchResult[];
  search?: SearchMetadata;
};

export const MIN_SEARCH_QUERY_LENGTH = 2;
export const MAX_SEARCH_QUERY_LENGTH = 80;

/**
 * Cache key for a search query.
 *
 * unstable_cache derives its entry key from the arguments, so passing raw user
 * input created a separate cache entry for every distinct string typed into
 * the site — unbounded within the cache window. Trimming collapses the common
 * duplicates ("juan", "juan ", " juan"), and the length cap keeps a
 * pathological query from minting an entry at all.
 *
 * Normalisation is deliberately limited to what cannot change results.
 * Lower-casing would dedupe far more, but the `global_search` RPC's case
 * handling is not defined in this repository, so folding case here could
 * quietly alter what users see. That is the bigger risk.
 */
export function searchCacheKey(query: string) {
  return query.trim().slice(0, MAX_SEARCH_QUERY_LENGTH);
}
