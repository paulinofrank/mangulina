# Mangulina Data Governance & Modeling Guide

**Version:** 1.0  
**Status:** Official Reference  
**Last Updated:** 2026-07-03  
**Scope:** Data model, editorial rules, relationship definitions  

---

## 1. Mission

**Mangulina is the Dominican Music Database.**

Our objective is to preserve, document, and organize Dominican music with historical accuracy and editorial integrity.

Mangulina exists to serve as the authoritative record of Dominican musical creation—documenting artists, compositions, performances, and releases with meticulous care.

### Core Objective
- **Preserve** Dominican music history
- **Document** creators and their work with accuracy
- **Organize** relationships between artists, works, and recordings
- **Enable** discovery and understanding of Dominican music heritage

### Editorial Curation
Mangulina is an **editorially curated database**, not an automated aggregate.

Every entity, relationship, and credit is subject to human review and validation. We prioritize accuracy over completeness: an incomplete but correct entry is always preferable to a complete but inaccurate one.

---

## 2. Core Principles

These principles guide every modeling, data entry, and architectural decision.

### Principle 1: One Source of Truth
Each piece of information has a single authoritative source. We do not duplicate facts across tables or entities.

**Example:** An artist's name is stored once. All references to that artist point to that single entity.

### Principle 2: Avoid Duplication
Information is stored once at its natural level of belonging.

**Non-example:** Do not store "artist name" both on the artist record and in the recording_credits table. Store it once on the artist record; join to retrieve it.

**Exception:** Denormalized fields like `credited_as` (exact credit text as printed) are stored separately because they capture historical display information, not repetition of a canonical fact.

### Principle 3: Preserve Historical Accuracy
The database preserves how Dominican music was credited and released historically.

If a release credits "Juan Luis Guerra y 4.40", that exact text is stored—even if the artist entity is simply "Juan Luis Guerra". Historical accuracy takes priority over normalized naming.

### Principle 4: Never Sacrifice Correctness for Convenience
We reject "quick fixes" that compromise accuracy.

**Example:** Do not mark a recording's artist as "Unknown" because we haven't verified the true artist. Leave it unset and mark it as requiring verification.

### Principle 5: Relationships Are First-Class Citizens
Relationships (who performed with whom, who composed what, who is credited on which release) are as important as the entities themselves.

A recording without performance credits is incomplete, not optional.

### Principle 6: Dominican Music Remains Primary Scope
Mangulina catalogs Dominican music and Dominican creators.

International works appear in Mangulina **only when necessary to document Dominican creators**—e.g., a Dominican producer's work on an international artist's album, or a Dominican composer's international credits.

### Principle 7: Extensibility
The model is intentionally designed to support future features without breaking existing structure.

Publishing credits, licensing, studio information, and other future attributes can be added without restructuring core entities.

---

## 3. Entity Definitions

### 3.1 Artist

**Definition:** A person, duo, group, or collective credited with creating or performing music.

#### Types
- **Solo artist:** A single person (Juan Luis Guerra, Aventura member as solo artist)
- **Duo:** Two principal members (Luny Tunes, Zumaya)
- **Group:** Three or more members (Grupo Manía, Los Ilegales)
- **Collective:** Variable membership (Los Profesionales)

#### Primary Attributes
- **Name:** The canonical artist name (as most commonly credited)
- **Primary Role:** The main occupation (singer, producer, duo, group, etc.)
- **Slug:** URL-safe identifier (juan-luis-guerra, luny-tunes)
- **Status:** Published (visible) or draft (under review)
- **Birth/Formation Date:** When applicable
- **Bio:** Editorial description
- **Province:** Geographic connection (if Dominican)

#### Secondary Occupations
An artist may have multiple occupations:
- Singer, guitarist, producer, composer, arranger, engineer
- These are documented through relationships (see Section 5)

#### Examples
- **Juan Luis Guerra:** Singer, composer, producer (solo artist)
- **Luny Tunes:** Producer, composer (duo; not a performer)
- **Grupo Manía:** Group (collective)
- **Aventura:** Group (now famous individually)

---

### 3.2 Work

**Definition:** An abstract musical creation—independent of any specific recording.

A Work is the composition itself: melody, lyrics, arrangement, harmony. It is NOT the recording.

#### Key Distinction
- **Work:** The creative output ("Obsesión" the composition)
- **Recording:** A specific performance of that Work ("Obsesión" studio recording, "Obsesión" live version)

#### Types of Works
- **Composition:** Musical piece (melody, harmony, arrangement)
- **Lyrics:** Poetic/vocal text
- **Orchestration:** Arrangement or instrumentation

#### Attributes
- **Title:** Work title (composition title)
- **Creator(s):** Composer, lyricist, arranger (creative contributors; see Section 5)
- **Genre:** Musical style
- **Year Created:** When the Work was written (not recorded)
- **Description:** Editorial notes
- **ISWC:** International Standard Musical Work Code (future field)

#### Examples
- **"La Bella y La Bestia"** (composition by Luny Tunes)
  - May have multiple recordings by different artists
  - May have different arrangements
  - All share the same underlying Work

- **"Obsesión"** (composition)
  - Original composition (Work)
  - Aventura recording
  - Usher/Aventura remix
  - Live versions
  - All are the same Work, different Recordings

---

### 3.3 Recording

**Definition:** A specific recorded performance of a Work, captured at a particular time and place.

A Recording is NOT the release. It is the musical content.

#### Key Distinction
- **Recording:** The audio itself (studio recording, live performance, acoustic version)
- **Release:** The commercial or official release format (album, single, compilation)

