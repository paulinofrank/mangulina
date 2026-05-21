// src/components/DecadeSelector.tsx
"use client";

import { useRef, useState, useEffect } from "react";

const decades = [
  "1920s", "1930s", "1940s", "1950s", "1960s",
  "1970s", "1980s", "1990s", "2000s", "2010s", "2020s"
];

const yearsByDecade: Record<string, number[]> = {
  "1920s": Array.from({ length: 10 }, (_, i) => 1920 + i),
  "1930s": Array.from({ length: 10 }, (_, i) => 1930 + i),
  "1940s": Array.from({ length: 10 }, (_, i) => 1940 + i),
  "1950s": Array.from({ length: 10 }, (_, i) => 1950 + i),
  "1960s": Array.from({ length: 10 }, (_, i) => 1960 + i),
  "1970s": Array.from({ length: 10 }, (_, i) => 1970 + i),
  "1980s": Array.from({ length: 10 }, (_, i) => 1980 + i),
  "1990s": Array.from({ length: 10 }, (_, i) => 1990 + i),
  "2000s": Array.from({ length: 10 }, (_, i) => 2000 + i),
  "2010s": Array.from({ length: 10 }, (_, i) => 2010 + i),
  "2020s": Array.from({ length: 10 }, (_, i) => 2020 + i),
};

export default function DecadeSelector({ onYearSelect }: { onYearSelect: (year: number | null) => void }) {
  const scrollRef = useRef<HTMLDivElement>(null);

  const [selectedDecade, setSelectedDecade] = useState<string | null>(null);
  const [selectedYear, setSelectedYear] = useState<number | null>(null);
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
      <div className="px-5 py-6 sm:px-6">
        <div className="w-full">

          {/* Header */}
          <div className="flex items-center justify-between mb-4">
            <h2 className="text-sm font-medium uppercase tracking-wider text-[#002D62]">
              Browse Archive by Decade
            </h2>

            <div className="hidden sm:flex gap-1.5">
              <button
                onClick={() => scroll("left")}
                className="p-1.5 rounded-md border border-black/5 hover:bg-[#002D62] hover:text-white transition-all shadow-xs cursor-pointer"
              >
                <svg width="16" height="16" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M15 19l-7-7 7-7" />
                </svg>
              </button>

              <button
                onClick={() => scroll("right")}
                className="p-1.5 rounded-md border border-black/5 hover:bg-[#002D62] hover:text-white transition-all shadow-xs cursor-pointer"
              >
                <svg width="16" height="16" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 5l7 7-7 7" />
                </svg>
              </button>
            </div>
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
                    setSelectedDecade(isActive ? null : decade);
                    setSelectedYear(null);
                    onYearSelect(null);
                  }}
                  className="shrink-0 w-28 group"
                >
                  <div
                    className={`relative aspect-[1/0.7] overflow-hidden rounded-lg border transition-all duration-300 ease-out flex flex-col items-center justify-center shadow-[0_2px_4px_rgba(0,0,0,0.05)]
                      ${isActive
                        ? "bg-[#002D62] border-[#002D62]"
                        : "bg-white border-[#B0C4DE] hover:bg-[#002D62] hover:border-[#002D62]"
                      }
                      group-hover:scale-[1.03]
                    `}
                  >
                    <svg
                      width="28"
                      height="28"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.5"
                      className={`mb-1 transition-colors ${
                        isActive ? "text-white" : "text-[#002D62] group-hover:text-white"
                      }`}
                    >
                      <path d="M9 18V5l12-2v13" strokeLinecap="round" strokeLinejoin="round" />
                      <circle cx="6" cy="18" r="3" />
                      <circle cx="18" cy="16" r="3" />
                    </svg>

                    <span
                      className={`text-lg font-semibold transition-colors ${
                        isActive ? "text-white" : "text-[#002D62] group-hover:text-white"
                      }`}
                    >
                      {decade}
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
                      setSelectedYear(newYear);
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
