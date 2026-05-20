//FeaturedArtistImage.tsx
import Image from "next/image";
import type { Artist } from "@/types/music";

interface FeaturedArtistImageProps {
  featuredArtist: Artist | null;
}

export default function FeaturedArtistImage({ featuredArtist }: FeaturedArtistImageProps) {
  return (
    <div className="relative aspect-square w-full sm:w-56 lg:w-64 shrink-0 overflow-hidden rounded-lg bg-gray-100 border border-black/5">
      {featuredArtist?.image_url ? (
        <div className="h-full w-full transition-transform duration-300 ease-out hover:scale-105">
          <Image
            src={featuredArtist.image_url}
            alt={featuredArtist.name || "Featured Artist"}
            fill
            className="object-cover"
            priority
            sizes="(max-width: 640px) 100vw, 50vw"
          />
        </div>
      ) : (
        <div className="flex h-full w-full items-center justify-center text-gray-400 text-xs italic">
          No Image
        </div>
      )}
    </div>
  );
}
