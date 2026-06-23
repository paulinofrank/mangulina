import { NextIntlClientProvider, hasLocale } from "next-intl";
import { getMessages } from "next-intl/server";
import { notFound } from "next/navigation";

import { routing } from "@/i18n/routing";
import SiteChrome from "@/components/layout/SiteChrome";
import HtmlLangSync from "@/components/HtmlLangSync";

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
