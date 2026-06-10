// components/organisms/SongHero.tsx
import Image from "next/image";
import Link from "next/link";

import { genreDefinitions } from "@/lib/genres";

type SongHeroProps = {
  title: string;
  artist: string;
  artistSlug?: string | null;
  year?: number | null;
  genre?: string | null;       // genre_name from view
  subgenre?: string | null;    // subgenre_name from view
  duration?: number | null;    // milliseconds
  isrcs?: string[] | null;
  views?: number | null;
  coverImageUrl?: string | null;
  releaseTitle?: string | null;
  releaseSlug?: string | null;
};

function formatDuration(ms: number): string {
  const totalSec = Math.floor(ms / 1000);
  const min = Math.floor(totalSec / 60);
  const sec = totalSec % 60;
  return `${min}:${String(sec).padStart(2, "0")}`;
}

function slugify(value: string): string {
  return value
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}

function getGenreHref(label: string): string {
  const normalized = label.trim().toLowerCase();
  const definition = genreDefinitions.find((genreDefinition) => {
    const names = [
      genreDefinition.title,
      genreDefinition.primaryGenre,
      ...genreDefinition.aliases,
    ]
      .filter(Boolean)
      .map((name) => String(name).trim().toLowerCase());

    return names.includes(normalized);
  });

  return definition?.href ?? `/genres/${slugify(label)}`;
}

export default function SongHero({
  title,
  artist,
  artistSlug,
  year,
  genre,
  subgenre,
  duration,
  isrcs,
  views,
  coverImageUrl,
  releaseTitle,
  releaseSlug,
}: SongHeroProps) {
  const genreChips = [genre, subgenre].filter(Boolean) as string[];
  const isrcText = (isrcs ?? []).filter(Boolean).join(" · ");
  const durationStr = duration && duration > 0 ? formatDuration(duration) : null;
  const heroFacts = [
    releaseTitle ? { label: "Album", value: releaseTitle } : null,
    year ? { label: "Release Year", value: String(year) } : null,
    durationStr ? { label: "Duration", value: durationStr } : null,
  ].filter(Boolean) as { label: string; value: string }[];
  const hasMetadata =
    heroFacts.length > 0 ||
    Boolean(views != null && views > 0) ||
    Boolean(isrcText) ||
    genreChips.length > 0;

  return (
    <section className="relative h-fit overflow-hidden rounded-xl border border-black/5 bg-white/60">
      <div className="px-5 py-6 sm:px-6">
        <div className="flex flex-col items-start gap-6 md:flex-row">
          <div className="group relative aspect-square w-full shrink-0 overflow-hidden rounded-lg border border-black/5 bg-gray-100 sm:w-56 lg:w-64">
            {coverImageUrl ? (
              <Image
                src={coverImageUrl}
                alt={title}
                fill
                className="object-cover transition-all duration-300 group-hover:scale-105 group-hover:brightness-110"
                priority
                sizes="(max-width: 640px) calc(100vw - 56px), 256px"
              />
            ) : (
              <div className="flex h-full w-full items-center justify-center bg-gray-100 text-xs italic text-gray-400">
                No Image
              </div>
            )}
          </div>

          <div className="flex min-w-0 flex-1 flex-col justify-center gap-4 md:min-h-56 lg:min-h-64">
            <div className="min-w-0">
              <h1 className="flex flex-wrap items-baseline gap-x-3 gap-y-1 text-3xl font-bold leading-tight text-[#002D62] sm:text-4xl lg:text-5xl">
                <span>{title}</span>
                <span className="text-xl font-semibold text-gray-500 sm:text-2xl lg:text-3xl">
                  by{" "}
                  {artistSlug ? (
                    <Link
                      href={`/artists/${artistSlug}`}
                      className="transition-colors hover:text-[#CE1126]"
                    >
                      {artist}
                    </Link>
                  ) : (
                    <span>{artist}</span>
                  )}
                </span>
              </h1>
            </div>

            {hasMetadata && (
              <dl className="grid gap-x-8 gap-y-3 text-sm text-gray-600 sm:grid-cols-2 xl:grid-cols-3">
                {heroFacts.map((fact) => (
                  <div key={fact.label} className="flex min-w-0 items-center gap-3">
                    <dt className="shrink-0 text-[10px] font-semibold uppercase tracking-[0.18em] text-gray-400">
                      {fact.label}
                    </dt>
                    <dd className="min-w-0 truncate text-gray-600">
                      {fact.label === "Album" && releaseSlug ? (
                        <Link
                          href={`/releases/${releaseSlug}`}
                          className="transition-colors hover:text-[#CE1126]"
                        >
                          {fact.value}
                        </Link>
                      ) : (
                        fact.value
                      )}
                    </dd>
                  </div>
                ))}

                {views != null && views > 0 && (
                  <div className="flex min-w-0 items-center gap-3">
                    <dt className="shrink-0 text-[10px] font-semibold uppercase tracking-[0.18em] text-gray-400">
                      Views
                    </dt>
                    <dd className="min-w-0 truncate text-gray-600">
                      {views.toLocaleString()}
                    </dd>
                  </div>
                )}

                {isrcText && (
                  <div className="flex min-w-0 items-center gap-3">
                    <dt className="shrink-0 text-[10px] font-semibold uppercase tracking-[0.18em] text-gray-400">
                      ISRC
                    </dt>
                    <dd className="min-w-0 truncate text-gray-600">
                      {isrcText}
                    </dd>
                  </div>
                )}

                {genreChips.length > 0 && (
                  <div className="flex min-w-0 items-center gap-3 sm:col-span-2 xl:col-span-1">
                    <dt className="shrink-0 text-[10px] font-semibold uppercase tracking-[0.18em] text-gray-400">
                      Genres
                    </dt>
                    <dd className="flex min-w-0 flex-wrap gap-2">
                      {genreChips.map((chip) => (
                        <Link
                          key={chip}
                          href={getGenreHref(chip)}
                          className="inline-flex items-center rounded-full border border-gray-200 bg-gray-50 px-3 py-1 text-xs font-medium text-gray-500 transition-colors hover:border-gray-300 hover:bg-gray-100 hover:text-gray-700"
                        >
                          {chip}
                        </Link>
                      ))}
                    </dd>
                  </div>
                )}
              </dl>
            )}
          </div>
        </div>
      </div>
    </section>
  );
}
