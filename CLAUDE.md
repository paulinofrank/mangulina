# Mangulina AI Entry Point

**CLAUDE.MD — Required Reading Before Making Code or Schema Changes**

This file is the starting point for Claude Code and any AI assistant working on Mangulina.

If you are about to:
- Create a database migration
- Add a new table or column
- Introduce new roles or relationships
- Change architectural patterns
- Modify editorial workflows

**Read this file and the linked documents first.**

---

## Read These Documents First

In this order. Do not skip.

### 1. **[docs/AI_INSTRUCTIONS.md](docs/AI_INSTRUCTIONS.md)** ← Start here
Project rules for AI assistants. Non-negotiable.
- Database rules (8 core rules)
- Credits model (three-layer system)
- Development rules
- Checklists before submitting

### 2. **[docs/DATA_GOVERNANCE.md](docs/DATA_GOVERNANCE.md)** ← Then read this
Conceptual data model and editorial authority.
- Entity definitions (Artist, Work, Recording, Release, Track)
- Relationship model with diagrams
- Performer vs. Creative Contributor (critical distinction)
- Editorial rules for creating/merging entities
- Examples (Johnny Ventura, Juan Luis Guerra, Luny Tunes, compilations)

### 3. **[docs/ROLE_DICTIONARY.md](docs/ROLE_DICTIONARY.md)** ← Reference this
Valid role names and relationship types.
- Don't invent new roles
- Search this before adding to any role field

### 4. **[docs/BUILD_NOTES.md](docs/BUILD_NOTES.md)** ← If modifying build/architecture
Build and deployment conventions.
- Only needed if touching CI/CD, migrations, or infrastructure

These documents are **authoritative**. Follow them.

---

## Core Principles

Never violate these:

✅ **Mangulina is the Dominican Music Database**  
Preserve Dominican music heritage. Accuracy matters more than completeness.

✅ **Preserve Editorial Accuracy**  
Historical credit text, original titles, and relationships must be preserved as released.

✅ **Preserve Backward Compatibility**  
Existing pages, APIs, queries, and features must continue working.

✅ **Search Before Creating**  
Before proposing a new table, column, or role:
- Search the current schema
- Search previous migrations
- Search the codebase

You'll often find it already exists or belongs elsewhere.

✅ **Update ROLE_DICTIONARY.md First**  
Never introduce a new role name without updating the dictionary and explaining why.

✅ **Keep SEO, i18n, Analytics Intact**  
- No broken links or changed URLs without redirects
- No hardcoded text (use translation keys)
- No removed tracking events

✅ **Update Documentation**  
If you change the schema, update:
- docs/DATA_GOVERNANCE.md (if entity definitions change)
- docs/ROLE_DICTIONARY.md (if new roles)
- docs/AI_INSTRUCTIONS.md (if new rules)
- Inline code comments (if not obvious)

---

## Before Creating a Migration

Follow this checklist:

- [ ] Searched existing schema for similar tables/columns
- [ ] Searched git history for previous work on this topic
- [ ] Searched codebase for current references
- [ ] Read relevant sections of DATA_GOVERNANCE.md
- [ ] Checked ROLE_DICTIONARY.md if adding roles
- [ ] **Explained why a new table is needed** (not just "to store X")
- [ ] Preferred extending existing tables over creating new ones
- [ ] Confirmed relationship aligns with the data model
- [ ] Planned for backward compatibility
- [ ] Documented the change in migration comments

**Example good reason for a migration:**
> "Adding `credited_as` to `release_artists` to preserve exact historical credit text (e.g., 'Juan Luis Guerra y 4.40') separately from canonical artist name."

**Example bad reason:**
> "Creating new table `artist_info` to store artist information."  
> (Use existing `artists` table or explain why it doesn't fit.)

---

## Before Finishing

Verify these before submitting code:

- [ ] **TypeScript compiles** — No type errors
- [ ] **Existing functionality works** — Pages load, queries work, no 404s
- [ ] **Documentation updated** — Schema changes documented in governance files
- [ ] **Migration reversible** — Can rollback if needed
- [ ] **No breaking changes** — Backward compatible

If uncertain about any of these, ask for review rather than guessing.

---

## Quick Reference

| Document | When to Use | Find It |
|----------|------------|---------|
| AI_INSTRUCTIONS.md | Before any code change | docs/AI_INSTRUCTIONS.md |
| DATA_GOVERNANCE.md | Before any schema change | docs/DATA_GOVERNANCE.md |
| ROLE_DICTIONARY.md | When adding roles | docs/ROLE_DICTIONARY.md |
| BUILD_NOTES.md | When modifying build | docs/BUILD_NOTES.md |

---

## Remember

You're not just writing code.

You're maintaining a historical record of Dominican music.

**Get it right the first time.**

- Accuracy > Speed
- Compatibility > Convenience
- Documentation > Assumptions

When in doubt, **read the docs, check existing patterns, and ask questions** rather than guessing.

---

**Last Updated:** 2026-07-03  
**Status:** Active  
**Authority:** Project governance
