"use client";

import { useMemo, useState } from "react";
import { useTranslations } from "next-intl";
import { Link } from "@/i18n/navigation";
import type { PortfolioWork } from "@/lib/getArtistWorksPortfolio";
import { normalizeArtistWorkCreditRole } from "@/lib/artistWorkCreditRoles";

const ROLE_TABS = [
  { key: "composer", roles: ["composer", "songwriter"] },
  { key: "lyricist", roles: ["lyricist", "writer"] },
  { key: "arranger", roles: ["arranger"] },
] as const;

type RoleTab = (typeof ROLE_TABS)[number]["key"];

function belongsToTab(work: PortfolioWork, roles: readonly string[]) {
  return work.roles.some((role) => roles.includes(normalizeArtistWorkCreditRole(role)));
}

function workHref(work: PortfolioWork) {
  const recording = work.recordings.find((item) => item.songHref || item.recordingSlug);
  return recording?.songHref ?? (recording?.recordingSlug ? `/songs/${recording.recordingSlug}` : null);
}

function performerNames(work: PortfolioWork) {
  return [...new Set(work.recordings.flatMap((recording) => recording.performers)
    .map((performer) => performer.creditedAs?.trim() || performer.artistName?.trim())
    .filter((name): name is string => Boolean(name)))];
}

export default function ArtistWorksTabs({ works }: { works: PortfolioWork[] }) {
  const t = useTranslations("artist");
  const groups = useMemo(() => ROLE_TABS.map((tab) => ({
    ...tab,
    works: works.filter((work) => belongsToTab(work, tab.roles)),
  })).filter((group) => group.works.length > 0), [works]);
  const [activeTab, setActiveTab] = useState<RoleTab>(groups[0]?.key ?? "composer");

  if (!groups.length) return null;

  return <div className="min-w-0">
    <div className="mb-2 flex min-w-0 gap-1 overflow-x-auto border-b border-gray-200 pb-px shadow-[0_1px_0_rgba(0,45,98,0.06)]"
      role="tablist" aria-label={t("worksRoleTabs.label")}>
      {groups.map(({ key, works: tabWorks }) => {
        const active = key === activeTab;
        return <button key={key} id={`works-tab-${key}`} type="button" role="tab"
          aria-selected={active} aria-controls={`works-panel-${key}`} onClick={() => setActiveTab(key)}
          className={`min-w-fit flex-1 cursor-pointer whitespace-nowrap border-b-2 px-3 py-1.5 text-center text-sm font-normal transition-colors ${active ? "border-(--color-wikicrimson) text-(--color-wikicrimson)" : "border-transparent text-gray-500 hover:text-(--color-flagblue)"}`}>
          {t(`workRoles.${key}`)} <span className="text-gray-400">({tabWorks.length})</span>
        </button>;
      })}
    </div>

    {groups.map(({ key, works: tabWorks }) => <div key={key} id={`works-panel-${key}`}
      role="tabpanel" aria-labelledby={`works-tab-${key}`} hidden={key !== activeTab}
      className="divide-y divide-gray-100">
      {tabWorks.map((work) => {
        const href = workHref(work);
        const artists = performerNames(work);
        const content = <><span className="block text-[15px] font-normal leading-tight text-(--color-flagblue)">{work.title}</span>
          <span className="mt-0.5 block text-xs font-normal leading-tight text-gray-500">{artists.length ? t("byArtist", { artist: artists.join(", ") }) : t("artistUnknown")}</span></>;
        return <article key={work.id} className="py-2.5 first:pt-1.5 last:pb-0.5">
          {href ? <Link href={href} prefetch={false} className="group block rounded-sm font-normal underline-offset-4 hover:[&>span:first-child]:text-(--color-wikicrimson) hover:[&>span:first-child]:underline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-(--color-flagblue)">{content}</Link> : content}
        </article>;
      })}
    </div>)}
  </div>;
}
