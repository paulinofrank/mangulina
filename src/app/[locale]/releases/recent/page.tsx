import { RecentReleasesPage } from "@/app/[locale]/releases/_releasePages";
import { createPageMetadata } from "@/lib/seo";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  return createPageMetadata({
    title: "Recent Dominican Releases | Mangulina",
    description:
      "Browse recent Dominican albums, singles, EPs, compilations, live recordings, and other releases in Mangulina.",
    path: "/releases/recent",
    locale,
  });
}

export const revalidate = 3600;

export default RecentReleasesPage;
