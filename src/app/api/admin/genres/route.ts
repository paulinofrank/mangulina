import { NextResponse } from "next/server";
import { getSupabaseClient } from "@/lib/supabase";

export async function GET() {
  const supabase = getSupabaseClient();
  const { data, error } = await supabase
    .from("genres")
    .select("id,name,description,slug,display_order,is_home_featured")
    .order("display_order", { ascending: true, nullsFirst: false })
    .order("name", { ascending: true });

  if (error) {
    return NextResponse.json(
      { ok: false, error: error.message, genres: [] },
      { status: 500 },
    );
  }

  return NextResponse.json({ ok: true, genres: data ?? [] });
}

export async function POST(request: Request) {
  const { genreId, genreData } = await request.json();

  if (!genreData?.name) {
    return NextResponse.json(
      { ok: false, error: "Genre name is required." },
      { status: 400 },
    );
  }

  const supabase = getSupabaseClient();
  const response = genreId
    ? await supabase
        .from("genres")
        .update(genreData)
        .eq("id", genreId)
        .select("id")
        .maybeSingle()
    : await supabase.from("genres").insert([genreData]).select("id").maybeSingle();

  if (response.error) {
    return NextResponse.json(
      { ok: false, error: response.error.message },
      { status: 500 },
    );
  }

  if (!response.data?.id) {
    return NextResponse.json(
      { ok: false, error: "No genre row was saved." },
      { status: 500 },
    );
  }

  return NextResponse.json({ ok: true, id: response.data.id });
}
