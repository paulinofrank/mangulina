"use client";

import Link from "next/link";
import { useTranslations } from "next-intl";
import {
  Award,
  BadgeCheck,
  BarChart3,
  Disc3,
  ExternalLink,
  FileClock,
  Library,
  LogOut,
  Mic2,
  Music,
  Users,
  UserPlus,
} from "lucide-react";
import type { ComponentType } from "react";
import AdminHomepageSpotlight from "@/components/organisms/AdminHomepageSpotlight";

type AdminTool = {
  title: string;
  eyebrow: string;
  description: string;
  href: string;
  status: "available" | "planned";
  minimumRole?: "owner" | "admin" | "editor";
  icon: string;
  Icon: ComponentType<{ className?: string; "aria-hidden"?: boolean }>;
};

type AdminToolConfig = Omit<AdminTool, "title" | "eyebrow" | "description" | "Icon">;

const toolIcons: Record<string, ComponentType<{ className?: string; "aria-hidden"?: boolean }>> = {
  analytics: BarChart3,
  artists: Mic2,
  songs: Music,
  genres: Library,
  discography: Disc3,
  awards: Award,
  platformLinks: ExternalLink,
  contributors: Users,
  invites: UserPlus,
  reviews: FileClock,
};

type AdminPortalContentProps = {
  user: { email?: string } | null;
  profile: { role?: string } | null;
  adminToolsConfig: AdminToolConfig[];
};

export default function AdminPortalContent({
  user,
  profile,
  adminToolsConfig,
}: AdminPortalContentProps) {
  const t = useTranslations();

  // Build the tools with translations
  const adminTools: AdminTool[] = adminToolsConfig.map((config) => {
    const toolKey = getToolKey(config.href);
    return {
      ...config,
      title: t(`admin.tools.${toolKey}.title`),
      eyebrow: t(`admin.tools.${toolKey}.eyebrow`),
      description: t(`admin.tools.${toolKey}.description`),
      Icon: toolIcons[config.icon] ?? BadgeCheck,
    };
  });

  return (
    <main className="min-h-screen bg-gray-50 px-5 pb-10 pt-8 font-sans text-gray-900 sm:px-6 sm:pb-12 sm:pt-10">
      <div className="mx-auto max-w-6xl">
        <header className="rounded-xl border border-black/5 bg-white p-6 shadow-sm sm:p-8">
          <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
            <div>
              <p className="text-xs font-medium uppercase tracking-[0.22em] text-[#CE1126]">
                {t("admin.ui.header")}
              </p>
              <h1 className="mt-3 text-3xl font-black uppercase tracking-tight text-[#002D62] sm:text-4xl">
                {t("admin.ui.portal")}
              </h1>
              <p className="mt-4 max-w-3xl text-sm leading-relaxed text-gray-600 sm:text-base">
                {t("admin.ui.description")}
              </p>
            </div>

            <div className="flex shrink-0 flex-col items-start gap-3 sm:items-end">
              <p className="max-w-64 truncate text-sm text-gray-500">
                {user?.email}
                {profile?.role && (
                  <span className="ml-2 rounded-full bg-gray-100 px-2 py-1 text-[10px] uppercase tracking-[0.14em] text-gray-500">
                    {profile.role}
                  </span>
                )}
              </p>

              <div className="flex flex-wrap items-center gap-2">
                <Link
                  href="/"
                  className="inline-flex w-fit items-center rounded-lg border border-[#CE1126]/25 bg-white px-4 py-2 text-xs font-medium uppercase tracking-[0.18em] text-[#CE1126] shadow-sm transition hover:border-[#CE1126] hover:bg-[#CE1126] hover:text-white"
                >
                  {t("admin.buttons.exitToHome")}
                </Link>

                <form action="/auth/sign-out" method="post">
                  <button
                    type="submit"
                    className="inline-flex w-fit items-center gap-2 rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs font-medium uppercase tracking-[0.18em] text-gray-600 shadow-sm transition hover:border-[#002D62] hover:text-[#002D62]"
                  >
                    <LogOut className="h-4 w-4" aria-hidden={true} />
                    {t("admin.buttons.signOut")}
                  </button>
                </form>
              </div>
            </div>
          </div>
        </header>

        <AdminHomepageSpotlight />

        <section className="mt-8 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {adminTools.map((tool) => (
            <AdminToolCard key={tool.href} tool={tool} t={t} />
          ))}
        </section>
      </div>
    </main>
  );
}

function AdminToolCard({
  tool,
  t,
}: {
  tool: AdminTool;
  t: ReturnType<typeof useTranslations>;
}) {
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
          {isAvailable ? t("admin.ui.statusOpen") : t("admin.ui.statusComingSoon")}
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
          {t("admin.ui.goToTool")}
          <BadgeCheck className="h-4 w-4" aria-hidden={true} />
        </p>
      )}
    </Link>
  );
}

function getToolKey(href: string): string {
  const pathSegments = href.split("/").filter(Boolean);
  const lastSegment = pathSegments[pathSegments.length - 1];

  // Map href paths to translation keys
  const keyMap: Record<string, string> = {
    analytics: "analytics",
    artists: "artists",
    songs: "songs",
    genres: "genres",
    discography: "discography",
    awards: "awards",
    "platform-links": "platformLinks",
    contributors: "contributors",
    invites: "invites",
    reviews: "reviews",
  };

  return keyMap[lastSegment] || lastSegment;
}
