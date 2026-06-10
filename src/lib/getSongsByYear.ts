// src/lib/getSongsByYear.ts
import { supabase } from "@/lib/supabase";

async function getPublishedArtistIds(artistIds: unknown[]) {
  const ids = [...new Set(artistIds.filter((id): id is string => typeof id === "string" && id.length > 0))];

  if (!ids.length) return new Set<string>();

  const { data, error } = await supabase
    .from("artists")
    .select("id")
    .eq("status", "published")
    .in("id", ids);

  if (error) {
    console.error(error);
    return new Set<string>();
  }

  return new Set((data ?? []).map((artist) => artist.id));
}

async function addRecordingSlugs(rows: any[]) {
  const recordingIds = rows
    .map((row: any) => row.recording_id)
    .filter((id: unknown): id is string => typeof id === "string" && id.length > 0);

  if (!recordingIds.length) return rows;

  const { data: slugRows, error: slugError } = await supabase
    .from("recordings")
    .select("id, slug")
    .in("id", recordingIds);

  if (slugError) {
    console.error(slugError);
    return rows;
  }

  const slugMap = new Map(
    ((slugRows ?? []) as { id: string; slug: string | null }[]).map((row) => [
      row.id,
      row.slug,
    ])
  );

  return rows.map((row: any) => ({
    ...row,
    recording_slug: slugMap.get(row.recording_id) ?? null,
  }));
}

async function filterToPublishedArtists(rows: any[]) {
  const publishedArtistIds = await getPublishedArtistIds(rows.map((row: any) => row.artist_id));
  return rows.filter((row: any) => !row.artist_id || publishedArtistIds.has(row.artist_id));
}

type SongsByYearOptions = {
  limit?: number;
  offset?: number;
  sort?: "title" | "views";
};

export async function getSongsByYear(year: number, options: SongsByYearOptions = {}) {
  const sort = options.sort === "views" ? "views" : "title";

  const { data, error } = await supabase
    .from("recordings_with_release_info")
    .select("*")
    .eq("release_year_actual", year)
    .order(sort === "views" ? "views" : "recording_title", {
      ascending: sort === "title",
      nullsFirst: false,
    });

  if (error) {
    console.error(error);
    return { songs: [], total: 0, hasMore: false };
  }

  const rows = data ?? [];
  const visibleRows = await filterToPublishedArtists(rows);
  const offset = Math.max(0, options.offset ?? 0);
  const limit = Math.max(1, options.limit ?? 50);
  const songs = await addRecordingSlugs(visibleRows.slice(offset, offset + limit));

  return {
    songs,
    total: visibleRows.length,
    hasMore: offset + songs.length < visibleRows.length,
  };
}

export async function getTopSongsByViews(limit = 100) {
  const { data, error } = await supabase
    .from("recordings_with_release_info")
    .select("*")
    .order("views", { ascending: false, nullsFirst: false })
    .limit(limit);

  if (error) {
    console.error(error);
    return [];
  }

  const rows = data ?? [];
  const visibleRows = await filterToPublishedArtists(rows);

  return addRecordingSlugs(visibleRows);
}

export async function getArchiveDecadeCounts() {
  const pageSize = 1000;
  let from = 0;
  const rows: any[] = [];

  while (true) {
    const { data, error } = await supabase
      .from("recordings_with_release_info")
      .select("release_year_actual, artist_id")
      .not("release_year_actual", "is", null)
      .range(from, from + pageSize - 1);

    if (error) {
      console.error(error);
      return {};
    }

    rows.push(...(data ?? []));

    if (!data || data.length < pageSize) break;
    from += pageSize;
  }

  const visibleRows = await filterToPublishedArtists(rows);

  return visibleRows.reduce<Record<string, number>>((counts, row: any) => {
    const year = Number(row.release_year_actual);
    if (!Number.isInteger(year)) return counts;

    const decade = `${Math.floor(year / 10) * 10}s`;
    counts[decade] = (counts[decade] ?? 0) + 1;
    return counts;
  }, {});
}
