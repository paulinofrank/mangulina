import { NextResponse } from "next/server";

import { getSupabaseClient } from "@/lib/supabase";

type ReleasePayload = {
  title?: string;
  type?: string | null;
  release_year?: number | null;
  year?: number | null;
  date?: string | null;
  status?: string | null;
  label?: string | null;
  country?: string | null;
  barcode?: string | null;
  catalog_number?: string | null;
  disambiguation?: string | null;
  release_artist_id?: string;
};

const RELEASE_FIELDS =
  "id, title, type, release_year, year, date, status, label, country, barcode, catalog_number, disambiguation, release_artist_id";

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const artistId = searchParams.get("artistId");

  if (!artistId) {
    return NextResponse.json(
      { ok: false, error: "Artist id is required." },
      { status: 400 }
    );
  }

  const supabase = getSupabaseClient();
  const { data: releases, error } = await supabase
    .from("releases")
    .select(RELEASE_FIELDS)
    .eq("release_artist_id", artistId)
    .order("release_year", { ascending: true, nullsFirst: false })
    .order("title", { ascending: true });

  if (error) {
    return NextResponse.json(
      { ok: false, error: error.message },
      { status: 500 }
    );
  }

  const releaseIds = (releases ?? []).map((release) => release.id);
  const trackCounts = new Map<string, number>();

  if (releaseIds.length > 0) {
    const { data: tracks, error: trackError } = await supabase
      .from("tracks")
      .select("release_id")
      .in("release_id", releaseIds);

    if (trackError) {
      return NextResponse.json(
        { ok: false, error: trackError.message },
        { status: 500 }
      );
    }

    for (const track of tracks ?? []) {
      trackCounts.set(track.release_id, (trackCounts.get(track.release_id) ?? 0) + 1);
    }
  }

  const releasesWithCounts = (releases ?? []).map((release) => ({
    ...release,
    track_count: trackCounts.get(release.id) ?? 0,
  }));

  return NextResponse.json({ ok: true, releases: releasesWithCounts });
}

export async function POST(request: Request) {
  const { releaseId, releaseData } = await request.json();
  const payload = releaseData as ReleasePayload | undefined;

  if (!payload?.release_artist_id) {
    return NextResponse.json(
      { ok: false, error: "Artist id is required." },
      { status: 400 }
    );
  }

  if (!payload.title?.trim()) {
    return NextResponse.json(
      { ok: false, error: "Release title is required." },
      { status: 400 }
    );
  }

  const supabase = getSupabaseClient();
  const writePayload = {
    ...payload,
    title: payload.title.trim(),
    updated_at: new Date().toISOString(),
  };

  const response = releaseId
    ? await supabase
        .from("releases")
        .update(writePayload)
        .eq("id", releaseId)
        .eq("release_artist_id", payload.release_artist_id)
        .select("id")
        .maybeSingle()
    : await supabase
        .from("releases")
        .insert(writePayload)
        .select("id")
        .maybeSingle();

  if (response.error) {
    return NextResponse.json(
      { ok: false, error: response.error.message },
      { status: 500 }
    );
  }

  if (!response.data?.id) {
    return NextResponse.json(
      { ok: false, error: "No release row was saved." },
      { status: 500 }
    );
  }

  return NextResponse.json({ ok: true, id: response.data.id });
}
