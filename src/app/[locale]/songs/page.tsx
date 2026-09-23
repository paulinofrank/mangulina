import { getTranslations, setRequestLocale } from "next-intl/server";
import MainWrapper from "@/components/layout/MainWrapper";
import PageSection from "@/components/layout/PageSection";
import { SongListRow } from "@/components/organisms/ArtistSongDiscography";
import { Link } from "@/i18n/navigation";
import { getSongDirectory } from "@/lib/queries/songCatalog";
import { getPublicReleaseCoverUrl } from "@/lib/releaseCover";
import { createPageMetadata } from "@/lib/seo";

type Props = { params: Promise<{ locale: string }>; searchParams: Promise<{ page?: string; q?: string }> };
export async function generateMetadata({ params }: Props) {
  const { locale } = await params;
  const t = await getTranslations({ locale, namespace: "songCatalog" });
  return createPageMetadata({ title: t("title"), description: t("description"), path: "/songs", locale });
}

export default async function SongsPage({ params, searchParams }: Props) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("songCatalog");
  const query = await searchParams;
  const parsedPage = Number(query.page ?? 1);
  const page = Number.isSafeInteger(parsedPage) ? Math.max(1, Math.min(100000, parsedPage)) : 1;
  const search = typeof query.q === "string" ? query.q.trim().slice(0,120) : "";
  const data = await getSongDirectory(page, search);
  const pageHref = (number: number) => `/songs?${new URLSearchParams({ page: String(number), ...(search ? { q: search } : {}) })}`;
  return <MainWrapper><PageSection className="mt-4">
    <div className="mx-auto max-w-4xl space-y-5">
      <header className="rounded-xl border border-gray-100 bg-white p-6 shadow-sm">
        <h1 className="text-3xl font-semibold text-(--color-flagblue)">{t("title")}</h1>
        <p className="mt-3 text-gray-600">{t("description")}</p>
        <form className="mt-5 flex gap-2">
          <label className="sr-only" htmlFor="song-search">{t("search")}</label>
          <input id="song-search" name="q" defaultValue={search} maxLength={120} placeholder={t("search")}
            className="min-w-0 flex-1 rounded-md border border-gray-300 px-3 py-2" />
          <button className="rounded-md bg-(--color-flagblue) px-4 py-2 text-white">{t("search")}</button>
        </form>
      </header>
      <div className="grid gap-2">
        {data.entries.map((song) => <SongListRow key={song.identity} title={song.title} year={song.year}
          href={`/songs/${song.slug}`} coverUrl={song.cover_release_id && song.has_cover_image ? getPublicReleaseCoverUrl(song.cover_release_id,150) : null} />)}
        {!data.entries.length && <p>{t("empty")}</p>}
      </div>
      <nav aria-label={t("pagination")} className="flex items-center justify-between gap-4 text-sm text-(--color-flagblue)">
        {page > 1 ? <Link href={pageHref(page-1)}>{t("previous")}</Link> : <span />}
        <span>{t("page", { page, total: Math.max(1, Math.ceil(data.total/48)) })}</span>
        {page*48 < data.total ? <Link href={pageHref(page+1)}>{t("next")}</Link> : <span />}
      </nav>
    </div>
  </PageSection></MainWrapper>;
}
