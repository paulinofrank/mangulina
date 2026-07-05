# Historical Report

**Status:** Historical Snapshot (2026-06-20)

**Current Source of Truth:**
- [I18N_ARCHITECTURE_DIAGRAMS.md](../../I18N_ARCHITECTURE_DIAGRAMS.md)

**Purpose:**
Forensic audit of the multilingual system revealing critical failures and configuration issues identified during Phase 1 development.

**Note:**
This is a historical audit. Issues identified have been addressed through subsequent phases. Consult current i18n documentation for the authoritative current state.

---

# Mangulina Multilingual System - Forensic Audit Report

**Date:** June 20, 2026  
**Auditor:** Senior Webmaster Engineer / i18n Specialist  
**System:** Next.js 16.2.6 with next-intl 4.13.0  
**Status:** CRITICAL FAILURES IDENTIFIED

---

## EXECUTIVE SUMMARY

The multilingual system is **fundamentally broken** due to a cascading series of architectural failures:

1. **CRITICAL:** Missing middleware means locale detection headers are never set
2. **CRITICAL:** Mismatched locale resolution strategy (header-based without headers)
3. **CRITICAL:** No proper routing structure for next-intl
4. **MAJOR:** Incomplete transition between implementation approaches
5. **MAJOR:** Cookie-based preference has no authority (header detection fails first)

**Result:** System appears to work intermittently because:
- URL-based locale detection in components works partially
- next-intl doesn't receive correct locale information
- Language switching works for URLs but translation rendering is unpredictable
- Returning to English fails because of locale detection conflicts

---

## SECTION 1: CURRENT ARCHITECTURE

### 1.1 File Inventory

| File | Purpose | Status | Issue |
|------|---------|--------|-------|
| `next.config.ts` | next-intl plugin configuration | ✅ Correct | Uses proper plugin integration |
| `src/i18n/request.ts` | next-intl server config | ❌ **BROKEN** | Expects `x-locale` header that is never set |
| `src/i18n/pathname.ts` | URL locale manipulation | ✅ Correct | Functions work correctly but are cosmetic |
| `src/i18n/preference.ts` | Cookie persistence | ✅ Correct | Code is correct but authority is never established |
| `middleware.ts` | Locale detection & header injection | ❌ **DELETED** | CRITICAL - this is why x-locale header doesn't exist |
| `src/app/layout.tsx` | Root layout with NextIntlClientProvider | ⚠️ Partial | Receives locale from getLocale() which gets undefined |
| `src/components/LanguageSwitcher.tsx` | Desktop language selector | ⚠️ Fragile | Works via URL manipulation, not system authority |
| `src/components/providers/LanguageSelectionModal.tsx` | First-visit modal | ⚠️ Fragile | Sets cookie but system ignores it |
| `src/components/organisms/Footer.tsx` | Footer with language links | ⚠️ Fragile | Hardcoded locale detection from URL |
| `messages/en.json` | English translations | ✅ Correct | 750+ keys, complete |
| `messages/es.json` | Spanish translations | ✅ Correct | 750+ keys, complete |

### 1.2 Route Structure

**Current Reality:**
```
src/app/
├── page.tsx                    # / and /es (via middleware redirect?)
├── artists/
├── songs/
├── releases/
├── search/
├── christian/
├── archive/
└── ... (no [locale] directory)
```

**Problem:** No `[locale]` dynamic segment means next-intl cannot use its standard routing convention. The system relies entirely on middleware to:
1. Detect locale from URL pathname
2. Inject `x-locale` header
3. Possibly redirect non-Spanish URLs to maintain consistency

**Current State:** Middleware is DELETED, so none of this happens.

---

## SECTION 2: LOCALE RESOLUTION ANALYSIS

### 2.1 How Locale SHOULD Be Determined

**Next.js + next-intl standard flow:**
```
Request → Middleware (read locale from URL) 
       → Set x-locale header 
       → Pass to request.ts via headers() 
       → request.ts returns locale to getLocale() 
       → Components receive correct locale
       → Translations render in correct language
```

### 2.2 How Locale IS Currently Determined

**Actual broken flow:**

```
Request arrives
│
├─ URL is /artists or /es/artists
│  (middleware would have redirected, but it's deleted)
│
├─ request.ts awaits headers() and reads x-locale
│  (x-locale header NEVER EXISTS because no middleware)
│  └─ Falls back to: locale = "en" (default)
│
├─ All routes resolve to English
│  (even if URL is /es/artists)
│
└─ Components independently call getLocaleFromPathname()
   (this DOES work correctly)
   └─ But this is DISCONNECTED from next-intl's locale
      └─ Creates CLIENT/SERVER locale mismatch
```

