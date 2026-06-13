import type { Metadata } from "next";

export const SITE_NAME = "Mangulina";
export const SITE_URL = (
  process.env.NEXT_PUBLIC_SITE_URL ??
  process.env.SITE_URL ??
  "https://mangulina.vercel.app"
).replace(/\/$/, "");

export const DEFAULT_DESCRIPTION =
  "Explore Dominican artists, songs, albums, genres, awards and music history in Mangulina, the Dominican Music Database.";

export function buildCanonical(path: string) {
  const normalizedPath = path === "/" ? "" : `/${path.replace(/^\/+|\/+$/g, "")}`;
  return `${SITE_URL}${normalizedPath || "/"}`;
}

export function truncateDescription(text: string | null | undefined, fallback: string) {
  const clean = text?.replace(/<[^>]*>/g, " ").replace(/\s+/g, " ").trim();
  if (!clean) return fallback;
  if (clean.length <= 160) return clean;
  return `${clean.slice(0, 157).replace(/\s+\S*$/, "").trim()}...`;
}

export function artistSeoTitle(artist: { name: string }) {
  return `${artist.name} - Biography, Songs & Discography`;
}

export function songSeoTitle(recording: { recording_title: string }) {
  return `${recording.recording_title} - Song Information`;
}

export function releaseSeoTitle(release: {
  title: string;
  type?: string | null;
  artist?: { name: string } | null;
}) {
  if (!release.artist?.name) return `${release.title} - Release Information`;
  const type = release.type?.trim() || "Release";
  const formattedType = type.charAt(0).toUpperCase() + type.slice(1).toLowerCase();
  return `${release.title} - ${formattedType} by ${release.artist.name}`;
}

export function genreSeoTitle(genre: { title?: string; name?: string }) {
  return `${genre.title ?? genre.name ?? "Genre"} Artists, Songs & Albums`;
}

type PageMetadataOptions = {
  title: string;
  description: string;
  path: string;
  image?: string | null;
  openGraphType?: "website" | "profile" | "article" | "music.song" | "music.album";
  noIndex?: boolean;
};

export function createPageMetadata({
  title,
  description,
  path,
  image,
  openGraphType = "website",
  noIndex = false,
}: PageMetadataOptions): Metadata {
  const canonical = buildCanonical(path);
  const images = image ? [{ url: image }] : undefined;

  return {
    title,
    description,
    alternates: { canonical },
    openGraph: {
      type: openGraphType,
      siteName: SITE_NAME,
      title,
      description,
      url: canonical,
      images,
    },
    twitter: {
      card: image ? "summary_large_image" : "summary",
      title,
      description,
      images: image ? [image] : undefined,
    },
    robots: noIndex ? { index: false, follow: false } : undefined,
  };
}
