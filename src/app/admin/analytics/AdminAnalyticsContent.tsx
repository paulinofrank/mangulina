// Force dynamic rendering to always fetch fresh analytics data
export const dynamic = "force-dynamic";

import Link from "next/link";
import { TrendChart } from "@/components/analytics/TrendChart";
import { ExportButton } from "@/components/analytics/ExportButton";
import {
  fetchTopArtistViews,
  fetchTopRecordingViews,
  fetchTopGenreViews,
  fetchSearchesWithNoResults,
  fetchPlatformClicks,
  fetchArtistViewTrends,
  fetchRecordingViewTrends,
  fetchSearchTrends,
  fetchArtistsByIds,
  fetchRecordingsByIds,
} from "@/lib/analyticsQueries";

function formatPlatform(platform: string) {
  return platform
    .replace(/_/g, " ")
    .replace(/\b\w/g, (character) => character.toUpperCase());
}

function ReportCard({
  title,
  description,
  children,
}: {
  title: string;
  description?: string;
  children: React.ReactNode;
}) {
  return (
    <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <div className="mb-5">
        <h2 className="text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">{title}</h2>
        {description && <p className="mt-2 text-xs text-gray-500">{description}</p>}
      </div>
      {children}
    </section>
  );
}

function EmptyRow() {
  return <p className="py-5 text-center text-sm text-gray-500">No activity recorded yet.</p>;
}

/**
 * Server component that fetches and displays analytics data
 *
 * Displays 6 report cards with analytics metrics:
 * - Top artists, recordings, genres
 * - Platform engagement
 * - Zero-result searches (catalog gaps)
 * - Trend charts for visual insights
 */
