import type { Metadata } from "next";
import SectionTitle from "@/components/atoms/SectionTitle";

export const metadata: Metadata = {
  title: "About Mangulina | Dominican Music Database",
  description:
    "Learn about Mangulina — a music data platform dedicated to building a structured, searchable database for Dominican music, covering artists, recordings, and releases across all genres and decades.",
  alternates: { canonical: "/about" },
};

const WHAT_WE_COVER = [
  "Artists from every region and era of Dominican music",
  "Recordings with credits, genre tags, and release details",
  "Albums and releases with full track listings",
  "Searchable catalog across all styles and decades",
  "Links to streaming platforms and official sources",
];

export default function AboutPage() {
  return (
    <main className="mx-auto max-w-4xl px-6 pt-20 pb-4 sm:pt-32 sm:pb-6">

      {/* Hero Header */}
      <header className="mb-16 border-b border-black/10 pb-10">
        <h1 className="mb-4 text-4xl font-bold tracking-tight text-[#002D62] sm:text-5xl">
          About Mangulina&trade;
        </h1>
        <p className="text-lg leading-relaxed text-gray-600 sm:text-xl">
          Mangulina is a music data platform focused on building a structured,
          searchable, and scalable database for Dominican music.
        </p>
      </header>

      <div className="space-y-16">

        {/* Brand Identity */}
        <section className="space-y-8">
          <div className="prose prose-slate max-w-none">
            <SectionTitle>Brand &amp; Identity</SectionTitle>
            <p className="mt-4 text-gray-700 leading-relaxed">
              The name <strong>Mangulina</strong>{" "}is inspired by the traditional Dominican musical genre of the same
              name — a lively rhythm with deep roots in the country&apos;s cultural identity.
              While the platform covers all of Dominican music and is not limited to any single genre,
              the name is a nod to that heritage and a reflection of the pride behind this project.
            </p>
          </div>

          {/* Artist Community Message */}
          <div className="rounded-2xl border border-[#002D62]/10 bg-[#002D62]/[0.03] p-7">
            <p className="mb-1 text-xs font-semibold uppercase tracking-widest text-[#002D62]/50">
              A note to artists
            </p>
            <p className="mt-3 text-gray-700 leading-relaxed">
              Mangulina is a curated database dedicated to preserving, documenting, and celebrating
              Dominican music — and the people who create it. Every artist, songwriter, and musician
              in this database is here because their work matters and deserves to be remembered.
            </p>
            <p className="mt-3 text-gray-700 leading-relaxed">
              We do not host, sell, or distribute music. We do not claim ownership of any recordings,
              lyrics, artwork, or creative work. Our role is to organize publicly available metadata —
              names, dates, credits, and references — so that Dominican music is easier to discover,
              research, and appreciate.
            </p>
            <p className="mt-3 text-gray-700 leading-relaxed">
              If you are an artist and have questions about how your information appears here, or if
              you would like to update, correct, or remove anything, please{" "}
              <a href="/contact" className="font-medium text-[#CE1126] underline underline-offset-2 hover:text-[#8B0000] transition-colors">
                reach out to us
              </a>
              . We are always happy to work with you directly.
            </p>
          </div>
        </section>

        {/* What We Cover */}
        <section>
          <SectionTitle>What We Cover</SectionTitle>
          <p className="mb-6 mt-2 text-sm font-semibold uppercase tracking-widest text-gray-500">
            One place for Dominican music information:
          </p>
          <div className="grid gap-3 sm:grid-cols-2">
            {WHAT_WE_COVER.map((item) => (
              <div
                key={item}
                className="flex items-center gap-3 rounded-xl border border-black/5 bg-white p-4 shadow-sm transition-all hover:border-[#8B0000]/20 hover:shadow-md"
              >
                <div className="h-2 w-2 shrink-0 rounded-full bg-[#8B0000]" />
                <span className="text-sm font-medium text-[#002D62]">{item}</span>
              </div>
            ))}
          </div>
        </section>

        {/* Mission Statement */}
        <section className="rounded-3xl bg-[#002D62] p-8 text-white shadow-xl sm:p-12">
          <h2 className="mb-4 text-2xl font-bold">Our Mission</h2>
          <div className="space-y-4 text-lg leading-relaxed opacity-90 sm:text-xl">
            <p>
              To create a reliable, open, and extensible resource for Dominican music data —
              enabling developers, researchers, artists, and the general public to access
              structured musical information at scale.
            </p>
            <p>
              Mangulina is designed not only as a technical platform, but also as a cultural
              and educational resource for anyone interested in Dominican music — from casual
              listeners discovering new artists, to professionals building music applications
              and conducting research.
            </p>
            <p>
              Our goal is to make Dominican music more accessible, understandable, and
              connected across both digital systems and everyday listeners.
            </p>
          </div>
        </section>

        {/* The Name + Platform Focus */}
        <div className="grid gap-8 sm:grid-cols-2">
          <section className="rounded-2xl border border-red-100 bg-red-50/30 p-6">
            <h3 className="mb-3 font-bold text-[#8B0000]">The Name</h3>
            <p className="text-sm leading-relaxed text-gray-700">
              Mangulina is a real Dominican musical genre — joyful, traditional, and distinctly
              Caribbean. This platform takes its name from that genre as a tribute, though it
              covers the full breadth of Dominican music across all styles, decades, and artists.
            </p>
          </section>

          <section className="rounded-2xl border border-blue-100 bg-blue-50/30 p-6">
            <h3 className="mb-3 font-bold text-[#002D62]">Platform Focus</h3>
            <p className="text-sm leading-relaxed text-gray-700">
              Mangulina operates as a reference layer for music information — not as a publisher,
              label, or genre authority. Its goal is to make Dominican music data structured,
              searchable, and open to everyone.
            </p>
          </section>
        </div>

      </div>
    </main>
  );
}
