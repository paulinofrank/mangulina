import { supabase } from "@/lib/supabase";
import { getPublicReleaseCoverUrl } from "@/lib/releaseCover";

const RELEASE_LIST_PAGE_SIZE = 24;
const RELEASE_SECTION_LIMIT = 12;
const RELEASE_SUMMARY_SELECT =
  "id,slug,title,type,release_year,year,label,release_artist_id";
const RELEASE_SUMMARY_SELECT_WITH_VIEWS = `${RELEASE_SUMMARY_SELECT},views`;

// ============================================================================
// Helper type for release artist info
// ============================================================================

export type ReleaseArtistInfo = {
  artist_id: string | null;
  artist_name: string | null;
  credited_as: string | null;
};

// ============================================================================
// Helper function: Get release artist (prefer release_artists, fallback to legacy)
// ============================================================================
// Returns artist info from release_artists table if available, otherwise falls back
// to releases.release_artist_id. Maintains backward compatibility during transition.

export async function getReleaseArtistInfo(releaseId: string): Promise<ReleaseArtistInfo> {
  // Try to get from release_artists table first (new model)
  const { data: releaseArtistsData } = await supabase
    .from("release_artists")
    .select("artist_id,credited_as,artists!inner(name)")
    .eq("release_id", releaseId)
    .eq("role", "primary")
    .order("display_order", { ascending: true, nullsFirst: true })
    .limit(1)
    .single();

  if (releaseArtistsData && releaseArtistsData.artists) {
    return {
      artist_id: releaseArtistsData.artist_id,
      artist_name: (releaseArtistsData.artists as any).name || null,
      credited_as: releaseArtistsData.credited_as || null,
    };
  }

  // Fallback: get from releases.release_artist_id (legacy field, no credited_as)
  const { data: releaseData } = await supabase
    .from("releases")
    .select("release_artist_id,artists!release_artist_id(name)")
    .eq("id", releaseId)
    .single();

  if (releaseData?.release_artist_id && releaseData.artists) {
    return {
      artist_id: releaseData.release_artist_id,
      artist_name: (releaseData.artists as any).name || null,
      credited_as: null,
    };
  }

  return { artist_id: null, artist_name: null, credited_as: null };
}

// ============================================================================
// Batch helper: Get release artists for multiple releases
// ============================================================================
// More efficient than calling getReleaseArtistInfo() N times.
// Returns Map<releaseId, ReleaseArtistInfo> for batch processing.

async function getReleaseArtistsInfo(releaseIds: string[]): Promise<Map<string, ReleaseArtistInfo>> {
  if (releaseIds.length === 0) return new Map();

  const result = new Map<string, ReleaseArtistInfo>();

  // First, try to get from release_artists table (new model)
  const { data: releaseArtists } = await supabase
    .from("release_artists")
    .select("release_id,artist_id,credited_as,artists!inner(name)")
    .in("release_id", releaseIds)
    .eq("role", "primary")
    .order("release_id")
    .order("display_order", { ascending: true, nullsFirst: true });

  if (releaseArtists) {
    for (const row of releaseArtists) {
      result.set(row.release_id, {
        artist_id: row.artist_id,
        artist_name: (row.artists as any)?.name || null,
        credited_as: row.credited_as || null,
      });
    }
  }

  // Find releases that don't have entries in release_artists (yet)
  const remainingIds = releaseIds.filter((id) => !result.has(id));

  if (remainingIds.length > 0) {
    // Fallback: get from releases.release_artist_id (legacy field, no credited_as)
    const { data: releases } = await supabase
      .from("releases")
      .select("id,release_artist_id,artists!release_artist_id(name)")
      .in("id", remainingIds);

    if (releases) {
      for (const row of releases) {
        if (row.release_artist_id && row.artists) {
          result.set(row.id, {
            artist_id: row.release_artist_id,
            artist_name: (row.artists as any)?.name || null,
            credited_as: null,
          });
        } else {
          result.set(row.id, { artist_id: null, artist_name: null, credited_as: null });
        }
      }
    }
  }

  // Ensure all releases have entries (even if null)
  for (const id of releaseIds) {
    if (!result.has(id)) {
      result.set(id, { artist_id: null, artist_name: null, credited_as: null });
    }
  }

  return result;
}

export type ReleaseSort = "views" | "recent" | "title";

export type ReleaseTypeDefinition = {
  slug: string;
  label: string;
  h1: string;
  title: string;
  description: string;
  aliases: string[];
};

