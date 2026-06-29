export function extractYouTubeVideoId(urlOrId: string | null | undefined) {
  const value = (urlOrId ?? "").trim();

  if (!value) return "";

  if (/^[a-zA-Z0-9_-]{11}$/.test(value)) {
    return value;
  }

  try {
    const parsedUrl = new URL(value);
    const hostname = parsedUrl.hostname.replace(/^www\./, "");

    if (hostname === "youtu.be") {
      return parsedUrl.pathname.split("/").filter(Boolean)[0] ?? "";
    }

    if (hostname.endsWith("youtube.com")) {
      if (parsedUrl.pathname === "/watch") {
        return parsedUrl.searchParams.get("v") ?? "";
      }

      const [section, id] = parsedUrl.pathname.split("/").filter(Boolean);

      if (section === "embed" || section === "shorts" || section === "live") {
        return id ?? "";
      }
    }
  } catch {
    return "";
  }

  return "";
}
