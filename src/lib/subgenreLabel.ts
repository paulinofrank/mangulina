/** Qualify a short subgenre name without changing stored filter values. */
export function formatSubgenreLabel(parentName: string | undefined, subgenreName: string) {
  const parent = parentName?.trim();
  const child = subgenreName.trim();
  if (!parent || !child) return child || parent || "";

  const normalizedParent = parent.toLocaleLowerCase();
  const normalizedChild = child.toLocaleLowerCase();
  if (
    normalizedChild === normalizedParent ||
    normalizedChild.startsWith(`${normalizedParent} `) ||
    normalizedChild.startsWith(`${normalizedParent}-`)
  ) return child;

  // Keep acronyms intact; short style names become e.g. "Merengue house".
  const suffix = child === child.toLocaleUpperCase()
    ? child
    : child.charAt(0).toLocaleLowerCase() + child.slice(1);
  return `${parent} ${suffix}`;
}