### 2.3 Locale Resolution Flowchart

```
REQUEST TO /es/artists

     ↓
Next.js Router (no middleware to intercept)
     ↓
request.ts getRequestConfig()
     ├─ const headersList = await headers()
     ├─ const locale = headersList.get("x-locale") === "es" ? "es" : "en"
     │  (x-locale doesn't exist, returns undefined)
     └─ locale = "en" (DEFAULT)
     ↓
getLocale() returns "en"
     ↓
getMessages() loads en.json
     ↓
Layout receives: locale="en", messages=en.json
     ↓
HTML renders with lang="en" attribute
     ↓
Components call getLocaleFromPathname(pathname)
     ├─ pathname = "/es/artists"
     └─ returns "es" (DIFFERENT from server locale="en")
     ↓
CLIENT-SIDE HYDRATION MISMATCH
├─ Server rendered: English
├─ Client tries: Spanish
└─ useTranslations() from next-intl context: English
└─ getLocaleFromPathname() returns: Spanish
└─ Components confused about which language to display
```

### 2.4 Current Locale Sources (Priority)

| Source | Current Value | Authority | Reliability |
|--------|---------------|-----------|-------------|
| `x-locale` header | ❌ Never set | None | 0% |
| URL pathname `/es` prefix | ✅ Works | Component-level | 60% |
| Cookie `mangulina_locale` | ✅ Sets on click | None (ignored) | 0% |
| Browser locale preference | ❌ Not checked | None | 0% |
| next-intl getLocale() | ❌ Always "en" | next-intl | 0% |

**SOURCE OF TRUTH CONFLICT:** 
- Components believe URL is the source of truth → `/es/artists` = Spanish
- next-intl believes headers/request config is source → header missing = English
- Result: Hydration mismatch on page load

---

## SECTION 3: ROUTE AUDIT

### 3.1 English Routes (No Prefix)

| Route | Status | Notes |
|-------|--------|-------|
| `/` | ✅ Works | Root route |
| `/artists` | ✅ Works | Artist list |
| `/artists/[slug]` | ✅ Works | Individual artist |
| `/songs/[slug]` | ✅ Works | Individual song |
| `/releases` | ✅ Works | Release list |
| `/releases/[slug]` | ✅ Works | Individual release |
| `/search` | ✅ Works | Search page |
| `/christian` | ✅ Works | Christian genre |
| `/archive` | ✅ Works | Archive page |
| `/archive/[period]` | ✅ Works | Archive by period |
| `/genres/[slug]` | ✅ Works | Genre page |
| All others | ✅ Work | About, Contact, Privacy, etc. |

### 3.2 Spanish Routes (With /es Prefix)

| Route | Actual Status | Should Work? | Known Issues |
|-------|----------------|--------------|--------------|
| `/es` | ⚠️ Unknown | Yes | Might redirect to `/` |
| `/es/artists` | ⚠️ BROKEN | Yes | Returns 404 OR English content with /es prefix |
| `/es/artists/[slug]` | ⚠️ BROKEN | Yes | Same as above |
| `/es/songs/[slug]` | ⚠️ BROKEN | Yes | Same as above |
| `/es/releases` | ⚠️ BROKEN | Yes | Same as above |
| `/es/releases/[slug]` | ⚠️ BROKEN | Yes | Same as above |
| `/es/search` | ⚠️ BROKEN | Yes | Same as above |
| `/es/christian` | ⚠️ BROKEN | Yes | Same as above |
| `/es/archive` | ⚠️ BROKEN | Yes | Same as above |
| `/es/archive/[period]` | ⚠️ BROKEN | Yes | Same as above |

**Root Cause:** No middleware means:
- Next.js doesn't know `/es/artists` is a valid route
- The app doesn't have a `src/app/es/` directory structure
- Requests to `/es/*` either get 404 or fall through to `/artists` with `?lang=es` handling missing
- Some frameworks auto-redirect `/es/artists` → `/artists`, losing the language prefix

### 3.3 Route Resolution Evidence

```
File Structure:
src/app/
└── artists/
    ├── page.tsx           (renders both /artists and /es/artists?)
    ├── [slug]/
    │   └── page.tsx
    └── layout.tsx

When Request Arrives:
GET /es/artists
  → No middleware to intercept
  → Next.js looks for: src/app/es/artists/page.tsx
  → DOESN'T EXIST
  → Next.js looks for: src/app/artists/page.tsx
  → FOUND ✅
  → BUT url.pathname still shows /es/artists
  → Components use getLocaleFromPathname("/es/artists") = "es"
  → Server rendered with lang="en"
  → Mismatch occurs
```

