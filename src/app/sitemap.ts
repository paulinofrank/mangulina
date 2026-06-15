import type { MetadataRoute } from "next";

import { genreDefinitions } from "@/lib/genres";
import { buildCanonical } from "@/lib/seo";
import { getSupabaseClient } from "@/lib/supabase";
import { getPublishedProvinces } from "@/lib/provinces";

const PAGE_SIZE = 1000;

export const revalidate = 3600;

type ArtistSitemapRow = { id: string; slug: string | null };
type ReleaseSitemapRow = {
  id: string;
  slug: string | null;
  release_artist_id: string | null;
};
type RecordingSitemapRow = {
  slug: string | null;
  artist_id: string | null;
  release_id: string | null;
};
type GenreSitemapRow = { slug: string | null };

async function getPublishedArtists() {
  const supabase = getSupabaseClient();
  const rows: ArtistSitemapRow[] = [];

  for (let from = 0; ; from += PAGE_SIZE) {
    const { data, error } = await supabase
      .from("artists")
      .select("id,slug")
      .eq("status", "published")
      .not("slug", "is", null)
      .range(from, from + PAGE_SIZE - 1);

    if (error) throw error;
    const page = (data ?? []) as ArtistSitemapRow[];
    rows.push(...page);
    if (page.length < PAGE_SIZE) break;
  }

  return rows;
}

async function getReleases() {
  const supabase = getSupabaseClient();
  const rows: ReleaseSitemapRow[] = [];

  for (let from = 0; ; from += PAGE_SIZE) {
    const { data, error } = await supabase
      .from("releases")
      .select("id,slug,release_artist_id")
      .not("slug", "is", null)
      .range(from, from + PAGE_SIZE - 1);

    if (error) throw error;
    const page = (data ?? []) as ReleaseSitemapRow[];
    rows.push(...page);
    if (page.length < PAGE_SIZE) break;
  }

  return rows;
}

async function getRecordings() {
  const supabase = getSupabaseClient();
  const rows: RecordingSitemapRow[] = [];

  for (let from = 0; ; from += PAGE_SIZE) {
    const { data, error } = await supabase
      .from("recordings")
      .select("slug,artist_id,release_id")
      .not("slug", "is", null)
      .range(from, from + PAGE_SIZE - 1);

    if (error) throw error;
    const page = (data ?? []) as RecordingSitemapRow[];
    rows.push(...page);
    if (page.length < PAGE_SIZE) break;
  }

  return rows;
}

async function getActiveGenreSlugs() {
  const supabase = getSupabaseClient();
  const { data, error } = await supabase
    .from("genres")
    .select("slug")
    .eq("active", true)
    .eq("level", 0)
    .is("parent_id", null)
    .not("slug", "is", null);

  if (error) throw error;
  return (data ?? []) as GenreSitemapRow[];
}

function entry(path: string, priority?: number): MetadataRoute.Sitemap[number] {
  return {
    url: buildCanonical(path),
    changeFrequency: "weekly",
    priority,
  };
}

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const [artists, releases, recordings, databaseGenres, provinces] = await Promise.all([
    getPublishedArtists(),
    getReleases(),
    getRecordings(),
    getActiveGenreSlugs(),
    getPublishedProvinces(),
  ]);

  const publishedArtistIds = new Set(artists.map((artist) => artist.id));
  const publicReleases = releases.filter(
    (release) => !release.release_artist_id || publishedArtistIds.has(release.release_artist_id),
  );
  const publicReleaseIds = new Set(publicReleases.map((release) => release.id));
  const publicRecordings = recordings.filter((recording) => {
    if (recording.artist_id) return publishedArtistIds.has(recording.artist_id);
    if (recording.release_id) return publicReleaseIds.has(recording.release_id);
    return true;
  });
  const genreSlugs = new Set([
    ...genreDefinitions.map((genre) => genre.slug),
    ...databaseGenres.map((genre) => genre.slug).filter((slug): slug is string => Boolean(slug)),
  ]);

  return [
    entry("/", 1),
    entry("/discover", 0.8),
    entry("/artists", 0.9),
    entry("/artists/legends", 0.8),
    entry("/artists/emerging", 0.8),
    entry("/artists/most-awarded", 0.8),
    entry("/instrumental-classical", 0.7),
    entry("/composers", 0.8),
    entry("/songwriters", 0.8),
    entry("/lyricists", 0.8),
    entry("/musicians", 0.8),
    entry("/djs", 0.8),
    entry("/producers", 0.8),
    entry("/christian", 0.8),
    entry("/archive", 0.9),
    entry("/artists/birthdays", 0.7),
    entry("/about", 0.6),
    entry("/contact", 0.5),
    entry("/contributors", 0.5),
    entry("/privacy-policy", 0.4),
    entry("/terms-of-use", 0.4),
    entry("/dmca", 0.4),
    ...provinces.map((province) => entry(`/provinces/${province.slug}`, 0.8)),
    ...artists.map((artist) => entry(`/artists/${artist.slug}`, 0.8)),
    ...publicRecordings.map((recording) => entry(`/songs/${recording.slug}`, 0.7)),
    ...publicReleases.map((release) => entry(`/releases/${release.slug}`, 0.7)),
    ...[...genreSlugs].map((slug) => entry(`/genres/${slug}`, 0.7)),
  ];
}
