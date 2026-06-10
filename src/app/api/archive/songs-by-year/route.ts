import { NextResponse } from "next/server";

import { getSongsByYear, getTopSongsByViews } from "@/lib/getSongsByYear";

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const yearParam = searchParams.get("year");
  const limitParam = Number(searchParams.get("limit") ?? 50);
  const offsetParam = Number(searchParams.get("offset") ?? 0);
  const sortParam = searchParams.get("sort") === "title" ? "title" : "views";

  if (!yearParam) {
    const songs = await getTopSongsByViews(100);
    return NextResponse.json({ ok: true, songs });
  }

  const year = yearParam ? Number(yearParam) : NaN;

  if (!Number.isInteger(year) || year < 1800 || year > 2100) {
    return NextResponse.json(
      { ok: false, error: "A valid year is required.", songs: [] },
      { status: 400 }
    );
  }

  const limit = Number.isInteger(limitParam) ? Math.min(Math.max(limitParam, 1), 100) : 50;
  const offset = Number.isInteger(offsetParam) ? Math.max(offsetParam, 0) : 0;
  const result = await getSongsByYear(year, {
    limit,
    offset,
    sort: sortParam,
  });

  return NextResponse.json({ ok: true, ...result });
}