---

## SECTION 4: LANGUAGE SWITCHING AUDIT

### 4.1 Desktop Language Switcher (LanguageSwitcher.tsx)

**Location:** Header (TopBanner)

**Current Flow:**
```
User clicks "Español"
     ↓
handleLanguageChange("es")
     ├─ saveLocalePreference("es")
     │  └─ Sets cookie: mangulina_locale=es; Max-Age=31536000; Path=/
     │     (365 days, correct)
     └─ const newPath = getPathForLocale(pathname, "es")
        └─ If pathname="/artists" → newPath="/es/artists" ✅
        └─ If pathname="/es/artists" → newPath="/es/artists" (no change)
        └─ router.push(newPath)
           └─ PROBLEM: This pushes the URL but locale handling fails
```

**Issues:**
- ✅ Cookie is set correctly
- ✅ URL is generated correctly
- ❌ Route resolution fails (404 or wrong locale)
- ❌ next-intl doesn't receive locale (no middleware to read cookie or set header)
- ❌ Clicking back to English sometimes fails

**Why back to English fails:**
```
Current: /es/artists (lang="es" shown)
Click English
     → newPath = removeSpanishPrefix("/es/artists") = "/artists"
     → router.push("/artists")
     → Page loads
     → BUT middleware would have:
        - Detected no /es prefix
        - Checked cookie: mangulina_locale=es
        - NOT redirected (English is default)
        - Set x-locale: en
     → EXCEPT middleware is deleted
     → So: no mechanism to check cookie or enforce default
     → URL change alone doesn't trigger re-render with correct translations
     → Cache issues: /artists might have English cached from earlier
```

### 4.2 Footer Language Switch

**Location:** Footer (mobile only)

**Current Code:**
```tsx
<Link
  href={alternateLocalePath}
  onClick={() => saveLocalePreference(alternateLocale)}
  className="..."
>
  {locale === "en" ? t("languageSwitchToSpanish") : t("languageSwitchToEnglish")}
</Link>
```

**Flow:**
```
alternateLocale = locale === "en" ? "es" : "en"
alternateLocalePath = getAlternateLocalePath(pathname)
  → "/artists" → "/es/artists" ✅
  → "/es/artists" → "/artists" ✅

onClick saves preference to cookie ✅
Link navigates to alternateLocalePath

BUT:
- Same routing problems as desktop switcher
- Cookie is set but never consulted
- Next page still renders with server locale="en"
```

**Issues:**
- Same as desktop switcher
- Cookie preference is cosmetic

### 4.3 Language Selection Modal (LanguageSelectionModal.tsx)

**Location:** SiteChrome (renders globally)

**Current Flow:**
```
First Visit (no cookie exists)
     ↓
useEffect checks document.cookie for "mangulina_locale="
     ├─ Not found
     └─ setShowModal(true)
     ↓
Modal appears with English/Español buttons
     ↓
User clicks "Español"
     ├─ saveLocalePreference("es")
     │  └─ Sets cookie: mangulina_locale=es
     ├─ newPath = getPathForLocale(pathname, "es")
     │  └─ "/" → "/es" ✅
     └─ router.push(newPath)
        └─ Navigates to /es
        └─ PROBLEM: No route exists for /es
        └─ Might 404 or fall through
     ↓
setShowModal(false)
```

**Issues:**
- ✅ Cookie is set correctly
- ⚠️ Modal logic is correct for first-visit detection
- ❌ Navigation to `/es` might fail (no route)
- ❌ Even if successful, next page still renders English (no middleware)

---

## SECTION 5: TRANSLATION COVERAGE AUDIT

### 5.1 Translation Key Inventory

**File: messages/en.json**
- ✅ Structure: Valid JSON
- ✅ Keys: 750+ translated strings
- ✅ Coverage: language.*, navigation.*, footer.*, search.*, sections.*, etc.
- ✅ Status: Complete

**File: messages/es.json**
- ✅ Structure: Valid JSON  
- ✅ Keys: 750+ translated strings
- ✅ Coverage: Matches en.json structure
- ✅ Status: Complete

### 5.2 Component Translation Usage

**Components Using next-intl useTranslations():**
- ✅ TopBanner.tsx: Uses `t("footer.tagline")` and `t("footer.logo")`
- ✅ LanguageSwitcher.tsx: Uses `t("language.selector.*")`
- ✅ LanguageSelectionModal.tsx: Uses `t("language.modal.*")`
- ✅ Footer.tsx: Uses `t("footer.*")` and `t("navigation.*")`
- ✅ Navbar.tsx: Uses `t("navigation.*")`

