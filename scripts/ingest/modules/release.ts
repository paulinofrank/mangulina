import { SupabaseClient } from "@supabase/supabase-js";
import { normalizeMBDate } from "../utils.js";

export async function upsertRelease(
  supabase: SupabaseClient,
  mbid: string,
  mbData: any,
  releaseGroupId: string | null,
  coverPath: string | null
) {
  const payload = {
    mbid,
    title: mbData.title || null,
    release_group_id: releaseGroupId,

    // FIX: Normalizamos fechas de MusicBrainz
    date: normalizeMBDate(mbData.date || null),

    country: mbData.country || null,
    status: mbData.status || null,
    packaging: mbData.packaging || null,
    barcode: mbData.barcode || null,

    catalog_number:
      mbData["label-info"]?.[0]?.catalogue || null,

    metadata: mbData,
    cover_image_url: coverPath
  };

  const { data, error } = await supabase
    .from("releases")
    .upsert(payload, { onConflict: "mbid" })
    .select()
    .limit(1);

  if (error) throw error;
  return data?.[0];
}
