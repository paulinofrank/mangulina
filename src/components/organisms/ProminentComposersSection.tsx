// ProminentComposersSection.tsx
"use client";

import { useRef } from "react"
import SectionCard from "@/components/layout/SectionCard";
import ArtistCard from "@/components/molecules/ArtistCard"
import CarouselArrow from "@/components/molecules/CarouselArrow";

type Composer = {
  id: string
  name: string
  image_url?: string | null
  province?: string | null
  views?: number
}

type ProminentComposersSectionProps = {
  composers: Composer[]
}

export default function ProminentComposersSection({ composers }: ProminentComposersSectionProps) {
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
    <SectionCard>
      <div className="section-inner">

        {/* HEADER */}
        <div className="section-header">
          <h2>Behind the Scenes Composers</h2>
        </div>

        {/* DESKTOP ARROWS */}
        <CarouselArrow direction="left" onClick={() => scroll("left")} />
        <CarouselArrow direction="right" onClick={() => scroll("right")} />

        {/* CAROUSEL */}
        <div
          ref={scrollRef}
          className="flex w-full gap-3 overflow-x-auto scrollbar-none pb-2"
        >
          {composers.map((artist) => (
            <div
              key={artist.id}
              className="shrink-0 w-[42%] sm:w-[26%] lg:w-[14%]"
            >
              <ArtistCard artist={artist} titleAs="h3" />
            </div>
          ))}
        </div>
      </div>
    </SectionCard>
  )
}
