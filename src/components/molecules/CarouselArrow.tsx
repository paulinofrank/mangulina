"use client";

import React from "react";

type CarouselArrowProps = {
  direction: "left" | "right";
  onClick: () => void;
  className?: string;
};

export default function CarouselArrow({
  direction,
  onClick,
  className = "",
}: CarouselArrowProps) {
  const isLeft = direction === "left";

  return (
    <button
      onClick={onClick}
      aria-label={`Scroll ${direction}`}
      className={`
        hidden md:flex absolute top-1/2 -translate-y-1/2 z-20
        p-2 rounded-full bg-white shadow-md border border-black/10
        hover:bg-[#002D62] hover:text-white transition
        ${isLeft ? "left-3" : "right-3"}
        ${className}
      `}
    >
      <svg width="20" height="20" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        {isLeft ? (
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M15 19l-7-7 7-7" />
        ) : (
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={1.5} d="M9 5l7 7-7 7" />
        )}
      </svg>
    </button>
  );
}
