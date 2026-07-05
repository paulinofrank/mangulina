import { NextResponse } from "next/server";
import { requireAdminApiRole } from "@/lib/adminApiAuth";
import { getSupabaseClient } from "@/lib/supabase";
import {
  countRows,
  getArtistNames,
  getReleaseTitles,
  jsonError,
  nullableBigintId,
  nullableInteger,
  nullableJson,
  nullableString,
  nullableUuid,
  recordingContextValues,
  slugify,
} from "@/lib/adminCatalog";

type RecordingPayload = Record<string, unknown>;

const RECORDING_FIELDS =
  "id,title,work_id,youtube_id,duration,metadata,release_id,recording_year,artist_id,views,mbid,disambiguation,isrcs,updated_at,genre_id,subgenre_id,ai_confidence,ai_reason,classified_at,recording_context,slug";

function normalizeIsrcs(value: unknown) {
  if (!Array.isArray(value)) return [];
  return value
    .map((item) => String(item).trim().toUpperCase())
    .filter(Boolean);
}

function extractYouTubeId(value: unknown) {
  const raw = nullableString(value);
  if (!raw) return null;

  const patterns = [
    /(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/|youtube\.com\/shorts\/|youtube\.com\/live\/)([A-Za-z0-9_-]{6,})/,
    /^[A-Za-z0-9_-]{6,}$/,
  ];

  for (const pattern of patterns) {
    const match: RegExpMatchArray | null = raw.match(pattern);
    if (match?.[1]) return match[1];
    if (match?.[0] === raw) return raw;
  }

  return raw;
}

async function hydrateRecordings(rows: RecordingPayload[]) {
  const artistMap = await getArtistNames(rows.map((row) => row.artist_id as string | null));
  const releaseMap = await getReleaseTitles(rows.map((row) => row.release_id as string | null));

  return rows.map((row) => ({
    ...row,
    artist_name: row.artist_id ? artistMap.get(row.artist_id as string) ?? null : null,
    release_title: row.release_id ? releaseMap.get(row.release_id as string) ?? null : null,
    subtitle: [
      row.artist_id ? artistMap.get(row.artist_id as string) ?? "Unknown artist" : "No artist",
      row.recording_year,
      row.release_id ? releaseMap.get(row.release_id as string) ?? "Unknown release" : null,
      row.youtube_id,
    ]
      .filter(Boolean)
      .join(" · "),
  }));
}

async function getRecordingDetails(recordingId: string) {
  const supabase = getSupabaseClient();
  const [linksResponse, tracksResponse] = await Promise.all([
    supabase
      .from("recording_platform_links")
      .select("id,platform,label,url,status,confidence,source,checked_at")
      .eq("recording_id", recordingId)
      .order("platform", { ascending: true }),
    supabase
      .from("tracks")
      .select("id,release_id,disc_number,track_number,position,title_override,length")
      .eq("recording_id", recordingId)
      .order("disc_number", { ascending: true, nullsFirst: false })
      .order("track_number", { ascending: true, nullsFirst: false }),
  ]);

  const trackRows = (tracksResponse.data ?? []) as Array<{ release_id: string | null }>;
  const releaseMap = await getReleaseTitles(trackRows.map((track) => track.release_id));
  const track_usage = trackRows.map((track) => ({
    ...track,
    release_title: track.release_id ? releaseMap.get(track.release_id) ?? null : null,
  }));

  return {
    platform_links: linksResponse.error ? [] : linksResponse.data ?? [],
    track_usage: tracksResponse.error ? [] : track_usage,
  };
}

export async function GET(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const { searchParams } = new URL(request.url);
  const id = searchParams.get("id");
  const artistId = searchParams.get("artistId");
  const q = searchParams.get("q")?.trim() ?? "";
  const limit = Math.min(Number(searchParams.get("limit") ?? "25"), 50);
  const supabase = getSupabaseClient();

  let rows: RecordingPayload[] = [];

  if (id) {
    const { data, error } = await supabase
      .from("recordings")
      .select(RECORDING_FIELDS)
      .eq("id", id)
      .limit(1);
    if (error) return jsonError(error.message, 500);
    rows = (data ?? []) as RecordingPayload[];
  } else {
    let query = supabase.from("recordings").select(RECORDING_FIELDS);
    if (artistId) query = query.eq("artist_id", artistId);
    if (q) {
      const pattern = `%${q.replace(/[%_]/g, "")}%`;
      const numeric = Number.parseInt(q, 10);
      const filters = [
        `title.ilike.${pattern}`,
        `slug.ilike.${pattern}`,
        `youtube_id.ilike.${pattern}`,
      ];
      if (Number.isInteger(numeric)) filters.push(`recording_year.eq.${numeric}`);
      query = query.or(filters.join(",")).limit(limit);
    } else {
      query = query.order("updated_at", { ascending: false, nullsFirst: false }).limit(limit);
    }

    const { data, error } = await query.order("title", { ascending: true });
    if (error) return jsonError(error.message, 500);
    rows = (data ?? []) as RecordingPayload[];

    if (q) {
      const { data: isrcRows } = await supabase
        .from("recordings")
        .select(RECORDING_FIELDS)
        .contains("isrcs", [q.toUpperCase()])
        .match(artistId ? { artist_id: artistId } : {})
        .limit(limit);
      const byId = new Map(rows.map((row) => [row.id, row]));
      for (const row of (isrcRows ?? []) as RecordingPayload[]) byId.set(row.id, row);
      rows = [...byId.values()].slice(0, limit);
    }
  }

  const recordings = await hydrateRecordings(rows);
  const details = id ? await getRecordingDetails(id) : {};

  return NextResponse.json({ ok: true, recordings, ...details });
}

