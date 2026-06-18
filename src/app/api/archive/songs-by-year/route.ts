import { NextResponse } from "next/server";

import { getSongsByYear, getSongsByYearRange, getTopSongsByViews } from "@/lib/getSongsByYear";

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const yearParam = searchParams.get("year");
  const startYearParam = searchParams.get("startYear");
  const endYearParam = searchParams.get("endYear");
  const limitParam = Number(searchParams.get("limit") ?? 50);
  const offsetParam = Number(searchParams.get("offset") ?? 0);
  const sortParam: "title" | "views" = searchParams.get("sort") === "title" ? "title" : "views";

  const limit = Number.isInteger(limitParam) ? Math.min(Math.max(limitParam, 1), 100) : 50;
  const offset = Number.isInteger(offsetParam) ? Math.max(offsetParam, 0) : 0;
  const options = {
    limit,
    offset,
    sort: sortParam,
  };

  if (!yearParam && (!startYearParam || !endYearParam)) {
    const songs = await getTopSongsByViews(limit);
    return NextResponse.json({ ok: true, songs, total: songs.length, hasMore: false });
  }

  const year = yearParam ? Number(yearParam) : NaN;
  const startYear = startYearParam ? Number(startYearParam) : NaN;
  const endYear = endYearParam ? Number(endYearParam) : NaN;

  if (yearParam && (!Number.isInteger(year) || year < 1800 || year > 2100)) {
    return NextResponse.json(
      { ok: false, error: "A valid year is required.", songs: [] },
      { status: 400 }
    );
  }

  if (
    !yearParam &&
    (!Number.isInteger(startYear) ||
      !Number.isInteger(endYear) ||
      startYear < 1800 ||
      endYear > 2100 ||
      startYear > endYear)
  ) {
    return NextResponse.json(
      { ok: false, error: "A valid year range is required.", songs: [] },
      { status: 400 }
    );
  }

  const result = yearParam
    ? await getSongsByYear(year, options)
    : await getSongsByYearRange(startYear, endYear, options);

  return NextResponse.json({ ok: true, ...result });
}
