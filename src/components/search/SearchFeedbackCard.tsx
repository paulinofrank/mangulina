"use client";

import { HeartHandshake, Music2 } from "lucide-react";
import { useLocale, useTranslations } from "next-intl";
import { Link } from "@/i18n/navigation";

export default function SearchFeedbackCard() {
  const locale = useLocale();
  const t = useTranslations("search.feedback");
  const isSpanish = locale === "es";
  const accentClass = isSpanish
    ? "text-(--color-wikicrimson)"
    : "text-(--color-flagblue)";
  const buttonClass = isSpanish
    ? "bg-(--color-wikicrimson) hover:bg-(--color-wikicrimson)/90 focus-visible:outline-(--color-wikicrimson)"
    : "bg-(--color-flagblue) hover:bg-(--color-flagblue)/90 focus-visible:outline-(--color-flagblue)";

  return (
    <aside className="relative overflow-hidden rounded-3xl border border-gray-100 bg-[#fffdf8] p-6 shadow-[0_18px_45px_rgba(0,45,98,0.10)] sm:p-8">
      <div className="absolute inset-x-0 top-0 h-1 bg-linear-to-r from-(--color-flagblue) via-[#D4AF37] to-(--color-wikicrimson)" />
      <Music2
        aria-hidden="true"
        className="pointer-events-none absolute -right-5 -top-6 h-32 w-32 rotate-12 text-(--color-flagblue) opacity-[0.06]"
      />
      <Music2
        aria-hidden="true"
        className="pointer-events-none absolute bottom-5 right-24 hidden h-12 w-12 -rotate-12 text-(--color-wikicrimson) opacity-[0.05] sm:block"
      />

      <div className="relative flex flex-col gap-5 md:flex-row md:items-center md:justify-between">
        <div className="flex flex-col items-center gap-4 text-center sm:flex-row sm:items-start sm:text-left">
          <div
            className={`flex h-14 w-14 shrink-0 items-center justify-center rounded-2xl bg-white shadow-sm ring-1 ring-gray-100 ${accentClass}`}
          >
            <HeartHandshake aria-hidden="true" className="h-7 w-7" />
          </div>

          <div className="max-w-3xl">
            <h2 className={`text-2xl font-black tracking-tight ${accentClass}`}>
              {t("title")}
            </h2>
            <p className="mt-3 text-base leading-7 text-gray-700">
              {t("body")}
            </p>
            <p className="mt-4 border-t-2 border-[#D4AF37] pt-4 text-sm font-semibold leading-6 text-gray-700 sm:border-l-2 sm:border-t-0 sm:pl-4 sm:pt-0">
              {t("footer")}
            </p>
          </div>
        </div>

        <Link
          href="/contact"
          className={`inline-flex w-full shrink-0 items-center justify-center rounded-full px-6 py-3 text-sm font-black uppercase tracking-widest text-white shadow-sm transition focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 md:w-auto ${buttonClass}`}
        >
          {t("button")}
        </Link>
      </div>
    </aside>
  );
}
