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

function Chip({ children }: { children: React.ReactNode }) {
  return (
    <span className="inline-flex rounded-full bg-gray-100 px-2.5 py-1 text-xs font-semibold text-gray-700">
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
      <span className="block text-[10px] font-bold text-gray-400 uppercase">
        {label}
      </span>
      <div className="mt-1 text-sm font-semibold text-gray-800">
        {children}
      </div>
    </div>
  );
}

export default function ArtistFactsCard({ artist }: Props) {
  const realName = getRealName(artist);
  const birthDate = formatDate(artist.date_of_birth);
  const birthPlace = getBirthPlace(artist);
  const occupations = getOccupationList(artist.occupations);

  return (
    <section className="bg-white p-6 rounded-xl border border-gray-100 shadow-sm">
      <h3 className="text-xs font-bold text-(--color-wikicrimson) uppercase mb-4">
        Technical Sheet
      </h3>

      <div className="space-y-4">
        <Field label="Type">{formatLabel(artist.type)}</Field>

        <Field label="Primary Role">
          {formatLabel(artist.primary_role)}
        </Field>

        {occupations.length > 0 && (
          <Field label="Occupations">
            <div className="flex flex-wrap gap-2">
              {occupations.map((occupation) => (
                <Chip key={occupation}>{formatLabel(occupation)}</Chip>
              ))}
            </div>
          </Field>
        )}

        <Field label="Birth">
          <div className="space-y-1">
            {birthDate && <div>Date: {birthDate}</div>}
            {birthPlace && <div>Place: {birthPlace}</div>}
          </div>
        </Field>

        <Field label="Real Name">{realName}</Field>

        <Field label="Stage Name">{artist.stage_name}</Field>

        {!!artist.aliases?.length && (
          <Field label="Aliases">
            <div className="flex flex-wrap gap-2">
              {artist.aliases.map((alias) => (
                <Chip key={alias}>{alias}</Chip>
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