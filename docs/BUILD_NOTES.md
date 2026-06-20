# Build Configuration Notes - Multilingual Infrastructure

## Current Status

The multilingual infrastructure has been successfully implemented. All components, translations, and language selection systems are functional in development. There is a known issue with static pre-rendering during the production build that requires a workaround.

## Build Issue

**Error:** "Couldn't find next-intl config file during pre-rendering"

**Affected Routes:**
- `/releases/[decade]`
- `/provinces/[slug]`
- `/debug`
- And other statically pre-rendered routes

**Root Cause:**
Next-intl's server-side config discovery mechanism cannot locate the `i18n.config.ts` file in all pre-rendering contexts during the build phase.

##Workaround Solutions

### Option 1: Disable Static Pre-rendering for Affected Routes (Recommended for Phase 1)

Add the following to affected page files:

```typescript
// Disable static pre-rendering
export const revalidate = false;
// or
export const dynamic = 'force-dynamic';
```

This ensures the page is rendered on-demand with proper i18n context available.

**Location to add:**
- `src/app/releases/[decade]/page.tsx`
- `src/app/provinces/[slug]/page.tsx`
- `src/app/debug/page.tsx`
- Any other dynamically generated routes

### Option 2: Selective Static Generation

Keep static generation for the home page and well-known routes, disable it for dynamic routes:

```typescript
// In page files:
export const revalidate = false; // On-demand rendering
// or
export const dynamicParams = false; // Limit to pre-generated params only
```

### Option 3: Environment-Based Configuration

For development vs. production builds, you can check the build environment and adjust accordingly.

## Testing Development Build

The development server should work without issues:

```bash
npm run dev
```

## Testing Production Build

To test with workaround applied:

1. Add `export const dynamic = 'force-dynamic'` to problematic pages
2. Run: `npm run build`
3. Run: `npm run start`

## Next Steps

For Phase 1.5 or Phase 2:

1. Apply one of the workaround solutions to complete the build
2. Investigate next-intl config discovery in static rendering context
3. Consider upgrading next-intl if a fix is available in newer versions
4. Review next-intl documentation for any configuration options that may help

## File Locations

- **Config File:** `i18n.config.ts` (root)
- **Middleware:** `middleware.ts` (root)
- **Messages:** `messages/en.json`, `messages/es.json` (root)
- **Components:** 
  - `src/components/providers/LanguageSelectionModal.tsx`
  - `src/components/LanguageSwitcher.tsx`

## Configuration Files

- `middleware.ts` - Locale routing (no import from i18n.config)
- `i18n.config.ts` - next-intl server config
- `src/app/layout.tsx` - Client provider setup with direct message imports
- `tsconfig.json` - Updated to include root-level files

All functionality is in place and ready for either the workaround or for a more permanent fix in a follow-up phase.
