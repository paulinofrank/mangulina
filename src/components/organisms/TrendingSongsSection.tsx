// TrendingSongsSection.tsx  (Organism)
"use client";

import { useRef } from "react";
import type { TrendingSong } from "@/types/home";

interface TrendingSongsSectionProps {
  songs?: TrendingSong[];
}

export default function TrendingSongsSection({ songs = [] }: TrendingSongsSectionProps) {
  const scrollRef = useRef<HTMLDivElement>(null);

  const scroll = (direction: "left" | "right") => {
    if (scrollRef.current) {
      const { scrollLeft, clientWidth } = scrollRef.current;
      const scrollTo =
        direction === "left"
          ? scrollLeft - clientWidth * 0.8
          : scrollLeft + clientWidth * 0.8;

      scrollRef.current.scrollTo({ left: scrollTo, behavior: "smooth" });
    }
  };

  const safeSongs = Array.isArray(songs) ? songs : [];

  const supabaseBase =
    "https://srulenjahemkuxtkfmzt.supabase.co/storage/v1/object/public/";

  return (
    <section className="relative overflow-hidden rounded-xl border border-black/5 bg-white/60 backdrop-blur-md">
      <div className="px-5 py-6 sm:px-6">
        <div className="w-full">
          {/* Section Header */}
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-sm font-medium uppercase tracking-wider text-[#002D62]">
              Most Searched Songs
            </h2>
            <div className="flex items-center gap-3">
              <div className="hidden sm:flex gap-1.5">
                <button
                  onClick={() => scroll("left")}
                  className="p-1.5 rounded-md border border-black/5 hover:bg-[#002D62] hover:text-white transition-all shadow-xs cursor-pointer"
                  aria-label="Scroll left"
                >
                  <svg width="16" height="16" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M15 19l-7-7 7-7" />
                  </svg>
                </button>
                <button
                  onClick={() => scroll("right")}
                  className="p-1.5 rounded-md border border-black/5 hover:bg-[#002D62] hover:text-white transition-all shadow-xs cursor-pointer"
                  aria-label="Scroll right"
                >
                  <svg width="16" height="16" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 5l7 7-7 7" />
                  </svg>
                </button>
              </div>
              <a
                href="/songs"
                className="text-[#8B0000] hover:text-[#6B0000] font-normal text-xs uppercase tracking-wider transition-colors"
              >
                See All
              </a>
            </div>
          </div>

          {/* Cards Carousel */}
          <div ref={scrollRef} className="flex w-full gap-4 overflow-x-auto scrollbar-none pb-2">
            {safeSongs.map((song) => {
              if (!song) return null;

              const credits = song.recording_credits ?? [];
              const artistName =
                credits.length > 0
                  ? credits.map((c) => c.artist?.name).filter(Boolean).join(" & ")
                  : "Unknown Artist";

              // IMAGE: only cover-art or placeholder
              const coverUrl = song.release?.id
                ? `${supabaseBase}cover-art/${song.release.id}.jpg`
                : "/images/placeholder-song.jpg";

              return (
                <div key={song.id} className="shrink-0 w-32 group">
                  <div className="relative aspect-square overflow-hidden rounded-lg bg-gray-100 border border-black/5 transition-transform duration-350 ease-out group-hover:scale-[1.02]">
                    <img
                      src={coverUrl}
                      alt={song.title}
                      className="absolute inset-0 w-full h-full object-cover"
                      loading="lazy"
                      onError={(e) => {
                        // Always fall back to placeholder, never artist image
                        e.currentTarget.src = "/images/placeholder-song.jpg";
                      }}
                    />
                  </div>

                  <div className="mt-2">
                    <h4 className="truncate text-sm font-normal text-[#002D62] group-hover:text-[#CE1126] transition-colors duration-200">
                      {song.title}
                    </h4>
                    <p className="truncate text-xs text-gray-500">
                      {artistName}
                    </p>
                  </div>
                </div>
              );
            })}
          </div>

        </div>
      </div>
    </section>
  );
}
