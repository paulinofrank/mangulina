"use client";
// Groups credits by role for a liner-notes style display.
import { Link } from "@/i18n/navigation";
import { useLocale, useTranslations } from "next-intl";
import { useEffect, useState } from "react";

export type CreditItem = {
  role: string;
  name: string;
  slug?: string | null;
  externalContributorId?: string | null;
  country?: string | null;
  roleFamily?: string | null;
  creditDetail?: string | null;
  instruments?: { code: string; name_en: string; name_es: string }[];
};

type SongCreditsSectionProps = {
  credits: CreditItem[];
  labelName?: string;
  releaseInfo?: string;
  title?: string;
  embedded?: boolean;
};

const ROLE_LABELS_KEYS: Record<string, string> = {
  performer: "performedBy",
  lead_performer: "leadPerformer",
  featured_performer: "featuredPerformer",
  featured_artist: "featuredPerformer",
  guest_performer: "guestPerformer",
  recording_engineer: "recordingEngineer",
  mixing_engineer: "mixEngineer",
  mastering_engineer: "masteringEngineer",
  vocalist: "vocals",
  vocal: "vocals",
  vocals: "vocals",
  singer: "vocals",
  composer: "composedBy",
  songwriter: "writtenBy",
  writer: "writtenBy",
  lyricist: "lyricsBy",
  lyrics: "lyricsBy",
  arranger: "arrangedBy",
  producer: "producedBy",
  "co-producer": "coProducedBy",
  "executive producer": "executiveProducer",
  conductor: "conductedBy",
  "musical director": "musicalDirector",
  "recording engineer": "recordingEngineer",
  engineer: "engineer",
  "mix engineer": "mixEngineer",
  "mastering engineer": "masteringEngineer",
  guitar: "guitar",
  piano: "piano",
  bass: "bass",
  "bass guitar": "bassGuitar",
  drums: "drums",
  percussion: "percussion",
  trumpet: "trumpet",
  saxophone: "saxophone",
  violin: "violin",
  chorus: "chorus",
  "backing vocals": "backingVocals",
  backing_vocalist: "backingVocals",
  "background vocals": "backgroundVocals",
};

const ROLE_ORDER = [
  "lead_performer",
  "performer",
  "lyricist",
  "lyrics",
  "composer",
  "songwriter",
  "writer",
  "arranger",
  "vocalist",
  "vocal",
  "vocals",
  "singer",
  "backing_vocalist",
  "backing vocals",
  "background vocals",
  "producer",
  "co-producer",
  "executive producer",
  "musical director",
  "conductor",
  "recording_engineer",
  "recording engineer",
  "engineer",
  "mixing_engineer",
  "mix engineer",
  "mastering_engineer",
  "mastering engineer",
];

function roleOrder(role: string) {
  const normalized = role.trim().toLowerCase();
  const index = ROLE_ORDER.indexOf(normalized);
  return index === -1 ? Number.MAX_SAFE_INTEGER : index;
}

function sortRoles(roles: string[], priorities: Map<string, number>): string[] {
  return roles.sort((a, b) => {
    const ia = priorities.get(a) ?? Number.MAX_SAFE_INTEGER;
    const ib = priorities.get(b) ?? Number.MAX_SAFE_INTEGER;
    if (ia !== ib) return ia - ib;
    return a.localeCompare(b);
  });
}

function titleCase(value: string) {
  return value
    .replace(/[_-]+/g, " ")
    .trim()
    .replace(/\s+/g, " ")
    .replace(/\b\w/g, (letter) => letter.toUpperCase());
}

function normalizeRole(role: string, t: (key: string) => string) {
  const normalized = role.trim().toLowerCase();
  const key = ROLE_LABELS_KEYS[normalized];
  return key ? t(key) : titleCase(role);
}

