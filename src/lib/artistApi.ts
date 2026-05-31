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

export type ArtistProfileData = {
  id: string;
  name: string;
  slug: string;
  type: "person" | "duo" | "group" | null;
  bio: string | null;

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
  occupations: Record<string, unknown> | string[] | null;

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

  const { data, error } = await supabase.rpc("get_artist_profile_page", {
    artist_slug: slug,
  });

  if (error || !data) {
    console.error("getArtistProfile error:", error);
    return null;
  }

  return data as ArtistProfileData;
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
};

export type DiscographyRelease = {
  release_id: string;
  release_title: string;
  release_year: number | null;
  release_type: string | null;

  tracks: DiscographyTrack[];
};

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
  const releases = new Map<string, DiscographyRelease>();

  for (const row of rows) {
    if (!releases.has(row.release_id)) {
      releases.set(row.release_id, {
        release_id: row.release_id,
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
    });
  }

  return Array.from(releases.values());
}