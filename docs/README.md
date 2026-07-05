# Mangulina Documentation

**Welcome to the Mangulina Project Documentation.**

This directory contains the authoritative guides for developing, contributing to, and understanding the Mangulina Dominican Music Database.

---

## 🎯 Start Here

**New to the project?** Start with this checklist:

1. Read **[CLAUDE.md](../CLAUDE.md)** ← Entry point for all work
2. Read **[AI_INSTRUCTIONS.md](AI_INSTRUCTIONS.md)** ← Rules for AI assistants
3. Read **[DATA_GOVERNANCE.md](DATA_GOVERNANCE.md)** ← Data model and editorial rules
4. Reference **[BUILD_NOTES.md](BUILD_NOTES.md)** ← Build and deployment conventions

---

## Documentation Hierarchy

### Living Documents (Current Truth)

These documents are **continuously updated** as the project evolves. They represent the **current state** of the project's design, rules, and data model.

**The "Constitution" Layer:**
- **[DATA_GOVERNANCE.md](DATA_GOVERNANCE.md)** — The authoritative data model and editorial rules (the "constitution" of Mangulina)
  - Entity definitions, relationships, examples
  - Editorial rules for data quality and scope
  - This is the source of truth for "what is X and why do we model it this way?"

**Rules & Instructions Layer:**
- **[CLAUDE.md](../CLAUDE.md)** — Entry point for all AI assistants and code contributors
  - Links to core documentation, principles, and checklists
- **[AI_INSTRUCTIONS.md](AI_INSTRUCTIONS.md)** — Rules for AI coding assistants
  - Non-negotiable database rules, credits model, development guidelines, decision-review checklist
- **[EDITORIAL_GUIDELINES.md](EDITORIAL_GUIDELINES.md)** — Editorial philosophy and decision-making
  - How to curate music, artists, and relationships
  - Handling duplicates, disputed information, special cases
- **[ROLE_DICTIONARY.md](ROLE_DICTIONARY.md)** — Complete list of valid role names (recording, work, release levels)

**Implementation & Architecture Layer:**
- **[BUILD_NOTES.md](BUILD_NOTES.md)** — Build and deployment conventions
  - Migration patterns, testing, CI/CD
- **[ARCHITECTURAL_DECISIONS.md](ARCHITECTURAL_DECISIONS.md)** — Explains why major decisions were made
  - 8 ADRs covering credit architecture, scope, backward compatibility, etc.

**Technical Reference Layer:**
- **[DATABASE_SCHEMA.md](DATABASE_SCHEMA.md)** — Complete technical reference for the database
  - Table structures, relationships, indexes, constraints
  - Field definitions and data types
- **[I18N_ARCHITECTURE_DIAGRAMS.md](I18N_ARCHITECTURE_DIAGRAMS.md)** — Internationalization system design
- **[I18N_QUICK_FIX_CHECKLIST.md](I18N_QUICK_FIX_CHECKLIST.md)** — i18n common patterns and fixes

### Historical Documents (Reference Only)

These documents are **snapshots in time** and are **never rewritten**. They are preserved for understanding how decisions were made and what work was completed in each phase.

→ **[See reports/](reports/)** for:
- Phase reports (Phase 1.5, Phase 2 implementation)
- Architecture and database audits
- Deployment checklists from specific phases
- Verification and validation reports
- Translation audits and repair documentation

**Key principle:** If permanent docs and historical reports disagree, **trust the permanent docs** — they are current, reports are from a point in time.

---

## Reports & Historical Documents

**Historical implementation reports, audits, and phase documentation** (reference only; may be outdated):

→ **[See reports/](reports/)**

This directory contains:
- Phase 1.5 and Phase 2 implementation reports
- Architecture audits (database, i18n)
- Deployment checklists and decision matrices
- Verification and validation reports
- SEO and analytics audits
- Translation audits and repair reports

