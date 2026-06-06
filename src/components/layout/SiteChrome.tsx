"use client";

import { usePathname } from "next/navigation";

import TopBanner from "@/components/organisms/TopBanner";
import Navbar from "@/components/organisms/Navbar";
import Footer from "@/components/organisms/Footer";

export default function SiteChrome() {
  const pathname = usePathname();
  const isAdmin = pathname?.startsWith("/admin");

  if (isAdmin) return null;

  return (
    <>
      <TopBanner />
      <Navbar />
      <Footer />
    </>
  );
}
