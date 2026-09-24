import type {
  EditorialBlockNode,
  EditorialDocumentV1,
  EditorialInlineNode,
} from "@/types/editorialDocument";

export function inlineNodesInBlock(block: EditorialBlockNode): EditorialInlineNode[] {
  if (block.type === "paragraph" || block.type === "heading") return block.content ?? [];
  if (block.type === "horizontalRule") return [];
  return block.content.flatMap((child) =>
    child.type === "listItem"
      ? child.content.flatMap(inlineNodesInBlock)
      : inlineNodesInBlock(child),
  );
}

export function allEditorialInlineNodes(document: EditorialDocumentV1): EditorialInlineNode[] {
  return document.content.flatMap(inlineNodesInBlock);
}

export function mapEditorialInlineNodes(
  document: EditorialDocumentV1,
  mapper: (node: EditorialInlineNode) => EditorialInlineNode,
): EditorialDocumentV1 {
  const mapBlock = (block: EditorialBlockNode): EditorialBlockNode => {
    if (block.type === "paragraph" || block.type === "heading") {
      return { ...block, ...(block.content ? { content: block.content.map(mapper) } : {}) };
    }
    if (block.type === "horizontalRule") return block;
    return {
      ...block,
      content: block.content.map((child) =>
        child.type === "listItem"
          ? { ...child, content: child.content.map(mapBlock) }
          : mapBlock(child),
      ),
    } as EditorialBlockNode;
  };
  return { ...document, content: document.content.map(mapBlock) };
}

export function sanitizeEditorialDocumentTree(document: EditorialDocumentV1): EditorialDocumentV1 {
  const sanitizeBlock = (block: EditorialBlockNode): EditorialBlockNode => {
    if (block.type === "paragraph" || block.type === "heading") {
      if (!block.content) return block;
      const content = block.content.filter(
        (node) => !(node.type === "text" && typeof node.text === "string" && node.text.length === 0),
      );
      return { ...block, ...(content.length > 0 ? { content } : {}) };
    }
    if (block.type === "horizontalRule") return block;
    return {
      ...block,
      content: block.content.map((child) =>
        child.type === "listItem"
          ? { ...child, content: child.content.map(sanitizeBlock) }
          : sanitizeBlock(child),
      ),
    } as EditorialBlockNode;
  };
  return { ...document, content: document.content.map(sanitizeBlock) };
}
