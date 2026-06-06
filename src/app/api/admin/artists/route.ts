import { NextResponse } from "next/server";
import { getSupabaseClient } from "@/lib/supabase";

export async function POST(request: Request) {
  const { artistId, artistData } = await request.json();

  if (!artistData?.name) {
    return NextResponse.json(
      { ok: false, error: "Artist name is required." },
      { status: 400 }
    );
  }

  const supabase = getSupabaseClient();
  const response = artistId
    ? await supabase
        .from("artists")
        .update(artistData)
        .eq("id", artistId)
        .select("id")
        .maybeSingle()
    : await supabase.from("artists").insert([artistData]).select("id").maybeSingle();

  if (response.error) {
    return NextResponse.json(
      { ok: false, error: response.error.message },
      { status: 500 }
    );
  }

  if (!response.data?.id) {
    return NextResponse.json(
      { ok: false, error: "No artist row was saved." },
      { status: 500 }
    );
  }

  return NextResponse.json({ ok: true, id: response.data.id });
}

export async function DELETE(request: Request) {
  const { artistId } = await request.json();

  if (!artistId) {
    return NextResponse.json(
      { ok: false, error: "Artist id is required." },
      { status: 400 }
    );
  }

  const supabase = getSupabaseClient();
  const { error } = await supabase
    .from("artists")
    .delete()
    .eq("id", artistId);

  if (error) {
    return NextResponse.json(
      { ok: false, error: error.message },
      { status: 500 }
    );
  }

  return NextResponse.json({ ok: true, id: artistId });
}
