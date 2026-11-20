import assert from "node:assert/strict";
import test from "node:test";
import { recoverSearchFailure } from "../../src/lib/searchRecovery";
import type { SearchResult } from "../../src/lib/searchTypes";

test("backend and fallback failures are error outcomes, never no-match", async () => {
  const result = await recoverSearchFailure(async () => { throw new Error("database down"); });
  assert.equal(result.search?.outcome, "error");
  assert.deepEqual(result.artists, []);
});
test("empty fallback remains an error", async () => {
  assert.equal((await recoverSearchFailure(async () => [])).search?.outcome, "error");
});
test("fallback record is explicitly degraded", async () => {
  const artist: SearchResult = { type: "artist", id: "5d8fb3d5-facf-4c54-b92c-518a7ec79d74", title: "Didi Hernández", slug: "didi-hernandez", subtitle: null, year: null, cover_url: null };
  const result = await recoverSearchFailure(async () => [artist]);
  assert.equal(result.search?.outcome, "degraded");
  assert.equal(result.artists[0].id, artist.id);
});
