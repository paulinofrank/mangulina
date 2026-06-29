import type { Metadata } from "next";
import { Finlandica, Inter, Instrument_Serif } from "next/font/google";
import { Analytics } from "@vercel/analytics/react";
import { SpeedInsights } from "@vercel/speed-insights/next";
import { NextIntlClientProvider } from "next-intl";
import { getLocale, getMessages } from "next-intl/server";
import "./globals.css";

import GradientBackground from "@/components/atoms/GradientBackground";
import RoutePageView from "@/components/analytics/RoutePageView";
import { DEFAULT_DESCRIPTION, SITE_NAME, SITE_URL } from "@/lib/seo";

const finlandica = Finlandica({
  subsets: ["latin"],
  weight: ["400", "500", "600", "700"],
  variable: "--font-finlandica",
});

const inter = Inter({
  subsets: ["latin"],
  variable: "--font-inter",
});

const instrumentSerif = Instrument_Serif({
  subsets: ["latin"],
  weight: "400",
  variable: "--font-serif",
});

export const metadata: Metadata = {
  metadataBase: new URL(SITE_URL),
  title: {
    default: "Mangulina | Dominican Music Database",
    template: "%s | Mangulina",
  },
  description: DEFAULT_DESCRIPTION,
  applicationName: SITE_NAME,
  manifest: "/site.webmanifest",
  icons: {
    icon: [
      { url: "/favicon.ico", sizes: "any" },
      { url: "/favicon.svg", type: "image/svg+xml" },
      { url: "/favicon-96x96.png", sizes: "96x96", type: "image/png" },
    ],
    apple: [
      { url: "/apple-touch-icon.png", sizes: "180x180", type: "image/png" },
    ],
  },
  openGraph: {
    type: "website",
    siteName: SITE_NAME,
    title: "Mangulina | Dominican Music Database",
    description: DEFAULT_DESCRIPTION,
    url: SITE_URL,
  },
  twitter: {
    card: "summary",
    title: "Mangulina | Dominican Music Database",
    description: DEFAULT_DESCRIPTION,
  },
};

export default async function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const locale = await getLocale();
  const messages = await getMessages();

  return (
    <html
      lang={locale}
      className={`${finlandica.variable} ${inter.variable} ${instrumentSerif.variable}`}
    >
      <body className={`${finlandica.className} antialiased min-h-screen`}>
        <NextIntlClientProvider locale={locale} messages={messages}>
          <GradientBackground />

          <div
            className="fixed inset-0 -z-20 pointer-events-none"
            style={{
              background: `
                linear-gradient(135deg, rgba(0, 45, 98, 0.08) 0%, transparent 35%),
                linear-gradient(45deg, transparent 65%, rgba(206, 17, 38, 0.08) 100%),
                radial-gradient(ellipse at 50% 0%, rgba(0, 45, 98, 0.12) 0%, transparent 50%),
                radial-gradient(ellipse at 100% 100%, rgba(206, 17, 38, 0.12) 0%, transparent 50%)
              `,
            }}
          />

          {/* IMPORTANT: no padding wrapper here */}
          <RoutePageView />
          {children}

          {/* SiteChrome (TopBanner/Navbar/Footer/modal) is rendered by
              app/[locale]/layout.tsx so it re-renders with the active locale. */}

          {process.env.NODE_ENV === "production" && <Analytics />}
          {process.env.NODE_ENV === "production" && <SpeedInsights />}
        </NextIntlClientProvider>
      </body>
    </html>
  );
}
