// app/page.tsx

import { getHomeData } from "@/lib/homeApi";

import FeaturedArtistSection from "@/components/organisms/FeaturedArtistSection";
import TopArtistsSection from "@/components/organisms/TopArtistsSection";
import TrendingSongsSection from "@/components/organisms/MostSearchedSongs";
import BrowseByGenreSection from "@/components/organisms/BrowseByGenreSection";
import BrowseByRegionSection from "@/components/organisms/BrowseByRegionSection";
import BirthdaySection from "@/components/organisms/BirthdaySection";

export const revalidate = 600; // 10 minutes

export default async function HomePage() {
  const data = await getHomeData();

  return (
    <main className="pb-16 pt-16">
      {/* HERO */}
      <section className="mx-4 sm:mx-8 lg:mx-12">
        <FeaturedArtistSection featuredArtist={data.featuredArtist} />
      </section>

      {/* CONTENT */}
      <div className="mt-6 space-y-6">
        <section className="mx-4 sm:mx-8 lg:mx-12">
          <TopArtistsSection topArtists={data.topArtists} />
        </section>

        <section className="mx-4 sm:mx-8 lg:mx-12">
          <BrowseByRegionSection regions={data.regions} />
        </section>

        <section className="mx-4 sm:mx-8 lg:mx-12">
          <TrendingSongsSection songs={data.trendingSongs} />
        </section>

        <section className="mx-4 sm:mx-8 lg:mx-12">
          <BrowseByGenreSection />
        </section>

          <section className="mx-4 sm:mx-8 lg:mx-12">
            <BirthdaySection birthdayArtists={data.birthdayArtists} />
          </section>
      </div>
    </main>
  );
}