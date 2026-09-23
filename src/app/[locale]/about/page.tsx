import type { Metadata } from "next";
import { Link } from "@/i18n/navigation";
import { getTranslations, setRequestLocale } from "next-intl/server";
import { Sparkles } from "lucide-react";
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

// Section titles are real h2s so the page has an outline; the utilities
// override the global h2 style to keep the small eyebrow look.
function SectionHeading({
  id,
  className = "text-[#8B0000]",
  children,
}: {
  id: string;
  className?: string;
  children: React.ReactNode;
}) {
  return (
    <h2 id={id} className={`mb-4 text-sm font-semibold uppercase tracking-widest ${className}`}>
      {children}
    </h2>
  );
}

export default async function AboutPage({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  setRequestLocale(locale);
  const t = await getTranslations("pages.about");

  return (
    <main className="mx-auto max-w-5xl px-6 pt-20 pb-10 sm:pt-23 sm:pb-16">
      {/* Hero */}
      <header className="relative mb-12 overflow-hidden rounded-3xl border border-amber-300/60 bg-gradient-to-br from-amber-50 via-white to-orange-50 p-7 shadow-sm sm:p-10 lg:p-12">
        <Sparkles
          aria-hidden="true"
          className="absolute right-7 top-7 size-9 text-amber-500/25 sm:right-10 sm:top-10 sm:size-12"
          strokeWidth={1.5}
        />
        <div className="relative max-w-4xl">
          <span className="inline-flex rounded-full border border-amber-500/30 bg-amber-400/15 px-3 py-1 text-xs font-bold tracking-widest text-amber-900">
            {t("betaHero.badge")}
          </span>
          <h1 className="mt-6 text-4xl font-bold tracking-tight text-[#002D62] sm:text-5xl lg:text-6xl">
            {t("betaHero.title")}
          </h1>
          <p className="mt-3 text-xl font-semibold text-[#8B0000] sm:text-2xl">
            {t("betaHero.subtitle")}
          </p>
          <div className="mt-8 space-y-5 text-base leading-relaxed text-gray-700 sm:text-lg">
            <p>{t("betaHero.paragraphOne")}</p>
            <p className="font-medium text-[#002D62]">
              {t("betaHero.paragraphThree")}
            </p>
          </div>
        </div>
      </header>

      <div className="space-y-10">
        {/* Mission */}
        <section
          aria-labelledby="about-mission"
          className="rounded-3xl bg-[#002D62] p-8 text-white shadow-xl sm:p-12"
        >
          <SectionHeading id="about-mission" className="text-white/70">
            {t("missionTitle")}
          </SectionHeading>

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
        <section
          aria-labelledby="about-why"
          className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10"
        >
          <SectionHeading id="about-why">{t("whyTitle")}</SectionHeading>

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
        <section
          aria-labelledby="about-cover"
          className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10"
        >
          <SectionHeading id="about-cover">{t("coverTitle")}</SectionHeading>

          <p className="max-w-3xl text-lg leading-relaxed text-gray-700">
            {t("coverDescription")}
          </p>

          <ul className="mt-7 grid gap-4 sm:grid-cols-2">
            {WHAT_WE_COVER.map((item) => (
              <li
                key={item}
                className="flex items-start gap-4 rounded-2xl border border-black/5 bg-[#FAF9F6] p-5"
              >
                <span aria-hidden="true" className="mt-2 h-2.5 w-2.5 shrink-0 rounded-full bg-[#8B0000]" />
                <span className="text-base font-medium leading-relaxed text-[#002D62]">
                  {t(`coverItems.${item}`)}
                </span>
              </li>
            ))}
          </ul>
        </section>

        {/* Editorial Principles */}
        <section
          aria-labelledby="about-principles"
          className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10"
        >
          <SectionHeading id="about-principles">{t("principlesTitle")}</SectionHeading>

          <p className="max-w-4xl text-lg leading-relaxed text-gray-700">
            {t("principlesRole")}
          </p>

          <ul className="mt-7 grid gap-4 sm:grid-cols-2">
            {PRINCIPLES.map((item) => (
              <li
                key={item}
                className="rounded-2xl border border-[#002D62]/10 bg-[#002D62]/3 p-5 text-base font-medium leading-relaxed text-[#002D62]"
              >
                {t(`principleItems.${item}`)}
              </li>
            ))}
          </ul>
        </section>

        {/* Artist Message */}
        <section
          aria-labelledby="about-artists"
          className="rounded-3xl border border-[#8B0000]/15 bg-[#8B0000]/3 p-8 shadow-sm sm:p-10"
        >
          <SectionHeading id="about-artists">{t("artistNoteTitle")}</SectionHeading>

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

        {/* Participation */}
        <section
          aria-labelledby="about-involved"
          className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10"
        >
          <SectionHeading id="about-involved">{t("involvedTitle")}</SectionHeading>

          <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
            <p>
              {t("involvedWelcome")}
            </p>

            <p>
              {t("involvedInvitation")}
            </p>

            <p className="font-medium text-[#002D62]">
              {t("involvedReturn")}
            </p>

            <p>
              {t("involvedThanks")}
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
