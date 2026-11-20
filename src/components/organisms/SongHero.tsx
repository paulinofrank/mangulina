// components/organisms/SongHero.tsx
import Image from "next/image";
import { Link } from "@/i18n/navigation";
import { getTranslations } from "next-intl/server";
import { ChevronLeft, ChevronRight } from "lucide-react";

import { getPublicGenreDestinations } from "@/lib/genreApi";
import { resolveGenreDestination } from "@/lib/genreDestinations";
import { formatDurationMilliseconds } from "@/lib/artistPortfolioPresentation";
import ShareButton from "@/components/atoms/ShareButton";
import SongHeroTitle from "./SongHeroTitle";

const metadataChipClass = "inline-flex grow items-center rounded-md border border-[#002D62]/10 bg-[#002D62]/5 px-3 py-1 text-xs font-medium text-[#002D62]";
const linkedMetadataChipClass = `${metadataChipClass} transition-colors hover:border-[#CE1126]/20 hover:bg-[#CE1126]/5 hover:text-[#CE1126]`;

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
  shareUrl: string;
  shareTitle: string;
};

export default async function SongHero({
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
  shareUrl,
  shareTitle,
}: SongHeroProps) {
  const [t, destinations] = await Promise.all([getTranslations(), getPublicGenreDestinations()]);
  const genreChips = [genre, subgenre].filter((label): label is string => Boolean(label))
    .map((label) => ({ label, href: resolveGenreDestination(label, destinations, genre) }));
  const isrcText = (isrcs ?? []).filter(Boolean).join(" · ");
  const durationStr = duration && duration > 0 ? formatDurationMilliseconds(duration) : null;
  const heroFacts = [
    year ? { key: "releaseYear", label: t("song.hero.releaseYear"), value: String(year) } : null,
    durationStr ? { key: "duration", label: t("song.hero.duration"), value: durationStr } : null,
  ].filter(Boolean) as { key: string; label: string; value: string }[];
  const hasMetadata =
    Boolean(releaseTitle) ||
    heroFacts.length > 0 ||
    Boolean(views != null && views > 0) ||
    Boolean(isrcText) ||
    genreChips.length > 0;

  return (
    <section className="relative h-fit overflow-hidden rounded-xl border border-black/5 bg-white/60">
      <div className="px-5 py-6 sm:px-6">
        <div className="flex flex-col items-start gap-6 md:flex-row">
          <div className="group relative aspect-square w-full shrink-0 overflow-hidden rounded-lg border border-black/5 bg-gray-100 sm:w-56 lg:w-64">
            <ShareButton url={shareUrl} title={shareTitle} subject={title} placement="artwork" />
            {coverImageUrl ? (
              // Song pages select the stored 300px WebP variant. Optimizing it
              // would only upscale/re-encode that fixed source; see the image architecture.
              <Image
                src={coverImageUrl}
                alt={title}
                fill
                className="object-cover transition-all duration-300 group-hover:scale-105 group-hover:brightness-110"
                priority
                sizes="(max-width: 640px) calc(100vw - 56px), 256px"
                unoptimized
              />
            ) : (
              <div className="flex h-full w-full items-center justify-center bg-gray-100 text-xs italic text-gray-500">
                {t("common.noImage")}
              </div>
            )}
          </div>

          <div className="flex w-full min-w-0 flex-1 flex-col justify-center gap-4 md:min-h-56 md:w-auto lg:min-h-64">
            <div className="min-w-0">
              <h1 className="flex flex-col items-center gap-x-3 gap-y-1 text-center text-3xl font-bold leading-tight text-[#002D62] sm:text-4xl md:flex-row md:flex-wrap md:items-baseline md:text-left lg:text-5xl">
                <SongHeroTitle title={title} />
                <span className="inline-flex items-center gap-2 text-xl font-semibold text-gray-500 sm:text-2xl lg:text-3xl">
                  <span className="sr-only">{t("song.hero.by")}{" "}</span>
                  <ChevronRight aria-hidden="true" strokeWidth={3} className="size-4 shrink-0 text-[#CE1126]" />
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
                  <ChevronLeft aria-hidden="true" strokeWidth={3} className="size-4 shrink-0 text-[#CE1126]" />
                </span>
              </h1>
              <div aria-hidden="true" className="mx-auto mt-3 h-px w-[93.333%] max-w-[16.8rem] bg-linear-to-r from-transparent via-gray-400/25 to-transparent md:hidden" />
            </div>

            {hasMetadata && (
              <dl className="grid gap-x-8 gap-y-3 text-sm text-gray-600 sm:grid-cols-2 xl:grid-cols-3">
                {releaseTitle && (
                  <div className="flex min-w-0 items-center gap-3 sm:col-span-full">
                    <dt className="shrink-0 text-[10px] font-semibold uppercase tracking-[0.18em] text-gray-500">
                      {t("song.hero.album")}
                    </dt>
                    <dd className="flex min-w-0 flex-1">
                      {releaseSlug ? (
                        <Link href={`/releases/${releaseSlug}`} className={linkedMetadataChipClass}>
                          {releaseTitle}
                        </Link>
                      ) : (
                        <span className={metadataChipClass}>{releaseTitle}</span>
                      )}
                    </dd>
                  </div>
                )}

                {genreChips.length > 0 && (
                  <div className="flex min-w-0 items-center gap-3 sm:col-start-1 sm:col-span-full">
                    <dt className="shrink-0 text-[10px] font-semibold uppercase tracking-[0.18em] text-gray-500">
                      {t("song.hero.genres")}
                    </dt>
                    <dd className="flex min-w-0 flex-1 flex-wrap gap-2">
                      {genreChips.map((chip) => (
                        chip.href ? <Link
                          key={chip.label}
                          href={chip.href}
                          className={linkedMetadataChipClass}
                        >
                          {chip.label}
                        </Link> : <span key={chip.label} className={metadataChipClass}>{chip.label}</span>
                      ))}
                    </dd>
                  </div>
                )}

                {heroFacts.map((fact) => (
                  <div key={fact.key} className={`relative flex min-w-0 items-center gap-3${fact.key === "releaseYear" ? " max-sm:pb-3 sm:col-span-full" : ""}`}>
                    <dt className="shrink-0 text-[10px] font-semibold uppercase tracking-[0.18em] text-gray-500">
                      {fact.label}
                    </dt>
                    <dd className={fact.key === "releaseYear" ? "flex min-w-0 flex-1" : "min-w-0 truncate text-gray-600"}>
                      {fact.key === "releaseYear" ? (
                        <Link href={`/archive/${fact.value}`} className={linkedMetadataChipClass}>
                          {fact.value}
                        </Link>
                      ) : (
                        fact.value
                      )}
                    </dd>
                    {fact.key === "releaseYear" && (
                      <div aria-hidden="true" className="pointer-events-none absolute inset-x-0 bottom-0 mx-auto h-px w-[93.333%] max-w-[16.8rem] bg-linear-to-r from-transparent via-gray-400/25 to-transparent sm:hidden" />
                    )}
                  </div>
                ))}

                {isrcText && (
                  <div className="flex min-w-0 items-center gap-3">
                    <dt className="shrink-0 text-[10px] font-semibold uppercase tracking-[0.18em] text-gray-500">
                      ISRC
                    </dt>
                    <dd className="min-w-0 truncate text-gray-600">
                      {isrcText}
                    </dd>
                  </div>
                )}

                {views != null && views > 0 && (
                  <div className="flex min-w-0 items-center gap-3">
                    <dt className="shrink-0 text-[10px] font-semibold uppercase tracking-[0.18em] text-gray-500">
                      {t("song.hero.views")}
                    </dt>
                    <dd className="min-w-0 truncate text-gray-600">
                      {views.toLocaleString()}
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
