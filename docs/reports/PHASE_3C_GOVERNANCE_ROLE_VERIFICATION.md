# Phase 3C Governance Verification: Role Classification

**Status:** Requires Supabase Query Execution  
**Date:** 2026-07-05  
**Purpose:** Verify that recording_credits contains only appropriate recording-level roles, not work-level creative credits

---

## Instructions

Before deploying Phase 3C migrations to Supabase:

1. Run the SQL query below against your Supabase database
2. Copy the results
3. Compare each role to the Classification Guide (Section 3)
4. Mark each role as Category 1, 2, or 3
5. Report any Category 2 or 3 roles for review

---

## SQL Query to Run

Execute this query in Supabase SQL Editor or pgAdmin:

```sql
-- Phase 3C Governance: Audit Current Roles in recording_credits

SELECT DISTINCT
    role,
    COUNT(*) as usage_count,
    COUNT(DISTINCT recording_id) as recording_count,
    COUNT(DISTINCT artist_id) as artist_count
FROM public.recording_credits
GROUP BY role
ORDER BY usage_count DESC, role ASC;
```

**Expected output:** List of distinct role values with usage counts

---

## Section 2: Results Template

Once you run the query, record the results here:

| Role | Count | Recording Count | Artist Count | Classification | Notes |
|------|-------|-----------------|--------------|------------------|-------|
| *(run query)* | | | | | |

---

## Section 3: Classification Guide

### Category 1: ✅ OK to Remain in recording_credits

**Recording Performer / Session / Technical Credits**

These belong at the RECORDING level because they describe who performed/engineered THIS SPECIFIC RECORDING.

| Role | Rationale |
|------|-----------|
| `vocal` | Performer who sang on this recording |
| `lead_vocal` | Lead vocalist on this recording |
| `vocals` | Backup/supporting vocals on this recording |
| `featured_vocal` | Featured vocalist on this recording |
| `guest_vocal` | Guest vocalist on this recording |
| `guitar` | Guitarist who performed on this recording |
| `drums` | Drummer who performed on this recording |
| `piano` | Pianist who performed on this recording |
| `bass` | Bass player on this recording |
| `trumpet` | Trumpet player on this recording |
| `saxophone` | Saxophone player on this recording |
| `trombone` | Trombone player on this recording |
| `strings` | String musicians on this recording |
| `orchestra` | Orchestra that performed on this recording |
| `choir` | Choir that performed on this recording |
| `percussion` | Percussionist on this recording |
| `horns` | Horn section on this recording |
| `producer` | Producer of THIS recording/session |
| `recording_engineer` | Engineer who recorded THIS session |
| `engineer` | Recording engineer for THIS session |
| `mixing` | Engineer who mixed THIS recording |
| `mixing_engineer` | Mixing engineer for THIS recording |
| `mastering` | Engineer who mastered THIS recording |
| `mastering_engineer` | Mastering engineer for THIS recording |
| `session_musician` | Session musician on THIS recording |
| `arranger` | Arranger of THIS recording (if recording-specific arrangement) |
| `conductor` | Conductor of THIS recording/session |

**Key Test:** "Did this person perform on or technically engineer THIS RECORDING?"  
If YES → Category 1 ✅

---

### Category 2: ❌ Should Move to credited_work_credits (Work Level)

**Creative Credits at Composition Level**

These belong at the WORK level because they describe who CREATED/COMPOSED the underlying musical work, which is the same across all recordings of that work.

| Role | Rationale | Correct Location |
|------|-----------|------------------|
| `composer` | Wrote the musical composition | credited_work_credits |
| `lyricist` | Wrote the lyrics/words | credited_work_credits |
| `writer` | Wrote the song | credited_work_credits |
| `songwriter` | Wrote the song | credited_work_credits |
| `arranger` | Arranged the work (if not recording-specific) | credited_work_credits |
| `orchestrator` | Orchestrated the work | credited_work_credits |
| `co-composer` | Co-wrote the composition | credited_work_credits |
| `co-writer` | Co-wrote the work | credited_work_credits |

**Key Test:** "Would this credit be the same for ALL recordings of this work?"  
If YES → Category 2 ❌ (move to credited_work_credits)

**Examples:**
- "Luny Tunes" as composer (work-level) ≠ "Luny Tunes" as producer (recording-level)
- "Juan Luis Guerra" as composer (work-level) ≠ "Juan Luis Guerra" as vocalist (recording-level)

---

### Category 3: ⚠️ Ambiguous - Requires Human Review

**Roles that could belong to either level depending on context**

| Role | Ambiguity | Resolution |
|------|-----------|-----------|
| `arranger` | Could be work-level OR recording-specific arrangement | Review usage: If consistent across recordings → work-level; If recording-specific → recording-level |
| `producer` | Could be work-level (produced composition) OR recording-level (produced session) | Review context: In Mangulina, producers are typically RECORDING-level (session producers), unless they also composed |
| `remix_producer` | Producer who remixed THIS recording | Category 1 ✅ (recording-level) |
| `composer_arranger` | Role combines two levels | Split into composer (work) and arranger (recording) |
| `musical_director` | Could conduct or arrange THIS recording | Usually Category 1 ✅ (recording-level), but verify context |

