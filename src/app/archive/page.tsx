// src/app/archive/page.tsx

import { Suspense } from "react";
import { permanentRedirect } from "next/navigation";
import MainWrapper from "@/components/layout/MainWrapper";
import ArchiveClient from "./ArchiveClient";
import { createPageMetadata } from "@/lib/seo";
import { parseArchivePeriod } from "@/lib/archivePeriods";

export const metadata = createPageMetadata({
  title: "Dominican Songs & Recordings",
  description:
    "Browse Dominican songs and recordings by year, title and popularity in Mangulina, the Dominican Music Database.",
  path: "/archive",
});

export const revalidate = 3600;

type ArchivePageProps = {
  searchParams: Promise<{
    year?: string | string[];
    decade?: string | string[];
  }>;
};

function firstParam(value: string | string[] | undefined) {
  return Array.isArray(value) ? value[0] : value;
}

export default async function ArchivePage({ searchParams }: ArchivePageProps) {
  const params = await searchParams;
  const year = firstParam(params.year);
  const decade = firstParam(params.decade);

  if (year && parseArchivePeriod(year)?.type === "year") {
    permanentRedirect(`/archive/${year}`);
  }

  if (decade && parseArchivePeriod(decade)?.type === "decade") {
    permanentRedirect(`/archive/${decade}`);
  }

  return (
    <MainWrapper>
      {/* ⭐ ARCHIVE INTERACTIVE CLIENT SECTION */}
      <Suspense fallback={null}>
        <ArchiveClient />
      </Suspense>
    </MainWrapper>
  );
}
