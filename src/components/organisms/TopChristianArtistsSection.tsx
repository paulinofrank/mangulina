// TopChristianArtistsSection.tsx
"use client";

import { useRef } from "react";
import { Link } from "@/i18n/navigation";
import { useTranslations } from "next-intl";
import SectionCard from "@/components/layout/SectionCard";
import ArtistCard from "@/components/molecules/ArtistCard";
import CarouselArrow from "@/components/molecules/CarouselArrow";
import type { ArtistSummary } from "@/types/home";

type TopChristianArtistsSectionProps = {
  christianArtists: ArtistSummary[];
};

export default function TopChristianArtistsSection({
  christianArtists,
}: TopChristianArtistsSectionProps) {
  const t = useTranslations("sections");
  const nav = useTranslations("navigation");
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
    <SectionCard compact>
      <div className="section-inner">
        {/* HEADER */}
        <div className="section-header">
          <h2>{t("christianArtists")}</h2>
          <Link
            href="/christian"
            className="text-[#8B0000] hover:text-[#6B0000] font-normal text-sm uppercase tracking-wider transition-colors ml-auto"
          >
            {nav("seeAll")}
          </Link></div>

        {/* DESKTOP ARROWS */}
        <CarouselArrow direction="left" onClick={() => scroll("left")} />
        <CarouselArrow direction="right" onClick={() => scroll("right")} />

        {/* CAROUSEL */}
        <div
          ref={scrollRef}
          className="flex w-full gap-4 overflow-x-auto scrollbar-none pb-2"
        >
          {christianArtists.map((artist) => (
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
