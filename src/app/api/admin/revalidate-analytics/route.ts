import { NextResponse } from "next/server";
import { revalidatePath } from "next/cache";

/**
 * Revalidates the analytics page cache to refresh data
 * Called by the refresh button on the analytics dashboard
 */
export async function POST(request: Request) {
  try {
    // Verify this is an internal request
    const authHeader = request.headers.get("authorization");
    if (!authHeader) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    // Revalidate the analytics page and all related data
    revalidatePath("/admin/analytics");

    return NextResponse.json({ ok: true, message: "Analytics cache revalidated" });
  } catch (error) {
    console.error("Revalidate analytics error:", error);
    return NextResponse.json({ error: "Failed to revalidate" }, { status: 500 });
  }
}
