# Analytics System Documentation

## Overview

The Mangulina analytics system provides comprehensive insights into user engagement with the Dominican music database. It collects anonymous behavioral data and presents actionable metrics to the editorial team.

## Architecture

### Client-Side Tracking

**Components**: `AnalyticsPageView`, `SearchAnalytics`

Events are tracked client-side and sent to `/api/analytics/track` using `navigator.sendBeacon()` for reliability. Analytics errors never interrupt user actions.

**Tracked Events**:
- `artist_view` - User views an artist profile
- `recording_view` - User views a song/recording
- `release_view` - User views an album/release
- `genre_view` - User views a genre landing page
- `page_view` - Generic page view with metadata
- `search` - User performs a search (with results count)
- `platform_click` - User clicks a streaming platform link

### Server-Side Processing

**Route**: `/api/analytics/track` (POST)

Validates, sanitizes, and persists events to Supabase:

1. **Validation**
   - UUID format for entity IDs
   - Text length limits to prevent abuse
   - Data type checking

2. **Privacy**
   - IP addresses hashed with salt (SHA256)
   - Referrer URLs sanitized to origin only (no paths)
   - User agent captured for debugging only

3. **Storage**
   - Events inserted into type-specific tables
   - View counters incremented on parent entities **atomically and deduplicated
     in the database** — one view per visitor per day per entity (enforced by a
     partial UNIQUE index + `record_*_view` SECURITY DEFINER functions). Browser
     refresh, reload, back-navigation, React re-mount, and multiple tabs no
     longer inflate counters.
   - All database access uses service role (no client access)

### Most Viewed vs. Trending vs. Rising

These are distinct concepts backed by different sources:

- **Most Viewed / "Top …" sections** — all-time, deduplicated `views` column on
  `artists` / `recordings` / `releases`.
- **Trending Songs** — last 7 days, from `mv_recording_views_7d` (materialized,
  refreshed every 15 min), with all-time fallback when the window is sparse.
- **Rising Stars** — `emerging`-tagged artists ranked by last-7-day views
  (`mv_artist_views_7d`), with all-time fallback.

### Database Schema

#### Event Tables

```sql
- artist_view_events (id, artist_id, viewed_at, metadata...)
- recording_view_events (id, recording_id, viewed_at, metadata...)
- release_view_events (id, release_id, viewed_at, metadata...)
- genre_view_events (id, genre_slug, viewed_at, metadata...)
- search_events (id, query, results_count, searched_at, metadata...)
- platform_click_events (id, recording_id, platform, clicked_at, metadata...)
- page_view_events (id, path, entity_id, page_type, created_at, metadata...)
```

All tables have:
- Row-level security enabled (no public access)
- Indexes on common query patterns
- Retention: 90 days of granular events, then automatic cleanup

#### Aggregation Views

**7-Day & 30-Day Views** (pre-aggregated for dashboard):
- `artist_views_last_7_days` / `artist_views_last_30_days`
- `recording_views_last_7_days` / `recording_views_last_30_days`
- `genre_views_last_7_days` / `genre_views_last_30_days`
- `release_views_last_7_days` / `release_views_last_30_days`
- `platform_clicks_last_30_days`
- `searches_with_no_results`

**Time-Series Views** (for trend charts):
- `artist_views_by_day_last_30_days`
- `recording_views_by_day_last_30_days`
- `search_events_by_day_last_30_days`

## Admin Dashboard

**URL**: `/admin/analytics`

### Features

1. **Date Range Selection**
   - Last 7 days (quick analysis)
   - Last 30 days (medium-term trends)
   - Last 90 days (long-term patterns)

2. **Auto-Refresh**
   - Off (manual refresh only)
   - Every 5 minutes
   - Every 15 minutes
   - Every 30 minutes

3. **Data Export**
   - CSV export of all visible metrics
   - Suitable for further analysis in spreadsheets

4. **Manual Refresh**
   - Force data reload without waiting for auto-refresh interval

### Reports

#### 1. Top Artist Views

**What it shows**: Artists with the most profile views

**Use this to**:
- Identify emerging artist interest
- Feature trending artists in homepage/email
- Curate "Trending Now" collections
- Plan editorial content around popular artists

**Actions**:
- Click artist name to view their profile
- Export for internal reporting

#### 2. Top Recording Views

**What it shows**: Songs with the most profile views

