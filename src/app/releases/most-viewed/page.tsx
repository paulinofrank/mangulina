import { MostViewedReleasesPage } from "@/app/releases/_releasePages";
import { createPageMetadata } from "@/lib/seo";

export const metadata = createPageMetadata({
  title: "Most Viewed Dominican Releases | Mangulina",
  description:
    "Browse the most viewed Dominican albums, singles, EPs, compilations, live recordings, and other releases in Mangulina.",
  path: "/releases/most-viewed",
});

export const revalidate = 3600;

export default MostViewedReleasesPage;
