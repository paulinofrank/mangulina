// components/organisms/SongArtistPreviewCard.tsx
import { Link } from "@/i18n/navigation";
import { useTranslations } from "next-intl";

import ArtistImage from "@/components/atoms/ArtistImage";
import { getArtistImageUrl } from "@/utils/getArtistImageUrl";

type SongArtistPreviewCardProps = {
  artist: {
    id: string;
    slug: string;
    name: string;
    bio?: string | null;
    views?: number | null;
  } | null;
};

function getExcerpt(value: string | null | undefined, fallback: string) {
  if (!value?.trim()) return fallback;

  const normalized = value.replace(/\s+/g, " ").trim();
  if (normalized.length <= 170) return normalized;

  return `${normalized.slice(0, 167).trim()}...`;
}

export default function SongArtistPreviewCard({ artist }: SongArtistPreviewCardProps) {
  const t = useTranslations();
  if (!artist?.slug) return null;

  const imageUrl = getArtistImageUrl(artist.id);

  return (
    <Link
      href={`/artists/${artist.slug}`}
      className="group block h-fit rounded-xl border border-black/5 bg-white p-5 shadow-sm transition-shadow hover:shadow-md sm:p-6"
    >
      <h2 className="mb-4 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
        {t("song.hero.aboutArtist")}
      </h2>

      <div className="flex gap-4">
        <div className="relative h-24 w-24 shrink-0 overflow-hidden rounded-lg border border-black/5 bg-gray-100 sm:h-28 sm:w-28">
          <ArtistImage imageUrl={imageUrl} name={artist.name} />
        </div>

        <div className="min-w-0 flex-1">
          <div className="flex flex-wrap items-baseline justify-between gap-x-3 gap-y-1">
            <h3 className="truncate text-base font-semibold text-[#002D62] transition-colors group-hover:text-[#CE1126]">
              {artist.name}
            </h3>

            {artist.views != null && artist.views > 0 && (
              <p className="shrink-0 text-xs text-gray-400">
                {artist.views.toLocaleString()} {t("common.views")}
              </p>
            )}
          </div>

          <p className="mt-2 text-sm leading-relaxed text-gray-600">
            {getExcerpt(artist.bio, t("song.hero.artistFallback"))}
          </p>
        </div>
      </div>
    </Link>
  );
}
