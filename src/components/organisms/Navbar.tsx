'use client';

import Link from 'next/link';
import { usePathname, useRouter } from 'next/navigation';

export default function Navbar() {
  const pathname = usePathname();
  const router = useRouter();

  const navLinks = [
    { name: 'Home', href: '/' },
    { name: 'Artists', href: '/artists' },
    { name: 'Songs', href: '/archive' },
    { name: 'Christians', href: '/artists?tag=christian'},
  ];

  return (
    <nav
      className="fixed bottom-4 left-1/2 z-100 w-[calc(100%-2rem)] max-w-fit -translate-x-1/2 pb-[env(safe-area-inset-bottom)] sm:bottom-6"
    >
      <div className="flex items-center justify-center gap-3 rounded-full border border-black/5 bg-white/80 px-4 py-2.5 shadow-sm backdrop-blur-xl sm:gap-4 sm:px-5">
        
        {/* Back Button */}
        <button 
          onClick={() => router.back()}
          className="flex items-center justify-center w-6 h-6 rounded-full hover:bg-black/5 transition-colors group"
          aria-label="Go Back"
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
                {link.name}
              </Link>
            );
          })}
        </div>
      </div>
    </nav>
  );
}
