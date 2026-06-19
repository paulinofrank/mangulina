export type SongPlatformLink = {
  platform: string;
  url: string | null | undefined;
  label?: string | null;
};

export type PlatformConfig = {
  display: string;
  icon: string;
  color: string;
  bg: string;
  verb: "Listen on" | "Watch on";
  order: number;
};

export const PLATFORM_CONFIG: Record<string, PlatformConfig> = {
  youtube:       { display: "YouTube",       icon: "mdi:youtube",              color: "#FF0000", bg: "bg-red-50     border-red-200     text-red-700",     verb: "Watch on",  order: 1 },
  spotify:       { display: "Spotify",       icon: "mdi:spotify",              color: "#1DB954", bg: "bg-green-50   border-green-200   text-green-700",   verb: "Listen on", order: 2 },
  apple_music:   { display: "Apple Music",   icon: "simple-icons:applemusic",  color: "#fc3c44", bg: "bg-red-50     border-red-200     text-red-700",     verb: "Listen on", order: 3 },
  deezer:        { display: "Deezer",        icon: "simple-icons:deezer",      color: "#A238FF", bg: "bg-purple-50  border-purple-200  text-purple-700",  verb: "Listen on", order: 4 },
  amazon_music:  { display: "Amazon Music",  icon: "simple-icons:amazonmusic", color: "#00A8E0", bg: "bg-sky-50     border-sky-200     text-sky-700",     verb: "Listen on", order: 5 },
  tidal:         { display: "TIDAL",         icon: "simple-icons:tidal",       color: "#000000", bg: "bg-gray-50    border-gray-300    text-gray-800",    verb: "Listen on", order: 6 },
  pandora:       { display: "Pandora",       icon: "simple-icons:pandora",     color: "#3668FF", bg: "bg-blue-50    border-blue-200    text-blue-700",    verb: "Listen on", order: 7 },
  audiomack:     { display: "Audiomack",     icon: "simple-icons:audiomack",   color: "#FFA500", bg: "bg-orange-50  border-orange-200  text-orange-700",  verb: "Listen on", order: 8 },
  boomplay:      { display: "Boomplay",      icon: "simple-icons:boomplay",    color: "#00C853", bg: "bg-green-50   border-green-200   text-green-700",   verb: "Listen on", order: 8 },
};

export function normalizePlatformKey(platform: string): string {
  return platform.trim().toLowerCase().replace(/[\s-]+/g, "_");
}

export function isValidPlatformUrl(url: string | null | undefined): url is string {
  if (!url) return false;
  try {
    const parsed = new URL(url);
    return parsed.protocol === "https:" || parsed.protocol === "http:";
  } catch {
    return false;
  }
}

export function getPlatformConfig(platform: string): PlatformConfig {
  const key = normalizePlatformKey(platform);
  return (
    PLATFORM_CONFIG[key] ?? {
      display: platform,
      icon:    "mdi:music",
      color:   "#002D62",
      bg:      "bg-blue-50 border-blue-200 text-blue-700",
      verb:    "Listen on",
      order:   99,
    }
  );
}

export function getVisiblePlatformLinks(links: SongPlatformLink[]): SongPlatformLink[] {
  const byPlatform = new Map<string, SongPlatformLink>();

  for (const link of links) {
    if (!isValidPlatformUrl(link.url)) continue;

    const platformKey = normalizePlatformKey(link.platform);
    if (!byPlatform.has(platformKey)) {
      byPlatform.set(platformKey, link);
    }
  }

  if (byPlatform.has("audiomack")) {
    byPlatform.delete("boomplay");
  }

  return [...byPlatform.values()].sort(
    (a, b) => getPlatformConfig(a.platform).order - getPlatformConfig(b.platform).order,
  );
}