#### Types
- **Studio recording:** Professional studio performance
- **Live recording:** Captured live performance
- **Acoustic version:** Unplugged or acoustic arrangement
- **Radio edit:** Shortened for radio play
- **Remix:** Modified version by producer
- **Remaster:** Re-engineered for quality
- **Demo:** Early/preliminary version
- **Instrumental:** Music without vocals

#### Attributes
- **Title:** Recording title (may differ slightly from Work title)
- **Work:** Which Work is being performed (nullable; may be unattributed)
- **Primary Artist:** The artist most associated with this recording
- **Duration:** Length in seconds or milliseconds
- **Release Date:** When first released
- **Performers:** All musicians/singers involved (see Section 5)
- **Recording Year:** When recorded
- **Genre:** Musical style
- **ISRC:** International Standard Recording Code (future field)
- **YouTube ID:** Link to official video (if available)

#### Example
**"Obsesión" by Aventura (Studio Recording)**
- Work: "Obsesión" (composition)
- Primary Artist: Aventura
- Performers: Juan Luis Díaz (vocals), Lenny Santos (vocals), etc.
- Duration: 3:29
- Recording Year: 2002
- Genre: Bachata
- Release Year: 2002

---

### 3.4 Release

**Definition:** A curated collection of recordings released together as a single product.

A Release is the commercial or official package. It contains Tracks (placements of Recordings).

#### Types
- **Album/LP:** Full-length release (12+ tracks, 30+ minutes)
- **Single:** One or two tracks
- **EP:** Extended play (6-11 tracks, 15-30 minutes)
- **Compilation:** Curated collection by various artists
- **Soundtrack:** Music from film/media
- **Soundtrack (Live):** Live performance recording
- **Digital Release:** Online-only release
- **Physical Format:** Vinyl, CD, cassette, etc.

#### Attributes
- **Title:** Release title
- **Release Artist:** Artist credited for the release (see Section 6)
- **Release Date:** Official release date
- **Release Year:** Year of release
- **Type:** Album, single, EP, compilation, etc.
- **Country:** Country of release
- **Label:** Record label (future field)
- **Tracks:** List of tracks on release (see Track section)
- **Cover Art:** Album artwork (image URL)
- **Barcode:** UPC/EAN code
- **Catalog Number:** Label catalog identifier

#### Example
**"Obsérvame" by Juan Luis Guerra (Album)**
- Title: Obsérvame
- Release Artist: Juan Luis Guerra
- Release Date: 1986-06-15
- Type: Album
- Country: Dominican Republic
- Tracks: 10 songs
- Contains "Obsesión", "Bachata Rosa", and others

---

### 3.5 Track

**Definition:** The placement of a Recording within a Release at a specific position.

A Track is the relationship between a Recording and a Release. The same Recording may appear in multiple Releases, each as a separate Track.

#### Attributes
- **Recording:** Which recording is in this track
- **Release:** Which release contains this track
- **Track Number:** Position on release (disc 1, track 3)
- **Disc Number:** If multi-disc release
- **Title Override:** If track title differs from recording title (rare)
- **Duration:** Duration on this release (may differ from studio version)
- **Sequence/Order:** Placement in release order

#### Example
**"Obsesión" appears in multiple releases:**

1. **Aventura's "K.O.B" (2002)** → Track 1
2. **Aventura's "Last Night (Live)" (2005)** → Track 8
3. **Compilation "Bachata Legends"** → Track 5

All are the same Recording, different Tracks (different Releases).

---

## 4. Relationship Model

The relationships between entities are as important as the entities themselves.

### 4.1 Core Relationships

```
Artist ← performs → Recording
         ↓ (many performers per recording)
         Recording Performer role: singer, guitarist, engineer, etc.

Artist ← creates → Work
         ↓ (many creators per work)
         Creative Contributor role: composer, lyricist, arranger, etc.

Artist ← credited as → Release
         ↓ (many artists per release)
         Release Artist role: primary, featured, compilation, etc.

Work ← has → Recording
       (a recording performs a work)
       (one work may have many recordings)

Recording ← appears in → Release
           ↓ (as a Track)
           (one recording may appear in many releases)

Release ← contains → Track
         ↓ (track is the placement of recording in release)
         Track connects Recording to Release with sequence info
```

### 4.2 Visual Model

```
┌─────────┐
│ Artist  │
└────┬────┘
     │
     ├─ Performs → Recording
     │             │
     │             ├─ Performs → Work (creative content)
     │             │
     │             └─ Appears In → Release (track placement)
     │                            │
     │                            └─ Contains Tracks
     │
     ├─ Creates → Work
     │
     └─ Credited On → Release

Release (Album)
├─ Track 1: Recording A (01:23)
├─ Track 2: Recording B (03:45)
├─ Track 3: Recording A (02:15)  ← same recording, different position
└─ Track 4: Recording C (04:10)
```

### 4.3 Example: "Obsesión"

```
WORK: "Obsesión" (Composition)
├─ Composer: Luny Tunes
├─ Lyricist: Luny Tunes
└─ Arranger: Aventura

RECORDING 1: "Obsesión" by Aventura (Studio, 2002)
├─ Performers:
│  ├─ Juan Luis Díaz (lead vocal)
│  ├─ Lenny Santos (vocal)
│  └─ Romeo Santos (vocal)
├─ Producer: Luny Tunes
└─ Appears In:
   ├─ Release: K.O.B (Track 1)
   ├─ Release: K.O.B Reissue (Track 1)
   └─ Release: Bachata Legends (Track 5)

RECORDING 2: "Obsesión" Remix by Usher & Aventura (2007)
├─ Performers:
│  ├─ Usher (lead vocal)
│  ├─ Juan Luis Díaz (vocal)
│  └─ Lenny Santos (vocal)
├─ Producer: The Neptunes
└─ Appears In:
   └─ Release: K.O.B Remix Edition (Track 8)

RECORDING 3: "Obsesión" Live at Madison Square Garden (2005)
├─ Performers:
│  ├─ Juan Luis Díaz (lead vocal)
│  ├─ Lenny Santos (vocal)
│  └─ Romeo Santos (vocal)
└─ Appears In:
   └─ Release: Last Night Live (Track 8)
```

