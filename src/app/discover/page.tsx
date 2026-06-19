import Link from "next/link";
import JsonLd from "@/components/seo/JsonLd";

import { getPublishedProvinces } from "@/lib/provinces";
import { createPageMetadata } from "@/lib/seo";
import { breadcrumbSchema, collectionPageSchema } from "@/lib/structuredData";

export const metadata = createPageMetadata({
  title: "Discover Dominican Music",
  description:
    "Explore Mangulina, the Dominican Music Database. Discover Dominican artists, songs, releases, genres, regions, creators, birthdays, Christian music, legends, and emerging artists.",
  path: "/discover",
});

const ARTIST_LINKS = [
  { label: "Singers", href: "/artists" },
  { label: "Christian Artists", href: "/christian" },
  { label: "Legends", href: "/artists/legends" },
  { label: "Emerging Artists", href: "/artists/emerging" },
  { label: "Most Awarded Artists", href: "/artists/most-awarded" },
  { label: "Artist Birthdays", href: "/artists/birthdays" },
  { label: "Instrumental & Classical", href: "/instrumental-classical" },
];

const CREATOR_LINKS = [
  { label: "Composers", href: "/composers" },
  { label: "Songwriters", href: "/songwriters" },
  { label: "Lyricists", href: "/lyricists" },
  { label: "DJs", href: "/djs" },
  { label: "Musicians", href: "/musicians" },
  { label: "Producers", href: "/producers" },
];

const MUSIC_LINKS = [
  { label: "Songs", href: "/archive" },
  { label: "Releases", href: "/releases" },
  { label: "Genres", href: "#genres" },
];

const GENRES = [
  { label: "Worship", slug: "worship" },
  { label: "Merengue", slug: "merengue" },
  { label: "Bachata", slug: "bachata" },
  { label: "Urban", slug: "urbano" },
  { label: "Salsa", slug: "salsa" },
  { label: "Ballads", slug: "ballads" },
  { label: "Pop", slug: "pop" },
  { label: "Rock", slug: "rock" },
  { label: "Reggae", slug: "reggae" },
  { label: "Jazz", slug: "jazz" },
  { label: "Electronic", slug: "electronic" },
  { label: "Instrumental", slug: "instrumental" },
  { label: "Folklore", slug: "folklore" },
  { label: "Fusion", slug: "fusion" },
];

const INFORMATION_LINKS = [
  { label: "Home", href: "/" },
  { label: "About", href: "/about" },
  { label: "Contact", href: "/contact" },
  { label: "Contributors", href: "/contributors" },
  { label: "Privacy Policy", href: "/privacy-policy" },
  { label: "Terms of Use", href: "/terms-of-use" },
  { label: "Copyrights & DMCA", href: "/dmca" },
];

type DirectoryLink = { label: string; href: string };

function SectionEyebrow({ children }: { children: React.ReactNode }) {
  return (
    <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#8B0000]">
      {children}
    </p>
  );
}

function LinkGrid({ links }: { links: DirectoryLink[] }) {
  return (
    <div className="grid gap-3 sm:grid-cols-2">
      {links.map((link) => (
        <Link
          key={`${link.label}-${link.href}`}
          href={link.href}
          className="rounded-2xl border border-[#002D62]/10 bg-[#FAF9F6] px-5 py-4 font-medium text-[#002D62] transition hover:border-[#002D62]/30 hover:bg-[#002D62]/5"
        >
          {link.label}
        </Link>
      ))}
    </div>
  );
}

export default async function DiscoverPage() {
  const provinces = await getPublishedProvinces();

  return (
    <main className="mx-auto max-w-5xl px-6 pb-10 pt-20 sm:pb-16 sm:pt-32">
      <JsonLd
        data={[
          collectionPageSchema({
            name: "Discover Dominican Music",
            description:
              "Explore Mangulina, the Dominican Music Database. Discover Dominican artists, songs, releases, genres, regions, creators, birthdays, Christian music, legends, and emerging artists.",
            path: "/discover",
          }),
          breadcrumbSchema([
            { name: "Home", path: "/" },
            { name: "Discover Dominican Music", path: "/discover" },
          ]),
        ]}
      />
      <header className="mb-10 rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-12">
        <SectionEyebrow>Explore Mangulina</SectionEyebrow>
        <h1 className="mb-5 text-4xl font-bold tracking-tight text-[#002D62] sm:text-5xl">
          Discover Dominican Music
        </h1>
        <p className="max-w-4xl text-lg leading-relaxed text-gray-700 sm:text-xl">
          Explore the Dominican Music Database through artists, songs, releases,
          genres, regions, creators, birthdays, and cultural categories.
        </p>
      </header>

      <div className="grid gap-6 md:grid-cols-2">
        <section className="rounded-3xl border border-black/10 bg-white p-7 shadow-sm sm:p-8">
          <SectionEyebrow>Artists</SectionEyebrow>
          <LinkGrid links={ARTIST_LINKS} />
        </section>

        <section className="rounded-3xl border border-black/10 bg-white p-7 shadow-sm sm:p-8">
          <SectionEyebrow>Creators</SectionEyebrow>
          <LinkGrid links={CREATOR_LINKS} />
        </section>

        <section className="rounded-3xl bg-[#002D62] p-7 text-white shadow-xl sm:p-8">
          <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-white/70">
            Music
          </p>
          <div className="grid gap-3">
            {MUSIC_LINKS.map((link) => (
              <Link
                key={link.label}
                href={link.href}
                className="rounded-2xl border border-white/15 bg-white/10 px-5 py-4 font-medium text-white transition hover:border-white/30 hover:bg-white/15"
              >
                {link.label}
              </Link>
            ))}
          </div>
        </section>

        <section className="rounded-3xl border border-black/10 bg-white p-7 shadow-sm sm:p-8">
          <SectionEyebrow>Information</SectionEyebrow>
          <LinkGrid links={INFORMATION_LINKS} />
        </section>
      </div>

      <section
        id="genres"
        className="mt-6 scroll-mt-28 rounded-3xl border border-black/10 bg-white p-7 shadow-sm sm:p-10"
      >
        <SectionEyebrow>Genres</SectionEyebrow>
        <div className="grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-4">
          {GENRES.map((genre) => (
            <Link
              key={genre.slug}
              href={`/genres/${genre.slug}`}
              className="rounded-2xl border border-[#002D62]/10 bg-[#FAF9F6] px-4 py-4 text-center font-medium text-[#002D62] transition hover:border-[#8B0000]/25 hover:bg-[#8B0000]/3 hover:text-[#8B0000]"
            >
              {genre.label}
            </Link>
          ))}
        </div>
      </section>

      {provinces.length > 0 && (
        <section className="mt-6 rounded-3xl border border-black/10 bg-white p-7 shadow-sm sm:p-10">
          <SectionEyebrow>Regions</SectionEyebrow>
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
