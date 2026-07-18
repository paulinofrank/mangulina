import { NextResponse } from "next/server";
import { requireAdminApiRole } from "@/lib/adminApiAuth";
import { getSupabaseClient } from "@/lib/supabase";

const FIELDS = "id,genre_id,media_type,title,url,platform,external_id,thumbnail_url,published_date,youtube_channel_id,youtube_channel_name,youtube_channel_url,youtube_channel_avatar_url,youtube_metadata_fetched_at,is_official,is_featured,display_order,notes";

export async function GET(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;
  const genreId = new URL(request.url).searchParams.get("genreId");
  if (!genreId) return NextResponse.json({ ok: false, error: "Genre id is required." }, { status: 400 });
  const { data, error } = await getSupabaseClient()
    .from("genre_media").select(FIELDS).eq("genre_id", genreId)
    .order("is_featured", { ascending: false }).order("display_order").order("created_at");
  if (error) return NextResponse.json({ ok: false, error: error.message }, { status: 500 });
  return NextResponse.json({ ok: true, media: data ?? [] });
}

export async function POST(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;
  const { mediaId, mediaData } = await request.json();
  if (!mediaData?.genre_id || !mediaData?.title?.trim() || !mediaData?.url?.trim()) {
    return NextResponse.json({ ok: false, error: "Genre, title, and URL are required." }, { status: 400 });
  }
  const payload = { ...mediaData, title: mediaData.title.trim(), url: mediaData.url.trim(), updated_at: new Date().toISOString() };
  const query = mediaId
    ? getSupabaseClient().from("genre_media").update(payload).eq("id", mediaId).eq("genre_id", mediaData.genre_id)
    : getSupabaseClient().from("genre_media").insert(payload);
  const { data, error } = await query.select("id").maybeSingle();
  if (error) return NextResponse.json({ ok: false, error: error.message }, { status: 500 });
  return NextResponse.json({ ok: true, id: data?.id });
}

export async function DELETE(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;
  const { mediaId, genreId } = await request.json();
  if (!mediaId || !genreId) return NextResponse.json({ ok: false, error: "Media and genre ids are required." }, { status: 400 });
  const { error } = await getSupabaseClient().from("genre_media").delete().eq("id", mediaId).eq("genre_id", genreId);
  if (error) return NextResponse.json({ ok: false, error: error.message }, { status: 500 });
  return NextResponse.json({ ok: true });
}