---

## 5. Performer vs. Creative Contributor

This is a critical distinction in Mangulina.

### 5.1 Performer (Recording Performers)

**Definition:** An artist who performed on a recording.

Performers are credited at the **Recording level**. They answered the question: "Who played/sang on this recording?"

#### Types of Performers
- **Vocalist:** Lead singer, backing vocals, choir
- **Musician:** Guitar, piano, drums, trumpet, etc.
- **Engineer:** Recording engineer, mixing engineer, mastering engineer
- **Producer:** Producer of the recording session
- **Featured Artist:** Guest artist prominently featured on the track

#### Examples
```
Recording: "Obsesión" by Aventura
Performers:
- Juan Luis Díaz (lead vocal)
- Lenny Santos (vocal)
- Romeo Santos (vocal)
- Producers: Luny Tunes
- Engineers: [Recording/mixing engineers]
```

### 5.2 Creative Contributor (Work Credits)

**Definition:** An artist who created or composed the work.

Creative contributors are credited at the **Work level**. They answer the question: "Who created/wrote this composition?"

#### Types of Contributors
- **Composer:** Wrote the melody and harmony
- **Lyricist:** Wrote the lyrics/text
- **Arranger:** Arranged the composition for instruments
- **Orchestrator:** Orchestrated the arrangement
- **Producer:** Overall creative direction (for composition)

#### Examples
```
Work: "Obsesión"
Creative Contributors:
- Composer: Luny Tunes
- Lyricist: Luny Tunes
- Arranger: Aventura

Work: "Bachata Rosa"
Creative Contributors:
- Composer: Juan Luis Guerra
- Lyricist: Juan Luis Guerra
- Arranger: Juan Luis Guerra
```

### 5.3 The Critical Difference

| Aspect | Performer | Creative Contributor |
|--------|-----------|---------------------|
| **Level** | Recording | Work |
| **Question** | Who performed on this recording? | Who created/wrote this work? |
| **Example** | Singer on the track | Composer of the song |
| **Relationship** | Recording → Performer | Work → Creator |
| **Many-to-Many** | Recording has many performers | Work has many creators |
| **Reusable** | Different recordings may have different performers | Same creators across all recordings |

### 5.4 Real-World Example

**Song: "Mi Santa Cecilia" (Work)**
- Composer: Juan Luis Guerra
- Lyricist: Juan Luis Guerra
- Arranger: Juan Luis Guerra

**Original Recording (Studio, 1990)**
- Performers:
  - Vocals: Juan Luis Guerra
  - Guitars: [musicians]
  - Percussion: [musicians]
- Producer: Juan Luis Guerra

**Live Rendition (Madison Square Garden, 2005)**
- Performers:
  - Vocals: Juan Luis Guerra
  - Guest vocalist: [female vocalist]
  - Orchestra: [ensemble]
- Producer: [concert producer]

**Remaster (2020)**
- Performers: (same as original)
- Engineers: [remastering team]

The **Work** (composition) has the same creators across all versions.  
The **Recordings** have different performers.

---

## 6. Release Artist

**Definition:** The artist credited for the album/single itself.

Release Artist is the artist whose name appears on the album cover and marketing material.

### Distinction from Recording Performers

**Release Artist** ≠ **Recording Performers**

- **Release Artist:** "Artist credited with this album/single"
- **Recording Performers:** "Musicians/singers who performed on each track"

An album by "Juan Luis Guerra" may include guest vocalists and musicians. Juan Luis Guerra is the Release Artist; the guests are Recording Performers.

### Types of Release Artists

- **Primary Artist:** Main artist for the release (Juan Luis Guerra, Aventura)
- **Featured Artist:** Artist prominently featured (e.g., on a single)
- **Compilation Artist:** "Various Artists" (compilation albums)
- **Collaborative Release:** "Artist A & Artist B" (duet album)
- **Presenter/Curator:** Editor of a compilation

### The Credited_As Field

Releases store a **`credited_as`** field to preserve exact historical credit text:

```
Release: "4.40"
Release Artist (entity): Juan Luis Guerra
credited_as: "Juan Luis Guerra y 4.40"
```

The `credited_as` field captures how the artist is credited on the release, which may differ from the canonical artist name.

### Examples

```
Album: "Obsérvame" by Juan Luis Guerra
Release Artist: Juan Luis Guerra
credited_as: "Juan Luis Guerra"
Performers on tracks: Juan Luis Guerra + session musicians

Single: "Obsesión" by Aventura featuring Usher
Primary Release Artist: Aventura
Featured: Usher
credited_as: "Aventura featuring Usher"

Compilation: "Bachata Legends"
Release Artist: Various Artists
credited_as: "Various Artists"
Track performers vary
```

---

## 7. National vs. International Scope

Mangulina's scope is **Dominican music and Dominican creators**.

### In Scope: Dominican Creation
- Music created by Dominicans
- Music about Dominican culture
- Music released in Dominican Republic
- Dominican compositions regardless of performer

### In Scope: International Where Necessary
- Work by Dominican producers on international artists
- Compositions by Dominican writers for international performers
- International recordings needed to document Dominican creators' work

**Rule:** International content is included ONLY when it documents Dominican creators' contributions.

### Examples

#### In Scope ✅
- Luny Tunes producing Daddy Yankee (Dominican producer)
- Juan Luis Guerra composing for international artist (Dominican composer)
- Aventura collaboration with international artist (Dominican group)
- Dominican-American artists creating Dominican music

