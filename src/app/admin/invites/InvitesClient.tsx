"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import type { FormEvent } from "react";
import { Clipboard, LinkIcon, RefreshCw, Send, Trash2, Users } from "lucide-react";

type AdminInvite = {
  id: string;
  email: string;
  role: string;
  expires_at: string;
  accepted_at: string | null;
  created_at: string;
};

type AdminMember = {
  id: string;
  email: string;
  role: string;
  status: string;
  created_at: string;
};

type InviteResponse = {
  ok: boolean;
  invites?: AdminInvite[];
  members?: AdminMember[];
  inviteUrl?: string;
  emailSent?: boolean;
  emailError?: string;
  error?: string;
};

function formatDate(value: string) {
  return new Intl.DateTimeFormat("en", {
    dateStyle: "medium",
    timeStyle: "short",
  }).format(new Date(value));
}

export default function InvitesClient() {
  const [email, setEmail] = useState("");
  const [role, setRole] = useState("editor");
  const [inviteUrl, setInviteUrl] = useState("");
  const [invites, setInvites] = useState<AdminInvite[]>([]);
  const [members, setMembers] = useState<AdminMember[]>([]);
  const [loading, setLoading] = useState(false);
  const [status, setStatus] = useState("");

  async function loadAccess() {
    setLoading(true);
    const response = await fetch("/api/admin/invites");
    const result = (await response.json()) as InviteResponse;
    setLoading(false);

    if (!response.ok || !result.ok) {
      setStatus(result.error || "Unable to load admin access.");
      return;
    }

    setInvites(result.invites ?? []);
    setMembers(result.members ?? []);
  }

  async function createInvite(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();
    setLoading(true);
    setStatus("");
    setInviteUrl("");

    const response = await fetch("/api/admin/invites", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email: email.trim().toLowerCase(), role }),
    });
    const result = (await response.json()) as InviteResponse;
    setLoading(false);

    if (!response.ok || !result.ok || !result.inviteUrl) {
      setStatus(result.error || "Unable to create invite.");
      return;
    }

    setInviteUrl(result.inviteUrl);
    setEmail("");
    setStatus(
      result.emailSent
        ? "Invite email sent. The link is also available below."
        : `Invite link created, but email was not sent: ${
            result.emailError || "unknown email error"
          }`,
    );
    await loadAccess();
  }

  async function copyInvite() {
    if (!inviteUrl) return;
    await navigator.clipboard.writeText(inviteUrl);
    setStatus("Invite link copied.");
  }

  async function revokeInvite(invite: AdminInvite) {
    const confirmed = window.confirm(
      `Revoke the pending invite for ${invite.email}?`,
    );

    if (!confirmed) return;

    setLoading(true);
    setStatus("");

    const response = await fetch("/api/admin/invites", {
      method: "DELETE",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ inviteId: invite.id }),
    });
    const result = (await response.json()) as InviteResponse;
    setLoading(false);

    if (!response.ok || !result.ok) {
      setStatus(result.error || "Unable to revoke invite.");
      return;
    }

    setStatus("Pending invite revoked.");
    await loadAccess();
  }

  useEffect(() => {
    void loadAccess();
  }, []);

  return (
    <main className="min-h-screen bg-gray-50 px-5 pb-10 pt-8 font-sans text-gray-900 sm:px-6 sm:pb-12 sm:pt-10">
      <div className="mx-auto max-w-6xl">
        <header className="rounded-xl border border-black/5 bg-white p-6 shadow-sm sm:p-8">
          <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
            <div>
              <p className="text-xs font-medium uppercase tracking-[0.22em] text-[#CE1126]">
                Admin Access
              </p>
              <h1 className="mt-3 text-3xl font-black uppercase tracking-tight text-[#002D62] sm:text-4xl">
                Invites
              </h1>
            </div>

            <Link
              href="/admin"
              className="inline-flex w-fit items-center rounded-lg border border-[#CE1126]/25 bg-white px-4 py-2 text-xs font-medium uppercase tracking-[0.18em] text-[#CE1126] shadow-sm transition hover:border-[#CE1126] hover:bg-[#CE1126] hover:text-white"
            >
              Back to Admin
            </Link>
          </div>
        </header>

        <section className="mt-8 grid gap-5 lg:grid-cols-[minmax(0,0.9fr)_minmax(0,1.1fr)]">
          <form
            onSubmit={createInvite}
            className="rounded-xl border border-black/5 bg-white p-5 shadow-sm"
          >
            <div className="flex items-center gap-3">
              <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-[#002D62]/8 text-[#002D62]">
                <Send className="h-5 w-5" aria-hidden={true} />
              </div>
              <h2 className="text-lg font-semibold text-[#002D62]">
                Send Invite
              </h2>
            </div>

            <div className="mt-5 space-y-4">
              <label className="block">
                <span className="mb-1 block text-[10px] font-normal uppercase tracking-[0.18em] text-gray-400">
                  Email
                </span>
                <input
                  type="email"
                  required
                  value={email}
                  onChange={(event) => setEmail(event.target.value)}
                  className="w-full rounded-lg border border-gray-200 bg-white px-3 py-3 text-sm text-gray-900 outline-none transition focus:border-[#002D62]"
                />
              </label>

              <label className="block">
                <span className="mb-1 block text-[10px] font-normal uppercase tracking-[0.18em] text-gray-400">
                  Role
                </span>
                <select
                  value={role}
                  onChange={(event) => setRole(event.target.value)}
                  className="w-full rounded-lg border border-gray-200 bg-white px-3 py-3 text-sm text-gray-900 outline-none transition focus:border-[#002D62]"
                >
                  <option value="editor">Editor</option>
                  <option value="admin">Admin</option>
                  <option value="owner">Owner</option>
                </select>
              </label>
            </div>

            <button
              type="submit"
              disabled={loading}
              className="mt-5 inline-flex w-full items-center justify-center gap-2 rounded-lg bg-[#002D62] px-4 py-3 text-sm font-medium uppercase tracking-[0.16em] text-white transition hover:bg-[#CE1126] disabled:cursor-not-allowed disabled:opacity-50"
            >
              <LinkIcon className="h-4 w-4" aria-hidden={true} />
              Send Invite
            </button>

            {inviteUrl && (
              <div className="mt-5 rounded-lg border border-gray-100 bg-gray-50 p-3">
                <p className="break-all text-sm text-gray-700">{inviteUrl}</p>
                <button
                  type="button"
                  onClick={copyInvite}
                  className="mt-3 inline-flex items-center gap-2 rounded-lg border border-gray-200 bg-white px-3 py-2 text-xs font-medium uppercase tracking-[0.14em] text-gray-600 transition hover:border-[#002D62] hover:text-[#002D62]"
                >
                  <Clipboard className="h-4 w-4" aria-hidden={true} />
                  Copy
                </button>
              </div>
            )}

            {status && (
              <p className="mt-4 rounded-lg border border-gray-100 bg-gray-50 px-3 py-2 text-sm text-gray-600">
                {status}
              </p>
            )}
          </form>

          <section className="rounded-xl border border-black/5 bg-white p-5 shadow-sm">
            <div className="flex items-center justify-between gap-3">
              <div className="flex items-center gap-3">
                <div className="flex h-10 w-10 items-center justify-center rounded-lg bg-[#002D62]/8 text-[#002D62]">
                  <Users className="h-5 w-5" aria-hidden={true} />
                </div>
                <h2 className="text-lg font-semibold text-[#002D62]">
                  Members
                </h2>
              </div>

              <button
                type="button"
                onClick={loadAccess}
                disabled={loading}
                className="inline-flex h-10 w-10 items-center justify-center rounded-lg border border-gray-200 bg-white text-gray-600 transition hover:border-[#002D62] hover:text-[#002D62] disabled:opacity-50"
                aria-label="Refresh admin access"
              >
                <RefreshCw className="h-4 w-4" aria-hidden={true} />
              </button>
            </div>

            <div className="mt-5 overflow-hidden rounded-lg border border-gray-100">
              {members.length === 0 ? (
                <p className="px-4 py-5 text-sm text-gray-500">
                  No admin members found.
                </p>
              ) : (
                <div className="divide-y divide-gray-100">
                  {members.map((member) => (
                    <div
                      key={member.id}
                      className="grid gap-1 px-4 py-3 text-sm sm:grid-cols-[1fr_auto_auto]"
                    >
                      <span className="font-medium text-gray-800">
                        {member.email}
                      </span>
                      <span className="text-gray-500">{member.role}</span>
                      <span className="text-gray-500">{member.status}</span>
                    </div>
                  ))}
                </div>
              )}
            </div>
          </section>
        </section>

        <section className="mt-5 rounded-xl border border-black/5 bg-white p-5 shadow-sm">
          <h2 className="text-lg font-semibold text-[#002D62]">
            Recent Invites
          </h2>

          <div className="mt-5 overflow-hidden rounded-lg border border-gray-100">
            {invites.length === 0 ? (
              <p className="px-4 py-5 text-sm text-gray-500">
                No invites created yet.
              </p>
            ) : (
              <div className="divide-y divide-gray-100">
                {invites.map((invite) => (
                  <div
                    key={invite.id}
                    className="grid gap-2 px-4 py-3 text-sm lg:grid-cols-[1fr_auto_auto_auto_auto]"
                  >
                    <span className="font-medium text-gray-800">
                      {invite.email}
                    </span>
                    <span className="text-gray-500">{invite.role}</span>
                    <span className="text-gray-500">
                      {invite.accepted_at ? "Accepted" : "Pending"}
                    </span>
                    <span className="text-gray-500">
                      Expires {formatDate(invite.expires_at)}
                    </span>
                    {invite.accepted_at ? (
                      <span className="text-gray-400">-</span>
                    ) : (
                      <button
                        type="button"
                        onClick={() => revokeInvite(invite)}
                        disabled={loading}
                        className="inline-flex items-center justify-center gap-2 rounded-lg border border-red-200 bg-white px-3 py-2 text-xs font-medium uppercase tracking-[0.14em] text-red-700 transition hover:bg-red-700 hover:text-white disabled:cursor-not-allowed disabled:opacity-50"
                      >
                        <Trash2 className="h-4 w-4" aria-hidden={true} />
                        Revoke
                      </button>
                    )}
                  </div>
                ))}
              </div>
            )}
          </div>
        </section>
      </div>
    </main>
  );
}
