import type { Metadata } from "next";
import Link from "next/link";
import { getTranslations } from "next-intl/server";
import { createPageMetadata } from "@/lib/seo";

export const metadata: Metadata = createPageMetadata({
  title: "Terms of Use",
  description:
    "Read the Terms of Use for Mangulina, the Dominican Music Database dedicated to documenting and preserving Dominican music history.",
  path: "/terms-of-use",
});

type TermsSection = {
  title: string;
  paragraphs: React.ReactNode[];
  items?: string[];
  closingParagraphs?: React.ReactNode[];
};

const TERMS_SECTIONS: TermsSection[] = [
  {
    title: "1. About Mangulina",
    paragraphs: [
      "Mangulina is an independent reference database dedicated to documenting, preserving, and promoting information about Dominican music, artists, recordings, releases, genres, and related cultural history.",
      "Mangulina is an informational resource and does not provide music streaming, digital downloads, or music sales unless explicitly stated.",
    ],
  },
  {
    title: "2. Informational Purposes Only",
    paragraphs: [
      "The information provided on Mangulina is intended for educational, research, historical, editorial, and informational purposes.",
      "While we strive to maintain accurate and up-to-date information, we do not guarantee that all content is complete, current, accurate, or free of errors.",
      "Users should independently verify information when making decisions based on data found on the website.",
    ],
  },
  {
    title: "3. Intellectual Property",
    paragraphs: [
      "The Mangulina name, logo, design, original text, database structure, and original content are the property of Mangulina unless otherwise noted.",
      "Users may view content for personal use, share links to pages on the website, and cite information with proper attribution.",
      "Users may not:",
    ],
    items: [
      "Copy substantial portions of the database",
      "Republish large amounts of content without permission",
      "Create competing databases using data obtained from Mangulina",
      "Remove copyright notices or attribution",
    ],
  },
  {
    title: "4. Third-Party Content",
    paragraphs: [
      "Mangulina may display or reference artist names, album titles, recording titles, release information, cover artwork, photographs, external platform links, and embedded media.",
      "Such content remains the property of its respective owners.",
      "The inclusion of third-party content does not imply ownership, endorsement, sponsorship, or affiliation unless expressly stated.",
    ],
  },
  {
    title: "5. External Links",
    paragraphs: [
      "Mangulina may provide links to third-party services and platforms, including music streaming services, social media platforms, artist websites, and other external resources.",
      "We are not responsible for the content, availability, privacy practices, or policies of third-party websites.",
    ],
  },
  {
    title: "6. Copyright and Rights Holders",
    paragraphs: [
      "Mangulina respects intellectual property rights.",
      <span key="rights-holder-contact">
        Artists, labels, photographers, rights holders, and authorized
        representatives who believe that content appearing on the website
        infringes their rights may contact us through our{" "}
        <Link
          href="/dmca"
          className="font-medium text-[#002D62] underline underline-offset-4 hover:text-[#8B0000]"
        >
          Copyright &amp; DMCA page
        </Link>
        .
      </span>,
      "We will review all legitimate requests and take appropriate action when necessary.",
    ],
  },
  {
    title: "7. User Conduct",
    paragraphs: ["Users agree not to:"],
    items: [
      "Use the website for unlawful purposes",
      "Attempt unauthorized access",
      "Interfere with website operations",
      "Circumvent security measures",
      "Excessively scrape or harvest data",
      "Engage in activity that may damage the website or its services",
    ],
    closingParagraphs: [
      "Reasonable access by search engines and legitimate indexing services is permitted.",
    ],
  },
  {
    title: "8. Availability of Service",
    paragraphs: [
      "We may modify, suspend, restrict, or discontinue any part of the website at any time without notice.",
      "We do not guarantee uninterrupted availability of the website or its services.",
    ],
  },
  {
    title: "9. No Warranties",
    paragraphs: [
      <span key="as-is">
        The website and its content are provided on an &quot;as is&quot; and
        &quot;as available&quot; basis.
      </span>,
      "To the fullest extent permitted by law, Mangulina disclaims all warranties, express or implied, including warranties of accuracy, merchantability, fitness for a particular purpose, and non-infringement.",
    ],
  },
  {
    title: "10. Limitation of Liability",
    paragraphs: [
      "To the fullest extent permitted by law, Mangulina shall not be liable for any direct, indirect, incidental, consequential, or special damages arising from the use of, or inability to use, the website or its content.",
    ],
  },
  {
    title: "11. Changes to These Terms",
    paragraphs: [
      "We may update these Terms of Use from time to time.",
      <span key="updated-version">
        The updated version will be posted on this page with a revised
        &quot;Last Updated&quot; date.
      </span>,
      "Continued use of the website after changes become effective constitutes acceptance of the revised terms.",
    ],
  },
  {
    title: "12. Contact",
    paragraphs: [
      <span key="contact">
        Questions regarding these Terms of Use may be directed through our{" "}
        <Link
          href="/contact"
          className="font-medium text-[#002D62] underline underline-offset-4 hover:text-[#8B0000]"
        >
          Contact page
        </Link>
        .
      </span>,
    ],
  },
];

