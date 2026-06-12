"use client";

import { useRouter } from "next/navigation";

type BirthdayYearSelectProps = {
  years: number[];
  selectedYear?: number;
};

export default function BirthdayYearSelect({
  years,
  selectedYear,
}: BirthdayYearSelectProps) {
  const router = useRouter();

  function handleYearChange(value: string) {
    router.push(value ? `/artists/birthdays?year=${value}` : "/artists/birthdays");
  }

  return (
    <label className="mx-auto mt-3 block w-full max-w-64">
      <span className="sr-only">Browse artist birthdays by year</span>
      <select
        value={selectedYear ?? ""}
        onChange={(event) => handleYearChange(event.target.value)}
        className="h-10 w-full rounded-xl border border-black/10 bg-white px-4 text-center text-sm text-gray-600 outline-none transition focus:border-[#002D62]"
      >
        <option value="" className="text-center">Select Year</option>
        {years.map((year) => (
          <option key={year} value={year} className="text-center">
            {year}
          </option>
        ))}
      </select>
    </label>
  );
}
