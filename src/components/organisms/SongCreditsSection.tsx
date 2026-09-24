"use client";
// Groups credits by role for a liner-notes style display.
import { Link } from "@/i18n/navigation";
import { useLocale, useTranslations } from "next-intl";
import { Fragment, useEffect, useState } from "react";

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
  songwriter: "lyricsBy",
  writer: "lyricsBy",
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
  instrumentalist: "instrumentalist",
  pianist: "pianist",
  co_producer: "coProducedBy",
  beat_programmer: "beatProgrammer",
  musical_director: "musicalDirector",
  "background vocals": "backgroundVocals",
};

const ROLE_ORDER = [
  "lead_performer",
  "performer",
  "featured_performer",
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
  "instrumentalist",
  "pianist",
  "guitar",
  "piano",
  "bass",
  "bass guitar",
  "drums",
  "percussion",
  "trumpet",
  "saxophone",
  "violin",
  "producer",
  "co-producer",
  "co_producer",
  "beat_programmer",
  "executive producer",
  "musical director",
  "musical_director",
  "conductor",
  "recording_engineer",
  "recording engineer",
  "engineer",
  "mixing_engineer",
  "mix engineer",
  "mastering_engineer",
  "mastering engineer",
];

const INSTRUMENT_ROLES = new Set([
  "instrumentalist", "pianist", "guitar", "piano", "bass", "bass guitar",
  "drums", "percussion", "trumpet", "saxophone", "violin",
]);

const EXTERNAL_ROLE_KEYS: Record<string, string> = {
  composer: "composer",
  songwriter: "author",
  writer: "author",
  lyricist: "lyricist",
  lyrics: "lyricist",
  performer: "singer",
  lead_performer: "singer",
  vocalist: "singer",
  vocal: "singer",
  vocals: "singer",
  singer: "singer",
  arranger: "arranger",
  producer: "producer",
};

function externalRoleKeys(credits: CreditItem[], contributorId: string) {
  const order = ["composer", "lyricist", "author", "singer", "arranger", "producer"];
  return [...new Set(credits
    .filter((credit) => credit.externalContributorId === contributorId)
    .map((credit) => EXTERNAL_ROLE_KEYS[credit.role.trim().toLowerCase()])
    .filter((role): role is string => Boolean(role)))]
    .sort((left, right) => order.indexOf(left) - order.indexOf(right));
}

function countryName(country: string, locale: string) {
  if (!/^[A-Z]{2}$/i.test(country)) return country;
  try {
    return new Intl.DisplayNames([locale], { type: "region" }).of(country.toUpperCase()) ?? country;
  } catch {
    return country;
  }
}

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
  const instrumentRoleLabels = new Set<string>();
  for (const c of credits) {
    const role = normalizeRole(c.role || "Credit", t);
    if (INSTRUMENT_ROLES.has(c.role.trim().toLowerCase()) || c.instruments?.length) instrumentRoleLabels.add(role);
    rolePriorities.set(role, Math.min(rolePriorities.get(role) ?? Number.MAX_SAFE_INTEGER, roleOrder(c.role)));
    if (!grouped.has(role)) grouped.set(role, []);
    const names = grouped.get(role)!;
    if (!names.some((item) => item.name === c.name && item.slug === c.slug && item.externalContributorId === c.externalContributorId)) {
      names.push(c);
    }
  }
  const sortedRoles = sortRoles([...grouped.keys()], rolePriorities);
  const firstInstrumentIndex = sortedRoles.findIndex((role) => instrumentRoleLabels.has(role));
  const lastInstrumentIndex = sortedRoles.findLastIndex((role) => instrumentRoleLabels.has(role));
  const openExternalRoleKeys = openExternal?.externalContributorId
    ? externalRoleKeys(credits, openExternal.externalContributorId)
    : [];
  const openExternalCountry = openExternal?.country?.trim() || null;
  const nationalityKey = openExternalCountry?.toUpperCase() === "VE" || openExternalCountry?.toLowerCase() === "venezuela"
    ? "VE"
    : null;
  const externalDescriptions = openExternalRoleKeys.map((role) => nationalityKey
    ? tSong("externalContributorDescription", {
        role: tSong(`externalContributorRoles.${role}`),
        nationality: tSong(`nationalities.${nationalityKey}`),
      })
    : openExternalCountry
      ? tSong("externalContributorFromCountry", {
          role: tSong(`externalContributorRoles.${role}`),
          country: countryName(openExternalCountry, locale),
        })
      : tSong(`externalContributorRoles.${role}`));

  return (
    <section className={embedded ? "" : "h-fit rounded-xl border border-black/5 bg-white p-5 shadow-sm sm:p-6"}>
      {!embedded && <h2 className="mb-5 text-xs font-semibold uppercase tracking-[0.2em] text-[#CE1126]">
        {title ?? tSong("credits")}
      </h2>}

      {/* Credit rows */}
      {(sortedRoles.length > 0 || hasExtra) && (
        <dl className="grid gap-y-3 sm:grid-cols-[240px_minmax(0,1fr)]">
          {sortedRoles.map((role, roleIndex) => {
            const names = grouped.get(role) ?? [];
            return (
              <Fragment key={role}>
                {roleIndex === firstInstrumentIndex && <div aria-hidden="true" className="col-span-full my-1 border-t border-gray-100" />}
                <div className="contents">
                <dt
                  className="text-xs font-semibold uppercase tracking-[0.14em] text-gray-500 sm:whitespace-nowrap sm:py-0.5"
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
                {roleIndex === lastInstrumentIndex && <div aria-hidden="true" className="col-span-full my-1 border-t border-gray-100" />}
              </Fragment>
            );
          })}
          {sortedRoles.length > 0 && hasExtra && <div aria-hidden="true" className="col-span-full my-1 border-t border-gray-100" />}
          {labelName && <div className="contents">
            <dt className="text-xs font-semibold uppercase tracking-[0.14em] text-gray-500 sm:whitespace-nowrap sm:py-0.5">{tSong("label")}</dt>
            <dd className="text-sm text-gray-700 sm:py-0.5">{labelName}</dd>
          </div>}
          {releaseInfo && <div className="contents">
            <dt className="text-xs font-semibold uppercase tracking-[0.14em] text-gray-500 sm:whitespace-nowrap sm:py-0.5">{tSong("release")}</dt>
            <dd className="text-sm text-gray-700 sm:py-0.5">{releaseInfo}</dd>
          </div>}
        </dl>
      )}
      {openExternal && <div role="dialog" aria-modal="true" aria-labelledby="external-contributor-name" className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-4" onClick={() => setOpenExternal(null)}><div className="w-full max-w-sm rounded-xl bg-white p-5 shadow-xl" onClick={(event) => event.stopPropagation()}><h3 id="external-contributor-name" className="text-lg font-bold text-[#002D62]">{openExternal.name}</h3><p className="mt-2 text-sm text-gray-600">{externalDescriptions.length ? externalDescriptions.join(" / ") : openExternalCountry ? countryName(openExternalCountry, locale) : tSong("countryNotDocumented")}</p><button type="button" autoFocus onClick={() => setOpenExternal(null)} className="mt-5 rounded-lg border px-4 py-2 text-sm">{tSong("close")}</button></div></div>}
    </section>
  );
}
