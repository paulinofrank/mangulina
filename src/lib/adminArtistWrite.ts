// Pure payload construction for the admin artists editor.
// Extracted from the editor so the diffing that protects concurrent edits can
// be tested without mounting the React page.

export type ArtistStatus =
  | "draft"
  | "published"
  | "hidden"
  | "needs_review"
  | "duplicate";

export type ArtistForm = {
  name: string;
  sort_name: string;
  slug: string;
  stage_name: string;
  first_name: string;
  middle_name: string;
  last_name: string;
  second_last_name: string;
  date_of_birth: string;
  birth_year: string;
  date_of_death: string;
  death_year: string;
  formation_year: string;
  dissolution_year: string;
  birth_place: string;
  province: string;
  type: string;
  primary_role: string;
  primary_genre: string;
  status: ArtistStatus;
  occupations: string;
  instruments: string;
  genres: string;
  artist_tags: string;
  aliases: string;
  website: string;
  facebook: string;
  instagram: string;
  youtube: string;
  gender: string;
  disambiguation: string;
  wikidata_id: string;
  ended: boolean;
};

export function parseCsv(value: string | null | undefined) {
  if (!value) return [];

  return value
    .split(",")
    .map((item) => item.trim())
    .filter(Boolean);
}

export function nullable(value: string | null | undefined) {
  const trimmed = (value ?? "").trim();
  return trimmed ? trimmed : null;
}

export function slugify(value: string) {
  return value
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .replace(/&/g, " and ")
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "")
    .replace(/-{2,}/g, "-");
}

// The save payload is built from the form alone, so the same function can
// produce both the baseline captured when an artist is opened and the current
// values at save time. Diffing two outputs of this function compares like with
// like: a field the editor never touched is byte-identical on both sides.
export function buildArtistWrite(form: ArtistForm) {
  const resolvedSlug = form.slug.trim() || slugify(form.name);
  return {
    name: form.name.trim(),
    sort_name: nullable(form.sort_name),
    slug: nullable(resolvedSlug),
    stage_name: nullable(form.stage_name),

    first_name: nullable(form.first_name),
    middle_name: nullable(form.middle_name),
    last_name: nullable(form.last_name),
    second_last_name: nullable(form.second_last_name),

    date_of_birth: nullable(form.date_of_birth),
    birth_year: form.birth_year ? Number(form.birth_year) : null,
    date_of_death: nullable(form.date_of_death),
    death_year: form.death_year ? Number(form.death_year) : null,
    formation_year: form.formation_year ? Number(form.formation_year) : null,
    dissolution_year: form.dissolution_year ? Number(form.dissolution_year) : null,

    birth_place: nullable(form.birth_place),
    province: nullable(form.province),

    type: nullable(form.type),
    primary_role: nullable(form.primary_role),
    primary_genre: nullable(form.primary_genre),
    status: form.status || "published",

    occupations: parseCsv(form.occupations),
    instruments: parseCsv(form.instruments),
    genres: parseCsv(form.genres),
    artist_tags: parseCsv(form.artist_tags),
    aliases: parseCsv(form.aliases),

    website: nullable(form.website),
    facebook: nullable(form.facebook),
    instagram: nullable(form.instagram),
    youtube: nullable(form.youtube),

    gender: nullable(form.gender),
    disambiguation: nullable(form.disambiguation),
    wikidata_id: nullable(form.wikidata_id),

    ended: form.ended,
  };
}

export type ArtistWrite = ReturnType<typeof buildArtistWrite>;

export function sameValue(a: unknown, b: unknown) {
  if (Array.isArray(a) && Array.isArray(b)) {
    return a.length === b.length && a.every((value, index) => value === b[index]);
  }
  return a === b;
}

// Only the fields the editor actually changed are sent. Posting the whole row
// meant that editing one field rewrote every other field from whatever the form
// held, so a row modified elsewhere after this editor loaded it was silently
// reverted — including corrections the editor never saw.
export function changedArtistFields(baseline: ArtistWrite, next: ArtistWrite) {
  const changed: Partial<ArtistWrite> = {};
  for (const key of Object.keys(next) as Array<keyof ArtistWrite>) {
    if (!sameValue(baseline[key], next[key])) {
      changed[key] = next[key] as never;
    }
  }
  return changed;
}
