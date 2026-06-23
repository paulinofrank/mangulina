import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getTranslations } from "next-intl/server";

import ArtistDirectory from "@/components/artists/ArtistDirectory";
import {
  getPublishedProvinceBySlug,
  getPublishedProvinces,
} from "@/lib/provinces";
import { createPageMetadata } from "@/lib/seo";

type ProvincePageProps = {
  params: Promise<{ slug: string }>;
};

// Render dynamically (matches genres/[slug]); the localized root layout reads
// the request locale, which is incompatible with static prerendering here.
export const dynamic = "force-dynamic";

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

  const t = await getTranslations("artistDirectory");

  return (
    <ArtistDirectory
      path={`/provinces/${province.slug}`}
      heading={t("provinceHeading", { province: province.name })}
      mobileTitlePrefix={t("provinceMobilePrefix")}
      mobileTitleHighlight={province.name}
      intro={t("provinceIntro", { province: province.name })}
      fixedProvince={province.name}
      showProvinceSelector
      hideGenreFilter
    />
  );
}
