import { NextResponse } from "next/server";
import { requireAdminApiRole } from "@/lib/adminApiAuth";
import { getSupabaseClient } from "@/lib/supabase";
import {
  getArtistNames,
  getReleaseTitles,
  jsonError,
  nullableInteger,
  nullableJson,
  nullableString,
  nullableUuid,
} from "@/lib/adminCatalog";

type TrackPayload = Record<string, unknown>;

const TRACK_FIELDS =
  "id,release_id,recording_id,track_number,disc_number,title_override,mbid,medium_id,position,length,metadata,updated_at";

async function hydrateTracks(rows: TrackPayload[]) {
  const recordingIds = rows.map((row) => row.recording_id as string | null).filter((id): id is string => Boolean(id));
  const recordingMap = new Map<string, { title: string; artist_id: string | null }>();
  const artistIds: Array<string | null> = [];

  if (recordingIds.length > 0) {
    const { data } = await getSupabaseClient()
      .from("recordings")
      .select("id,title,artist_id")
      .in("id", recordingIds);

    for (const recording of (data ?? []) as Array<{ id: string; title: string; artist_id: string | null }>) {
      recordingMap.set(recording.id, {
        title: recording.title,
        artist_id: recording.artist_id,
      });
      artistIds.push(recording.artist_id);
    }
  }

  const artistMap = await getArtistNames(artistIds);
  const releaseMap = await getReleaseTitles(rows.map((row) => row.release_id as string | null));

  return rows.map((row) => {
    const recording = row.recording_id ? recordingMap.get(row.recording_id as string) : null;
    return {
      ...row,
      release_title: row.release_id ? releaseMap.get(row.release_id as string) ?? null : null,
      recording_title: recording?.title ?? null,
      recording_artist_name: recording?.artist_id ? artistMap.get(recording.artist_id) ?? null : null,
    };
  });
}

export async function GET(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const { searchParams } = new URL(request.url);
  const id = searchParams.get("id");
  const releaseId = searchParams.get("releaseId");
  const recordingId = searchParams.get("recordingId");

  let query = getSupabaseClient().from("tracks").select(TRACK_FIELDS);

  if (id) query = query.eq("id", id);
  if (releaseId) query = query.eq("release_id", releaseId);
  if (recordingId) query = query.eq("recording_id", recordingId);

  const { data, error } = await query
    .order("disc_number", { ascending: true, nullsFirst: false })
    .order("track_number", { ascending: true, nullsFirst: false })
    .order("position", { ascending: true, nullsFirst: false });

  if (error) return jsonError(error.message, 500);
  return NextResponse.json({ ok: true, tracks: await hydrateTracks((data ?? []) as TrackPayload[]) });
}

export async function POST(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const { trackId, trackData } = (await request.json()) as {
    trackId?: string | null;
    trackData?: TrackPayload;
  };

  if (!trackData) return jsonError("Track data is required.");

  const release = nullableUuid(trackData.release_id, "Release id");
  if (release.error) return jsonError(release.error);
  if (!release.value) return jsonError("Release id is required.");

  const recording = nullableUuid(trackData.recording_id, "Recording id");
  if (recording.error) return jsonError(recording.error);
  if (!recording.value) return jsonError("Recording id is required.");

  const discNumber = nullableInteger(trackData.disc_number ?? 1, "Disc number", 1);
  if (discNumber.error) return jsonError(discNumber.error);
  const trackNumber = nullableInteger(trackData.track_number, "Track number", 0);
  if (trackNumber.error) return jsonError(trackNumber.error);
  const position = nullableInteger(trackData.position, "Position", 0);
  if (position.error) return jsonError(position.error);
  const length = nullableInteger(trackData.length, "Length", 0);
  if (length.error) return jsonError(length.error);
  const metadata = nullableJson(trackData.metadata, "Metadata");
  if (metadata.error) return jsonError(metadata.error);
  const mbid = nullableUuid(trackData.mbid, "MBID");
  if (mbid.error) return jsonError(mbid.error);
  const medium = nullableUuid(trackData.medium_id, "Medium id");
  if (medium.error) return jsonError(medium.error);

  const payload = {
    release_id: release.value,
    recording_id: recording.value,
    disc_number: discNumber.value ?? 1,
    track_number: trackNumber.value,
    position: position.value,
    title_override: nullableString(trackData.title_override),
    length: length.value,
    metadata: metadata.value,
    mbid: mbid.value,
    medium_id: medium.value,
    updated_at: new Date().toISOString(),
  };

  const supabase = getSupabaseClient();
  const response = trackId
    ? await supabase.from("tracks").update(payload).eq("id", trackId).select("id").maybeSingle()
    : await supabase.from("tracks").insert(payload).select("id").maybeSingle();

  if (response.error) return jsonError(response.error.message, 500);
  if (!response.data?.id) return jsonError("No track row was saved.", 500);

  return NextResponse.json({ ok: true, id: response.data.id });
}

export async function DELETE(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const { trackId } = (await request.json()) as { trackId?: string };
  if (!trackId) return jsonError("Track id is required.");

  const { error } = await getSupabaseClient().from("tracks").delete().eq("id", trackId);
  if (error) return jsonError(error.message, 500);
  return NextResponse.json({ ok: true, id: trackId });
}

