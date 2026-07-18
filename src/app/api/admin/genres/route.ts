import { NextResponse } from "next/server";
import { getSupabaseClient } from "@/lib/supabase";

export async function GET(request: Request) {
  const includeHierarchy = new URL(request.url).searchParams.get("hierarchy") === "1";
  const supabase = getSupabaseClient();
  let query = supabase
    .from("genres")
    .select("id,parent_id,level,name,description,history_en,history_es,slug,display_order,is_home_featured,sort_order")
    .eq("active", true)
    .order("display_order", { ascending: true, nullsFirst: false })
    .order("sort_order", { ascending: true })
    .order("name", { ascending: true });

  if (!includeHierarchy) {
    query = query.eq("level", 0).is("parent_id", null);
  }

  const { data, error } = await query;

  if (error) {
    return NextResponse.json(
      { ok: false, error: error.message, genres: [] },
      { status: 500 },
    );
  }

  return NextResponse.json({ ok: true, genres: data ?? [] });
}

export async function POST(request: Request) {
  const body = (await request.json()) as {
    genreId?: string | number | null;
    genreData?: {
      name?: string;
      slug?: string;
      description?: string | null;
      history_en?: string | null;
      history_es?: string | null;
      display_order?: number | null;
      is_home_featured?: boolean;
    };
  };
  const { genreId, genreData } = body;

  if (!genreData?.name) {
    return NextResponse.json(
      { ok: false, error: "Genre name is required." },
      { status: 400 },
    );
  }

  const supabase = getSupabaseClient();
  const payload = {
    name: genreData.name.trim(),
    slug: genreData.slug?.trim() || null,
    description: genreData.description ?? null,
    history_en: genreData.history_en ?? null,
    history_es: genreData.history_es ?? null,
    display_order: genreData.display_order ?? null,
    sort_order: genreData.display_order ?? 0,
    is_home_featured: Boolean(genreData.is_home_featured),
    parent_id: null,
    level: 0,
    active: true,
  };
  const response = genreId
    ? await supabase
        .from("genres")
        .update(payload)
        .eq("id", genreId)
        .eq("level", 0)
        .select("id")
        .maybeSingle()
    : await supabase.from("genres").insert([payload]).select("id").maybeSingle();

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
