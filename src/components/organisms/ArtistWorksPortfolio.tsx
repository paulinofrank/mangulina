import { Fragment } from "react";
import { getArtistWorksPortfolio, summarizePortfolioRoles, type PortfolioWork } from "@/lib/getArtistWorksPortfolio";
import { formatRoleName } from "@/lib/roleNameFormatter";
import { normalizeArtistWorkCreditRole } from "@/lib/artistWorkCreditRoles";
import { Link } from "@/i18n/navigation";

type Translator = Awaited<ReturnType<typeof import("next-intl/server").getTranslations>>;

function roleLabel(role: string, t: Translator) {
  const normalized = normalizeArtistWorkCreditRole(role);
  const key = `workRoles.${normalized}` as const;
  return t.has(key) ? t(key) : formatRoleName(role);
}

function PerformerList({ work }: { work: PortfolioWork }) {
  return (
    <>
      {work.performers.map((performer, index) => {
        const name = performer.creditedAs?.trim() || performer.artistName?.trim();
        if (!name) return null;
        return (
          <Fragment key={`${performer.artistId ?? name}-${index}`}>
            {performer.artistSlug ? (
              <Link
                href={`/artists/${performer.artistSlug}`}
                prefetch={false}
                className="font-medium text-(--color-flagblue) underline-offset-2 transition-colors hover:text-(--color-wikicrimson) hover:underline focus-visible:rounded-sm focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-(--color-flagblue)"
              >
                {name}
              </Link>
            ) : <span>{name}</span>}
            {performer.joinPhrase ? ` ${performer.joinPhrase} ` : index < work.performers.length - 1 ? ", " : ""}
          </Fragment>
        );
      })}
    </>
  );
}

export default async function ArtistWorksPortfolio({ artistId }: { artistId: string }) {
  const { getTranslations } = await import("next-intl/server");
  const t = await getTranslations("artist");
  const works = await getArtistWorksPortfolio(artistId);
  if (!works.length) return null;

  const roleStats = summarizePortfolioRoles(works);
  const yearGroups = new Map<number | null, PortfolioWork[]>();
  for (const work of works) {
    yearGroups.set(work.releaseYear, [...(yearGroups.get(work.releaseYear) ?? []), work]);
  }

  return (
    <section className="min-w-0 rounded-xl border border-gray-100 bg-white p-5 shadow-sm sm:p-6">
      <div className="mb-6">
        <h3 className="mb-4 text-center text-xs font-normal uppercase text-(--color-wikicrimson)">{t("worksAndCredits")}</h3>
        <div className="border-b border-gray-200 pb-6 text-center">
          <div className="mb-4 flex items-baseline justify-center gap-2">
            <p className="text-xl font-black text-(--color-flagblue)">{works.length}</p>
            <p className="text-xl font-medium uppercase tracking-wide text-gray-500">{works.length === 1 ? t("work") : t("works")}</p>
          </div>
          <div className="flex flex-wrap items-center justify-center gap-1">
            {roleStats.map((stat, index) => (
              <div key={stat.role} className="flex items-center gap-1">
                <span className="text-xs font-medium text-(--color-flagblue)">{roleLabel(stat.role, t)}</span>
                <span className="text-xs text-gray-400">({stat.count})</span>
                {index < roleStats.length - 1 && <span className="mx-1 text-xs text-gray-300">•</span>}
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="space-y-2">
        {[...yearGroups].flatMap(([, groupWorks]) => groupWorks.map((work) => (
          <article key={work.id} className="grid grid-cols-1 gap-x-6 gap-y-1 border-b border-gray-100 pb-2 last:border-b-0 lg:grid-cols-[minmax(0,3fr)_minmax(0,2fr)]">
            <div className="min-w-0">
              <h5 className="mb-1 text-sm font-semibold text-(--color-flagblue)">
                {work.recordingSlug ? (
                  <Link
                    href={`/songs/${work.recordingSlug}`}
                    prefetch={false}
                    className="underline-offset-2 hover:text-(--color-wikicrimson) hover:underline focus-visible:rounded-sm focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-(--color-flagblue)"
                  >
                    {work.title}
                  </Link>
                ) : work.title}
              </h5>

              {work.performers.length > 0 && (
                <div className="mb-1 text-sm text-gray-500">
                  <span className="text-gray-400">{t("performedBy")}: </span>
                  <PerformerList work={work} />
                </div>
              )}
            </div>

            <div className="min-w-0">
              {(work.releaseTitle || work.releaseYear) && (
                <div className="mb-1 text-sm text-gray-500">
                  <span className="text-gray-400">{t("worksCreditsRelease")}: </span>
                  {work.releaseTitle && work.releaseSlug ? (
                    <Link
                      href={`/releases/${work.releaseSlug}`}
                      prefetch={false}
                      className="font-medium text-(--color-flagblue) underline-offset-2 hover:text-(--color-wikicrimson) hover:underline focus-visible:rounded-sm focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-(--color-flagblue)"
                    >
                      {work.releaseTitle}
                    </Link>
                  ) : work.releaseTitle}
                  {work.releaseTitle && work.releaseYear ? " • " : ""}
                  {work.releaseYear}
                </div>
              )}

              {work.roles.length > 0 && (
                <div className="text-sm text-gray-600">
                  <span className="text-gray-400">{t("role")}: </span>
                  <span className="font-medium">{work.roles.map((role) => roleLabel(role, t)).join(" • ")}</span>
                </div>
              )}
            </div>
          </article>
        )))}
      </div>
    </section>
  );
}
