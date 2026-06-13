import type { Metadata } from "next";
import { Finlandica, Inter, Instrument_Serif } from "next/font/google";
import { Analytics } from "@vercel/analytics/react";
import { SpeedInsights } from "@vercel/speed-insights/next";
import "./globals.css";

import GradientBackground from "@/components/atoms/GradientBackground";
import SiteChrome from "@/components/layout/SiteChrome";
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

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html
      lang="en"
      className={`${finlandica.variable} ${inter.variable} ${instrumentSerif.variable}`}
    >
      <body className={`${finlandica.className} antialiased min-h-screen`}>
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
        {children}

        <SiteChrome />

        {process.env.NODE_ENV === "production" && <Analytics />}
        {process.env.NODE_ENV === "production" && <SpeedInsights />}
      </body>
    </html>
  );
}
