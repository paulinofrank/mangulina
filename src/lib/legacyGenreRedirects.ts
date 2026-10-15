// Verified against active catalog genre IDs 54, 31, 15 and 20 on 2026-10-15.
const legacySubgenres = [
  { oldSlug: "afro-caribbean", parent: "fusion", slug: "fusion-afro-caribbean" },
  { oldSlug: "gospel", parent: "worship", slug: "worship-gospel" },
  { oldSlug: "de-orquesta", parent: "merengue", slug: "merengue-orquesta" },
  { oldSlug: "mambo", parent: "merengue", slug: "merengue-mambo" },
];

export const legacyGenreRedirects = ["", "/en", "/es"].flatMap((prefix) =>
  legacySubgenres.map((genre) => ({
    source: `${prefix}/genres/${genre.oldSlug}`,
    destination: `${prefix === "/es" ? "/es" : ""}/genres/${genre.parent}?subgenre=${genre.slug}`,
    permanent: true,
  })),
);
