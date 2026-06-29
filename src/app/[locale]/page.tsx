// app/page.tsx

import type { Metadata } from "next";
import MainWrapper from "@/components/layout/MainWrapper";
import PageSection from "@/components/layout/PageSection";
import { getHomeData } from "@/lib/homeApi";
import FeaturedArtistSection from "@/components/organisms/FeaturedArtistSection";
import TopArtistsSection from "@/components/organisms/TopArtistsSection";
import TrendingSongsSection from "@/components/organisms/MostSearchedSongs";
import BrowseByGenreSection from "@/components/organisms/BrowseByGenreSection";
import BrowseByRegionSection from "@/components/organisms/BrowseByRegionSection";
import MostAwardedArtistsSection from "@/components/organisms/MostAwardedArtistsSection";
import ProminentComposersSection from "@/components/organisms/ProminentComposersSection";
import TopDjsSection from "@/components/organisms/TopDjsSection";
import BirthdaySection from "@/components/organisms/BirthdaySection";
import TopChristianArtistsSection from "@/components/organisms/TopChristianArtistsSection";
import ClassicalArtistsSection from "@/components/organisms/ClassicalArtistsSection";
import TopRisingStarsSection from "@/components/organisms/TopRisingStarsSection";
import TopLegendsArtistsSection from "@/components/organisms/TopLegendsArtistsSection";
import DecadeTimelineCarousel from "@/components/home/DecadeTimelineCarousel";
import { getArchiveCounts } from "@/lib/getSongsByYear";
import { createPageMetadata, type SeoLocale } from "@/lib/seo";
import JsonLd from "@/components/seo/JsonLd";
import { SITE_NAME, SITE_URL } from "@/lib/seo";

const HOME_METADATA: Record<SeoLocale, { title: string; description: string }> = {
  en: {
    title: "Mangulina — The Dominican Music Database",
    description:
      "Explore Dominican artists, songs, albums, genres, awards, and music history.",
  },
  es: {
    title: "Mangulina — La Base de Datos de Música Dominicana",
    description:
      "Explora artistas, canciones, álbumes, géneros, premios e historia de la música dominicana.",
  },
};

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale: routeLocale } = await params;
  const locale: SeoLocale = routeLocale === "es" ? "es" : "en";
  const { title, description } = HOME_METADATA[locale];

  return createPageMetadata({
    title,
    description,
    path: "/",
    locale,
  });
}

export const revalidate = 600; // 10 minutes

export default async function HomePage() {
  const [data, archiveCounts] = await Promise.all([
    getHomeData(),
    getArchiveCounts(),
  ]);

  return (
    <MainWrapper className="homepage-section-titles-red !pb-0">
      <JsonLd
        data={[
          {
            "@context": "https://schema.org",
            "@type": "WebSite",
            name: SITE_NAME,
            alternateName: "Dominican Music Database",
            url: SITE_URL,
            description:
              "Mangulina is a Dominican Music Database dedicated to documenting artists, songs, releases, genres, and Dominican music history.",
            potentialAction: {
              "@type": "SearchAction",
              target: `${SITE_URL}/search?q={search_term_string}`,
              "query-input": "required name=search_term_string",
            },
          },
          {
            "@context": "https://schema.org",
            "@type": "Organization",
            name: SITE_NAME,
            alternateName: "Dominican Music Database",
            url: SITE_URL,
            description:
              "Mangulina is a Dominican Music Database dedicated to documenting artists, songs, releases, genres, and Dominican music history.",
          },
        ]}
      />
      <PageSection>
        <FeaturedArtistSection featuredArtist={data.featuredArtist} />
      </PageSection>

      <PageSection>
        <TopArtistsSection topArtists={data.topArtists} />
      </PageSection>

      <PageSection>
        <DecadeTimelineCarousel decadeCounts={archiveCounts.decadeCounts} />
      </PageSection>

      <PageSection>
        <TopChristianArtistsSection christianArtists={data.christianArtists} />
      </PageSection>

      <PageSection>
        <BrowseByGenreSection />
      </PageSection>

      <PageSection>
        <MostAwardedArtistsSection artists={data.mostAwardedArtists} />
      </PageSection>

      <PageSection>
        <TrendingSongsSection songs={data.trendingSongs} />
      </PageSection>

      <PageSection>
        <TopLegendsArtistsSection artists={data.legendsArtists} />
      </PageSection>

      <PageSection>
        <BrowseByRegionSection regions={data.regions} />
      </PageSection>

      <PageSection>
        <ClassicalArtistsSection classicalArtists={data.classicalArtists} />
      </PageSection>

      <PageSection>
        <ProminentComposersSection composers={data.composers} />
      </PageSection>

      <PageSection>
        <TopDjsSection djs={data.djs} />
      </PageSection>

      <PageSection>
        <TopRisingStarsSection risingStars={data.risingStars} />
      </PageSection>

      <PageSection className="!mb-2">
        <BirthdaySection birthdayArtists={data.birthdayArtists} />
      </PageSection>
    </MainWrapper>
  );
}
