// homeApi.ts  (API)
import { getSupabaseClient } from "@/lib/supabase";
import type { TopArtist, TrendingSong, RegionCount, ArtistSummary } from "@/types/home";
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
        slug,
        name,
        stage_name,
        province,
        birth_place,
        bio,
        facebook,
        instagram,
        genres,
        artist_tags,
        views
      )
    `)
    .eq("id", 1)
    .single();

  const featuredArtist = (featured.data as any)?.artist ?? null;

  // 2. Birthday Artists
  // Loaded in BirthdaySection using the visitor's local browser date.
  const birthdayArtists: Artist[] = [];

  // 3. Trending Songs
  const trendingResponse = await supabase
    .from("trending_recordings_mv")
    .select(`
      recording_id,
      recording_title,
      views,
      release_id,
      artist_id,
      artist_name
    `)
    .order("views", { ascending: false })
    .limit(12);

  const trendingSongs: TrendingSong[] =
    (trendingResponse.data || []).map((r: any) => ({
      id: r.recording_id,
      title: r.recording_title,
      views: Number(r.views || 0),
      release: r.release_id ? { id: r.release_id } : null,
      recording_credits: [
        {
          artist: r.artist_name
            ? {
              id: r.artist_id,
              name: r.artist_name,
            }
            : null,
        },
      ],
    }));

  // 4. Top Artists (Singers)
  const topResponse = await supabase.rpc("get_top_artists");

  const topArtists: ArtistSummary[] =
    ((topResponse.data as ArtistSummary[]) || []).map((a) => ({
      id: a.id,
      slug: a.slug,
      name: a.name,
      province: a.province,
      views: a.views,
    }));

  // 5. Regions
  const regionsResponse = await supabase.rpc("get_artist_provinces");

  const regions: RegionCount[] =
    (regionsResponse.data || []).map((r: any) => ({
      province: r.province,
      count: Number(r.count || 0),
    }));

  // 6. Prominent Composers (ONLY composers)
  const composersResponse = await supabase.rpc("get_top_composers");

  const composers: ArtistSummary[] =
    ((composersResponse.data as ArtistSummary[]) || []).map((a) => ({
      id: a.id,
      slug: a.slug,
      name: a.name,
      province: a.province,
      views: a.views,
    }));

  // 7. Top DJs
  const djsResponse = await supabase
    .from("artists")
    .select("id, slug, name, province, views")
    .eq("primary_role", "dj")
    .order("views", {
      ascending: false,
      nullsFirst: false,
    })
    .limit(10);


  const djs: ArtistSummary[] =
    ((djsResponse.data as ArtistSummary[]) || []).map((a) => ({
      id: a.id,
      slug: a.slug,
      name: a.name,
      province: a.province,
      views: a.views,
    }));

  // 8. Top Christian Artists
  const christianResponse = await supabase
    .from("artists")
    .select("id, slug, name, province, views")
    .contains("artist_tags", ["christian"])
    .order("views", {
      ascending: false,
      nullsFirst: false,
    })
    .limit(10);

  const christianArtists: ArtistSummary[] =
    ((christianResponse.data as ArtistSummary[]) || []).map((a) => ({
      id: a.id,
      slug: a.slug,
      name: a.name,
      province: a.province,
      views: a.views,
    }));

  // 9. Classical Artists
  const classicalResponse = await supabase
    .from("artists")
    .select("id, slug, name, province, views")
    .eq("primary_role", "instrumentalist")
    .order("views", {
      ascending: false,
      nullsFirst: false,
    })
    .limit(10);

  const classicalArtists: ArtistSummary[] =
    ((classicalResponse.data as ArtistSummary[]) || []).map((a) => ({
      id: a.id,
      slug: a.slug,
      name: a.name,
      province: a.province,
      views: a.views,
    }));

  // 10. Rising Stars (Emerging Artists)
  const risingResponse = await supabase
    .from("artists")
    .select("id, slug, name, province, views")
    .contains("artist_tags", ["emerging"])
    .order("views", {
      ascending: false,
      nullsFirst: false,
    })
    .limit(10);

  const risingStars: ArtistSummary[] =
    ((risingResponse.data as ArtistSummary[]) || []).map((a) => ({
      id: a.id,
      slug: a.slug,
      name: a.name,
      province: a.province,
      views: a.views,
    }));

  return {
    featuredArtist,
    birthdayArtists,
    trendingSongs,
    topArtists,
    regions,
    composers,
    djs,
    christianArtists,
    classicalArtists,
    risingStars
  };
}
