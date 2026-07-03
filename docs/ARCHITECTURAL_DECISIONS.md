# Architectural Decision Records (ADRs)

**Mangulina Architectural Decision Log**

This document records major architectural and editorial decisions made throughout the life of Mangulina. Each decision explains the context, the choice made, and the rationale behind it.

This is NOT a schema reference, governance guide, or implementation manual. It is a historical record explaining **why** important decisions were made.

---

## ADR-001: Separate Performers, Creative Contributors, and Release Artists

**Date:** 2026-07-03  
**Status:** Accepted  
**Author:** Mangulina Architecture Team

### Context

Early in the project, it became unclear how to model different types of artist involvement in music:
- Artists who performed on a recording (vocalist, guitarist, engineer)
- Artists who created a work (composer, lyricist, arranger)
- Artists credited for a release (album artist, featured artist, compilation artist)

Without clear distinction, data would conflate these concepts, making it impossible to accurately document who did what.

### Decision

Implement a three-level credit system:
- **Performance Credits** (Recording level) — Who performed on this specific recording
- **Creative Credits** (Work level) — Who created/composed the underlying work
- **Release Credits** (Release level) — Who is credited for the album/single

### Rationale

This separation achieves several goals:
1. **Accuracy** — An artist's role is unambiguous (performer ≠ composer ≠ album artist)
2. **Reusability** — A work's composition stays the same across multiple recordings and releases
3. **Dominican Music Focus** — Enables documentation of Dominican producers working with international artists
4. **Historical Preservation** — Captures exact credit text as released (e.g., "Juan Luis Guerra y 4.40")

### Alternatives Considered

- **Single Credits Table:** Conflate all roles in one table (rejected: loses semantic clarity)
- **Artist-to-Artist Links:** Model only collaboration without performance details (rejected: insufficient detail)
- **Credits in Each Entity:** Store all credit info redundantly (rejected: violates DRY principle)

### Consequences

- **Positive:**
  - Editorial clarity about who contributed what
  - Support for complex producer/performer/composer relationships
  - Ability to credit Dominican creators on international releases
  - Historical accuracy in credit preservation

- **Negative:**
  - Requires more complex queries to get "all credits for a recording"
  - More tables to maintain (recording_credits, credited_work_credits, release_artists)
  - Steeper learning curve for new contributors

### Future Considerations

As Mangulina evolves, this model supports:
- Publishing rights and publishing companies
- Session musicians and studio session tracking
- Royalty information and split sheets
- Copyright ownership documentation

---

## ADR-002: Mangulina Catalogs Dominican Music Only

**Date:** 2026-07-03  
**Status:** Accepted  
**Author:** Mangulina Editorial Team

### Context

Early discussions about Mangulina's scope raised the question: What international content, if any, belongs in a Dominican music database?

Including all music would dilute focus. Excluding all international content would miss important Dominican creator contributions.

### Decision

**Scope:** Mangulina catalogs Dominican music and Dominican creators.

**International content is included only when necessary to document Dominican creators' contributions.**

Examples:
- ✅ Luny Tunes producing a Daddy Yankee album (Dominican producers)
- ✅ Juan Luis Guerra composing for an international artist (Dominican composer)
- ❌ International reggaeton artist with no Dominican connection
- ❌ K-pop group performing in Dominican Republic (neither creator nor performer is Dominican)

### Rationale

1. **Mission Clarity** — Mangulina preserves Dominican music heritage, not a universal music database
2. **Scope Management** — Keeps catalog manageable and focused
3. **Editorial Authority** — Mangulina makes editorial judgments about what's in scope
4. **Creator Credit** — Ensures Dominican creators receive proper recognition even for international work
5. **Long-term Sustainability** — A focused catalog is easier to maintain and curate

### Alternatives Considered

