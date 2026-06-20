import { NextResponse } from "next/server";
import { revalidatePath } from "next/cache";

/**
 * Revalidates the analytics page cache to refresh data
 * Called by the refresh button on the analytics dashboard
 * No auth required - runs on client refresh, returns 200 regardless
 */
export async function POST(request: Request) {
  try {
    // Revalidate the analytics page and all related data
    revalidatePath("/admin/analytics", "page");

    return NextResponse.json({ ok: true, message: "Analytics cache revalidated" });
  } catch (error) {
    console.error("Revalidate analytics error:", error);
    // Return 200 anyway - analytics should never block user
    return NextResponse.json({ ok: false }, { status: 200 });
  }
}
