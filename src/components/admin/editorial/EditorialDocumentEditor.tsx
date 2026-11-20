"use client";

import { EditorContent, useEditor } from "@tiptap/react";
import { NodeSelection } from "@tiptap/pm/state";
import { AlignLeft, AtSign, Bold, Eye, Heading2, Heading3, Heading4, IndentDecrease, IndentIncrease, Italic, Link2, List, ListOrdered, Minus, Quote, Redo2, RemoveFormatting, RotateCcw, Save, Unlink, Undo2 } from "lucide-react";
import { useTranslations } from "next-intl";
import { useEffect, useMemo, useState } from "react";
import { createPortal } from "react-dom";
import ArtistCombobox, { type ArtistComboboxOption } from "@/components/admin/ArtistCombobox";
import { editorialDocumentHasVisibleText } from "@/lib/editorial/biographyFallback";
import { saveAdminEditorialDocument, type AdminEditorialDocumentState } from "@/lib/editorial/adminClient";
import { createArtistReferenceAttrs } from "@/lib/editorial/tiptap/artistReference";
import { editorialTiptapExtensions } from "@/lib/editorial/tiptap/extensions";
import { allEditorialInlineNodes } from "@/lib/editorial/documentTree";
import { normalizeEditorialLink } from "@/lib/editorial/links";
import { classifyEditorialSaveResponse, prepareEditorialDocumentForSave } from "@/lib/editorial/tiptap/save";
import type { EditorialValidationIssue } from "@/lib/editorial/validate";
import type { EditorialBlockNode, EditorialDocumentV1, EditorialInlineNode, EditorialLocale, EditorialTextNode } from "@/types/editorialDocument";

const toolClass = "rounded-md border border-gray-200 bg-white p-2 text-gray-700 hover:bg-gray-50 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-(--color-flagblue) disabled:cursor-not-allowed disabled:opacity-35";

type Props = {
  ownerArtistId: string;
  locale: EditorialLocale;
  initial: AdminEditorialDocumentState | null;
  onDirtyChange: (dirty: boolean) => void;
  onReloadRequested: () => Promise<void>;
  /**
   * Optional container for the Save draft / Publish controls, letting a parent
   * host them outside this component (the biography editor puts them on the
   * language-tab row). When omitted the controls stay in the footer as before.
   */
  actionsSlot?: HTMLElement | null;
};

