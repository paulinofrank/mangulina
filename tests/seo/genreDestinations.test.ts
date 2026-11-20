import assert from "node:assert/strict";
import test from "node:test";
import config from "../../next.config";
import { buildGenreDestinations, resolveGenreDestination, type PublicGenreRow } from "../../src/lib/genreDestinations";

const rows: PublicGenreRow[] = [
  { id: 1, name: "Merengue", slug: "merengue", parent_id: null, level: 0 },
  { id: 12, name: "Fusion", slug: "fusion", parent_id: null, level: 0 },
  { id: 13, name: "Worship", slug: "worship", parent_id: null, level: 0 },
  { id: 15, name: "de Orquesta", slug: "merengue-orquesta", parent_id: 1, level: 1 },
  { id: 20, name: "Mambo", slug: "merengue-mambo", parent_id: 1, level: 1 },
  { id: 31, name: "Gospel", slug: "worship-gospel", parent_id: 13, level: 1 },
  { id: 54, name: "Afro-Caribbean", slug: "fusion-afro-caribbean", parent_id: 12, level: 1 },
];
const links = buildGenreDestinations(rows);

test("song labels resolve to actual top-level pages and catalog subgenre filters", () => {
  assert.equal(resolveGenreDestination("Merengue", links), "/genres/merengue");
  assert.equal(resolveGenreDestination("de Orquesta", links), "/genres/merengue?subgenre=merengue-orquesta");
  assert.equal(resolveGenreDestination("mambo", links), "/genres/merengue?subgenre=merengue-mambo");
  assert.equal(resolveGenreDestination(" Gospel ", links), "/genres/worship?subgenre=worship-gospel");
  assert.equal(resolveGenreDestination("Afro-Caribbean", links), "/genres/fusion?subgenre=fusion-afro-caribbean");
});

test("unknown labels and broken taxonomy relations do not invent URLs", () => {
  assert.equal(resolveGenreDestination("Not cataloged", links), null);
  assert.deepEqual(buildGenreDestinations([
    { id: 99, name: "Orphan", slug: "orphan", parent_id: 999, level: 1 },
    { id: 100, name: "No slug", slug: null, parent_id: null, level: 0 },
  ]), []);
});

test("duplicate subgenre names require an unambiguous parent", () => {
  const duplicates = [...links, { name: "Mambo", slug: "other-mambo", parentName: "Other", href: "/genres/other?subgenre=other-mambo" }];
  assert.equal(resolveGenreDestination("Mambo", duplicates), null);
  assert.equal(resolveGenreDestination("Mambo", duplicates, "Merengue"), "/genres/merengue?subgenre=merengue-mambo");
});

test("Next configuration redirects the four broken genre URLs in every supported URL form", async () => {
  const redirects = await config.redirects!();
  for (const prefix of ["", "/en", "/es"]) {
    for (const [old, target] of [
      ["afro-caribbean", "/genres/fusion?subgenre=fusion-afro-caribbean"],
      ["gospel", "/genres/worship?subgenre=worship-gospel"],
      ["de-orquesta", "/genres/merengue?subgenre=merengue-orquesta"],
      ["mambo", "/genres/merengue?subgenre=merengue-mambo"],
    ]) {
      const route = redirects.find((item) => item.source === `${prefix}/genres/${old}`);
      assert.ok(route);
      assert.equal(route.destination, `${prefix === "/es" ? "/es" : ""}${target}`);
      assert.equal(route.permanent, true);
    }
  }
});
