# Staged indexing release gate

This workflow tests the production deployment named by Vercel's `vercel.deployment.ready` event before Vercel assigns public domains. It is separate from the existing public-site smoke check.

## Activation requirements

1. Review and merge the workflow and helper scripts onto main. Do not merge until the required Vercel check is configured or automatic production assignment is temporarily held by the account owner: Git main currently differs from the verified CLI production snapshot.
2. Create the GitHub environment `seo-release`, restrict deployment branches to `main`, and require a reviewer to approve the exact workflow commit before its credential is available.
3. The account owner creates a Vercel token with the least access needed to read this team's deployment metadata and adds it directly as the protected environment secret `VERCEL_TOKEN`. Never copy local CLI credentials into CI or paste a token into chat. The token is exposed only to the verification step; no npm installation runs in that job.
4. In Vercel Trusted Sources, approve GitHub Actions with repository `paulinofrank/mangulina`, workflow name `Staged indexing release gate`, branch `main`, audience `https://github.com/paulinofrank`, and production access only. This is a persistent permission to read protected deployment responses from that exact workload. The API verifier must succeed before a short-lived OIDC identity is used.
5. Enable Vercel's ready repository-dispatch events. In Deployment Checks, require the commit status `Mangulina staged SEO (production)`. Do not select the existing public-site smoke check as the staged release gate. Keep production auto-assignment on when the required check is configured.
6. Stage a known failing production deployment and verify that it stays off all public domains. Then stage the verified application source and verify that all seven checks pass and that only that build is promoted. Do not force-promote a failing deployment to complete setup.

The gate is not active until these steps and the end-to-end release test have completed. Missing credentials or an identity mismatch cannot produce a successful release status. A failed, canceled, or skipped test reports failure after successful identity verification.

## Trust boundaries

The verifier fetches metadata from the fixed Vercel API host and checks team, project, production environment, READY state, repository ID, main branch, SHA and immutable URL. The test job executes the harness from the workflow's main commit, not the deployed application's commit, and gets only a short-lived OIDC identity. Authenticated test requests cannot follow redirects. The status-writing job executes no repository code and reports the actual test outcome on the API-verified deployment SHA.

Vercel adds `X-Robots-Tag: noindex` to immutable deployment hostnames. The staged check therefore checks indexing directives in the application's HTML, matching the existing CLI staging check. The public-origin check additionally checks response headers. A platform staging header must not falsely block an otherwise indexable public page.

GitHub-backed Vercel checks are commit statuses. Concurrent deployments from the same commit can share status history; the workflow serializes runs for a commit, but this is not a per-deployment cryptographic attestation. CLI or owner force-promotion can bypass hosting checks. Continue using the explicit staged check before any manual CLI promotion.

## Verification completed before publication

Ten validator tests cover acceptance and rejection of wrong project, team, environment, readiness, hostname, URL, SHA, branch and repository. The existing HTML harness rejected the older Git deployment because the archive heading was absent from its HTML. The known-good production deployment remains `dpl_53oYBbHdwpLehHJuynAZXLBX89Z6`.

## Activation status

The account owner added `VERCEL_TOKEN` directly to the `seo-release` environment. The environment requires review by `paulinofrank` and permits main only. After explicit owner approval, the production Trusted Sources grant was saved with the repository, workflow, branch and audience restrictions above. Vercel now requires `Mangulina staged SEO (production)` before production publication. End-to-end failed-build hold and passing-build release verification are still pending; those results must be recorded before declaring setup complete.
