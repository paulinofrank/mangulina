import { NextResponse } from "next/server";
import { requireAdminApiRole } from "@/lib/adminApiAuth";
import { createServiceRoleClient } from "@/lib/supabaseService";
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
import {
  revalidateHomepageArchiveCounts,
  revalidateHomepageData,
} from "@/lib/homepageCache";
import {
  revalidateReleasesContainingRecording,
  revalidateSongProfilePaths,
  revalidateSongProfileByRecordingId,
  revalidateSongsLinkedToWork,
  revalidateArtistProfilesByArtistIds,
} from "@/lib/revalidateCatalogProfiles";

type RecordingPayload = Record<string, unknown>;

const RECORDING_FIELDS =
  "id,title,work_id,youtube_id,duration,metadata,release_id,recording_year,artist_id,views,mbid,disambiguation,isrcs,updated_at,genre_id,subgenre_id,ai_confidence,ai_reason,classified_at,recording_context,slug";

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
  const ids = rows.map((row) => row.id as string).filter(Boolean);
  const firstAppearance = new Map<string, { year: number | null; title: string | null }>();
  if (ids.length) {
    const db = createServiceRoleClient();
    const { data: tracks } = await db.from("tracks").select("recording_id,release_id").in("recording_id", ids);
    const releaseIds = [...new Set((tracks ?? []).map((track) => track.release_id).filter((id): id is string => Boolean(id)))];
    const { data: releases } = releaseIds.length ? await db.from("releases").select("id,title,release_year,year,date").in("id", releaseIds) : { data: [] };
    const releasesById = new Map((releases ?? []).map((release) => [release.id, release]));
    for (const track of tracks ?? []) {
      const release = track.release_id ? releasesById.get(track.release_id) : null;
      const year = release?.release_year ?? release?.year ?? (release?.date ? new Date(release.date).getUTCFullYear() : null);
      const current = firstAppearance.get(track.recording_id);
      if (!current || (year != null && (current.year == null || year < current.year))) firstAppearance.set(track.recording_id, { year, title: release?.title ?? null });
    }
  }

  return rows.map((row) => ({
    ...row,
    artist_name: row.artist_id ? artistMap.get(row.artist_id as string) ?? null : null,
    release_title: row.release_id ? releaseMap.get(row.release_id as string) ?? null : null,
    subtitle: [
      row.artist_id ? artistMap.get(row.artist_id as string) ?? "Unknown artist" : "No artist",
      row.disambiguation,
      row.recording_year ? `recorded ${row.recording_year}` : "recording year unknown",
      row.duration ? `${row.duration} ms` : null,
      firstAppearance.get(row.id as string)?.year ? `first-known release ${firstAppearance.get(row.id as string)?.year}` : null,
    ]
      .filter(Boolean)
      .join(" · "),
  }));
}

