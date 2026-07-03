# Editorial Guidelines

**Mangulina Dominican Music Database — Editorial Standards and Decision-Making**

This document explains the editorial philosophy and decision-making framework for Mangulina. It guides how we curate music, artists, and relationships in the database.

**Related Documents:**
- [DATA_GOVERNANCE.md](DATA_GOVERNANCE.md) — Technical data model (entity definitions, relationships)
- [ROLE_DICTIONARY.md](ROLE_DICTIONARY.md) — Valid role names at each level

---

## Mission

Mangulina preserves the heritage of Dominican music and documents Dominican creators' contributions worldwide. Editorial decisions serve this mission by prioritizing **accuracy and historical preservation** over completeness.

### Core Principle: Accuracy Over Completeness

An **incomplete but correct** entry is more valuable than a complete but inaccurate one. When uncertain, we document the uncertainty rather than guessing.

---

## What Qualifies as Dominican Music

Mangulina catalogs **Dominican music and Dominican creators**.

### In Scope ✅

- **Dominican-composed works** — Compositions created by Dominican citizens or residents
- **Dominican-performed recordings** — Music where Dominican artists performed
- **Dominican-released works** — Albums/singles released by Dominican labels or artists
- **International works by Dominican creators** — When a Dominican composer, producer, or artist created or performed on music for international artists

### Out of Scope ❌

- **International music with no Dominican connection** — Music where neither creator nor performer is Dominican
- **Tourist performances** — International artists performing in Dominican Republic with no lasting connection to the catalog
- **Language-based inclusion** — Spanish-language music by non-Dominican artists
- **Tourist music about Dominican Republic** — Songs about the country by non-Dominican artists

### Borderline Cases (Require Editorial Judgment)

- **Diaspora artists** — Dominican heritage but grew up/created elsewhere (case-by-case)
- **Multi-national groups with one Dominican member** — Include if the Dominican member is a principal creator or performer
- **Historical recordings** — Music created by Dominicans working abroad (include)

---

## Who Qualifies as a Dominican Artist

An artist is Dominican if they meet **at least one** of these criteria:

1. **Dominican citizenship or residence** at the time of creation
2. **Dominican descent** (parents or ancestors born in Dominican Republic)
3. **Established career within Dominican music industry** (even if born elsewhere)
4. **Significant contributions to Dominican music heritage** (historical importance)

### Examples

✅ **Juan Luis Guerra** — Dominican citizen, major international career
✅ **Luny Tunes** — Dominican production duo (Don Omar collaborators)
✅ **Romeo Santos** — Dominican-American but central to modern bachata evolution
✅ **Oscar de la Renta** — Fashion, but if we expanded to fashion: Dominican-born designer
❌ **Bad Bunny** — Puerto Rican artist (different national tradition)
❌ **Daddy Yankee** — Puerto Rican reggaeton artist
✅ **Daddy Yankee + Dominican producer** — Include the Dominican producer's contribution

---

## Handling Common Editorial Decisions

### Stage Names, Aliases, and Artist Identity

**Principle:** Preserve how artists are credited while maintaining editorial clarity.

**Decision Matrix:**

| Situation | Action | Example |
|-----------|--------|---------|
| **Single artist with multiple stage names** | Create one primary artist; list aliases in biography | "Juan Luis Guerra" with alias "Grupo Manengue" |
| **Name variations by era** | Use primary name; document variations | "Los Ilegales" vs. "Los Ilegales de Oro" |
| **Collective vs. individual** | Create separate entries if they release separately | Los Hermanos Rosario (group) vs. individual members |
| **Featuring artists** | Create relationships; use `featured` role | Song by Artist A featuring Artist B |

### Duplicate Artists

**When to merge:**
- Same person using different names (confirmed by reliable source)
- Band name changes with same core members
- Clear spelling variations (typos in historical credits)

**When NOT to merge:**
- Same name but different people (verify with release dates, other context)
- Name confusion in sources (document both; mark one as "variant of")
- Possible but unconfirmed identity

**Process:**
1. Document evidence for the merge
2. Preserve the merged artist's credits in notes
3. Create redirects from merged names
4. Update dependent records

### Duplicate Recordings

**When to merge:**
- Identical performance remastered or re-released
- Same recording, different catalog IDs
- Confirmed duplicate from same master tape

