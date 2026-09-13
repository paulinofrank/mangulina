// homeApi.ts  (API)
import { unstable_cache } from "next/cache";
import { getSupabaseClient } from "@/lib/supabase";
import type {
  TrendingSong,
  RegionCount,
  ArtistSummary,
  MostAwardedArtistSummary,
} from "@/types/home";
import type { Artist } from "@/types/music";
import { getRecordingViews7d, getArtistViews7d } from "@/lib/analyticsRollups";
import { HOME_ARTIST_CARD_LIMIT, HOME_SONG_CARD_LIMIT } from "@/lib/homepageLimits";
import {
  HOMEPAGE_CACHE_SECONDS,
  HOMEPAGE_DATA_CACHE_TAG,
} from "@/lib/homepageCache";
import { getPublicRecordingIds } from "@/lib/publicRecordingVisibility";
import { hasPositiveRecentOrAllTimeViews } from "@/lib/analyticsPresentation";
import type { EditorialLocale } from "@/types/editorialDocument";

type HomepageMostAwardedArtistRow = {
  id: string;
  slug: string;
  name: string;
  province: string | null;
  views: number | string | null;
  has_image: boolean | null;
  image_updated_at: string | null;
  award_count: number | string | null;
  nomination_count: number | string | null;
};

type HomepageRegionCountRow = {
  province: string | null;
  count: number | string | null;
};

type HomepageTrendingRow = {
  recording_id: string;
  recording_title: string;
  views: number | string | null;
  release_id: string | null;
  artist_id: string | null;
  artist_name: string | null;
};

function startRequest<T>(request: PromiseLike<T>): Promise<T> {
  return Promise.resolve(request);
}

