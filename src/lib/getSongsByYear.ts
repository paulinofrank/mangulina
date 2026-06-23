// src/lib/getSongsByYear.ts
import { supabase } from "@/lib/supabase";
import type { ArchiveSongRow } from "@/app/[locale]/archive/SongsByYearList";

type RecordingArchiveRow = ArchiveSongRow & {
  release_year_actual: number | null;
  artist_id?: string | null;
};

type ArchiveCounts = {
  decadeCounts: Record<string, number>;
  yearCounts: Record<string, number>;
};

async function getPublishedArtistIds(artistIds: unknown[]) {
  const ids = [...new Set(artistIds.filter((id): id is string => typeof id === "string" && id.length > 0))];

  if (!ids.length) return new Set<string>();

  // Large-ID audit: decade/archive result sets can contain more than 100 artists;
  // publication filtering should move into the archive query/RPC, not be chunked here.
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

async function addRecordingSlugs(rows: RecordingArchiveRow[]) {
  const recordingIds = rows
    .map((row) => row.recording_id)
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

  return rows.map((row) => ({
    ...row,
    recording_slug: slugMap.get(row.recording_id) ?? null,
  }));
}

async function filterToPublishedArtists<T extends { artist_id?: string | null }>(rows: T[]) {
  const publishedArtistIds = await getPublishedArtistIds(rows.map((row) => row.artist_id));
  return rows.filter((row) => !row.artist_id || publishedArtistIds.has(row.artist_id));
}

type SongsByYearOptions = {
  limit?: number;
  offset?: number;
  sort?: "title" | "views";
};

export async function getSongsByYearRange(
  startYear: number,
  endYear: number,
  options: SongsByYearOptions = {},
) {
  const sort = options.sort === "views" ? "views" : "title";

  const { data, error } = await supabase
    .from("recordings_with_release_info")
    .select("*")
    .gte("release_year_actual", startYear)
    .lte("release_year_actual", endYear)
    .order(sort === "views" ? "views" : "recording_title", {
      ascending: sort === "title",
      nullsFirst: false,
    });

  if (error) {
    console.error(error);
    return { songs: [], total: 0, hasMore: false };
  }

  const rows = (data ?? []) as RecordingArchiveRow[];
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

export async function getSongsByYear(year: number, options: SongsByYearOptions = {}) {
  return getSongsByYearRange(year, year, options);
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

  const rows = (data ?? []) as RecordingArchiveRow[];
  const visibleRows = await filterToPublishedArtists(rows);

  return addRecordingSlugs(visibleRows);
}

export async function getArchiveCountsForYearRange(
  startYear?: number,
  endYear?: number,
): Promise<ArchiveCounts> {
  const pageSize = 1000;
  let from = 0;
  const rows: Pick<RecordingArchiveRow, "release_year_actual" | "artist_id">[] = [];

  while (true) {
    let query = supabase
      .from("recordings_with_release_info")
      .select("release_year_actual, artist_id")
      .not("release_year_actual", "is", null);

    if (startYear !== undefined) query = query.gte("release_year_actual", startYear);
    if (endYear !== undefined) query = query.lte("release_year_actual", endYear);

    const { data, error } = await query.range(from, from + pageSize - 1);

    if (error) {
      console.error(error);
      return { decadeCounts: {}, yearCounts: {} };
    }

    rows.push(...((data ?? []) as Pick<RecordingArchiveRow, "release_year_actual" | "artist_id">[]));

    if (!data || data.length < pageSize) break;
    from += pageSize;
  }

  const visibleRows = await filterToPublishedArtists(rows);

  return visibleRows.reduce(
    (counts, row) => {
      const year = Number(row.release_year_actual);
      if (!Number.isInteger(year)) return counts;

      const yearKey = String(year);
      const decade = `${Math.floor(year / 10) * 10}s`;
      counts.yearCounts[yearKey] = (counts.yearCounts[yearKey] ?? 0) + 1;
      counts.decadeCounts[decade] = (counts.decadeCounts[decade] ?? 0) + 1;
      return counts;
    },
    { decadeCounts: {}, yearCounts: {} } as ArchiveCounts,
  );
}

export async function getArchiveCounts(): Promise<ArchiveCounts> {
  return getArchiveCountsForYearRange();
}

export async function getArchiveDecadeCounts() {
  const { decadeCounts } = await getArchiveCounts();
  return decadeCounts;
}
