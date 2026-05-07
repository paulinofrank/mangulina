import Image from "next/image";
import Link from "next/link";
import { Globe, Music2, Radio, Star } from "lucide-react";

const socialLinks = [
  { label: "Instagram", href: "#", icon: Star },
  { label: "YouTube", href: "#", icon: Radio },
  { label: "Facebook", href: "#", icon: Globe },
  { label: "Sound", href: "#", icon: Music2 },
];

const helpfulLinks = [
  { label: "About", href: "#" },
  { label: "Discover", href: "/recordings" },
  { label: "Artists", href: "/artists" },
  { label: "Archive", href: "/archive" },
  { label: "Support", href: "#" },
];

const legalLinks = [
  { label: "Terms of Use", href: "#" },
  { label: "Privacy Policy", href: "#" },
  { label: "Cookie Preferences", href: "#" },
  { label: "Accessibility", href: "#" },
];

export default function Footer() {
  return (
    <footer className="mt-20 border-t border-black/10 bg-white/70 backdrop-blur-sm">
      <div className="mx-auto flex w-full max-w-7xl flex-col gap-8 px-6 py-12 sm:px-10">
        <div className="flex flex-wrap items-center justify-center gap-3 sm:justify-start">
          {socialLinks.map(({ label, href, icon: Icon }) => (
            <Link
              key={label}
              href={href}
              className="inline-flex h-10 w-10 items-center justify-center rounded-full border border-black/10 bg-white text-ink/70 shadow-sm transition-all hover:-translate-y-0.5 hover:border-flagblue/40 hover:text-flagblue"
              aria-label={label}
            >
              <Icon className="h-4 w-4" />
            </Link>
          ))}
        </div>

        <div className="flex flex-wrap items-center gap-x-6 gap-y-3 text-sm font-medium text-ink/75">
          {helpfulLinks.map((link) => (
            <Link key={link.label} href={link.href} className="transition-colors hover:text-wikicrimson">
              {link.label}
            </Link>
          ))}
        </div>

        <div className="flex flex-wrap items-center gap-x-5 gap-y-2 text-xs text-ink/60">
          {legalLinks.map((link) => (
            <Link key={link.label} href={link.href} className="transition-colors hover:text-ink">
              {link.label}
            </Link>
          ))}
        </div>

        <div className="flex flex-wrap items-center justify-between gap-4 border-t border-black/10 pt-6">
          <div className="flex items-center gap-2">
            <Image
              src="/icon0.svg"
              alt="Mangulina logo"
              width={24}
              height={24}
              className="h-6 w-6 object-contain"
            />
            <span className="text-sm font-semibold tracking-tight text-ink">Mangulina</span>
          </div>
          <p className="text-xs text-ink/65">© 2026 Mangulina. Dominican music data, curated with care.</p>
        </div>
      </div>
    </footer>
  );
}
