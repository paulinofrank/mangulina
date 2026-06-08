//artist facts card component
import Link from "next/link";
import { Globe } from "lucide-react";
import { SiFacebook, SiInstagram, SiYoutube } from "react-icons/si";
import type { IconType } from "react-icons";

import type { ArtistProfileData } from "@/lib/artistApi";
import {
  formatArtistRelationshipDisplay,
  type ArtistRelationship,
} from "@/lib/artistRelationships";

type Props = {
  artist: ArtistProfileData;
  groupsAndProjects?: ArtistRelationship[];
  members?: ArtistRelationship[];
};

function formatDate(date: string | null) {
  if (!date) return null;

  const parsed = new Date(`${date}T00:00:00`);
  if (Number.isNaN(parsed.getTime())) return null;

  return parsed
    .toLocaleDateString("en-GB", {
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
  return [artist.birth_place, artist.province].filter(Boolean).join(", ") || null;
}

function getOccupationList(occupations: ArtistProfileData["occupations"]) {
  if (!occupations) return [];

  if (Array.isArray(occupations)) {
    return occupations.map(String);
  }

  return Object.keys(occupations);
}

function getArtistStatus(artist: ArtistProfileData) {
  if (artist.type === "person") {
    return artist.date_of_death || artist.death_year ? "Deceased" : null;
  }

  if (
    artist.type === "duo" ||
    artist.type === "group" ||
    artist.type === "orchestra" ||
    artist.type === "choir" ||
    artist.type === "collective" ||
    artist.type === "other"
  ) {
    return artist.ended ? "No longer active" : "Active";
  }

  return null;
}

function getOriginLabel(artist: ArtistProfileData) {
  return artist.type === "person" ? "Place of Birth" : "Origin";
}

function normalizeSocialUsername(value: string | null | undefined) {
  if (!value) return null;

  return value
    .replace(/^https?:\/\/(www\.)?/i, "")
    .replace(/^facebook\.com\//i, "")
    .replace(/^instagram\.com\//i, "")
    .replace(/^youtube\.com\//i, "")
    .replace(/^youtu\.be\//i, "")
    .replace(/^@/, "")
    .replace(/\/$/, "");
}

function normalizeYoutubeDisplay(value: string | null | undefined) {
  if (!value) return null;

  const cleanValue = value.trim();

  if (!cleanValue) return null;

  if (cleanValue.startsWith("@")) {
    return cleanValue;
  }

  if (cleanValue.includes("youtube.com/@")) {
    return `@${cleanValue.split("youtube.com/@")[1].replace(/\/$/, "")}`;
  }

  if (cleanValue.includes("youtube.com/channel/")) {
    return cleanValue.split("youtube.com/channel/")[1].replace(/\/$/, "");
  }

  if (cleanValue.includes("youtube.com/c/")) {
    return cleanValue.split("youtube.com/c/")[1].replace(/\/$/, "");
  }

  if (cleanValue.includes("youtube.com/user/")) {
    return cleanValue.split("youtube.com/user/")[1].replace(/\/$/, "");
  }

  return normalizeSocialUsername(cleanValue);
}

function getWebsiteUrl(value: string | null | undefined) {
  if (!value) return null;

  return value.startsWith("http") ? value : `https://${value}`;
}

function getWebsiteDisplay(value: string | null | undefined) {
  if (!value) return null;

  return value.replace(/^https?:\/\//i, "").replace(/\/$/, "");
}

function getYoutubeUrl(value: string | null | undefined) {
  if (!value) return null;

  const cleanValue = value.trim();

  if (!cleanValue) return null;

  if (cleanValue.startsWith("http")) {
    return cleanValue;
  }

  if (cleanValue.startsWith("@")) {
    return `https://www.youtube.com/${cleanValue}`;
  }

  if (cleanValue.startsWith("channel/")) {
    return `https://www.youtube.com/${cleanValue}`;
  }

  if (cleanValue.startsWith("c/")) {
    return `https://www.youtube.com/${cleanValue}`;
  }

  if (cleanValue.startsWith("user/")) {
    return `https://www.youtube.com/${cleanValue}`;
  }

  return `https://www.youtube.com/@${cleanValue.replace(/^@/, "")}`;
}

function getFacebookUrl(value: string | null | undefined) {
  const username = normalizeSocialUsername(value);
  return username ? `https://www.facebook.com/${username}` : null;
}

function getInstagramUrl(value: string | null | undefined) {
  const username = normalizeSocialUsername(value);
  return username ? `https://www.instagram.com/${username}` : null;
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

function GroupsAndProjectsList({
  label,
  relationships,
  direction,
}: {
  label: string;
  relationships: ArtistRelationship[];
  direction: "outgoing" | "incoming";
}) {
  if (!relationships.length) return null;

  return (
    <Field label={label}>
      <div className="space-y-2">
        {relationships.map((relationship) => {
          const artist =
            direction === "outgoing"
              ? relationship.target_artist
              : relationship.source_artist;
          const detailText = formatArtistRelationshipDisplay(
            relationship.relationship_type,
            relationship.start_year,
            relationship.end_year
          );
          const content = (
            <>
              <span className="block font-normal text-(--color-ink)">
                {artist?.name ?? "Unknown artist"}
              </span>
              {detailText && (
                <span className="mt-0.5 block text-xs text-gray-500">
                  {detailText}
                </span>
              )}
            </>
          );

          return artist?.slug ? (
            <Link
              key={relationship.id}
              href={`/artists/${artist.slug}`}
              className="block text-sm leading-snug underline-offset-4 hover:text-(--color-wikicrimson) hover:underline"
            >
              {content}
            </Link>
          ) : (
            <div key={relationship.id} className="text-sm leading-snug">
              {content}
            </div>
          );
        })}
      </div>
    </Field>
  );
}

export default function ArtistFactsCard({
  artist,
  groupsAndProjects = [],
  members = [],
}: Props) {
  const realName = getRealName(artist);
  const birthDate = formatDate(artist.date_of_birth);
  const deathDate = formatDate(artist.date_of_death);
  const birthPlace = getBirthPlace(artist);
  const originLabel = getOriginLabel(artist);
  const occupations = getOccupationList(artist.occupations);
  const artistStatus = getArtistStatus(artist);

  const websiteUrl = getWebsiteUrl(artist.website);
  const websiteDisplay = getWebsiteDisplay(artist.website);
  const hasWebsiteLink = Boolean(websiteUrl && artist.website);

  const youtubeDisplay = normalizeYoutubeDisplay(artist.youtube);
  const youtubeUrl = getYoutubeUrl(artist.youtube);

  const facebookUsername = normalizeSocialUsername(artist.facebook);
  const facebookUrl = getFacebookUrl(artist.facebook);

  const instagramUsername = normalizeSocialUsername(artist.instagram);
  const instagramUrl = getInstagramUrl(artist.instagram);
  const hasSocialLinks = Boolean(
    hasWebsiteLink ||
    (youtubeUrl && youtubeDisplay) ||
      (facebookUrl && facebookUsername) ||
      (instagramUrl && instagramUsername)
  );

  return (
    <section className="rounded-xl border border-gray-100 bg-white p-6 font-sans shadow-sm">
      <h3 className="mb-4 text-xs font-normal uppercase tracking-[0.18em] text-(--color-wikicrimson)">
        Technical Sheet
      </h3>

      <div className="space-y-4">
        <Field label="Stage Name">{artist.stage_name}</Field>

        <Field label="Real Name">{realName}</Field>

        <Field label="Date of Birth">{birthDate}</Field>

        <Field label="Date of Death">{deathDate}</Field>

        <Field label={originLabel}>{birthPlace}</Field>

        {!!artist.aliases?.length && (
          <Field label="Aliases">
            <InlineList values={artist.aliases} />
          </Field>
        )}

        {!!artist.aliases?.length && <SectionDivider />}

        <Field label="Artist Type">{formatLabel(artist.type)}</Field>

        <Field label="Status">{artistStatus}</Field>

        <Field label="Primary Role">{formatLabel(artist.primary_role)}</Field>

        {occupations.length > 0 && (
          <Field label="Other Roles">
            <InlineList values={occupations.map((occupation) => formatLabel(occupation))} />
          </Field>
        )}

        <Field label="Main Genre">{formatLabel(artist.primary_genre)}</Field>

        {!!artist.genres?.length && (
          <Field label="Musical Genres">
            <InlineList values={artist.genres.map((genre) => formatLabel(genre))} />
          </Field>
        )}

        {!!artist.artist_tags?.length && (
          <Field label="Tags">
            <InlineList values={artist.artist_tags.map((tag) => formatLabel(tag))} />
          </Field>
        )}

        {!!artist.artist_tags?.length && <SectionDivider />}

        {hasSocialLinks && (
          <LinkGroup>
            <SocialLink href={websiteUrl} label="Official Website" Icon={Globe}>
              {websiteDisplay}
            </SocialLink>

            <SocialLink href={youtubeUrl} label="YouTube" Icon={SiYoutube}>
              {youtubeDisplay}
            </SocialLink>

            <SocialLink href={facebookUrl} label="Facebook" Icon={SiFacebook}>
              {facebookUsername}
            </SocialLink>

            <SocialLink href={instagramUrl} label="Instagram" Icon={SiInstagram}>
              {instagramUsername ? `@${instagramUsername}` : null}
            </SocialLink>
          </LinkGroup>
        )}

        {(groupsAndProjects.length > 0 || members.length > 0) && (
          <>
            <SectionDivider />
            <GroupsAndProjectsList
              label="Groups & Projects"
              relationships={groupsAndProjects}
              direction="outgoing"
            />
            <GroupsAndProjectsList
              label="Members"
              relationships={members}
              direction="incoming"
            />
          </>
        )}
      </div>
    </section>
  );
}
