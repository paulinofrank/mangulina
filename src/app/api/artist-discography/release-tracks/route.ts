import { NextResponse } from "next/server";

import { getSupabaseClient } from "@/lib/supabase";

type TrackRow = {
  id: string;
  disc_number: number | null;
  position: number | null;
  track_number: number | null;
  recording_id: string;
  title_override: string | null;
  length: number | null;
};

type RecordingRow = {
  id: string;
  title: string;
  slug: string | null;
  duration: number | null;
  genre_id: number | null;
  subgenre_id: number | null;
  recording_context: string | null;
};

type GenreRow = {
  id: number;
  name: string;
};

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const releaseId = searchParams.get("releaseId");

  if (!releaseId) {
    return NextResponse.json(
      { ok: false, error: "A release ID is required.", tracks: [] },
      { status: 400 },
    );
  }

  const supabase = getSupabaseClient();

  const { data: trackRows, error: tracksError } = await supabase
    .from("tracks")
    .select("id, disc_number, position, track_number, recording_id, title_override, length")
    .eq("release_id", releaseId)
    .order("disc_number", { ascending: true, nullsFirst: false })
    .order("position", { ascending: true, nullsFirst: false })
    .order("track_number", { ascending: true, nullsFirst: false });

  if (tracksError) {
    console.error("release tracks query error:", tracksError);
    return NextResponse.json(
      { ok: false, error: "Unable to load tracks for this release.", tracks: [] },
      { status: 500 },
    );
  }

  const tracks = (trackRows ?? []) as TrackRow[];
  const recordingIds = [...new Set(tracks.map((track) => track.recording_id).filter(Boolean))];

  if (!recordingIds.length) {
    return NextResponse.json({ ok: true, tracks: [] });
  }

  const { data: recordingRows, error: recordingsError } = await supabase
    .from("recordings")
    .select("id, title, slug, duration, genre_id, subgenre_id, recording_context")
    .in("id", recordingIds);

  if (recordingsError) {
    console.error("release track recordings query error:", recordingsError);
    return NextResponse.json(
      { ok: false, error: "Unable to load recordings for this release.", tracks: [] },
      { status: 500 },
    );
  }

  const recordings = (recordingRows ?? []) as RecordingRow[];
  const genreIds = [
    ...new Set(
      recordings
        .flatMap((recording) => [recording.genre_id, recording.subgenre_id])
        .filter((id): id is number => id != null),
    ),
  ];
  const genresById = new Map<number, string>();

  if (genreIds.length > 0) {
    const { data: genreRows, error: genresError } = await supabase
      .from("genres")
      .select("id, name")
      .in("id", genreIds);

    if (genresError) {
      console.error("release track genres query error:", genresError);
    } else {
      for (const genre of (genreRows ?? []) as GenreRow[]) {
        genresById.set(genre.id, genre.name);
      }
    }
  }

  const recordingsById = new Map(recordings.map((recording) => [recording.id, recording]));
  const responseTracks = tracks.map((track) => {
    const recording = recordingsById.get(track.recording_id);

    return {
      track_id: track.id,
      disc_number: track.disc_number ?? 1,
      track_number: track.position ?? track.track_number,
      recording_id: track.recording_id,
      recording_title: track.title_override ?? recording?.title ?? "",
      duration_ms: track.length ?? recording?.duration ?? null,
      genre: recording?.genre_id ? genresById.get(recording.genre_id) ?? null : null,
      subgenre: recording?.subgenre_id ? genresById.get(recording.subgenre_id) ?? null : null,
      recording_context: recording?.recording_context ?? null,
      slug: recording?.slug ?? null,
    };
  });

  return NextResponse.json({ ok: true, tracks: responseTracks });
}