export type ReleaseDecadeDefinition = {
  slug: string;
  label: string;
  startYear: number;
  endYear: number;
};

export const RELEASE_TYPE_DEFINITIONS: ReleaseTypeDefinition[] = [
  {
    slug: "albums",
    label: "Albums",
    h1: "Dominican Albums",
    title: "Dominican Albums | Mangulina",
    description:
      "Explore Dominican albums across merengue, bachata, salsa, urban, worship, and other styles in Mangulina.",
    aliases: ["album", "albums", "lp"],
  },
  {
    slug: "singles",
    label: "Singles",
    h1: "Dominican Singles",
    title: "Dominican Singles | Mangulina",
    description:
      "Explore Dominican singles from artists across classic, contemporary, and emerging music scenes.",
    aliases: ["single", "singles"],
  },
  {
    slug: "eps",
    label: "EPs",
    h1: "Dominican EPs",
    title: "Dominican EPs | Mangulina",
    description:
      "Browse Dominican EPs and shorter release projects documented in the Dominican Music Database.",
    aliases: ["ep", "eps", "e.p."],
  },
  {
    slug: "compilations",
    label: "Compilations",
    h1: "Dominican Compilations",
    title: "Dominican Compilations | Mangulina",
    description:
      "Discover Dominican compilation releases, collections, and multi-artist projects in Mangulina.",
    aliases: ["compilation", "compilations"],
  },
  {
    slug: "live",
    label: "Live Albums",
    h1: "Dominican Live Albums",
    title: "Dominican Live Albums | Mangulina",
    description:
      "Explore Dominican live albums and concert recordings from Mangulina's release catalog.",
    aliases: ["live", "live_album", "live album", "live albums"],
  },
  {
    slug: "soundtracks",
    label: "Soundtracks",
    h1: "Dominican Soundtracks",
    title: "Dominican Soundtracks | Mangulina",
    description:
      "Browse Dominican soundtrack releases and music connected to film, television, and stage works.",
    aliases: ["soundtrack", "soundtracks"],
  },
];

export const RELEASE_DECADES: ReleaseDecadeDefinition[] = [
  { slug: "1950s", label: "1950s", startYear: 1950, endYear: 1959 },
  { slug: "1960s", label: "1960s", startYear: 1960, endYear: 1969 },
  { slug: "1970s", label: "1970s", startYear: 1970, endYear: 1979 },
  { slug: "1980s", label: "1980s", startYear: 1980, endYear: 1989 },
  { slug: "1990s", label: "1990s", startYear: 1990, endYear: 1999 },
  { slug: "2000s", label: "2000s", startYear: 2000, endYear: 2009 },
  { slug: "2010s", label: "2010s", startYear: 2010, endYear: 2019 },
  { slug: "2020s", label: "2020s", startYear: 2020, endYear: 2029 },
];

export type ReleaseTrack = {
  id: string;
  discNumber: number;
  trackNumber: number | null;
  title: string;
  durationMs: number | null;
  recordingId: string | null;
  recordingSlug: string | null;
};

export type ReleasePageData = {
  id: string;
  slug: string;
  title: string;
  type: string | null;
  releaseYear: number | null;
  year: number | null;
  date: string | null;
  label: string | null;
  country: string | null;
  barcode: string | null;
  catalogNumber: string | null;
  views: number | null;
  coverImageUrl: string | null;
  artist: {
    id: string;
    slug: string | null;
    name: string;
  } | null;
  tracks: ReleaseTrack[];
};

export type ReleaseSummary = {
  id: string;
  slug: string | null;
  title: string;
  type: string | null;
  releaseYear: number | null;
  label: string | null;
  views: number | null;
  coverImageUrl: string | null;
  artist: {
    id: string;
    slug: string | null;
    name: string;
  } | null;
};

export type ReleaseListingResult = {
  releases: ReleaseSummary[];
  total: number;
  page: number;
  pageSize: number;
};

export type ReleaseTypeCount = ReleaseTypeDefinition & {
  count: number;
};

export type ReleaseDecadeCount = ReleaseDecadeDefinition & {
  count: number;
};

export type DominantReleaseGenre = {
  id: number;
  name: string;
  slug: string | null;
};

type ReleaseRow = {
  id: string;
  slug: string | null;
  title: string;
  type: string | null;
  release_year: number | null;
  year: number | null;
  date: string | null;
  label: string | null;
  country: string | null;
  barcode: string | null;
  catalog_number: string | null;
  release_artist_id: string | null;
  views?: number | null;
};

