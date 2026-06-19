import { ReleaseTypePage, metadataForReleaseType } from "@/app/releases/_releasePages";

export const metadata = metadataForReleaseType("albums");
export const revalidate = 3600;

export default function AlbumsPage({ searchParams }: { searchParams: Promise<{ sort?: string | string[]; page?: string | string[]; decade?: string | string[] }> }) {
  return <ReleaseTypePage slug="albums" searchParams={searchParams} />;
}
