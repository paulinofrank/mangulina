# Translation System Test Plan

## Prerequisites
- Dev server running with `npm run dev`
- Browser developer tools open (DevTools) to check:
  - Network tab (to verify requests)
  - Application tab (to check cookies)
  - Console (for errors)

---

## Test 1: Fresh Visit (First-Time User)

**Setup:** Clear all cookies for localhost:3000

**Actions:**
1. Open http://localhost:3000
2. Expect: Language selection modal appears
3. Select "English" button
4. Expect: Modal closes, page renders in English
5. Check DevTools > Application > Cookies
   - Should see `mangulina_locale=en`

**Verify English content:**
- Navigation shows: Home, Singers, Christian, Discover, etc.
- Search placeholder: "Search artists, songs..."
- Footer: "The Dominican Music Database"
- All section titles in English

---

## Test 2: First Visit - Select Spanish

**Setup:** Clear cookies again

**Actions:**
1. Open http://localhost:3000
2. Language modal appears
3. Select "Español" button
4. Expect: Redirects to http://localhost:3000/es
5. Page renders in Spanish
6. Check DevTools > Application > Cookies
   - Should see `mangulina_locale=es`

**Verify Spanish content:**
- Navigation shows: Inicio, Cantantes, Cristiana, Descubrir, etc.
- Search placeholder: "Buscar artistas, canciones..."
- Footer: "La Base de Datos de Música Dominicana"

---

## Test 3: Switch English → Spanish

**Starting point:** http://localhost:3000 (English)

**Desktop (click language selector):**
1. Top right corner, click button showing "English"
2. Dropdown menu appears with "English" and "Español" options
3. Click "Español"
4. Expect: URL changes to http://localhost:3000/es
5. Page content becomes Spanish
6. Language selector now shows "Español"
7. Cookie updates to `mangulina_locale=es`

**Mobile (click footer link):**
1. Scroll to footer
2. Click "Cambiar a Español" link
3. Expect: URL changes to http://localhost:3000/es
4. Page content becomes Spanish
5. Footer link now shows "Switch to English"

---

## Test 4: Switch Spanish → English

**Starting point:** http://localhost:3000/es (Spanish)

**Desktop (click language selector):**
1. Top right corner, click button showing "Español"
2. Dropdown menu appears
3. Click "English"
4. Expect: URL changes to http://localhost:3000
5. Page content becomes English
6. Language selector now shows "English"
7. Cookie updates to `mangulina_locale=en`

**Mobile (click footer link):**
1. Scroll to footer
2. Click "Switch to English" link
3. Expect: URL changes to http://localhost:3000
4. Page content becomes English
5. Footer link now shows "Cambiar a Español"

---

## Test 5: Page-Specific Navigation

**Test these paths:**

From English (/):
- `/` → English → Click Español → `/es` (Spanish)
- `/artists` → English → Click Español → `/es/artists` (Spanish)
- `/discover` → English → Click Español → `/es/discover` (Spanish)
- `/christian` → English → Click Español → `/es/christian` (Spanish)

From Spanish (/es):
- `/es` → Spanish → Click English → `/` (English)
- `/es/artists` → Spanish → Click English → `/artists` (English)
- `/es/discover` → Spanish → Click English → `/discover` (English)
- `/es/christian` → Spanish → Click English → `/christian` (English)

**Verify:** Content language matches URL language

---

## Test 6: Direct URL Navigation

**Actions:**
1. On English page, manually type http://localhost:3000/es in address bar
2. Expect: Page loads in Spanish, selector shows "Español"
3. Manually type http://localhost:3000 in address bar
4. Expect: Page loads in English, selector shows "English"
5. Type http://localhost:3000/es/artists
6. Expect: Artists page loads in Spanish
7. Type http://localhost:3000/artists
8. Expect: Artists page loads in English

---

## Test 7: Cookie Persistence

**Actions:**
1. Start on English page
2. Select Spanish via language switcher
3. Refresh page (`F5`)
4. Expect: Page reloads in Spanish (URL should still be `/es`)
5. Navigate to another page like `/es/artists`
6. Refresh page
7. Expect: Still Spanish
8. Navigate to English `/`
9. Refresh page
10. Expect: Still English

---

## Test 8: Translation Keys

**Verify these elements are translated:**

English pages should show:
- "Top Singers by Views" (not "Top Artists")
- "Most Searched Songs"
- Search: "Search artists, songs..."
- Navigation: "Discover", "Releases", "About"
- Footer: "The Dominican Music Database"

Spanish pages should show:
- "Cantantes Principales por Vistas"
- "Canciones Más Buscadas"
- Search: "Buscar artistas, canciones..."
- Navigation: "Descubrir", "Lanzamientos", "Acerca de"
- Footer: "La Base de Datos de Música Dominicana"

---

## Test 9: Admin Routes (Should Not Have /es prefix)

**Actions:**
1. Try to access http://localhost:3000/es/admin
2. Expect: 404 or redirect (admin routes are not localized)
3. Access http://localhost:3000/admin/login
4. Expect: Admin login page loads (no /es prefix needed)

---

## Test 10: URL No-Repeats

**Verify:**
- There should NEVER be a `/en` prefix in any URL
- Only `/es` for Spanish, nothing for English
- `/` and `/artists` are English
- `/es` and `/es/artists` are Spanish

---

## Checklist

- [ ] Test 1: Fresh visit selects English
- [ ] Test 2: Fresh visit selects Spanish
- [ ] Test 3: English → Spanish switching works
- [ ] Test 4: Spanish → English switching works
- [ ] Test 5: Page-specific navigation correct
- [ ] Test 6: Direct URL navigation works
- [ ] Test 7: Cookie persistence across refreshes
- [ ] Test 8: Translation keys render correctly
- [ ] Test 9: Admin routes not localized
- [ ] Test 10: No /en URLs created

---

## Debug Checklist

If any test fails:

1. **Check DevTools Console** for JavaScript errors
2. **Check Network tab** for failed requests
3. **Check Application > Cookies** for locale preference
4. **Check URL** matches expected locale
5. **Check page source** HTML for correct language (lang="en" or lang="es")
6. **Check proxy logs** if available (should show locale detection)

