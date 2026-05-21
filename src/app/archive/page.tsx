// src/app/archive/page.tsx
"use client";

import { useState, useEffect } from "react";
import { getHomeData } from "@/lib/homeApi";
import DecadeSelector from "@/components/DecadeSelector";
import SongsByYearList from "@/components/SongsByYearList";
import TrendingSongsSection from "@/components/organisms/TrendingSongsSection";
import { getSongsByYear } from "@/lib/getSongsByYear";
import { Suspense } from "react";

export default function ArchivePage() {
  const [year, setYear] = useState<number | null>(null);
  const [songs, setSongs] = useState<any[]>([]);
  const [loading, setLoading] = useState(false);
  const [homeData, setHomeData] = useState<any>(null);

  // Load trending songs (server → client bridge)
  useEffect(() => {
    getHomeData().then(setHomeData);
  }, []);

  // Load songs by year
  useEffect(() => {
    if (!year) return;

    setLoading(true);

    getSongsByYear(year)
      .then((data) => setSongs(data))
      .finally(() => setLoading(false));
  }, [year]);

  return (
    <main className="pb-16 pt-16">
      <div className="mt-6 space-y-6">

        {/* ⭐ TRENDING SONGS */}
        {homeData && (
          <section className="mx-4 sm:mx-8 lg:mx-12">
            <TrendingSongsSection songs={homeData.trendingSongs} />
          </section>
        )}

        {/* ⭐ DECADE SELECTOR */}
        <section className="mx-4 sm:mx-8 lg:mx-12">
          <DecadeSelector onYearSelect={setYear} />
        </section>

        {/* ⭐ YEAR RESULTS */}
        {year && (
          <section className="mx-4 sm:mx-8 lg:mx-12 mt-6">
            <h2 className="text-xl font-semibold text-[#002D62] mb-4">
              Recordings from {year}
            </h2>

            {loading && (
              <p className="text-center text-gray-500">Loading songs…</p>
            )}

            {!loading && songs.length > 0 && (
              <SongsByYearList songs={songs} />
            )}

            {!loading && songs.length === 0 && (
              <p className="text-center text-gray-500">
                No recordings found for {year}.
              </p>
            )}
          </section>
        )}
      </div>
    </main>
  );
}