#### Out of Scope ❌
- International reggaeton artist with no Dominican connection
- International pop album with no Dominican creator involvement
- Foreign music performed in Dominican Republic (unless Dominican artist)

### Editorial Decision
When international content is considered:
1. Is the primary creator or performer Dominican?
2. Is this essential to document Dominican music heritage?
3. Does this add editorial value to understanding Dominican music?

If "no" to all three, the content is not a priority for Mangulina.

---

## 8. Credits Architecture

Credits in Mangulina are organized by level of belonging.

### Three Credit Layers

#### Layer 1: Creative Credits (Work Level)
**Where:** Work table  
**What:** Who created the composition  
**Relationships:** Composer, Lyricist, Arranger, Orchestrator

```
Work: "Obsesión"
Creative Credits:
├─ Composer: Luny Tunes
├─ Lyricist: Luny Tunes
└─ Arranger: Aventura
```

#### Layer 2: Performance Credits (Recording Level)
**Where:** Recording table → recording_credits relationship  
**What:** Who performed on the recording  
**Relationships:** Vocal, Guitar, Drums, Piano, Producer, Engineer, Mixing, Mastering

```
Recording: "Obsesión" by Aventura (2002)
Performance Credits:
├─ Lead Vocal: Juan Luis Díaz
├─ Vocals: Lenny Santos, Romeo Santos
├─ Percussion: [session musician]
├─ Strings: [arranger]
├─ Producer: Luny Tunes
├─ Recording Engineer: [engineer]
└─ Mastering: [mastering engineer]
```

#### Layer 3: Release Credits (Release Level)
**Where:** Release table → release_artists relationship  
**What:** Artist credited for the release  
**Relationships:** Primary, Featured, Compilation, Presenter

```
Release: "K.O.B" Album
Release Credits:
├─ Primary Artist: Aventura
├─ Label: [label]
└─ Presented by: [distributor]
```

### No Duplication

Information is stored once at its natural level.

```
DON'T DO THIS:
Recording table: artist = "Juan Luis Guerra"
Work table: artist = "Juan Luis Guerra"
Recording_Credits table: artist = "Juan Luis Guerra"
(Duplication!)

DO THIS:
Work table: creators = [composer: Luny Tunes]
Recording table: performers = [vocalist: Juan Luis Díaz]
Release table: release_artist = Aventura
(Stored once at natural level; relationships clarify role)
```

### Important: Version 1 Scope

The three-layer architecture is extensible and designed to support complete credit networks.

However, **Version 1 of Works & Credits documents only the contributions of the Dominican artist whose profile is being viewed.**

Examples above show the complete structure, but in practice:
- A Dominican composer's profile shows works they composed
- A Dominican performer's profile shows recordings they performed on
- A Dominican lyricist's profile shows works they wrote lyrics for

Version 1 does **not** strive for complete session information (all engineers, all session musicians, all producers not connected to the featured artist).

Complete collaborative credit networks are a future expansion. See Section 9 (Editorial Philosophy) for the reasoning behind this scope.

---

## 9. Editorial Philosophy — Dominican Artist-Centered Credits

The Works & Credits system is guided by a fundamental editorial philosophy: **Mangulina documents the creative careers and contributions of Dominican artists.**

### Primary Mission

Mangulina exists to preserve and present the body of work created or contributed to by Dominican artists throughout their careers.

**Critical:** Mangulina is NOT attempting to reconstruct the complete worldwide credit history of every musical work.

The Dominican artist is the center of the model. Every feature, every credit, every relationship is evaluated against one question:

**"How does this document or serve a Dominican artist's creative contribution?"**

---

### Artist-Centered Approach

Every record in the Works & Credits system answers one specific question:

**"What contribution did this Dominican artist make to this work?"**

Not:

**"Who contributed to this work?"**

Those are different editorial goals with different data models and different scopes.

Mangulina prioritizes documenting the Dominican artist's career. We are building the artist's resume, not the work's credits.

---

### Progressive Documentation

**The absence of other collaborators must never prevent documenting the contribution of a Dominican artist.**

Example:

If Luny Tunes is credited as a Producer on a song, that credit should be preserved and documented even if every other producer, writer, arranger, engineer, or musician on that work has not yet been documented.

Additional collaborators may be added later as Mangulina grows and expands its editorial coverage.

**This is not incompleteness. This is prioritization.**

The Dominican artist's verified contribution stands independently. It does not depend on completeness of other credits.

---

### Accuracy Before Completeness

**Never invent missing collaborators. Never delay documenting a verified Dominican credit because other credits are still unknown.**

These principles guide editorial decisions:

1. **Unknown information remains empty** until verified
2. **Verified information is always preserved** and visible
3. **Incomplete credits are acceptable** if the Dominican contribution is accurate
4. **We never guess** to fill gaps

Example:

```
CORRECT:
Work: "La Bella y La Bestia"
Composer: Luny Tunes
(No other credits documented yet)

INCORRECT:
Work: "La Bella y La Bestia"
Composer: Luny Tunes
Lyricist: Unknown
Producer: Unknown
[Guessing to appear complete]
```

The verified Dominican composer credit stands alone. It does not require padding with empty guesses.

---

### Scope of Version 1

**Version 1 of Works & Credits documents only the contributions of the Dominican artist whose profile is being viewed.**

A composer's profile shows:
- Works composed by that composer
- Works where they contributed as lyricist
- Works where they arranged or orchestrated
- Works in any creative role they held

It does **not** show complete credits for those works (other contributors, studio engineers, session musicians).

Future versions may expand to include complete collaborative credit networks and detailed session information.

**That future expansion is not required for Version 1 to succeed.**

