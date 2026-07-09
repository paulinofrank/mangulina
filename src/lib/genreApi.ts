import { getSupabaseClient } from "@/lib/supabase";
import { getPublicReleaseCoverUrl } from "@/lib/releaseCover";
import { getReleasesForGenreIds, type ReleaseSummary } from "@/lib/releaseApi";
import {
  createGenericGenreDefinition,
  getGenreDefinition,
  type GenreDefinition,
  type GenreSubgenre,
} from "@/lib/genres";
import type { ArtistSummary } from "@/types/home";

const SECTION_LIMIT = 12;

export type GenreSongSummary = {
  id: string;
  slug: string | null;
  title: string;
  artistName: string;
  coverUrl: string;
  views: number | null;
};

export type GenreReleaseSummary = {
  id: string;
  slug: string | null;
  title: string;
  releaseYear: number | null;
  coverUrl: string | null;
  label: string | null;
};

export type GenrePageData = {
  genre: GenreDefinition;
  subgenres: GenreSubgenre[];
  mainArtists: ArtistSummary[];
  connectedArtists: ArtistSummary[];
  popularSongs: GenreSongSummary[];
  importantReleases: GenreReleaseSummary[];
  mostViewedReleases: ReleaseSummary[];
  recentReleases: ReleaseSummary[];
  recentlyAdded: ArtistSummary[];
};

type ArtistGenreRow = ArtistSummary & {
  created_at?: string | null;
  primary_genre?: string | null;
  genres?: string[] | null;
};

type GenreRow = {
  id: number;
  name: string;
  slug: string | null;
  description?: string | null;
  display_order?: number | null;
  is_home_featured?: boolean | null;
};

type SubgenreRow = {
  id: number;
  name: string;
  parent_id: number;
  description?: string | null;
};

type RecordingRow = {
  id: string;
  slug: string | null;
  title: string;
  views: number | null;
  artist_id: string | null;
  release_id: string | null;
  artists?: { name: string | null } | { name: string | null }[] | null;
};

type ReleaseRow = {
  id: string;
  slug: string | null;
  title: string;
  release_year: number | null;
  year: number | null;
  label: string | null;
  has_cover_image?: boolean | null;
};

function normalize(value: string) {
  return value
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase();
}

function firstRelation<T>(value: T | T[] | null | undefined) {
  if (Array.isArray(value)) return value[0] ?? null;
  return value ?? null;
}

function uniqueValues(values: Array<string | null | undefined>) {
  return Array.from(
    new Set(
      values
        .map((value) => value?.trim())
        .filter((value): value is string => Boolean(value)),
    ),
  );
}

async function safeQuery<T>(label: string, query: () => Promise<T>): Promise<T | null> {
  try {
    return await query();
  } catch (error) {
    console.error(`getGenrePageData ${label} error:`, error);
    return null;
  }
}

function toArtistSummary(artist: ArtistGenreRow): ArtistSummary {
  return {
    id: artist.id,
    slug: artist.slug,
    name: artist.name,
    province: artist.province,
    has_image: artist.has_image,
    views: artist.views,
  };
}

async function getCatalogGenre(slug: string) {
  const supabase = getSupabaseClient();
  const genreResponse = await supabase
    .from("genres")
    .select("id,name,description,slug,display_order,is_home_featured")
    .eq("slug", slug)
    .eq("level", 0)
    .eq("active", true)
    .is("parent_id", null)
    .maybeSingle();

  if (genreResponse.error) throw genreResponse.error;
  if (!genreResponse.data) return null;

  const genre = genreResponse.data as GenreRow;
  const subgenreResponse = await supabase
    .from("genres")
    .select("id,parent_id,name,description")
    .eq("parent_id", genre.id)
    .eq("level", 1)
    .eq("active", true)
    .order("sort_order", { ascending: true })
    .order("name", { ascending: true });

  if (subgenreResponse.error) throw subgenreResponse.error;

  const subgenres = ((subgenreResponse.data ?? []) as SubgenreRow[]).map((subgenre) => ({
    id: subgenre.id,
    name: subgenre.name,
    description: subgenre.description ?? null,
  }));

  return { genre, subgenres };
}

