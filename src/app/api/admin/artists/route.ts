import { NextResponse } from "next/server";
import { requireAdminApiRole } from "@/lib/adminApiAuth";
import { getSupabaseClient } from "@/lib/supabase";
import { revalidateArtistProfilePaths } from "@/lib/revalidateArtistProfile";

export async function GET(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const { searchParams } = new URL(request.url);
  const id = searchParams.get("id");
  const q = searchParams.get("q")?.trim() ?? "";
  const limit = Math.min(Number(searchParams.get("limit") ?? "25"), 50);

  let query = getSupabaseClient()
    .from("artists")
    .select("id,name,slug,stage_name,sort_name,status,primary_role,primary_genre,province,aliases")
    .order("name", { ascending: true })
    .limit(limit);

  if (id) {
    query = query.eq("id", id).limit(1);
  } else if (q) {
    const pattern = `%${q.replace(/[%_]/g, "")}%`;
    query = query.or(
      [
        `name.ilike.${pattern}`,
        `slug.ilike.${pattern}`,
        `stage_name.ilike.${pattern}`,
        `sort_name.ilike.${pattern}`,
      ].join(","),
    );
  }

  const { data, error } = await query;
  if (error) {
    return NextResponse.json({ ok: false, error: error.message }, { status: 500 });
  }

  let rows = data ?? [];

  if (!id && q) {
    const { data: aliasRows } = await getSupabaseClient()
      .from("artists")
      .select("id,name,slug,stage_name,sort_name,status,primary_role,primary_genre,province,aliases")
      .contains("aliases", [q])
      .limit(limit);
    const byId = new Map(rows.map((artist) => [artist.id, artist]));
    for (const artist of aliasRows ?? []) byId.set(artist.id, artist);
    rows = [...byId.values()].slice(0, limit);
  }

  const artists = rows.map((artist) => ({
    ...artist,
    subtitle: [artist.primary_role, artist.primary_genre, artist.province, artist.stage_name]
      .filter(Boolean)
      .join(" · "),
  }));

  return NextResponse.json({ ok: true, artists });
}

export async function POST(request: Request) {
  const { artistId, artistData } = await request.json();

  if (!artistData?.name) {
    return NextResponse.json(
      { ok: false, error: "Artist name is required." },
      { status: 400 }
    );
  }

  const normalizedArtistData = {
    ...artistData,
    image_updated_at:
      artistData.has_image === true && !artistData.image_updated_at
        ? new Date().toISOString()
        : artistData.image_updated_at,
  };

  const supabase = getSupabaseClient();
  const previousSlugResponse = artistId
    ? await supabase
        .from("artists")
        .select("slug")
        .eq("id", artistId)
        .maybeSingle()
    : null;
  const response = artistId
    ? await supabase
        .from("artists")
        .update(normalizedArtistData)
        .eq("id", artistId)
        .select("id, slug")
        .maybeSingle()
    : await supabase.from("artists").insert([normalizedArtistData]).select("id, slug").maybeSingle();

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

  if (previousSlugResponse?.data?.slug && previousSlugResponse.data.slug !== response.data.slug) {
    revalidateArtistProfilePaths(previousSlugResponse.data.slug);
  }

  if (response.data.slug) {
    revalidateArtistProfilePaths(response.data.slug);
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
  const { data: artist, error: artistError } = await supabase
    .from("artists")
    .select("id,slug")
    .eq("id", artistId)
    .maybeSingle();

  if (artistError) {
    return NextResponse.json(
      { ok: false, error: artistError.message },
      { status: 500 },
    );
  }

  if (!artist) {
    return NextResponse.json(
      { ok: false, error: "Artist not found." },
      { status: 404 },
    );
  }

  const { error: imageError } = await supabase.storage
    .from("artists-images")
    .remove([`${artistId}.webp`]);

  if (imageError) {
    return NextResponse.json(
      {
        ok: false,
        error: `Artist image could not be deleted: ${imageError.message}`,
      },
      { status: 500 },
    );
  }

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

  if (artist.slug) {
    revalidateArtistProfilePaths(artist.slug);
  }

  return NextResponse.json({
    ok: true,
    id: artistId,
    imageCleanupCompleted: true,
  });
}
