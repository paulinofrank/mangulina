import { Link } from "@/i18n/navigation";
import { getTranslations } from "next-intl/server";
import JsonLd from "@/components/seo/JsonLd";

import { getPublishedProvinces } from "@/lib/provinces";
import { createPageMetadata } from "@/lib/seo";
import { breadcrumbSchema, collectionPageSchema } from "@/lib/structuredData";

export async function generateMetadata() {
  const t = await getTranslations("pages.discover");
  return createPageMetadata({title: t("metadataTitle"), description: t("metadataDescription"), path: "/discover"});
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
  const provinces = await getPublishedProvinces();

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
      <header className="mb-10 rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-12">
        <SectionEyebrow>{t("eyebrow")}</SectionEyebrow>
        <h1 className="mb-5 text-4xl font-bold tracking-tight text-[#002D62] sm:text-5xl">
          {t("title")}
        </h1>
        <p className="max-w-4xl text-lg leading-relaxed text-gray-700 sm:text-xl">
          {t("description")}
        </p>
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
    </main>
  );
}
