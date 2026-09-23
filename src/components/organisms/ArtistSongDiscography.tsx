import Image from "next/image";
import { getLocale, getTranslations } from "next-intl/server";
import { Link } from "@/i18n/navigation";
import type { RepertoireRecording } from "@/lib/queries/songCatalog";
import { recordingSongHref } from "@/lib/songIdentity";
import { getPublicReleaseCoverUrl } from "@/lib/releaseCover";

export function SongListRow({ title, year, coverUrl, href }: {
  title: string; year: number | null; coverUrl: string | null; href: string;
}) {
  return (
    <Link href={href} prefetch={false}
      className="group flex w-full min-w-0 items-center gap-2.5 rounded-lg border border-gray-100 bg-gray-50 px-3 py-1.5 transition-colors hover:bg-white focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-(--color-flagblue)">
      <div className="relative h-11 w-11 shrink-0 overflow-hidden rounded-md bg-gray-200">
        {coverUrl ? <Image src={coverUrl} alt="" fill sizes="44px" className="object-cover" unoptimized />
          : <div className="h-full w-full bg-gray-300" />}
      </div>
      <span className="min-w-0 flex-1 truncate text-sm font-normal leading-tight text-(--color-flagblue) underline-offset-4 group-hover:text-(--color-wikicrimson) group-hover:underline">{title}</span>
      <span className="shrink-0 text-xs tabular-nums text-gray-500">{year ?? "—"}</span>
    </Link>
  );
}

export default async function ArtistSongDiscography({ recordings }: { recordings: RepertoireRecording[] }) {
  const [t, locale] = await Promise.all([getTranslations("artist"), getLocale()]);
  const collator = new Intl.Collator(locale, { sensitivity: "base", ignorePunctuation: true, numeric: true });
  const sortedRecordings = [...recordings].sort((a, b) => collator.compare(a.title, b.title));
  return (
    <section id="discography" className="h-fit min-w-0 rounded-xl border border-gray-100 bg-white p-5 shadow-sm sm:p-6">
      <h3 className="mb-5 text-xs font-normal uppercase text-(--color-wikicrimson)">{t("discography")}</h3>
      <div className="grid min-w-0 gap-2">
        {sortedRecordings.map((recording) => <SongListRow key={recording.id} title={recording.title}
          year={recording.year} href={recordingSongHref(recording)}
          coverUrl={recording.has_cover_image && recording.cover_release_id ? getPublicReleaseCoverUrl(recording.cover_release_id, 150) : null} />)}
      </div>
    </section>
  );
}