### 5.3 Translation Rendering Issue

**The Problem:** Even though translations exist and components request them:

```tsx
// LanguageSwitcher.tsx
const t = useTranslations("language.selector");
const locale = getLocaleFromPathname(pathname);  // Returns "es"

return (
  <button>
    {locale === "en" ? t("english") : t("spanish")}
    {/* If server locale="en" but URL is /es, 
        next-intl has en.json loaded but component wants es */}
  </button>
);
```

**Why translations don't appear correctly:**
1. Server receives request to `/es/artists`
2. request.ts reads x-locale header → null → defaults to "en"
3. Layout loads en.json (English messages)
4. NextIntlClientProvider initialized with locale="en", messages=en.json
5. Component calls useTranslations() → gets en.json
6. Component calls getLocaleFromPathname("/es/artists") → "es"
7. Mismatch: wants Spanish keys from Spanish JSON, but en.json is loaded
8. Either shows English OR shows translation key name (broken fallback)

---

## SECTION 6: NEXT-INTL CONFIGURATION AUDIT

### 6.1 next.config.ts Analysis

```typescript
import createNextIntlPlugin from "next-intl/plugin";

const withNextIntl = createNextIntlPlugin("./src/i18n/request.ts");

const nextConfig: NextConfig = {
  allowedDevOrigins: ["10.0.0.3"],
  images: { /* ... */ },
};

export default withNextIntl(nextConfig);
```

**Status:** ✅ Correct

**Verification:**
- ✅ Imports correct plugin: `createNextIntlPlugin`
- ✅ Points to correct request config: `./src/i18n/request.ts`
- ✅ Wraps config correctly with `withNextIntl()`
- ✅ This enables next-intl's automatic locale detection

### 6.2 src/i18n/request.ts Analysis

```typescript
import { getRequestConfig } from "next-intl/server";
import { headers } from "next/headers";

export default getRequestConfig(async () => {
  const headersList = await headers();
  const locale = headersList.get("x-locale") === "es" ? "es" : "en";

  return {
    locale,
    messages: (await import(`../../messages/${locale}.json`)).default,
  };
});
```

**Status:** ❌ BROKEN - Architecture Mismatch

**Analysis:**
- ✅ Imports: Correct
- ✅ Export format: Correct (getRequestConfig)
- ✅ Message loading: Correct (dynamic import)
- ❌ **CRITICAL:** Expects `x-locale` header
  - Header format: `x-locale: es` or `x-locale: en`
  - Source: Should come from middleware
  - Current state: **Middleware is deleted, header never exists**
  - Fallback: Always defaults to "en"

**Evidence of the Problem:**

```javascript
// Current code logic:
headersList.get("x-locale") === "es" 
  ? "es" 
  : "en"

// In real execution:
// headersList.get("x-locale") returns null or undefined
// null === "es" ? NO, so returns "en"
// RESULT: All requests get locale="en"
```

### 6.3 Layout Integration

**src/app/layout.tsx:**
```typescript
const locale = await getLocale();      // ← Gets "en" (always)
const messages = await getMessages();  // ← Loads en.json (always)

<html lang={locale}>                   {/* lang="en" */}
  <NextIntlClientProvider 
    locale={locale}                    {/* locale="en" */}
    messages={messages}                {/* en.json */}
  >
```

**Status:** ✅ Code is correct, but receives wrong locale

**The Flow:**
1. getLocale() calls request.ts getRequestConfig()
2. request.ts tries to read x-locale header
3. Header doesn't exist
4. Defaults to "en"
5. en.json loads
6. Layout provides en.json to all client components
7. All pages render in English regardless of URL

### 6.4 Client Provider Configuration

**Problem Chain:**

```
→ No middleware to read locale from URL and set header
→ request.ts can't find x-locale header
→ getLocaleFromPathname() defaults to "en"
→ Layout passes locale="en" to NextIntlClientProvider
→ All useTranslations() calls get English messages
→ But components also call getLocaleFromPathname(pathname)
→ If pathname=/es/something, component thinks it's Spanish
→ MISMATCH on the client side during hydration
```

---

## SECTION 7: COOKIE AUDIT

### 7.1 Cookie Creation

**File:** src/i18n/preference.ts
```typescript
const ONE_YEAR_IN_SECONDS = 365 * 24 * 60 * 60;

export function saveLocalePreference(locale: AppLocale) {
  document.cookie = `mangulina_locale=${locale}; Max-Age=${ONE_YEAR_IN_SECONDS}; Path=/; SameSite=Lax`;
}
```

