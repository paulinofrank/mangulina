# Mangulina i18n Architecture - Visual Diagrams

## DIAGRAM 1: Current Broken Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     USER BROWSER                                 │
│  clicks "Español" button or visits /es/artists                  │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                    NEXT.JS ROUTER                               │
│  Request: GET /es/artists                                       │
│  Path: /es/artists                                              │
└────────────────────────┬────────────────────────────────────────┘
                         │
         ┌───────────────┴───────────────┐
         │                               │
         ▼                               ▼
    ❌ MISSING                    ✅ Exists but unused
    middleware.ts                 src/i18n/request.ts
                                   ├─ Awaits headers()
                                   ├─ Looks for x-locale header
                                   └─ Returns DEFAULT "en" (no header exists)
         │                               │
         │                               ▼
         │                    ┌──────────────────────┐
         │                    │  locale = "en"       │
         │                    │  messages = en.json  │
         │                    └──────────┬───────────┘
         │                               │
         └───────────────┬───────────────┘
                         │
                         ▼
            ┌────────────────────────────┐
            │   src/app/layout.tsx       │
            │                            │
            │   locale = "en" ← WRONG!   │
            │   messages = en.json       │
            │   lang="en"                │
            │   NextIntlClientProvider { │
            │     locale: "en"           │
            │     messages: en.json      │
            │   }                        │
            └────────────────┬───────────┘
                             │
              ┌──────────────┴──────────────┐
              │                             │
              ▼                             ▼
         Server Renders               Components Start
         ├─ lang="en"                 ├─ useTranslations() ← gets en.json
         ├─ HTML in English           ├─ getLocaleFromPathname("/es/artists")
         └─ Serves to browser         │  └─ returns "es" ← MISMATCH!
                                      └─ React tries to render Spanish
                                         with English messages loaded
         ▼
    ┌─────────────────────────┐
    │ BROWSER RECEIVES        │
    │ - lang="en" HTML tag    │
    │ - English translations  │
    │ - Hydration begins...   │
    └────────────────┬────────┘
                     │
              ┌──────▼──────┐
              │ MISMATCH!   │
              │ Server: en  │
              │ Client: es  │
              └──────┬──────┘
                     │
                     ▼
            ┌─────────────────────┐
            │ Hydration Error     │
            │ Text Mismatches     │
            │ Wrong translations  │
            │ Flickering          │
            └─────────────────────┘
```

### Current Flow Analysis

**Path 1: User visits /es/artists**
```
Request arrives
    ↓
No middleware to intercept (DELETED)
    ↓
request.ts calls getRequestConfig()
    ├─ headersList.get("x-locale") 
    │  └─ returns null/undefined (no middleware to set it)
    ├─ Comparison: null === "es" ? NO
    └─ Default: locale = "en"
    ↓
All requests → locale = "en" (ALWAYS)
    ↓
Browser receives English content
    ↓
Components detect URL=/es/artists and think it should be Spanish
    ↓
Hydration MISMATCH
```

**Path 2: User clicks "Español" button in LanguageSwitcher**
```
handleLanguageChange("es") called
    ├─ saveLocalePreference("es")
    │  └─ Sets cookie: mangulina_locale=es ✅
    └─ router.push("/es/artists") ✅
    ↓
Browser navigates to /es/artists
    ↓
(Same as Path 1 - request.ts defaults to "en")
    ↓
Cookie exists but is IGNORED
    └─ No server-side code reads it
    ↓
User sees English content despite Spanish selection
    ↓
User clicks "English" to switch back
    └─ Same issue: English content appears
    └─ BUT user may have cached Spanish from earlier
    └─ Looks like "switching back doesn't work"
