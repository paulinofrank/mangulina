"use client";

import { useEffect } from "react";
import { useSearchParams } from "next/navigation";
import { usePathname, useRouter } from "@/i18n/navigation";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

type Option = { slug: string; name: string };

export default function SubgenreSelector({
  options,
  selectedSlug,
  hasInvalidSelection,
  label,
  allLabel,
}: {
  options: Option[];
  selectedSlug: string | null;
  hasInvalidSelection: boolean;
  label: string;
  allLabel: string;
}) {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();

  const updateUrl = (value: string, replace = false) => {
    const params = new URLSearchParams(searchParams.toString());
    if (value === "all") params.delete("subgenre");
    else params.set("subgenre", value);
    const href = `${pathname}${params.size ? `?${params.toString()}` : ""}`;
    if (replace) router.replace(href, { scroll: false });
    else router.push(href, { scroll: false });
  };

  useEffect(() => {
    if (hasInvalidSelection) updateUrl("all", true);
    // Normalize an invalid server-validated value once; search params changing ends the effect.
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [hasInvalidSelection]);

  return (
    <div className="mt-2 w-full max-w-56 px-4">
      <label className="sr-only" htmlFor="genre-subgenre-selector">
        {label}
      </label>
      <Select value={selectedSlug ?? "all"} onValueChange={updateUrl}>
        <SelectTrigger
          id="genre-subgenre-selector"
          aria-label={label}
          className="relative h-10 w-full justify-center rounded-full border border-white/50 bg-white/95 px-10 text-center text-sm font-semibold text-[#002D62] shadow-sm transition-colors hover:bg-white focus-visible:ring-2 focus-visible:ring-white/80 [&>svg]:absolute [&>svg]:right-4"
        >
          <SelectValue />
        </SelectTrigger>
        <SelectContent>
          <SelectItem value="all">{allLabel}</SelectItem>
          {options.map((option) => (
            <SelectItem key={option.slug} value={option.slug}>
              {option.name}
            </SelectItem>
          ))}
        </SelectContent>
      </Select>
    </div>
  );
}
