"use client";

import React, { ReactNode, useEffect, useState } from "react";
import { AlertCircle, RotateCcw } from "lucide-react";
import { useTranslations } from "next-intl";

interface Props {
  children: ReactNode;
}

interface State {
  hasError: boolean;
  error: Error | null;
}

/**
 * Error boundary for analytics components
 * Catches errors and displays a user-friendly error message with retry option
 */
export class AnalyticsErrorBoundary extends React.Component<Props, State> {
  constructor(props: Props) {
    super(props);
    this.state = { hasError: false, error: null };
  }

  static getDerivedStateFromError(error: Error): State {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, errorInfo: React.ErrorInfo) {
    console.error("Analytics error boundary caught:", error, errorInfo);
  }

  handleReset = () => {
    this.setState({ hasError: false, error: null });
    // Optionally reload the page
    window.location.reload();
  };

  render() {
    if (this.state.hasError) {
      return <ErrorBoundaryContent error={this.state.error} onReset={this.handleReset} />;
    }

    return this.props.children;
  }
}

/**
 * Client component to display error boundary UI with translations
 */
function ErrorBoundaryContent({ error, onReset }: { error: Error | null; onReset: () => void }) {
  const t = useTranslations("admin.analytics");

  return (
    <div className="rounded-xl border border-[#CE1126]/20 bg-white p-6 shadow-sm sm:p-8">
      <div className="flex flex-col items-center text-center">
        <AlertCircle className="mb-4 h-12 w-12 text-[#CE1126]" />
        <h3 className="mb-2 text-lg font-semibold text-[#002D62]">
          Something went wrong
        </h3>
        <p className="mb-6 max-w-sm text-sm text-gray-600">
          {error?.message || t("failedToLoadGeneral")}
        </p>
        <button
          onClick={onReset}
          className="inline-flex items-center gap-2 rounded-lg bg-[#CE1126] px-4 py-2 text-sm font-medium text-white shadow-sm transition hover:bg-[#8B0000]"
        >
          <RotateCcw className="h-4 w-4" />
          Try Again
        </button>
      </div>
    </div>
  );
}