type ReleaseSummaryRpcRow = {
  id: string;
  slug: string | null;
  title: string;
  type: string | null;
  release_year: number | null;
  year: number | null;
  label: string | null;
  views: number | null;
  release_artist_id: string | null;
  artist_name: string | null;
  artist_slug: string | null;
};

type TrackRow = {
  id: string;
  recording_id: string | null;
  track_number: number | null;
  disc_number: number | null;
  position: number | null;
  length: number | null;
  title_override: string | null;
};

type RecordingRow = {
  id: string;
  slug: string | null;
  title: string | null;
  duration: number | null;
};

type ReleaseArtistRow = {
  id: string;
  slug: string | null;
  name: string;
  status?: string | null;
};

type RecordingGenreRow = {
  id?: string;
  release_id?: string | null;
  genre_id: number | null;
  subgenre_id: number | null;
  views?: number | null;
};

type GenreRow = {
  id: number;
  name: string;
  slug: string | null;
};

type ReleaseDiscoveryOptions = {
  limit?: number;
  page?: number;
  sort?: ReleaseSort;
  type?: ReleaseTypeDefinition;
  decade?: ReleaseDecadeDefinition;
};

function isMissingReleaseViewsColumn(error: unknown) {
  const candidate = error as { message?: unknown } | null;
  if (!candidate || typeof candidate !== "object") return false;
  return typeof candidate.message === "string" && candidate.message.includes("releases.views");
}

export function getReleaseCoverUrl(releaseId: string) {
  return getPublicReleaseCoverUrl(releaseId, 300);
}

export function formatReleaseType(type?: string | null) {
  if (!type) return "Release";
  return type
    .replace(/_/g, " ")
    .replace(/\b\w/g, (character) => character.toUpperCase());
}

export function getReleaseYear(release: {
  releaseYear?: number | null;
  year?: number | null;
  release_year?: number | null;
}) {
  return release.releaseYear ?? release.release_year ?? release.year ?? null;
}

export function getReleaseTypeDefinition(slug: string) {
  return RELEASE_TYPE_DEFINITIONS.find((definition) => definition.slug === slug) ?? null;
}

export function getReleaseDecade(slug: string) {
  return RELEASE_DECADES.find((decade) => decade.slug === slug) ?? null;
}

export function normalizeReleaseSort(value: string | string[] | undefined): ReleaseSort {
  const raw = Array.isArray(value) ? value[0] : value;
  return raw === "recent" || raw === "title" ? raw : "views";
}

export function normalizeReleasePage(value: string | string[] | undefined) {
  const raw = Array.isArray(value) ? value[0] : value;
  const page = Number.parseInt(raw ?? "1", 10);
  return Number.isFinite(page) && page > 0 ? page : 1;
}

function normalizeType(type: string) {
  return type.trim().toLowerCase().replace(/[\s-]+/g, "_");
}

function getTypeAliasVariants(type: ReleaseTypeDefinition) {
  return [
    ...new Set(
      type.aliases.flatMap((alias) => {
        const normalized = normalizeType(alias);
        return [alias, normalized, alias.toLowerCase(), alias.toUpperCase()];
      }),
    ),
  ];
}

async function getArtistMap(artistIds: string[]) {
  const uniqueArtistIds = [...new Set(artistIds.filter(Boolean))];
  const artistMap = new Map<string, ReleaseArtistRow>();

  if (uniqueArtistIds.length === 0) return artistMap;

  const { data, error } = await supabase
    .from("artists")
    .select("id,slug,name,status")
    .in("id", uniqueArtistIds);

  if (error) {
    console.error("getArtistMap error:", error);
    return artistMap;
  }

  for (const artist of (data ?? []) as ReleaseArtistRow[]) {
    artistMap.set(artist.id, artist);
  }

  return artistMap;
}

