import { createServerClient } from "@supabase/auth-helpers-nextjs";
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";
import { canManageAdminAccess, hasAdminAccess } from "@/lib/adminAccess";
import {
  getLocaleFromPathname,
  removeSpanishPrefix,
} from "@/i18n/pathname";

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
  const pathname = req.nextUrl.pathname;
  const locale = getLocaleFromPathname(pathname);

  // Check if this is an admin route
  const isAdminPath = pathname === "/admin" || pathname.startsWith("/admin/");
  const isAdminApiPath =
    pathname === "/api/admin" || pathname.startsWith("/api/admin/");
  const isApiPath = pathname === "/api" || pathname.startsWith("/api/");

  if (isApiPath && !isAdminApiPath) {
    return NextResponse.next();
  }

  // For non-admin routes, handle locale routing with next-intl
  if (!isAdminPath && !isAdminApiPath) {
    // Create headers with locale
    const requestHeaders = new Headers(req.headers);
    requestHeaders.set("x-locale", locale);

    // For Spanish locale paths, rewrite internally
    // /es/* → /* (Next.js can find the pages)
    // But preserve locale in headers for next-intl
    if (locale === "es") {
      const rewritePath = removeSpanishPrefix(pathname);

      // Admin and API routes are intentionally not localized.
      if (
        rewritePath === "/admin" ||
        rewritePath.startsWith("/admin/") ||
        rewritePath === "/api" ||
        rewritePath.startsWith("/api/")
      ) {
        return NextResponse.next();
      }

      const rewriteUrl = req.nextUrl.clone();
      rewriteUrl.pathname = rewritePath;

      return NextResponse.rewrite(rewriteUrl, {
        request: {
          headers: requestHeaders,
        },
      });
    }

    // For English (default), just pass through with locale header
    return NextResponse.next({
      request: {
        headers: requestHeaders,
      },
    });
  }

  // Admin route - perform authentication checks
  const requestHeaders = new Headers(req.headers);
  requestHeaders.set("x-locale", locale);
  const res = NextResponse.next({
    request: {
      headers: requestHeaders,
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
  matcher: [
    "/((?!_next|_vercel|.*\\..*).*)",
    "/admin/:path*",
    "/api/admin/:path*",
  ],
};
