// components/organisms/SongPlatformLinksSection.tsx
import { Icon } from "@iconify/react";

export type SongPlatformLink = {
  platform: string;
  url: string | null | undefined;
  label?: string | null;
};

type PlatformConfig = {
  display:  string;
  icon:     string;          // Iconify icon id
  color:    string;          // brand color for the icon
  bg:       string;          // Tailwind classes for the pill
  verb:     "Listen on" | "Watch on";
  order:    number;          // sort order (lower = first)
};

const PLATFORM_CONFIG: Record<string, PlatformConfig> = {
  youtube:       { display: "YouTube",       icon: "mdi:youtube",              color: "#FF0000", bg: "bg-red-50     border-red-200     text-red-700",     verb: "Watch on",  order: 1 },
  spotify:       { display: "Spotify",       icon: "mdi:spotify",              color: "#1DB954", bg: "bg-green-50   border-green-200   text-green-700",   verb: "Listen on", order: 2 },
  apple_music:   { display: "Apple Music",   icon: "simple-icons:applemusic",  color: "#fc3c44", bg: "bg-red-50     border-red-200     text-red-700",     verb: "Listen on", order: 3 },
  deezer:        { display: "Deezer",        icon: "simple-icons:deezer",      color: "#A238FF", bg: "bg-purple-50  border-purple-200  text-purple-700",  verb: "Listen on", order: 4 },
  amazon_music:  { display: "Amazon Music",  icon: "simple-icons:amazonmusic", color: "#00A8E0", bg: "bg-sky-50     border-sky-200     text-sky-700",     verb: "Listen on", order: 5 },
  tidal:         { display: "TIDAL",         icon: "simple-icons:tidal",       color: "#000000", bg: "bg-gray-50    border-gray-300    text-gray-800",    verb: "Listen on", order: 6 },
  pandora:       { display: "Pandora",       icon: "simple-icons:pandora",     color: "#3668FF", bg: "bg-blue-50    border-blue-200    text-blue-700",    verb: "Listen on", order: 7 },
  audiomack:     { display: "Audiomack",     icon: "simple-icons:audiomack",   color: "#FFA500", bg: "bg-orange-50  border-orange-200  text-orange-700",  verb: "Listen on", order: 8 },
};

function isValidUrl(url: string | null | undefined): url is string {
  if (!url) return false;
  try {
    const p = new URL(url);
    return p.protocol === "https:" || p.protocol === "http:";
  } catch {
    return false;
  }
}

function getPlatformConfig(platform: string): PlatformConfig {
  const key = platform.toLowerCase().replace(/\s+/g, "_");
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

type Props = { links: SongPlatformLink[] };

export default function SongPlatformLinksSection({ links }: Props) {
  const visible = links
    .filter((l) => isValidUrl(l.url))
    .sort((a, b) => getPlatformConfig(a.platform).order - getPlatformConfig(b.platform).order);

  if (visible.length === 0) return null;

  return (
    <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
      <h2 className="mb-4 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
        Listen on your favorite Platforms
      </h2>

      <div className="grid grid-cols-2 gap-2 sm:grid-cols-3 md:grid-cols-4">
        {visible.map((link) => {
          const cfg   = getPlatformConfig(link.platform);
          const label = link.label ?? `${cfg.verb} ${cfg.display}`;
          return (
            <a
              key={`${link.platform}-${link.url}`}
              href={link.url ?? ""}
              target="_blank"
              rel="noopener noreferrer"
              title={label}
              aria-label={label}
              className={`inline-flex w-full items-center justify-center gap-2 rounded-full border px-3 py-2 text-sm font-medium transition-opacity hover:opacity-80 ${cfg.bg}`}
            >
              <Icon
                icon={cfg.icon}
                style={{ color: cfg.color }}
                className="h-4 w-4 shrink-0"
                aria-hidden="true"
              />
              <span className="truncate">{label}</span>
            </a>
          );
        })}
      </div>
    </section>
  );
}
