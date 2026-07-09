import { revalidatePath } from "next/cache";
import { routing } from "@/i18n/routing";

export function getArtistProfileRevalidationPaths(slug: string) {
  const normalizedSlug = slug.trim();
  const paths = new Set(["/", "/en", "/es"]);

  if (!normalizedSlug) return paths;

  paths.add(`/artists/${normalizedSlug}`);
  paths.add(`/en/artists/${normalizedSlug}`);
  paths.add(`/es/artists/${normalizedSlug}`);

  for (const locale of routing.locales) {
    paths.add(
      locale === routing.defaultLocale
        ? `/artists/${normalizedSlug}`
        : `/${locale}/artists/${normalizedSlug}`,
    );
  }

  return paths;
}

export function revalidateArtistProfilePaths(slug: string) {
  for (const path of getArtistProfileRevalidationPaths(slug)) {
    revalidatePath(path, "page");
  }
}
