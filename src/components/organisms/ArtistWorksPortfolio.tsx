import { getArtistWorksPortfolio } from "@/lib/getArtistWorksPortfolio";
import ArtistWorksTabs from "@/components/organisms/ArtistWorksTabs";

export default async function ArtistWorksPortfolio({ artistId }: { artistId: string }) {
  const { getTranslations } = await import("next-intl/server");
  const t = await getTranslations("artist");
  const portfolio = await getArtistWorksPortfolio(artistId);
  if (!portfolio.length) return null;
  const linkedWorks = portfolio.filter((item) => item.workId || item.recordings.some((recording) => recording.source === "editorial"));

  return <section className="min-w-0 rounded-xl border border-gray-100 bg-white p-5 shadow-sm sm:p-6">
    <div className="mb-5 text-center"><h3 className="mb-3 text-xs font-normal uppercase text-(--color-wikicrimson)">{t("worksAndCredits")}</h3><p className="text-xl font-normal text-(--color-flagblue)">{linkedWorks.length} <span className="uppercase tracking-wide text-gray-500">{linkedWorks.length === 1 ? t("work") : t("works")}</span></p></div>
    <ArtistWorksTabs works={linkedWorks} />
  </section>;
}
