import Image from "next/image";
import Link from "next/link";
import { Search } from "lucide-react";

export default function TopBanner() {
  return (
    <header className="fixed top-0 left-0 right-0 z-40 border-b border-black/10 bg-white/80 backdrop-blur-xl">
      <div className="mx-auto flex h-20 w-full max-w-7xl items-center justify-between gap-6 px-6 sm:px-10">
        <Link href="/" className="flex min-w-0 items-center gap-4 transition-opacity hover:opacity-90">
          <Image
            src="/icon0.svg"
            alt="Mangulina logo"
            width={44}
            height={44}
            className="h-11 w-11 shrink-0 object-contain"
            priority
          />
          <div className="min-w-0">
            <p className="truncate text-2xl font-semibold tracking-tight text-ink">Mangulina</p>
            <p className="truncate text-xs font-semibold uppercase tracking-[0.24em] text-wikicrimson/80">
              Dominican Music Database
            </p>
          </div>
        </Link>

        <div className="w-full max-w-sm">
          <label
            htmlFor="site-search"
            className="flex items-center gap-2 rounded-full border border-black/10 bg-white px-4 py-2 shadow-sm transition-shadow focus-within:shadow-md"
          >
            <Search className="h-4 w-4 text-black/50" />
            <input
              id="site-search"
              type="search"
              placeholder="Search artists, songs, genres..."
              className="w-full bg-transparent text-sm text-ink outline-none placeholder:text-black/45"
              aria-label="Search Mangulina"
            />
          </label>
        </div>
      </div>
    </header>
  );
}
