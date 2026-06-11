"use client";

type ContributorImageProps = {
  contributorId: string;
  alt: string;
  className?: string;
  cacheKey?: number;
};

const placeholderImage = "/placeholder.png";

export function getContributorImageUrl(contributorId: string, cacheKey?: number) {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;

  if (!supabaseUrl) return placeholderImage;

  const url = `${supabaseUrl}/storage/v1/object/public/contributors-images/${contributorId}.webp`;
  return cacheKey ? `${url}?v=${cacheKey}` : url;
}

export default function ContributorImage({
  contributorId,
  alt,
  className = "",
  cacheKey,
}: ContributorImageProps) {
  return (
    // The storage object may not exist yet, so a native img gives us a reliable fallback.
    // eslint-disable-next-line @next/next/no-img-element
    <img
      src={getContributorImageUrl(contributorId, cacheKey)}
      alt={alt}
      className={className}
      onError={(event) => {
        if (!event.currentTarget.src.endsWith(placeholderImage)) {
          event.currentTarget.src = placeholderImage;
        }
      }}
    />
  );
}
