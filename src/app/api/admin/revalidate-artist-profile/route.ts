import { NextResponse } from "next/server";
import { requireAdminApiRole } from "@/lib/adminApiAuth";
import { revalidateArtistProfilePaths } from "@/lib/revalidateArtistProfile";

export async function POST(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  const { slug } = (await request.json()) as { slug?: unknown };
  const normalizedSlug = typeof slug === "string" ? slug.trim() : "";

  if (!normalizedSlug) {
    return NextResponse.json(
      { ok: false, error: "Artist slug is required." },
      { status: 400 },
    );
  }

  revalidateArtistProfilePaths(normalizedSlug);

  return NextResponse.json({ ok: true });
}