export async function POST(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const { recordingId, recordingData } = (await request.json()) as {
    recordingId?: string | null;
    recordingData?: RecordingPayload;
  };

  if (!recordingData?.title || typeof recordingData.title !== "string" || !recordingData.title.trim()) {
    return jsonError("Recording title is required.");
  }

  const artist = nullableUuid(recordingData.artist_id, "Artist id");
  if (artist.error) return jsonError(artist.error);
  const release = nullableUuid(recordingData.release_id, "Release id");
  if (release.error) return jsonError(release.error);
  const work = nullableUuid(recordingData.work_id, "Work id");
  if (work.error) return jsonError(work.error);
  const mbid = nullableUuid(recordingData.mbid, "MBID");
  if (mbid.error) return jsonError(mbid.error);
  const year = nullableInteger(recordingData.recording_year, "Recording year", 0);
  if (year.error) return jsonError(year.error);
  const duration = nullableInteger(recordingData.duration, "Duration", 0);
  if (duration.error) return jsonError(duration.error);
  const genre = nullableBigintId(recordingData.genre_id, "Genre id");
  if (genre.error) return jsonError(genre.error);
  const subgenre = nullableBigintId(recordingData.subgenre_id, "Subgenre id");
  if (subgenre.error) return jsonError(subgenre.error);
  const metadata = nullableJson(recordingData.metadata, "Metadata");
  if (metadata.error) return jsonError(metadata.error);

  const context = nullableString(recordingData.recording_context);
  if (context && !recordingContextValues.includes(context as (typeof recordingContextValues)[number])) {
    return jsonError("Recording context is not allowed.");
  }

  const title = recordingData.title.trim();
  const artistName = nullableString(recordingData.artist_name);
  const slug = nullableString(recordingData.slug) ?? slugify([title, artistName].filter(Boolean).join(" "));

  const payload = {
    title,
    slug,
    artist_id: artist.value,
    release_id: release.value,
    recording_year: year.value,
    youtube_id: extractYouTubeId(recordingData.youtube_id),
    duration: duration.value,
    recording_context: context,
    genre_id: genre.value,
    subgenre_id: subgenre.value,
    isrcs: normalizeIsrcs(recordingData.isrcs),
    disambiguation: nullableString(recordingData.disambiguation),
    metadata: metadata.value,
    work_id: work.value,
    mbid: mbid.value,
    updated_at: new Date().toISOString(),
  };

  const supabase = getSupabaseClient();
  const response = recordingId
    ? await supabase.from("recordings").update(payload).eq("id", recordingId).select("id").maybeSingle()
    : await supabase.from("recordings").insert(payload).select("id").maybeSingle();

  if (response.error) return jsonError(response.error.message, 500);
  if (!response.data?.id) return jsonError("No recording row was saved.", 500);

  const finalRecordingId = response.data.id;

  // Phase 3C-B: Also write to recording_credits table if artist_id is set
  // This synchronizes the new recording_credits table with the legacy recordings.artist_id field
  if (artist.value) {
    const recordingCreditsPayload = {
      recording_id: finalRecordingId,
      artist_id: artist.value,
      role: "lead_performer",
      display_order: 0,
    };

    // Check if entry already exists
    const existingCheck = await supabase
      .from("recording_credits")
      .select("id")
      .eq("recording_id", finalRecordingId)
      .eq("role", "lead_performer")
      .maybeSingle();

    if (existingCheck.data?.id) {
      // Update existing
      await supabase
        .from("recording_credits")
        .update(recordingCreditsPayload)
        .eq("id", existingCheck.data.id);
    } else {
      // Insert new
      await supabase.from("recording_credits").insert(recordingCreditsPayload);
    }
  }

  return NextResponse.json({ ok: true, id: finalRecordingId });
}

export async function DELETE(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const { recordingId } = (await request.json()) as { recordingId?: string };
  if (!recordingId) return jsonError("Recording id is required.");

  const checks = [
    ["tracks", "recording_id"],
    ["recording_platform_links", "recording_id"],
    ["recording_credits", "recording_id"],
    ["artist_credits", "recording_id"],
    ["lyrics", "recording_id"],
    ["translations", "recording_id"],
    ["cultural_notes", "recording_id"],
    ["recording_expressions", "recording_id"],
    ["recording_editorial", "recording_id"],
    ["recording_fun_facts", "recording_id"],
    ["recording_sources", "recording_id"],
    ["recording_media", "recording_id"],
    ["recording_locations", "recording_id"],
    ["recording_view_events", "recording_id"],
    ["platform_click_events", "recording_id"],
  ] as const;

  const blockers: string[] = [];
  for (const [table, column] of checks) {
    try {
      const count = await countRows(table, column, recordingId);
      if (count > 0) blockers.push(`${table}: ${count}`);
    } catch (error) {
      blockers.push(`${table}: check failed (${error instanceof Error ? error.message : "unknown error"})`);
    }
  }

  for (const column of ["recording_id", "related_recording_id"] as const) {
    try {
      const count = await countRows("recording_relationships", column, recordingId);
      if (count > 0) blockers.push(`recording_relationships.${column}: ${count}`);
    } catch (error) {
      blockers.push(`recording_relationships.${column}: check failed (${error instanceof Error ? error.message : "unknown error"})`);
    }
  }

  if (blockers.length > 0) {
    return jsonError(`Recording cannot be deleted while linked rows exist. ${blockers.join("; ")}`, 409);
  }

  const { error } = await getSupabaseClient().from("recordings").delete().eq("id", recordingId);
  if (error) return jsonError(error.message, 500);
  return NextResponse.json({ ok: true, id: recordingId });
}
