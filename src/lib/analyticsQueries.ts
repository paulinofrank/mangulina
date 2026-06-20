import { getSupabaseServiceClient } from "@/lib/adminAccess";

/**
 * Fetches top artists with both 7-day and 30-day view metrics
 *
 * Use this to identify trending artists and engagement patterns.
 * Artists with high view counts may warrant:
 * - Featured placement on homepage
 * - Curated collection recommendations
 * - Genre category spotlighting
 *
 * @param limit - Maximum number of results (default: 20)
 * @returns Array of artist view counts with 7d and 30d metrics, sorted by 7d popularity
 */
export async function fetchTopArtistViews(limit: number = 20) {
  const supabase = getSupabaseServiceClient();

  const { data, error } = await supabase
    .from("artist_views_comparison")
    .select("artist_id,views_7d,views_30d")
    .order("views_7d", { ascending: false })
    .limit(limit);

  if (error) throw error;
  return data || [];
}

/**
 * Fetches top recordings with both 7-day and 30-day view metrics
 */
export async function fetchTopRecordingViews(limit: number = 20) {
  const supabase = getSupabaseServiceClient();

  const { data, error } = await supabase
    .from("recording_views_comparison")
    .select("recording_id,views_7d,views_30d")
    .order("views_7d", { ascending: false })
    .limit(limit);

  if (error) throw error;
  return data || [];
}

/**
 * Fetches top genres with both 7-day and 30-day view metrics
 */
export async function fetchTopGenreViews(limit: number = 15) {
  const supabase = getSupabaseServiceClient();

  const { data, error } = await supabase
    .from("genre_views_comparison")
    .select("genre_slug,views_7d,views_30d")
    .order("views_7d", { ascending: false })
    .limit(limit);

  if (error) throw error;
  return data || [];
}

/**
 * Fetches searches that returned zero results
 *
 * These represent catalog gaps and user demand signals. High-frequency
 * zero-result searches should be prioritized for content curation:
 * - Artist names users search for but don't exist in database
 * - Song titles that should be available
 * - Genre combinations with low coverage
 *
 * Can be used to drive editorial decisions and content acquisition priorities.
 *
 * @param limit - Maximum number of results to return (default: 30)
 * @returns Array of search queries with zero matches, sorted by frequency
 */
export async function fetchSearchesWithNoResults(limit: number = 30) {
  const supabase = getSupabaseServiceClient();

  const { data, error } = await supabase
    .from("searches_with_no_results")
    .select("query,search_count,last_searched_at")
    .order("search_count", { ascending: false })
    .order("last_searched_at", { ascending: false })
    .limit(limit);

  if (error) throw error;
  return data || [];
}

/**
 * Fetches platform clicks from the last 30 days
 */
export async function fetchPlatformClicks() {
  const supabase = getSupabaseServiceClient();

  const { data, error } = await supabase
    .from("platform_clicks_last_30_days")
    .select("platform,clicks_30d")
    .order("clicks_30d", { ascending: false });

  if (error) throw error;
  return data || [];
}

/**
 * Fetches daily artist view trends for the past N days
 */
export async function fetchArtistViewTrends(daysBack: number = 30) {
  const supabase = getSupabaseServiceClient();

  const { data, error } = await supabase
    .from("artist_views_by_day_last_30_days")
    .select("view_date,daily_views")
    .order("view_date", { ascending: true })
    .limit(daysBack);

  if (error) throw error;
  return (data || []).map((row: { view_date: string; daily_views: number }) => ({
    date: row.view_date,
    views: row.daily_views,
  }));
}

/**
 * Fetches daily recording view trends for the past N days
 */
export async function fetchRecordingViewTrends(daysBack: number = 30) {
  const supabase = getSupabaseServiceClient();

  const { data, error } = await supabase
    .from("recording_views_by_day_last_30_days")
    .select("view_date,daily_views")
    .order("view_date", { ascending: true })
    .limit(daysBack);

  if (error) throw error;
  return (data || []).map((row: { view_date: string; daily_views: number }) => ({
    date: row.view_date,
    views: row.daily_views,
  }));
}

/**
 * Fetches daily search trends for the past N days
 */
export async function fetchSearchTrends(daysBack: number = 30) {
  const supabase = getSupabaseServiceClient();

  const { data, error } = await supabase
    .from("search_events_by_day_last_30_days")
    .select("search_date,total_searches,zero_result_searches")
    .order("search_date", { ascending: true })
    .limit(daysBack);

  if (error) throw error;
  return (data || []).map((row: { search_date: string; total_searches: number; zero_result_searches: number }) => ({
    date: row.search_date,
    views: row.total_searches,
    zeroResults: row.zero_result_searches,
  }));
}

/**
 * Fetches artist details by their IDs
 */
export async function fetchArtistsByIds(artistIds: string[]) {
  if (artistIds.length === 0) return [];

  const supabase = getSupabaseServiceClient();
  const { data, error } = await supabase
    .from("artists")
    .select("id,name,slug")
    .in("id", artistIds);

  if (error) throw error;
  return data || [];
}

/**
 * Fetches recording details by their IDs
 */
export async function fetchRecordingsByIds(recordingIds: string[]) {
  if (recordingIds.length === 0) return [];

  const supabase = getSupabaseServiceClient();
  const { data, error } = await supabase
    .from("recordings")
    .select("id,title,slug")
    .in("id", recordingIds);

  if (error) throw error;
  return data || [];
}