async function hydrateReleaseSummaries(rows: ReleaseRow[]): Promise<ReleaseSummary[]> {
  // Get release artists from new table (prefer) or legacy field (fallback)
  const releaseArtistsMap = await getReleaseArtistsInfo(rows.map((r) => r.id));

  // Get artist details for all artist IDs found
  const artistIds = Array.from(new Set(
    Array.from(releaseArtistsMap.values())
      .map((info) => info.artist_id)
      .filter((id): id is string => Boolean(id))
  ));
  const artistMap = artistIds.length > 0 ? await getArtistMap(artistIds) : new Map();

  return rows
    .filter((release) => {
      const artistInfo = releaseArtistsMap.get(release.id);
      if (!artistInfo?.artist_id) return true;
      return artistMap.get(artistInfo.artist_id)?.status === "published";
    })
    .map((release) => {
      const artistInfo = releaseArtistsMap.get(release.id);
      const artist = artistInfo?.artist_id ? artistMap.get(artistInfo.artist_id) : null;
      // Use credited_as (historical credit text) if available, otherwise use canonical name
      const displayName = artistInfo?.credited_as || artist?.name || null;
      return {
        id: release.id,
        slug: release.slug,
        title: release.title,
        type: release.type,
        releaseYear: release.release_year ?? release.year,
        label: release.label,
        views: release.views ?? null,
        coverImageUrl: getReleaseCoverUrl(release.id),
        artist: artist
          ? {
              id: artist.id,
              slug: artist.slug,
              name: displayName,
            }
          : null,
      };
    });
}

function applyReleaseSort<T extends ReleaseSummary>(releases: T[], sort: ReleaseSort) {
  return releases.slice().sort((left, right) => {
    if (sort === "recent") {
      return (
        Number(right.releaseYear ?? 0) - Number(left.releaseYear ?? 0) ||
        left.title.localeCompare(right.title)
      );
    }
    if (sort === "title") return left.title.localeCompare(right.title);
    return (
      Number(right.views ?? 0) - Number(left.views ?? 0) ||
      Number(right.releaseYear ?? 0) - Number(left.releaseYear ?? 0) ||
      left.title.localeCompare(right.title)
    );
  });
}

function applyReleaseOrder(query: any, sort: ReleaseSort) {
  if (sort === "recent") {
    return query
      .order("release_year", { ascending: false, nullsFirst: false })
      .order("year", { ascending: false, nullsFirst: false })
      .order("title", { ascending: true });
  }

  if (sort === "title") {
    return query.order("title", { ascending: true });
  }

  return query
    .order("views", { ascending: false, nullsFirst: false })
    .order("release_year", { ascending: false, nullsFirst: false })
    .order("title", { ascending: true });
}

function applyReleaseFilters(query: any, options: ReleaseDiscoveryOptions) {
  let nextQuery = query.not("slug", "is", null);

  if (options.type) {
    nextQuery = nextQuery.in("type", getTypeAliasVariants(options.type));
  }

  if (options.decade) {
    nextQuery = nextQuery
      .gte("release_year", options.decade.startYear)
      .lte("release_year", options.decade.endYear);
  }

  return nextQuery;
}

export async function getReleaseSummaries(
  options: ReleaseDiscoveryOptions = {},
): Promise<ReleaseListingResult> {
  const pageSize = options.limit ?? RELEASE_LIST_PAGE_SIZE;
  const page = options.page ?? 1;
  const from = (page - 1) * pageSize;
  const to = from + pageSize - 1;
  const sort = options.sort ?? "views";

  async function runQuery(includeViews: boolean) {
    let query = supabase
      .from("releases")
      .select(includeViews ? RELEASE_SUMMARY_SELECT_WITH_VIEWS : RELEASE_SUMMARY_SELECT, {
        count: "exact",
      });

    query = applyReleaseFilters(query, options);
    query = applyReleaseOrder(query, includeViews ? sort : sort === "views" ? "recent" : sort).range(from, to);

    return query;
  }

  let { data, error, count } = await runQuery(true);

  if (error && isMissingReleaseViewsColumn(error)) {
    ({ data, error, count } = await runQuery(false));
  }

  if (error) {
    console.error("getReleaseSummaries error:", error);
    return { releases: [], total: 0, page, pageSize };
  }

  return {
    releases: await hydrateReleaseSummaries((data ?? []) as unknown as ReleaseRow[]),
    total: count ?? 0,
    page,
    pageSize,
  };
}

async function countReleases(options: ReleaseDiscoveryOptions) {
  let query = supabase
    .from("releases")
    .select("id", { count: "exact", head: true });

  query = applyReleaseFilters(query, options);
  const { count, error } = await query;

  if (error) {
    console.error("countReleases error:", error);
    return 0;
  }

  return count ?? 0;
}

