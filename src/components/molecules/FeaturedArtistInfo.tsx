//FeaturedArtistInfo.tsx
import ButtonSecondary from "@/components/atoms/ButtonSecondary";
import type { Artist } from "@/types/music";

type FeaturedArtistInfoProps = {
  featuredArtist?: Artist | null;
};

function getBioExcerpt(bio?: string | null, maxLength = 420) {
  if (!bio) return null;

  const cleanBio = bio.replace(/\s+/g, " ").trim();

  if (cleanBio.length <= maxLength) {
    return cleanBio;
  }

  return cleanBio.slice(0, maxLength).trim() + "...";
}

export default function FeaturedArtistInfo({
  featuredArtist,
}: FeaturedArtistInfoProps) {
  const bioExcerpt = getBioExcerpt(featuredArtist?.bio);

  return (
    <div className="flex-1">
      <p className="text-sm font-normal uppercase tracking-wider text-[#8B0000] mb-2">
        Featured Artist
      </p>

      <h1 className="text-3xl sm:text-4xl font-normal tracking-tight text-gray-800 mb-4">
        {featuredArtist?.name || "Featured Artist"}
      </h1>

      <div className="flex flex-wrap items-center gap-2 mb-4 text-sm font-normal">
        {(featuredArtist?.birth_place || featuredArtist?.province) && (
          <span className="text-gray-700">
            <span className="text-gray-600 mr-1">From:</span>

            <span className="bg-gray-100 px-2 py-0.5 rounded text-gray-700">
               {[featuredArtist?.birth_place, featuredArtist?.province]
        .filter(Boolean)
        .join(", ")}
            </span>
          </span>
        )}

        {featuredArtist?.genres &&
          featuredArtist.genres.length > 0 && (
            <span className="text-gray-700">
              <span className="text-gray-600 mr-1">Genre:</span>

              <span className="bg-gray-100 px-2 py-0.5 rounded text-gray-700">
                {featuredArtist.genres.join(", ")}
              </span>
            </span>
          )}
      </div>

      {bioExcerpt && (
        <p className="text-gray-600 max-w-2xl text-sm leading-relaxed mb-6">
          {bioExcerpt}
        </p>
      )}

      <div className="flex items-center">
        <ButtonSecondary
          href={
            featuredArtist
              ? `/artists/${featuredArtist.slug}`
              : "#"
          }
        />
      </div>
    </div>
  );
}
