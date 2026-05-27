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