import type { Metadata } from "next";
import { notFound } from "next/navigation";

import ArtistDirectory from "@/components/artists/ArtistDirectory";
import {
  getPublishedProvinceBySlug,
  getPublishedProvinces,
} from "@/lib/provinces";
import { createPageMetadata } from "@/lib/seo";

type ProvincePageProps = {
  params: Promise<{ slug: string }>;
};

export async function generateStaticParams() {
  const provinces = await getPublishedProvinces();
  return provinces.map((province) => ({ slug: province.slug }));
}

export async function generateMetadata({ params }: ProvincePageProps): Promise<Metadata> {
  const { slug } = await params;
  const province = await getPublishedProvinceBySlug(slug);
  if (!province) return {};

  const title = `Dominican Artists from the Province ${province.name}`;
  return createPageMetadata({
    title,
    description: `Explore Dominican artists from the province of ${province.name}, including singers, composers, musicians, DJs, and other figures in Dominican music.`,
    path: `/provinces/${province.slug}`,
  });
}

export default async function ProvinceArtistsPage({ params }: ProvincePageProps) {
  const { slug } = await params;
  const province = await getPublishedProvinceBySlug(slug);
  if (!province) notFound();

  return (
    <ArtistDirectory
      path={`/provinces/${province.slug}`}
      heading={`Dominican Artists from the Province ${province.name}`}
      mobileTitlePrefix="Dominican Artists from the Province"
      mobileTitleHighlight={province.name}
      intro={`Explore Dominican artists from the province of ${province.name} and their contributions to Dominican music in Mangulina, the Dominican Music Database.`}
      fixedProvince={province.name}
      showProvinceSelector
      hideGenreFilter
    />
  );
}
