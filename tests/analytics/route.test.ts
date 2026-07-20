import { describe, it, beforeEach } from "node:test";
import assert from "node:assert/strict";
import type { SupabaseClient } from "@supabase/supabase-js";
import { handleTrackRequest } from "../../src/app/api/analytics/track/route";
import { MemoryRateLimitStore, type RateLimitStore } from "../../src/lib/analyticsRateLimit";

const TRACK_URL = "https://mangulina.vercel.app/api/analytics/track";
const BROWSER_UA =
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/126.0 Safari/537.36";
const SESSION = "f47ac10b-58cc-4372-a567-0e02b2c3d479";
const VALID_UUID = "a3bb189e-8bf9-3888-9912-ace4e6543002";

type RpcCall = { fn: string; args: Record<string, unknown> };
type InsertCall = { table: string; values: Record<string, unknown> };

function makeMockClient(options?: {
  rpcData?: unknown;
  rpcError?: { message: string; code?: string } | null;
}) {
  const calls: { rpc: RpcCall[]; inserts: InsertCall[] } = { rpc: [], inserts: [] };
  const client = {
    rpc: async (fn: string, args: Record<string, unknown>) => {
      calls.rpc.push({ fn, args });
      return { data: options?.rpcData ?? true, error: options?.rpcError ?? null };
    },
    from: (table: string) => ({
      insert: async (values: Record<string, unknown>) => {
        calls.inserts.push({ table, values });
        return { error: null };
      },
    }),
  } as unknown as SupabaseClient;
  return { client, calls };
}

function makeDeps(options?: Parameters<typeof makeMockClient>[0] & {
  store?: RateLimitStore;
  forbidClient?: boolean;
}) {
  const { client, calls } = makeMockClient(options);
  let clientRequested = false;
  return {
    deps: {
      getClient: () => {
        clientRequested = true;
        if (options?.forbidClient) {
          throw new Error("Supabase client must not be requested for this case");
        }
        return client;
      },
      rateLimitStore: options?.store ?? new MemoryRateLimitStore(),
    },
    calls,
    wasClientRequested: () => clientRequested,
  };
}

function trackRequest(
  body: unknown,
  headers: Record<string, string> = {},
): Request {
  return new Request(TRACK_URL, {
    method: "POST",
    headers: {
      "content-type": "application/json",
      "user-agent": BROWSER_UA,
      ...headers,
    },
    body: typeof body === "string" ? body : JSON.stringify(body),
  });
}

beforeEach(() => {
  delete process.env.ANALYTICS_IP_HASH_SALT;
  delete process.env.ANALYTICS_DEBUG;
});

