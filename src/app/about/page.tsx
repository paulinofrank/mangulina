import type { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "About Mangulina | Dominican Music Database",
  description:
    "Mangulina is a curated Dominican music database dedicated to preserving and documenting Dominican artists, songs, releases, credits, genres, and musical history.",
  alternates: { canonical: "/about" },
};

const WHAT_WE_COVER = [
  "Artists from every region and era of Dominican music",
  "Recordings with credits, genre classifications, and release details",
  "Albums and releases with complete track listings",
  "Songwriters, composers, producers, musicians, and other contributors",
  "Awards, musical history, and cultural context",
  "Links to streaming platforms and official sources",
];

const PRINCIPLES = [
  "Human-reviewed and curated music information",
  "Corrections welcomed from artists, families, researchers, and the public",
  "Respect for artists, rights holders, labels, and official sources",
  "A focus on preserving Dominican musical heritage across generations",
];

function SectionEyebrow({ children }: { children: React.ReactNode }) {
  return (
    <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#8B0000]">
      {children}
    </p>
  );
}

export default function AboutPage() {
  return (
    <main className="mx-auto max-w-5xl px-6 pt-20 pb-10 sm:pt-32 sm:pb-16">
      {/* Hero */}
      <header className="mb-12 rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-12">
        <SectionEyebrow>Dominican Music Database</SectionEyebrow>

        <h1 className="mb-5 text-4xl font-bold tracking-tight text-[#002D62] sm:text-5xl">
          About Mangulina&trade;
        </h1>

        <p className="max-w-3xl text-lg leading-relaxed text-gray-700 sm:text-xl">
          Mangulina is a curated Dominican music database dedicated to
          preserving, documenting, and celebrating the artists, songs,
          recordings, releases, credits, and stories that shape Dominican music.
        </p>
      </header>

      <div className="space-y-10">
        {/* Mission */}
        <section className="rounded-3xl bg-[#002D62] p-8 text-white shadow-xl sm:p-12">
          <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-white/70">
            Our Mission
          </p>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-white/90">
            <p>
              To build the most comprehensive and reliable reference for
              Dominican music — preserving its history, documenting its creators,
              and making its cultural legacy more accessible to everyone.
            </p>

            <p>
              Mangulina serves artists, researchers, historians, collectors,
              educators, developers, journalists, and music fans seeking
              structured and trustworthy information about Dominican music.
            </p>

            <p>
              We believe Dominican music deserves a dedicated home where its
              people, recordings, releases, and achievements can be preserved,
              discovered, and appreciated across generations.
            </p>
          </div>
        </section>

        {/* Why Mangulina */}
        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>Why Mangulina</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              The name <strong>Mangulina</strong> is inspired by the traditional
              Dominican musical genre of the same name — a lively rhythm with
              deep roots in the country&apos;s cultural heritage.
            </p>

            <p>
              While the platform covers all genres and eras of Dominican music,
              the name serves as a tribute to the traditions that helped shape
              the nation&apos;s musical identity. It reflects the project&apos;s
              broader purpose: preserving and celebrating Dominican music in all
              its forms.
            </p>
          </div>
        </section>

        {/* What We Cover */}
        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>What We Cover</SectionEyebrow>

          <p className="max-w-3xl text-lg leading-relaxed text-gray-700">
            Mangulina is building a growing reference for Dominican music,
            connecting artists, recordings, releases, contributors, genres, and
            historical context in one searchable place.
          </p>

          <div className="mt-7 grid gap-4 sm:grid-cols-2">
            {WHAT_WE_COVER.map((item) => (
              <div
                key={item}
                className="flex items-start gap-4 rounded-2xl border border-black/5 bg-[#FAF9F6] p-5"
              >
                <div className="mt-2 h-2.5 w-2.5 shrink-0 rounded-full bg-[#8B0000]" />
                <span className="text-base font-medium leading-relaxed text-[#002D62]">
                  {item}
                </span>
              </div>
            ))}
          </div>
        </section>

        {/* Editorial Principles */}
        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>Editorial Principles</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              Mangulina is curated with human review. We organize information
              carefully, verify details whenever possible, and welcome
              corrections from artists, representatives, researchers,
              collectors, contributors, and the public.
            </p>

            <p>
              Our goal is not to replace official artist websites, streaming
              platforms, record labels, publishers, or rights holders. Instead,
              we aim to connect information, improve discoverability, and help
              preserve the history of Dominican music.
            </p>

            <p>
              Music information is constantly evolving. As new information
              becomes available, entries may be updated, expanded, corrected, or
              refined over time.
            </p>
          </div>

          <div className="mt-7 grid gap-4 sm:grid-cols-2">
            {PRINCIPLES.map((item) => (
              <div
                key={item}
                className="rounded-2xl border border-[#002D62]/10 bg-[#002D62]/[0.03] p-5 text-base font-medium leading-relaxed text-[#002D62]"
              >
                {item}
              </div>
            ))}
          </div>
        </section>

        {/* Artist Message */}
        <section className="rounded-3xl border border-[#8B0000]/15 bg-[#8B0000]/[0.03] p-8 shadow-sm sm:p-10">
          <SectionEyebrow>A note to artists and rights holders</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              Mangulina is dedicated to preserving, documenting, and celebrating
              Dominican music — and the people who create it. Every artist,
              songwriter, composer, producer, musician, and contributor included
              in this database represents an important part of that story.
            </p>

            <p>
              We do not host, sell, stream, or distribute music. We do not claim
              ownership of recordings, artwork, lyrics, trademarks, or other
              creative works. Our role is limited to organizing and presenting
              music-related information and metadata for educational,
              informational, and reference purposes.
            </p>

            <p>
              If you are an artist, representative, rights holder, or family
              member and would like to update, correct, enrich, or discuss any
              information appearing on the site, we encourage you to contact us.
            </p>
          </div>
        </section>

        {/* Two Feature Cards */}
        <div className="grid gap-6 sm:grid-cols-2">
          <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm">
            <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#002D62]">
              Built for Discovery
            </p>

            <p className="text-lg leading-relaxed text-gray-700">
              Mangulina helps people discover connections across Dominican
              music — artists, recordings, releases, genres, contributors,
              awards, and historical context — through a structured and
              searchable catalog.
            </p>
          </section>

          <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm">
            <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#8B0000]">
              A Living Archive
            </p>

            <p className="text-lg leading-relaxed text-gray-700">
              Dominican music continues to evolve every day. Mangulina is
              designed as a living archive that grows alongside the music,
              expanding through research, community contributions, artist
              collaboration, and ongoing editorial review.
            </p>
          </section>
        </div>

        {/* Participation */}
        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>Get Involved</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              Mangulina welcomes participation from artists, researchers,
              historians, collectors, music professionals, and passionate fans
              who share an interest in preserving Dominican musical heritage.
            </p>

            <p>
              Whether you would like to submit corrections, contribute
              information, enrich artist profiles, provide historical research,
              or become a contributor, we would love to hear from you.
            </p>
          </div>

          <div className="mt-8 flex flex-col gap-3 sm:flex-row">
            <Link
              href="/contact"
              className="rounded-full bg-[#8B0000] px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-white transition-colors hover:bg-[#6f0000]"
            >
              Contact Mangulina
            </Link>

            <Link
              href="/contributors"
              className="rounded-full border border-[#002D62]/20 px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-[#002D62] transition-colors hover:bg-[#002D62]/5"
            >
              Contributors
            </Link>

            <Link
              href="/dmca"
              className="rounded-full border border-black/10 px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-gray-700 transition-colors hover:bg-black/[0.03]"
            >
              Copyright &amp; DMCA
            </Link>
          </div>
        </section>
      </div>
    </main>
  );
}