"use client";

import { useRef, useState } from "react";
import { SiYoutube } from "react-icons/si";
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

export default function ArtistInterviewsCarousel({
  interviews,
}: ArtistInterviewsCarouselProps) {
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
            Video Interviews
          </h3>
          <p className="mt-2 text-xs text-gray-400">
            Interviews, conversations, and archival media connected to this artist.
          </p>
        </div>

        <div
          ref={scrollRef}
          className="flex min-w-0 max-w-full gap-4 overflow-x-auto scrollbar-none pb-2 lg:flex-col lg:overflow-visible lg:pb-0"
        >
          {interviews.map((interview) => {
            const videoId = getYouTubeVideoId(interview);
            const thumbnail = interview.thumbnail_url ?? getYouTubeThumbnail(videoId);
            const isYouTube = Boolean(videoId);
            const cardClassName =
              "group w-[min(16rem,78vw)] shrink-0 sm:w-72 lg:flex lg:w-full lg:gap-4";

            const cardContent = (
              <>
                <div className="relative aspect-video overflow-hidden rounded-lg border border-black/5 bg-gray-100 lg:w-48 lg:shrink-0">
                  {thumbnail ? (
                    <img
                      src={thumbnail}
                      alt={interview.title}
                      className="h-full w-full object-cover transition-transform duration-300 group-hover:scale-[1.03]"
                      loading="lazy"
                    />
                  ) : (
                    <div className="flex h-full w-full items-center justify-center text-xs italic text-gray-400">
                      No preview
                    </div>
                  )}
                  {isYouTube && (
                    <span
                      aria-label={interview.platform}
                      className="absolute bottom-2 left-2 inline-flex text-[#FF0000] drop-shadow-[0_1px_1px_rgba(255,255,255,0.95)]"
                    >
                      <SiYoutube
                        className="h-5 w-5 stroke-white"
                        aria-hidden="true"
                      />
                    </span>
                  )}
                </div>

                <div className="mt-3 min-w-0 text-left lg:mt-0 lg:flex lg:flex-1 lg:flex-col lg:justify-center">
                  <h4 className="line-clamp-2 text-sm font-semibold leading-snug text-(--color-flagblue) transition-colors group-hover:text-(--color-wikicrimson)">
                    {interview.title}
                  </h4>
                  {interview.notes && (
                    <p className="mt-1 line-clamp-2 text-xs leading-relaxed text-gray-500">
                      {interview.notes}
                    </p>
                  )}
                </div>
              </>
            );

            return isYouTube ? (
              <button
                key={interview.url}
                type="button"
                onClick={() => setActiveInterview({ ...interview, videoId })}
                className={cardClassName}
                aria-label={`Play ${interview.title}`}
              >
                {cardContent}
              </button>
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
                aria-label="Close video"
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
              <span>Playing inside Mangulina</span>
              <a
                href={activeInterview.url}
                target="_blank"
                rel="noopener noreferrer"
                className="font-semibold text-[#CE1126] underline-offset-2 hover:underline"
              >
                Open on YouTube
              </a>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
