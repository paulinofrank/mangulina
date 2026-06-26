import type { Metadata } from "next";
import { getTranslations } from "next-intl/server";

import { Link } from "@/i18n/navigation";
import { createPageMetadata } from "@/lib/seo";

export async function generateMetadata(): Promise<Metadata> {
  const t = await getTranslations("legal.dmca.metadata");

  return createPageMetadata({
    title: t("title"),
    description: t("description"),
    path: "/dmca",
  });
}

function SectionEyebrow({ children }: { children: React.ReactNode }) {
  return (
    <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#8B0000]">
      {children}
    </p>
  );
}

export default async function DmcaPage() {
  const t = await getTranslations("legal.dmca");

  const thirdPartyItems = [
    t("thirdParty.items.artistInformation"),
    t("thirdParty.items.metadata"),
    t("thirdParty.items.titles"),
    t("thirdParty.items.credits"),
    t("thirdParty.items.images"),
    t("thirdParty.items.youtube"),
    t("thirdParty.items.links"),
  ];
  const claimItems = [
    t("claims.items.contactInformation"),
    t("claims.items.identification"),
    t("claims.items.location"),
    t("claims.items.goodFaith"),
    t("claims.items.accuracy"),
    t("claims.items.signature"),
  ];
  const rightsHolderItems = [
    t("rightsHolders.items.correct"),
    t("rightsHolders.items.update"),
    t("rightsHolders.items.credits"),
    t("rightsHolders.items.review"),
    t("rightsHolders.items.attribution"),
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
            {t("overview.title")}
          </p>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-white/90">
            <p>{t("overview.database")}</p>
            <p>{t("overview.reference")}</p>
            <p>{t("overview.noHosting")}</p>
          </div>
        </section>

        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>{t("policy.title")}</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>{t("policy.respect")}</p>
            <p>{t("policy.action")}</p>
            <p>{t("policy.goal")}</p>
          </div>
        </section>

        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>{t("thirdParty.title")}</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>{t("thirdParty.introduction")}</p>

            <ul className="list-disc space-y-3 pl-6">
              {thirdPartyItems.map((item) => (
                <li key={item}>{item}</li>
              ))}
            </ul>

            <p>{t("thirdParty.ownership")}</p>
            <p>{t("thirdParty.noAffiliation")}</p>
          </div>
        </section>

        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>{t("claims.title")}</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>{t("claims.introduction")}</p>

            <ol className="list-decimal space-y-3 pl-6">
              {claimItems.map((item) => (
                <li key={item}>{item}</li>
              ))}
            </ol>

            <p>{t("claims.action")}</p>
          </div>
        </section>

        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>{t("counterNotice.title")}</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>{t("counterNotice.objection")}</p>
            <p>{t("counterNotice.review")}</p>
          </div>
        </section>

        <section className="rounded-3xl border border-[#8B0000]/15 bg-[#8B0000]/3 p-8 shadow-sm sm:p-10">
          <SectionEyebrow>{t("rightsHolders.title")}</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>{t("rightsHolders.introduction")}</p>

            <ul className="list-disc space-y-3 pl-6">
              {rightsHolderItems.map((item) => (
                <li key={item}>{item}</li>
              ))}
            </ul>

            <p>{t("rightsHolders.collaboration")}</p>
          </div>
        </section>

        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>{t("goodFaith.title")}</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>{t("goodFaith.mission")}</p>
            <p>{t("goodFaith.commitment")}</p>
            <p>{t("goodFaith.contact")}</p>
          </div>
        </section>

        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>{t("contact.title")}</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>{t("contact.description")}</p>

            <div className="rounded-2xl border border-[#002D62]/10 bg-[#002D62]/3 p-6">
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
              {t("contact.contactButton")}
            </Link>

            <Link
              href="/about"
              className="rounded-full border border-[#002D62]/20 px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-[#002D62] transition-colors hover:bg-[#002D62]/5"
            >
              {t("contact.aboutButton")}
            </Link>
          </div>
        </section>
      </div>
    </main>
  );
}
