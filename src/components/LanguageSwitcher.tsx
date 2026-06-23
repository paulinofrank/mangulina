"use client";

import { useTranslations, useLocale } from "next-intl";
import { usePathname, useRouter } from "@/i18n/navigation";
import { type AppLocale } from "@/i18n/pathname";

export default function LanguageSwitcher() {
  const t = useTranslations("language.selector");
  const router = useRouter();
  const pathname = usePathname();
  const locale = useLocale() as AppLocale;

  const handleLanguageChange = (newLocale: AppLocale) => {
    if (newLocale !== locale) {
      // Navigate to the same page in the target locale: /artists <-> /es/artists.
      // The URL is the source of truth; next-intl persists the preference cookie.
      // Preserve query parameters (e.g., ?view=zodiac).
      const search = typeof window !== "undefined" ? window.location.search : "";
      const params = new URLSearchParams(search);
      const query = Object.fromEntries(params.entries());

      router.replace(
        Object.keys(query).length > 0 ? { pathname, query } : pathname,
        { locale: newLocale },
      );
    }
  };

  const options: Array<{ value: AppLocale; label: string; activeClass: string }> = [
    { value: "en", label: t("english"), activeClass: "bg-[#002D62] text-white" },
    { value: "es", label: t("spanish"), activeClass: "bg-[#CE1126] text-white" },
  ];

  return (
    <div
      role="group"
      aria-label={t("label")}
      className="inline-flex items-center rounded-full border border-[#002D62]/10 bg-white p-0.5"
    >
      {options.map((option) => {
        const isActive = locale === option.value;
        return (
          <button
            key={option.value}
            type="button"
            onClick={() => handleLanguageChange(option.value)}
            aria-pressed={isActive}
            className={`cursor-pointer rounded-full px-3 py-1 text-sm font-normal whitespace-nowrap transition-colors ${
              isActive ? option.activeClass : "text-gray-600 hover:text-[#002D62]"
            }`}
          >
            {option.label}
          </button>
        );
      })}
    </div>
  );
}
