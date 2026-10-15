"use client";

import {
  AlertTriangle,
  ArrowLeft,
  CheckCircle2,
  Info,
  RefreshCw,
  ShieldCheck,
} from "lucide-react";
import { useTranslations } from "next-intl";
import { useCallback, useEffect, useState } from "react";

import { Link } from "@/i18n/navigation";

export type IntegrityFinding = {
  code: string;
  severity: "blocking" | "warning" | "informational";
  documentId?: string;
  ownerArtistId?: string;
  locale?: string;
  occurrenceId?: string;
  detail?: string;
};

export type IntegrityReport = {
  generatedAt: string;
  counts: {
    documents: number;
    relations: number;
    blocking: number;
    warning: number;
    informational: number;
  };
  findings: IntegrityFinding[];
};

export type ReportState =
  | { status: "loading" }
  | { status: "error" }
  | { status: "success"; report: IntegrityReport };

export default function EditorialIntegrityPage() {
  const [state, setState] = useState<ReportState>({ status: "loading" });

  const loadReport = useCallback(async () => {
    setState({ status: "loading" });
    try {
      setState({ status: "success", report: await fetchIntegrityReport() });
    } catch {
      setState({ status: "error" });
    }
  }, []);

  useEffect(() => {
    let active = true;

    void fetchIntegrityReport()
      .then((report) => {
        if (active) setState({ status: "success", report });
      })
      .catch(() => {
        if (active) setState({ status: "error" });
      });

    return () => {
      active = false;
    };
  }, []);

  return <EditorialIntegrityContent state={state} onRetry={loadReport} />;
}

async function fetchIntegrityReport(): Promise<IntegrityReport> {
  const response = await fetch("/api/admin/editorial-integrity");
  const body = (await response.json()) as {
    ok?: boolean;
    report?: IntegrityReport;
  };

  if (!response.ok || !body.ok || !body.report) {
    throw new Error("Integrity report request failed");
  }

  return body.report;
}

export function EditorialIntegrityContent({
  state,
  onRetry,
}: {
  state: ReportState;
  onRetry: () => void;
}) {
  const t = useTranslations("admin.editorialIntegrity");
  const adminT = useTranslations("admin");

  return (
    <main className="min-h-screen bg-gray-50 px-5 pb-10 pt-8 font-sans text-gray-900 sm:px-6 sm:pb-12 sm:pt-10">
      <div className="mx-auto max-w-6xl">
        <header className="mb-8 rounded-xl border border-black/5 bg-white p-6 shadow-sm sm:p-8">
          <div className="flex flex-col gap-5 sm:flex-row sm:items-start sm:justify-between">
            <div>
              <p className="text-xs font-medium uppercase tracking-[0.22em] text-[#CE1126]">
                {adminT("ui.branding")}
              </p>
              <h1 className="mt-3 text-3xl font-black uppercase tracking-tight text-[#002D62] sm:text-4xl">
                {t("title")}
              </h1>
              <p className="mt-4 max-w-3xl text-sm leading-relaxed text-gray-600 sm:text-base">
                {t("description")}
              </p>
            </div>

            <Link
              href="/admin"
              className="inline-flex w-fit shrink-0 items-center gap-2 rounded-lg border border-gray-200 bg-white px-4 py-2 text-xs font-normal uppercase tracking-[0.18em] text-[#002D62] shadow-sm transition hover:border-[#CE1126] hover:text-[#CE1126]"
            >
              <ArrowLeft className="h-4 w-4" aria-hidden="true" />
              {t("backToPortal")}
            </Link>
          </div>
        </header>

        {state.status === "loading" && <LoadingState />}
        {state.status === "error" && <ErrorState onRetry={onRetry} />}
        {state.status === "success" && <ReportResults report={state.report} />}
      </div>
    </main>
  );
}

function LoadingState() {
  const t = useTranslations("admin.editorialIntegrity");

  return (
    <section
      aria-live="polite"
      className="rounded-xl border border-black/5 bg-white p-6 shadow-sm sm:p-8"
    >
      <div className="flex items-center gap-3 text-[#002D62]">
        <RefreshCw className="h-5 w-5 animate-spin" aria-hidden="true" />
        <p className="text-sm font-medium">{t("loading")}</p>
      </div>
    </section>
  );
}

function ErrorState({ onRetry }: { onRetry: () => void }) {
  const t = useTranslations("admin.editorialIntegrity");

  return (
    <section
      role="alert"
      className="rounded-xl border border-red-200 bg-white p-6 shadow-sm sm:p-8"
    >
      <div className="flex items-start gap-4">
        <AlertTriangle className="mt-0.5 h-6 w-6 shrink-0 text-red-700" aria-hidden="true" />
        <div className="min-w-0">
          <h2 className="text-lg font-semibold text-red-900">{t("errorTitle")}</h2>
          <p className="mt-2 text-sm leading-relaxed text-gray-600">{t("errorDescription")}</p>
          <button
            type="button"
            onClick={onRetry}
            className="mt-5 inline-flex items-center gap-2 rounded-lg bg-[#002D62] px-4 py-2 text-xs font-medium uppercase tracking-[0.18em] text-white transition hover:bg-[#CE1126]"
          >
            <RefreshCw className="h-4 w-4" aria-hidden="true" />
            {t("retry")}
          </button>
        </div>
      </div>
    </section>
  );
}

