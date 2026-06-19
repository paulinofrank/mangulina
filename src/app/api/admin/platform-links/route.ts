import { NextResponse } from "next/server";
import { getSupabaseClient } from "@/lib/supabase";

// ---------------------------------------------------------------------------
// GET /api/admin/platform-links
// Query params: platform, status, minConfidence, limit
// Runs server-side — uses service role key, bypasses RLS.
// Returns merged rows with recording title + resolved artist name.
// ---------------------------------------------------------------------------
export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const platform      = searchParams.get("platform")      ?? "deezer";
  const status        = searchParams.get("status")        ?? "needs_review";
  const minConfidence = searchParams.get("minConfidence") ?? "";
  const limit         = Math.min(Number(searchParams.get("limit") ?? "50"), 200);

  const supabase = getSupabaseClient();

  // ── 1. Fetch platform link rows ──────────────────────────────────────────
  let query = supabase
    .from("recording_platform_links")
    .select(
      "id,recording_id,platform,url,label,link_type,is_official,status," +
      "display_order,created_at,updated_at,confidence,source,external_id," +
      "title_found,artist_found,checked_at",
    )
    .eq("platform", platform)
    .order("confidence", { ascending: false, nullsFirst: false })
    .order("checked_at",  { ascending: false, nullsFirst: false })
    .order("created_at",  { ascending: false })
    .limit(limit);

  if (status !== "all") {
    query = query.eq("status", status);
  }
  if (minConfidence.trim()) {
    query = query.gte("confidence", Number(minConfidence));
  }

  const { data: linkRows, error: linkErr } = await query;
  if (linkErr) {
    console.error("[platform-links GET] links error:", linkErr.message);
    return NextResponse.json({ ok: false, error: linkErr.message }, { status: 500 });
  }

  if (!linkRows || linkRows.length === 0) {
    return NextResponse.json({ ok: true, rows: [] });
  }

  // ── 2. Fetch recordings ──────────────────────────────────────────────────
  // Large-ID audit: this endpoint permits 200 rows, so the recording/release/artist
  // lookups below should move to UUID-array RPCs before raising that cap.
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const recordingIds = [...new Set((linkRows as any[]).map((r) => r.recording_id as string))];
  const { data: recordings, error: recErr } = await supabase
    .from("recordings")
    .select("id,title,artist_id,release_id,recording_year,duration")
    .in("id", recordingIds);

  if (recErr) {
    console.error("[platform-links GET] recordings error:", recErr.message);
    return NextResponse.json({ ok: false, error: recErr.message }, { status: 500 });
  }

  type RecRow = { id: string; title: string; artist_id: string | null; release_id: string | null; recording_year: number | null; duration: number | null };
  const recMap = new Map<string, RecRow>(
    ((recordings ?? []) as RecRow[]).map((r) => [r.id, r])
  );

  // ── 3. Bulk-fetch releases ───────────────────────────────────────────────
  const releaseIds = [
    ...new Set(
      ((recordings ?? []) as RecRow[])
        .map((r) => r.release_id)
        .filter((id): id is string => Boolean(id))
    ),
  ];

  type RelRow = { id: string; release_year: number | null; year: number | null; release_artist_id: string | null };
  const relMap = new Map<string, RelRow>();

  if (releaseIds.length > 0) {
    const { data: releases, error: relErr } = await supabase
      .from("releases")
      .select("id,release_year,year,release_artist_id")
      .in("id", releaseIds);
    if (relErr) {
      console.error("[platform-links GET] releases error:", relErr.message);
      return NextResponse.json({ ok: false, error: relErr.message }, { status: 500 });
    }
    for (const rel of (releases ?? []) as RelRow[]) relMap.set(rel.id, rel);
  }

  // ── 4. Bulk-fetch artists (direct + release) ─────────────────────────────
  const directArtistIds = [
    ...new Set(
      ((recordings ?? []) as RecRow[])
        .map((r) => r.artist_id)
        .filter((id): id is string => Boolean(id))
    ),
  ];
  const releaseArtistIds = [
    ...new Set(
      [...relMap.values()]
        .map((r) => r.release_artist_id)
        .filter((id): id is string => Boolean(id))
    ),
  ];
  const allArtistIds = [...new Set([...directArtistIds, ...releaseArtistIds])];

  type ArtRow = { id: string; name: string };
  const artistMap = new Map<string, string>();

  if (allArtistIds.length > 0) {
    const { data: artists, error: artErr } = await supabase
      .from("artists")
      .select("id,name")
      .in("id", allArtistIds);
    if (artErr) {
      console.error("[platform-links GET] artists error:", artErr.message);
      return NextResponse.json({ ok: false, error: artErr.message }, { status: 500 });
    }
    for (const a of (artists ?? []) as ArtRow[]) artistMap.set(a.id, a.name);
  }

  // ── 5. Merge and return ──────────────────────────────────────────────────
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const rows = (linkRows as any[]).map((link: Record<string, unknown>) => {
    const rec = recMap.get(link.recording_id as string);
    const rel = rec?.release_id ? relMap.get(rec.release_id) : null;

    // Artist resolution: direct artist_id → release_artist_id → fallback
    const artistName =
      (rec?.artist_id ? artistMap.get(rec.artist_id) : null) ??
      (rel?.release_artist_id ? artistMap.get(rel.release_artist_id) : null) ??
      "Unknown Artist";

    const releaseYear =
      rec?.recording_year ??
      rel?.release_year ??
      rel?.year ??
      null;

    // Convert duration ms → seconds for display
    const durationSec =
      rec?.duration != null && rec.duration > 0
        ? rec.duration > 5000
          ? Math.round(rec.duration / 1000)
          : rec.duration
        : null;

    return {
      ...link,
      recording_title: rec?.title ?? "Unknown Recording",
      artist_name:     artistName,
      recording_year:  releaseYear,
      duration_sec:    durationSec,
    };
  });

  return NextResponse.json({ ok: true, rows });
}

