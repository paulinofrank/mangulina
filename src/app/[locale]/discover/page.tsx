import { Link } from "@/i18n/navigation";
import { getTranslations } from "next-intl/server";
import { Sparkles } from "lucide-react";
import JsonLd from "@/components/seo/JsonLd";

import { getArchiveDecades } from "@/lib/archivePeriods";
import { getArchiveCounts } from "@/lib/getSongsByYear";
import { getPublishedProvinces } from "@/lib/provinces";
import { createPageMetadata, type SeoLocale } from "@/lib/seo";
import { breadcrumbSchema, collectionPageSchema } from "@/lib/structuredData";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale: routeLocale } = await params;
  const locale: SeoLocale = routeLocale === "es" ? "es" : "en";
  const t = await getTranslations("pages.discover");
  return createPageMetadata({
    title: t("metadataTitle"),
    description: t("metadataDescription"),
    path: "/discover",
    locale,
  });
}

const ARTIST_LINKS = [
  { key: "singers", href: "/artists" }, { key: "christianArtists", href: "/christian" }, { key: "legends", href: "/artists/legends" }, { key: "emergingArtists", href: "/artists/emerging" }, { key: "mostAwarded", href: "/artists/most-awarded" }, { key: "birthdays", href: "/artists/birthdays" }, { key: "instrumentalClassical", href: "/instrumental-classical" },
];

const CREATOR_LINKS = [
  { key: "composers", href: "/composers" }, { key: "songwriters", href: "/songwriters" }, { key: "lyricists", href: "/lyricists" }, { key: "djs", href: "/djs" }, { key: "musicians", href: "/musicians" }, { key: "producers", href: "/producers" },
];

const MUSIC_LINKS = [
  { key: "songs", href: "/archive" }, { key: "releases", href: "/releases" }, { key: "genres", href: "#genres" },
];

const GENRES = [
  { key: "worship", slug: "worship" },
  { key: "merengue", slug: "merengue" }, { key: "bachata", slug: "bachata" }, { key: "urban", slug: "urbano" }, { key: "salsa", slug: "salsa" }, { key: "ballads", slug: "ballads" }, { key: "pop", slug: "pop" }, { key: "rock", slug: "rock" }, { key: "reggae", slug: "reggae" }, { key: "jazz", slug: "jazz" }, { key: "electronic", slug: "electronic" }, { key: "instrumental", slug: "instrumental" }, { key: "folklore", slug: "folklore" }, { key: "fusion", slug: "fusion" },
];

const INFORMATION_LINKS = [
  { key: "home", href: "/" }, { key: "about", href: "/about" }, { key: "contact", href: "/contact" }, { key: "contributors", href: "/contributors" }, { key: "privacy", href: "/privacy-policy" }, { key: "terms", href: "/terms-of-use" }, { key: "dmca", href: "/dmca" },
];

type DirectoryLink = { key: string; href: string };

function SectionEyebrow({ children }: { children: React.ReactNode }) {
  return (
    <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#8B0000]">
      {children}
    </p>
  );
}

function LinkGrid({ links, label }: { links: DirectoryLink[]; label: (key: string) => string }) {
  return (
    <div className="grid gap-3 sm:grid-cols-2">
      {links.map((link) => (
        <Link
          key={`${link.key}-${link.href}`}
          href={link.href}
          className="rounded-2xl border border-[#002D62]/10 bg-[#FAF9F6] px-5 py-4 font-medium text-[#002D62] transition hover:border-[#002D62]/30 hover:bg-[#002D62]/5"
        >
          {label(link.key)}
        </Link>
      ))}
    </div>
  );
}

