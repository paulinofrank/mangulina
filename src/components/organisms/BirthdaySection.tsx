"use client";

import { useRef } from "react";
import SectionTitle from "@/components/atoms/SectionTitle";
import ArtistCard from "@/components/molecules/ArtistCard";
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
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
      age--;
    }
    return age;
  };

  const scroll = (direction: "left" | "right") => {
    if (scrollRef.current) {
      const { scrollLeft, clientWidth } = scrollRef.current;
      const scrollAmount = clientWidth * 0.8;
      const scrollTo = direction === "left" ? scrollLeft - scrollAmount : scrollLeft + scrollAmount;
      scrollRef.current.scrollTo({ left: scrollTo, behavior: "smooth" });
    }
  };

  return (
    <section className="relative mx-6 overflow-hidden rounded-3xl border border-black/10 bg-white/90 shadow-xl sm:mx-12 my-12">
      <div className="px-8 py-10 sm:px-12 sm:py-12">
        <div className="w-full">
          <div className="flex items-center justify-between mb-8 pb-4 border-b border-[#002D62]/25">
            <SectionTitle>Born on a Day Like Today</SectionTitle>
            
            {birthdayArtists.length > 0 && (
              <div className="flex items-center gap-2">
                <button onClick={() => scroll("left")} className="p-2 rounded-full border border-black/10 hover:bg-[#8B0000] hover:text-white transition-all shadow-sm">
                  <svg width="18" height="18" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 19l-7-7 7-7" />
                  </svg>
                </button>
                <button onClick={() => scroll("right")} className="p-2 rounded-full border border-black/10 hover:bg-[#8B0000] hover:text-white transition-all shadow-sm">
                  <svg width="18" height="18" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
                  </svg>
                </button>
              </div>
            )}
          </div>

          {birthdayArtists.length === 0 ? (
            <div className="py-12 text-center">
              <p className="text-lg text-gray-500 italic">No artists were born on this day.</p>
            </div>
          ) : (
            <div ref={scrollRef} className="flex w-full gap-6 overflow-x-auto scrollbar-none pb-4">
              {birthdayArtists.map((artist) => {
                // Now TypeScript knows artist has date_of_birth from '@/types/music'
                const age = calculateAge(artist.date_of_birth);
                return (
                  <div key={artist.id} className="shrink-0 w-[75%] sm:w-[35%] lg:w-[22%]">
                    <div className="relative group">
                      <ArtistCard artist={artist} titleAs="h3" />
                      
                      {age !== null && (
                        <div className="absolute bottom-14 left-1/2 -translate-x-1/2 translate-y-1/2 z-30 
                                      bg-[#FFFFFF] text-[#8B0000] 
                                      px-4 py-1.5 rounded-full text-[10px] font-bold uppercase tracking-wider
                                      border border-black/10 shadow-xl whitespace-nowrap
                                      pointer-events-none">
                          {age} Years Old
                        </div>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>
          )}
        </div>
      </div>
    </section>
  );
}