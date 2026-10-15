import type { ReactNode } from "react";
import ArtistReference from "@/components/editorial/ArtistReference";
import { editorialDocumentHasVisibleText } from "@/lib/editorial/biographyFallback";
import { canonicalEditorialHref } from "@/lib/editorial/publicHref";
import type {
  EditorialBlockNode,
  EditorialInlineNode,
  EditorialTextNode,
  ResolvedEditorialDocument,
} from "@/types/editorialDocument";

export type EditorialDocumentRendererProps = { resolvedDocument: ResolvedEditorialDocument };

function renderText(node: EditorialTextNode): ReactNode {
  return (node.marks ?? []).reduceRight<ReactNode>((content, mark) => {
    if (mark.type === "bold") return <strong>{content}</strong>;
    if (mark.type === "italic") return <em>{content}</em>;
    return <a href={canonicalEditorialHref(mark.attrs.href)} target="_blank" rel="noopener noreferrer" className="font-medium text-(--color-flagblue) underline decoration-blue-300 underline-offset-2 hover:decoration-(--color-flagblue)">{content}</a>;
  }, node.text);
}

function renderInline(node: EditorialInlineNode, index: number, document: ResolvedEditorialDocument) {
  if (node.type === "text") return <span key={index}>{renderText(node)}</span>;
  if (node.type === "hardBreak") return <br key={index}/>;
  const reference = document.references[node.attrs.occurrenceId] ?? { ...node.attrs, slug: null, isPubliclyLinkable: false };
  return <ArtistReference key={node.attrs.occurrenceId} reference={reference} locale={document.locale}/>;
}

function renderBlock(block: EditorialBlockNode, index: number, document: ResolvedEditorialDocument): ReactNode {
  const inline = (block.type === "paragraph" || block.type === "heading")
    ? (block.content ?? []).map((node, child) => renderInline(node, child, document))
    : null;
  if (block.type === "paragraph") return <p key={index} className="min-w-0 [overflow-wrap:anywhere]">{inline}</p>;
  if (block.type === "heading") {
    const className = "min-w-0 font-semibold leading-tight text-gray-900 [overflow-wrap:anywhere]";
    if (block.attrs.level === 2) return <h2 key={index} className={`${className} pt-3 text-2xl`}>{inline}</h2>;
    if (block.attrs.level === 3) return <h3 key={index} className={`${className} pt-2 text-xl`}>{inline}</h3>;
    return <h4 key={index} className={`${className} pt-1 text-lg`}>{inline}</h4>;
  }
  if (block.type === "horizontalRule") return <hr key={index} className="my-6 border-0 border-t border-gray-200"/>;
  if (block.type === "blockquote") return <blockquote key={index} className="space-y-3 border-l-4 border-blue-200 bg-blue-50/40 py-2 pl-4 pr-3 italic text-gray-700">{block.content.map((child, childIndex) => renderBlock(child, childIndex, document))}</blockquote>;
  const List = block.type === "bulletList" ? "ul" : "ol";
  return <List key={index} start={block.type === "orderedList" ? block.attrs?.start : undefined} className={`${block.type === "bulletList" ? "list-disc" : "list-decimal"} my-4 pl-6 marker:text-gray-500 [&>li]:my-0 [&>li>p]:m-0 [&>li>ol]:my-0 [&>li>ul]:my-0`}>{block.content.map((item, itemIndex) => <li key={itemIndex} className="pl-1">{item.content.map((child, childIndex) => renderBlock(child, childIndex, document))}</li>)}</List>;
}

export default function EditorialDocumentRenderer({ resolvedDocument }: EditorialDocumentRendererProps) {
  if (!editorialDocumentHasVisibleText({ kind: "structured", document: resolvedDocument })) return null;
  return <div className="min-w-0 space-y-4 text-sm leading-relaxed text-gray-700 [overflow-wrap:anywhere] sm:text-base">{resolvedDocument.document.content.map((block, index) => renderBlock(block, index, resolvedDocument))}</div>;
}
