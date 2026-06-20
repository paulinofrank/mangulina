import { Suspense } from "react";
import Link from "next/link";
import { getTranslations } from "next-intl/server";
import SignUpForm from "./SignUpForm";

export default async function AdminSignUpPage() {
  const t = await getTranslations("pages");

  return (
    <main className="flex min-h-screen items-center justify-center bg-gray-50 px-5 py-10 font-sans text-gray-900">
      <div className="w-full max-w-md">
        <Suspense
          fallback={
            <div className="h-96 rounded-xl border border-black/5 bg-white shadow-sm" />
          }
        >
          <SignUpForm />
        </Suspense>

        <div className="mt-4 text-center">
          <Link
            href="/"
            className="text-xs font-medium uppercase tracking-[0.18em] text-gray-500 transition hover:text-[#CE1126]"
          >
            {t("signup.backToHomepage")}
          </Link>
        </div>
      </div>
    </main>
  );
}
