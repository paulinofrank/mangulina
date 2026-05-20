// page.tsx  (Page)
"use client";

import { useEffect, useState } from "react";
import { getHomeData } from "@/lib/homeApi";

import FeaturedArtistSection from "@/components/organisms/FeaturedArtistSection";
import TopArtistsSection from "@/components/organisms/TopArtistsSection";
import TrendingSongsSection from "@/components/organisms/TrendingSongsSection";
import BrowseByGenreSection from "@/components/organisms/BrowseByGenreSection";
import BrowseByRegionSection from "@/components/organisms/BrowseByRegionSection";
import BirthdaySection from "@/components/organisms/BirthdaySection";

import type { TopArtist, TrendingSong, RegionCount } from "@/types/home";
import type { Artist } from "@/types/music";

export default function HomePage() {
  const [featuredArtist, setFeaturedArtist] = useState<Artist | null>(null);
  const [trendingSongs, setTrendingSongs] = useState<TrendingSong[]>([]);
  const [topArtists, setTopArtists] = useState<TopArtist[]>([]);
  const [birthdayArtists, setBirthdayArtists] = useState<Artist[]>([]);
  const [regions, setRegions] = useState<RegionCount[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function load() {
      try {
        const data = await getHomeData();

        setFeaturedArtist(data.featuredArtist);
        setBirthdayArtists(data.birthdayArtists);
        setTrendingSongs(data.trendingSongs);
        setTopArtists(data.topArtists);
        setRegions(data.regions);
      } catch (e) {
        console.error("Home load error:", e);
      } finally {
        setLoading(false);
      }
    }

    load();
  }, []);

  if (loading) {
    return (
      <div className="flex min-h-screen items-center justify-center text-xs uppercase text-gray-400">
        Loading...
      </div>
    );
  }

  return (
    <main className="pb-16">
      {/* HERO */}
      <section className="mx-4 sm:mx-8 lg:mx-12">
        <FeaturedArtistSection featuredArtist={featuredArtist} />
      </section>

      {/* CONTENT */}
      <div className="space-y-6 mt-6">
        <section className="mx-4 sm:mx-8 lg:mx-12">
          <TopArtistsSection topArtists={topArtists} />
        </section>

        <section className="mx-4 sm:mx-8 lg:mx-12">
          <TrendingSongsSection songs={trendingSongs} />
        </section>

        <section className="mx-4 sm:mx-8 lg:mx-12">
          <BrowseByRegionSection regions={regions} />
        </section>

        <section className="mx-4 sm:mx-8 lg:mx-12">
          <BrowseByGenreSection />
        </section>

        {birthdayArtists.length > 0 && (
          <section className="mx-4 sm:mx-8 lg:mx-12">
            <BirthdaySection birthdayArtists={birthdayArtists} />
          </section>
        )}
      </div>
    </main>
  );
}