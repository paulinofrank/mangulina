// src/lib/getSongsByYear.ts
import { supabase } from "@/lib/supabase";

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

  return data;
}
