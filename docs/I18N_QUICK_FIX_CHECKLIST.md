# Mangulina i18n - Quick Fix Checklist

## ⚠️ CRITICAL: Read This First

**Your multilingual system is BROKEN because middleware.ts was deleted.**

**Status:** Spanish routes don't work. Language switching appears to work but translations don't load.

**Fix Time:** 1-2 hours for full restoration

---

## 🔴 CRITICAL FIXES REQUIRED

### [ ] 1. Restore middleware.ts (30 min)

**What to do:**
- Create `middleware.ts` in project root
- Add locale detection logic
- Set x-locale header that request.ts depends on

**File location:** C:\Mangulina\middleware.ts

**What it should do:**
```
1. Detect locale from URL path (/es = Spanish, no prefix = English)
2. Read cookie preference (mangulina_locale)
3. Set x-locale header (es or en)
4. Handle redirects if needed
5. Pass request to next handler
```

**Why this fixes it:**
- request.ts is looking for x-locale header that doesn't exist
- Without middleware, ALL requests default to locale="en"
- Even if URL is /es/artists, it serves English
- Spanish routes are unreachable

---

### [ ] 2. Verify request.ts locale detection (15 min)

**File:** src/i18n/request.ts

**Check:**
- [ ] Imports `headers` from "next/headers"
- [ ] Calls `headersList.get("x-locale")`
- [ ] Has fallback if header missing
- [ ] Returns correct locale object

**Current code should:**
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

**If different, restore to above**

---

## 🟠 MAJOR FUNCTIONALITY CHECKS

### [ ] 3. Test all English routes (30 min)

After middleware is restored, verify:
- [ ] GET / returns 200
- [ ] GET /artists returns 200
- [ ] GET /releases returns 200
- [ ] GET /search returns 200
- [ ] GET /christian returns 200
- [ ] GET /archive returns 200

**Command:**
```bash
npm run build && npm run start
# Then test routes in browser or curl
```

---

### [ ] 4. Test all Spanish routes (30 min)

After middleware is restored, verify:
- [ ] GET /es returns 200
- [ ] GET /es/artists returns 200
- [ ] GET /es/releases returns 200
- [ ] GET /es/search returns 200
- [ ] GET /es/christian returns 200
- [ ] GET /es/archive returns 200

**Expected:** Spanish content in Spanish language

---

### [ ] 5. Test language switcher (20 min)

On homepage, click "Español":
- [ ] URL changes to /es or /es/artists (depending on page)
- [ ] Page content changes to Spanish
- [ ] Text appears in Spanish (not English)
- [ ] No console errors

Then click "English":
- [ ] URL changes back to /artists (or page equivalent)
- [ ] Page content changes to English
- [ ] Text appears in English (not Spanish)

---

### [ ] 6. Test language modal (10 min)

**First visit (new browser/incognito):**
- [ ] Modal appears asking for language
- [ ] Click "Español"
- [ ] Navigates to /es
- [ ] Content in Spanish
- [ ] Cookie set (check in DevTools: Application > Cookies > mangulina_locale)

**Second visit (same browser):**
- [ ] Modal does NOT appear
- [ ] Page loads in remembered language

---

### [ ] 7. Test mobile footer language switch (10 min)

**Mobile view (< 640px):**
- [ ] Footer shows language switch link
- [ ] Click link
- [ ] Language changes
- [ ] Content updates

---

## 🟡 SEO IMPROVEMENTS (Optional but Important)

### [ ] 8. Add hreflang tags (1 hour)

**Location:** Page metadata or layout

**What to add:**
```typescript
alternates: {
  languages: {
    "en": "https://mangulina.com" + pathname,
    "es": "https://mangulina.com/es" + pathname,
  }
}
```

**Why:** Google knows both versions exist and should index both

---

### [ ] 9. Verify sitemap includes Spanish routes (30 min)

**File:** src/app/sitemap.ts

**Check:**
- [ ] Lists /artists
- [ ] Lists /es/artists
- [ ] Has xhtml:link alternate entries
- [ ] Declares both languages

---

## ✅ VERIFICATION CHECKLIST

After all fixes, verify:

