import { sanitizeEditorialDocumentTree } from "@/lib/editorial/documentTree";
import { repairDuplicateOccurrenceIds } from "@/lib/editorial/tiptap/artistReference";
import { validateEditorialDocument } from "@/lib/editorial/validate";
import type { EditorialDocumentV1 } from "@/types/editorialDocument";

export function prepareEditorialDocumentForSave(
  document: EditorialDocumentV1,
  generateUuid?: () => string,
) {
  const sanitized = sanitizeEditorialDocumentTree(document);
  const repaired = repairDuplicateOccurrenceIds(sanitized, generateUuid);
  return validateEditorialDocument(1, repaired);
}

export function classifyEditorialSaveResponse(status: number, ok: boolean) {
  if (status === 409) return "stale" as const;
  if (!ok) return "error" as const;
  return "saved" as const;
}
