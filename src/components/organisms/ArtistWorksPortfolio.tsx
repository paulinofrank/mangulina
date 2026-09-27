import { getArtistWorksPortfolio } from "@/lib/getArtistWorksPortfolio";
import ArtistWorksTabs from "@/components/organisms/ArtistWorksTabs";

function sameArtistName(left: string | null | undefined, right: string) {
  return Boolean(left?.trim()) && left!.trim().localeCompare(right.trim(), undefined, { sensitivity: "base" }) === 0;
}

export default async function ArtistWorksPortfolio({ artistId, artistName }: { artistId: string; artistName: string }) {
  const { getTranslations } = await import("next-intl/server");
  const t = await getTranslations("artist");
  const portfolio = await getArtistWorksPortfolio(artistId);
  if (!portfolio.length) return null;
  const linkedWorks = portfolio.filter((item) =>
    item.recordings.some((recording) => 
      recording.releaseArtistId !== artistId &&
      recording.performers.some((performer) =>
        performer.artistId !== artistId &&
        Boolean(performer.creditedAs?.trim() || performer.artistName?.trim()) &&
        !sameArtistName(performer.creditedAs || performer.artistName, artistName),
      )
    ),
  );
  if (!linkedWorks.length) return null;

  const displayWorks = linkedWorks.map(item => ({
    ...item,
    recordings: item.recordings.map(recording => ({
      ...recording,
      performers: recording.performers.filter(performer => 
        performer.artistId !== artistId &&
        !sameArtistName(performer.creditedAs || performer.artistName, artistName)
      )
    }))
  }));

  return <section className="min-w-0 rounded-xl border border-gray-100 bg-white p-5 shadow-sm sm:p-6">
    <div className="mb-5 text-center"><h3 className="text-sm font-normal uppercase text-(--color-wikicrimson)">{t("creditsCount", { count: displayWorks.length })}</h3></div>
    <ArtistWorksTabs works={displayWorks} />
  </section>;
}
