import { getArtistWorksPortfolio, getArtistWorksPortfolioRoleSummary } from "@/lib/getArtistWorksPortfolio";
import { formatRoleName } from "@/lib/roleNameFormatter";

function getRoleTranslation(role: string, locale: string): string {
  if (locale === "es") {
    const roleMap: { [key: string]: string } = {
      producer: "Productor",
      composer: "Compositor",
      arranger: "Arreglista",
      "co-producer": "Co-productor",
      "executive producer": "Productor Ejecutivo",
      "mastering engineer": "Ingeniero de Masterización",
      "mix engineer": "Ingeniero de Mezcla",
      "beat programmer": "Creador de Ritmos",
      remixer: "Remezclador",
    };
    return roleMap[role.toLowerCase()] || formatRoleName(role);
  }
  return formatRoleName(role);
}

interface YearGroup {
  year: number | null;
  works: Array<{
    id: string;
    title: string;
    performer_text: string | null;
    release_title: string | null;
    release_year: number | null;
    roles: string[];
  }>;
}

interface ProcessedData {
  yearGroups: YearGroup[];
  totalWorks: number;
  roleStats: Array<{ role: string; count: number }>;
}

async function processPortfolioData(artistId: string): Promise<ProcessedData> {
  const [works, roleSummary] = await Promise.all([
    getArtistWorksPortfolio(artistId),
    getArtistWorksPortfolioRoleSummary(artistId),
  ]);

  if (works.length === 0) {
    return {
      yearGroups: [],
      totalWorks: 0,
      roleStats: [],
    };
  }

  // Group by year
  const yearMap = new Map<number | null, YearGroup["works"]>();
  for (const work of works) {
    const year = work.release_year ?? null;
    if (!yearMap.has(year)) {
      yearMap.set(year, []);
    }
    yearMap.get(year)!.push(work);
  }

  // Sort years descending (null at end)
  const yearGroups: YearGroup[] = Array.from(yearMap.entries())
    .sort(([yearA], [yearB]) => {
      if (yearA === null && yearB === null) return 0;
      if (yearA === null) return 1;
      if (yearB === null) return -1;
      return yearB - yearA;
    })
    .map(([year, groupWorks]) => ({
      year,
      works: groupWorks,
    }));

  return {
    yearGroups,
    totalWorks: works.length,
    roleStats: roleSummary,
  };
}

export default async function ArtistWorksPortfolio({ artistId }: { artistId: string }) {
  const { getTranslations, getLocale } = await import("next-intl/server");
  const t = await getTranslations("artist");
  const locale = await getLocale();

  const data = await processPortfolioData(artistId);

  if (data.totalWorks === 0) {
    return null;
  }

  const { yearGroups, totalWorks, roleStats } = data;

  return (
    <section className="min-w-0 bg-white p-5 rounded-xl border border-gray-100 shadow-sm sm:p-6">
      {/* Header */}
      <div className="mb-6">
        <h3 className="text-xs font-normal text-(--color-wikicrimson) uppercase mb-4 text-center">
          {t("worksAndCredits") || "Works & Credits"}
        </h3>

        {/* Portfolio Summary - Centered with Cloud Style */}
        <div className="text-center pb-6 border-b border-gray-200">
          <div className="flex justify-center items-baseline gap-2 mb-4">
            <p className="text-xl font-black text-(--color-flagblue)">
              {totalWorks}
            </p>
            <p className="text-xl text-gray-500 uppercase tracking-wide font-medium">
              {totalWorks === 1 ? t("work") : t("works")}
            </p>
          </div>

          {/* Role Summary Cloud - Centered with vertical dots */}
          {roleStats.length > 0 && (
            <div className="flex flex-wrap justify-center gap-1 items-center">
              {roleStats.map((stat, idx) => (
                <div key={stat.role} className="flex items-center gap-1">
                  <span className="text-xs font-medium text-(--color-flagblue)">
                    {getRoleTranslation(stat.role, locale)}
                  </span>
                  <span className="text-xs text-gray-400">
                    ({stat.count})
                  </span>
                  {idx < roleStats.length - 1 && (
                    <span className="text-xs text-gray-300 mx-1">•</span>
                  )}
                </div>
              ))}
            </div>
          )}
        </div>
      </div>

      {/* Works List */}
      <div className="space-y-2">
        {yearGroups.flatMap((yearGroup) =>
          yearGroup.works.map((work) => (
            <div
              key={work.id}
              className="pb-2 border-b border-gray-100 last:border-b-0"
            >
              {/* Year • Title */}
              <h5 className="text-sm font-semibold text-(--color-flagblue) mb-1">
                {work.release_year ?? "Year Unknown"} • {work.title}
              </h5>

              {/* Roles */}
              <div className="text-xs text-gray-600">
                <span className="text-gray-400">{t("role")}: </span>
                <span className="font-medium">
                  {work.roles.map((role) => getRoleTranslation(role, locale)).join(", ")}
                </span>
              </div>

              {/* Metadata: Performer, Release */}
              <div className="text-xs text-gray-500 space-y-0">
                {work.performer_text && (
                  <div>
                    <span className="text-gray-400">{t("performer")}: </span>
                    <span>{work.performer_text}</span>
                  </div>
                )}

                {work.release_title && (
                  <div>
                    <span className="text-gray-400">{t("release")}: </span>
                    <span>{work.release_title}</span>
                  </div>
                )}
              </div>
            </div>
          ))
        )}
      </div>
    </section>
  );
}
