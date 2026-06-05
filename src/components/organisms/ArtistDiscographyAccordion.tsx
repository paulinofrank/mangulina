
//artistDiscographyaccordion.tsx

import Image from "next/image";
import Link from "next/link";
import { ChevronDown } from "lucide-react";
import { getSignedCoverUrl } from "@/utils/getSignedCoverUrl";
import type { DiscographyRelease } from "@/lib/artistApi";

function formatDuration(ms: number | null) {
  if (!ms) return "";

  const totalSeconds = Math.round(ms / 1000);
  const minutes = Math.floor(totalSeconds / 60);
  const seconds = totalSeconds % 60;

  return `${minutes}:${seconds.toString().padStart(2, "0")}`;
}

const TYPE_ORDER = ["Album", "EP", "Single", "Compilation", "Live", "Other"];

export default async function ArtistDiscographyGrouped({
  releases,
}: {
  releases: DiscographyRelease[];
}) {
  if (releases.length === 0) {
    return (
      <section className="min-w-0 bg-white p-5 rounded-xl border border-gray-100 shadow-sm sm:p-6">
        <h3 className="text-xs font-normal text-(--color-wikicrimson) uppercase mb-4">
          Discography
        </h3>

        <p className="text-gray-700 leading-relaxed">
          No discography available for this artist.
        </p>
      </section>
    );
  }

  const releasesWithCovers = await Promise.all(
    releases.map(async (release) => ({
      ...release,
      cover_url: await getSignedCoverUrl(release.release_id),
    }))
  );

  const grouped = TYPE_ORDER.map((type) => ({
    type,
    items: releasesWithCovers.filter(
      (release) => release.release_type === type
    ),
  })).filter((group) => group.items.length > 0);

  return (
    <section className="h-fit min-w-0 bg-white p-5 rounded-xl border border-gray-100 shadow-sm sm:p-6">
      <h3 className="text-xs font-normal text-(--color-wikicrimson) uppercase mb-5">
        Discography
      </h3>

      <div className="space-y-7">
        {grouped.map((group) => (
          <div key={group.type}>
            <h4 className="text-sm font-normal uppercase tracking-wider text-(--color-flagblue) mb-2">
              {group.type}s
            </h4>

            <div className="grid min-w-0 gap-2 2xl:grid-cols-2">
              {group.items.map((release) => (
                <details
                  key={release.release_id}
                  className="group rounded-lg border border-gray-100 bg-gray-50 open:bg-white"
                >
                  <summary className="cursor-pointer list-none px-3 py-1.5 transition-colors hover:bg-white [&::-webkit-details-marker]:hidden">
                    <div className="flex min-w-0 items-center gap-2.5">
                      <div className="relative w-11 h-11 rounded-md overflow-hidden bg-gray-200 shrink-0">
                        {release.cover_url ? (
                          <Image
                            src={release.cover_url}
                            alt={release.release_title}
                            fill
                            sizes="44px"
                            className="object-cover"
                          />
                        ) : (
                          <div className="w-full h-full bg-gray-300" />
                        )}
                      </div>

                      <div className="min-w-0 flex-1 leading-tight">
                        <p className="text-(--color-flagblue) text-sm font-normal truncate">
                          {release.release_title}
                        </p>

                        <p className="text-xs text-gray-500 tracking-wide mt-0.5">
                          {release.release_year} · {release.release_type} ·{" "}
                          {release.tracks.length} tracks
                        </p>
                      </div>

                      <span
                        aria-hidden
                        className="inline-flex h-8 w-8 shrink-0 items-center justify-center rounded-full border border-gray-200 bg-white text-gray-500 shadow-sm transition group-hover:border-[#002D62]/30 group-hover:text-[#002D62] group-open:rotate-180"
                      >
                        <ChevronDown className="h-4 w-4" strokeWidth={2} />
                      </span>
                    </div>
                  </summary>

                  <div className="border-t border-gray-100">
                    {release.tracks.map((track) => {
                      const rowContent = (
                        <>
                          <span className="w-6 text-gray-400 tabular-nums text-xs shrink-0">
                            {String(track.track_number ?? "").padStart(2, "0")}
                          </span>

                          <div className="flex-1 truncate">
                            <span className="text-sm">
                              {track.recording_title}
                            </span>
                            {(track.genre || track.subgenre) && (
                              <span className="text-gray-400 text-xs">
                                {" · "}
                                {[track.genre, track.subgenre].filter(Boolean).join(" / ")}
                              </span>
                            )}
                          </div>

                          <span className="text-gray-400 tabular-nums text-xs shrink-0">
                            {formatDuration(track.duration_ms)}
                          </span>
                        </>
                      );

                      const href = `/songs/${track.slug ?? track.recording_id}`;

                      return (
                        <Link
                          key={track.track_id}
                          href={href}
                          className="flex items-center gap-3 px-3 py-2 text-sm border-b border-gray-100 last:border-b-0 leading-snug text-gray-800 hover:bg-gray-50 hover:text-(--color-wikicrimson) transition-colors group"
                        >
                          {rowContent}
                        </Link>
                      );
                    })}
                  </div>
                </details>
              ))}
            </div>
          </div>
        ))}
      </div>
    </section>
  );
}
