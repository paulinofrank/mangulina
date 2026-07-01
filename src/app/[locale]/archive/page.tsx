// src/app/archive/page.tsx

import { Suspense } from "react";
import { permanentRedirect } from "next/navigation";
import { getTranslations } from "next-intl/server";
import MainWrapper from "@/components/layout/MainWrapper";
import PageSection from "@/components/layout/PageSection";
import DecadeTimelineCarousel from "@/components/home/DecadeTimelineCarousel";
import ArchiveClient, { type ArchiveInitialData } from "./ArchiveClient";
import { createPageMetadata } from "@/lib/seo";
import { parseArchivePeriod } from "@/lib/archivePeriods";
import { ARCHIVE_PAGE_SIZE, getArchiveCacheKey } from "@/lib/archiveShared";
import { getArchiveCounts, getTopSongsByViews } from "@/lib/getSongsByYear";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  return createPageMetadata({
    title: "Dominican Songs & Recordings",
    description:
      "Browse Dominican songs and recordings by year, title and popularity in Mangulina, the Dominican Music Database.",
    path: "/archive",
    locale,
  });
}

export const revalidate = 3600;

type ArchivePageProps = {
  searchParams: Promise<{
    year?: string | string[];
    decade?: string | string[];
    sort?: string | string[];
    page?: string | string[];
  }>;
};

function firstParam(value: string | string[] | undefined) {
  return Array.isArray(value) ? value[0] : value;
}

export default async function ArchivePage({ searchParams }: ArchivePageProps) {
  const params = await searchParams;
  const year = firstParam(params.year);
  const decade = firstParam(params.decade);
  const sort = firstParam(params.sort) === "title" ? "title" : "views";

  if (year && parseArchivePeriod(year)?.type === "year") {
    permanentRedirect(`/archive/${year}`);
  }

  if (decade && parseArchivePeriod(decade)?.type === "decade") {
    permanentRedirect(`/archive/${decade}`);
  }

  const archiveCounts = await getArchiveCounts();
  const songs = await getTopSongsByViews(ARCHIVE_PAGE_SIZE);
  const initialData: ArchiveInitialData = {
    songs,
    total: songs.length,
    hasMore: false,
    cacheKey: getArchiveCacheKey(null, sort, 1),
  };
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
        <ArchiveClient initialData={initialData} />
      </Suspense>
    </MainWrapper>
  );
}
