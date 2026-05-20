"use client";

import { useRef } from "react"
import Link from "next/link"
import ArtistCard from "@/components/molecules/ArtistCard"
type TopArtist = {
  id: string
  name: string
  image_url?: string | null
  province?: string | null
  views?: number
}

type TopArtistsSectionProps = {
  topArtists: TopArtist[]
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
    <section className="relative overflow-hidden rounded-xl border border-black/5 bg-white/60">
      <div className="px-5 py-6 sm:px-6">
        <div className="w-full">
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-base font-normal uppercase tracking-wider text-[#002D62]">Top 10 Artists</h2>
            <div className="hidden sm:flex gap-1.5 ml-auto mr-3">
              <button 
                onClick={() => scroll("left")}
                className="p-1.5 rounded-md border border-black/5 hover:bg-[#002D62] hover:text-white transition-all"
                aria-label="Previous"
              >
                <svg width="16" height="16" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M15 19l-7-7 7-7" />
                </svg>
              </button>
              <button 
                onClick={() => scroll("right")}
                className="p-1.5 rounded-md border border-black/5 hover:bg-[#002D62] hover:text-white transition-all"
                aria-label="Next"
              >
                <svg width="16" height="16" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 5l7 7-7 7" />
                </svg>
              </button>
            </div>
            <Link href="/artists" className="text-[#8B0000] hover:text-[#6B0000] font-normal text-sm uppercase tracking-wider transition-colors ml-auto">
              See All
            </Link>
          </div>

          <div 
            ref={scrollRef}
            className="flex w-full gap-3 overflow-x-auto scrollbar-none pb-2"
          >
            {topArtists.map((artist) => (
              <div 
                key={artist.id} 
                className="shrink-0 w-[42%] sm:w-[26%] lg:w-[14%]" 
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
