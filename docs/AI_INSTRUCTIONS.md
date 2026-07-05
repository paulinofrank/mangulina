# AI Coding Assistant Instructions for Mangulina

**Status:** Official Project Rules  
**Audience:** AI coding assistants, automated systems  
**Authority:** Project governance  
**Last Updated:** 2026-07-03

---

## Before You Start

Read these documents **in order** before making any code or database changes:

1. **[DATA_GOVERNANCE.md](DATA_GOVERNANCE.md)** — The canonical data model and editorial rules
   - Read Sections 1–8 to understand the conceptual model
   - Review Section 10 (Editorial Rules) before proposing database changes
   - Refer back to Section 5 (Performer vs. Creative Contributor) when modeling credits

2. **[EDITORIAL_GUIDELINES.md](EDITORIAL_GUIDELINES.md)** — Editorial philosophy and decision-making
   - How to handle artists, works, recordings, and releases
   - When to create new entries vs. update existing ones
   - Guidelines for disputed or uncertain information

3. **ROLE_DICTIONARY.md** — Complete list of valid role names
   - Do not invent new role names
   - Search this document before adding any new `role` field value

4. **BUILD_NOTES.md** — Build/deployment conventions
   - Follow project conventions for migrations, naming, and structure

---

## Before Proposing New Architecture

Before suggesting any of the following:

- New tables or columns
- New relationship models or redesigns
- New role names or relationships
- Editorial rules or scope changes

**You MUST first review:**

1. **[ARCHITECTURAL_DECISIONS.md](ARCHITECTURAL_DECISIONS.md)** — Why major decisions were made
   - Read the ADRs related to your proposal
   - Understand the historical context and rationale
   - Check for consequences already identified

2. **[DATA_GOVERNANCE.md](DATA_GOVERNANCE.md)** — Current data model and editorial rules
   - Verify your proposal doesn't conflict with existing structure
   - Check entity definitions and relationships
   - Review editorial rules

3. **ROLE_DICTIONARY.md** — Valid roles and relationships
   - Do not invent new roles without understanding existing ones
   - Check where roles belong (recording, work, release level)

### If You Conflict with an Existing Decision

If your proposal conflicts with an existing ADR, you must:

1. **Explain why the decision is no longer appropriate**
   - What has changed since the original decision?
   - Is there new technical information?
   - What evidence supports reconsidering?

2. **Document the trade-offs**
   - What do we gain by changing the decision?
   - What do we lose?
   - What's the risk?

3. **Plan the migration strategy**
   - How do we move from old approach to new?
   - How do we preserve backward compatibility?
   - What's the timeline for deprecation and removal?

4. **Identify documentation updates required**
   - What ADRs need to be superseded?
   - What sections of DATA_GOVERNANCE.md change?
   - What new ADR needs to be created?

### Example: Challenging an Existing Decision

❌ **Wrong approach:**
> "We should add a new `composer` column to the recordings table because it would be convenient."

✅ **Right approach:**
> "Per ADR-004, creative credits belong to the work level, not recording level. However, I propose reconsidering this because:
> 1. Most queries for 'who composed this recording' require complex JOINs
> 2. Our current usage shows 95% of recordings have work-level credits
> 
> Trade-off: Denormalizing composer_id to recordings would speed queries but violate the three-level credit architecture.
>
> Proposal: Create a materialized view `recording_composers` that caches this join, preserving the original architecture while improving query performance.
>
> This aligns with ADR-006 (backward compatibility) and ADR-007 (additive migrations) by adding new structure without changing existing tables."

---

## Project Mission

**Mangulina is the Dominican Music Database.**

### Core Principles (from DATA_GOVERNANCE.md Section 2)

- **Accuracy > Completeness** — An incomplete but correct entry is better than a complete but wrong one
- **One Source of Truth** — Information exists in one place; relationships point to it
- **Avoid Duplication** — Don't store the same fact in multiple tables
- **Preserve Historical Accuracy** — How music was credited and released matters
- **Never Sacrifice Correctness for Convenience** — Don't add quick fixes that compromise integrity

### Your Responsibility as an AI

When you write code or propose database changes, you are:
- Preserving Dominican music heritage
- Maintaining historical accuracy
- Enabling future researchers and developers to trust the data

**Do not** introduce features or schema changes that conflict with the editorial model described in DATA_GOVERNANCE.md.

---

## Database Rules (Non-Negotiable)

These rules must be followed before any database migration is created.

