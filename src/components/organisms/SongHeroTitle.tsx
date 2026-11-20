"use client";

import { useEffect, useRef } from "react";

export default function SongHeroTitle({ title }: { title: string }) {
  const titleRef = useRef<HTMLSpanElement>(null);

  useEffect(() => {
    const element = titleRef.current;
    const heading = element?.parentElement;
    if (!element || !heading) return;

    let active = true;
    const fitTitle = () => {
      if (!active) return;
      element.style.removeProperty("--song-title-size");
      const availableWidth = element.clientWidth;
      if (!availableWidth) return;

      const baseSize = parseFloat(getComputedStyle(element).fontSize);
      const minSize = parseFloat(getComputedStyle(document.documentElement).fontSize) * 1.125;
      element.style.whiteSpace = "nowrap";
      const naturalWidth = element.scrollWidth;
      element.style.removeProperty("white-space");

      if (naturalWidth > availableWidth) {
        const fittedSize = Math.max(minSize, Math.floor(baseSize * (availableWidth - 1) / naturalWidth));
        element.style.setProperty("--song-title-size", `${fittedSize}px`);
      }
    };

    const observer = new ResizeObserver(fitTitle);
    observer.observe(heading);
    fitTitle();
    void document.fonts.ready.then(fitTitle);

    return () => {
      active = false;
      observer.disconnect();
    };
  }, [title]);

  return (
    <span ref={titleRef} className="max-md:block max-md:w-full max-md:wrap-anywhere max-md:[font-size:var(--song-title-size,inherit)]">
      {title}
    </span>
  );
}
