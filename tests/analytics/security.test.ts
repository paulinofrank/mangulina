import { describe, it } from "node:test";
import assert from "node:assert/strict";
import {
  readBodyWithLimit,
  ANALYTICS_MAX_BODY_BYTES,
} from "../../src/lib/analyticsSecurity";

const TRACK_URL = "https://mangulina.vercel.app/api/analytics/track";

describe("body limit configuration", () => {
  it("is exactly 4096 bytes", () => {
    assert.equal(ANALYTICS_MAX_BODY_BYTES, 4096);
  });
});

describe("readBodyWithLimit", () => {
  it("reads a small body", async () => {
    const request = new Request(TRACK_URL, {
      method: "POST",
      body: JSON.stringify({ hello: "world" }),
    });
    const result = await readBodyWithLimit(request);
    assert.equal(result.ok, true);
    if (result.ok) assert.equal(result.text, '{"hello":"world"}');
  });

  it("accepts a body of exactly 4096 bytes", async () => {
    const exact = "a".repeat(ANALYTICS_MAX_BODY_BYTES);
    const request = new Request(TRACK_URL, { method: "POST", body: exact });
    const result = await readBodyWithLimit(request);
    assert.equal(result.ok, true);
    if (result.ok) assert.equal(result.text.length, ANALYTICS_MAX_BODY_BYTES);
  });

  it("rejects a body of 4097 bytes", async () => {
    const over = "a".repeat(ANALYTICS_MAX_BODY_BYTES + 1);
    const request = new Request(TRACK_URL, { method: "POST", body: over });
    const result = await readBodyWithLimit(request);
    assert.equal(result.ok, false);
    if (!result.ok) assert.equal(result.reason, "too_large");
  });

  it("rejects via Content-Length before reading the body", async () => {
    const request = new Request(TRACK_URL, {
      method: "POST",
      headers: { "content-length": "999999" },
      body: "x",
    });
    const result = await readBodyWithLimit(request);
    assert.equal(result.ok, false);
    if (!result.ok) assert.equal(result.reason, "too_large");
  });

  it("aborts an oversized streamed body without a trustworthy header", async () => {
    const chunk = new TextEncoder().encode("y".repeat(1024));
    const stream = new ReadableStream<Uint8Array>({
      start(controller) {
        for (let i = 0; i < 20; i += 1) controller.enqueue(chunk);
        controller.close();
      },
    });
    const request = new Request(TRACK_URL, {
      method: "POST",
      body: stream,
      // @ts-expect-error duplex is required by undici for stream bodies
      duplex: "half",
    });
    const result = await readBodyWithLimit(request);
    assert.equal(result.ok, false);
    if (!result.ok) assert.equal(result.reason, "too_large");
  });
});
