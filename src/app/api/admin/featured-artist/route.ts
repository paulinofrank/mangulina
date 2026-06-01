import { NextResponse } from "next/server";
import { getSupabaseClient } from "@/lib/supabase";

export async function POST(request: Request) {
  const { artistId } = await request.json();

  if (!artistId) {
    return NextResponse.json(
      { ok: false, error: "Featured artist id is required." },
      { status: 400 }
    );
  }

  const supabase = getSupabaseClient();
  const { data, error } = await supabase
    .from("featured_artist")
    .upsert({ id: 1, artist_id: artistId })
    .select("artist_id")
    .maybeSingle();

  if (error) {
    return NextResponse.json(
      { ok: false, error: error.message },
      { status: 500 }
    );
  }

  if (!data?.artist_id) {
    return NextResponse.json(
      { ok: false, error: "No featured artist row was saved." },
      { status: 500 }
    );
  }

  return NextResponse.json({ ok: true, artistId: data.artist_id });
}
