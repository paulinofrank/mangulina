import type { Metadata } from "next";

import { createPageMetadata } from "@/lib/seo";

export async function generateMetadata({
  params,
}: {
  params: Promise<{ locale: string }>;
}): Promise<Metadata> {
  const { locale } = await params;
  const baseMetadata = createPageMetadata({
    title: "Dominican Singers",
    description:
      "Browse Dominican singers by genre, province and musical context in Mangulina, the Dominican Music Database.",
    path: "/artists",
    locale,
  });

  return {
    ...baseMetadata,
    title: {
      default: "Dominican Singers",
      template: "%s | Mangulina",
    },
  };
}

export default function ArtistsLayout({ children }: { children: React.ReactNode }) {
  return children;
}
