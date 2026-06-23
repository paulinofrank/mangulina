"use client";

import { useEffect, useState } from "react";
import { useTranslations } from "next-intl";

import SongsByYearList, { type ArchiveSongRow } from "@/app/[locale]/archive/SongsByYearList";
import SectionCard from "@/components/layout/SectionCard";
import type { GenreSubgenre } from "@/lib/genres";

type SubgenreSongsResponse = {
  ok: boolean;
  songs?: ArchiveSongRow[];
  total?: number;
  hasMore?: boolean;
  subgenreName?: string;
  error?: string;
};

const PAGE_SIZE = 25;
type SongSort = "title" | "views";

export default function GenreSubgenreSongs({
  genreId,
  subgenres,
}: {
  genreId: number;
  subgenres: GenreSubgenre[];
}) {
  const t = useTranslations();
  const [selectedId, setSelectedId] = useState(subgenres[0]?.id ?? 0);
  const [sortBy, setSortBy] = useState<SongSort>("views");
  const [songs, setSongs] = useState<ArchiveSongRow[]>([]);
  const [total, setTotal] = useState(0);
  const [hasMore, setHasMore] = useState(false);
  const [loading, setLoading] = useState(true);
  const [loadingMore, setLoadingMore] = useState(false);
  const [error, setError] = useState("");

  const selectedSubgenre = subgenres.find((subgenre) => subgenre.id === selectedId);

  useEffect(() => {
    if (!selectedId) return;

    const controller = new AbortController();
    setLoading(true);
    setError("");
    setSongs([]);
    setTotal(0);
    setHasMore(false);

    fetch(
      `/api/genres/subgenre-songs?genreId=${genreId}&subgenreId=${selectedId}&limit=${PAGE_SIZE}&offset=0&sort=${sortBy}`,
      { signal: controller.signal },
    )
      .then(async (response) => {
        const result = (await response.json()) as SubgenreSongsResponse;
        if (!response.ok || !result.ok) throw new Error(result.error || response.statusText);

        setSongs(result.songs ?? []);
        setTotal(result.total ?? 0);
        setHasMore(Boolean(result.hasMore));
      })
      .catch((fetchError: unknown) => {
        if (fetchError instanceof DOMException && fetchError.name === "AbortError") return;
        setError(fetchError instanceof Error ? fetchError.message : t("pages.genreDetail.loadError"));
      })
      .finally(() => {
        if (!controller.signal.aborted) setLoading(false);
      });

    return () => controller.abort();
  }, [genreId, selectedId, sortBy]);

  const loadMore = async () => {
    if (!selectedId || loadingMore || !hasMore) return;

    setLoadingMore(true);
    setError("");

    try {
      const response = await fetch(
        `/api/genres/subgenre-songs?genreId=${genreId}&subgenreId=${selectedId}&limit=${PAGE_SIZE}&offset=${songs.length}&sort=${sortBy}`,
      );
      const result = (await response.json()) as SubgenreSongsResponse;
      if (!response.ok || !result.ok) throw new Error(result.error || response.statusText);

      setSongs((current) => [...current, ...(result.songs ?? [])]);
      setTotal(result.total ?? total);
      setHasMore(Boolean(result.hasMore));
    } catch (fetchError: unknown) {
      setError(fetchError instanceof Error ? fetchError.message : t("pages.genreDetail.loadMoreError"));
    } finally {
      setLoadingMore(false);
    }
  };

  return (
    <>
      <SectionCard>
        <div className="section-inner">
          <div className="section-header">
            <h2>{t("pages.genreDetail.subgenresStyles")}</h2>
          </div>
          <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-3">
            {subgenres.map((subgenre) => {
              const selected = subgenre.id === selectedId;

              return (
                <button
                  key={subgenre.id}
                  type="button"
                  onClick={() => setSelectedId(subgenre.id)}
                  aria-pressed={selected}
                  className={`rounded-lg border px-4 py-3 text-left transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[#002D62] focus-visible:ring-offset-2 ${
                    selected
                      ? "border-[#002D62] bg-[#002D62] text-white"
                      : "border-black/5 bg-white hover:border-[#002D62]/30 hover:bg-[#002D62]/5"
                  }`}
                >
                  <h3 className={`text-sm font-semibold ${selected ? "text-white" : "text-[#002D62]"}`}>
                    {subgenre.name}
                  </h3>
                  {subgenre.description && (
                    <p className={`mt-1 text-sm leading-relaxed ${selected ? "text-white/80" : "text-gray-600"}`}>
                      {subgenre.description}
                    </p>
                  )}
                </button>
              );
            })}
          </div>
        </div>
      </SectionCard>

      <section aria-live="polite">
        <div className="mb-4 flex items-center justify-between gap-3 px-1">
          <h2 className="!mb-0 text-xl font-semibold normal-case tracking-normal text-[#002D62]">
            {t("pages.genreDetail.subgenreSongs", {
              name: selectedSubgenre?.name ?? t("pages.genreDetail.subgenreFallback"),
            })}
            {!loading && !error ? ` (${total.toLocaleString()})` : ""}
          </h2>
          <select
            value={sortBy}
            onChange={(event) => setSortBy(event.target.value as SongSort)}
            className="h-8 shrink-0 rounded-lg border border-[#B0C4DE] bg-white px-3 font-sans text-xs font-medium tracking-normal text-[#002D62] outline-none transition hover:border-[#002D62]"
            aria-label={t("pages.genreDetail.sortAria")}
          >
            <option value="title">{t("archive.ui.sortByTitle")}</option>
            <option value="views">{t("archive.ui.sortByViews")}</option>
          </select>
        </div>

        {loading && <p className="py-8 text-center text-gray-500">{t("archive.ui.loadingSongs")}</p>}
        {!loading && error && <p className="py-8 text-center text-gray-500">{error}</p>}
        {!loading && !error && songs.length > 0 && (
          <SongsByYearList
            songs={songs}
            hasMore={hasMore}
            loadingMore={loadingMore}
            onShowMore={loadMore}
          />
        )}
        {!loading && !error && songs.length === 0 && (
          <div className="rounded-xl border border-black/5 bg-white/70 px-5 py-10 text-center text-gray-500">
            {t("pages.genreDetail.noSongsAssigned", {
              name: selectedSubgenre?.name ?? t("pages.genreDetail.subgenreFallback"),
            })}
          </div>
        )}
      </section>
    </>
  );
}
