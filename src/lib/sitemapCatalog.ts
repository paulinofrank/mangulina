import { unstable_cache } from "next/cache";

import { genreDefinitions } from "@/lib/genres";
import { getArchiveCounts } from "@/lib/getSongsByYear";
import { getPublishedProvinces } from "@/lib/provinces";
import { workSongSlug } from "@/lib/songIdentity";
import { buildCanonical, localizedPath, spanishPath } from "@/lib/seo";
import { getSupabaseClient } from "@/lib/supabase";

/**
 * Segmented sitemap architecture.
 *
 * The public catalog is exposed through a small sitemap index at /sitemap.xml
 * — the established, already-indexed entry point, unchanged — which now
 * references independently cached child sitemaps instead of inlining every
 * URL itself:
 *
 *   /sitemaps/static.xml       stable public pages, directories, genres,
 *                              provinces, archive periods, release listings
 *   /sitemaps/artists-N.xml    published artist profiles
 *   /sitemaps/songs-N.xml      publicly visible song profiles
 *   /sitemaps/releases-N.xml   publicly visible release profiles
 *
 * Both live outside the locale proxy: its matcher skips any path containing a
 * dot (see src/proxy.ts), so ".xml" resources are served directly.
 *
 * Chunks are 1-based windows of SITEMAP_CHUNK_SIZE logical records ordered by
 * (created_at ASC, id ASC). `id` breaks ties, so the ordering is total and the
 * window for a given chunk is deterministic at any instant: a full pass over
 * every chunk yields each eligible record exactly once.
 *
 * Chunk membership is *stable*, not immutable. Newly created records get
 * created_at = now(), sort last, and therefore only ever affect the final
 * chunk. Membership does shift by one position — cascading into later chunks —
 * when a record is deleted, when a record is backfilled/imported with a
 * historical created_at, or (artists only, whose window is publication-filtered
 * before the range is applied) when an existing artist's status flips into or
 * out of "published". Song and release windows are not publication-filtered
 * before ranging, so ownership/publication changes alter which URLs a chunk
 * emits without moving any offsets.
 *
 * Because chunks are cached independently, a shift can briefly leave one URL
 * listed in two chunks or in neither until the affected chunks revalidate
 * (bounded by the 7-day TTL). Sitemaps are discovery hints, not authority: the
 * public route itself enforces publication immediately, so both conditions are
 * harmless and self-healing. This is deliberately not engineered away —
 * immutable membership would require keyset boundaries and far more machinery
 * than correct discovery warrants.
 *
 * A request for one chunk queries only that chunk's window — never the whole
 * catalog.
 *
 * Every logical record expands to two <url> entries (EN + ES), each carrying
 * en / es / x-default xhtml alternates — byte-compatible with the previous
 * monolithic sitemap's per-URL markup. lastmod is deliberately omitted, as
 * before: no per-page modification date we hold is trustworthy enough to
 * assert to search engines.
 */

export const SITEMAP_CHUNK_SIZE = 5000;

/**
 * Fallback freshness for every sitemap resource. Mirrored as a literal in the
 * route handlers' `revalidate` export — Next.js only accepts statically
 * analyzable values there, so the constant cannot be imported into that
 * position. tests/performance/sitemapArchitecture.test.ts asserts the two
 * stay in sync.
 */
export const SITEMAP_REVALIDATE_SECONDS = 604800; // 7 days

export const SITEMAP_FAMILIES = ["artists", "songs", "releases"] as const;
export type SitemapFamily = (typeof SITEMAP_FAMILIES)[number];

const FAMILY_PRIORITY: Record<SitemapFamily, number> = {
  artists: 0.8,
  songs: 0.7,
  releases: 0.7,
};

// Batch size for `.in(...)` lookups: keeps PostgREST GET URLs well under
// practical length limits while bounding the query count per chunk. Also
// stays under SUPABASE_MAX_ROWS, so these lookups are never truncated.
const IN_BATCH_SIZE = 200;

/**
 * PostgREST caps every response at 1000 rows (Supabase's `max-rows`),
 * regardless of the requested Range. A chunk window wider than this is
 * therefore silently truncated — asking for rows 0-4999 returns 1000 and
 * reports success. Chunk windows are read in slices of this size and
 * reassembled by fetchChunkWindow() so a 5000-record chunk really contains
 * 5000 records. Verified against production: range(0,4999) → 1000 rows.
 */
