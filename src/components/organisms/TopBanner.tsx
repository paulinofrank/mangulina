"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import Image from "next/image";
import Link from "next/link";
import { Search } from "lucide-react";

export default function TopBanner() {
  const [searchTerm, setSearchTerm] = useState("");
  const router = useRouter();

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (!searchTerm.trim()) return;
    router.push(`/search?q=${encodeURIComponent(searchTerm.trim())}`);
  };

  return (
    <header className="fixed top-0 left-0 right-0 z-40 border-b border-black/5 bg-white/80 backdrop-blur-xl">
      <div className="mx-4 sm:mx-8 lg:mx-12 flex h-14 items-center justify-between gap-3">
        
        {/* Logo */}
        <Link 
          href="/" 
          className="flex shrink-0 items-center gap-2.5 transition-opacity hover:opacity-90 min-w-0"
        >
          <Image
            src="/icon.svg"
            alt="Mangulina logo"
            width={36} 
            height={36}
            className="h-8 w-8 shrink-0 object-contain"
            priority
          />
          <div className="min-w-0 flex flex-col justify-center">
            <p className="truncate text-2xl sm:text-3xl font-medium tracking-tight text-[#002D62] leading-tight">
              Mangulina<span className="tm-fix">&trade;</span>
            </p>
            <p className="hidden sm:block truncate text-xs font-normal uppercase tracking-wider text-[#8B0000]">
              Dominican Music Database
            </p>
          </div>
        </Link>

        {/* Search Bar */}
        <form 
          onSubmit={handleSearch}
          className="flex flex-1 justify-end max-w-48 xs:max-w-[220px] sm:max-w-sm"
        >
          <label
            htmlFor="site-search"
            className="flex w-full items-center gap-2 rounded-full border border-[#8B0000]/15 bg-white px-3 py-1.5 shadow-[0_0_8px_rgba(139,0,0,0.08)] transition-all focus-within:border-[#8B0000]/30 focus-within:shadow-[0_0_12px_rgba(139,0,0,0.15)]"
          >
            <Search className="h-4 w-4 shrink-0 text-[#8B0000]/50" />
            <input
              id="site-search"
              type="search"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              placeholder="Search artists, songs..."
              className="w-full min-w-0 bg-transparent text-sm text-[#002D62] outline-none placeholder:text-gray-500"
            />
          </label>
        </form>
      </div>
    </header>
  );
}
