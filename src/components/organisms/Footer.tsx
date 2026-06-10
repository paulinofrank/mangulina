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
    <footer className="mt-12 border-t border-black/10 bg-white/50">
      <div className="mx-4 pt-10 pb-28 sm:mx-8 sm:py-10 lg:mx-12">
        <div className="flex flex-col gap-6">

          {/* Social Icons */}
          <div className="flex items-center gap-3">
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
          <div className="flex flex-wrap gap-x-6 gap-y-2 text-base font-normal text-gray-600">
            <Link href="/about" className="hover:text-[#002D62] transition-colors">About</Link>
            <Link href="/contact" className="hover:text-[#002D62] transition-colors">Contact</Link>
            <Link href="/dmca" className="hover:text-[#002D62] transition-colors">Copyrights & DMCA</Link>
          </div>

          {/* Bottom Bar */}
          <div className="flex items-center justify-between border-t border-black/10 pt-6">
            <div className="flex items-center gap-2">
              <Image src="/icon.svg" alt="logo" width={28} height={28} />
              <span className="text-lg font-medium tracking-tight text-[#002D62]">Mangulina<span className="tm-fix">&trade;</span></span>
            </div>
            <p className="text-sm text-gray-600">
              &copy; All Rights Reserved 2026
            </p>
          </div>
        </div>
      </div>
    </footer>
  );
}
