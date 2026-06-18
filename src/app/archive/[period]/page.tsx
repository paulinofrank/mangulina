import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { Suspense } from "react";

import MainWrapper from "@/components/layout/MainWrapper";
import ArchiveClient from "@/app/archive/ArchiveClient";
import { parseArchivePeriod } from "@/lib/archivePeriods";
import { createPageMetadata } from "@/lib/seo";

type ArchivePeriodPageProps = {
  params: Promise<{ period: string }>;
};

function getArchivePeriodMetadata(periodSlug: string) {
  const period = parseArchivePeriod(periodSlug);
  if (!period) return null;

  if (period.type === "year") {
    return {
      period,
      metadata: createPageMetadata({
        title: `Dominican Music Released in ${period.year} | Mangulina`,
        description: `Browse Dominican music recordings and releases from ${period.year}. Discover artists, songs, and albums from Dominican music history.`,
        path: `/archive/${period.year}`,
      }),
    };
  }

  return {
    period,
    metadata: createPageMetadata({
      title: `Dominican Music from the ${period.decade} | Mangulina`,
      description: `Explore Dominican music from the ${period.decade}, including recordings, releases, artists, and albums from Dominican music history.`,
      path: `/archive/${period.decade}`,
    }),
  };
}

export async function generateMetadata({ params }: ArchivePeriodPageProps): Promise<Metadata> {
  const { period: periodSlug } = await params;
  const result = getArchivePeriodMetadata(periodSlug);

  if (!result) return {};

  return result.metadata;
}

export const revalidate = 3600;

export default async function ArchivePeriodPage({ params }: ArchivePeriodPageProps) {
  const { period: periodSlug } = await params;
  const result = getArchivePeriodMetadata(periodSlug);

  if (!result) notFound();

  return (
    <MainWrapper>
      <Suspense fallback={null}>
        <ArchiveClient period={result.period} />
      </Suspense>
    </MainWrapper>
  );
}
