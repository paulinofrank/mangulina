import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { describeAnalyticsRoute } from "../../src/lib/analyticsRoute";

describe("describeAnalyticsRoute", () => {
  it("classifies unprefixed and localized homepages as home", () => {
    for (const path of ["/", "/en", "/es", "/en/", "/es/"]) {
      assert.deepEqual(describeAnalyticsRoute(path), { page_type: "home" }, path);
    }
  });

  it("classifies English and Spanish artist indexes", () => {
    for (const path of ["/en/artists", "/es/artists", "/artists/"]) {
      assert.deepEqual(describeAnalyticsRoute(path), { page_type: "artists", entity_slug: undefined }, path);
    }
  });

  it("classifies localized artist profiles", () => {
    for (const path of ["/en/artists/adalgisa-pantaleon", "/es/artists/adalgisa-pantaleon"]) {
      assert.deepEqual(describeAnalyticsRoute(path), {
        page_type: "artist",
        entity_slug: "adalgisa-pantaleon",
      }, path);
    }
  });

  it("classifies representative localized public routes", () => {
    const cases = [
      ["/en/songs/example", "song", "example"],
      ["/es/releases/example", "release", "example"],
      ["/en/genres/bachata", "genre", "bachata"],
      ["/es/search", "search", undefined],
      ["/en/discover", "discover", undefined],
    ] as const;

    for (const [path, pageType, entitySlug] of cases) {
      assert.deepEqual(describeAnalyticsRoute(path), {
        page_type: pageType,
        entity_slug: entitySlug,
      }, path);
    }
  });

  it("excludes admin and auth routes, including localized variants", () => {
    for (const path of ["/admin", "/admin/analytics", "/auth/login", "/en/admin/users", "/es/auth/login"]) {
      assert.equal(describeAnalyticsRoute(path), null, path);
    }
  });

  it("preserves the existing behavior for unknown public routes", () => {
    assert.deepEqual(describeAnalyticsRoute("/es/community/example"), {
      page_type: "community",
      entity_slug: "example",
    });
  });

  it("ignores query strings and fragments when classifying", () => {
    assert.deepEqual(describeAnalyticsRoute("/es/search?q=bachata#results"), {
      page_type: "search",
      entity_slug: undefined,
    });
  });
});