**Resolution:** Review specific artists and their documented roles in context

---

## Section 4: Known Governance Rules

### Definitive Recording-Level Roles

These are ALWAYS recording-level per DATA_GOVERNANCE.md § 8.2:
- ✅ Vocal, Guitar, Drums, Piano, Producer, Engineer, Mixing, Mastering

### Definitive Work-Level Roles

These are ALWAYS work-level per DATA_GOVERNANCE.md § 8.1:
- ❌ Composer, Lyricist, Orchestrator

### From Documentation Examples

**Recording level examples in documentation:**
- Lead Vocal: Juan Luis Díaz
- Vocals: Lenny Santos, Romeo Santos
- Percussion: [session musician]
- Strings: [arranger]
- Orchestra: [ensemble]
- Producer: Luny Tunes
- Recording Engineer: [engineer]
- Mastering: [mastering engineer]

**Work level examples in documentation:**
- Composer: Luny Tunes
- Lyricist: Luny Tunes
- Arranger: Aventura (when defining the work, not the session)

---

## Section 5: Action Items

### After Role Classification

**If all roles are Category 1:**
- ✅ Proceed to Phase 3C deployment
- ✅ All data is correctly placed

**If any Category 2 roles found:**
- ⚠️ PAUSE deployment
- 📋 Flag which roles and how many records affected
- 🔍 Review whether they should move to `credited_work_credits`
- 📝 Plan data migration if needed
- ⚠️ This may require:
  - Creating `credited_work_credits` table (Phase 3D work)
  - Moving specific credits from recording to work level
  - Updating queries that depend on current structure

**If any Category 3 roles found:**
- ⚠️ PAUSE for review
- 📋 List examples of each Category 3 role
- 🔍 Determine if they should stay (Category 1) or move (Category 2)
- 👤 Verify with editorial team if unclear
- 📝 Document decision
- ✅ Then proceed

---

## Section 6: Examples from Documentation

### Example 1: Luny Tunes (The Producers)

**Work level:**
```
Work: "Obsesión"
Composer: Luny Tunes
```
→ Goes to `credited_work_credits`

**Recording level:**
```
Recording: "Obsesión" by Aventura (2002)
Producer: Luny Tunes
```
→ Stays in `recording_credits`

---

### Example 2: Juan Luis Guerra

**Work level:**
```
Work: "Bachata Rosa"
Composer: Juan Luis Guerra
Lyricist: Juan Luis Guerra
```
→ Goes to `credited_work_credits`

**Recording level:**
```
Recording: "Bachata Rosa" (studio 1990)
Lead Vocal: Juan Luis Guerra
Guitar: Juan Luis Guerra
Producer: Juan Luis Guerra
```
→ Stays in `recording_credits`

---

### Example 3: Aventura (Vocalists vs. Arrangers)

**Work level (if recording-specific arrangement exists):**
```
Work: "Obsesión"
Composer: Luny Tunes
Arranger: Aventura (if they arranged the work specifically)
```
→ Could go to `credited_work_credits`

**Recording level:**
```
Recording: "Obsesión" (Aventura version, 2002)
Lead Vocal: Juan Luis Díaz
Vocals: Lenny Santos
Vocals: Romeo Santos
Producer: Luny Tunes
```
→ Stays in `recording_credits`

---

## Section 7: Governance Compliance

### ADR-001: Three-Level Credit Architecture

This verification ensures proper separation:

| Level | Table | Focus |
|-------|-------|-------|
| Work | `credited_work_credits` | Who WROTE/COMPOSED this? |
| Recording | `recording_credits` | Who PERFORMED/ENGINEERED this? |
| Release | `release_artists` | Who is CREDITED for this album? |

**Phase 3C Goal:** Ensure `recording_credits` contains only recording-level credits, not work-level

---

## Section 8: How to Report Results

Once you run the query and classify the roles, provide:

1. **Count of roles by category:**
   - Category 1 (OK): ___ roles
   - Category 2 (Move): ___ roles
   - Category 3 (Review): ___ roles

2. **List of roles by category:**
   ```
   Category 1 ✅: vocal, lead_vocal, guitar, drums, piano, producer, engineer
   Category 2 ❌: [list any found]
   Category 3 ⚠️: [list any found]
   ```

3. **If any Category 2 or 3 found:**
   - Which role(s)?
   - How many records affected?
   - What action needed?
   - Can data stay or must it move?

4. **Final decision:**
   - ✅ Safe to deploy Phase 3C
   - ⚠️ Review needed before deployment
   - ❌ Data migration required before deployment

---

**Next Step:** Run the SQL query above and report results

---

**Authority:** Phase 3C Governance Verification  
**Due Before:** Phase 3C Supabase Deployment  
**Approval Gate:** Cannot proceed to deployment without this verification
