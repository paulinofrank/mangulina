"use client";

import Image from "next/image";
import Link from "next/link";
import { FaFacebook, FaInstagram, FaYoutube, FaTiktok } from "react-icons/fa6";

const SOCIAL_LINKS = [
  { icon: FaFacebook,  label: "Facebook",  href: "https://facebook.com/MangulinaDo" },
  { icon: FaInstagram, label: "Instagram", href: "https://instagram.com/MangulinaDo" },
  { icon: FaYoutube,   label: "YouTube",   href: "https://youtube.com/@MangulinaDo" },
  { icon: FaTiktok,    label: "TikTok",    href: "https://tiktok.com/@MangulinaDo" },
];

export default function Footer() {
  return (
    <footer className="mt-2 border-t border-black/10 bg-white/50">
      <div className="mx-5 pb-32 pt-8 sm:mx-8 sm:pb-28 sm:pt-10 lg:mx-12">
        <div className="flex flex-col gap-7 sm:gap-6">

          {/* Social Icons */}
          <div className="flex items-center justify-center gap-3">
            {SOCIAL_LINKS.map(({ icon: Icon, label, href }) => (
              <a
                key={label}
                href={href}
                target="_blank"
                rel="noopener noreferrer"
                aria-label={label}
                className="flex h-10 w-10 items-center justify-center rounded-full border border-black/10 bg-white/70 text-gray-600 transition-colors hover:text-[#002D62] hover:border-black/20"
              >
                <Icon className="h-5 w-5" />
              </a>
            ))}
          </div>

          {/* Navigation */}
          <nav aria-label="Footer navigation" className="text-sm font-normal text-gray-600 sm:text-base">
            <div className="grid grid-cols-2 gap-x-6 sm:hidden">
              <div className="flex flex-col gap-3 pl-[5ch]">
                <Link href="/about" className="transition-colors hover:text-[#002D62]">About</Link>
                <Link href="/contact" className="transition-colors hover:text-[#002D62]">Contact</Link>
                <Link href="/contributors" className="transition-colors hover:text-[#002D62]">Contributors</Link>
              </div>
              <div className="flex flex-col gap-3">
                <Link href="/terms-of-use" className="transition-colors hover:text-[#002D62]">Terms of Use</Link>
                <Link href="/privacy-policy" className="transition-colors hover:text-[#002D62]">Privacy Policy</Link>
                <Link href="/dmca" className="transition-colors hover:text-[#002D62]">Copyrights & DMCA</Link>
              </div>
            </div>

            <div className="mt-5 flex justify-center sm:hidden">
              <Link
                href="/discover"
                className="inline-flex items-center gap-2 text-[1.2em] font-medium text-[#002D62] transition-colors hover:text-[#8B0000]"
              >
                <span aria-hidden="true" className="text-[#8B0000]">✦</span>
                Discover
                <span aria-hidden="true" className="text-[#8B0000]">✦</span>
              </Link>
            </div>

            <div className="hidden flex-wrap justify-center gap-x-6 gap-y-2 sm:flex">
              <Link href="/discover" className="transition-colors hover:text-[#002D62]">Discover</Link>
              <Link href="/about" className="transition-colors hover:text-[#002D62]">About</Link>
              <Link href="/contact" className="transition-colors hover:text-[#002D62]">Contact</Link>
              <Link href="/contributors" className="transition-colors hover:text-[#002D62]">Contributors</Link>
              <Link href="/privacy-policy" className="transition-colors hover:text-[#002D62]">Privacy Policy</Link>
              <Link href="/terms-of-use" className="transition-colors hover:text-[#002D62]">Terms of Use</Link>
              <Link href="/dmca" className="transition-colors hover:text-[#002D62]">Copyrights & DMCA</Link>
            </div>
          </nav>

          {/* Bottom Bar */}
          <div className="flex flex-col items-center gap-0 border-t border-black/10 pt-6 text-center">
            <div className="flex flex-col items-center gap-0">
              <div className="flex items-center gap-2">
                <Image src="/icon.svg" alt="Mangulina logo" width={28} height={28} />
                <span className="text-lg font-medium tracking-tight text-[#002D62]">
                  Mangulina<span className="tm-fix">&trade;</span>
                </span>
              </div>
              <span className="max-w-56 text-sm leading-relaxed text-gray-600 sm:max-w-none">
                The Dominican Music Database
              </span>
            </div>
            <p className="text-sm leading-relaxed text-gray-600">
              &copy; 2026 Mangulina. All Rights Reserved.
            </p>
          </div>
        </div>
      </div>
    </footer>
  );
}
