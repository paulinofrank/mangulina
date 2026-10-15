// src/lib/getSongsByYear.ts
import { unstable_cache } from "next/cache";
import { supabase } from "@/lib/supabase";
import type { ArchiveSongRow } from "@/app/[locale]/archive/SongsByYearList";
import {
  HOMEPAGE_ARCHIVE_CACHE_TAG,
  HOMEPAGE_CACHE_SECONDS,
} from "@/lib/homepageCache";
import { getPublicRecordingIds } from "@/lib/publicRecordingVisibility";

type RecordingArchiveRow = ArchiveSongRow & {
  release_year_actual: number | null;
  artist_id?: string | null;
};

type ArchiveCounts = {
  decadeCounts: Record<string, number>;
  yearCounts: Record<string, number>;
};

type ArchiveYearCountRow = {
  year: number | string | null;
  count: number | string | null;
};

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

async function addReleaseCoverAvailability<T extends { release_id?: string | null }>(rows: T[]) {
  const releaseIds = [
    ...new Set(
      rows
        .map((row) => row.release_id)
        .filter((id): id is string => typeof id === "string" && id.length > 0),
    ),
  ];

  if (!releaseIds.length) return rows;

  const { data, error } = await supabase
    .from("releases")
    .select("id, has_cover_image")
    .in("id", releaseIds);

  if (error) {
    console.error(error);
    return rows;
  }

  const coverMap = new Map(
    ((data ?? []) as Array<{ id: string; has_cover_image: boolean | null }>).map((release) => [
      release.id,
      release.has_cover_image === true,
    ]),
  );

  return rows.map((row) => ({
    ...row,
    has_cover_image: row.release_id ? coverMap.get(row.release_id) === true : false,
  }));
}

async function filterToPublishedArtists<T extends { recording_id: string }>(rows: T[]) {
  const publicRecordingIds = await getPublicRecordingIds(rows.map((row) => row.recording_id));
  return rows.filter((row) => publicRecordingIds.has(row.recording_id));
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
    })
    // Tied titles/view counts must not reorder records across page boundaries.
    .order("recording_id", { ascending: true });

  if (error) {
    console.error(error);
    return { songs: [], total: 0, hasMore: false };
  }

  const rows = (data ?? []) as RecordingArchiveRow[];
  const visibleRows = await filterToPublishedArtists(rows);
  const offset = Math.max(0, options.offset ?? 0);
  const limit = Math.max(1, options.limit ?? 50);
  const songs = await addReleaseCoverAvailability(
    await addRecordingSlugs(visibleRows.slice(offset, offset + limit)),
  );

  return {
    songs,
    total: visibleRows.length,
    hasMore: offset + songs.length < visibleRows.length,
  };
}

export async function getSongsByYear(year: number, options: SongsByYearOptions = {}) {
  return getSongsByYearRange(year, year, options);
}

async function loadTopSongsByViews(limit = 100) {
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

  return addReleaseCoverAvailability(await addRecordingSlugs(visibleRows));
}

export const getTopSongsByViews = unstable_cache(
  loadTopSongsByViews,
  ["archive-top-songs-v1"],
  {
    revalidate: HOMEPAGE_CACHE_SECONDS,
    tags: [HOMEPAGE_ARCHIVE_CACHE_TAG],
  },
);

export async function getArchiveCountsForYearRange(
  startYear?: number,
  endYear?: number,
): Promise<ArchiveCounts> {
  const { data, error } = await supabase.rpc("get_archive_year_counts", {
    p_start_year: startYear ?? null,
    p_end_year: endYear ?? null,
  });
  if (error) throw new Error(`get_archive_year_counts failed: ${error.message}`, { cause: error });

  return ((data ?? []) as ArchiveYearCountRow[]).reduce(
    (counts, row) => {
      const year = Number(row.year);
      const count = Number(row.count ?? 0);
      if (!Number.isInteger(year) || !Number.isFinite(count)) return counts;

      const yearKey = String(year);
      const decade = `${Math.floor(year / 10) * 10}s`;
      counts.yearCounts[yearKey] = count;
      counts.decadeCounts[decade] = (counts.decadeCounts[decade] ?? 0) + count;
      return counts;
    },
    { decadeCounts: {}, yearCounts: {} } as ArchiveCounts,
  );
}

export const getArchiveCounts = unstable_cache(
  async (): Promise<ArchiveCounts> => getArchiveCountsForYearRange(),
  ["homepage-archive-counts-v1"],
  {
    revalidate: HOMEPAGE_CACHE_SECONDS,
    tags: [HOMEPAGE_ARCHIVE_CACHE_TAG],
  },
);

export async function getArchiveDecadeCounts() {
  const { decadeCounts } = await getArchiveCounts();
  return decadeCounts;
}
