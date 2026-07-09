"use client";

import { useState, useEffect, useRef, useMemo } from "react";
import { useSearchParams } from "next/navigation";
import { useTranslations } from "next-intl";
import { useRouter } from "@/i18n/navigation";
import DecadeSelector from "@/app/[locale]/archive/DecadeSelector";
import SongsByYearList from "@/app/[locale]/archive/SongsByYearList";
import type { ArchivePeriod } from "@/lib/archivePeriods";
import {
  ARCHIVE_PAGE_SIZE,
  getArchiveCacheKey,
  getArchiveListingPeriod,
  type ArchiveSort,
} from "@/lib/archiveShared";

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

export type ArchiveInitialData = CacheEntry & {
  cacheKey: string;
};

const SCROLL_KEY = "archive:scrollY";

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

function parseSort(value: string | null): ArchiveSort {
  return value === "title" ? "title" : "views";
}

function parsePage(value: string | null) {
  const page = Number(value);
  return Number.isInteger(page) && page > 0 ? page : 1;
}

function buildArchiveUrl(period: ArchivePeriod | null, sortBy: ArchiveSort, page = 1) {
  const basePath = period ? `/archive/${period.slug}` : "/archive";
  const params = new URLSearchParams();

  if (sortBy === "title") params.set("sort", "title");
  if (page > 1) params.set("page", String(page));

  const query = params.toString();
  return query ? `${basePath}?${query}` : basePath;
}

function buildFetchUrl(period: ArchivePeriod | null, sortBy: ArchiveSort, page: number) {
  const params = new URLSearchParams({
    limit: String(ARCHIVE_PAGE_SIZE),
    offset: String((page - 1) * ARCHIVE_PAGE_SIZE),
    sort: sortBy,
  });

  if (!period) {
    return `/api/archive/songs-by-year?${params.toString()}`;
  }

  if (period.type === "year") {
    params.set("year", String(period.year));
  } else {
    params.set("startYear", String(period.startYear));
    params.set("endYear", String(period.endYear));
  }

  return `/api/archive/songs-by-year?${params.toString()}`;
}

function getRangeLabel({
  loading,
  totalSongs,
  currentPage,
  period,
  t,
}: {
  loading: boolean;
  totalSongs: number;
  currentPage: number;
  period: ArchivePeriod | null;
  t: ReturnType<typeof useTranslations>;
}) {
  if (loading) return t("archive.ui.loadingSongs");
  if (totalSongs === 0) return t("archive.ui.noSongs");

  const start = (currentPage - 1) * ARCHIVE_PAGE_SIZE + 1;
  const end = Math.min(currentPage * ARCHIVE_PAGE_SIZE, totalSongs);

  return t("archive.ui.showingRange", {
    start: start.toLocaleString(),
    end: end.toLocaleString(),
    total: totalSongs.toLocaleString(),
  });
}

