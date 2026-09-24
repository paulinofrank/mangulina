import assert from "node:assert/strict";
import test from "node:test";
import { classifyEditorialSaveResponse, prepareEditorialDocumentForSave } from "../../src/lib/editorial/tiptap/save.ts";
import type { EditorialDocumentV1 } from "../../src/types/editorialDocument.ts";

test("save response classification preserves stale edits", () => {
  assert.equal(classifyEditorialSaveResponse(409, false), "stale");
});
test("save response classification distinguishes success and validation failure", () => {
  assert.equal(classifyEditorialSaveResponse(200, true), "saved");
  assert.equal(classifyEditorialSaveResponse(400, false), "error");
});
test("prepareEditorialDocumentForSave cleans empty text nodes and validates successfully", () => {
  const docWithEmptyTextNode: EditorialDocumentV1 = {
    type: "doc",
    content: [
      {
        type: "paragraph",
        content: [
          { type: "text", text: "Some text" },
          { type: "text", text: "" },
          {
            type: "artistReference",
            attrs: {
              occurrenceId: "4df29df6-4b57-45a2-8514-b379c45854e4",
              artistId: "13d63640-f73e-46ae-80a3-94e720b7d76b",
              displayText: "Referenced Artist",
            },
          },
        ],
      },
    ],
  };
  const result = prepareEditorialDocumentForSave(docWithEmptyTextNode);
  assert.equal(result.ok, true);
  if (result.ok) {
    const paragraph = result.document.content[0];
    if (paragraph.type === "paragraph" && paragraph.content) {
      assert.equal(paragraph.content.length, 2);
      assert.equal(paragraph.content[0].type, "text");
      assert.equal(paragraph.content[1].type, "artistReference");
    }
  }
});
