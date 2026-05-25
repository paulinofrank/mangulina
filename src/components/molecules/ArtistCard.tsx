// ArtistCard.tsx  (Molecule)
import Link from "next/link";

import ArtistImage from "@/components/atoms/ArtistImage";
import ArtistName from "@/components/atoms/ArtistName";
import ArtistRegion from "@/components/atoms/ArtistRegion";
import type { Artist } from "@/types/music";
import { getArtistImageUrl } from "@/utils/getArtistImageUrl";

type ArtistCardProps = {
  artist: Artist;
  titleAs?: "h3" | "h4";
};

export default function ArtistCard({
  artist,
  titleAs = "h3",
}: ArtistCardProps) {

  // Build dynamic image URL
  const imageUrl = getArtistImageUrl(artist.id);

  return (
    <Link
      href={`/artists/${artist.slug}`}
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
          />

          {artist.views ? (
            <span className="absolute top-2 right-2 text-[12px] text-gray-500 text-right leading-none">
              {artist.views.toLocaleString()}
              <br />
              <span className="text-[10px]">views</span>
            </span>
          ) : null}

        </div>

        {/* SUBTLE ARCHIVE OVERLAY */}
        <div className="pointer-events-none absolute inset-0 ring-1 ring-inset ring-black/3" />

      </div>

      {/* ========================================= */}
      {/* TEXT */}
      {/* ========================================= */}

      <div className="relative mt-3 space-y-1">

        <ArtistName
          name={artist.name}
          as={titleAs}
        />

        <ArtistRegion
          region={artist.province}
        />

      </div>
    </Link>
  );
}
