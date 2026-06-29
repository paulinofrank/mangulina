import { requireAdminUser } from "@/lib/auth";

export default async function AdminArtistsLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  await requireAdminUser();

  return children;
}
