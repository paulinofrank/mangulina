# Composition credit removal — owner installation confirmed

On 2026-10-31 the owner reported applying the SQL. A read-only inspection of the
Mangulina database confirmed the exact five-argument RPC is installed, with an
empty search path, execution denied to `anon` and `authenticated`, and execution
allowed to `service_role`. Its definition includes the proposed capability,
identity, reason, governance, audit and idempotency checks. No removal was invoked
as part of this verification. Successful mutation and transactional rollback remain
untested against the installed function.

The local Works admin now offers **Remove credit**, a required reason, confirmation,
pending/error handling, and English/Spanish labels. Existing removed rows remain
visible as historical records with no removal button.

The endpoint calls `remove_editorial_work_credit` atomically. It never falls back to
direct writes. If the RPC is absent, it returns 503 with an explanation; no data or
cache is changed. Success refreshes the affected Work's songs and contributors
through the existing bounded helper. Concrete song paths now omit the `page` type.

## Human installation required

Review [remove-editorial-work-credit.sql](remove-editorial-work-credit.sql).
It is **PROPOSAL — NOT APPLIED**, outside the migrations directory, because
[SUPABASE_SECURITY_POLICY.md](../SUPABASE_SECURITY_POLICY.md) requires a human to
apply function-security and privilege changes. No new capability assignments are
proposed; the existing `credit.dispute` and `assertion.reject` checks restrict the
operation to suitably privileged staff. Application authorization is checked too.

The proposed transaction changes only the selected Work credit to `superseded`,
supersedes its assertions, and records the actor, reason, prior state and decision.
It retains evidence, contributor identity, the Work and recording relationships.
Wrong-Work IDs, missing reasons, already-removed rows and unauthorized actors fail.
Contested credits and Works linked to multiple recordings are held for independent
editorial approval rather than silently bypassing that gate. A separate reviewed
resolution is needed for those cases; this proposal does not implement that queue.

Existing public song context and composition portfolios exclude superseded credits.
Removing one role does not remove another role held by the same contributor.

## Validation and limitations

Local tests cover identity/reason validation, unavailable RPCs, permission errors,
and refresh ordering. The localhost UI was inspected using the existing signed-in
browser without submitting removal. Localhost uses the configured database, so its
page load can perform remote reads; no catalog mutations were used for testing.
No deployment, production-site navigation, or manual cache refresh was performed.

The SQL was applied by the owner; it has not been transaction-tested. A human must
verify service-only execution and run fixture-based integration checks for atomic
rollback, repeated/concurrent calls, preserved evidence, denied roles, governance
holds, and public projection results. The SQL file includes installation rollback.
Dropping the function does not reverse prior editorial decisions; those require
separate evidence review using the preserved previous state.
