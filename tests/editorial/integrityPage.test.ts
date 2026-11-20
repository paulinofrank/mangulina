import assert from "node:assert/strict";
import { describe, test } from "node:test";
import { createElement } from "react";
import { renderToStaticMarkup } from "react-dom/server";
import { NextIntlClientProvider } from "next-intl";

import en from "../../messages/en.json";
import es from "../../messages/es.json";
import {
  EditorialIntegrityContent,
  type IntegrityReport,
  type ReportState,
} from "../../src/app/admin/(protected)/editorial-integrity/EditorialIntegrityPage";

const cleanReport: IntegrityReport = {
  generatedAt: "2026-08-05T15:30:00.000Z",
  counts: {
    documents: 581,
    relations: 37,
    blocking: 0,
    warning: 0,
    informational: 0,
  },
  findings: [],
};

function renderState(
  state: ReportState,
  locale: "en" | "es" = "en",
) {
  const messages = locale === "en" ? en : es;

  return renderToStaticMarkup(
    createElement(
      NextIntlClientProvider,
      { locale, messages },
      createElement(EditorialIntegrityContent, { state, onRetry() {} }),
    ),
  );
}

describe("editorial integrity admin page", () => {
  test("zero findings renders a deliberate success state and real summary statistics", () => {
    const html = renderState({ status: "success", report: cleanReport });

    assert.match(html, /Editorial integrity is healthy/);
    assert.match(html, /Report completed with no findings/);
    assert.match(html, /Documents checked/);
    assert.match(html, />581</);
    assert.match(html, /References checked/);
    assert.match(html, />37</);
    assert.match(html, /Blocking findings/);
    assert.match(html, /Warnings/);
    assert.match(html, /Informational findings/);
    assert.doesNotMatch(html, /Integrity findings/);
  });

  test("blocking, warning, and informational findings render in clear groups", () => {
    const report: IntegrityReport = {
      ...cleanReport,
      counts: { ...cleanReport.counts, blocking: 1, warning: 1, informational: 1 },
      findings: [
        {
          code: "published_empty_document",
          severity: "blocking",
          ownerArtistId: "artist-with-a-very-long-identifier",
          locale: "en",
          detail: "Published biography has no readable content.",
        },
        {
          code: "display_text_drift",
          severity: "warning",
          locale: "es",
          detail: "Stored reference wording differs from the artist name.",
        },
        {
          code: "draft_document",
          severity: "informational",
          detail: "Biography remains in draft.",
        },
      ],
    };
    const html = renderState({ status: "success", report });

    assert.match(html, /Blocking \(1\)/);
    assert.match(html, /Warning \(1\)/);
    assert.match(html, /Informational \(1\)/);
    assert.match(html, /Published biography has no readable content/);
    assert.match(html, /href="\/admin\/artists\?artistId=artist-with-a-very-long-identifier"/);
    assert.match(html, />es</);
  });

  test("the admin hero and return link use English translations", () => {
    const html = renderState({ status: "loading" });

    assert.match(html, /Mangulina Admin/);
    assert.match(html, /Editorial Integrity/);
    assert.match(html, /Back to Admin Portal/);
    assert.match(html, /href="\/admin"/);
    assert.match(html, /Running the editorial integrity report/);
  });

  test("the page uses Spanish translations when provided the Spanish locale", () => {
    const html = renderState({ status: "success", report: cleanReport }, "es");

    assert.match(html, /Integridad editorial/);
    assert.match(html, /Volver al portal administrativo/);
    assert.match(html, /La integridad editorial está en buen estado/);
    assert.match(html, /Documentos revisados/);
    assert.match(html, /Referencias revisadas/);
  });

  test("API failure renders a safe error state with retry and never a blank screen", () => {
    const html = renderState({ status: "error" });

    assert.match(html, /The integrity report could not be loaded/);
    assert.match(html, /Try again/);
    assert.doesNotMatch(html, /service-role|SQL/i);
  });
});
