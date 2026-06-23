//browse by genre section on homepage
"use client";

import { useRef } from "react";
import { Link } from "@/i18n/navigation";
import { useTranslations } from "next-intl";
import { Disc3, Ellipsis, Flame, Heart, Music, Music2, Music4, Sparkles, Waves } from "lucide-react";
import CarouselArrows from "@/components/molecules/CarouselArrows";
import SectionCard from "@/components/layout/SectionCard";

export default function BrowseByGenreSection() {
  const t = useTranslations("sections");
  const tg = useTranslations("genres");
  const scrollRef = useRef<HTMLDivElement>(null);

  const genreGroups = [
    { titleKey: "merengue", labelKeys: ["pambiche", "tipico"], href: "/genres/merengue", color: "bg-amber-500", icon: Music },
    { titleKey: "bachata", labelKeys: [], href: "/genres/bachata", color: "bg-blue-500", icon: Heart },
    { titleKey: "salsa", labelKeys: [], href: "/genres/salsa", color: "bg-red-500", icon: Flame },
    { titleKey: "urbano", labelKeys: ["dembow", "reggaeton"], href: "/genres/urbano", color: "bg-gradient-to-br from-pink-500 to-zinc-700", icon: Disc3 },
    { titleKey: "instrumental", labelKeys: ["classical"], href: "/genres/instrumental", color: "bg-[#7A3E1C]", icon: Music4 },
    { titleKey: "ballads", labelKeys: ["bolero", "romantic"], href: "/genres/ballads", color: "bg-teal-500", icon: Sparkles },
    { titleKey: "folklore", labelKeys: ["traditional", "roots"], href: "/genres/folklore", color: "bg-emerald-600", icon: Music2 },
    { titleKey: "fusion", labelKeys: ["jazz", "experimental"], href: "/genres/fusion", color: "bg-indigo-500", icon: Waves },
    { titleKey: "moreGenre", labelKeys: [], href: "/genres/more", color: "bg-gray-300", icon: Ellipsis },
  ];

  const scroll = (direction: "left" | "right") => {
    if (!scrollRef.current) return;

    const { scrollLeft, clientWidth } = scrollRef.current;
    const amount = clientWidth * 0.8;

    scrollRef.current.scrollTo({
      left: direction === "left" ? scrollLeft - amount : scrollLeft + amount,
      behavior: "smooth",
    });
  };

  return (
    <SectionCard compact>
      <CarouselArrows onLeft={() => scroll("left")} onRight={() => scroll("right")} />

      <div className="section-inner">
        <div className="section-header">
          <h2>{t("browseByGenre")}</h2>
        </div>
        <div
          ref={scrollRef}
          className="scrollbar-none flex w-full gap-4 overflow-x-auto pb-2"
        >
          {genreGroups.map((genre) => {
            const IconComponent = genre.icon;
            return (
              <Link
                key={genre.href}
                href={genre.href}
                className="group relative flex aspect-square w-28 shrink-0 flex-col justify-between overflow-hidden rounded-lg p-3 transition-all duration-200 hover:scale-[1.02] sm:w-32 sm:p-4 lg:w-36"
              >
                <div
                  className={`absolute inset-0 ${genre.color} opacity-75 transition-opacity group-hover:opacity-90`}
                />

                <IconComponent
                  className="relative z-10 h-5 w-5 text-white/90 sm:h-6 sm:w-6"
                  strokeWidth={1.5}
                />

                <div className="relative z-10 text-white">
                  <span className="block text-sm font-normal leading-tight sm:text-base">
                    {tg(genre.titleKey)}
                  </span>
                  {genre.labelKeys.length > 0 && (
                    <span className="mt-1 block text-[11px] font-normal leading-tight text-white/85 sm:text-xs">
                      {genre.labelKeys.map((k) => tg(k)).join(", ")}
                    </span>
                  )}
                </div>
              </Link>
            );
          })}
        </div>
      </div>
    </SectionCard>
  );
}
