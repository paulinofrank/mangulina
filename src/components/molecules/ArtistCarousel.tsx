"use client";

import { forwardRef, type ReactNode } from "react";

import CarouselSeeAllCard from "./CarouselSeeAllCard";

type ArtistCarouselProps = {
  children: ReactNode;
  seeAllHref?: string;
  seeAllLabel?: string;
};

const ArtistCarousel = forwardRef<HTMLDivElement, ArtistCarouselProps>(
  function ArtistCarousel({ children, seeAllHref, seeAllLabel }, ref) {
    return (
      <div ref={ref} className="w-full overflow-x-auto pb-2 scrollbar-none">
        <div className="flex w-max min-w-full justify-center gap-4">
          {children}
          {seeAllHref && seeAllLabel ? <CarouselSeeAllCard href={seeAllHref} label={seeAllLabel} /> : null}
        </div>
      </div>
    );
  },
);

export default ArtistCarousel;
