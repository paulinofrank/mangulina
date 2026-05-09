import "./globals.css";
import type { Metadata } from "next";
import { Inter, Instrument_Serif } from "next/font/google";
import Navbar from "@/components/Navbar";
import TopBanner from "@/components/TopBanner";
import Footer from "@/components/Footer";

const inter = Inter({ subsets: ["latin"], variable: "--font-outfit" });
const instrumentSerif = Instrument_Serif({ subsets: ["latin"], weight: "400", variable: "--font-serif" });

export const metadata: Metadata = {
  title: "Dominican Music Database | Mangulina",
  description: "Explore artists and songs with lyrics, translations, and cultural notes.",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" className={`${inter.variable} ${instrumentSerif.variable}`} suppressHydrationWarning>
      <body className="min-h-screen relative font-outfit antialiased bg-white">
        {/* Dominican Flag Inspired Background */}
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
        
        <TopBanner />
        <Navbar />

        <div className="pt-24">
          {children}
          <Footer />
        </div>
      </body>
    </html>
  );
}