"use client";

import Link from "next/link";
import { useState } from "react";
import type { FormEvent } from "react";
import { useSearchParams } from "next/navigation";
import { LockKeyhole, UserPlus } from "lucide-react";

export default function SignUpForm() {
  const searchParams = useSearchParams();
  const inviteToken = searchParams.get("invite") ?? "";
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState("");

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    const normalizedEmail = email.trim().toLowerCase();

    if (!normalizedEmail) {
      setMessage("Enter your invited admin email.");
      return;
    }

    setLoading(true);
    setMessage("");

    const response = await fetch("/api/auth/sign-up", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        email: normalizedEmail,
        password,
        inviteToken,
      }),
    });
    const result = (await response.json()) as {
      ok?: boolean;
      message?: string;
      error?: string;
    };

    setLoading(false);
    setMessage(result.message || result.error || "Signup request finished.");

    if (response.ok && result.ok) {
      setPassword("");
    }
  }

  return (
    <form
      onSubmit={handleSubmit}
      className="w-full max-w-md rounded-xl border border-black/5 bg-white p-6 shadow-sm sm:p-8"
    >
      <div className="flex h-11 w-11 items-center justify-center rounded-lg bg-[#002D62]/8 text-[#002D62]">
        <LockKeyhole className="h-5 w-5" aria-hidden={true} />
      </div>

      <div className="mt-6">
        <p className="text-xs font-medium uppercase tracking-[0.2em] text-[#CE1126]">
          Mangulina Admin
        </p>
        <h1 className="mt-2 text-3xl font-black uppercase tracking-tight text-[#002D62]">
          Create Account
        </h1>
        <p className="mt-3 text-sm leading-relaxed text-gray-600">
          {inviteToken
            ? "Use the invited email address to create your admin account."
            : "Signup requires an invite link from an existing admin."}
        </p>
      </div>

      <div className="mt-6 space-y-4">
        <label className="block">
          <span className="mb-1 block text-[10px] font-normal uppercase tracking-[0.18em] text-gray-400">
            Email
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
            Password
          </span>
          <input
            type="password"
            autoComplete="new-password"
            required
            minLength={8}
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
          <UserPlus className="h-4 w-4" aria-hidden={true} />
          {loading ? "Creating..." : "Create Account"}
        </button>

        <Link
          href="/admin/login"
          className="rounded-lg border border-[#CE1126]/25 bg-white px-4 py-3 text-center text-sm font-medium uppercase tracking-[0.16em] text-[#CE1126] transition hover:border-[#CE1126]"
        >
          Back to Sign In
        </Link>
      </div>
    </form>
  );
}
