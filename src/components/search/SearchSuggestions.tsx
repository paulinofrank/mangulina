"use client";

import React, { useEffect, useRef, useState, useCallback, forwardRef, useImperativeHandle } from "react";
import { Link, usePathname, useRouter } from "@/i18n/navigation";
import type { SearchResult } from "@/lib/searchApi";
import { globalSearch, MIN_SEARCH_QUERY_LENGTH } from "@/lib/searchApi";

type SearchSuggestionsProps = {
  searchTerm: string;
  onNavigate?: () => void;
  onStateChange?: (isOpen: boolean, activeDescendant: string | undefined) => void;
  formRef?: React.MutableRefObject<HTMLFormElement | null>;
};

export type SearchSuggestionsHandle = {
  reset: () => void;
};

function getHref(result: SearchResult) {
  if (result.type === "artist" && result.slug) return `/artists/${result.slug}`;
  if (result.type === "song" && result.slug) return `/songs/${result.slug}`;
  if (result.type === "release" && result.slug) return `/releases/${result.slug}`;
  return null;
}

interface SuggestionItemProps {
  result: SearchResult;
  isActive: boolean;
  onMouseEnter: () => void;
  onMouseLeave: () => void;
  onSelect: () => void;
}

const SuggestionItem = forwardRef<HTMLDivElement, SuggestionItemProps>(
  ({ result, isActive, onMouseEnter, onMouseLeave, onSelect }, ref) => {
    const href = getHref(result);
    if (!href) return null;

    const subtitle =
      result.type === "song"
        ? [result.year, result.release_title].filter(Boolean).join(" · ")
        : [result.year, result.subtitle].filter(Boolean).join(" · ");

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
          className={`block px-4 py-3 text-left text-sm transition-colors ${
            isActive
              ? "bg-[#CE1126]/10 text-[#CE1126]"
              : "hover:bg-gray-100 text-gray-800"
          }`}
        >
          <div className="font-medium truncate">{result.title}</div>
          {subtitle && (
            <div className="text-xs text-gray-500 truncate">{subtitle}</div>
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
  const [suggestions, setSuggestions] = useState<SearchResult[]>([]);
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
        const results = await globalSearch(query);
        if (requestId !== requestIdRef.current) return;
        const all = [
          ...results.artists,
          ...results.songs,
          ...results.releases,
        ];
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

  return (
    <div
      ref={suggestionsRef}
      className="absolute top-full left-0 right-0 mt-2 max-h-96 overflow-y-auto rounded-lg border border-[#8B0000]/15 bg-white shadow-lg z-50"
      role="listbox"
      id="site-search-suggestions"
    >
      {suggestions.map((result, index) => (
        <SuggestionItem
          key={`${result.type}-${result.id}`}
          ref={index === activeIndex ? activeItemRef : null}
          result={result}
          isActive={index === activeIndex}
          onMouseEnter={() => setActiveIndex(index)}
          onMouseLeave={() => setActiveIndex(-1)}
          onSelect={() => {
            resetAutocomplete();
            onNavigate?.();
          }}
        />
      ))}
    </div>
  );
});

export default SearchSuggestions;
