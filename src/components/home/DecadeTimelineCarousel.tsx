"use client";

import { Link } from "@/i18n/navigation";
import { Music2 } from "lucide-react";
import { useEffect, useRef, useState } from "react";
import { useTranslations } from "next-intl";

import CarouselArrows from "@/components/molecules/CarouselArrows";
import SectionCard from "@/components/layout/SectionCard";
import { getArchiveDecades } from "@/lib/archivePeriods";

type DecadeTimelineCarouselProps = {
  decadeCounts: Record<string, number>;
  ctaHref?: string;
  ctaLabel?: string;
};

export default function DecadeTimelineCarousel({
  decadeCounts,
  ctaHref = "/archive",
  ctaLabel,
}: DecadeTimelineCarouselProps) {
  const t = useTranslations("components");
  const tCommon = useTranslations("common");
  const scrollRef = useRef<HTMLDivElement>(null);
  const [isOverflowing, setIsOverflowing] = useState(false);

  useEffect(() => {
    const el = scrollRef.current;
    if (!el) return;

    const checkOverflow = () => {
      setIsOverflowing(el.scrollWidth > el.clientWidth);
    };

    checkOverflow();
    window.addEventListener("resize", checkOverflow);

    return () => window.removeEventListener("resize", checkOverflow);
  }, [decadeCounts]);

  const scroll = (direction: "left" | "right") => {
    if (scrollRef.current) {
      const { scrollLeft, clientWidth } = scrollRef.current;
      const scrollTo =
        direction === "left"
          ? scrollLeft - clientWidth * 0.8
          : scrollLeft + clientWidth * 0.8;

      scrollRef.current.scrollTo({ left: scrollTo, behavior: "smooth" });
    }
  };

  const visibleDecades = getArchiveDecades().filter((decade) => (decadeCounts[decade] ?? 0) > 0);

  if (visibleDecades.length === 0) return null;

  return (
    <SectionCard compact>
      <CarouselArrows onLeft={() => scroll("left")} onRight={() => scroll("right")} />

      <div className="section-inner">
        <div className="section-header">
          <h2>
            <span className="sm:hidden">{t("throughTheDecades")}</span>
            <span className="hidden sm:inline">{t("domincanMusicDecades")}</span>
          </h2>
          <Link
            href={ctaHref}
            prefetch={false}
            className="text-[#8B0000] hover:text-[#6B0000] font-normal text-sm uppercase tracking-wider transition-colors ml-auto"
          >
            {ctaLabel ?? t("archiveCta")}
          </Link>
        </div>

        <div
          ref={scrollRef}
          className={`flex w-full gap-4 overflow-x-auto scrollbar-none pb-2 transition-all
            ${isOverflowing ? "justify-start" : "justify-center"}
          `}
        >
          {visibleDecades.map((decade) => (
            <Link
              key={decade}
              href={`/archive/${decade}`}
              prefetch={false}
              className="shrink-0 w-28 sm:w-32 lg:w-36 group"
            >
              <div
                className="relative h-24 sm:h-28 overflow-hidden rounded-lg border border-[#B0C4DE] bg-white transition-all duration-300 ease-out flex flex-col items-center justify-center shadow-[0_2px_4px_rgba(0,0,0,0.05)] hover:bg-[#002D62] hover:border-[#002D62] group-hover:scale-[1.03]"
              >
                <Music2
                  className="mb-2 h-5 w-5 text-[#CE1126] transition-colors group-hover:text-white"
                  aria-hidden="true"
                />
                <span className="text-xl font-semibold text-[#002D62] transition-colors group-hover:text-white">
                  {decade}
                </span>
                <span className="mt-1 text-xs font-medium leading-none text-gray-500 transition-colors group-hover:text-white/80">
                  {(decadeCounts[decade] ?? 0).toLocaleString()} {tCommon("songs")}
                </span>
              </div>
            </Link>
          ))}
        </div>
      </div>
    </SectionCard>
  );
}
