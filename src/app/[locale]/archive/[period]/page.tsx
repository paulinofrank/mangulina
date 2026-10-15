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
  params: Promise<{ period: string; locale: string; page?: string }>;
};

function getArchivePeriodMetadata(periodSlug: string, locale?: string, page = 1) {
  const period = parseArchivePeriod(periodSlug);
  if (!period) return null;

  const suffix = page > 1 ? `/page/${page}` : "";
  if (period.type === "year") {
    return {
      period,
      metadata: createPageMetadata({
        title: `Dominican Music Released in ${period.year} | Mangulina`,
        description: `Browse Dominican music recordings and releases from ${period.year}. Discover artists, songs, and albums from Dominican music history.`,
        path: `/archive/${period.year}${suffix}`,
        locale,
      }),
    };
  }

  return {
    period,
    metadata: createPageMetadata({
      title: `Dominican Music from the ${period.decade} | Mangulina`,
      description: `Explore Dominican music from the ${period.decade}, including recordings, releases, artists, and albums from Dominican music history.`,
      path: `/archive/${period.decade}${suffix}`,
      locale,
    }),
  };
}

export async function generateMetadata({ params }: ArchivePeriodPageProps): Promise<Metadata> {
  const { period: periodSlug, locale, page: rawPage } = await params;
  const result = getArchivePeriodMetadata(periodSlug, locale, Number(rawPage ?? 1));

  if (!result) return {};

  return result.metadata;
}

// The archive spans ~118 periods (decades from 1920 plus every year), each
// cached per locale, and the route has no on-demand invalidation — this clock
// is its only freshness path. At 1h that was ~236 URLs expiring 24x a day,
// the largest ISR cost outside the profile routes. Archive listings describe
// historical catalogue, so a day of lag is immaterial.
export const revalidate = 86400; // 24 hours

// Required for this route to be cacheable at all. A dynamic segment with no
// generateStaticParams is rendered per request, so before this the route was
// pure origin compute: every crawler hit on any of ~236 period URLs paid a
// full render. Returning [] prebuilds nothing (the catalogue must never be
// serialized at build time) and lets dynamicParams fill the cache on first
// request, exactly as the profile routes do.
export function generateStaticParams() {
  return [];
}

export default async function ArchivePeriodPage({
  params,
}: ArchivePeriodPageProps) {
  const { period: periodSlug, page: rawPage } = await params;
  const page = Number(rawPage ?? 1);
  if (!Number.isSafeInteger(page) || page < 1 || page > 100000 || (rawPage && (page === 1 || String(page) !== rawPage))) notFound();
  const result = getArchivePeriodMetadata(periodSlug);

  if (!result) notFound();
  const listingPeriod = getArchiveListingPeriod(result.period);
  const initialSongs = listingPeriod
    ? await getSongsByYearRange(listingPeriod.startYear, listingPeriod.endYear, {
        limit: ARCHIVE_PAGE_SIZE,
        offset: (page - 1) * ARCHIVE_PAGE_SIZE,
        sort: "views",
      })
    : { songs: [], total: 0, hasMore: false };
  if (page > 1 && !initialSongs.songs.length) notFound();
  const initialData: ArchiveInitialData = {
    ...initialSongs,
    cacheKey: getArchiveCacheKey(listingPeriod, "views", page),
  };

  return (
    <MainWrapper>
      <Suspense fallback={null}>
        <ArchiveClient period={result.period} initialData={initialData} initialPage={page} />
      </Suspense>
    </MainWrapper>
  );
}
