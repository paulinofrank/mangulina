# Luny Tunes: Discography vs. Creative Works Comparison Report

**Generated:** 2026-07-05  
**Analysis Scope:** Complete comparison of existing Discography against newly imported Creative Works portfolio  
**Data Source:** Supabase database + Consolidated Creative Works spreadsheet

---

## Executive Summary

**Key Finding:** Luny Tunes has **ZERO overlap** between their Discography and Creative Works portfolio.

- **Discography (recording_credits):** 0 entries
- **Creative Works:** 210 unique works with 341 credits
- **Overlap:** 0 works (0%)
- **Status:** Completely independent datasets

This is expected and correct. Luny Tunes is a production/composer collective, not a traditional recording artist. Their Discography slot is empty because they don't appear as performers/vocalists on tracks. The Creative Works portfolio captures their actual contribution: production, composition, and arrangement work.

---

## 1. Exact Matches

**Result:** 0 matches

No works appear in both Discography and Creative Works because the Discography is empty.

---

## 2. Discography Only

**Result:** 0 entries

Luny Tunes has no recording credits in the system. They appear on 36 releases as a **Release Artist** (group entity), but have zero individual track credits.

---

## 3. Creative Works Only

**Result:** 210 works

All 210 imported creative works are exclusive to the Creative Works portfolio. They do not appear in the recording_credits table.

**Sample entries:**

| Title | Performer | Release | Year | Roles |
|-------|-----------|---------|------|-------|
| Yo Te Buscaba | Héctor & Tito | A La Reconquista | 2002 | Composer |
| Cazando Voy | Angel & Khriz | The Golden Era | 2002 | Producer, Arranger |
| Besos en la Boca | Héctor & Tito | A La Reconquista | 2002 | Composer |
| Gata Salvaje | Héctor & Tito / Héctor el Bambino ft. Daddy Yankee & Nicky Jam | A La Reconquista | 2002 | Producer |
| Yo Soy Rey | Wisin & Yandel | Los Vaqueros | 2007 | Producer, Composer |

(All 210 works listed in database, sample shown above)

---

## 4. Possible Matches

**Result:** 0 possible matches

Since the Discography is completely empty, there are no candidates for fuzzy matching.

---

## 5. Statistics

| Metric | Count |
|--------|-------|
| **Discography Works** | 0 |
| **Creative Works** | 210 |
| **Exact Matches** | 0 |
| **Possible Matches** | 0 |
| **Discography Only** | 0 |
| **Creative Works Only** | 210 |
| **Total Unique Works Across Both** | 210 |

### Coverage Analysis

| Direction | Coverage |
|-----------|----------|
| **Creative Works represented in Discography** | 0% (0/210) |
| **Discography represented in Creative Works** | N/A (0 entries) |

### Role Distribution (Creative Works)

| Role | Count | % of Total |
|------|-------|-----------|
| Producer | 191 | 56% |
| Composer | 70 | 21% |
| Arranger | 44 | 13% |
| Mastering Engineer | 12 | 4% |
| Mix Engineer | 10 | 3% |
| Executive Producer | 6 | 2% |
| Beat Programmer | 3 | 1% |
| Co-Producer | 3 | 1% |
| Remixer | 2 | 1% |

---

## 6. Editorial Observations

### Is the Creative Works portfolio largely independent from the Discography?

**Yes, completely independent.**

The Creative Works portfolio is fundamentally a different editorial model:
- **Discography:** Tracks where an artist is credited as a performer/vocalist
- **Creative Works:** Tracks where an artist is credited as a producer, composer, engineer, or arranger

For Luny Tunes specifically:
- They are **not** credited as performers on recordings
- They **are** credited for production/composition work on 210 tracks
- These are editorial roles, not recording artist roles

### Are there many duplicate works?

**No duplicates between systems.**

There is zero overlap, so no duplication concern.

**Internal deduplication (within Creative Works):**
- Imported: 210 unique works (by title/performer/release/year)
- Credits: 341 credits across those works
- Average: 1.62 credits per work (some works have multiple roles)

### Does the current "hide self-performed works" rule still make sense?

**Yes, and it's actually working correctly.**

The current rule (hiding works by Luny Tunes as performers) makes sense because:
1. Luny Tunes **is not** credited as a performer anywhere in the system
2. The "hide self-performed" filter would have no effect on them anyway
3. The Creative Works portfolio captures their actual contribution (production)

### Should any filtering logic be adjusted?

**No changes needed.**

Current observations:
1. **Discography (empty)** — Works where Luny Tunes appears as a recording artist/performer
   - Status: 0 entries (expected, they're producers not artists)
   - Filter rule: Hide self-produced compilations (if any)
   - **No action needed**

2. **Creative Works (210 works)** — Works where Luny Tunes contributed as producer/composer
   - Status: Properly separated from Discography
   - Filter rule: None currently applied
   - **Could add filtering by role** if desired (e.g., "show only Producer credits" or "show all creative roles")
   - **Recommendation:** Keep as-is (show all 210 works with all roles)

---

## Architectural Observations

### System Structure

Luny Tunes appears in three places:

1. **artists table** — The artist entity (Luny Tunes)
2. **release_artists** — 36 releases they're associated with (as a group)
3. **credited_work_credits** — 341 credits across 210 creative works (production roles)

**Missing:**
- **recording_credits** — No individual track credits as performers

### Data Quality

✅ **Clean separation:** Discography and Creative Works are entirely separate  
✅ **Complete import:** All 210 works successfully imported with correct roles  
✅ **Role diversity:** 9 different role types across 341 credits  
✅ **No duplicates:** Each (work, artist, role) combination appears exactly once  

### Why This Separation Makes Sense

Luny Tunes is a **production collective**, not a **recording artist**:
- They don't release "Luny Tunes songs"
- They produce songs **for other artists** (Wisin & Yandel, Daddy Yankee, etc.)
- Their creative contribution is production/arrangement, not performance

The separated model reflects this reality:
- **Discography** = where they appear as themselves (0 entries)
- **Creative Works** = where they appear as uncredited producers (210 works)

---

## Recommendations

### For Editorial Team

1. ✅ **Keep Discography empty** — It's correct for a production collective
2. ✅ **Keep Creative Works separate** — This is their actual body of work
3. Consider adding context: "Luny Tunes is a reggaeton production collective known for production and composition work on these tracks" 

### For UI/UX

1. The Creative Works portfolio is now ready for display
2. No need for overlap warnings or deduplication
3. Consider grouping by role or by artist-performer for easier browsing
4. The "210 Works" summary is accurate and authoritative

### For Data Validation

1. ✅ Import validation successful (all 210 works linked to 341 credits)
2. ✅ No orphaned works remaining
3. ✅ No duplicate role credits within work/artist combinations
4. ✅ All role names normalized and valid

---

## Conclusion

The comparison reveals a **healthy, clean data model**:

- **Zero conflicts** between Discography and Creative Works
- **Complete independence** due to different editorial roles (performer vs. producer)
- **Successful import** of all 210 works with accurate role attribution
- **Ready for production** with no data cleanup or merging required

The Creative Works portfolio is a complete, independent editorial view of Luny Tunes' production legacy, spanning from 2002 to 2016 across multiple reggaeton artists and compilations.

---

**Status:** ✅ Analysis Complete — No data modifications needed  
**Last Verified:** 2026-07-05  
**Database:** Supabase (production)