- [ ] No 404 on /es routes
- [ ] No 404 on /es/artists/[slug]
- [ ] Language switcher displays correct current language
- [ ] Switching languages works both directions
- [ ] Text translates (not showing translation keys)
- [ ] No console hydration errors
- [ ] No Uncaught Error messages
- [ ] Refresh /es/artists keeps Spanish
- [ ] Mobile language switch works
- [ ] Cookie persists language choice
- [ ] First-visit modal appears
- [ ] Second-visit modal doesn't appear
- [ ] hreflang tags in page source (if implemented)
- [ ] Sitemap includes Spanish routes (if implemented)

---

## 🧪 TESTING COMMANDS

```bash
# Build and verify no errors
npm run build

# Start dev server
npm run dev

# Test routes
curl http://localhost:3000/
curl http://localhost:3000/es
curl http://localhost:3000/es/artists
curl http://localhost:3000/artists

# Check for hydration errors
# Open browser console and reload pages
# Should see NO hydration errors
```

---

## 📋 TIMELINE

| Task | Est. Time | Priority |
|------|-----------|----------|
| Restore middleware.ts | 30 min | 🔴 CRITICAL |
| Verify request.ts | 15 min | 🔴 CRITICAL |
| Test English routes | 30 min | 🟠 MAJOR |
| Test Spanish routes | 30 min | 🟠 MAJOR |
| Test language switcher | 20 min | 🟠 MAJOR |
| Test modal | 10 min | 🟠 MAJOR |
| Test mobile footer | 10 min | 🟠 MAJOR |
| **Subtotal Critical+Major** | **2 hours 45 min** | |
| Add hreflang (optional) | 1 hour | 🟡 OPTIONAL |
| Verify sitemap (optional) | 30 min | 🟡 OPTIONAL |
| **Total with SEO** | **4 hours 15 min** | |

---

## ❓ FAQ

**Q: Why did this break?**
A: middleware.ts was deleted in commit 737844ff, but it's essential for locale detection. The deletion was a mistake.

**Q: Will users lose their language preference?**
A: No, the cookie is still set correctly. Once middleware is restored, it will be read properly.

**Q: Do I need to recreate the exact old middleware.ts?**
A: No, the old one had some issues. A cleaned-up version would be better.

**Q: Why does /es/artists sometimes show English?**
A: Without middleware, request.ts always defaults to "en" locale, so all pages render English. The URL doesn't matter without middleware to intercept it.

**Q: Is the translation JSON incomplete?**
A: No, both en.json and es.json are complete with 750+ keys.

---

## 🚨 BEFORE YOU START FIXING

1. **Read the full audit first:** docs/I18N_FORENSIC_AUDIT.md
2. **Understand the architecture:** docs/I18N_ARCHITECTURE_DIAGRAMS.md
3. **Don't guess** - follow the exact fixes listed
4. **Test after each fix** - don't wait until the end

---

## 📞 REFERENCE INFORMATION

**Files mentioned:**
- middleware.ts (missing)
- src/i18n/request.ts (broken)
- src/i18n/pathname.ts (working correctly)
- src/i18n/preference.ts (working correctly)
- messages/en.json (complete)
- messages/es.json (complete)
- src/app/layout.tsx (receiving wrong locale)

**Commits that caused issues:**
- 737844ff: Deleted middleware.ts (CRITICAL MISTAKE)
- 6347eac3: Modified request.ts to use headers (attempted fix)

**Git branches:**
- main: Current broken state
- origin/main: Might have working version (check if behind)

---

## ✔️ SUCCESS CRITERIA

**System is fixed when:**
1. ✅ All /es/* routes return 200 (not 404)
2. ✅ Spanish routes show Spanish content
3. ✅ English routes show English content
4. ✅ Language switching works both ways
5. ✅ No hydration errors in console
6. ✅ Refresh maintains language choice
7. ✅ Cookie preference is respected

**If ANY of these fail, the system is still broken.**

---

## 📝 NOTES

- The old middleware.ts (before 737844ff) can be found in git history
- Don't use the old one directly; clean it up first
- The pathname.ts functions are working correctly, so don't change them
- The cookie logic is correct, just not being used
- All 750+ translation keys are complete, so this isn't a translation issue

---

**Next step:** Create middleware.ts with proper locale detection logic.

See: docs/I18N_FORENSIC_AUDIT.md Section 10 for detailed repair instructions.
