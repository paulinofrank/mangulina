// SongsByYearList.tsx
"use client";

import Link from "next/link";

type SongRow = {
  recording_id: string;
  recording_slug?: string | null;
  recording_title: string;
  artist_name: string | null;
  duration: number | null;
  genre_name?: string | null;
  subgenre_name?: string | null;
  genre?: string | null;
  subgenre?: string | null;
};

export default function SongsByYearList({ songs }: { songs: SongRow[] }) {
  return (
    <div className="mt-8 rounded-xl border border-black/5 bg-white/70 p-4">
      {/* Header */}
      <div className="hidden grid-cols-[minmax(0,1.5fr)_minmax(0,1fr)_minmax(0,1fr)_5rem] gap-3 border-b pb-2 text-xs font-semibold uppercase tracking-wider text-gray-500 md:grid">
        <span>Song</span>
        <span>Artist</span>
        <span>Genre</span>
        <span className="text-right">Duration</span>
      </div>

      {/* Rows */}
      {songs.map((song) => {
        const genreText = [song.genre_name ?? song.genre, song.subgenre_name ?? song.subgenre]
          .filter(Boolean)
          .join(" / ");
        const href = `/songs/${song.recording_slug ?? song.recording_id}`;

        return (
          <Link
            key={song.recording_id}
            href={href}
            className="grid gap-1 border-b py-3 text-sm transition hover:bg-[#002D62]/5 last:border-none md:grid-cols-[minmax(0,1.5fr)_minmax(0,1fr)_minmax(0,1fr)_5rem] md:items-center md:gap-3 md:py-2"
          >
            <span className="truncate font-medium text-[#002D62]">
              {song.recording_title}
            </span>

            <span className="truncate text-gray-700">
              {song.artist_name ?? "Unknown Artist"}
            </span>

            <span className="truncate text-gray-500">
              {genreText || "Uncategorized"}
            </span>

            <span className="font-mono text-xs text-gray-600 md:text-right md:text-sm">
              {song.duration ? formatDuration(song.duration) : "--:--"}
            </span>
          </Link>
        );
      })}
    </div>
  );
}

function formatDuration(ms: number) {
  if (!ms || ms <= 0) return "--:--";

  const totalSeconds = Math.floor(ms / 1000);
  const minutes = Math.floor(totalSeconds / 60);
  const seconds = totalSeconds % 60;

  return `${minutes}:${seconds.toString().padStart(2, "0")}`;
}
