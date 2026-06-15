import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";

import MainWrapper from "@/components/layout/MainWrapper";
import AnalyticsPageView from "@/components/analytics/AnalyticsPageView";
import PageSection from "@/components/layout/PageSection";
import ReleaseCoverImage from "@/components/genres/ReleaseCoverImage";
import JsonLd from "@/components/seo/JsonLd";
import {
  formatReleaseType,
  getReleaseBySlug,
  type ReleasePageData,
  type ReleaseTrack,
} from "@/lib/releaseApi";
import { createPageMetadata, releaseSeoTitle } from "@/lib/seo";
import { absoluteUrl, breadcrumbSchema } from "@/lib/structuredData";

type PageProps = {
  params: Promise<{ slug: string }>;
};

function cleanSlug(raw: string) {
  return decodeURIComponent(raw).trim().replace(/^"|"$/g, "");
}

function formatDate(release: ReleasePageData) {
  return release.date || release.releaseYear || release.year || null;
}

function formatDuration(ms: number | null) {
  if (!ms || ms <= 0) return "";

  const totalSeconds = Math.round(ms / 1000);
  const minutes = Math.floor(totalSeconds / 60);
  const seconds = totalSeconds % 60;

  return `${minutes}:${seconds.toString().padStart(2, "0")}`;
}

function getTrackHref(track: ReleaseTrack) {
  if (!track.recordingId) return null;
  return `/songs/${track.recordingSlug ?? track.recordingId}`;
}

function ReleaseHero({ release }: { release: ReleasePageData }) {
  const releaseType = formatReleaseType(release.type);
  const releaseDate = formatDate(release);

  return (
    <section className="rounded-2xl border border-black/5 bg-white/70 p-5 shadow-sm sm:p-6">
      <div className="grid gap-6 md:grid-cols-[220px_minmax(0,1fr)] md:items-center lg:grid-cols-[280px_minmax(0,1fr)]">
        <div className="relative mx-auto aspect-square w-full max-w-[280px] overflow-hidden rounded-2xl border border-black/5 bg-gray-100 shadow-sm md:mx-0">
          {release.coverImageUrl ? (
            <ReleaseCoverImage
              src={release.coverImageUrl}
              alt={release.title}
              priority
            />
          ) : (
            <div className="flex h-full w-full items-center justify-center bg-linear-to-br from-gray-100 to-gray-200 text-5xl font-black text-gray-300">
              {release.title.slice(0, 1).toUpperCase()}
            </div>
          )}
        </div>

        <div className="min-w-0 text-center md:text-left">
          <p className="text-xs font-normal uppercase tracking-[0.22em] text-[#CE1126]">
            {releaseType}
          </p>
          <h1 className="mt-3 text-4xl font-black uppercase tracking-tight text-[#002D62] sm:text-5xl">
            {release.title}
          </h1>

          {release.artist && (
            <p className="mt-3 text-lg text-gray-700">
              by{" "}
              {release.artist.slug ? (
                <Link
                  href={`/artists/${release.artist.slug}`}
                  className="font-semibold text-[#002D62] underline-offset-4 hover:text-[#CE1126] hover:underline"
                >
                  {release.artist.name}
                </Link>
              ) : (
                <span className="font-semibold text-[#002D62]">{release.artist.name}</span>
              )}
            </p>
          )}

          <div className="mt-5 flex flex-wrap justify-center gap-2 md:justify-start">
            {releaseDate && (
              <span className="rounded-full border border-[#002D62]/15 bg-[#002D62]/5 px-3 py-1 text-xs font-medium uppercase tracking-[0.16em] text-[#002D62]">
                {releaseDate}
              </span>
            )}
            <span className="rounded-full border border-[#CE1126]/15 bg-[#CE1126]/5 px-3 py-1 text-xs font-medium uppercase tracking-[0.16em] text-[#8B0000]">
              {release.tracks.length} {release.tracks.length === 1 ? "track" : "tracks"}
            </span>
          </div>
        </div>
      </div>
    </section>
  );
}

