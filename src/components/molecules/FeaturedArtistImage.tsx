// src/components/molecules/FeaturedArtistImage.tsx
import Image from "next/image";
import Link from "next/link";
import type { Artist } from "@/types/music";
import { getArtistImageUrl } from "@/utils/getArtistImageUrl";

interface FeaturedArtistImageProps {
  featuredArtist: Artist | null;
}

export default function FeaturedArtistImage({
  featuredArtist,
}: FeaturedArtistImageProps) {
  if (!featuredArtist) {
    return (
      <div className="relative aspect-square w-full sm:w-56 lg:w-64 shrink-0 overflow-hidden rounded-lg bg-gray-100 border border-black/5 flex items-center justify-center text-gray-400 text-xs italic">
        No Image
      </div>
    );
  }

  const imageUrl = getArtistImageUrl(featuredArtist.id);

  return (
    <Link
      href={`/artists/${featuredArtist.slug}`}
      className="group relative block aspect-square w-full shrink-0 overflow-hidden rounded-lg border border-black/5 bg-gray-100 sm:w-56 lg:w-64"
      aria-label={`View ${featuredArtist.name} profile`}
    >
      <Image
        src={imageUrl}
        alt={featuredArtist.name || "Featured Artist"}
        fill
        className="object-cover transition-all duration-300 group-hover:scale-105 group-hover:brightness-110"
        priority
        sizes="(max-width: 640px) 100vw, 256px"
      />
    </Link>
  );
}