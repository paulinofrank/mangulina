import assert from "node:assert/strict";
import test from "node:test";
import { readFileSync } from "node:fs";
import { recordingSongHref, uniqueRecordings, workSongSlug } from "../../src/lib/songIdentity";

test("repeated appearances yield one row but same-title recordings remain distinct", () => {
  const studio = { id: "studio", title: "Quebrántame" };
  const live = { id: "live", title: "Quebrántame" };
  const unrelated = { id: "other-work", title: "Quebrántame" };
  assert.deepEqual(uniqueRecordings([studio, studio, live, studio, unrelated]), [studio, live, unrelated]);
});

test("versions of a documented Work share its destination, with separate anchors", () => {
  const base = { slug: "quebrantame", work_id: "composition", work_slug: "quebrantame-composition" };
  assert.equal(recordingSongHref({ ...base, id: "studio" }), "/songs/work-quebrantame-composition#recording-studio");
  assert.equal(recordingSongHref({ ...base, id: "live" }), "/songs/work-quebrantame-composition#recording-live");
});

test("unknown composition is never manufactured from a recording title", () => {
  assert.equal(recordingSongHref({ id: "recording", slug: "live-version", work_id: null, work_slug: null }), "/songs/live-version");
  assert.equal(recordingSongHref({ id: "recording", slug: null, work_id: null, work_slug: null }), "/songs/recording");
  assert.equal(workSongSlug({ id: "work-id", slug: null }), "work-work-id");
});

test("public profiles separate release discography from archival song evidence", () => {
  const artistPage = readFileSync("src/app/[locale]/artists/[slug]/page.tsx", "utf8");
  const versions = readFileSync("src/components/organisms/SongVersionsSection.tsx", "utf8");
  const releaseTracks = readFileSync("src/app/api/artist-discography/release-tracks/route.ts", "utf8");

  assert.match(artistPage, /getArtistDiscographySummaries/);
  assert.match(artistPage, /ArtistDiscographyAccordion/);
  assert.match(releaseTracks, /\.from\("tracks"\)/);
  assert.match(releaseTracks, /\.from\("recordings"\)/);
  assert.doesNotMatch(versions, /recording\.appearances\.map/);
  assert.doesNotMatch(versions, /versionPending/);
  assert.doesNotMatch(versions, /ISRC:/);
});

test("recording profiles use one flat Credits card", () => {
  const versions = readFileSync("src/components/organisms/SongVersionsSection.tsx", "utf8");
  const personnel = readFileSync("src/components/organisms/SongPersonnelCredits.tsx", "utf8");
  assert.match(versions, /workPage && <section/);
  assert.match(personnel, /<SongCreditsSection[\s\S]*credits=\{credits\}[\s\S]*title=\{t\("eyebrow"\)\}/);
  assert.doesNotMatch(personnel, /<details/);
  assert.doesNotMatch(personnel, /ChevronDown/);
  assert.doesNotMatch(personnel, /t\("title"\)/);
});
