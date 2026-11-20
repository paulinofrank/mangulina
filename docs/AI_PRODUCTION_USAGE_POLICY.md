# Mangulina AI workflow: minimize production usage

Effective October 19, 2026. Applies to Codex, Claude, Gemini/Antigravity, Copilot, Perplexity, and other assistants working on Mangulina.

## Default workflow

1. Read repository instructions and inspect local source first. Research with original external sources rather than repeatedly loading Mangulina production pages.
2. Develop, render, and verify on localhost with targeted local tests. Use fixtures or a local/development database where available. Do not provision a database, paid service, preview deployment, or new environment just to perform routine checks.
3. Inspect scripts before running them. A command called build, test, verify, dry-run, or check may still fetch production data, write records, invalidate caches, or default to mangulina.do. Set a supported local origin explicitly where appropriate. A local build can still query a remote database during prerendering.
4. Prefer a small verification set that covers the actual change and both relevant locales. Run required checks once after the final relevant change; repeat only for a new change, failure, or unresolved concern. Do not replace meaningful verification with an unsupported claim that the change works.
5. Finish by stating local checks performed, production requests/refreshes/deployments performed, and any production verification deferred. Never imply that local verification proves production behavior.

## Production authorization

- Production deployments, redeployments, promotions, rollbacks, and broad production verification require the user's explicit instruction for that action and scope. A request to fix, complete, research, or test a feature does not by itself authorize a production release.
- Do not create Vercel previews as the default substitute for localhost; they also consume infrastructure. Create one only when deployment is within the authorized task.
- Do not commit or push merely to save work or finish a task. A push to a connected branch can trigger a deployment. Before an explicitly requested push, inspect its deployment implications; obtain production-release authorization if it would trigger production deployment. Do not disable CI or change hosting configuration to avoid the gate.
- Broad verification includes catalog crawls, sitemap-wide checks, bulk URL checks, repeated full SEO suites, cache warming, and repeated production polling. Name the target set and request cap before an authorized run. Stop when the checks answer the question.
- When a requested task includes publishing or live verification, a small production spot-check may be used within that scope. Prefer at most three representative page navigations in one pass, covering the relevant locales where feasible; this is a target, not a claim that a browser page causes only one CDN request. Use request-only checks when they verify the behavior sufficiently. If the task is not about the live site, keep checks local.
- Existing approval remains valid for the action and scope actually authorized. Do not ask again for the same approved action, and do not stretch it into an unrelated release or crawl.

## Editorial and database work

- Database-only biographies, credits, discographies, social links, and metadata changes generally do not need a Vercel deployment. Do not bundle editorial database work with a release unless application/schema behavior actually requires one and the release is explicitly authorized.
- Preserve existing catalog-write, identity, draft/publication, shared-record, and security rules. This policy grants no new database permissions and does not alter Supabase security restrictions.
- Use the authorized admin save's existing targeted invalidation rather than adding a second manual refresh. Where an authorized public content change is written directly to the database and requires immediate freshness, collect the genuinely affected artist/song/release targets and perform one deduplicated targeted refresh after the meaningful batch, within that publication scope.
- Do not manually refresh production for draft-only preparation, local tests, research, or documentation. If public freshness was not authorized or cannot be verified, report the pending targeted refresh and possible stale content; do not claim publication is complete.
- Avoid `allArtists`, global portfolio tags, root/layout invalidation, cache purges, and catalog-wide warmups for a single-entity correction. A broad invalidation requires explicit user instruction and a stated reason, target scope, and expected impact. Existing admin routes may already fan out invalidation; inspect and report that behavior rather than silently changing it.
- Preserve related credits, canonical URLs, SEO, sitemap availability, indexing, and legitimate crawlers. Reduce duplicate work, not required correctness checks. Do not change TTLs, bot rules, analytics collection, billing, or budgets as an incidental cost-saving step.

## Production editorial batches

For an authorized production batch of artist profiles (fichas), biographies, or discography imports, use one writer at a time and set a finite batch and request limit before execution. Compare against existing records and skip identical writes. Stop the batch on a revision conflict (`409` or `40001`) and reconcile the saved revision before resuming. This also applies to scripts calling Supabase directly. For transient failures, use bounded backoff and verify whether an ambiguous write committed before replaying it. Stop on repeated failures or a production resource alert. Record the run's UTC start and end, scope, request and retry counts, and failure categories so the editor can correlate the run with Supabase metrics. In mixed batches, record separate time ranges and counts for profile, biography, and discography phases.

## Local work is not automatically free

Local source review and fixture-based tests use no Vercel hosting resources. Localhost connected to production Supabase can still consume database resources and may mutate production if the script writes. Production pages, preview deployments, public asset requests, refresh endpoints, and monitoring queries can consume remote resources. Never promise zero usage for a workflow that accesses remote services.

## Release checks

Release documentation describes how to execute an authorized release; it is not permission to deploy. When a release is authorized, retain the required staged and post-promotion SEO checks for relevant public catalog changes. Run the approved bounded suite once per release stage, inspect failures, and rerun only when justified. Local verification may use a supported explicit localhost origin, but it must not be presented as the required production release check.

## Completion note

Use a short truthful note, for example: "Verified locally with [checks]. Production: no deployment, cache refresh, or site requests. Deferred: [live checks, if any]." If production was accessed, state what was done and the scope instead. Keep a small changed-entity/refresh manifest when applicable; never log tokens, credentials, or private content unnecessarily.

This is a workflow instruction for assistants, not a technical block on deployment or billing. It does not change hosting settings, application code, or database behavior. An assistant must load these instructions to follow them.
