import { ReleaseTypePage, metadataForReleaseType } from "@/app/[locale]/releases/_releasePages";

export const metadata = metadataForReleaseType("live");
export const revalidate = 3600;

export default function LiveAlbumsPage({ searchParams }: { searchParams: Promise<{ sort?: string | string[]; page?: string | string[]; decade?: string | string[] }> }) {
  return <ReleaseTypePage slug="live" searchParams={searchParams} />;
}
