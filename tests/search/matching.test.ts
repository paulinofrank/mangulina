import assert from "node:assert/strict";
import test from "node:test";
import fixture from "./fixtures/catalog.json";
import { normalizeSearchText } from "../../src/lib/searchRanking";
import { rankCatalogResults, rankCatalogCandidate } from "../../src/lib/searchMatching";
import type { GlobalSearchResponse, SearchResult } from "../../src/lib/searchTypes";

const catalog: GlobalSearchResponse = { ...fixture, artists: fixture.artists.filter((a) => a.status === "published") } as GlobalSearchResponse;
const expected: Record<string, string> = {
  "jhony ventura": "3f8bafec-e5ee-415d-8405-9551cceeeb9b", "johnny ventura": "3f8bafec-e5ee-415d-8405-9551cceeeb9b",
  "quienes son los padre de didi hernandez": "5d8fb3d5-facf-4c54-b92c-518a7ec79d74", "hernandez didi": "5d8fb3d5-facf-4c54-b92c-518a7ec79d74",
  "og black": "30f61137-9e6b-472a-b4ef-b13aecae2d7a", "o.g. black": "30f61137-9e6b-472a-b4ef-b13aecae2d7a",
  "el caballo mayor": "3f8bafec-e5ee-415d-8405-9551cceeeb9b", "anmiily": "5b271d53-9c3e-4cc3-88a4-b94126604198",
  "ada betasbe": "61781451-6220-4b5c-9074-9c1b6d2ec2ab", "dibujo de dalvin la melodía": "4f331050-2568-42a4-a73b-7f9a731f1df4",
};
for (const [query, id] of Object.entries(expected)) test(`verified artist recovery: ${query}`, () => {
  assert.equal(rankCatalogResults(catalog, query).artists[0]?.id, id);
});
test("normalization handles accents, dotted initials and whitespace consistently", () => {
  assert.equal(normalizeSearchText(" O.G.  Black "), normalizeSearchText("og black"));
  assert.equal(normalizeSearchText("Áda  Betsabé"), "ada betsabe");
  assert.equal(normalizeSearchText("Ray-Polanco"), "ray polanco");
});
test("no fabricated Yandel/Caminero match, including real Camionero title", () => {
  for (const query of ["yandel", "caminero"]) {
    const result = rankCatalogResults(catalog, query);
    assert.equal(result.artists.length + result.songs.length + result.releases.length, 0);
    assert.equal(result.search?.outcome, "no_match");
  }
});
test("question coverage rejects Hernandez-only candidates", () => {
  assert.deepEqual(rankCatalogResults(catalog, "quienes son los padre de didi hernandez").artists.map(a => a.title), ["Didi Hernández"]);
});
test("exact canonical matches precede alias, token and fuzzy matches", () => {
  const johnny = catalog.artists.find(a => a.title === "Johnny Ventura")!;
  const alias = { ...catalog.artists.find(a => a.title === "Didi Hernández")!, aliases: ["Johnny Ventura"] };
  const result = rankCatalogResults({ artists: [alias, johnny], songs: [], releases: [] }, "johnny ventura");
  assert.equal(result.artists[0].id, johnny.id);
});
test("exact common-word title is not erased by question weighting", () => {
  const real = catalog.songs[0];
  for (const title of ["Padre", "Who", "La"]) {
    // Synthetic text on a verified recording ID tests the word rule only;
    // these cases do not assert that each synthetic title exists in catalog.
    const match = rankCatalogCandidate({ ...real, title } as SearchResult, title);
    assert.equal(match?.tier, 0);
  }
});
test("short queries never invoke typo recovery", () => {
  const result = rankCatalogResults(catalog, "og");
  assert.equal(result.search?.suggestion, undefined);
  assert.equal(result.artists.some(a => a.title === "Johnny Ventura"), false);
});
test("confident corrections are attached to existing records", () => {
  const result = rankCatalogResults(catalog, "anmiily");
  assert.equal(result.search?.suggestion?.id, expected.anmiily);
  assert.equal(result.search?.suggestion?.text, "Anmily");
});
test("accented recording titles preserve exact priority", () => {
  const result = rankCatalogResults(catalog, "obsesion");
  assert.equal(result.songs[0]?.title, "Obsesión");
  assert.equal(result.search?.outcome, "normal");
});
test("reordered incomplete artist words combine", () => {
  assert.equal(rankCatalogResults(catalog, "hernand didi").artists[0]?.title, "Didi Hernández");
});

test("verified swapped artist word recovers Marcos Yaroide", () => {
  const result = rankCatalogResults(catalog, "ayroide");
  assert.equal(result.artists[0]?.id, "629a7daa-5ab3-4b77-825f-6795b8c4a566");
  assert.equal(result.search?.outcome, "recovered");
  assert.equal(result.search?.suggestion?.text, "Marcos Yaroide");
  assert.equal(rankCatalogResults(catalog, "yaroide").artists[0]?.id, result.artists[0]?.id);
});
