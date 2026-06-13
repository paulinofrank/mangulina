import { NextResponse } from "next/server";

import { getSongsBySubgenre } from "@/lib/getSongsBySubgenre";

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const genreId = Number(searchParams.get("genreId"));
  const subgenreId = Number(searchParams.get("subgenreId"));
  const limit = Number(searchParams.get("limit") ?? 25);
  const offset = Number(searchParams.get("offset") ?? 0);
  const sort = searchParams.get("sort") === "title" ? "title" : "views";

  if (!Number.isInteger(genreId) || !Number.isInteger(subgenreId)) {
    return NextResponse.json(
      { ok: false, error: "Valid genre and subgenre IDs are required.", songs: [] },
      { status: 400 },
    );
  }

  try {
    const result = await getSongsBySubgenre(genreId, subgenreId, { limit, offset, sort });

    if (!result) {
      return NextResponse.json(
        { ok: false, error: "Subgenre not found.", songs: [] },
        { status: 404 },
      );
    }

    return NextResponse.json({ ok: true, ...result });
  } catch (error: unknown) {
    console.error("Subgenre songs query failed", error);
    return NextResponse.json(
      { ok: false, error: "Unable to load songs for this subgenre.", songs: [] },
      { status: 500 },
    );
  }
}
