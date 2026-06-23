"use client";

import { useEffect } from "react";

// The <html> element lives in the root layout, which is preserved across
// client-side navigations and therefore can't update `lang` when the locale
// segment changes. This keeps document.documentElement.lang in sync on the
// client so /es pages report lang="es" after an in-app language switch too.
export default function HtmlLangSync({ locale }: { locale: string }) {
  useEffect(() => {
    document.documentElement.lang = locale;
  }, [locale]);

  return null;
}