describe("handleTrackRequest — accepted events", () => {
  it("accepts a valid artist_view via RPC", async () => {
    const { deps, calls } = makeDeps();
    const response = await handleTrackRequest(
      trackRequest({ event_type: "artist_view", artist_id: VALID_UUID, session_id: SESSION }),
      deps,
    );
    assert.equal(response.status, 200);
    assert.deepEqual(await response.json(), { ok: true });
    assert.equal(calls.rpc.length, 1);
    assert.equal(calls.rpc[0].fn, "record_artist_view");
    assert.equal(calls.rpc[0].args.p_artist_id, VALID_UUID);
    assert.equal(calls.rpc[0].args.p_session, SESSION);
  });

  it("accepts recording, release, and genre views via their RPCs", async () => {
    const cases = [
      { body: { event_type: "recording_view", recording_id: VALID_UUID }, rpc: "record_recording_view" },
      { body: { event_type: "release_view", release_id: VALID_UUID }, rpc: "record_release_view" },
      { body: { event_type: "genre_view", genre_slug: "bachata" }, rpc: "record_genre_view" },
    ];
    for (const { body, rpc } of cases) {
      const { deps, calls } = makeDeps();
      const response = await handleTrackRequest(
        trackRequest({ ...body, session_id: SESSION }),
        deps,
      );
      assert.equal(response.status, 200, rpc);
      assert.equal(calls.rpc[0]?.fn, rpc);
    }
  });

  it("accepts a valid search event via direct insert", async () => {
    const { deps, calls } = makeDeps();
    const response = await handleTrackRequest(
      trackRequest({ event_type: "search", query: "bachata", results_count: 12, session_id: SESSION }),
      deps,
    );
    assert.equal(response.status, 200);
    assert.equal(calls.inserts.length, 1);
    assert.equal(calls.inserts[0].table, "search_events");
    assert.equal(calls.inserts[0].values.query, "bachata");
    assert.equal(calls.inserts[0].values.results_count, 12);
  });

  it("accepts a valid platform_click event", async () => {
    const { deps, calls } = makeDeps();
    const response = await handleTrackRequest(
      trackRequest({
        event_type: "platform_click",
        recording_id: VALID_UUID,
        platform: "spotify",
        url: "https://open.spotify.com/track/1",
        session_id: SESSION,
      }),
      deps,
    );
    assert.equal(response.status, 200);
    assert.equal(calls.inserts[0]?.table, "platform_click_events");
  });

  it("accepts a valid page_view event", async () => {
    const { deps, calls } = makeDeps();
    const response = await handleTrackRequest(
      trackRequest({
        event_type: "page_view",
        path: "/artists/juan-luis-guerra",
        page_type: "artist",
        entity_slug: "juan-luis-guerra",
        session_id: SESSION,
      }),
      deps,
    );
    assert.equal(response.status, 200);
    assert.equal(calls.inserts[0]?.table, "page_view_events");
  });

  it("accepts the legacy fallback session format", async () => {
    const { deps, calls } = makeDeps();
    const response = await handleTrackRequest(
      trackRequest({
        event_type: "artist_view",
        artist_id: VALID_UUID,
        session_id: "v_1734567890123_k3j2h1g0",
      }),
      deps,
    );
    assert.equal(response.status, 200);
    assert.equal(calls.rpc.length, 1);
  });

  it("still accepts events when the IP hash salt is unavailable", async () => {
    // No ANALYTICS_IP_HASH_SALT set: per-IP limiting is skipped, session
    // limiting still applies, and the event is accepted.
    const { deps, calls } = makeDeps();
    const response = await handleTrackRequest(
      trackRequest(
        { event_type: "artist_view", artist_id: VALID_UUID, session_id: SESSION },
        { "x-forwarded-for": "203.0.113.9" },
      ),
      deps,
    );
    assert.equal(response.status, 200);
    assert.equal(calls.rpc.length, 1);
  });

  it("returns ok for a deduplicated RPC result (inserted=false)", async () => {
    const { deps, calls } = makeDeps({ rpcData: false });
    const response = await handleTrackRequest(
      trackRequest({ event_type: "artist_view", artist_id: VALID_UUID, session_id: SESSION }),
      deps,
    );
    assert.equal(response.status, 200);
    assert.deepEqual(await response.json(), { ok: true });
    assert.equal(calls.rpc.length, 1);
  });
});

describe("handleTrackRequest — origin headers never cause rejection", () => {
  const base = {
    event_type: "artist_view",
    artist_id: VALID_UUID,
    session_id: SESSION,
  };

  it("accepts a valid event with an arbitrary cross-origin Origin header", async () => {
    const { deps, calls } = makeDeps();
    const response = await handleTrackRequest(
      trackRequest(base, {
        origin: "https://some-other-site.example",
        "sec-fetch-site": "cross-site",
        referer: "https://some-other-site.example/page",
      }),
      deps,
    );
    assert.equal(response.status, 200);
    assert.deepEqual(await response.json(), { ok: true });
    assert.equal(calls.rpc.length, 1);
  });

  it("accepts a valid event with no Origin, Referer, or Sec-Fetch-Site", async () => {
    const { deps, calls } = makeDeps();
    const response = await handleTrackRequest(trackRequest(base), deps);
    assert.equal(response.status, 200);
    assert.equal(calls.rpc.length, 1);
  });

  it("accepts a valid event with an opaque 'null' Origin", async () => {
    const { deps, calls } = makeDeps();
    const response = await handleTrackRequest(
      trackRequest(base, { origin: "null" }),
      deps,
    );
    assert.equal(response.status, 200);
    assert.equal(calls.rpc.length, 1);
  });
});

