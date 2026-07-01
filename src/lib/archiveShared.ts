import type { ArchivePeriod } from "@/lib/archivePeriods";

export type ArchiveSort = "title" | "views";

export const ARCHIVE_PAGE_SIZE = 50;

export function getArchiveCacheKey(
  period: ArchivePeriod | null,
  sort: ArchiveSort,
  page: number,
) {
  if (!period) return `archive:songs:top:${sort}:page:${page}`;
  if (period.type === "year") return `archive:songs:${period.year}:${sort}:page:${page}`;
  return `archive:songs:${period.startYear}-${period.endYear}:${sort}:page:${page}`;
}

export function getArchiveListingPeriod(period: ArchivePeriod | null): ArchivePeriod | null {
  if (!period || period.type === "year") return period;

  return {
    type: "year",
    slug: String(period.startYear),
    year: period.startYear,
    decade: period.decade,
    startYear: period.startYear,
    endYear: period.startYear,
  };
}
