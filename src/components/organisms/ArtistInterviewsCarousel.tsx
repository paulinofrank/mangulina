"use client";

import Image from "next/image";
import { useRef, useState } from "react";
import { useTranslations } from "next-intl";
import { X } from "lucide-react";

import CarouselArrows from "@/components/molecules/CarouselArrows";

export type ArtistInterview = {
  id?: string;
  title: string;
  url: string;
  platform: string;
  media_type?: string | null;
  external_id?: string | null;
  thumbnail_url?: string | null;
  published_date?: string | null;
  youtube_channel_id?: string | null;
  youtube_channel_name?: string | null;
  youtube_channel_url?: string | null;
  youtube_channel_avatar_url?: string | null;
  youtube_metadata_fetched_at?: string | null;
  videoId?: string | null;
  notes?: string | null;
};

type ArtistInterviewsCarouselProps = {
  interviews: ArtistInterview[];
};

function getYouTubeThumbnail(videoId: string | undefined) {
  return videoId ? `https://img.youtube.com/vi/${videoId}/hqdefault.jpg` : null;
}

function getYouTubeVideoId(interview: ArtistInterview) {
  if (interview.videoId) return interview.videoId;
  if (interview.platform.toLowerCase() === "youtube" && interview.external_id) {
    return interview.external_id;
  }

  return undefined;
}

function formatDate(value: string) {
  const [year, month, day] = value.split("T")[0].split("-").map(Number);
  if (!year || !month || !day) return value;

  const date = new Date(Date.UTC(year, month - 1, day));
  const monthLabel = new Intl.DateTimeFormat("en-US", {
    month: "long",
    timeZone: "UTC",
  }).format(date);
  const dayLabel = String(day).padStart(2, "0");
  const yearLabel = new Intl.DateTimeFormat("en-US", {
    year: "numeric",
    timeZone: "UTC",
  }).format(date);

  return `${monthLabel} ${dayLabel}, ${yearLabel}`;
}