const SUPABASE_MAX_ROWS = 1000;

type PageResult = { data: unknown; error: { message: string } | null };

/**
 * Reads one chunk window [from, to] in <=SUPABASE_MAX_ROWS slices.
 *
 * Bounded by construction: exactly ceil(SITEMAP_CHUNK_SIZE / 1000) requests
 * for a full chunk (5 today), and it stops early on the first short slice, so
 * the final partial chunk costs only what it holds. Returns null when the
 * window lies past the end of the family — the route renders that as a 404,
 * which is distinct from an empty-but-valid window.
 */
async function fetchChunkWindow<Row>(
  label: string,
  page: (start: number, end: number) => PromiseLike<PageResult>,
  from: number,
  to: number,
): Promise<Row[] | null> {
  const rows: Row[] = [];

  for (let start = from; start <= to; start += SUPABASE_MAX_ROWS) {
    const end = Math.min(start + SUPABASE_MAX_ROWS - 1, to);
    const { data, error } = await page(start, end);
    if (error) throw new Error(`${label} failed: ${error.message}`);

    const slice = (data ?? []) as Row[];
    rows.push(...slice);
    // A short slice means the family ended inside this window.
    if (slice.length < end - start + 1) break;
  }

  return rows.length === 0 ? null : rows;
}

export type SitemapPath = { path: string; priority?: number };

// ---------------------------------------------------------------------------
// XML builders (pure)
// ---------------------------------------------------------------------------

export function escapeXml(value: string) {
  return value
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&apos;");
}

function urlEntry(loc: string, alternates: { en: string; es: string }, priority?: number) {
  const priorityTag = priority === undefined ? "" : `\n<priority>${priority}</priority>`;
  return `<url>
<loc>${escapeXml(loc)}</loc>
<xhtml:link rel="alternate" hreflang="en" href="${escapeXml(alternates.en)}" />
<xhtml:link rel="alternate" hreflang="es" href="${escapeXml(alternates.es)}" />
<xhtml:link rel="alternate" hreflang="x-default" href="${escapeXml(alternates.en)}" />
<changefreq>weekly</changefreq>${priorityTag}
</url>`;
}

/**
 * Expands one logical path into its EN and ES <url> entries with reciprocal
 * hreflang alternates (x-default = the unprefixed English canonical).
 */
export function buildLocaleUrlEntries({ path, priority }: SitemapPath) {
  const en = buildCanonical(localizedPath(path, "en"));
  const es = buildCanonical(spanishPath(path));
  const alternates = { en, es };
  return [urlEntry(en, alternates, priority), urlEntry(es, alternates, priority)];
}

export function buildUrlsetXml(paths: SitemapPath[]) {
  const entries = paths.flatMap((item) => buildLocaleUrlEntries(item));
  return `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xhtml="http://www.w3.org/1999/xhtml">
${entries.join("\n")}
</urlset>`;
}

export function buildSitemapIndexXml(childUrls: string[]) {
  const entries = childUrls.map(
    (url) => `<sitemap>
<loc>${escapeXml(url)}</loc>
</sitemap>`,
  );
  return `<?xml version="1.0" encoding="UTF-8"?>
<sitemapindex xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${entries.join("\n")}
</sitemapindex>`;
}

// ---------------------------------------------------------------------------
// Chunk naming and math (pure)
// ---------------------------------------------------------------------------

const CHILD_NAME_PATTERN = /^(artists|songs|releases)-([1-9][0-9]*)\.xml$/;

export type ChildSitemapTarget =
  | { kind: "static" }
  | { kind: "family"; family: SitemapFamily; chunk: number };

export function parseChildSitemapName(name: string): ChildSitemapTarget | null {
  if (name === "static.xml") return { kind: "static" };
  const match = CHILD_NAME_PATTERN.exec(name);
  if (!match) return null;
  return { kind: "family", family: match[1] as SitemapFamily, chunk: Number(match[2]) };
}

