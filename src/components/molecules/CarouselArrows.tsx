"use client";

import type { RefObject } from "react";
import useCarouselEnd from "./useCarouselEnd";
import { useTranslations } from "next-intl";

type CarouselArrowsProps = {
  scrollRef?: RefObject<HTMLDivElement | null>;
  onLeft: () => void;
  onRight: () => void;
};

export default function CarouselArrows({ onLeft, onRight, scrollRef }: CarouselArrowsProps) {
  const atEnd = useCarouselEnd(scrollRef);
  const t = useTranslations("a11y");

  return (
    <>
      {/* LEFT ARROW */}
      <button
        onClick={onLeft}
        className="hidden md:flex absolute left-3 top-1/2 -translate-y-1/2 
                 z-20 p-2 rounded-full cursor-pointer bg-white shadow-md border border-black/10 
                 hover:bg-[#002D62] hover:text-white transition"
        aria-label={t("scrollLeft")}
      >
        <svg width="20" height="20" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M15 19l-7-7 7-7" />
        </svg>
      </button>

      {/* RIGHT ARROW */}
      <button
        onClick={onRight}
        className={`${atEnd ? "hidden" : "hidden md:flex"} absolute right-3 top-1/2 -translate-y-1/2
                 z-20 p-2 rounded-full cursor-pointer bg-white shadow-md border border-black/10 
                 hover:bg-[#002D62] hover:text-white transition`}
        aria-label={t("scrollRight")}
      >
        <svg width="20" height="20" fill="none" viewBox="0 0 24 24" stroke="currentColor">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 5l7 7-7 7" />
        </svg>
      </button>
    </>
  );
}
