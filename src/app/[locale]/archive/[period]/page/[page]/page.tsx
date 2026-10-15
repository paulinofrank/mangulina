// Each archive slice has cacheable HTML, a stable address, and its own canonical.
export { default, generateMetadata } from "../../page";
export const revalidate = 86400;
export function generateStaticParams() { return []; }
