"use client";

import { useRef, type ReactNode } from "react";
import { Link } from "@/i18n/navigation";
import SectionCard from "@/components/layout/SectionCard";
import CarouselArrows from "@/components/molecules/CarouselArrows";

type GenreCarouselSectionProps = {
  title: string;
  children: ReactNode;
  className?: string;
  /**
   * Optional "see all" destination, shown at the right of the heading.
   *
   * The homepage carousels have carried one since they were built; the genre
   * page's did not, so a reader who wanted the rest of a genre's artists had
   * no way out of the carousel. Both label and href are passed in rather than
   * resolved here, because this component is used for more than one kind of
   * list and each one leads somewhere different.
   */
  linkHref?: string;
  linkLabel?: string;
};

export default function GenreCarouselSection({
  title,
  children,
  className = "",
  linkHref,
  linkLabel,
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
          {linkHref && linkLabel ? (
            <Link
              href={linkHref}
              prefetch={false}
              className="text-[#8B0000] hover:text-[#6B0000] font-normal text-sm uppercase tracking-wider transition-colors ml-auto"
            >
              {linkLabel}
            </Link>
          ) : null}
        </div>

        <div
          ref={scrollRef}
          className={`scrollbar-none flex w-full gap-4 overflow-x-auto pb-2 ${className}`}
        >
          {children}
        </div>
      </div>
    </SectionCard>
  );
}
