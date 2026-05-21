// src/lib/queries/songs.ts
import { supabase } from "@/lib/supabase";

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

  return data;
}

// ----------------------
// CREDITS
// ----------------------
export type RawCredit = {
  role: string;
  artist: { name: string }[];
};

export async function getSongCredits(id: string): Promise<RawCredit[]> {
  const cleanId = decodeURIComponent(id).trim().replace(/^"|"$/g, "");

  const { data, error } = await supabase
    .from("recording_credits")
    .select("role, artist:artists(name)")
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

  return error ? [] : data;
}