export default function EditorialDocumentEditor({ ownerArtistId, locale, initial, onDirtyChange, onReloadRequested, actionsSlot }: Props) {
  const t = useTranslations("admin.editorialToolbar");
  const [dirty, setDirty] = useState(false);
  const [status, setStatus] = useState<"draft" | "published">(initial?.status ?? "draft");
  const [revision, setRevision] = useState(initial?.revision ?? 0);
  const [documentId, setDocumentId] = useState(initial?.id ?? null);
  const [message, setMessage] = useState("");
  const [issues, setIssues] = useState<EditorialValidationIssue[]>([]);
  const [saving, setSaving] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  const [preview, setPreview] = useState(false);
  const [stale, setStale] = useState(false);
  const [selectedReference, setSelectedReference] = useState<{ occurrenceId: string; artistId: string; displayText: string } | null>(null);
  const [linkEditor, setLinkEditor] = useState<{ href: string; from: number; to: number } | null>(null);
  const [linkError, setLinkError] = useState("");
  const [, rerenderToolbar] = useState(0);

  const editor = useEditor({
    immediatelyRender: false,
    extensions: editorialTiptapExtensions,
    content: initial?.document ?? { type: "doc", content: [{ type: "paragraph" }] },
    editorProps: {
      attributes: {
        class: "min-h-56 rounded-b-lg px-4 py-3 text-sm leading-7 text-gray-900 outline-none focus-visible:ring-2 focus-visible:ring-inset focus-visible:ring-(--color-flagblue) [&_a]:text-blue-700 [&_a]:underline [&_blockquote]:my-4 [&_blockquote]:border-l-4 [&_blockquote]:border-blue-200 [&_blockquote]:pl-4 [&_h2]:my-4 [&_h2]:text-2xl [&_h2]:font-semibold [&_h3]:my-3 [&_h3]:text-xl [&_h3]:font-semibold [&_h4]:my-3 [&_h4]:text-lg [&_h4]:font-semibold [&_hr]:my-6 [&_hr]:border-gray-200 [&_ol]:my-4 [&_ol]:list-decimal [&_ol]:pl-6 [&_ul]:my-4 [&_ul]:list-disc [&_ul]:pl-6 [&_li]:my-0 [&_li>p]:m-0 [&_li_ol]:my-0 [&_li_ul]:my-0 [&_.editorial-artist-reference]:rounded [&_.editorial-artist-reference]:bg-blue-100 [&_.editorial-artist-reference]:px-1 [&_.editorial-artist-reference]:text-blue-900 [&_.editorial-artist-reference.ProseMirror-selectednode]:outline-2 [&_.editorial-artist-reference.ProseMirror-selectednode]:outline-blue-600",
        "aria-label": `${locale === "en" ? "English" : "Spanish"} structured biography editor`,
      },
    },
    onUpdate: () => { setDirty(true); onDirtyChange(true); setMessage(""); rerenderToolbar((value) => value + 1); },
    onSelectionUpdate: ({ editor: current }) => {
      const selection = current.state.selection;
      if (selection instanceof NodeSelection && selection.node.type.name === "artistReference") {
        setSelectedReference(selection.node.attrs as typeof selectedReference);
      } else setSelectedReference(null);
      rerenderToolbar((value) => value + 1);
    },
  });

  useEffect(() => {
    const warn = (event: BeforeUnloadEvent) => { if (dirty) { event.preventDefault(); event.returnValue = ""; } };
    const guardLink = (event: MouseEvent) => {
      const link = (event.target as Element | null)?.closest("a[href]");
      if (dirty && link && !window.confirm("The structured biography has unsaved changes. Leave this page?")) event.preventDefault();
    };
    window.addEventListener("beforeunload", warn);
    document.addEventListener("click", guardLink, true);
    return () => { window.removeEventListener("beforeunload", warn); document.removeEventListener("click", guardLink, true); };
  }, [dirty]);

  const json = editor?.getJSON() as EditorialDocumentV1 | undefined;
  const empty = useMemo(() => json ? !editorialDocumentHasVisibleText({ kind: "legacy", text: allEditorialInlineNodes(json).map((node) => node.type === "text" ? node.text : node.type === "artistReference" ? node.attrs.displayText : "\n").join("") }) : true, [json]);

  function selectArtist(artist: ArtistComboboxOption) {
    if (!editor) return;
    const selection = editor.state.selection;
    const selectedText = editor.state.doc.textBetween(selection.from, selection.to, " ");
    if (selectedReference) {
      editor.chain().focus().updateArtistReference({ artistId: artist.id }).run();
    } else {
      editor.chain().focus().insertArtistReference(createArtistReferenceAttrs(artist.id, selectedText || artist.name)).run();
    }
    setSearchOpen(false);
  }

  function openLinkEditor() {
    if (!editor) return;
    if (editor.isActive("link")) editor.commands.extendMarkRange("link");
    const { from, to } = editor.state.selection;
    setLinkEditor({ href: String(editor.getAttributes("link").href ?? ""), from, to });
    setLinkError("");
  }

  function applyLink() {
    if (!editor || !linkEditor) return;
    const href = normalizeEditorialLink(linkEditor.href);
    if (!href) { setLinkError(t("invalidLink")); return; }
    editor.chain().focus().setTextSelection({ from: linkEditor.from, to: linkEditor.to }).setLink({ href }).run();
    setLinkEditor(null);
    setLinkError("");
  }

  async function save(nextStatus: "draft" | "published") {
    if (!editor || saving || stale) return;
    const validation = prepareEditorialDocumentForSave(editor.getJSON() as EditorialDocumentV1);
    if (!validation.ok) { setIssues(validation.issues); setMessage("Fix the validation errors before saving."); return; }
    const document = validation.document;
    if (nextStatus === "published" && empty && !window.confirm("Publishing an empty structured biography will suppress the legacy biography. Continue?")) return;
    setSaving(true); setIssues([]); setMessage("");
    try {
      const { response, result } = await saveAdminEditorialDocument({ documentType: "artist_biography", ownerArtistId, locale, schemaVersion: 1, status: nextStatus, document, expectedRevision: revision });
      const outcome = classifyEditorialSaveResponse(response.status, response.ok && result.ok);
      if (outcome === "stale") {
        setStale(true);
        return;
      }
      if (outcome === "error") { setMessage(!result.ok ? result.error : "Save failed."); return; }
      if (!result.ok) { setMessage(result.error); return; }
      setDocumentId(result.document.id); setRevision(result.document.revision); setStatus(result.document.status);
      editor.commands.setContent(document, { emitUpdate: false });
      setDirty(false); onDirtyChange(false); setMessage(nextStatus === "published" ? "Biography published." : "Draft saved.");
    } finally { setSaving(false); }
  }

  if (!editor) return <p className="p-4 text-sm text-gray-500">Loading editor…</p>;

  const documentActions = (
    <>
      <button type="button" disabled={saving || stale} onClick={() => void save("draft")} className="inline-flex items-center gap-2 rounded bg-gray-700 px-4 py-2 text-sm text-white disabled:opacity-40"><Save size={15}/>Save draft</button>
      <button type="button" disabled={saving || stale} onClick={() => void save("published")} className="inline-flex items-center gap-2 rounded bg-(--color-flagblue) px-4 py-2 text-sm text-white disabled:opacity-40">Publish</button>
      {dirty && <span className="self-center text-xs font-medium text-amber-700">Unsaved changes</span>}
    </>
  );

  return (
    <div className="rounded-xl border border-blue-100 bg-white shadow-sm" data-document-id={documentId ?? undefined}>
      <div className="flex flex-wrap items-center justify-between gap-3 border-b border-gray-100 px-4 py-3">
        <div><strong className="text-sm">{locale === "en" ? "English" : "Spanish"} structured biography</strong><p className="text-xs text-gray-500">{initial ? `${status} · revision ${revision}` : "No structured document exists yet"}</p></div>
        <span className="rounded border bg-gray-50 px-2 py-1 text-xs font-medium capitalize text-gray-600">{status}</span>
      </div>
      <div role="toolbar" aria-label={t("toolbarLabel")} className="flex flex-wrap items-center gap-1 border-b bg-gray-50 p-2">
        <div className="flex flex-wrap gap-1" aria-label={t("blockStylesGroup")}>
          <button type="button" title={t("paragraph")} aria-label={t("paragraph")} aria-pressed={editor.isActive("paragraph")} onClick={() => editor.chain().focus().setParagraph().run()} className={`${toolClass} ${editor.isActive("paragraph") ? "bg-blue-100" : ""}`}><AlignLeft size={16}/></button>
          <button type="button" title={t("heading2")} aria-label={t("heading2")} aria-pressed={editor.isActive("heading", { level: 2 })} onClick={() => editor.chain().focus().toggleHeading({ level: 2 }).run()} className={`${toolClass} ${editor.isActive("heading", { level: 2 }) ? "bg-blue-100" : ""}`}><Heading2 size={16}/></button>
          <button type="button" title={t("heading3")} aria-label={t("heading3")} aria-pressed={editor.isActive("heading", { level: 3 })} onClick={() => editor.chain().focus().toggleHeading({ level: 3 }).run()} className={`${toolClass} ${editor.isActive("heading", { level: 3 }) ? "bg-blue-100" : ""}`}><Heading3 size={16}/></button>
          <button type="button" title={t("heading4")} aria-label={t("heading4")} aria-pressed={editor.isActive("heading", { level: 4 })} onClick={() => editor.chain().focus().toggleHeading({ level: 4 }).run()} className={`${toolClass} ${editor.isActive("heading", { level: 4 }) ? "bg-blue-100" : ""}`}><Heading4 size={16}/></button>
        </div>
        <span aria-hidden="true" className="mx-1 h-6 w-px bg-gray-200"/>
        <div className="flex gap-1" aria-label={t("inlineGroup")}>
          <button type="button" title={t("bold")} aria-label={t("bold")} aria-pressed={editor.isActive("bold")} onClick={() => editor.chain().focus().toggleBold().run()} className={`${toolClass} ${editor.isActive("bold") ? "bg-blue-100" : ""}`}><Bold size={16}/></button>
          <button type="button" title={t("italic")} aria-label={t("italic")} aria-pressed={editor.isActive("italic")} onClick={() => editor.chain().focus().toggleItalic().run()} className={`${toolClass} ${editor.isActive("italic") ? "bg-blue-100" : ""}`}><Italic size={16}/></button>
        </div>
        <span aria-hidden="true" className="mx-1 h-6 w-px bg-gray-200"/>
        <div className="flex flex-wrap gap-1" aria-label={t("structureGroup")}>
          <button type="button" title={t("bulletList")} aria-label={t("bulletList")} aria-pressed={editor.isActive("bulletList")} onClick={() => editor.chain().focus().toggleBulletList().run()} className={`${toolClass} ${editor.isActive("bulletList") ? "bg-blue-100" : ""}`}><List size={16}/></button>
          <button type="button" title={t("numberedList")} aria-label={t("numberedList")} aria-pressed={editor.isActive("orderedList")} onClick={() => editor.chain().focus().toggleOrderedList().run()} className={`${toolClass} ${editor.isActive("orderedList") ? "bg-blue-100" : ""}`}><ListOrdered size={16}/></button>
          <button type="button" title={t("decreaseIndent")} aria-label={t("decreaseIndent")} disabled={!editor.can().liftListItem("listItem")} onClick={() => editor.chain().focus().liftListItem("listItem").run()} className={toolClass}><IndentDecrease size={16}/></button>
          <button type="button" title={t("increaseIndent")} aria-label={t("increaseIndent")} disabled={!editor.can().sinkListItem("listItem")} onClick={() => editor.chain().focus().sinkListItem("listItem").run()} className={toolClass}><IndentIncrease size={16}/></button>
          <button type="button" title={t("blockquote")} aria-label={t("blockquote")} aria-pressed={editor.isActive("blockquote")} onClick={() => editor.chain().focus().toggleBlockquote().run()} className={`${toolClass} ${editor.isActive("blockquote") ? "bg-blue-100" : ""}`}><Quote size={16}/></button>
          <button type="button" title={t("horizontalRule")} aria-label={t("horizontalRule")} onClick={() => editor.chain().focus().setHorizontalRule().run()} className={toolClass}><Minus size={16}/></button>
        </div>
        <span aria-hidden="true" className="mx-1 h-6 w-px bg-gray-200"/>
        <div className="flex flex-wrap gap-1" aria-label={t("linksGroup")}>
          <button type="button" title={t("addEditLink")} aria-label={t("addEditLink")} aria-pressed={editor.isActive("link")} disabled={editor.state.selection.empty && !editor.isActive("link")} onClick={openLinkEditor} className={`${toolClass} ${editor.isActive("link") ? "bg-blue-100" : ""}`}><Link2 size={16}/></button>
          <button type="button" title={t("removeLink")} aria-label={t("removeLink")} disabled={!editor.isActive("link")} onClick={() => editor.chain().focus().extendMarkRange("link").unsetLink().run()} className={toolClass}><Unlink size={16}/></button>
          <button type="button" title={t("artistReference")} aria-label={t("artistReference")} onClick={() => setSearchOpen(true)} className={toolClass}><AtSign size={16}/></button>
        </div>
        <span aria-hidden="true" className="mx-1 h-6 w-px bg-gray-200"/>
        <button type="button" title={t("clearFormatting")} aria-label={t("clearFormatting")} disabled={editor.state.selection.empty} onClick={() => editor.chain().focus().unsetAllMarks().clearNodes().run()} className={toolClass}><RemoveFormatting size={16}/></button>
        <span aria-hidden="true" className="mx-1 h-6 w-px bg-gray-200"/>
        <div className="flex gap-1" aria-label={t("historyGroup")}>
          <button type="button" title={t("undo")} aria-label={t("undo")} disabled={!editor.can().undo()} onClick={() => editor.chain().focus().undo().run()} className={toolClass}><Undo2 size={16}/></button>
          <button type="button" title={t("redo")} aria-label={t("redo")} disabled={!editor.can().redo()} onClick={() => editor.chain().focus().redo().run()} className={toolClass}><Redo2 size={16}/></button>
          <button type="button" title={t("preview")} aria-label={t("preview")} aria-pressed={preview} onClick={() => setPreview((value) => !value)} className={toolClass}><Eye size={16}/></button>
        </div>
      </div>
      {linkEditor && <div className="m-3 rounded-lg border border-blue-100 bg-blue-50 p-3"><label className="text-xs font-medium" htmlFor={`editorial-link-${locale}`}>{t("linkUrl")}</label><div className="mt-1 flex flex-col gap-2 sm:flex-row"><input id={`editorial-link-${locale}`} type="url" autoFocus value={linkEditor.href} onChange={(event) => { setLinkEditor({ ...linkEditor, href: event.target.value }); setLinkError(""); }} onKeyDown={(event) => { if (event.key === "Enter") { event.preventDefault(); applyLink(); } if (event.key === "Escape") setLinkEditor(null); }} placeholder="https://example.com" className="min-w-0 flex-1 rounded border bg-white px-3 py-2 text-sm"/><button type="button" onClick={applyLink} className="rounded bg-(--color-flagblue) px-3 py-2 text-sm text-white">{t("applyLink")}</button><button type="button" onClick={() => setLinkEditor(null)} className="rounded border bg-white px-3 py-2 text-sm">{t("cancel")}</button></div>{linkError && <p role="alert" className="mt-2 text-xs text-red-700">{linkError}</p>}</div>}
      {searchOpen && <div className="relative z-20 mx-3 mt-3"><ArtistCombobox initialQuery={selectedReference?.displayText ?? ""} onSelect={selectArtist} onCancel={() => setSearchOpen(false)}/></div>}
      {selectedReference && <div className="m-3 rounded-lg border border-blue-100 bg-blue-50 p-3"><label className="text-xs font-medium">Visible wording<input value={selectedReference.displayText} onChange={(event) => { const displayText=event.target.value; setSelectedReference({...selectedReference,displayText}); editor.chain().focus().updateArtistReference({displayText}).run(); }} className="mt-1 block w-full rounded border bg-white px-2 py-1 text-sm"/></label><div className="mt-2 flex gap-2"><button type="button" onClick={() => setSearchOpen(true)} className="rounded border bg-white px-2 py-1 text-xs">Change target</button><button type="button" onClick={() => editor.chain().focus().removeArtistReferencePreservingText().run()} className="rounded border bg-white px-2 py-1 text-xs">Remove link, keep text</button></div></div>}
      <div className="max-h-[60vh] min-h-56 overflow-y-auto overscroll-contain [scrollbar-gutter:stable] supports-[height:100dvh]:max-h-[60dvh]">
        {preview ? <SafeEditorPreview document={editor.getJSON() as EditorialDocumentV1}/> : <EditorContent editor={editor}/>} 
      </div>
      {issues.length > 0 && <ul role="alert" className="mx-4 mb-3 list-disc pl-5 text-sm text-red-700">{issues.map((issue) => <li key={`${issue.path}:${issue.message}`}>{issue.path}: {issue.message}</li>)}</ul>}
      {stale ? (
        <p role="status" className="mx-4 mb-3 text-sm text-amber-800">A newer saved version exists. Copy any unsaved edits you want to keep, then reload the saved version before saving again.</p>
      ) : message && <p role="status" className="mx-4 mb-3 text-sm text-gray-700">{message}</p>}
      {stale && <button type="button" onClick={async () => { if (window.confirm("Reloading will replace your unsaved changes. Continue?")) await onReloadRequested(); }} className="mx-4 mb-3 inline-flex items-center gap-2 rounded border px-3 py-2 text-sm"><RotateCcw size={15}/>Reload saved version</button>}
      {actionsSlot
        ? createPortal(documentActions, actionsSlot)
        : <div className="flex flex-wrap gap-2 border-t p-3">{documentActions}</div>}
    </div>
  );
}

