import type { ComponentType } from "react";
import {
  Award,
  BarChart3,
  BadgeCheck,
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
import AdminHomepageSpotlight from "@/components/organisms/AdminHomepageSpotlight";
import { getCurrentUser } from "@/lib/auth";
import { getAdminAccessProfile } from "@/lib/adminAccess";
import AdminPortalContent from "./AdminPortalContent";

type AdminTool = {
  title: string;
  eyebrow: string;
  description: string;
  href: string;
  status: "available" | "planned";
  minimumRole?: "owner" | "admin" | "editor";
  Icon: ComponentType<{ className?: string; "aria-hidden"?: boolean }>;
};

const ADMIN_TOOLS_CONFIG: Omit<AdminTool, "title" | "eyebrow" | "description">[] = [
  {
    href: "/admin/analytics",
    status: "available",
    Icon: BarChart3,
  },
  {
    href: "/admin/artists",
    status: "available",
    Icon: Mic2,
  },
  {
    href: "/admin/songs",
    status: "planned",
    Icon: Music,
  },
  {
    href: "/admin/genres",
    status: "available",
    Icon: Library,
  },
  {
    href: "/admin/discography",
    status: "available",
    Icon: Disc3,
  },
  {
    href: "/admin/awards",
    status: "available",
    Icon: Award,
  },
  {
    href: "/admin/platform-links",
    status: "available",
    Icon: ExternalLink,
  },
  {
    href: "/admin/contributors",
    status: "available",
    Icon: Users,
  },
  {
    href: "/admin/invites",
    status: "available",
    minimumRole: "admin",
    Icon: UserPlus,
  },
  {
    href: "/admin/reviews",
    status: "planned",
    Icon: FileClock,
  },
];

export default async function AdminPortalPage() {
  const user = await getCurrentUser();
  const profile = await getAdminAccessProfile(user);
  const canManageAccess = profile?.role === "owner" || profile?.role === "admin";

  const visibleAdminTools = ADMIN_TOOLS_CONFIG.filter(
    (tool) => tool.minimumRole !== "admin" || canManageAccess,
  );

  return (
    <AdminPortalContent
      user={user}
      profile={profile}
      adminToolsConfig={visibleAdminTools}
    />
  );
}
