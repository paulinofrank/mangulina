import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getLocale, getTranslations } from "next-intl/server";
import { localizeGenreContent } from "@/lib/genreContent.es";
import MainWrapper from "@/components/layout/MainWrapper";
import AnalyticsPageView from "@/components/analytics/AnalyticsPageView";
import GenreDynamicSections, { GenreHistoryLink } from "@/components/genres/GenreDynamicSections";
import GenreSubgenreProvider from "@/components/genres/GenreSubgenreProvider";
import SubgenreSelector from "@/components/genres/SubgenreSelector";
import GenreTitleSelector from "@/components/genres/GenreTitleSelector";
import JsonLd from "@/components/seo/JsonLd";
import {
  getGenrePageData,
  getGenrePageSlugs,
  getGenreMedia,
  getTopGenreOptions,
} from "@/lib/genreApi";
import { ALL_SUBGENRES, type GenreLabelSet, type GenreLabels } from "@/lib/genreLabels";
import { genreDefinitions } from "@/lib/genres";
import { createPageMetadata, genreSeoTitle } from "@/lib/seo";
import { breadcrumbSchema, collectionPageSchema } from "@/lib/structuredData";

type PageProps = {
  params: Promise<{ slug: string; locale: string }>;
};

/**
 * Genre profiles are cacheable HTML.
 *
 * This route was `force-dynamic` and read `?subgenre=` during the server
 * render, so every request — including repeated hits on the same canonical
 * URL — was rendered at origin. Production logs showed 78 genre renders with
 * zero cache hits of any kind.
 *
 * The server now renders only the canonical, unfiltered genre, so the route
 * has a bounded cache identity: query strings are ignored here and therefore
 * cannot multiply Full Route Cache entries. Subgenre filtering moved to the
 * client (see GenreSubgenreProvider).
 *
 * The 24h fallback TTL is a safety net, not the freshness mechanism: the admin
 * genre, subgenre and genre-media routes revalidate this page on demand (see
 * src/lib/revalidateGenre.ts).
 */
export const revalidate = 86400;

// Genres are a small, bounded family (~18 canonical slugs), so prerendering
// them at build is cheap and gives crawlers a warm cache from the first hit.
// This export existed before but was inert under `force-dynamic`.
export async function generateStaticParams() {
  const dbSlugs = await getGenrePageSlugs();
  const slugs = Array.from(new Set([...genreDefinitions.map((genre) => genre.slug), ...dbSlugs]));

  return slugs.map((slug) => ({ slug }));
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { slug, locale } = await params;
  const data = await getGenrePageData(slug);

  if (!data) {
    return createPageMetadata({
      title: "Genre Not Found",
      description: "This genre is not available in the Dominican Music Database.",
      path: `/genres/${slug}`,
      locale,
      noIndex: true,
    });
  }

  return createPageMetadata({
    title: genreSeoTitle(data.genre, locale),
    description: locale === "es"
      ? `Explora artistas, canciones, álbumes y grabaciones de ${data.genre.title} en la Base de Datos de Música Dominicana.`
      : `Explore ${data.genre.title} artists, songs, albums and recordings in the Dominican Music Database.`,
    path: `/genres/${data.genre.slug}`,
    locale,
  });
}

export default async function GenrePage({ params }: PageProps) {
  const { slug, locale: routeLocale } = await params;
  const [data, topGenreOptions] = await Promise.all([
    getGenrePageData(slug),
    getTopGenreOptions(),
  ]);

  if (!data) return notFound();

  const t = await getTranslations("pages.genreDetail");
  const locale = await getLocale();

  const { subgenres, connectedSoloArtists, connectedGroupArtists } = data;
  const genre = localizeGenreContent(data.genre, locale);
  const genreMedia = genre.catalogId ? await getGenreMedia(genre.catalogId) : [];
  const sortedSubgenres = subgenres.slice().sort((a, b) =>
    a.name.localeCompare(b.name, locale, { sensitivity: "base" }),
  );
  const Icon = genre.icon;

  // The public client bundle deliberately excludes the `pages.*` messages
  // (see [locale]/layout.tsx), so headings are resolved here and handed down.
  // Every possible active name is known server-side — the genre itself plus
  // each of its subgenres — so this is a small, bounded set of strings.
  const labelsFor = (name: string): GenreLabelSet => ({
    connectedSoloArtists: t("connectedSoloArtists", { genre: name }),
    connectedGroupArtists: t("connectedGroupArtists", { genre: name }),
    songsHeading: t("subgenreSongs", { name }),
    songsEmpty: t("noSongsAssigned", { name }),
    mediaTitle: t("publicMedia.title", { genre: name }),
    history: t("history", { genre: name }),
    learnMoreHistory: t("learnMoreHistory", { genre: name }),
  });
  const labels: GenreLabels = {
    byKey: {
      [ALL_SUBGENRES]: labelsFor(genre.title),
      ...Object.fromEntries(
        sortedSubgenres.map((subgenre) => [subgenre.slug, labelsFor(subgenre.name)]),
      ),
    },
    loadError: t("loadError"),
    sortAria: t("sortAria"),
    mediaSubtitle: t("publicMedia.subtitle"),
  };

  return (
    <MainWrapper>
      <JsonLd
        data={[
          collectionPageSchema({
            name: `${genre.title} Artists, Songs & Albums`,
            description: `Explore ${genre.title} artists, songs, albums and recordings in the Dominican Music Database.`,
            path: `/genres/${genre.slug}`,
          }),
          breadcrumbSchema([
            { name: "Home", path: "/" },
            { name: "Genres", path: "/discover#genres" },
            { name: genre.title, path: `/genres/${genre.slug}` },
          ], routeLocale),
        ]}
      />
      <AnalyticsPageView eventType="genre_view" entityId={genre.slug} />
      <GenreSubgenreProvider
        genreSlug={genre.slug}
        genreHistory={genre.history ?? null}
        subgenres={sortedSubgenres}
        canonicalSoloArtists={connectedSoloArtists}
        canonicalGroupArtists={connectedGroupArtists}
        canonicalMedia={genreMedia}
        locale={locale}
        labels={labels}
      >
        <div className="w-full px-5 pb-10 pt-5 sm:px-6 sm:pb-12 sm:pt-6">
          <header className="mb-8 overflow-hidden rounded-lg border border-black/5 bg-white shadow-sm">
            <div className="grid gap-0 md:grid-cols-[1fr_280px]">
              <div className="p-6 sm:p-8">
                <GenreTitleSelector
                  currentSlug={genre.slug}
                  currentTitle={genre.title}
                  options={topGenreOptions}
                  label={t("genreSelectorLabel")}
                />
                <p className="mt-5 max-w-3xl text-base leading-relaxed text-gray-700 sm:text-lg">
                  {genre.description}
                </p>
                <GenreHistoryLink />
              </div>

              <div className={`flex min-h-48 flex-col items-center justify-center py-6 ${genre.color}`}>
                <Icon className="h-20 w-20 text-white/90" strokeWidth={1.4} />
                {sortedSubgenres.length > 0 && (
                  <>
                    <p className="mt-4 text-center text-sm font-semibold uppercase tracking-[0.16em] text-white">
                      {t("subgenresStyles")}
                    </p>
                    <SubgenreSelector
                      label={t("subgenreSelector.label")}
                      allLabel={t("subgenreSelector.all")}
                    />
                  </>
                )}
              </div>
            </div>
          </header>

          <div className="space-y-8">
            <GenreDynamicSections genreCatalogId={genre.catalogId ?? null} />
          </div>
        </div>
      </GenreSubgenreProvider>
    </MainWrapper>
  );
}