**These documents are preserved for historical reference and do not represent current project state.**

---

## Guidelines for Contributors

### Understanding Our Documentation System

**Permanent docs (Living Documents):**
- Reflect the *current* state and truth
- Are updated and evolved over time
- Are the source of truth for design decisions and rules
- When permanent docs and reports disagree, **permanent docs are current**

**Historical docs (Snapshots):**
- Capture what was true at a specific point in time
- Are never rewritten or updated
- Explain the context and rationale for past decisions
- Help future developers understand the evolution of the project

### When to Update Permanent Documentation

Update **living documents** immediately when:

| Change | Update Document |
|--------|-----------------|
| New entity or data model | DATA_GOVERNANCE.md |
| New role names or relationships | ROLE_DICTIONARY.md |
| New architectural decision | ARCHITECTURAL_DECISIONS.md (create new ADR) |
| New rules for developers | AI_INSTRUCTIONS.md |
| New build/deployment process | BUILD_NOTES.md |
| Fixing an error in existing docs | Update the document; explain in commit message |

### When to Create a Historical Report

Create a new report in **docs/reports/** when:

- [ ] Completing a major implementation phase
- [ ] Documenting a significant audit or review
- [ ] Recording significant architectural decision context (before creating the ADR)
- [ ] Archiving old work that shouldn't be deleted

**Important:** Once a report is in docs/reports/, it should NEVER be modified. Historical accuracy requires that it stay frozen.

### Best Practices

1. **Read CLAUDE.md first** — Entry point for all contributions
2. **Read DATA_GOVERNANCE.md** — Understand the data model constitution
3. **Review ARCHITECTURAL_DECISIONS.md** — Before proposing new architecture (required by AI_INSTRUCTIONS.md)
4. **Check ROLE_DICTIONARY.md** — Before inventing new role names
5. **Update docs with code changes** — Schema changes require documentation updates
6. **Never modify reports** — Only permanent docs are updated; historical reports stay frozen
7. **Link between docs** — Reference ADRs by number (e.g., "Per ADR-004") and cross-reference related docs
8. **Trust permanent docs over reports** — If they contradict, permanent docs are current; update the permanent doc and explain why in the commit

---

## File Organization

```
docs/
├── README.md (you are here)
├── CLAUDE.md (entry point)
├── AI_INSTRUCTIONS.md (rules for AI)
├── DATA_GOVERNANCE.md (data model authority)
├── BUILD_NOTES.md (build conventions)
├── I18N_ARCHITECTURE_DIAGRAMS.md (i18n design)
├── I18N_QUICK_FIX_CHECKLIST.md (i18n reference)
└── reports/ (historical documentation)
    ├── PHASE-1.5-REPORT.md
    ├── PHASE-2-FINAL-REPORT.md
    ├── ARCHITECTURE_AUDIT_INDEX.md
    ├── DATABASE_AUDIT.md
    ├── PHASE_2_ARCHITECTURE_REVIEW.md
    ├── PHASE_2_SUMMARY.md
    ├── VERIFICATION_REPORT.md
    ├── I18N_FORENSIC_AUDIT.md
    ├── I18N_PERMANENT_REPAIR_REPORT.md
    └── ... (other audits and reports)
```

---

## Quick Reference

| Task | Document | Purpose |
|------|----------|---------|
| **Starting any task** | [CLAUDE.md](../CLAUDE.md) | Entry point with links to all core docs and checklists |
| **Understanding the data model** | [DATA_GOVERNANCE.md](DATA_GOVERNANCE.md) | The "constitution" — entity definitions, relationships, editorial rules |
| **Editorial decisions and curation** | [EDITORIAL_GUIDELINES.md](EDITORIAL_GUIDELINES.md) | How to handle artists, works, recordings, duplicates, disputed info |
| **Technical database reference** | [DATABASE_SCHEMA.md](DATABASE_SCHEMA.md) | Complete schema: tables, columns, relationships, indexes, constraints |
| **Reviewing before proposing architecture** | [ARCHITECTURAL_DECISIONS.md](ARCHITECTURAL_DECISIONS.md) | Why past decisions were made; required before proposing new architecture |
| **Finding valid role names** | [ROLE_DICTIONARY.md](ROLE_DICTIONARY.md) | Canonical list of roles at each credit level |
| **AI assistant rules** | [AI_INSTRUCTIONS.md](AI_INSTRUCTIONS.md) | Non-negotiable database rules, development guidelines, decision-review checklist |
| **Build and deployment** | [BUILD_NOTES.md](BUILD_NOTES.md) | Migration patterns, testing, CI/CD conventions |
| **Project roadmap** | [../ROADMAP.md](../ROADMAP.md) | Planned features and initiatives |
| **Project version and status** | [../VERSION.md](../VERSION.md) | Version numbers, schema status, maturity indicators |
| **i18n architecture** | [I18N_ARCHITECTURE_DIAGRAMS.md](I18N_ARCHITECTURE_DIAGRAMS.md) | Internationalization system design and data flow |
| **i18n quick fixes** | [I18N_QUICK_FIX_CHECKLIST.md](I18N_QUICK_FIX_CHECKLIST.md) | Common i18n patterns and solutions |
| **Why were past decisions made?** | [reports/](reports/) | Historical phase reports, audits, and implementation documentation |

---

## Documentation Authority

### Permanent Living Documents

These documents define the project's rules, data model, and architecture. Updating them requires review and consensus.

| Document | Authority | Update Process |
|----------|-----------|-----------------|
| **DATA_GOVERNANCE.md** | Project architect (Constitutional authority) | New versions require consensus; critical for data model changes |
| **ARCHITECTURAL_DECISIONS.md** | Architecture team | New ADRs require approval; old ADRs become historical records |
| **AI_INSTRUCTIONS.md** | Project lead + team | Updates for new rules or clarifications |
| **CLAUDE.md** | Project lead | Updates for entry-point changes |
| **BUILD_NOTES.md** | DevOps + team | Updates for build/deployment process changes |
| **ROLE_DICTIONARY.md** | Project architect | New roles require approval |

### Historical Reports (Frozen)

Documents in `docs/reports/` are **never updated**. They represent the project state at a specific moment in time.

### Proposing a Documentation Change

To update a permanent living document:

1. **Check the contradiction** — Read the document and understand what needs to change
2. **Review ARCHITECTURAL_DECISIONS.md** — Does your change conflict with an existing decision?
3. **Propose the change** — Create an issue explaining why the doc is outdated
4. **Get consensus** — Discuss with the appropriate authority (architect for data model, team lead for rules)
5. **Update the document** — Make the change with a clear commit message explaining why
6. **Update related docs** — If DATA_GOVERNANCE.md changes, may need AI_INSTRUCTIONS.md or BUILD_NOTES.md updates

### Documenting Major Work

When completing a significant implementation, audit, or architectural review:

1. **Create a report** — Write it in `docs/reports/` with today's date
2. **Make it comprehensive** — Include context, methodology, findings, recommendations
3. **Mark it as a snapshot** — Explain that this represents project state on a specific date
4. **Never modify it** — Once committed, it becomes historical record
5. **Update permanent docs** — If the work changes the data model or rules, update the relevant living documents and explain in the commit

---

## Questions or Issues?

**Contradiction between permanent doc and code?**
1. Assume the permanent doc is the source of truth
2. Check if a report in `reports/` explains historical context
3. File an issue — the permanent doc may need updating or the code may be wrong

**Unclear guidance in documentation?**
1. Read CLAUDE.md for context links
2. Check ARCHITECTURAL_DECISIONS.md for the reasoning
3. File an issue with the specific question

---

**Last Updated:** 2026-07-03  
**Status:** Active  
**Authority:** Project governance
