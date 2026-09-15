import type { Metadata } from "next";
import Image from "next/image";
import { Search } from "lucide-react";
import { getLocale, getTranslations } from "next-intl/server";

import { getPathname } from "@/i18n/navigation";
import MainWrapper from "@/components/layout/MainWrapper";
import PageSection from "@/components/layout/PageSection";

// Rendered for every notFound() call under [locale] and, through
// [locale]/[...rest], for any URL that matches no route (dotted paths arrive
// via the afterFiles rewrite in next.config.ts). The locale layout still wraps
// it, so the header (logo, search), the floating bottom nav (Home, Discover,
// language) and the footer stay; the page adds only the message and a search.

export async function generateMetadata(): Promise<Metadata> {
  const t = await getTranslations("notFound");
  return {
    // Absolute: nested layouts (e.g. /artists) add their own "| Mangulina" template.
    title: { absolute: t("metadataTitle") },
    robots: { index: false, follow: false },
  };
}

export default async function NotFound() {
  const locale = await getLocale();
  const t = await getTranslations("notFound");
  const searchAction = getPathname({ href: "/search", locale });

  return (
    // Spacing is kept tight so the page and footer fit a ~957px-tall desktop
    // viewport without scrolling.
    <MainWrapper className="!pb-0">
      <PageSection className="!my-0">
        {/* No card: the content sits directly on the site's gradient background. */}
        <section className="relative px-2 py-10 text-center sm:py-6">
          <Image
            src="/icon.svg"
            alt=""
            aria-hidden="true"
            width={256}
            height={256}
            className="pointer-events-none absolute left-1/2 top-4 h-40 w-40 -translate-x-1/2 opacity-[0.06] sm:top-2 sm:h-52 sm:w-52"
          />

          <div className="relative mx-auto max-w-2xl">
            <p
              aria-hidden="true"
              className="text-7xl font-bold leading-none tracking-tight text-[#CE1126]"
            >
              404
            </p>

            <h1 className="mt-4">
              <span className="block text-sm font-semibold uppercase tracking-widest text-[#8B0000]">
                {t("eyebrow")}
              </span>
              <span className="mt-2 block text-3xl font-bold tracking-tight text-[#002D62] sm:text-4xl">
                {t("title")}
              </span>
            </h1>

            <p className="mx-auto mt-3 max-w-xl text-base leading-relaxed text-gray-700 sm:text-lg">
              {t("body")}
            </p>

            {/* A plain GET form: works before hydration and does not duplicate
                the header's autocomplete ids. No autofocus, so screen reader
                users land on the heading first. */}
            <form
              role="search"
              action={searchAction}
              method="get"
              className="mx-auto mt-6 flex max-w-md items-stretch rounded-full border border-[#8B0000]/15 bg-white shadow-[0_0_8px_rgba(139,0,0,0.08)] transition-all focus-within:border-[#8B0000]/40 focus-within:ring-2 focus-within:ring-[#8B0000] focus-within:ring-offset-2"
            >
              <label htmlFor="not-found-search" className="sr-only">
                {t("searchLabel")}
              </label>
              <input
                id="not-found-search"
                name="q"
                type="search"
                required
                minLength={2}
                autoComplete="off"
                placeholder={t("searchPlaceholder")}
                className="min-w-0 flex-1 rounded-l-full bg-transparent py-2.5 pl-5 pr-2 text-base text-[#002D62] outline-none placeholder:text-gray-500"
              />
              <button
                type="submit"
                aria-label={t("searchSubmit")}
                className="flex shrink-0 cursor-pointer items-center justify-center rounded-r-full border-l border-[#8B0000]/10 px-4 text-[#8B0000]/70 transition-colors hover:bg-[#8B0000]/5 hover:text-[#8B0000] focus-visible:outline-none focus-visible:bg-[#8B0000]/10 focus-visible:text-[#8B0000]"
              >
                <Search className="h-4 w-4" aria-hidden="true" />
              </button>
            </form>
          </div>
        </section>
      </PageSection>
    </MainWrapper>
  );
}
