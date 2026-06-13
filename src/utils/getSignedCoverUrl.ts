import { getPublicReleaseCoverUrl } from "@/lib/releaseCover";

export async function getSignedCoverUrl(releaseId: string) {
  return getPublicReleaseCoverUrl(releaseId, 150);
}
