import type { ArchiveSongRow } from "@/app/[locale]/archive/SongsByYearList";
import { supabase } from "@/lib/supabase";

type SubgenreSongOptions = {
  limit?: number;
  offset?: number;
  sort?: "title" | "views";
};

const SUPABASE_BATCH_SIZE = 1000;
const ARTIST_ID_BATCH_SIZE = 500;

type RecordingViewRow = ArchiveSongRow & {
  artist_id: string | null;
};

export async function getSongsBySubgenre(
  genreId: number,
  subgenreId: number | null,
  options: SubgenreSongOptions = {},
) {
  const { data: genre, error: genreError } = await supabase
    .from("genres")
    .select("id,name")
    .eq("id", genreId)
    .eq("level", 0)
    .eq("active", true)
    .maybeSingle();

  if (genreError) throw genreError;
  if (!genre) return null;

  const { data: subgenre, error: subgenreError } = subgenreId === null
    ? { data: null, error: null }
    : await supabase
        .from("genres")
        .select("id,parent_id,name")
        .eq("id", subgenreId)
        .eq("parent_id", genreId)
        .eq("level", 1)
        .eq("active", true)
        .maybeSingle();

  if (subgenreError) throw subgenreError;
  if (subgenreId !== null && !subgenre) return null;

  const sort = options.sort === "title" ? "title" : "views";

  const rows: RecordingViewRow[] = [];

  for (let from = 0; ; from += SUPABASE_BATCH_SIZE) {
    let query = supabase
      .from("recordings_with_release_info")
      .select(
        "recording_id,recording_title,artist_id,artist_name,duration,views,genre_id,genre_name,subgenre_id,subgenre_name,release_id",
      )
      .eq("genre_id", genreId);

    if (subgenreId !== null) query = query.eq("subgenre_id", subgenreId);

    const { data, error } = await query
      .order(sort === "title" ? "recording_title" : "views", {
        ascending: sort === "title",
        nullsFirst: false,
      })
      .order("recording_id", { ascending: true })
      .range(from, from + SUPABASE_BATCH_SIZE - 1);

    if (error) throw error;

    const batch = (data ?? []) as RecordingViewRow[];
    rows.push(...batch);
    if (batch.length < SUPABASE_BATCH_SIZE) break;
  }
  const artistIds = [
    ...new Set(
      rows
        .map((row) => row.artist_id)
        .filter((id): id is string => typeof id === "string" && id.length > 0),
    ),
  ];

  let publishedArtistIds = new Set<string>();

  if (artistIds.length > 0) {
    publishedArtistIds = new Set<string>();
    for (let index = 0; index < artistIds.length; index += ARTIST_ID_BATCH_SIZE) {
      const { data: artists, error: artistsError } = await supabase
        .from("artists")
        .select("id")
        .eq("status", "published")
        .in("id", artistIds.slice(index, index + ARTIST_ID_BATCH_SIZE));

      if (artistsError) throw artistsError;
      for (const artist of artists ?? []) publishedArtistIds.add(artist.id);
    }
  }

  const visibleRows = rows.filter(
    (row) => !row.artist_id || publishedArtistIds.has(row.artist_id),
  );
  const offset = Math.max(0, options.offset ?? 0);
  const limit = Math.min(Math.max(1, options.limit ?? 25), 100);
  const pageRows = visibleRows.slice(offset, offset + limit);
  const recordingIds = pageRows.map((row) => row.recording_id);
  const releaseIds = [
    ...new Set(pageRows.map((row) => row.release_id).filter((id): id is string => Boolean(id))),
  ];
  let slugMap = new Map<string, string | null>();
  let coverMap = new Map<string, boolean>();

  if (recordingIds.length > 0) {
    const { data: slugRows, error: slugError } = await supabase
      .from("recordings")
      .select("id,slug")
      .in("id", recordingIds);

    if (slugError) throw slugError;
    slugMap = new Map((slugRows ?? []).map((row) => [row.id, row.slug]));
  }

  if (releaseIds.length > 0) {
    const { data: releaseRows, error: releaseError } = await supabase
      .from("releases")
      .select("id, has_cover_image")
      .in("id", releaseIds);

    if (releaseError) throw releaseError;
    coverMap = new Map(
      (releaseRows ?? []).map((row) => [row.id, row.has_cover_image === true]),
    );
  }

  const songs = pageRows.map((row) => ({
    ...row,
    recording_slug: slugMap.get(row.recording_id) ?? null,
    has_cover_image: row.release_id ? coverMap.get(row.release_id) === true : false,
  }));

  return {
    subgenreName: subgenre?.name ?? genre.name,
    songs,
    total: visibleRows.length,
    hasMore: offset + songs.length < visibleRows.length,
  };
}
