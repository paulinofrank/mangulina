import { getSupabaseClient } from "@/lib/supabase";

export type ArtistAward = {
  year: number;
  award: string;
  category: string | null;
  work: string | null;
  won: boolean;
  country: string | null;
  source: string | null;
};

export type ArtistMedia = {
  id: string;
  artist_id: string;
  media_type: string;
  title: string;
  url: string;
  platform: string;
  external_id: string | null;
  thumbnail_url: string | null;
  published_date: string | null;
  youtube_channel_id: string | null;
  youtube_channel_name: string | null;
  youtube_channel_url: string | null;
  youtube_channel_avatar_url: string | null;
  youtube_metadata_fetched_at: string | null;
  is_official: boolean;
  is_featured: boolean;
  display_order: number;
  notes: string | null;
};

export type ArtistProfileData = {
  id: string;
  name: string;
  slug: string;
  type:
    | "person"
    | "duo"
    | "group"
    | "orchestra"
    | "choir"
    | "collective"
    | "other"
    | null;
  ended: boolean | null;
  bio_en: string | null;
  bio_es: string | null;
  views: number | null;

  first_name: string | null;
  middle_name: string | null;
  last_name: string | null;
  second_last_name: string | null;
  stage_name: string | null;

  date_of_birth: string | null;
  date_of_death: string | null;
  death_year: number | null;
  birth_place: string | null;
  province: string | null;

  primary_role: string | null;
  primary_genre: string | null;
  occupations: Record<string, unknown> | string[] | null;
  instruments: Record<string, unknown> | string[] | null;

  genres: string[] | null;
  artist_tags: string[] | null;
  aliases: string[] | null;
  pseudonyms: string[] | null;

  website: string | null;
  youtube: string | null;
  facebook: string | null;
  instagram: string | null;

  awards: ArtistAward[];
};

export async function getArtistProfile(slug: string) {
  const supabase = getSupabaseClient();

  const { data: publishedArtist, error: publishedArtistError } = await supabase
    .from("artists")
    .select("id, type, ended, bio_en, bio_es, primary_genre, views, date_of_death, death_year, instruments")
    .eq("slug", slug)
    .eq("status", "published")
    .maybeSingle();

  if (publishedArtistError || !publishedArtist) {
    if (publishedArtistError) {
      console.error("getArtistProfile published artist check error:", publishedArtistError);
    }
    return null;
  }

  const { data, error } = await supabase.rpc("get_artist_profile_page", {
    artist_slug: slug,
  });

  if (error || !data) {
    console.error("getArtistProfile error:", error);
    return null;
  }

  return {
    ...(data as ArtistProfileData),
    type:
      (data as Partial<ArtistProfileData>).type ??
      publishedArtist.type ??
      null,
    ended:
      (data as Partial<ArtistProfileData>).ended ??
      publishedArtist.ended ??
      null,
    bio_en:
      (data as Partial<ArtistProfileData>).bio_en ??
      publishedArtist.bio_en ??
      null,
    bio_es:
      (data as Partial<ArtistProfileData>).bio_es ??
      publishedArtist.bio_es ??
      null,
    date_of_death:
      (data as Partial<ArtistProfileData>).date_of_death ??
      publishedArtist.date_of_death ??
      null,
    death_year:
      (data as Partial<ArtistProfileData>).death_year ??
      publishedArtist.death_year ??
      null,
    primary_genre:
      (data as Partial<ArtistProfileData>).primary_genre ??
      publishedArtist.primary_genre ??
      null,
    views:
      (data as Partial<ArtistProfileData>).views ??
      publishedArtist.views ??
      null,
    instruments:
      (data as Partial<ArtistProfileData>).instruments ??
      publishedArtist.instruments ??
      null,
  };
}

/* ==========================================================
   DISCOGRAPHY
   ========================================================== */

type DiscographyRow = {
  release_id: string;
  release_title: string;
  release_year: number | null;
  release_type: string | null;

  track_id: string;
  disc_number: number;
  track_number: number | null;

  recording_id: string;
  recording_title: string;
  duration_ms: number | null;

  genre: string | null;
  subgenre: string | null;
  recording_context: string | null;
};

export type DiscographyTrack = {
  track_id: string;
  disc_number: number;
  track_number: number | null;

  recording_id: string;
  recording_title: string;
  duration_ms: number | null;

  genre: string | null;
  subgenre: string | null;
  recording_context: string | null;

  slug: string | null;
};

export type DiscographyRelease = {
  release_id: string;
  release_slug: string | null;
  release_title: string;
  release_year: number | null;
  release_type: string | null;

  tracks: DiscographyTrack[];
};