function SafeEditorPreview({ document }: { document: EditorialDocumentV1 }) {
  return <div aria-label="Biography preview" className="min-h-56 space-y-4 px-4 py-3 text-sm leading-7">{document.content.map(renderPreviewBlock)}</div>;
}

function renderPreviewText(node: EditorialTextNode): React.ReactNode {
  return (node.marks ?? []).reduceRight<React.ReactNode>((content, mark) => mark.type === "bold" ? <strong>{content}</strong> : mark.type === "italic" ? <em>{content}</em> : <a href={mark.attrs.href} target="_blank" rel="noopener noreferrer" className="text-blue-700 underline">{content}</a>, node.text);
}

function renderPreviewInline(node: EditorialInlineNode, index: number) {
  if (node.type === "hardBreak") return <br key={index}/>;
  if (node.type === "artistReference") return <span key={node.attrs.occurrenceId} className="rounded bg-blue-100 px-1 text-blue-900">{node.attrs.displayText}</span>;
  return <span key={index}>{renderPreviewText(node)}</span>;
}

function renderPreviewBlock(block: EditorialBlockNode, index: number): React.ReactNode {
  const inline = (block.type === "paragraph" || block.type === "heading") ? (block.content ?? []).map(renderPreviewInline) : null;
  if (block.type === "paragraph") return <p key={index}>{inline}</p>;
  if (block.type === "heading") {
    if (block.attrs.level === 2) return <h2 key={index} className="text-2xl font-semibold">{inline}</h2>;
    if (block.attrs.level === 3) return <h3 key={index} className="text-xl font-semibold">{inline}</h3>;
    return <h4 key={index} className="text-lg font-semibold">{inline}</h4>;
  }
  if (block.type === "horizontalRule") return <hr key={index} className="my-5 border-gray-200"/>;
  if (block.type === "blockquote") return <blockquote key={index} className="space-y-3 border-l-4 border-blue-200 pl-4 italic">{block.content.map(renderPreviewBlock)}</blockquote>;
  const children = block.content.map((item, itemIndex) => <li key={itemIndex}>{item.content.map(renderPreviewBlock)}</li>);
  const listClass = "my-4 pl-6 [&>li]:my-0 [&>li>p]:m-0 [&>li>ol]:my-0 [&>li>ul]:my-0";
  return block.type === "bulletList" ? <ul key={index} className={`list-disc ${listClass}`}>{children}</ul> : <ol key={index} start={block.attrs?.start} className={`list-decimal ${listClass}`}>{children}</ol>;
}
