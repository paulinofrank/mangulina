// MostAwardedArtistsSection.tsx
"use client";

import { useRef } from "react";
import { Link } from "@/i18n/navigation";
import { useTranslations } from "next-intl";
import SectionCard from "@/components/layout/SectionCard";
import ArtistCard from "@/components/molecules/ArtistCard";
import CarouselArrow from "@/components/molecules/CarouselArrow";
import type { MostAwardedArtistSummary } from "@/types/home";
import { HOME_ARTIST_CARD_LIMIT } from "@/lib/homepageLimits";

type MostAwardedArtistsSectionProps = {
  artists: MostAwardedArtistSummary[];
};

function getAwardLabel(artist: MostAwardedArtistSummary) {
  const total = artist.awardCount + artist.nominationCount;

  if (artist.awardCount > 0) {
    return `${artist.awardCount.toLocaleString()} ${
      artist.awardCount === 1 ? "award" : "awards"
    }`;
  }

  return `${total.toLocaleString()} ${total === 1 ? "nomination" : "nominations"}`;
}

export default function MostAwardedArtistsSection({
  artists,
}: MostAwardedArtistsSectionProps) {
  const t = useTranslations("sections");
  const nav = useTranslations("navigation");
  const scrollRef = useRef<HTMLDivElement>(null);

  if (!artists.length) return null;

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
          <h2>{t("mostAwarded")}</h2>
          <Link
            href="/artists/most-awarded"
            prefetch={false}
            className="ml-auto text-sm font-normal uppercase tracking-wider text-[#8B0000] transition-colors hover:text-[#6B0000]"
          >
            {nav("seeAll")}
          </Link>
        </div>

        {/* DESKTOP ARROWS */}
        <CarouselArrow direction="left" onClick={() => scroll("left")} />
        <CarouselArrow direction="right" onClick={() => scroll("right")} />

        {/* CAROUSEL */}
        <div
          ref={scrollRef}
          className="flex w-full gap-4 overflow-x-auto scrollbar-none pb-2"
        >
          {artists.slice(0, HOME_ARTIST_CARD_LIMIT).map((artist) => (
            <div
              key={artist.id}
              className="w-28 shrink-0 sm:w-32 lg:w-36"
            >
              <ArtistCard artist={{ ...artist, views: 0 }} titleAs="h3" />
              <p className="mt-1 text-[11px] font-medium leading-tight text-[#8B0000]">
                {getAwardLabel(artist)}
              </p>
            </div>
          ))}
        </div>
      </div>
    </SectionCard>
  );
}
