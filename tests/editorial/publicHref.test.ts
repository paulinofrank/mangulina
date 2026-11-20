import assert from "node:assert/strict";
import { describe, it } from "node:test";
import { createElement } from "react";
import { renderToStaticMarkup } from "react-dom/server";
import BioText from "../../src/components/molecules/BioText";
import { canonicalEditorialHref } from "../../src/lib/editorial/publicHref";

describe("public editorial link destinations", () => {
  it("removes English aliases and www without changing query strings or fragments", () => {
    for (const href of [
      "https://mangulina.do/en/artists/chichi-peralta?source=bio#career",
      "http://www.mangulina.do/en/artists/chichi-peralta?source=bio#career",
      "/en/artists/chichi-peralta?source=bio#career",
    ]) assert.equal(canonicalEditorialHref(href), "/artists/chichi-peralta?source=bio#career");
    assert.equal(canonicalEditorialHref("https://mangulina.do/en"), "/");
    assert.equal(canonicalEditorialHref("/en/?a=1#top"), "/?a=1#top");
  });

  it("preserves explicit Spanish destinations and valid English paths", () => {
    assert.equal(canonicalEditorialHref("https://www.mangulina.do/es/artists/duluc"), "/es/artists/duluc");
    assert.equal(canonicalEditorialHref("/artists/duluc"), "/artists/duluc");
    assert.equal(canonicalEditorialHref("/es/artists/duluc"), "/es/artists/duluc");
    assert.equal(canonicalEditorialHref("/enrique"), "/enrique");
  });

  it("leaves external URLs and application endpoints untouched", () => {
    for (const href of [
      "https://example.com/en/artists/duluc", "https://mangulina.do.example.com/en/artists/duluc",
      "https://mangulina.do@other.example/en/artists/duluc", "https://other@mangulina.do/en/artists/duluc",
      "https://mangulina.do:8443/en/artists/duluc", "https://mangulina.do/admin/artists",
      "/api/artists", "/auth/callback", "/debug", "#career", "mailto:info@example.com", "not a URL",
    ]) assert.equal(canonicalEditorialHref(href), href);
  });

  it("renders legacy markdown with canonical links while preserving wording and external sources", () => {
    const html = renderToStaticMarkup(createElement(BioText, { bio:
      "[Chichi Peralta](https://mangulina.do/en/artists/chichi-peralta) and [Fuente](https://example.com/en/source).",
    }));
    assert.match(html, /href="\/artists\/chichi-peralta"/);
    assert.match(html, />Chichi Peralta<\/a>/);
    assert.match(html, /href="https:\/\/example.com\/en\/source"/);
    assert.match(html, /rel="noopener noreferrer"/);
  });
});
