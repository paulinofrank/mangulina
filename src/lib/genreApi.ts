import { getSupabaseClient } from "@/lib/supabase";
import { unstable_cache } from "next/cache";
import {
  PUBLIC_GENRE_REVALIDATE_SECONDS,
  PUBLIC_GENRE_CACHE_TAG,
} from "@/lib/publicCatalogCache";
import {
  createGenericGenreDefinition,
  genreDefinitions,
  getGenreDefinition,
  type GenreDefinition,
  type GenreSubgenre,
} from "@/lib/genres";
import type { ArtistSummary } from "@/types/home";

export type GenrePageData = {
  genre: GenreDefinition;
  subgenres: GenreSubgenre[];
  connectedSoloArtists: ArtistSummary[];
  connectedGroupArtists: ArtistSummary[];
};

// The only two collective types in the catalog (see artists.type); everything
// else — solo_artist, legacy/unclassified rows — counts as solo.
const COLLECTIVE_ARTIST_TYPES = ["group", "duo"] as const;
type ArtistKindFilter = "solo" | "collective";

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
  history_en?: string | null;
  history_es?: string | null;
  display_order?: number | null;
  is_home_featured?: boolean | null;
};

type SubgenreRow = {
  id: number;
  slug: string | null;
  name: string;
  parent_id: number;
  description?: string | null;
  history_en?: string | null;
  history_es?: string | null;
};

export type TopGenreOption = {
  slug: string;
  name: string;
};

export type GenreMedia = {
  id: string; title: string; url: string; platform: string; media_type: string;
  external_id: string | null; thumbnail_url: string | null; published_date: string | null;
  youtube_channel_id: string | null; youtube_channel_name: string | null;
  youtube_channel_url: string | null; youtube_channel_avatar_url: string | null;
  youtube_metadata_fetched_at: string | null; notes: string | null;
};

function normalize(value: string) {
  return value
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase();
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
    image_updated_at: artist.image_updated_at,
    views: artist.views,
  };
}

async function loadCatalogGenre(slug: string) {
  const supabase = getSupabaseClient();
  const genreResponse = await supabase
    .from("genres")
    .select("id,name,description,history_en,history_es,slug,display_order,is_home_featured")
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
    .select("id,parent_id,name,slug,description,history_en,history_es")
    .eq("parent_id", genre.id)
    .eq("level", 1)
    .eq("active", true)
    .order("sort_order", { ascending: true })
    .order("name", { ascending: true });

  if (subgenreResponse.error) throw subgenreResponse.error;

  const subgenres = ((subgenreResponse.data ?? []) as SubgenreRow[]).map((subgenre) => ({
    id: subgenre.id,
    slug: subgenre.slug ?? String(subgenre.id),
    name: subgenre.name,
    description: subgenre.description ?? null,
    history: subgenre.history_en ?? null,
    historyEs: subgenre.history_es ?? null,
  }));

  return { genre, subgenres };
}

const getCatalogGenre = unstable_cache(
  loadCatalogGenre,
  ["public-catalog-genre-v5"],
  {
    revalidate: PUBLIC_GENRE_REVALIDATE_SECONDS,
    tags: [PUBLIC_GENRE_CACHE_TAG],
  },
);

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
    ...catalogGenre.subgenres.flatMap((subgenre) => [subgenre.name, subgenre.slug]),
  ]);

  if (!staticGenre) {
    const genericGenre = createGenericGenreDefinition({
      id: catalogGenre.genre.id,
      slug,
      title: catalogGenre.genre.name,
      description: catalogGenre.genre.description ?? `${catalogGenre.genre.name} in Mangulina.`,
      aliases,
      subgenres: catalogGenre.subgenres,
    });
    return {
      ...genericGenre,
      history: catalogGenre.genre.history_en ?? undefined,
      historyEs: catalogGenre.genre.history_es ?? undefined,
    };
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
    history: catalogGenre.genre.history_en ?? undefined,
    historyEs: catalogGenre.genre.history_es ?? undefined,
    aliases,
    subgenres: catalogGenre.subgenres,
    href: `/genres/${slug}`,
  };
}

async function loadMostViewedPrimaryGenreArtists(values: string[], kind: ArtistKindFilter) {
  if (values.length === 0) return [];

  const supabase = getSupabaseClient();
  const base = supabase
    .from("artists")
    .select("id, slug, name, province, has_image, image_updated_at, views, type, primary_role, primary_genre, genres, created_at")
    .eq("status", "published")
    .in("primary_genre", uniqueValues(values));

  // Solo also catches a null/unclassified type, matching how the admin editor
  // treats anything that isn't a group or duo as reachable under "solo".
  const scoped =
    kind === "collective"
      ? base.in("type", COLLECTIVE_ARTIST_TYPES)
      : base.or(`type.is.null,type.not.in.(${COLLECTIVE_ARTIST_TYPES.join(",")})`);

  const response = await scoped
    .order("views", { ascending: false, nullsFirst: false })
    .order("name", { ascending: true })
    .limit(10);

  if (response.error) throw response.error;
  return (response.data ?? []) as ArtistGenreRow[];
}

const getMostViewedPrimaryGenreArtists = unstable_cache(
  loadMostViewedPrimaryGenreArtists,
  ["public-genre-artists-v2"],
  {
    revalidate: PUBLIC_GENRE_REVALIDATE_SECONDS,
    tags: [PUBLIC_GENRE_CACHE_TAG],
  },
);

