import type { SearchResult } from "./searchTypes";

export const ARTIST_RECOVERY_PAGE_SIZE = 1000;
export const ARTIST_RECOVERY_LIMIT = 5000;
export type ArtistRecoveryPage = { rows: SearchResult[]; total: number | null };

export async function loadArtistRecoveryCatalog(fetchPage: (from: number, to: number) => Promise<ArtistRecoveryPage>): Promise<SearchResult[]> {
  const first = await fetchPage(0, ARTIST_RECOVERY_PAGE_SIZE - 1);
  if (first.total === null || first.total < 0 || first.total > ARTIST_RECOVERY_LIMIT)
    throw new Error("Published artist recovery catalog exceeds its verified capacity or has no count.");
  const remaining = [];
  for (let from = ARTIST_RECOVERY_PAGE_SIZE; from < first.total; from += ARTIST_RECOVERY_PAGE_SIZE)
    remaining.push(fetchPage(from, Math.min(from + ARTIST_RECOVERY_PAGE_SIZE, first.total) - 1));
  const pages = [first, ...await Promise.all(remaining)];
  const rows = pages.flatMap(page => page.rows);
  if (pages.some(page => page.total !== first.total) || rows.length !== first.total || new Set(rows.map(row => row.id)).size !== first.total)
    throw new Error("Published artist recovery catalog is incomplete or changed during retrieval.");
  return rows;
}
