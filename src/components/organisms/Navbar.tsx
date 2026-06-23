'use client';

import { Link, usePathname, useRouter } from "@/i18n/navigation";
import { useTranslations } from 'next-intl';

export default function Navbar() {
  const pathname = usePathname();
  const router = useRouter();
  const t = useTranslations('navigation');

  const navLinks = [
    { key: 'home', href: '/' },
    { key: 'singers', href: '/artists' },
    { key: 'christian', href: '/christian' },
    { key: 'discover', href: '/discover'},
  ];

  return (
    <nav
      className="fixed bottom-4 left-1/2 z-100 w-[calc(100%-2rem)] max-w-fit -translate-x-1/2 pb-[env(safe-area-inset-bottom)] sm:bottom-6"
    >
      <div className="flex items-center justify-center gap-3 rounded-full border border-[#002D62]/10 bg-white/80 px-4 py-2.5 shadow-[0_4px_18px_rgba(0,45,98,0.22)] backdrop-blur-xl sm:gap-4 sm:px-5">

        {/* Back Button */}
        <button
          onClick={() => router.back()}
          className="flex items-center justify-center w-6 h-6 rounded-full hover:bg-black/5 transition-colors group"
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
        <div className="flex min-w-0 gap-3 sm:gap-5">
          {navLinks.map((link) => {
            const isActive = pathname === link.href;
            return (
              <Link
                key={link.href}
                href={link.href}
                className={`text-sm font-normal uppercase tracking-wider transition-colors ${
                  isActive ? 'text-[#CE1126]' : 'text-gray-700 hover:text-[#CE1126]'
                }`}
              >
                {t(link.key as any)}
              </Link>
            );
          })}
        </div>

        {/* Divider */}
        <div className="h-3 w-px bg-black/10" />

        {/* Back to Top Button */}
        <button
          type="button"
          onClick={() => window.scrollTo({ top: 0, behavior: 'smooth' })}
          className="group flex h-6 w-6 items-center justify-center rounded-full transition-colors hover:bg-black/5"
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
