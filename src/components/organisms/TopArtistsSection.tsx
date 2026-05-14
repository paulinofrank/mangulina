"use client";

import { useRef } from "react"
import Link from "next/link"
import SectionTitle from "@/components/atoms/SectionTitle"
import ArtistCard from "@/components/molecules/ArtistCard"
import type { Artist } from "@/types/music"

type TopArtistsSectionProps = {
  topArtists: Artist[]
}

export default function TopArtistsSection({ topArtists }: TopArtistsSectionProps) {
  const scrollRef = useRef<HTMLDivElement>(null)

  const scroll = (direction: "left" | "right") => {
    if (scrollRef.current) {
      const { scrollLeft, clientWidth } = scrollRef.current
      const scrollAmount = clientWidth * 0.8;
      const scrollTo = direction === "left" ? scrollLeft - scrollAmount : scrollLeft + scrollAmount
      scrollRef.current.scrollTo({ left: scrollTo, behavior: "smooth" })
    }
  }

  return (
    <section className="relative mx-6 overflow-hidden rounded-3xl border border-black/10 bg-white/90 shadow-xl sm:mx-12">
      <div className="px-8 py-10 sm:px-12 sm:py-12">
        <div className="w-full">
          <div className="flex items-center justify-between mb-8 pb-4 border-b border-[#002D62]/25">
            <SectionTitle>Top 10 Artists</SectionTitle>
            
            <div className="flex items-center gap-4">
              <div className="hidden sm:flex gap-2">
                <button 
                  onClick={() => scroll("left")}
                  className="p-2 rounded-full border border-black/10 hover:bg-[#8B0000] hover:text-white transition-all shadow-sm"
                  aria-label="Previous"
                >
                  <svg width="20" height="20" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                  </svg>
                </button>
                <button 
                  onClick={() => scroll("right")}
                  className="p-2 rounded-full border border-black/10 hover:bg-[#8B0000] hover:text-white transition-all shadow-sm"
                  aria-label="Next"
                >
                  <svg width="20" height="20" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                  </svg>
                </button>
              </div>
              <Link href="/artists" className="ml-4 text-[#8B0000] hover:text-[#6B0000] font-semibold text-sm">
                See All →
              </Link>
            </div>
          </div>

          <div 
            ref={scrollRef}
            className="flex w-full gap-6 overflow-x-auto scrollbar-none pb-4"
          >
            {topArtists.map((artist) => (
              <div 
                key={artist.id} 
                /* 
                   FIXED: Removed hover:scale and transition-transform.
                   The "magnifier" zoom is now handled entirely inside 
                   the ArtistCard's image container.
                */
                className="shrink-0 w-[70%] sm:w-[35%] lg:w-[22%]" 
              >
                <ArtistCard artist={artist} titleAs="h3" />
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>
  )
}