import assert from "node:assert/strict";
import fs from "node:fs";
import test from "node:test";
import pg from "pg";
import { rankCatalogResults } from "../../src/lib/searchMatching";
import { normalizeSearchText } from "../../src/lib/searchRanking";
import type { GlobalSearchResponse } from "../../src/lib/searchTypes";

const url = process.env.SEARCH_TEST_DATABASE_URL;
const expected: Record<string, string | null> = {
  "jhony ventura": "3f8bafec-e5ee-415d-8405-9551cceeeb9b", "johnny ventura": "3f8bafec-e5ee-415d-8405-9551cceeeb9b",
  "quienes son los padre de didi hernandez": "5d8fb3d5-facf-4c54-b92c-518a7ec79d74", "hernandez didi": "5d8fb3d5-facf-4c54-b92c-518a7ec79d74",
  "og black": "30f61137-9e6b-472a-b4ef-b13aecae2d7a", "o.g. black": "30f61137-9e6b-472a-b4ef-b13aecae2d7a",
  "el caballo mayor": "3f8bafec-e5ee-415d-8405-9551cceeeb9b", "anmiily": "5b271d53-9c3e-4cc3-88a4-b94126604198",
  "ada betasbe": "61781451-6220-4b5c-9074-9c1b6d2ec2ab", "dibujo de dalvin la melodía": "4f331050-2568-42a4-a73b-7f9a731f1df4",
  ayroide: "629a7daa-5ab3-4b77-825f-6795b8c4a566", yandel: null, caminero: null,
};
test("full catalog RPC regression under anonymous visibility", { skip: !url }, async () => {
  assert.ok(url);
  assert.ok(["localhost", "127.0.0.1", "[::1]"].includes(new URL(url).hostname), "This test is restricted to an isolated local database.");
  const client = new pg.Client({ connectionString: url });
  await client.connect();
  try {
    await client.query("BEGIN READ ONLY");
    await client.query("SET LOCAL ROLE anon");
    for (const [query, id] of Object.entries(expected)) {
      const response = await client.query<{ result: GlobalSearchResponse }>("select global_search($1) result", [normalizeSearchText(query)]);
      const candidates = response.rows[0].result;
      for (const key of ["artists", "songs", "releases"] as const) assert.ok(candidates[key].length <= 120);
      const ranked = rankCatalogResults(candidates, query);
      if (id) assert.equal(ranked.artists[0]?.id, id, query);
      else assert.equal(ranked.artists.length + ranked.songs.length + ranked.releases.length, 0, query);
    }
    const hidden = await client.query("select global_search('blackfox') result");
    assert.equal(hidden.rows[0].result.artists.some((artist: { id: string }) => artist.id === "3dd4ffd4-6d58-4e78-b6d8-28f126eaed08"), false, "Verified needs_review artist stays hidden");
    const properties = await client.query("select prosecdef,proconfig from pg_proc where oid='global_search(text)'::regprocedure");
    assert.equal(properties.rows[0].prosecdef, false);
    assert.deepEqual(properties.rows[0].proconfig, ["search_path=public, extensions"]);
    await client.query("ROLLBACK");
  } finally { await client.end(); }
});

test("migration changes no search normalization, index, privileges or policies", () => {
  const migration = fs.readFileSync("supabase/migrations/20261013010000_progressive_search_candidates.sql", "utf8");
  assert.doesNotMatch(migration, /CREATE\s+(?:OR\s+REPLACE\s+)?FUNCTION\s+public\.search_normalize|CREATE\s+INDEX|GRANT\s|REVOKE\s|ALTER\s+POLICY|SECURITY\s+DEFINER/i);
});
