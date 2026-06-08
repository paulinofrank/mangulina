"use client";

import Image from "next/image";
import Link from "next/link";
import { Globe, Music2, Radio, Star } from "lucide-react";

export default function Footer() {
  return (
    <footer className="mt-12 border-t border-black/10 bg-white/50">
      <div className="mx-4 sm:mx-8 lg:mx-12 py-10">
        <div className="flex flex-col gap-6">
          
          {/* Social Icons */}
          <div className="flex items-center gap-3">
            {[
              { icon: Star, label: "IG" },
              { icon: Radio, label: "YT" },
              { icon: Globe, label: "FB" },
              { icon: Music2, label: "Sound" }
            ].map((social, i) => (
              <div key={i} className="flex h-10 w-10 items-center justify-center rounded-full border border-black/10 bg-white/70 text-gray-600 transition-colors hover:text-[#002D62] hover:border-black/20">
                <social.icon className="h-5 w-5" />
              </div>
            ))}
          </div>

          {/* Navigation */}
          <div className="flex flex-wrap gap-x-6 gap-y-2 text-base font-normal text-gray-600">
            <Link href="/about" className="hover:text-[#002D62] transition-colors">About</Link>
            <Link href="/artists?tag=emerging" className="hover:text-[#002D62] transition-colors">Discover</Link>
            <Link href="/artists" className="hover:text-[#002D62] transition-colors">Artists</Link>
            <Link href="/archive" className="hover:text-[#002D62] transition-colors">Archive</Link>
            <Link href="/admin" className="hover:text-[#002D62] transition-colors">Admin</Link>
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