async function getRecordingDetails(recordingId: string) {
  const supabase = createServiceRoleClient();
  const [linksResponse, tracksResponse, isrcResponse, recordingResponse] = await Promise.all([
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
    supabase.from("recording_isrcs").select("id,isrc,verification_status,recording_isrc_sources(count)").eq("recording_id", recordingId).order("isrc"),
    supabase.from("recordings").select("work_id,work:works(id,preferred_title,status)").eq("id", recordingId).maybeSingle(),
  ]);

  const trackRows = (tracksResponse.data ?? []) as Array<{ release_id: string | null }>;
  const releaseIds = [...new Set(trackRows.map((track) => track.release_id).filter((id): id is string => Boolean(id)))];
  const { data: releases } = releaseIds.length ? await supabase.from("releases").select("id,title,release_year,year,date,type,country,packaging,disambiguation,release_group_id,release_group:release_groups(id,title)").in("id", releaseIds) : { data: [] };
  const releaseMap = new Map((releases ?? []).map((release) => [release.id, release]));
  const track_usage = trackRows.map((track) => ({
    ...track,
    ...(track.release_id ? releaseMap.get(track.release_id) ?? {} : {}),
    release_title: track.release_id ? releaseMap.get(track.release_id)?.title ?? null : null,
  }));
  const isrcValues = (isrcResponse.data ?? []).map((row) => row.isrc);
  const { data: conflicts } = isrcValues.length ? await supabase.from("recording_isrc_conflicts").select("isrc,recording_count").in("isrc", isrcValues) : { data: [] };
  const conflictSet = new Set((conflicts ?? []).map((row) => row.isrc));
  const workValue = recordingResponse.error ? null : recordingResponse.data?.work ?? null;
  const work = Array.isArray(workValue) ? workValue[0] ?? null : workValue;
  const { data: compositionCredits } = work?.id
    ? await supabase
        .from("work_credits")
        .select("id,role,credited_as,verification_status,artist:artists(id,name),external_contributor:external_contributors(id,preferred_name),role_definition:credit_roles(id,code,display_name_en,role_family)")
        .eq("work_id", work.id)
        .order("sequence", { ascending: true, nullsFirst: false })
    : { data: [] };

  return {
    platform_links: linksResponse.error ? [] : linksResponse.data ?? [],
    track_usage: tracksResponse.error ? [] : track_usage,
    normalized_isrcs: isrcResponse.error ? [] : (isrcResponse.data ?? []).map((row) => ({ ...row, conflict: conflictSet.has(row.isrc) })),
    canonical_work: work,
    composition_credits: compositionCredits ?? [],
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
  const supabase = createServiceRoleClient();

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
  if (slug.startsWith("work-")) return jsonError("Recording slugs cannot use the work- prefix reserved for composition pages.");

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
    disambiguation: nullableString(recordingData.disambiguation),
    metadata: metadata.value,
    mbid: mbid.value,
    updated_at: new Date().toISOString(),
  };

  const supabase = createServiceRoleClient();
  const previousSlugResponse = recordingId
    ? await supabase.from("recordings").select("slug,work_id,artist_id").eq("id", recordingId).maybeSingle()
    : null;
  const response = recordingId
    ? await supabase.from("recordings").update(payload).eq("id", recordingId).select("id").maybeSingle()
    : await supabase.from("recordings").insert(payload).select("id").maybeSingle();

  if (response.error) return jsonError(response.error.message, 500);
  if (!response.data?.id) return jsonError("No recording row was saved.", 500);

  const finalRecordingId = response.data.id;

  // Song profiles use a long fallback TTL; editorial freshness comes from the
  // targeted revalidation below (old slug covered on slug changes).
  const previousSlug = previousSlugResponse?.data?.slug as string | null | undefined;
  if (previousSlug && previousSlug !== slug) revalidateSongProfilePaths(previousSlug);
  if (slug) revalidateSongProfilePaths(slug);
  await revalidateSongProfileByRecordingId(finalRecordingId);
  if (previousSlugResponse?.data?.work_id) await revalidateSongsLinkedToWork(previousSlugResponse.data.work_id);
  if (previousSlugResponse?.data?.artist_id) await revalidateArtistProfilesByArtistIds([previousSlugResponse.data.artist_id]);
  await revalidateReleasesContainingRecording(finalRecordingId);

  revalidateHomepageData();
  revalidateHomepageArchiveCounts();
  return NextResponse.json({ ok: true, id: finalRecordingId });
}

export async function DELETE(request: Request) {
  const auth = await requireAdminApiRole("admin");
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

  const supabase = createServiceRoleClient();
  const { data: deletedRecording } = await supabase
    .from("recordings")
    .select("slug,work_id,artist_id")
    .eq("id", recordingId)
    .maybeSingle();
  const { error } = await supabase.from("recordings").delete().eq("id", recordingId);
  if (error) return jsonError(error.message, 500);
  // Regenerating the deleted slug turns the cached page into a 404. The
  // blockers above guarantee no tracks remain, so no release fan-out needed.
  if (deletedRecording?.slug) revalidateSongProfilePaths(deletedRecording.slug);
  if (deletedRecording?.work_id) await revalidateSongsLinkedToWork(deletedRecording.work_id);
  if (deletedRecording?.artist_id) await revalidateArtistProfilesByArtistIds([deletedRecording.artist_id]);
  revalidateHomepageData();
  revalidateHomepageArchiveCounts();
  return NextResponse.json({ ok: true, id: recordingId });
}
