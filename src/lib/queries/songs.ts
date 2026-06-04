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
  cover_image_url?: string | null;
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

export type RelatedSongRecord = {
  id: string;
  slug: string | null;
  title: string;
  artist_name: string;
  artist_id?: string | null;
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

  return song;
}

// ----------------------
// CREDITS
// ----------------------
export type RawCredit = {
  role: string | null;
  artist: { name: string | null; status?: string | null } | { name: string | null; status?: string | null }[] | null;
};

export async function getSongCredits(id: string): Promise<RawCredit[]> {
  const cleanId = decodeURIComponent(id).trim().replace(/^"|"$/g, "");

  const { data, error } = await supabase
    .from("recording_credits")
    .select("role, artist:artists!inner(name, status)")
    .eq("artist.status", "published")
    .eq("recording_id", cleanId);

  return error ? [] : (data as RawCredit[]);
}

// ----------------------
// FUN FACTS
// ----------------------
export async function getSongFunFacts(id: string) {
  const cleanId = decodeURIComponent(id).trim().replace(/^"|"$/g, "");

  const { data, error } = await supabase
    .from("song_fun_facts")
    .select("*")
    .eq("song_id", cleanId);

  return error ? [] : data;
}

// ----------------------
// SLANG
// ----------------------
export async function getSongSlang(id: string) {
  const cleanId = decodeURIComponent(id).trim().replace(/^"|"$/g, "");

  const { data, error } = await supabase
    .from("song_slang")
    .select("*")
    .eq("song_id", cleanId);

  return error ? [] : data;
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
  release_year_actual: number | null;
  cover_image_url: string | null;
};

export async function getMoreSongsByArtist(
  artistId: string,
  excludeId: string,
  limit = 8,
): Promise<ArtistSongRecord[]> {
  if (!artistId) return [];

  const { data, error } = await supabase
    .from("recordings_with_release_info")
    .select("recording_id, recording_title, release_year_actual, cover_image_url")
    .eq("artist_id", artistId)
    .neq("recording_id", excludeId)
    .order("release_year_actual", { ascending: false, nullsFirst: false })
    .limit(limit);

  if (error || !data) return [];

  const rows = data as { recording_id: string; recording_title: string; release_year_actual: number | null; cover_image_url: string | null }[];

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
    release_year_actual: r.release_year_actual,
    cover_image_url:    r.cover_image_url,
  }));
}
