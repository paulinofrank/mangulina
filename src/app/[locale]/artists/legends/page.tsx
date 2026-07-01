import ArtistStatusDirectoryPage from "@/components/artists/ArtistStatusDirectoryPage";
import { createPageMetadata } from "@/lib/seo";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  return createPageMetadata({
    title: "Dominican Music Legends",
    description:
      "Explore legendary Dominican artists and influential figures who shaped Dominican music history in Mangulina, the Dominican Music Database.",
    path: "/artists/legends",
    locale,
  });
}

type DominicanMusicLegendsPageProps = {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
};

export default async function DominicanMusicLegendsPage({
  searchParams,
}: DominicanMusicLegendsPageProps) {
  return (
    <ArtistStatusDirectoryPage
      path="/artists/legends"
      i18nKey="legends"
      artistStatus="legend"
      searchParams={await searchParams}
    />
  );
}
