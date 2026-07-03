# Changelog

All notable changes to Mangulina are documented here.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### In Progress

- Release Artists table implementation (Phase A/B)
- Recording Performers query optimization
- Credits UI redesign
- Luny Tunes catalog migration

### Planned

- Publishing rights documentation
- Copyright owner tracking
- Label information and relationships
- Session musician database
- Advanced search filters
- Contributor workflow improvements

---

## [1.1.0] — 2026-07-03

### Added

- **Official Documentation Governance** — CLAUDE.md, AI_INSTRUCTIONS.md, EDITORIAL_GUIDELINES.md
- **Architectural Decision Records (ADRs)** — 8 foundational decisions documented
- **Database Schema Reference** — DATABASE_SCHEMA.md technical documentation
- **Editorial Guidelines** — EDITORIAL_GUIDELINES.md for curators
- **Documentation Organization** — Historical reports in docs/reports/ with category folders

### Changed

- **Documentation Restructure** — Permanent docs in docs/, historical reports in docs/reports/
- **Database Schema** — Organized 47 tables; classified as KEEP/REVIEW

### Deprecated

- Legacy field: `recordings.artist_id` — Use `recording_credits` instead (deprecation period: 6+ months from 2026-07-03)
- Legacy field: `releases.release_artist_id` — Use `release_artists` instead (deprecation period: 6+ months from 2026-07-03)

---

## [1.0.2] — 2026-06-20

### Added

- **Multilingual Infrastructure** — Phase 2 complete, 750+ translation keys
- **Spanish Support** — Full `/es` locale implementation with next-intl
- **Analytics System** — User engagement tracking and insights
- **SEO Optimization** — Canonical URLs, hreflang tags, metadata

### Fixed

- i18n configuration issues (Phase 1 forensic audit findings)
- Translation key extraction and organization
- Multilingual routing and locale detection

### Changed

- Homepage and artist profiles now fully bilingual
- Analytics dashboard operational
- SEO audit complete and recommendations implemented

---

## [1.0.1] — 2026-06-12

### Added

- **Genre Taxonomy Finalized** — 50+ approved genres frozen (see ADR-003)
- **Credits Architecture Review** — Phase 2 design analysis complete
- **Database Audit** — All 47 tables classified and documented

### Changed

- Genre system finalized; no new genres without editorial consensus

### Documented

- Phase 2 architecture analysis (credit model)
- Database table classifications (KEEP/REVIEW/DROP)

---

## [1.0.0] — 2026-06-01

### Added

- **Initial Public Release** — Mangulina Dominican Music Database
- **Core Entities** — Artists, Works, Recordings, Releases, Tracks
- **Credit System** — Three-level credit architecture (recording, work, release)
- **Multilingual Foundation** — English-primary with internationalization structure
- **Basic Search** — Artist and release search
- **Artist Profiles** — Browse and discover Dominican creators
- **Release Pages** — Album details and tracklisting

### Notes

- Foundation laid for multilingual expansion
- Analytics framework prepared
- SEO structure implemented

---

## [0.9.0] — 2026-05-15

### Added

- **Supabase Database** — PostgreSQL backend with RLS
- **Next.js App** — Modern React frontend with App Router
- **Authentication** — Admin authentication framework
- **Basic CRUD** — Content management for artists and releases
- **Deploy Pipeline** — Vercel integration

---

## [0.1.0] — 2026-04-01

### Added

- **Project Initiation** — Mangulina project created
- **Initial Planning** — Scope, mission, and goals defined
- **Database Design** — Conceptual model and entity relationships
- **Team Setup** — Development environment and collaboration tools

---

## Legend

- **Added** — New features or functionality
- **Changed** — Changes to existing functionality
- **Deprecated** — Features planned for removal (with timeline)
- **Removed** — Deleted features
- **Fixed** — Bug fixes and corrections
- **Security** — Security improvements or vulnerability fixes
- **Documented** — Major documentation updates (for development purposes)

---

## Notes on Versioning

- **1.x.x** — Post-launch releases (feature additions, refinements)
- **0.9.x** — Pre-release (alpha/beta features, infrastructure)
- **0.1.x** — Initialization (planning and setup)

---

## Future Roadmap

See [ROADMAP.md](ROADMAP.md) for planned features and initiatives.

---

**Last Updated:** 2026-07-03  
**Current Version:** 1.1.0  
**Status:** Active
