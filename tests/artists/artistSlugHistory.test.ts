import assert from "node:assert/strict";
import test from "node:test";

test("historical artist URLs resolve the published artist's current slug", async (t) => {
  process.env.NEXT_PUBLIC_SUPABASE_URL = "http://localhost:54321";
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY = "test-key";
  const requests: URL[] = [];
  let available = true;
  let failHistory = false;
  t.mock.method(globalThis, "fetch", async (input: string | URL | Request, init?: RequestInit) => {
    const url = new URL(String(input));
    requests.push(url);
    if (url.pathname.endsWith("/rpc/get_artist_profile_page")) {
      assert.deepEqual(JSON.parse(String(init?.body)), { artist_slug: "cruzmonty" });
      return Response.json({ id: "artist-id", name: "Cruzmonty", slug: "cruzmonty" });
    }
    assert.equal(url.searchParams.get("status"), "eq.published");
    if (url.searchParams.has("slug_history")) {
      assert.equal(url.searchParams.get("slug_history"), "cs.{cruz-monty}");
      if (failHistory) return Response.json({ message: "upstream failure" }, { status: 500 });
      return Response.json(available ? { id: "artist-id", slug: "cruzmonty" } : null);
    }
    return Response.json(null);
  });
  const { getArtistProfile } = await import("../../src/lib/artistApi");
  const artist = await getArtistProfile("cruz-monty");
  assert.equal(artist?.slug, "cruzmonty");
  assert.equal(requests.length, 3);

  available = false;
  assert.equal(await getArtistProfile("cruz-monty"), null, "unpublished or absent targets remain unavailable");

  failHistory = true;
  await assert.rejects(getArtistProfile("cruz-monty"), /public artist URL history/);
});

test("permanent redirects preserve Spanish and canonical unprefixed English paths", async () => {
  const { permanentRedirect } = await import("next/navigation");
  const { getPathname } = await import("../../src/i18n/navigation");
  for (const [locale, path] of [["es", "/es/artists/cruzmonty"], ["en", "/artists/cruzmonty"]]) {
    assert.throws(
      () => permanentRedirect(getPathname({ locale, href: "/artists/cruzmonty" })),
      (error: unknown) => {
        assert.equal((error as { digest: string }).digest, `NEXT_REDIRECT;replace;${path};308;`);
        return true;
      },
    );
  }
});
