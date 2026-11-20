import { getArtistWorksPortfolio } from "@/lib/getArtistWorksPortfolio";
import ArtistWorksTabs from "@/components/organisms/ArtistWorksTabs";
import { externalPortfolioWorks } from "@/lib/artistPortfolioPresentation";
import { supabase } from "@/lib/supabase";

export default async function ArtistWorksPortfolio({ artistId, artistName, coverTitles }: {
  artistId: string;
  artistName: string;
  coverTitles: Record<string, string>;
}) {
  const { getTranslations } = await import("next-intl/server");
  const t = await getTranslations("artist");
  const portfolio = await getArtistWorksPortfolio(artistId);
  if (!portfolio.length) return null;
  const linkedWorks = externalPortfolioWorks(portfolio, artistId, artistName);
  if (!linkedWorks.length) return null;

  const missingCoverIds = [...new Set(linkedWorks.flatMap((work) =>
    work.recordings.flatMap((recording) => {
      const id = recording.coverReleaseId;
      return recording.hasCoverImage && id && !coverTitles[id]
        && !(id === recording.releaseId && recording.releaseTitle) ? [id] : [];
    }),
  ))];
  const resolvedCoverTitles = { ...coverTitles };
  for (let offset = 0; offset < missingCoverIds.length; offset += 100) {
    const { data, error } = await supabase.from("releases").select("id,title")
      .in("id", missingCoverIds.slice(offset, offset + 100));
    if (error) {
      console.error("Unable to load portfolio cover titles", error.message);
      break;
    }
    for (const release of data ?? []) {
      if (release.title) resolvedCoverTitles[release.id] = release.title;
    }
  }

  return <section className="min-w-0 rounded-xl border border-gray-100 bg-white p-5 shadow-sm sm:p-6">
    <div className="mb-5 text-center"><h3 className="text-sm font-normal uppercase text-(--color-wikicrimson)">{t("creditsCount", { count: linkedWorks.length })}</h3></div>
    <ArtistWorksTabs works={linkedWorks} coverTitles={resolvedCoverTitles} />
  </section>;
}
