"use client";

import { formatSubgenreLabel } from "@/lib/subgenreLabel";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { ALL_SUBGENRES, useGenreSubgenre } from "@/components/genres/GenreSubgenreProvider";

/**
 * Subgenre picker. Selection is client state held by GenreSubgenreProvider —
 * it no longer navigates, because a navigation would re-request the route and
 * defeat the genre page's Full Route Cache. The provider keeps `?subgenre=`
 * in the URL so links stay shareable.
 */
export default function SubgenreSelector({
  label,
  allLabel,
  genreName,
}: {
  label: string;
  allLabel: string;
  genreName: string;
}) {
  const { subgenres, selected, select } = useGenreSubgenre();

  return (
    <div className="mt-2 w-fit max-w-full px-4">
      <label className="sr-only" htmlFor="genre-subgenre-selector">
        {label}
      </label>
      <Select value={selected?.slug ?? ALL_SUBGENRES} onValueChange={select}>
        <SelectTrigger
          id="genre-subgenre-selector"
          aria-label={label}
          className="relative h-auto min-h-10 w-full justify-center rounded-full border border-white/50 bg-white/95 px-10 py-2 text-center text-sm font-semibold text-[#002D62] shadow-sm transition-colors hover:bg-white focus-visible:ring-2 focus-visible:ring-white/80 [&>svg]:absolute [&>svg]:right-4"
        >
          <SelectValue />
        </SelectTrigger>
        <SelectContent>
          <SelectItem value={ALL_SUBGENRES}>{allLabel}</SelectItem>
          {subgenres.map((option) => (
            <SelectItem key={option.slug} value={option.slug}>
              {formatSubgenreLabel(genreName, option.name)}
            </SelectItem>
          ))}
        </SelectContent>
      </Select>
    </div>
  );
}
