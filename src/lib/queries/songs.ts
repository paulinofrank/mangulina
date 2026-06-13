// src/lib/queries/songs.ts
import { supabase } from "@/lib/supabase";

export type SongRecord = {
  recording_id: string;
  recording_title: string;
  artist_id?: string | null;
  artist_name: string;

  // ── Correct view column names ──────────────────────────────────────
  // The view exposes these names. The legacy names below (genre, subgenre,
  // release_year, label_name) do NOT match view columns and will be undefined
  // at runtime — always prefer the _name / _actual suffixed versions.
  genre_name?: string | null;        // view: genre_name
  subgenre_name?: string | null;     // view: subgenre_name
  release_year_actual?: number | null; // view: release_year_actual
  release_id?: string | null;        // view: release_id (used to build cover URL)
  release_title?: string | null;     // view: release_title (album)
  release_slug?: string | null;      // fetched separately from releases.slug
  label?: string | null;             // view: label
  duration?: number | null;          // view: duration (milliseconds)
  country?: string | null;           // view: country (ISO code)
  isrcs?: string[] | null;           // view: isrcs
  mbid?: string | null;              // view: mbid (MusicBrainz recording ID)
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  recording_metadata?: Record<string, any> | null;
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  release_metadata?: Record<string, any> | null;

  // ── Legacy / wrong names kept for TypeScript compat ────────────────
  // These don't match view columns; prefer the _name / _actual versions above.
  release_year?: number | null;
  genre?: string | null;
  subgenre?: string | null;
  label_name?: string | null;

  // ── Other view / legacy fields ─────────────────────────────────────
  views?: number | null;
  recording_year?: number | null;
  youtube_id?: string | null;
  youtube_url?: string | null;
  official_video_url?: string | null;
  youtube_embed_allowed?: boolean | null;
  lyrics?: string | null;
  lyrics_authorized?: boolean | null;
  release_info?: string | null;
  song_about?: string | null;
  inspiration?: string | null;
  cultural_context?: string | null;
  notes?: string | null;
  spotify_url?: string | null;
  apple_music_url?: string | null;
  youtube_music_url?: string | null;
  amazon_music_url?: string | null;
  deezer_url?: string | null;
  tidal_url?: string | null;
  soundcloud_url?: string | null;
  bandcamp_url?: string | null;
};

type RecordingEditorial = {
  recording_id: string;
  story: string | null;
  inspiration: string | null;
  historical_context: string | null;
  cultural_significance: string | null;
  notes: string | null;
};

export type RelatedSongRecord = {
  id: string;
  slug: string | null;
  title: string;
  artist_name: string;
  artist_id?: string | null;
};

export type SongFunFactRecord = {
  id: string | number;
  recording_id: string;
  fact: string;
  source_url: string | null;
  display_order: number | null;
};

export type SongSlangRecord = {
  id: string | number;
  recording_id: string;
  expression_id: string | number;
  meaning_in_song: string | null;
  cultural_note: string | null;
  lyric_excerpt: string | null;
  display_order: number | null;
  source_url: string | null;
  expression: {
    id: string | number;
    term: string;
    definition: string | null;
    example: string | null;
    notes: string | null;
  } | null;
};

export type SongSourceRecord = {
  id: string | number;
  recording_id: string;
  source_usage: string | null;
  source: {
    id: string | number;
    title: string;
    source_type: string | null;
    author: string | null;
    publisher: string | null;
    url: string | null;
    publication_date: string | null;
    notes: string | null;
  } | null;
};

export type SongMediaRecord = {
  id: string | number;
  recording_id: string;
  media_type: string;
  title: string;
  url: string;
  platform: string | null;
  external_id: string | null;
  is_official: boolean | null;
  is_primary: boolean | null;
  notes: string | null;
  source_id: string | number | null;
  display_order: number | null;
  source: {
    id: string | number;
    title: string;
    url: string | null;
  } | null;
};

async function getPublishedArtistIds(artistIds: unknown[]) {
  const ids = [...new Set(artistIds.filter((id): id is string => typeof id === "string" && id.length > 0))];

  if (!ids.length) return new Set<string>();

  const { data, error } = await supabase
    .from("artists")
    .select("id")
    .eq("status", "published")
    .in("id", ids);

  if (error) {
    console.error("published artist status check error:", error);
    return new Set<string>();
  }

  return new Set((data ?? []).map((artist) => artist.id));
}

async function isPublishedArtist(artistId: unknown) {
  if (typeof artistId !== "string" || !artistId) return true;
  const publishedIds = await getPublishedArtistIds([artistId]);
  return publishedIds.has(artistId);
}

async function getRecordingEditorial(recordingId: string): Promise<RecordingEditorial | null> {
  const { data, error } = await supabase
    .from("recording_editorial")
    .select("recording_id, story, inspiration, historical_context, cultural_significance, notes")
    .eq("recording_id", recordingId)
    .maybeSingle();

  if (error) {
    console.error("getRecordingEditorial error:", error);
    return null;
  }

  return data as RecordingEditorial | null;
}

