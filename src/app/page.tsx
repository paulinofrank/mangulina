// app/page.tsx

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
import { createPageMetadata, DEFAULT_DESCRIPTION } from "@/lib/seo";

export const metadata = createPageMetadata({
  title: "Dominican Music Database",
  description: DEFAULT_DESCRIPTION,
  path: "/",
});

export const revalidate = 600; // 10 minutes

export default async function HomePage() {
  const data = await getHomeData();

  return (
    <MainWrapper className="!pb-0">
      <PageSection>
        <FeaturedArtistSection featuredArtist={data.featuredArtist} />
      </PageSection>

      <PageSection>
        <TopArtistsSection topArtists={data.topArtists} />
      </PageSection>

      <PageSection>
        <BrowseByRegionSection regions={data.regions} />
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