**When NOT to merge:**
- Different performances (even of same song)
- Live vs. studio recordings
- Different arrangements or mixes
- Remasters with significant editorial changes

**Process:**
1. Keep the earliest/original release as primary
2. Link alternate versions with metadata
3. Document the relationship (remaster, re-release, etc.)
4. Preserve any unique metadata from merged recordings

### Collaborations and Featured Artists

**Principle:** Document exactly how the music credits the artist.

**Examples:**

| Situation | How to Model |
|-----------|--------------|
| "Song by Artist A featuring Artist B" | Work: Artist A (composer); Release: Artist A primary, Artist B featured |
| "Duet by A & B" | Work: Both A and B as creative contributors; Release: Both primary (or one primary + one featured) |
| "Album by Various Artists (compilation)" | Release: Various Artists; Each track has its own primary artist |
| "Remix by Producer X" | Create new recording; Producer X as remixer; Link to original work |
| "Medley of songs" | Original works linked; New recording documents the medley performance |

### Medleys, Mashups, and Arrangements

**When to create new recording:**
- Significant creative arrangement (more than mixing)
- New performance context (live medley, remix)
- Different personnel or instrumentation

**When to link to existing:**
- Cover of existing song (create recording; link to work)
- Remaster of same performance (don't duplicate recording)
- Studio version of previously-live track (document context in notes)

**Credits:**
- Original composer/lyricist always credited
- Arranger credited if substantial contribution
- All performers credited at recording level

---

## Release Date Handling

### When dates conflict

**Priority order:**
1. **Original release date** (most authoritative)
2. **Copyright date** (if no release documented)
3. **Recording date** (if release unknown)
4. **Best estimate** (documented in notes as uncertain)

**Process:**
- Document the source for the date chosen
- Note conflicting dates in the record
- Mark as uncertain if multiple contradictory sources
- Research original liner notes if available

### Special cases

| Case | Decision |
|------|----------|
| **Multiple country releases** | Use earliest release date globally; note country variations |
| **Pre-release distribution** | Use official release date, not pre-release |
| **Streaming release dates** | Use the album/single official release, not platform debut |
| **Unreleased recorded works** | Document recording date; mark as unreleased |
| **Posthumous releases** | Use posthumous release date; note original recording date |

---

## Genre and Category Assignment

**Principle:** Use the frozen genre taxonomy. Do not invent new genres.

**Current taxonomy:** See [ROLE_DICTIONARY.md](ROLE_DICTIONARY.md) (genre section)

**When a song doesn't fit existing genres:**
1. Choose the closest existing genre
2. Document the reasoning in notes
3. If truly novel, propose new genre with evidence to editorial team
4. Do not create new genres unilaterally (see ADR-003)

**Primary vs. secondary genres:**
- **Primary:** Most dominant characteristic
- **Secondary:** Supporting influences (optional; only if significant)

**Examples:**
- Bachata with merengue elements = Primary: Bachata, Secondary: Merengue
- Reggaeton with Afrobeat production = Primary: Reggaeton, Secondary: Afrobeat

---

## Handling Unknown or Uncertain Information

**Principle:** Document uncertainty rather than guessing.

**Guidelines:**

| Information | Approach |
|-------------|----------|
| **Artist unknown** | Leave artist_id empty; document "Artist unknown" in notes |
| **Date uncertain** | Use best estimate; mark in notes as "circa [year]" |
| **Role unclear** | Use most likely role; add note explaining uncertainty |
| **Composer unknown** | Leave field empty; note "Composer unknown" |
| **Release vs. recording date uncertain** | Document both possibilities in notes |

**Never:**
- Guess artist names
- Invent dates (use "circa" or leave empty)
- Assume roles without evidence
- Create relationships without verification

---

## Disputed Information

**When sources contradict:**

1. **Document all versions** — Note the contradictory information
2. **Identify sources** — Which sources claim what?
3. **Mark as disputed** — Use metadata flag if available
4. **Research further** — Try to find authoritative source
5. **Preserve for transparency** — Keep disputed note even if primary data chosen

**Example:**
> "Release date disputed: Some sources list June 1985, others July 1985. Original liner notes show July 1, 1985 as official release."

---

## International Works by Dominican Creators

**When to include:**

✅ Dominican composer/lyricist wrote the song
✅ Dominican producer produced the album
✅ Dominican musician performed on international artist's recording
✅ Dominican label released it (internationally)

**When NOT to include:**

❌ International artist recorded Dominican music (without Dominican creator involvement)
❌ Performance at Dominican venue (without lasting contribution)
❌ Sample of Dominican music (without significant reuse)

**Credits:**
- Link to the international work
- Document Dominican creator's specific role
- Preserve original credit text
- Note in artist's profile: "Worked on [international artist]'s [album]"

---

## Christian vs. Secular Classification

**Classification rule:**
- **Christian** — Explicitly religious content, worship purpose, or gospel tradition
- **Secular** — All other music (even if performed by religious artists)

**Examples:**
- ✅ **Christian:** Worship songs, hymns, gospel music about faith
- ✅ **Secular:** Pop song by artist who is Christian
- ✅ **Secular:** Love ballad with spiritual metaphors (unless explicitly religious)

**Edge cases:**
- **Merengue cristiano** — Merengue with Christian lyrics = Christian
- **Religious references in secular song** — Document in notes; classify as secular

---

## Remasters, Re-releases, and Versions

### Remaster
- Same recording, improved audio quality
- **Decision:** Link as variant of original; don't duplicate
- **Documentation:** Note remaster date and mastering engineer

### Re-release
- Same recording, new packaging or format
- **Decision:** Link as variant; don't duplicate recording
- **Documentation:** Note original and re-release dates

### Live Recording
- Performance of a studio-recorded work
- **Decision:** Create new recording; link to original work
- **Documentation:** Document venue, date, context

### Karaoke Version
- Instrumental version for singing along
- **Decision:** Create if significant; otherwise link in notes
- **Documentation:** Note as "karaoke version" or "backing track"

### Instrumental Version
- Music without vocals
- **Decision:** Create new recording; note as instrumental
- **Documentation:** Note relationship to original

### Cover Version
- Different artist's interpretation of existing work
- **Decision:** Create new recording; link to original work
- **Documentation:** Document cover artist and context

---

## Compilations and Various Artists

**For Various Artists albums:**
1. Create release with "Various Artists" as primary artist
2. Each track links to its own primary artist
3. Use `compilation` role for featured/compilation tracks
4. Document each artist's participation clearly

**Example structure:**
```
Release: "Dominican Summer Hits Vol. 1"
Primary Artist: Various Artists
Track 1: Juan Luis Guerra - "Mi Primer Amor"
  → Work Level: Juan Luis Guerra (composer)
  → Recording Level: Juan Luis Guerra (vocal)
  → Release Level: Juan Luis Guerra (primary artist on compilation)
```

---

## Unofficial Releases and Fan-Created Content

**Include only if:**
- Authorized by the artist
- Historically significant (bootleg with documented impact)
- Artist approved (remixes, bootlegs released by artist)

**Document:**
- Status as unofficial/unofficial release
- Context and authorization
- Artist intention regarding distribution

**Exclude:**
- Fan recordings without artist approval
- Unauthorized bootlegs
- Leaked/unreleased material without artist release

---

## Version Control and Historical Accuracy

**Every edit should:**
1. Preserve original information (don't delete; mark as superseded)
2. Document the change reason
3. Maintain audit trail
4. Reference the source for updates

**Corrections:**
- If original data was wrong, correct it
- Document what was wrong and why
- Note the source for correction

**Additions:**
- If original was incomplete, add details
- Document source for new information
- Note when information was added

---

## Editorial Review Process

**Before finalizing significant entries:**

1. **Verify primary information** (artist, work, composer, dates)
2. **Cross-reference sources** (at least 2 independent sources)
3. **Document sources** in notes or audit trail
4. **Check for duplicates** in existing database
5. **Verify relationships** (credits, collaborations)
6. **Mark disputes** if conflicting sources exist
7. **Add context notes** for non-obvious decisions

**For major artists or works:**
- Obtain at least 3 sources
- Document each source used
- Note any conflicts between sources
- Get editorial team approval before publishing

---

## Contact and Questions

If you have questions about editorial decisions:
1. Check this document first
2. Review specific examples in [DATA_GOVERNANCE.md](DATA_GOVERNANCE.md)
3. Consult existing similar entries in the database
4. Ask the editorial team

---

**Status:** Active and Living  
**Last Updated:** 2026-07-03  
**Authority:** Editorial Team
