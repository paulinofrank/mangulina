import type { Metadata } from "next";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Copyright & DMCA | Mangulina",
  description:
    "Mangulina's copyright and DMCA policy, including procedures for reporting copyright concerns, requesting corrections, and contacting rights holders.",
  alternates: { canonical: "/dmca" },
};

function SectionEyebrow({ children }: { children: React.ReactNode }) {
  return (
    <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#8B0000]">
      {children}
    </p>
  );
}

export default function DmcaPage() {
  return (
    <main className="mx-auto max-w-5xl px-6 pt-20 pb-10 sm:pt-32 sm:pb-16">
      {/* Hero */}
      <header className="mb-12 rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-12">
        <SectionEyebrow>Copyright & DMCA</SectionEyebrow>

        <h1 className="mb-5 text-4xl font-bold tracking-tight text-[#002D62] sm:text-5xl">
          Copyright Policy
        </h1>

        <p className="max-w-3xl text-lg leading-relaxed text-gray-700 sm:text-xl">
          Mangulina respects the intellectual property rights of artists,
          songwriters, publishers, record labels, photographers, and other
          rights holders. This page explains how copyright concerns may be
          reported and reviewed.
        </p>

        <p className="mt-6 text-sm text-gray-500">
          Last Updated: June 2026
        </p>
      </header>

      <div className="space-y-10">
        {/* Overview */}
        <section className="rounded-3xl bg-[#002D62] p-8 text-white shadow-xl sm:p-12">
          <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-white/70">
            Overview
          </p>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-white/90">
            <p>
              Mangulina is a curated Dominican music database dedicated to
              documenting and preserving information about Dominican music and
              the people who create it.
            </p>

            <p>
              The website provides reference information such as artist
              profiles, recording information, release details, credits,
              awards, historical information, and links to third-party
              platforms.
            </p>

            <p>
              Mangulina does not host, stream, sell, distribute, or provide
              downloadable copies of copyrighted music recordings.
            </p>
          </div>
        </section>

        {/* Copyright Policy */}
        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>Copyright Policy</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              We respect the intellectual property rights of artists,
              songwriters, composers, publishers, record labels, photographers,
              and all other rights holders.
            </p>

            <p>
              If we become aware of material that infringes copyright or other
              intellectual property rights, we will review the matter promptly
              and take appropriate action where necessary.
            </p>

            <p>
              Our goal is to preserve and organize information about Dominican
              music while respecting the rights of creators and rights holders.
            </p>
          </div>
        </section>

        {/* Third Party Content */}
        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>Third-Party Content</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              Mangulina may display or reference information obtained from
              publicly available sources, including:
            </p>

            <ul className="space-y-3 pl-6 list-disc">
              <li>Artist names and biographies</li>
              <li>Recording and release metadata</li>
              <li>Album and release titles</li>
              <li>Credits and personnel information</li>
              <li>Publicly available images</li>
              <li>Embedded YouTube videos</li>
              <li>Links to streaming services and official websites</li>
            </ul>

            <p>
              All trademarks, logos, recordings, videos, images, and other
              copyrighted materials remain the property of their respective
              owners.
            </p>

            <p>
              The inclusion of information within Mangulina does not imply
              ownership, endorsement, sponsorship, or affiliation unless
              explicitly stated.
            </p>
          </div>
        </section>

        {/* DMCA Notice */}
        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>Copyright Infringement Claims</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              If you believe that material appearing on Mangulina infringes
              your copyright or other intellectual property rights, please
              submit a written notice containing:
            </p>

            <ol className="space-y-3 pl-6 list-decimal">
              <li>Your full name and contact information.</li>
              <li>
                Identification of the copyrighted work claimed to have been
                infringed.
              </li>
              <li>
                The URL or specific location of the material in question.
              </li>
              <li>
                A statement that you have a good-faith belief that the use is
                unauthorized.
              </li>
              <li>
                A statement that the information provided is accurate and that
                you are the copyright owner or authorized representative.
              </li>
              <li>Your physical or electronic signature.</li>
            </ol>

            <p>
              Upon receipt of a valid notice, we will review the request and
              take appropriate action, which may include correction, removal,
              restriction, or further investigation of the material.
            </p>
          </div>
        </section>

        {/* Counter Notice */}
        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>Counter-Notification</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              If you believe that material was removed, restricted, or modified
              as a result of a mistake or misidentification, you may submit a
              counter-notification explaining the basis for your objection.
            </p>

            <p>
              We will review all counter-notifications and may restore or
              revise material where appropriate and permitted by applicable
              law.
            </p>
          </div>
        </section>

        {/* Artists & Rights Holders */}
        <section className="rounded-3xl border border-[#8B0000]/15 bg-[#8B0000]/[0.03] p-8 shadow-sm sm:p-10">
          <SectionEyebrow>Artists & Rights Holders</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              Artists, managers, publishers, record labels, estates, and
              authorized representatives may also contact us to:
            </p>

            <ul className="space-y-3 pl-6 list-disc">
              <li>Correct inaccurate information</li>
              <li>Update artist biographies or profile details</li>
              <li>Add missing credits or discography information</li>
              <li>Request review of images or other content</li>
              <li>Discuss attribution concerns</li>
            </ul>

            <p>
              Mangulina welcomes collaboration and strives to maintain
              accurate, respectful, and well-sourced information.
            </p>
          </div>
        </section>

        {/* Good Faith */}
        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>Good-Faith Commitment</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              Mangulina's mission is educational, informational, and cultural.
            </p>

            <p>
              We are committed to preserving Dominican musical heritage while
              respecting the rights and interests of artists, creators, and
              rights holders.
            </p>

            <p>
              If you have questions regarding this policy, please contact us
              and we will make every reasonable effort to resolve concerns
              promptly and professionally.
            </p>
          </div>
        </section>

        {/* Contact */}
        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>Contact</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              For copyright inquiries, infringement claims, attribution
              concerns, or rights-holder requests, please contact:
            </p>

            <div className="rounded-2xl border border-[#002D62]/10 bg-[#002D62]/[0.03] p-6">
              <p className="font-semibold text-[#002D62]">
                copyright@mangulina.do
              </p>
            </div>
          </div>

          <div className="mt-8 flex flex-col gap-3 sm:flex-row">
            <Link
              href="/contact"
              className="rounded-full bg-[#8B0000] px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-white transition-colors hover:bg-[#6f0000]"
            >
              Contact Us
            </Link>

            <Link
              href="/about"
              className="rounded-full border border-[#002D62]/20 px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-[#002D62] transition-colors hover:bg-[#002D62]/5"
            >
              About Mangulina
            </Link>
          </div>
        </section>
      </div>
    </main>
  );
}