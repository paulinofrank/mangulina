import { describe, it } from "node:test";
import assert from "node:assert/strict";
import {
  textValue,
  uuidValue,
  sessionIdValue,
  sanitizeReferrer,
  validateEventPayload,
} from "../../src/lib/analyticsValidation";

const VALID_UUID = "a3bb189e-8bf9-3888-9912-ace4e6543002";

describe("textValue", () => {
  it("strips control characters", () => {
    const dirty = "hello" + String.fromCharCode(0, 31) + "world" + String.fromCharCode(127);
    assert.equal(textValue(dirty, 100), "helloworld");
  });

  it("normalizes empty and whitespace-only strings to null", () => {
    assert.equal(textValue("", 100), null);
    assert.equal(textValue("   ", 100), null);
    assert.equal(textValue(42, 100), null);
  });

  it("truncates to maxLength", () => {
    assert.equal(textValue("abcdef", 3), "abc");
  });
});

describe("uuidValue", () => {
  it("accepts a valid UUID", () => {
    assert.equal(uuidValue(VALID_UUID), VALID_UUID);
  });

  it("rejects malformed values", () => {
    assert.equal(uuidValue("not-a-uuid"), null);
    assert.equal(uuidValue(""), null);
    assert.equal(uuidValue(VALID_UUID + "x"), null);
  });
});

describe("sessionIdValue", () => {
  it("accepts crypto.randomUUID() output", () => {
    const id = "f47ac10b-58cc-4372-a567-0e02b2c3d479";
    assert.equal(sessionIdValue(id), id);
  });

  it("accepts the legacy fallback format", () => {
    assert.equal(
      sessionIdValue("v_1734567890123_k3j2h1g0f9"),
      "v_1734567890123_k3j2h1g0f9",
    );
  });

  it("rejects empty and whitespace-only values", () => {
    assert.equal(sessionIdValue(""), null);
    assert.equal(sessionIdValue("   "), null);
  });

  it("rejects control characters", () => {
    const withNul = "v_1734567890123_abc" + String.fromCharCode(0) + "def";
    assert.equal(sessionIdValue(withNul), null);
  });

  it("rejects free-form text and excessive length", () => {
    assert.equal(sessionIdValue("my-custom-session"), null);
    assert.equal(sessionIdValue("attacker-1"), null);
    assert.equal(sessionIdValue("a".repeat(101)), null);
    assert.equal(sessionIdValue(12345), null);
  });
});

describe("sanitizeReferrer", () => {
  it("reduces to origin only", () => {
    assert.equal(
      sanitizeReferrer("https://example.com/user/123?q=secret#frag"),
      "https://example.com",
    );
  });

  it("rejects non-HTTP schemes", () => {
    assert.equal(sanitizeReferrer("javascript:alert(1)"), null);
    assert.equal(sanitizeReferrer("ftp://example.com"), null);
    assert.equal(sanitizeReferrer("not a url"), null);
  });
});

describe("validateEventPayload", () => {
  it("accepts a valid artist_view", () => {
    const result = validateEventPayload("artist_view", {
      event_type: "artist_view",
      artist_id: VALID_UUID,
      session_id: "x",
    });
    assert.equal(result.ok, true);
    if (result.ok) {
      assert.deepEqual(result.event, {
        event_type: "artist_view",
        artist_id: VALID_UUID,
      });
    }
  });

  it("accepts valid recording_view / release_view", () => {
    for (const [type, field] of [
      ["recording_view", "recording_id"],
      ["release_view", "release_id"],
    ] as const) {
      const result = validateEventPayload(type, {
        event_type: type,
        [field]: VALID_UUID,
      });
      assert.equal(result.ok, true, type);
    }
  });

  it("accepts a valid genre_view and rejects invalid slugs", () => {
    const good = validateEventPayload("genre_view", {
      event_type: "genre_view",
      genre_slug: "merengue-tipico",
    });
    assert.equal(good.ok, true);

    const bad = validateEventPayload("genre_view", {
      event_type: "genre_view",
      genre_slug: "not a slug!",
    });
    assert.equal(bad.ok, false);
  });

  it("accepts a valid search and validates results_count", () => {
    const good = validateEventPayload("search", {
      event_type: "search",
      query: "juan luis guerra",
      results_count: 5,
    });
    assert.equal(good.ok, true);

    for (const bad of [-1, 1.5, "5", null, 2_000_000]) {
      const result = validateEventPayload("search", {
        event_type: "search",
        query: "x",
        results_count: bad,
      });
      assert.equal(result.ok, false, `results_count=${String(bad)}`);
    }
  });

  it("accepts a valid platform_click and drops non-HTTP urls", () => {
    const good = validateEventPayload("platform_click", {
      event_type: "platform_click",
      recording_id: VALID_UUID,
      platform: "apple_music",
      url: "https://music.apple.com/track/1",
    });
    assert.equal(good.ok, true);
    if (good.ok && good.event.event_type === "platform_click") {
      assert.equal(good.event.url, "https://music.apple.com/track/1");
    }

    const dropped = validateEventPayload("platform_click", {
      event_type: "platform_click",
      recording_id: VALID_UUID,
      platform: "spotify",
      url: "javascript:alert(1)",
    });
    assert.equal(dropped.ok, true);
    if (dropped.ok && dropped.event.event_type === "platform_click") {
      assert.equal(dropped.event.url, null);
    }
  });

  it("accepts a valid page_view and rejects internal paths", () => {
    const good = validateEventPayload("page_view", {
      event_type: "page_view",
      path: "/artists/juan-luis-guerra",
      page_type: "artist",
      entity_slug: "juan-luis-guerra",
    });
    assert.equal(good.ok, true);

    for (const path of ["/admin/analytics", "/auth/login"]) {
      const internal = validateEventPayload("page_view", {
        event_type: "page_view",
        path,
        page_type: "page",
      });
      assert.equal(internal.ok, false, path);
    }

    const noSlash = validateEventPayload("page_view", {
      event_type: "page_view",
      path: "artists/x",
      page_type: "artist",
    });
    assert.equal(noSlash.ok, false);
  });

  it("rejects invalid entity_id on page_view", () => {
    const result = validateEventPayload("page_view", {
      event_type: "page_view",
      path: "/artists/x",
      page_type: "artist",
      entity_id: "not-a-uuid",
    });
    assert.equal(result.ok, false);
  });

  it("rejects missing required fields", () => {
    assert.equal(
      validateEventPayload("artist_view", { event_type: "artist_view" }).ok,
      false,
    );
    assert.equal(
      validateEventPayload("search", { event_type: "search", query: "x" }).ok,
      false,
    );
    assert.equal(
      validateEventPayload("platform_click", {
        event_type: "platform_click",
        recording_id: VALID_UUID,
      }).ok,
      false,
    );
  });

  it("rejects unknown event types", () => {
    const result = validateEventPayload("made_up_event", { event_type: "made_up_event" });
    assert.equal(result.ok, false);
  });

  it("rejects unexpected fields", () => {
    const result = validateEventPayload("artist_view", {
      event_type: "artist_view",
      artist_id: VALID_UUID,
      admin: true,
    });
    assert.equal(result.ok, false);
    if (!result.ok) assert.equal(result.reason, "unexpected_field");
  });
});
