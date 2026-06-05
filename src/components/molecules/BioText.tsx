import type { ReactNode } from "react";

type BioTextProps = {
  bio: string | null | undefined;
};

function parseInline(text: string): ReactNode[] {
  const parts: ReactNode[] = [];
  const pattern = /(\[([^\]]+)\]\((https?:\/\/[^)\s]+)\)|\*\*([^*]+)\*\*|\*([^*]+)\*)/g;
  let lastIndex = 0;
  let match: RegExpExecArray | null;

  while ((match = pattern.exec(text)) !== null) {
    if (match.index > lastIndex) {
      parts.push(text.slice(lastIndex, match.index));
    }

    if (match[2] && match[3]) {
      parts.push(
        <a
          key={match.index}
          href={match[3]}
          target="_blank"
          rel="noopener noreferrer"
          className="text-(--color-flagblue) underline-offset-4 hover:text-(--color-wikicrimson) hover:underline"
        >
          {match[2]}
        </a>
      );
    } else if (match[4]) {
      parts.push(<strong key={match.index}>{match[4]}</strong>);
    } else if (match[5]) {
      parts.push(<em key={match.index}>{match[5]}</em>);
    }

    lastIndex = pattern.lastIndex;
  }

  if (lastIndex < text.length) {
    parts.push(text.slice(lastIndex));
  }

  return parts;
}

function renderInlineLines(lines: string[]) {
  return lines.map((line, index) => (
    <span key={index}>
      {parseInline(line)}
      {index < lines.length - 1 && <br />}
    </span>
  ));
}

export default function BioText({ bio }: BioTextProps) {
  if (!bio?.trim()) return null;

  const blocks = bio
    .replace(/\r\n/g, "\n")
    .split(/\n\s*\n/)
    .map((block) => block.trim())
    .filter(Boolean);

  return (
    <div className="min-w-0 space-y-4 text-sm leading-relaxed text-gray-700 [overflow-wrap:anywhere] sm:text-base">
      {blocks.map((block, index) => {
        const lines = block.split("\n").map((line) => line.trimEnd());
        const firstLine = lines[0]?.trim() ?? "";

        if (firstLine.startsWith("## ")) {
          return (
            <h4
              key={index}
            className="pt-2 text-base font-semibold leading-snug text-(--color-flagblue) [overflow-wrap:anywhere] sm:text-lg"
            >
              {parseInline(firstLine.replace(/^##\s+/, ""))}
            </h4>
          );
        }

        if (lines.every((line) => line.trim().startsWith("- "))) {
          return (
            <ul key={index} className="list-disc space-y-1 pl-5">
              {lines.map((line, lineIndex) => (
                <li key={lineIndex}>{parseInline(line.trim().replace(/^-\s+/, ""))}</li>
              ))}
            </ul>
          );
        }

        if (lines.every((line) => line.trim().startsWith("> "))) {
          return (
            <blockquote
              key={index}
              className="border-l-2 border-(--color-flagblue)/25 pl-4 italic text-gray-600"
            >
              {renderInlineLines(lines.map((line) => line.trim().replace(/^>\s+/, "")))}
            </blockquote>
          );
        }

          return <p key={index} className="min-w-0 [overflow-wrap:anywhere]">{renderInlineLines(lines)}</p>;
      })}
    </div>
  );
}