function applyEditorial(song: SongRecord, editorial: RecordingEditorial | null): SongRecord {
  if (!editorial) return song;

  return {
    ...song,
    song_about: editorial.story ?? song.song_about,
    inspiration: editorial.inspiration ?? song.inspiration,
    cultural_context:
      editorial.cultural_significance ??
      editorial.historical_context ??
      song.cultural_context,
    notes: editorial.notes ?? song.notes,
  };
}

function firstRelated<T>(value: T | T[] | null | undefined): T | null {
  if (Array.isArray(value)) return value[0] ?? null;
  return value ?? null;
}

// ----------------------
// SONG BY ID
// ----------------------
export async function getSongById(id: string): Promise<SongRecord | null> {
  const cleanId = decodeURIComponent(id).trim().replace(/^"|"$/g, "");

  const { data, error } = await supabase
    .from("recordings_with_release_info")
    .select("*")
    .eq("recording_id", cleanId)
    .single();

  if (error) {
    console.error("getSongById error:", error);
    return null;
  }

  const song = data as SongRecord;

  if (!(await isPublishedArtist(song.artist_id))) {
    return null;
  }

  if (song.release_id) {
    const { data: rel } = await supabase
      .from("releases")
      .select("slug")
      .eq("id", song.release_id)
      .maybeSingle();
    song.release_slug = rel?.slug ?? null;
  }

  const editorial = await getRecordingEditorial(song.recording_id);
  return applyEditorial(song, editorial);
}

// ----------------------
// CREDITS
// ----------------------
export type RawCredit = {
  role: string | null;
  artist:
    | { id: string; slug: string | null; name: string | null; status?: string | null }
    | { id: string; slug: string | null; name: string | null; status?: string | null }[]
    | null;
};

export async function getSongCredits(id: string): Promise<RawCredit[]> {
  const cleanId = decodeURIComponent(id).trim().replace(/^"|"$/g, "");

  const { data, error } = await supabase
    .from("recording_credits")
    .select("role, artist:artists!inner(id, slug, name, status)")
    .eq("artist.status", "published")
    .eq("recording_id", cleanId);

  return error ? [] : (data as RawCredit[]);
}

// ----------------------
// FUN FACTS
// ----------------------
export async function getSongFunFacts(id: string): Promise<SongFunFactRecord[]> {
  const cleanId = decodeURIComponent(id).trim().replace(/^"|"$/g, "");

  const { data, error } = await supabase
    .from("recording_fun_facts")
    .select("id, recording_id, fact, source_url, display_order")
    .eq("recording_id", cleanId)
    .order("display_order", { ascending: true, nullsFirst: false })
    .order("id", { ascending: true });

  if (error) {
    console.error("getSongFunFacts error:", error);
    return [];
  }

  return (data ?? []) as SongFunFactRecord[];
}

// ----------------------
// SLANG
// ----------------------
export async function getSongSlang(id: string): Promise<SongSlangRecord[]> {
  const cleanId = decodeURIComponent(id).trim().replace(/^"|"$/g, "");

  const { data, error } = await supabase
    .from("recording_expressions")
    .select(`
      id,
      recording_id,
      expression_id,
      meaning_in_song,
      cultural_note,
      lyric_excerpt,
      display_order,
      source_url,
      expression:expressions(id, term, definition, example, notes)
    `)
    .eq("recording_id", cleanId)
    .order("display_order", { ascending: true, nullsFirst: false })
    .order("id", { ascending: true });

  if (error) {
    console.error("getSongSlang error:", error);
    return [];
  }

  return ((data ?? []) as (Omit<SongSlangRecord, "expression"> & {
    expression?: SongSlangRecord["expression"] | SongSlangRecord["expression"][];
  })[]).map((row) => ({
    ...row,
    expression: firstRelated(row.expression),
  }));
}

// ----------------------
// SONG BY SLUG
// ----------------------
const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

export async function getSongBySlug(slug: string): Promise<SongRecord | null> {
  const clean = decodeURIComponent(slug).trim().replace(/^"|"$/g, "");

  // Fast path: look up the recording id by slug, then reuse the existing query.
  const { data: rec, error: recErr } = await supabase
    .from("recordings")
    .select("id")
    .eq("slug", clean)
    .maybeSingle();

  if (!recErr && rec?.id) {
    return getSongById(rec.id);
  }

  // Backward-compat fallback: if param looks like a UUID, treat it as an id.
  if (UUID_RE.test(clean)) {
    return getSongById(clean);
  }

  return null;
}

// ----------------------
// PLATFORM LINKS
// ----------------------
export type SongPlatformLinkRecord = {
  id: string;
  platform: string;
  url: string;
  label: string | null;
  link_type: string;
  display_order: number;
};