```

---

## DIAGRAM 2: Required Working Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     USER BROWSER                                 │
│  visits /es/artists  (or clicks language switcher)              │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│               NEXT.JS ROUTER WITH MIDDLEWARE                    │
│  Request: GET /es/artists                                       │
│  Headers: (initially empty)                                     │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│              ✅ middleware.ts (REQUIRED)                         │
│                                                                  │
│  1. Read pathname: "/es/artists"                               │
│  2. Extract locale: "es"                                        │
│  3. Check cookie: mangulina_locale (if exists)                 │
│  4. Determine final locale: "es" (from URL)                    │
│  5. Set header: x-locale: "es"                                 │
│  6. Set header: x-pathname: "/es/artists"                      │
│  7. Pass to next middleware                                     │
│  8. Return NextResponse.next({ headers })                       │
│                                                                  │
│  Export const config = {                                        │
│    matcher: ['/((?!api|_next|_vercel|_public|.*\\..*).*)']   │
│  }                                                               │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼ (headers now include x-locale: "es")
┌─────────────────────────────────────────────────────────────────┐
│              src/i18n/request.ts                                 │
│                                                                  │
│  const headersList = await headers()                            │
│  const locale = headersList.get("x-locale") === "es"           │
│                                                                  │
│  If x-locale header exists:                                    │
│    ✅ locale = "es" (from header set by middleware)            │
│  Else:                                                           │
│    ✅ Fallback to getLocaleFromPathname()                       │
│    ✅ Or cookie preference                                      │
│    └─ Default to "en"                                          │
│                                                                  │
│  Return {                                                        │
│    locale: "es",                                               │
│    messages: await import("../../messages/es.json")            │
│  }                                                               │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
            ┌────────────────────────────┐
            │   src/app/layout.tsx       │
            │                            │
            │   locale = await getLocale()│
            │   locale = "es" ✅ CORRECT │
            │   messages = es.json ✅    │
            │   lang="es" ✅             │
            │   NextIntlClientProvider { │
            │     locale: "es"           │
            │     messages: es.json      │
            │   }                        │
            └────────────────┬───────────┘
                             │
              ┌──────────────┴──────────────┐
              │                             │
              ▼                             ▼
         Server Renders               Components Hydrate
         ├─ lang="es" ✅              ├─ useTranslations()
         ├─ HTML in Spanish ✅        │  └─ gets es.json ✅
         ├─ All text translated ✅    ├─ getLocaleFromPathname()
         └─ Sends to browser ✅       │  └─ returns "es" ✅
                                      ├─ MATCH! ✅
                                      └─ Smooth hydration ✅
         ▼
    ┌─────────────────────────┐
    │ BROWSER RECEIVES        │
    │ - lang="es" HTML tag ✅ │
    │ - Spanish content ✅    │
    │ - Hydration succeeds ✅ │
    │ - No errors ✅          │
    │ - User sees Spanish ✅  │
    └─────────────────────────┘
```

### Correct Flow Analysis

**Path 1: User visits /es/artists (correct)**
```
Request: /es/artists
    ↓
middleware.ts intercepts
    ├─ Detects: /es prefix
    ├─ Extracts: locale = "es"
    ├─ Reads: No cookie (first time) or Cookie: mangulina_locale=es
    ├─ Sets: x-locale: "es"
    └─ Passes request with header
    ↓
request.ts getRequestConfig()
    ├─ Reads: headersList.get("x-locale") = "es" ✅
    ├─ Loads: messages/es.json
    └─ Returns: { locale: "es", messages: es.json }
    ↓
Layout receives correct locale
    ├─ lang="es"
    ├─ messages = es.json
    └─ NextIntlClientProvider with correct locale
    ↓
Server renders Spanish HTML
    ↓
Client hydrates with Spanish context
    ↓
No mismatch ✅
    ↓
User sees Spanish ✅
```

**Path 2: User visits /artists (English - no prefix)**
```
Request: /artists
    ↓
middleware.ts intercepts
    ├─ Detects: No /es prefix
    ├─ Extracts: locale = "en"
    ├─ Reads: Cookie (if exists) or use default
    ├─ Sets: x-locale: "en"
    └─ Passes request
    ↓
request.ts → locale = "en"
    ↓
messages/en.json loaded
    ↓
Server renders in English
    ↓
User sees English ✅
```