function mergeGenreDefinition(
  staticGenre: GenreDefinition | null,
  catalogGenre: Awaited<ReturnType<typeof getCatalogGenre>>,
) {
  if (!catalogGenre) return staticGenre;

  const slug = catalogGenre.genre.slug ?? staticGenre?.slug;
  if (!slug) return staticGenre;

  const aliases = uniqueValues([
    ...(staticGenre?.aliases ?? []),
    catalogGenre.genre.name,
    catalogGenre.genre.slug,
    ...catalogGenre.subgenres.map((subgenre) => subgenre.name),
  ]);

  if (!staticGenre) {
    return createGenericGenreDefinition({
      id: catalogGenre.genre.id,
      slug,
      title: catalogGenre.genre.name,
      description: catalogGenre.genre.description ?? `${catalogGenre.genre.name} in Mangulina.`,
      aliases,
      subgenres: catalogGenre.subgenres,
    });
  }

  return {
    ...staticGenre,
    catalogId: catalogGenre.genre.id,
    slug,
    title: catalogGenre.genre.name || staticGenre.title,
    subtitle:
      catalogGenre.subgenres.length > 0
        ? catalogGenre.subgenres.slice(0, 3).map((subgenre) => subgenre.name).join(", ")
        : staticGenre.subtitle,
    description: catalogGenre.genre.description || staticGenre.description,
    aliases,
    subgenres: catalogGenre.subgenres,
    href: `/genres/${slug}`,
  };
}

async function getMainArtists(primaryGenre: string | null) {
  if (!primaryGenre) return [];

  const supabase = getSupabaseClient();
  const response = await supabase
    .from("artists")
    .select("id, slug, name, province, has_image, views, primary_role, primary_genre, genres, created_at")
    .eq("status", "published")
    .eq("primary_genre", primaryGenre)
    .order("views", { ascending: false, nullsFirst: false })
    .order("name", { ascending: true })
    .limit(SECTION_LIMIT);

  if (response.error) throw response.error;

  return (response.data ?? []) as ArtistGenreRow[];
}

async function getConnectedArtists(genre: GenreDefinition) {
  if (!genre.primaryGenre || genre.aliases.length === 0) return [];

  const supabase = getSupabaseClient();
  const response = await supabase
    .from("artists")
    .select("id, slug, name, province, has_image, views, primary_role, primary_genre, genres, created_at")
    .eq("status", "published")
    .overlaps("genres", genre.aliases)
    .order("views", { ascending: false, nullsFirst: false })
    .order("name", { ascending: true })
    .limit(SECTION_LIMIT * 2);

  if (response.error) throw response.error;

  return ((response.data ?? []) as ArtistGenreRow[])
    .filter((artist) => artist.primary_genre !== genre.primaryGenre)
    .slice(0, SECTION_LIMIT);
}

async function getGenreIds(aliases: string[]) {
  if (aliases.length === 0) return { genreIds: [], subgenreIds: [] };

  const supabase = getSupabaseClient();
  const [genresResponse, subgenresResponse] = await Promise.all([
    supabase
      .from("genres")
      .select("id,name,slug")
      .eq("level", 0)
      .eq("active", true),
    supabase
      .from("genres")
      .select("id,name,parent_id")
      .eq("level", 1)
      .eq("active", true),
  ]);

  if (genresResponse.error) throw genresResponse.error;
  if (subgenresResponse.error) throw subgenresResponse.error;

  const genreRows = (genresResponse.data ?? []) as GenreRow[];
  const subgenreRows = (subgenresResponse.data ?? []) as SubgenreRow[];
  const normalizedAliases = aliases.map(normalize);

  const genreIds = genreRows
    .filter((genre) => {
      const names = [genre.name, genre.slug].filter(Boolean).map((item) => normalize(String(item)));
      return names.some((name) => normalizedAliases.some((alias) => name === alias || name.includes(alias)));
    })
    .map((genre) => genre.id);

  const subgenreIds = subgenreRows
    .filter((subgenre) => {
      const name = normalize(subgenre.name);
      return normalizedAliases.some((alias) => name === alias || name.includes(alias));
    })
    .map((subgenre) => subgenre.id);

  return { genreIds, subgenreIds };
}

async function getPopularSongs(aliases: string[]) {
  const { genreIds, subgenreIds } = await getGenreIds(aliases);

  if (genreIds.length === 0 && subgenreIds.length === 0) return [];

  const supabase = getSupabaseClient();
  const filters = [
    ...genreIds.map((id) => `genre_id.eq.${id}`),
    ...subgenreIds.map((id) => `subgenre_id.eq.${id}`),
  ].join(",");

  const response = await supabase
    .from("recordings")
    .select("id,slug,title,views,artist_id,release_id,artists:artist_id(name)")
    .or(filters)
    .order("views", { ascending: false, nullsFirst: false })
    .limit(SECTION_LIMIT);

  if (response.error) throw response.error;

  const rows = (response.data ?? []) as RecordingRow[];
  const releaseIds = [...new Set(rows.map((recording) => recording.release_id).filter(Boolean))];
  const releaseCoverMap = new Map<string, boolean>();

  if (releaseIds.length > 0) {
    const { data: releases, error: releasesError } = await supabase
      .from("releases")
      .select("id, has_cover_image")
      .in("id", releaseIds);

    if (releasesError) throw releasesError;
    for (const release of (releases ?? []) as Array<{ id: string; has_cover_image: boolean | null }>) {
      releaseCoverMap.set(release.id, release.has_cover_image === true);
    }
  }

  return rows.map((recording) => ({
    id: recording.id,
    slug: recording.slug ?? null,
    title: recording.title,
    artistName: firstRelation(recording.artists)?.name ?? "Unknown artist",
    coverUrl: recording.release_id && releaseCoverMap.get(recording.release_id)
      ? getPublicReleaseCoverUrl(recording.release_id, 150)
      : "/images/placeholder-song.jpg",
    views: recording.views,
  }));
}

