import type { Metadata } from "next";
import { Link } from "@/i18n/navigation";
import { getTranslations } from "next-intl/server";
import { createPageMetadata, type SeoLocale } from "@/lib/seo";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale: routeLocale } = await params;
  const locale: SeoLocale = routeLocale === "es" ? "es" : "en";
  const t = await getTranslations("pages.about");
  return createPageMetadata({
    title: t("metadataTitle"),
    description: t("metadataDescription"),
    path: "/about",
    locale,
  });
}

const WHAT_WE_COVER = [
  "artists", "recordings", "albums", "creators", "history", "sources",
] as const;

const PRINCIPLES = [
  "reviewed", "corrections", "respect", "heritage",
] as const;

function SectionEyebrow({ children }: { children: React.ReactNode }) {
  return (
    <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#8B0000]">
      {children}
    </p>
  );
}

export default async function AboutPage() {
  const t = await getTranslations("pages.about");

  return (
    <main className="mx-auto max-w-5xl px-6 pt-20 pb-10 sm:pt-32 sm:pb-16">
      {/* Hero */}
      <header className="mb-12 rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-12">
        <SectionEyebrow>{t("eyebrow")}</SectionEyebrow>

        <h1 className="mb-5 text-4xl font-bold tracking-tight text-[#002D62] sm:text-5xl">
          {t("title")}
        </h1>

        <p className="max-w-3xl text-lg leading-relaxed text-gray-700 sm:text-xl">
          {t("heroDescription")}
        </p>
      </header>

      <div className="space-y-10">
        {/* Mission */}
        <section className="rounded-3xl bg-[#002D62] p-8 text-white shadow-xl sm:p-12">
          <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-white/70">
            {t("missionTitle")}
          </p>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-white/90">
            <p>
              {t("missionReference")}
            </p>

            <p>
              {t("missionAudience")}
            </p>

            <p>
              {t("missionBelief")}
            </p>
          </div>
        </section>

        {/* Why Mangulina */}
        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>{t("whyTitle")}</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              {t("whyName")}
            </p>

            <p>
              {t("whyPurpose")}
            </p>
          </div>
        </section>

        {/* What We Cover */}
        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>{t("coverTitle")}</SectionEyebrow>

          <p className="max-w-3xl text-lg leading-relaxed text-gray-700">
            {t("coverDescription")}
          </p>

          <div className="mt-7 grid gap-4 sm:grid-cols-2">
            {WHAT_WE_COVER.map((item) => (
              <div
                key={item}
                className="flex items-start gap-4 rounded-2xl border border-black/5 bg-[#FAF9F6] p-5"
              >
                <div className="mt-2 h-2.5 w-2.5 shrink-0 rounded-full bg-[#8B0000]" />
                <span className="text-base font-medium leading-relaxed text-[#002D62]">
                  {t(`coverItems.${item}`)}
                </span>
              </div>
            ))}
          </div>
        </section>

        {/* Editorial Principles */}
        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>{t("principlesTitle")}</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              {t("principlesReview")}
            </p>

            <p>
              {t("principlesRole")}
            </p>

            <p>
              {t("principlesEvolution")}
            </p>
          </div>

          <div className="mt-7 grid gap-4 sm:grid-cols-2">
            {PRINCIPLES.map((item) => (
              <div
                key={item}
                className="rounded-2xl border border-[#002D62]/10 bg-[#002D62]/3 p-5 text-base font-medium leading-relaxed text-[#002D62]"
              >
                {t(`principleItems.${item}`)}
              </div>
            ))}
          </div>
        </section>

        {/* Artist Message */}
        <section className="rounded-3xl border border-[#8B0000]/15 bg-[#8B0000]/3 p-8 shadow-sm sm:p-10">
          <SectionEyebrow>{t("artistNoteTitle")}</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              {t("artistNoteMission")}
            </p>

            <p>
              {t("artistNoteRights")}
            </p>

            <p>
              {t("artistNoteContact")}
            </p>
          </div>
        </section>

        {/* Two Feature Cards */}
        <div className="grid gap-6 sm:grid-cols-2">
          <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm">
            <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#002D62]">
              {t("discoveryTitle")}
            </p>

            <p className="text-lg leading-relaxed text-gray-700">
              {t("discoveryDescription")}
            </p>
          </section>

          <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm">
            <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#8B0000]">
              {t("archiveTitle")}
            </p>

            <p className="text-lg leading-relaxed text-gray-700">
              {t("archiveDescription")}
            </p>
          </section>
        </div>

        {/* Participation */}
        <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
          <SectionEyebrow>{t("involvedTitle")}</SectionEyebrow>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              {t("involvedWelcome")}
            </p>

            <p>
              {t("involvedInvitation")}
            </p>
          </div>

          <div className="mt-8 flex flex-col gap-3 sm:flex-row">
            <Link
              href="/contact"
              className="rounded-full bg-[#8B0000] px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-white transition-colors hover:bg-[#6f0000]"
            >
              {t("contactButton")}
            </Link>

            <Link
              href="/contributors"
              className="rounded-full border border-[#002D62]/20 px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-[#002D62] transition-colors hover:bg-[#002D62]/5"
            >
              {t("contributorsButton")}
            </Link>

            <Link
              href="/dmca"
              className="rounded-full border border-black/10 px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-gray-700 transition-colors hover:bg-black/3"
            >
              {t("dmcaButton")}
            </Link>
          </div>
        </section>
      </div>
    </main>
  );
}
