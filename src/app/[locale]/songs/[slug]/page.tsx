// app/songs/[slug]/page.tsx
import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { redirect } from "@/i18n/navigation";
import { getTranslations, setRequestLocale } from "next-intl/server";
import SongVersionsSection from "@/components/organisms/SongVersionsSection";
import { getSongContext } from "@/lib/queries/songCatalog";
import { workSongSlug } from "@/lib/songIdentity";
import { getPublicReleaseCoverUrl } from "@/lib/releaseCover";
import { createPageMetadata, songSeoTitle } from "@/lib/seo";

import MainWrapper from "@/components/layout/MainWrapper";
import AnalyticsPageView from "@/components/analytics/AnalyticsPageView";
import PageSection from "@/components/layout/PageSection";
import SongAboutSection from "@/components/organisms/SongAboutSection";
import SongFunFactsSection from "@/components/organisms/SongFunFactsSection";
import SongHero from "@/components/organisms/SongHero";
import SongLyricsSection from "@/components/organisms/SongLyricsSection";
import SongMediaSection from "@/components/organisms/SongMediaSection";
import SongSlangSection from "@/components/organisms/SongSlangSection";
import SongSourcesSection from "@/components/organisms/SongSourcesSection";
import JsonLd from "@/components/seo/JsonLd";

import { getVisiblePlatformLinks } from "@/lib/platformLinks";
import {
  getSongBySlug,
  getSongFunFacts,
  getSongMedia,
  getSongSlang,
  getSongSources,
} from "@/lib/queries/songs";
import { absoluteUrl, breadcrumbSchema, isoDuration } from "@/lib/structuredData";

type PageProps = {
  params: Promise<{ slug: string; locale: string }>;
};

// Fallback-only TTL: editorial changes revalidate this page on demand
// (revalidateSongProfilePaths), so the clock exists purely as a safety net.
//
// Held at 7 days. The public catalogue is ~41,700 cacheable profile URLs
// across both locales, so this clock — not editorial activity — sets the ISR
// write bill: roughly 41,700 / 7 days, about 179K writes a month. A 24h value
// projected past 1.2M.
//
// Freshness comes from the on-demand path above and from /api/revalidate after
// work written straight to Postgres. This is the backstop for when both are
// missed, which is why it is a week rather than a month: a correction nobody
// revalidated still reaches the public site within seven days.
export const revalidate = 31536000; // 365 days -- see CATALOG_PROFILE_REVALIDATE_SECONDS

export function generateStaticParams() {
  return [];
}

function cleanSongParam(raw: string) {
  return decodeURIComponent(raw).trim().replace(/^"|"$/g, "");
}

// ── Data helpers ──────────────────────────────────────────────────────────────

/** Pick the best available value for a field the view renamed. */
function pick<T>(...values: (T | null | undefined)[]): T | null {
  for (const v of values) if (v != null) return v;
  return null;
}

// ── Metadata ──────────────────────────────────────────────────────────────────

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { slug, locale } = await params;
  const cleanSlug = cleanSongParam(slug);

  if (cleanSlug.startsWith("work-")) {
    const context = await getSongContext("work", cleanSlug.slice(5));
    const t = await getTranslations({ locale, namespace: "songCatalog" });
    return createPageMetadata({ title: context?.work?.title ?? t("title"),
      description: t("description"), path: `/songs/${cleanSlug}`, locale, noIndex: !context?.work });
  }

  const song = await getSongBySlug(cleanSlug);
  if (!song) {
    return createPageMetadata({
      title: "Song Not Found",
      description: "This recording is not available in the Dominican Music Database.",
      path: `/songs/${slug}`,
      locale,
      noIndex: true,
    });
  }

  const description = locale === "es"
    ? `Información, créditos, lanzamientos y enlaces de plataformas para ${song.recording_title} en la Base de Datos de Música Dominicana.`
    : `Song information, credits, releases and platform links for ${song.recording_title} in the Dominican Music Database.`;
  const image = song.release_id && song.has_cover_image
    ? getPublicReleaseCoverUrl(song.release_id, 300)
    : null;

  return createPageMetadata({
    title: songSeoTitle(song, locale),
    description,
    path: `/songs/${slug}`,
    image,
    openGraphType: "music.song",
    locale,
  });
}

// ── Page ──────────────────────────────────────────────────────────────────────