export default function ArtistInterviewsCarousel({
  interviews,
}: ArtistInterviewsCarouselProps) {
  const t = useTranslations();
  const tc = useTranslations("components");
  const scrollRef = useRef<HTMLDivElement>(null);
  const [activeInterview, setActiveInterview] = useState<ArtistInterview | null>(null);

  if (!interviews.length) return null;

  const scroll = (direction: "left" | "right") => {
    if (!scrollRef.current) return;

    const { scrollLeft, clientWidth } = scrollRef.current;
    const amount = clientWidth * 0.8;

    scrollRef.current.scrollTo({
      left: direction === "left" ? scrollLeft - amount : scrollLeft + amount,
      behavior: "smooth",
    });
  };

  const closeModal = () => setActiveInterview(null);

  return (
    <>
      <section className="relative h-fit min-w-0 max-w-full overflow-hidden rounded-xl border border-gray-100 bg-white p-5 shadow-sm sm:p-6">
        <CarouselArrows onLeft={() => scroll("left")} onRight={() => scroll("right")} />

        <div className="mb-4">
          <h3 className="text-xs font-normal uppercase text-(--color-wikicrimson)">
            {t("artist.videoInterviews")}
          </h3>
          <p className="mt-2 text-xs text-gray-400">
            {t("artist.interviewsSubtitle")}
          </p>
        </div>

        <div
          ref={scrollRef}
          className="flex min-w-0 max-w-full gap-4 overflow-x-auto scrollbar-none pb-2"
        >
          {interviews.map((interview) => {
            const videoId = getYouTubeVideoId(interview);
            const thumbnail = interview.thumbnail_url ?? getYouTubeThumbnail(videoId);
            const isYouTube = Boolean(videoId);
            const showChannelRow = Boolean(
              interview.youtube_channel_name || interview.youtube_channel_avatar_url
            );
            const cardClassName =
              "group w-[min(16rem,78vw)] shrink-0 cursor-pointer sm:w-72 lg:w-80";

            const cardContent = (
              <>
                <div className="relative aspect-video overflow-hidden rounded-lg border border-black/5 bg-gray-100">
                  {thumbnail ? (
                    <img
                      src={thumbnail}
                      alt={interview.title}
                      className="h-full w-full object-cover transition-transform duration-300 group-hover:scale-[1.03]"
                      loading="lazy"
                    />
                  ) : (
                    <div className="flex h-full w-full items-center justify-center text-xs italic text-gray-400">
                      {tc("noPreview")}
                    </div>
                  )}
                </div>

                <div className="mt-3 min-w-0 space-y-2 text-left">
                  <h4 className="line-clamp-2 text-sm font-semibold leading-snug text-(--color-flagblue) transition-colors group-hover:text-(--color-wikicrimson)">
                    {interview.title}
                  </h4>

                  {showChannelRow && (
                    <div className="flex items-start gap-2">
                      {interview.youtube_channel_avatar_url ? (
                        <Image
                          src={interview.youtube_channel_avatar_url}
                          alt={
                            interview.youtube_channel_name
                              ? `${interview.youtube_channel_name} channel logo`
                              : "YouTube channel logo"
                          }
                          width={24}
                          height={24}
                          className="h-6 w-6 shrink-0 rounded-full object-cover"
                          sizes="24px"
                        />
                      ) : (
                        <div
                          className="h-6 w-6 shrink-0 rounded-full bg-gray-200"
                          aria-hidden="true"
                        />
                      )}

                      <div className="min-w-0">
                        {interview.youtube_channel_url &&
                        interview.youtube_channel_name ? (
                          <a
                            href={interview.youtube_channel_url}
                            target="_blank"
                            rel="noopener noreferrer"
                            className="line-clamp-1 text-xs font-medium text-gray-700 hover:text-(--color-wikicrimson)"
                            onClick={(event) => event.stopPropagation()}
                          >
                            {interview.youtube_channel_name}
                          </a>
                        ) : interview.youtube_channel_name ? (
                          <span className="line-clamp-1 text-xs font-medium text-gray-700">
                            {interview.youtube_channel_name}
                          </span>
                        ) : null}

                        {interview.published_date && (
                          <p className="text-xs text-gray-400">
                            {formatDate(interview.published_date)}
                          </p>
                        )}
                      </div>
                    </div>
                  )}

                  {!showChannelRow && interview.published_date && (
                    <p className="text-xs text-gray-400">
                      {formatDate(interview.published_date)}
                    </p>
                  )}
                </div>
              </>
            );

            return isYouTube ? (
              <div
                key={interview.url}
                role="button"
                tabIndex={0}
                onClick={() => setActiveInterview({ ...interview, videoId })}
                onKeyDown={(event) => {
                  if (event.key === "Enter" || event.key === " ") {
                    event.preventDefault();
                    setActiveInterview({ ...interview, videoId });
                  }
                }}
                className={cardClassName}
                aria-label={t("artist.playAria", { title: interview.title })}
              >
                {cardContent}
              </div>
            ) : (
              <a
                key={interview.url}
                href={interview.url}
                target="_blank"
                rel="noopener noreferrer"
                className={cardClassName}
              >
                {cardContent}
              </a>
            );
          })}
        </div>
      </section>

      {activeInterview?.videoId && (
        <div
          className="fixed inset-0 z-[200] flex items-center justify-center bg-black/75 px-4 py-6 backdrop-blur-sm"
          role="dialog"
          aria-modal="true"
          aria-label={activeInterview.title}
          onClick={closeModal}
        >
          <div
            className="w-full max-w-5xl overflow-hidden rounded-xl bg-white shadow-2xl"
            onClick={(event) => event.stopPropagation()}
          >
            <div className="flex items-center justify-between gap-4 border-b border-gray-100 px-4 py-3 sm:px-5">
              <div className="min-w-0">
                <h3 className="truncate text-sm font-semibold text-[#002D62]">
                  {activeInterview.title}
                </h3>
                <p className="text-xs text-gray-400">{activeInterview.platform}</p>
              </div>

              <button
                type="button"
                onClick={closeModal}
                className="inline-flex h-9 w-9 shrink-0 items-center justify-center rounded-full border border-gray-200 text-gray-500 transition-colors hover:border-[#002D62]/30 hover:text-[#002D62]"
                aria-label={t("artist.closeVideo")}
              >
                <X className="h-4 w-4" aria-hidden="true" />
              </button>
            </div>

            <div className="aspect-video bg-black">
              <iframe
                src={`https://www.youtube.com/embed/${activeInterview.videoId}?autoplay=1&rel=0`}
                title={activeInterview.title}
                className="h-full w-full"
                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                allowFullScreen
              />
            </div>

            <div className="flex flex-col gap-2 px-4 py-3 text-xs text-gray-500 sm:flex-row sm:items-center sm:justify-between sm:px-5">
              <span>{tc("playingInMangulina")}</span>
              <a
                href={activeInterview.url}
                target="_blank"
                rel="noopener noreferrer"
                className="font-semibold text-[#CE1126] underline-offset-2 hover:underline"
              >
                {t("fallback.openYoutube")}
              </a>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
