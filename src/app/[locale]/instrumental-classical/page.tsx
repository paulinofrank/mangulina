import ArtistDirectory from "@/components/artists/ArtistDirectory";
import { getArtistOccupationOptions } from "@/lib/artistOccupationOptions";
import { getArtistDirectoryInitialData } from "@/lib/artistDirectoryData";
import { createPageMetadata } from "@/lib/seo";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}) {
  const { locale } = await params;
  return createPageMetadata({
    title: "Dominican Instrumental and Classical Artists",
    description:
      "Explore Dominican instrumentalists, classical musicians, orchestral performers, and related artists in Mangulina, the Dominican Music Database.",
    path: "/instrumental-classical",
    locale,
  });
}

type InstrumentalClassicalPageProps = {
  searchParams: Promise<Record<string, string | string[] | undefined>>;
};

export default async function InstrumentalClassicalPage({
  searchParams,
}: InstrumentalClassicalPageProps) {
  const occupationOptions = await getArtistOccupationOptions("instrumentalist");
  const initialData = await getArtistDirectoryInitialData({
    searchParams: await searchParams,
    role: "instrumentalist",
  });

  return (
    <ArtistDirectory
      path="/instrumental-classical"
      i18nKey="instrumentalClassical"
      role="instrumentalist"
      hideGenreFilter
      hideProvinceSelector
      occupationOptions={occupationOptions}
      initialData={initialData}
    />
  );
}
