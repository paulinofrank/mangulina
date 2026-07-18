"use client";

import { useRouter } from "@/i18n/navigation";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

type GenreOption = { slug: string; name: string };

export default function GenreTitleSelector({
  currentSlug,
  currentTitle,
  options,
  label,
}: {
  currentSlug: string;
  currentTitle: string;
  options: GenreOption[];
  label: string;
}) {
  const router = useRouter();

  return (
    <div>
      <p className="mb-1 text-xs font-bold uppercase tracking-[0.18em] text-[#CE1126]">
        {label}
      </p>
      <h1 className="text-4xl font-black uppercase tracking-tight text-[#002D62] sm:text-5xl">
        <Select
          value={currentSlug}
          onValueChange={(slug) => router.push(`/genres/${slug}`)}
        >
          <SelectTrigger
            aria-label={label}
            className="-ml-2 inline-flex max-w-full cursor-pointer justify-start gap-3 rounded-lg px-2 py-1 text-left font-inherit uppercase tracking-inherit text-inherit transition-colors hover:bg-[#002D62]/5 focus-visible:ring-2 focus-visible:ring-[#002D62]/40 [&>svg]:h-6 [&>svg]:w-6 [&>svg]:opacity-100 sm:[&>svg]:h-7 sm:[&>svg]:w-7"
          >
            <SelectValue>{currentTitle}</SelectValue>
          </SelectTrigger>
          <SelectContent className="min-w-56">
            {options.map((option) => (
              <SelectItem key={option.slug} value={option.slug}>
                {option.name}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>
      </h1>
    </div>
  );
}
