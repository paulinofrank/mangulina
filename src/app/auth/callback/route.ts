import { NextResponse } from "next/server";
import { createServerSupabaseAuthClient, isAdminEmail } from "@/lib/auth";

const emailOtpTypes = new Set([
  "signup",
  "invite",
  "magiclink",
  "recovery",
  "email_change",
  "email",
]);

function sanitizeNextPath(value: string | null) {
  if (!value || !value.startsWith("/") || value.startsWith("//")) {
    return "/admin";
  }

  return value;
}

function redirectToLogin(requestUrl: URL, message?: string) {
  const loginUrl = new URL("/admin/login", requestUrl.origin);
  if (message) loginUrl.searchParams.set("message", message);
  return NextResponse.redirect(loginUrl);
}

export async function GET(request: Request) {
  const requestUrl = new URL(request.url);
  const code = requestUrl.searchParams.get("code");
  const tokenHash = requestUrl.searchParams.get("token_hash");
  const type = requestUrl.searchParams.get("type") || "magiclink";
  const nextPath = sanitizeNextPath(requestUrl.searchParams.get("next"));
  const supabase = await createServerSupabaseAuthClient();

  if (code) {
    const { error } = await supabase.auth.exchangeCodeForSession(code);

    if (error) {
      return redirectToLogin(requestUrl, error.message);
    }
  } else if (tokenHash && emailOtpTypes.has(type)) {
    const { error } = await supabase.auth.verifyOtp({
      token_hash: tokenHash,
      type,
    });

    if (error) {
      return redirectToLogin(requestUrl, error.message);
    }
  } else {
    return redirectToLogin(requestUrl, "Missing authentication token.");
  }

  const {
    data: { user },
  } = await supabase.auth.getUser();

  if (isAdminEmail(user?.email)) {
    return NextResponse.redirect(new URL(nextPath, requestUrl.origin));
  }

  return redirectToLogin(requestUrl, "This account is not allowed to access admin.");
}
