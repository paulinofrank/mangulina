"use client";

import { useEffect, useState } from "react";
import { useTranslations } from "next-intl";

import SongsByYearList, { type ArchiveSongRow } from "@/app/[locale]/archive/SongsByYearList";
import { ArchivePagination } from "@/app/[locale]/archive/ArchiveClient";
import type { GenreSubgenre } from "@/lib/genres";

type GenreSongsResponse = {
  ok: boolean;
  songs?: ArchiveSongRow[];
  total?: number;
  error?: string;
};

const PAGE_SIZE = 50;
type SongSort = "title" | "views";

export default function GenreSubgenreSongs({
  genreId,
  genreName,
  subgenre,
}: {
  genreId: number;
  genreName: string;
  subgenre: GenreSubgenre | null;
}) {
  const t = useTranslations();
  const [sortBy, setSortBy] = useState<SongSort>("views");
  const [songs, setSongs] = useState<ArchiveSongRow[]>([]);
  const [total, setTotal] = useState(0);
  const [currentPage, setCurrentPage] = useState(1);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const activeName = subgenre?.name ?? genreName;

  const buildUrl = (offset: number) => {
    const params = new URLSearchParams({
      genreId: String(genreId),
      limit: String(PAGE_SIZE),
      offset: String(offset),
      sort: sortBy,
    });
    if (subgenre) params.set("subgenreId", String(subgenre.id));
    return `/api/genres/subgenre-songs?${params.toString()}`;
  };

  useEffect(() => {
    if (!genreId) return;

    const controller = new AbortController();
    // Reset the previous filter's result before synchronizing with the API.
    // eslint-disable-next-line react-hooks/set-state-in-effect
    setLoading(true);
    setError("");
    setSongs([]);
    setTotal(0);

    fetch(buildUrl((currentPage - 1) * PAGE_SIZE), { signal: controller.signal })
      .then(async (response) => {
        const result = (await response.json()) as GenreSongsResponse;
        if (!response.ok || !result.ok) throw new Error(result.error || response.statusText);
        setSongs(result.songs ?? []);
        setTotal(result.total ?? 0);
      })
      .catch((fetchError: unknown) => {
        if (fetchError instanceof DOMException && fetchError.name === "AbortError") return;
        setError(fetchError instanceof Error ? fetchError.message : t("pages.genreDetail.loadError"));
      })
      .finally(() => {
        if (!controller.signal.aborted) setLoading(false);
      });

    return () => controller.abort();
    // buildUrl is derived entirely from these filter values.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [currentPage, genreId, subgenre?.id, sortBy]);

  const totalPages = Math.ceil(total / PAGE_SIZE);
  const changePage = (page: number) => {
    setCurrentPage(page);
    document.getElementById("genre-songs")?.scrollIntoView({ behavior: "smooth", block: "start" });
  };

  return (
    <section id="genre-songs" className="scroll-mt-20" aria-live="polite">
      <div className="mb-4 flex items-center justify-between gap-3 px-1">
        <h2 className="!mb-0 text-xl font-semibold normal-case tracking-normal text-[#002D62]">
          {t("pages.genreDetail.subgenreSongs", { name: activeName })}
          {!loading && !error ? ` (${total.toLocaleString()})` : ""}
        </h2>
        <select
          value={sortBy}
          onChange={(event) => {
            setCurrentPage(1);
            setSortBy(event.target.value as SongSort);
          }}
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
        <>
          <ArchivePagination
            currentPage={currentPage}
            totalPages={totalPages}
            onPageChange={changePage}
            t={t}
          />
          <SongsByYearList songs={songs} compact />
          <ArchivePagination
            currentPage={currentPage}
            totalPages={totalPages}
            onPageChange={changePage}
            t={t}
          />
        </>
      )}
      {!loading && !error && songs.length === 0 && (
        <div className="rounded-xl border border-black/5 bg-white/70 px-5 py-10 text-center text-gray-500">
          {t("pages.genreDetail.noSongsAssigned", { name: activeName })}
        </div>
      )}
    </section>
  );
}
