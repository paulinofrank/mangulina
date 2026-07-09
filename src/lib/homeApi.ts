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
import { getRecordingViews7d, getArtistViews7d } from "@/lib/analyticsRollups";
import { HOME_ARTIST_CARD_LIMIT, HOME_SONG_CARD_LIMIT } from "@/lib/homepageLimits";

type HomepageMostAwardedArtistRow = {
  id: string;
  slug: string;
  name: string;
  province: string | null;
  views: number | string | null;
  has_image: boolean | null;
  award_count: number | string | null;
  nomination_count: number | string | null;
};

type HomepageRegionCountRow = {
  province: string | null;
  count: number | string | null;
};

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

  // 3. Trending Songs — ranked by REAL last-7-day activity (mv_recording_views_7d),
  // not all-time views. Falls back to all-time `views` when the 7-day window is
  // sparse so the section is never empty. The card still displays the all-time
  // view count; only the ordering reflects recent momentum.
  const recordingViews7d = await getRecordingViews7d();

  const top7dRecordingIds = [...recordingViews7d.entries()]
    .sort((a, b) => b[1] - a[1])
    .slice(0, HOME_SONG_CARD_LIMIT * 4)
    .map(([id]) => id);

  const [hot7dRes, allTimeTrendingRes] = await Promise.all([
    top7dRecordingIds.length
      ? supabase
          .from("recordings_with_release_info")
          .select("recording_id, recording_title, views, release_id, artist_id, artist_name")
          .in("recording_id", top7dRecordingIds)
      : Promise.resolve({ data: [] as any[] }),
    supabase
      .from("recordings_with_release_info")
      .select("recording_id, recording_title, views, release_id, artist_id, artist_name")
      .order("views", { ascending: false, nullsFirst: false })
      .limit(HOME_SONG_CARD_LIMIT * 5),
  ]);

  // Merge unique by recording_id, then rank by 7-day views with all-time tiebreak.
  const trendingPool = new Map<string, any>();
  for (const r of [
    ...(((hot7dRes.data as any[]) || [])),
    ...(((allTimeTrendingRes.data as any[]) || [])),
  ]) {
    if (r?.recording_id && !trendingPool.has(r.recording_id)) {
      trendingPool.set(r.recording_id, r);
    }
  }

  const rankedTrending = [...trendingPool.values()].sort((a, b) => {
    const av = recordingViews7d.get(a.recording_id) || 0;
    const bv = recordingViews7d.get(b.recording_id) || 0;
    return bv - av || Number(b.views || 0) - Number(a.views || 0);
  });

  const trendingArtistIds = [
    ...new Set(rankedTrending.map((r) => r.artist_id).filter(Boolean)),
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

  const filteredTrending = rankedTrending
    .filter((r: any) => !r.artist_id || publishedTrendingArtistIds.has(r.artist_id))
    .slice(0, HOME_SONG_CARD_LIMIT);

  // Fetch slugs for the filtered recording IDs
  const trendingRecordingIds = filteredTrending.map((r: any) => r.recording_id).filter(Boolean);
  const slugMap = new Map<string, string | null>();
  const releaseCoverMap = new Map<string, boolean>();
  if (trendingRecordingIds.length > 0) {
    const { data: slugRows } = await supabase
      .from("recordings")
      .select("id, slug")
      .in("id", trendingRecordingIds);
    for (const row of (slugRows || []) as { id: string; slug: string | null }[]) {
      slugMap.set(row.id, row.slug);
    }
  }

  const trendingReleaseIds = [
    ...new Set(filteredTrending.map((r: any) => r.release_id).filter(Boolean)),
  ];
  if (trendingReleaseIds.length > 0) {
    const { data: releaseRows } = await supabase
      .from("releases")
      .select("id, has_cover_image")
      .in("id", trendingReleaseIds);
    for (const row of (releaseRows || []) as { id: string; has_cover_image: boolean | null }[]) {
      releaseCoverMap.set(row.id, row.has_cover_image === true);
    }
  }

  const trendingSongs: TrendingSong[] = filteredTrending.map((r: any) => ({
    id: r.recording_id,
    slug: slugMap.get(r.recording_id) ?? null,
    title: r.recording_title,
    views: Number(r.views || 0),
    release: r.release_id
      ? { id: r.release_id, has_cover_image: releaseCoverMap.get(r.release_id) === true }
      : null,
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
    .select("id, slug, name, province, has_image, views")
    .eq("status", "published")
    .eq("primary_role", "singer")
    .order("views", {
      ascending: false,
      nullsFirst: false,
    })
    .limit(HOME_ARTIST_CARD_LIMIT);

  const topArtists: ArtistSummary[] =
    ((topResponse.data as ArtistSummary[]) || []).map((a) => ({
      id: a.id,
      slug: a.slug,
      name: a.name,
      province: a.province,
      has_image: a.has_image,
      views: a.views,
    }));

  // 5. Regions
  let regions: RegionCount[] = [];
  const regionsResponse = await supabase.rpc("get_homepage_region_counts");

  if (regionsResponse.error) {
    console.error("Unable to load homepage region counts:", regionsResponse.error);

    const fallbackRegionsResponse = await supabase
      .from("artists")
      .select("province")
      .eq("status", "published")
      .not("province", "is", null);

    const regionCounts = new Map<string, number>();
    for (const row of (fallbackRegionsResponse.data || []) as Array<{ province: string | null }>) {
      if (!row.province) continue;
      regionCounts.set(row.province, (regionCounts.get(row.province) || 0) + 1);
    }

    regions = Array.from(regionCounts.entries())
      .map(([province, count]) => ({ province, count }))
      .sort((a, b) => b.count - a.count || a.province.localeCompare(b.province));
  } else {
    regions = ((regionsResponse.data ?? []) as HomepageRegionCountRow[])
      .filter((row) => row.province)
      .map((row) => ({
        province: row.province as string,
        count: Number(row.count || 0),
      }));
  }

  // 6. Prominent Composers (ONLY composers)
  const composersResponse = await supabase
    .from("artists")
    .select("id, slug, name, province, has_image, views")
    .eq("status", "published")
    .eq("primary_role", "composer")
    .order("views", {
      ascending: false,
      nullsFirst: false,
    })
    .limit(HOME_ARTIST_CARD_LIMIT);

  const composers: ArtistSummary[] =
    ((composersResponse.data as ArtistSummary[]) || []).map((a) => ({
      id: a.id,
      slug: a.slug,
      name: a.name,
      province: a.province,
      has_image: a.has_image,
      views: a.views,
    }));

  // 7. Top DJs
  const djsResponse = await supabase
    .from("artists")
    .select("id, slug, name, province, has_image, views")
    .eq("status", "published")
    .eq("primary_role", "dj")
    .order("views", {
      ascending: false,
      nullsFirst: false,
    })
    .limit(HOME_ARTIST_CARD_LIMIT);


  const djs: ArtistSummary[] =
    ((djsResponse.data as ArtistSummary[]) || []).map((a) => ({
      id: a.id,
      slug: a.slug,
      name: a.name,
      province: a.province,
      has_image: a.has_image,
      views: a.views,
    }));

  // 8. Top Christian Artists
  const christianResponse = await supabase
    .from("artists")
    .select("id, slug, name, province, has_image, views")
    .eq("status", "published")
    .contains("artist_tags", ["christian"])
    .order("views", {
      ascending: false,
      nullsFirst: false,
    })
    .limit(HOME_ARTIST_CARD_LIMIT);

  const christianArtists: ArtistSummary[] =
    ((christianResponse.data as ArtistSummary[]) || []).map((a) => ({
      id: a.id,
      slug: a.slug,
      name: a.name,
      province: a.province,
      has_image: a.has_image,
      views: a.views,
    }));

  let mostAwardedArtists: MostAwardedArtistSummary[] = [];

  const mostAwardedResponse = await supabase.rpc("get_homepage_most_awarded_artists", {
    p_limit: HOME_ARTIST_CARD_LIMIT,
  });

  if (mostAwardedResponse.error) {
    console.error("Unable to load homepage most awarded artists:", mostAwardedResponse.error);

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

    if (awardedArtistIds.length > 0) {
      const awardedArtistsResponse = await supabase
        .from("artists")
        .select("id, slug, name, province, has_image, views")
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
            has_image: artist.has_image,
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
        .slice(0, HOME_ARTIST_CARD_LIMIT);
    }
  } else {
    mostAwardedArtists = ((mostAwardedResponse.data ?? []) as HomepageMostAwardedArtistRow[]).map(
      (artist) => ({
        id: artist.id,
        slug: artist.slug,
        name: artist.name,
        province: artist.province,
        views: Number(artist.views || 0),
        has_image: artist.has_image,
        awardCount: Number(artist.award_count || 0),
        nominationCount: Number(artist.nomination_count || 0),
      }),
    );
  }

  // 10. Classical Artists
  const classicalResponse = await supabase
    .from("artists")
    .select("id, slug, name, province, has_image, views")
    .eq("status", "published")
    .eq("primary_role", "instrumentalist")
    .order("views", {
      ascending: false,
      nullsFirst: false,
    })
    .limit(HOME_ARTIST_CARD_LIMIT);

  const classicalArtists: ArtistSummary[] =
    ((classicalResponse.data as ArtistSummary[]) || []).map((a) => ({
      id: a.id,
      slug: a.slug,
      name: a.name,
      province: a.province,
      has_image: a.has_image,
      views: a.views,
    }));

  // 11. Rising Stars — emerging-tagged artists ranked by REAL last-7-day views
  // (weekly trending), with all-time `views` as a tiebreak so the section is
  // never empty while the 7-day window is sparse. Card still shows all-time views.
  const risingResponse = await supabase
    .from("artists")
    .select("id, slug, name, province, has_image, views")
    .eq("status", "published")
    .contains("artist_tags", ["emerging"])
    .order("views", {
      ascending: false,
      nullsFirst: false,
    })
    .limit(HOME_ARTIST_CARD_LIMIT * 4);

  const artistViews7d = await getArtistViews7d();

  const risingStars: ArtistSummary[] =
    ((risingResponse.data as ArtistSummary[]) || [])
      .map((a) => ({ a, v7: artistViews7d.get(a.id) || 0 }))
      .sort((x, y) => y.v7 - x.v7 || Number(y.a.views || 0) - Number(x.a.views || 0))
      .slice(0, HOME_ARTIST_CARD_LIMIT)
      .map(({ a }) => ({
        id: a.id,
        slug: a.slug,
        name: a.name,
        province: a.province,
        has_image: a.has_image,
        views: a.views,
      }));

  // 12. Top Legends Artists
  const legendsResponse = await supabase
    .from("artists")
    .select("id, slug, name, province, has_image, views")
    .eq("status", "published")
    .contains("artist_tags", ["legend"])
    .order("views", { ascending: false, nullsFirst: false })
    .limit(HOME_ARTIST_CARD_LIMIT);

  const legendsArtists: ArtistSummary[] =
    ((legendsResponse.data as ArtistSummary[]) || []).map((artist) => ({
      id: artist.id,
      slug: artist.slug,
      name: artist.name,
      province: artist.province,
      has_image: artist.has_image,
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