**Use this to**:
- Understand which songs resonate with audience
- Create "Popular Songs" playlists/collections
- Identify potential content gaps (why is X song popular but Y isn't?)
- Monitor breakout hits in Dominican music

**Actions**:
- Click recording name to view the song page
- Analyze which artists' songs trend most

#### 3. Top Genre Views

**What it shows**: Genre landing pages with highest engagement

**Use this to**:
- Prioritize genre curation efforts
- Identify underrepresented genres in marketing
- Understand current music taste in your audience
- Plan themed collections

**Actions**:
- Click genre to view that genre's page
- Cross-reference with other metrics

#### 4. Platform Clicks (Last 30 Days)

**What it shows**: Aggregate clicks to streaming services

**Platforms tracked**:
- Spotify
- Apple Music
- YouTube
- Deezer
- TIDAL
- Amazon Music
- Other configured platforms

**Use this to**:
- Understand which platforms your audience prefers
- Monitor distribution effectiveness
- Negotiate better deals with platforms
- Identify underperforming platform integrations

**Actions**:
- Compare platform popularity
- Ensure all links are working correctly

#### 5. Searches With No Results

**What it shows**: Search queries that returned zero matches

**CRITICAL**: These represent direct user demand for content you don't have.

**Use this to**:
- Identify high-priority artists/songs to add
- Understand content acquisition needs
- Spot misspellings or alternate names (e.g., "Juan Luis Война" vs "Juan Luis Guerra")
- Plan curator outreach

**Common categories**:
- Missing artists (add to database)
- Missing releases (add album info)
- Search bugs (ambiguous queries)
- Alternative spellings/nicknames

### View Trends

**What they show**: Daily view counts over the last N days (7, 30, or 90)

**Charts**:
- Artist Views Trend
- Recording Views Trend
- Search Trends (total searches + zero-result rate)

**Use this to**:
- Spot viral moments or sudden interest spikes
- Identify seasonal patterns
- Measure impact of editorial changes
- Forecast resource needs

## Integration Guide

### Tracking a New Event Type

1. **Define the event** in `src/lib/analytics.ts`:

```typescript
export function trackMyEvent(id: string, metadata?: string) {
  if (id.trim()) {
    sendAnalyticsEvent({
      event_type: "my_event",
      entity_id: id,
      source: metadata,
    });
  }
}
```

2. **Add validation handler** in `src/lib/analyticsValidation.ts`:

```typescript
export async function processMyViewEvent(
  data: RequestBody,
  metadata: Record<string, unknown>,
): Promise<void> {
  const entityId = uuidValue(data.entity_id);
  if (!entityId) throw new Error("Invalid entity_id");

  const supabase = getSupabaseServiceClient();
  const { error } = await supabase
    .from("my_view_events")
    .insert({ entity_id: entityId, ...metadata });
  if (error) throw error;
}
```

3. **Register in API route** (`/api/analytics/track`):

```typescript
const handlers = {
  // ... existing handlers
  my_event: processMyViewEvent,
};
```

4. **Create database table** (migration):

```sql
CREATE TABLE public.my_view_events (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  entity_id uuid NOT NULL,
  viewed_at timestamptz NOT NULL DEFAULT now(),
  source text,
  referrer text,
  user_agent text,
  ip_hash text
);
```

5. **Create aggregation views** for dashboard display

6. **Add report card** to admin dashboard

## Performance Considerations

### Database

- **Indexes**: All event tables indexed on `(entity_id, timestamp)` for efficient range queries
- **Partitioning**: Consider partitioning events tables by date for very large datasets
- **Aggregation Views**: Pre-computed aggregations prevent expensive GROUP BY on raw event tables
- **Query Limits**: Dashboard fetches max 20 artists, 20 recordings, 30 searches, etc.

### Client-Side

- **sendBeacon()**: Used instead of fetch() for better reliability
- **Silent Failure**: Analytics errors caught and suppressed (never breaks user experience)
- **Batch Tracking**: Consider batching events if tracking frequency is very high

### Retention

- **90-day granular events** (planned target): Full detail on what happened
- **Long-term trending**: Aggregations / `views` counters kept indefinitely for historical analysis
- **Automatic cleanup**: a `delete_old_analytics_events(days)` function and an
  `analytics_retention_preview` view are installed but **DORMANT** — nothing is
  scheduled and no rows are deleted. Review `analytics_retention_preview`, then
  schedule the cleanup explicitly when approved (see the commented block in
  `20260701001000_analytics_retention_plan.sql`). The `views` counters are never
  affected by retention.

## Privacy & Compliance

### What We Track

✅ Behavior (views, clicks, searches)
✅ Aggregated metrics (view counts, popular items)
✅ General context (referrer origin, user agent type)

### What We Don't Track

❌ Personal information (user email, account details)
❌ URL paths (only domain origin in referrer)
❌ Raw IP addresses (only hashed with salt)
❌ Identifiable browsing history

### Data Access

- Only service role can read raw event data
- Admin users see aggregated/anonymized dashboards
- No export of individual user profiles
- All queries filtered by date range for relevance

## Troubleshooting

### Missing Data

1. **Check database migration applied**: Verify `20260619003000_add_missing_analytics_views_and_functions.sql` exists in Supabase
2. **Check RLS policies**: Ensure `service_role` has `SELECT, INSERT` on event tables
3. **Check API errors**: Look for 400-level responses in browser network tab
4. **Check event being tracked**: Verify `trackXyz()` is being called on the page

### High Query Latency

1. **Check indexes**: Run `EXPLAIN ANALYZE` on dashboard queries
2. **Check data volume**: Are event tables growing beyond memory limits?
3. **Consider partitioning**: For 100M+ events, partition by date
4. **Check aggregation freshness**: Views may be stale if Supabase hasn't refreshed

### IP Hash Not Working

- Verify `ANALYTICS_IP_HASH_SALT` environment variable is set
- Change salt to rotate all hashes (old hash won't match new)
- If salt is empty, hashing is skipped (ip_hash = NULL)

## Future Enhancements

1. **Cohort Analysis**: Track user journeys (artist view → genre view → search)
2. **A/B Testing**: Support variant tracking for feature experiments
3. **Alerts**: Notify team when a metric exceeds threshold
4. **Custom Reports**: Let admins build custom dashboard cards
5. **Real-Time Data**: WebSocket updates instead of polling
6. **Heatmaps**: Track scroll depth and interaction patterns
7. **Retention Metrics**: Understand repeat visitor patterns

## Questions?

For issues or feature requests, contact the platform team.
