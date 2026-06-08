// SongsByYearList.tsx
"use client";

import Link from "next/link";

type SongRow = {
  recording_id: string;
  recording_slug?: string | null;
  recording_title: string;
  release_id?: string | null;
  cover_image_url?: string | null;
  artist_name: string | null;
  duration: number | null;
  genre_name?: string | null;
  subgenre_name?: string | null;
  genre?: string | null;
  subgenre?: string | null;
};

export default function SongsByYearList({ songs }: { songs: SongRow[] }) {
  const supabaseBase =
    "https://srulenjahemkuxtkfmzt.supabase.co/storage/v1/object/public/";

  return (
    <div className="mt-4 rounded-xl border border-black/5 bg-white/70 p-2.5 md:mt-8 md:p-4">
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
        const coverUrl = song.release_id
          ? `${supabaseBase}cover-art/150px/${song.release_id}.webp`
          : song.cover_image_url ?? "/images/placeholder-song.jpg";

        return (
          <Link
            key={song.recording_id}
            href={href}
            className="grid grid-cols-[2rem_minmax(0,1fr)_minmax(5.5rem,auto)] gap-x-2.5 gap-y-0.5 border-b py-2 text-sm transition hover:bg-[#002D62]/5 last:border-none md:grid-cols-[minmax(0,1.5fr)_minmax(0,1fr)_minmax(0,1fr)_5rem] md:items-center md:gap-3 md:py-2"
          >
            <span className="relative col-start-1 row-span-2 row-start-1 block h-8 w-8 overflow-hidden rounded-md border border-black/5 bg-gray-100 md:hidden">
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

            <span className="col-start-2 row-start-1 truncate font-medium text-[#002D62] md:col-start-auto md:row-start-auto">
              {song.recording_title}
            </span>

            <span className="col-start-2 row-start-2 truncate text-gray-700 md:col-start-auto md:row-start-auto">
              {song.artist_name ?? "Unknown Artist"}
            </span>

            <span className="col-start-3 row-start-1 truncate text-right text-xs text-gray-500 md:col-start-auto md:row-start-auto md:text-left md:text-sm">
              {genreText || "Uncategorized"}
            </span>

            <span className="col-start-3 row-start-2 font-mono text-xs text-right text-gray-600 md:col-start-auto md:row-start-auto md:text-sm">
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
