import createMiddleware from 'next-intl/middleware';

const locales = ['en', 'es'] as const;
const defaultLocale = 'en' as const;

export default createMiddleware({
  locales: [...locales],
  defaultLocale,
  localePrefix: 'as-needed',
});

export const config = {
  matcher: [
    '/((?!_next|_vercel|.*\\..*|api).*)',
    '/((?!api|_next/static|_next/image|favicon.ico).*)',
  ],
};
