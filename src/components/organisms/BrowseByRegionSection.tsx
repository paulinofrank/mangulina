import Link from "next/link";

type RegionData = {
  name: string;
  count: number;
};

type BrowseByRegionSectionProps = {
  regions: RegionData[];
};

export default function BrowseByRegionSection({ regions }: BrowseByRegionSectionProps) {
  const validRegions = regions.filter(r => r && r.name);

  return (
    <section className="rounded-xl border border-black/5 bg-white/60 px-5 py-6 sm:px-6">
      <h2 className="text-base font-normal uppercase tracking-wider text-[#002D62] mb-4">Browse Artists by Region</h2>
      <div className="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-2">
        {validRegions.map((region) => (
          <Link
            key={region.name}
            href={`/artists?region=${encodeURIComponent(region.name)}`}
            className="group relative flex items-center justify-between px-3 py-2.5 rounded-md border border-black/5 bg-gray-50/30 transition-all duration-200 hover:bg-[#002D62] hover:border-[#002D62]"
          >
            <span className="relative z-10 text-sm font-normal text-[#002D62] group-hover:text-white transition-colors truncate">
              {region.name}
            </span>

            <span className="relative z-10 ml-2 text-xs text-gray-600 font-mono group-hover:text-white/70 transition-all">
              {region.count}
            </span>
          </Link>
        ))}
      </div>
    </section>
  );
}
