"use client";
import { Link } from "@/i18n/navigation";
import type { useTranslations } from "next-intl";

export default function ArchivePaginationLinks({ currentPage, totalPages, pageHref, t }: {
  currentPage: number;
  totalPages: number;
  pageHref: (page: number) => string;
  t: ReturnType<typeof useTranslations>;
}) {
  if (totalPages <= 1) return null;
  const start = Math.min(Math.max(currentPage - 2, 1), Math.max(1, totalPages - 4));
  const pages = Array.from({ length: Math.min(5, totalPages) }, (_, index) => start + index);
  const mobileSize = Math.min(3, totalPages);
  const mobileStart = currentPage <= 3 ? 1 : Math.min(currentPage - 1, totalPages - mobileSize + 1);
  const mobilePages = Array.from({ length: mobileSize }, (_, index) => mobileStart + index);
  const ellipsis = <span aria-hidden="true" className="text-sm text-gray-400">...</span>;
  const pageLink = (page: number, label: string | number, disabled = false) => {
    const isCurrent = typeof label === "number" && page === currentPage;
    const className = "inline-block text-sm text-gray-500 transition sm:rounded-lg sm:border sm:border-black/10 sm:px-3 sm:py-2 sm:text-gray-600";
    return disabled ? <span aria-disabled="true" className={className + " opacity-30"}>{label}</span> :
      <Link href={pageHref(page)} prefetch={false} scroll
        aria-current={isCurrent ? "page" : undefined}
        className={`${className} underline-offset-4 hover:text-(--color-flagblue) hover:underline sm:hover:bg-gray-100 sm:hover:no-underline ${isCurrent ? "font-semibold text-(--color-flagblue) sm:text-(--color-flagblue)" : ""}`}>
        {label}
      </Link>;
  };
  const pageNumbers = pages.map(page => <span key={page}>{pageLink(page, page)}</span>);

  return <nav aria-label={t("songCatalog.pagination")} className="my-3 flex flex-wrap items-center justify-between gap-2 sm:my-7 sm:justify-center">
    <div className="flex gap-2 max-sm:px-1">
      {pageLink(1, t("pagination.first"), currentPage === 1)}
      {pageLink(currentPage - 1, t("pagination.previous"), currentPage === 1)}
    </div>
    <div className="hidden sm:flex sm:items-center sm:gap-2">{pageNumbers}</div>
    <div className="flex flex-1 items-center justify-center gap-1.5 sm:hidden">
      {mobileStart > 1 && ellipsis}
      {mobilePages.map(page => <span key={page}>{pageLink(page, page)}</span>)}
      {mobileStart + mobileSize - 1 < totalPages && ellipsis}
    </div>
    <div className="flex gap-2 max-sm:px-1">
      {pageLink(currentPage + 1, t("pagination.next"), currentPage === totalPages)}
      {pageLink(totalPages, t("pagination.last"), currentPage === totalPages)}
    </div>
  </nav>;
}