export async function getReleaseTypeCounts(): Promise<ReleaseTypeCount[]> {
  const counts = await Promise.all(
    RELEASE_TYPE_DEFINITIONS.map(async (definition) => ({
      ...definition,
      count: await countReleases({ type: definition }),
    })),
  );

  return counts.filter((definition) => definition.count > 0);
}

export async function getReleaseDecadeCounts(): Promise<ReleaseDecadeCount[]> {
  const counts = await Promise.all(
    RELEASE_DECADES.map(async (decade) => ({
      ...decade,
      count: await countReleases({ decade }),
    })),
  );

  return counts.filter((decade) => decade.count > 0);
}

export async function getReleaseSummariesByIds(
  ids: string[],
  sort: ReleaseSort = "views",
): Promise<ReleaseSummary[]> {
  const uniqueIds = [...new Set(ids.filter(Boolean))];
  if (uniqueIds.length === 0) return [];

  const { data, error } = await supabase.rpc("get_release_summaries_by_ids", {
    release_ids: uniqueIds,
  });

  if (error) {
    console.error("getReleaseSummariesByIds RPC error:", error);
    return [];
  }

  const releases = ((data ?? []) as ReleaseSummaryRpcRow[]).map((release) => ({
    id: release.id,
    slug: release.slug,
    title: release.title,
    type: release.type,
    releaseYear: release.release_year ?? release.year,
    label: release.label,
    views: release.views,
    coverImageUrl: getReleaseCoverUrl(release.id),
    artist: release.release_artist_id
      ? {
          id: release.release_artist_id,
          slug: release.artist_slug,
          name: release.artist_name as string,
        }
      : null,
  }));

  return applyReleaseSort(releases, sort);
}

export async function getFeaturedRelease() {
  const { data, error } = await supabase
    .from("featured_release")
    .select("release_id")
    .eq("id", 1)
    .maybeSingle();

  const releaseId = (data as { release_id?: string | null } | null)?.release_id;

  if (error || !releaseId) {
    const fallback = await getReleaseSummaries({ limit: 1, sort: "views" });
    return fallback.releases[0] ?? null;
  }

  return (await getReleaseSummariesByIds([releaseId], "views"))[0] ?? null;
}

export async function getEssentialReleases(limit = RELEASE_SECTION_LIMIT) {
  const { data, error } = await supabase
    .from("essential_releases")
    .select("release_id,display_order")
    .order("display_order", { ascending: true })
    .limit(limit);

  if (error) return [];

  const ids = ((data ?? []) as Array<{ release_id: string | null }>).map((row) => row.release_id).filter((id): id is string => Boolean(id));
  return getReleaseSummariesByIds(ids, "title");
}

export async function getReleaseHubData() {
  const [featuredRelease, mostViewed, recent, typeCounts, decadeCounts, essential] =
    await Promise.all([
      getFeaturedRelease(),
      getReleaseSummaries({ limit: RELEASE_SECTION_LIMIT, sort: "views" }),
      getReleaseSummaries({ limit: RELEASE_SECTION_LIMIT, sort: "recent" }),
      getReleaseTypeCounts(),
      getReleaseDecadeCounts(),
      getEssentialReleases(),
    ]);

  return {
    featuredRelease,
    mostViewed: mostViewed.releases,
    recent: recent.releases,
    typeCounts,
    decadeCounts,
    essential,
  };
}

export async function getReleasesForGenreIds({
  genreIds,
  subgenreIds = [],
  sort = "views",
  limit = RELEASE_SECTION_LIMIT,
  excludeReleaseId,
}: {
  genreIds: number[];
  subgenreIds?: number[];
  sort?: ReleaseSort;
  limit?: number;
  excludeReleaseId?: string;
}) {
  const filters = [
    ...genreIds.map((id) => `genre_id.eq.${id}`),
    ...subgenreIds.map((id) => `subgenre_id.eq.${id}`),
  ].join(",");

  if (!filters) return [];

  let query = supabase
    .from("recordings")
    .select("release_id,genre_id,subgenre_id,views")
    .or(filters)
    .not("release_id", "is", null)
    .limit(1000);

  if (sort === "views") {
    query = query.order("views", { ascending: false, nullsFirst: false });
  }

  const { data, error } = await query;

  if (error) {
    console.error("getReleasesForGenreIds recordings error:", error);
    return [];
  }

  const releaseScores = new Map<string, number>();
  for (const recording of (data ?? []) as RecordingGenreRow[]) {
    if (!recording.release_id || recording.release_id === excludeReleaseId) continue;
    releaseScores.set(
      recording.release_id,
      Math.max(releaseScores.get(recording.release_id) ?? 0, Number(recording.views ?? 0)),
    );
  }

  const releases = await getReleaseSummariesByIds([...releaseScores.keys()], sort);

  if (sort === "views") {
    return releases
      .sort(
        (left, right) =>
          (releaseScores.get(right.id) ?? 0) - (releaseScores.get(left.id) ?? 0) ||
          Number(right.views ?? 0) - Number(left.views ?? 0),
      )
      .slice(0, limit);
  }

  return applyReleaseSort(releases, sort).slice(0, limit);
}

