import Image from "next/image";
import type { Artist } from "@/types/music";

interface FeaturedArtistImageProps {
  featuredArtist: Artist | null;
}

export default function FeaturedArtistImage({ featuredArtist }: FeaturedArtistImageProps) {
  return (
    /* FIX: Added 'aspect-square' and 'w-full'. 
      On mobile, without a fixed height or aspect ratio, 
      a relative container with a 'fill' image collapses to 0px.
    */
    <div className="relative w-full aspect-square sm:aspect-auto sm:h-full min-h-75 rounded-2xl overflow-hidden shadow-lg border border-black/5 bg-gray-100">
      {featuredArtist?.image_url ? (
        <Image
          src={featuredArtist.image_url}
          alt={featuredArtist.name || "Featured Artist"}
          fill
          className="object-cover transition-transform duration-700 hover:scale-105"
          priority
          sizes="(max-width: 640px) 100vw, 50vw"
        />
      ) : (
        <div className="flex h-full w-full items-center justify-center text-gray-400 italic text-sm">
          No Image Available
        </div>
      )}
    </div>
  );
}