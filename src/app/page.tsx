"use client";

import { useEffect, useState } from "react";
import { getSupabaseClient } from "@/lib/supabase";

import FeaturedArtistSection from "@/components/organisms/FeaturedArtistSection";
import TopArtistsSection from "@/components/organisms/TopArtistsSection";
import TrendingSongsSection from "@/components/organisms/TrendingSongsSection";
import BrowseByGenreSection from "@/components/organisms/BrowseByGenreSection";
import BrowseByRegionSection from "@/components/organisms/BrowseByRegionSection";

import type { Artist } from "@/types/Artist";

export default function HomePage() {
  const supabase = getSupabaseClient();

  const [featuredArtist, setFeaturedArtist] = useState<any>(null);
  const [trendingSongs, setTrendingSongs] = useState<any[]>([]);
  const [topArtists, setTopArtists] = useState<any[]>([]);
  const [regions, setRegions] = useState<any[]>([]); // Changed to any[] to hold objects
  const [loading, setLoading] = useState<boolean>(true);

  useEffect(() => {
    async function load() {
      setLoading(true);

      try {
        // 1. Fetch Featured Artist
        const { data: featuredData } = await supabase
          .from("featured_artist")
          .select(`artists (*)`)
          .maybeSingle();

        // 2. Trending Songs
        const { data: trending, error: trendError } = await supabase
          .from("recordings")
          .select(`
            id,
            title,
            views,
            release:releases!recordings_release_id_fkey (
              id,
              cover_image_url
            ),
            artist:artists!recordings_artist_id_fkey (
              id,
              name
            )
          `)
          .order("views", { ascending: false })
          .limit(10);

        if (trendError) console.error("Trending Error:", trendError.message);

        // 3. Top Artists
        const { data: top } = await supabase
          .from("artists")
          .select("*")
          .order("views", { ascending: false })
          .limit(10);

        // 4. Regions Logic with Counts
        const { data: regionData } = await supabase
          .from("artists")
          .select("origin_region")
          .not("origin_region", "is", null);

        // Transform flat strings into { name, count } objects
        const counts = (regionData || []).reduce((acc: any, curr: any) => {
          const name = curr.origin_region;
          if (name) acc[name] = (acc[name] || 0) + 1;
          return acc;
        }, {});

        const regionObjects = Object.entries(counts).map(([name, count]) => ({
          name,
          count
        }));

        // Update States
        setFeaturedArtist((featuredData as any)?.artists || null);
        setTrendingSongs(trending || []);
        setTopArtists(top || []);
        setRegions(regionObjects); // Now passing objects!
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
        <div className="animate-pulse font-medium">Loading Mangulina&trade;…</div>
      </div>
    );
  }

return (
    <main className="space-y-16 p-6 pb-[40vh]"> {/* Added pb-[40vh] */}
      <FeaturedArtistSection featuredArtist={featuredArtist} />
      <TopArtistsSection topArtists={topArtists} />
      <TrendingSongsSection songs={trendingSongs} />
      <BrowseByRegionSection regions={regions} />
      <BrowseByGenreSection />
       </main>
  );
}