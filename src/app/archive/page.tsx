// src/app/archive/page.tsx

import { Suspense } from "react";
import MainWrapper from "@/components/layout/MainWrapper";
import ArchiveClient from "./ArchiveClient";

export const revalidate = 3600;

export default function ArchivePage() {
  return (
    <MainWrapper>
      {/* ⭐ ARCHIVE INTERACTIVE CLIENT SECTION */}
      <Suspense fallback={null}>
        <ArchiveClient />
      </Suspense>
    </MainWrapper>
  );
}
