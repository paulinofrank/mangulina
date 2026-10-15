import { SITE_URL } from "@/lib/seo";

const PUBLIC_HOSTS = new Set([new URL(SITE_URL).hostname, `www.${new URL(SITE_URL).hostname}`]);

/** Normalize known public aliases at render time without changing editorial data. */
export function canonicalEditorialHref(href: string): string {
  const rootRelative = href.startsWith("/") && !href.startsWith("//");
  if (!rootRelative && !/^https?:\/\//i.test(href)) return href;

  try {
    const url = new URL(href, SITE_URL);
    if (!PUBLIC_HOSTS.has(url.hostname) || url.port || url.username || url.password) return href;

    // Do not reinterpret links to non-public application endpoints.
    const path = url.pathname.replace(/^\/en(?=\/|$)/, "") || "/";
    if (/^\/(?:admin|api|auth|debug)(?:\/|$)/.test(path)) return href;

    return `${path}${url.search}${url.hash}`;
  } catch {
    return href;
  }
}
