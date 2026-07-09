// ArtistCard.tsx  (Molecule)
import { useTranslations } from "next-intl";
import { Link } from "@/i18n/navigation";

import ArtistImage from "@/components/atoms/ArtistImage";
import ArtistName from "@/components/atoms/ArtistName";
import ArtistRegion from "@/components/atoms/ArtistRegion";
import type { Artist } from "@/types/music";
import { getArtistImageUrl } from "@/utils/getArtistImageUrl";

type ArtistCardProps = {
  artist: Artist;
  titleAs?: "h3" | "h4";
  showViews?: boolean;
  priorityImage?: boolean;
};

export default function ArtistCard({
  artist,
  titleAs = "h3",
  showViews = true,
  priorityImage = false,
}: ArtistCardProps) {

  const t = useTranslations("common");

  // Build dynamic image URL
  const imageUrl = artist.has_image ? getArtistImageUrl(artist.id) : null;

  return (
    <Link
      href={`/artists/${artist.slug}`}
      prefetch={false}
      className="group block w-full"
    >

      {/* ========================================= */}
      {/* IMAGE FRAME */}
      {/* ========================================= */}

      <div className="relative aspect-square w-full overflow-hidden rounded-lg border border-black/5 bg-gray-100 shadow-[0_1px_2px_rgba(0,0,0,0.04)] transition-all duration-300">

        {/* IMAGE */}
        <div className="relative h-full w-full transition-transform duration-500 ease-out group-hover:scale-[1.06]">

          <ArtistImage
            imageUrl={imageUrl}
            name={artist.name}
            priority={priorityImage}
          />

        </div>

        {/* SUBTLE ARCHIVE OVERLAY */}
        <div className="pointer-events-none absolute inset-0 ring-1 ring-inset ring-black/3" />

      </div>

      {/* ========================================= */}
      {/* TEXT */}
      {/* ========================================= */}

      <div className="relative mt-3">

        <ArtistName
          name={artist.name}
          as={titleAs}
        />

        <ArtistRegion
          region={artist.province}
        />

        {showViews && artist.views ? (
          <p className="text-[11px] text-gray-500 leading-tight">
            {artist.views.toLocaleString()} {t("views")}
          </p>
        ) : null}

      </div>
    </Link>
  );
}
