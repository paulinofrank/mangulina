"use client";

import { useState, useEffect, useMemo } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import DecadeSelector from "@/app/archive/DecadeSelector";
import SongsByYearList from "@/app/archive/SongsByYearList";

type ArchiveSort = "title" | "views";

type ArchiveSongsResponse = {
  ok: boolean;
  songs?: Parameters<typeof SongsByYearList>[0]["songs"];
  error?: string;
};

function parseYear(value: string | null) {
  if (!value) return null;
  const year = Number(value);
  return Number.isInteger(year) && year >= 1800 && year <= 2100 ? year : null;
}

function parseSort(value: string | null): ArchiveSort {
  return value === "title" ? "title" : "views";
}

export default function ArchiveClient() {
  const router = useRouter();
  const searchParams = useSearchParams();

  const year = parseYear(searchParams.get("year"));
  const sortBy = parseSort(searchParams.get("sort"));
  const [songs, setSongs] = useState<Parameters<typeof SongsByYearList>[0]["songs"]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const updateArchiveParams = (next: { year?: number | null; sort?: ArchiveSort }) => {
    const params = new URLSearchParams(searchParams.toString());

    if ("year" in next) {
      if (next.year) {
        params.set("year", String(next.year));
      } else {
        params.delete("year");
      }
    }

    if ("sort" in next) {
      if (next.sort && next.sort !== "views") {
        params.set("sort", next.sort);
      } else {
        params.delete("sort");
      }
    }

    const query = params.toString();
    router.push(query ? `/archive?${query}` : "/archive", { scroll: false });
  };

  useEffect(() => {
    let cancelled = false;
    setLoading(true);
    setError("");

    const url = year
      ? `/api/archive/songs-by-year?year=${encodeURIComponent(String(year))}`
      : "/api/archive/songs-by-year";

    fetch(url)
      .then(async (response) => {
        const result = (await response.json()) as ArchiveSongsResponse;

        if (!response.ok || !result.ok) {
          throw new Error(result.error || response.statusText);
        }

        if (!cancelled) {
          setSongs(result.songs ?? []);
        }
      })
      .catch((fetchError: unknown) => {
        if (!cancelled) {
          setSongs([]);
          setError(fetchError instanceof Error ? fetchError.message : "Error loading songs.");
        }
      })
      .finally(() => {
        if (!cancelled) {
          setLoading(false);
        }
      });

    return () => {
      cancelled = true;
    };
  }, [year]);

  const sortedSongs = useMemo(() => {
    return [...songs].sort((a, b) => {
      if (sortBy === "title") {
        return a.recording_title.localeCompare(b.recording_title);
      }

      return (b.views ?? 0) - (a.views ?? 0);
    });
  }, [songs, sortBy]);

  return (
    <>
      <section className="mx-4 sm:mx-8 lg:mx-12">
        <DecadeSelector
          selectedYear={year}
          onYearSelect={(nextYear) => updateArchiveParams({ year: nextYear })}
        />
      </section>

      <section className="mx-4 sm:mx-8 lg:mx-12 mt-6">
        <div className="mb-4 flex items-center justify-between gap-3">
          <h2 className="!mb-0 text-left text-xl font-semibold normal-case tracking-normal text-[#002D62]">
            {year
              ? loading
                ? `Recordings from ${year}`
                : `${songs.length.toLocaleString()} recordings from ${year}`
              : "Top 100 songs by views"}
          </h2>

          <select
            value={sortBy}
            onChange={(event) => updateArchiveParams({ sort: event.target.value as ArchiveSort })}
            className="h-8 shrink-0 rounded-lg border border-[#B0C4DE] bg-white px-3 font-sans text-xs font-medium tracking-normal text-[#002D62] outline-none transition hover:border-[#002D62]"
            aria-label="Sort archive songs"
          >
            <option value="title">Sort by Title</option>
            <option value="views">Sort by Views</option>
          </select>
        </div>

        {loading && (
          <p className="text-center text-gray-500">
            Loading songs…
          </p>
        )}

        {!loading && error && (
          <p className="text-center text-gray-500">
            {error}
          </p>
        )}

        {!loading && sortedSongs.length > 0 && (
          <SongsByYearList songs={sortedSongs} />
        )}

        {!loading && !error && sortedSongs.length === 0 && (
          <p className="text-center text-gray-500">
            {year ? `No recordings found for ${year}.` : "No recordings found."}
          </p>
        )}
      </section>
    </>
  );
}
