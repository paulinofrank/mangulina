'use client';

import Link from 'next/link';
import Image from 'next/image';
import { usePathname, useRouter } from 'next/navigation';
import { useEffect, useState, useRef } from 'react';

export default function Navbar() {
  const pathname = usePathname();
  const router = useRouter();
  const [isFooterVisible, setIsFooterVisible] = useState(false);
  const navRef = useRef<HTMLElement>(null);

  const navLinks = [
    { name: 'Recordings', href: '/recordings' },
    { name: 'Artists', href: '/artists' },
    { name: 'Archive', href: '/archive' },
  ];

  useEffect(() => {
    const footerContainer = document.querySelector('footer > div.mx-auto');
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
      className={`fixed bottom-8 left-1/2 -translate-x-1/2 z-100 w-fit transition-all duration-200 ${
        isFooterVisible ? 'navbar-lifted' : ''
      }`}
    >
      {/* 
          Lighter transparency allows the gradient background to shine through
          while maintaining readability with backdrop-blur
      */}
      <div className="flex items-center gap-6 px-6 py-4 bg-white/20 backdrop-blur-2xl border border-white/30 rounded-full shadow-lg">
        
        {/* Back Button */}
        <button 
          onClick={() => router.back()}
          className="flex items-center justify-center w-8 h-8 rounded-full hover:bg-white/20 transition-colors group"
          aria-label="Go Back"
        >
          <svg 
            width="20" 
            height="20" 
            viewBox="0 0 24 24" 
            fill="none" 
            stroke="currentColor" 
            strokeWidth="2.5" 
            strokeLinecap="round" 
            strokeLinejoin="round" 
            className="text-black/60 group-hover:text-wikicrimson transition-colors"
          >
            <path d="M19 12H5M12 19l-7-7 7-7"/>
          </svg>
        </button>

        {/* Logo - icon0.svg */}
        <Link href="/" className="pr-6 border-r border-white/30 flex items-center">
          <Image 
            src="/icon0.svg" 
            alt="Mangulina Logo" 
            width={28} 
            height={28} 
            className="w-7 h-7 object-contain"
            priority 
          />
        </Link>

        {/* Navigation Links */}
        <div className="flex gap-8">
          {navLinks.map((link) => {
            const isActive = pathname === link.href;
            return (
              <Link
                key={link.href}
                href={link.href}
                className={`text-[10px] font-bold uppercase tracking-[0.3em] transition-all duration-300 ${
                  isActive ? 'text-wikicrimson' : 'text-black/60 hover:text-wikicrimson'
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