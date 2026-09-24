"use client";

import { useMemo, useState } from "react";
import { useTranslations } from "next-intl";
import Image from "next/image";
import { Link } from "@/i18n/navigation";
import type { PortfolioWork } from "@/lib/getArtistWorksPortfolio";
import { normalizeArtistWorkCreditRole } from "@/lib/artistWorkCreditRoles";
import { getPublicReleaseCoverUrl } from "@/lib/releaseCover";
import { getArtistImageUrl } from "@/utils/getArtistImageUrl";

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

function isInternationalWork(work: PortfolioWork) {
  return !workHref(work) && work.recordings.every((recording) =>
    recording.source === "editorial" && recording.performers.every((performer) => !performer.artistId),
  );
}

function displayRecording(work: PortfolioWork) {
  return work.recordings.find((recording) =>
    (recording.songHref || recording.recordingSlug) && recording.hasCoverImage && recording.coverReleaseId,
  ) ?? work.recordings.find((recording) => recording.songHref || recording.recordingSlug) ?? work.recordings[0];
}

function renderPerformers(work: PortfolioWork, t: (key: string) => string) {
  const recording = displayRecording(work);
  const performers = recording?.performers ?? [];
  if (!performers.length) {
    const fallback = performerNames(work);
    return fallback.length ? fallback.join(", ") : t("artistUnknown");
  }
  return performers.map((p, idx) => {
    const name = p.artistName?.trim() || p.creditedAs?.trim() || "";
    if (!name) return null;
    return (
      <span key={p.artistId ?? idx}>
        {idx > 0 && ", "}
        {p.artistSlug ? (
          <Link
            href={`/artists/${p.artistSlug}`}
            prefetch={false}
            className="hover:text-(--color-wikicrimson) hover:underline"
          >
            {name}
          </Link>
        ) : (
          name
        )}
      </span>
    );
  });
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

    {groups.map(({ key, works: tabWorks }) => {
      const catalogWorks = tabWorks.filter((work) => !isInternationalWork(work));
      const internationalWorks = tabWorks.filter(isInternationalWork);
      return <div key={key} id={`works-panel-${key}`}
      role="tabpanel" aria-labelledby={`works-tab-${key}`} hidden={key !== activeTab}
      className="min-w-0">
      <div className="space-y-1.5">
      {catalogWorks.map((work) => {
        const href = workHref(work);
        const recording = displayRecording(work);
        const year = recording?.releaseYear ?? recording?.recordingYear;
        const coverUrl = recording?.hasCoverImage && recording.coverReleaseId
          ? getPublicReleaseCoverUrl(recording.coverReleaseId, 150)
          : recording?.performers.find((performer) => performer.artistId && performer.hasImage)
            ? getArtistImageUrl(recording.performers.find((performer) => performer.artistId && performer.hasImage)!.artistId!,
              recording.performers.find((performer) => performer.artistId && performer.hasImage)!.imageUpdatedAt)
            : null;
        return <article key={work.id} className="flex min-w-0 items-center gap-3 rounded-lg border border-gray-100 bg-gray-50 px-3 py-1.5 font-normal transition-colors hover:border-gray-200 hover:bg-white">
          <div className="relative h-11 w-11 shrink-0 overflow-hidden rounded-md bg-gray-100 shadow-sm">
            {coverUrl ? (
              href ? (
                <Link href={href} prefetch={false} className="block h-full w-full">
                  <Image src={coverUrl} alt="" fill sizes="44px" className="object-cover" />
                </Link>
              ) : (
                <Image src={coverUrl} alt="" fill sizes="44px" className="object-cover" />
              )
            ) : null}
          </div>
          <div className="min-w-0 flex-1">
            {href ? (
              <Link href={href} prefetch={false} className="block truncate text-[15px] font-normal leading-tight text-(--color-flagblue) transition-colors hover:text-(--color-wikicrimson)">
                {work.title}
              </Link>
            ) : (
              <span className="block truncate text-[15px] font-normal leading-tight text-(--color-flagblue)">
                {work.title}
              </span>
            )}
            <span className="mt-0.5 block truncate text-xs font-normal leading-tight text-gray-500">
              {year ? `${year} · ` : ""}
              {renderPerformers(work, t)}
            </span>
          </div>
        </article>;
      })}
      </div>
      {internationalWorks.length > 0 ? <section className={`${catalogWorks.length ? "mt-5 border-t border-gray-200 pt-4" : "mt-2"}`}>
        <h3 className="mb-1.5 text-xs font-normal uppercase tracking-wide text-(--color-wikicrimson)">{t("internationalWorks")}</h3>
        <div className="divide-y divide-gray-100">{internationalWorks.map((work) => {
          const recording = displayRecording(work);
          const year = recording?.releaseYear ?? recording?.recordingYear;
          return <article key={work.id} className="py-2 first:pt-1">
            <span className="block text-[15px] font-normal leading-tight text-(--color-flagblue)">{work.title}</span>
            <span className="mt-0.5 block text-xs font-normal leading-tight text-gray-500">
              {year ? `${year} · ` : ""}
              {t("performedByArtist", { artist: "" })} {renderPerformers(work, t)}
            </span>
          </article>;
        })}</div>
      </section> : null}
    </div>;
    })}
  </div>;
}
