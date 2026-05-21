// homeApi.ts  (API)
import { getSupabaseClient } from "@/lib/supabase";
import type { TopArtist, TrendingSong, RegionCount } from "@/types/home";
import type { Artist } from "@/types/music";

export async function getHomeData() {
  const supabase = getSupabaseClient();

  if (!supabase) {
    throw new Error("Supabase not configured");
  }

  // 1. Featured Artist
const featured = await supabase
  .from("featured_artist")
  .select(`
    artist:artist_id (
      id,
      name,
      stage_name,
      province,
      birth_place,
      bio,
      image_url,
      is_religious,
      facebook,
      instagram,
      genres,
      views
    )
  `)
  .eq("id", 1)
  .single();

const featuredArtist =
  (featured.data as any)?.artist ?? null;

// 2. Birthday Artists
const now = new Date();

const month = now.getMonth() + 1;
const day = now.getDate();

const birthdayResponse = await supabase
  .from("artists")
  .select("*")
  .eq("birth_month", month)
  .eq("birth_day", day)
  
// 3. Trending Songs
const trendingResponse = await supabase
  .from("trending_recordings_mv")
  .select(`
    recording_id,
    recording_title,
    views,
    release_id,
    artist_name,
    artist_image_url
  `)
  .order("views", { ascending: false })
  .limit(12);

const trendingSongs: TrendingSong[] =
  (trendingResponse.data || []).map((r: any) => ({
    id: r.recording_id,
    title: r.recording_title,
    views: Number(r.views || 0),

    // NEW: release.id only
    release: r.release_id
      ? { id: r.release_id }
      : null,

    recording_credits: [
      {
        artist: r.artist_name
          ? {
              name: r.artist_name,
              image_url: r.artist_image_url ?? null,
            }
          : null,
      },
    ],
  }));


  // 4. Top Artists
  const topResponse = await supabase.rpc("get_top_artists");

  const topArtists: TopArtist[] =
    (topResponse.data || []).map((a: any) => ({
      id: a.id,
      name: a.name,
      image_url: a.image_url ?? null,
      province: a.province ?? null,
      views: Number(a.views || 0),
    }));

  // 5. Regions
  const regionsResponse = await supabase.rpc("get_region_counts");

  const regions: RegionCount[] =
    (regionsResponse.data || []).map((r: any) => ({
      name: r.name,
      count: Number(r.count || 0),
    }));

  return {
    featuredArtist,
    birthdayArtists: (birthdayResponse.data as Artist[]) || [],
    trendingSongs,
    topArtists,
    regions,
  };
}