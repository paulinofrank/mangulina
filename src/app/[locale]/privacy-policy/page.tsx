import type { Metadata } from "next";
import { getTranslations } from "next-intl/server";

import { Link } from "@/i18n/navigation";
import { createPageMetadata } from "@/lib/seo";

export async function generateMetadata(): Promise<Metadata> {
  const t = await getTranslations("legal.privacy.metadata");

  return createPageMetadata({
    title: t("title"),
    description: t("description"),
    path: "/privacy-policy",
  });
}

type PrivacySection = {
  title: string;
  paragraphs: React.ReactNode[];
  items?: string[];
  secondaryItems?: string[];
  secondaryIntroduction?: string;
  closingParagraphs?: React.ReactNode[];
};

function SectionEyebrow({ children }: { children: React.ReactNode }) {
  return (
    <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#8B0000]">
      {children}
    </p>
  );
}

function PolicyList({ items }: { items: string[] }) {
  return (
    <ul className="list-disc space-y-3 pl-6">
      {items.map((item) => (
        <li key={item}>{item}</li>
      ))}
    </ul>
  );
}

const legalLinkClass =
  "font-medium text-[#002D62] underline underline-offset-4 hover:text-[#8B0000]";

export default async function PrivacyPolicyPage() {
  const t = await getTranslations("legal.privacy");

  const sections: PrivacySection[] = [
    {
      title: t("sections.information.title"),
      paragraphs: [t("sections.information.introduction")],
      items: [
        t("sections.information.items.browser"),
        t("sections.information.items.device"),
        t("sections.information.items.operatingSystem"),
        t("sections.information.items.pagesVisited"),
        t("sections.information.items.referringWebsites"),
        t("sections.information.items.visitDate"),
        t("sections.information.items.region"),
        t("sections.information.items.performance"),
      ],
      closingParagraphs: [t("sections.information.closing")],
    },
    {
      title: t("sections.voluntary.title"),
      paragraphs: [t("sections.voluntary.introduction")],
      items: [
        t("sections.voluntary.items.contacting"),
        t("sections.voluntary.items.corrections"),
        t("sections.voluntary.items.edits"),
        t("sections.voluntary.items.copyright"),
        t("sections.voluntary.items.contributor"),
      ],
      secondaryIntroduction: t("sections.voluntary.detailsIntroduction"),
      secondaryItems: [
        t("sections.voluntary.details.name"),
        t("sections.voluntary.details.email"),
        t("sections.voluntary.details.organization"),
        t("sections.voluntary.details.message"),
      ],
      closingParagraphs: [t("sections.voluntary.closing")],
    },
    {
      title: t("sections.cookies.title"),
      paragraphs: [t("sections.cookies.introduction")],
      items: [
        t("sections.cookies.items.performance"),
        t("sections.cookies.items.behavior"),
        t("sections.cookies.items.traffic"),
        t("sections.cookies.items.security"),
      ],
      closingParagraphs: [
        t("sections.cookies.analytics"),
        t("sections.cookies.disabling"),
      ],
    },
    {
      title: t("sections.use.title"),
      paragraphs: [t("sections.use.introduction")],
      items: [
        t("sections.use.items.operate"),
        t("sections.use.items.experience"),
        t("sections.use.items.respond"),
        t("sections.use.items.investigate"),
        t("sections.use.items.monitor"),
        t("sections.use.items.accuracy"),
      ],
    },
    {
      title: t("sections.sharing.title"),
      paragraphs: [
        t("sections.sharing.noSale"),
        t("sections.sharing.introduction"),
      ],
      items: [
        t("sections.sharing.items.law"),
        t("sections.sharing.items.rights"),
        t("sections.sharing.items.investigate"),
        t("sections.sharing.items.vendors"),
      ],
    },
    {
      title: t("sections.thirdParty.title"),
      paragraphs: [t("sections.thirdParty.introduction")],
      items: [
        t("sections.thirdParty.items.artistWebsites"),
        t("sections.thirdParty.items.socialMedia"),
        t("sections.thirdParty.items.streaming"),
        t("sections.thirdParty.items.video"),
        t("sections.thirdParty.items.resources"),
      ],
      closingParagraphs: [
        t("sections.thirdParty.responsibility"),
        t("sections.thirdParty.review"),
      ],
    },
    {
      title: t("sections.security.title"),
      paragraphs: [
        t("sections.security.measures"),
        t("sections.security.limitation"),
      ],
    },
    {
      title: t("sections.children.title"),
      paragraphs: [
        t("sections.children.audience"),
        t("sections.children.collection"),
        t("sections.children.removal"),
      ],
    },
    {
      title: t("sections.international.title"),
      paragraphs: [
        t("sections.international.access"),
        t("sections.international.processing"),
      ],
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
        t.rich("sections.contact.contactPage", {
          contact: (chunks) => (
            <Link href="/contact" className={legalLinkClass}>
              {chunks}
            </Link>
          ),
        }),
        t.rich("sections.contact.dmcaPage", {
          dmca: (chunks) => (
            <Link href="/dmca" className={legalLinkClass}>
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
            <p>{t("welcome.description")}</p>
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

              {section.items && <PolicyList items={section.items} />}

              {section.secondaryIntroduction && (
                <p>{section.secondaryIntroduction}</p>
              )}

              {section.secondaryItems && (
                <PolicyList items={section.secondaryItems} />
              )}

              {section.closingParagraphs?.map((paragraph, index) => (
                <p key={`closing-${index}`}>{paragraph}</p>
              ))}
            </div>
          </section>
        ))}

        <section className="rounded-3xl border border-[#8B0000]/15 bg-[#8B0000]/[0.03] p-8 shadow-sm sm:p-10">
          <SectionEyebrow>{t("questions.title")}</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>{t("questions.description")}</p>
          </div>

          <div className="mt-8 flex flex-col gap-3 sm:flex-row">
            <Link
              href="/contact"
              className="rounded-full bg-[#8B0000] px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-white transition-colors hover:bg-[#6f0000]"
            >
              {t("questions.contactButton")}
            </Link>
            <Link
              href="/terms-of-use"
              className="rounded-full border border-[#002D62]/20 px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-[#002D62] transition-colors hover:bg-[#002D62]/5"
            >
              {t("questions.termsButton")}
            </Link>
          </div>
        </section>
      </div>
    </main>
  );
}
