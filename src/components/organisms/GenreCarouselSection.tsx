"use client";

import { useRef, type ReactNode } from "react";
import SectionCard from "@/components/layout/SectionCard";
import CarouselArrows from "@/components/molecules/CarouselArrows";

type GenreCarouselSectionProps = {
  title: string;
  children: ReactNode;
  className?: string;
};

export default function GenreCarouselSection({
  title,
  children,
  className = "",
}: GenreCarouselSectionProps) {
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

  return (
    <SectionCard>
      <CarouselArrows onLeft={() => scroll("left")} onRight={() => scroll("right")} />

      <div className="section-inner">
        <div className="section-header">
          <h2>{title}</h2>
        </div>

        <div
          ref={scrollRef}
          className={`scrollbar-none flex w-full gap-3 overflow-x-auto pb-2 ${className}`}
        >
          {children}
        </div>
      </div>
    </SectionCard>
  );
}
