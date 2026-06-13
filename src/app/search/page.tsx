import Link from "next/link";
import SearchAnalytics from "@/components/analytics/SearchAnalytics";
import MainWrapper from "@/components/layout/MainWrapper";
import { globalSearch, SearchResult } from "@/lib/searchApi";

type SearchPageProps = {
  searchParams: Promise<{ q?: string }>;
};

function getHref(result: SearchResult) {
  if (result.type === "artist" && result.slug) return `/artists/${result.slug}`;
  if (result.type === "song") return `/songs/${result.slug ?? result.id}`;
  if (result.type === "release" && result.slug) return `/releases/${result.slug}`;
  return "#";
}

function PlaceholderCover({ label }: { label: string }) {
  return (
    <div className="flex h-16 w-16 shrink-0 items-center justify-center rounded-xl bg-linear-to-br from-gray-100 to-gray-200 text-lg font-black text-gray-400">
      {label.slice(0, 1).toUpperCase()}
    </div>
  );
}

function ResultGroup({
  title,
  results,
}: {
  title: string;
  results: SearchResult[];
}) {
  if (!results.length) return null;

  function getMetaLine(result: SearchResult) {
    if (result.type === "song") {
      return [result.year, result.release_title].filter(Boolean).join(" · ");
    }

    return [result.year, result.subtitle].filter(Boolean).join(" · ");
  }

  return (
    <section className="rounded-2xl border border-gray-100 bg-white p-5 shadow-sm">
      <h2 className="mb-4 text-sm font-black uppercase tracking-widest text-(--color-wikicrimson)">
        {title}
      </h2>

      <div className="space-y-2">
        {results.map((result) => {
          const metaLine = getMetaLine(result);

          return (
            <Link
              key={`${result.type}-${result.id}`}
              href={getHref(result)}
              className="group flex items-center gap-4 rounded-xl border border-gray-100 p-3 transition hover:border-(--color-wikicrimson) hover:bg-gray-50"
            >
              {result.cover_url ? (
                <div className="h-16 w-16 shrink-0 overflow-hidden rounded-xl bg-gray-100">
                  <img
                    src={result.cover_url}
                    alt={result.title}
                    className="h-full w-full object-cover"
                    loading="lazy"
                  />
                </div>
              ) : (
                <PlaceholderCover label={result.title} />
              )}

              <div className="min-w-0 flex-1">
                <h3 className="truncate font-bold text-gray-950 group-hover:text-(--color-wikicrimson)">
                  {result.title}
                </h3>

                {metaLine && (
                  <p className="mt-1 truncate text-sm text-gray-500">
                    {metaLine}
                  </p>
                )}

                {result.type === "song" && result.artist_name && (
                  <p className="truncate text-sm text-gray-500">
                    by {result.artist_name}
                  </p>
                )}
              </div>
            </Link>
          );
        })}
      </div>
    </section>
  );
}

export default async function SearchPage({ searchParams }: SearchPageProps) {
  const { q = "" } = await searchParams;
  const query = q.trim();

  const results = query
    ? await globalSearch(query)
    : { artists: [], songs: [], releases: [] };

  const total =
    results.artists.length + results.songs.length + results.releases.length;

  return (
    <MainWrapper>
      {query && <SearchAnalytics query={query} resultsCount={total} />}
      <div className="mx-auto max-w-5xl px-6 py-12">
        <header className="mb-8">
          <h1 className="text-4xl font-black uppercase tracking-tight text-(--color-flagblue)">
            Search
          </h1>

          <p className="mt-2 text-gray-600">
            {query ? (
              <>
                Results for <span className="font-bold">“{query}”</span>
              </>
            ) : (
              "Search artists, songs, and albums."
            )}
          </p>
        </header>

        {!query ? (
          <div className="rounded-2xl border border-dashed border-gray-200 bg-white p-8 text-gray-500">
            Type something in the search box to begin.
          </div>
        ) : total === 0 ? (
          <div className="rounded-2xl border border-dashed border-gray-200 bg-white p-8 text-gray-500">
            No results found.
          </div>
        ) : (
          <div className="space-y-6">
            <ResultGroup title="Artists" results={results.artists} />

            <ResultGroup title="Songs" results={results.songs} />

            <ResultGroup title="Albums" results={results.releases} />
          </div>
        )}
      </div>
    </MainWrapper>
  );
}