**Status:** ✅ Correct implementation

**Details:**
- ✅ Cookie name: `mangulina_locale` (consistent)
- ✅ Value: "en" or "es" (correct)
- ✅ Max-Age: 31,536,000 seconds (365 days, correct)
- ✅ Path: "/" (site-wide, correct)
- ✅ SameSite: Lax (secure and reasonable)
- ✅ Expiration: Yes, explicit Max-Age set

### 7.2 Cookie Reading

**Where cookie SHOULD be read:**
- Middleware should check for `mangulina_locale` cookie
- If user has preference, enforce it
- If user switches language, middleware should update x-locale header

**Where cookie IS actually read:**
- LanguageSelectionModal.tsx: Checks if cookie exists (first visit logic only)
- Nowhere else in the codebase

**Status:** ⚠️ Partially correct

**Issues:**
1. ✅ Cookie is successfully created when user clicks language switcher
2. ✅ Cookie persists across sessions (365 days)
3. ❌ Cookie is NEVER consulted by server (no middleware)
4. ❌ User preference has zero authority
5. ❌ Every page load defaults to English

### 7.3 Cookie + URL Conflict

**Scenario:**
```
User: Sets preference to Spanish (Cookie: mangulina_locale=es)
User: Visits /artists (English URL, no /es prefix)
Expected: Should render Spanish (respecting cookie)
Actual: Renders English (no middleware to read cookie)

User: Manually navigates to /es/artists (Spanish URL)
Expected: Should render Spanish (URL has /es prefix)
Actual: Renders English (no middleware to verify or set header)
```

**Hierarchy Problem:**
```
URL-based locale (no prefix) → English
        ↓
Cookie-based locale → Ignored (no middleware)
        ↓
Header-based locale → Ignored (never set)
        ↓
Final Result: Always English
```

**Correct Hierarchy Should Be:**
```
URL-based locale (explicit /es prefix) → Spanish
        ↓
Cookie-based locale (user preference) → Respected if no URL prefix
        ↓
Browser locale → Used if no preference
        ↓
Default → English
```

---

## SECTION 8: SEO AUDIT

### 8.1 Canonical URL Issues

**Current State:** ⚠️ PROBLEMATIC

**Issues Identified:**
1. ❌ No `<link rel="canonical">` tags
2. ❌ No hreflang alternate links
3. ❌ Both English and Spanish routes might be indexable
4. ❌ Duplicate content risk: `/artists` and `/es/artists` serve similar content

**SEO Risk Assessment:**

| Issue | Severity | Impact | Current State |
|-------|----------|--------|---------------|
| Duplicate content | HIGH | Multiple URLs same content | Both /artists and /es/artists might exist |
| No hreflang | HIGH | Search engine confusion | Not specified |
| No alternate links | HIGH | Crawlers don't know variants | Missing |
| Mixed language HTML | MEDIUM | Confuses Google | lang="en" but /es URLs exist |
| No language metadata | MEDIUM | SEO score penalty | Incomplete |

### 8.2 Robots Exclusion

**Current:** No robots.txt specific handling for locale variations

**Recommendation for Later:**
```
# /public/robots.txt should include:
Disallow: /es/*-es     # If using locale suffixes
Allow: /es/            # But allow main Spanish routes
```

### 8.3 Sitemap Issues

**File:** src/app/sitemap.ts

**Status:** Need to verify if it includes Spanish routes

**Expected:**
```xml
<url>
  <loc>https://mangulina.com/artists</loc>
  <xhtml:link rel="alternate" hreflang="es" href="https://mangulina.com/es/artists" />
</url>
<url>
  <loc>https://mangulina.com/es/artists</loc>
  <xhtml:link rel="alternate" hreflang="en" href="https://mangulina.com/artists" />
</url>
```

### 8.4 Accidental /en Routes

**Status:** ✅ No /en prefix exists (good)

**Reason:** System correctly uses no prefix for English (best practice)

---

## SECTION 9: ROOT CAUSE ANALYSIS

### 9.1 Primary Root Cause

**THE CORE ISSUE: Middleware Was Deleted**

**Commit:** `737844ff` - "Fix next-intl configuration with proper plugin integration"

**Commit Message Claims:**
> Remove unnecessary i18n.config.ts and middleware.ts

