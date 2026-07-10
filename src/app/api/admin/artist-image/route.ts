import { NextResponse } from "next/server";
import { requireAdminApiRole } from "@/lib/adminApiAuth";
import { getSupabaseClient } from "@/lib/supabase";
import { revalidateArtistProfilePaths } from "@/lib/revalidateArtistProfile";

// Artist image metadata must be written server-side: the browser Supabase
// client is blocked by RLS on the artists table (the update matches zero
// rows and reports no error), while server routes use the service role.
export async function POST(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const { artistId, hasImage } = (await request.json()) as {
    artistId?: unknown;
    hasImage?: unknown;
  };

  if (typeof artistId !== "string" || !artistId.trim()) {
    return NextResponse.json(
      { ok: false, error: "Artist id is required." },
      { status: 400 },
    );
  }

  const nextHasImage = hasImage !== false;
  const imageUpdatedAt = new Date().toISOString();

  const { data: updatedArtist, error } = await getSupabaseClient()
    .from("artists")
    .update({ has_image: nextHasImage, image_updated_at: imageUpdatedAt })
    .eq("id", artistId)
    .select("id, slug, has_image, image_updated_at")
    .maybeSingle();

  if (error) {
    return NextResponse.json(
      { ok: false, error: error.message },
      { status: 500 },
    );
  }

  if (!updatedArtist) {
    return NextResponse.json(
      { ok: false, error: `No artist row was updated for id ${artistId}.` },
      { status: 404 },
    );
  }

  if (updatedArtist.slug) {
    revalidateArtistProfilePaths(updatedArtist.slug);
  }

  return NextResponse.json({
    ok: true,
    has_image: updatedArtist.has_image,
    image_updated_at: updatedArtist.image_updated_at,
  });
}
