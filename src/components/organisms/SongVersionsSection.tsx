import { getTranslations } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import SongPlatformLinksSection from "@/components/organisms/SongPlatformLinksSection";
import SongPersonnelCredits from "@/components/organisms/SongPersonnelCredits";
import { creditItems, type SongContext } from "@/lib/queries/songCatalog";
import { workSongSlug } from "@/lib/songIdentity";

export default async function SongVersionsSection({ context, workPage = false, labelName, releaseInfo }: {
  context: SongContext; workPage?: boolean; labelName?: string; releaseInfo?: string;
}) {
  const t = await getTranslations("songCatalog");
  const work = context.work;
  return <section className="space-y-5" aria-label={t("versions")}>
    {workPage && <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm sm:p-6">
      <h2 className="mb-3 text-xs font-semibold uppercase tracking-widest text-(--color-wikicrimson)">{t("work")}</h2>
      {work ? <>
        <Link href={`/songs/${workSongSlug(work)}`} className="text-lg text-(--color-flagblue) hover:underline">{work.title}</Link>
        <p className="mt-2 text-sm text-gray-600">{t("workExplanation")}</p>
        <dl className="mt-3 flex flex-wrap gap-x-6 gap-y-2 text-sm">
          {work.composition_year && <div><dt className="text-gray-500">{t("compositionYear")}</dt><dd>{work.composition_year}</dd></div>}
          {work.publication_year && <div><dt className="text-gray-500">{t("publicationYear")}</dt><dd>{work.publication_year}</dd></div>}
          {work.language && <div><dt className="text-gray-500">{t("language")}</dt><dd>{work.language}</dd></div>}
        </dl>
      </> : <p className="text-sm text-gray-600">{t("workPending")}</p>}
    </section>}
    {workPage && <h2 className="text-xl font-medium text-(--color-flagblue)">{t("versions")}</h2>}
    {!context.recordings.length && <p className="text-sm text-gray-600">{t("noRecordings")}</p>}
    {context.recordings.map((recording) => {
      const version = recording.version;
      const versionLabels = [version?.performance_kind ? t(`performance.${version.performance_kind}`) : null,
        version?.derivation_kind ? t(`derivation.${version.derivation_kind}`) : null,
        version?.performance_context, version?.language_code].filter(Boolean);
      return <article key={recording.id} id={`recording-${recording.id}`} className={workPage ? "scroll-mt-8 space-y-4 rounded-xl border border-gray-100 bg-white p-5 shadow-sm sm:p-6" : "scroll-mt-8 space-y-4"}>
        {workPage && <header>
          <h3 className="text-lg font-medium text-(--color-flagblue)">{recording.title}</h3>
          {recording.artist_name && <p className="mt-1 text-sm text-gray-600">{recording.artist_slug
            ? <Link href={`/artists/${recording.artist_slug}`} className="hover:underline">{recording.artist_name}</Link> : recording.artist_name}</p>}
          {versionLabels.length > 0 && <p className="mt-2 text-sm text-gray-600">{versionLabels.join(" · ")}</p>}
        </header>}
        <SongPersonnelCredits workCredits={creditItems(context.work_credits)} recordingCredits={creditItems(recording.credits)}
          labelName={labelName} releaseInfo={releaseInfo} />
        <SongPlatformLinksSection recordingId={recording.id} links={recording.platform_links} />
        {workPage && <Link href={`/songs/${recording.slug ?? recording.id}`} className="inline-block text-sm text-(--color-flagblue) hover:underline">{t("recordingDetails")}</Link>}
      </article>;
    })}
  </section>;
}