### Rule 1: Never Create Duplicate Entities
```
WRONG:
CREATE TABLE artist_profiles;
CREATE TABLE artist_info;
CREATE TABLE artist_metadata;
(Three tables for the same concept)

RIGHT:
Extend the existing artists table with new columns.
Or create a separate table that links to artists via foreign key.
```

### Rule 2: Prefer Extending Existing Tables
```
WRONG:
CREATE TABLE artist_recordings;
(New table for recording performers)

RIGHT:
Add columns to existing recording_credits table.
Or review existing schema to see if recording_credits already serves this purpose.
```

### Rule 3: Never Remove Columns Without Migration Strategy
```
WRONG:
ALTER TABLE recordings DROP COLUMN artist_id;
(Breaking change; existing queries fail)

RIGHT:
1. Plan backward-compatibility strategy
2. Deprecate column (mark as unused)
3. Update all queries to use new tables
4. Wait for 6+ months of stability
5. Then remove column in a separate migration
(See DATA_GOVERNANCE.md Section 2, Principle 4)
```

### Rule 4: Preserve Backward Compatibility
All changes must work with existing code.

If a query uses `recordings.artist_id`, that field must continue working even after introducing a new `recording_artists` table.

### Rule 5: Always Search for Existing Tables First
```
Before proposing:
CREATE TABLE release_credits;

Search:
- Existing schema
- Previous migrations
- Codebase for similar patterns
- DATA_GOVERNANCE.md for related entities

You may discover release_artists already exists,
or that the concept belongs elsewhere.
```

### Rule 6: Never Create New Role Names Without Approval
```
WRONG:
INSERT INTO recording_credits (role) VALUES ('fretboard_wizard');

RIGHT:
1. Check ROLE_DICTIONARY.md for existing values
2. If role doesn't exist, update ROLE_DICTIONARY.md first
3. Explain why the new role is needed
4. Get consensus on the name
5. Then use it in code
```

### Rule 7: Never Invent Genres
```
WRONG:
INSERT INTO recordings (genre) VALUES ('reggaeton-fusion-trap');

RIGHT:
1. Use genres from the canonical genre taxonomy (in database)
2. If a genre is missing, discuss whether it's in scope
3. Check existing genre table before inventing new ones
4. Refer to DATA_GOVERNANCE.md Section 7 (National vs. International)
```

### Rule 8: Never Invent Relationship Types
```
WRONG:
ALTER TABLE recording_credits ADD COLUMN relationship_type;
INSERT ... VALUES ('mentor');

RIGHT:
1. Check existing role/relationship types in schema
2. If a new relationship type is needed, update ROLE_DICTIONARY.md
3. Discuss whether this belongs in the editorial model
4. Document the relationship in DATA_GOVERNANCE.md
```

---

## Credits Model (Summary)

**This is the most common source of mistakes. Read DATA_GOVERNANCE.md Sections 5–8 completely.**

### Three-Layer Credit System

| Layer | Location | Question | Examples |
|-------|----------|----------|----------|
| **Creative** | Work table | Who created this composition? | Composer, lyricist, arranger |
| **Performance** | Recording table | Who performed on this recording? | Singer, guitarist, producer, engineer |
| **Release** | Release table | Who is credited for this album? | Primary artist, featured, compilation |

### Critical Rule: Never Mix Layers
```
WRONG:
recording_credits table with role = 'composer'
(Composer is a work-level credit, not recording-level)

WRONG:
credited_works table with role = 'guitar'
(Guitar player is a recording-level credit, not work-level)

RIGHT:
Work → credited_work_credits (composer, lyricist, arranger)
Recording → recording_credits (vocals, guitar, producer, engineer)
Release → release_artists (primary, featured, compilation)
```

### credited_as Field

The `release_artists` table includes a `credited_as` field (nullable text):

```sql
Artist Entity: "Juan Luis Guerra"
credited_as: "Juan Luis Guerra y 4.40"
(Preserves historical credit text)
```

This field captures how an artist was credited on the release. It's **not duplication**—it's historical data preservation (see DATA_GOVERNANCE.md Section 2, Principle 3).

### When in Doubt

Refer to DATA_GOVERNANCE.md Section 5 (Performer vs. Creative Contributor) and Section 8 (Credits Architecture).

If you still have questions, **do not guess**. Comment in the code or ask for clarification rather than making an assumption that could perpetuate incorrect modeling.

---

## Development Rules

