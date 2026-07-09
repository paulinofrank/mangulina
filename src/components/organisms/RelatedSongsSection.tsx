"use client";

import { Link } from "@/i18n/navigation";
import { useRef } from "react";
import { useTranslations } from "next-intl";

import CarouselArrows from "@/components/molecules/CarouselArrows";
import SongCard from "@/components/molecules/SongCard";
import { getPublicReleaseCoverUrl } from "@/lib/releaseCover";
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
  const t = useTranslations("song.hero");
  const scrollRef = useRef<HTMLDivElement>(null);
  const hasRelated = songs.length > 0;
  const hasMore    = moreSongs.length > 0;
  if (!hasRelated && !hasMore) return null;

  const scroll = (direction: "left" | "right") => {
    if (!scrollRef.current) return;

    const { scrollLeft, clientWidth } = scrollRef.current;
    const amount = clientWidth * 0.8;

    scrollRef.current.scrollTo({
      left: direction === "left" ? scrollLeft - amount : scrollLeft + amount,
      behavior: "smooth",
    });
  };

  return (
    <div className="grid min-w-0 items-start gap-5 lg:grid-cols-2">
      {/* Related Songs */}
      {hasRelated && (
        <section className="h-fit min-w-0 rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
          <h2 className="mb-4 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
            {t("relatedSongs")}
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
        <section className="relative h-fit min-w-0 overflow-hidden rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6 lg:col-span-2">
          <CarouselArrows onLeft={() => scroll("left")} onRight={() => scroll("right")} />

          <div className="section-header mb-4 flex items-center justify-between">
            <h2>
              {t("moreBy", { artist: artistName })}
            </h2>
          </div>

          <div
            ref={scrollRef}
            className="flex min-w-0 max-w-full gap-4 overflow-x-auto scrollbar-none pb-2"
          >
            {moreSongs.map((song) => {
              const coverUrl = song.release_id && song.has_cover_image
                ? getPublicReleaseCoverUrl(song.release_id, 150)
                : "/images/placeholder-song.jpg";

              return (
                <SongCard
                  key={song.id}
                  id={song.id}
                  slug={song.slug}
                  title={song.title}
                  artistName={song.artist_name ?? artistName}
                  coverUrl={coverUrl}
                  views={song.views}
                />
              );
            })}
          </div>
        </section>
      )}
    </div>
  );
}
