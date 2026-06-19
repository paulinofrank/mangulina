import { ReleaseTypePage, metadataForReleaseType } from "@/app/releases/_releasePages";

export const metadata = metadataForReleaseType("eps");
export const revalidate = 3600;

export default function EpsPage({ searchParams }: { searchParams: Promise<{ sort?: string | string[]; page?: string | string[]; decade?: string | string[] }> }) {
  return <ReleaseTypePage slug="eps" searchParams={searchParams} />;
}