function ArchivePagination({
  currentPage,
  totalPages,
  onPageChange,
  t,
}: {
  currentPage: number;
  totalPages: number;
  onPageChange: (page: number) => void;
  t: ReturnType<typeof useTranslations>;
}) {
  if (totalPages <= 1) return null;

  const mobileWindowSize = Math.min(totalPages, 3);
  const mobileWindowStart =
    currentPage <= 3
      ? 1
      : Math.min(currentPage - 1, totalPages - mobileWindowSize + 1);
  const mobilePages = Array.from({ length: mobileWindowSize }).map(
    (_, index) => mobileWindowStart + index,
  );
  const desktopWindowSize = Math.min(totalPages, 5);
  const desktopWindowStart = Math.min(
    Math.max(currentPage - 2, 1),
    totalPages - desktopWindowSize + 1,
  );
  const desktopPages = Array.from({ length: desktopWindowSize }).map(
    (_, index) => desktopWindowStart + index,
  );
  const showMobileLeadingEllipsis = mobilePages[0] > 1;
  const showMobileTrailingEllipsis = mobilePages[mobilePages.length - 1] < totalPages;

  return (
    <section className="my-3 flex flex-wrap items-center justify-center gap-2 sm:my-7">
      <button
        onClick={() => onPageChange(1)}
        disabled={currentPage === 1}
        className="flex cursor-pointer px-1 text-sm text-gray-500 underline-offset-4 transition hover:text-(--color-flagblue) hover:underline disabled:cursor-default disabled:opacity-30 sm:hidden"
      >
        {t("pagination.first")}
      </button>

      <button
        onClick={() => onPageChange(currentPage - 1)}
        disabled={currentPage === 1}
        className="flex cursor-pointer px-1 text-sm text-gray-500 underline-offset-4 transition hover:text-(--color-flagblue) hover:underline disabled:cursor-default disabled:opacity-30 sm:hidden"
      >
        {t("pagination.previous")}
      </button>

      <div className="flex flex-1 items-center justify-center gap-2 sm:hidden">
        {showMobileLeadingEllipsis && (
          <span className="px-1 text-sm text-gray-400" aria-hidden="true">
            ...
          </span>
        )}

        {mobilePages.map((page) => (
          <button
            key={page}
            onClick={() => onPageChange(page)}
            className={`cursor-pointer text-sm underline-offset-4 transition hover:underline
              ${
                currentPage === page
                  ? "font-semibold text-(--color-flagblue)"
                  : "text-gray-500 hover:text-(--color-flagblue)"
              }`}
          >
            {page}
          </button>
        ))}

        {showMobileTrailingEllipsis && (
          <span className="px-1 text-sm text-gray-400" aria-hidden="true">
            ...
          </span>
        )}
      </div>

      <button
        onClick={() => onPageChange(currentPage + 1)}
        disabled={currentPage === totalPages}
        className="flex cursor-pointer px-1 text-sm text-gray-500 underline-offset-4 transition hover:text-(--color-flagblue) hover:underline disabled:cursor-default disabled:opacity-30 sm:hidden"
      >
        {t("pagination.next")}
      </button>

      <button
        onClick={() => onPageChange(totalPages)}
        disabled={currentPage === totalPages}
        className="flex cursor-pointer px-1 text-sm text-gray-500 underline-offset-4 transition hover:text-(--color-flagblue) hover:underline disabled:cursor-default disabled:opacity-30 sm:hidden"
      >
        {t("pagination.last")}
      </button>

      <button
        onClick={() => onPageChange(1)}
        disabled={currentPage === 1}
        className="hidden cursor-pointer rounded-xl border border-black/10 bg-white px-4 py-2 text-sm text-gray-600 transition hover:bg-black hover:text-white disabled:cursor-default disabled:opacity-30 sm:block"
      >
        {t("pagination.first")}
      </button>

      <button
        onClick={() => onPageChange(currentPage - 1)}
        disabled={currentPage === 1}
        className="hidden cursor-pointer rounded-xl border border-black/10 bg-white px-4 py-2 text-sm text-gray-600 transition hover:bg-black hover:text-white disabled:cursor-default disabled:opacity-30 sm:block"
      >
        {t("pagination.previous")}
      </button>

      {desktopPages.map((page) => (
        <button
          key={page}
          onClick={() => onPageChange(page)}
          className={`hidden h-10 w-10 cursor-pointer rounded-full border text-sm transition sm:block
            ${
              currentPage === page
                ? "bg-(--color-flagblue) text-white border-(--color-flagblue)"
                : "border-black/10 bg-white text-gray-600 hover:bg-gray-100"
            }`}
        >
          {page}
        </button>
      ))}

      <button
        onClick={() => onPageChange(currentPage + 1)}
        disabled={currentPage === totalPages}
        className="hidden cursor-pointer rounded-xl border border-black/10 bg-white px-4 py-2 text-sm text-gray-600 transition hover:bg-black hover:text-white disabled:cursor-default disabled:opacity-30 sm:block"
      >
        {t("pagination.next")}
      </button>

      <button
        onClick={() => onPageChange(totalPages)}
        disabled={currentPage === totalPages}
        className="hidden cursor-pointer rounded-xl border border-black/10 bg-white px-4 py-2 text-sm text-gray-600 transition hover:bg-black hover:text-white disabled:cursor-default disabled:opacity-30 sm:block"
      >
        {t("pagination.last")}
      </button>
    </section>
  );
}

function getPeriodHeading(period: ArchivePeriod | null, t: ReturnType<typeof useTranslations>) {
  if (!period) return t("archive.ui.allHeading");
  if (period.type === "year") return t("archive.ui.yearHeading", { year: period.year });
  return t("archive.ui.decadeHeading", { decade: period.decade });
}

