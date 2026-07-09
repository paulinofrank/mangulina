
//artistDiscographyaccordion.tsx

import type { DiscographyReleaseSummary } from "@/lib/artistApi";
import ArtistDiscographyRelease from "@/components/organisms/ArtistDiscographyRelease";

const TYPE_ORDER = ["Album", "EP", "Single", "Compilation", "Live", "Other"];

export default async function ArtistDiscographyGrouped({
  releases,
}: {
  releases: DiscographyReleaseSummary[];
}) {
  const { getTranslations } = await import("next-intl/server");
  const t = await getTranslations("artist");

  if (releases.length === 0) {
    return (
      <section className="min-w-0 bg-white p-5 rounded-xl border border-gray-100 shadow-sm sm:p-6">
        <h3 className="text-xs font-normal text-(--color-wikicrimson) uppercase mb-4">
          {t("discography")}
        </h3>

        <p className="text-gray-700 leading-relaxed">
          {t("noDiscography")}
        </p>
      </section>
    );
  }

  const releasesWithCovers = await Promise.all(
    releases.map(async (release) => ({
      release_id: release.release_id,
      release_slug: release.release_slug,
      release_title: release.release_title,
      release_year: release.release_year,
      release_type: release.release_type,
      track_count: release.track_count,
      cover_url: release.cover_url,
    }))
  );

  const grouped = TYPE_ORDER.map((type) => ({
    type,
    items: releasesWithCovers.filter(
      (release) => release.release_type === type
    ),
  })).filter((group) => group.items.length > 0);

  return (
    <section className="h-fit min-w-0 bg-white p-5 rounded-xl border border-gray-100 shadow-sm sm:p-6">
      <h3 className="text-xs font-normal text-(--color-wikicrimson) uppercase mb-5">
        {t("discography")}
      </h3>

      <div className="space-y-7">
        {grouped.map((group) => (
          <div key={group.type}>
            <h4 className="text-sm font-normal uppercase tracking-wider text-(--color-flagblue) mb-2">
              {t(`releaseGroups.${group.type}`)}
            </h4>

            <div className="grid min-w-0 gap-2 2xl:grid-cols-2">
              {group.items.map((release) => (
                <ArtistDiscographyRelease key={release.release_id} release={release} />
              ))}
            </div>
          </div>
        ))}
      </div>
    </section>
  );
}
