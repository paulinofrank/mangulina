# Project Version & Status

**Mangulina — Quick Reference on Project Maturity and State**

---

## Project Information

| Aspect | Value |
|--------|-------|
| **Project Name** | Mangulina |
| **Subtitle** | Dominican Music Database |
| **Founded** | April 2026 |
| **Mission** | Preserve Dominican music heritage and document Dominican creators worldwide |

---

## Current Version

| Component | Version | Status |
|-----------|---------|--------|
| **Application** | 1.1.0 | Active |
| **Schema** | 1.1.0 | Current (with 2 deprecated fields) |
| **Documentation** | 1.1.0 | Current |
| **API** | v1 | Stable |

---

## Project Stage

| Category | Status |
|----------|--------|
| **Development** | Mature (post-launch) |
| **Release** | Public (production ready) |
| **Data Completeness** | Growing (incomplete but accurate) |
| **Documentation** | Complete (governance documented) |
| **Community** | Early stage (open to contributions) |

---

## Technical Status

| Component | Status | Notes |
|-----------|--------|-------|
| **Frontend** | ✅ Production | Next.js 16.2.6 with App Router |
| **Backend** | ✅ Production | Supabase PostgreSQL |
| **Database** | ✅ Current | 47 tables; 3 levels of credits |
| **Auth** | ✅ Production | Admin authentication |
| **i18n** | ✅ Complete | English + Spanish (/es) |
| **Analytics** | ✅ Complete | Event tracking and rollups |
| **SEO** | ✅ Complete | Canonical URLs, hreflang, metadata |
| **RLS** | ✅ Active | Row-level security on sensitive tables |

---

## Schema Version

| Aspect | Details |
|--------|---------|
| **Current Version** | 1.1.0 |
| **Base Tables** | 47 (KEEP: 35, REVIEW: 7, DROP: 0) |
| **Credit Levels** | 3 (recording, work, release) |
| **Deprecated Fields** | 2 (recordings.artist_id, releases.release_artist_id) |
| **Active Migrations** | 70+ completed |
| **Deprecation Timeline** | 6-12 months from 2026-07-03 |

---

## Documentation Version

| Document | Status | Last Updated |
|----------|--------|---------------|
| CLAUDE.md | Active | 2026-07-03 |
| DATA_GOVERNANCE.md | Active | 2026-07-03 |
| AI_INSTRUCTIONS.md | Active | 2026-07-03 |
| EDITORIAL_GUIDELINES.md | Active | 2026-07-03 |
| DATABASE_SCHEMA.md | Active | 2026-07-03 |
| ARCHITECTURAL_DECISIONS.md | Active | 2026-07-03 |
| BUILD_NOTES.md | Active | 2026-06-20 |
| ROADMAP.md | Active | 2026-07-03 |
| CHANGELOG.md | Active | 2026-07-03 |

---

## Last Major Architecture Update

| Initiative | Completed | Impact |
|-----------|-----------|--------|
| **Multilingual Infrastructure** | June 20, 2026 | 750+ translation keys, /es support |
| **Analytics System** | June 20, 2026 | Event tracking, insights dashboard |
| **SEO Optimization** | June 14, 2026 | Canonical URLs, hreflang, metadata |
| **Credits Architecture Review** | July 3, 2026 | Phase 2 design, implementation roadmap |
| **Documentation Governance** | July 3, 2026 | Official rules, guidelines, ADRs |

---

## Next Planned Version

| Target | Features | Timeline |
|--------|----------|----------|
| **1.2.0** | Release Artists implementation, query optimizations | Q3-Q4 2026 |
| **1.3.0** | Publishing rights, copyright tracking | Q1 2027 |
| **2.0.0** | Major feature expansions (tentative) | 2027+ |

---

## Data Status

| Metric | Value | Notes |
|--------|-------|-------|
| **Artists** | 1,000+ | Dominican and international collaborators |
| **Works** | 500+ | Unique compositions |
| **Recordings** | 2,000+ | Individual performances |
| **Releases** | 800+ | Albums, singles, EPs |
| **Data Quality** | Accurate but incomplete | By design (ADR-005) |
| **Languages** | 2 | English (primary), Spanish |

---

## Known Issues

### Deprecated Fields (Transitioning)

- **`recordings.artist_id`** — Legacy field; use `recording_credits` instead
  - **Deprecation Period:** 6+ months from 2026-07-03
  - **Status:** Still active for backward compatibility
  - **Migration Path:** [ADR-006](docs/ARCHITECTURAL_DECISIONS.md#adr-006-preserve-backward-compatibility-during-schema-evolution)

- **`releases.release_artist_id`** — Legacy field; use `release_artists` instead
  - **Deprecation Period:** 6+ months from 2026-07-03
  - **Status:** Still active for backward compatibility
  - **Migration Path:** [ADR-007](docs/ARCHITECTURAL_DECISIONS.md#adr-007-additive-migrations-first-deprecate-before-removal)

### Open Items

See [ROADMAP.md](ROADMAP.md) for planned improvements.

---

## Support & Contact

- **Questions?** See [CLAUDE.md](CLAUDE.md) for documentation entry points
- **Found a bug?** Create an issue in the project repository
- **Contributing?** Read [EDITORIAL_GUIDELINES.md](docs/EDITORIAL_GUIDELINES.md)

---

**Last Updated:** 2026-07-03  
**Status:** Current  
**Maturity:** Stable (post-launch, production-ready)
