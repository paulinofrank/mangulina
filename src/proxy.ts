import createMiddleware from "next-intl/middleware";
import { createServerClient } from "@supabase/auth-helpers-nextjs";
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";
import { canManageAdminAccess, hasAdminAccess } from "@/lib/adminAccess";
import { routing } from "@/i18n/routing";

const intlMiddleware = createMiddleware(routing);

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

async function handleAdmin(req: NextRequest) {
  const res = NextResponse.next();

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

  const isAdminPath =
    req.nextUrl.pathname === "/admin" || req.nextUrl.pathname.startsWith("/admin/");
  const isAdminApiPath =
    req.nextUrl.pathname === "/api/admin" ||
    req.nextUrl.pathname.startsWith("/api/admin/");
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

export async function proxy(req: NextRequest) {
  const pathname = req.nextUrl.pathname;

  const isAdminPath = pathname === "/admin" || pathname.startsWith("/admin/");
  const isAdminApiPath =
    pathname === "/api/admin" || pathname.startsWith("/api/admin/");
  const isApiPath = pathname === "/api" || pathname.startsWith("/api/");
  const isAuthPath = pathname === "/auth" || pathname.startsWith("/auth/");
  const isDebugPath = pathname === "/debug" || pathname.startsWith("/debug/");

  // Admin pages and admin APIs: authenticate. Never localized.
  if (isAdminPath || isAdminApiPath) {
    return handleAdmin(req);
  }

  // Public APIs, OAuth routes and the debug page: pass through untouched.
  // These are intentionally English-only (no /es equivalents).
  if (isApiPath || isAuthPath || isDebugPath) {
    return NextResponse.next();
  }

  // Everything else is a public, localized page. next-intl resolves the locale
  // from the URL (/es prefix → Spanish, otherwise English) and rewrites to the
  // [locale] segment internally.
  return intlMiddleware(req);
}

export const config = {
  matcher: [
    // Run on every path except Next internals and files with an extension
    // (sitemap.xml, robots.txt, icons, manifest, _next assets, etc.).
    "/((?!_next|_vercel|.*\\..*).*)",
    "/admin/:path*",
    "/api/admin/:path*",
  ],
};
