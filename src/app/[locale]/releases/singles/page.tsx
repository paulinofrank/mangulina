import { ReleaseTypePage, metadataForReleaseType } from "@/app/[locale]/releases/_releasePages";

export const metadata = metadataForReleaseType("singles");
export const revalidate = 3600;

export default function SinglesPage({ searchParams }: { searchParams: Promise<{ sort?: string | string[]; page?: string | string[]; decade?: string | string[] }> }) {
  return <ReleaseTypePage slug="singles" searchParams={searchParams} />;
}
