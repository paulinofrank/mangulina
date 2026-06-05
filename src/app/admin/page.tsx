import Link from "next/link";
import type { ComponentType } from "react";
import {
  Award,
  BadgeCheck,
  Disc3,
  ExternalLink,
  FileClock,
  Library,
  Mic2,
  Music,
} from "lucide-react";
import AdminHomepageSpotlight from "@/components/organisms/AdminHomepageSpotlight";

type AdminTool = {
  title: string;
  eyebrow: string;
  description: string;
  href: string;
  status: "available" | "planned";
  Icon: ComponentType<{ className?: string; "aria-hidden"?: boolean }>;
};

const adminTools: AdminTool[] = [
  {
    title: "Artist Profile Editor",
    eyebrow: "Artists",
    description:
      "Create, review, and update curated artist profiles, biographies, images, and editorial classification.",
    href: "/admin/artists",
    status: "available",
    Icon: Mic2,
  },
  {
    title: "Songs / Recordings Editor",
    eyebrow: "Recordings",
    description:
      "Manage song identity, credits, genre metadata, cultural context, and authorized lyric details.",
    href: "/admin/songs",
    status: "planned",
    Icon: Music,
  },
  {
    title: "Genre Pages Manager",
    eyebrow: "Genres",
    description:
      "Curate genre landing pages, primary genre mappings, aliases, descriptions, and cultural notes.",
    href: "/admin/genres",
    status: "available",
    Icon: Library,
  },
  {
    title: "Releases / Albums Editor",
    eyebrow: "Releases",
    description:
      "Maintain albums, singles, release dates, cover art, labels, tracklists, and release credits.",
    href: "/admin/releases",
    status: "planned",
    Icon: Disc3,
  },
  {
    title: "Awards Manager",
    eyebrow: "Awards",
    description:
      "Review artist awards, categories, sources, countries, years, and award-page relationships.",
    href: "/admin/awards",
    status: "available",
    Icon: Award,
  },
  {
    title: "Platform Links Review",
    eyebrow: "Links",
    description:
      "Approve official listening links for Spotify, Apple Music, YouTube, Deezer, TIDAL, and more.",
    href: "/admin/platform-links",
    status: "available",
    Icon: ExternalLink,
  },
  {
    title: "Pending Reviews",
    eyebrow: "Editorial Queue",
    description:
      "Triage profiles, recordings, links, metadata, and other database entries that need human review.",
    href: "/admin/reviews",
    status: "planned",
    Icon: FileClock,
  },
];

function ToolCard({ tool }: { tool: AdminTool }) {
  const isAvailable = tool.status === "available";
  const Icon = tool.Icon;

  return (
    <Link
      href={tool.href}
      aria-disabled={!isAvailable}
      className={`group rounded-xl border border-black/5 bg-white p-5 shadow-sm transition ${
        isAvailable
          ? "hover:-translate-y-0.5 hover:border-[#CE1126]/30 hover:shadow-md"
          : "pointer-events-none opacity-70"
      }`}
    >
      <div className="flex items-start justify-between gap-4">
        <div className="flex h-11 w-11 items-center justify-center rounded-xl bg-[#002D62]/8 text-[#002D62]">
          <Icon className="h-5 w-5" aria-hidden={true} />
        </div>

        <span
          className={`rounded-full px-3 py-1 text-[11px] font-medium uppercase tracking-[0.16em] ${
            isAvailable
              ? "bg-[#CE1126]/10 text-[#CE1126]"
              : "bg-gray-100 text-gray-500"
          }`}
        >
          {isAvailable ? "Open" : "Coming Soon"}
        </span>
      </div>

      <div className="mt-5">
        <p className="text-xs font-medium uppercase tracking-[0.18em] text-[#CE1126]">
          {tool.eyebrow}
        </p>
        <h2 className="mt-2 text-lg font-semibold text-[#002D62]">
          {tool.title}
        </h2>
        <p className="mt-2 text-sm leading-relaxed text-gray-600">
          {tool.description}
        </p>
      </div>

      {isAvailable && (
        <p className="mt-5 inline-flex items-center gap-2 text-sm font-medium text-[#002D62] transition-colors group-hover:text-[#CE1126]">
          Go to tool
          <BadgeCheck className="h-4 w-4" aria-hidden={true} />
        </p>
      )}
    </Link>
  );
}

export default function AdminPortalPage() {
  return (
    <main className="min-h-screen bg-gray-50 px-5 pb-10 pt-24 font-sans text-gray-900 sm:px-6 sm:pb-12">
      <div className="mx-auto max-w-6xl">
        <header className="rounded-xl border border-black/5 bg-white p-6 shadow-sm sm:p-8">
          <p className="text-xs font-medium uppercase tracking-[0.22em] text-[#CE1126]">
            Mangulina Admin
          </p>
          <h1 className="mt-3 text-3xl font-black uppercase tracking-tight text-[#002D62] sm:text-4xl">
            Admin Portal
          </h1>
          <p className="mt-4 max-w-3xl text-sm leading-relaxed text-gray-600 sm:text-base">
            Editorial tools for maintaining Mangulina&apos;s curated Dominican
            music database.
          </p>
        </header>

        <AdminHomepageSpotlight />

        <section className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {adminTools.map((tool) => (
            <ToolCard key={tool.href} tool={tool} />
          ))}
        </section>
      </div>
    </main>
  );
}
