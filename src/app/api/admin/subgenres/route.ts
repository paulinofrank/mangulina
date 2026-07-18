import { NextResponse } from "next/server";
import { getSupabaseClient } from "@/lib/supabase";

type SubgenrePayload = {
  genre_id?: string | number;
  name?: string;
  description?: string | null;
  history_en?: string | null;
  history_es?: string | null;
};

function slugify(value: string) {
  return value
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const genreId = searchParams.get("genreId");
  const includeAll = searchParams.get("all") === "1";

  if (!genreId && !includeAll) {
    return NextResponse.json({ ok: true, subgenres: [] });
  }

  const supabase = getSupabaseClient();
  let query = supabase
    .from("genres")
    .select("id,parent_id,name,description,history_en,history_es,sort_order")
    .eq("level", 1)
    .eq("active", true)
    .not("parent_id", "is", null)
    .order("sort_order", { ascending: true })
    .order("name", { ascending: true });

  if (genreId) {
    query = query.eq("parent_id", genreId);
  }

  const { data, error } = await query;

  if (error) {
    return NextResponse.json(
      { ok: false, error: error.message, subgenres: [] },
      { status: 500 },
    );
  }

  const subgenres = (data ?? []).map((row) => ({
    id: row.id,
    genre_id: row.parent_id,
    name: row.name,
    description: row.description,
    history_en: row.history_en,
    history_es: row.history_es,
  }));

  return NextResponse.json({ ok: true, subgenres });
}

export async function POST(request: Request) {
  const body = (await request.json()) as {
    subgenreId?: string | number | null;
    subgenreData?: SubgenrePayload;
  };
  const { subgenreId, subgenreData } = body;

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
  const existingResponse = subgenreId
    ? await supabase
        .from("genres")
        .select("id,parent_id,slug,sort_order")
        .eq("id", subgenreId)
        .eq("level", 1)
        .maybeSingle()
    : null;
  const parentId = subgenreData.genre_id ?? existingResponse?.data?.parent_id;

  if (!parentId) {
    return NextResponse.json(
      { ok: false, error: "A valid parent genre is required." },
      { status: 400 },
    );
  }

  const { data: parent, error: parentError } = await supabase
    .from("genres")
    .select("id,slug")
    .eq("id", parentId)
    .eq("level", 0)
    .eq("active", true)
    .maybeSingle();

  if (parentError || !parent) {
    return NextResponse.json(
      { ok: false, error: parentError?.message || "Parent genre was not found." },
      { status: 400 },
    );
  }

  const payload = {
    name: subgenreData.name.trim(),
    description: subgenreData.description ?? null,
    history_en: subgenreData.history_en ?? null,
    history_es: subgenreData.history_es ?? null,
    parent_id: parent.id,
    level: 1,
    active: true,
    is_home_featured: false,
    slug:
      existingResponse?.data?.slug ||
      `${parent.slug}-${slugify(subgenreData.name)}`,
    sort_order: existingResponse?.data?.sort_order ?? 0,
  };
  const response = subgenreId
    ? await supabase
        .from("genres")
        .update(payload)
        .eq("id", subgenreId)
        .eq("level", 1)
        .select("id")
        .maybeSingle()
    : await supabase
        .from("genres")
        .insert([payload])
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