export default function SongCreditsSection({
  credits,
  labelName,
  releaseInfo,
  title,
  embedded = false,
}: SongCreditsSectionProps) {
  const t = useTranslations("creditRoles");
  const tSong = useTranslations("song");
  const locale = useLocale();
  const [openExternal, setOpenExternal] = useState<CreditItem | null>(null);
  useEffect(() => {
    if (!openExternal) return;
    const closeOnEscape = (event: KeyboardEvent) => {
      if (event.key === "Escape") setOpenExternal(null);
    };
    document.addEventListener("keydown", closeOnEscape);
    return () => document.removeEventListener("keydown", closeOnEscape);
  }, [openExternal]);
  const hasCredits = credits.length > 0;
  const hasExtra = Boolean(labelName || releaseInfo);
  if (!hasCredits && !hasExtra) return null;

  const grouped = new Map<string, CreditItem[]>();
  const rolePriorities = new Map<string, number>();
  for (const c of credits) {
    const role = normalizeRole(c.role || "Credit", t);
    rolePriorities.set(role, Math.min(rolePriorities.get(role) ?? Number.MAX_SAFE_INTEGER, roleOrder(c.role)));
    if (!grouped.has(role)) grouped.set(role, []);
    const names = grouped.get(role)!;
    if (!names.some((item) => item.name === c.name && item.slug === c.slug && item.externalContributorId === c.externalContributorId)) {
      names.push(c);
    }
  }
  const sortedRoles = sortRoles([...grouped.keys()], rolePriorities);

  return (
    <section className={embedded ? "" : "h-fit rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6"}>
      {!embedded && <h2 className="mb-5 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
        {title ?? tSong("credits")}
      </h2>}

      {/* Credit rows */}
      {sortedRoles.length > 0 && (
        <dl className="grid gap-y-3 sm:grid-cols-[140px_1fr]">
          {sortedRoles.map((role) => {
            const names = grouped.get(role) ?? [];
            return (
              <div key={role} className="contents">
                <dt
                  className="text-[10px] font-semibold uppercase tracking-[0.14em] text-gray-500 sm:py-0.5"
                >
                  {role}
                </dt>
                <dd className="text-sm text-gray-700 sm:py-0.5">
                  <span className="flex flex-wrap gap-x-1.5 gap-y-1">
                    {names.map((credit, index) => (
                      <span key={`${role}-${credit.name}-${credit.slug ?? index}`} className="inline-flex flex-wrap items-baseline gap-x-1">
                        {credit.slug ? (
                          <Link
                            href={`/artists/${credit.slug}`}
                            className="font-medium text-[#002D62] transition hover:text-[#CE1126]"
                          >
                            {credit.name}
                          </Link>
                        ) : credit.externalContributorId ? (
                          <button type="button" onClick={() => setOpenExternal(credit)} className="font-medium text-[#002D62] underline decoration-dotted underline-offset-2 hover:text-[#CE1126]">{credit.name}</button>
                        ) : (
                          <span>{credit.name}</span>
                        )}
                        {(credit.instruments?.length || credit.creditDetail) && <span className="text-xs text-slate-500">
                          — {[credit.instruments?.map((instrument) => locale === "es" ? instrument.name_es : instrument.name_en).join(", "), credit.creditDetail].filter(Boolean).join(" · ")}
                        </span>}
                        {index < names.length - 1 && <span>,</span>}
                      </span>
                    ))}
                  </span>
                </dd>
              </div>
            );
          })}
        </dl>
      )}
      {hasExtra && (
        <div className={`${sortedRoles.length ? "mt-5 border-t border-gray-100 pt-4" : ""} flex flex-wrap gap-x-6 gap-y-2 text-sm`}>
          {labelName && (
            <div>
              <span className="mr-1.5 text-[10px] font-semibold uppercase tracking-[0.14em] text-gray-500">{tSong("label")}</span>
              <span className="text-gray-700">{labelName}</span>
            </div>
          )}
          {releaseInfo && (
            <div>
              <span className="mr-1.5 text-[10px] font-semibold uppercase tracking-[0.14em] text-gray-500">{tSong("release")}</span>
              <span className="text-gray-700">{releaseInfo}</span>
            </div>
          )}
        </div>
      )}
      {openExternal && <div role="dialog" aria-modal="true" aria-labelledby="external-contributor-name" className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-4" onClick={() => setOpenExternal(null)}><div className="w-full max-w-sm rounded-xl bg-white p-5 shadow-xl" onClick={(event) => event.stopPropagation()}><h3 id="external-contributor-name" className="text-lg font-bold text-[#002D62]">{openExternal.name}</h3><p className="mt-2 text-sm text-gray-600">{openExternal.country ?? tSong("countryNotDocumented")}</p><button type="button" autoFocus onClick={() => setOpenExternal(null)} className="mt-5 rounded-lg border px-4 py-2 text-sm">{tSong("close")}</button></div></div>}
    </section>
  );
}
