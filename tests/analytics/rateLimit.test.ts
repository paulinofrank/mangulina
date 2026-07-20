import { describe, it } from "node:test";
import assert from "node:assert/strict";
import {
  MemoryRateLimitStore,
  checkRateLimit,
  sessionLimitForEventType,
  eventLimitClass,
  ANALYTICS_RATE_LIMITS,
  type RateLimitStore,
} from "../../src/lib/analyticsRateLimit";

describe("MemoryRateLimitStore", () => {
  it("increments within a window and isolates keys", async () => {
    const store = new MemoryRateLimitStore(() => 1_000_000);
    assert.equal(await store.increment("a", 60), 1);
    assert.equal(await store.increment("a", 60), 2);
    assert.equal(await store.increment("b", 60), 1);
  });

  it("resets when the window rolls over", async () => {
    let now = 1_000_000;
    const store = new MemoryRateLimitStore(() => now);
    assert.equal(await store.increment("a", 60), 1);
    now += 61_000;
    assert.equal(await store.increment("a", 60), 1);
  });

  it("reports itself as non-distributed", () => {
    const store = new MemoryRateLimitStore();
    assert.equal(store.provider, "memory");
    assert.equal(store.distributed, false);
  });
});

describe("checkRateLimit", () => {
  it("allows under the ceiling and blocks over it", async () => {
    const store = new MemoryRateLimitStore(() => 1_000_000);
    for (let i = 0; i < 3; i += 1) {
      const result = await checkRateLimit(store, "k", 3, 60);
      assert.equal(result.allowed, true, `request ${i + 1}`);
    }
    const fourth = await checkRateLimit(store, "k", 3, 60);
    assert.equal(fourth.allowed, false);
    assert.equal(fourth.degraded, false);
  });

  it("fails open (degraded) when the store errors", async () => {
    const failing: RateLimitStore = {
      provider: "memory",
      distributed: false,
      increment: async () => null,
    };
    const result = await checkRateLimit(failing, "k", 1, 60);
    assert.equal(result.allowed, true);
    assert.equal(result.degraded, true);
  });
});

describe("limit configuration", () => {
  it("maps event types to their session ceilings", () => {
    assert.equal(
      sessionLimitForEventType("search"),
      ANALYTICS_RATE_LIMITS.searchEventsPerSessionPerMinute,
    );
    assert.equal(
      sessionLimitForEventType("platform_click"),
      ANALYTICS_RATE_LIMITS.platformClicksPerSessionPerMinute,
    );
    assert.equal(
      sessionLimitForEventType("artist_view"),
      ANALYTICS_RATE_LIMITS.viewEventsPerSessionPerMinute,
    );
    assert.equal(
      sessionLimitForEventType("page_view"),
      ANALYTICS_RATE_LIMITS.viewEventsPerSessionPerMinute,
    );
  });

  it("buckets event types into limit classes", () => {
    assert.equal(eventLimitClass("search"), "search");
    assert.equal(eventLimitClass("platform_click"), "click");
    assert.equal(eventLimitClass("artist_view"), "view");
  });
});
