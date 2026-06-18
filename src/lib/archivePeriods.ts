export const FIRST_ARCHIVE_DECADE = 1920;

export type ArchivePeriod =
  | {
      type: "year";
      slug: string;
      year: number;
      decade: string;
      startYear: number;
      endYear: number;
    }
  | {
      type: "decade";
      slug: string;
      decade: string;
      startYear: number;
      endYear: number;
    };

export function getCurrentArchiveYear() {
  return new Date().getFullYear();
}

export function getDecadeForYear(year: number) {
  return `${Math.floor(year / 10) * 10}s`;
}

export function getYearsForDecade(decade: string, currentYear = getCurrentArchiveYear()) {
  const start = Number(decade.replace("s", ""));
  const currentDecadeStart = Math.floor(currentYear / 10) * 10;
  const end = start === currentDecadeStart ? currentYear : start + 9;

  if (!Number.isInteger(start) || end < start) return [];

  return Array.from({ length: end - start + 1 }, (_, index) => end - index);
}

export function getArchiveDecades(currentYear = getCurrentArchiveYear()) {
  const currentDecadeStart = Math.floor(currentYear / 10) * 10;

  return Array.from(
    { length: (currentDecadeStart - FIRST_ARCHIVE_DECADE) / 10 + 1 },
    (_, index) => `${currentDecadeStart - index * 10}s`,
  );
}

export function parseArchivePeriod(period: string, currentYear = getCurrentArchiveYear()): ArchivePeriod | null {
  if (/^\d{4}$/.test(period)) {
    const year = Number(period);
    const decade = getDecadeForYear(year);

    return {
      type: "year",
      slug: period,
      year,
      decade,
      startYear: year,
      endYear: year,
    };
  }

  if (/^\d{4}s$/.test(period)) {
    const startYear = Number(period.slice(0, 4));
    const currentDecadeStart = Math.floor(currentYear / 10) * 10;
    const endYear = startYear === currentDecadeStart ? currentYear : startYear + 9;

    return {
      type: "decade",
      slug: period,
      decade: period,
      startYear,
      endYear,
    };
  }

  return null;
}
