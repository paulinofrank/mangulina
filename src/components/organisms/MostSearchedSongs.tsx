//most searched songs section on homepage
"use client";

import { useRef } from "react";
import Link from "next/link";
import type { TrendingSong } from "@/types/home";
import CarouselArrows from "@/components/molecules/CarouselArrows";
import SongCard from "@/components/molecules/SongCard";
import SectionCard from "@/components/layout/SectionCard";

interface MostSearchedSongsProps {
  songs?: TrendingSong[];
}

export default function MostSearchedSongs({ songs = [] }: MostSearchedSongsProps) {
  const scrollRef = useRef<HTMLDivElement>(null);

  const scroll = (direction: "left" | "right") => {
    if (!scrollRef.current) return;

    const { scrollLeft, clientWidth } = scrollRef.current;
    const amount = clientWidth * 0.8;

    scrollRef.current.scrollTo({
      left: direction === "left" ? scrollLeft - amount : scrollLeft + amount,
      behavior: "smooth",
    });
  };

  const safeSongs = Array.isArray(songs) ? songs : [];

  const supabaseBase =
    "https://srulenjahemkuxtkfmzt.supabase.co/storage/v1/object/public/";

  return (
    <SectionCard>
      <CarouselArrows onLeft={() => scroll("left")} onRight={() => scroll("right")} />

      <div className="px-5 py-0 sm:px-6">
        <div className="w-full">

          {/* Header */}
          <div className="section-header">
            <h2>
              Most Searched Songs
            </h2>

            <Link
              href="/archive"
              className="text-[#8B0000] hover:text-[#6B0000] font-normal text-xs uppercase tracking-wider transition-colors"
            >
              See All
            </Link>
          </div>

          {/* Carousel */}
          <div
            ref={scrollRef}
            className="flex w-full gap-4 overflow-x-auto scrollbar-none pb-2"
          >
            {safeSongs.map((song) => {
              if (!song) return null;

              const credits = song.recording_credits ?? [];
              const artistName =
                credits.length > 0
                  ? credits.map((c) => c.artist?.name).filter(Boolean).join(" & ")
                  : "Unknown Artist";

              const coverUrl = song.release?.id
                ? `${supabaseBase}cover-art/${song.release.id}.webp`
                : "/images/placeholder-song.jpg";

              return (
                <SongCard
                  key={song.id}
                  id={song.id}
                  title={song.title}
                  artistName={artistName}
                  coverUrl={coverUrl}
                  views={song.views}
                />
              );
            })}
          </div>
        </div>
      </div>
    </SectionCard>
  );
}
