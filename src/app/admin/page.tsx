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
  icon: string;
};

const ADMIN_TOOLS_CONFIG: Omit<AdminTool, "title" | "eyebrow" | "description">[] = [
  {
    href: "/admin/analytics",
    status: "available",
    icon: "analytics",
  },
  {
    href: "/admin/artists",
    status: "available",
    icon: "artists",
  },
  {
    href: "/admin/songs",
    status: "planned",
    icon: "songs",
  },
  {
    href: "/admin/genres",
    status: "available",
    icon: "genres",
  },
  {
    href: "/admin/discography",
    status: "available",
    icon: "discography",
  },
  {
    href: "/admin/awards",
    status: "available",
    icon: "awards",
  },
  {
    href: "/admin/platform-links",
    status: "available",
    icon: "platformLinks",
  },
  {
    href: "/admin/contributors",
    status: "available",
    icon: "contributors",
  },
  {
    href: "/admin/invites",
    status: "available",
    minimumRole: "admin",
    icon: "invites",
  },
  {
    href: "/admin/reviews",
    status: "planned",
    icon: "reviews",
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
