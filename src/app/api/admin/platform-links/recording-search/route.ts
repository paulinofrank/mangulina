import { NextResponse } from "next/server";
import { getSupabaseClient } from "@/lib/supabase";

/**
 * GET /api/admin/platform-links/recording-search?q=...
 * Server-side recording title search with artist resolution.
 * Used by the Manual Add form on the platform-links admin page.
 */
export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const q = searchParams.get("q")?.trim() ?? "";

  if (!q) return NextResponse.json({ recordings: [] });

  const supabase = getSupabaseClient();

  const { data: recordings, error: recErr } = await supabase
    .from("recordings")
    .select("id,title,artist_id,release_id,recording_year")
    .ilike("title", `%${q}%`)
    .order("title", { ascending: true })
    .limit(20);

  if (recErr) {
    return NextResponse.json({ ok: false, error: recErr.message }, { status: 500 });
  }

  if (!recordings || recordings.length === 0) {
    return NextResponse.json({ recordings: [] });
  }

  type RecRow = { id: string; title: string; artist_id: string | null; release_id: string | null; recording_year: number | null };

  const releaseIds = [
    ...new Set(
      (recordings as RecRow[]).map((r) => r.release_id).filter((id): id is string => Boolean(id))
    ),
  ];

  type RelRow = { id: string; release_artist_id: string | null; release_year: number | null; year: number | null };
  const relMap = new Map<string, RelRow>();

  if (releaseIds.length > 0) {
    const { data: releases } = await supabase
      .from("releases")
      .select("id,release_artist_id,release_year,year")
      .in("id", releaseIds);
    for (const r of (releases ?? []) as RelRow[]) relMap.set(r.id, r);
  }

  const artistIds = [
    ...new Set(
      [
        ...(recordings as RecRow[]).map((r) => r.artist_id),
        ...[...relMap.values()].map((r) => r.release_artist_id),
      ].filter((id): id is string => Boolean(id))
    ),
  ];

  type ArtRow = { id: string; name: string };
  const artistMap = new Map<string, string>();

  if (artistIds.length > 0) {
    const { data: artists } = await supabase
      .from("artists")
      .select("id,name")
      .in("id", artistIds);
    for (const a of (artists ?? []) as ArtRow[]) artistMap.set(a.id, a.name);
  }

  const result = (recordings as RecRow[]).map((rec) => {
    const rel = rec.release_id ? relMap.get(rec.release_id) : null;
    const artistName =
      (rec.artist_id ? artistMap.get(rec.artist_id) : null) ??
      (rel?.release_artist_id ? artistMap.get(rel.release_artist_id) : null) ??
      "Unknown Artist";
    const recordingYear = rec.recording_year ?? rel?.release_year ?? rel?.year ?? null;
    return { id: rec.id, title: rec.title, artist_name: artistName, recording_year: recordingYear };
  });

  return NextResponse.json({ recordings: result });
}
