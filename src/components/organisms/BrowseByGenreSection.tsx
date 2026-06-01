//browse by genre section on homepage
"use client";

import { useRef } from "react";
import Link from "next/link";
import { Church, Disc3, Ellipsis, Flame, Heart, Music, Music4, Sparkles } from "lucide-react";
import CarouselArrows from "@/components/molecules/CarouselArrows";
import SectionCard from "@/components/layout/SectionCard";

export default function BrowseByGenreSection() {
  const scrollRef = useRef<HTMLDivElement>(null);

  const genreGroups = [
    {
      title: "Christian",
      labels: ["Religious", "Catholic"],
      href: "/genres/christian",
      color: "bg-purple-500",
      icon: Church,
    },
    {
      title: "Merengue",
      labels: ["Pambiche", "Típico"],
      href: "/genres/merengue",
      color: "bg-amber-500",
      icon: Music,
    },
    {
      title: "Bachata",
      labels: [],
      href: "/genres/bachata",
      color: "bg-blue-500",
      icon: Heart,
    },
    {
      title: "Salsa",
      labels: [],
      href: "/genres/salsa",
      color: "bg-red-500",
      icon: Flame,
    },
    {
      title: "Urbano",
      labels: ["Dembow", "Reggaeton"],
      href: "/genres/urbano",
      color: "bg-gradient-to-br from-pink-500 to-zinc-700",
      icon: Disc3,
    },
    {
      title: "Instrumental",
      labels: ["Classical"],
      href: "/genres/instrumental",
      color: "bg-[#7A3E1C]",
      icon: Music4,
    },
    {
      title: "Ballads",
      labels: ["Bolero", "Romantic"],
      href: "/genres/ballads",
      color: "bg-teal-500",
      icon: Sparkles,
    },
    {
      title: "More Genre",
      labels: ["Folklore", "Fusion"],
      href: "/genres",
      color: "bg-gray-300",
      icon: Ellipsis,
    },
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
    <SectionCard>
      <CarouselArrows onLeft={() => scroll("left")} onRight={() => scroll("right")} />

      <div className="section-inner">
        <div className="section-header">
          <h2>Explore Music by Genre</h2>
        </div>
        <div
          ref={scrollRef}
          className="scrollbar-none flex w-full gap-3 overflow-x-auto pb-2"
        >
          {genreGroups.map((genre) => {
            const IconComponent = genre.icon;
            return (
              <Link
                key={genre.title}
                href={genre.href}
                className="group relative flex aspect-[4/3] min-w-[138px] flex-col justify-between overflow-hidden rounded-lg p-4 transition-all duration-200 hover:scale-[1.02] sm:min-w-[160px] md:min-w-[180px]"
              >
                <div
                  className={`absolute inset-0 ${genre.color} opacity-75 transition-opacity group-hover:opacity-90`}
                />

                <IconComponent
                  className="relative z-10 h-5 w-5 text-white/90 sm:h-6 sm:w-6"
                  strokeWidth={1.5}
                />

                <div className="relative z-10 text-white">
                  <span className="block text-[15px] font-normal leading-tight sm:text-base md:text-lg">
                    {genre.title}
                  </span>
                  {genre.labels.length > 0 && (
                    <span className="mt-1 block text-[12px] font-normal leading-tight text-white/85 sm:text-[13px]">
                      {genre.labels.join(", ")}
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
