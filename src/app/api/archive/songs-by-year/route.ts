import { NextResponse } from "next/server";

import { getSongsByYear } from "@/lib/getSongsByYear";

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const yearParam = searchParams.get("year");
  const year = yearParam ? Number(yearParam) : NaN;

  if (!Number.isInteger(year) || year < 1800 || year > 2100) {
    return NextResponse.json(
      { ok: false, error: "A valid year is required.", songs: [] },
      { status: 400 }
    );
  }

  const songs = await getSongsByYear(year);

  return NextResponse.json({ ok: true, songs });
}