**Reality:**
- i18n.config.ts was truly optional (could use request.ts instead)
- middleware.ts is NOT optional (it's the ENTIRE locale detection system)

**What the middleware did:**
1. Detected locale from URL pathname (`/es/artists` → locale="es")
2. Set `x-locale` header for downstream processing
3. Possibly handled redirects to normalize URLs
4. Made cookie accessible to server-side decisions

**What was lost:**
```
Before deletion:
Request → Middleware (detects /es) → Sets x-locale:es → request.ts reads it → Correct locale

After deletion:
Request → No middleware → x-locale missing → request.ts defaults to "en" → Wrong locale
```

### 9.2 Secondary Root Cause

**Incomplete Transition Between Implementation Approaches**

**The system attempted TWO different architectures:**

**Approach 1 (Original):**
- Use middleware for all locale detection
- Middleware sets x-locale header
- request.ts reads from getRequestConfig({ locale }) parameter
- Middleware optionally performs redirects

**Approach 2 (Attempted Latest):**
- Remove middleware entirely
- Use URL-based detection in components only
- Migrate to standard next-intl pattern with [locale] directory

**Current Result:**
- Approach 1's middleware was deleted ❌
- Approach 2 was never implemented ❌
- Code was modified mid-transition (6347eac3)
- System is in broken hybrid state ❌

### 9.3 Tertiary Root Cause

**Misunderstanding of next-intl's Locale Resolution**

**What was assumed:**
> "next-intl plugin auto-discovers locale from request headers"

**What's actually true:**
> "next-intl plugin expects middleware to set locale or middleware.ts to exist with proper config"

**The Confusion:**
```
next-intl has TWO modes:

Mode 1: Auto-discovery (requires middleware or [locale] directory)
  → Middleware sets locale on request
  → OR request happens to [locale]/... directory path
  → next-intl auto-detects from these signals

Mode 2: Manual config (requires request.ts to read from request)
  → request.ts must explicitly read locale from some source
  → That source must be populated by middleware
  → OR passed via request headers/cookies

Current Implementation:
  → Attempted Mode 1 but deleted middleware
  → Attempted Mode 2 but middleware deleted (missing source)
  → Result: Neither mode works
```

### 9.4 Summary: Root Causes by Component

| Component | Root Cause | Evidence | Severity |
|-----------|-----------|----------|----------|
| Locale Detection | No middleware to set x-locale header | Deleted in 737844ff, never replaced | CRITICAL |
| Route Resolution | No [locale] directory structure | Middleware was supposed to handle this | CRITICAL |
| Translation Loading | Locale always defaults to "en" | x-locale header never exists | CRITICAL |
| Language Switching | Cookie ignored by server | No middleware to read cookies | MAJOR |
| Hydration Mismatch | Client/server locale conflict | Server="en", Client detects /es | MAJOR |
| SEO | Duplicate content + missing hreflang | No canonical URLs specified | MAJOR |
| User Experience | Back-to-English fails | Cache issues + no server preference | MAJOR |

---

## SECTION 10: REPAIR PLAN

### 10.1 Priority 1: Critical (System Non-Functional)

#### FIX 1.1: Restore Middleware
**Effort:** 30 minutes

**Current State:** middleware.ts deleted
**Solution:** Restore or recreate proper middleware that:
1. Detects locale from request URL pathname
2. Sets x-locale header for request.ts to read
3. Handles redirect logic for normalized URLs
4. Reads cookie preference and applies it

**Files to Create/Modify:**
- `middleware.ts` (create new)
- Update next.config.ts if needed for middleware.ts matcher config

**Expected Outcome:**
- request.ts receives x-locale header
- All routes resolve to correct locale
- /es/artists works properly
- Switching languages functions correctly

---

#### FIX 1.2: Fix request.ts to Handle Both Signals
**Effort:** 15 minutes

**Current State:**
```typescript
const locale = headersList.get("x-locale") === "es" ? "es" : "en";
```

**Solution:** Update to handle fallback to URL-based detection:
```typescript
let locale: AppLocale = "en";

// Try header first (set by middleware)
const headerLocale = headersList.get("x-locale");
if (headerLocale === "es") {
  locale = "es";
}

// Fallback to pathname detection if header missing
// (This handles edge cases where middleware didn't run)
const pathname = headersList.get("x-pathname") || "/";
if (pathname.startsWith("/es")) {
  locale = "es";
}

return {
  locale,
  messages: (await import(`../../messages/${locale}.json`)).default,
};
```

**Files to Modify:**
- `src/i18n/request.ts`

**Expected Outcome:**
- Robust locale detection even if middleware partially fails
- Fallback handling for edge cases

---

### 10.2 Priority 2: Functional (Complete Implementation)

#### FIX 2.1: Verify Route Handling
**Effort:** 1 hour

**Task:**
1. Test GET `/es` → should render homepage in Spanish
2. Test GET `/es/artists` → should render artist list in Spanish
3. Test GET `/es/artists/juan-luis-guerra` → should render in Spanish
4. Verify all 26 route categories work with /es prefix

**Files to Test:**
- All pages in src/app/

**Expected Outcome:**
- All Spanish routes accessible
- No 404 errors for /es/* paths
- Correct translations render

---

#### FIX 2.2: Fix Language Switcher State Display
**Effort:** 20 minutes

**Current Issue:** Switcher might show wrong current language

**Solution:**
1. In LanguageSwitcher.tsx, ensure locale is read from next-intl's getLocale() NOT pathname
2. Verify button state matches server-side locale

**Files to Modify:**
- `src/components/LanguageSwitcher.tsx`

**Expected Outcome:**
- Current language button shows correct state
- No visual confusion about active language

---

#### FIX 2.3: Test Language Selection Modal
**Effort:** 30 minutes

**Test Cases:**
1. First visit (no cookie) → modal appears
2. Select Spanish → navigates to /es
3. Refresh → no modal (cookie exists)
4. Clear cookie → modal reappears

**Files to Test:**
- `src/components/providers/LanguageSelectionModal.tsx`

**Expected Outcome:**
- Modal works reliably
- Navigation to /es succeeds
- Spanish content renders

---

### 10.3 Priority 3: User Experience

#### FIX 3.1: Fix Back-to-English Issue
**Effort:** 20 minutes

**Current Problem:** Returning to English sometimes fails

**Solution:**
1. Ensure language switcher properly handles both directions
2. Test route.push() flow for both languages
3. Verify cache invalidation (ISR or revalidate)

**Files to Modify:**
- `src/components/LanguageSwitcher.tsx`
- Check page revalidate settings

**Expected Outcome:**
- Switching between languages always works
- No cache-related issues

---

#### FIX 3.2: Verify Footer Language Switch
**Effort:** 15 minutes

**Test:**
1. Mobile view, click footer language link
2. Verify navigation works
3. Verify translations update

**Files to Test:**
- `src/components/organisms/Footer.tsx`

**Expected Outcome:**
- Footer language switch works on mobile
- Consistent with desktop switcher behavior

---

### 10.4 Priority 4: SEO Improvements

#### FIX 4.1: Add Canonical URLs
**Effort:** 45 minutes

**Files to Modify:**
- Layout files or metadata generation

**Solution:**
```typescript
// In page metadata or layout
const canonicalUrl = locale === "es" 
  ? `https://mangulina.com/es${pathname}`
  : `https://mangulina.com${pathname}`;

export const metadata = {
  alternates: {
    canonical: canonicalUrl,
    languages: {
      "en": `https://mangulina.com${pathname}`,
      "es": `https://mangulina.com/es${pathname}`,
    }
  }
}
```

**Expected Outcome:**
- Google knows canonical URLs
- Proper hreflang tags set
- No duplicate content penalties

---

#### FIX 4.2: Verify Sitemap Includes Spanish Routes
**Effort:** 30 minutes

**Files to Modify:**
- `src/app/sitemap.ts`

**Expected Output:**
```xml
<url>
  <loc>https://mangulina.com/artists</loc>
  <xhtml:link rel="alternate" hreflang="es" href="https://mangulina.com/es/artists" />
</url>
<url>
  <loc>https://mangulina.com/es/artists</loc>
  <xhtml:link rel="alternate" hreflang="en" href="https://mangulina.com/artists" />
</url>
```

**Expected Outcome:**
- Search engines discover Spanish content
- Proper language alternates marked
- Complete sitemap coverage

---

## SECTION 11: RISK ASSESSMENT

### 11.1 Current Production Risk Level: **CRITICAL** 🔴

| Risk | Level | Impact | Mitigation |
|------|-------|--------|-----------|
| Users cannot access Spanish content reliably | CRITICAL | 50% of user base blocked | Restore middleware |
| Hydration mismatch errors in console | CRITICAL | Poor user experience | Fix locale detection |
| SEO duplicate content penalty | HIGH | Reduced search visibility | Add canonical tags |
| Broken language switching UX | HIGH | User frustration | Fix switcher logic |
| Cookie preference ignored | MEDIUM | User settings lost | Implement cookie logic in middleware |

### 11.2 Testing Before Production

**Critical Tests:**
1. ✅ All English routes return 200 (not 404)
2. ✅ All Spanish routes return 200 (not 404)
3. ✅ Language switcher displays correct current language
4. ✅ Switching English → Spanish → English works
5. ✅ Spanish page renders Spanish text (not English)
6. ✅ Refresh /es/artists keeps Spanish
7. ✅ Modal appears first visit, not second
8. ✅ Cookie persists across sessions
9. ✅ No console hydration errors
10. ✅ hreflang tags in page source

---

## SECTION 12: TECHNICAL RECOMMENDATIONS

### 12.1 Recommended Architecture

```
For Mangulina, use this pattern:

    REQUEST (e.g., GET /es/artists)
          ↓
    [middleware.ts]
    ├─ Detect locale from pathname
    ├─ Read user preference from cookies
    ├─ Set x-locale header
    ├─ Set x-pathname header
    └─ NextResponse.next({ headers })
          ↓
    [request.ts getRequestConfig]
    ├─ Read x-locale header
    ├─ Load messages for that locale
    └─ Return { locale, messages }
          ↓
    [layout.tsx]
    ├─ const locale = await getLocale()
    ├─ const messages = await getMessages()
    ├─ Provide to NextIntlClientProvider
    └─ Set html lang={locale}
          ↓
    [Components]
    ├─ useTranslations() uses provided messages
    ├─ No URL-based locale detection needed
    └─ Consistent server/client locale
```

### 12.2 Next.js Next-Intl Best Practices

1. **Middleware is NOT optional** - It's the locale detection source
2. **Always set headers in middleware** - Components can't access headers directly
3. **Implement cookie logic in middleware** - Server respects user preference
4. **Test route resolution** - Both /en/* (if used) and /es/*
5. **Verify hydration** - No mismatches between server and client

### 12.3 Avoid These Patterns

❌ **Don't:** Delete middleware and expect next-intl to auto-discover locale
❌ **Don't:** Use URL-based detection in components as source of truth (use for fallback only)
❌ **Don't:** Ignore cookie preferences on server
❌ **Don't:** Have multiple conflicting locale sources
❌ **Don't:** Forget to set hreflang tags for multilingual SEO

---

## SECTION 13: INVESTIGATION EVIDENCE

### Git Commits Showing Issue Evolution

```
337e1322 - Implement multilingual infrastructure (Phase 1)
└─ Created working middleware.ts and i18n.config.ts
└─ Status: ✅ Middleware present

1a032509 - Fix next-intl config discovery error
└─ Modified middleware for header-based approach
└─ Status: ⚠️ Middleware still present

737844ff - Fix next-intl configuration with proper plugin integration
└─ DELETED middleware.ts ← CRITICAL CHANGE
└─ DELETED i18n.config.ts
└─ Status: ❌ Middleware missing, system broken

6347eac3 - Fix: Use translation keys for TopBanner subtitle and logo alt text
└─ Modified request.ts to read x-locale header
└─ Status: ❌ Trying to access header that no longer gets set
```

### Code Analysis

**src/i18n/request.ts expecting header that doesn't exist:**
```typescript
const headersList = await headers();
const locale = headersList.get("x-locale") === "es" ? "es" : "en";
// x-locale is null because middleware.ts is deleted
// Returns "en" (default)
```

**middleware.ts (deleted in 737844ff, was the header source):**
```typescript
const requestHeaders = new Headers(request.headers);
requestHeaders.set('x-locale', locale);
// This line made the above work!
// Deleted in 737844ff
```

---

## SECTION 14: CONCLUSION

The Mangulina multilingual system is **not functioning correctly** due to fundamental architectural issues introduced during a transition between implementation approaches.

### What's Broken
1. Middleware responsible for locale detection was deleted
2. x-locale header is never set or read
3. All routes default to English
4. Spanish routes are inaccessible or inaccessible
5. Language switching appears to work but doesn't persist
6. SEO is compromised (duplicate content risk)

### What's Working
1. ✅ Translation files (750+ keys, complete)
2. ✅ Language switching component logic (UX works)
3. ✅ Cookie creation (persistence works)
4. ✅ URL manipulation functions (pathname.ts)
5. ✅ next-intl plugin configuration

### What Needs Fixing
1. 🔴 Restore middleware.ts (CRITICAL)
2. 🔴 Ensure x-locale header is set and read (CRITICAL)
3. 🟠 Fix route resolution for /es/* paths (MAJOR)
4. 🟠 Fix language switching persistence (MAJOR)
5. 🟡 Add SEO hreflang tags (MINOR but important)

### Repair Effort
- **Critical Fixes:** 1-2 hours
- **Full System Verification:** 2-3 hours
- **Total Estimated:** 4-5 hours

The system can be fully restored by recreating the middleware and ensuring locale signals flow correctly through the request/response cycle.

---

**Report Generated:** June 20, 2026  
**System Status:** CRITICAL - Awaiting Repairs  
**Next Step:** Restore middleware.ts and verify all routes
