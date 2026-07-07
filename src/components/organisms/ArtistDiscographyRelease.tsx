"use client";

import Image from "next/image";
import { useState } from "react";
import { ChevronDown } from "lucide-react";
import { useTranslations } from "next-intl";

import { Link } from "@/i18n/navigation";

type LazyDiscographyTrack = {
  track_id: string;
  disc_number: number;
  track_number: number | null;
  recording_id: string;
  recording_title: string;
  duration_ms: number | null;
  genre: string | null;
  subgenre: string | null;
  recording_context: string | null;
  slug: string | null;
};

type ArtistDiscographyReleaseProps = {
  release: {
    release_id: string;
    release_slug: string | null;
    release_title: string;
    release_year: number | null;
    release_type: string | null;
    track_count: number;
    cover_url: string | null;
  };
};

function formatDuration(ms: number | null) {
  if (!ms) return "";

  const totalSeconds = Math.round(ms / 1000);
  const minutes = Math.floor(totalSeconds / 60);
  const seconds = totalSeconds % 60;

  return `${minutes}:${seconds.toString().padStart(2, "0")}`;
}

export default function ArtistDiscographyRelease({
  release,
}: ArtistDiscographyReleaseProps) {
  const t = useTranslations("artist");
  const components = useTranslations("components");
  const releases = useTranslations("releases");
  const [isOpen, setIsOpen] = useState(false);
  const [tracks, setTracks] = useState<LazyDiscographyTrack[] | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const loadTracks = async () => {
    if (tracks || isLoading) return;

    setIsLoading(true);
    setError(null);

    try {
      const response = await fetch(
        `/api/artist-discography/release-tracks?releaseId=${encodeURIComponent(
          release.release_id,
        )}`,
      );
      const payload = (await response.json()) as {
        ok?: boolean;
        error?: string;
        tracks?: LazyDiscographyTrack[];
      };

      if (!response.ok || !payload.ok) {
        throw new Error(payload.error || "Unable to load tracks.");
      }

      setTracks(payload.tracks ?? []);
    } catch (loadError) {
      setError(loadError instanceof Error ? loadError.message : "Unable to load tracks.");
      setTracks([]);
    } finally {
      setIsLoading(false);
    }
  };

  const handleToggle = () => {
    const nextOpen = !isOpen;
    setIsOpen(nextOpen);
    if (nextOpen) void loadTracks();
  };

  return (
    <article className="group rounded-lg border border-gray-100 bg-gray-50 open:bg-white">
      <div className="px-3 py-1.5 transition-colors hover:bg-white">
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
            {release.release_slug ? (
              <Link
                href={`/releases/${release.release_slug}`}
                prefetch={false}
                className="block truncate text-sm font-normal text-(--color-flagblue) underline-offset-4 hover:text-(--color-wikicrimson) hover:underline"
              >
                {release.release_title}
              </Link>
            ) : (
              <p className="truncate text-sm font-normal text-(--color-flagblue)">
                {release.release_title}
              </p>
            )}

            <p className="text-xs text-gray-500 tracking-wide mt-0.5">
              {release.release_year} · {release.release_type} ·{" "}
              {t("tracksCount", { count: release.track_count })}
            </p>
          </div>

          <button
            type="button"
            onClick={handleToggle}
            className="inline-flex h-8 w-8 shrink-0 cursor-pointer items-center justify-center rounded-full border border-gray-200 bg-white text-gray-500 shadow-sm transition group-hover:border-[#002D62]/30 group-hover:text-[#002D62]"
            aria-expanded={isOpen}
            aria-label={`${release.release_title} ${t("tracksCount", {
              count: release.track_count,
            })}`}
          >
            <ChevronDown
              className={`h-4 w-4 transition-transform ${isOpen ? "rotate-180" : ""}`}
              strokeWidth={2}
              aria-hidden="true"
            />
          </button>
        </div>
      </div>

      {isOpen && (
        <div className="border-t border-gray-100">
          {isLoading ? (
            <div className="px-3 py-3 text-sm text-gray-500">{components("loading")}</div>
          ) : error ? (
            <div className="px-3 py-3 text-sm text-gray-500">{error}</div>
          ) : tracks && tracks.length > 0 ? (
            tracks.map((track) => {
              const href = `/songs/${track.slug ?? track.recording_id}`;

              return (
                <Link
                  key={track.track_id}
                  href={href}
                  prefetch={false}
                  className="flex items-center gap-3 px-3 py-2 text-sm border-b border-gray-100 last:border-b-0 leading-snug text-gray-800 hover:bg-gray-50 hover:text-(--color-wikicrimson) transition-colors group"
                >
                  <span className="w-6 text-gray-400 tabular-nums text-xs shrink-0">
                    {String(track.track_number ?? "").padStart(2, "0")}
                  </span>

                  <div className="flex-1 truncate">
                    <span className="text-sm">{track.recording_title}</span>
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
                </Link>
              );
            })
          ) : (
            <div className="px-3 py-3 text-sm text-gray-500">
              {releases("noTracksAvailable")}
            </div>
          )}
        </div>
      )}
    </article>
  );
}
