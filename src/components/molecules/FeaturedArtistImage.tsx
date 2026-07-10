// src/components/molecules/FeaturedArtistImage.tsx
import { useTranslations } from "next-intl";
import { Link } from "@/i18n/navigation";
import ArtistImage from "@/components/atoms/ArtistImage";
import type { Artist } from "@/types/music";
import { getArtistImageUrlIfAvailable } from "@/utils/getArtistImageUrl";

interface FeaturedArtistImageProps {
  featuredArtist: Artist | null;
}

export default function FeaturedArtistImage({
  featuredArtist,
}: FeaturedArtistImageProps) {
  const t = useTranslations("common");

  if (!featuredArtist) {
    return (
      <div className="relative aspect-square w-full sm:w-56 lg:w-64 shrink-0 overflow-hidden rounded-lg bg-gray-100 border border-black/5 flex items-center justify-center text-gray-400 text-xs italic">
        {t("noImage")}
      </div>
    );
  }

  const imageUrl = getArtistImageUrlIfAvailable(featuredArtist);

  if (!imageUrl) {
    return (
      <div className="relative aspect-square w-full sm:w-56 lg:w-64 shrink-0 overflow-hidden rounded-lg bg-gray-100 border border-black/5 flex items-center justify-center text-gray-400 text-xs italic">
        {t("noImage")}
      </div>
    );
  }

  return (
    <Link
      href={`/artists/${featuredArtist.slug}`}
      prefetch={false}
      className="group relative block aspect-square w-full shrink-0 overflow-hidden rounded-lg border border-black/5 bg-gray-100 sm:w-56 lg:w-64"
      aria-label={t("viewArtistProfile", { name: featuredArtist.name })}
    >
      <div className="relative h-full w-full transition-all duration-300 group-hover:scale-105 group-hover:brightness-110">
        <ArtistImage
          imageUrl={imageUrl}
          name={featuredArtist.name || "Featured Artist"}
          priority
          sizes="(max-width: 640px) 100vw, 256px"
        />
      </div>
    </Link>
  );
}
