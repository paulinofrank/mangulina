"use client";

import React, { useEffect, useRef, useState, useCallback, forwardRef, useImperativeHandle } from "react";
import { useTranslations } from "next-intl";
import { Link, usePathname, useRouter } from "@/i18n/navigation";
import { isBornAbroadProvince } from "@/lib/provinceSlug";
import {
  MIN_SEARCH_QUERY_LENGTH,
  type GlobalSearchResponse,
  type SearchResult,
} from "@/lib/searchTypes";

type SearchSuggestionsProps = {
  searchTerm: string;
  onNavigate?: () => void;
  onStateChange?: (isOpen: boolean, activeDescendant: string | undefined) => void;
  formRef?: React.MutableRefObject<HTMLFormElement | null>;
};

export type SearchSuggestionsHandle = {
  reset: () => void;
};

// The API returns up to 10 of each type; the dropdown shows a short preview of
// each section so it stays compact. The full /search page lists everything.
const ARTIST_SUGGESTION_LIMIT = 5;
const SONG_ALBUM_SUGGESTION_LIMIT = 5;
// Songs come first in the "Songs & Albums" section, but when both types match
// albums keep at least this many slots so they are never crowded out.
const MIN_ALBUM_SLOTS = 2;

function pickSongsAndAlbums(songs: SearchResult[], releases: SearchResult[]) {
  const albumSlots = Math.min(
    releases.length,
    Math.max(SONG_ALBUM_SUGGESTION_LIMIT - songs.length, MIN_ALBUM_SLOTS),
  );
  const songSlots = Math.min(songs.length, SONG_ALBUM_SUGGESTION_LIMIT - albumSlots);
  return [
    ...songs.slice(0, songSlots),
    ...releases.slice(0, SONG_ALBUM_SUGGESTION_LIMIT - songSlots),
  ];
}

function getHref(result: SearchResult) {
  if (result.type === "artist" && result.slug) return `/artists/${result.slug}`;
  if (result.type === "song" && result.slug) return `/songs/${result.slug}`;
  if (result.type === "release" && result.slug) return `/releases/${result.slug}`;
  return null;
}

interface SuggestionItemProps {
  result: SearchResult;
  isActive: boolean;
  // Alternate rows get a light tint so each line is easy to follow.
  isStriped: boolean;
  onMouseEnter: () => void;
  onMouseLeave: () => void;
  onSelect: () => void;
}

const SuggestionItem = forwardRef<HTMLDivElement, SuggestionItemProps>(
  ({ result, isActive, isStriped, onMouseEnter, onMouseLeave, onSelect }, ref) => {
    const tDirectory = useTranslations("artistDirectory");
    const tSearch = useTranslations("search.ui");
    const href = getHref(result);
    if (!href) return null;

    // An artist's subtitle is their stored province; the born-abroad sentinel
    // is shown in the page language instead of its stored Spanish form.
    const resultSubtitle =
      result.type === "artist" && isBornAbroadProvince(result.subtitle)
        ? tDirectory("abroadLabel")
        : result.subtitle;
    const subtitle = [result.year, resultSubtitle].filter(Boolean).join(" · ");
    // Songs and albums show only "Title by Artist". Songs carry artist_name;
    // for albums the API puts the release artist in subtitle.
    const artistName = result.type === "artist" ? null : result.artist_name ?? result.subtitle;

    return (
      <div
        id={`search-suggestion-${result.type}-${result.id}`}
        ref={ref}
        onMouseEnter={onMouseEnter}
        onMouseLeave={onMouseLeave}
        role="option"
        aria-selected={isActive}
      >
        <Link
          href={href}
          onClick={onSelect}
          className={`block px-4 py-1.5 text-left text-sm leading-tight transition-colors ${
            isActive
              ? "bg-[#CE1126]/10 text-[#CE1126]"
              : `${isStriped ? "bg-gray-100" : "bg-white"} hover:bg-gray-200 text-gray-800`
          }`}
        >
          {result.type === "artist" ? (
            <>
              <div className="font-medium truncate">{result.title}</div>
              {subtitle && (
                <div className="text-xs leading-tight text-gray-600 truncate">{subtitle}</div>
              )}
            </>
          ) : (
            // Title and "by Artist" share one line from sm up; on phones the
            // dropdown is narrow, so the artist drops below the title.
            <div className="min-w-0 sm:flex sm:items-baseline sm:gap-1">
              <div className="truncate font-medium sm:min-w-0 sm:shrink">{result.title}</div>
              {artistName && (
                <div className="truncate text-xs leading-tight text-gray-600 sm:max-w-[45%] sm:shrink-0">
                  {tSearch("byArtist", { artist: artistName })}
                </div>
              )}
            </div>
          )}
        </Link>
      </div>
    );
  }
);

