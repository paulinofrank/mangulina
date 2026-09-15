import { notFound } from "next/navigation";

// Any public URL that matches no route lands here. Without this catch-all the
// request never reaches [locale]/not-found.tsx and Next serves its unstyled
// default 404 outside the site layout. notFound() keeps the 404 status.
export default function UnmatchedRoute() {
  notFound();
}
