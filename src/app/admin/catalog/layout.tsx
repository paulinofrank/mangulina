import { requireAdminUser } from "@/lib/auth";

export default async function AdminCatalogLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  await requireAdminUser();
  return children;
}

