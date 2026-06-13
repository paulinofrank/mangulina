import { createClient } from "@supabase/supabase-js";

export async function GET(req: Request) {
  try {
    const { searchParams } = new URL(req.url);
    const offset = Number(searchParams.get("offset") ?? 0);

    const sb = createClient(
      process.env.SUPABASE_URL!,
      process.env.SUPABASE_SERVICE_ROLE_KEY!
    );

    // Test Supabase connection
    const { data: test, error: testError } = await sb.from("recording_platform_links").select("id").limit(1);

    if (testError) {
      return Response.json({ error: "Supabase error", details: testError.message }, { status: 500 });
    }

    return Response.json({
      ok: true,
      message: "Supabase connection OK",
      offset,
      testRow: test
    });

  } catch (err: any) {
    return Response.json({
      error: "Unhandled exception",
      message: err.message,
      stack: err.stack
    }, { status: 500 });
  }
}
