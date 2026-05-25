"use client";

import { useEffect, useRef, useState } from "react";
import SectionCard from "@/components/layout/SectionCard";
import ArtistCard from "@/components/molecules/ArtistCard";
import CarouselArrow from "@/components/molecules/CarouselArrow";
import { getSupabaseClient } from "@/lib/supabase";
import type { Artist } from "@/types/music";

type BirthdaySectionProps = {
  birthdayArtists: Artist[];
};

export default function BirthdaySection({ birthdayArtists }: BirthdaySectionProps) {
  const scrollRef = useRef<HTMLDivElement>(null);
  const [localBirthdayArtists, setLocalBirthdayArtists] = useState<Artist[]>([]);
  const [loadingLocalBirthdays, setLoadingLocalBirthdays] = useState(true);

  useEffect(() => {
    async function loadLocalBirthdays() {
      const today = new Date();
      const supabase = getSupabaseClient();

      const { data, error } = await supabase.rpc("get_artists_by_day_month", {
        target_month: today.getMonth() + 1,
        target_day: today.getDate(),
      });

      if (error) {
        console.error("Birthday artists fetch failed:", error);
        setLocalBirthdayArtists(birthdayArtists);
      } else {
        setLocalBirthdayArtists((data ?? []) as Artist[]);
      }

      setLoadingLocalBirthdays(false);
    }

    loadLocalBirthdays();
  }, [birthdayArtists]);

  const parseLocalDate = (dateString: string | null | undefined) => {
    if (!dateString) return null;

    const [year, month, day] = dateString.split("T")[0].split("-").map(Number);
    if (!year || !month || !day) return null;

    return new Date(year, month - 1, day);
  };

  const calculateAge = (dobString: string | null | undefined) => {
    const birthDate = parseLocalDate(dobString);
    if (!birthDate) return null;

    const today = new Date();
    let age = today.getFullYear() - birthDate.getFullYear();
    const m = today.getMonth() - birthDate.getMonth();
    if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) age--;
    return age;
  };

  const getLifeLabel = (dob: string | null | undefined, deathYear: number | null | undefined) => {
    const birthDate = parseLocalDate(dob);
    if (!birthDate) return null;

    const birthYear = birthDate.getFullYear();
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

const sortedArtists = [...localBirthdayArtists].sort((a, b) => {
  const yearA = parseLocalDate(a.date_of_birth)?.getFullYear() ?? 9999;
  const yearB = parseLocalDate(b.date_of_birth)?.getFullYear() ?? 9999;
  return yearB - yearA; // ascending
});


  return (
    <SectionCard>
      <div className="section-inner">

        {/* HEADER — now identical structure */}
        <div className="section-header">
          <h2>Born on a Day Like Today ({localBirthdayArtists.length})</h2>

          {localBirthdayArtists.length > 0 && (
            <div className="flex items-center gap-1.5">
              <CarouselArrow direction="left" onClick={() => scroll("left")} />
              <CarouselArrow direction="right" onClick={() => scroll("right")} />

            </div>
          )}
        </div>

        {/* EMPTY STATE */}
        {loadingLocalBirthdays ? (
          <div className="py-10 text-center">
            <div className="mx-auto h-9 w-9 rounded-full border border-black/10 border-t-(--color-flagblue) animate-spin" />
          </div>
        ) : localBirthdayArtists.length === 0 ? (
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
