import { getSupabaseClient } from "@/lib/supabase";

type ArtistAwardRow = {
  artist_id: string | null;
  won: boolean | null;
};

export type AwardedArtistRanking = {
  artist_id: string;
  award_count: number;
  nomination_count: number;
  total_count: number;
};

export type AwardFilterOption = {
  value: string;
  label: string;
};

type AwardFilter =
  | { type: "award"; id: string }
  | { type: "category"; id: string };

export async function getAwardFilterOptions(): Promise<AwardFilterOption[]> {
  const supabase = getSupabaseClient();
  const [{ data: awards, error: awardsError }, { data: artistAwards, error: usageError }] =
    await Promise.all([
      supabase.from("awards").select("id,name").order("name"),
      supabase.from("artist_awards").select("award_id,category_id"),
    ]);

  if (awardsError || usageError) {
    console.error("Unable to load award filter options:", awardsError ?? usageError);
    return [];
  }

  const usedAwardIds = new Set((artistAwards ?? []).map((row) => row.award_id));
  const usedCategoryIds = new Set(
    (artistAwards ?? []).flatMap((row) => (row.category_id ? [row.category_id] : [])),
  );
  const options: AwardFilterOption[] = (awards ?? [])
    .filter((award) => usedAwardIds.has(award.id))
    .map((award) => ({ value: `award:${award.id}`, label: award.name }));

  // Large-ID audit: the full set of used award categories can eventually exceed 100;
  // replace this filter with an RPC if the taxonomy grows to that size.
  const { data: specialCategories, error: categoryError } = await supabase
    .from("award_categories")
    .select("id,name")
    .in("id", [...usedCategoryIds])
    .ilike("name", "%Gran Soberano%")
    .order("name");

  if (categoryError) {
    console.error("Unable to load special award categories:", categoryError);
    return options;
  }

  return [
    ...options,
    ...(specialCategories ?? []).map((category) => ({
      value: `category:${category.id}`,
      label: category.name,
    })),
  ];
}

export async function getAwardedArtistRankings(
  filter?: AwardFilter,
): Promise<AwardedArtistRanking[]> {
  const supabase = getSupabaseClient();
  let query = supabase
    .from("artist_awards")
    .select("artist_id,won");

  if (filter?.type === "award") query = query.eq("award_id", filter.id);
  if (filter?.type === "category") query = query.eq("category_id", filter.id);

  const { data, error } = await query;

  if (error) {
    console.error("Unable to load awarded artists:", error);
    return [];
  }

  const counts = new Map<string, { wins: number; nominations: number }>();
  for (const row of (data ?? []) as ArtistAwardRow[]) {
    if (!row.artist_id) continue;
    const current = counts.get(row.artist_id) ?? { wins: 0, nominations: 0 };
    if (row.won) current.wins += 1;
    else current.nominations += 1;
    counts.set(row.artist_id, current);
  }

  if (counts.size === 0) return [];

  // Large-ID audit: the awarded-artist set is unbounded and can exceed 100 IDs;
  // ranking and publication filtering should ultimately happen in PostgreSQL.
  const { data: artists, error: artistsError } = await supabase
    .from("artists")
    .select("id,name,views")
    .eq("status", "published")
    .in("id", [...counts.keys()]);

  if (artistsError) {
    console.error("Unable to validate awarded artists:", artistsError);
    return [];
  }

  return ((artists ?? []) as Array<{ id: string; name: string; views: number | null }>)
    .sort((left, right) => {
      const leftCount = counts.get(left.id) ?? { wins: 0, nominations: 0 };
      const rightCount = counts.get(right.id) ?? { wins: 0, nominations: 0 };
      return (
        rightCount.wins - leftCount.wins ||
        rightCount.nominations - leftCount.nominations ||
        left.name.localeCompare(right.name)
      );
    })
    .map((artist) => {
      const count = counts.get(artist.id) ?? { wins: 0, nominations: 0 };
      return {
        artist_id: artist.id,
        award_count: count.wins,
        nomination_count: count.nominations,
        total_count: count.wins + count.nominations,
      };
    });
}

export async function getRankedAwardedArtistIds(filter?: AwardFilter) {
  const rankings = await getAwardedArtistRankings(filter);
  return rankings.map((ranking) => ranking.artist_id);
}
