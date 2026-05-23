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
import { supabase } from "@/lib/supabase";

export const revalidate = 600; // 10 minutes

export default async function HomePage() {
  const data = await getHomeData();

  const { data: composers } = await supabase
    .from("artists")
    .select("*")
    .contains("occupations", ["composer"])
    .order("views", { ascending: false })
    .limit(10); // temporary
    


  return (
    <MainWrapper>
      {/* HERO */}
      <PageSection>
        <FeaturedArtistSection featuredArtist={data.featuredArtist} />
      </PageSection>

      {/* CONTENT */}
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
        <BirthdaySection birthdayArtists={data.birthdayArtists} />
      </PageSection>

      <PageSection>
        <ProminentComposersSection composers={composers || []} />
      </PageSection>
    </MainWrapper>
  );
}