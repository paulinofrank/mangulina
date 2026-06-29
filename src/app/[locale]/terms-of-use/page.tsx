import type { Metadata } from "next";
import { getTranslations } from "next-intl/server";

import { Link } from "@/i18n/navigation";
import { createPageMetadata, type SeoLocale } from "@/lib/seo";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale: routeLocale } = await params;
  const locale: SeoLocale = routeLocale === "es" ? "es" : "en";
  const t = await getTranslations("legal.terms.metadata");

  return createPageMetadata({
    title: t("title"),
    description: t("description"),
    path: "/terms-of-use",
    locale,
  });
}

type TermsSection = {
  title: string;
  paragraphs: React.ReactNode[];
  items?: string[];
  closingParagraphs?: React.ReactNode[];
};

function SectionEyebrow({ children }: { children: React.ReactNode }) {
  return (
    <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#8B0000]">
      {children}
    </p>
  );
}

const legalLinkClass =
  "font-medium text-[#002D62] underline underline-offset-4 hover:text-[#8B0000]";

export default async function TermsOfUsePage() {
  const t = await getTranslations("legal.terms");

  const sections: TermsSection[] = [
    {
      title: t("sections.about.title"),
      paragraphs: [
        t("sections.about.description"),
        t("sections.about.informationalResource"),
      ],
    },
    {
      title: t("sections.informational.title"),
      paragraphs: [
        t("sections.informational.purposes"),
        t("sections.informational.accuracy"),
        t("sections.informational.verification"),
      ],
    },
    {
      title: t("sections.intellectualProperty.title"),
      paragraphs: [
        t("sections.intellectualProperty.ownership"),
        t("sections.intellectualProperty.permittedUse"),
        t("sections.intellectualProperty.prohibitedIntroduction"),
      ],
      items: [
        t("sections.intellectualProperty.items.copy"),
        t("sections.intellectualProperty.items.republish"),
        t("sections.intellectualProperty.items.competingDatabase"),
        t("sections.intellectualProperty.items.removeNotices"),
      ],
    },
    {
      title: t("sections.thirdPartyContent.title"),
      paragraphs: [
        t("sections.thirdPartyContent.examples"),
        t("sections.thirdPartyContent.ownership"),
        t("sections.thirdPartyContent.noAffiliation"),
      ],
    },
    {
      title: t("sections.externalLinks.title"),
      paragraphs: [
        t("sections.externalLinks.examples"),
        t("sections.externalLinks.responsibility"),
      ],
    },
    {
      title: t("sections.rightsHolders.title"),
      paragraphs: [
        t("sections.rightsHolders.respect"),
        t.rich("sections.rightsHolders.contact", {
          dmca: (chunks) => (
            <Link href="/dmca" className={legalLinkClass}>
              {chunks}
            </Link>
          ),
        }),
        t("sections.rightsHolders.review"),
      ],
    },
    {
      title: t("sections.conduct.title"),
      paragraphs: [t("sections.conduct.introduction")],
      items: [
        t("sections.conduct.items.unlawful"),
        t("sections.conduct.items.unauthorizedAccess"),
        t("sections.conduct.items.interfere"),
        t("sections.conduct.items.security"),
        t("sections.conduct.items.scrape"),
        t("sections.conduct.items.damage"),
      ],
      closingParagraphs: [t("sections.conduct.indexing")],
    },
    {
      title: t("sections.availability.title"),
      paragraphs: [
        t("sections.availability.modification"),
        t("sections.availability.noGuarantee"),
      ],
    },
    {
      title: t("sections.warranties.title"),
      paragraphs: [
        t("sections.warranties.asIs"),
        t("sections.warranties.disclaimer"),
      ],
    },
    {
      title: t("sections.liability.title"),
      paragraphs: [t("sections.liability.limitation")],
    },
    {
      title: t("sections.changes.title"),
      paragraphs: [
        t("sections.changes.updates"),
        t("sections.changes.posting"),
        t("sections.changes.acceptance"),
      ],
    },
    {
      title: t("sections.contact.title"),
      paragraphs: [
        t.rich("sections.contact.description", {
          contact: (chunks) => (
            <Link href="/contact" className={legalLinkClass}>
              {chunks}
            </Link>
          ),
        }),
      ],
    },
  ];

  return (
    <main className="mx-auto max-w-5xl px-6 pb-10 pt-20 sm:pb-16 sm:pt-32">
      <header className="mb-12 rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-12">
        <SectionEyebrow>{t("eyebrow")}</SectionEyebrow>

        <h1 className="mb-5 text-4xl font-bold tracking-tight text-[#002D62] sm:text-5xl">
          {t("title")}
        </h1>

        <p className="max-w-3xl text-lg leading-relaxed text-gray-700 sm:text-xl">
          {t("heroDescription")}
        </p>

        <p className="mt-6 text-sm text-gray-500">{t("lastUpdated")}</p>
      </header>

      <div className="space-y-10">
        <section className="rounded-3xl bg-[#002D62] p-8 text-white shadow-xl sm:p-12">
          <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-white/70">
            {t("welcome.eyebrow")}
          </p>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-white/90">
            <p>{t("welcome.introduction")}</p>
            <p>{t("welcome.acceptance")}</p>
          </div>
        </section>

        {sections.map((section) => (
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
          <SectionEyebrow>{t("editorial.title")}</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>{t("editorial.description")}</p>
          </div>

          <div className="mt-8 flex flex-col gap-3 sm:flex-row">
            <Link
              href="/contact"
              className="rounded-full bg-[#8B0000] px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-white transition-colors hover:bg-[#6f0000]"
            >
              {t("editorial.contactButton")}
            </Link>
            <Link
              href="/about"
              className="rounded-full border border-[#002D62]/20 px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-[#002D62] transition-colors hover:bg-[#002D62]/5"
            >
              {t("editorial.aboutButton")}
            </Link>
          </div>
        </section>
      </div>
    </main>
  );
}