describe("handleTrackRequest — validation rejections (no Supabase access)", () => {
  const rejectionCases: Array<{ name: string; body: unknown; status: number }> = [
    {
      name: "unknown event type",
      body: { event_type: "made_up", session_id: SESSION },
      status: 400,
    },
    {
      name: "invalid UUID",
      body: { event_type: "artist_view", artist_id: "nope", session_id: SESSION },
      status: 400,
    },
    {
      name: "invalid genre slug",
      body: { event_type: "genre_view", genre_slug: "bad slug!", session_id: SESSION },
      status: 400,
    },
    {
      name: "malformed session ID",
      body: { event_type: "artist_view", artist_id: VALID_UUID, session_id: "attacker-1" },
      status: 400,
    },
    {
      name: "missing session ID",
      body: { event_type: "artist_view", artist_id: VALID_UUID },
      status: 400,
    },
    {
      name: "missing required field",
      body: { event_type: "search", query: "x", session_id: SESSION },
      status: 400,
    },
    {
      name: "invalid results_count",
      body: { event_type: "search", query: "x", results_count: -5, session_id: SESSION },
      status: 400,
    },
    {
      name: "non-object body",
      body: JSON.stringify([1, 2, 3]),
      status: 400,
    },
    {
      name: "invalid JSON",
      body: "{not json",
      status: 400,
    },
  ];

  for (const { name, body, status } of rejectionCases) {
    it(`rejects ${name} without touching Supabase`, async () => {
      const { deps, wasClientRequested } = makeDeps({ forbidClient: true });
      const response = await handleTrackRequest(trackRequest(body), deps);
      assert.equal(response.status, status);
      assert.deepEqual(await response.json(), { ok: false });
      assert.equal(wasClientRequested(), false);
    });
  }

  it("rejects an oversized payload with 413 before parsing", async () => {
    const { deps, wasClientRequested } = makeDeps({ forbidClient: true });
    const oversized = JSON.stringify({
      event_type: "search",
      query: "x".repeat(5000),
      results_count: 0,
      session_id: SESSION,
    });
    const response = await handleTrackRequest(trackRequest(oversized), deps);
    assert.equal(response.status, 413);
    assert.equal(wasClientRequested(), false);
  });
});

describe("handleTrackRequest — rate limiting", () => {
  it("returns 429 with Retry-After when the session limit is hit", async () => {
    const saturated: RateLimitStore = {
      provider: "memory",
      distributed: false,
      increment: async () => 9_999,
    };
    const { deps, wasClientRequested } = makeDeps({
      store: saturated,
      forbidClient: true,
    });
    const response = await handleTrackRequest(
      trackRequest({ event_type: "artist_view", artist_id: VALID_UUID, session_id: SESSION }),
      deps,
    );
    assert.equal(response.status, 429);
    assert.equal(response.headers.get("retry-after"), "60");
    assert.equal(wasClientRequested(), false);
  });

  it("fails open when the rate-limit store errors", async () => {
    const failing: RateLimitStore = {
      provider: "memory",
      distributed: false,
      increment: async () => null,
    };
    const { deps, calls } = makeDeps({ store: failing });
    const response = await handleTrackRequest(
      trackRequest({ event_type: "artist_view", artist_id: VALID_UUID, session_id: SESSION }),
      deps,
    );
    assert.equal(response.status, 200);
    assert.equal(calls.rpc.length, 1);
  });
});

describe("handleTrackRequest — bots and failures", () => {
  it("silently drops bot requests without touching Supabase", async () => {
    const { deps, wasClientRequested } = makeDeps({ forbidClient: true });
    const response = await handleTrackRequest(
      trackRequest(
        { event_type: "artist_view", artist_id: VALID_UUID, session_id: SESSION },
        { "user-agent": "curl/8.0" },
      ),
      deps,
    );
    assert.equal(response.status, 200);
    assert.deepEqual(await response.json(), { ok: true });
    assert.equal(wasClientRequested(), false);
  });

  it("returns 200 {ok:false} on an unexpected Supabase failure", async () => {
    const { deps, calls } = makeDeps({ rpcError: { message: "connection refused" } });
    const response = await handleTrackRequest(
      trackRequest({ event_type: "artist_view", artist_id: VALID_UUID, session_id: SESSION }),
      deps,
    );
    assert.equal(response.status, 200);
    assert.deepEqual(await response.json(), { ok: false });
    assert.equal(calls.rpc.length, 1);
  });

  it("treats a nonexistent entity UUID as a safe database rejection", async () => {
    // FK violation: valid-format UUID that references no real artist. The
    // constrained insert fails atomically — no orphan row, no counter update.
    const { deps, calls } = makeDeps({
      rpcError: {
        message: 'insert or update on table "artist_view_events" violates foreign key constraint',
        code: "23503",
      },
    });
    const response = await handleTrackRequest(
      trackRequest({ event_type: "artist_view", artist_id: VALID_UUID, session_id: SESSION }),
      deps,
    );
    assert.equal(response.status, 200);
    assert.deepEqual(await response.json(), { ok: false });
    assert.equal(calls.rpc.length, 1);
  });
});