export default async function SongProfilePage({ params }: PageProps) {
  const { slug, locale } = await params;
  setRequestLocale(locale);
  const cleanSlug = cleanSongParam(slug);

  if (cleanSlug.startsWith("work-")) {
    const context = await getSongContext("work", cleanSlug.slice(5));
    if (!context?.work) notFound();
    return <MainWrapper><PageSection className="mt-4">
      <div className="mx-auto max-w-5xl space-y-5">
        <h1 className="text-3xl font-semibold text-(--color-flagblue)">{context.work.title}</h1>
        <JsonLd data={{ "@context": "https://schema.org", "@type": "MusicComposition",
          name: context.work.title, url: absoluteUrl(`/songs/${workSongSlug(context.work)}`,locale),
          recordedAs: context.recordings.map((recording) => ({ "@type": "MusicRecording", name: recording.title,
            url: absoluteUrl(`/songs/${workSongSlug(context.work!)}#recording-${recording.id}`,locale) })) }} />
        <SongVersionsSection context={context} workPage />
      </div>
    </PageSection></MainWrapper>;
  }

  const song = await getSongBySlug(cleanSlug);
  if (!song) notFound();
  if (song.recording_slug && song.recording_slug !== cleanSlug) {
    redirect({ href: `/songs/${song.recording_slug}`, locale });
  }

  const recordingId = song.recording_id;
  const songContext = await getSongContext("recording", recordingId);

  const [funFacts, slang, sources, media, artistRow] =
    await Promise.all([
      getSongFunFacts(recordingId),
      getSongSlang(recordingId),
      getSongSources(recordingId),
      getSongMedia(recordingId),
      song.artist_id
        ? import("@/lib/supabase").then(({ supabase }) =>
            supabase
              .from("artists")
              .select("id, slug, name, has_image, image_updated_at, views")
              .eq("id", song.artist_id!)
              .single()
              .then(({ data }) => data)
          )
        : Promise.resolve(null),
    ]);

  const artistSlug = artistRow?.slug ?? null;

  // Resolve the correctly named view fields with fallbacks for legacy names
  const genre       = pick(song.genre_name,          song.genre);
  const subgenre    = pick(song.subgenre_name,        song.subgenre);
  const releaseYear = pick(song.release_year_actual,  song.release_year);
  const labelName   = pick(song.label,                song.label_name);

  // Song pages use the larger cover-art variant: 300px/{release_id}.webp.
  // Cover artwork is keyed by the Mangulina release ID in Supabase Storage.
  const coverImageUrl = song.release_id && song.has_cover_image
    ? getPublicReleaseCoverUrl(song.release_id, 300)
    : null;

  const visiblePlatformLinks = getVisiblePlatformLinks(songContext?.recordings[0]?.platform_links ?? []);
  const canShowLyrics     = Boolean(song.lyrics && song.lyrics_authorized === true);
  const sameAs = visiblePlatformLinks
    .map((link) => link.url)
    .filter((url): url is string => Boolean(url));
  const songPath = `/songs/${cleanSlug}`;
  const recordingSchema = {
    "@context": "https://schema.org",
    "@type": "MusicRecording",
    name: song.recording_title,
    url: absoluteUrl(songPath, locale),
    byArtist: song.artist_name
      ? {
          "@type": "MusicGroup",
          name: song.artist_name,
          url: artistSlug ? absoluteUrl(`/artists/${artistSlug}`, locale) : undefined,
        }
      : undefined,
    inAlbum: song.release_title
      ? {
          "@type": "MusicAlbum",
          name: song.release_title,
          url: song.release_slug ? absoluteUrl(`/releases/${song.release_slug}`, locale) : undefined,
        }
      : undefined,
    duration: isoDuration(song.duration),
    isrcCode: song.isrcs?.[0] ?? undefined,
    genre: [genre, subgenre].filter(Boolean),
    datePublished: releaseYear ? String(releaseYear) : song.recording_year ? String(song.recording_year) : undefined,
    sameAs: sameAs.length ? sameAs : undefined,
  };

  return (
    <MainWrapper>
      <JsonLd
        data={[
          recordingSchema,
          breadcrumbSchema([
            { name: "Home", path: "/" },
            { name: "Songs", path: "/songs" },
            { name: song.recording_title, path: songPath },
          ], locale),
        ]}
      />
      <AnalyticsPageView eventType="recording_view" entityId={recordingId} />
      <PageSection className="mt-4">
        <div className="mx-auto max-w-5xl">
          <SongHero
            title={song.recording_title}
            artist={song.artist_name}
            artistSlug={artistSlug}
            year={releaseYear}
            genre={genre}
            subgenre={subgenre}
            duration={song.duration}
            isrcs={song.isrcs}
            views={song.views}
            coverImageUrl={coverImageUrl}
            releaseTitle={song.release_title}
            releaseSlug={song.release_slug}
            shareUrl={absoluteUrl(songPath, locale)}
            shareTitle={songSeoTitle(song, locale)}
          />

          {songContext && <div className="mt-5"><SongVersionsSection context={songContext}
            labelName={labelName ?? undefined} releaseInfo={song.release_info ?? undefined} /></div>}

          <div className="mt-5 space-y-5">
            <div className="grid items-start gap-5 xl:grid-cols-2">
              <SongAboutSection
                about={song.song_about}
                inspiration={song.inspiration}
                culturalContext={song.cultural_context}
                notes={song.notes}
              />

              <SongMediaSection media={media} />
            </div>

            {canShowLyrics && (
              <SongLyricsSection
                lyrics={song.lyrics ?? ""}
                notice="Lyrics displayed with permission from rights holders."
              />
            )}

            <SongFunFactsSection facts={funFacts} />

            <SongSlangSection slang={slang} />

            <SongSourcesSection sources={sources} />
          </div>
        </div>
      </PageSection>
    </MainWrapper>
  );
}
