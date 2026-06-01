//artist facts card component
import type { ArtistProfileData } from "@/lib/artistApi";

type Props = {
  artist: ArtistProfileData;
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

function Chip({ children }: { children: React.ReactNode }) {
  return (
    <span className="inline-flex rounded-full bg-gray-100 px-2.5 py-1 text-xs font-normal text-gray-700">
      {children}
    </span>
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
}: {
  href: string | null;
  children: React.ReactNode;
}) {
  if (!href || !children) return null;

  return (
    <a
      href={href}
      target="_blank"
      rel="noopener noreferrer"
      className="text-(--color-flagblue) underline-offset-4 hover:text-(--color-wikicrimson) hover:underline"
    >
      {children}
    </a>
  );
}

export default function ArtistFactsCard({ artist }: Props) {
  const realName = getRealName(artist);
  const birthDate = formatDate(artist.date_of_birth);
  const deathDate = formatDate(artist.date_of_death);
  const birthPlace = getBirthPlace(artist);
  const occupations = getOccupationList(artist.occupations);

  const websiteUrl = getWebsiteUrl(artist.website);

  const youtubeDisplay = normalizeYoutubeDisplay(artist.youtube);
  const youtubeUrl = getYoutubeUrl(artist.youtube);

  const facebookUsername = normalizeSocialUsername(artist.facebook);
  const facebookUrl = getFacebookUrl(artist.facebook);

  const instagramUsername = normalizeSocialUsername(artist.instagram);
  const instagramUrl = getInstagramUrl(artist.instagram);

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

        <Field label="Place of Birth">{birthPlace}</Field>

        <Field label="Artist Type">{formatLabel(artist.type)}</Field>

        <Field label="Primary Role">{formatLabel(artist.primary_role)}</Field>

        {occupations.length > 0 && (
          <Field label="Other Roles">
            <div className="flex flex-wrap gap-2">
              {occupations.map((occupation) => (
                <Chip key={occupation}>{formatLabel(occupation)}</Chip>
              ))}
            </div>
          </Field>
        )}

        {!!artist.genres?.length && (
          <Field label="Musical Genres">
            <div className="flex flex-wrap gap-2">
              {artist.genres.map((genre) => (
                <Chip key={genre}>{formatLabel(genre)}</Chip>
              ))}
            </div>
          </Field>
        )}

        <Field label="Official Website">
          <ExternalLink href={websiteUrl}>{artist.website}</ExternalLink>
        </Field>

        <Field label="YouTube">
          <ExternalLink href={youtubeUrl}>{youtubeDisplay}</ExternalLink>
        </Field>

        <Field label="Facebook">
          <ExternalLink href={facebookUrl}>{facebookUsername}</ExternalLink>
        </Field>

        <Field label="Instagram">
          <ExternalLink href={instagramUrl}>
            {instagramUsername ? `@${instagramUsername}` : null}
          </ExternalLink>
        </Field>

        {!!artist.aliases?.length && (
          <Field label="Aliases">
            <div className="flex flex-wrap gap-2">
              {artist.aliases.map((alias) => (
                <Chip key={alias}>{alias}</Chip>
              ))}
            </div>
          </Field>
        )}

        {!!artist.artist_tags?.length && (
          <Field label="Tags">
            <div className="flex flex-wrap gap-2">
              {artist.artist_tags.map((tag) => (
                <Chip key={tag}>{formatLabel(tag)}</Chip>
              ))}
            </div>
          </Field>
        )}
      </div>
    </section>
  );
}