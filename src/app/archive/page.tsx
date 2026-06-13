// src/app/archive/page.tsx

import { Suspense } from "react";
import MainWrapper from "@/components/layout/MainWrapper";
import ArchiveClient from "./ArchiveClient";
import { createPageMetadata } from "@/lib/seo";

export const metadata = createPageMetadata({
  title: "Dominican Songs & Recordings",
  description:
    "Browse Dominican songs and recordings by year, title and popularity in Mangulina, the Dominican Music Database.",
  path: "/archive",
});

export const revalidate = 3600;

export default function ArchivePage() {
  return (
    <MainWrapper>
      {/* ⭐ ARCHIVE INTERACTIVE CLIENT SECTION */}
      <Suspense fallback={null}>
        <ArchiveClient />
      </Suspense>
    </MainWrapper>
  );
}
