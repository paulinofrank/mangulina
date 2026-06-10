"use client";

import { useState, useEffect, useRef, useMemo } from "react";
import { useRouter, useSearchParams } from "next/navigation";
import DecadeSelector from "@/app/archive/DecadeSelector";
import SongsByYearList from "@/app/archive/SongsByYearList";

type ArchiveSort = "title" | "views";

type SongRow = Parameters<typeof SongsByYearList>[0]["songs"][number];

type ArchiveSongsResponse = {
  ok: boolean;
  songs?: SongRow[];
  total?: number;
  hasMore?: boolean;
  error?: string;
};

type CacheEntry = {
  songs: SongRow[];
  total: number;
  hasMore: boolean;
};

const ARCHIVE_PAGE_SIZE = 50;
const SCROLL_KEY = "archive:scrollY";

function cacheKey(year: number | null, sort: ArchiveSort) {
  return `archive:songs:${year ?? "top"}:${sort}`;
}

function readCache(key: string): CacheEntry | null {
  try {
    const raw = sessionStorage.getItem(key);
    return raw ? (JSON.parse(raw) as CacheEntry) : null;
  } catch {
    return null;
  }
}

function writeCache(key: string, entry: CacheEntry) {
  try {
    sessionStorage.setItem(key, JSON.stringify(entry));
  } catch {
    // storage full or unavailable — silently skip
  }
}

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

  // Seed state from sessionStorage synchronously so the list renders on first
  // paint and the browser's native scroll restoration finds content to scroll to.
  const initialCache = useMemo(() => readCache(cacheKey(year, sortBy)), [year, sortBy]);

  const [songs, setSongs] = useState<SongRow[]>(initialCache?.songs ?? []);
  const [totalSongs, setTotalSongs] = useState(initialCache?.total ?? 0);
  const [hasMoreSongs, setHasMoreSongs] = useState(initialCache?.hasMore ?? false);
  const [loading, setLoading] = useState(!initialCache);
  const [loadingMore, setLoadingMore] = useState(false);
  const [error, setError] = useState("");

  // After restoring from cache, scroll to saved position.
  const scrollRestored = useRef(false);
  useEffect(() => {
    if (initialCache && !scrollRestored.current) {
      scrollRestored.current = true;
      try {
        const saved = sessionStorage.getItem(SCROLL_KEY);
        if (saved) {
          const y = Number(saved);
          // Small delay lets the browser finish layout before we force scroll.
          setTimeout(() => window.scrollTo({ top: y, behavior: "instant" }), 0);
        }
      } catch {
        // ignore
      }
    }
  }, [initialCache]);

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

    // If we already seeded from cache, skip the fetch (data is fresh enough
    // for this session). The cache gets replaced when the user actively changes
    // year/sort, because initialCache will be null for that new key.
    if (initialCache) return;

    setLoading(true);
    setError("");
    setHasMoreSongs(false);

    const url = year
      ? `/api/archive/songs-by-year?year=${encodeURIComponent(String(year))}&limit=${ARCHIVE_PAGE_SIZE}&offset=0&sort=${encodeURIComponent(sortBy)}`
      : "/api/archive/songs-by-year";

    fetch(url)
      .then(async (response) => {
        const result = (await response.json()) as ArchiveSongsResponse;

        if (!response.ok || !result.ok) {
          throw new Error(result.error || response.statusText);
        }

        if (!cancelled) {
          const fetched = result.songs ?? [];
          const total = result.total ?? fetched.length;
          const hasMore = Boolean(result.hasMore);
          setSongs(fetched);
          setTotalSongs(total);
          setHasMoreSongs(hasMore);
          writeCache(cacheKey(year, sortBy), { songs: fetched, total, hasMore });
        }
      })
      .catch((fetchError: unknown) => {
        if (!cancelled) {
          setSongs([]);
          setTotalSongs(0);
          setHasMoreSongs(false);
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
  // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [year, sortBy]);

  // Save scroll position whenever the user leaves the page (navigates to a song).
  useEffect(() => {
    const saveScroll = () => {
      try {
        sessionStorage.setItem(SCROLL_KEY, String(window.scrollY));
      } catch {
        // ignore
      }
    };

    // pagehide fires on all browsers when navigating away (including Next.js soft-nav).
    window.addEventListener("pagehide", saveScroll);
    // visibilitychange catches tab switches / fast navigation on mobile.
    document.addEventListener("visibilitychange", saveScroll);

    return () => {
      window.removeEventListener("pagehide", saveScroll);
      document.removeEventListener("visibilitychange", saveScroll);
    };
  }, []);

  const loadMoreSongs = async () => {
    if (!year || loadingMore || !hasMoreSongs) return;

    setLoadingMore(true);
    setError("");

    try {
      const response = await fetch(
        `/api/archive/songs-by-year?year=${encodeURIComponent(String(year))}&limit=${ARCHIVE_PAGE_SIZE}&offset=${songs.length}&sort=${encodeURIComponent(sortBy)}`,
      );
      const result = (await response.json()) as ArchiveSongsResponse;

      if (!response.ok || !result.ok) {
        throw new Error(result.error || response.statusText);
      }

      const newSongs = [...songs, ...(result.songs ?? [])];
      const newTotal = result.total ?? totalSongs;
      const newHasMore = Boolean(result.hasMore);
      setSongs(newSongs);
      setTotalSongs(newTotal);
      setHasMoreSongs(newHasMore);
      writeCache(cacheKey(year, sortBy), { songs: newSongs, total: newTotal, hasMore: newHasMore });
    } catch (fetchError: unknown) {
      setError(fetchError instanceof Error ? fetchError.message : "Error loading more songs.");
    } finally {
      setLoadingMore(false);
    }
  };

  const sortedSongs = useMemo(() => {
    if (year) return songs;

    return [...songs].sort((a, b) => {
      if (sortBy === "title") {
        return a.recording_title.localeCompare(b.recording_title);
      }

      return (b.views ?? 0) - (a.views ?? 0);
    });
  }, [songs, sortBy, year]);

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
                : `${totalSongs.toLocaleString()} recordings from ${year}`
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
          <SongsByYearList
            songs={sortedSongs}
            hasMore={Boolean(year && hasMoreSongs)}
            loadingMore={loadingMore}
            onShowMore={loadMoreSongs}
          />
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
