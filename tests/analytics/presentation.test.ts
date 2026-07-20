import { describe, it } from "node:test";
import assert from "node:assert/strict";
import {
  chronologicalTrendRows,
  normalizeSevenDayViews,
} from "../../src/lib/analyticsPresentation";

describe("normalizeSevenDayViews", () => {
  it("never falls back to a different metric window", () => {
    const views30d = 25;
    assert.equal(normalizeSevenDayViews(0), 0);
    assert.equal(normalizeSevenDayViews(null), 0);
    assert.equal(normalizeSevenDayViews(12), 12);
    assert.equal(views30d, 25);
  });
});

describe("chronologicalTrendRows", () => {
  const newestFirst = [
    { date: "2026-07-20", value: 5 },
    { date: "2026-07-19", value: 4 },
    { date: "2026-07-18", value: 3 },
    { date: "2026-07-17", value: 2 },
    { date: "2026-07-16", value: 1 },
  ];

  it("keeps the newest requested rows and returns them chronologically", () => {
    assert.deepEqual(chronologicalTrendRows(newestFirst, 3), [
      { date: "2026-07-18", value: 3 },
      { date: "2026-07-19", value: 4 },
      { date: "2026-07-20", value: 5 },
    ]);
  });

  it("returns fewer rows when fewer than daysBack are available", () => {
    assert.deepEqual(chronologicalTrendRows(newestFirst.slice(0, 2), 7), [
      { date: "2026-07-19", value: 4 },
      { date: "2026-07-20", value: 5 },
    ]);
  });

  it("returns an empty array for empty or missing results", () => {
    assert.deepEqual(chronologicalTrendRows([], 7), []);
    assert.deepEqual(chronologicalTrendRows(null, 7), []);
  });
});
