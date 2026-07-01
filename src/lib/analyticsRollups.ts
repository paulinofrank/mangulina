// analyticsRollups.ts
// Server-side readers for the time-windowed view rollups (materialized views
// created in 20260701000000_analytics_rollups.sql). Used to rank "Trending"
// (last 7 days) and "Rising" (emerging artists by last 7 days) separately from
// the all-time `views` column used by the "Most Viewed / Top …" sections.
//
// These read aggregated counts only (no per-event data) via the service role,
// so nothing is exposed to the browser. Every reader fails soft: if the
// materialized view is missing or errors, it returns an empty map and callers
// fall back to all-time `views`, so the homepage never renders empty.
import { getSupabaseServiceClient } from "@/lib/adminAccess";

async function readViewCounts(
  table: string,
  idColumn: string,
  countColumn: string,
): Promise<Map<string, number>> {
  try {
    const supabase = getSupabaseServiceClient();
    const { data, error } = await supabase.from(table).select(`${idColumn}, ${countColumn}`);
    if (error || !data) return new Map();

    const map = new Map<string, number>();
    for (const row of data as unknown as Array<Record<string, unknown>>) {
      const id = row[idColumn];
      if (typeof id === "string") {
        map.set(id, Number(row[countColumn]) || 0);
      }
    }
    return map;
  } catch {
    return new Map();
  }
}

/** recording_id -> views in the last 7 days */
export function getRecordingViews7d(): Promise<Map<string, number>> {
  return readViewCounts("mv_recording_views_7d", "recording_id", "views_7d");
}

/** artist_id -> views in the last 7 days */
export function getArtistViews7d(): Promise<Map<string, number>> {
  return readViewCounts("mv_artist_views_7d", "artist_id", "views_7d");
}

/**
 * ISO timestamp of the last successful rollup refresh, or null if the status
 * table is missing / never refreshed. Lets the admin dashboard confirm the
 * pg_cron refresh job is actually running.
 */
export async function getRollupLastRefreshed(): Promise<string | null> {
  try {
    const supabase = getSupabaseServiceClient();
    const { data, error } = await supabase
      .from("analytics_rollup_status")
      .select("refreshed_at")
      .limit(1)
      .maybeSingle();
    if (error || !data) return null;
    return (data as { refreshed_at: string | null }).refreshed_at ?? null;
  } catch {
    return null;
  }
}
