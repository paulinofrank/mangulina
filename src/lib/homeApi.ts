// homeApi.ts  (API)
import { getSupabaseClient } from "@/lib/supabase";
import type {
  TopArtist,
  TrendingSong,
  RegionCount,
  ArtistSummary,
  MostAwardedArtistSummary,
} from "@/types/home";
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
      artist:artist_id!inner (
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
        status,
        views
      )
    `)
    .eq("id", 1)
    .eq("artist.status", "published")
    .single();

  const featuredArtist = (featured.data as any)?.artist ?? null;

  // 2. Birthday Artists
  // Loaded in BirthdaySection using the visitor's local browser date.
  const birthdayArtists: Artist[] = [];

  // 3. Trending Songs — top by real view count from recordings_with_release_info
  // Fetch extra rows to account for filtering out unpublished artists
  const trendingResponse = await supabase
    .from("recordings_with_release_info")
    .select("recording_id, recording_title, views, release_id, artist_id, artist_name")
    .order("views", { ascending: false, nullsFirst: false })
    .limit(20);

  const trendingArtistIds = [
    ...new Set(
      ((trendingResponse.data || []) as any[])
        .map((r) => r.artist_id)
        .filter(Boolean)
    ),
  ];
  const publishedTrendingArtistIds = new Set<string>();

  if (trendingArtistIds.length > 0) {
    const { data: publishedTrendingArtists } = await supabase
      .from("artists")
      .select("id")
      .eq("status", "published")
      .in("id", trendingArtistIds);

    for (const artist of publishedTrendingArtists || []) {
      publishedTrendingArtistIds.add(artist.id);
    }
  }

  const filteredTrending = (trendingResponse.data || [])
    .filter((r: any) => !r.artist_id || publishedTrendingArtistIds.has(r.artist_id))
    .slice(0, 12);

  // Fetch slugs for the filtered recording IDs
  const trendingRecordingIds = filteredTrending.map((r: any) => r.recording_id).filter(Boolean);
  const slugMap = new Map<string, string | null>();
  if (trendingRecordingIds.length > 0) {
    const { data: slugRows } = await supabase
      .from("recordings")
      .select("id, slug")
      .in("id", trendingRecordingIds);
    for (const row of (slugRows || []) as { id: string; slug: string | null }[]) {
      slugMap.set(row.id, row.slug);
    }
  }

  const trendingSongs: TrendingSong[] = filteredTrending.map((r: any) => ({
    id: r.recording_id,
    slug: slugMap.get(r.recording_id) ?? null,
    title: r.recording_title,
    views: Number(r.views || 0),
    release: r.release_id ? { id: r.release_id } : null,
    recording_credits: [
      {
        artist: r.artist_name
          ? { id: r.artist_id, name: r.artist_name }
          : null,
      },
    ],
  }));

  // 4. Top Artists (Singers)
  const topResponse = await supabase
    .from("artists")
    .select("id, slug, name, province, views")
    .eq("status", "published")
    .eq("primary_role", "singer")
    .order("views", {
      ascending: false,
      nullsFirst: false,
    })
    .limit(10);

  const topArtists: ArtistSummary[] =
    ((topResponse.data as ArtistSummary[]) || []).map((a) => ({
      id: a.id,
      slug: a.slug,
      name: a.name,
      province: a.province,
      views: a.views,
    }));

  // 5. Regions
  const regionsResponse = await supabase
    .from("artists")
    .select("province")
    .eq("status", "published")
    .not("province", "is", null);

  const regionCounts = new Map<string, number>();
  for (const row of (regionsResponse.data || []) as Array<{ province: string | null }>) {
    if (!row.province) continue;
    regionCounts.set(row.province, (regionCounts.get(row.province) || 0) + 1);
  }

  const regions: RegionCount[] = Array.from(regionCounts.entries())
    .map(([province, count]) => ({ province, count }))
    .sort((a, b) => b.count - a.count || a.province.localeCompare(b.province));

  // 6. Prominent Composers (ONLY composers)
  const composersResponse = await supabase
    .from("artists")
    .select("id, slug, name, province, views")
    .eq("status", "published")
    .eq("primary_role", "composer")
    .order("views", {
      ascending: false,
      nullsFirst: false,
    })
    .limit(10);

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
    .eq("status", "published")
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
    .eq("status", "published")
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

  // 9. Most Awarded Artists
  const awardRowsResponse = await supabase
    .from("artist_awards")
    .select("artist_id, won");

  const awardCounts = new Map<string, { awardCount: number; nominationCount: number }>();

  for (const row of (awardRowsResponse.data ?? []) as Array<{
    artist_id: string | null;
    won: boolean | null;
  }>) {
    if (!row.artist_id) continue;

    const current = awardCounts.get(row.artist_id) ?? {
      awardCount: 0,
      nominationCount: 0,
    };

    if (row.won) {
      current.awardCount += 1;
    } else {
      current.nominationCount += 1;
    }

    awardCounts.set(row.artist_id, current);
  }

  const awardedArtistIds = [...awardCounts.keys()];
  let mostAwardedArtists: MostAwardedArtistSummary[] = [];

  if (awardedArtistIds.length > 0) {
    // Large-ID audit: the complete awarded-artist set is unbounded and can exceed
    // 100 IDs; migrate the ranking to an RPC as the awards catalog grows.
    const awardedArtistsResponse = await supabase
      .from("artists")
      .select("id, slug, name, province, views")
      .eq("status", "published")
      .in("id", awardedArtistIds);

    mostAwardedArtists = ((awardedArtistsResponse.data as ArtistSummary[]) || [])
      .map((artist) => {
        const counts = awardCounts.get(artist.id) ?? {
          awardCount: 0,
          nominationCount: 0,
        };

        return {
          id: artist.id,
          slug: artist.slug,
          name: artist.name,
          province: artist.province,
          views: artist.views,
          awardCount: counts.awardCount,
          nominationCount: counts.nominationCount,
        };
      })
      .sort(
        (a, b) =>
          b.awardCount - a.awardCount ||
          b.awardCount + b.nominationCount - (a.awardCount + a.nominationCount) ||
          Number(b.views || 0) - Number(a.views || 0) ||
          a.name.localeCompare(b.name),
      )
      .slice(0, 10);
  }

  // 10. Classical Artists
  const classicalResponse = await supabase
    .from("artists")
    .select("id, slug, name, province, views")
    .eq("status", "published")
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

  // 11. Rising Stars (Emerging Artists)
  const risingResponse = await supabase
    .from("artists")
    .select("id, slug, name, province, views")
    .eq("status", "published")
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

  // 12. Top Legends Artists
  const legendsResponse = await supabase
    .from("artists")
    .select("id, slug, name, province, views")
    .eq("status", "published")
    .contains("artist_tags", ["legend"])
    .order("views", { ascending: false, nullsFirst: false })
    .limit(10);

  const legendsArtists: ArtistSummary[] =
    ((legendsResponse.data as ArtistSummary[]) || []).map((artist) => ({
      id: artist.id,
      slug: artist.slug,
      name: artist.name,
      province: artist.province,
      views: artist.views,
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
    mostAwardedArtists,
    classicalArtists,
    risingStars,
    legendsArtists,
  };
}