Version 1 succeeds by accurately and completely documenting the Dominican artist's career.

---

### Design Consequences

This philosophy intentionally keeps the system:

- **Simpler:** Focused scope, fewer edge cases, clearer editorial decisions
- **Editorially Consistent:** Clear rules for what to include and what to exclude
- **Historically Accurate:** No invented credits, no padding, no guesses
- **Scalable:** Can expand to include collaborators without breaking the foundation

Future versions can add:
- Complete session credits
- Producer/engineer credits
- Arranger/orchestrator details
- Collaborative credit networks
- Studio and session information

But the foundation remains: the Dominican artist's career is properly documented first.

---

### Relationship to Other Sections

This philosophy informs:

- **Section 7 (National vs. International Scope):** International works are included ONLY when they document Dominican artist contributions
- **Section 8 (Credits Architecture):** The three-layer system preserves each level of Dominican creative contribution
- **Section 10 (Editorial Rules):** Rules for creation/merging/deletion follow this artist-centered model

When editorial decisions are ambiguous, refer back to this question:

**"How does this decision serve documentation of the Dominican artist's creative contribution?"**

---

## 11. Data Modeling Rules

These rules codify how entities relate to each other.

### Rule 1: One Work, Many Recordings
```
Work: "Obsesión"
├─ Recording 1: Studio version by Aventura (2002)
├─ Recording 2: Remix by Usher & Aventura (2007)
├─ Recording 3: Live version (2005)
└─ Recording N: Acoustic version, radio edit, etc.

Principle: A composition may be recorded many times.
Each recording is independent.
```

### Rule 2: One Recording, Many Tracks
```
Recording: "Obsesión" Studio Version
├─ Track on Release: K.O.B (disc 1, track 1)
├─ Track on Release: K.O.B Reissue (disc 1, track 1)
├─ Track on Release: Bachata Legends Compilation (track 5)
└─ Track on Release: Greatest Hits (disc 2, track 3)

Principle: A recording may appear on multiple albums.
Each appearance is a separate Track (placement).
```

### Rule 3: One Work, Many Creators
```
Work: "Obsesión"
├─ Creator 1: Luny Tunes (composer)
├─ Creator 2: Luny Tunes (lyricist)
└─ Creator 3: Aventura (arranger)

Principle: Compositions have multiple creative contributors.
Each role is documented separately.
```

### Rule 4: One Recording, Many Performers
```
Recording: "Obsesión" by Aventura
├─ Performer 1: Juan Luis Díaz (lead vocal)
├─ Performer 2: Lenny Santos (vocal)
├─ Performer 3: Romeo Santos (vocal)
├─ Performer 4: Luny Tunes (producer)
└─ Performer N: [session musicians]

Principle: Recordings involve many performers in different roles.
Each role is documented separately.
```

### Rule 5: One Release, Many Artists
```
Release: "K.O.B"
├─ Release Artist: Aventura (primary)
├─ Record Label: [label name]
├─ Distributed by: [distributor]
└─ Presented by: [entity]

Principle: A release may be credited to/associated with multiple entities.
Each role is documented separately.
```

### Rule 6: No Cross-Level Shortcuts
```
WRONG:
Recording has a "composer" field pointing directly to an artist
(This bypasses the Work and duplicates composition information)

CORRECT:
Recording → Work → creative_credits → composers
(Relationship path clarifies that composition is a Work-level attribute)
```

### Rule 7: No Unnecessary Denormalization
```
WRONG:
Recording table: artist = "Juan Luis Guerra"
And in recording_credits: artist = "Juan Luis Guerra" (vocalist)
(Duplication; artist_id is enough)

CORRECT:
Recording → recording_credits [with role], then JOIN to artist table
(Single source of truth; roles clarify the relationship)
```

### Rule 8: Exceptions for Historical Accuracy
```
ALLOWED EXCEPTION:
credited_as field on release_artists
Reason: Preserves historical credit text ("Juan Luis Guerra y 4.40")
This is historical data, not duplication of the canonical name.
```

---

## 12. Editorial Rules

These rules govern when to create, reuse, or merge entities.

### When to Create a New Artist

Create a new Artist entity when:
- ✅ A previously uncatalogued person/group comes into scope
- ✅ An artist establishes independent identity (e.g., Aventura member as solo artist)
- ✅ A collaboration requires a formal group name (e.g., "Juan Luis Guerra y 4.40")

