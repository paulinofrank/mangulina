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
  const visibleRows = rows.filter((row: any) => !row.artist_id || publishedArtistIds.has(row.artist_id));
  const recordingIds = visibleRows
    .map((row: any) => row.recording_id)
    .filter((id: unknown): id is string => typeof id === "string" && id.length > 0);

  if (!recordingIds.length) return visibleRows;

  const { data: slugRows, error: slugError } = await supabase
    .from("recordings")
    .select("id, slug")
    .in("id", recordingIds);

  if (slugError) {
    console.error(slugError);
    return visibleRows;
  }

  const slugMap = new Map(
    ((slugRows ?? []) as { id: string; slug: string | null }[]).map((row) => [
      row.id,
      row.slug,
    ])
  );

  return visibleRows.map((row: any) => ({
    ...row,
    recording_slug: slugMap.get(row.recording_id) ?? null,
  }));
}
