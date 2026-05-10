'use client';

import Link from 'next/link';
import { usePathname, useRouter } from 'next/navigation';
import { useEffect, useState, useRef } from 'react';

export default function Navbar() {
  const pathname = usePathname();
  const router = useRouter();
  const [isFooterVisible, setIsFooterVisible] = useState(false);
  const navRef = useRef<HTMLElement>(null);

  const navLinks = [
    { name: 'Home', href: '/' },
    { name: 'Artists', href: '/artists' },
    { name: 'Songs', href: '/recordings' },
    { name: 'Christians', href: '/genres/christian' }, // Placeholder for your future page
  ];

  useEffect(() => {
    // Updated selector to match your new Footer container structure
    const footerContainer = document.querySelector('footer > div');
    if (!footerContainer) return;

    const observer = new IntersectionObserver(
      ([entry]) => {
        setIsFooterVisible(entry.isIntersecting);
      },
      {
        threshold: 0.05,
        rootMargin: '0px',
      }
    );

    observer.observe(footerContainer);

    return () => observer.disconnect();
  }, []);

  return (
    <nav 
      ref={navRef}
      className={`fixed bottom-8 left-1/2 -translate-x-1/2 z-100 w-fit transition-all duration-300 ${
        isFooterVisible ? 'navbar-lifted' : ''
      }`}
    >
      <div className="flex items-center gap-6 px-7 py-4 bg-white/40 backdrop-blur-3xl border border-white/40 rounded-full shadow-xl">
        
        {/* Back Button */}
        <button 
          onClick={() => router.back()}
          className="flex items-center justify-center w-8 h-8 rounded-full hover:bg-black/5 transition-colors group"
          aria-label="Go Back"
        >
          <svg 
            width="18" 
            height="18" 
            viewBox="0 0 24 24" 
            fill="none" 
            stroke="currentColor" 
            strokeWidth="3" 
            strokeLinecap="round" 
            strokeLinejoin="round" 
            className="text-black/70 group-hover:text-[#CE1126] transition-colors"
          >
            <path d="M19 12H5M12 19l-7-7 7-7"/>
          </svg>
        </button>

        {/* Darker Divider */}
        <div className="h-4 w-px bg-black/30" />

        {/* Navigation Links */}
        <div className="flex gap-8 pr-2">
          {navLinks.map((link) => {
            const isActive = pathname === link.href;
            return (
              <Link
                key={link.href}
                href={link.href}
                className={`text-[10px] font-extrabold uppercase tracking-[0.25em] transition-all duration-300 ${
                  isActive ? 'text-[#CE1126]' : 'text-black/70 hover:text-[#CE1126]'
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