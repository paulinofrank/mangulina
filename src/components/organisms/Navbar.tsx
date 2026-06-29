'use client';

import { Link, usePathname, useRouter } from "@/i18n/navigation";
import { useLocale, useTranslations } from 'next-intl';
import { type AppLocale } from "@/i18n/pathname";

export default function Navbar() {
  const pathname = usePathname();
  const router = useRouter();
  const locale = useLocale() as AppLocale;
  const t = useTranslations('navigation');
  const alternateLocale = locale === "en" ? "es" : "en";
  const alternateLanguageLabel = locale === "en" ? "Spanish" : "English";

  const navLinks = [
    { key: 'home', href: '/' },
    { key: 'discover', href: '/discover'},
  ];

  const handleLanguageSwitch = () => {
    const search = typeof window !== "undefined" ? window.location.search : "";
    const params = new URLSearchParams(search);
    const query = Object.fromEntries(params.entries());

    router.replace(
      Object.keys(query).length > 0 ? { pathname, query } : pathname,
      { locale: alternateLocale },
    );
  };

  return (
    <nav
      className="fixed bottom-4 left-1/2 z-100 w-[calc(100%-2rem)] max-w-fit -translate-x-1/2 pb-[env(safe-area-inset-bottom)] sm:bottom-6"
    >
      <div className="flex items-center justify-center gap-3 rounded-full border border-[#002D62]/10 bg-white/80 px-4 py-2.5 shadow-[0_4px_18px_rgba(0,45,98,0.22)] backdrop-blur-xl sm:gap-4 sm:px-5">

        {/* Back Button */}
        <button
          onClick={() => router.back()}
          className="group flex h-6 w-6 cursor-pointer items-center justify-center rounded-full transition-colors hover:bg-black/5"
          aria-label={t('goBack')}
        >
          <svg
            width="14"
            height="14"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
            className="text-gray-400 group-hover:text-[#CE1126] transition-colors"
          >
            <path d="M19 12H5M12 19l-7-7 7-7"/>
          </svg>
        </button>

        {/* Divider */}
        <div className="h-3 w-px bg-black/10" />

        {/* Navigation Links */}
        <div className="flex min-w-0 items-center gap-3 sm:gap-5">
          {navLinks.map((link) => {
            const isActive = pathname === link.href;
            return (
              <div key={link.href} className="contents">
                <Link
                  href={link.href}
                  className={`text-sm font-normal uppercase tracking-wider transition-colors ${
                    isActive ? 'text-[#CE1126]' : 'text-gray-700 hover:text-[#CE1126]'
                  }`}
                >
                  {t(link.key as any)}
                </Link>
                {link.key === 'home' && (
                  <span aria-hidden="true" className="text-sm text-gray-300">
                    |
                  </span>
                )}
              </div>
            );
          })}

          <span aria-hidden="true" className="text-sm text-gray-300">
            |
          </span>

          <button
            type="button"
            onClick={handleLanguageSwitch}
            className="cursor-pointer text-sm font-normal uppercase tracking-wider text-gray-700 transition-colors hover:text-[#CE1126]"
          >
            {alternateLanguageLabel}
          </button>
        </div>

        {/* Divider */}
        <div className="h-3 w-px bg-black/10" />

        {/* Back to Top Button */}
        <button
          type="button"
          onClick={() => window.scrollTo({ top: 0, behavior: 'smooth' })}
          className="group flex h-6 w-6 cursor-pointer items-center justify-center rounded-full transition-colors hover:bg-black/5"
          aria-label={t('goToTop')}
        >
          <svg
            width="14"
            height="14"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
            className="text-gray-400 transition-colors group-hover:text-[#CE1126]"
          >
            <path d="M12 19V5M5 12l7-7 7 7" />
          </svg>
        </button>
      </div>
    </nav>
  );
}
