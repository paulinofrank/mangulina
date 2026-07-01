import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { Suspense } from "react";

import MainWrapper from "@/components/layout/MainWrapper";
import ArchiveClient, { type ArchiveInitialData } from "@/app/[locale]/archive/ArchiveClient";
import { parseArchivePeriod } from "@/lib/archivePeriods";
import {
  ARCHIVE_PAGE_SIZE,
  getArchiveCacheKey,
  getArchiveListingPeriod,
} from "@/lib/archiveShared";
import { getSongsByYearRange } from "@/lib/getSongsByYear";
import { createPageMetadata } from "@/lib/seo";

type ArchivePeriodPageProps = {
  params: Promise<{ period: string; locale: string }>;
  searchParams: Promise<Record<string, string | string[] | undefined>>;
};

function getArchivePeriodMetadata(periodSlug: string, locale?: string) {
  const period = parseArchivePeriod(periodSlug);
  if (!period) return null;

  if (period.type === "year") {
    return {
      period,
      metadata: createPageMetadata({
        title: `Dominican Music Released in ${period.year} | Mangulina`,
        description: `Browse Dominican music recordings and releases from ${period.year}. Discover artists, songs, and albums from Dominican music history.`,
        path: `/archive/${period.year}`,
        locale,
      }),
    };
  }

  return {
    period,
    metadata: createPageMetadata({
      title: `Dominican Music from the ${period.decade} | Mangulina`,
      description: `Explore Dominican music from the ${period.decade}, including recordings, releases, artists, and albums from Dominican music history.`,
      path: `/archive/${period.decade}`,
      locale,
    }),
  };
}

export async function generateMetadata({ params }: ArchivePeriodPageProps): Promise<Metadata> {
  const { period: periodSlug, locale } = await params;
  const result = getArchivePeriodMetadata(periodSlug, locale);

  if (!result) return {};

  return result.metadata;
}

export const revalidate = 3600;

function firstParam(value: string | string[] | undefined) {
  return Array.isArray(value) ? value[0] : value;
}

export default async function ArchivePeriodPage({
  params,
  searchParams,
}: ArchivePeriodPageProps) {
  const { period: periodSlug } = await params;
  const result = getArchivePeriodMetadata(periodSlug);

  if (!result) notFound();
  const resolvedSearchParams = await searchParams;
  const sort = firstParam(resolvedSearchParams.sort) === "title" ? "title" : "views";
  const pageParam = Number(firstParam(resolvedSearchParams.page) ?? "1");
  const page = Number.isInteger(pageParam) && pageParam > 0 ? pageParam : 1;
  const listingPeriod = getArchiveListingPeriod(result.period);
  const initialSongs = listingPeriod
    ? await getSongsByYearRange(listingPeriod.startYear, listingPeriod.endYear, {
        limit: ARCHIVE_PAGE_SIZE,
        offset: (page - 1) * ARCHIVE_PAGE_SIZE,
        sort,
      })
    : { songs: [], total: 0, hasMore: false };
  const initialData: ArchiveInitialData = {
    ...initialSongs,
    cacheKey: getArchiveCacheKey(listingPeriod, sort, page),
  };

  return (
    <MainWrapper>
      <Suspense fallback={null}>
        <ArchiveClient period={result.period} initialData={initialData} />
      </Suspense>
    </MainWrapper>
  );
}
