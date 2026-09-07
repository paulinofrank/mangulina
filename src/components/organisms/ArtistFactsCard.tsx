//artist facts card component
"use client";

import { Link } from "@/i18n/navigation";
import { useTranslations, useLocale } from "next-intl";
import { Globe } from "lucide-react";
import { SiFacebook, SiInstagram, SiYoutube } from "react-icons/si";
import type { IconType } from "react-icons";

import type { ArtistProfileData } from "@/lib/artistApi";
import type { ArtistRelationshipItem } from "@/lib/artistRelationships";
import type { FamilyRelationshipItem } from "@/lib/artistFamilyRelationships";
import { formatOrigin } from "@/lib/artistDirectoryShared";
import ShareButton from "@/components/atoms/ShareButton";
import {
  getFacebookDisplay,
  getFacebookUrl,
  getInstagramUrl,
  getWebsiteDisplay,
  getWebsiteUrl,
  getYoutubeUrl,
  normalizeSocialUsername,
  normalizeYoutubeDisplay,
} from "@/lib/artistSocialLinks";


type Props = {
  artist: ArtistProfileData;
  shareUrl: string;
  memberships?: ArtistRelationshipItem[];
  foundedProjects?: ArtistRelationshipItem[];
  ledProjects?: ArtistRelationshipItem[];
  members?: ArtistRelationshipItem[];
  founders?: ArtistRelationshipItem[];
  leaders?: ArtistRelationshipItem[];
  familyRelationships?: FamilyRelationshipItem[];
};

function formatDate(date: string | null, locale: string) {
  if (!date) return null;

  const parsed = new Date(`${date}T00:00:00`);
  if (Number.isNaN(parsed.getTime())) return null;

  return parsed
    .toLocaleDateString(locale === "es" ? "es-ES" : "en-GB", {
      day: "2-digit",
      month: "short",
      year: "numeric",
    })
    .replace(/ /g, "-")
    .toUpperCase();
}

function formatLabel(value: string | null | undefined) {
  if (!value) return null;

  return value
    .replace(/[-_]/g, " ")
    .replace(/\b\w/g, (char) => char.toUpperCase());
}

function formatDisplayValue(value: string | null | undefined, locale: string) {
  if (!value) return null;

  const normalized = value.trim().replace(/[-_]/g, " ");
  if (!normalized) return null;

  return normalized
    .split(/\s+/)
    .map((word) => {
      const [firstChar, ...rest] = Array.from(word);
      return firstChar ? `${firstChar.toLocaleUpperCase(locale)}${rest.join("")}` : word;
    })
    .join(" ");
}

// Editorial values are stored as free text; message keys are the same value
// lowercased, unaccented, with separators collapsed to underscores.
function normalizeMessageKey(value: string) {
  return value
    .trim()
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/[\s-]+/g, "_");
}

function normalizeGenreKey(value: string) {
  const normalized = normalizeMessageKey(value);

  if (normalized === "romantica") return "romantic";
  if (normalized === "balada" || normalized === "baladas") return "ballads";

  return normalized;
}

function translateGenreValue(
  value: string | null | undefined,
  t: ReturnType<typeof useTranslations>,
  locale: string,
) {
  if (!value) return null;

  const key = `genres.${normalizeGenreKey(value)}`;
  return t.has(key) ? t(key) : formatDisplayValue(value, locale);
}

// Instruments are stored as free-text English values. Unknown ones fall back to
// the raw label so editorial data stays visible rather than disappearing.
function translateInstrumentValue(
  value: string,
  t: ReturnType<typeof useTranslations>,
) {
  const key = `instruments.${normalizeMessageKey(value)}`;
  return t.has(key) ? t(key) : formatLabel(value);
}

function translateArtistType(
  value: string | null | undefined,
  t: ReturnType<typeof useTranslations>,
) {
  if (!value) return null;

  const trimmed = value.trim();
  if (!trimmed) return null;

  const key = `artistFields.types.${trimmed.toLowerCase()}`;
  return t.has(key) ? t(key) : trimmed;
}

