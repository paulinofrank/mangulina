"use client";

import { useState, useEffect, useCallback } from "react";
import Link from "next/link";
import { TrendChart } from "@/components/analytics/TrendChart";
import { ExportButton } from "@/components/analytics/ExportButton";
import { AnalyticsErrorBoundary } from "@/components/analytics/AnalyticsErrorBoundary";

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

interface AnalyticsData {
  artistViewsData: Array<{ artist_id: string; views_7d: number; views_30d: number }>;
  recordingViewsData: Array<{ recording_id: string; views_7d: number; views_30d: number }>;
  genreViewsData: Array<{ genre_slug: string; views_7d: number; views_30d: number }>;
  searchesData: Array<{ query: string; search_count: number; last_searched_at: string }>;
  clicksData: Array<{ platform: string; clicks_30d: number }>;
  artistTrendsData: any[];
  recordingTrendsData: any[];
  searchTrendsData: any[];
  artists: Array<{ id: string; name: string; slug: string }>;
  recordings: Array<{ id: string; title: string; slug: string | null }>;
  timestamp: string;
}

export default function AdminAnalyticsClientWrapper({
  onRefreshStateChange,
}: {
  onRefreshStateChange?: (isRefreshing: boolean, lastUpdated: string | null) => void;
}) {
  const [data, setData] = useState<AnalyticsData | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [lastUpdated, setLastUpdated] = useState<string | null>(null);

  const fetchData = useCallback(async () => {
    setIsLoading(true);
    try {
      const response = await fetch("/api/admin/analytics/data");
      if (!response.ok) throw new Error("Failed to fetch analytics");
      const newData = await response.json();
      setData(newData);
      setLastUpdated(new Date().toLocaleTimeString());
      setError(null);
      onRefreshStateChange?.(false, new Date().toLocaleTimeString());
    } catch (err) {
      setError(err instanceof Error ? err.message : "Unknown error");
      onRefreshStateChange?.(false, lastUpdated);
    } finally {
      setIsLoading(false);
    }
  }, [lastUpdated, onRefreshStateChange]);

  // Initial load
  useEffect(() => {
    fetchData();
  }, []);

  if (error) {
    return (
      <div className="rounded-xl border border-[#CE1126]/20 bg-white px-6 py-8 text-center">
        <p className="text-sm text-[#8B0000]">
          Failed to load analytics data: {error}
        </p>
      </div>
    );
  }

  if (isLoading || !data) {
    return (
      <div className="space-y-6">
        {[...Array(6)].map((_, i) => (
          <div
            key={i}
            className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6"
          >
            <div className="mb-5 h-4 w-32 animate-pulse rounded bg-gray-200" />
            <div className="space-y-3">
              {[...Array(3)].map((_, j) => (
                <div key={j} className="h-3 animate-pulse rounded bg-gray-100" />
              ))}
            </div>
          </div>
        ))}
      </div>
    );
  }

  const artistMap = new Map(data.artists.map((a) => [a.id, a]));
  const recordingMap = new Map(data.recordings.map((r) => [r.id, r]));

  const exportData = [
    {
      title: "Artist Views",
      data: data.artistViewsData.map((row) => {
        const artist = artistMap.get(row.artist_id);
        return {
          Artist: artist?.name || "Unknown",
          Views: (row.views_7d || 0).toString(),
        };
      }),
    },
    {
      title: "Recording Views",
      data: data.recordingViewsData.map((row) => {
        const recording = recordingMap.get(row.recording_id);
        return {
          Recording: recording?.title || "Unknown",
          Views: (row.views_7d || 0).toString(),
        };
      }),
    },
    {
      title: "Genre Views",
      data: data.genreViewsData.map((row) => ({
        Genre: row.genre_slug,
        Views: (row.views_7d || 0).toString(),
      })),
    },
    {
      title: "Platform Clicks",
      data: data.clicksData.map((row) => ({
        Platform: formatPlatform(row.platform),
        Clicks: row.clicks_30d.toString(),
      })),
    },
    {
      title: "Searches With No Results",
      data: data.searchesData.map((row) => ({
        Query: row.query,
        Count: row.search_count.toString(),
        "Last Searched": new Date(row.last_searched_at).toLocaleDateString(),
      })),
    },
  ];

  return (
    <AnalyticsErrorBoundary>
      {/* Status Bar with Controls */}
      <div className="mb-6 space-y-4 rounded-xl border border-black/5 bg-white p-4 shadow-sm sm:p-5">
        <div className="flex flex-col items-start justify-between gap-2 sm:flex-row sm:items-center">
          <div className="text-xs text-gray-600">
            {lastUpdated ? (
              <span>
                Last updated: <span className="font-medium text-[#002D62]">{lastUpdated}</span>
              </span>
            ) : (
              <span>Loading data...</span>
            )}
          </div>
          <button
            onClick={() => {
              onRefreshStateChange?.(true, lastUpdated);
              fetchData();
            }}
            disabled={isLoading}
            className="inline-flex items-center gap-2 rounded-lg border border-gray-200 bg-white px-3 py-1.5 text-xs font-medium uppercase tracking-[0.16em] text-gray-600 shadow-sm transition hover:border-[#CE1126] hover:text-[#CE1126] disabled:opacity-50 disabled:cursor-not-allowed"
          >
            <svg
              className={`h-3.5 w-3.5 ${isLoading ? "animate-spin" : ""}`}
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"
              />
            </svg>
            {isLoading ? "Refreshing..." : "Refresh Now"}
          </button>
        </div>

      </div>

      {/* Analytics Data */}
      <div className="space-y-6">
        {/* Trend Charts */}
        <div className="grid gap-6 lg:grid-cols-1">
          <ReportCard
            title="Artist Views Trend"
            description="Daily views across the past 7 days"
          >
            <TrendChart
              title="Views per day"
              data={data.artistTrendsData}
              color="crimson"
            />
          </ReportCard>

          <ReportCard
            title="Recording Views Trend"
            description="Daily views across the past 7 days"
          >
            <TrendChart
              title="Views per day"
              data={data.recordingTrendsData}
              color="blue"
            />
          </ReportCard>

          <ReportCard
            title="Search Trends"
            description="Search activity across the past 7 days"
          >
            <TrendChart
              title="Searches per day"
              data={data.searchTrendsData}
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
            {data.artistViewsData.length === 0 ? (
              <EmptyRow />
            ) : (
              <div className="divide-y divide-gray-100">
                {data.artistViewsData.map((row) => {
                  const artist = artistMap.get(row.artist_id);
                  const views = row.views_7d || row.views_30d || 0;
                  return (
                    <div
                      key={row.artist_id}
                      className="flex items-center justify-between gap-4 py-1.5"
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
            {data.recordingViewsData.length === 0 ? (
              <EmptyRow />
            ) : (
              <div className="divide-y divide-gray-100">
                {data.recordingViewsData.map((row) => {
                  const recording = recordingMap.get(row.recording_id);
                  const views = row.views_7d || row.views_30d || 0;
                  return (
                    <div
                      key={row.recording_id}
                      className="flex items-center justify-between gap-4 py-1.5"
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
            {data.genreViewsData.length === 0 ? (
              <EmptyRow />
            ) : (
              <div className="divide-y divide-gray-100">
                {data.genreViewsData.map((row) => {
                  const views = row.views_7d || row.views_30d || 0;
                  return (
                    <div
                      key={row.genre_slug}
                      className="flex items-center justify-between gap-4 py-1.5"
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
            {data.clicksData.length === 0 ? (
              <EmptyRow />
            ) : (
              <div className="divide-y divide-gray-100">
                {data.clicksData.map((row) => (
                  <div key={row.platform} className="flex items-center justify-between gap-4 py-1.5">
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
            {data.searchesData.length === 0 ? (
              <EmptyRow />
            ) : (
              <div className="divide-y divide-gray-100">
                {data.searchesData.map((row) => (
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
                ))}
              </div>
            )}
          </ReportCard>
        </div>

        {/* Export Section */}
        <div className="flex justify-end">
          <ExportButton exports={exportData} />
        </div>
      </div>
    </AnalyticsErrorBoundary>
  );
}
