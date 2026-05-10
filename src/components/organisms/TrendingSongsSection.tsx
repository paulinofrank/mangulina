"use client";

import { useRef } from "react";
import Link from "next/link";
import SectionTitle from "@/components/atoms/SectionTitle";
import Image from "next/image";

// --- Types ---
interface Song {
  id: string | number;
  title: string;
  views?: number;
  release?: {
    cover_image_url?: string | null;
    artist?: { name: string } | { name: string }[];
  } | { cover_image_url?: string | null; artist?: { name: string } | { name: string }[] }[];
  artist?: { name: string } | { name: string }[];
}

interface TrendingSongsSectionProps {
  songs: Song[];
}

export default function TrendingSongsSection({ songs }: TrendingSongsSectionProps) {
  const scrollRef = useRef<HTMLDivElement>(null);

  const scroll = (direction: "left" | "right") => {
    if (scrollRef.current) {
      const { scrollLeft, clientWidth } = scrollRef.current;
      const scrollTo = direction === "left" ? scrollLeft - clientWidth * 0.8 : scrollLeft + clientWidth * 0.8;
      scrollRef.current.scrollTo({ left: scrollTo, behavior: "smooth" });
    }
  };

  return (
    <section className="relative mx-6 overflow-hidden rounded-3xl border border-black/10 bg-white/90 shadow-xl sm:mx-12">
      <div className="px-8 py-10 sm:px-12 sm:py-12">
        <div className="w-full">
          {/* Header Section */}
          <div className="flex items-center justify-between mb-8 pb-4 border-b border-[#002D62]/25">
            <SectionTitle>Trending Songs</SectionTitle>
            <div className="flex items-center gap-4">
              <div className="hidden sm:flex gap-2">
                <button
                  onClick={() => scroll("left")}
                  className="p-2 rounded-full border border-black/10 hover:bg-[#8B0000] hover:text-white transition-all shadow-sm"
                  aria-label="Scroll left"
                >
                  <svg width="20" height="20" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                  </svg>
                </button>
                <button
                  onClick={() => scroll("right")}
                  className="p-2 rounded-full border border-black/10 hover:bg-[#8B0000] hover:text-white transition-all shadow-sm"
                  aria-label="Scroll right"
                >
                  <svg width="20" height="20" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                  </svg>
                </button>
              </div>
              <Link
                href="/songs"
                className="ml-4 text-[#8B0000] hover:text-[#6B0000] font-semibold text-sm"
              >
                See All →
              </Link>
            </div>
          </div>

          {/* Horizontal Scroll Container */}
          <div
            ref={scrollRef}
            className="flex w-full gap-6 overflow-x-auto scrollbar-none pb-4"
          >
            {songs.map((song: Song) => {
              // Normalize Release Object
              const rel = Array.isArray(song.release) ? song.release[0] : song.release;
              
              // Normalize Artist Name
              const artistName =
                (Array.isArray(rel?.artist) ? rel.artist[0]?.name : (rel?.artist as any)?.name) ||
                (Array.isArray(song.artist) ? (song.artist[0] as any)?.name : (song.artist as any)?.name) ||
                "Unknown Artist";

              // 1. IMPROVED: Cover URL Protection (Handles empty strings and 'null' values)
              const coverUrl = (rel?.cover_image_url && rel.cover_image_url !== "" && rel.cover_image_url !== "null") 
                ? rel.cover_image_url 
                : null;

              return (
                <Link
                  key={song.id}
                  href={`/recordings/${song.id}`}
                  className="group shrink-0 transition-transform duration-300 hover:scale-[1.02]
                             w-[70%] 
                             sm:w-[35%] 
                             lg:w-[22%]" 
                >
                  {/* Image Container */}
                  <div className="relative w-full aspect-square rounded-2xl overflow-hidden bg-gray-100 border border-black/5 shadow-sm">
                    {coverUrl ? (
                      <Image
                        src={coverUrl}
                        alt={song.title}
                        fill
                        // 2. IMPROVED: Added sizes to help Next.js optimize the fetch for responsive widths
                        sizes="(max-width: 640px) 70vw, (max-width: 1024px) 35vw, 22vw"
                        className="object-cover transition-transform duration-500 group-hover:scale-105"
                      />
                    ) : (
                      <div className="flex flex-center items-center justify-center h-full bg-gray-200 text-gray-400 italic text-[10px] font-black uppercase tracking-widest">
                        No Cover
                      </div>
                    )}
                  </div>

                  {/* Metadata */}
                  <div className="mt-4 px-1">
                    <h4 className="font-bold text-base text-[#002D62] truncate group-hover:text-[#8B0000] transition-colors">
                      {song.title}
                    </h4>
                    <p className="text-sm text-gray-600 truncate mt-1">
                      {artistName}
                    </p>
                    <p className="text-[10px] font-black text-gray-400 mt-2 uppercase tracking-wider">
                      {song.views?.toLocaleString() ?? 0} views
                    </p>
                  </div>
                </Link>
              );
            })}
          </div>
        </div>
      </div>
    </section>
  );
}