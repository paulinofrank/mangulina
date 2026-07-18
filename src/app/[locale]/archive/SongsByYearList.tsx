// SongsByYearList.tsx
"use client";

import { Link } from "@/i18n/navigation";
import { useTranslations } from "next-intl";
import { getPublicReleaseCoverUrl } from "@/lib/releaseCover";

export type ArchiveSongRow = {
  recording_id: string;
  recording_slug?: string | null;
  recording_title: string;
  release_id?: string | null;
  has_cover_image?: boolean | null;
  artist_name: string | null;
  duration: number | null;
  genre_name?: string | null;
  subgenre_name?: string | null;
  genre?: string | null;
  subgenre?: string | null;
  views?: number | null;
};

export default function SongsByYearList({
  songs,
  hasMore = false,
  loadingMore = false,
  onShowMore,
  compact = false,
}: {
  songs: ArchiveSongRow[];
  hasMore?: boolean;
  loadingMore?: boolean;
  onShowMore?: () => void;
  compact?: boolean;
}) {
  const t = useTranslations("table");
  const tCommon = useTranslations("common");

  return (
    <div className="mt-4 rounded-xl border border-black/5 bg-white/70 p-2.5 md:mt-8 md:p-4">
      {/* Header */}
      <div className="hidden grid-cols-[3rem_minmax(0,1.5fr)_minmax(0,1fr)_minmax(0,1fr)_5rem_6rem] gap-3 border-b pb-2 text-xs font-semibold uppercase tracking-wider text-gray-500 md:grid">
        <span aria-hidden="true" />
        <span>{t("headers.song")}</span>
        <span>{t("headers.artist")}</span>
        <span>{t("headers.genre")}</span>
        <span className="text-right">{t("headers.duration")}</span>
        <span className="text-right">{t("headers.views")}</span>
      </div>

      {/* Rows */}
      {songs.map((song) => {
        const genreText = [song.genre_name ?? song.genre, song.subgenre_name ?? song.subgenre]
          .filter(Boolean)
          .join(" / ");
        const href = `/songs/${song.recording_slug ?? song.recording_id}`;
        const coverUrl = song.release_id && song.has_cover_image
          ? getPublicReleaseCoverUrl(song.release_id, 150)
          : "/images/placeholder-song.jpg";
        const viewsText = formatViews(song.views);

        return (
          <Link
            key={song.recording_id}
            href={href}
            className={`grid grid-cols-[2rem_minmax(0,1fr)_minmax(6.75rem,auto)] gap-x-2.5 gap-y-0.5 border-b text-sm text-[#002D62] transition hover:bg-[#002D62]/5 last:border-none md:grid-cols-[3rem_minmax(0,1.5fr)_minmax(0,1fr)_minmax(0,1fr)_5rem_6rem] md:items-center md:gap-3 ${compact ? "py-[3px] md:py-[3px]" : "py-2 md:py-2"}`}
          >
            <span className="col-start-1 row-span-2 row-start-1 flex h-full items-center md:row-span-1">
              <span className="relative block h-8 w-8 overflow-hidden rounded-md border border-black/5 bg-gray-100 md:h-10 md:w-10">
                <img
                  src={coverUrl}
                  alt=""
                  className="h-full w-full object-cover"
                  loading="lazy"
                  onError={(event) => {
                    event.currentTarget.src = "/images/placeholder-song.jpg";
                  }}
                />
              </span>
            </span>

            <span className="col-start-2 row-start-1 truncate font-semibold md:col-start-2 md:row-start-auto">
              {song.recording_title}
            </span>

            <span className="col-start-2 row-start-2 truncate font-normal text-[#002D62] md:col-start-3 md:row-start-auto">
              {song.artist_name ?? "Unknown Artist"}
            </span>

            <span className="col-start-3 row-start-1 truncate text-right text-xs font-normal text-[#002D62]/70 md:col-start-4 md:row-start-auto md:text-left md:text-sm">
              {genreText || "Uncategorized"}
            </span>

            <span className="col-start-3 row-start-2 text-right text-xs font-normal text-[#002D62]/70 md:col-start-5 md:row-start-auto md:text-sm">
              <span className="md:hidden">
                {viewsText} {tCommon("views")}
              </span>
              <span className="hidden md:inline">
                {song.duration ? formatDuration(song.duration) : "--:--"}
              </span>
            </span>

            <span className="hidden text-sm font-normal text-right text-[#002D62]/70 md:col-start-6 md:block">
              {viewsText}
            </span>
          </Link>
        );
      })}

      {hasMore && (
        <button
          type="button"
          onClick={onShowMore}
          disabled={loadingMore}
          className="block w-full py-3 text-center text-sm font-semibold uppercase tracking-wider text-[#8B0000] transition hover:bg-[#8B0000]/5 hover:text-[#6B0000] disabled:cursor-wait disabled:text-[#8B0000]/50"
        >
          {loadingMore ? "Loading more..." : "Show more..."}
        </button>
      )}
    </div>
  );
}

function formatViews(views?: number | null) {
  if (views == null) return "0";
  return views.toLocaleString();
}

function formatDuration(ms: number) {
  if (!ms || ms <= 0) return "--:--";

  const totalSeconds = Math.floor(ms / 1000);
  const minutes = Math.floor(totalSeconds / 60);
  const seconds = totalSeconds % 60;

  return `${minutes}:${seconds.toString().padStart(2, "0")}`;
}
