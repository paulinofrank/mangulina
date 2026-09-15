import type { Metadata } from "next";
import { notFound } from "next/navigation";
import { getTranslations } from "next-intl/server";

import ArtistDirectory from "@/components/artists/ArtistDirectory";
import { getArtistDirectoryInitialData } from "@/lib/artistDirectoryData";
import {
  getPublishedProvinceBySlug,
  getPublishedProvinces,
  isBornAbroadProvince,
} from "@/lib/provinces";
import { createPageMetadata } from "@/lib/seo";

type ProvincePageProps = {
  params: Promise<{ slug: string; locale: string }>;
  searchParams: Promise<Record<string, string | string[] | undefined>>;
};

// Render dynamically (matches genres/[slug]); the localized root layout reads
// the request locale, which is incompatible with static prerendering here.
export const dynamic = "force-dynamic";

export async function generateStaticParams() {
  const provinces = await getPublishedProvinces();
  return provinces.map((province) => ({ slug: province.slug }));
}

export async function generateMetadata({ params }: ProvincePageProps): Promise<Metadata> {
  const { slug, locale } = await params;
  const province = await getPublishedProvinceBySlug(slug);
  if (!province) return {};
  const t = await getTranslations({ locale, namespace: "artistDirectory" });
  const bornAbroad = isBornAbroadProvince(province.name);

  return createPageMetadata({
    title: bornAbroad
      ? t("abroadMetadataTitle")
      : t("provinceMetadataTitle", { province: province.name }),
    description: bornAbroad
      ? t("abroadMetadataDescription")
      : t("provinceMetadataDescription", { province: province.name }),
    path: `/provinces/${province.slug}`,
    locale,
  });
}

export default async function ProvinceArtistsPage({
  params,
  searchParams,
}: ProvincePageProps) {
  const { slug } = await params;
  const province = await getPublishedProvinceBySlug(slug);
  if (!province) notFound();
  // Artists born outside the country share this page, but "Nacido en el
  // Exterior" is not a province, so it gets its own wording.
  const bornAbroad = isBornAbroadProvince(province.name);

  const t = await getTranslations("artistDirectory");
  const initialData = await getArtistDirectoryInitialData({
    searchParams: await searchParams,
    fixedProvince: province.name,
  });

  return (
    <ArtistDirectory
      path={`/provinces/${province.slug}`}
      heading={bornAbroad ? t("abroadHeading") : t("provinceHeading", { province: province.name })}
      mobileTitlePrefix={bornAbroad ? t("abroadMobilePrefix") : t("provinceMobilePrefix")}
      mobileTitleHighlight={bornAbroad ? t("abroadMobileHighlight") : province.name}
      intro={bornAbroad ? t("abroadIntro") : t("provinceIntro", { province: province.name })}
      fixedProvince={province.name}
      showProvinceSelector
      hideGenreFilter
      initialData={initialData}
    />
  );
}