export function chunkCountFor(totalRecords: number) {
  return totalRecords <= 0 ? 0 : Math.ceil(totalRecords / SITEMAP_CHUNK_SIZE);
}

export function chunkRange(chunk: number) {
  const from = (chunk - 1) * SITEMAP_CHUNK_SIZE;
  return { from, to: from + SITEMAP_CHUNK_SIZE - 1 };
}

export function buildChildSitemapUrls(counts: Record<SitemapFamily, number>) {
  const urls: string[] = [buildCanonical("/sitemaps/static.xml")];
  for (const family of SITEMAP_FAMILIES) {
    for (let chunk = 1; chunk <= chunkCountFor(counts[family]); chunk += 1) {
      urls.push(buildCanonical(`/sitemaps/${family}-${chunk}.xml`));
    }
  }
  return urls;
}

// ---------------------------------------------------------------------------
// Bounded data access
// ---------------------------------------------------------------------------

function idBatches(ids: string[]) {
  const unique = [...new Set(ids.filter(Boolean))];
  const batches: string[][] = [];
  for (let start = 0; start < unique.length; start += IN_BATCH_SIZE) {
    batches.push(unique.slice(start, start + IN_BATCH_SIZE));
  }
  return batches;
}

async function fetchReleaseRowsByIds(releaseIds: string[]) {
  const rows: ReleaseSitemapRow[] = [];
  for (const batch of idBatches(releaseIds)) {
    const { data, error } = await getSupabaseClient()
      .from("releases")
      .select("id,slug,release_artist_id")
      .in("id", batch);
    if (error) throw new Error(`Sitemap release lookup failed: ${error.message}`);
    rows.push(...((data ?? []) as ReleaseSitemapRow[]));
  }
  return rows;
}

/**
 * Which of these artist ids are published.
 *
 * Only songs and releases need this: their chunk windows are keyed on
 * recordings/releases, but their public visibility depends on the *owning*
 * artist's status, which is not a column on those rows. Artist chunks do not
 * call this — they enforce `status = "published"` inline in their single
 * window query.
 */
async function fetchPublishedArtistIdSet(artistIds: string[]) {
  const published = new Set<string>();
  for (const batch of idBatches(artistIds)) {
    const { data, error } = await getSupabaseClient()
      .from("artists")
      .select("id")
      .eq("status", "published")
      .in("id", batch);
    if (error) throw new Error(`Sitemap artist lookup failed: ${error.message}`);
    for (const row of data ?? []) published.add(row.id as string);
  }
  return published;
}

/**
 * Per-family logical record counts used to derive chunk counts for the index.
 * Songs and releases are counted on their chunk-window basis (slug present);
 * per-row publication filtering happens inside each chunk, so filtered-out
 * rows only make a chunk slightly smaller — never larger.
 */
export async function getSitemapFamilyCounts(): Promise<Record<SitemapFamily, number>> {
  const supabase = getSupabaseClient();
  const [artists, songs, releases] = await Promise.all([
    supabase
      .from("artists")
      .select("id", { count: "exact", head: true })
      .eq("status", "published")
      .not("slug", "is", null),
    supabase
      .from("recordings")
      .select("id", { count: "exact", head: true })
      .not("slug", "is", null),
    supabase
      .from("releases")
      .select("id", { count: "exact", head: true })
      .not("slug", "is", null),
  ]);

  for (const result of [artists, songs, releases]) {
    if (result.error) throw new Error(`Sitemap count failed: ${result.error.message}`);
  }

  return {
    artists: artists.count ?? 0,
    songs: songs.count ?? 0,
    releases: releases.count ?? 0,
  };
}

/**
 * The chunk's window and nothing else. Publication is enforced inside the
 * window query itself (`status = "published"`), so no follow-up artist lookup
 * is needed or performed here.
 *
 * Returns null when the window lies past the end of the family, which the
 * route turns into a 404; an empty array would mean "window exists, nothing
 * in it survived filtering".
 */
