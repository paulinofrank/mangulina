import { supabase } from "@/lib/supabase";
import { getPublicReleaseCoverUrl } from "@/lib/releaseCover";

export type ReleaseTrack = {
  id: string;
  discNumber: number;
  trackNumber: number | null;
  title: string;
  durationMs: number | null;
  recordingId: string | null;
  recordingSlug: string | null;
};

export type ReleasePageData = {
  id: string;
  slug: string;
  title: string;
  type: string | null;
  releaseYear: number | null;
  year: number | null;
  date: string | null;
  label: string | null;
  country: string | null;
  barcode: string | null;
  catalogNumber: string | null;
  coverImageUrl: string | null;
  artist: {
    id: string;
    slug: string | null;
    name: string;
  } | null;
  tracks: ReleaseTrack[];
};

type ReleaseRow = {
  id: string;
  slug: string;
  title: string;
  type: string | null;
  release_year: number | null;
  year: number | null;
  date: string | null;
  label: string | null;
  country: string | null;
  barcode: string | null;
  catalog_number: string | null;
  release_artist_id: string | null;
};

type TrackRow = {
  id: string;
  recording_id: string | null;
  track_number: number | null;
  disc_number: number | null;
  position: number | null;
  length: number | null;
  title_override: string | null;
};

type RecordingRow = {
  id: string;
  slug: string | null;
  title: string | null;
  duration: number | null;
};

export function getReleaseCoverUrl(releaseId: string) {
  return getPublicReleaseCoverUrl(releaseId, 300);
}

export function formatReleaseType(type?: string | null) {
  if (!type) return "Release";
  return type.charAt(0).toUpperCase() + type.slice(1).toLowerCase();
}

export async function getReleaseBySlug(slug: string): Promise<ReleasePageData | null> {
  const { data: release, error: releaseError } = await supabase
    .from("releases")
    .select(
      "id, slug, title, type, release_year, year, date, label, country, barcode, catalog_number, release_artist_id",
    )
    .eq("slug", slug)
    .maybeSingle();

  if (releaseError) {
    console.error("getReleaseBySlug release error:", releaseError);
    return null;
  }

  if (!release) return null;

  const releaseRow = release as ReleaseRow;
  const [artistResponse, tracksResponse] = await Promise.all([
    releaseRow.release_artist_id
      ? supabase
          .from("artists")
          .select("id, slug, name")
          .eq("id", releaseRow.release_artist_id)
          .maybeSingle()
      : Promise.resolve({ data: null, error: null }),
    supabase
      .from("tracks")
      .select("id, recording_id, track_number, disc_number, position, length, title_override")
      .eq("release_id", releaseRow.id)
      .order("disc_number", { ascending: true, nullsFirst: false })
      .order("track_number", { ascending: true, nullsFirst: false })
      .order("position", { ascending: true, nullsFirst: false }),
  ]);

  if (artistResponse.error) {
    console.error("getReleaseBySlug artist error:", artistResponse.error);
  }

  if (tracksResponse.error) {
    console.error("getReleaseBySlug tracks error:", tracksResponse.error);
  }

  const trackRows = (tracksResponse.data ?? []) as TrackRow[];
  const recordingIds = [
    ...new Set(trackRows.map((track) => track.recording_id).filter((id): id is string => Boolean(id))),
  ];
  const recordingMap = new Map<string, RecordingRow>();

  if (recordingIds.length > 0) {
    const { data: recordings, error: recordingsError } = await supabase
      .from("recordings")
      .select("id, slug, title, duration")
      .in("id", recordingIds);

    if (recordingsError) {
      console.error("getReleaseBySlug recordings error:", recordingsError);
    }

    for (const recording of (recordings ?? []) as RecordingRow[]) {
      recordingMap.set(recording.id, recording);
    }
  }

  const tracks = trackRows.map((track) => {
    const recording = track.recording_id ? recordingMap.get(track.recording_id) : null;

    return {
      id: track.id,
      discNumber: track.disc_number ?? 1,
      trackNumber: track.track_number ?? track.position,
      title: track.title_override ?? recording?.title ?? "Untitled track",
      durationMs: track.length ?? recording?.duration ?? null,
      recordingId: track.recording_id,
      recordingSlug: recording?.slug ?? null,
    };
  });

  const artist = artistResponse.data as { id: string; slug: string | null; name: string } | null;

  return {
    id: releaseRow.id,
    slug: releaseRow.slug,
    title: releaseRow.title,
    type: releaseRow.type,
    releaseYear: releaseRow.release_year,
    year: releaseRow.year,
    date: releaseRow.date,
    label: releaseRow.label,
    country: releaseRow.country,
    barcode: releaseRow.barcode,
    catalogNumber: releaseRow.catalog_number,
    coverImageUrl: getReleaseCoverUrl(releaseRow.id),
    artist,
    tracks,
  };
}
