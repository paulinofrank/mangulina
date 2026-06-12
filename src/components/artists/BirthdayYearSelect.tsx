"use client";

import { usePathname, useRouter, useSearchParams } from "next/navigation";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";

type BirthdayYearSelectProps = {
  years: number[];
  selectedYear?: number;
};

export default function BirthdayYearSelect({
  years,
  selectedYear,
}: BirthdayYearSelectProps) {
  const router = useRouter();
  const pathname = usePathname();
  const searchParams = useSearchParams();

  function handleYearChange(value: string) {
    if (value === "month") {
      router.push(pathname);
      return;
    }

    const params = new URLSearchParams(searchParams.toString());
    params.delete("view");
    params.set("year", value);
    router.push(`${pathname}?${params.toString()}`);
  }

  return (
    <div className="mx-auto mt-3 w-full max-w-64">
      <Select
        value={selectedYear ? String(selectedYear) : undefined}
        onValueChange={handleYearChange}
      >
        <SelectTrigger
          aria-label="Browse artist birthdays by year"
          className="h-10 w-full justify-center rounded-xl border border-[#002D62] bg-white px-4 text-center text-sm text-[#002D62] transition hover:bg-[#002D62]/5 focus-visible:ring-2 focus-visible:ring-[#002D62]/30"
        >
          <SelectValue placeholder="Select Year" className="flex-1 text-center" />
        </SelectTrigger>
        <SelectContent className="text-center">
          <SelectItem value="month">Browse by Month</SelectItem>
        {years.map((year) => (
          <SelectItem key={year} value={String(year)}>
            {year}
          </SelectItem>
        ))}
        </SelectContent>
      </Select>
    </div>
  );
}
