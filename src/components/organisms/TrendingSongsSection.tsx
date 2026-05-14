"use client";

import { useRef } from "react";
import Link from "next/link";
import Image from "next/image";
import SectionTitle from "@/components/atoms/SectionTitle";

interface Song {
  id: string;
  title: string;
  views: number;
  release?: {
    cover_image_url?: string | null;
  };
  recording_credits?: {
    artist?: {
      name: string;
      image_url?: string | null;
    };
  }[];
}

interface TrendingSongsSectionProps {
  songs: Song[];
}

export default function TrendingSongsSection({ songs }: TrendingSongsSectionProps) {
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

  return (
    <section className="relative mx-6 overflow-hidden rounded-3xl border border-black/10 bg-white/90 shadow-xl sm:mx-12">
      <div className="px-8 py-10 sm:px-12 sm:py-12">
        <div className="w-full">
          <div className="flex items-center justify-between mb-8 pb-4 border-b border-[#002D62]/25">
            <SectionTitle>Trending Songs</SectionTitle>
            <div className="flex items-center gap-4">
              <div className="hidden sm:flex gap-2">
                <button
                  onClick={() => scroll("left")}
                  className="p-2 rounded-full border border-black/10 hover:bg-[#8B0000] hover:text-white transition-all shadow-sm"
                >
                  <svg width="20" height="20" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                  </svg>
                </button>
                <button
                  onClick={() => scroll("right")}
                  className="p-2 rounded-full border border-black/10 hover:bg-[#8B0000] hover:text-white transition-all shadow-sm"
                >
                  <svg width="20" height="20" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                  </svg>
                </button>
              </div>
              <Link href="/songs" className="ml-4 text-[#8B0000] hover:text-[#6B0000] font-semibold text-sm">
                See All →
              </Link>
            </div>
          </div>

          <div ref={scrollRef} className="flex w-full gap-6 overflow-x-auto scrollbar-none pb-4">
            {songs.map((song) => {
              const credits = song.recording_credits ?? [];
              const artistName =
                credits.length > 0
                  ? credits.map((c) => c.artist?.name).filter(Boolean).join(" & ")
                  : "Frank Reyes";

              const supabaseBase =
                "https://srulenjahemkuxtkfmzt.supabase.co/storage/v1/object/public/";
              let finalImageUrl = "";

              if (song.release?.cover_image_url) {
                const path = song.release.cover_image_url;
                finalImageUrl = path.startsWith("http") ? path : `${supabaseBase}${path}`;
              } else if (credits[0]?.artist?.image_url) {
                finalImageUrl = credits[0].artist.image_url ?? "";
              }

              return (
                <div key={song.id} className="shrink-0 w-50">
                  <div className="relative aspect-square overflow-hidden rounded-2xl bg-gray-200">
                    {finalImageUrl !== "" ? (
                      <Image
                        src={finalImageUrl}
                        alt={song.title}
                        fill
                        className="object-cover"
                        sizes="200px"
                        unoptimized
                        onError={(e) => {
                          e.currentTarget.src = `${supabaseBase}cover-art/${song.id}/front.jpg`;
                        }}
                      />
                    ) : (
                      <div className="h-full w-full bg-gray-300 animate-pulse" />
                    )}
                  </div>
                  <div className="mt-3">
                    <h4 className="truncate font-bold text-[#002D62]">{song.title}</h4>
                    <p className="truncate text-sm text-gray-600">{artistName}</p>
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
