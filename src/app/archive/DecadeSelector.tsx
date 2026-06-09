// src/components/DecadeSelector.tsx
"use client";

import { useRef, useState, useEffect } from "react";
import CarouselArrows from "@/components/molecules/CarouselArrows";

const FIRST_ARCHIVE_DECADE = 1920;
const currentYear = new Date().getFullYear();
const currentDecadeStart = Math.floor(currentYear / 10) * 10;
const currentDecade = `${currentDecadeStart}s`;

const decades = Array.from(
  { length: (currentDecadeStart - FIRST_ARCHIVE_DECADE) / 10 + 1 },
  (_, index) => `${currentDecadeStart - index * 10}s`,
);

const yearsByDecade = decades.reduce<Record<string, number[]>>((map, decade) => {
  const start = Number(decade.replace("s", ""));
  const end = decade === currentDecade ? currentYear : start + 9;
  map[decade] = Array.from({ length: end - start + 1 }, (_, index) => end - index);
  return map;
}, {});

type ArchiveCountsResponse = {
  ok: boolean;
  decadeCounts?: Record<string, number>;
};

export default function DecadeSelector({
  selectedYear,
  onYearSelect,
}: {
  selectedYear: number | null;
  onYearSelect: (year: number | null) => void;
}) {
  const scrollRef = useRef<HTMLDivElement>(null);

  const selectedDecade = selectedYear ? `${Math.floor(selectedYear / 10) * 10}s` : null;
  const [isOverflowing, setIsOverflowing] = useState(false);
  const [decadeCounts, setDecadeCounts] = useState<Record<string, number>>({});

  useEffect(() => {
    let cancelled = false;

    fetch("/api/archive/counts")
      .then(async (response) => {
        const result = (await response.json()) as ArchiveCountsResponse;
        if (!response.ok || !result.ok) return;

        if (!cancelled) {
          setDecadeCounts(result.decadeCounts ?? {});
        }
      })
      .catch(() => {
        if (!cancelled) {
          setDecadeCounts({});
        }
      });

    return () => {
      cancelled = true;
    };
  }, []);

  useEffect(() => {
    const el = scrollRef.current;
    if (!el) return;

    const checkOverflow = () => {
      setIsOverflowing(el.scrollWidth > el.clientWidth);
    };

    checkOverflow();
    window.addEventListener("resize", checkOverflow);

    return () => window.removeEventListener("resize", checkOverflow);
  }, []);

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

  return (
    <section className="relative overflow-hidden rounded-xl border border-black/5 bg-white/60 backdrop-blur-md">
      <CarouselArrows onLeft={() => scroll("left")} onRight={() => scroll("right")} />

      <div className="px-5 py-3 sm:px-6">
        <div className="w-full">

          {/* Header */}
          <div className="section-header mb-0 flex items-center justify-between gap-3">
            <h2>
              Browse Archive by Decade
            </h2>
          </div>

          {/* DECADE CAROUSEL */}
          <div
            ref={scrollRef}
            className={`flex w-full gap-4 overflow-x-auto scrollbar-none pb-2 transition-all
              ${isOverflowing ? "justify-start" : "justify-center"}
            `}
          >
            {decades.map((decade) => {
              const isActive = selectedDecade === decade;

              return (
                <button
                  key={decade}
                  onClick={() => {
                    const nextYear = yearsByDecade[decade][0] ?? null;
                    onYearSelect(nextYear);
                  }}
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
                </button>
              );
            })}
          </div>

          {/* YEARS */}
          {selectedDecade && (
            <div
              className="mt-3 flex flex-wrap gap-2 justify-center opacity-0 data-[active=true]:opacity-100 transition-opacity duration-300 ease-out"
              data-active={true}
            >
              {yearsByDecade[selectedDecade].map((year) => {
                const isActive = selectedYear === year;

                return (
                  <button
                    key={year}
                    onClick={() => {
                      const newYear = isActive ? null : year;
                      onYearSelect(newYear);
                    }}
                    className="flex-[1_1_60px] max-w-22.5 group"
                  >
                    <div
                      className={`relative h-12 overflow-hidden rounded-lg border shadow-[0_2px_4px_rgba(0,0,0,0.05)]
                        transition-all duration-300 ease-out flex items-center justify-center
                        ${isActive
                          ? "bg-[#8B0000] border-[#8B0000]"
                          : "bg-white border-[#CE1126] hover:bg-[#8B0000] hover:border-[#8B0000]"
                        }
                        group-hover:scale-[1.03]
                      `}
                    >
                      <span
                        className={`text-sm font-medium transition-colors ${
                          isActive ? "text-white" : "text-[#002D62] group-hover:text-white"
                        }`}
                      >
                        {year}
                      </span>
                    </div>
                  </button>
                );
              })}
            </div>
          )}

        </div>
      </div>
    </section>
  );
}