**Path 3: User clicks "Español" from English page**
```
Current page: /artists
handleLanguageChange("es")
    ├─ saveLocalePreference("es") → Sets cookie ✅
    └─ router.push("/es/artists") ✅
    ↓
(Same as Path 1)
    ↓
Next request detected as /es → locale = "es"
    ↓
Spanish content renders ✅
```

**Path 4: User clicks "English" from Spanish page**
```
Current page: /es/artists
handleLanguageChange("en")
    ├─ saveLocalePreference("en") → Sets cookie ✅
    └─ router.push("/artists") ✅
    ↓
(Same as Path 2)
    ↓
Next request detected as /en (false) → locale = "en"
    ↓
English content renders ✅
```

---

## DIAGRAM 3: Locale Resolution Decision Tree

### Current (Broken)

```
                    REQUEST ARRIVES
                           │
                    ┌──────▼──────┐
                    │ middleware? │
                    ├──────────────┤
                    │    ❌ NO     │ (Deleted)
                    └──────┬──────┘
                           │
                    ┌──────▼────────────┐
                    │ x-locale header?  │
                    ├───────────────────┤
                    │ ❌ NO (nothing    │
                    │    set it)        │
                    └──────┬────────────┘
                           │
                    ┌──────▼──────────────┐
                    │ Default to "en"    │
                    ├───────────────────┤
                    │ locale = "en"      │
                    │ (REGARDLESS OF URL)│
                    └────────┬───────────┘
                             │
                      ┌──────▼──────┐
                      │ ALL REQUESTS│
                      │ GET ENGLISH │
                      └──────────────┘
```

### Correct (Required)

```
                    REQUEST ARRIVES
                           │
                    ┌──────▼──────┐
                    │ middleware? │
                    ├──────────────┤
                    │   ✅ YES     │
                    └──────┬──────┘
                           │
                    ┌──────▼──────────────┐
                    │ Read pathname      │
                    ├──────────────────┐
                    │ /artists → "en"  │
                    │ /es/artists → es"│
                    └──────┬───────────┘
                           │
                    ┌──────▼──────────────┐
                    │ Check cookie?      │
                    ├──────────────────┐
                    │ If /artists but  │
                    │ cookie="es"      │
                    │ User prefers es  │
                    └──────┬───────────┘
                           │
                    ┌──────▼──────────────┐
                    │ Set x-locale       │
                    │ header             │
                    └──────┬───────────┘
                           │
                    ┌──────▼──────────────┐
                    │ request.ts         │
                    │ reads x-locale     │
                    │ Loads correct      │
                    │ messages           │
                    └──────┬───────────┘
                           │
                    ┌──────▼──────────────┐
                    │ CORRECT LOCALE     │
                    │ CORRECT MESSAGES   │
                    │ CORRECT LANGUAGE   │
                    └────────────────────┘
```

---

## DIAGRAM 4: Cookie vs. URL Conflict Scenarios

### Scenario A: User on English site, has Spanish cookie

```
CURRENT (BROKEN):
  URL: /artists (no /es prefix)
  Cookie: mangulina_locale=es
  
  Middleware: DELETED ❌
  No code reads cookie
  
  Result: Renders ENGLISH ❌
  User expectation: SPANISH (they set preference)
  Status: WRONG

FIXED:
  URL: /artists (no /es prefix)
  Cookie: mangulina_locale=es
  
  middleware.ts:
    ├─ Detect: No /es prefix → locale="en"
    ├─ Check: Cookie exists → mangulina_locale=es
    ├─ Decision: URL explicit override, cookie is fallback
    ├─ Result: Use cookie preference (since URL is default)
    └─ Set: x-locale: "es"
  
  Result: Renders SPANISH ✅
  User expectation: SPANISH
  Status: CORRECT ✅
```

### Scenario B: User clicks language switcher to Spanish