export default async function AdminAnalyticsContent() {
  const daysBack = 7;

  try {
    // Fetch all analytics data in parallel
    const [
      artistViewsData,
      recordingViewsData,
      genreViewsData,
      searchesData,
      clicksData,
      artistTrendsData,
      recordingTrendsData,
      searchTrendsData,
    ] = await Promise.all([
      fetchTopArtistViews(20),
      fetchTopRecordingViews(20),
      fetchTopGenreViews(15),
      fetchSearchesWithNoResults(30),
      fetchPlatformClicks(),
      fetchArtistViewTrends(7),
      fetchRecordingViewTrends(7),
      fetchSearchTrends(7),
    ]);

    // Fetch related entity data
    const [artists, recordings] = await Promise.all([
      fetchArtistsByIds(artistViewsData.map((row: { artist_id: string }) => row.artist_id)),
      fetchRecordingsByIds(recordingViewsData.map((row: { recording_id: string }) => row.recording_id)),
    ]);

    const artistMap = new Map(artists.map((a: { id: string }) => [a.id, a]));
    const recordingMap = new Map(recordings.map((r: { id: string }) => [r.id, r]));

    // Prepare data for export
    const exportData = [
      {
        title: "Artist Views",
        data: artistViewsData.map((row: { artist_id: string; views_7d: number; views_30d: number }) => {
          const artist = artistMap.get(row.artist_id) as { id: string; name: string; slug: string } | undefined;
          return {
            Artist: artist?.name || "Unknown",
            Views: (row.views_7d || 0).toString(),
          };
        }),
      },
      {
        title: "Recording Views",
        data: recordingViewsData.map((row: { recording_id: string; views_7d: number; views_30d: number }) => {
          const recording = recordingMap.get(row.recording_id) as { id: string; title: string; slug: string | null } | undefined;
          return {
            Recording: recording?.title || "Unknown",
            Views: (row.views_7d || 0).toString(),
          };
        }),
      },
      {
        title: "Genre Views",
        data: genreViewsData.map((row: { genre_slug: string; views_7d: number; views_30d: number }) => ({
          Genre: row.genre_slug,
          Views: (row.views_7d || 0).toString(),
        })),
      },
      {
        title: "Platform Clicks",
        data: clicksData.map((row: { platform: string; clicks_30d: number }) => ({
          Platform: formatPlatform(row.platform),
          Clicks: row.clicks_30d.toString(),
        })),
      },
      {
        title: "Searches With No Results",
        data: searchesData.map(
          (row: { query: string; search_count: number; last_searched_at: string }) => ({
            Query: row.query,
            Count: row.search_count.toString(),
            "Last Searched": new Date(row.last_searched_at).toLocaleDateString(),
          }),
        ),
      },
    ];

    return (
      <div className="space-y-6">
        {/* Trend Charts */}
        <div className="grid gap-6 lg:grid-cols-3">
          <ReportCard
            title="Artist Views Trend"
            description="Daily views across the past 7 days"
          >
            <TrendChart
              title="Views per day"
              data={artistTrendsData}
              color="crimson"
            />
          </ReportCard>

          <ReportCard
            title="Recording Views Trend"
            description="Daily views across the past 7 days"
          >
            <TrendChart
              title="Views per day"
              data={recordingTrendsData}
              color="blue"
            />
          </ReportCard>

          <ReportCard
            title="Search Trends"
            description="Search activity across the past 7 days"
          >
            <TrendChart
              title="Searches per day"
              data={searchTrendsData}
              color="crimson"
            />
          </ReportCard>
        </div>

        {/* Main Reports */}
        <div className="grid gap-6 lg:grid-cols-2">
          <ReportCard
            title="Top Artist Views - Last 7 Days"
            description="Artists with the highest profile views. Use this to identify emerging interest, feature trending artists, and plan curated collections."
          >
            {artistViewsData.length === 0 ? (
              <EmptyRow />
            ) : (
              <div className="divide-y divide-gray-100">
                {artistViewsData.map((row: { artist_id: string; views_7d: number; views_30d: number }) => {
                  const artist = artistMap.get(row.artist_id) as { id: string; name: string; slug: string } | undefined;
                  const views = row.views_7d || row.views_30d || 0;
                  return (
                    <div
                      key={row.artist_id}
                      className="flex items-center justify-between gap-4 py-3"
                    >
                      {artist ? (
                        <Link
                          href={`/artists/${artist.slug}`}
                          className="min-w-0 truncate text-sm font-medium text-[#002D62] hover:text-[#CE1126]"
                        >
                          {artist.name}
                        </Link>
                      ) : (
                        <span className="truncate text-sm text-gray-500">Unknown artist</span>
                      )}
                      <span className="shrink-0 text-sm tabular-nums text-gray-600">
                        {views.toLocaleString()}
                      </span>
                    </div>
                  );
                })}
              </div>
            )}
          </ReportCard>

          <ReportCard
            title="Top Recording Views - Last 7 Days"
            description="Songs with the most profile views. Indicates user interest in specific recordings and popular musical moments. Use to recommend songs and understand listening patterns."
          >
            {recordingViewsData.length === 0 ? (
              <EmptyRow />
            ) : (
              <div className="divide-y divide-gray-100">
                {recordingViewsData.map((row: { recording_id: string; views_7d: number; views_30d: number }) => {
                  const recording = recordingMap.get(row.recording_id) as { id: string; title: string; slug: string | null } | undefined;
                  const views = row.views_7d || row.views_30d || 0;
                  return (
                    <div
                      key={row.recording_id}
                      className="flex items-center justify-between gap-4 py-3"
                    >
                      {recording ? (
                        <Link
                          href={`/songs/${recording.slug ?? recording.id}`}
                          className="min-w-0 truncate text-sm font-medium text-[#002D62] hover:text-[#CE1126]"
                        >
                          {recording.title}
                        </Link>
                      ) : (
                        <span className="truncate text-sm text-gray-500">Unknown recording</span>
                      )}
                      <span className="shrink-0 text-sm tabular-nums text-gray-600">
                        {views.toLocaleString()}
                      </span>
                    </div>
                  );
                })}
              </div>
            )}
          </ReportCard>

          <ReportCard
            title="Top Genre Views - Last 7 Days"
            description="Genre pages with the highest views. Shows which music styles resonate most with your audience. Use to prioritize genre curation and editorial features."
          >
            {genreViewsData.length === 0 ? (
              <EmptyRow />
            ) : (
              <div className="divide-y divide-gray-100">
                {genreViewsData.map((row: { genre_slug: string; views_7d: number; views_30d: number }) => {
                  const views = row.views_7d || row.views_30d || 0;
                  return (
                    <div
                      key={row.genre_slug}
                      className="flex items-center justify-between gap-4 py-3"
                    >
                      <Link
                        href={`/genres/${row.genre_slug}`}
                        className="min-w-0 truncate text-sm font-medium text-[#002D62] hover:text-[#CE1126]"
                      >
                        {row.genre_slug}
                      </Link>
                      <span className="shrink-0 text-sm tabular-nums text-gray-600">
                        {views.toLocaleString()}
                      </span>
                    </div>
                  );
                })}
              </div>
            )}
          </ReportCard>

          <ReportCard
            title="Platform Clicks - Last 30 Days"
            description="Aggregate clicks to streaming services (Spotify, Apple Music, YouTube, etc.). High clicks indicate strong user intent to listen. Monitor platform distribution to understand user preferences."
          >
            {clicksData.length === 0 ? (
              <EmptyRow />
            ) : (
              <div className="divide-y divide-gray-100">
                {clicksData.map((row: { platform: string; clicks_30d: number }) => (
                  <div key={row.platform} className="flex items-center justify-between gap-4 py-3">
                    <span className="text-sm font-medium text-[#002D62]">
                      {formatPlatform(row.platform)}
                    </span>
                    <span className="text-sm tabular-nums text-gray-600">
                      {row.clicks_30d.toLocaleString()}
                    </span>
                  </div>
                ))}
              </div>
            )}
          </ReportCard>

          <ReportCard
            title="Searches With No Results"
            description="Queries that returned no matches. Critical indicator of catalog gaps. Shows what users are looking for that you don't have. Priority for content curation and database expansion."
          >
            {searchesData.length === 0 ? (
              <EmptyRow />
            ) : (
              <div className="divide-y divide-gray-100">
                {searchesData.map(
                  (row: { query: string; search_count: number; last_searched_at: string }) => (
                    <div key={row.query} className="flex items-center justify-between gap-4 py-3">
                      <div className="min-w-0">
                        <p className="truncate text-sm font-medium text-[#002D62]">{row.query}</p>
                        <p className="mt-1 text-xs text-gray-400">
                          Last searched {new Date(row.last_searched_at).toLocaleDateString()}
                        </p>
                      </div>
                      <span className="shrink-0 text-sm tabular-nums text-gray-600">
                        {row.search_count.toLocaleString()}
                      </span>
                    </div>
                  ),
                )}
              </div>
            )}
          </ReportCard>
        </div>

        {/* Export Section */}
        <div className="flex justify-end">
          <ExportButton exports={exportData} />
        </div>
      </div>
    );
  } catch (error) {
    console.error("Analytics content error:", error);
    return (
      <div className="rounded-xl border border-[#CE1126]/20 bg-white px-6 py-8 text-center">
        <p className="text-sm text-[#8B0000]">
          Failed to load analytics data. Please try refreshing the page.
        </p>
      </div>
    );
  }
}