// ---------------------------------------------------------------------------
// PATCH /api/admin/platform-links
// Body: { id: string, updates: Partial<PlatformLinkRow> }
// ---------------------------------------------------------------------------
export async function PATCH(request: Request) {
  let body: { id?: string; updates?: Record<string, unknown> };
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ ok: false, error: "Invalid JSON body." }, { status: 400 });
  }

  const { id, updates } = body;
  if (!id || !updates || typeof updates !== "object") {
    return NextResponse.json(
      { ok: false, error: "id and updates are required." },
      { status: 400 },
    );
  }

  // Always stamp updated_at
  const safeUpdates = { ...updates, updated_at: new Date().toISOString() };

  const supabase = getSupabaseClient();
  const { error } = await supabase
    .from("recording_platform_links")
    .update(safeUpdates)
    .eq("id", id);

  if (error) {
    console.error("[platform-links PATCH] error:", error.message);
    return NextResponse.json({ ok: false, error: error.message }, { status: 500 });
  }

  return NextResponse.json({ ok: true });
}

// ---------------------------------------------------------------------------
// POST /api/admin/platform-links
// Body: manual link insert payload
// ---------------------------------------------------------------------------
export async function POST(request: Request) {
  let body: Record<string, unknown>;
  try {
    body = await request.json();
  } catch {
    return NextResponse.json({ ok: false, error: "Invalid JSON body." }, { status: 400 });
  }

  if (!body.recording_id || !body.url || !body.platform) {
    return NextResponse.json(
      { ok: false, error: "recording_id, platform, and url are required." },
      { status: 400 },
    );
  }

  const supabase = getSupabaseClient();
  const { data, error } = await supabase
    .from("recording_platform_links")
    .insert([{ ...body, source: "manual_admin", checked_at: new Date().toISOString() }])
    .select("id")
    .maybeSingle();

  if (error) {
    console.error("[platform-links POST] error:", error.message);
    return NextResponse.json({ ok: false, error: error.message }, { status: 500 });
  }

  return NextResponse.json({ ok: true, id: data?.id });
}
