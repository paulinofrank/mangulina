"use client";

import { useEffect, useState } from "react";
import { useTranslations, useLocale } from "next-intl";
import { usePathname, useRouter } from "@/i18n/navigation";
import { type AppLocale } from "@/i18n/pathname";
import { saveLocalePreference } from "@/i18n/preference";

export default function LanguageSelectionModal() {
  const t = useTranslations("language.modal");
  const router = useRouter();
  const pathname = usePathname();
  const currentLocale = useLocale() as AppLocale;
  const [showModal, setShowModal] = useState(false);

  useEffect(() => {
    // Check if user has already selected a language
    const hasLocalePreference = document.cookie
      .split("; ")
      .some((cookie) => cookie.startsWith("mangulina_locale="));

    if (!hasLocalePreference) {
      // Show modal on first visit only
      setShowModal(true);
    }
  }, []);

  const handleLanguageSelect = (locale: AppLocale) => {
    // Remember the choice so the modal does not reappear.
    saveLocalePreference(locale);
    setShowModal(false);

    // Send the user to the chosen locale's URL (English stays unprefixed).
    // Preserve query parameters (e.g., ?view=zodiac).
    if (locale !== currentLocale) {
      const search = typeof window !== "undefined" ? window.location.search : "";
      const params = new URLSearchParams(search);
      const query = Object.fromEntries(params.entries());

      router.replace(
        Object.keys(query).length > 0 ? { pathname, query } : pathname,
        { locale },
      );
    }
  };

  if (!showModal) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/50 backdrop-blur-sm">
      <div className="mx-4 rounded-lg bg-white p-8 text-center max-w-md shadow-xl">
        <h2 className="mb-3 text-2xl font-bold text-[#002D62]">{t("title")}</h2>
        <p className="mb-8 text-gray-600">{t("description")}</p>

        <div className="flex gap-4">
          <button
            onClick={() => handleLanguageSelect("en")}
            className="flex-1 rounded-lg border-2 border-[#002D62] bg-[#002D62] px-6 py-3 font-semibold text-white transition-colors hover:bg-[#001a47]"
          >
            {t("english")}
          </button>
          <button
            onClick={() => handleLanguageSelect("es")}
            className="flex-1 rounded-lg border-2 border-[#CE1126] bg-[#CE1126] px-6 py-3 font-semibold text-white transition-colors hover:bg-[#9d0a20]"
          >
            {t("spanish")}
          </button>
        </div>
      </div>
    </div>
  );
}