// Translates role-like artist values via next-intl without mutating DB values.
// Unknown values are returned unchanged so editorial data remains visible.
function translateRoleLikeValue(
  value: string | null | undefined,
  t: ReturnType<typeof useTranslations>,
) {
  if (!value) return null;

  const trimmed = value.trim();
  if (!trimmed) return null;

  const key = `artistFields.roles.${trimmed.toLowerCase().replace(/[\s-]+/g, "_")}`;
  return t.has(key) ? t(key) : trimmed;
}

function getRealName(artist: ArtistProfileData) {
  const realName = [
    artist.first_name,
    artist.middle_name,
    artist.last_name,
    artist.second_last_name,
  ]
    .filter(Boolean)
    .join(" ");

  return realName || null;
}

function getBirthPlace(artist: ArtistProfileData) {
  return formatOrigin(artist.birth_place, artist.province);
}

function getOccupationList(occupations: ArtistProfileData["occupations"]) {
  if (!occupations) return [];

  if (Array.isArray(occupations)) {
    return occupations.map(String);
  }

  return Object.keys(occupations);
}

function getInstrumentList(instruments: ArtistProfileData["instruments"]) {
  if (!instruments) return [];

  if (Array.isArray(instruments)) {
    return instruments.map(String);
  }

  return Object.keys(instruments);
}

function getArtistStatus(
  artist: ArtistProfileData,
  t: ReturnType<typeof useTranslations>
) {
  if (artist.type === "solo_artist" || artist.type === "person") {
    return artist.date_of_death || artist.death_year ? t("status.deceased", { year: artist.death_year || "" }) : null;
  }

  if (
    artist.type === "duo" ||
    artist.type === "group" ||
    artist.type === "orchestra" ||
    artist.type === "choir" ||
    artist.type === "collective" ||
    artist.type === "other"
  ) {
    return artist.ended ? t("artist.noLongerActive") : t("artist.active");
  }

  return null;
}

function InlineList({ values }: { values: Array<string | null> }) {
  const visibleValues = values.filter(Boolean);

  if (visibleValues.length === 0) return null;

  return <>{visibleValues.join(", ")}</>;
}

function SectionDivider() {
  return (
    <div className="h-px bg-linear-to-r from-transparent via-gray-200 to-transparent" />
  );
}

function Field({
  label,
  children,
}: {
  label: string;
  children: React.ReactNode;
}) {
  if (!children) return null;

  return (
    <div>
      <span className="block text-[12px] uppercase tracking-[0.18em] text-(--color-flagblue)">
        {label}
      </span>
      <div className="mt-1 text-sm font-normal leading-snug text-(--color-ink)">
        {children}
      </div>
    </div>
  );
}

function ExternalLink({
  href,
  children,
  className = "",
}: {
  href: string | null;
  children: React.ReactNode;
  className?: string;
}) {
  if (!href || !children) return null;

  return (
    <a
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      className={`text-(--color-ink) underline-offset-4 hover:text-(--color-wikicrimson) hover:underline ${className}`}
    >
      {children}
    </a>
  );
}

function SocialLink({
  href,
  label,
  Icon,
  children,
}: {
  href: string | null;
  label: string;
  Icon: IconType | React.ComponentType<{ className?: string; "aria-hidden"?: boolean }>;
  children: React.ReactNode;
}) {
  if (!href || !children) return null;

  return (
    <a
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      aria-label={label}
      title={label}
      className="flex w-fit items-center gap-2 text-sm font-normal leading-snug text-(--color-ink) underline-offset-4 hover:text-(--color-wikicrimson) hover:underline"
    >
      <Icon className="h-4 w-4 shrink-0" aria-hidden={true} />
      <span>{children}</span>
    </a>
  );
}

function LinkGroup({ children }: { children: React.ReactNode }) {
  if (!children) return null;

  return <div className="space-y-2">{children}</div>;
}

function formatMembershipYears(
  startYear: number | null,
  endYear: number | null,
  t: ReturnType<typeof useTranslations>,
) {
  if (startYear && endYear) return `${startYear}–${endYear}`;
  if (startYear) return `${startYear}–${t("artist.present")}`;
  if (endYear) return `${t("artist.untilYear", { year: endYear })}`;
  return null;
}

