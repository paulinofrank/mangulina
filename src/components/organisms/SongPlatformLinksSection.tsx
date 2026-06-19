"use client";

import { Icon } from "@iconify/react";
import { trackPlatformClick } from "@/lib/analytics";
import {
  getPlatformConfig,
  getVisiblePlatformLinks,
  type SongPlatformLink,
} from "@/lib/platformLinks";

export type { SongPlatformLink };

type Props = {
  recordingId: string;
  links: SongPlatformLink[];
};

export default function SongPlatformLinksSection({ recordingId, links }: Props) {
  const visible = getVisiblePlatformLinks(links);

  if (visible.length === 0) return null;

  return (
    <section className="h-fit rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6">
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
              onClick={() =>
                trackPlatformClick(recordingId, link.platform, link.url ?? undefined)
              }
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
