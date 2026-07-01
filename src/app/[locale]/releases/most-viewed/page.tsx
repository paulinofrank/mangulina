import { MostViewedReleasesPage } from "@/app/[locale]/releases/_releasePages";
import { createPageMetadata } from "@/lib/seo";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  return createPageMetadata({
    title: "Most Viewed Dominican Releases | Mangulina",
    description:
      "Browse the most viewed Dominican albums, singles, EPs, compilations, live recordings, and other releases in Mangulina.",
    path: "/releases/most-viewed",
    locale,
  });
}

export const revalidate = 3600;

export default MostViewedReleasesPage;
