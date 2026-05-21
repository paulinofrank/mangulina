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

          {/* HEADER */}
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-base font-normal uppercase tracking-wider text-[#002D62]">
              Top 10 Artists
            </h2>
          </div>

          {/* DESKTOP ARROWS — FLOATING OVER CAROUSEL */}
          <button
            onClick={() => scroll("left")}
            className="hidden md:flex absolute left-3 top-1/2 -translate-y-1/2 
             z-20 p-2 rounded-full bg-white shadow-md border border-black/10 
             hover:bg-[#002D62] hover:text-white transition"
            aria-label="Scroll Left"
          >
            <svg width="20" height="20" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M15 19l-7-7 7-7" />
            </svg>
          </button>

          <button
            onClick={() => scroll("right")}
            className="hidden md:flex absolute right-3 top-1/2 -translate-y-1/2 
             z-20 p-2 rounded-full bg-white shadow-md border border-black/10 
             hover:bg-[#002D62] hover:text-white transition"
            aria-label="Scroll Right"
          >
            <svg width="20" height="20" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 5l7 7-7 7" />
            </svg>
          </button>


          {/* CAROUSEL */}
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
