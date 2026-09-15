"use client";

import { useEffect, useRef, useState } from "react";
import { Check, Share2 } from "lucide-react";
import { useTranslations } from "next-intl";
import { shareOrCopy } from "@/lib/share";

type ShareButtonProps = {
  url: string;
  title: string;
  subject: string;
  placement: "facts" | "artwork";
};

function copyWithTextarea(value: string): boolean {
  const textarea = document.createElement("textarea");
  textarea.value = value;
  textarea.setAttribute("readonly", "");
  textarea.style.position = "fixed";
  textarea.style.opacity = "0";
  document.body.appendChild(textarea);
  textarea.select();
  try {
    return document.execCommand("copy");
  } finally {
    textarea.remove();
  }
}

async function copyToClipboard(value: string): Promise<boolean> {
  if (navigator.clipboard?.writeText) {
    try {
      await navigator.clipboard.writeText(value);
      return true;
    } catch {
      // Some browsers expose Clipboard API but reject it at runtime.
    }
  }
  return copyWithTextarea(value);
}

export default function ShareButton({ url, title, subject, placement }: ShareButtonProps) {
  const t = useTranslations("share");
  const [copied, setCopied] = useState(false);
  const resetTimer = useRef<ReturnType<typeof setTimeout> | null>(null);

  useEffect(() => () => {
    if (resetTimer.current) clearTimeout(resetTimer.current);
  }, []);

  const showCopiedConfirmation = () => {
    setCopied(true);
    if (resetTimer.current) clearTimeout(resetTimer.current);
    resetTimer.current = setTimeout(() => setCopied(false), 2200);
  };

  const handleShare = async () => {
    const outcome = await shareOrCopy(
      { title, text: t("text", { subject }), url },
      {
        share: navigator.share?.bind(navigator),
        copy: copyToClipboard,
      },
    );

    if (outcome === "copied") showCopiedConfirmation();
  };

  const buttonStyle = placement === "artwork"
    ? "absolute right-3 top-3 z-10 bg-white/95 text-[#002D62] shadow-md ring-1 ring-black/15 hover:bg-white sm:right-4 sm:top-4"
    : "shrink-0 border border-gray-200 bg-white text-gray-600 shadow-sm hover:border-gray-300 hover:bg-gray-50 hover:text-(--color-wikicrimson)";

  return (
    <div className={placement === "artwork" ? "contents" : "relative"}>
      <button
        type="button"
        onClick={handleShare}
        aria-label={copied ? t("linkCopied") : t("label")}
        title={copied ? t("linkCopied") : t("label")}
        className={`flex size-11 cursor-pointer items-center justify-center rounded-full transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-(--color-wikicrimson) ${buttonStyle}`}
      >
        {copied ? <Check className="size-5" aria-hidden="true" /> : <Share2 className="size-5" aria-hidden="true" />}
      </button>
      {copied && (
        <span
          role="status"
          className={`absolute z-20 whitespace-nowrap rounded-md bg-gray-950 px-2.5 py-1.5 text-xs font-medium text-white shadow-lg ${placement === "artwork" ? "right-3 top-16 sm:right-4 sm:top-17" : "right-0 top-13"}`}
        >
          {t("linkCopied")}
        </span>
      )}
    </div>
  );
}