export async function getDominantGenreForRecordings(recordingIds: string[]) {
  const ids = [...new Set(recordingIds.filter(Boolean))];
  if (ids.length === 0) return null;

  // Large-ID audit: multi-disc/compilation releases can exceed 100 recordings;
  // dominant-genre aggregation should move into PostgreSQL rather than be chunked.
  const { data, error } = await supabase
    .from("recordings")
    .select("id,genre_id,subgenre_id")
    .in("id", ids);

  if (error) {
    console.error("getDominantGenreForRecordings recordings error:", error);
    return null;
  }

  const counts = new Map<number, number>();
  for (const recording of (data ?? []) as RecordingGenreRow[]) {
    if (!recording.genre_id) continue;
    counts.set(recording.genre_id, (counts.get(recording.genre_id) ?? 0) + 1);
  }

  const dominantId = [...counts.entries()].sort((a, b) => b[1] - a[1])[0]?.[0];
  if (!dominantId) return null;

  const { data: genre, error: genreError } = await supabase
    .from("genres")
    .select("id,name,slug")
    .eq("id", dominantId)
    .maybeSingle();

  if (genreError) {
    console.error("getDominantGenreForRecordings genre error:", genreError);
    return null;
  }

  return (genre as GenreRow | null) ?? null;
}

export async function getMoreReleasesFromArtist(
  artistId: string | null | undefined,
  excludeReleaseId: string,
) {
  if (!artistId) return [];

  async function runQuery(includeViews: boolean) {
    let query = supabase
      .from("releases")
      .select(includeViews ? RELEASE_SUMMARY_SELECT_WITH_VIEWS : RELEASE_SUMMARY_SELECT)
      .eq("release_artist_id", artistId)
      .neq("id", excludeReleaseId)
      .not("slug", "is", null)
      .order("release_year", { ascending: false, nullsFirst: false });

    if (includeViews) query = query.order("views", { ascending: false, nullsFirst: false });

    return query.limit(RELEASE_SECTION_LIMIT);
  }

  let { data, error } = await runQuery(true);

  if (error && isMissingReleaseViewsColumn(error)) {
    ({ data, error } = await runQuery(false));
  }

  if (error) {
    console.error("getMoreReleasesFromArtist error:", error);
    return [];
  }

  return hydrateReleaseSummaries((data ?? []) as unknown as ReleaseRow[]);
}

export async function getMoreReleasesFromDecade(
  year: number | null | undefined,
  excludeReleaseId: string,
) {
  if (!year) return [];

  const startYear = Math.floor(year / 10) * 10;
  const endYear = startYear + 9;

  async function runQuery(includeViews: boolean) {
    let query = supabase
      .from("releases")
      .select(includeViews ? RELEASE_SUMMARY_SELECT_WITH_VIEWS : RELEASE_SUMMARY_SELECT)
      .gte("release_year", startYear)
      .lte("release_year", endYear)
      .neq("id", excludeReleaseId)
      .not("slug", "is", null);

    if (includeViews) query = query.order("views", { ascending: false, nullsFirst: false });

    return query
      .order("release_year", { ascending: false, nullsFirst: false })
      .limit(RELEASE_SECTION_LIMIT);
  }

  let { data, error } = await runQuery(true);

  if (error && isMissingReleaseViewsColumn(error)) {
    ({ data, error } = await runQuery(false));
  }

  if (error) {
    console.error("getMoreReleasesFromDecade error:", error);
    return [];
  }

  return hydrateReleaseSummaries((data ?? []) as unknown as ReleaseRow[]);
}

export async function getMoreReleasesInDominantGenre(
  recordingIds: string[],
  excludeReleaseId: string,
) {
  const genre = await getDominantGenreForRecordings(recordingIds);
  if (!genre) return { genre: null, releases: [] };

  const releases = await getReleasesForGenreIds({
    genreIds: [genre.id],
    excludeReleaseId,
    sort: "views",
    limit: RELEASE_SECTION_LIMIT,
  });

  return { genre, releases };
}

