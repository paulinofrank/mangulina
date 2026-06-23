import { createNavigation } from "next-intl/navigation";
import { routing } from "./routing";

// Locale-aware navigation primitives. <Link href="/artists" /> automatically
// renders as /es/artists when the active locale is Spanish, and as /artists for
// English (default, unprefixed). useRouter/usePathname behave the same way.
export const { Link, redirect, usePathname, useRouter, getPathname } =
  createNavigation(routing);
