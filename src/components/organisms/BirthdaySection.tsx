"use client";

import { useEffect, useRef, useState } from "react";
import Link from "next/link";
import { useTranslations } from "next-intl";
import SectionCard from "@/components/layout/SectionCard";
import ArtistCard from "@/components/molecules/ArtistCard";
import CarouselArrow from "@/components/molecules/CarouselArrow";
import { getSupabaseClient } from "@/lib/supabase";
import type { Artist } from "@/types/music";

type BirthdaySectionProps = {
  birthdayArtists: Artist[];
};

type BirthdayParts = {
  year: number;
  month: number;
  day: number;
};

const BIRTHDAY_WINDOW_DAYS = 7;

function parseBirthday(dateString: string | null | undefined): BirthdayParts | null {
  if (!dateString) return null;

  const [year, month, day] = dateString.split("T")[0].split("-").map(Number);
  if (!year || !month || !day) return null;

  return { year, month, day };
}

function birthdayKey(month: number, day: number) {
  return `${month}-${day}`;
}

function buildUpcomingBirthdayOffsets(today: Date) {
  const offsets = new Map<string, number>();

  for (let offset = 0; offset < BIRTHDAY_WINDOW_DAYS; offset += 1) {
    const date = new Date(today.getFullYear(), today.getMonth(), today.getDate() + offset);
    offsets.set(birthdayKey(date.getMonth() + 1, date.getDate()), offset);
  }

  return offsets;
}

function filterAndSortUpcomingBirthdays(artists: Artist[], today: Date) {
  const upcomingOffsets = buildUpcomingBirthdayOffsets(today);

  return artists
    .map((artist) => {
      const birthday = parseBirthday(artist.date_of_birth);
      if (!birthday) return null;

      const offset = upcomingOffsets.get(birthdayKey(birthday.month, birthday.day));
      return offset === undefined ? null : { artist, offset };
    })
    .filter((entry): entry is { artist: Artist; offset: number } => entry !== null)
    .sort(
      (a, b) =>
        a.offset - b.offset ||
        a.artist.name.localeCompare(b.artist.name, undefined, { sensitivity: "base" }),
    )
    .map(({ artist }) => artist);
}

function getLifeLabel(
  dob: string | null | undefined,
  deathYear: number | null | undefined,
  t: any,
) {
  const birthday = parseBirthday(dob);
  if (!birthday) return null;

  if (deathYear) return t("deceased", { year: deathYear });

  const today = new Date();
  let age = today.getFullYear() - birthday.year;
  const birthdayHasPassed =
    today.getMonth() + 1 > birthday.month ||
    (today.getMonth() + 1 === birthday.month && today.getDate() >= birthday.day);

  if (!birthdayHasPassed) age -= 1;
  return t("yearsOld", { age });
}

export default function BirthdaySection({ birthdayArtists }: BirthdaySectionProps) {
  const t = useTranslations("sections");
  const tCommon = useTranslations("common");
  const nav = useTranslations("navigation");
  const tStatus = useTranslations("status");
  const scrollRef = useRef<HTMLDivElement>(null);
  const [localBirthdayArtists, setLocalBirthdayArtists] = useState<Artist[]>([]);
  const [loadingLocalBirthdays, setLoadingLocalBirthdays] = useState(true);

  useEffect(() => {
    async function loadLocalBirthdays() {
      const today = new Date();
      const supabase = getSupabaseClient();

      const { data, error } = await supabase
        .from("artists")
        .select(
          "id, slug, name, status, date_of_birth, province, birth_place, bio, genres, artist_tags, views, death_year",
        )
        .eq("status", "published")
        .not("date_of_birth", "is", null);

      if (error) {
        console.error("Birthday artists fetch failed:", error);
        setLocalBirthdayArtists(filterAndSortUpcomingBirthdays(birthdayArtists, today));
      } else {
        setLocalBirthdayArtists(
          filterAndSortUpcomingBirthdays((data ?? []) as Artist[], today),
        );
      }

      setLoadingLocalBirthdays(false);
    }

    void loadLocalBirthdays();
  }, [birthdayArtists]);

  function scroll(direction: "left" | "right") {
    if (!scrollRef.current) return;

    const { scrollLeft, clientWidth } = scrollRef.current;
    const scrollAmount = clientWidth * 0.8;
    const scrollTo =
      direction === "left" ? scrollLeft - scrollAmount : scrollLeft + scrollAmount;

    scrollRef.current.scrollTo({ left: scrollTo, behavior: "smooth" });
  }

  return (
    <SectionCard compact>
      <div className="section-inner">
        <div className="section-header">
          <h2>{t("birthdaysThisWeek")} ({localBirthdayArtists.length})</h2>
          <Link
            href="/artists/birthdays"
            className="ml-auto text-sm font-normal uppercase tracking-wider text-[#8B0000] transition-colors hover:text-[#6B0000]"
          >
            {nav("seeAll")}
          </Link>
        </div>

        {localBirthdayArtists.length > 0 && (
          <>
            <CarouselArrow direction="left" onClick={() => scroll("left")} />
            <CarouselArrow direction="right" onClick={() => scroll("right")} />
          </>
        )}

        {loadingLocalBirthdays ? (
          <div className="py-10 text-center">
            <div className="mx-auto h-9 w-9 animate-spin rounded-full border border-black/10 border-t-(--color-flagblue)" />
          </div>
        ) : localBirthdayArtists.length === 0 ? (
          <div className="py-10 text-center">
            <p className="text-sm font-light text-gray-400">
              {tCommon("noBirthdaysThisWeek")}
            </p>
          </div>
        ) : (
          <div
            ref={scrollRef}
            className="scrollbar-none flex w-full gap-4 overflow-x-auto pb-2"
          >
            {localBirthdayArtists.map((artist) => (
              <div key={artist.id} className="w-28 shrink-0 sm:w-32 lg:w-36">
                <div className="group relative">
                  <ArtistCard artist={artist} titleAs="h3" showViews={false} />
                  {(artist.date_of_birth || artist.death_year) && (
                    <div className="pointer-events-none absolute bottom-15 left-1/2 z-30 -translate-x-1/2 translate-y-1/2 whitespace-nowrap rounded-full border border-black/5 bg-white px-2.5 py-1 text-[11px] font-normal uppercase tracking-wider text-[#8B0000]/80">
                      {getLifeLabel(artist.date_of_birth, artist.death_year, tStatus)}
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
