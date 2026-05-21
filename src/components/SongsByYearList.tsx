// SongsByYearList.tsx
"use client";

type SongRow = {
  recording_id: string;
  recording_title: string;
  artist_name: string | null;
  duration: number | null;
  genre_name?: string | null;
  subgenre_name?: string | null;
};

export default function SongsByYearList({ songs }: { songs: SongRow[] }) {
  return (
    <div className="mt-8 rounded-xl border border-black/5 bg-white/70 p-4">
      {/* Header */}
      <div className="grid grid-cols-5 text-xs font-semibold uppercase tracking-wider text-gray-500 border-b pb-1 mb-2">
  <span>Song</span>
  <span>Category / Genre</span>   {/* ← updated label */}
  <span>Artist</span>
  <span className="text-center">Play</span>
  <span className="text-right">Duration</span>
</div>

      {/* Rows */}
{songs.map((song) => (
  <div
    key={song.recording_id}
    className="grid grid-cols-5 py-1 border-b last:border-none text-sm items-center" // was py-2
  >
    <span className="truncate text-[#002D62]">{song.recording_title}</span>

    {/* Category / Genre */}
    <span className="truncate">{song.genre_name ?? ""}</span>

    {/* Artist */}
    <span className="truncate">{song.artist_name ?? ""}</span>

    {/* Play button (no box, smaller) */}
    <button className="mx-auto text-[#002D62] hover:text-[#8B0000] transition">
      ▶
    </button>

    {/* Duration */}
    <span className="text-right text-gray-600">
      {song.duration ? formatDuration(song.duration) : "--:--"}
    </span>
  </div>
))}
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

