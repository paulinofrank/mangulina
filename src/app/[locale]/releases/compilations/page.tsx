import { ReleaseTypePage, metadataForReleaseType } from "@/app/[locale]/releases/_releasePages";

export const metadata = metadataForReleaseType("compilations");
export const revalidate = 3600;

export default function CompilationsPage({ searchParams }: { searchParams: Promise<{ sort?: string | string[]; page?: string | string[]; decade?: string | string[] }> }) {
  return <ReleaseTypePage slug="compilations" searchParams={searchParams} />;
}
