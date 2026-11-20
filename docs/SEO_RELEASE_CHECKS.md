# Indexing release checks

## Authorization and local checks

Follow [AI_PRODUCTION_USAGE_POLICY.md](AI_PRODUCTION_USAGE_POLICY.md). The commands below consume Vercel resources and apply only to a user-authorized release. This document does not itself authorize staging, deploying, promoting, or broad production verification. For routine local verification, use the supported explicit localhost origin (for example, `npm run check:seo -- --origin http://localhost:3000` after inspecting the script and local server configuration). Do not treat a local pass as production verification. Preserve the staged and post-promotion checks once the release is authorized, and run them once per release stage unless changes or failures justify a rerun.

Run from the linked, isolated Mangulina release checkout, after the production build is staged with `vercel deploy --prod --skip-domain` and before assigning the public domain:

```powershell
npm run check:seo -- --deployment https://STAGED-DEPLOYMENT.vercel.app
```

Use the actual staged URL. Stop if the command exits nonzero. Promote only the same tested production deployment. After promotion, run:

```powershell
npm run check:seo
```

The check requests HTML directly, without executing browser JavaScript, and fails for missing headings or recording links, incorrect canonical URLs, unexpected noindex directives, missing next/previous anchors, or page two repeating page one's records. It checks archive pages and the songs directory in English and Spanish, plus the internal search result policy.

`--deployment` uses the existing Vercel CLI authorization for the linked project. It does not change deployment protection or expose a bypass token. The public check uses `https://mangulina.do` by default; `--origin` supports another unprotected test server.

This is a repeatable release check, not an automatically configured GitHub/Vercel CI gate. A direct deployment can bypass it. Future public catalog releases should run it before promotion and after deployment. Keep unrelated local changes out of the release snapshot.

Google's indexing decisions are outside this check. Passing establishes technical behavior on these representative routes, not that Google has indexed them or every catalog page.
