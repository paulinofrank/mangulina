import Link from "next/link";
import { getTranslations } from "next-intl/server";

import MainWrapper from "@/components/layout/MainWrapper";
import PageSection from "@/components/layout/PageSection";
import SectionCard from "@/components/layout/SectionCard";
import ReleaseCoverImage from "@/components/genres/ReleaseCoverImage";
import JsonLd from "@/components/seo/JsonLd";
import {
  ReleaseDecadeCards,
  ReleaseTypeCards,
} from "@/components/releases/ReleaseDiscoveryCards";
import ReleaseSection from "@/components/releases/ReleaseSection";
import {
  formatReleaseType,
  getReleaseHubData,
  type ReleaseSummary,
} from "@/lib/releaseApi";
import { createPageMetadata } from "@/lib/seo";
import { breadcrumbSchema, collectionPageSchema } from "@/lib/structuredData";

const DESCRIPTION =
  "Explore Dominican albums, singles, EPs, compilations, live recordings, and other releases from artists across merengue, bachata, salsa, urban, worship, and more.";

export const metadata = createPageMetadata({
  title: "Dominican Albums & Releases | Mangulina",
  description: DESCRIPTION,
  path: "/releases",
});

export const revalidate = 3600;

async function FeaturedRelease({ release }: { release: ReleaseSummary | null }) {
  const t = await getTranslations("pages");

  if (!release) {
    return (
      <SectionCard>
        <div className="section-inner">
          <div className="section-header">
            <h2>{t("releases.releaseDetails")}</h2>
          </div>
          <p className="text-sm text-gray-500">{t("releases.featuredComingSoon")}</p>
        </div>
      </SectionCard>
    );
  }

  return (
    <section className="overflow-hidden rounded-xl border border-black/5 bg-white/70 shadow-sm">
      <div className="grid gap-0 md:grid-cols-[280px_minmax(0,1fr)]">
        <div className="relative aspect-square bg-gray-100">
          {release.coverImageUrl ? (
            <ReleaseCoverImage src={release.coverImageUrl} alt={release.title} priority />
          ) : (
            <div className="flex h-full w-full items-center justify-center text-5xl font-black text-gray-300">
              {release.title.slice(0, 1).toUpperCase()}
            </div>
          )}
        </div>
        <div className="flex flex-col justify-center p-6 sm:p-8">
          <p className="text-xs font-semibold uppercase tracking-[0.22em] text-[#CE1126]">
            Featured Release
          </p>
          <h2 className="mt-3 text-3xl font-black uppercase tracking-tight text-[#002D62] sm:text-4xl">
            {release.title}
          </h2>
          <p className="mt-3 text-base text-gray-700">
            {[release.artist?.name, release.releaseYear, formatReleaseType(release.type)]
              .filter(Boolean)
              .join(" / ")}
          </p>
          {release.slug && (
            <Link
              href={`/releases/${release.slug}`}
              className="mt-6 inline-flex w-fit rounded-full bg-[#002D62] px-5 py-2 text-sm font-semibold uppercase tracking-[0.14em] text-white transition hover:bg-[#002D62]/90"
            >
              View Release
            </Link>
          )}
        </div>
      </div>
    </section>
  );
}

export default async function ReleasesHubPage() {
  const data = await getReleaseHubData();

  return (
    <MainWrapper>
      <JsonLd
        data={[
          collectionPageSchema({
            name: "Dominican Albums & Releases",
            description: DESCRIPTION,
            path: "/releases",
          }),
          breadcrumbSchema([
            { name: "Home", path: "/" },
            { name: "Releases", path: "/releases" },
          ]),
        ]}
      />
      <PageSection className="mt-4">
        <div className="mx-auto max-w-6xl space-y-5">
          <header className="rounded-xl border border-black/5 bg-white/70 p-6 shadow-sm sm:p-8">
            <p className="text-xs font-semibold uppercase tracking-[0.22em] text-[#CE1126]">
              Releases
            </p>
            <h1 className="mt-3 text-4xl font-black uppercase tracking-tight text-[#002D62] sm:text-5xl">
              Dominican Albums & Releases
            </h1>
            <p className="mt-4 max-w-4xl text-base leading-relaxed text-gray-700 sm:text-lg">
              {DESCRIPTION}
            </p>
          </header>

          <FeaturedRelease release={data.featuredRelease} />
          <ReleaseSection
            title="Most Viewed Releases"
            releases={data.mostViewed}
            href="/releases/most-viewed"
          />
          <ReleaseSection
            title="Recent Releases"
            releases={data.recent}
            href="/releases/recent"
          />

          <SectionCard>
            <div className="section-inner">
              <div className="section-header">
                <h2>Browse by Type</h2>
              </div>
              <ReleaseTypeCards types={data.typeCounts} />
            </div>
          </SectionCard>

          <SectionCard>
            <div className="section-inner">
              <div className="section-header">
                <h2>Browse by Decade</h2>
              </div>
              <ReleaseDecadeCards decades={data.decadeCounts} />
            </div>
          </SectionCard>

          <ReleaseSection
            title="Essential Dominican Albums"
            releases={data.essential}
            href="/releases/essential"
            emptyMessage="The editorial essential albums list is being prepared."
          />
        </div>
      </PageSection>
    </MainWrapper>
  );
}
