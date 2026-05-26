'use client';

import Link from 'next/link';
import { usePathname, useRouter } from 'next/navigation';
import { useEffect, useState, useRef } from 'react';

export default function Navbar() {
  const pathname = usePathname();
  const router = useRouter();
  const [isFooterVisible, setIsFooterVisible] = useState(false);
  const [footerHeight, setFooterHeight] = useState(0);
  const navRef = useRef<HTMLElement>(null);

  const navLinks = [
    { name: 'Home', href: '/' },
    { name: 'Artists', href: '/artists' },
    { name: 'Songs', href: '/archive' },
    { name: 'Christians', href: '/artists?tag=christian'},
  ];

  useEffect(() => {
    const footer = document.querySelector('footer');
    if (!footer) return;

    // Get footer height for positioning
    const updateFooterHeight = () => {
      setFooterHeight(footer.offsetHeight);
    };
    updateFooterHeight();
    window.addEventListener('resize', updateFooterHeight);

    const observer = new IntersectionObserver(
      ([entry]) => {
        // Trigger when footer top edge enters viewport
        setIsFooterVisible(entry.isIntersecting);
      },
      {
        threshold: 0,
        rootMargin: '0px 0px 0px 0px',
      }
    );

    observer.observe(footer);

    return () => {
      observer.disconnect();
      window.removeEventListener('resize', updateFooterHeight);
    };
  }, []);

  return (
    <nav 
      ref={navRef}
      style={isFooterVisible ? { bottom: `${footerHeight + 16}px` } : undefined}
      className={`fixed left-1/2 -translate-x-1/2 z-100 w-fit transition-all duration-300 ${
        isFooterVisible ? '' : 'bottom-8'
      }`}
    >
      <div className="flex items-center gap-4 px-5 py-2.5 bg-white/70 backdrop-blur-xl border border-black/5 rounded-full shadow-sm">
        
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
        <div className="flex gap-5">
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
