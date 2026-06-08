import { NextResponse } from "next/server";
import { getSupabaseClient } from "@/lib/supabase";

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const genreId = searchParams.get("genreId");
  const includeAll = searchParams.get("all") === "1";

  if (!genreId && !includeAll) {
    return NextResponse.json({ ok: true, subgenres: [] });
  }

  const supabase = getSupabaseClient();
  let query = supabase
    .from("subgenres")
    .select("id,genre_id,name,description")
    .order("name", { ascending: true });

  if (genreId) {
    query = query.eq("genre_id", genreId);
  }

  const { data, error } = await query;

  if (error) {
    return NextResponse.json(
      { ok: false, error: error.message, subgenres: [] },
      { status: 500 },
    );
  }

  return NextResponse.json({ ok: true, subgenres: data ?? [] });
}

export async function POST(request: Request) {
  const { subgenreId, subgenreData } = await request.json();

  if (!subgenreData?.name) {
    return NextResponse.json(
      { ok: false, error: "Subgenre name is required." },
      { status: 400 },
    );
  }

  if (!subgenreId && !subgenreData.genre_id) {
    return NextResponse.json(
      { ok: false, error: "Genre ID is required for a new subgenre." },
      { status: 400 },
    );
  }

  const supabase = getSupabaseClient();
  const response = subgenreId
    ? await supabase
        .from("subgenres")
        .update(subgenreData)
        .eq("id", subgenreId)
        .select("id")
        .maybeSingle()
    : await supabase
        .from("subgenres")
        .insert([subgenreData])
        .select("id")
        .maybeSingle();

  if (response.error) {
    return NextResponse.json(
      { ok: false, error: response.error.message },
      { status: 500 },
    );
  }

  if (!response.data?.id) {
    return NextResponse.json(
      { ok: false, error: "No subgenre row was saved." },
      { status: 500 },
    );
  }

  return NextResponse.json({ ok: true, id: response.data.id });
}
