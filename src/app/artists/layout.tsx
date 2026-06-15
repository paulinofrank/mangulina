import type { Metadata } from "next";

import { createPageMetadata } from "@/lib/seo";

const baseMetadata = createPageMetadata({
  title: "Dominican Singers",
  description:
    "Browse Dominican singers by genre, province and musical context in Mangulina, the Dominican Music Database.",
  path: "/artists",
});

export const metadata: Metadata = {
  ...baseMetadata,
  title: {
    default: "Dominican Singers",
    template: "%s | Mangulina",
  },
};

export default function ArtistsLayout({ children }: { children: React.ReactNode }) {
  return children;
}