async function loadHomeData(locale: EditorialLocale) {
  const supabase = getSupabaseClient();

  if (!supabase) {
    throw new Error("Supabase not configured");
  }

  // Start every independent homepage request immediately. Keeping these
  // promises in flight prevents the latency of unrelated sections from being
  // added together while preserving the existing data shaping and fallbacks.
  const featuredPromise = startRequest(supabase
    .from("featured_artist")
    .select(`
      artist:artist_id!inner (
        id,
        slug,
        name,
        stage_name,
        province,
        birth_place,
        facebook,
        instagram,
        genres,
        artist_tags,
        status,
        has_image,
        image_updated_at,
        views
      )
    `)
    .eq("id", 1)
    .eq("artist.status", "published")
    .single());

  const recordingViews7dPromise = getRecordingViews7d();
  const artistViews7dPromise = getArtistViews7d();
  const allTimeTrendingPromise = startRequest(supabase
    .from("recordings_with_release_info")
    .select("recording_id, recording_title, views, release_id, artist_id, artist_name")
    .gt("views", 0)
    .order("views", { ascending: false, nullsFirst: false })
    .limit(HOME_SONG_CARD_LIMIT * 5));

  const artistFields = "id, slug, name, province, has_image, image_updated_at, views";
  const topResponsePromise = startRequest(supabase
    .from("artists")
    .select(artistFields)
    .eq("status", "published")
    .in("primary_role", ["singer", "rapper"])
    .eq("type", "solo_artist")
    .gt("views", 0)
    .order("views", { ascending: false, nullsFirst: false })
    .limit(HOME_ARTIST_CARD_LIMIT));
  const regionsResponsePromise = startRequest(supabase.rpc("get_homepage_region_counts"));
  const composersResponsePromise = startRequest(supabase
    .from("artists")
    .select(artistFields)
    .eq("status", "published")
    .eq("primary_role", "composer")
    .gt("views", 0)
    .order("views", { ascending: false, nullsFirst: false })
    .limit(HOME_ARTIST_CARD_LIMIT));
  const djsResponsePromise = startRequest(supabase
    .from("artists")
    .select(artistFields)
    .eq("status", "published")
    .eq("primary_role", "dj")
    .gt("views", 0)
    .order("views", { ascending: false, nullsFirst: false })
    .limit(HOME_ARTIST_CARD_LIMIT));
  const christianResponsePromise = startRequest(supabase
    .from("artists")
    .select(artistFields)
    .eq("status", "published")
    .contains("artist_tags", ["christian"])
    .in("primary_role", ["singer", "rapper"])
    .eq("type", "solo_artist")
    .gt("views", 0)
    .order("views", { ascending: false, nullsFirst: false })
    .limit(HOME_ARTIST_CARD_LIMIT));
  const mostAwardedResponsePromise = startRequest(supabase.rpc("get_homepage_most_awarded_artists", {
    p_limit: HOME_ARTIST_CARD_LIMIT,
  }));
  const classicalResponsePromise = startRequest(supabase
    .from("artists")
    .select(artistFields)
    .eq("status", "published")
    .or("artist_tags.cs.{instrumental},primary_genre.eq.instrumental-classical,genres.cs.{instrumental-classical}")
    .gt("views", 0)
    .order("views", { ascending: false, nullsFirst: false })
    .limit(HOME_ARTIST_CARD_LIMIT));
  const risingResponsePromise = startRequest(supabase
    .from("artists")
    .select(artistFields)
    .eq("status", "published")
    .contains("artist_tags", ["emerging"])
    .gt("views", 0)
    .order("views", { ascending: false, nullsFirst: false })
    .limit(HOME_ARTIST_CARD_LIMIT * 4));
  const legendsResponsePromise = startRequest(supabase
    .from("artists")
    .select(artistFields)
    .eq("status", "published")
    .in("type", ["group", "duo"])
    .gt("views", 0)
    .order("views", { ascending: false, nullsFirst: false })
    .limit(HOME_ARTIST_CARD_LIMIT));

  // 1. Featured Artist
  const featured = await featuredPromise;

  const featuredRelation = (featured.data as { artist?: Artist | Artist[] | null } | null)?.artist;
  const featuredArtistBase = Array.isArray(featuredRelation)
    ? featuredRelation[0] ?? null
    : featuredRelation ?? null;
  let featuredArtist: Artist | null = null;
  if (featuredArtistBase) {
    const { getPublishedEditorialPlainText } = await import("@/lib/editorial/publicData");
    const localizedBiography = await getPublishedEditorialPlainText(featuredArtistBase.id, locale);
    const biography = localizedBiography
      ?? (locale === "es" ? await getPublishedEditorialPlainText(featuredArtistBase.id, "en") : null);
    featuredArtist = { ...featuredArtistBase, biography };
  }

  // 2. Birthday Artists
  // Loaded in BirthdaySection using the visitor's local browser date.
  const birthdayArtists: Artist[] = [];

  // 3. Trending Songs — ranked by REAL last-7-day activity (mv_recording_views_7d),
  // not all-time views. Falls back to all-time `views` when the 7-day window is
  // sparse. Zero-view fallback rows never qualify. The card still displays the all-time
  // view count; only the ordering reflects recent momentum.
  const recordingViews7d = await recordingViews7dPromise;

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
      : Promise.resolve({ data: [] as HomepageTrendingRow[] }),
    allTimeTrendingPromise,
  ]);

  // Merge unique by recording_id, then rank by 7-day views with all-time tiebreak.
  const trendingPool = new Map<string, HomepageTrendingRow>();
  for (const r of [
    ...(((hot7dRes.data as HomepageTrendingRow[]) || [])),
    ...(((allTimeTrendingRes.data as HomepageTrendingRow[]) || [])),
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

  const publicTrendingRecordingIds = await getPublicRecordingIds(
    rankedTrending
      .filter((row) => hasPositiveRecentOrAllTimeViews(
        recordingViews7d.get(row.recording_id),
        row.views,
      ))
      .map((row) => row.recording_id),
  );
  const filteredTrending = rankedTrending
    .filter((row) =>
      hasPositiveRecentOrAllTimeViews(recordingViews7d.get(row.recording_id), row.views) &&
      publicTrendingRecordingIds.has(row.recording_id),
    )
    .slice(0, HOME_SONG_CARD_LIMIT);

  // Fetch slugs for the filtered recording IDs
  const trendingRecordingIds = filteredTrending.map((r) => r.recording_id).filter(Boolean);
  const slugMap = new Map<string, string | null>();
  const releaseCoverMap = new Map<string, boolean>();
  const slugRowsPromise = trendingRecordingIds.length > 0
    ? supabase
      .from("recordings")
      .select("id, slug")
      .in("id", trendingRecordingIds)
    : Promise.resolve({ data: [] as Array<{ id: string; slug: string | null }> });

  const trendingReleaseIds = [
    ...new Set(filteredTrending.map((r) => r.release_id).filter(Boolean)),
  ];
  const releaseRowsPromise = trendingReleaseIds.length > 0
    ? supabase
      .from("releases")
      .select("id, has_cover_image")
      .in("id", trendingReleaseIds)
    : Promise.resolve({ data: [] as Array<{ id: string; has_cover_image: boolean | null }> });

  const [{ data: slugRows }, { data: releaseRows }] = await Promise.all([
    slugRowsPromise,
    releaseRowsPromise,
  ]);

  if (trendingRecordingIds.length > 0) {
    for (const row of (slugRows || []) as { id: string; slug: string | null }[]) {
      slugMap.set(row.id, row.slug);
    }
  }

  if (trendingReleaseIds.length > 0) {
    for (const row of (releaseRows || []) as { id: string; has_cover_image: boolean | null }[]) {
      releaseCoverMap.set(row.id, row.has_cover_image === true);
    }
  }

  const trendingSongs: TrendingSong[] = filteredTrending.map((r) => ({
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
  const topResponse = await topResponsePromise;

  const topArtists: ArtistSummary[] =
    ((topResponse.data as ArtistSummary[]) || []).map((a) => ({
      id: a.id,
      slug: a.slug,
      name: a.name,
      province: a.province,
      has_image: a.has_image,
      image_updated_at: a.image_updated_at,
      views: a.views,
    }));

  // 5. Regions
  let regions: RegionCount[] = [];
  const regionsResponse = await regionsResponsePromise;

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
  const composersResponse = await composersResponsePromise;

  const composers: ArtistSummary[] =
    ((composersResponse.data as ArtistSummary[]) || []).map((a) => ({
      id: a.id,
      slug: a.slug,
      name: a.name,
      province: a.province,
      has_image: a.has_image,
      image_updated_at: a.image_updated_at,
      views: a.views,
    }));

  // 7. Top DJs
  const djsResponse = await djsResponsePromise;


  const djs: ArtistSummary[] =
    ((djsResponse.data as ArtistSummary[]) || []).map((a) => ({
      id: a.id,
      slug: a.slug,
      name: a.name,
      province: a.province,
      has_image: a.has_image,
      image_updated_at: a.image_updated_at,
      views: a.views,
    }));

  // 8. Top Christian Artists
  const christianResponse = await christianResponsePromise;

  const christianArtists: ArtistSummary[] =
    ((christianResponse.data as ArtistSummary[]) || []).map((a) => ({
      id: a.id,
      slug: a.slug,
      name: a.name,
      province: a.province,
      has_image: a.has_image,
      image_updated_at: a.image_updated_at,
      views: a.views,
    }));

  let mostAwardedArtists: MostAwardedArtistSummary[] = [];

  const mostAwardedResponse = await mostAwardedResponsePromise;

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
        .select("id, slug, name, province, has_image, image_updated_at, views")
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
            image_updated_at: artist.image_updated_at,
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
        image_updated_at: artist.image_updated_at,
        awardCount: Number(artist.award_count || 0),
        nominationCount: Number(artist.nomination_count || 0),
      }),
    );
  }

  // 10. Classical Artists
  const classicalResponse = await classicalResponsePromise;

  const classicalArtists: ArtistSummary[] =
    ((classicalResponse.data as ArtistSummary[]) || []).map((a) => ({
      id: a.id,
      slug: a.slug,
      name: a.name,
      province: a.province,
      has_image: a.has_image,
      image_updated_at: a.image_updated_at,
      views: a.views,
    }));

  // 11. Rising Stars — emerging-tagged artists ranked by REAL last-7-day views
  // (weekly trending), with all-time `views` as a tiebreak so the section is
  // the 7-day window is sparse. Artists without either signal do not qualify.
  const [risingResponse, artistViews7d] = await Promise.all([
    risingResponsePromise,
    artistViews7dPromise,
  ]);

  const risingStars: ArtistSummary[] =
    ((risingResponse.data as ArtistSummary[]) || [])
      .map((a) => ({ a, v7: artistViews7d.get(a.id) || 0 }))
      .filter(({ a, v7 }) => hasPositiveRecentOrAllTimeViews(v7, a.views))
      .sort((x, y) => y.v7 - x.v7 || Number(y.a.views || 0) - Number(x.a.views || 0))
      .slice(0, HOME_ARTIST_CARD_LIMIT)
      .map(({ a }) => ({
        id: a.id,
        slug: a.slug,
        name: a.name,
        province: a.province,
        has_image: a.has_image,
        image_updated_at: a.image_updated_at,
        views: a.views,
      }));

  // 12. Top Legends Artists
  const legendsResponse = await legendsResponsePromise;

  const legendsArtists: ArtistSummary[] =
    ((legendsResponse.data as ArtistSummary[]) || []).map((artist) => ({
      id: artist.id,
      slug: artist.slug,
      name: artist.name,
      province: artist.province,
      has_image: artist.has_image,
      image_updated_at: artist.image_updated_at,
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

const getCachedHomeData = unstable_cache(
  loadHomeData,
  ["homepage-data-v2"],
  {
    revalidate: HOMEPAGE_CACHE_SECONDS,
    tags: [HOMEPAGE_DATA_CACHE_TAG],
  },
);

export function getHomeData(locale: string) {
  return getCachedHomeData(locale === "es" ? "es" : "en");
}
