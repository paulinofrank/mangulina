"use client";

import { useEffect } from "react";
import { useTranslations } from "next-intl";
import { Link } from "@/i18n/navigation";
import { trackSearchSuggestion } from "@/lib/analytics";
import type { SearchMetadata } from "@/lib/searchTypes";

export default function SearchCorrection({ query, search, onSelect }: { query: string; search?: SearchMetadata; onSelect?: () => void }) {
  const t = useTranslations("search.ui");
  useEffect(() => {
    if (search?.suggestion?.slug) trackSearchSuggestion(query, search, "suggestion_displayed");
  }, [query, search]);
  const suggestion = search?.suggestion;
  if (!suggestion?.slug) return null;
  const path = suggestion.type === "artist" ? "artists" : suggestion.type === "song" ? "songs" : "releases";
  return <p className="px-4 py-2 text-sm text-gray-600">
    {t("didYouMean")} <Link href={`/${path}/${suggestion.slug}`} className="font-semibold underline" onClick={() => {
      if (search) trackSearchSuggestion(query, search, "suggestion_selected");
      onSelect?.();
    }}>{suggestion.text}</Link>
  </p>;
}
