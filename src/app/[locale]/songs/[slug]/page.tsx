// app/songs/[slug]/page.tsx
import type { Metadata } from "next";
import { notFound, permanentRedirect } from "next/navigation";
import { setRequestLocale } from "next-intl/server";
import { getPublicReleaseCoverUrl } from "@/lib/releaseCover";
import { createPageMetadata, songSeoTitle } from "@/lib/seo";

import MainWrapper from "@/components/layout/MainWrapper";
import AnalyticsPageView from "@/components/analytics/AnalyticsPageView";
import PageSection from "@/components/layout/PageSection";
import RelatedSongsSection from "@/components/organisms/RelatedSongsSection";
import SongArtistPreviewCard from "@/components/organisms/SongArtistPreviewCard";
import SongAboutSection from "@/components/organisms/SongAboutSection";
import SongCreditsSection from "@/components/organisms/SongCreditsSection";
import SongFunFactsSection from "@/components/organisms/SongFunFactsSection";
import SongHero from "@/components/organisms/SongHero";
import SongLyricsSection from "@/components/organisms/SongLyricsSection";
import SongMediaSection from "@/components/organisms/SongMediaSection";
import SongPlatformLinksSection, {
  type SongPlatformLink,
} from "@/components/organisms/SongPlatformLinksSection";
import SongSlangSection from "@/components/organisms/SongSlangSection";
import SongSourcesSection from "@/components/organisms/SongSourcesSection";
import JsonLd from "@/components/seo/JsonLd";

import { getVisiblePlatformLinks } from "@/lib/platformLinks";
import {
  getMoreSongsByArtist,
  getRelatedSongs,
  getSongBySlug,
  getSongCredits,
  getSongFunFacts,
  getSongMedia,
  getSongPlatformLinks,
  getSongSlang,
  getSongSources,
  type RawCredit,
  type SongRecord,
} from "@/lib/queries/songs";
import { absoluteUrl, breadcrumbSchema, isoDuration } from "@/lib/structuredData";
import { getPublishedEditorialPlainText } from "@/lib/editorial/publicData";

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

type SongArtistPreview = {
  id: string;
  slug: string;
  name: string;
  biography: string | null;
  views: number | null;
};

function cleanSongParam(raw: string) {
  return decodeURIComponent(raw).trim().replace(/^"|"$/g, "");
}

// ── Data helpers ──────────────────────────────────────────────────────────────

/** Pick the best available value for a field the view renamed. */
function pick<T>(...values: (T | null | undefined)[]): T | null {
  for (const v of values) if (v != null) return v;
  return null;
}

function getYouTubeUrl(song: SongRecord): string | null {
  return (
    song.official_video_url ??
    song.youtube_url ??
    (song.youtube_id ? `https://www.youtube.com/watch?v=${song.youtube_id}` : null) ??
    null
  );
}

/**
 * Merge platform links from recording_platform_links (curated, shown first)
 * with legacy URL fields on the song record (shown only if no DB link exists
 * for that platform).
 */
function mergePlatformLinks(
  song: SongRecord,
  dbLinks: { platform: string; url: string; label: string | null; link_type: string }[],
): SongPlatformLink[] {
  const dbPlatforms = new Set(dbLinks.map((l) => l.platform.toLowerCase()));
  const youtubeUrl = getYouTubeUrl(song);

  const legacyLinks: SongPlatformLink[] = [
    { platform: "spotify",       url: song.spotify_url },
    { platform: "apple_music",   url: song.apple_music_url },
    { platform: "youtube_music", url: song.youtube_music_url },
    { platform: "amazon_music",  url: song.amazon_music_url },
    { platform: "deezer",        url: song.deezer_url },
    { platform: "tidal",         url: song.tidal_url },
    { platform: "soundcloud",    url: song.soundcloud_url },
    { platform: "bandcamp",      url: song.bandcamp_url },
    {
      platform: "youtube",
      label: "Watch on YouTube",
      url: youtubeUrl,
    },
  ].filter((l) => !dbPlatforms.has(l.platform.toLowerCase()));

  const dbFormatted: SongPlatformLink[] = dbLinks.map((l) => ({
    platform: l.platform,
    url:      l.url,
    label:    l.label ?? undefined,
  }));

  return [...dbFormatted, ...legacyLinks];
}

