"use client";

import { useRef } from "react";
import { Link } from "@/i18n/navigation";
import { useTranslations } from "next-intl";

import SectionCard from "@/components/layout/SectionCard";
import ArtistCard from "@/components/molecules/ArtistCard";
import CarouselArrow from "@/components/molecules/CarouselArrow";
import type { ArtistSummary } from "@/types/home";
import { HOME_ARTIST_CARD_LIMIT } from "@/lib/homepageLimits";

export default function TopLegendsArtistsSection({
  artists,
}: {
  artists: ArtistSummary[];
}) {
  const t = useTranslations("sections");
  const nav = useTranslations("navigation");
  const scrollRef = useRef<HTMLDivElement>(null);

  if (!artists.length) return null;

  const scroll = (direction: "left" | "right") => {
    if (!scrollRef.current) return;
    const { scrollLeft, clientWidth } = scrollRef.current;
    scrollRef.current.scrollTo({
      left: direction === "left" ? scrollLeft - clientWidth * 0.8 : scrollLeft + clientWidth * 0.8,
      behavior: "smooth",
    });
  };

  return (
    <SectionCard compact>
      <div className="section-inner">
        <div className="section-header">
          <h2>{t("legends")}</h2>
          <Link
            href="/artists/legends"
            prefetch={false}
            className="ml-auto text-sm font-normal uppercase tracking-wider text-[#8B0000] transition-colors hover:text-[#6B0000]"
          >
            {nav("seeAll")}
          </Link>
        </div>

        <CarouselArrow direction="left" onClick={() => scroll("left")} />
        <CarouselArrow direction="right" onClick={() => scroll("right")} />

        <div ref={scrollRef} className="flex w-full gap-4 overflow-x-auto pb-2 scrollbar-none">
          {artists.slice(0, HOME_ARTIST_CARD_LIMIT).map((artist) => (
            <div key={artist.id} className="w-28 shrink-0 sm:w-32 lg:w-36">
              <ArtistCard artist={artist} titleAs="h3" />
            </div>
          ))}
        </div>
      </div>
    </SectionCard>
  );
}