```
CURRENT (BROKEN):
  1. On /artists
  2. Click "Español"
  3. LanguageSwitcher:
     ├─ saveLocalePreference("es") ✅
     └─ router.push("/es/artists") ✅
  4. Browser navigates to /es/artists
  5. middleware: DELETED ❌
  6. request.ts reads x-locale header
  7. Header doesn't exist → defaults to "en"
  8. Loads en.json
  9. Renders ENGLISH ❌
  
  Result: Clicked "Español" but got English

FIXED:
  1. On /artists
  2. Click "Español"
  3. LanguageSwitcher:
     ├─ saveLocalePreference("es") ✅
     └─ router.push("/es/artists") ✅
  4. Browser navigates to /es/artists
  5. middleware.ts:
     ├─ Detects /es prefix
     ├─ Sets x-locale: "es" ✅
     └─ Passes request
  6. request.ts reads x-locale: "es"
  7. Loads es.json ✅
  8. Renders SPANISH ✅
  
  Result: Clicked "Español" and got Spanish ✅
```

---

## DIAGRAM 5: Component Communication Flow

### Current (Broken)

```
                      SERVER SIDE
        ┌─────────────────────────────────┐
        │ getRequestConfig():             │
        │ locale = "en" (ALWAYS)          │
        │ messages = en.json (ALWAYS)     │
        │                                 │
        │ Layout receives:                │
        │ locale: "en"                    │
        │ messages: en.json               │
        │ NextIntlClientProvider:         │
        │   locale: "en"                  │
        │   messages: en.json             │
        └────────────┬────────────────────┘
                     │
                HYDRATION POINT
                     │
        ┌────────────▼────────────────────┐
        │        CLIENT SIDE               │
        │                                  │
        │ useTranslations():               │
        │ source = en.json (from context)  │
        │                                  │
        │ getLocaleFromPathname():         │
        │ source = "/es/artists"           │
        │ result = "es" ← DIFFERENT!       │
        │                                  │
        │ Component:                       │
        │ const locale = getLocaleFromPath │
        │ const t = useTranslations()      │
        │                                  │
        │ if (locale === "es") {           │
        │   display: t("spanish_key")      │
        │   ✅ Key exists in es.json       │
        │   ❌ But context has en.json     │
        │   Result: KEY NAME shown         │
        │   OR undefined                   │
        │ }                                │
        │                                  │
        │ HYDRATION ERROR ❌              │
        └──────────────────────────────────┘
```

### Correct (Required)

```
                      SERVER SIDE
        ┌─────────────────────────────────┐
        │ middleware.ts:                  │
        │ locale = "es"                   │
        │ Sets x-locale: "es"             │
        │                                 │
        │ getRequestConfig():             │
        │ locale = "es" ✅ (from header)  │
        │ messages = es.json ✅           │
        │                                 │
        │ Layout receives:                │
        │ locale: "es" ✅                 │
        │ messages: es.json ✅            │
        │ NextIntlClientProvider:         │
        │   locale: "es"                  │
        │   messages: es.json             │
        └────────────┬────────────────────┘
                     │
                HYDRATION POINT
                     │
        ┌────────────▼────────────────────┐
        │        CLIENT SIDE               │
        │                                  │
        │ useTranslations():               │
        │ source = es.json (from context)  │
        │ result = spanish text ✅         │
        │                                  │
        │ getLocaleFromPathname():         │
        │ source = "/es/artists"           │
        │ result = "es" ✅ MATCHES!        │
        │                                  │
        │ Component:                       │
        │ const locale = getLocaleFromPath │
        │ const t = useTranslations()      │
        │                                  │
        │ if (locale === "es") {           │
        │   display: t("spanish_key") ✅   │
        │   Key exists in es.json ✅       │
        │   Context has es.json ✅         │
        │   Result: Spanish text ✅        │
        │ }                                │
        │                                  │
        │ HYDRATION SUCCESS ✅             │
        │ USER SEES SPANISH ✅            │
        └──────────────────────────────────┘
```

---

## DIAGRAM 6: Request Header Flow

### Current (Broken)

