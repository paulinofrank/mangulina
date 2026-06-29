type YouTubeThumbnail = {
  url?: string;
};

type YouTubeThumbnails = Partial<
  Record<"default" | "medium" | "high" | "standard" | "maxres", YouTubeThumbnail>
>;

type YouTubeVideoListResponse = {
  items?: Array<{
    snippet?: {
      title?: string;
      publishedAt?: string;
      channelId?: string;
      channelTitle?: string;
      thumbnails?: YouTubeThumbnails;
    };
  }>;
  error?: {
    message?: string;
  };
};

type YouTubeChannelListResponse = {
  items?: Array<{
    snippet?: {
      title?: string;
      thumbnails?: YouTubeThumbnails;
    };
  }>;
  error?: {
    message?: string;
  };
};

export type YouTubeVideoMetadata = {
  title: string | null;
  thumbnail_url: string | null;
  published_date: string | null;
  youtube_channel_id: string | null;
  youtube_channel_name: string | null;
  youtube_channel_url: string | null;
  youtube_channel_avatar_url: string | null;
};

function pickThumbnail(thumbnails: YouTubeThumbnails | undefined, order: string[]) {
  if (!thumbnails) return null;

  for (const key of order) {
    const url = thumbnails[key as keyof YouTubeThumbnails]?.url;
    if (url) return url;
  }

  return null;
}

function toDateOnly(value: string | undefined) {
  if (!value) return null;

  const date = new Date(value);
  if (Number.isNaN(date.getTime())) return null;

  return date.toISOString().slice(0, 10);
}

async function fetchYouTubeJson<T>(url: URL) {
  const response = await fetch(url, { cache: "no-store" });
  const result = (await response.json()) as T & { error?: { message?: string } };

  if (!response.ok) {
    throw new Error(result.error?.message || "YouTube API request failed.");
  }

  return result;
}

export async function fetchYouTubeVideoMetadata(
  videoId: string
): Promise<YouTubeVideoMetadata> {
  const normalizedVideoId = videoId.trim();
  const apiKey = process.env.YOUTUBE_API_KEY;

  if (!normalizedVideoId) {
    throw new Error("YouTube video ID is required.");
  }

  if (!apiKey) {
    throw new Error("YOUTUBE_API_KEY is not configured.");
  }

  const videoUrl = new URL("https://www.googleapis.com/youtube/v3/videos");
  videoUrl.searchParams.set("part", "snippet");
  videoUrl.searchParams.set("id", normalizedVideoId);
  videoUrl.searchParams.set("key", apiKey);

  const videoResult = await fetchYouTubeJson<YouTubeVideoListResponse>(videoUrl);
  const videoSnippet = videoResult.items?.[0]?.snippet;

  if (!videoSnippet) {
    throw new Error("YouTube video was not found.");
  }

  const channelId = videoSnippet.channelId ?? null;
  let channelAvatarUrl: string | null = null;
  let channelName = videoSnippet.channelTitle ?? null;

  if (channelId) {
    try {
      const channelUrl = new URL("https://www.googleapis.com/youtube/v3/channels");
      channelUrl.searchParams.set("part", "snippet");
      channelUrl.searchParams.set("id", channelId);
      channelUrl.searchParams.set("key", apiKey);

      const channelResult = await fetchYouTubeJson<YouTubeChannelListResponse>(channelUrl);
      const channelSnippet = channelResult.items?.[0]?.snippet;

      channelName = channelSnippet?.title ?? channelName;
      channelAvatarUrl = pickThumbnail(channelSnippet?.thumbnails, [
        "high",
        "medium",
        "default",
      ]);
    } catch {
      channelAvatarUrl = null;
    }
  }

  return {
    title: videoSnippet.title ?? null,
    thumbnail_url: pickThumbnail(videoSnippet.thumbnails, [
      "maxres",
      "standard",
      "high",
      "medium",
      "default",
    ]),
    published_date: toDateOnly(videoSnippet.publishedAt),
    youtube_channel_id: channelId,
    youtube_channel_name: channelName,
    youtube_channel_url: channelId
      ? `https://www.youtube.com/channel/${channelId}`
      : null,
    youtube_channel_avatar_url: channelAvatarUrl,
  };
}
