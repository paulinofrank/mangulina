"use client";

// BrowseByRegionSection component that shows the regions and the count of artists in that region. It is used in the archive page to show the regions that users can browse by.
import { Link } from "@/i18n/navigation";
import { useTranslations } from "next-intl";
import SectionCard from "@/components/layout/SectionCard";
import { isBornAbroadProvince, isValidProvinceName, provinceToSlug } from "@/lib/provinceSlug";

type RegionData = {
  province: string;
  count: number;
};

type BrowseByRegionSectionProps = {
  regions: RegionData[];
};

function chunkRegions(regions: RegionData[], size: number) {
  const chunks: RegionData[][] = [];

  for (let index = 0; index < regions.length; index += size) {
    chunks.push(regions.slice(index, index + size));
  }

  return chunks;
}

function RegionLink({ region }: { region: RegionData }) {
  const tDirectory = useTranslations("artistDirectory");
  // The born-abroad sentinel is stored in Spanish; show it in the page language.
  const bornAbroad = isBornAbroadProvince(region.province);
  const label = bornAbroad ? tDirectory("abroadLabel") : region.province;

  return (
    <Link
      href={`/provinces/${provinceToSlug(region.province)}`}
      prefetch={false}
      className="group relative flex items-center justify-between rounded-md border border-[#002D62]/15 bg-white px-3 py-2.5 shadow-[0_1px_0_rgba(0,45,98,0.05)] transition-all duration-200 hover:border-[#002D62]/45 hover:bg-[#002D62]/5"
    >
      <span
        className={`relative z-10 truncate text-sm font-normal transition-colors ${
          bornAbroad ? "text-[#8B0000]" : "text-[#002D62]"
        }`}
      >
        {label}
      </span>

      <span className="relative z-10 ml-2 font-mono text-xs text-gray-500 transition-colors group-hover:text-[#002D62]">
        {region.count}
      </span>
    </Link>
  );
}

export default function BrowseByRegionSection({ regions }: BrowseByRegionSectionProps) {
  const t = useTranslations("sections");
  const provinces = regions.filter((region) => isValidProvinceName(region?.province));
  // Born abroad is not a province, so it always closes the list, whatever its count.
  const validRegions = [
    ...provinces.filter((region) => !isBornAbroadProvince(region.province)),
    ...provinces.filter((region) => isBornAbroadProvince(region.province)),
  ];
  const mobileColumns = chunkRegions(validRegions, 3);

  return (
    <SectionCard compact>
      <div className="section-inner">
        <div className="section-header">
          <h2>{t("browseByRegion")}</h2>
        </div>

        <div className="flex snap-x gap-3 overflow-x-auto pb-2 md:hidden scrollbar-none">
          {mobileColumns.map((column, index) => (
            <div
              key={`region-column-${index}`}
              className="grid w-[72%] shrink-0 snap-start gap-2 min-[420px]:w-[58%] sm:w-[42%]"
            >
              {column.map((region) => (
                <RegionLink key={region.province} region={region} />
              ))}
            </div>
          ))}
        </div>

        <div className="hidden grid-cols-4 gap-2 md:grid lg:grid-cols-6">
          {validRegions.map((region) => (
            <RegionLink key={region.province} region={region} />
          ))}
        </div>
      </div>
    </SectionCard>
  );
}
