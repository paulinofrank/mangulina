"use client";

import { useEffect, useState, type RefObject } from "react";

export default function useCarouselEnd(scrollRef?: RefObject<HTMLDivElement | null>) {
  const [atEnd, setAtEnd] = useState(false);

  // Run after every render as conditional carousels can attach the same ref later.
  useEffect(() => {
    const element = scrollRef?.current;
    if (!element) return;

    const measure = () => {
      // scrollLeft can be fractional while scrollWidth/clientWidth are rounded.
      setAtEnd(element.scrollWidth - element.clientWidth - element.scrollLeft <= 1);
    };
    const resize = new ResizeObserver(measure);
    const observeSizes = () => {
      resize.disconnect();
      resize.observe(element);
      element.querySelectorAll<HTMLElement>("*").forEach((child) => resize.observe(child));
      measure();
    };
    const mutations = new MutationObserver(observeSizes);
    mutations.observe(element, { childList: true, subtree: true, characterData: true, attributes: true });
    element.addEventListener("scroll", measure, { passive: true });
    window.addEventListener("resize", measure);
    observeSizes();

    return () => {
      resize.disconnect();
      mutations.disconnect();
      element.removeEventListener("scroll", measure);
      window.removeEventListener("resize", measure);
    };
  });

  return atEnd;
}
