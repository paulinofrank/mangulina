import { SupabaseClient } from "@supabase/supabase-js";

export async function upsertTrack(
  supabase: SupabaseClient,
  trackMbid: string | null,
  releaseId: string,
  recordingId: string | null,
  trackObj: any
) {
  const payload = {
    mbid: trackMbid,
    release_id: releaseId,
    recording_id: recordingId,
    track_number: trackObj.position || null,
    disc_number: trackObj["medium-position"] || 1,
    position: trackObj.position || null,
    length: trackObj.length || null,
    metadata: trackObj
  };

  const { data, error } = await supabase
    .from("tracks")
    .upsert(payload, { onConflict: "mbid" })
    .select()
    .limit(1);

  if (error) throw error;
  return data?.[0];
}