- **All Music:** Include everything (rejected: loses focus, unsustainable)
- **Dominican Artists Only:** Exclude international collaborations (rejected: hides Dominican contributions)
- **Language-Based:** Include Spanish-language music (rejected: misses English-language Dominican contributions)

### Consequences

- **Positive:**
  - Clear editorial scope
  - Dominican creators properly credited for international work
  - Manageable database size
  - Focus on quality over quantity

- **Negative:**
  - Some international artists' work must be excluded
  - Requires editorial judgment for borderline cases
  - May leave gaps in understanding some Dominican creators' work

### Future Considerations

As Mangulina documents more international collaborations, the decision may need refining:
- How to handle multi-national groups where one member is Dominican
- Whether to include diaspora artists (Dominican heritage, but grew up elsewhere)
- How to handle artists who worked in Dominican Republic but are not Dominican nationals

---

## ADR-003: Freeze the Official Genre Taxonomy

**Date:** 2026-06-12  
**Status:** Accepted  
**Author:** Mangulina Editorial Team

### Context

During the first phase of cataloging, the genre taxonomy evolved multiple times as new music was discovered. This created confusion and required re-categorization of existing entries.

At 2026-06-12, the taxonomy was finalized and promoted to "approved" status.

### Decision

The genre taxonomy is frozen.

No new genres may be added without explicit editorial review and approval.

### Rationale

1. **Data Consistency** — A fixed taxonomy ensures all music is categorized in the same way
2. **Historical Accuracy** — Dominician music doesn't evolve faster than new genres appear; existing taxonomy covers the scope
3. **Editorial Authority** — Genre decisions require human judgment and context
4. **Backward Compatibility** — Prevents re-categorization of millions of historical entries

### Alternatives Considered

- **Open-Ended Genres:** Allow contributors to add genres freely (rejected: leads to inconsistency and duplicates)
- **Versioned Taxonomies:** Maintain multiple genre versions (rejected: too complex, breaks historical tracking)

### Consequences

- **Positive:**
  - Genre categorization is predictable and consistent
  - Historical entries never change categories
  - Clear process for evaluating new genres

- **Negative:**
  - New or emerging genres may be underrepresented
  - Requires editorial process for any genre additions
  - May not perfectly match external genre standards (Spotify, MusicBrainz, etc.)

### Future Considerations

If a new genre genuinely emerges in Dominican music and cannot fit existing categories:
1. Document the case for the new genre
2. Get editorial team consensus
3. Create migration to recategorize affected entries
4. Update genre taxonomy documentation

---

## ADR-004: Three-Level Credit Architecture

**Date:** 2026-07-03  
**Status:** Accepted  
**Related to:** ADR-001  
**Author:** Mangulina Architecture Team

### Context

Building on ADR-001 (three-level credit system), this decision formalizes where each type of credit lives in the database.

### Decision

- **Work-Level Credits:** `credited_work_credits` table
  - Composer, lyricist, arranger, orchestrator
  - These credits belong to the composition, not the recording

- **Recording-Level Credits:** `recording_credits` table
  - Vocalist, guitarist, producer, engineer, mixer, mastering engineer
  - These credits describe who performed on this specific recording

- **Release-Level Credits:** `release_artists` table
  - Primary artist, featured artist, compilation artist, presenter
  - These credits describe the album/single as a product

### Rationale

This organization ensures:
- One source of truth for each credit type
- No duplication (information stored once)
- Clear responsibility boundaries
- Support for complex relationships (e.g., same work recorded by different artists)

### Alternatives Considered

- **Single Credits Table:** All credits in one table with role types (rejected: violates normalization, creates confusion)
- **Nested Structure:** Credits embedded in entities (rejected: violates separation of concerns)

### Consequences

- **Positive:**
  - Clear data ownership boundaries
  - Reusable works across recordings
  - Supports complex producer/performer relationships

- **Negative:**
  - Requires JOINs to retrieve complete credit picture
  - More tables to maintain and document

### Future Considerations

