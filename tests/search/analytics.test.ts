import assert from "node:assert/strict";
import test from "node:test";
import { validateEventPayload, persistEvent } from "../../src/lib/analyticsValidation";
import type { SupabaseClient } from "@supabase/supabase-js";

test("old events remain accepted without invented classification", () => {
  const result = validateEventPayload("search", { query: "old", results_count: 0 });
  assert.deepEqual(result, { ok: true, event: { event_type: "search", query: "old", results_count: 0 } });
});
test("result outcomes distinguish no-match from backend errors", () => {
  for (const [search_outcome, results_count] of [["normal", 1], ["recovered", 1], ["no_match", 0], ["error", 0], ["degraded", 1]] as const) {
    assert.equal(validateEventPayload("search", { query: "query", results_count, search_outcome, search_action: "results", search_version: "progressive-v1" }).ok, true);
  }
  assert.equal(validateEventPayload("search", { query: "query", results_count: 0, search_outcome: "normal", search_action: "results", search_version: "progressive-v1" }).ok, false);
});
test("correction interactions carry no result count", () => {
  for (const search_action of ["suggestion_displayed", "suggestion_selected"]) {
    const body = { query: "anmiily", results_count: null, search_outcome: "recovered", search_action, search_version: "progressive-v1", suggestion_text: "Anmily" };
    assert.equal(validateEventPayload("search", body).ok, true);
    assert.equal(validateEventPayload("search", { ...body, results_count: 0 }).ok, false);
    assert.equal(validateEventPayload("search", { ...body, suggestion_text: undefined }).ok, false);
  }
});
test("classified events persist explicit fields without changing history", async () => {
  let inserted: Record<string, unknown> | undefined;
  const client = { from: () => ({ insert: async (row: Record<string, unknown>) => { inserted = row; return { error: null }; } }) } as unknown as SupabaseClient;
  const validation = validateEventPayload("search", { query: "anmiily", results_count: 1, search_outcome: "recovered", search_action: "results", search_version: "progressive-v1" });
  assert.equal(validation.ok, true);
  if (validation.ok) await persistEvent(client, validation.event, { source: null, referrer: null, user_agent: null, ip_hash: null, session_id: null });
  assert.equal(inserted?.search_outcome, "recovered");
  assert.equal(inserted?.results_count, 1);
});
