const INVALID_PROVINCES = new Set(["unknown", "no province", "born abroad"]);

// Every form the born-abroad sentinel has taken in the province column (see
// PROVINCE_SENTINELS in artistDirectoryShared.ts). It is not a place name, so
// the UI shows a localized label for it instead of the stored value. Kept here,
// free of imports, so client components such as artist cards can use it.
const BORN_ABROAD_PROVINCES = new Set(["Nacido en el Exterior", "Born Abroad", "X - Born Outside"]);

export function isBornAbroadProvince(province: string | null | undefined) {
  return Boolean(province && BORN_ABROAD_PROVINCES.has(province));
}

export function provinceToSlug(province: string) {
  return province
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .trim()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/^-+|-+$/g, "");
}

export function isValidProvinceName(
  province: string | null | undefined,
): province is string {
  const normalized = province?.trim().toLowerCase();
  return Boolean(normalized && !INVALID_PROVINCES.has(normalized));
}
