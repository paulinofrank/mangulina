# Mangulina AI Agent Guidelines (Antigravity & Gemini)

Read [AGENTS.md](AGENTS.md) and the [production usage policy](docs/AI_PRODUCTION_USAGE_POLICY.md) before every task. Its batch limits, conflict stops, and run logging apply to Bios/Fichas as well as discography imports.

## Shared discography instructions (2026-10-15)

Read [AGENTS.md](AGENTS.md) first and [docs/discography.md](docs/discography.md) before discography, credits, research, import or duplicate work. Their scoped execution and review gates supersede older unconditional autonomy or catalog-write guidance. Work autonomously within the authorized task; research is not permission to import, publish, merge or delete. Preserve the Supabase security prohibition.

Contributor research must retain performer/release context; it does not authorize changes to another performer or mass creation of Works. Self-performance portfolio filtering is a display rule and never permits removing valid authorship credits.


## Supabase Security: Hands Off (applies to every AI tool)

**No AI assistant or agent (Claude, Codex, Gemini/Antigravity, Copilot, Cursor, or any other) may alter Supabase security**: RLS, policies, grants, function security, roles, auth settings, keys, or advisor dismissals. Read, audit and propose only; a human applies. Autonomous or bypass-permissions modes do **not** apply to this. Full rule: [docs/SUPABASE_SECURITY_POLICY.md](docs/SUPABASE_SECURITY_POLICY.md).

## Autonomous execution within scope

Complete authorized work without routine confirmations. Follow AGENTS.md and docs/discography.md review gates before catalog writes, scope expansion, shared-record changes, publication or destructive actions. Bypass mode does not enlarge authorization.

---

## 📚 Project Rules & Required Reading

Before making code or schema changes, adhere to the authoritative project governance documents:

1. **[docs/AI_INSTRUCTIONS.md](docs/AI_INSTRUCTIONS.md)**: Database rules (8 core rules), credits model, development checklists.
2. **[docs/DATA_GOVERNANCE.md](docs/DATA_GOVERNANCE.md)**: Entity definitions (Artist, Work, Recording, Release, Track), Performer vs. Creative Contributor.
3. **[docs/ROLE_DICTIONARY.md](docs/ROLE_DICTIONARY.md)**: Valid role names and relationship types. Do not invent new roles.
4. **[docs/EDITORIAL_BIOGRAPHY_FORMAT.md](docs/EDITORIAL_BIOGRAPHY_FORMAT.md)**: How biographies are structured and stored in `editorial_documents`.
5. **[docs/BUILD_NOTES.md](docs/BUILD_NOTES.md)**: Build and deployment conventions.

---

## 🛡️ Core Principles

- **Preserve Editorial Accuracy**: Historical credit text, original titles, and relationships must be preserved as released.
- **Preserve Backward Compatibility**: Existing pages, APIs, queries, and features must continue working.
- **Dominican Artist Creation & Draft Status Policy**:
  - Before creating any missing artist discovered during discography, works, or credits workflows, confirm that the artist is **Dominican**.
  - Newly created artists must ALWAYS be saved with `status = 'draft'` (NEVER published immediately).
  - Leaving new artists in `draft` status allows the editor to review details and upload their photo before publishing.
- **Recording-Driven Work & Credit Creation Rule**:
  - When creating or documenting the catalogue of an arranger, composer, or lyricist, do NOT create standalone/floating Work entities directly without release context.
  - Always create the song/track within the **Performer's Discography** (on their Release/Recording), and attach the composer, lyricist, or arranger through credits (`work_credits` / `recording_credits`).
  - This anchors the song to historical release evidence and automatically populates the creator's Works Portfolio tab.
- **Contributor Ingestion & Karaoke Rules (Editor Clarification, 2026-10-24)**:
  - **No Karaokes / Imitations**: Under no circumstances will Karaoke, backing tracks, or imitation cover albums (e.g. «Pistas Para Cantar Como...») be cataloged.
  - **International Works Must Be Original**: For international/foreign performers, creative contributions are ONLY cataloged if the song is an **original work** composed, arranged, or produced specifically for that foreign artist, or premiered by them. Re-recordings or covers of pre-existing Dominican songs by foreign artists (e.g. foreign orchestras covering existing national hits) are **strictly excluded**; taking an existing national song and covering it abroad does not constitute an international work of the author.
  - **Existing Songs in Discography**: If a song already exists in the performer's discography, do not duplicate releases or recordings; ONLY attach/update credits (`work_credits`).
  - **Missing Performers**: If the performer does not exist, do NOT create them during a contributor task; exclude and report at the end.
  - **Performers Without Discography**: If the performer exists in Mangulina but does NOT have their discography built yet, do NOT create partial floating tracks; report them at the end to be worked on as a dedicated discography task.
- **Self-Performance Presentation Rule**: Songs performed by an artist belong strictly in their **Discography** tab. An artist's **Works / Compositions Portfolio** tab must NEVER duplicate songs performed by themselves, but is reserved exclusively for works written, composed, arranged, or produced for OTHER artists (DATA_GOVERNANCE.md Section 5.5).
- **Musical Genres Policy**: Never invent musical genres or subgenres. All genres assigned to artists (`primary_genre`, `genres`) or referenced in biographies must come strictly from the frozen database taxonomy in the `genres` table (e.g. do not invent terms like «merengue jocoso»). If a genre or subgenre is not in the database, do not invent it; ask the editor.
- **Search Before Creating**: Check existing schema, tables, columns, and previous migrations before adding new structures.
- **Verification**: Ensure TypeScript compiles cleanly (`npx tsc --noEmit`) and existing functionality remains unbroken before completing a task.
