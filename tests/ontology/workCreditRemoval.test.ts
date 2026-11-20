import assert from "node:assert/strict";
import test from "node:test";
import { readFileSync } from "node:fs";
import { createTranslator } from "next-intl";
import { executeWorkCreditRemoval, parseWorkCreditRemoval } from "../../src/lib/workCreditRemoval";

const input = {
  workId: "8b81cf02-1b92-45a7-b762-155d9e2fdd14",
  creditId: "bb2ecc6a-e88a-4fd2-aa72-205119032c0a",
  reason: " Incorrect contributor identity. ",
};
test("removal requires exact Work and credit identities and trims the reason", () => {
  assert.deepEqual(parseWorkCreditRemoval(input), { ...input, ok: true, reason: "Incorrect contributor identity." });
  for (const field of ["workId", "creditId"] as const) {
    for (const value of [undefined, "", "another-work", 42]) {
      assert.equal(parseWorkCreditRemoval({ ...input, [field]: value }).ok, false);
    }
  }
});
test("removal rejects missing or oversized editorial reasons", () => {
  for (const reason of [undefined, "", "   ", 123, "a".repeat(2001)]) {
    assert.equal(parseWorkCreditRemoval({ ...input, reason }).ok, false);
  }
  assert.equal(parseWorkCreditRemoval({ ...input, reason: "a".repeat(2000) }).ok, true);
});

test("invalid input never writes or refreshes", async () => {
  const unexpected = async () => { throw new Error("Unexpected database/cache access"); };
  const result = await executeWorkCreditRemoval({ ...input, reason: " " }, { remove: unexpected, refresh: unexpected });
  assert.equal(result.status, 400);
});

test("database rejection and unavailable workflow preserve the credit and cache", async () => {
  for (const [code, status] of [["42501", 403], ["PGRST202", 503], ["42883", 503], ["P0001", 400]] as const) {
    const result = await executeWorkCreditRemoval(input, {
      remove: async () => ({ data: null, error: { code, message: "Rejected" } }),
      refresh: async () => { throw new Error("Must not refresh a failed removal"); },
    });
    assert.equal(result.status, status);
    assert.equal(result.body.ok, false);
  }
});

test("successful removal refreshes exactly the affected Work after the transaction", async () => {
  const events: string[] = [];
  const result = await executeWorkCreditRemoval(input, {
    remove: async (parsed) => {
      assert.equal(parsed.creditId, input.creditId);
      assert.equal(parsed.reason, input.reason.trim());
      events.push("remove");
      return { data: { status: "superseded" }, error: null };
    },
    refresh: async (workId) => { events.push(workId); },
  });
  assert.equal(result.status, 200);
  assert.deepEqual(events, ["remove", input.workId]);
});

test("removal confirmation renders in both locales with singular/plural impact", () => {
  for (const locale of ["en", "es"]) {
    const messages = JSON.parse(readFileSync(`messages/${locale}.json`, "utf8"));
    const t = createTranslator({ locale, messages, namespace: "admin.workWorkspace" });
    assert.ok(t("removeCredit"));
    assert.match(t("removeCreditImpact", { count: 1 }), /1 (linked recording|grabación vinculada)/);
    assert.match(t("removeCreditImpact", { count: 2 }), /2 (linked recordings|grabaciones vinculadas)/);
  }
});
