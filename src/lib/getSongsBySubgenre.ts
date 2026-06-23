import type { ArchiveSongRow } from "@/app/[locale]/archive/SongsByYearList";
import { supabase } from "@/lib/supabase";

type RecordingViewRow = ArchiveSongRow & {
  artist_id: string | null;
};

type SubgenreSongOptions = {
  limit?: number;
  offset?: number;
  sort?: "title" | "views";
};

export async function getSongsBySubgenre(
  genreId: number,
  subgenreId: number,
  options: SubgenreSongOptions = {},
) {
  const { data: subgenre, error: subgenreError } = await supabase
    .from("genres")
    .select("id,parent_id,name")
    .eq("id", subgenreId)
    .eq("parent_id", genreId)
    .eq("level", 1)
    .eq("active", true)
    .maybeSingle();

  if (subgenreError) throw subgenreError;
  if (!subgenre) return null;

  const sort = options.sort === "title" ? "title" : "views";

  const { data, error } = await supabase
    .from("recordings_with_release_info")
    .select(
      "recording_id,recording_title,artist_id,artist_name,duration,views,genre_id,genre_name,subgenre_id,subgenre_name,release_id",
    )
    .eq("genre_id", genreId)
    .eq("subgenre_id", subgenreId)
    .order(sort === "title" ? "recording_title" : "views", {
      ascending: sort === "title",
      nullsFirst: false,
    });

  if (error) throw error;

  const rows = (data ?? []) as RecordingViewRow[];
  const artistIds = [
    ...new Set(
      rows
        .map((row) => row.artist_id)
        .filter((id): id is string => typeof id === "string" && id.length > 0),
    ),
  ];

  let publishedArtistIds = new Set<string>();

  if (artistIds.length > 0) {
    // Large-ID audit: popular subgenres can span more than 100 artists; publication
    // filtering should move into the database query/RPC instead of growing this URL.
    const { data: artists, error: artistsError } = await supabase
      .from("artists")
      .select("id")
      .eq("status", "published")
      .in("id", artistIds);

    if (artistsError) throw artistsError;
    publishedArtistIds = new Set((artists ?? []).map((artist) => artist.id));
  }

  const visibleRows = rows.filter(
    (row) => !row.artist_id || publishedArtistIds.has(row.artist_id),
  );
  const offset = Math.max(0, options.offset ?? 0);
  const limit = Math.min(Math.max(1, options.limit ?? 25), 100);
  const pageRows = visibleRows.slice(offset, offset + limit);
  const recordingIds = pageRows.map((row) => row.recording_id);
  let slugMap = new Map<string, string | null>();

  if (recordingIds.length > 0) {
    const { data: slugRows, error: slugError } = await supabase
      .from("recordings")
      .select("id,slug")
      .in("id", recordingIds);

    if (slugError) throw slugError;
    slugMap = new Map((slugRows ?? []).map((row) => [row.id, row.slug]));
  }

  const songs = pageRows.map((row) => ({
    ...row,
    recording_slug: slugMap.get(row.recording_id) ?? null,
  }));

  return {
    subgenreName: subgenre.name,
    songs,
    total: visibleRows.length,
    hasMore: offset + songs.length < visibleRows.length,
  };
}
