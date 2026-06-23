# Mangulina i18n — Audit Validation (Red-Team Review)

**Date:** June 20, 2026
**Purpose:** Challenge every conclusion in `I18N_FORENSIC_AUDIT.md` against actual repository evidence.
**Method:** Treat the prior audit as an unproven hypothesis. Verify with file paths and git history only.

---

## TL;DR — Verdict on the Original Audit

> The original audit's **diagnosis of the translation failure is correct**, but its **primary fix recommendation (“restore middleware”) is WRONG** and would not fix the `/es` 404s — and could break the currently-working English pages.

The single most important fact the original audit **missed**:

> **There is no `app/[locale]/` segment and no `app/es/` directory — and there never has been, not even in Phase 1.** Therefore `/es/*` URLs have *never* been routable. Restoring the old middleware does **not** create those routes. The `/es` 404 is a **missing-routes problem**, not a missing-middleware problem.

| # | Original Audit Claim | Verdict | Confidence |
|---|----------------------|---------|------------|
| 1 | middleware.ts is mandatory | **FALSE** | 95% |
| 2 | System cannot function without middleware | **FALSE / misleading** | 90% |
| 3 | request.ts must read `x-locale` headers | **FALSE** (bespoke, non-standard) | 97% |
| 4 | Spanish routes require middleware to resolve | **MISLEADING** (they require `[locale]` routing that doesn't exist) | 90% |
| 5 | Restoring middleware is the primary fix | **FALSE** (would not fix /es; risks breaking EN) | 85% |

---

## 1. Does next-intl 4.x Require Middleware?

### Evidence

next-intl 4.x supports **two officially documented architectures**:

**Architecture A — i18n routing (locale in the URL, e.g. `/es/artists`):**
- Requires `next-intl/middleware` (`createMiddleware`)
- Requires an `app/[locale]/` route segment that all pages live under
- Middleware **rewrites** `/es/artists` → internal `/[locale]/artists` and `/artists` → `/[locale]/artists` (default locale)
- Reference pattern: `app/[locale]/layout.tsx` + `middleware.ts` + `src/i18n/routing.ts`

**Architecture B — no i18n routing (locale from cookie/header, no URL prefix):**
- **No middleware required**
- **No `[locale]` segment required**
- `getRequestConfig` reads the locale itself, typically from a **cookie** via `cookies()` from `next/headers`
- Reference pattern: official next-intl docs, “Without i18n routing”

### Answers

| Question | Answer | Basis |
|----------|--------|-------|
| Is middleware required? | Only for Architecture A (URL-prefixed locales) | next-intl docs |
| Is middleware optional? | Yes, fully optional in Architecture B | next-intl docs |
| Can locale routing work without middleware? | **URL-based** locale routing: no. **Cookie-based** locale selection: yes. | next-intl docs |
| Can request.ts work without custom headers? | Yes — it can read `cookies()` directly | next-intl docs |

> **Conclusion:** Claim #1 (“middleware mandatory”) is **false**. Middleware is only mandatory for the URL-prefix design — which this repo is **not structured to support** (see §2).

*(Documentation references are to next-intl's two canonical setup guides: “With i18n routing” vs. “Without i18n routing.” The repo-specific facts below are grounded in file/git evidence and are independently verifiable.)*

---

## 2. Route Architecture — How `/es` Is *Actually* Implemented

### Evidence (file paths)

**There is no locale segment and no Spanish route tree:**

```
Glob  src/app/**/[locale]/**     → No files found
Glob  src/app/es/**              → No files found
find  src/app -type d -name es   → (nothing)
```

**The app tree is flat — confirmed at the current HEAD AND at Phase 1 (`337e1322`):**

```
git ls-tree -d src/app @ 337e1322:
  about  admin  api  archive  artists  auth  christian  composers
  contact  contributors  debug  discover  djs  dmca  genres
  instrumental-classical  lyricists  musicians  privacy-policy
  producers  provinces  releases  search  songs  songwriters  terms-of-use
```

No `[locale]`. No `es`. **At any point in history.**

**No rewrites/redirects in config:**
```
grep "rewrite|redirect" next.config.ts → (none)
```

**How `/es` URLs are *generated*** — purely as strings in components, with no backing routes:
- [src/i18n/pathname.ts:14](src/i18n/pathname.ts) — `addSpanishPrefix()` prepends `/es`
- [src/components/organisms/Footer.tsx:59](src/components/organisms/Footer.tsx) — `<Link href={alternateLocalePath}>` → `/es/...`
- [src/components/LanguageSwitcher.tsx:24](src/components/LanguageSwitcher.tsx) — `router.push(getPathForLocale(...))` → `/es/...`
- [src/components/providers/LanguageSelectionModal.tsx:29](src/components/providers/LanguageSelectionModal.tsx) — `router.push(newPath)` → `/es`

### What actually happens on `GET /es/artists`

```
Request /es/artists
  → No middleware, no rewrite
  → App Router looks for src/app/es/artists/page.tsx → DOES NOT EXIST
  → 404
```

This is true **with or without middleware**, because the *old* middleware never rewrote `/es/x` → `/x` either (see §4).

### Answers

| Question | Answer |
|----------|--------|
| How are /es routes implemented? | They aren't. `/es` is only generated as link strings; no route files exist. |
| Does App Router already handle locale segments? | **No.** There is no `[locale]` segment. |
| Are /es URLs expected to work without middleware? | They can't work **even with** the old middleware — there are no routes to serve them. |

> **Conclusion:** Claim #4 is **misleading**. `/es` 404s are caused by **missing route structure**, not missing middleware. This is the original audit's biggest blind spot.

---

## 3. request.ts — Is the `x-locale` Logic Standard?

### Evidence (git history of `src/i18n/request.ts`)

| Commit | request.ts behavior |
|--------|---------------------|
| `337e1322` (Phase 1) | File didn't exist. Config lived in root `i18n.config.ts`, reading the **`{ locale }` param**: `getRequestConfig(async ({ locale: requestLocale }) => ...)` |
| `737844ff` | `request.ts` **created**, reading the **`{ locale }` param**: `getRequestConfig(async ({ locale }) => ...)` |
| `6347eac3` (latest) | **Changed to read `x-locale` header**: `headersList.get("x-locale")` |

So the `x-locale` header read was **introduced last**, in `6347eac3` — a commit whose stated purpose was unrelated (“Use translation keys for TopBanner subtitle”).

### Is it standard?

- The **`{ locale }` param** pattern (737844ff and Phase 1) is the next-intl pattern for **Architecture A** — but it only receives a value when an `app/[locale]/` segment feeds it. With a flat app, `locale` is `undefined` → falls back to `en`.
- The **`x-locale` header** pattern (current) is **bespoke**. It assumes a middleware sets that header. No such middleware exists. → always `en`.
- The **standard Architecture B** pattern would read `cookies()` — which the repo **never** did (`grep cookies() src/i18n/` → none).

### Is it the likely source of the translation failure?

**Yes.** Current `request.ts`:
```ts
const headersList = await headers();
const locale = headersList.get("x-locale") === "es" ? "es" : "en";
```
`x-locale` is never set by anything → `locale` is **always `"en"`** → `en.json` always loads → server always renders English. **This is real and confirmed.**

### Answers

| Question | Answer |
|----------|--------|
| Was x-locale part of the original implementation? | **No.** Introduced in `6347eac3` (latest commit). |
| Was it introduced later? | **Yes**, last. |
| Is it a standard next-intl pattern? | **No.** Standard Architecture B reads a cookie. |
| Is it the likely source of failure? | **Yes** — for the *translation* failure (always-English). Not the cause of /es 404s. |

> **Conclusion:** Claim #3 is **false**. `x-locale` is non-standard and is the proximate cause of the translation failure. The original audit got the *symptom* right but mislabeled the cure.

---

## 4. “The System Cannot Work Without Middleware” — Prove or Disprove

### Disproof by decomposition

The system has **two independent failures**, and middleware is required for **neither** in the minimal design:

**Failure A — translations never switch (always English).**
- Cause: `request.ts` reads `x-locale` (never set).
- Middleware-free fix: read the **`mangulina_locale` cookie** in `request.ts` via `cookies()`. The cookie is already being written correctly by [src/i18n/preference.ts:5](src/i18n/preference.ts).
- → **No middleware needed.**

**Failure B — `/es/*` returns 404.**
- Cause: no `app/[locale]` segment and no `app/es` directory (§2).
- Middleware **alone does not fix this** — the standard `next-intl/middleware` *rewrites into* `[locale]`, which doesn't exist. Restoring it would 404 (or mis-rewrite) and could disturb the working flat English routes.
- Fixing B requires **either** building `app/[locale]/` (large) **or** abandoning `/es` URLs (small).

### Critical evidence the old middleware would NOT have fixed `/es`

Phase 1 middleware (`337e1322:middleware.ts`):
```ts
import createMiddleware from 'next-intl/middleware';
export default createMiddleware({
  locales: ['en','es'], defaultLocale: 'en', localePrefix: 'as-needed',
});
```
This **requires** `app/[locale]/`. Phase 1 had **no** `[locale]` directory (`git ls-tree @337e1322` confirms). So **Spanish routes never resolved, even in Phase 1.** The multilingual feature was **incomplete from inception**, not “broken by deletion.”

> **Conclusion:** Claim #2 is **disproved**. The translation half can work cookie-only with no middleware; the routing half needs route structure, which middleware does not supply.

---

## 5. Smallest Possible Fix (Ranked by Probability of Success)

Goal: restore **English pages**, **Spanish pages**, **language switching** with minimal change. No rebuild.

### Rank 1 — Cookie-based locale, drop URL prefixes  ★ RECOMMENDED
**Confidence it fully restores function: 85%** · **Effort: ~1 hr** · **Risk: low**

Changes:
1. `src/i18n/request.ts` — read `mangulina_locale` cookie via `cookies()` instead of `x-locale` header (~4 lines).
2. `LanguageSwitcher` / `LanguageSelectionModal` / `Footer` — on select, set cookie then `router.refresh()` instead of `router.push("/es/...")`.
3. Stop generating `/es` hrefs (so no 404s); selector reads locale from `useLocale()` (next-intl) not from pathname.

Restores: EN ✅ · ES ✅ (cookie) · switching ✅ · selector state ✅ · **eliminates all /es 404s** ✅
Evidence this is viable: cookie writer already exists ([preference.ts:5](src/i18n/preference.ts)); messages complete (`en.json`/`es.json`); flat routes already serve EN.
Trade-off: **no language in URL** → weaker per-language SEO/shareable links (acceptable; can add hreflang later).

### Rank 2 — Full URL-prefix architecture (`app/[locale]/` + next-intl middleware)
**Confidence it works: 90%** · **Effort: high (4–8 hrs)** · **Risk: high**

Move *every* route under `app/[locale]/`, add `next-intl/middleware`, `routing.ts`, update all internal links. This matches what the components already *try* to do (they generate `/es` URLs).
Why not first choice: this is the “rebuild” the task explicitly says to avoid; touches ~57 page files; high regression surface.

### Rank 3 — Revert request.ts to cookie BUT keep `/es` links
**Confidence: 40%** · Translations would switch, but `/es` links still 404. Half-fix. Rejected.

### Rank 4 — Restore the old `createMiddleware` only
**Confidence: 20%** · Does **not** create `[locale]` routes → `/es` still broken; may break working EN routes via bad rewrites. **This is the original audit's recommendation — and it is the weakest option.**

---

## 6. Confidence Assessment Summary

| Recommendation | Confidence | Key Evidence | Files |
|----------------|-----------|--------------|-------|
| `x-locale` read is the cause of always-English | 97% | git: introduced `6347eac3`; nothing sets the header | [request.ts](src/i18n/request.ts) |
| `/es` 404 is a missing-routes problem, not middleware | 90% | no `[locale]`/`es` dir at HEAD or Phase 1 | `git ls-tree` @337e1322 |
| Middleware is NOT the primary fix | 85% | old middleware needs `[locale]` that never existed | [337e1322:middleware.ts] |
| Cookie-based fix is smallest viable repair | 85% | cookie writer + complete messages already present | [preference.ts](src/i18n/preference.ts) |
| Multilingual was incomplete from inception | 88% | Phase 1 already lacked `[locale]` + Spanish routes | `git ls-tree` @337e1322 |
| Original audit's translation diagnosis was correct | 95% | request.ts always returns `en` | [request.ts](src/i18n/request.ts) |

---

## 7. What the Original Audit Got Right vs. Wrong

**Right:**
- ✅ `request.ts` always resolves to `en` (translation failure is real).
- ✅ The `x-locale` header is never set.
- ✅ Cookie is written but never read server-side.
- ✅ Translation JSON files are complete.
- ✅ Server/client locale mismatch is plausible.

**Wrong / Incomplete:**
- ❌ Called middleware “mandatory.” It isn’t for the minimal design.
- ❌ Claimed restoring middleware is the primary fix. It wouldn’t fix `/es` and could break EN.
- ❌ **Missed that no `[locale]`/`es` route structure exists** — the actual cause of `/es` 404s.
- ❌ Implied the system once worked and was “broken by deletion.” Evidence shows **Spanish routing never worked** (no `[locale]` even in Phase 1).
- ❌ Misidentified `x-locale` as something to preserve; it’s a non-standard late addition that should be replaced with cookie reading.

---

## 8. Final Determination

> **Is restoring middleware the correct fix? — No.**

The real bugs are:
1. **`request.ts` reads a header nothing sets** → always English. *(Fix: read the cookie.)*
2. **No route structure for `/es/*`** → 404. *(Fix: either drop `/es` URLs (small) or build `app/[locale]/` (large).)*

The **smallest correct fix** is the **cookie-based, no-URL-prefix** approach (Rank 1): change `request.ts` to read `mangulina_locale`, and make the switchers set the cookie + `router.refresh()` instead of navigating to non-existent `/es` routes. Middleware restoration (the original audit's headline recommendation) is the **lowest-probability** option and is not recommended.

**No code was changed during this validation.**
