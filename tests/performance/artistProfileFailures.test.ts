import assert from "node:assert/strict";
import test from "node:test";

test("public artist reads distinguish upstream failures from missing data", async (t) => {
  process.env.NEXT_PUBLIC_SUPABASE_URL = "http://localhost:54321";
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY = "test-key";

  let status = 200;
  let body: unknown = [];
  const paths: string[] = [];
  t.mock.method(globalThis, "fetch", async (input: string | URL | Request) => {
    paths.push(new URL(String(input)).pathname);
    return Response.json(body, { status });
  });

  const { getArtistProfile, getArtistMedia } = await import("../../src/lib/artistApi");
  const { getArtistRelationships } = await import("../../src/lib/artistRelationships");
  assert.equal(await getArtistProfile("missing"), null);

  status = 522;
  body = { message: "upstream unavailable" };
  await assert.rejects(getArtistProfile("unavailable"), /public artist visibility/);

  paths.length = 0;
  const signal = AbortSignal.timeout(1_000);
  await assert.rejects(getArtistMedia("artist", signal), /artist media/);
  assert.deepEqual(paths, ["/rest/v1/artist_media"]);
  await assert.rejects(getArtistRelationships("artist", signal), /artist relationships/);
});
