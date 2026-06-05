// app/songs/[slug]/page.tsx
import type { Metadata } from "next";
import { notFound } from "next/navigation";

import MainWrapper from "@/components/layout/MainWrapper";
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
import SongYouTubePlayer from "@/components/organisms/SongYouTubePlayer";

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
  type SongMediaRecord,
  type SongRecord,
} from "@/lib/queries/songs";

type PageProps = {
  params: Promise<{ slug: string }>;
};

type SongArtistPreview = {
  id: string;
  slug: string;
  name: string;
  bio: string | null;
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

function isEmbeddedYouTubeMedia(media: SongMediaRecord, youtubeId: string | null | undefined) {
  if (!youtubeId) return false;

  const platform = media.platform?.toLowerCase() ?? "";
  const url = media.url.toLowerCase();
  const externalId = media.external_id?.toLowerCase();
  const normalizedYouTubeId = youtubeId.toLowerCase();

  return (
    externalId === normalizedYouTubeId ||
    ((platform.includes("youtube") || url.includes("youtube.com") || url.includes("youtu.be")) &&
      url.includes(normalizedYouTubeId))
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
      url: song.youtube_embed_allowed ? null : youtubeUrl,
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
  return credits.map((credit) => {
    const artist = Array.isArray(credit.artist)
      ? credit.artist[0] ?? null
      : credit.artist;
    return {
      role: credit.role ?? "Credit",
      name: artist?.name ?? "Unknown",
    };
  });
}

// ── Metadata ──────────────────────────────────────────────────────────────────

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { slug } = await params;
  const song = await getSongBySlug(cleanSongParam(slug));
  if (!song) return { title: "Song Not Found | Mangulina" };

  const genre   = pick(song.genre_name, song.genre);
  const genreTxt = genre ? ` · ${genre}` : "";

  return {
    title: `${song.recording_title} by ${song.artist_name} | Mangulina`,
    description:
      `Explore ${song.recording_title} by ${song.artist_name}${genreTxt}: ` +
      `credits, genre, release details, cultural context, fun facts, and official listening links.`,
  };
}

// ── Page ──────────────────────────────────────────────────────────────────────

export default async function SongProfilePage({ params }: PageProps) {
  const { slug } = await params;
  const cleanSlug = cleanSongParam(slug);

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
              .select("id, slug, name, bio, views")
              .eq("id", song.artist_id!)
              .single()
              .then(({ data }) => data)
          )
        : Promise.resolve(null),
    ]);

  const artistPreview = artistRow as SongArtistPreview | null;
  const artistSlug = artistPreview?.slug ?? null;

  // Resolve the correctly named view fields with fallbacks for legacy names
  const genre       = pick(song.genre_name,          song.genre);
  const subgenre    = pick(song.subgenre_name,        song.subgenre);
  const releaseYear = pick(song.release_year_actual,  song.release_year);
  const labelName   = pick(song.label,                song.label_name);

  // Song pages use the larger cover-art variant: 300px/{release_id}.webp.
  // There is no reliable cover_image_url column — always build from release_id.
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL ?? "";
  const coverImageUrl = song.release_id
    ? `${supabaseUrl}/storage/v1/object/public/cover-art/300px/${song.release_id}.webp`
    : null;

  const normalizedCredits = normalizeCredits(credits);
  const platformLinks     = mergePlatformLinks(song, dbPlatformLinks);
  const canEmbedYouTube   = Boolean(song.youtube_id && song.youtube_embed_allowed === true);
  const canShowLyrics     = Boolean(song.lyrics && song.lyrics_authorized === true);
  const mediaItems        = canEmbedYouTube
    ? media.filter((item) => !isEmbeddedYouTubeMedia(item, song.youtube_id))
    : media;

  return (
    <MainWrapper>
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
          />

          <div className="space-y-5">
            <SongPlatformLinksSection links={platformLinks} />
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
            {canEmbedYouTube && (
              <SongYouTubePlayer
                videoId={song.youtube_id ?? ""}
                coverArtUrl={song.cover_image_url}
              />
            )}

            <div className="grid items-start gap-5 xl:grid-cols-2">
              <SongAboutSection
                about={song.song_about}
                inspiration={song.inspiration}
                culturalContext={song.cultural_context}
                notes={song.notes}
              />

              <SongMediaSection media={mediaItems} />
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
