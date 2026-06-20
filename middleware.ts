import { NextRequest, NextResponse } from 'next/server';

export const locales = ['en', 'es'] as const;
export const defaultLocale = 'en' as const;

export function middleware(request: NextRequest) {
  const pathname = request.nextUrl.pathname;

  // Check if pathname already has locale prefix
  const hasLocalePrefix = locales.some((locale) => pathname.startsWith(`/${locale}`));

  // Determine locale from pathname
  let locale: typeof locales[number] = defaultLocale;
  if (pathname.startsWith('/es')) {
    locale = 'es';
  }

  // Add locale to headers for consumption in layout and components
  const requestHeaders = new Headers(request.headers);
  requestHeaders.set('x-locale', locale);

  // If no locale prefix exists and locale is not default, redirect with prefix
  if (!hasLocalePrefix && locale !== defaultLocale) {
    const url = request.nextUrl.clone();
    url.pathname = `/${locale}${pathname}`;
    return NextResponse.redirect(url);
  }

  return NextResponse.next({
    request: {
      headers: requestHeaders,
    },
  });
}

export const config = {
  matcher: [
    '/((?!_next|_vercel|.*\\..*|api).*)',
    '/((?!api|_next/static|_next/image|favicon.ico).*)',
  ],
};
