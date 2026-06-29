import { NextResponse } from "next/server";

import { requireAdminApiRole } from "@/lib/adminApiAuth";
import { fetchYouTubeVideoMetadata } from "@/lib/youtubeMetadata";
import { extractYouTubeVideoId } from "@/utils/youtube";

type YouTubeMetadataRequest = {
  videoId?: string;
  url?: string;
};

export async function POST(request: Request) {
  const auth = await requireAdminApiRole();
  if (auth.response) return auth.response;

  let body: YouTubeMetadataRequest;

  try {
    body = (await request.json()) as YouTubeMetadataRequest;
  } catch {
    return NextResponse.json(
      { ok: false, error: "Invalid YouTube metadata request." },
      { status: 400 }
    );
  }

  const videoId = body.videoId?.trim() || extractYouTubeVideoId(body.url);

  if (!videoId) {
    return NextResponse.json(
      { ok: false, error: "A valid YouTube video ID or URL is required." },
      { status: 400 }
    );
  }

  try {
    const metadata = await fetchYouTubeVideoMetadata(videoId);
    return NextResponse.json({ ok: true, metadata });
  } catch (error) {
    return NextResponse.json(
      {
        ok: false,
        error:
          error instanceof Error
            ? error.message
            : "Could not load YouTube metadata.",
      },
      { status: 500 }
    );
  }
}
