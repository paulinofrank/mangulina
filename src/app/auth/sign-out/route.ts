import { NextResponse } from "next/server";
import { createServerSupabaseAuthClient } from "@/lib/auth";

export async function POST(request: Request) {
  const supabase = await createServerSupabaseAuthClient();
  await supabase.auth.signOut();

  return NextResponse.redirect(new URL("/admin/login", request.url), {
    status: 303,
  });
}
