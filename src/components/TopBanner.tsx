"use client";

import Image from "next/image";
import Link from "next/link";
import { Search } from "lucide-react";

export default function TopBanner() {
  return (
    <header className="fixed top-0 left-0 right-0 z-40 border-b border-black/10 bg-white/80 backdrop-blur-xl">
      {/* FIXED: Removed mx-auto and max-w-7xl.
          ADDED: mx-6 sm:mx-12 to match the Genre and Footer horizontal alignment.
      */}
      <div className="mx-6 sm:mx-12 flex h-20 items-center justify-between gap-3">
        
        {/* Logo & Slogan Section */}
        <Link 
          href="/" 
          className="flex shrink-0 items-center gap-3 transition-opacity hover:opacity-90 min-w-0"
        >
          <Image
            src="/icon0.svg"
            alt="Mangulina logo"
            width={44} 
            height={44}
            style={{ height: 'auto' }}
            className="h-10 w-10 shrink-0 object-contain sm:h-11 sm:w-11"
            priority
          />
          <div className="min-w-0 flex flex-col justify-center">
            <p className="truncate text-xl font-bold tracking-tight text-[#002D62] sm:text-2xl leading-tight">
              Mangulina&trade;
            </p>
            <p className="block truncate text-[9px] font-bold uppercase tracking-[0.12em] text-[#8B0000]/80 sm:text-xs sm:tracking-[0.24em]">
              Dominican Music Database
            </p>
          </div>
        </Link>

        {/* Search Bar Section */}
        <div className="flex flex-1 justify-end max-w-40 xs:max-w-[220px] sm:max-w-sm">
          <label
            htmlFor="site-search"
            className="flex w-full items-center gap-2 rounded-full border border-[#8B0000]/20 bg-white px-3 py-1.5 shadow-[0_0_10px_rgba(139,0,0,0.1)] transition-all focus-within:border-[#8B0000]/40 focus-within:shadow-[0_0_12px_rgba(139,0,0,0.2)] sm:px-4 sm:py-2"
          >
            <Search className="h-4 w-4 shrink-0 text-[#8B0000]/50" />
            <input
              id="site-search"
              type="search"
              placeholder="Search artists, songs.."
              className="w-full min-w-0 bg-transparent text-sm text-[#002D62] outline-none placeholder:text-black/45"
              aria-label="Search Mangulina"
            />
          </label>
        </div>
      </div>
    </header>
  );
}