export async function getGenrePageData(
  slug: string,
  requestedSubgenreSlug?: string,
): Promise<GenrePageData | null> {
  const staticGenre = getGenreDefinition(slug);
  const catalogGenre = await safeQuery("catalogGenre", () => getCatalogGenre(slug));
  const mergedGenre = mergeGenreDefinition(staticGenre, catalogGenre);
  if (!mergedGenre) return null;
  const genre = {
    ...mergedGenre,
    history: catalogGenre?.genre.history_en ?? undefined,
    historyEs: catalogGenre?.genre.history_es ?? undefined,
  };

  const subgenres = genre.subgenres ?? [];
  const activeSubgenre = requestedSubgenreSlug
    ? subgenres.find((subgenre) => subgenre.slug === requestedSubgenreSlug) ?? null
    : null;
  // The parent view rolls its subgenres up. `primary_genre` legitimately holds
  // level-1 slugs (merengue-orquesta, urban-dembow), and matching the parent's
  // own labels alone hid every artist classified that precisely — 122 published
  // artists, including the whole dembow and perico ripiao rosters. Selecting a
  // subgenre still narrows to that subgenre only.
  const primaryGenreValues = activeSubgenre
    ? uniqueValues([activeSubgenre.slug, activeSubgenre.name, normalize(activeSubgenre.name)])
    : uniqueValues([
        genre.primaryGenre,
        genre.slug,
        genre.title,
        normalize(genre.title),
        ...subgenres.flatMap((subgenre) => [
          subgenre.slug,
          subgenre.name,
          normalize(subgenre.name),
        ]),
      ]);
  const [connectedSoloArtistRows, connectedGroupArtistRows] = await Promise.all([
    safeQuery("connectedSoloArtists", () =>
      getMostViewedPrimaryGenreArtists(primaryGenreValues, "solo"),
    ),
    safeQuery("connectedGroupArtists", () =>
      getMostViewedPrimaryGenreArtists(primaryGenreValues, "collective"),
    ),
  ]);

  return {
    genre,
    subgenres,
    connectedSoloArtists: (connectedSoloArtistRows ?? []).map(toArtistSummary),
    connectedGroupArtists: (connectedGroupArtistRows ?? []).map(toArtistSummary),
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

async function loadTopGenreOptions(): Promise<TopGenreOption[]> {
  const supabase = getSupabaseClient();
  const response = await supabase
    .from("genres")
    .select("slug,name")
    .eq("level", 0)
    .eq("active", true)
    .is("parent_id", null)
    .order("display_order", { ascending: true })
    .order("name", { ascending: true });

  if (response.error) {
    console.error("getTopGenreOptions error:", response.error);
    return genreDefinitions.map((genre) => ({ slug: genre.slug, name: genre.title }));
  }

  return (response.data ?? [])
    .filter((genre): genre is { slug: string; name: string } => Boolean(genre.slug))
    .map((genre) => ({ slug: genre.slug, name: genre.name }));
}

export const getTopGenreOptions = unstable_cache(
  loadTopGenreOptions,
  ["public-top-genre-options-v1"],
  {
    revalidate: PUBLIC_GENRE_REVALIDATE_SECONDS,
    tags: [PUBLIC_GENRE_CACHE_TAG],
  },
);

async function loadGenreMedia(genreId: number): Promise<GenreMedia[]> {
  const { data, error } = await getSupabaseClient()
    .from("genre_media")
    .select("id,title,url,platform,media_type,external_id,thumbnail_url,published_date,youtube_channel_id,youtube_channel_name,youtube_channel_url,youtube_channel_avatar_url,youtube_metadata_fetched_at,notes")
    .eq("genre_id", genreId)
    .order("is_featured", { ascending: false })
    .order("display_order", { ascending: true })
    .order("created_at", { ascending: true });
  if (error) {
    console.error("getGenreMedia error:", error);
    return [];
  }
  return (data ?? []) as GenreMedia[];
}

export const getGenreMedia = unstable_cache(
  loadGenreMedia,
  ["public-genre-media-v1"],
  {
    revalidate: PUBLIC_GENRE_REVALIDATE_SECONDS,
    tags: [PUBLIC_GENRE_CACHE_TAG],
  },
);

/**
 * Artists and media for one subgenre of a genre.
 *
 * Phase 3A moved subgenre filtering off the server render so the canonical
 * genre page can live in the Full Route Cache. The server now always renders
 * the unfiltered genre; this is what the client calls when a visitor picks a
 * subgenre. It reuses the same cached helpers the canonical render uses
 * (getGenrePageData, getMostViewedPrimaryGenreArtists, getGenreMedia), so a
 * filtered view costs no more database work than the page already did — and
 * usually none, because those caches are warm.
 *
 * Returns null for an unknown genre or subgenre so the caller can fall back to
 * the canonical view rather than render an empty state.
 */
export async function getSubgenreContext(
  genreSlug: string,
  subgenreSlug: string,
): Promise<{ soloArtists: ArtistSummary[]; groupArtists: ArtistSummary[]; media: GenreMedia[] } | null> {
  const data = await getGenrePageData(genreSlug);
  if (!data) return null;

  const subgenre = data.subgenres.find((entry) => entry.slug === subgenreSlug);
  if (!subgenre) return null;

  const subgenreValues = uniqueValues([subgenre.slug, subgenre.name, normalize(subgenre.name)]);
  const [soloArtistRows, groupArtistRows] = await Promise.all([
    safeQuery("subgenreSoloArtists", () => getMostViewedPrimaryGenreArtists(subgenreValues, "solo")),
    safeQuery("subgenreGroupArtists", () =>
      getMostViewedPrimaryGenreArtists(subgenreValues, "collective"),
    ),
  ]);

  const media = subgenre.id ? await getGenreMedia(subgenre.id) : [];

  return {
    soloArtists: (soloArtistRows ?? []).map(toArtistSummary),
    groupArtists: (groupArtistRows ?? []).map(toArtistSummary),
    media,
  };
}
