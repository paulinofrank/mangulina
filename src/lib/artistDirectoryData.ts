import type { ArtistBrowseRole } from "@/components/artists/ArtistDirectory";
import type { FilteredArtistGenreOptions } from "@/lib/artistGenreOptions";
import {
  ARTIST_DIRECTORY_ITEMS_PER_PAGE,
  ARTIST_LIST_SELECT,
  type ArtistDirectoryInitialData,
} from "@/lib/artistDirectoryShared";
import { getSupabaseClient } from "@/lib/supabase";
import type { Artist } from "@/types/music";

type ArtistDirectoryQueryOptions = {
  searchParams?: Record<string, string | string[] | undefined>;
  role?: ArtistBrowseRole;
  fixedContext?: "secular" | "christian";
  filteredGenreOptions?: FilteredArtistGenreOptions;
  fixedProvince?: string;
  fixedArtistStatus?: "legend" | "emerging";
  rankedArtistIds?: string[];
};

function firstParam(value: string | string[] | undefined) {
  return Array.isArray(value) ? value[0] : value;
}

function quotePostgrestValue(value: string) {
  return `"${value.replace(/\\/g, "\\\\").replace(/"/g, '\\"')}"`;
}

function buildGenreMatchFilter(values: string[]) {
  return values
    .flatMap((value) => {
      const quoted = quotePostgrestValue(value);
      return [`primary_genre.eq.${quoted}`, `genres.cs.{${quoted}}`];
    })
    .join(",");
}

function toSearchParamsString(searchParams?: Record<string, string | string[] | undefined>) {
  const params = new URLSearchParams();

  Object.entries(searchParams ?? {}).forEach(([key, value]) => {
    const firstValue = firstParam(value);
    if (firstValue) params.set(key, firstValue);
  });

  return params.toString();
}

export function createArtistDirectoryInitialDataKey({
  searchParams,
  role,
  fixedContext,
  filteredGenreOptions,
  fixedProvince,
  fixedArtistStatus,
  rankedArtistIds,
}: ArtistDirectoryQueryOptions) {
  const params = new URLSearchParams(toSearchParamsString(searchParams));
  const currentPage = Number.parseInt(params.get("page") ?? "1", 10) || 1;
  const tag = params.get("tag");
  const genreFilter =
    params.get("genre") ??
    (params.get("classical") === "1" || tag === "classical" ? "classical" : null);
  const subgenreFilter = params.get("subgenre");
  const province = fixedProvince ?? params.get("province") ?? params.get("region");
  const sort = params.get("sort") ?? "views";
  const artistStatuses = fixedArtistStatus ? [fixedArtistStatus] : [];
  const genreOptions = filteredGenreOptions?.genres ?? [];
  const subgenreOptions = filteredGenreOptions?.subgenres ?? [];

  return [
    params.toString(),
    currentPage,
    role ?? "",
    fixedContext ?? "",
    artistStatuses.join(","),
    genreFilter ?? "",
    subgenreFilter ?? "",
    params.get("occupation") ?? "",
    params.get("instrument") ?? "",
    province ?? "",
    sort,
    rankedArtistIds?.join(",") ?? "",
    genreOptions.map((item) => `${item.id}:${item.slug ?? item.name}`).join("|"),
    subgenreOptions.map((item) => `${item.id}:${item.name}`).join("|"),
  ].join("::");
}

export async function getArtistDirectoryInitialData(
  options: ArtistDirectoryQueryOptions,
): Promise<ArtistDirectoryInitialData> {
  const supabase = getSupabaseClient();
  const params = new URLSearchParams(toSearchParamsString(options.searchParams));
  const currentPage = Number.parseInt(params.get("page") ?? "1", 10) || 1;
  const from = (currentPage - 1) * ARTIST_DIRECTORY_ITEMS_PER_PAGE;
  const to = from + ARTIST_DIRECTORY_ITEMS_PER_PAGE - 1;
  const tag = params.get("tag");
  const genreFilter =
    params.get("genre") ??
    (params.get("classical") === "1" || tag === "classical" ? "classical" : null);
  const subgenreFilter = params.get("subgenre");
  const occupationFilter = params.get("occupation");
  const instrumentFilter = params.get("instrument");
  const province = options.fixedProvince ?? params.get("province") ?? params.get("region");
  const sort = params.get("sort") ?? "views";
  const artistStatuses = options.fixedArtistStatus ? [options.fixedArtistStatus] : [];
  const genreOptions = options.filteredGenreOptions?.genres ?? [];
  const subgenreOptions = options.filteredGenreOptions?.subgenres ?? [];

  let query = supabase
    .from("artists")
    .select(ARTIST_LIST_SELECT, { count: "exact" })
    .eq("status", "published");

  const search = params.get("search");
  if (search) query = query.ilike("name", `%${search}%`);
  if (options.role) query = query.eq("primary_role", options.role);
  if (options.fixedContext) query = query.contains("artist_tags", [options.fixedContext]);
  if (artistStatuses.length === 1) query = query.contains("artist_tags", [artistStatuses[0]]);
  if (genreFilter) {
    const option = genreOptions.find((item) => (item.slug || item.name) === genreFilter);
    query = option?.matchValues?.length
      ? query.or(buildGenreMatchFilter(option.matchValues))
      : query.eq("primary_genre", genreFilter);
  }
  if (subgenreFilter) {
    const option = subgenreOptions.find((item) => item.name === subgenreFilter);
    query = option?.matchValues?.length
      ? query.or(buildGenreMatchFilter(option.matchValues))
      : query.contains("genres", [subgenreFilter]);
  }
  if (occupationFilter) query = query.filter("occupations", "cs", JSON.stringify([occupationFilter]));
  if (instrumentFilter) query = query.contains("instruments", [instrumentFilter]);
  if (province) query = query.eq("province", province);

  const response = options.rankedArtistIds?.length
    ? await query.in("id", options.rankedArtistIds)
    : await query
        .order(sort === "name" ? "name" : sort === "newest" ? "created_at" : "views", {
          ascending: sort === "name",
        })
        .range(from, to);

  if (response.error) {
    console.error(response.error);
    return {
      artists: [],
      totalCount: 0,
      cacheKey: createArtistDirectoryInitialDataKey(options),
    };
  }

  const loadedArtists = ((response.data ?? []) as unknown) as Artist[];
  if (options.rankedArtistIds?.length) {
    const rank = new Map(options.rankedArtistIds.map((id, index) => [id, index]));
    loadedArtists.sort(
      (left, right) =>
        (rank.get(left.id) ?? Number.MAX_SAFE_INTEGER) -
        (rank.get(right.id) ?? Number.MAX_SAFE_INTEGER),
    );
  }

  return {
    artists: options.rankedArtistIds?.length ? loadedArtists.slice(from, to + 1) : loadedArtists,
    totalCount: options.rankedArtistIds?.length ? loadedArtists.length : response.count ?? 0,
    cacheKey: createArtistDirectoryInitialDataKey(options),
  };
}
