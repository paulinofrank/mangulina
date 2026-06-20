"use client";

import { useMemo, useState } from "react";
import type { FormEvent } from "react";
import Link from "next/link";
import { useRouter, useSearchParams } from "next/navigation";
import { useTranslations } from "next-intl";
import { LockKeyhole, LogIn } from "lucide-react";
import { createBrowserClient } from "@supabase/auth-helpers-nextjs";
import { getSupabasePublicConfig } from "@/lib/supabaseConfig";

function sanitizeNextPath(value: string | null) {
  if (!value || !value.startsWith("/") || value.startsWith("//")) {
    return "/admin";
  }

  return value;
}

export default function LoginForm() {
  const t = useTranslations();
  const router = useRouter();
  const searchParams = useSearchParams();
  const nextPath = sanitizeNextPath(searchParams.get("next"));
  const callbackMessage = searchParams.get("message");
  const supabase = useMemo(() => {
    const { supabaseUrl, supabaseAnonKey } = getSupabasePublicConfig();
    return createBrowserClient(supabaseUrl, supabaseAnonKey);
  }, []);

  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState(callbackMessage ?? "");

  async function handlePasswordSignIn(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    const normalizedEmail = email.trim().toLowerCase();

    if (!normalizedEmail) {
      setMessage(t("auth.login.emailRequired"));
      return;
    }

    setLoading(true);
    setMessage("");

    const { error } = await supabase.auth.signInWithPassword({
      email: normalizedEmail,
      password,
    });

    setLoading(false);

    if (error) {
      setMessage(error.message);
      return;
    }

    router.replace(nextPath);
    router.refresh();
  }

  async function handleMagicLink() {
    const normalizedEmail = email.trim().toLowerCase();

    if (!normalizedEmail) {
      setMessage(t("auth.login.magicLinkEmailRequired"));
      return;
    }

    setLoading(true);
    setMessage("");

    const origin = window.location.origin;
    const { error } = await supabase.auth.signInWithOtp({
      email: normalizedEmail,
      options: {
        emailRedirectTo: `${origin}/auth/callback?next=${encodeURIComponent(nextPath)}`,
        shouldCreateUser: false,
      },
    });

    setLoading(false);
    setMessage(
      error
        ? error.message
        : t("auth.login.magicLinkSent"),
    );
  }

  return (
    <form
      onSubmit={handlePasswordSignIn}
      className="w-full max-w-md rounded-xl border border-black/5 bg-white p-6 shadow-sm sm:p-8"
    >
      <div className="flex h-11 w-11 items-center justify-center rounded-lg bg-[#002D62]/8 text-[#002D62]">
        <LockKeyhole className="h-5 w-5" aria-hidden={true} />
      </div>

      <div className="mt-6">
        <p className="text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
          {t("admin.ui.branding")}
        </p>
        <h1 className="mt-2 text-3xl font-black uppercase tracking-tight text-[#002D62]">
          {t("auth.login.title")}
        </h1>
      </div>

      <div className="mt-6 space-y-4">
        <label className="block">
          <span className="mb-1 block text-[10px] font-normal uppercase tracking-[0.18em] text-gray-400">
            {t("form.labels.email")}
          </span>
          <input
            type="email"
            autoComplete="email"
            required
            value={email}
            onChange={(event) => setEmail(event.target.value)}
            className="w-full rounded-lg border border-gray-200 bg-white px-3 py-3 text-sm text-gray-900 outline-none transition focus:border-[#002D62]"
          />
        </label>

        <label className="block">
          <span className="mb-1 block text-[10px] font-normal uppercase tracking-[0.18em] text-gray-400">
            {t("form.labels.password")}
          </span>
          <input
            type="password"
            autoComplete="current-password"
            value={password}
            onChange={(event) => setPassword(event.target.value)}
            className="w-full rounded-lg border border-gray-200 bg-white px-3 py-3 text-sm text-gray-900 outline-none transition focus:border-[#002D62]"
          />
        </label>
      </div>

      {message && (
        <p className="mt-4 rounded-lg border border-gray-100 bg-gray-50 px-3 py-2 text-sm text-gray-600">
          {message}
        </p>
      )}

      <div className="mt-6 grid gap-3">
        <button
          type="submit"
          disabled={loading}
          className="inline-flex items-center justify-center gap-2 rounded-lg bg-[#002D62] px-4 py-3 text-sm font-medium uppercase tracking-[0.16em] text-white transition hover:bg-[#CE1126] disabled:cursor-not-allowed disabled:opacity-50"
        >
          <LogIn className="h-4 w-4" aria-hidden={true} />
          {loading ? t("auth.login.signingIn") : t("auth.login.submitButton")}
        </button>

        <button
          type="button"
          onClick={handleMagicLink}
          disabled={loading}
          className="rounded-lg border border-[#CE1126]/25 bg-white px-4 py-3 text-sm font-medium uppercase tracking-[0.16em] text-[#CE1126] transition hover:border-[#CE1126] disabled:cursor-not-allowed disabled:opacity-50"
        >
          {t("auth.login.magicLinkButton")}
        </button>

        <Link
          href="/admin/sign-up"
          className="rounded-lg border border-gray-200 bg-white px-4 py-3 text-center text-sm font-medium uppercase tracking-[0.16em] text-gray-600 transition hover:border-[#002D62] hover:text-[#002D62]"
        >
          {t("auth.signup.linkButton")}
        </Link>
      </div>
    </form>
  );
}