export type DiscographyReleaseSummary = {
  release_id: string;
  release_slug: string | null;
  release_title: string;
  release_year: number | null;
  release_type: string | null;
  track_count: number;
};

type ReleaseSummaryRow = {
  id: string;
  slug: string | null;
  title: string;
  release_year: number | null;
  year: number | null;
  type: string | null;
  release_group_id: string | null;
  country: string | null;
  date: string | null;
  created_at: string | null;
  release_group:
    | ReleaseGroupSummaryRow
    | null;
  tracks: Array<{ count: number }> | null;
};

type ReleaseGroupSummaryRow = {
  id: string;
  title: string | null;
  release_year: number | null;
  primary_type: string | null;
};

function getReleaseRank(row: ReleaseSummaryRow) {
  const countryRank =
    row.country === "DO" ? 0 : row.country === "XW" ? 1 : row.country == null ? 2 : 3;
  const dateRank = row.date ? Date.parse(row.date) : Number.MAX_SAFE_INTEGER;
  const createdRank = row.created_at ? Date.parse(row.created_at) : Number.MAX_SAFE_INTEGER;

  return [countryRank, dateRank, createdRank] as const;
}

function compareReleaseRows(a: ReleaseSummaryRow, b: ReleaseSummaryRow) {
  const aRank = getReleaseRank(a);
  const bRank = getReleaseRank(b);

  for (let index = 0; index < aRank.length; index += 1) {
    const diff = aRank[index] - bRank[index];
    if (diff !== 0) return diff;
  }

  return a.title.localeCompare(b.title);
}

export async function getArtistDiscographySummaries(
  artistId: string,
): Promise<DiscographyReleaseSummary[]> {
  const supabase = getSupabaseClient();

  const { data, error } = await supabase
    .from("releases")
    .select(
      `
        id,
        slug,
        title,
        release_year,
        year,
        type,
        release_group_id,
        country,
        date,
        created_at,
        tracks(count)
      `,
    )
    .eq("release_artist_id", artistId);

  if (error) {
    console.error("getArtistDiscographySummaries error:", {
      code: error.code,
      message: error.message,
      details: error.details,
      hint: error.hint,
    });

    return [];
  }

  const rows = (data ?? []) as unknown as ReleaseSummaryRow[];
  const releaseGroupIds = [...new Set(rows.map((row) => row.release_group_id).filter(Boolean))];
  const releaseGroupsById = new Map<string, ReleaseGroupSummaryRow>();

  if (releaseGroupIds.length > 0) {
    const { data: releaseGroupRows, error: releaseGroupsError } = await supabase
      .from("release_groups")
      .select("id, title, release_year, primary_type")
      .in("id", releaseGroupIds);

    if (releaseGroupsError) {
      console.error("getArtistDiscographySummaries release groups error:", {
        code: releaseGroupsError.code,
        message: releaseGroupsError.message,
        details: releaseGroupsError.details,
        hint: releaseGroupsError.hint,
      });
    } else {
      for (const releaseGroup of (releaseGroupRows ?? []) as ReleaseGroupSummaryRow[]) {
        releaseGroupsById.set(releaseGroup.id, releaseGroup);
      }
    }
  }

  const selectedRows = new Map<string, ReleaseSummaryRow>();

  for (const row of rows) {
    const key = row.release_group_id ?? row.id;
    row.release_group = row.release_group_id
      ? releaseGroupsById.get(row.release_group_id) ?? null
      : null;
    const current = selectedRows.get(key);

    if (!current || compareReleaseRows(row, current) < 0) {
      selectedRows.set(key, row);
    }
  }

  return Array.from(selectedRows.values())
    .map((row) => {
      const releaseGroup = row.release_group;

      return {
        release_id: row.id,
        release_slug: row.slug,
        release_title: releaseGroup?.title ?? row.title,
        release_year: releaseGroup?.release_year ?? row.release_year ?? row.year,
        release_type: releaseGroup?.primary_type ?? row.type,
        track_count: row.tracks?.[0]?.count ?? 0,
      };
    })
    .sort((a, b) => {
      const aYear = a.release_year ?? Number.MAX_SAFE_INTEGER;
      const bYear = b.release_year ?? Number.MAX_SAFE_INTEGER;
      if (aYear !== bYear) return aYear - bYear;
      return a.release_title.localeCompare(b.release_title);
    });
}

