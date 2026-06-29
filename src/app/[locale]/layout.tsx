import type { Metadata } from "next";
import { NextIntlClientProvider, hasLocale } from "next-intl";
import { getMessages } from "next-intl/server";
import { notFound } from "next/navigation";

import { routing } from "@/i18n/routing";
import SiteChrome from "@/components/layout/SiteChrome";
import HtmlLangSync from "@/components/HtmlLangSync";
import { createPageMetadata, type SeoLocale } from "@/lib/seo";

const LOCALE_DEFAULT_METADATA: Record<SeoLocale, { title: string; description: string }> = {
  en: {
    title: "Mangulina — The Dominican Music Database",
    description:
      "Explore Dominican artists, songs, albums, genres, awards, and music history.",
  },
  es: {
    title: "Mangulina — La Base de Datos de Música Dominicana",
    description:
      "Explora artistas, canciones, álbumes, géneros, premios e historia de la música dominicana.",
  },
};

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale: routeLocale } = await params;
  const locale: SeoLocale = routeLocale === "es" ? "es" : "en";
  const { title, description } = LOCALE_DEFAULT_METADATA[locale];

  return createPageMetadata({
    title,
    description,
    path: "/",
    locale,
  });
}

// This layout is scoped to the [locale] segment, so it RE-RENDERS whenever the
// locale changes during client-side navigation (e.g. /artists -> /es/artists).
// That is what makes the language switch take effect immediately without a
// manual refresh: NextIntlClientProvider receives the new locale + messages and
// every client component reading useTranslations() updates in place.
export default async function LocaleLayout({
  children,
  params,
}: {
  children: React.ReactNode;
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;

  if (!hasLocale(routing.locales, locale)) {
    notFound();
  }

  const messages = await getMessages();

  return (
    <NextIntlClientProvider locale={locale} messages={messages}>
      <HtmlLangSync locale={locale} />
      {children}
      <SiteChrome />
    </NextIntlClientProvider>
  );
}
