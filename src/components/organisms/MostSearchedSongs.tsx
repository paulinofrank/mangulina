//most searched songs section on homepage
"use client";

import { useRef } from "react";
import { Link } from "@/i18n/navigation";
import { useTranslations } from "next-intl";
import type { TrendingSong } from "@/types/home";
import CarouselArrows from "@/components/molecules/CarouselArrows";
import SongCard from "@/components/molecules/SongCard";
import { getPublicReleaseCoverUrl } from "@/lib/releaseCover";
import SectionCard from "@/components/layout/SectionCard";
import { HOME_SONG_CARD_LIMIT } from "@/lib/homepageLimits";

interface MostSearchedSongsProps {
  songs?: TrendingSong[];
}

export default function MostSearchedSongs({ songs = [] }: MostSearchedSongsProps) {
  const t = useTranslations("sections");
  const nav = useTranslations("navigation");
  const scrollRef = useRef<HTMLDivElement>(null);

  const scroll = (direction: "left" | "right") => {
    if (!scrollRef.current) return;

    const { scrollLeft, clientWidth } = scrollRef.current;
    const amount = clientWidth * 0.8;

    scrollRef.current.scrollTo({
      left: direction === "left" ? scrollLeft - amount : scrollLeft + amount,
      behavior: "smooth",
    });
  };

  const safeSongs = Array.isArray(songs) ? songs : [];

  return (
    <SectionCard compact>
      <CarouselArrows onLeft={() => scroll("left")} onRight={() => scroll("right")} />

      <div className="px-[7px] py-0 sm:px-6">
        <div className="w-full">

          {/* Header */}
   <div className="section-header flex items-center justify-between">
  <h2>
    {t("trendingSongs")}
  </h2>

  <Link
    href="/archive"
    prefetch={false}
    className="text-[#8B0000] hover:text-[#6B0000] text-sm uppercase tracking-wider transition-colors"
  >
    {nav("seeAll")}
  </Link>
</div>


          {/* Carousel */}
          <div
            ref={scrollRef}
            className="flex w-full gap-4 overflow-x-auto scrollbar-none pb-2"
          >
            {safeSongs.slice(0, HOME_SONG_CARD_LIMIT).map((song) => {
              if (!song) return null;

              const credits = song.recording_credits ?? [];
              const artistName =
                credits.length > 0
                  ? credits.map((c) => c.artist?.name).filter(Boolean).join(" & ")
                  : "Unknown Artist";

              const coverUrl = song.release?.id
                ? song.release.has_cover_image
                  ? getPublicReleaseCoverUrl(song.release.id, 150)
                  : "/images/placeholder-song.jpg"
                : "/images/placeholder-song.jpg";

              return (
                <SongCard
                  key={song.id}
                  id={song.id}
                  slug={song.slug}
                  title={song.title}
                  artistName={artistName}
                  coverUrl={coverUrl}
                  views={song.views}
                />
              );
            })}
          </div>
        </div>
      </div>
    </SectionCard>
  );
}
