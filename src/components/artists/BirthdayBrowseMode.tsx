"use client";

import { useRouter } from "@/i18n/navigation";
import { useTranslations } from "next-intl";

export type BirthdayBrowseModeValue = "month" | "year" | "zodiac";

type BirthdayBrowseModeProps = {
  mode: BirthdayBrowseModeValue;
};

const modes: Array<{
  labelKey: "byMonth" | "byYear" | "byZodiac";
  value: BirthdayBrowseModeValue;
  href: string;
}> = [
  { labelKey: "byMonth", value: "month", href: "/artists/birthdays" },
  { labelKey: "byYear", value: "year", href: "/artists/birthdays?view=year" },
  {
    labelKey: "byZodiac",
    value: "zodiac",
    href: "/artists/birthdays?view=zodiac",
  },
];

export default function BirthdayBrowseMode({ mode }: BirthdayBrowseModeProps) {
  const router = useRouter();
  const t = useTranslations("birthdays.ui");

  return (
    <div className="mx-auto mt-6 grid w-full max-w-xl grid-cols-3 gap-2" aria-label={t("browseAria")}>
      {modes.map((item) => {
        const active = mode === item.value;

        return (
          <button
            key={item.value}
            type="button"
            aria-pressed={active}
            onClick={() => router.push(item.href)}
            className={`cursor-pointer rounded-xl border px-3 py-2 text-xs font-normal transition sm:text-sm ${
              active
                ? "border-[#002D62] bg-[#002D62] text-white"
                : "border-black/10 bg-white text-gray-600 hover:bg-[#002D62]/5"
            }`}
          >
            {t(item.labelKey)}
          </button>
        );
      })}
    </div>
  );
}
