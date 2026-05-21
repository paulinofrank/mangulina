"use client";

import { useRef } from "react";
import Image from "next/image";

import ArtistCard from "@/components/molecules/ArtistCard";
import type { Artist } from "@/types/music";

type BirthdaySectionProps = {
  birthdayArtists: Artist[];
};

export default function BirthdaySection({
  birthdayArtists,
}: BirthdaySectionProps) {
  const scrollRef = useRef<HTMLDivElement>(null);

  const calculateAge = (dobString: string | null | undefined) => {
    if (!dobString) return null;

    const birthDate = new Date(dobString);
    const today = new Date();

    let age = today.getFullYear() - birthDate.getFullYear();

    const m = today.getMonth() - birthDate.getMonth();

    if (
      m < 0 ||
      (m === 0 && today.getDate() < birthDate.getDate())
    ) {
      age--;
    }

    return age;
  };

  const getLifeLabel = (
    dob: string | null | undefined,
    deathYear: number | null | undefined
  ) => {
    if (!dob) return null;

    const birthYear = new Date(dob).getFullYear();

    if (deathYear) {
      return `Deceased on ${deathYear}`;
    }

    const age = calculateAge(dob);

    return `${age} years old - Born on ${birthYear}`;
  };

  const scroll = (direction: "left" | "right") => {
    if (scrollRef.current) {
      const { scrollLeft, clientWidth } = scrollRef.current;

      const scrollAmount = clientWidth * 0.8;

      const scrollTo =
        direction === "left"
          ? scrollLeft - scrollAmount
          : scrollLeft + scrollAmount;

      scrollRef.current.scrollTo({
        left: scrollTo,
        behavior: "smooth",
      });
    }
  };

  return (
    <section className="relative overflow-hidden rounded-xl border border-black/5 bg-white/60">
      <div className="px-6 py-8 sm:px-8">
        <div className="w-full">
          <div className="flex items-center justify-between mb-5 pb-3 border-b border-black/5">
            <div>

              <h2 className="text-sm font-light text-[#002D62]">
                Born on a Day Like Today
              </h2>
            </div>

            {birthdayArtists.length > 0 && (
              <div className="flex items-center gap-1.5">
                <button
                  onClick={() => scroll("left")}
                  className="p-1.5 rounded-md border border-black/5 hover:bg-[#002D62] hover:text-white transition-all"
                >
                  <svg
                    width="14"
                    height="14"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={1.5}
                      d="M15 19l-7-7 7-7"
                    />
                  </svg>
                </button>

                <button
                  onClick={() => scroll("right")}
                  className="p-1.5 rounded-md border border-black/5 hover:bg-[#002D62] hover:text-white transition-all"
                >
                  <svg
                    width="14"
                    height="14"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={1.5}
                      d="M9 5l7 7-7 7"
                    />
                  </svg>
                </button>
              </div>
            )}
          </div>

          {birthdayArtists.length === 0 ? (
            <div className="py-10 text-center">
              <p className="text-sm text-gray-400 font-light">
                No Artist Was Born On A Day Like Today
              </p>
            </div>
          ) : (
            <div
              ref={scrollRef}
              className="flex w-full gap-3 overflow-x-auto scrollbar-none pb-2"
            >
              {birthdayArtists.map((artist) => {
                return (
                 <div
  key={artist.id}
  className="shrink-0 w-[42%] sm:w-[26%] lg:w-[14%]"
>
  <div className="relative group">
    <ArtistCard artist={artist} titleAs="h3" />

                      {(artist.date_of_birth || artist.death_year) && (
                        <div
                          className="absolute bottom-15 left-1/2 -translate-x-1/2 translate-y-1/2 z-30 
                          bg-white text-[#8B0000]/80 
                          px-2.5 py-1 rounded-full text-[11px] font-normal uppercase tracking-wider
                          border border-black/5 whitespace-nowrap
                          pointer-events-none"
                        >
                          {getLifeLabel(
                            artist.date_of_birth,
                            artist.death_year
                          )}
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