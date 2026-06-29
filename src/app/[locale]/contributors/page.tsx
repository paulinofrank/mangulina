import type { Metadata } from "next";
import { Link } from "@/i18n/navigation";
import { getTranslations } from "next-intl/server";
import ContributorImage from "@/components/atoms/ContributorImage";
import { supabase } from "@/lib/supabase";
import type { Contributor } from "@/types/contributor";
import { createPageMetadata, type SeoLocale } from "@/lib/seo";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale: routeLocale } = await params;
  const locale: SeoLocale = routeLocale === "es" ? "es" : "en";
  const t = await getTranslations("pages.contributors");
  return createPageMetadata({
    title: t("metadataTitle"),
    description: t("metadataDescription"),
    path: "/contributors",
    locale,
  });
}

function SectionEyebrow({ children }: { children: React.ReactNode }) {
  return (
    <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-[#8B0000]">
      {children}
    </p>
  );
}

export default async function ContributorsPage() {
  const t = await getTranslations("pages.contributors");
  const { data: contributors, error } = await supabase
    .from("contributors")
    .select(
      "id, name, slug, role, bio, location, specialty, website, facebook, instagram, youtube, active, display_order, created_at"
    )
    .eq("active", true)
    .order("display_order", { ascending: true })
    .order("name", { ascending: true });

  if (error) {
    console.error("Error loading contributors:", error);
  }

  return (
    <main className="mx-auto max-w-5xl px-6 pt-20 pb-2 sm:pb-3">
      <header className="mb-6 rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-12">
        <SectionEyebrow>{t("eyebrow")}</SectionEyebrow>

        <h1 className="mb-5 text-4xl font-bold tracking-tight text-[#002D62] sm:text-5xl">
          {t("title")}
        </h1>

        <p className="max-w-3xl text-lg leading-relaxed text-gray-700 sm:text-xl">
          {t("description")}
        </p>
      </header>

      <section className="rounded-3xl border border-black/10 bg-white p-8 shadow-sm sm:p-10">
        <SectionEyebrow>{t("currentTitle")}</SectionEyebrow>

        {!contributors || contributors.length === 0 ? (
          <p className="text-lg leading-relaxed text-gray-700">
            {t("empty")}
          </p>
        ) : (
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {(contributors as Contributor[]).map((contributor) => (
              <article
                key={contributor.id}
                className="overflow-hidden rounded-3xl border border-black/10 bg-[#FAF9F6] shadow-sm transition hover:shadow-md"
              >
                <div className="aspect-square bg-white">
                  <ContributorImage
                    contributorId={contributor.id}
                    alt={contributor.name}
                    className="h-full w-full object-cover"
                  />
                </div>

                <div className="p-6">
                  <p className="mb-2 text-xs font-semibold uppercase tracking-widest text-[#8B0000]">
                    {contributor.role}
                  </p>

                  <h2 className="text-2xl font-bold text-[#002D62]">
                    {contributor.name}
                  </h2>

                  {contributor.location && (
                    <p className="mt-1 text-sm font-medium text-gray-500">
                      {contributor.location}
                    </p>
                  )}

                  {contributor.bio && (
                    <p className="mt-4 text-base leading-relaxed text-gray-700">
                      {contributor.bio}
                    </p>
                  )}

                  {contributor.specialty &&
                    contributor.specialty.length > 0 && (
                      <div className="mt-5 flex flex-wrap gap-2">
                        {contributor.specialty.map((item) => (
                          <span
                            key={item}
                            className="rounded-full border border-[#002D62]/10 bg-white px-3 py-1 text-xs font-semibold text-[#002D62]"
                          >
                            {item}
                          </span>
                        ))}
                      </div>
                    )}

                  <div className="mt-6 flex flex-wrap gap-3 text-sm font-semibold text-[#8B0000]">
                    {contributor.website && (
                      <a href={contributor.website} target="_blank">
                        {t("website")}
                      </a>
                    )}
                    {contributor.facebook && (
                      <a href={contributor.facebook} target="_blank">
                        Facebook
                      </a>
                    )}
                    {contributor.instagram && (
                      <a href={contributor.instagram} target="_blank">
                        Instagram
                      </a>
                    )}
                    {contributor.youtube && (
                      <a href={contributor.youtube} target="_blank">
                        YouTube
                      </a>
                    )}
                  </div>
                </div>
              </article>
            ))}
          </div>
        )}
      </section>

      <section className="mt-6 rounded-3xl bg-[#002D62] p-8 text-white shadow-xl sm:p-12">
        <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-white/70">
          {t("communityTitle")}
        </p>

        <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-white/90">
          <p>
            {t("communityWelcome")}
          </p>

          <p>
            {t("communityWork")}
          </p>
        </div>
      </section>

      <section className="mt-6 rounded-3xl border border-[#8B0000]/15 bg-[#8B0000]/3 p-8 shadow-sm sm:p-10">
        <SectionEyebrow>{t("joinTitle")}</SectionEyebrow>

        <div className="max-w-4xl space-y-5 text-lg leading-relaxed text-gray-700">
          <p>
            {t("joinKnowledge")}
          </p>

          <p>
            {t("joinImpact")}
          </p>
        </div>

        <div className="mt-8">
          <Link
            href="/contact"
            className="inline-flex rounded-full bg-[#8B0000] px-6 py-3 text-center text-sm font-bold uppercase tracking-widest text-white transition-colors hover:bg-[#6f0000]"
          >
            {t("contactButton")}
          </Link>
        </div>
      </section>
    </main>
  );
}