export async function loadArtistSitemapPaths(chunk: number): Promise<SitemapPath[] | null> {
  const { from, to } = chunkRange(chunk);
  const rows = await fetchChunkWindow<{ slug: string | null }>(
    "Artist sitemap chunk",
    (start, end) =>
      getSupabaseClient()
        .from("artists")
        .select("slug")
        .eq("status", "published")
        .not("slug", "is", null)
        .order("created_at", { ascending: true, nullsFirst: false })
        .order("id", { ascending: true })
        .range(start, end),
    from,
    to,
  );
  if (rows === null) return null;

  return rows
    .filter((row): row is { slug: string } => Boolean(row.slug))
    .map((row) => ({ path: `/artists/${row.slug}`, priority: FAMILY_PRIORITY.artists }));
}

type RecordingSitemapRow = {
  slug: string | null;
  artist_id: string | null;
  release_id: string | null;
};

type ReleaseSitemapRow = { id: string; slug: string | null; release_artist_id: string | null };

/**
 * Bounded queries: the chunk's recording window plus batched publication
 * lookups for only the artists/releases that window references. Mirrors the
 * previous monolith's visibility rule exactly: a recording is public when its
 * artist is published, or (with no artist) when its release is public, or
 * when it references neither.
 */
export async function loadSongSitemapPaths(chunk: number): Promise<SitemapPath[] | null> {
  const { from, to } = chunkRange(chunk);
  const rows = await fetchChunkWindow<RecordingSitemapRow>(
    "Song sitemap chunk",
    (start, end) =>
      getSupabaseClient()
        .from("recordings")
        .select("slug,artist_id,release_id")
        .not("slug", "is", null)
        .order("created_at", { ascending: true, nullsFirst: false })
        .order("id", { ascending: true })
        .range(start, end),
    from,
    to,
  );
  if (rows === null) return null;

  const fallbackReleaseIds = rows
    .filter((row) => !row.artist_id && row.release_id)
    .map((row) => row.release_id as string);
  const releases = await fetchReleaseRowsByIds(fallbackReleaseIds);
  const releaseById = new Map(releases.map((release) => [release.id, release]));

  const publishedArtists = await fetchPublishedArtistIdSet([
    ...rows.map((row) => row.artist_id).filter((id): id is string => Boolean(id)),
    ...releases
      .map((release) => release.release_artist_id)
      .filter((id): id is string => Boolean(id)),
  ]);

  const isReleasePublic = (releaseId: string) => {
    const release = releaseById.get(releaseId);
    if (!release) return false;
    return !release.release_artist_id || publishedArtists.has(release.release_artist_id);
  };

  return rows
    .filter((row) => {
      if (!row.slug) return false;
      if (row.artist_id) return publishedArtists.has(row.artist_id);
      if (row.release_id) return isReleasePublic(row.release_id);
      return true;
    })
    .map((row) => ({ path: `/songs/${row.slug}`, priority: FAMILY_PRIORITY.songs }));
}

/**
 * Bounded queries: the chunk's release window plus one batched artist
 * publication lookup. Public rule (unchanged): no primary artist, or a
 * published primary artist.
 */
export async function loadReleaseSitemapPaths(chunk: number): Promise<SitemapPath[] | null> {
  const { from, to } = chunkRange(chunk);
  const rows = await fetchChunkWindow<{ slug: string | null; release_artist_id: string | null }>(
    "Release sitemap chunk",
    (start, end) =>
      getSupabaseClient()
        .from("releases")
        .select("slug,release_artist_id")
        .not("slug", "is", null)
        .order("created_at", { ascending: true, nullsFirst: false })
        .order("id", { ascending: true })
        .range(start, end),
    from,
    to,
  );
  if (rows === null) return null;

  const publishedArtists = await fetchPublishedArtistIdSet(
    rows.map((row) => row.release_artist_id).filter((id): id is string => Boolean(id)),
  );

  return rows
    .filter((row) => row.slug && (!row.release_artist_id || publishedArtists.has(row.release_artist_id)))
    .map((row) => ({ path: `/releases/${row.slug}`, priority: FAMILY_PRIORITY.releases }));
}

// ---------------------------------------------------------------------------
// Static / directory family
// ---------------------------------------------------------------------------

/**
 * Stable public pages carried over verbatim from the previous monolithic
 * sitemap: canonical navigation pages, role directories, curated listings,
 * and legal pages, with their original priorities.
 */