function normalizeCredits(credits: RawCredit[]) {
  return credits.map((credit) => ({
    role: credit.role ?? "Credit",
    name: credit.display_name || "Unknown",
    slug: credit.identity_type === "artist" ? credit.artist_slug : null,
    externalContributorId:
      credit.identity_type === "external_contributor" ? credit.identity_id : null,
    country: credit.identity_type === "external_contributor" ? credit.country : null,
  }));
}

// ── Metadata ──────────────────────────────────────────────────────────────────

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { slug, locale } = await params;
  const cleanSlug = cleanSongParam(slug);
  if (cleanSlug === "pagame-tu-vicio-antony-santos") {
    permanentRedirect(locale === "es" ? "/es/songs/pegame-tu-vicio-antony-santos-6" : "/songs/pegame-tu-vicio-antony-santos-6");
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

  if (cleanSlug === "pagame-tu-vicio-antony-santos") {
    permanentRedirect(locale === "es" ? "/es/songs/pegame-tu-vicio-antony-santos-6" : "/songs/pegame-tu-vicio-antony-santos-6");
  }

  const song = await getSongBySlug(cleanSlug);
  if (!song) notFound();

  const recordingId = song.recording_id;

  const [credits, funFacts, slang, sources, media, related, dbPlatformLinks, moreSongs, artistRow] =
    await Promise.all([
      getSongCredits(recordingId),
      getSongFunFacts(recordingId),
      getSongSlang(recordingId),
      getSongSources(recordingId),
      getSongMedia(recordingId),
      getRelatedSongs(recordingId),
      getSongPlatformLinks(recordingId),
      song.artist_id
        ? getMoreSongsByArtist(song.artist_id, recordingId, 12)
        : Promise.resolve([]),
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

  const artistPreview = artistRow
    ? { ...(artistRow as Omit<SongArtistPreview, "biography">), biography: await getPublishedEditorialPlainText(song.artist_id!, "en") }
    : null;
  const artistSlug = artistPreview?.slug ?? null;

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

  const normalizedCredits = normalizeCredits(credits);
  const platformLinks     = mergePlatformLinks(song, dbPlatformLinks);
  const visiblePlatformLinks = getVisiblePlatformLinks(platformLinks);
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
            { name: "Songs", path: "/archive" },
            { name: song.recording_title, path: songPath },
          ], locale),
        ]}
      />
      <AnalyticsPageView eventType="recording_view" entityId={recordingId} />
      <PageSection className="mt-4">
        <div className="grid items-start gap-5 xl:grid-cols-[minmax(0,1.45fr)_minmax(320px,0.85fr)]">
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

          <div className="space-y-5">
            <SongPlatformLinksSection recordingId={recordingId} links={visiblePlatformLinks} />
            <SongArtistPreviewCard artist={artistPreview} />
          </div>
        </div>

        <div className="mt-5 grid items-start gap-5 xl:grid-cols-[minmax(0,1.45fr)_minmax(320px,0.85fr)]">
          <aside className="order-1 space-y-5 xl:order-2">
            <SongCreditsSection
              credits={normalizedCredits}
              labelName={labelName ?? undefined}
              releaseInfo={song.release_info ?? undefined}
            />
          </aside>

          <div className="order-2 space-y-5 xl:order-1">
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

        <div className="mt-5">
          <RelatedSongsSection
            songs={related}
            moreSongs={moreSongs}
            artistName={song.artist_name}
          />
        </div>
      </PageSection>
    </MainWrapper>
  );
}
