"use client";

import { useCallback, useRef, useState } from "react";
import { useTranslations } from "next-intl";
import Image from "next/image";
import { Link, useRouter } from "@/i18n/navigation";
import { Search } from "lucide-react";
import LanguageSwitcher from "@/components/LanguageSwitcher";
import SearchSuggestions, { type SearchSuggestionsHandle } from "@/components/search/SearchSuggestions";

export default function TopBanner() {
  const [searchTerm, setSearchTerm] = useState("");
  const router = useRouter();
  const searchInputRef = useRef<HTMLInputElement>(null);
  const searchFormRef = useRef<HTMLFormElement | null>(null);
  const suggestionsRef = useRef<SearchSuggestionsHandle>(null);
  const [autocompleteState, setAutocompleteState] = useState<{ isOpen: boolean; activeDescendant?: string }>({ isOpen: false });
  const homeHref = "/";
  const searchHref = "/search";
  const t = useTranslations("search");
  const tFooter = useTranslations("footer");

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    const query = searchTerm.trim();
    if (query.length < 2) return;
    suggestionsRef.current?.reset();
    setSearchTerm("");
    router.push(`${searchHref}?q=${encodeURIComponent(query)}`);
  };

  const handleAutocompleteStateChange = useCallback((isOpen: boolean, activeDescendant: string | undefined) => {
    setAutocompleteState({ isOpen, activeDescendant });
  }, []);

  const handleSearchInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setSearchTerm(e.target.value);
  };

  return (
    <header className="fixed top-0 left-0 right-0 z-40 border-b border-black/5 bg-white/80 backdrop-blur-xl">
      <div className="mx-4 sm:mx-8 lg:mx-12 flex h-14 items-center justify-between gap-3">

        {/* Logo */}
        <Link
          href={homeHref}
          className="flex shrink-0 items-center gap-2.5 transition-opacity hover:opacity-90 min-w-0"
        >
          <Image
            src="/icon.svg"
            alt={tFooter("logo")}
            width={47}
            height={47}
            className="h-10 w-10 shrink-0 object-contain"
          />
          <div className="min-w-0 flex flex-col justify-center">
            <p className="truncate text-2xl sm:text-3xl font-medium tracking-tight text-[#002D62] leading-tight">
              Mangulina<span className="tm-fix">&trade;</span>
            </p>
            <p className="hidden sm:block truncate text-xs font-normal uppercase tracking-wider text-[#8B0000]">
              {tFooter("tagline")}
            </p>
          </div>
        </Link>

        {/* Search Bar and Language Switcher */}
        <div className="flex flex-1 justify-end gap-2 max-w-48 xs:max-w-[220px] sm:max-w-sm">
          <form
            ref={searchFormRef}
            onSubmit={handleSearch}
            className="relative flex flex-1 justify-end"
            role="search"
          >
            <label
              htmlFor="site-search"
              className="flex w-full items-center gap-2 rounded-full border border-[#8B0000]/15 bg-white px-3 py-1.5 shadow-[0_0_8px_rgba(139,0,0,0.08)] transition-all focus-within:border-[#8B0000]/30 focus-within:shadow-[0_0_12px_rgba(139,0,0,0.15)]"
            >
              <Search className="h-4 w-4 shrink-0 text-[#8B0000]/50" />
              <input
                id="site-search"
                ref={searchInputRef}
                type="search"
                value={searchTerm}
                onChange={handleSearchInputChange}
                placeholder={t("ui.placeholder")}
                className="w-full min-w-0 bg-transparent text-sm text-[#002D62] outline-none placeholder:text-gray-500"
                role="combobox"
                aria-autocomplete="list"
                aria-haspopup="listbox"
                aria-expanded={autocompleteState.isOpen}
                aria-controls="site-search-suggestions"
                aria-activedescendant={autocompleteState.activeDescendant}
                autoComplete="off"
              />
            </label>
            <SearchSuggestions
              ref={suggestionsRef}
              searchTerm={searchTerm}
              formRef={searchFormRef}
              onNavigate={() => setSearchTerm("")}
              onStateChange={handleAutocompleteStateChange}
            />
          </form>

          {/* Desktop Language Switcher */}
          <div className="hidden sm:block">
            <LanguageSwitcher />
          </div>
        </div>
      </div>
    </header>
  );
}
