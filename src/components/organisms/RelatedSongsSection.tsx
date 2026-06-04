// components/organisms/RelatedSongsSection.tsx

import Link from "next/link";
import type { ArtistSongRecord } from "@/lib/queries/songs";

type RelatedSong = {
  id: string;
  slug: string | null;
  title: string;
  artist_name: string;
};

type RelatedSongsSectionProps = {
  songs: RelatedSong[];
  moreSongs?: ArtistSongRecord[];
  artistName?: string;
};

export default function RelatedSongsSection({
  songs,
  moreSongs = [],
  artistName,
}: RelatedSongsSectionProps) {
  const hasRelated = songs.length > 0;
  const hasMore    = moreSongs.length > 0;
  if (!hasRelated && !hasMore) return null;

  return (
    <div className="space-y-5">
      {/* Related Songs */}
      {hasRelated && (
        <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
          <h2 className="mb-4 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
            Related Songs
          </h2>
          <ul className="divide-y divide-gray-50">
            {songs.map((song) => (
              <li key={song.id}>
                <Link
                  href={`/songs/${song.slug ?? song.id}`}
                  className="flex items-center justify-between gap-3 py-2.5 text-sm text-[#002D62] transition-colors hover:text-[#CE1126]"
                >
                  <span className="truncate font-medium">{song.title}</span>
                  <span className="shrink-0 text-xs text-gray-400">
                    {song.artist_name}
                  </span>
                </Link>
              </li>
            ))}
          </ul>
        </section>
      )}

      {/* More Songs by Artist */}
      {hasMore && artistName && (
        <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
          <h2 className="mb-4 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
            More by {artistName}
          </h2>
          <ul className="divide-y divide-gray-50">
            {moreSongs.map((song) => (
              <li key={song.id}>
                <Link
                  href={`/songs/${song.slug ?? song.id}`}
                  className="flex items-center justify-between gap-3 py-2.5 text-sm text-[#002D62] transition-colors hover:text-[#CE1126]"
                >
                  <span className="truncate font-medium">{song.title}</span>
                  {song.release_year_actual && (
                    <span className="shrink-0 text-xs text-gray-400">
                      {song.release_year_actual}
                    </span>
                  )}
                </Link>
              </li>
            ))}
          </ul>
        </section>
      )}
    </div>
  );
}
