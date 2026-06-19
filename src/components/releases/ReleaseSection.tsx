import Link from "next/link";
import SectionCard from "@/components/layout/SectionCard";
import ReleaseGrid from "@/components/releases/ReleaseGrid";
import type { ReleaseSummary } from "@/lib/releaseApi";

type ReleaseSectionProps = {
  title: string;
  releases: ReleaseSummary[];
  href?: string;
  emptyMessage?: string;
};

export default function ReleaseSection({
  title,
  releases,
  href,
  emptyMessage,
}: ReleaseSectionProps) {
  return (
    <SectionCard>
      <div className="section-inner">
        <div className="section-header flex items-center justify-between gap-4">
          <h2>{title}</h2>
          {href && (
            <Link
              href={href}
              className="shrink-0 text-sm font-medium uppercase tracking-wider text-[#8B0000] transition-colors hover:text-[#CE1126]"
            >
              See All
            </Link>
          )}
        </div>

        <ReleaseGrid releases={releases} emptyMessage={emptyMessage} />
      </div>
    </SectionCard>
  );
}
