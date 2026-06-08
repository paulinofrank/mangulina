"use client";

import { useRef } from "react";
import SectionCard from "@/components/layout/SectionCard";
import ArtistCard from "@/components/molecules/ArtistCard";
import CarouselArrow from "@/components/molecules/CarouselArrow";
import type { ArtistSummary } from "@/types/home";
import Link from "next/link";

type TopRisingStarsSectionProps = {
  risingStars: ArtistSummary[];
};

export default function TopRisingStarsSection({ risingStars }: TopRisingStarsSectionProps) {
  const scrollRef = useRef<HTMLDivElement>(null);

  const scroll = (direction: "left" | "right") => {
    if (scrollRef.current) {
      const { scrollLeft, clientWidth } = scrollRef.current;
      const scrollAmount = clientWidth * 0.8;
      const scrollTo =
        direction === "left"
          ? scrollLeft - scrollAmount
          : scrollLeft + scrollAmount;

      scrollRef.current.scrollTo({ left: scrollTo, behavior: "smooth" });
    }
  };

  return (
    <SectionCard>
      <div className="section-inner">
        <div className="section-header">
          <h2>Emerging Artists</h2>
           <Link
            href="/artists?tag=emerging"
            className="text-[#8B0000] hover:text-[#6B0000] font-normal text-sm uppercase tracking-wider transition-colors ml-auto"
          >
            See All
          </Link>
        </div>

        <CarouselArrow direction="left" onClick={() => scroll("left")} />
        <CarouselArrow direction="right" onClick={() => scroll("right")} />

        <div
          ref={scrollRef}
          className="flex w-full gap-4 overflow-x-auto scrollbar-none pb-2"
        >
          {risingStars.map((artist) => (
            <div
              key={artist.id}
              className="shrink-0 w-28 sm:w-32 lg:w-36"
            >
              <ArtistCard artist={artist} titleAs="h3" />
            </div>
          ))}
        </div>
      </div>
    </SectionCard>
  );
}
