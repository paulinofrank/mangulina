import { ReleaseDecadePage, metadataForReleaseDecade } from "@/app/releases/_releasePages";

export const metadata = metadataForReleaseDecade("1990s");
export const revalidate = 3600;

export default function Releases1990sPage({ searchParams }: { searchParams: Promise<{ sort?: string | string[]; page?: string | string[] }> }) {
  return <ReleaseDecadePage slug="1990s" searchParams={searchParams} />;
}
