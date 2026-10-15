import { NextResponse } from "next/server";
import { getCachedGlobalSearch } from "@/lib/searchApi";
import {
  MAX_SEARCH_QUERY_LENGTH,
  MIN_SEARCH_QUERY_LENGTH,
} from "@/lib/searchTypes";

const EMPTY_RESULTS = { artists: [], songs: [], releases: [] };

export async function GET(request: Request) {
  const query = new URL(request.url).searchParams.get("q")?.trim() ?? "";

  if (query.length < MIN_SEARCH_QUERY_LENGTH) {
    return NextResponse.json({ ok: true, ...EMPTY_RESULTS });
  }

  if (query.length > MAX_SEARCH_QUERY_LENGTH) {
    return NextResponse.json(
      { ok: false, error: "Search query is too long." },
      { status: 400 },
    );
  }

  try {
    const results = await getCachedGlobalSearch(query);
    if (results.search?.outcome === "error" || results.search?.outcome === "degraded") {
      return NextResponse.json({ ok: results.search.outcome !== "error", ...results }, {
        status: results.search.outcome === "error" ? 503 : 200,
        headers: { "Cache-Control": "no-store" },
      });
    }
    return NextResponse.json(
      { ok: true, ...results },
      {
        headers: {
          "Cache-Control": "public, s-maxage=300, stale-while-revalidate=600",
        },
      },
    );
  } catch (error) {
    console.error("Search suggestions error:", error);
    return NextResponse.json(
      { ok: false, error: "Unable to load search suggestions." },
      { status: 500 },
    );
  }
}
