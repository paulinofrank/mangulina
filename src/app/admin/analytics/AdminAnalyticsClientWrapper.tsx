"use client";

import { useState, useEffect, useCallback } from "react";
import Link from "next/link";
import { useTranslations } from "next-intl";
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

function EmptyRow({ message }: { message: string }) {
  return <p className="py-5 text-center text-sm text-gray-500">{message}</p>;
}

function SectionHeading({ title, description }: { title: string; description?: string }) {
  return (
    <div className="mb-4">
      <h3 className="text-sm font-bold uppercase tracking-[0.18em] text-[#002D62]">{title}</h3>
      {description && <p className="mt-1 text-xs text-gray-500">{description}</p>}
    </div>
  );
}

function ComingSoonCard({ title }: { title: string }) {
  return (
    <ReportCard title={title}>
      <div className="flex items-center justify-center py-8">
        <span className="rounded-full border border-dashed border-gray-300 px-4 py-1.5 text-xs font-medium uppercase tracking-[0.16em] text-gray-400">
          Coming Soon
        </span>
      </div>
    </ReportCard>
  );
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
  const t = useTranslations("admin.analytics");
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
      setError(err instanceof Error ? err.message : t("unknownError"));
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
          {t("failedToLoad", { error })}
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
      title: t("sheets.artistViews"),
      data: data.artistViewsData.map((row) => {
        const artist = artistMap.get(row.artist_id);
        return {
          Artist: artist?.name || t("labels.unknownArtist"),
          Views: (row.views_7d || 0).toString(),
        };
      }),
    },
    {
      title: t("sheets.recordingViews"),
      data: data.recordingViewsData.map((row) => {
        const recording = recordingMap.get(row.recording_id);
        return {
          Recording: recording?.title || t("labels.unknownRecording"),
          Views: (row.views_7d || 0).toString(),
        };
      }),
    },
    {
      title: t("sheets.genreViews"),
      data: data.genreViewsData.map((row) => ({
        Genre: row.genre_slug,
        Views: (row.views_7d || 0).toString(),
      })),
    },
    {
      title: t("sheets.platformClicks"),
      data: data.clicksData.map((row) => ({
        Platform: formatPlatform(row.platform),
        Clicks: row.clicks_30d.toString(),
      })),
    },
    {
      title: t("sheets.searchesNoResults"),
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
                {t("lastUpdated")}<span className="font-medium text-[#002D62]">{lastUpdated}</span>
              </span>
            ) : (
              <span>{t("loadingData")}</span>
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
            {isLoading ? t("refreshing") : t("refreshNow")}
          </button>
        </div>

      </div>

      {/* Product Analytics — Mangulina-specific data, grouped into sections. */}
      <div className="space-y-10">
        {/* ===================== VIEWS ===================== */}
        <div>
          <SectionHeading title="Views" description="Profile views by entity and over time." />
          <div className="grid gap-6 lg:grid-cols-2">
            <ReportCard
              title={t("reports.artistViewsTrend.title")}
              description={t("reports.artistViewsTrend.description")}
            >
              <TrendChart
                title={t("charts.viewsPerDay")}
                data={data.artistTrendsData}
                color="crimson"
              />
            </ReportCard>

            <ReportCard
              title={t("reports.recordingViewsTrend.title")}
              description={t("reports.recordingViewsTrend.description")}
            >
              <TrendChart
                title={t("charts.viewsPerDay")}
                data={data.recordingTrendsData}
                color="blue"
              />
            </ReportCard>
          </div>

          <div className="mt-6 grid gap-6 lg:grid-cols-2">
            <ReportCard
              title={t("reports.topArtistViews.title")}
              description={t("reports.topArtistViews.description")}
            >
              {data.artistViewsData.length === 0 ? (
                <EmptyRow message={t("noActivityYet")} />
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
                          <span className="truncate text-sm text-gray-500">{t("labels.unknownArtist")}</span>
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
              title={t("reports.topRecordingViews.title")}
              description={t("reports.topRecordingViews.description")}
            >
              {data.recordingViewsData.length === 0 ? (
                <EmptyRow message={t("noActivityYet")} />
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
                          <span className="truncate text-sm text-gray-500">{t("labels.unknownRecording")}</span>
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
              title={t("reports.topGenreViews.title")}
              description={t("reports.topGenreViews.description")}
            >
              {data.genreViewsData.length === 0 ? (
                <EmptyRow message={t("noActivityYet")} />
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

            <ComingSoonCard title="Release Views" />
          </div>
        </div>

        {/* ===================== SEARCH ===================== */}
        <div>
          <SectionHeading title="Search" description="What visitors are looking for." />
          <div className="grid gap-6 lg:grid-cols-1">
            <ReportCard
              title={t("reports.searchTrend.title")}
              description={t("reports.searchTrend.description")}
            >
              <TrendChart
                title={t("charts.searchesPerDay")}
                data={data.searchTrendsData}
                color="crimson"
              />
            </ReportCard>
          </div>

          <div className="mt-6 grid gap-6 lg:grid-cols-2">
            <ReportCard
              title={t("reports.searchesNoResults.title")}
              description={t("reports.searchesNoResults.description")}
            >
              {data.searchesData.length === 0 ? (
                <EmptyRow message={t("noActivityYet")} />
              ) : (
                <div className="divide-y divide-gray-100">
                  {data.searchesData.map((row) => (
                    <div key={row.query} className="flex items-center justify-between gap-4 py-3">
                      <div className="min-w-0">
                        <p className="truncate text-sm font-medium text-[#002D62]">{row.query}</p>
                        <p className="mt-1 text-xs text-gray-400">
                          {t("labels.lastSearched")}{new Date(row.last_searched_at).toLocaleDateString()}
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

            <ComingSoonCard title="Trending Searches" />
          </div>
        </div>

        {/* ===================== PLATFORM CLICKS ===================== */}
        <div>
          <SectionHeading title="Platform Clicks" description="Streaming-link engagement." />
          <div className="grid gap-6 lg:grid-cols-2">
            <ReportCard
              title={t("reports.platformClicks.title")}
              description={t("reports.platformClicks.description")}
            >
              {data.clicksData.length === 0 ? (
                <EmptyRow message={t("noActivityYet")} />
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

            <ComingSoonCard title="Clicks by Artist" />
            <ComingSoonCard title="Clicks by Recording" />
          </div>
        </div>

        {/* ===================== POPULARITY ===================== */}
        <div>
          <SectionHeading
            title="Popularity"
            description="Rankings (currently powered on the public site; admin views coming soon)."
          />
          <div className="grid gap-6 lg:grid-cols-3">
            <ComingSoonCard title="Most Viewed" />
            <ComingSoonCard title="Trending" />
            <ComingSoonCard title="Rising" />
          </div>
        </div>

        {/* ===================== REPORTS ===================== */}
        <div>
          <SectionHeading title="Reports" description="Periodic summaries." />
          <div className="grid gap-6 lg:grid-cols-3">
            <ComingSoonCard title="Daily" />
            <ComingSoonCard title="Weekly" />
            <ComingSoonCard title="Monthly" />
          </div>
        </div>

        {/* Export Section */}
        <div className="flex justify-end">
          <ExportButton exports={exportData} />
        </div>
      </div>
    </AnalyticsErrorBoundary>
  );
}
