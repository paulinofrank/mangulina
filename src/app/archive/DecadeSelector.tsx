// src/components/DecadeSelector.tsx
"use client";

import Link from "next/link";
import { Music2 } from "lucide-react";
import { useRef, useState, useEffect } from "react";
import CarouselArrows from "@/components/molecules/CarouselArrows";
import SectionCard from "@/components/layout/SectionCard";
import { getArchiveDecades, getDecadeForYear, getYearsForDecade } from "@/lib/archivePeriods";

type ArchiveCountsResponse = {
  ok: boolean;
  decadeCounts?: Record<string, number>;
  yearCounts?: Record<string, number>;
};

type DecadeSelectorProps = {
  mode?: "decades" | "years";
  selectedDecade?: string | null;
  selectedYear?: number | null;
  selectedYearCount?: number;
};

export default function DecadeSelector({
  mode = "decades",
  selectedDecade,
  selectedYear,
  selectedYearCount,
}: DecadeSelectorProps) {
  const scrollRef = useRef<HTMLDivElement>(null);
  const selectedItemRef = useRef<HTMLAnchorElement | null>(null);
  const [hydrated, setHydrated] = useState(false);

  const activeDecade = selectedDecade ?? (selectedYear ? getDecadeForYear(selectedYear) : null);
  const [isOverflowing, setIsOverflowing] = useState(false);
  const [decadeCounts, setDecadeCounts] = useState<Record<string, number>>({});
  const [yearCounts, setYearCounts] = useState<Record<string, number>>({});

  useEffect(() => {
    let cancelled = false;
    const params = mode === "years" && activeDecade ? `?decade=${encodeURIComponent(activeDecade)}` : "";

    fetch(`/api/archive/counts${params}`)
      .then(async (response) => {
        const result = (await response.json()) as ArchiveCountsResponse;
        if (!response.ok || !result.ok) return;

        if (!cancelled) {
          setDecadeCounts(result.decadeCounts ?? {});
          setYearCounts(result.yearCounts ?? {});
        }
      })
      .catch(() => {
        if (!cancelled) {
          setDecadeCounts({});
          setYearCounts({});
        }
      });

    return () => {
      cancelled = true;
    };
  }, [mode, activeDecade]);

  useEffect(() => {
    setHydrated(true);
  }, []);

  useEffect(() => {
    if (!hydrated) return;

    const el = scrollRef.current;
    if (!el) return;

    const checkOverflow = () => {
      setIsOverflowing(el.scrollWidth > el.clientWidth);
    };

    checkOverflow();
    window.addEventListener("resize", checkOverflow);

    return () => window.removeEventListener("resize", checkOverflow);
  }, [mode, activeDecade, decadeCounts, yearCounts, hydrated]);

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

  const decades = getArchiveDecades();
  const visibleYears = activeDecade
    ? [...getYearsForDecade(activeDecade)].sort((a, b) => a - b)
    : [];
  const showYears = mode === "years" && activeDecade;

  useEffect(() => {
    if (!showYears || !selectedYear) return;

    const timeout = window.setTimeout(() => {
      selectedItemRef.current?.scrollIntoView({
        behavior: "smooth",
        block: "nearest",
        inline: "center",
      });
    }, 0);

    return () => window.clearTimeout(timeout);
  }, [showYears, selectedYear, visibleYears.length]);

  return (
    <SectionCard>
      <CarouselArrows onLeft={() => scroll("left")} onRight={() => scroll("right")} />

      <div className="section-inner">
        <div className="w-full">
          <div className="section-header">
            <h2>
              {showYears ? `${activeDecade} Archive` : "Browse Archive by Decade"}
            </h2>
          </div>

          <div
            ref={scrollRef}
            className={`flex w-full gap-4 overflow-x-auto scrollbar-none pb-2 transition-all
              ${hydrated && isOverflowing ? "justify-start" : "justify-center"}
            `}
          >
            {showYears
              ? visibleYears.map((year) => {
                  const isActive = selectedYear === year;
                  const count =
                    isActive && selectedYearCount !== undefined
                      ? selectedYearCount
                      : (yearCounts[String(year)] ?? 0);

                  return (
                    <Link
                      key={year}
                      href={`/archive/${year}`}
                      ref={isActive ? selectedItemRef : null}
                      aria-current={isActive ? "page" : undefined}
                      className="shrink-0 w-36 group"
                    >
                      <div
                        className={`relative h-28 overflow-hidden rounded-lg border shadow-[0_2px_4px_rgba(0,0,0,0.05)]
                          transition-all duration-300 ease-out flex flex-col items-center justify-center
                          ${isActive
                            ? "bg-[#8B0000] border-[#8B0000]"
                            : "bg-white border-[#B0C4DE] hover:bg-[#002D62] hover:border-[#002D62]"
                          }
                          group-hover:scale-[1.03]
                        `}
                      >
                        <Music2
                          className={`mb-2 h-5 w-5 transition-colors ${
                            isActive ? "text-white" : "text-[#CE1126] group-hover:text-white"
                          }`}
                          aria-hidden="true"
                        />
                        <span
                          className={`text-xl font-semibold transition-colors ${
                            isActive ? "text-white" : "text-[#002D62] group-hover:text-white"
                          }`}
                        >
                          {year}
                        </span>
                        <span
                          className={`mt-1 text-xs font-medium leading-none transition-colors ${
                            isActive ? "text-white/80" : "text-gray-500 group-hover:text-white/80"
                          }`}
                        >
                          {count.toLocaleString()} songs
                        </span>
                      </div>
                    </Link>
                  );
                })
              : decades.map((decade) => {
                  const isActive = activeDecade === decade;

                  return (
                    <Link
                      key={decade}
                      href={`/archive/${decade}`}
                      aria-current={isActive ? "page" : undefined}
                      className="shrink-0 w-28 group"
                    >
                      <div
                        className={`relative h-16 overflow-hidden rounded-lg border transition-all duration-300 ease-out flex flex-col items-center justify-center shadow-[0_2px_4px_rgba(0,0,0,0.05)]
                          ${isActive
                            ? "bg-[#002D62] border-[#002D62]"
                            : "bg-white border-[#B0C4DE] hover:bg-[#002D62] hover:border-[#002D62]"
                          }
                          group-hover:scale-[1.03]
                        `}
                      >
                        <span
                          className={`text-lg font-semibold transition-colors ${
                            isActive ? "text-white" : "text-[#002D62] group-hover:text-white"
                          }`}
                        >
                          {decade}
                        </span>
                        <span
                          className={`mt-0.5 text-[10px] font-medium leading-none transition-colors ${
                            isActive ? "text-white/80" : "text-gray-500 group-hover:text-white/80"
                          }`}
                        >
                          {(decadeCounts[decade] ?? 0).toLocaleString()} songs
                        </span>
                      </div>
                    </Link>
                  );
                })}
          </div>
        </div>
      </div>
    </SectionCard>
  );
}
