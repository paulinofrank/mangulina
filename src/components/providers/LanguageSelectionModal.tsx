"use client";

import { useEffect, useState } from "react";
import { useTranslations } from "next-intl";
import { useRouter, usePathname } from "next/navigation";

export default function LanguageSelectionModal() {
  const t = useTranslations("language.modal");
  const router = useRouter();
  const pathname = usePathname();
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

  const handleLanguageSelect = (locale: "en" | "es") => {
    // Set cookie for 365 days
    const date = new Date();
    date.setTime(date.getTime() + 365 * 24 * 60 * 60 * 1000);
    document.cookie = `mangulina_locale=${locale}; expires=${date.toUTCString()}; path=/`;

    // Redirect to appropriate locale
    if (locale === "en") {
      // Remove /es prefix if exists
      const newPath = pathname.replace(/^\/es/, "") || "/";
      router.push(newPath);
    } else {
      // Add /es prefix if not exists
      const newPath = pathname.startsWith("/es") ? pathname : `/es${pathname}`;
      router.push(newPath);
    }

    setShowModal(false);
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
