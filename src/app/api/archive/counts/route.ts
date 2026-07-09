import { NextResponse } from "next/server";

import { parseArchivePeriod } from "@/lib/archivePeriods";
import { getArchiveCounts, getArchiveCountsForYearRange } from "@/lib/getSongsByYear";

export async function GET(request: Request) {
  const { searchParams } = new URL(request.url);
  const decadeParam = searchParams.get("decade");
  const decadePeriod = decadeParam ? parseArchivePeriod(decadeParam) : null;
  const counts =
    decadePeriod?.type === "decade"
      ? await getArchiveCountsForYearRange(decadePeriod.startYear, decadePeriod.endYear)
      : await getArchiveCounts();

  return NextResponse.json(
    { ok: true, ...counts },
    { headers: { "Cache-Control": "no-store" } },
  );
}
