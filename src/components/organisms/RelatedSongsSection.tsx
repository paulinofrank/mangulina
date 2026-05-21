// components/organisms/RelatedSongsSection.tsx
import Link from "next/link";

type RelatedSong = {
  id: string;
  title: string;
  artist_name: string;
};

type RelatedSongsSectionProps = {
  songs: RelatedSong[];
};

export default function RelatedSongsSection({ songs }: RelatedSongsSectionProps) {
  if (!songs.length) return null;

  return (
    <section className="mt-8 border-t border-black/5 pt-6">
      <h2 className="mb-3 text-sm font-semibold uppercase tracking-wider text-[#002D62]">
        Related Songs
      </h2>
      <ul className="space-y-1 text-sm text-[#002D62]">
        {songs.map((song) => (
          <li key={song.id}>
            <Link
              href={`/songs/${song.id}`}
              className="flex items-center justify-between gap-2 hover:text-[#CE1126] transition-colors"
            >
              <span className="truncate">{song.title}</span>
              <span className="truncate text-xs text-gray-500">
                {song.artist_name}
              </span>
            </Link>
          </li>
        ))}
      </ul>
    </section>
  );
}