export default function ArchiveClient({
  period = null,
  initialData,
}: {
  period?: ArchivePeriod | null;
  initialData?: ArchiveInitialData;
}) {
  const t = useTranslations();
  const router = useRouter();
  const searchParams = useSearchParams();

  const sortBy = parseSort(searchParams.get("sort"));
  const currentPage = parsePage(searchParams.get("page"));
  const listingPeriod = useMemo(() => getArchiveListingPeriod(period), [period]);

  const [songs, setSongs] = useState<SongRow[]>(initialData?.songs ?? []);
  const [totalSongs, setTotalSongs] = useState(initialData?.total ?? 0);
  const [loading, setLoading] = useState(!initialData);
  const [error, setError] = useState("");
  const scrollRestored = useRef(false);

  const updateSort = (nextSort: ArchiveSort) => {
    router.push(buildArchiveUrl(period, nextSort), { scroll: false });
  };

  const updatePage = (nextPage: number) => {
    const page = Math.max(1, nextPage);
    router.push(buildArchiveUrl(period, sortBy, page), { scroll: true });
  };

  useEffect(() => {
    let cancelled = false;
    const requestCacheKey = getArchiveCacheKey(listingPeriod, sortBy, currentPage);
    if (initialData?.cacheKey === requestCacheKey) {
      setSongs(initialData.songs);
      setTotalSongs(initialData.total);
      setError("");
      setLoading(false);
      writeCache(requestCacheKey, initialData);
      return;
    }

    const cached = readCache(requestCacheKey);

    if (cached) {
      setSongs(cached.songs);
      setTotalSongs(cached.total);
      setError("");
      setLoading(false);

      if (!scrollRestored.current) {
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

      return;
    }

    setSongs([]);
    setTotalSongs(0);
    setLoading(true);
    setError("");

    const url = buildFetchUrl(listingPeriod, sortBy, currentPage);

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
          writeCache(requestCacheKey, { songs: fetched, total, hasMore });
        }
      })
      .catch((fetchError: unknown) => {
        if (!cancelled) {
          setSongs([]);
          setTotalSongs(0);
          setError(fetchError instanceof Error ? fetchError.message : t("archive.ui.loadError"));
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
  }, [listingPeriod, sortBy, currentPage, initialData]);

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

  const sortedSongs = useMemo(() => {
    if (listingPeriod) return songs;

    return [...songs].sort((a, b) => {
      if (sortBy === "title") {
        return a.recording_title.localeCompare(b.recording_title);
      }

      return (b.views ?? 0) - (a.views ?? 0);
    });
  }, [songs, sortBy, listingPeriod]);
  const totalPages = Math.ceil(totalSongs / ARCHIVE_PAGE_SIZE);

  return (
    <>
      {period && (
        <section className="mx-4 sm:mx-8 lg:mx-12">
          <DecadeSelector
            mode="years"
            selectedDecade={period.type === "decade" ? period.decade : undefined}
            selectedYear={listingPeriod?.type === "year" ? listingPeriod.year : null}
            selectedYearCount={listingPeriod?.type === "year" && !loading ? totalSongs : undefined}
          />
        </section>
      )}

      <section className="mx-4 sm:mx-8 lg:mx-12 mt-6">
        <h1 className="mb-4 text-left text-2xl font-semibold normal-case tracking-normal text-[#002D62]">
          {getPeriodHeading(period, t)}
        </h1>

        {!period && (
          <p className="mb-4 max-w-3xl text-sm leading-relaxed text-gray-600 sm:text-base">
            {t("archive.ui.allIntro")}
          </p>
        )}

        <div className="mb-4 flex items-center justify-between gap-3">
          <h2 className="!mb-0 text-left text-xl font-semibold normal-case tracking-normal text-[#002D62]">
            {period
              ? getRangeLabel({
                  loading,
                  totalSongs,
                  currentPage,
                  period: listingPeriod,
                  t,
                })
              : t("archive.ui.topSongs")}
          </h2>

          <select
            value={sortBy}
            onChange={(event) => updateSort(event.target.value as ArchiveSort)}
            className="h-8 shrink-0 rounded-lg border border-[#B0C4DE] bg-white px-3 font-sans text-xs font-medium tracking-normal text-[#002D62] outline-none transition hover:border-[#002D62]"
            aria-label={t("archive.ui.sortAria")}
          >
            <option value="title">{t("archive.ui.sortByTitle")}</option>
            <option value="views">{t("archive.ui.sortByViews")}</option>
          </select>
        </div>

        {loading && (
          <p className="text-center text-gray-500">
            {t("archive.ui.loadingMore")}
          </p>
        )}

        {!loading && error && (
          <p className="text-center text-gray-500">
            {error}
          </p>
        )}

        {!loading && sortedSongs.length > 0 && (
          <>
            <ArchivePagination
              currentPage={currentPage}
              totalPages={totalPages}
              onPageChange={updatePage}
              t={t}
            />
            <SongsByYearList songs={sortedSongs} />
            <ArchivePagination
              currentPage={currentPage}
              totalPages={totalPages}
              onPageChange={updatePage}
              t={t}
            />
          </>
        )}

        {!loading && !error && sortedSongs.length === 0 && (
          <p className="text-center text-gray-500">
            {period
              ? t("archive.ui.noRecordingsFor", {
                  period: period.type === "year" ? period.year : period.decade,
                })
              : t("archive.ui.noRecordings")}
          </p>
        )}
      </section>
    </>
  );
}
