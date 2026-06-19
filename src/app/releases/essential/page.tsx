import MainWrapper from "@/components/layout/MainWrapper";
import PageSection from "@/components/layout/PageSection";
import SectionCard from "@/components/layout/SectionCard";
import JsonLd from "@/components/seo/JsonLd";
import ReleaseGrid from "@/components/releases/ReleaseGrid";
import { getEssentialReleases } from "@/lib/releaseApi";
import { createPageMetadata } from "@/lib/seo";
import { breadcrumbSchema, collectionPageSchema } from "@/lib/structuredData";

const DESCRIPTION =
  "An editorial guide to culturally important Dominican albums and releases in Mangulina.";

export const metadata = createPageMetadata({
  title: "Essential Dominican Albums | Mangulina",
  description: DESCRIPTION,
  path: "/releases/essential",
});

export const revalidate = 3600;

export default async function EssentialDominicanAlbumsPage() {
  const releases = await getEssentialReleases(48);

  return (
    <MainWrapper>
      <JsonLd
        data={[
          collectionPageSchema({
            name: "Essential Dominican Albums",
            description: DESCRIPTION,
            path: "/releases/essential",
          }),
          breadcrumbSchema([
            { name: "Home", path: "/" },
            { name: "Releases", path: "/releases" },
            { name: "Essential Dominican Albums", path: "/releases/essential" },
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
              Essential Dominican Albums
            </h1>
            <p className="mt-4 max-w-3xl text-base leading-relaxed text-gray-700 sm:text-lg">
              {DESCRIPTION}
            </p>
          </header>

          <SectionCard>
            <div className="section-inner">
              <ReleaseGrid
                releases={releases}
                emptyMessage="The editorial essential albums list is being prepared."
              />
            </div>
          </SectionCard>
        </div>
      </PageSection>
    </MainWrapper>
  );
}
