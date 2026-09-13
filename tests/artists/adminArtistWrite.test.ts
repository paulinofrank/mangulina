import assert from "node:assert/strict";
import test from "node:test";

import {
  buildArtistWrite,
  changedArtistFields,
  type ArtistForm,
} from "../../src/lib/adminArtistWrite";

const base: ArtistForm = {
  name: "Lilly Goodman",
  sort_name: "Goodman, Lilly",
  slug: "lilly-goodman",
  stage_name: "Lilly Goodman",
  first_name: "Liliana",
  middle_name: "",
  last_name: "Goodman",
  second_last_name: "Meregildo",
  date_of_birth: "1980-12-19",
  birth_year: "1980",
  date_of_death: "",
  death_year: "",
  formation_year: "",
  dissolution_year: "",
  birth_place: "Santo Domingo",
  province: "Distrito Nacional",
  type: "solo_artist",
  primary_role: "singer",
  primary_genre: "worship",
  status: "published",
  occupations: "songwriter, composer, writer",
  instruments: "",
  genres: "ballads, worship-gospel",
  artist_tags: "christian",
  aliases: "",
  website: "https://www.lillygoodman.com",
  facebook: "LillyGoodman",
  instagram: "goodmanlilly",
  youtube: "",
  gender: "female",
  disambiguation: "Dominican Christian singer-songwriter",
  wikidata_id: "Q5976436",
  ended: false,
};

test("an untouched form produces no changed fields", () => {
  const baseline = buildArtistWrite(base);
  assert.deepEqual(changedArtistFields(baseline, buildArtistWrite(base)), {});
});

test("editing one field sends only that field", () => {
  const baseline = buildArtistWrite(base);
  const next = buildArtistWrite({ ...base, primary_genre: "ballads" });

  assert.deepEqual(changedArtistFields(baseline, next), { primary_genre: "ballads" });
});

// The regression this guards: the editor held a stale row, one field was
// edited, and saving posted every field back — reverting a corrected surname
// the editor had never seen.
test("a field corrected elsewhere is not reverted by an unrelated edit", () => {
  const stale: ArtistForm = { ...base, second_last_name: "Merced" };
  const baseline = buildArtistWrite(stale);
  const next = buildArtistWrite({ ...stale, primary_genre: "ballads" });

  const changed = changedArtistFields(baseline, next);

  assert.equal("second_last_name" in changed, false);
  assert.deepEqual(Object.keys(changed), ["primary_genre"]);
});

test("array fields compare by contents, not identity", () => {
  const baseline = buildArtistWrite(base);

  assert.deepEqual(
    changedArtistFields(baseline, buildArtistWrite({ ...base, occupations: "songwriter,composer,writer" })),
    {},
    "whitespace-only CSV differences must not register as a change",
  );

  assert.deepEqual(
    changedArtistFields(baseline, buildArtistWrite({ ...base, genres: "ballads" })),
    { genres: ["ballads"] },
  );
});

test("clearing a field sends an explicit null rather than omitting it", () => {
  const baseline = buildArtistWrite(base);
  const changed = changedArtistFields(baseline, buildArtistWrite({ ...base, wikidata_id: "" }));

  assert.deepEqual(changed, { wikidata_id: null });
  assert.equal("wikidata_id" in changed, true);
});

test("every form field can round-trip into the payload", () => {
  const baseline = buildArtistWrite(base);
  const next = buildArtistWrite({ ...base, name: "Changed", birth_year: "1981", ended: true });
  const changed = changedArtistFields(baseline, next);

  assert.equal(changed.name, "Changed");
  assert.equal(changed.birth_year, 1981);
  assert.equal(changed.ended, true);
});

test("formation_year and dissolution_year convert to number and diff correctly", () => {
  const baseline = buildArtistWrite(base);
  const next = buildArtistWrite({
    ...base,
    type: "group",
    formation_year: "1985",
    dissolution_year: "2010",
  });
  const changed = changedArtistFields(baseline, next);

  assert.equal(changed.type, "group");
  assert.equal(changed.formation_year, 1985);
  assert.equal(changed.dissolution_year, 2010);
});