### Strict TypeScript
- All code must pass TypeScript type checking
- No `any` types unless absolutely necessary (and with explanation)
- Prefer strict mode (`strict: true`)

### Keep Existing Coding Style
- Match the codebase style (indentation, naming, structure)
- Don't refactor surrounding code unless necessary for the change
- Use existing conventions (see BUILD_NOTES.md)

### Avoid Breaking Changes
- Existing pages must continue to work
- Existing APIs must remain compatible
- Deprecate before removing

### Preserve SEO
- Don't change URL slugs without 301 redirects
- Don't remove canonical tags or meta descriptions
- Don't restructure artist/recording/release pages without SEO review

### Preserve i18n (Internationalization)
- Don't hardcode text in components
- Use existing translation keys
- Update TRANSLATION_KEYS if adding new user-facing text

### Preserve Analytics
- Don't remove tracking events
- Don't change event names without updating dashboards
- Document any analytics-related changes

---

## Database Changes Checklist

Before creating any migration file, complete this checklist:

### Research Phase
- [ ] Read DATA_GOVERNANCE.md Sections 3–10 (Entity Definitions through Editorial Rules)
- [ ] Search existing schema for similar tables/columns
- [ ] Search git history for previous migrations on this topic
- [ ] Search codebase for references to the thing you're changing
- [ ] Check ROLE_DICTIONARY.md if adding new roles