Do NOT create when:
- ❌ An artist has performed under different names (use aliases instead)
- ❌ An artist appears as a featured guest (use relationship; don't create entity)
- ❌ Uncertain if person is the same individual

### When to Merge Artist Duplicates

Merge duplicates when:
- ✅ Same person documented under different spellings
- ✅ Same artist with variant names (formal name + stage name)
- ✅ High confidence these are the same individual

Example: "Juan Luis Guerra" and "Juan Luis Guerra Seijas" → merge to one entity with aliases.

### When to Create Artist Aliases

Create aliases when:
- ✅ Same artist known by multiple names (stage name, legal name, nickname)
- ✅ Artist wants both forms searchable

Example:
```
Artist: Juan Luis Guerra
├─ Canonical: Juan Luis Guerra
├─ Alias: Juan Luis
└─ Alias: JLG
```

### When to Create a New Work

Create a new Work when:
- ✅ A new composition is catalogued
- ✅ A composition with no prior recording appears in scope
- ✅ A traditional/folk song is formally attributed

Reuse existing Work when:
- ✅ Same composition already exists (even if under different recording)
- ✅ Standard/traditional song (reuse Work, create new Recording if needed)

Do NOT create when:
- ❌ Uncertain if this is the same composition
- ❌ Similar-sounding songs (verify they are the same)

### When to Create a New Recording

Create a new Recording when:
- ✅ Different performer(s) recording the Work
- ✅ Different arrangement (e.g., acoustic vs. full production)
- ✅ Live vs. studio version
- ✅ Significantly rearranged (remix counts)
- ✅ Remaster (technically same recording, but may warrant new entry for clarity)

Reuse same Recording when:
- ✅ Same performance appearing on multiple releases (use Tracks instead)
- ✅ Different format of same recording (CD vs. vinyl of same mastering)

### When to Create a Release

Create a new Release when:
- ✅ New album, single, or compilation is released
- ✅ Significant reissue (remaster, new artwork, new track listing)
- ✅ Different format is a distinct commercial product

Reuse same Release when:
- ✅ Same tracks, same order (e.g., digital + physical of same album)
- ✅ Minor printing variation (doesn't warrant new entry)

### Handling Remasters

Remaster decisions:
- **Option A:** New Release entry (e.g., "K.O.B Remastered 2020")
  - Use if remaster is commercial release
  - Create new Tracks, same Recordings, or new Recordings if sonically distinct

- **Option B:** New Recording entry
  - Use if remaster is significant audio revision
  - Mark with annotation that it's a remaster of [original year]

Example:
```
Release: K.O.B (1995, original mastering)
Release: K.O.B Remaster (2020, new mastering)

Both use same Recordings (unless remaster is sonically distinct)
Both have same Tracks (same songs in same order)
```

### Handling Live Versions

Live versions are:
- ✅ New Recording (different performance)
- ✅ May be on own Release or compilation
- ✅ Same Work (same composition)

Example:
```
Work: "Obsesión"
├─ Recording: Studio (2002)
└─ Recording: Live at Madison Square Garden (2005)
   └─ Release: Last Night Live
```

### Handling Compilations

Compilations are:
- ✅ New Release entry
- ✅ Use Tracks from existing Recordings
- ✅ Release Artist: "Various Artists"
- ✅ Each Track links to original Recording

Example:
```
Release: Bachata Legends (Compilation)
├─ Track 1: Recording of "Obsesión" by Aventura
├─ Track 2: Recording of "Bachata Rosa" by Juan Luis Guerra
├─ Track 3: Recording of "La Bella y La Bestia" by Luny Tunes
└─ Track 4: ...
```

### Handling Medleys

Medleys are treated as:
- ✅ New Recording (combination/arrangement of multiple Works)
- ✅ Credited to artists involved, with medley note
- ✅ If each Work has separate credits, document all contributors

Example:
```
Recording: "Medley: Obsesión / Bachata Rosa"
Performers: Aventura
Includes: Compositions by Luny Tunes + Juan Luis Guerra
```

### Handling Instrumentals

Instrumentals are:
- ✅ Recording with no vocal credit
- ✅ If based on Work, link to that Work
- ✅ If instrumental original, create as new Work (no lyricist)
- ✅ Credit instrumentalist/arranger as performer

### Handling Karaoke Versions

Karaoke versions are:
- ❌ Generally NOT catalogued in Mangulina
- ✅ Exception: Officially released karaoke album (rare)
- ❌ Skip unofficial/derivative versions

---

## 13. Naming Conventions

Consistency in naming ensures searchability and clarity.

### Artist Names

**Capitalization:**
- Full capitalization for proper names: Juan Luis Guerra, Luny Tunes
- Spanish accents preserved: José, María, Ángel
- No "the" in artist names: "Aventura" not "The Aventura"

**Featured Artists:**
- Format: "Artist A featuring Artist B" or "Artist A & Artist B"
- Use consistent preposition: "featuring" for one artist, "&" for collaboration

**Group Names:**
- Preserve official spelling: "Luny Tunes" not "Loony Tunes"
- Preserve special characters: "4.40" not "Four Forty"

### Work & Recording Titles

**Capitalization:**
- Title case for English: "The Beauty and the Beast"
- Sentence case for Spanish (unless proper name): "Obsesión", "Mi Santa Cecilia"
- Preserve artist stylization: "4.40" (group name in title)

**Diacriticals:**
- Preserve Spanish accents: "Obsérvame", "La Bella y La Bestia"
- Preserve original language of composition

**Length:**
- Use full official title
- Abbreviations only if officially abbreviated

### Release Titles

**Album Titles:**
- Title case, full official name
- Subtitles noted separately if applicable

**Version Indicators:**
- "Album Name (Deluxe Edition)"
- "Album Name (Remastered)"
- "Album Name (2020 Version)"

### Slugs (URL-Safe Identifiers)

Slugs are generated from names, lowercase, hyphenated:

- Juan Luis Guerra → `juan-luis-guerra`
- Luny Tunes → `luny-tunes`
- 4.40 → `4-40`
- Obsesión → `obsesion` (accent removed)
- K.O.B → `kob` (punctuation removed)

**Rules:**
- Lowercase only
- Hyphens for word separation
- No special characters except hyphens
- Accents/diacriticals removed (é → e)
- Unique per artist/work/recording (add suffix if collision)

### Punctuation & Special Characters

Handle consistently:
- Ampersands: "Artist A & Artist B" in display; understandable in search
- Periods: "Jr.", "Sr." preserved in names
- Apostrophes: "The Beatles' Greatest Hits" preserved
- Hyphens: Multi-word proper names: "John-Claude"

---

## 14. Future Compatibility

Mangulina's model is intentionally extensible for future features.

### Reserved for Future Features

The following features are planned but not yet implemented. The data model supports them without breaking changes:

#### Publishing & Licensing
- Publishing companies
- Publishing rights ownership
- ISWC (International Standard Musical Work Code)
- Mechanical licenses
- Royalty information
- Copyright holders

#### Labels & Distribution
- Record labels (independent, major)
- Label ownership history
- Distribution partners
- Regional rights
- Release territories

#### Studio & Session Information
- Recording studios
- Session dates and locations
- Session musicians (distinction from credited performers)
- Producers and engineers as separate credited roles
- Equipment and recording format

#### Extended Credits
- Conductors and orchestras
- Choir masters
- Music directors
- Guest appearances (featured slots on tracks)
- Collaboration details

#### Digital Identifiers
- ISRC (International Standard Recording Code)
- ISWC (Works)
- EIDR (Entertainment Identifier Registry)
- Spotify/Apple Music IDs

#### International/Localization
- Translated titles
- Alternative spellings in different languages
- Regional release variations

### Extensibility Principles

When adding future features:
1. **Preserve one source of truth** — New data doesn't duplicate existing information
2. **Maintain relationships** — New attributes are related through entities, not stored redundantly
3. **Respect the hierarchy** — Composition → Recording → Release structure remains
4. **Support Django/ORM** — Model design accommodates relational database patterns
5. **Maintain backward compatibility** — Existing queries continue to work

---

## 15. Examples

Complete, real-world examples demonstrating the data model.

### Example 1: Johnny Ventura ("El Caballo Negro")

**Artist Entity:**
```
Name: Johnny Ventura
Slug: johnny-ventura
Primary Role: Singer, Bandleader
Other Roles: Composer, Producer
Birth: 1945
Bio: Dominican merengue and salsa band leader...
Status: Published
```

**Works Created:**
```
Work 1: "Chévere la Nena"
├─ Composer: Johnny Ventura
└─ Lyricist: Johnny Ventura

Work 2: "La Morena" (Traditional arrangement)
├─ Arranger: Johnny Ventura
└─ Original Composer: [traditional]
```

**Recordings:**
```
Recording: "Chévere la Nena" (1974 Studio)
├─ Work: "Chévere la Nena"
├─ Primary Artist: Johnny Ventura
├─ Performers:
│  ├─ Lead Vocal: Johnny Ventura
│  ├─ Percussionist: [band member]
│  └─ Horns: [band section]
└─ Producer: Johnny Ventura

Recording: "Chévere la Nena" (Live, 2005)
├─ Work: "Chévere la Nena"
├─ Primary Artist: Johnny Ventura
├─ Performers: [live band members]
└─ Venue: [concert location]
```

**Releases:**
```
Release: "Colección Privada Vol. 1"
├─ Release Artist: Johnny Ventura
├─ Release Date: 1974-XX-XX
├─ Tracks:
│  ├─ Track 1: "Chévere la Nena" (Studio Recording)
│  ├─ Track 2: [other song]
│  └─ Track N: ...
└─ Label: [label]

Release: "Johnny Ventura Live" (2005)
├─ Release Artist: Johnny Ventura
├─ Tracks:
│  ├─ Track 1: "Chévere la Nena" (Live Recording)
│  └─ Track N: ...
```

---

### Example 2: Juan Luis Guerra (International & Dominican)

**Artist Entity:**
```
Name: Juan Luis Guerra
Slug: juan-luis-guerra
Primary Role: Singer, Composer
Other Roles: Guitarist, Producer
Birth: 1957
Province: Santiago
Bio: Bachata revolutionary who won Grammy awards...
Status: Published
```

**Works (Dominican & International):**
```
Work: "Obsesión"
├─ Composer: Juan Luis Guerra
└─ Genre: Bachata

Work: "Bachata Rosa"
├─ Composer: Juan Luis Guerra
└─ Lyricist: Juan Luis Guerra

Work: "La Morena"
├─ Composer: Juan Luis Guerra
└─ For International Artist: [artist name]
```

**Recordings:**
```
Recording: "Obsesión" (Studio, 1990)
├─ Work: "Obsesión"
├─ Primary Artist: Juan Luis Guerra
├─ Performers:
│  ├─ Lead Vocal: Juan Luis Guerra
│  ├─ Guitar: Juan Luis Guerra
│  └─ Orchestra: [session orchestra]
├─ Producer: Juan Luis Guerra
└─ Recording Location: Dominican Republic

Recording: "Obsesión (Usher Remix)" (2007)
├─ Work: "Obsesión"
├─ Primary Artist: Juan Luis Guerra
├─ Featured: Usher
├─ Performers:
│  ├─ Vocal: Usher
│  ├─ Vocal: Juan Luis Guerra (sample/interpolation)
│  └─ Producer: [remix producer]
└─ Recording Location: USA

Recording: "Composition for [International Artist]"
├─ Work: "La Morena"
├─ Primary Artist: [International Artist]
├─ Performers: [International Artist's musicians]
├─ Composer Credit: Juan Luis Guerra
└─ Recording Location: [International location]
```

**Releases:**
```
Release: "Obsérvame" (Album, 1990)
├─ Release Artist: Juan Luis Guerra
├─ Tracks:
│  ├─ Track 1: "Obsesión" (Studio Recording)
│  ├─ Track 2: "Bachata Rosa" (Studio Recording)
│  └─ Track N: [other songs]
└─ Genre: Bachata

Release: "Obsesión (Remixes)" (2008)
├─ Release Artist: Juan Luis Guerra
├─ Featured: [remix artists]
├─ Tracks:
│  ├─ Track 1: "Obsesión (Usher Remix)"
│  └─ Track N: [other remixes]
```

---

### Example 3: Luny Tunes ("The Producers")

**Artist Entity:**
```
Name: Luny Tunes
Slug: luny-tunes
Type: Duo
Primary Role: Producer, Composer
Members: Juan "Luny" Peña, Francisco "Tunes" Saldaña
Bio: Pioneering reggaeton production duo...
Status: Published
Note: Luny Tunes are PRODUCERS, not performers
```

**Distinction:**
- Luny Tunes COMPOSE and PRODUCE works
- Luny Tunes DO NOT perform (no vocal credits)
- Other artists RECORD and PERFORM their compositions

**Works Created:**
```
Work: "La Bella y La Bestia"
├─ Composer: Luny Tunes
└─ Lyricist: Wisin & Yandel (or other collaborator)

Work: "Obsesión"
├─ Composer: Luny Tunes
└─ Lyricist: Luny Tunes

Work: [100+ other reggaeton compositions]
```

**Recordings (NOT by Luny Tunes, but their compositions):**
```
Recording: "Obsesión" by Aventura
├─ Work: "Obsesión" (composed by Luny Tunes)
├─ Primary Artist: Aventura
├─ Performers: Aventura members (vocals, instruments)
├─ Producer: Luny Tunes
└─ NOT a recording BY Luny Tunes, but OF their work

Recording: "La Bella y La Bestia" by Wisin & Yandel
├─ Work: "La Bella y La Bestia" (composed by Luny Tunes)
├─ Primary Artist: Wisin & Yandel
├─ Performers: Wisin & Yandel
├─ Composer: Luny Tunes
└─ Producer: Luny Tunes

Recording: "Luny Tunes Present..." (Compilation)
├─ Release Artist: Luny Tunes
├─ Role: Producer/Curator (not performer)
├─ Tracks: Various artists performing Luny Tunes compositions
```

**Releases:**
```
Release: "Barrio Fino" (Wisin & Yandel, 2004)
├─ Release Artist: Wisin & Yandel
├─ Producer: Luny Tunes
├─ Tracks: [songs including Luny Tunes-produced tracks]

Release: "Luny Tunes Presents: Estado Sólido"
├─ Release Artist: Luny Tunes
├─ Type: Producer/Curator Album
├─ Tracks: Various artists
```

**Key Distinction:**
- Luny Tunes are in **Creative Credits** (Work level) as composers
- Luny Tunes are in **Performance Credits** (Recording level) as producers
- Luny Tunes are **NOT** recording artists (no vocal performances)
- Luny Tunes-produced releases feature other artists as performers

---

### Example 4: Various Artists Compilation

**Release Entity:**
```
Title: "Bachata Legends"
Release Artist: Various Artists
Release Date: 2010-XX-XX
Type: Compilation
Country: Dominican Republic
Genre: Bachata
```

**Track Listing:**
```
Track 1: "Obsesión" by Aventura
├─ Recording: Studio version (2002)
├─ Primary Artist (on this track): Aventura
└─ Performers: Aventura members

Track 2: "Bachata Rosa" by Juan Luis Guerra
├─ Recording: Album version (1990)
├─ Primary Artist (on this track): Juan Luis Guerra
└─ Performers: Juan Luis Guerra

Track 3: "Te Voy a Amar" by Monchy & Alexandra
├─ Recording: [version]
├─ Primary Artist (on this track): Monchy & Alexandra
└─ Performers: Monchy & Alexandra

Track 4-N: [other artists]
```

**Release Artist vs. Track Artists:**
```
Release Artist (Album Level): Various Artists
Track 1 Artist: Aventura (performer on this recording)
Track 2 Artist: Juan Luis Guerra (performer on this recording)
Track 3 Artist: Monchy & Alexandra (performer on this recording)

Important: Release Artist is "Various Artists"
But each Track has its own Primary Artist (the recording performer)
```

---

## 16. Guiding Philosophy

Mangulina is more than a database. It is a historical record of Dominican music.

Every entity, relationship, and editorial decision carries the weight of documentary responsibility.

### The Archive Model

Mangulina exists to serve future generations—researchers, musicians, fans, historians.

A recording in Mangulina is:
- **A fact:** This person created this work
- **A memory:** This is how this art was credited and released
- **A testament:** This artist contributed to Dominican culture
- **A guide:** Others can follow this artist's creative path

### Accuracy Over Completeness

Incompleteness is preferable to inaccuracy. An empty field is honest; a wrong entry is a lie.

An album with unknown production credits is better than one with guessed credits. A recording without performers listed is better than one with invented performers.

### The Relationship as Evidence

Relationships document causation and contribution:
- "This artist composed this work" is different from "this artist performed this work"
- "This artist recorded for this label" is different from "this artist owns this label"
- "This artist appeared on this release" is different from "this artist created this release"

Precision in relationships reveals the structure of creative work.

### Respect for Dominican Heritage

Every artist in Mangulina represents Dominican cultural output. Every work represents Dominican creativity. Every recording represents Dominican artistry.

The data model must honor this heritage by:
- Documenting Dominican creators with the same rigor as international stars
- Preserving historical credit exactly as given
- Distinguishing Dominican innovation (bachata revolution, reggaeton pioneering)
- Connecting artists to their communities and regions

### Future Extensibility, Present Integrity

The model grows with Dominican music.

New features (publishing, licensing, regional variation) will extend Mangulina without breaking its foundation.

But the core principle remains: accuracy, clarity, respect.

---

## 17. Conclusion: The Constitution of Mangulina

This document is the constitution of Mangulina's data model.

Every query, migration, and editorial decision should respect these principles.

New team members, contributors, and AI systems should read this document to understand not just *how* Mangulina's data is structured, but *why*.

The structure exists to serve a purpose: to preserve Dominican music heritage with integrity and clarity.

When you model Dominican music in Mangulina, you are not merely entering data. You are writing history.

---

**Document Authority:** Official Reference  
**Governance:** Central to all data decisions  
**Supersession:** Future updates to this document require architectural review  
**Citation:** Reference this document in architectural decisions and code comments

**Contact:** Mangulina Development Team  
**Last Reviewed:** 2026-07-03