function SectionEyebrow({ children }: { children: React.ReactNode }) {
  return (
    <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#8B0000]">
      {children}
    </p>
  );
}

export default async function TermsOfUsePage() {
  const t = await getTranslations("pages");

  return (
    <main className="mx-auto max-w-5xl px-6 pb-10 pt-20 sm:pb-16 sm:pt-32">
      <header className="mb-12 rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-12">
        <SectionEyebrow>Terms of Use</SectionEyebrow>

        <h1 className="mb-5 text-4xl font-bold tracking-tight text-[#002D62] sm:text-5xl">
          Terms of Use
        </h1>

        <p className="max-w-3xl text-lg leading-relaxed text-gray-700 sm:text-xl">
          Mangulina is an independent Dominican Music Database dedicated to
          documenting and preserving the history of Dominican music.
        </p>

        <p className="mt-6 text-sm text-gray-500">{t("termsOfUse.lastUpdated")}</p>
      </header>

      <div className="space-y-10">
        <section className="rounded-3xl bg-[#002D62] p-8 text-white shadow-xl sm:p-12">
          <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-white/70">
            Welcome to Mangulina
          </p>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-white/90">
            <p>
              Welcome to Mangulina (&quot;Mangulina,&quot; &quot;we,&quot;
              &quot;our,&quot; or &quot;us&quot;), the Dominican Music Database.
            </p>
            <p>
              By accessing or using this website, you agree to these Terms of
              Use. If you do not agree with these terms, please do not use the
              website.
            </p>
          </div>
        </section>

        {TERMS_SECTIONS.map((section) => (
          <section
            key={section.title}
            className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10"
          >
            <SectionEyebrow>{section.title}</SectionEyebrow>

            <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
              {section.paragraphs.map((paragraph, index) => (
                <p key={index}>{paragraph}</p>
              ))}

              {section.items && (
                <ul className="list-disc space-y-3 pl-6">
                  {section.items.map((item) => (
                    <li key={item}>{item}</li>
                  ))}
                </ul>
              )}

              {section.closingParagraphs?.map((paragraph, index) => (
                <p key={`closing-${index}`}>{paragraph}</p>
              ))}
            </div>
          </section>
        ))}

        <section className="rounded-3xl border border-[#8B0000]/15 bg-[#8B0000]/[0.03] p-8 shadow-sm sm:p-10">
          <SectionEyebrow>Editorial Note</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              Mangulina&apos;s mission is to preserve and document the history,
              culture, and people of Dominican music. We welcome corrections,
              additional information, and contributions from artists, families,
              researchers, historians, and rights holders to help improve the
              accuracy and completeness of the database.
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