function MembershipList({
  label,
  relationships,
  t,
}: {
  label: string;
  relationships: ArtistRelationshipItem[];
  t: ReturnType<typeof useTranslations>;
}) {
  if (!relationships.length) return null;

  return (
    <Field label={label}>
      <div className="space-y-2">
        {relationships.map((relationship) => {
          const years = formatMembershipYears(
            relationship.startYear,
            relationship.endYear,
            t
          );
          const name =
            relationship.relatedArtistName || t("fallback.unknownArtist");

          // Only the artist name is the link. The years sit outside it so the
          // hover underline does not run through the date range.
          return (
            <div key={relationship.id} className="text-sm leading-snug">
              {relationship.relatedArtistSlug ? (
                <Link
                  href={`/artists/${relationship.relatedArtistSlug}`}
                  className="font-normal text-(--color-ink) underline-offset-4 hover:text-(--color-wikicrimson) hover:underline"
                >
                  {name}
                </Link>
              ) : (
                <span className="font-normal text-(--color-ink)">{name}</span>
              )}
              {years && (
                <span className="mt-0.5 block text-xs text-gray-500">
                  {years}
                </span>
              )}
            </div>
          );
        })}
      </div>
    </Field>
  );
}

export default function ArtistFactsCard({
  artist,
  shareUrl,
  memberships = [],
  foundedProjects = [],
  ledProjects = [],
  members = [],
  founders = [],
  leaders = [],
  familyRelationships = [],
}: Props) {
  const t = useTranslations();
  const locale = useLocale();
  const realName = getRealName(artist);
  const birthDate = formatDate(artist.date_of_birth, locale);
  const deathDate = formatDate(artist.date_of_death, locale);
  const birthPlace = getBirthPlace(artist);
  const originLabel =
    artist.type === "solo_artist" || artist.type === "person"
      ? t("artist.placeOfBirth")
      : t("artist.origin");
  const occupations = getOccupationList(artist.occupations);
  const instruments = getInstrumentList(artist.instruments);
  const artistStatus = getArtistStatus(artist, t);

  const websiteUrl = getWebsiteUrl(artist.website);
  const websiteDisplay = getWebsiteDisplay(artist.website);
  const hasWebsiteLink = Boolean(websiteUrl && artist.website);

  const youtubeDisplay = normalizeYoutubeDisplay(artist.youtube);
  const youtubeUrl = getYoutubeUrl(artist.youtube);

  const facebookUsername = normalizeSocialUsername(artist.facebook);
  const facebookDisplay = getFacebookDisplay(artist.facebook);
  const facebookUrl = getFacebookUrl(artist.facebook);

  const instagramUsername = normalizeSocialUsername(artist.instagram);
  const instagramUrl = getInstagramUrl(artist.instagram);
  const hasSocialLinks = Boolean(
    hasWebsiteLink ||
    (youtubeUrl && youtubeDisplay) ||
    (facebookUrl && facebookUsername) ||
    (instagramUrl && instagramUsername)
  );
  const currentMemberships = memberships.filter((relationship) => !relationship.isFormer);
  const formerMemberships = memberships.filter((relationship) => relationship.isFormer);
  const currentLedProjects = ledProjects.filter((relationship) => !relationship.isFormer);
  const formerLedProjects = ledProjects.filter((relationship) => relationship.isFormer);
  const currentMembers = members.filter((relationship) => !relationship.isFormer);
  const formerMembers = members.filter((relationship) => relationship.isFormer);
  const currentLeaders = leaders.filter((relationship) => !relationship.isFormer);
  const formerLeaders = leaders.filter((relationship) => relationship.isFormer);
  const hasRelationships = [
    memberships,
    foundedProjects,
    ledProjects,
    members,
    founders,
    leaders,
  ].some((relationships) => relationships.length > 0);

  return (
    <section className="rounded-xl border border-gray-100 bg-white p-6 font-sans shadow-sm">
      <div className="mb-4 flex items-center justify-between gap-3">
        <h3 className="text-xs font-normal uppercase tracking-[0.18em] text-(--color-wikicrimson)">
          {t("artist.technicalSheet")}
        </h3>
        <ShareButton url={shareUrl} title={artist.name} subject={artist.name} placement="facts" />
      </div>

      <div className="space-y-4">
        <Field label={t("artist.stageName")}>{artist.stage_name}</Field>

        <Field label={t("artist.realName")}>{realName}</Field>

        <Field label={t("artist.dateOfBirth")}>{birthDate}</Field>

        <Field label={t("artist.dateOfDeath")}>{deathDate}</Field>

        <Field label={originLabel}>{birthPlace}</Field>

        {!!artist.aliases?.length && (
          <Field label={t("artist.aliases")}>
            <InlineList values={artist.aliases} />
          </Field>
        )}

        {familyRelationships.length > 0 && (
          <Field label={t("family.title")}>
            <div className="space-y-2">
              {familyRelationships.map((relationship) => (
                <div key={relationship.id}>
                  <Link href={`/artists/${relationship.relatedArtist.slug}`} className="w-fit underline-offset-4 hover:text-(--color-wikicrimson) hover:underline">
                    {relationship.relatedArtist.name}
                  </Link>
                  <span className="block text-xs text-gray-500">{t(`family.labels.${relationship.labelKey}`)}</span>
                </div>
              ))}
            </div>
          </Field>
        )}

        {(!!artist.aliases?.length || familyRelationships.length > 0) && <SectionDivider />}

        <Field label={t("artist.artistType")}>
          {translateArtistType(artist.type, t) ?? "—"}
        </Field>

        <Field label={t("artist.statusLabel")}>{artistStatus}</Field>

        <Field label={t("artist.primaryRole")}>{translateRoleLikeValue(artist.primary_role, t)}</Field>

        {occupations.length > 0 && (
          <Field label={t("artist.otherRoles")}>
            <InlineList values={occupations.map((occupation) => translateRoleLikeValue(occupation, t))} />
          </Field>
        )}

        {instruments.length > 0 && (
          <Field label={t("artist.instruments")}>
            <InlineList
              values={instruments.map((instrument) => translateInstrumentValue(instrument, t))}
            />
          </Field>
        )}

        <Field label={t("artist.mainGenre")}>
          {translateGenreValue(artist.primary_genre, t, locale)}
        </Field>

        {!!artist.genres?.length && (
          <Field label={t("artist.musicalGenres")}>
            <InlineList values={artist.genres.map((genre) => translateGenreValue(genre, t, locale))} />
          </Field>
        )}
<SectionDivider />
        {hasSocialLinks && (
          
          <LinkGroup>
            <SocialLink href={websiteUrl} label={t("artist.officialWebsite")} Icon={Globe}>
              {websiteDisplay}
            </SocialLink>

            <SocialLink href={youtubeUrl} label="YouTube" Icon={SiYoutube}>
              {youtubeDisplay}
            </SocialLink>

            <SocialLink href={facebookUrl} label="Facebook" Icon={SiFacebook}>
              {facebookDisplay}
            </SocialLink>

            <SocialLink href={instagramUrl} label="Instagram" Icon={SiInstagram}>
              {instagramUsername ? `@${instagramUsername}` : null}
            </SocialLink>
          </LinkGroup>
        )}

        {hasRelationships && (
          <>
            <SectionDivider />
            <MembershipList
              label={t("artist.memberOf")}
              relationships={currentMemberships}
              t={t}
            />
            <MembershipList
              label={t("artist.formerMemberOf")}
              relationships={formerMemberships}
              t={t}
            />
            <MembershipList
              label={t("artist.founderOf")}
              relationships={foundedProjects}
              t={t}
            />
            <MembershipList
              label={t("artist.leaderOf")}
              relationships={currentLedProjects}
              t={t}
            />
            <MembershipList
              label={t("artist.formerLeaderOf")}
              relationships={formerLedProjects}
              t={t}
            />
            <MembershipList
              label={t("artist.members")}
              relationships={currentMembers}
              t={t}
            />
            <MembershipList
              label={t("artist.formerMembers")}
              relationships={formerMembers}
              t={t}
            />
            <MembershipList
              label={t("artist.founders", { count: founders.length })}
              relationships={founders}
              t={t}
            />
            <MembershipList
              label={t("artist.leaders", { count: currentLeaders.length })}
              relationships={currentLeaders}
              t={t}
            />
            <MembershipList
              label={t("artist.formerLeaders", { count: formerLeaders.length })}
              relationships={formerLeaders}
              t={t}
            />
          </>
        )}
      </div>
    </section>
  );
}