export const STATIC_SITEMAP_PATHS: SitemapPath[] = [
  { path: "/", priority: 1 },
  { path: "/discover", priority: 0.8 },
  { path: "/artists", priority: 0.9 },
  { path: "/artists/legends", priority: 0.8 },
  { path: "/artists/emerging", priority: 0.8 },
  { path: "/artists/most-awarded", priority: 0.8 },
  { path: "/artists/groups", priority: 0.8 },
  { path: "/instrumental-classical", priority: 0.7 },
  { path: "/composers", priority: 0.8 },
  { path: "/songwriters", priority: 0.8 },
  { path: "/lyricists", priority: 0.8 },
  { path: "/arrangers", priority: 0.8 },
  { path: "/musical-directors", priority: 0.8 },
  { path: "/musicians", priority: 0.8 },
  { path: "/djs", priority: 0.8 },
  { path: "/producers", priority: 0.8 },
  { path: "/christian", priority: 0.8 },
  { path: "/archive", priority: 0.9 },
  { path: "/songs", priority: 0.9 },
  { path: "/artists/birthdays", priority: 0.7 },
  { path: "/about", priority: 0.6 },
  { path: "/contact", priority: 0.5 },
  { path: "/contributors", priority: 0.5 },
  { path: "/privacy-policy", priority: 0.4 },
  { path: "/terms-of-use", priority: 0.4 },
  { path: "/dmca", priority: 0.4 },
];

async function getActiveGenreSlugs() {
  const { data, error } = await getSupabaseClient()
    .from("genres")
    .select("slug")
    .eq("active", true)
    .eq("level", 0)
    .is("parent_id", null)
    .not("slug", "is", null);

  if (error) throw new Error(`Genre sitemap lookup failed: ${error.message}`);
  return (data ?? [])
    .map((row) => row.slug as string | null)
    .filter((slug): slug is string => Boolean(slug));
}

async function buildStaticSitemapPaths(): Promise<SitemapPath[]> {
  const [{ decadeCounts, yearCounts }, provinces, dbGenreSlugs, workResponse] =
    await Promise.all([
      getArchiveCounts(),
      getPublishedProvinces(),
      getActiveGenreSlugs(),
      getSupabaseClient().from("works").select("id,slug").eq("status", "published"),
    ]);
  if (workResponse.error) throw new Error(workResponse.error.message);

  const genreSlugs = new Set([
    ...genreDefinitions.map((genre) => genre.slug),
    ...dbGenreSlugs,
  ]);

  return [
    ...STATIC_SITEMAP_PATHS,
    ...Object.keys(decadeCounts)
      .filter((decade) => decadeCounts[decade] > 0)
      .sort((a, b) => Number(b.slice(0, 4)) - Number(a.slice(0, 4)))
      .map((decade) => ({ path: `/archive/${decade}`, priority: 0.8 })),
    ...Object.keys(yearCounts)
      .filter((year) => yearCounts[year] > 0)
      .sort((a, b) => Number(b) - Number(a))
      .map((year) => ({ path: `/archive/${year}`, priority: 0.7 })),
    ...(workResponse.data ?? []).map((work) => ({ path: `/songs/${workSongSlug(work)}`, priority: 0.7 })),
    ...provinces.map((province) => ({ path: `/provinces/${province.slug}`, priority: 0.8 })),
    ...[...genreSlugs].map((slug) => ({ path: `/genres/${slug}`, priority: 0.7 })),
  ];
}

/**
 * Static family: fixed public routes plus the small database-derived route
 * sets (genres, provinces, archive periods with content, release type/decade
 * listings). All lookups are bounded count/config queries — never catalog
 * scans.
 *
 * Wrapped in its own cache entry because those helpers are shared with the
 * hub pages, where they carry a 600s TTL. Next.js resolves a route's
 * revalidate as the minimum across everything it reads, so calling them
 * directly dragged this sitemap down to 600s — regenerating it 144x a day
 * instead of once. Isolating them here restores the intended 7-day TTL without
 * touching the shared helpers (whose own TTL is out of scope for Phase 2).
 */
export const loadStaticSitemapPaths = unstable_cache(
  buildStaticSitemapPaths,
  ["public-sitemap-static-v2-songs"],
  { revalidate: SITEMAP_REVALIDATE_SECONDS },
);
