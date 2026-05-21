"use client";

import { useState, useEffect } from "react";
import DecadeSelector from "@/app/archive/DecadeSelector";
import SongsByYearList from "@/app/archive/SongsByYearList";
import { getSongsByYear } from "@/lib/getSongsByYear";

export default function ArchiveClient() {
  const [year, setYear] = useState<number | null>(null);
  const [songs, setSongs] = useState<any[]>([]);
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    if (!year) return;

    setLoading(true);

    getSongsByYear(year)
      .then((data) => setSongs(data))
      .finally(() => setLoading(false));
  }, [year]);

  return (
    <>
      <section className="mx-4 sm:mx-8 lg:mx-12">
        <DecadeSelector onYearSelect={setYear} />
      </section>

      {year && (
        <section className="mx-4 sm:mx-8 lg:mx-12 mt-6">
          <h2 className="text-xl font-semibold text-[#002D62] mb-4">
            Recordings from {year}
          </h2>

          {loading && (
            <p className="text-center text-gray-500">
              Loading songs…
            </p>
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
    </>
  );
}