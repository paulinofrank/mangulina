// src/app/archive/page.tsx

import { Suspense } from "react";
import { permanentRedirect } from "next/navigation";
import { getTranslations } from "next-intl/server";
import MainWrapper from "@/components/layout/MainWrapper";
import PageSection from "@/components/layout/PageSection";
import DecadeTimelineCarousel from "@/components/home/DecadeTimelineCarousel";
import ArchiveClient from "./ArchiveClient";
import { createPageMetadata } from "@/lib/seo";
import { parseArchivePeriod } from "@/lib/archivePeriods";
import { getArchiveCounts } from "@/lib/getSongsByYear";

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

  const archiveCounts = await getArchiveCounts();
  const t = await getTranslations("navigation");

  return (
    <MainWrapper>
      <PageSection>
        <DecadeTimelineCarousel
          decadeCounts={archiveCounts.decadeCounts}
          ctaHref="/"
          ctaLabel={t("home")}
        />
      </PageSection>

      <Suspense fallback={null}>
        <ArchiveClient />
      </Suspense>
    </MainWrapper>
  );
}
