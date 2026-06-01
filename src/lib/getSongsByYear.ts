// src/lib/getSongsByYear.ts
import { supabase } from "@/lib/supabase";

async function getPublishedArtistIds(artistIds: unknown[]) {
  const ids = [...new Set(artistIds.filter((id): id is string => typeof id === "string" && id.length > 0))];

  if (!ids.length) return new Set<string>();

  const { data, error } = await supabase
    .from("artists")
    .select("id")
    .eq("status", "published")
    .in("id", ids);

  if (error) {
    console.error(error);
    return new Set<string>();
  }

  return new Set((data ?? []).map((artist) => artist.id));
}

export async function getSongsByYear(year: number) {
  const { data, error } = await supabase
    .from("recordings_with_release_info")
    .select("*")
    .eq("release_year_actual", year)
    .order("recording_title", { ascending: true });

  if (error) {
    console.error(error);
    return [];
  }

  const rows = data ?? [];
  const publishedArtistIds = await getPublishedArtistIds(rows.map((row: any) => row.artist_id));

  return rows.filter((row: any) => !row.artist_id || publishedArtistIds.has(row.artist_id));
}
