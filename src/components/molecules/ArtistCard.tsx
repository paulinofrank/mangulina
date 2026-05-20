// ArtistCard.tsx  (Molecule)
import Link from "next/link";

import ArtistImage from "@/components/atoms/ArtistImage";
import ArtistName from "@/components/atoms/ArtistName";
import ArtistRegion from "@/components/atoms/ArtistRegion";

import type { Artist } from "@/types/music";

type ArtistCardProps = {
  artist: Artist;
  titleAs?: "h3" | "h4";
};

export default function ArtistCard({
  artist,
  titleAs = "h3",
}: ArtistCardProps) {

  /**
   * Artist image path
   * Derived dynamically from Supabase Storage
   */
  const imageUrl =
    `${process.env.NEXT_PUBLIC_SUPABASE_URL}` +
    `/storage/v1/object/public/artists-images/` +
    `${artist.id}/profile.jpg`;

  return (
    <Link
      href={`/artists/${artist.id}`}
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

        </div>

        {/* SUBTLE ARCHIVE OVERLAY */}
        <div className="pointer-events-none absolute inset-0 ring-1 ring-inset ring-black/3" />

      </div>

      {/* ========================================= */}
      {/* TEXT */}
      {/* ========================================= */}

      <div className="mt-3 space-y-1">

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