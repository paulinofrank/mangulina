// app/page.tsx

import MainWrapper from "@/components/layout/MainWrapper";
import PageSection from "@/components/layout/PageSection";
import { getHomeData } from "@/lib/homeApi";
import FeaturedArtistSection from "@/components/organisms/FeaturedArtistSection";
import TopArtistsSection from "@/components/organisms/TopArtistsSection";
import TrendingSongsSection from "@/components/organisms/MostSearchedSongs";
import BrowseByGenreSection from "@/components/organisms/BrowseByGenreSection";
import BrowseByRegionSection from "@/components/organisms/BrowseByRegionSection";
import ProminentComposersSection from "@/components/organisms/ProminentComposersSection";
import BirthdaySection from "@/components/organisms/BirthdaySection";
import TopChristianArtistsSection from "@/components/organisms/TopChristianArtistsSection";
import TopRisingStarsSection from "@/components/organisms/TopRisingStarsSection";

export const revalidate = 600; // 10 minutes

export default async function HomePage() {
  const data = await getHomeData();

  return (
    <MainWrapper>
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
        <TrendingSongsSection songs={data.trendingSongs} />
      </PageSection>

      <PageSection>
        <BrowseByGenreSection />
      </PageSection>

      <PageSection>
        <TopChristianArtistsSection christianArtists={data.christianArtists} />
      </PageSection>

      <PageSection>
        <ProminentComposersSection composers={data.composers} />
      </PageSection>

      <PageSection>
        <TopRisingStarsSection risingStars={data.risingStars} />
      </PageSection>

      <PageSection>
        <BirthdaySection birthdayArtists={data.birthdayArtists} />
      </PageSection>
    </MainWrapper>
  );
}
