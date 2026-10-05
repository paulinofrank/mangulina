import assert from "node:assert/strict";
import test from "node:test";
import { readFileSync } from "node:fs";
import {
  formatDurationMilliseconds,
  externalPortfolioWorks,
  groupPortfolioRecordings,
  suppressRecordingRolesRepresentedAtWork,
  type GroupablePortfolioRecording,
} from "../../src/lib/artistPortfolioPresentation";

const recording = (overrides: Partial<GroupablePortfolioRecording>): GroupablePortfolioRecording => ({ id: "recording-a", workId: "work-a", workTitle: "Colegiala", title: "Colegiala", roles: ["arranger"], recordingYear: null, identityLabel: null, releaseYear: null, ...overrides });

test("one Work with one Recording displays as one Work", () => {
  const result = groupPortfolioRecordings([recording({})]);
  assert.equal(result.length, 1); assert.equal(result[0].recordings.length, 1);
});

test("one governed Work groups multiple distinct Recordings as children", () => {
  const result = groupPortfolioRecordings([recording({ id: "bachata", identityLabel: "Bachata" }), recording({ id: "merengue", identityLabel: "Merengue" })]);
  assert.equal(result.length, 1); assert.deepEqual(result[0].recordings.map((item) => item.id), ["bachata", "merengue"]);
});

test("different Work UUIDs remain separate even when titles match", () => {
  const result = groupPortfolioRecordings([recording({ id: "a", workId: "work-a" }), recording({ id: "b", workId: "work-b" })]);
  assert.equal(result.length, 2);
});

test("unlinked Recordings are never grouped by normalized title", () => {
  const result = groupPortfolioRecordings([recording({ id: "a", workId: null }), recording({ id: "b", workId: null })]);
  assert.equal(result.length, 2);
});

test("Work credits suppress only matching legacy Recording roles", () => {
  const result = suppressRecordingRolesRepresentedAtWork([
    { ...recording({ id: "composition", roles: ["composer"] }), source: "work" as const },
    { ...recording({ id: "recording", roles: ["composer", "producer"] }), source: "recording" as const },
    { ...recording({ id: "legacy", workId: "work-b", roles: ["lyricist"] }), source: "recording" as const },
  ]);
  assert.deepEqual(result.map((item) => [item.id, item.roles]), [
    ["composition", ["composer"]],
    ["recording", ["producer"]],
    ["legacy", ["lyricist"]],
  ]);
});

test("duration formatter handles catalog milliseconds consistently", () => {
  assert.equal(formatDurationMilliseconds(null), null);
  assert.equal(formatDurationMilliseconds(45_000), "0:45");
  assert.equal(formatDurationMilliseconds(260_360), "4:20");
  assert.equal(formatDurationMilliseconds(305_847), "5:06");
  assert.equal(formatDurationMilliseconds(3_735_000), "1:02:15");
});

test("public portfolio uses role tabs, catalog covers, and an international works section", () => {
  const shell = readFileSync("src/components/organisms/ArtistWorksPortfolio.tsx", "utf8");
  const tabs = readFileSync("src/components/organisms/ArtistWorksTabs.tsx", "utf8");
  assert.match(shell, /ArtistWorksTabs/);
  assert.match(shell, /t\("creditsCount", \{ count: linkedWorks\.length \}\)/);
  assert.doesNotMatch(shell, /linkedWorks\.length === 1 \? t\("work"\)/);
  assert.match(tabs, /role="tablist"/);
  assert.match(tabs, /"composer"/);
  assert.match(tabs, /"lyricist"/);
  assert.match(tabs, /"arranger"/);
  assert.match(tabs, /getPublicReleaseCoverUrl/);
  assert.match(tabs, /getArtistImageUrl/);
  assert.match(tabs, /t\("internationalWorks"/);
  assert.match(tabs, /t\("performedByArtist"/);
  assert.match(tabs, /\$\{year\} · /);
  assert.doesNotMatch(tabs, /font-(?:bold|semibold|black)/);
  assert.doesNotMatch(tabs, /Composition →/);
});

test("portfolio retains external versions and recomputes roles without self versions", () => {
  const own = { ...recording({ id: "own", roles: ["composer"] }), recordingArtistId: "self",
    performers: [{ artistId: "self", artistName: "Artist", creditedAs: null }] };
  const other = { ...recording({ id: "other", roles: ["arranger"] }), recordingArtistId: "other",
    performers: [{ artistId: "other", artistName: "Other", creditedAs: null }] };
  const result = externalPortfolioWorks(groupPortfolioRecordings([own, other]), "self", "Artist");
  assert.deepEqual(result[0].recordings.map((r) => r.id), ["other"]);
  assert.deepEqual(result[0].roles, ["arranger"]);
});

test("duets, text self credits and unidentified performers do not become external work", () => {
  const base = { ...recording({}), recordingArtistId: "other" };
  const duet = { ...base, performers: [{ artistId: "self", artistName: "Artist", creditedAs: null },
    { artistId: "other", artistName: "Other", creditedAs: null }] };
  const text = { ...base, performers: [{ artistId: null, artistName: null, creditedAs: " artist " }] };
  const unknown = { ...base, performers: [] };
  for (const item of [duet, text, unknown]) {
    assert.deepEqual(externalPortfolioWorks(groupPortfolioRecordings([item]), "self", "Artist"), []);
  }
});

test("an external performer can appear without a Dominican artist entity", () => {
  const item = { ...recording({}), recordingArtistId: null,
    performers: [{ artistId: null, artistName: "External Performer", creditedAs: null }] };
  assert.equal(externalPortfolioWorks(groupPortfolioRecordings([item]), "self", "Artist").length, 1);
});
