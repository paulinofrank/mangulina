# Copilot instructions for Mangulina

## Project snapshot

Mangulina is a Next.js 16 app for the Dominican Music Database. The public app is multilingual (`en` and `es`) and uses the App Router under `src/app`, with most data coming from Supabase-backed queries and UI components in `src/components` and `src/lib`.

The repository also contains editorial/data governance documentation under `docs/` that defines the canonical model for artists, works, recordings, releases, and credits. If a change touches data modeling, editorial rules, or role taxonomy, treat those docs as authoritative.

## Build, test, and lint

Use the repository scripts from `package.json`:

- Install dependencies: `npm install`
- Start local dev server: `npm run dev`
- Production build: `npm run build`
- Run production server: `npm start`
- Lint: `npm run lint`
- Test suite: `npm test`

Run one test file directly with `tsx`:

```bash
npx tsx --test tests/clientApiResponse.test.ts
```

For a single test name:

```bash
npx tsx --test tests/clientApiResponse.test.ts --test-name-pattern "readApiJson parses JSON responses"
```

Project-specific scripts worth knowing:

- `npm run i18n:audit` - checks i18n coverage and config issues
- `npm run audit-db-health` - database health checks
- `npm run instagram:typecheck` - checks Instagram scripts against the TypeScript config
- `npm run instagram:worker` / `npm run instagram:worker:dry` - run the engagement worker

## High-level architecture

### 1) App routing and locale model

- `src/app` contains route-level pages and API endpoints.
- Locale-aware routing is centralized in `src/i18n/routing.ts` and the next-intl plugin in `next.config.ts`.
- Public pages are typically under `src/app/[locale]/...` and use `next-intl` for translations and locale-aware metadata.
- English is the default language and stays at the root (`/artists`); Spanish is prefixed when needed (`/es/artists`).

### 2) Data layer and backend

- `src/lib/supabase.ts` is the main Supabase client entry point.
- `src/lib/supabaseConfig.ts` holds config assumptions and public/private env handling.
- Route and page data is usually assembled in server-side helpers inside `src/lib/*` and passed into view components.
- The app is structured as a mostly server-rendered Next.js app with client components only when interaction is required.

### 3) UI structure

- `src/components` contains the reusable UI building blocks and route-level sections.
- `src/components/layout` and `src/components/organisms` are the main composition points for pages.
- Keep data fetching and presentation separate: page/server modules should assemble data, while components should mostly render and handle local UI behavior.

### 4) Editorial/data model

The repository has a strong editorial and data-governance layer in `docs/`:

- `docs/AI_INSTRUCTIONS.md`
- `docs/DATA_GOVERNANCE.md`
- `docs/ROLE_DICTIONARY.md`
- `docs/EDITORIAL_GUIDELINES.md`
- `docs/EDITORIAL_BIOGRAPHY_FORMAT.md`

These files define the canonical model for artists, works, recordings, releases, tracks, credits, and role taxonomy. If work touches the database, schema, or editorial logic, start there and preserve the modeled relationships instead of inventing new ones.

## Key repository conventions

### Data and schema changes

- Prefer extending existing tables or relationships before creating new tables.
- Search the schema and codebase for an existing pattern before proposing a new table, column, role, or relationship type.
- Do not invent new role names or genres without checking `docs/ROLE_DICTIONARY.md` and the data model docs.
- Preserve historical accuracy and backward compatibility; existing queries and URLs must keep working.

### Localization and routing

- Keep locale behavior aligned with `src/i18n/routing.ts`.
- Do not treat the locale cookie as the source of truth for public routing.
- When changing a public route, check whether the page needs explicit dynamic behavior because of the repo’s known next-intl build/static-rendering caveats (`docs/BUILD_NOTES.md`).

### Project-specific editorial guardrails

- Accuracy outranks completeness.
- Preserve original crediting and historical release context.
- Do not duplicate the same fact across multiple tables if the data model already has a canonical location.
- Treat editorial documents as content storage for biography/metadata patterns, not as ad hoc freeform text blobs.

### Code shape

- Prefer the existing pattern in nearby modules over introducing one-off abstractions.
- Keep config and environment handling centralized; do not duplicate Supabase or locale setup across unrelated files.
- Follow the repo’s TypeScript + Next.js conventions rather than adding fresh framework patterns.

## Working with this repo

When making changes, check the most relevant neighboring files before editing:

- page and route files under `src/app`
- server data helpers under `src/lib`
- shared UI in `src/components`
- governance docs under `docs/` when the change affects data model or editorial rules

## Notes for AI agents

This repository is not just a generic Next.js app; it is a cultural database with editorial obligations. The data model and role vocabulary are intentionally constrained. Before changing schema, roles, or credit logic, consult the governance documentation first and keep changes additive and backward-compatible.
