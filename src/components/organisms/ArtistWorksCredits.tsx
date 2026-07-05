import { Link } from "@/i18n/navigation";
import { useTranslations } from "next-intl";
import { ChevronDown } from "lucide-react";
import { formatRoleName } from "@/lib/roleNameFormatter";
import type { CreditedWork, RoleGroup, YearGroup, WorkByRole, PortfolioSummary } from "@/lib/getArtistCreditedWorks";

export default async function ArtistWorksCredits({
  creditedWorks,
  artistName,
}: {
  creditedWorks: CreditedWork[];
  artistName: string;
}) {
  const { getTranslations } = await import("next-intl/server");
  const t = await getTranslations("artist");
  const tCommon = await getTranslations("common");

  // FILTER: Remove self-credits (where performer_name == current artist name)
  // TODO: Future versions should filter by artist ID instead of name comparison
  // once performer links are fully normalized in the database.
  const filteredWorks = creditedWorks.filter(
    (work) =>
      !work.performer_name ||
      work.performer_name.toLowerCase() !== artistName.toLowerCase()
  );

  if (filteredWorks.length === 0) {
    return null;
  }

  // GROUPING: Organize by role, then by year, building presentation data structure
  const roleMap = new Map<string, WorkByRole[]>();

  for (const row of filteredWorks) {
    if (!roleMap.has(row.role)) {
      roleMap.set(row.role, []);
    }

    // Deduplicate works within a role
    const works = roleMap.get(row.role)!;
    const key = `${row.title}|${row.performer_name}|${row.release_title}|${row.release_year}|${row.recording_id}|${row.release_id}`;
    const exists = works.some(
      (w) =>
        `${w.title}|${w.performer_name}|${w.release_title}|${w.release_year}|${w.recording_id}|${w.release_id}` === key
    );

    if (!exists) {
      works.push({
        title: row.title,
        performer_name: row.performer_name,
        release_title: row.release_title,
        release_year: row.release_year,
        recording_id: row.recording_id,
        release_id: row.release_id,
      });
    }
  }

  // Transform to role groups with year subgroups, sorted by role count DESC
  const roleGroups: RoleGroup[] = Array.from(roleMap.entries())
    .map(([role, works]) => {
      // Group works by year
      const yearMap = new Map<number | null, WorkByRole[]>();
      for (const work of works) {
        const yearKey = work.release_year ?? null;
        if (!yearMap.has(yearKey)) {
          yearMap.set(yearKey, []);
        }
        yearMap.get(yearKey)!.push(work);
      }

      // Transform to year groups, sorted DESC
      const yearGroups: YearGroup[] = Array.from(yearMap.entries())
        .sort(([yearA], [yearB]) => {
          // Nulls (unknown years) go to the end
          if (yearA === null && yearB === null) return 0;
          if (yearA === null) return 1;
          if (yearB === null) return -1;
          return yearB - yearA; // DESC
        })
        .map(([year, yearWorks]) => ({
          year,
          count: yearWorks.length,
          works: yearWorks,
        }));

      return {
        role,
        count: works.length,
        yearGroups,
      };
    })
    .sort((a, b) => b.count - a.count); // Sort roles by count DESC

  // SUMMARY CALCULATION: Portfolio statistics
  const allWorks = Array.from(roleMap.values()).flat();
  const totalWorks = allWorks.length;
  const allYears = allWorks
    .map((w) => w.release_year)
    .filter((y): y is number => y !== null);

  const summary: PortfolioSummary = {
    totalWorks,
    earliestYear: allYears.length > 0 ? Math.min(...allYears) : null,
    latestYear: allYears.length > 0 ? Math.max(...allYears) : null,
  };

  // Format year range for summary
  const yearRangeText =
    summary.earliestYear && summary.latestYear
      ? `${summary.earliestYear}–${summary.latestYear}`
      : null;

  return (
    <section className="min-w-0 bg-white p-5 rounded-xl border border-gray-100 shadow-sm sm:p-6">
      <div className="mb-6">
        <h3 className="text-xs font-normal text-(--color-wikicrimson) uppercase mb-2">
          {t("worksAndCredits") || "Works & Credits"}
        </h3>
        {/* Portfolio Summary */}
        <div className="space-y-1">
          <p className="text-2xl font-black text-(--color-flagblue)">
            {summary.totalWorks}
          </p>
          <p className="text-xs text-gray-500 uppercase tracking-wide">
            {summary.totalWorks === 1 ? tCommon("work") || "Work" : t("works") || "Works"}
            {yearRangeText && <span> • {yearRangeText}</span>}
          </p>
        </div>
      </div>

      {/* Role Accordions (collapsed by default) */}
      <div className="space-y-3">
        {roleGroups.map((roleGroup) => (
          <details
            key={roleGroup.role}
            className="group rounded-lg border border-gray-100 bg-gray-50 open:bg-white"
          >
            <summary className="cursor-pointer list-none px-4 py-3 transition-colors hover:bg-white [&::-webkit-details-marker]:hidden">
              <div className="flex items-center justify-between gap-2">
                <h4 className="text-sm font-normal text-(--color-flagblue) flex-1">
                  {formatRoleName(roleGroup.role)} •{" "}
                  <span className="text-gray-500">
                    {roleGroup.count} {roleGroup.count === 1 ? tCommon("work") || "Work" : t("works") || "Works"}
                  </span>
                </h4>
                <span
                  aria-hidden
                  className="inline-flex h-6 w-6 shrink-0 items-center justify-center rounded-full border border-gray-200 bg-white text-gray-500 shadow-sm transition group-hover:border-[#002D62]/30 group-hover:text-[#002D62] group-open:rotate-180"
                >
                  <ChevronDown className="h-3.5 w-3.5" strokeWidth={2} />
                </span>
              </div>
            </summary>

            {/* Role Content */}
            <div className="border-t border-gray-100 px-4 py-4">
              {/* Desktop: Table Layout */}
              <div className="hidden md:block">
                {/* Table Header (shown once per role) */}
                <div className="grid grid-cols-[2fr_1.5fr_1.5fr] gap-4 mb-4 pb-2 border-b border-gray-200">
                  <div className="text-xs font-medium uppercase tracking-wide text-gray-500">
                    Title
                  </div>
                  <div className="text-xs font-medium uppercase tracking-wide text-gray-500">
                    Performer(s)
                  </div>
                  <div className="text-xs font-medium uppercase tracking-wide text-gray-500 text-right">
                    Release
                  </div>
                </div>

                {/* Year Groups */}
                {roleGroup.yearGroups.map((yearGroup, yearIdx) => (
                  <div key={yearGroup.year ?? "unknown"} className="space-y-2">
                    {/* Year Heading */}
                    <h5 className="text-xs font-medium text-gray-500 uppercase tracking-wide mt-4 mb-2">
                      {yearGroup.year ?? "Year Unknown"}{" "}
                      <span className="text-gray-400">({yearGroup.count})</span>
                    </h5>

                    {/* Works Grid */}
                    <div className="space-y-1">
                      {yearGroup.works.map((work, workIdx) => (
                        <div
                          key={workIdx}
                          className="grid grid-cols-[2fr_1.5fr_1.5fr] gap-4 py-1.5 hover:bg-gray-50"
                        >
                          {/* Title */}
                          <div>
                            {work.recording_id ? (
                              <Link
                                href={`/songs/${work.recording_id}`}
                                className="text-sm text-(--color-flagblue) hover:text-(--color-wikicrimson) hover:underline underline-offset-2 truncate block"
                              >
                                {work.title}
                              </Link>
                            ) : (
                              <span className="text-sm text-(--color-flagblue) truncate block">
                                {work.title}
                              </span>
                            )}
                          </div>

                          {/* Performer(s) */}
                          <div>
                            {work.performer_name && (
                              <span className="text-sm text-gray-700 truncate block">
                                {work.performer_name}
                              </span>
                            )}
                          </div>

                          {/* Release */}
                          <div className="text-right">
                            {work.release_title ? (
                              work.release_id ? (
                                <Link
                                  href={`/releases/${work.release_id}`}
                                  className="text-sm text-gray-700 hover:text-(--color-flagblue) hover:underline underline-offset-2 truncate block"
                                >
                                  {work.release_title}
                                </Link>
                              ) : (
                                <span className="text-sm text-gray-700 truncate block">
                                  {work.release_title}
                                </span>
                              )
                            ) : null}
                          </div>
                        </div>
                      ))}
                    </div>

                    {/* Separator between year groups */}
                    {yearIdx < roleGroup.yearGroups.length - 1 && (
                      <div className="mt-4 mb-2 border-b border-gray-100" />
                    )}
                  </div>
                ))}
              </div>

              {/* Mobile: Compact Layout */}
              <div className="md:hidden space-y-3">
                {roleGroup.yearGroups.map((yearGroup) => (
                  <div key={yearGroup.year ?? "unknown"}>
                    {/* Year Heading */}
                    <h5 className="text-xs font-medium text-gray-500 uppercase tracking-wide mb-2">
                      {yearGroup.year ?? "Year Unknown"}{" "}
                      <span className="text-gray-400">({yearGroup.count})</span>
                    </h5>

                    {/* Works List */}
                    <div className="space-y-2">
                      {yearGroup.works.map((work, idx) => (
                        <div key={idx} className="py-2 hover:bg-gray-50 px-2">
                          {/* Title */}
                          <div className="mb-0.5">
                            {work.recording_id ? (
                              <Link
                                href={`/songs/${work.recording_id}`}
                                className="text-sm font-normal text-(--color-flagblue) hover:text-(--color-wikicrimson) hover:underline underline-offset-2"
                              >
                                {work.title}
                              </Link>
                            ) : (
                              <p className="text-sm font-normal text-(--color-flagblue)">
                                {work.title}
                              </p>
                            )}
                          </div>

                          {/* Performer • Release on one line */}
                          <div className="text-xs text-gray-600">
                            {work.performer_name && work.release_title ? (
                              <>
                                {work.performer_name} •{" "}
                                {work.release_id ? (
                                  <Link
                                    href={`/releases/${work.release_id}`}
                                    className="hover:text-(--color-flagblue) hover:underline underline-offset-1"
                                  >
                                    {work.release_title}
                                  </Link>
                                ) : (
                                  work.release_title
                                )}
                              </>
                            ) : work.performer_name ? (
                              work.performer_name
                            ) : work.release_title ? (
                              work.release_id ? (
                                <Link
                                  href={`/releases/${work.release_id}`}
                                  className="hover:text-(--color-flagblue) hover:underline underline-offset-1"
                                >
                                  {work.release_title}
                                </Link>
                              ) : (
                                work.release_title
                              )
                            ) : null}
                          </div>
                        </div>
                      ))}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </details>
        ))}
      </div>
    </section>
  );
}
