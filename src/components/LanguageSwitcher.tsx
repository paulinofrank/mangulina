"use client";

import { useTranslations } from "next-intl";
import { useRouter, usePathname } from "next/navigation";
import { ChevronDown } from "lucide-react";
import { useState, useRef, useEffect } from "react";
import {
  getLocaleFromPathname,
  getPathForLocale,
  type AppLocale,
} from "@/i18n/pathname";
import { saveLocalePreference } from "@/i18n/preference";

export default function LanguageSwitcher() {
  const t = useTranslations("language.selector");
  const router = useRouter();
  const pathname = usePathname();
  const locale = getLocaleFromPathname(pathname);
  const [open, setOpen] = useState(false);
  const dropdownRef = useRef<HTMLDivElement>(null);

  const handleLanguageChange = (newLocale: AppLocale) => {
    saveLocalePreference(newLocale);
    const newPath = getPathForLocale(pathname, newLocale);

    if (newPath !== pathname) {
      router.push(newPath);
    }
    setOpen(false);
  };

  useEffect(() => {
    function handleClickOutside(event: MouseEvent) {
      if (
        dropdownRef.current &&
        !dropdownRef.current.contains(event.target as Node)
      ) {
        setOpen(false);
      }
    }

    document.addEventListener("mousedown", handleClickOutside);
    return () => document.removeEventListener("mousedown", handleClickOutside);
  }, []);

  return (
    <div className="relative" ref={dropdownRef}>
      <button
        type="button"
        onClick={() => setOpen(!open)}
        aria-expanded={open}
        aria-haspopup="menu"
        className="flex items-center gap-2 px-3 py-1.5 rounded-full border border-[#002D62]/10 hover:border-[#002D62]/30 transition-colors text-sm font-normal text-gray-700 hover:text-[#002D62] whitespace-nowrap"
      >
        <span>{locale === "en" ? t("english") : t("spanish")}</span>
        <ChevronDown className={`h-4 w-4 transition-transform ${open ? "rotate-180" : ""}`} />
      </button>

      {open && (
        <div className="absolute right-0 mt-2 w-40 rounded-lg border border-[#002D62]/10 bg-white shadow-lg z-50">
          <button
            type="button"
            onClick={() => handleLanguageChange("en")}
            className={`w-full px-4 py-2 text-left text-sm transition-colors ${
              locale === "en"
                ? "bg-[#002D62]/5 text-[#002D62] font-semibold"
                : "text-gray-700 hover:bg-gray-50"
            }`}
          >
            {t("english")}
          </button>
          <button
            type="button"
            onClick={() => handleLanguageChange("es")}
            className={`w-full px-4 py-2 text-left text-sm transition-colors ${
              locale === "es"
                ? "bg-[#CE1126]/5 text-[#CE1126] font-semibold"
                : "text-gray-700 hover:bg-gray-50"
            }`}
          >
            {t("spanish")}
          </button>
        </div>
      )}
    </div>
  );
}
