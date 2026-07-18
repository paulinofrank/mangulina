import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getLocale, getTranslations } from "next-intl/server";
import { localizeGenreContent } from "@/lib/genreContent.es";
import MainWrapper from "@/components/layout/MainWrapper";
import AnalyticsPageView from "@/components/analytics/AnalyticsPageView";
import SectionCard from "@/components/layout/SectionCard";
import ArtistCard from "@/components/molecules/ArtistCard";
import BioText from "@/components/molecules/BioText";
import GenreCarouselSection from "@/components/organisms/GenreCarouselSection";
import ArtistInterviewsCarousel from "@/components/organisms/ArtistInterviewsCarousel";
import SubgenreSelector from "@/components/genres/SubgenreSelector";
import GenreTitleSelector from "@/components/genres/GenreTitleSelector";
import GenreSubgenreSongs from "@/components/genres/GenreSubgenreSongs";
import JsonLd from "@/components/seo/JsonLd";
import {
  getGenrePageData,
  getGenrePageSlugs,
  getGenreMedia,
  getTopGenreOptions,
} from "@/lib/genreApi";
import { genreDefinitions } from "@/lib/genres";
import { createPageMetadata, genreSeoTitle } from "@/lib/seo";
import { breadcrumbSchema, collectionPageSchema } from "@/lib/structuredData";

type PageProps = {
  params: Promise<{ slug: string; locale: string }>;
  searchParams: Promise<{ subgenre?: string | string[] }>;
};

export const dynamic = "force-dynamic";

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
    title: genreSeoTitle(data.genre),
    description: `Explore ${data.genre.title} artists, songs, albums and recordings in the Dominican Music Database.`,
    path: `/genres/${data.genre.slug}`,
    locale,
  });
}

export default async function GenrePage({ params, searchParams }: PageProps) {
  const { slug } = await params;
  const requestedValue = (await searchParams).subgenre;
  const requestedSubgenre = typeof requestedValue === "string" ? requestedValue : undefined;
  const [data, topGenreOptions] = await Promise.all([
    getGenrePageData(slug, requestedSubgenre),
    getTopGenreOptions(),
  ]);

  if (!data) return notFound();

  const t = await getTranslations("pages.genreDetail");
  const locale = await getLocale();

  const {
    subgenres,
    connectedArtists,
  } = data;
  const genre = localizeGenreContent(data.genre, locale);
  const selectedSubgenre = requestedSubgenre
    ? subgenres.find((subgenre) => subgenre.slug === requestedSubgenre) ?? null
    : null;
  const genreMediaId = selectedSubgenre?.id ?? genre.catalogId;
  const genreMedia = genreMediaId ? await getGenreMedia(genreMediaId) : [];
  const activeGenreName = selectedSubgenre?.name ?? genre.title;
  const activeHistory = selectedSubgenre
    ? locale === "es"
      ? selectedSubgenre.historyEs || selectedSubgenre.history
      : selectedSubgenre.history
    : genre.history;
  const sortedSubgenres = subgenres.slice().sort((a, b) =>
    a.name.localeCompare(b.name, locale, { sensitivity: "base" }),
  );
  const Icon = genre.icon;

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
          ]),
        ]}
      />
      <AnalyticsPageView eventType="genre_view" entityId={genre.slug} />
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
              {activeHistory && (
                <a
                  href="#genre-history"
                  className="mt-4 inline-flex text-sm font-semibold text-[#8B0000] underline decoration-[#8B0000]/30 underline-offset-4 transition-colors hover:text-[#CE1126]"
                >
                  {t("learnMoreHistory", { genre: activeGenreName })}
                </a>
              )}
            </div>

            <div className={`flex min-h-48 flex-col items-center justify-center py-6 ${genre.color}`}>
              <Icon className="h-20 w-20 text-white/90" strokeWidth={1.4} />
              {sortedSubgenres.length > 0 && (
                <>
                  <p className="mt-4 text-center text-sm font-semibold uppercase tracking-[0.16em] text-white">
                    {t("subgenresStyles")}
                  </p>
                  <SubgenreSelector
                    options={sortedSubgenres}
                    selectedSlug={selectedSubgenre?.slug ?? null}
                    hasInvalidSelection={Boolean(requestedSubgenre && !selectedSubgenre)}
                    label={t("subgenreSelector.label")}
                    allLabel={t("subgenreSelector.all")}
                  />
                </>
              )}
            </div>
          </div>
        </header>

        <div className="space-y-8">
          {connectedArtists.length > 0 && (
            <GenreCarouselSection
              title={t("connectedArtists", {
                genre: activeGenreName,
              })}
            >
              {connectedArtists.map((artist, index) => (
                <div key={artist.id} className="shrink-0 w-28 sm:w-32 lg:w-36">
                  <ArtistCard artist={artist} titleAs="h3" priorityImage={index === 0} />
                </div>
              ))}
            </GenreCarouselSection>
          )}

          {genre.catalogId && (
            <GenreSubgenreSongs
              key={selectedSubgenre?.slug ?? "all"}
              genreId={genre.catalogId}
              genreName={genre.title}
              subgenre={selectedSubgenre}
            />
          )}

          <ArtistInterviewsCarousel
            interviews={genreMedia}
            title={t("publicMedia.title", { genre: activeGenreName })}
            subtitle={t("publicMedia.subtitle")}
          />

          {activeHistory && (
            <div id="genre-history" className="scroll-mt-20 sm:scroll-mt-24">
              <SectionCard>
                <div className="section-inner">
                  <div className="section-header">
                    <h2>{t("history", { genre: activeGenreName })}</h2>
                  </div>
                  <div className="max-w-5xl">
                    <BioText bio={activeHistory} />
                  </div>
                </div>
              </SectionCard>
            </div>
          )}

        </div>
      </div>
    </MainWrapper>
  );
}
