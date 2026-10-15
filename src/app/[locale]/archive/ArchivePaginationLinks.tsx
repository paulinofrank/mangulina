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
  const pageLink = (page: number, label: string | number, disabled = false) => {
    const className = "rounded-lg border border-black/10 px-3 py-2 text-sm text-gray-600 transition hover:bg-gray-100";
    return disabled ? <span aria-disabled="true" className={className + " opacity-30"}>{label}</span> :
      <Link href={pageHref(page)} prefetch={false} scroll
        aria-current={page === currentPage ? "page" : undefined}
        className={className + (page === currentPage ? " font-semibold text-(--color-flagblue)" : "")}>
        {label}
      </Link>;
  };
  return <nav aria-label={t("songCatalog.pagination")} className="my-3 flex flex-wrap items-center justify-center gap-2 sm:my-7">
    {pageLink(1, t("pagination.first"), currentPage === 1)}
    {pageLink(currentPage - 1, t("pagination.previous"), currentPage === 1)}
    {pages.map(page => <span key={page}>{pageLink(page, page)}</span>)}
    {pageLink(currentPage + 1, t("pagination.next"), currentPage === totalPages)}
    {pageLink(totalPages, t("pagination.last"), currentPage === totalPages)}
  </nav>;
}
