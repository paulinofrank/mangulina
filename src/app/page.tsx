"use client";

import { useEffect, useState } from "react";
import { getSupabaseClient } from "@/lib/supabase";
import type { Artist } from "@/types/music";

import FeaturedArtistSection from "@/components/organisms/FeaturedArtistSection";
import TopArtistsSection from "@/components/organisms/TopArtistsSection";
import TrendingSongsSection from "@/components/organisms/TrendingSongsSection";
import BrowseByGenreSection from "@/components/organisms/BrowseByGenreSection";
import BrowseByRegionSection from "@/components/organisms/BrowseByRegionSection";
import BirthdaySection from "@/components/organisms/BirthdaySection";

interface TrendingSong {
  id: string;
  title: string;
  views: number;
  release?: {
    cover_image_url?: string | null;
  };
  recording_credits: {
    artist?: { // Changed from artist: ... | null to artist?: ...
      name: string;
      image_url?: string | null; // Added ? here
    };
  }[];
}
export default function HomePage() {
  const supabase = getSupabaseClient();

  const [featuredArtist, setFeaturedArtist] = useState<Artist | null>(null);
  // 2. Apply the TrendingSong interface here
  const [trendingSongs, setTrendingSongs] = useState<TrendingSong[]>([]);
  const [topArtists, setTopArtists] = useState<Artist[]>([]);
  const [birthdayArtists, setBirthdayArtists] = useState<Artist[]>([]);
  const [regions, setRegions] = useState<{ name: string; count: number }[]>([]);
  const [loading, setLoading] = useState<boolean>(true);

  useEffect(() => {
    async function load() {
      setLoading(true);

      try {
        // 1. Featured Artist
        const { data: featuredData, error: featError } = await supabase
          .from("featured_artist")
          .select(`id, artists (*)`)
          .eq("id", 1)
          .maybeSingle();

        if (featError) console.error("Featured Fetch Error:", featError.message);

        const featuredRow = featuredData as { artists?: Artist | null } | null | undefined;
        setFeaturedArtist(featuredRow?.artists ?? null);

        // 2. Birthday Artists
        const now = new Date();
        const m = now.getMonth() + 1;
        const d = now.getDate();

        const { data: bdays, error: bdayError } = await supabase.rpc(
          "get_artists_by_day_month",
          { target_month: m, target_day: d }
        );

        if (bdayError) console.error("RPC Error:", bdayError.message);
        setBirthdayArtists((bdays as Artist[]) || []);

        // 3. Trending Songs (Final Join Logic) - Typed to prevent "Property artists does not exist"
        const { data: trending, error: trendError } = await supabase
          .from("recordings")
          .select(`
            id,
            title,
            views,
            release:releases (
              cover_image_url
            ),
            recording_credits (
              artist:artists (
                name,
                image_url
              )
            )
          `)
          .order("views", { ascending: false })
          .limit(10);

        if (trendError) console.error("Trending Error:", trendError.message);

        setTrendingSongs((trending as unknown as TrendingSong[]) || []);

        // 4. Top Artists
        const { data: top } = await supabase
          .from("artists")
          .select("*")
          .order("views", { ascending: false })
          .limit(10);

        setTopArtists((top as Artist[]) || []);

        // 5. Regions
        const { data: regionData } = await supabase
          .from("artists")
          .select("province")
          .not("province", "is", null);

        const counts = (regionData || []).reduce<Record<string, number>>((acc, curr) => {
          const name = curr.province as string | null;
          if (name) acc[name] = (acc[name] || 0) + 1;
          return acc;
        }, {});

        const regionObjects = Object.entries(counts).map(([name, count]) => ({
          name,
          count,
        }));

        setRegions(regionObjects);

      } catch (err) {
        console.error("Data loading failed:", err);
      } finally {
        setLoading(false);
      }
    }

    load();
  }, [supabase]);

  if (loading) {
    return (
      <div className="flex h-screen items-center justify-center text-gray-400">
        <div className="animate-pulse font-medium text-(--color-flagblue)">
          Consulting Mangulina™ records…
        </div>
      </div>
    );
  }

return (
  <main className="space-y-16 p-6 pb-[40vh]">
    <FeaturedArtistSection featuredArtist={featuredArtist} />
    <TopArtistsSection topArtists={topArtists} />
    <TrendingSongsSection songs={trendingSongs} />
    <BrowseByRegionSection regions={regions} />
    <BrowseByGenreSection />

    {/* Only show the section if we have at least one birthday today */}
    {birthdayArtists.length > 0 && (
      <BirthdaySection birthdayArtists={birthdayArtists} />
    )}
  </main>
);
}