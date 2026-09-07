import assert from "node:assert/strict";
import test from "node:test";

import {
  getFacebookDisplay,
  getWebsiteUrl,
  getYoutubeUrl,
  normalizeYoutubeDisplay,
} from "../../src/lib/artistSocialLinks";

// These tests exist because normalising the stored identifiers silently
// changed what the profile card renders. Once the domain was stripped from the
// stored value, the old "youtube.com/channel/" branch stopped matching and the
// raw channel path was printed as the link label. The link still worked, so
// nothing failed loudly and nothing caught it.

test("a YouTube handle is displayed exactly as stored", () => {
  assert.equal(normalizeYoutubeDisplay("@ElReyTulileoficial"), "@ElReyTulileoficial");
});

test("a raw YouTube channel id is displayed as the network name", () => {
  // A channel id is a machine identifier and reads as noise, exactly like a
  // numeric Facebook id. Same treatment.
  assert.equal(normalizeYoutubeDisplay("channel/UCb8ICkBRCEJOxl5jGSStSOQ"), "YouTube");
});

test("a legacy c/ or user/ path keeps its readable half", () => {
  // Those names were chosen by the artist, so they are worth showing.
  assert.equal(normalizeYoutubeDisplay("c/GDAElUnico"), "GDAElUnico");
  assert.equal(normalizeYoutubeDisplay("user/FundacionSinfonia"), "FundacionSinfonia");
});

test("a full URL pasted into the admin is still understood", () => {
  assert.equal(
    normalizeYoutubeDisplay("https://www.youtube.com/@lainsuperable"),
    "@lainsuperable",
  );
  assert.equal(
    normalizeYoutubeDisplay("https://www.youtube.com/channel/UCb8ICkBRCEJOxl5jGSStSOQ"),
    "YouTube",
  );
});

test("an empty YouTube value produces no label", () => {
  assert.equal(normalizeYoutubeDisplay(null), null);
  assert.equal(normalizeYoutubeDisplay("   "), null);
});

test("every stored YouTube form builds its canonical URL", () => {
  assert.equal(
    getYoutubeUrl("@ElReyTulileoficial"),
    "https://www.youtube.com/@ElReyTulileoficial",
  );
  assert.equal(
    getYoutubeUrl("channel/UCb8ICkBRCEJOxl5jGSStSOQ"),
    "https://www.youtube.com/channel/UCb8ICkBRCEJOxl5jGSStSOQ",
  );
  assert.equal(getYoutubeUrl("c/GDAElUnico"), "https://www.youtube.com/c/GDAElUnico");
  assert.equal(
    getYoutubeUrl("user/FundacionSinfonia"),
    "https://www.youtube.com/user/FundacionSinfonia",
  );
});

test("a channel path is never turned into a handle", () => {
  // "@channel/UC..." is not a real address; this is the regression guard.
  assert.ok(!getYoutubeUrl("channel/UCb8ICkBRCEJOxl5jGSStSOQ")?.includes("/@"));
});

test("a Facebook vanity name is shown and a numeric id is not", () => {
  assert.equal(getFacebookDisplay("elreytulile"), "elreytulile");
  assert.equal(getFacebookDisplay("100063809615923"), "Facebook");
  assert.equal(getFacebookDisplay("profile.php?id=100044569503508"), "Facebook");
});

test("a website keeps its scheme, or is given one", () => {
  assert.equal(getWebsiteUrl("https://olgalara.com"), "https://olgalara.com");
  assert.equal(getWebsiteUrl("www.alfareros.do"), "https://www.alfareros.do");
});
