import createMiddleware from "next-intl/middleware";
import { createServerClient } from "@supabase/auth-helpers-nextjs";
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";
import { canManageAdminAccess, hasAdminAccess } from "@/lib/adminAccess";
import {
  LOCALE_COOKIE_MAX_AGE,
  LOCALE_COOKIE_NAME,
  routing,
  type AppLocale,
} from "@/i18n/routing";

const intlMiddleware = createMiddleware(routing);
const PUBLIC_COOKIE_OPTIONS = {
  maxAge: LOCALE_COOKIE_MAX_AGE,
  path: "/",
  sameSite: "lax" as const,
  secure: process.env.NODE_ENV === "production",
};

function getValidLocaleCookie(req: NextRequest): AppLocale | null {
  const value = req.cookies.get(LOCALE_COOKIE_NAME)?.value;
  return value === "en" || value === "es" ? value : null;
}

function getLocaleFromAcceptLanguage(req: NextRequest): AppLocale | null {
  const header = req.headers.get("accept-language");
  if (!header) return null;

  const match = header
    .split(",")
    .map((entry) => {
      const [tag = "", qValue] = entry.trim().split(";q=");
      const locale = tag.toLowerCase().split("-")[0];
      const quality = qValue ? Number.parseFloat(qValue) : 1;

      return {
        locale,
        quality: Number.isFinite(quality) ? quality : 0,
      };
    })
    .filter(({ locale }) => locale === "en" || locale === "es")
    .sort((left, right) => right.quality - left.quality)[0]?.locale;

  return match === "en" || match === "es" ? match : null;
}

function isSpanishPath(pathname: string) {
  return pathname === "/es" || pathname.startsWith("/es/");
}

function setLocaleCookie(res: NextResponse, locale: AppLocale) {
  res.cookies.set(LOCALE_COOKIE_NAME, locale, PUBLIC_COOKIE_OPTIONS);
}

function redirectToSpanish(req: NextRequest) {
  const url = req.nextUrl.clone();
  url.pathname = req.nextUrl.pathname === "/" ? "/es" : `/es${req.nextUrl.pathname}`;
  const res = NextResponse.redirect(url);
  setLocaleCookie(res, "es");
  return res;
}

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
  const localeCookie = getValidLocaleCookie(req);
  const browserLocale = localeCookie ?? getLocaleFromAcceptLanguage(req);
  const hasSpanishPrefix = isSpanishPath(pathname);

  if (browserLocale === "es" && !hasSpanishPrefix) {
    return redirectToSpanish(req);
  }

  const res = intlMiddleware(req);

  if (hasSpanishPrefix) {
    setLocaleCookie(res, "es");
  } else if (!localeCookie && browserLocale) {
    setLocaleCookie(res, browserLocale);
  }

  return res;
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