### Design Phase
- [ ] Explain why a new table is needed (or why extending existing table doesn't work)
- [ ] Confirm this doesn't conflict with editorial model
- [ ] Verify relationships align with DATA_GOVERNANCE.md model
- [ ] Plan for backward compatibility
- [ ] Document the change in migration comments

### Implementation Phase
- [ ] Follow migration naming convention (YYYYMMDDHHMMSS_description.sql)
- [ ] Include forward migration (up)
- [ ] Include rollback migration (down)
- [ ] Add RLS policies if needed
- [ ] Create indexes on foreign keys
- [ ] Add constraints (NOT NULL, UNIQUE, CHECK) where appropriate

### Validation Phase
- [ ] Migration is reversible
- [ ] Existing queries still work
- [ ] TypeScript types updated if needed
- [ ] Tests pass (if applicable)
- [ ] Documentation updated

---

## Common Mistakes to Avoid

### Mistake 1: Creating Duplicate Relationship Tables
```
WRONG:
artist_recordings, artist_credits, artist_collaborators
(Three tables for the same concept)

RIGHT:
recording_credits (unified table with role field)
(One table, different roles distinguish the relationship)
```

### Mistake 2: Storing Derivable Information
```
WRONG:
recording table: artist_name (duplicates artists.name)

RIGHT:
recording table: artist_id (links to artists table)
JOIN to get name when needed
```

### Mistake 3: Confusing Levels
```
WRONG:
Work has a "producer" field
(Producer is a recording-level credit, not work-level)

RIGHT:
Recording has producer in recording_credits
Work has composer in credited_work_credits
```

### Mistake 4: Breaking SEO
```
WRONG:
Change /artist/juan-luis-guerra to /artists/juan-luis-guerra
(Old links break)

RIGHT:
Implement 301 redirect from old path to new path
Update all internal links
Test that SEO metrics don't drop
```

### Mistake 5: Removing Columns Too Quickly
```
WRONG:
DROP COLUMN recordings.artist_id
(Breaks queries that depend on it)

RIGHT:
Keep for backward compatibility
Deprecate (document as "legacy; use recording_credits instead")
Remove 6+ months later after migration complete
```

### Mistake 6: Hardcoding Values
```
WRONG:
if (role === 'guitar') { ... }
(Assumes only 'guitar' exists; what about 'bass'?)

RIGHT:
Check ROLE_DICTIONARY.md for valid values
Handle any valid role appropriately
```

---

## Documentation Rule

**If you change the schema, update the documentation.**

### Changes Requiring Documentation Updates

| Change | Documents to Update |
|--------|---------------------|
| New table | DATA_GOVERNANCE.md (Section 3), ROLE_DICTIONARY.md (if applicable) |
| New column | DATA_GOVERNANCE.md (entity section) |
| New role/relationship type | ROLE_DICTIONARY.md |
| New feature affecting users | README.md, relevant user docs |
| Breaking change | Changelog, migration notes |

### Documentation is Not Optional

Don't create a migration without documenting it. The next developer (or you, six months from now) needs to understand:
- Why the change was needed
- What problem it solves
- How it relates to the data model

---

## Final Checklist: Before Submitting Code

Use this checklist for every PR, commit, or deployment:

### Code Quality
- [ ] TypeScript passes (no build errors)
- [ ] Code follows project style
- [ ] No `any` types without explanation
- [ ] No hardcoded values (use constants, config, or database)

### Backward Compatibility
- [ ] Existing pages still work
- [ ] Existing queries still work
- [ ] Existing APIs still work
- [ ] No 404s from removed endpoints

### Database Changes (if applicable)
- [ ] Migration is forward-compatible
- [ ] Migration is reversible
- [ ] Foreign keys are defined
- [ ] Indexes are created
- [ ] RLS policies are configured
- [ ] No breaking changes without migration strategy

### Documentation
- [ ] DATA_GOVERNANCE.md updated (if schema change)
- [ ] ROLE_DICTIONARY.md updated (if new roles)
- [ ] Inline code comments added (if needed for clarity)
- [ ] Commit message explains why (not just what)

### Testing
- [ ] TypeScript compiles
- [ ] Tests pass (if applicable)
- [ ] Manual testing done (if UI change)
- [ ] No console errors

### SEO & Analytics
- [ ] No broken links
- [ ] No changed URLs without redirects
- [ ] Analytics still tracking
- [ ] No removed meta tags

### Final Sign-Off
- [ ] Code is production-ready
- [ ] No shortcuts or "we'll fix it later"
- [ ] You would be confident deploying this
- [ ] Documentation is complete

---

## When to Ask for Help

**Do not guess.** Ask for clarification in these cases:

- You're unsure whether a new table is needed (ask for data model review)
- You're unsure about a role name or relationship type (ask in ROLE_DICTIONARY.md)
- You're unsure about editorial rules (refer to DATA_GOVERNANCE.md and ask if still unclear)
- You're unsure whether a change will break SEO (ask an SEO reviewer)
- You're unsure about backward compatibility (ask in code review)

It's better to ask and be sure than to guess and break something.

---

## Example: Proposing a New Table

**Bad approach:**
```
I'll create a new table called artist_collaborations 
to track who works with whom.
```

**Good approach:**
```
Proposal: Create a relationship table for artist collaborations

Reason: Track which artists have worked together, 
        with collaboration type and year.

Research:
- Checked existing schema: no artist-to-artist relationship table exists
- Checked migrations: no prior art collaboration work
- Checked DATA_GOVERNANCE.md: no existing coverage of collaborations

Questions:
1. Should this be at the artist level or recording level?
2. What relationship types are valid? (partnership, duo, guest appearance, etc.)
3. Should we update ROLE_DICTIONARY.md?

Proposed schema:
- artist_collaborations (artist_id, collaborator_id, role, year, description)
- Indexes on (artist_id, collaborator_id)
- RLS: public read, service_role manage
- Backward compatible: yes

References: DATA_GOVERNANCE.md Section 9 (Data Modeling Rules)
```

---

## Resources

**Always refer to these documents in this order:**

1. **[DATA_GOVERNANCE.md](DATA_GOVERNANCE.md)** — Conceptual model and editorial rules
2. **ROLE_DICTIONARY.md** — Valid role names and relationships
3. **BUILD_NOTES.md** — Build/deployment conventions
4. **README.md** — Project overview and setup

**Within the codebase:**

- **supabase/migrations/** — Past database changes (learn from patterns)
- **src/types/** — TypeScript type definitions
- **src/lib/queries/** — Example database queries
- **.claude/settings.json** — Project configuration

---

## Authority & Updates

This document is **official project policy**.

It represents the consensus of the Mangulina team on how AI assistants should approach code and database changes.

**Changes to this document require:**
- Discussion with the team
- Update to corresponding governance documents
- Clear explanation of why the rule changed

**If you find a rule that doesn't make sense,** document the issue and propose a change. But follow the rule until officially updated.

---

## Closing Note

You are not just writing code. You are maintaining a historical archive of Dominican music.

Every table, column, and relationship you create will be used by developers, researchers, and fans for years to come.

**Get it right the first time.**

- Accuracy > Speed
- Clarity > Cleverness  
- Compatibility > Convenience
- Documentation > Assumptions

When in doubt, **read the docs, ask questions, and verify your assumptions.**

---

**Document Version:** 1.0  
**Status:** Active  
**Last Updated:** 2026-07-03  
**Maintained by:** Mangulina Development Team

Questions? Refer to DATA_GOVERNANCE.md or open a discussion with the team.
