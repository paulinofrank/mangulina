import { NextResponse } from "next/server";

import { getSupabaseClient } from "@/lib/supabase";

type ArtistMediaPayload = {
  artist_id?: string;
  media_type?: string;
  title?: string;
  url?: string;
  platform?: string;
  external_id?: string | null;
  thumbnail_url?: string | null;
  published_date?: string | null;
  is_official?: boolean;
  is_featured?: boolean;
  display_order?: number;
  notes?: string | null;
};

const SELECT_FIELDS =
  "id, artist_id, media_type, title, url, platform, external_id, thumbnail_url, published_date, is_official, is_featured, display_order, notes";

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
  const { data, error } = await supabase
    .from("artist_media")
    .select(SELECT_FIELDS)
    .eq("artist_id", artistId)
    .order("display_order", { ascending: true })
    .order("created_at", { ascending: true });

  if (error) {
    return NextResponse.json(
      { ok: false, error: error.message },
      { status: 500 }
    );
  }

  return NextResponse.json({ ok: true, media: data ?? [] });
}

export async function POST(request: Request) {
  const { mediaId, mediaData } = await request.json();
  const payload = mediaData as ArtistMediaPayload | undefined;

  if (!payload?.artist_id) {
    return NextResponse.json(
      { ok: false, error: "Artist id is required." },
      { status: 400 }
    );
  }

  if (!payload.title?.trim() || !payload.url?.trim()) {
    return NextResponse.json(
      { ok: false, error: "Media title and URL are required." },
      { status: 400 }
    );
  }

  const supabase = getSupabaseClient();
  const writePayload = {
    ...payload,
    title: payload.title.trim(),
    url: payload.url.trim(),
    updated_at: new Date().toISOString(),
  };

  const response = mediaId
    ? await supabase
        .from("artist_media")
        .update(writePayload)
        .eq("id", mediaId)
        .eq("artist_id", payload.artist_id)
        .select("id")
        .maybeSingle()
    : await supabase
        .from("artist_media")
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
      { ok: false, error: "No artist media row was saved." },
      { status: 500 }
    );
  }

  return NextResponse.json({ ok: true, id: response.data.id });
}

export async function DELETE(request: Request) {
  const { mediaId, artistId } = await request.json();

  if (!mediaId || !artistId) {
    return NextResponse.json(
      { ok: false, error: "Media id and artist id are required." },
      { status: 400 }
    );
  }

  const supabase = getSupabaseClient();
  const { error } = await supabase
    .from("artist_media")
    .delete()
    .eq("id", mediaId)
    .eq("artist_id", artistId);

  if (error) {
    return NextResponse.json(
      { ok: false, error: error.message },
      { status: 500 }
    );
  }

  return NextResponse.json({ ok: true });
}
