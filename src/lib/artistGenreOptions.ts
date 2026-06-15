import { getSupabaseClient } from "@/lib/supabase";

const PAGE_SIZE = 1000;

export type ArtistGenreOption = {
  id: string | number;
  name: string;
  slug?: string | null;
  display_order?: number | null;
  matchValues?: string[];
};

export type ArtistSubgenreOption = {
  id: string | number;
  genre_id: string | number;
  name: string;
  matchValues?: string[];
};

export type ArtistGenreBaseFilter = {
  context?: "secular" | "christian";
  role?: string;
  province?: string;
  artistStatus?: "legend" | "emerging";
};

export type FilteredArtistGenreOptions = {
  genres: ArtistGenreOption[];
  subgenres: ArtistSubgenreOption[];
};

type ArtistClassificationRow = {
  primary_genre: string | null;
  genres: string[] | null;
};

type GenreTaxonomyRow = {
  id: string | number;
  parent_id: string | number | null;
  name: string;
  slug: string | null;
  level: number;
  display_order: number | null;
  sort_order: number | null;
};

function normalize(value: string) {
  return value.trim().toLocaleLowerCase();
}

const TAXONOMY_ALIASES: Record<string, string[]> = {
  urban: ["urban", "urbano", "rap", "hip-hop", "hip hop", "latin urban"],
  "rap / hip hop": [
    "rap",
    "hip-hop",
    "hip hop",
    "christian rap",
    "christian hip-hop",
    "christian hip hop",
    "latin hip hop",
  ],
  worship: ["worship", "adoracion", "adoración", "musica cristiana", "música cristiana"],
  pop: ["pop", "christian pop", "pop latino", "latin pop"],
  "latin pop": ["latin pop", "pop latino", "christian pop"],
  ballads: ["ballads", "ballad", "balada", "baladas"],
};

function getMatchValues(row: Pick<GenreTaxonomyRow, "name" | "slug">) {
  return Array.from(
    new Set(
      [row.name, row.slug, ...(TAXONOMY_ALIASES[normalize(row.name)] ?? [])]
        .filter((value): value is string => Boolean(value))
        .map(normalize),
    ),
  );
}

export async function getArtistGenreOptions(
  baseFilter: ArtistGenreBaseFilter,
): Promise<FilteredArtistGenreOptions> {
  const supabase = getSupabaseClient();
  const artists: ArtistClassificationRow[] = [];

  for (let from = 0; ; from += PAGE_SIZE) {
    let query = supabase
      .from("artists")
      .select("primary_genre,genres")
      .eq("status", "published");

    if (baseFilter.context) {
      query = query.contains("artist_tags", [baseFilter.context]);
    }

    if (baseFilter.role) {
      query = query.or(
        `primary_role.eq.${baseFilter.role},occupations.cs.${JSON.stringify([baseFilter.role])}`,
      );
    }

    if (baseFilter.province) {
      query = query.eq("province", baseFilter.province);
    }

    if (baseFilter.artistStatus) {
      query = query.contains("artist_tags", [baseFilter.artistStatus]);
    }

    const { data, error } = await query.range(from, from + PAGE_SIZE - 1);
    if (error) {
      console.error("Unable to load filtered artist genre options:", error);
      return { genres: [], subgenres: [] };
    }

    const page = (data ?? []) as ArtistClassificationRow[];
    artists.push(...page);
    if (page.length < PAGE_SIZE) break;
  }

  const usedPrimaryGenres = new Set(
    artists
      .map((artist) => artist.primary_genre)
      .filter((value): value is string => Boolean(value?.trim()))
      .map(normalize),
  );
  const usedStyles = new Set(
    artists.flatMap((artist) => (artist.genres ?? []).map(normalize)),
  );

  if (usedPrimaryGenres.size === 0 && usedStyles.size === 0) {
    return { genres: [], subgenres: [] };
  }

  const { data, error } = await supabase
    .from("genres")
    .select("id,parent_id,name,slug,level,display_order,sort_order")
    .eq("active", true)
    .in("level", [0, 1])
    .order("display_order", { ascending: true, nullsFirst: false })
    .order("sort_order", { ascending: true })
    .order("name", { ascending: true });

  if (error) {
    console.error("Unable to load genre taxonomy for artist options:", error);
    return { genres: [], subgenres: [] };
  }

  const taxonomy = (data ?? []) as GenreTaxonomyRow[];
  const usedSubgenres = taxonomy.filter(
    (row) =>
      row.level === 1 &&
      row.parent_id !== null &&
      getMatchValues(row).some(
        (value) => usedStyles.has(value) || usedPrimaryGenres.has(value),
      ),
  );
  const usedParentIds = new Set(usedSubgenres.map((row) => String(row.parent_id)));
  const seenGenres = new Set<string>();
  const genres = taxonomy
    .filter((row) => {
      if (row.level !== 0 || row.parent_id !== null) return false;
      const used =
        getMatchValues(row).some(
          (value) => usedPrimaryGenres.has(value) || usedStyles.has(value),
        ) || usedParentIds.has(String(row.id));
      const label = normalize(row.name);
      if (!used || seenGenres.has(label)) return false;
      seenGenres.add(label);
      return true;
    })
    .map((row) => ({
      id: row.id,
      name: row.name,
      slug: row.slug,
      display_order: row.display_order,
      matchValues: getMatchValues(row),
    }));

  const includedGenreIds = new Set(genres.map((genre) => String(genre.id)));
  const seenSubgenres = new Set<string>();
  const subgenres = usedSubgenres
    .filter((row) => {
      const label = `${row.parent_id}:${normalize(row.name)}`;
      if (!includedGenreIds.has(String(row.parent_id)) || seenSubgenres.has(label)) return false;
      seenSubgenres.add(label);
      return true;
    })
    .map((row) => ({
      id: row.id,
      genre_id: row.parent_id as string | number,
      name: row.name,
      matchValues: getMatchValues(row),
    }));

  return { genres, subgenres };
}