export default async function DiscoverPage() {
  const t = await getTranslations("pages.discover");
  const [provinces, archiveCounts] = await Promise.all([
    getPublishedProvinces(),
    getArchiveCounts(),
  ]);
  const decades = getArchiveDecades().filter(
    (decade) => (archiveCounts.decadeCounts[decade] ?? 0) > 0,
  );

  return (
    <main className="mx-auto max-w-5xl px-6 pb-10 pt-20 sm:pb-16 sm:pt-32">
      <JsonLd
        data={[
          collectionPageSchema({
            name: t("title"),
            description: t("metadataDescription"),
            path: "/discover",
          }),
          breadcrumbSchema([
            { name: t("links.home"), path: "/" },
            { name: t("title"), path: "/discover" },
          ]),
        ]}
      />
      <header className="relative mb-10 overflow-hidden rounded-3xl border border-amber-300/60 bg-gradient-to-br from-amber-50 via-white to-orange-50 p-7 shadow-sm sm:p-10 lg:p-12 dark:border-amber-400/20 dark:from-amber-950/40 dark:via-gray-950 dark:to-orange-950/30">
        <Sparkles
          aria-hidden="true"
          className="absolute right-7 top-7 size-9 text-amber-500/25 sm:right-10 sm:top-10 sm:size-12 dark:text-amber-300/20"
          strokeWidth={1.5}
        />
        <div className="relative max-w-4xl">
          <span className="inline-flex rounded-full border border-amber-500/30 bg-amber-400/15 px-3 py-1 text-xs font-bold tracking-widest text-amber-900 dark:border-amber-300/25 dark:bg-amber-300/10 dark:text-amber-200">
            {t("betaHero.badge")}
          </span>
          <h1 className="mt-6 text-4xl font-bold tracking-tight text-[#002D62] sm:text-5xl lg:text-6xl dark:text-white">
            {t("betaHero.title")}
          </h1>
          <p className="mt-3 text-xl font-semibold text-[#8B0000] sm:text-2xl dark:text-amber-300">
            {t("betaHero.subtitle")}
          </p>
          <div className="mt-8 space-y-5 text-base leading-relaxed text-gray-700 sm:text-lg dark:text-gray-200">
            <p>{t("betaHero.paragraphOne")}</p>
            <p>{t("betaHero.paragraphTwo")}</p>
            <p className="font-medium text-[#002D62] dark:text-amber-50">
              {t("betaHero.paragraphThree")}
            </p>
            <p className="rounded-2xl border border-amber-400/30 bg-white/70 px-5 py-4 font-medium text-amber-950 dark:border-amber-300/15 dark:bg-white/5 dark:text-amber-100">
              {t("betaHero.invitation")}
            </p>
            <p>{t("betaHero.thanks")}</p>
          </div>
        </div>
      </header>

      <div className="grid gap-6 md:grid-cols-2">
        <section className="rounded-3xl border border-black/10 bg-white p-7 shadow-sm sm:p-8">
          <SectionEyebrow>{t("artistsTitle")}</SectionEyebrow>
          <LinkGrid links={ARTIST_LINKS} label={(key) => t(`links.${key}`)} />
        </section>

        <section className="rounded-3xl border border-black/10 bg-white p-7 shadow-sm sm:p-8">
          <SectionEyebrow>{t("creatorsTitle")}</SectionEyebrow>
          <LinkGrid links={CREATOR_LINKS} label={(key) => t(`links.${key}`)} />
        </section>

        <section className="rounded-3xl bg-[#002D62] p-7 text-white shadow-xl sm:p-8">
          <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-white/70">
            {t("musicTitle")}
          </p>
          <div className="grid gap-3">
            {MUSIC_LINKS.map((link) => (
              <Link
                key={link.key}
                href={link.href}
                className="rounded-2xl border border-white/15 bg-white/10 px-5 py-4 font-medium text-white transition hover:border-white/30 hover:bg-white/15"
              >
                {t(`links.${link.key}`)}
              </Link>
            ))}
          </div>
        </section>

        <section className="rounded-3xl border border-black/10 bg-white p-7 shadow-sm sm:p-8">
          <SectionEyebrow>{t("informationTitle")}</SectionEyebrow>
          <LinkGrid links={INFORMATION_LINKS} label={(key) => t(`links.${key}`)} />
        </section>
      </div>

      <section
        id="genres"
        className="mt-6 scroll-mt-28 rounded-3xl border border-black/10 bg-white p-7 shadow-sm sm:p-10"
      >
        <SectionEyebrow>{t("genresTitle")}</SectionEyebrow>
        <div className="grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-4">
          {GENRES.map((genre) => (
            <Link
              key={genre.slug}
              href={`/genres/${genre.slug}`}
              className="rounded-2xl border border-[#002D62]/10 bg-[#FAF9F6] px-4 py-4 text-center font-medium text-[#002D62] transition hover:border-[#8B0000]/25 hover:bg-[#8B0000]/3 hover:text-[#8B0000]"
            >
              {t(`genreLabels.${genre.key}`)}
            </Link>
          ))}
        </div>
      </section>

      {provinces.length > 0 && (
        <section className="mt-6 rounded-3xl border border-black/10 bg-white p-7 shadow-sm sm:p-10">
          <SectionEyebrow>{t("regionsTitle")}</SectionEyebrow>
          <div className="grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-4">
            {provinces.map((province) => (
              <Link
                key={province.slug}
                href={`/provinces/${province.slug}`}
                className="flex items-center justify-between gap-3 rounded-2xl border border-[#002D62]/10 bg-[#FAF9F6] px-4 py-4 text-[#002D62] transition hover:border-[#002D62]/30 hover:bg-[#002D62]/5"
              >
                <span className="min-w-0 truncate font-medium">{province.name}</span>
                <span className="shrink-0 text-xs text-gray-500">{province.count}</span>
              </Link>
            ))}
          </div>
        </section>
      )}

      {decades.length > 0 && (
        <nav
          aria-labelledby="discover-decades-title"
          className="mt-6 rounded-3xl border border-black/10 bg-white p-7 shadow-sm sm:p-10 dark:border-white/10 dark:bg-gray-950"
        >
          <h2
            id="discover-decades-title"
            className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#8B0000] dark:text-amber-300"
          >
            {t("decadesTitle")}
          </h2>
          <ul className="grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-4">
            {decades.map((decade) => {
              const count = archiveCounts.decadeCounts[decade];

              return (
                <li key={decade}>
                  <Link
                    href={`/archive/${decade}`}
                    prefetch={false}
                    aria-label={t("decadeLinkAria", {
                      decade,
                      decadeYear: decade.slice(0, -1),
                      count,
                    })}
                    className="flex min-h-14 w-full items-center justify-between gap-3 rounded-2xl border border-[#002D62]/10 bg-[#FAF9F6] px-4 py-4 text-[#002D62] transition hover:border-[#002D62]/30 hover:bg-[#002D62]/5 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[#8B0000] focus-visible:ring-offset-2 dark:border-white/10 dark:bg-white/5 dark:text-gray-100 dark:hover:border-amber-300/30 dark:hover:bg-white/10 dark:focus-visible:ring-amber-300 dark:focus-visible:ring-offset-gray-950"
                  >
                    <span className="min-w-0 truncate font-medium">{decade}</span>
                    <span className="shrink-0 text-xs text-gray-500 dark:text-gray-400" aria-hidden="true">
                      {count.toLocaleString()}
                    </span>
                  </Link>
                </li>
              );
            })}
          </ul>
        </nav>
      )}
    </main>
  );
}