function ReportResults({ report }: { report: IntegrityReport }) {
  const t = useTranslations("admin.editorialIntegrity");
  const summary = [
    ["documents", report.counts.documents],
    ["references", report.counts.relations],
    ["blocking", report.counts.blocking],
    ["warnings", report.counts.warning],
    ["informational", report.counts.informational],
  ] as const;

  return (
    <div className="space-y-6">
      <section aria-labelledby="report-summary-heading">
        <div className="flex flex-col gap-2 sm:flex-row sm:items-end sm:justify-between">
          <div>
            <p className="text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
              {t("reportEyebrow")}
            </p>
            <h2 id="report-summary-heading" className="mt-2 text-xl font-semibold text-[#002D62]">
              {t("summaryTitle")}
            </h2>
          </div>
          <p className="text-xs text-gray-500">
            {t("generatedAt", { value: report.generatedAt })}
          </p>
        </div>

        <div className="mt-4 grid grid-cols-2 gap-3 sm:grid-cols-3 lg:grid-cols-5">
          {summary.map(([key, value]) => (
            <div key={key} className="min-w-0 rounded-xl border border-black/5 bg-white p-4 shadow-sm">
              <p className="break-words text-xs font-medium uppercase tracking-[0.14em] text-gray-500">
                {t(`summary.${key}`)}
              </p>
              <p className="mt-2 text-2xl font-bold tabular-nums text-[#002D62]">{value}</p>
            </div>
          ))}
        </div>
      </section>

      {report.findings.length === 0 ? (
        <section className="rounded-xl border border-emerald-200 bg-emerald-50/70 p-6 shadow-sm sm:p-8">
          <div className="flex flex-col gap-4 sm:flex-row sm:items-start">
            <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-full bg-emerald-100 text-emerald-700">
              <CheckCircle2 className="h-7 w-7" aria-hidden="true" />
            </div>
            <div>
              <h2 className="text-xl font-semibold text-emerald-950">{t("healthyTitle")}</h2>
              <p className="mt-2 max-w-3xl text-sm leading-relaxed text-emerald-900/80 sm:text-base">
                {t("healthyDescription")}
              </p>
              <p className="mt-4 inline-flex items-center gap-2 rounded-full bg-white/80 px-3 py-1.5 text-xs font-medium text-emerald-800">
                <ShieldCheck className="h-4 w-4" aria-hidden="true" />
                {t("cleanReport")}
              </p>
            </div>
          </div>
        </section>
      ) : (
        <Findings findings={report.findings} />
      )}
    </div>
  );
}

function Findings({ findings }: { findings: IntegrityFinding[] }) {
  const t = useTranslations("admin.editorialIntegrity");
  const groups = (["blocking", "warning", "informational"] as const)
    .map((severity) => ({ severity, findings: findings.filter((item) => item.severity === severity) }))
    .filter((group) => group.findings.length > 0);

  return (
    <section aria-labelledby="findings-heading" className="space-y-5">
      <div>
        <p className="text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
          {t("findingsEyebrow")}
        </p>
        <h2 id="findings-heading" className="mt-2 text-xl font-semibold text-[#002D62]">
          {t("findingsTitle")}
        </h2>
      </div>

      {groups.map((group) => (
        <div key={group.severity}>
          <h3 className="mb-3 flex items-center gap-2 text-sm font-semibold text-gray-800">
            {group.severity === "informational" ? (
              <Info className="h-4 w-4 text-blue-700" aria-hidden="true" />
            ) : (
              <AlertTriangle
                className={`h-4 w-4 ${group.severity === "blocking" ? "text-red-700" : "text-amber-700"}`}
                aria-hidden="true"
              />
            )}
            {t(`severity.${group.severity}`)} ({group.findings.length})
          </h3>
          <div className="grid gap-3">
            {group.findings.map((finding, index) => (
              <FindingCard key={`${finding.code}:${finding.documentId ?? index}`} finding={finding} />
            ))}
          </div>
        </div>
      ))}
    </section>
  );
}

function FindingCard({ finding }: { finding: IntegrityFinding }) {
  const t = useTranslations("admin.editorialIntegrity");

  return (
    <article className="min-w-0 rounded-xl border border-black/5 bg-white p-5 shadow-sm">
      <div className="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
        <div className="min-w-0">
          <p className="break-words font-mono text-xs text-gray-500">{finding.code}</p>
          <p className="mt-2 break-words text-sm leading-relaxed text-gray-800">
            {finding.detail || t("detailUnavailable")}
          </p>
        </div>
        <span className={`w-fit shrink-0 rounded-full px-3 py-1 text-xs font-semibold ${severityClass[finding.severity]}`}>
          {t(`severity.${finding.severity}`)}
        </span>
      </div>

      <dl className="mt-4 grid gap-3 border-t border-gray-100 pt-4 text-sm sm:grid-cols-2 lg:grid-cols-3">
        <FindingField label={t("fields.owner")} value={finding.ownerArtistId}>
          {finding.ownerArtistId ? (
            <Link
              href={`/admin/artists?artistId=${encodeURIComponent(finding.ownerArtistId)}`}
              className="break-all font-medium text-[#002D62] underline decoration-[#002D62]/25 underline-offset-2 hover:text-[#CE1126]"
            >
              {finding.ownerArtistId}
            </Link>
          ) : undefined}
        </FindingField>
        <FindingField label={t("fields.locale")} value={finding.locale} />
        <FindingField label={t("fields.occurrence")} value={finding.occurrenceId} />
      </dl>
    </article>
  );
}

function FindingField({
  label,
  value,
  children,
}: {
  label: string;
  value?: string;
  children?: React.ReactNode;
}) {
  return (
    <div className="min-w-0">
      <dt className="text-xs font-medium uppercase tracking-[0.12em] text-gray-400">{label}</dt>
      <dd className="mt-1 break-all text-gray-700">{children ?? value ?? "—"}</dd>
    </div>
  );
}

const severityClass = {
  blocking: "bg-red-100 text-red-800",
  warning: "bg-amber-100 text-amber-900",
  informational: "bg-blue-100 text-blue-800",
};