export async function getReleaseBySlug(slug: string): Promise<ReleasePageData | null> {
  async function runReleaseQuery(includeViews: boolean) {
    return supabase
      .from("releases")
      .select(
        includeViews
          ? "id, slug, title, type, release_year, year, date, label, country, barcode, catalog_number, release_artist_id, views"
          : "id, slug, title, type, release_year, year, date, label, country, barcode, catalog_number, release_artist_id",
      )
      .eq("slug", slug)
      .maybeSingle();
  }

  let { data: release, error: releaseError } = await runReleaseQuery(true);

  if (releaseError && isMissingReleaseViewsColumn(releaseError)) {
    ({ data: release, error: releaseError } = await runReleaseQuery(false));
  }

  if (releaseError) {
    console.error("getReleaseBySlug release error:", releaseError);
    return null;
  }

  if (!release) return null;

  const releaseRow = release as unknown as ReleaseRow;

  const [artistInfo, tracksResponse] = await Promise.all([
    getReleaseArtistInfo(releaseRow.id),
    supabase
      .from("tracks")
      .select("id, recording_id, track_number, disc_number, position, length, title_override")
      .eq("release_id", releaseRow.id)
      .order("disc_number", { ascending: true, nullsFirst: false })
      .order("track_number", { ascending: true, nullsFirst: false })
      .order("position", { ascending: true, nullsFirst: false }),
  ]);

  // Fetch artist details if we have an artist_id
  let artistResponse = await (artistInfo?.artist_id
    ? supabase
        .from("artists")
        .select("id, slug, name")
        .eq("id", artistInfo.artist_id)
        .maybeSingle()
    : Promise.resolve({ data: null as ReleaseArtistRow | null, error: null }));

  if (artistResponse.error) {
    console.error("getReleaseBySlug artist error:", artistResponse.error);
  }

  if (tracksResponse.error) {
    console.error("getReleaseBySlug tracks error:", tracksResponse.error);
  }

  const trackRows = (tracksResponse.data ?? []) as TrackRow[];
  const recordingIds = [
    ...new Set(trackRows.map((track) => track.recording_id).filter((id): id is string => Boolean(id))),
  ];
  const recordingMap = new Map<string, RecordingRow>();

  if (recordingIds.length > 0) {
    // Large-ID audit: unusually large compilations can exceed 100 tracks; track
    // hydration should use a UUID-array RPC if those releases enter the catalog.
    const { data: recordings, error: recordingsError } = await supabase
      .from("recordings")
      .select("id, slug, title, duration")
      .in("id", recordingIds);

    if (recordingsError) {
      console.error("getReleaseBySlug recordings error:", recordingsError);
    }

    for (const recording of (recordings ?? []) as RecordingRow[]) {
      recordingMap.set(recording.id, recording);
    }
  }

  const tracks = trackRows.map((track) => {
    const recording = track.recording_id ? recordingMap.get(track.recording_id) : null;

    return {
      id: track.id,
      discNumber: track.disc_number ?? 1,
      trackNumber: track.track_number ?? track.position,
      title: track.title_override ?? recording?.title ?? "Untitled track",
      durationMs: track.length ?? recording?.duration ?? null,
      recordingId: track.recording_id,
      recordingSlug: recording?.slug ?? null,
    };
  });

  const artistData = artistResponse.data as { id: string; slug: string | null; name: string } | null;
  // Use credited_as (historical credit text) if available, otherwise use canonical name
  const displayArtist = artistData && artistInfo
    ? {
        id: artistData.id,
        slug: artistData.slug,
        name: artistInfo.credited_as || artistData.name,
      }
    : artistData;

  return {
    id: releaseRow.id,
    slug: releaseRow.slug ?? slug,
    title: releaseRow.title,
    type: releaseRow.type,
    releaseYear: releaseRow.release_year,
    year: releaseRow.year,
    date: releaseRow.date,
    label: releaseRow.label,
    country: releaseRow.country,
    barcode: releaseRow.barcode,
    catalogNumber: releaseRow.catalog_number,
    views: releaseRow.views ?? null,
    coverImageUrl: getReleaseCoverUrl(releaseRow.id),
    artist: displayArtist,
    tracks,
  };
}
