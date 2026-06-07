import { createServerClient } from "@supabase/auth-helpers-nextjs";
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";
import { canManageAdminAccess, hasAdminAccess } from "@/lib/adminAccess";

function getRequiredSupabaseConfig() {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL;
  const supabaseAnonKey =
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY;

  if (!supabaseUrl || !supabaseAnonKey) {
    throw new Error("Missing Supabase URL or anon key for authentication.");
  }

  return { supabaseUrl, supabaseAnonKey };
}

function redirectToLogin(req: NextRequest) {
  const url = req.nextUrl.clone();
  const nextPath = `${req.nextUrl.pathname}${req.nextUrl.search}`;

  url.pathname = "/admin/login";
  url.search = "";
  if (nextPath !== "/admin/login") {
    url.searchParams.set("next", nextPath);
  }

  return NextResponse.redirect(url);
}

function sanitizeNextPath(value: string | null) {
  if (!value || !value.startsWith("/") || value.startsWith("//")) {
    return "/admin";
  }

  return value;
}

export async function proxy(req: NextRequest) {
  const res = NextResponse.next({
    request: {
      headers: req.headers,
    },
  });

  const { supabaseUrl, supabaseAnonKey } = getRequiredSupabaseConfig();
  const supabase = createServerClient(supabaseUrl, supabaseAnonKey, {
    cookies: {
      getAll() {
        return req.cookies.getAll();
      },
      setAll(cookiesToSet) {
        cookiesToSet.forEach(({ name, value }) => req.cookies.set(name, value));
        cookiesToSet.forEach(({ name, value, options }) => {
          res.cookies.set(name, value, options);
        });
      },
    },
  });

  const {
    data: { user },
  } = await supabase.auth.getUser();

  const isAdminPath = req.nextUrl.pathname.startsWith("/admin");
  const isAdminApiPath = req.nextUrl.pathname.startsWith("/api/admin");
  const isAccessManagementPath =
    req.nextUrl.pathname === "/admin/invites" ||
    req.nextUrl.pathname.startsWith("/api/admin/invites");
  const isAuthPage =
    req.nextUrl.pathname === "/admin/login" ||
    req.nextUrl.pathname === "/admin/sign-up";
  const userHasAdminAccess = await hasAdminAccess(user);
  const userCanManageAccess = isAccessManagementPath
    ? await canManageAdminAccess(user)
    : false;

  if (isAuthPage) {
    if (userHasAdminAccess) {
      const url = req.nextUrl.clone();
      url.pathname = sanitizeNextPath(req.nextUrl.searchParams.get("next"));
      url.search = "";
      return NextResponse.redirect(url);
    }

    return res;
  }

  if (isAdminPath && !userHasAdminAccess) {
    return redirectToLogin(req);
  }

  if (isAdminApiPath && !userHasAdminAccess) {
    return NextResponse.json(
      { ok: false, error: "Authentication required." },
      { status: 401 },
    );
  }

  if (isAccessManagementPath && !userCanManageAccess) {
    if (isAdminApiPath) {
      return NextResponse.json(
        { ok: false, error: "Access management permission required." },
        { status: 403 },
      );
    }

    const url = req.nextUrl.clone();
    url.pathname = "/admin";
    url.search = "";
    return NextResponse.redirect(url);
  }

  return res;
}

export const config = {
  matcher: ["/admin/:path*", "/api/admin/:path*"],
};
