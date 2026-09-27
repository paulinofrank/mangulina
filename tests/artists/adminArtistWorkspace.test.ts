import assert from "node:assert/strict";
import test from "node:test";
import { isCollectiveArtist, matchesArtistWorkspace, newArtistWorkspaceDefaults } from "../../src/lib/adminArtistWorkspace";

test("collectives use entity type, never gender, role, or instruments", () => {
  for (const type of ["group", "duo"]) {
    const artist = { type, primary_role: "musician", instruments: ["piano"] };
    assert.equal(matchesArtistWorkspace(artist, "groups"), true);
    assert.equal(matchesArtistWorkspace(artist, "solo"), false);
    assert.equal(matchesArtistWorkspace(artist, "musicians"), false);
  }
  assert.equal(isCollectiveArtist("person"), false);
  assert.equal(matchesArtistWorkspace({ type: "solo_artist", primary_role: "orchestra" }, "groups"), false);
});

test("singers with instruments appear in both person views without mutation", () => {
  const artist = Object.freeze({ type: "solo_artist", primary_role: "singer", instruments: ["voice", "guitar"] });
  assert.equal(matchesArtistWorkspace(artist, "solo"), true);
  assert.equal(matchesArtistWorkspace(artist, "musicians"), true);
  assert.equal(artist.primary_role, "singer");
  assert.equal(matchesArtistWorkspace({ ...artist, instruments: ["voice"] }, "musicians"), false);
});

test("musicians support legacy person type and occupation array/object shapes", () => {
  for (const occupations of [["pianist"], { pianist: true }]) {
    assert.equal(matchesArtistWorkspace({ type: "person", primary_role: "composer", occupations }, "musicians"), true);
  }
  assert.equal(matchesArtistWorkspace({ type: "solo_artist", primary_role: "musician" }, "musicians"), true);
  assert.equal(matchesArtistWorkspace({ type: "solo_artist", instruments: { accordion: true } }, "musicians"), true);
});

test("unclassified and contributor records stay reachable without guessing types", () => {
  for (const type of [null, "", "unknown", "solo_artist"]) {
    assert.equal(matchesArtistWorkspace({ type, primary_role: "producer" }, "solo"), true);
    assert.equal(matchesArtistWorkspace({ type, primary_role: "producer" }, "musicians"), false);
  }
});

test("new records use workspace defaults and remain drafts", () => {
  assert.deepEqual(newArtistWorkspaceDefaults("groups"), { type: "group", primary_role: "", status: "draft" });
  assert.deepEqual(newArtistWorkspaceDefaults("solo"), { type: "solo_artist", primary_role: "", status: "draft" });
  assert.deepEqual(newArtistWorkspaceDefaults("musicians"), { type: "solo_artist", primary_role: "musician", status: "draft" });
});
