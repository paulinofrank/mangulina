import { ReleaseDecadePage, metadataForReleaseDecade } from "@/app/[locale]/releases/_releasePages";

export const metadata = metadataForReleaseDecade("1960s");
export const revalidate = 3600;

export default function Releases1960sPage({ searchParams }: { searchParams: Promise<{ sort?: string | string[]; page?: string | string[] }> }) {
  return <ReleaseDecadePage slug="1960s" searchParams={searchParams} />;
}
