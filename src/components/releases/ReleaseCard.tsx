import Link from "next/link";
import ReleaseCoverImage from "@/components/genres/ReleaseCoverImage";
import { formatReleaseType, type ReleaseSummary } from "@/lib/releaseApi";

type ReleaseCardProps = {
  release: ReleaseSummary;
};

export default function ReleaseCard({ release }: ReleaseCardProps) {
  const year = release.releaseYear ? String(release.releaseYear) : null;
  const type = formatReleaseType(release.type);
  const artistName = release.artist?.name ?? "Unknown Artist";

  const content = (
    <article className="group h-full">
      <div className="relative aspect-square overflow-hidden rounded-lg border border-black/5 bg-gray-100 shadow-sm">
        {release.coverImageUrl ? (
          <ReleaseCoverImage src={release.coverImageUrl} alt={release.title} />
        ) : (
          <div className="flex h-full w-full items-center justify-center bg-gray-100 px-4 text-center text-sm text-gray-400">
            No cover
          </div>
        )}
      </div>

      <div className="mt-3">
        <h3 className="line-clamp-2 text-sm font-semibold leading-snug text-[#002D62] transition-colors group-hover:text-[#CE1126]">
          {release.title}
        </h3>
        <p className="mt-1 truncate text-xs text-gray-500">{artistName}</p>
        <p className="mt-1 text-[11px] uppercase tracking-[0.14em] text-gray-400">
          {[year, type].filter(Boolean).join(" / ")}
        </p>
      </div>
    </article>
  );

  if (!release.slug) return content;

  return (
    <Link
      href={`/releases/${release.slug}`}
      className="block rounded-lg focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-[#002D62] focus-visible:ring-offset-2"
      aria-label={`View ${release.title}`}
    >
      {content}
    </Link>
  );
}