As publishing and licensing data are added, this architecture will be extended with:
- Publishing rights tables
- Royalty information
- Publishing company credits

---

## ADR-005: Accuracy Is Preferred Over Completeness

**Date:** 2026-07-03  
**Status:** Accepted  
**Author:** Mangulina Editorial Team

### Context

During early curation, the team discovered a tension:
- Complete but potentially incorrect entries
- Incomplete but verified correct entries

Pressure to "fill the database" conflicted with editorial integrity.

### Decision

**Accuracy is the primary metric of database quality.**

An incomplete but correct entry is always preferable to a complete but inaccurate one.

Specifically:
- Leave fields empty if the information cannot be verified
- Do not guess artist roles
- Do not invent credit information
- Do not add information marked as uncertain

### Rationale

1. **Long-term Trust** — A database with known limitations is trustworthy; one with hidden inaccuracies is not
2. **Editorial Integrity** — Mangulina's value is in preservation of historical accuracy, not volume
3. **Future Curation** — Incomplete data can be filled later with proper research; incorrect data misleads future researchers
4. **Dominican Music Heritage** — Dominican music deserves accurate representation

### Alternatives Considered

- **Completeness First:** Populate fields aggressively, mark uncertain entries (rejected: too risky for historical data)
- **Crowd-Source Validation:** Accept community edits without verification (rejected: loses editorial control)

### Consequences

- **Positive:**
  - Readers can trust the database
  - Reduces need for data cleanup later
  - Encourages proper research before entry

- **Negative:**
  - Database grows more slowly
  - Some artist credits will remain incomplete
  - Requires more editorial effort

### Future Considerations

This decision shapes the curation culture:
- Community contributions should be reviewed before inclusion
- Research projects should prioritize accuracy over speed
- Admin tools should encourage verification, not speed

---

## ADR-006: Preserve Backward Compatibility During Schema Evolution

**Date:** 2026-07-03  
**Status:** Accepted  
**Author:** Mangulina Architecture Team

### Context

As the application grows, schema changes become inevitable. However, breaking changes can disrupt existing workflows, integrations, and application code.

### Decision

All schema changes must maintain backward compatibility.

When a breaking change is unavoidable:
1. Add new tables/columns alongside old ones (Phase A)
2. Migrate application code to use new tables (Phase B)
3. After 6+ months of validation, deprecate legacy fields (Phase C)
4. Only after 12+ months, remove legacy fields (Phase D)

Example: `recordings.artist_id` is legacy but kept because queries still use it.

### Rationale

1. **Continuous Deployment** — Breaking changes require coordinated deployments
2. **External Integrations** — External systems may depend on current schema
3. **Operational Safety** — Gradual migration allows rollback if issues arise
4. **Historical Queries** — Researchers may have stored queries using old schema

### Alternatives Considered

- **Big Bang Rewrites:** Replace old schema wholesale (rejected: high risk)
- **Parallel Maintenance:** Support two schemas indefinitely (rejected: unsustainable)

### Consequences

- **Positive:**
  - Safe, low-risk schema evolution
  - Existing integrations continue working
  - Time to discover and fix migration issues

- **Negative:**
  - Database carries legacy fields longer
  - Queries sometimes need JOINs instead of direct access
  - Documentation must explain both old and new approaches

### Future Considerations

As the application matures:
- Establish clear deprecation timelines
- Monitor usage of legacy fields before removal
- Document migration paths for external consumers

---

## ADR-007: Additive Migrations First; Deprecate Before Removal

**Date:** 2026-07-03  
**Status:** Accepted  
**Related to:** ADR-006  
**Author:** Mangulina Architecture Team

### Context

Related to ADR-006, this decision specifies the migration strategy.

The team observed that immediate column removal causes problems. A phased approach is safer and more maintainable.

### Decision

Schema migration happens in phases:

