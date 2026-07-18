import { getSupabaseClient } from "@/lib/supabase";
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
  connectedArtists: ArtistSummary[];
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

async function getCatalogGenre(slug: string) {
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

async function getMostViewedPrimaryGenreArtists(values: string[]) {
  if (values.length === 0) return [];

  const supabase = getSupabaseClient();
  const response = await supabase
    .from("artists")
    .select("id, slug, name, province, has_image, image_updated_at, views, primary_role, primary_genre, genres, created_at")
    .eq("status", "published")
    .in("primary_genre", uniqueValues(values))
    .order("views", { ascending: false, nullsFirst: false })
    .order("name", { ascending: true })
    .limit(10);

  if (response.error) throw response.error;
  return (response.data ?? []) as ArtistGenreRow[];
}

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
  const primaryGenreValues = activeSubgenre
    ? uniqueValues([activeSubgenre.slug, activeSubgenre.name, normalize(activeSubgenre.name)])
    : uniqueValues([genre.primaryGenre, genre.slug, genre.title, normalize(genre.title)]);
  const connectedArtistRows =
    (await safeQuery("connectedArtists", () =>
      getMostViewedPrimaryGenreArtists(primaryGenreValues),
    )) ?? [];
  const connectedArtists = connectedArtistRows.map(toArtistSummary);

  return {
    genre,
    subgenres,
    connectedArtists,
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

export async function getTopGenreOptions(): Promise<TopGenreOption[]> {
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

export async function getGenreMedia(genreId: number): Promise<GenreMedia[]> {
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
