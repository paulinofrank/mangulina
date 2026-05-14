"use client";

import Image from "next/image";
import Link from "next/link";
import { Globe, Music2, Radio, Star } from "lucide-react";

export default function Footer() {
  return (
    <footer className="mt-20 border-t border-black/10 bg-white/70 backdrop-blur-sm">
      {/* REMOVED max-w-7xl. 
          Using ONLY mx-6 sm:mx-12 to match the Genre sections' natural stretch.
      */}
      <div className="mx-6 sm:mx-12 py-12">
        <div className="flex flex-col gap-10">
          
          {/* Social Icons */}
          <div className="flex items-center gap-4">
            {[
              { icon: Star, label: "IG" },
              { icon: Radio, label: "YT" },
              { icon: Globe, label: "FB" },
              { icon: Music2, label: "Sound" }
            ].map((social, i) => (
              <div key={i} className="flex h-10 w-10 items-center justify-center rounded-full border border-black/10 bg-white text-[#002D62] shadow-sm transition-transform hover:-translate-y-1">
                <social.icon className="h-4 w-4" />
              </div>
            ))}
          </div>

          {/* Navigation */}
          <div className="flex flex-wrap gap-x-8 gap-y-2 text-sm font-bold text-[#002D62]">
            <Link href="/about" className="hover:text-[#CE1126]">About</Link>
            <Link href="/recordings" className="hover:text-[#CE1126]">Discover</Link>
            <Link href="/artists" className="hover:text-[#CE1126]">Artists</Link>
            <Link href="/archive" className="hover:text-[#CE1126]">Archive</Link>
            <Link href="/admin" className="hover:text-[#CE1126]">Admin</Link>
          </div>

          {/* Bottom Bar */}
          <div className="flex items-center justify-between border-t border-black/5 pt-8">
            <div className="flex items-center gap-2">
              <Image src="/icon0.svg" alt="logo" width={24} height={24} />
              <span className="text-sm font-bold tracking-tight text-[#002D62]">Mangulina&trade;</span>
            </div>
            <p className="text-[10px] uppercase tracking-widest text-gray-400">
              Dominican Music Database &copy; 2026
            </p>
          </div>
        </div>
      </div>
    </footer>
  );
}