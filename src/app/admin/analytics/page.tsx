import Link from "next/link";
import { getSupabaseServiceClient } from "@/lib/adminAccess";

export const dynamic = "force-dynamic";

type ArtistViewRow = {
  artist_id: string;
  views_7d: number;
};

type RecordingViewRow = {
  recording_id: string;
  views_7d: number;
};

type NoResultSearchRow = {
  query: string;
  search_count: number;
  last_searched_at: string;
};

type PlatformClickRow = {
  platform: string;
  clicks_30d: number;
};

type ArtistRow = {
  id: string;
  name: string;
  slug: string;
};

type RecordingRow = {
  id: string;
  title: string;
  slug: string | null;
};

function formatPlatform(platform: string) {
  return platform
    .replace(/_/g, " ")
    .replace(/\b\w/g, (character) => character.toUpperCase());
}

function ReportCard({
  title,
  children,
}: {
  title: string;
  children: React.ReactNode;
}) {
  return (
    <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <h2 className="mb-5 text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
        {title}
      </h2>
      {children}
    </section>
  );
}

function EmptyRow() {
  return <p className="py-5 text-center text-sm text-gray-500">No activity recorded yet.</p>;
}

export default async function AdminAnalyticsPage() {
  const supabase = getSupabaseServiceClient();
  const [artistViewsResponse, recordingViewsResponse, searchesResponse, clicksResponse] =
    await Promise.all([
      supabase
        .from("artist_views_last_7_days")
        .select("artist_id,views_7d")
        .order("views_7d", { ascending: false })
        .limit(20),
      supabase
        .from("recording_views_last_7_days")
        .select("recording_id,views_7d")
        .order("views_7d", { ascending: false })
        .limit(20),
      supabase
        .from("searches_with_no_results")
        .select("query,search_count,last_searched_at")
        .order("search_count", { ascending: false })
        .order("last_searched_at", { ascending: false })
        .limit(30),
      supabase
        .from("platform_clicks_last_30_days")
        .select("platform,clicks_30d")
        .order("clicks_30d", { ascending: false }),
    ]);

  const hasError = Boolean(
    artistViewsResponse.error ||
      recordingViewsResponse.error ||
      searchesResponse.error ||
      clicksResponse.error,
  );
  const artistViews = (artistViewsResponse.data ?? []) as ArtistViewRow[];
  const recordingViews = (recordingViewsResponse.data ?? []) as RecordingViewRow[];
  const searches = (searchesResponse.data ?? []) as NoResultSearchRow[];
  const clicks = (clicksResponse.data ?? []) as PlatformClickRow[];

  const [artistsResponse, recordingsResponse] = await Promise.all([
    artistViews.length
      ? supabase
          .from("artists")
          .select("id,name,slug")
          .in("id", artistViews.map((row) => row.artist_id))
      : Promise.resolve({ data: [] as ArtistRow[], error: null }),
    recordingViews.length
      ? supabase
          .from("recordings")
          .select("id,title,slug")
          .in("id", recordingViews.map((row) => row.recording_id))
      : Promise.resolve({ data: [] as RecordingRow[], error: null }),
  ]);

  const artists = new Map(
    ((artistsResponse.data ?? []) as ArtistRow[]).map((artist) => [artist.id, artist]),
  );
  const recordings = new Map(
    ((recordingsResponse.data ?? []) as RecordingRow[]).map((recording) => [
      recording.id,
      recording,
    ]),
  );

  return (
    <main className="min-h-screen bg-gray-50 px-5 pb-10 pt-8 font-sans text-gray-900 sm:px-6 sm:pb-12 sm:pt-10">
      <div className="mx-auto max-w-6xl">
        <header className="mb-8 rounded-xl border border-black/5 bg-white p-6 shadow-sm sm:p-8">
          <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
            <div>
              <p className="text-xs font-medium uppercase tracking-[0.22em] text-[#CE1126]">
                Mangulina Admin
              </p>
              <h1 className="mt-3 text-3xl font-black uppercase tracking-tight text-[#002D62] sm:text-4xl">
                Analytics
              </h1>
              <p className="mt-4 max-w-3xl text-sm leading-relaxed text-gray-600 sm:text-base">
                Anonymous activity signals for editorial priorities, catalog gaps, and platform engagement.
              </p>
            </div>

            <Link
              href="/admin"
              className="inline-flex w-fit items-center rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs font-normal uppercase tracking-[0.18em] text-[#002D62] shadow-sm transition hover:border-[#CE1126] hover:text-[#CE1126]"
            >
              Admin Portal
            </Link>
          </div>
        </header>

        {hasError && (
          <div className="mb-6 rounded-xl border border-[#CE1126]/20 bg-white px-4 py-3 text-sm text-[#8B0000] shadow-sm">
            Some analytics reports are temporarily unavailable. Confirm that the analytics migration has been applied.
          </div>
        )}

        <div className="grid gap-6 lg:grid-cols-2">
          <ReportCard title="Top Artist Views - Last 7 Days">
            {artistViews.length === 0 ? (
              <EmptyRow />
            ) : (
              <div className="divide-y divide-gray-100">
                {artistViews.map((row) => {
                  const artist = artists.get(row.artist_id);
                  return (
                    <div key={row.artist_id} className="flex items-center justify-between gap-4 py-3">
                      {artist ? (
                        <Link href={`/artists/${artist.slug}`} className="min-w-0 truncate text-sm font-medium text-[#002D62] hover:text-[#CE1126]">
                          {artist.name}
                        </Link>
                      ) : (
                        <span className="truncate text-sm text-gray-500">Unknown artist</span>
                      )}
                      <span className="shrink-0 text-sm tabular-nums text-gray-600">{row.views_7d.toLocaleString()}</span>
                    </div>
                  );
                })}
              </div>
            )}
          </ReportCard>

          <ReportCard title="Top Recording Views - Last 7 Days">
            {recordingViews.length === 0 ? (
              <EmptyRow />
            ) : (
              <div className="divide-y divide-gray-100">
                {recordingViews.map((row) => {
                  const recording = recordings.get(row.recording_id);
                  return (
                    <div key={row.recording_id} className="flex items-center justify-between gap-4 py-3">
                      {recording ? (
                        <Link href={`/songs/${recording.slug ?? recording.id}`} className="min-w-0 truncate text-sm font-medium text-[#002D62] hover:text-[#CE1126]">
                          {recording.title}
                        </Link>
                      ) : (
                        <span className="truncate text-sm text-gray-500">Unknown recording</span>
                      )}
                      <span className="shrink-0 text-sm tabular-nums text-gray-600">{row.views_7d.toLocaleString()}</span>
                    </div>
                  );
                })}
              </div>
            )}
          </ReportCard>

          <ReportCard title="Searches With No Results">
            {searches.length === 0 ? (
              <EmptyRow />
            ) : (
              <div className="divide-y divide-gray-100">
                {searches.map((row) => (
                  <div key={row.query} className="flex items-center justify-between gap-4 py-3">
                    <div className="min-w-0">
                      <p className="truncate text-sm font-medium text-[#002D62]">{row.query}</p>
                      <p className="mt-1 text-xs text-gray-400">Last searched {new Date(row.last_searched_at).toLocaleDateString()}</p>
                    </div>
                    <span className="shrink-0 text-sm tabular-nums text-gray-600">{row.search_count.toLocaleString()}</span>
                  </div>
                ))}
              </div>
            )}
          </ReportCard>

          <ReportCard title="Platform Clicks - Last 30 Days">
            {clicks.length === 0 ? (
              <EmptyRow />
            ) : (
              <div className="divide-y divide-gray-100">
                {clicks.map((row) => (
                  <div key={row.platform} className="flex items-center justify-between gap-4 py-3">
                    <span className="text-sm font-medium text-[#002D62]">{formatPlatform(row.platform)}</span>
                    <span className="text-sm tabular-nums text-gray-600">{row.clicks_30d.toLocaleString()}</span>
                  </div>
                ))}
              </div>
            )}
          </ReportCard>
        </div>
      </div>
    </main>
  );
}
