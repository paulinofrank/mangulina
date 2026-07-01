import ArtistStatusDirectoryPage from "@/components/artists/ArtistStatusDirectoryPage";
import { createPageMetadata } from "@/lib/seo";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  return createPageMetadata({
    title: "Emerging Dominican Artists",
    description:
      "Discover emerging Dominican artists and rising talent across Dominican music in Mangulina, the Dominican Music Database.",
    path: "/artists/emerging",
    locale,
  });
}

type EmergingDominicanArtistsPageProps = {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
};

export default async function EmergingDominicanArtistsPage({
  searchParams,
}: EmergingDominicanArtistsPageProps) {
  return (
    <ArtistStatusDirectoryPage
      path="/artists/emerging"
      i18nKey="emerging"
      artistStatus="emerging"
      searchParams={await searchParams}
    />
  );
}
