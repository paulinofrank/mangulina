"use client";

import { Link } from "@/i18n/navigation";
import { useTranslations } from "next-intl";
import type { SearchResult } from "@/lib/searchApi";

type SearchContentProps = {
  query: string;
  total: number;
  results: {
    artists: SearchResult[];
    songs: SearchResult[];
    releases: SearchResult[];
  };
};

function getHref(result: SearchResult) {
  if (result.type === "artist" && result.slug) return `/artists/${result.slug}`;
  if (result.type === "song" && result.slug) return `/songs/${result.slug}`;
  if (result.type === "release" && result.slug) return `/releases/${result.slug}`;
  return null;
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
          const href = getHref(result);
          const className =
            "group flex items-center gap-4 rounded-xl border border-gray-100 p-3 transition hover:border-(--color-wikicrimson) hover:bg-gray-50";
          const content = (
            <>
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
            </>
          );

          return href ? (
            <Link
              key={`${result.type}-${result.id}`}
              href={href}
              className={className}
            >
              {content}
            </Link>
          ) : (
            <div
              key={`${result.type}-${result.id}`}
              className={className}
              aria-disabled="true"
            >
              {content}
            </div>
          );
        })}
      </div>
    </section>
  );
}

export default function SearchContent({
  query,
  total,
  results,
}: SearchContentProps) {
  const t = useTranslations("search");

  return (
    <div className="mx-auto max-w-5xl px-6 py-12">
      <header className="mb-8">
        <h1 className="text-4xl font-black uppercase tracking-tight text-(--color-flagblue)">
          {t("ui.placeholder").replace("Search artists, songs...", "Search")}
        </h1>

        <p className="mt-2 text-gray-600">
          {query ? (
            <>
              {t("ui.resultsFor")} <span className="font-bold">"{query}"</span>
            </>
          ) : (
            t("ui.placeholder")
          )}
        </p>
      </header>

      {!query ? (
        <div className="rounded-2xl border border-dashed border-gray-200 bg-white p-8 text-gray-500">
          {t("ui.noQuery")}
        </div>
      ) : total === 0 ? (
        <div className="rounded-2xl border border-dashed border-gray-200 bg-white p-8 text-gray-500">
          {t("ui.noResults")}
        </div>
      ) : (
        <div className="space-y-6">
          <ResultGroup title={t("ui.artistsGroup")} results={results.artists} />

          <ResultGroup title={t("ui.songsGroup")} results={results.songs} />

          <ResultGroup title={t("ui.albumsGroup")} results={results.releases} />
        </div>
      )}
    </div>
  );
}
