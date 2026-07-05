# Roadmap

**Mangulina Project — Planned Features and Initiatives**

This roadmap outlines the direction for Mangulina's development. Items are organized by phase, with focus on strategic improvements to the Dominican music database.

---

## Current (In Progress)

These initiatives are actively being worked on or ready to start:

### Release Artists Implementation
- **Status:** Architecture designed (Phase 2 review complete)
- **Goal:** Implement release_artists table for cleaner release credit tracking
- **Work:** Phase A/B migration, application updates
- **Impact:** Resolves data duplication between recordings.artist_id and releases.release_artist_id
- **Timeline:** Q3 2026

### Recording Performers Query Optimization
- **Status:** Analysis phase
- **Goal:** Improve query performance for recording credits
- **Work:** Potential materialized views, caching strategy
- **Impact:** Faster artist discography pages, better search performance
- **Timeline:** Q3 2026

### Credits UI Redesign
- **Status:** Scoping
- **Goal:** Clearer presentation of recording credits, work credits, and release credits
- **Work:** Component redesign, improved visual hierarchy
- **Impact:** Better user understanding of credit structure
- **Timeline:** Q4 2026

### Luny Tunes Catalog Migration
- **Status:** Planning
- **Goal:** Import and integrate Luny Tunes' comprehensive discography
- **Work:** Data acquisition, validation, integration
- **Impact:** Major catalog expansion (Dominican producers with international reach)
- **Timeline:** Q3-Q4 2026

---

## Next (Planned)

These initiatives are planned for the near future:

### Publishing Rights Documentation
- **Goal:** Track publishing companies and rights holders
- **Scope:** Add tables for publishing entities, rights ownership percentages
- **Impact:** Support for licensing and rights management
- **Timeline:** Q1 2027

### Copyright Owner Tracking
- **Goal:** Document copyright ownership for compositions and recordings
- **Scope:** Add copyright ownership records, expiration dates, territories
- **Impact:** Legal compliance, licensing enablement
- **Timeline:** Q1 2027

### Label Information and Relationships
- **Goal:** Document record labels and release relationships
- **Scope:** Add label entity, label-release relationships
- **Impact:** Better historical context, label discovery
- **Timeline:** Q2 2027

### Session Musicians Database
- **Goal:** Track session musicians and studio session details
- **Scope:** Expand recording_credits with session context
- **Impact:** Support for complex studio arrangements, musician history
- **Timeline:** Q2 2027

### Advanced Search Filters
- **Goal:** Sophisticated search and filtering capabilities
- **Scope:** Multi-field search, faceted filtering, saved searches
- **Impact:** Improved discovery, better research capabilities
- **Timeline:** Q2 2027

### Contributor Workflow Improvements
- **Goal:** Better tools for community contributions
- **Scope:** Improved edit workflows, contribution guidelines, review process
- **Impact:** Easier for community to contribute data
- **Timeline:** Q3 2027

---

## Future (Vision)

Long-term strategic initiatives (timeline uncertain):

### Audio Preview Integration
- **Goal:** Embedded audio playback for recordings
- **Scope:** API integration with streaming services or audio storage
- **Impact:** Enhanced discovery, listening experience

### Relationship Timeline
- **Goal:** Track artist collaborations and relationships over time
- **Scope:** Timeline of collaborations, featured appearances, production work
- **Impact:** Better understanding of career arcs and influence

### Interactive Collaboration Network
- **Goal:** Visualize relationships between artists, producers, composers
- **Scope:** Network graphs, collaboration maps
- **Impact:** Discover connections, understand influence networks

### Community Reviews and Ratings
- **Goal:** User-generated content and feedback
- **Scope:** Reviews, ratings, user contributions
- **Impact:** Community engagement, crowdsourced validation

### Export and API
- **Goal:** Make data accessible to researchers and applications
- **Scope:** Public API, data exports, research datasets
- **Impact:** Enable third-party research, external tools

### Educational Content
- **Goal:** Learning materials about Dominican music
- **Scope:** Artist biographies, genre guides, historical context
- **Impact:** Cultural education and preservation

---

## Completed Initiatives ✅

These have been completed and are now part of the live system:

### Multilingual Infrastructure
- **Completed:** June 20, 2026
- **Result:** Full English/Spanish support with 750+ translation keys
- **Impact:** Accessible to Spanish-speaking users

### Analytics System
- **Completed:** June 20, 2026
- **Result:** User engagement tracking and insights dashboard
- **Impact:** Data-driven decisions about content and features

### SEO Optimization
- **Completed:** June 14, 2026
- **Result:** Canonical URLs, hreflang tags, metadata optimization
- **Impact:** Better search engine visibility, improved rankings

### Genre Taxonomy Finalization
- **Completed:** June 12, 2026
- **Result:** 50+ approved genres; frozen taxonomy (ADR-003)
- **Impact:** Consistent categorization, prevents genre proliferation

### Credits Architecture Review
- **Completed:** July 3, 2026
- **Result:** Phase 2 design analysis, recommendations, implementation plan
- **Impact:** Clear roadmap for credit system improvements

### Documentation Governance
- **Completed:** July 3, 2026
- **Result:** Official rules, guidelines, and decision records
- **Impact:** Clear direction for AI assistants and contributors

---

## Success Metrics

We measure progress by:

- **Data Quality** — Accuracy and completeness of artist/work/recording information
- **User Growth** — Visitors, researchers, developers using Mangulina
- **Community Contribution** — Quality and volume of community-submitted data
- **Search Performance** — Query response times, index health
- **Feature Adoption** — Usage of new features and capabilities
- **Documentation Completeness** — Coverage and clarity of guidance
- **Dominican Music Preservation** — Artists and works documented in database

---

## Guiding Principles

All roadmap items follow these principles:

1. **Accuracy over Completeness** — Better to document less correctly than more incorrectly
2. **Dominican Music Focus** — Prioritize Dominican creators and heritage
3. **Backward Compatibility** — Don't break existing pages, APIs, or workflows
4. **Community-Driven** — Incorporate feedback from researchers and users
5. **Sustainable** — Features must be maintainable long-term
6. **Documented** — Every initiative includes documentation updates

---

## How to Propose Features

If you have feature suggestions:

1. **Check existing items** — Your idea may be in a future phase
2. **Verify strategic fit** — Does it align with Mangulina's mission?
3. **Document the case** — Explain benefits and implementation approach
4. **Propose in issues** — Create GitHub issue with details
5. **Get team feedback** — Discuss with the architecture team
6. **Iterate** — Refine based on feedback

---

## Contact

Questions about the roadmap? See:
- **Project governance:** [CLAUDE.md](CLAUDE.md)
- **Architecture decisions:** [docs/ARCHITECTURAL_DECISIONS.md](docs/ARCHITECTURAL_DECISIONS.md)
- **Editorial mission:** [docs/EDITORIAL_GUIDELINES.md](docs/EDITORIAL_GUIDELINES.md)

---

**Last Updated:** 2026-07-03  
**Status:** Active  
**Next Review:** Q4 2026