async function getImportantReleases(artistIds: string[]) {
  if (artistIds.length === 0) return [];

  const supabase = getSupabaseClient();

  // Get releases from release_artists table (prefer new model)
  const { data: newModelReleases, error: newModelError } = await supabase
    .from("release_artists")
    .select("release_id")
    .in("artist_id", artistIds)
    .eq("role", "primary");

  if (newModelError) throw newModelError;

  const releaseIds = new Set(
    (newModelReleases ?? []).map((row: any) => row.release_id as string)
  );

  // Also get releases from legacy release_artist_id field
  const { data: legacyReleases, error: legacyError } = await supabase
    .from("releases")
    .select("id")
    .in("release_artist_id", artistIds);

  if (legacyError) throw legacyError;

  for (const row of (legacyReleases ?? []) as Array<{ id: string }>) {
    releaseIds.add(row.id);
  }

  // Fetch release details for all found releases
  if (releaseIds.size === 0) return [];

  const { data: releases, error: releasesError } = await supabase
    .from("releases")
    .select("id,slug,title,release_year,year,label,has_cover_image")
    .in("id", Array.from(releaseIds))
    .order("release_year", { ascending: false, nullsFirst: false })
    .limit(SECTION_LIMIT);

  if (releasesError) throw releasesError;

  return ((releases ?? []) as ReleaseRow[]).map((release) => ({
    id: release.id,
    slug: release.slug,
    title: release.title,
    releaseYear: release.release_year ?? release.year,
    coverUrl: release.has_cover_image ? getPublicReleaseCoverUrl(release.id, 150) : null,
    label: release.label,
  }));
}

async function getGenreReleaseSections(aliases: string[]) {
  const { genreIds, subgenreIds } = await getGenreIds(aliases);
  if (genreIds.length === 0 && subgenreIds.length === 0) {
    return { mostViewedReleases: [], recentReleases: [] };
  }

  const [mostViewedReleases, recentReleases] = await Promise.all([
    getReleasesForGenreIds({ genreIds, subgenreIds, sort: "views" }),
    getReleasesForGenreIds({ genreIds, subgenreIds, sort: "recent" }),
  ]);

  return { mostViewedReleases, recentReleases };
}

export async function getGenrePageData(slug: string): Promise<GenrePageData | null> {
  const staticGenre = getGenreDefinition(slug);
  const catalogGenre = await safeQuery("catalogGenre", () => getCatalogGenre(slug));
  const genre = mergeGenreDefinition(staticGenre, catalogGenre);
  if (!genre) return null;

  const subgenres = genre.subgenres ?? [];
  const mainArtistRows = (await safeQuery("mainArtists", () => getMainArtists(genre.primaryGenre))) ?? [];
  const connectedArtistRows =
    (await safeQuery("connectedArtists", () => getConnectedArtists(genre))) ?? [];
  const mainArtists = mainArtistRows.map(toArtistSummary);
  const connectedArtists = connectedArtistRows.map(toArtistSummary);

  const popularSongs =
    (await safeQuery("popularSongs", () => getPopularSongs(genre.aliases))) ?? [];

  const importantReleases =
    (await safeQuery("importantReleases", () =>
      getImportantReleases(mainArtistRows.slice(0, 40).map((artist) => artist.id)),
    )) ?? [];
  const releaseSections =
    (await safeQuery("genreReleaseSections", () => getGenreReleaseSections(genre.aliases))) ?? {
      mostViewedReleases: [],
      recentReleases: [],
    };

  const recentlyAdded = mainArtistRows
    .slice()
    .sort((a, b) => Date.parse(b.created_at ?? "") - Date.parse(a.created_at ?? ""))
    .slice(0, SECTION_LIMIT)
    .map(toArtistSummary);

  return {
    genre,
    subgenres,
    mainArtists,
    connectedArtists,
    popularSongs,
    importantReleases,
    mostViewedReleases: releaseSections.mostViewedReleases,
    recentReleases: releaseSections.recentReleases,
    recentlyAdded,
  };
}

export async function getGenrePageSlugs() {
  const supabase = getSupabaseClient();
  const response = await supabase.from("genres").select("slug");

  if (response.error) {
    console.error("getGenrePageSlugs error:", response.error);
    return [];
  }

  return uniqueValues((response.data ?? []).map((genre) => genre.slug));
}
