"use client";

import { useRouter } from "next/navigation";

export type BirthdayBrowseModeValue = "month" | "year" | "zodiac";

type BirthdayBrowseModeProps = {
  mode: BirthdayBrowseModeValue;
};

const modes: Array<{
  label: string;
  value: BirthdayBrowseModeValue;
  href: string;
}> = [
  { label: "By Month", value: "month", href: "/artists/birthdays" },
  { label: "By Year", value: "year", href: "/artists/birthdays?view=year" },
  {
    label: "By Zodiacal Sign",
    value: "zodiac",
    href: "/artists/birthdays?view=zodiac",
  },
];

export default function BirthdayBrowseMode({ mode }: BirthdayBrowseModeProps) {
  const router = useRouter();

  return (
    <div className="mx-auto mt-6 grid w-full max-w-xl grid-cols-3 gap-2" aria-label="Browse birthdays by">
      {modes.map((item) => {
        const active = mode === item.value;

        return (
          <button
            key={item.value}
            type="button"
            aria-pressed={active}
            onClick={() => router.push(item.href)}
            className={`rounded-xl border px-3 py-2 text-xs font-normal transition sm:text-sm ${
              active
                ? "border-[#002D62] bg-[#002D62] text-white"
                : "border-black/10 bg-white text-gray-600 hover:bg-[#002D62]/5"
            }`}
          >
            {item.label}
          </button>
        );
      })}
    </div>
  );
}
