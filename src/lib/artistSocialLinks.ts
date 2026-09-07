/**
 * Pure helpers that turn a stored social identifier into a link and a label.
 *
 * They live here rather than inside the profile card because they are plain
 * string functions with no React in them, which makes them testable on their
 * own — the same reason formatOrigin lives in artistDirectoryShared.
 *
 * STORAGE CONTRACT. Identifiers are stored WITHOUT scheme or domain:
 *
 *   youtube    "@handle" when the channel has one; otherwise "channel/UC...",
 *              "c/Name" or "user/Name".
 *   instagram  the bare username.
 *   facebook   the bare username, or the bare numeric id for accounts that
 *              never claimed a vanity name.
 *   website    the exception: it keeps its scheme, because there the value is
 *              a URL and not an identifier.
 *
 * The functions still accept full URLs, because the admin lets an editor paste
 * one and nothing should break if they do.
 */
export function normalizeSocialUsername(value: string | null | undefined) {
  if (!value) return null;

  return value
    .replace(/^https?:\/\/(www\.)?/i, "")
    .replace(/^facebook\.com\//i, "")
    .replace(/^instagram\.com\//i, "")
    .replace(/^youtube\.com\//i, "")
    .replace(/^youtu\.be\//i, "")
    .replace(/^@/, "")
    .replace(/\/$/, "");
}

/**
 * Some artists have no YouTube handle, only a raw channel identifier — stored
 * as "channel/UCb8ICkBRCEJOxl5jGSStSOQ". It links correctly but reads as
 * noise, so show the network name instead, the same way a numeric Facebook
 * identifier is handled in getFacebookDisplay.
 *
 * Legacy "c/Name" and "user/Name" paths keep their readable half: those are
 * words the artist chose, not machine identifiers.
 *
 * The youtube.com/... branches stay for values entered through the admin as
 * full URLs. Handles are stored bare, without scheme or domain.
 */
export function normalizeYoutubeDisplay(value: string | null | undefined) {
  if (!value) return null;

  const cleanValue = value.trim();

  if (!cleanValue) return null;

  if (cleanValue.startsWith("@")) {
    return cleanValue;
  }

  if (/^channel\//i.test(cleanValue) || cleanValue.includes("youtube.com/channel/")) {
    return "YouTube";
  }

  if (/^(c|user)\//i.test(cleanValue)) {
    return cleanValue.replace(/^(c|user)\//i, "").replace(/\/$/, "");
  }

  if (cleanValue.includes("youtube.com/@")) {
    return `@${cleanValue.split("youtube.com/@")[1].replace(/\/$/, "")}`;
  }

  if (cleanValue.includes("youtube.com/c/")) {
    return cleanValue.split("youtube.com/c/")[1].replace(/\/$/, "");
  }

  if (cleanValue.includes("youtube.com/user/")) {
    return cleanValue.split("youtube.com/user/")[1].replace(/\/$/, "");
  }

  return normalizeSocialUsername(cleanValue);
}

export function getWebsiteUrl(value: string | null | undefined) {
  if (!value) return null;

  return value.startsWith("http") ? value : `https://${value}`;
}

export function getWebsiteDisplay(value: string | null | undefined) {
  if (!value) return null;

  return value.replace(/^https?:\/\//i, "").replace(/\/$/, "");
}

export function getYoutubeUrl(value: string | null | undefined) {
  if (!value) return null;

  const cleanValue = value.trim();

  if (!cleanValue) return null;

  if (cleanValue.startsWith("http")) {
    return cleanValue;
  }

  if (cleanValue.startsWith("@")) {
    return `https://www.youtube.com/${cleanValue}`;
  }

  if (cleanValue.startsWith("channel/")) {
    return `https://www.youtube.com/${cleanValue}`;
  }

  if (cleanValue.startsWith("c/")) {
    return `https://www.youtube.com/${cleanValue}`;
  }

  if (cleanValue.startsWith("user/")) {
    return `https://www.youtube.com/${cleanValue}`;
  }

  return `https://www.youtube.com/@${cleanValue.replace(/^@/, "")}`;
}

export function getFacebookUrl(value: string | null | undefined) {
  const username = normalizeSocialUsername(value);
  return username ? `https://www.facebook.com/${username}` : null;
}

/**
 * Some artists have no Facebook vanity URL, only a numeric identifier — stored
 * either as "profile.php?id=100044569503508" or as the bare "100044564523848".
 * Both link correctly but read as noise, so show the network name instead of
 * the raw identifier.
 */
export function getFacebookDisplay(value: string | null | undefined) {
  const username = normalizeSocialUsername(value);
  if (!username) return null;
  const isNumericIdentifier =
    username.startsWith("profile.php") || /^\d{6,}$/.test(username);
  return isNumericIdentifier ? "Facebook" : username;
}

export function getInstagramUrl(value: string | null | undefined) {
  const username = normalizeSocialUsername(value);
  return username ? `https://www.instagram.com/${username}` : null;
}