```
CLIENT BROWSER              NEXT.JS SERVER           src/i18n/
┌─────────────┐            ┌──────────┐            ┌────────────┐
│ /es/artists │            │middleware│            │request.ts  │
└─────┬───────┘            └────┬─────┘            └─────┬──────┘
      │                         │                        │
      │ GET /es/artists         │                        │
      ├────────────────────────>│                        │
      │                    Headers: {                    │
      │                      accept: ...                 │
      │                      user-agent: ...             │
      │                      cookie: ...                 │
      │                      ❌ x-locale: MISSING        │
      │                    }                             │
      │                         │                        │
      │                    ┌────▼─────────┐              │
      │                    │ middleware?  │              │
      │                    │ ❌ DELETED   │              │
      │                    └────┬─────────┘              │
      │                         │                        │
      │ <────────────────────────├──────────────────────>│
      │   request with original │  calls                │
      │   headers (unchanged)   │  getRequestConfig()   │
      │                         │                        │
      │                         │  ┌─────────────────┐  │
      │                         │  │ headersList.get │  │
      │                         │  │ ("x-locale")    │  │
      │                         │  └────────┬────────┘  │
      │                         │           │           │
      │                         │      null (MISSING)   │
      │                         │           │           │
      │                         │    Default to "en"    │
      │                         │           │           │
      │ <────────────────────────┼──────────┤           │
      │  locale="en" (wrong)     │           │           │
      │  messages=en.json        │    Return └──────────>│
      │  lang="en"               │    {locale:"en",      │
      │  (with Spanish URL!)     │     messages: ...}   │
      │                          │                       │
      │ ❌ MISMATCH              │
      │
```

### Correct (Required)

```
CLIENT BROWSER              NEXT.JS SERVER           src/i18n/
┌─────────────┐            ┌──────────┐            ┌────────────┐
│ /es/artists │            │middleware│            │request.ts  │
└─────┬───────┘            └────┬─────┘            └─────┬──────┘
      │                         │                        │
      │ GET /es/artists         │                        │
      ├────────────────────────>│                        │
      │                    Headers: {                    │
      │                      accept: ...                 │
      │                      user-agent: ...             │
      │                      cookie: ...                 │
      │                    }                             │
      │                         │                        │
      │                    ┌────▼──────────────┐         │
      │                    │ middleware.ts ✅  │         │
      │                    │ 1. Read pathname  │         │
      │                    │ 2. Detect: /es    │         │
      │                    │ 3. locale="es"    │         │
      │                    │ 4. Set x-locale   │         │
      │                    └────┬───────────┬──┘         │
      │                         │   NEW     │            │
      │                    Headers:{        │            │
      │                      accept: ...    │            │
      │                      user-agent:... │            │
      │                      cookie: ...    │            │
      │                      ✅ x-locale:es │            │
      │                    }                 │            │
      │ <─────────────────────────┼──────────┤           │
      │                           │  Pass    │           │
      │                           │  forward │           │
      │                           │          │           │
      │                           │   calls  │           │
      │                           │  getRequest─────────>│
      │                           │  Config()            │
      │                           │          │           │
      │                           │    ┌─────▼────────┐  │
      │                           │    │headersList.  │  │
      │                           │    │get("x-locale")  │
      │                           │    └────────┬─────┘  │
      │                           │             │        │
      │                           │        "es" ✅      │
      │                           │             │        │
      │                           │    Load es.json ✅  │
      │                           │             │        │
      │ <──────────────────────────┼─────────────┤       │
      │ locale="es" ✅             │    Return  └──────> │
      │ messages=es.json ✅        │   {locale:"es",      │
      │ lang="es" ✅               │    messages: ...}    │
      │ (matches URL!) ✅          │                      │
      │                            │                      │
      │ ✅ MATCH                   │
      │ ✅ NO HYDRATION ERROR
```

---

## DIAGRAM 7: Language Switcher State Machine

### Current (Broken)

