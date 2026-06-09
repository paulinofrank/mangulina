import { NextResponse } from "next/server";

import { getArchiveDecadeCounts } from "@/lib/getSongsByYear";

export async function GET() {
  const decadeCounts = await getArchiveDecadeCounts();

  return NextResponse.json({ ok: true, decadeCounts });
}
