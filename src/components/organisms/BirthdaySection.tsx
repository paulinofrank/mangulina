"use client";

import { useRef } from "react";
import SectionCard from "@/components/layout/SectionCard";
import ArtistCard from "@/components/molecules/ArtistCard";
import CarouselArrow from "@/components/molecules/CarouselArrow";
import type { Artist } from "@/types/music";

type BirthdaySectionProps = {
  birthdayArtists: Artist[];
};

export default function BirthdaySection({ birthdayArtists }: BirthdaySectionProps) {
  const scrollRef = useRef<HTMLDivElement>(null);

  const calculateAge = (dobString: string | null | undefined) => {
    if (!dobString) return null;
    const birthDate = new Date(dobString);
    const today = new Date();
    let age = today.getFullYear() - birthDate.getFullYear();
    const m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) age--;
    return age;
  };

  const getLifeLabel = (dob: string | null | undefined, deathYear: number | null | undefined) => {
    if (!dob) return null;
    const birthYear = new Date(dob).getFullYear();
    if (deathYear) return `Deceased on ${deathYear}`;
    const age = calculateAge(dob);
    return `${age} years old - Born on ${birthYear}`;
  };

  const scroll = (direction: "left" | "right") => {
    if (scrollRef.current) {
      const { scrollLeft, clientWidth } = scrollRef.current;
      const scrollAmount = clientWidth * 0.8;
      const scrollTo = direction === "left" ? scrollLeft - scrollAmount : scrollLeft + scrollAmount;
      scrollRef.current.scrollTo({ left: scrollTo, behavior: "smooth" });
    }
  };

const sortedArtists = [...birthdayArtists].sort((a, b) => {
  const yearA = a.date_of_birth ? new Date(a.date_of_birth).getFullYear() : 9999;
  const yearB = b.date_of_birth ? new Date(b.date_of_birth).getFullYear() : 9999;
  return yearB - yearA; // ascending
});


  return (
    <SectionCard>
      <div className="section-inner">

        {/* HEADER — now identical structure */}
        <div className="section-header">
          <h2>Born on a Day Like Today ({birthdayArtists?.length ?? 0})</h2>

          {birthdayArtists.length > 0 && (
            <div className="flex items-center gap-1.5">
              <CarouselArrow direction="left" onClick={() => scroll("left")} />
              <CarouselArrow direction="right" onClick={() => scroll("right")} />

            </div>
          )}
        </div>

        {/* EMPTY STATE */}
        {birthdayArtists.length === 0 ? (
          <div className="py-10 text-center">
            <p className="text-sm text-gray-400 font-light">
              No Artist Was Born On A Day Like Today
            </p>
          </div>
        ) : (
          /* CAROUSEL — identical sizing to TopArtistsSection */
          <div
            ref={scrollRef}
            className="flex w-full gap-3 overflow-x-auto scrollbar-none pb-2"
          >
           {sortedArtists.map((artist) => (
    <div key={artist.id} className="shrink-0 w-[42%] sm:w-[26%] lg:w-[14%]">
      <div className="relative group">
        <ArtistCard artist={artist} titleAs="h3" />
        {(artist.date_of_birth || artist.death_year) && (
          <div className="absolute bottom-15 left-1/2 -translate-x-1/2 translate-y-1/2 z-30 
            bg-white text-[#8B0000]/80 
            px-2.5 py-1 rounded-full text-[11px] font-normal uppercase tracking-wider
            border border-black/5 whitespace-nowrap pointer-events-none">
            {getLifeLabel(artist.date_of_birth, artist.death_year)}
          </div>
                  )}
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </SectionCard>
  );
}
