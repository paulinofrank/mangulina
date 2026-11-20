import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { createElement } from "react";
import { renderToStaticMarkup } from "react-dom/server";
import { NextIntlClientProvider } from "next-intl";
import EditorialDocumentRenderer from "../../src/components/editorial/EditorialDocumentRenderer";
import type { EditorialDocumentV1, ResolvedEditorialDocument } from "../../src/types/editorialDocument";

const TARGET = "13d63640-f73e-46ae-80a3-94e720b7d76b";
const OCCURRENCE = "4df29df6-4b57-45a2-8514-b379c45854e4";

function resolved(document: EditorialDocumentV1, linkable = true): ResolvedEditorialDocument {
  const displayText = document.content
    .flatMap((paragraph) => paragraph.content ?? [])
    .find((node) => node.type === "artistReference")?.attrs.displayText ?? "Nombre guardado";
  return {
    id: "doc", documentType: "artist_biography", ownerArtistId: "018f5af2-4d7b-42f8-8f44-c6ef3ecbd0dc",
    locale: "es", schemaVersion: 1, revision: 1, document, integrityIssues: [],
    references: { [OCCURRENCE]: { occurrenceId: OCCURRENCE, artistId: TARGET, displayText, slug: linkable ? "slug-actual" : null, isPubliclyLinkable: linkable } },
  };
}

function render(document: ResolvedEditorialDocument) {
  return renderToStaticMarkup(createElement(
    NextIntlClientProvider,
    { locale: document.locale, messages: {} },
    createElement(EditorialDocumentRenderer, { resolvedDocument: document }),
  ));
}

describe("EditorialDocumentRenderer", () => {
  it("normalizes stored English aliases without changing wording or the document", () => {
    const document = resolved({ type: "doc", content: [{ type: "paragraph", content: [
      { type: "text", text: "Chichi Peralta", marks: [{ type: "link", attrs: { href: "https://www.mangulina.do/en/artists/chichi-peralta#career" } }] },
    ] }] });
    const before = JSON.stringify(document);
    assert.match(render(document), /href="\/artists\/chichi-peralta#career"/);
    assert.match(render(document), />Chichi Peralta<\/a>/);
    assert.equal(JSON.stringify(document), before);
  });

  it("renders the canonical empty document as no visible markup", () => {
    assert.equal(render(resolved({ type: "doc", content: [{ type: "paragraph" }] })), "");
  });

  it("renders paragraphs, hard breaks, bold, italic, and combined marks semantically", () => {
    const html = render(resolved({ type: "doc", content: [
      { type: "paragraph", content: [{ type: "text", text: "Bold", marks: [{ type: "bold" }] }, { type: "hardBreak" }, { type: "text", text: "Both", marks: [{ type: "bold" }, { type: "italic" }] }] },
      { type: "paragraph", content: [{ type: "text", text: "Italic", marks: [{ type: "italic" }] }] },
    ] }));
    assert.match(html, /<p/);
    assert.match(html, /<span><strong>Bold<\/strong><\/span><br\/>/);
    assert.match(html, /<strong><em>Both<\/em><\/strong>/);
    assert.match(html, /<em>Italic<\/em>/);
  });

  it("renders a published reference with current Spanish URL and saved wording", () => {
    const html = render(resolved({ type: "doc", content: [{ type: "paragraph", content: [
      { type: "artistReference", attrs: { occurrenceId: OCCURRENCE, artistId: TARGET, displayText: "Nombre guardado" } },
    ] }] }));
    assert.match(html, /href="\/es\/artists\/slug-actual"/);
    assert.match(html, />Nombre guardado<\/a>/);
  });

  it("renders unresolved references as plain escaped text without a link", () => {
    const html = render(resolved({ type: "doc", content: [{ type: "paragraph", content: [
      { type: "artistReference", attrs: { occurrenceId: OCCURRENCE, artistId: TARGET, displayText: "<script>alert(1)</script>" } },
    ] }] }, false));
    assert.doesNotMatch(html, /<a /);
    assert.doesNotMatch(html, /<script>/);
    assert.match(html, /&lt;script&gt;/);
  });

  it("renders multiple occurrences of the same artist independently", () => {
    const secondOccurrence = "7c48b1d8-e21f-4f39-af70-ce730be6d6d8";
    const document = resolved({ type: "doc", content: [{ type: "paragraph", content: [
      { type: "artistReference", attrs: { occurrenceId: OCCURRENCE, artistId: TARGET, displayText: "First wording" } },
      { type: "text", text: " and " },
      { type: "artistReference", attrs: { occurrenceId: secondOccurrence, artistId: TARGET, displayText: "Second wording" } },
    ] }] });
    document.references[secondOccurrence] = {
      occurrenceId: secondOccurrence, artistId: TARGET, displayText: "Second wording",
      slug: "slug-actual", isPubliclyLinkable: true,
    };
    const html = render(document);
    assert.match(html, />First wording<\/a><span> and <\/span><a /);
    assert.match(html, />Second wording<\/a>/);
  });

  it("renders curated semantic structure and hardened external links", () => {
    const html = render(resolved({ type: "doc", content: [
      { type: "heading", attrs: { level: 2 }, content: [{ type: "text", text: "Origins" }] },
      { type: "heading", attrs: { level: 3 }, content: [{ type: "text", text: "Career" }] },
      { type: "heading", attrs: { level: 4 }, content: [{ type: "text", text: "Legacy" }] },
      { type: "blockquote", content: [{ type: "paragraph", content: [{ type: "text", text: "Quoted" }] }] },
      { type: "bulletList", content: [{ type: "listItem", content: [{ type: "paragraph", content: [{ type: "text", text: "Bullet" }] }, { type: "orderedList", content: [{ type: "listItem", content: [{ type: "paragraph", content: [{ type: "text", text: "Nested" }] }] }] }] }] },
      { type: "paragraph", content: [{ type: "text", text: "Source", marks: [{ type: "link", attrs: { href: "https://example.com/" } }] }] },
      { type: "horizontalRule" },
    ] }));
    assert.match(html, /<h2/); assert.match(html, /<h3/); assert.match(html, /<h4/);
    assert.match(html, /<blockquote/); assert.match(html, /<ul/); assert.match(html, /<ol/); assert.match(html, /<hr/);
    assert.doesNotMatch(html, /space-y-2/);
    assert.match(html, /href="https:\/\/example.com\/"/);
    assert.match(html, /target="_blank"/);
    assert.match(html, /rel="noopener noreferrer"/);
  });
});
