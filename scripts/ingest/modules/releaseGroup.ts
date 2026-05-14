import { SupabaseClient } from "@supabase/supabase-js";

export async function upsertReleaseGroup(
  supabase: SupabaseClient,
  mbid: string,
  mbData: any
) {
  const payload = {
    mbid,
    title: mbData.title || null,
    primary_type: mbData["primary-type"] || null,
    secondary_types: mbData["secondary-types"] || [],
    disambiguation: mbData.disambiguation || null,
    metadata: mbData
  };

  const { data, error } = await supabase
    .from("release_groups")
    .upsert(payload, { onConflict: "mbid" })
    .select()
    .limit(1);

  if (error) throw error;
  return data?.[0];
}