1. **Phase A (Additive):** Add new tables/columns; keep old ones
2. **Phase B (Dual-Write):** Application uses new schema; legacy still available
3. **Phase C (Deprecation):** Mark legacy fields as deprecated; document removal timeline
4. **Phase D (Removal):** After validation period, remove legacy fields

### Rationale

1. **Safety** — Each phase is independently testable and reversible
2. **Validation** — Allows time to discover issues before removal
3. **Zero Downtime** — No service interruption during migration
4. **Audit Trail** — Deprecation comments document the removal timeline

### Alternatives Considered

- **Immediate Removal:** Delete old fields immediately (rejected: risky, breaks existing code)
- **Forever Maintenance:** Keep legacy fields indefinitely (rejected: technical debt grows)

### Consequences

- **Positive:**
  - Safe, reversible migrations
  - Time to validate before commitment
  - Clear deprecation path

- **Negative:**
  - Database temporarily carries redundant fields
  - Migration takes longer
  - Developers must understand both old and new schema

### Future Considerations

As Mangulina matures:
- Establish automated detection of deprecation deadline violations
- Document deprecation timelines in schema comments
- Create tools to identify code still using deprecated fields

---

## ADR-008: Documentation Is Part of Every Architectural Change

**Date:** 2026-07-03  
**Status:** Accepted  
**Author:** Mangulina Architecture Team

### Context

The team discovered that architectural changes without documentation created confusion for future developers.

Undocumented decisions are re-questioned and re-debated by later team members.

### Decision

Every architectural change requires corresponding documentation updates:

- **New Tables/Entities:** Update DATA_GOVERNANCE.md
- **New Roles/Relationships:** Update ROLE_DICTIONARY.md
- **New Editorial Rules:** Update DATA_GOVERNANCE.md Editorial Rules section
- **New Constraints:** Document in migration comments
- **Major Decisions:** Create or update ARCHITECTURAL_DECISIONS.md
- **Build/Deployment Changes:** Update BUILD_NOTES.md

### Rationale

1. **Knowledge Transfer** — Future developers understand not just *what* changed, but *why*
2. **Prevents Re-Debate** — Documented decisions don't need to be revisited
3. **Onboarding** — New contributors can learn from the decision history
4. **Audit Trail** — Explains the evolution of the system

### Alternatives Considered

- **Documentation as Afterthought:** Require docs after implementation complete (rejected: often forgotten)
- **Minimal Documentation:** Only document major changes (rejected: loses context for small decisions)

### Consequences

- **Positive:**
  - Clear decision history
  - Faster onboarding
  - Prevents repeated debates
  - Supports long-term maintenance

- **Negative:**
  - Architectural changes take slightly longer
  - Documentation must be kept in sync
  - Requires discipline from contributors

### Future Considerations

As the project grows:
- Establish documentation review as part of code review
- Create automated checks for documentation completeness
- Archive old decisions when they become historical reference only

---

## Future ADRs

Space for future architectural decisions:

- ADR-009: [Reserved for future decision]
- ADR-010: [Reserved for future decision]
- ADR-011: [Reserved for future decision]

When proposing a new architectural decision:

1. Create a new ADR following the format above
2. Get consensus from the architecture team
3. Update this document
4. Reference the ADR in related code and migrations
5. Cross-reference in other documentation (DATA_GOVERNANCE.md, etc.)

---

## How to Reference ADRs

When making decisions that relate to architectural choices:
- Reference the ADR number: "Per ADR-001, performance credits belong to the recording level"
- Link to this document
- Explain how your change aligns with or evolves the decision

### Example

> According to ADR-006 (Preserve Backward Compatibility), we must keep `recordings.artist_id` even though `recording_credits` is now the primary table. This migration adds new fields while maintaining the legacy field for 6+ months.

---

**Document Authority:** Official  
**Maintainer:** Mangulina Architecture Team  
**Last Updated:** 2026-07-03  
**Status:** Active
