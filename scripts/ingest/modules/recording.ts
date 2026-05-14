import { SupabaseClient } from "@supabase/supabase-js";

export async function upsertRecording(
  supabase: SupabaseClient,
  mbid: string,
  mbData: any
) {
  const payload = {
    mbid,
    title: mbData.title || null,
    duration: mbData.length || null,
    disambiguation: mbData.disambiguation || null,
    isrcs: mbData.isrcs || [],
    metadata: mbData
  };

  const { data, error } = await supabase
    .from("recordings")
    .upsert(payload, { onConflict: "mbid" })
    .select()
    .limit(1);

  if (error) throw error;
  return data?.[0];
}