function ReleaseFactsCard({ release }: { release: ReleasePageData }) {
  const facts = [
    ["Type", formatReleaseType(release.type)],
    ["Release", formatDate(release)],
    ["Label", release.label],
    ["Country", release.country],
    ["Catalog", release.catalogNumber],
    ["Barcode", release.barcode],
  ].filter(([, value]) => Boolean(value));

  return (
    <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm sm:p-6">
      <h2 className="mb-5 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
        Release Details
      </h2>

      <dl className="divide-y divide-gray-100">
        {facts.map(([label, value]) => (
          <div key={label} className="flex gap-4 py-3 first:pt-0 last:pb-0">
            <dt className="w-28 shrink-0 text-xs font-medium uppercase tracking-[0.14em] text-gray-400">
              {label}
            </dt>
            <dd className="min-w-0 flex-1 text-sm text-[#002D62]">{value}</dd>
          </div>
        ))}
      </dl>
    </section>
  );
}

function ReleaseTrackList({ tracks }: { tracks: ReleaseTrack[] }) {
  return (
    <section className="rounded-xl border border-gray-100 bg-white p-5 shadow-sm sm:p-6">
      <h2 className="mb-5 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
        Track Listing
      </h2>

      {tracks.length === 0 ? (
        <p className="text-sm text-gray-600">No tracks available for this release yet.</p>
      ) : (
        <div className="divide-y divide-gray-100">
          {tracks.map((track) => {
            const href = getTrackHref(track);
            const title = (
              <span className="truncate text-sm font-medium text-[#002D62] transition group-hover:text-[#CE1126]">
                {track.title}
              </span>
            );

            return (
              <div
                key={track.id}
                className="grid grid-cols-[2.25rem_minmax(0,1fr)_3.5rem] items-center gap-3 py-3"
              >
                <span className="text-xs tabular-nums text-gray-400">
                  {String(track.trackNumber ?? "").padStart(2, "0")}
                </span>

                {href ? (
                  <Link href={href} className="group min-w-0">
                    {title}
                  </Link>
                ) : (
                  <div className="min-w-0">{title}</div>
                )}

                <span className="text-right text-xs tabular-nums text-gray-400">
                  {formatDuration(track.durationMs)}
                </span>
              </div>
            );
          })}
        </div>
      )}
    </section>
  );
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { slug } = await params;
  const release = await getReleaseBySlug(cleanSlug(slug));

  if (!release) {
    return createPageMetadata({
      title: "Release Not Found",
      description: "This release is not available in the Dominican Music Database.",
      path: `/releases/${slug}`,
      noIndex: true,
    });
  }

  return createPageMetadata({
    title: releaseSeoTitle(release),
    description: `Track listing, release details and credits for ${release.title} in the Dominican Music Database.`,
    path: `/releases/${release.slug}`,
    image: release.coverImageUrl,
    openGraphType: "music.album",
  });
}

export default async function ReleasePage({ params }: PageProps) {
  const { slug } = await params;
  const release = await getReleaseBySlug(cleanSlug(slug));

  if (!release) notFound();
  const releasePath = `/releases/${release.slug}`;
  const releaseSchema = {
    "@context": "https://schema.org",
    "@type": "MusicAlbum",
    name: release.title,
    url: absoluteUrl(releasePath),
    byArtist: release.artist
      ? {
          "@type": "MusicGroup",
          name: release.artist.name,
          url: release.artist.slug
            ? absoluteUrl(`/artists/${release.artist.slug}`)
            : undefined,
        }
      : undefined,
    image: release.coverImageUrl ?? undefined,
    datePublished: formatDate(release) ?? undefined,
    numTracks: release.tracks.length || undefined,
    track: release.tracks.length
      ? release.tracks.map((track, index) => ({
          "@type": "MusicRecording",
          position: track.trackNumber ?? index + 1,
          name: track.title,
          url: getTrackHref(track) ? absoluteUrl(getTrackHref(track)!) : undefined,
        }))
      : undefined,
  };

  return (
    <MainWrapper>
      <AnalyticsPageView eventType="release_view" entityId={release.id} />
      <JsonLd
        data={[
          releaseSchema,
          breadcrumbSchema([
            { name: "Home", path: "/" },
            { name: "Releases", path: "/archive" },
            { name: release.title, path: releasePath },
          ]),
        ]}
      />
      <PageSection className="mt-4">
        <div className="mx-auto max-w-6xl space-y-5">
          <ReleaseHero release={release} />

          <div className="grid items-start gap-5 lg:grid-cols-[320px_minmax(0,1fr)]">
            <ReleaseFactsCard release={release} />
            <ReleaseTrackList tracks={release.tracks} />
          </div>
        </div>
      </PageSection>
    </MainWrapper>
  );
}
