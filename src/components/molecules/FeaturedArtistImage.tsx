//FeaturedArtistImage.tsx
import Image from "next/image";
import type { Artist } from "@/types/music";
import { getArtistImageUrl } from "@/utils/getArtistImageUrl";

interface FeaturedArtistImageProps {
  featuredArtist: Artist | null;
}

export default function FeaturedArtistImage({ featuredArtist }: FeaturedArtistImageProps) {
  if (!featuredArtist) {
    return (
      <div className="relative aspect-square w-full sm:w-56 lg:w-64 shrink-0 overflow-hidden rounded-lg bg-gray-100 border border-black/5 flex items-center justify-center text-gray-400 text-xs italic">
        No Image
      </div>
    );
  }

  const imageUrl = getArtistImageUrl(featuredArtist.id);

  return (
    <div className="relative aspect-square w-full sm:w-56 lg:w-64 shrink-0 overflow-hidden rounded-lg bg-gray-100 border border-black/5">
      <div className="relative h-full w-full transition-transform duration-300 ease-out hover:scale-105">
        <Image
          src={imageUrl}
          alt={featuredArtist.name || "Featured Artist"}
          fill
          className="object-cover"
          priority
          sizes="(max-width: 640px) 100vw, 50vw"
        />
      </div>
    </div>
  );
}
