import type { Metadata } from "next";
import { getTranslations } from "next-intl/server";
import ArtistDirectory from "@/components/artists/ArtistDirectory";
import { getArtistDirectoryInitialData } from "@/lib/artistDirectoryData";
import { createPageMetadata } from "@/lib/seo";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const t = await getTranslations({
    locale,
    namespace: "artistDirectory.groups",
  });
  return createPageMetadata({
    title: t("metadataTitle"),
    description: t("metadataDescription"),
    path: "/artists/groups",
    locale,
  });
}

type GroupsArtistsPageProps = {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
};

const FIXED_ARTIST_TYPES = ["group", "duo"] as const;

export default async function GroupsArtistsPage({
  searchParams,
}: GroupsArtistsPageProps) {
  const resolvedSearchParams = await searchParams;
  const initialData = await getArtistDirectoryInitialData({
    searchParams: resolvedSearchParams,
    fixedArtistTypes: [...FIXED_ARTIST_TYPES],
  });

  return (
    <ArtistDirectory
      path="/artists/groups"
      i18nKey="groups"
      fixedArtistTypes={[...FIXED_ARTIST_TYPES]}
      hideGenreFilter
      hideProvinceSelector
      initialData={initialData}
    />
  );
}