SuggestionItem.displayName = "SuggestionItem";

const SearchSuggestions = forwardRef<SearchSuggestionsHandle, SearchSuggestionsProps>(function SearchSuggestions({
  searchTerm,
  onNavigate,
  onStateChange,
  formRef,
}, ref) {
  const t = useTranslations("search.ui");
  // One flat list keeps keyboard navigation continuous across both sections:
  // the first `artistCount` entries are artists, the rest songs and albums.
  const [suggestions, setSuggestions] = useState<SearchResult[]>([]);
  const [artistCount, setArtistCount] = useState(0);
  const [activeIndex, setActiveIndex] = useState(-1);
  const [isOpen, setIsOpen] = useState(false);
  const debounceTimerRef = useRef<ReturnType<typeof setTimeout> | undefined>(undefined);
  const suggestionsRef = useRef<HTMLDivElement>(null);
  const activeItemRef = useRef<HTMLDivElement>(null);
  const requestIdRef = useRef(0);
  const router = useRouter();
  const pathname = usePathname();

  const resetAutocomplete = useCallback(() => {
    requestIdRef.current += 1;
    if (debounceTimerRef.current) clearTimeout(debounceTimerRef.current);
    setSuggestions([]);
    setIsOpen(false);
    setActiveIndex(-1);
  }, []);

  useImperativeHandle(ref, () => ({ reset: resetAutocomplete }), [resetAutocomplete]);

  const navigateTo = useCallback((href: string) => {
    resetAutocomplete();
    onNavigate?.();
    router.push(href);
  }, [onNavigate, resetAutocomplete, router]);

  // Define keyboard handler first
  const handleKeyDown = useCallback(
    (e: KeyboardEvent | React.KeyboardEvent) => {
      // Handle both native KeyboardEvent and React.KeyboardEvent
      const event = e as KeyboardEvent;

      if (!isOpen || suggestions.length === 0) {
        if (event.key === "Escape") {
          resetAutocomplete();
        }
        return;
      }

      switch (event.key) {
        case "ArrowDown":
          event.preventDefault();
          setActiveIndex((prev) =>
            prev < suggestions.length - 1 ? prev + 1 : prev
          );
          break;

        case "ArrowUp":
          event.preventDefault();
          setActiveIndex((prev) => (prev > 0 ? prev - 1 : 0));
          break;

        case "Enter":
          if (activeIndex >= 0 && activeIndex < suggestions.length) {
            event.preventDefault();
            const result = suggestions[activeIndex];
            const href = getHref(result);
            if (href) navigateTo(href);
          } else {
            resetAutocomplete();
          }
          break;

        case "Escape":
          event.preventDefault();
          resetAutocomplete();
          break;

        default:
          break;
      }
    },
    [isOpen, suggestions, activeIndex, navigateTo, resetAutocomplete]
  );

  // Fetch suggestions with debounce
  useEffect(() => {
    const requestId = ++requestIdRef.current;
    if (debounceTimerRef.current) {
      clearTimeout(debounceTimerRef.current);
    }

    const query = searchTerm.trim();

    if (query.length < MIN_SEARCH_QUERY_LENGTH) {
      setSuggestions([]);
      setIsOpen(false);
      setActiveIndex(-1);
      return;
    }

    debounceTimerRef.current = setTimeout(async () => {
      try {
        const response = await fetch(
          `/api/search/suggestions?q=${encodeURIComponent(query)}`,
        );
        const payload = (await response.json()) as GlobalSearchResponse & {
          ok?: boolean;
          error?: string;
        };

        if (!response.ok || payload.ok === false) {
          throw new Error(payload.error || "Unable to load search suggestions.");
        }

        const results = payload;
        if (requestId !== requestIdRef.current) return;
        const artists = results.artists.slice(0, ARTIST_SUGGESTION_LIMIT);
        const all = [...artists, ...pickSongsAndAlbums(results.songs, results.releases)];
        setArtistCount(artists.length);
        setSuggestions(all);
        setIsOpen(all.length > 0);
        setActiveIndex(-1);
      } catch (error) {
        if (requestId !== requestIdRef.current) return;
        console.error("Search suggestions error:", error);
        setSuggestions([]);
        setIsOpen(false);
      }
    }, 300);

    return () => {
      if (debounceTimerRef.current) {
        clearTimeout(debounceTimerRef.current);
      }
    };
  }, [searchTerm]);

  useEffect(() => {
    resetAutocomplete();
  }, [pathname, resetAutocomplete]);

  useEffect(() => {
    const handlePointerDown = (event: PointerEvent) => {
      if (formRef?.current && !formRef.current.contains(event.target as Node)) resetAutocomplete();
    };
    document.addEventListener("pointerdown", handlePointerDown);
    return () => document.removeEventListener("pointerdown", handlePointerDown);
  }, [formRef, resetAutocomplete]);

  useEffect(() => {
    const expanded = isOpen && suggestions.length > 0;
    const active = expanded && activeIndex >= 0 && activeIndex < suggestions.length
      ? `search-suggestion-${suggestions[activeIndex].type}-${suggestions[activeIndex].id}`
      : undefined;
    onStateChange?.(expanded, active);
  }, [activeIndex, isOpen, onStateChange, suggestions]);

  // Scroll active item into view
  useEffect(() => {
    if (
      activeIndex >= 0 &&
      activeIndex < suggestions.length &&
      activeItemRef.current
    ) {
      activeItemRef.current.scrollIntoView({
        block: "nearest",
        behavior: "smooth",
      });
    }
  }, [activeIndex, suggestions.length]);

  // Listen to keyboard events from the form
  useEffect(() => {
    const form = formRef?.current;
    if (!form) return;

    const handleFormKeyDown = (e: KeyboardEvent) => {
      if (e.key === "ArrowDown" || e.key === "ArrowUp" || e.key === "Escape" || e.key === "Enter") {
        handleKeyDown(e);
      }
    };

    form.addEventListener("keydown", handleFormKeyDown);
    return () => {
      form.removeEventListener("keydown", handleFormKeyDown);
    };
  }, [formRef, handleKeyDown]);

  if (!isOpen || suggestions.length === 0) {
    return null;
  }

  // A section with no matches is left out entirely, header included.
  const sections = [
    { key: "artists", label: t("artistsGroup"), start: 0, items: suggestions.slice(0, artistCount) },
    { key: "songs-albums", label: t("songsAndAlbumsGroup"), start: artistCount, items: suggestions.slice(artistCount) },
  ].filter((section) => section.items.length > 0);

  return (
    <div
      ref={suggestionsRef}
      className="absolute top-full left-0 right-0 mt-2 max-h-96 overflow-y-auto rounded-lg border border-[#8B0000]/15 bg-white shadow-lg z-50"
      role="listbox"
      id="site-search-suggestions"
    >
      {sections.map((section, sectionIndex) => {
        const labelId = `site-search-suggestions-${section.key}`;
        return (
          <div
            key={section.key}
            role="group"
            aria-labelledby={labelId}
            className={sectionIndex > 0 ? "border-t border-[#8B0000]/10" : undefined}
          >
            <div
              id={labelId}
              role="presentation"
              className="px-4 pb-0.5 pt-2 text-xs leading-tight font-normal uppercase tracking-wider text-[#8B0000]"
            >
              {section.label}
            </div>
            {section.items.map((result, itemIndex) => {
              const index = section.start + itemIndex;
              return (
                <SuggestionItem
                  key={`${result.type}-${result.id}`}
                  ref={index === activeIndex ? activeItemRef : null}
                  result={result}
                  isActive={index === activeIndex}
                  isStriped={itemIndex % 2 === 0}
                  onMouseEnter={() => setActiveIndex(index)}
                  onMouseLeave={() => setActiveIndex(-1)}
                  onSelect={() => {
                    resetAutocomplete();
                    onNavigate?.();
                  }}
                />
              );
            })}
          </div>
        );
      })}
    </div>
  );
});

export default SearchSuggestions;
