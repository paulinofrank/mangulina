import type { Metadata } from "next";

import { createPageMetadata } from "@/lib/seo";

const baseMetadata = createPageMetadata({
  title: "Dominican Artists",
  description:
    "Browse Dominican artists, singers, composers, musicians and groups in Mangulina, the Dominican Music Database.",
  path: "/artists",
});

export const metadata: Metadata = {
  ...baseMetadata,
  title: {
    default: "Dominican Artists",
    template: "%s | Mangulina",
  },
};

export default function ArtistsLayout({ children }: { children: React.ReactNode }) {
  return children;
}