export async function getArtistDiscography(
  artistId: string
): Promise<DiscographyRelease[]> {
  const supabase = getSupabaseClient();

  const { data, error } = await supabase.rpc("get_artist_discography", {
    artist_uuid: artistId,
  });

  if (error) {
    console.error("getArtistDiscography error:", {
      code: error.code,
      message: error.message,
      details: error.details,
      hint: error.hint,
    });

    return [];
  }

  const rows = (data ?? []) as DiscographyRow[];

  // Fetch slugs for all recordings and releases returned by the RPC
  const allRecordingIds = [...new Set(rows.map((r) => r.recording_id).filter(Boolean))];
  const slugMap = new Map<string, string | null>();
  if (allRecordingIds.length > 0) {
    // Large-ID audit: prolific artists can exceed 100 recordings; move slug hydration
    // into get_artist_discography (or a UUID-array RPC) instead of chunking this request.
    const { data: slugRows } = await supabase
      .from("recordings")
      .select("id, slug")
      .in("id", allRecordingIds);
    for (const row of (slugRows ?? []) as { id: string; slug: string | null }[]) {
      slugMap.set(row.id, row.slug);
    }
  }

  const allReleaseIds = [...new Set(rows.map((r) => r.release_id).filter(Boolean))];
  const releaseSlugMap = new Map<string, string | null>();
  if (allReleaseIds.length > 0) {
    // Large-ID audit: a large discography can also exceed 100 releases; this belongs
    // in the discography RPC rather than a growing PostgREST URL.
    const { data: releaseSlugRows } = await supabase
      .from("releases")
      .select("id, slug")
      .in("id", allReleaseIds);
    for (const row of (releaseSlugRows ?? []) as { id: string; slug: string | null }[]) {
      releaseSlugMap.set(row.id, row.slug);
    }
  }

  const releases = new Map<string, DiscographyRelease>();

  for (const row of rows) {
    if (!releases.has(row.release_id)) {
      releases.set(row.release_id, {
        release_id: row.release_id,
        release_slug: releaseSlugMap.get(row.release_id) ?? null,
        release_title: row.release_title,
        release_year: row.release_year,
        release_type: row.release_type,
        tracks: [],
      });
    }

    releases.get(row.release_id)?.tracks.push({
      track_id: row.track_id,
      disc_number: row.disc_number,
      track_number: row.track_number,
      recording_id: row.recording_id,
      recording_title: row.recording_title,
      duration_ms: row.duration_ms,
      genre: row.genre,
      subgenre: row.subgenre,
      recording_context: row.recording_context,
      slug: slugMap.get(row.recording_id) ?? null,
    });
  }

  return Array.from(releases.values());
}

export async function getArtistMedia(artistId: string): Promise<ArtistMedia[]> {
  const supabase = getSupabaseClient();
  const baseFields =
    "id, artist_id, media_type, title, url, platform, external_id, thumbnail_url, published_date, is_official, is_featured, display_order, notes";
  const youtubeFields =
    "youtube_channel_id, youtube_channel_name, youtube_channel_url, youtube_channel_avatar_url, youtube_metadata_fetched_at";

  const queryArtistMedia = (selectFields: string) =>
    supabase
      .from("artist_media")
      .select(selectFields)
      .eq("artist_id", artistId)
      .order("is_featured", { ascending: false })
      .order("display_order", { ascending: true })
      .order("published_date", { ascending: false, nullsFirst: false })
      .order("created_at", { ascending: true });

  const { data, error } = await queryArtistMedia(`${baseFields}, ${youtubeFields}`);
  const fallbackResponse = error ? await queryArtistMedia(baseFields) : null;
  const resolvedData = fallbackResponse?.data ?? data;
  const resolvedError = fallbackResponse?.error ?? null;

  if (resolvedError) {
    console.error("getArtistMedia error:", {
      code: resolvedError.code,
      message: resolvedError.message,
      details: resolvedError.details,
      hint: resolvedError.hint,
    });

    return [];
  }

  const rows = (resolvedData ?? []) as unknown as Partial<ArtistMedia>[];

  return rows.map((item) => ({
    ...(item as Omit<
      ArtistMedia,
      | "youtube_channel_id"
      | "youtube_channel_name"
      | "youtube_channel_url"
      | "youtube_channel_avatar_url"
      | "youtube_metadata_fetched_at"
    >),
    youtube_channel_id:
      "youtube_channel_id" in item ? item.youtube_channel_id : null,
    youtube_channel_name:
      "youtube_channel_name" in item ? item.youtube_channel_name : null,
    youtube_channel_url:
      "youtube_channel_url" in item ? item.youtube_channel_url : null,
    youtube_channel_avatar_url:
      "youtube_channel_avatar_url" in item
        ? item.youtube_channel_avatar_url
        : null,
    youtube_metadata_fetched_at:
      "youtube_metadata_fetched_at" in item
        ? item.youtube_metadata_fetched_at
        : null,
  })) as ArtistMedia[];
}