export async function getSongPlatformLinks(
  recordingId: string,
): Promise<SongPlatformLinkRecord[]> {
  const { data, error } = await supabase
    .from("recording_platform_links")
    .select("id, platform, url, label, link_type, display_order")
    .eq("recording_id", recordingId)
    .in("status", ["approved_manual", "approved_auto", "approved"])
    .order("display_order", { ascending: true })
    .order("platform",      { ascending: true });

  if (error) {
    console.error("getSongPlatformLinks error:", error);
    return [];
  }

  return (data ?? []) as SongPlatformLinkRecord[];
}

// ----------------------
// RELATED SONGS
// ----------------------
export async function getRelatedSongs(id: string): Promise<RelatedSongRecord[]> {
  const cleanId = decodeURIComponent(id).trim().replace(/^"|"$/g, "");

  const { data, error } = await supabase.rpc("get_related_songs", {
    song_id: cleanId,
  });

  if (error) return [];

  const rows = (data ?? []) as Omit<RelatedSongRecord, "slug">[];
  const publishedArtistIds = await getPublishedArtistIds(rows.map((row) => row.artist_id));
  const filtered = rows.filter((row) => !row.artist_id || publishedArtistIds.has(row.artist_id));

  if (filtered.length === 0) return [];

  // Fetch slugs for the returned recording IDs (RPC doesn't include slug)
  const { data: slugRows } = await supabase
    .from("recordings")
    .select("id, slug")
    .in("id", filtered.map((r) => r.id));

  const slugMap = new Map(
    ((slugRows ?? []) as { id: string; slug: string | null }[]).map((r) => [r.id, r.slug])
  );

  return filtered.map((row) => ({ ...row, slug: slugMap.get(row.id) ?? null }));
}

// ----------------------
// MORE SONGS BY ARTIST
// ----------------------
export type ArtistSongRecord = {
  id: string;
  slug: string | null;
  title: string;
  artist_name?: string | null;
  release_id: string | null;
  release_year_actual: number | null;
  views: number | null;
};

export async function getMoreSongsByArtist(
  artistId: string,
  excludeId: string,
  limit = 8,
): Promise<ArtistSongRecord[]> {
  if (!artistId) return [];

  const { data, error } = await supabase
    .from("recordings_with_release_info")
    .select("recording_id, recording_title, artist_name, release_id, release_year_actual, views")
    .eq("artist_id", artistId)
    .neq("recording_id", excludeId)
    .order("views", { ascending: false, nullsFirst: false })
    .limit(limit);

  if (error || !data) return [];

  const rows = data as {
    recording_id: string;
    recording_title: string;
    artist_name: string | null;
    release_id: string | null;
    release_year_actual: number | null;
    views: number | null;
  }[];

  // Fetch slugs
  const ids = rows.map((r) => r.recording_id);
  const { data: slugRows } = await supabase
    .from("recordings")
    .select("id, slug")
    .in("id", ids);

  const slugMap = new Map(
    ((slugRows ?? []) as { id: string; slug: string | null }[]).map((r) => [r.id, r.slug]),
  );

  return rows.map((r) => ({
    id:                 r.recording_id,
    slug:               slugMap.get(r.recording_id) ?? null,
    title:              r.recording_title,
    artist_name:        r.artist_name,
    release_id:         r.release_id,
    release_year_actual: r.release_year_actual,
    views:              r.views,
  }));
}

// ----------------------
// SOURCES
// ----------------------
export async function getSongSources(recordingId: string): Promise<SongSourceRecord[]> {
  const cleanId = decodeURIComponent(recordingId).trim().replace(/^"|"$/g, "");

  const { data, error } = await supabase
    .from("recording_sources")
    .select(`
      id,
      recording_id,
      source_usage,
      source:sources(id, title, source_type, author, publisher, url, publication_date, notes)
    `)
    .eq("recording_id", cleanId)
    .order("id", { ascending: true });

  if (error) {
    console.error("getSongSources error:", error);
    return [];
  }

  return ((data ?? []) as (Omit<SongSourceRecord, "source"> & {
    source?: SongSourceRecord["source"] | SongSourceRecord["source"][];
  })[]).map((row) => ({
    ...row,
    source: firstRelated(row.source),
  }));
}

// ----------------------
// MEDIA
// ----------------------
export async function getSongMedia(recordingId: string): Promise<SongMediaRecord[]> {
  const cleanId = decodeURIComponent(recordingId).trim().replace(/^"|"$/g, "");

  const { data, error } = await supabase
    .from("recording_media")
    .select(`
      id,
      recording_id,
      media_type,
      title,
      url,
      platform,
      external_id,
      is_official,
      is_primary,
      notes,
      source_id,
      display_order,
      source:sources(id, title, url)
    `)
    .eq("recording_id", cleanId)
    .order("is_primary", { ascending: false, nullsFirst: false })
    .order("display_order", { ascending: true, nullsFirst: false })
    .order("id", { ascending: true });

  if (error) {
    console.error("getSongMedia error:", error);
    return [];
  }

  return ((data ?? []) as (Omit<SongMediaRecord, "source"> & {
    source?: SongMediaRecord["source"] | SongMediaRecord["source"][];
  })[]).map((row) => ({
    ...row,
    source: firstRelated(row.source),
  }));
}
