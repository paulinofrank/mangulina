import assert from "node:assert/strict";
import test from "node:test";

import { createRobotsPolicy } from "../src/app/robots";

const INTERNAL_PATHS = [
  "/admin",
  "/admin/",
  "/api/",
  "/auth/",
  "/debug",
  "/_next/image",
];
// Phase 3D also keeps crawlers out of site search, whose result pages are
// user-driven and effectively unbounded. Faceted listing query strings are
// denied for the same reason — see FACETED_QUERY_PARAMS in src/app/robots.ts.
const FACETED_QUERY_DISALLOWED = [
  "sort",
  "genre",
  "subgenre",
  "province",
  "region",
  "tag",
  "classical",
  "decade",
  "view",
].map((param) => `/*?*${param}=`);
const CRAWLER_DISALLOWED = [
  ...INTERNAL_PATHS,
  "/search",
  ...FACETED_QUERY_DISALLOWED,
];

test("robots remains fail-closed when indexing is disabled", () => {
  assert.deepEqual(createRobotsPolicy(false), {
    rules: {
      userAgent: "*",
      disallow: "/",
    },
  });
});

type RobotsRule = {
  userAgent: string;
  allow?: string;
  disallow?: string | string[];
};

function permittedRules(policy: ReturnType<typeof createRobotsPolicy>) {
  return (policy.rules as RobotsRule[]).filter((rule) => rule.allow === "/");
}

test("robots explicitly permits Meta without widening internal access", () => {
  const policy = createRobotsPolicy(true);

  assert.equal(policy.sitemap, "https://mangulina.do/sitemap.xml");
  assert.equal(policy.host, "https://mangulina.do/");
  assert.ok(Array.isArray(policy.rules));

  const rules = permittedRules(policy);

  assert.deepEqual(
    rules.map((rule) => rule.userAgent),
    ["*", "facebookexternalhit", "Facebot", "meta-externalagent"],
  );

  for (const rule of rules) {
    assert.equal(rule.allow, "/");
    assert.deepEqual(rule.disallow, CRAWLER_DISALLOWED);
  }
});

// Amazonbot was denied outright while the profile routes were effectively
// uncached and its exhaustive walk forced a cold render per request. With
// profiles in the route cache that cost is gone, and the catalogue exists to
// be found — so no crawler is denied the site any more.
test("no crawler is denied the whole site", () => {
  const rules = createRobotsPolicy(true).rules as RobotsRule[];
  const denied = rules.filter((rule) => rule.disallow === "/");

  assert.deepEqual(
    denied.map((rule) => rule.userAgent),
    [],
    "a blanket denial keeps a crawler from discovering the catalogue at all",
  );
  assert.equal(
    rules.find((rule) => rule.userAgent === "Amazonbot"),
    undefined,
  );
});

test("every named agent is allowed the catalogue on the same terms", () => {
  const rules = createRobotsPolicy(true).rules as RobotsRule[];

  for (const rule of rules) {
    assert.equal(rule.allow, "/", `${rule.userAgent} must reach the catalogue`);
    assert.deepEqual(rule.disallow, CRAWLER_DISALLOWED);
  }

  const wildcard = rules.find((rule) => rule.userAgent === "*");
  assert.ok(wildcard, "the wildcard group must exist");
});

test("robots stays fail-closed when indexing is disabled", () => {
  const policy = createRobotsPolicy(false);
  assert.deepEqual(policy.rules, { userAgent: "*", disallow: "/" });
});

/** robots.txt matching: prefix match on path+query, `*` matches any run. */
function isDisallowed(rules: string[], url: string) {
  return rules.some((pattern) => {
    const source = pattern
      .split("*")
      .map((part) => part.replace(/[.+?^${}()|[\]\\]/g, "\\$&"))
      .join(".*");
    return new RegExp(`^${source}`).test(url);
  });
}

// Faceted listing URLs are duplicates of their bare path and each one is an
// uncached origin render. Blocking them must not cost any real crawl surface:
// the bare listings stay open and the catalogue is reached via the sitemaps.
test("faceted listing query strings are denied while bare listings stay crawlable", () => {
  const wildcard = (createRobotsPolicy(true).rules as RobotsRule[]).find(
    (rule) => rule.userAgent === "*",
  );
  const rules = wildcard?.disallow as string[];

  for (const url of [
    "/releases/albums?sort=views&page=3",
    "/releases/1990s?decade=1990s",
    "/artists?genre=merengue",
    "/artists?subgenre=bachata-urbana",
    "/producers?sort=name",
    "/provinces/azua?province=azua",
    "/artists/birthdays?view=zodiac",
  ]) {
    assert.ok(isDisallowed(rules, url), `${url} must be denied`);
  }

  for (const url of [
    "/",
    "/releases",
    "/releases/albums",
    "/releases/1990s",
    "/artists",
    "/musicians",
    "/artists/birthdays",
    "/artists/juan-luis-guerra",
    "/songs/ojala-que-llueva-cafe",
    "/genres/merengue",
    "/archive/1990",
    "/es/releases/albums",
    // Pagination is the catalogue's crawl path. Listings show 24 items, so
    // blocking it would strand 610 of 634 artists outside the internal link
    // graph and leave them reachable only from the sitemap.
    "/artists?page=2",
    "/musicians?page=4",
    "/releases/albums?page=2",
    "/es/releases/eps?page=7",
  ]) {
    assert.ok(!isDisallowed(rules, url), `${url} must stay crawlable`);
  }
});

// /archive?year=1990 permanently redirects to /archive/1990. Blocking it would
// strand the legacy URL in the index instead of letting it consolidate.
test("the legacy archive redirect stays crawlable", () => {
  const wildcard = (createRobotsPolicy(true).rules as RobotsRule[]).find(
    (rule) => rule.userAgent === "*",
  );
  const rules = wildcard?.disallow as string[];

  assert.ok(!isDisallowed(rules, "/archive?year=1990"));
  assert.ok(!isDisallowed(rules, "/es/archive?year=1990"));
});
