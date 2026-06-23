import ArtistDirectory from "@/components/artists/ArtistDirectory";
import {
  getAwardFilterOptions,
  getRankedAwardedArtistIds,
} from "@/lib/artistAwards";
import { createPageMetadata } from "@/lib/seo";

export const metadata = createPageMetadata({
  title: "Most Awarded Dominican Artists",
  description:
    "Explore the most awarded Dominican artists and their achievements in Mangulina, the Dominican Music Database.",
  path: "/artists/most-awarded",
});

type MostAwardedArtistsPageProps = {
  searchParams: Promise<{ award?: string }>;
};

export default async function MostAwardedArtistsPage({
  searchParams,
}: MostAwardedArtistsPageProps) {
  const { award } = await searchParams;
  const awardOptions = await getAwardFilterOptions();
  const selectedAward = awardOptions.some((option) => option.value === award)
    ? award
    : undefined;
  const [type, id] = selectedAward?.split(":") ?? [];
  const rankedArtistIds = await getRankedAwardedArtistIds(
    type === "award" || type === "category" ? { type, id } : undefined,
  );

  return (
    <ArtistDirectory
      path="/artists/most-awarded"
      i18nKey="mostAwarded"
      hideGenreFilter
      hideProvinceSelector
      rankedArtistIds={rankedArtistIds}
      awardOptions={awardOptions}
    />
  );
}
