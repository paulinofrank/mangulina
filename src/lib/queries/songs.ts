// src/lib/queries/songs.ts
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
    console.error("published artist status check error:", error);
    return new Set<string>();
  }

  return new Set((data ?? []).map((artist) => artist.id));
}

async function isPublishedArtist(artistId: unknown) {
  if (typeof artistId !== "string" || !artistId) return true;
  const publishedIds = await getPublishedArtistIds([artistId]);
  return publishedIds.has(artistId);
}

// ----------------------
// SONG BY ID
// ----------------------
export async function getSongById(id: string) {
  const cleanId = decodeURIComponent(id).trim().replace(/^"|"$/g, "");

  const { data, error } = await supabase
    .from("recordings_with_release_info")
    .select("*")
    .eq("recording_id", cleanId)
    .single();

  if (error) {
    console.error("getSongById error:", error);
    return null;
  }

  if (!(await isPublishedArtist((data as any)?.artist_id))) {
    return null;
  }

  return data;
}

// ----------------------
// CREDITS
// ----------------------
export type RawCredit = {
  role: string;
  artist: { name: string; status?: string }[];
};

export async function getSongCredits(id: string): Promise<RawCredit[]> {
  const cleanId = decodeURIComponent(id).trim().replace(/^"|"$/g, "");

  const { data, error } = await supabase
    .from("recording_credits")
    .select("role, artist:artists!inner(name, status)")
    .eq("artist.status", "published")
    .eq("recording_id", cleanId);

  return error ? [] : (data as RawCredit[]);
}

// ----------------------
// FUN FACTS
// ----------------------
export async function getSongFunFacts(id: string) {
  const cleanId = decodeURIComponent(id).trim().replace(/^"|"$/g, "");

  const { data, error } = await supabase
    .from("song_fun_facts")
    .select("*")
    .eq("song_id", cleanId);

  return error ? [] : data;
}

// ----------------------
// SLANG
// ----------------------
export async function getSongSlang(id: string) {
  const cleanId = decodeURIComponent(id).trim().replace(/^"|"$/g, "");

  const { data, error } = await supabase
    .from("song_slang")
    .select("*")
    .eq("song_id", cleanId);

  return error ? [] : data;
}

// ----------------------
// RELATED SONGS
// ----------------------
export async function getRelatedSongs(id: string) {
  const cleanId = decodeURIComponent(id).trim().replace(/^"|"$/g, "");

  const { data, error } = await supabase.rpc("get_related_songs", {
    song_id: cleanId,
  });

  if (error) return [];

  const rows = (data ?? []) as any[];
  const publishedArtistIds = await getPublishedArtistIds(rows.map((row) => row.artist_id));

  return rows.filter((row) => !row.artist_id || publishedArtistIds.has(row.artist_id));
}