```
                    ┌─────────────────────┐
                    │  Page: /artists     │
                    │  URL Locale: "en"   │
                    │  Server Locale: "en"│
                    │  Cookie: (none)     │
                    └──────────┬──────────┘
                               │
                        User clicks
                        "Español"
                               │
                               ▼
                    ┌──────────────────────┐
                    │  saveLocalePreference│
                    │  ("es") ✅           │
                    │  Cookie now: "es"   │
                    └──────────┬───────────┘
                               │
                        router.push("/es/artists")
                               │
                               ▼
                    ┌──────────────────────┐
                    │  Page: /es/artists   │
                    │  URL Locale: "es" ✅ │
                    │  Server Locale: "en" │ ❌ MISMATCH
                    │  Cookie: "es" ✅     │
                    └──────────┬───────────┘
                               │
                        User sees ENGLISH ❌
                        (even though they clicked Spanish)
                               │
                        User clicks "English"
                        (frustrated)
                               │
                               ▼
                    ┌──────────────────────┐
                    │  saveLocalePreference│
                    │  ("en") ✅           │
                    │  Cookie now: "en"   │
                    └──────────┬───────────┘
                               │
                        router.push("/artists")
                               │
                               ▼
                    ┌──────────────────────┐
                    │  Page: /artists      │
                    │  URL Locale: "en" ✅ │
                    │  Server Locale: "en" │ ✅ MATCH
                    │  Cookie: "en" ✅     │
                    └──────────┬───────────┘
                               │
                        User sees ENGLISH ✅
                        (but was Spanish cached?)
                        
                        SEEMS LIKE "BACK TO ENGLISH WORKS"
                        but only by accident!
```

### Correct (Required)

```
                    ┌─────────────────────┐
                    │  Page: /artists     │
                    │  URL Locale: "en"   │
                    │  Server Locale: "en"│ ✅
                    │  Cookie: (none)     │
                    │  Middleware: ACTIVE │
                    └──────────┬──────────┘
                               │
                        User clicks
                        "Español"
                               │
                               ▼
                    ┌──────────────────────┐
                    │  saveLocalePreference│
                    │  ("es") ✅           │
                    │  Cookie: "es"       │
                    └──────────┬───────────┘
                               │
                        router.push("/es/artists")
                               │
                    middleware.ts detects
                    /es prefix
                               │
                               ▼
                    ┌──────────────────────┐
                    │  Page: /es/artists   │
                    │  URL Locale: "es"    │
                    │  Set x-locale: "es"  │
                    │  Server Locale: "es" │ ✅ MATCH
                    │  Cookie: "es"        │
                    │  Middleware: ACTIVE  │
                    └──────────┬───────────┘
                               │
                        User sees SPANISH ✅
                        (Immediately correct!)
                               │
                        User clicks "English"
                               │
                               ▼
                    ┌──────────────────────┐
                    │  saveLocalePreference│
                    │  ("en") ✅           │
                    │  Cookie: "en"       │
                    └──────────┬───────────┘
                               │
                        router.push("/artists")
                               │
                    middleware.ts detects
                    no /es prefix
                               │
                               ▼
                    ┌──────────────────────┐
                    │  Page: /artists      │
                    │  URL Locale: "en"    │
                    │  Set x-locale: "en"  │
                    │  Server Locale: "en" │ ✅ MATCH
                    │  Cookie: "en"        │
                    │  Middleware: ACTIVE  │
                    └──────────┬───────────┘
                               │
                        User sees ENGLISH ✅
                        (Correctly served!)
```

---

## Summary Table: Current vs. Required

| Component | Current | Required | Status |
|-----------|---------|----------|--------|
| middleware.ts | ❌ Deleted | ✅ Required | CRITICAL |
| Header flow | ❌ Headers never set | ✅ Middleware sets x-locale | CRITICAL |
| Locale detection | ❌ Always "en" | ✅ From URL/cookie via middleware | CRITICAL |
| Message loading | ❌ Always en.json | ✅ Correct language JSON | CRITICAL |
| Server/Client match | ❌ Mismatch | ✅ Always matching | CRITICAL |
| Language switching | ⚠️ URL works, persistence fails | ✅ Both work | MAJOR |
| Cookie usage | ❌ Set but ignored | ✅ Read and enforced | MAJOR |
| SEO hreflang | ❌ Missing | ✅ Canonical + alternates | MINOR |

---

All diagrams and analyses demonstrate: **The system cannot work without middleware.**

Restore middleware.ts → System works.
