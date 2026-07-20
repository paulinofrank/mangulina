// analyticsRateLimit.ts
// Server-side rate limiting for the public analytics ingestion endpoint.
//
// CURRENT SCOPE — best-effort in-memory protection, not distributed:
//   * The only shipped adapter is MemoryRateLimitStore, which is
//     PROCESS-LOCAL. Vercel serverless instances do not share its state,
//     instances restart freely (resetting all counters), and traffic spread
//     across instances or regions can exceed the nominal ceilings.
//   * This is a deliberate launch decision: it blunts single-instance floods
//     and naive scripted abuse at zero infrastructure cost. A distributed
//     adapter (e.g. Redis-backed) is DEFERRED until traffic justifies it —
//     the RateLimitStore interface below is the seam where it plugs in.
//   * The active provider is stamped into structured logs
//     (rate_limit_provider) so production never silently claims protection
//     it does not have.
//
// Fail-open by design: a store failure must never block a legitimate
// visitor's analytics event, so check() returns "allow" and reports the
// degraded state instead of throwing.

export type RateLimitResult = {
  allowed: boolean;
  /** True when the decision came from a store error rather than a real count. */
  degraded: boolean;
};

export interface RateLimitStore {
  /**
   * Increments the counter for `key` in the current fixed window and returns
   * the post-increment count, or null if the store failed.
   */
  increment(key: string, windowSeconds: number): Promise<number | null>;
  readonly provider: string;
  readonly distributed: boolean;
}

/**
 * Rate-limit ceilings. Single documented location — these are conservative
 * starting engineering values, not permanent product policy.
 */
export const ANALYTICS_RATE_LIMITS = {
  /** artist/recording/release/genre/page view events, per session per minute */
  viewEventsPerSessionPerMinute: 60,
  /** search events, per session per minute */
  searchEventsPerSessionPerMinute: 30,
  /** platform click events, per session per minute */
  platformClicksPerSessionPerMinute: 30,
  /** every analytics event combined, per hashed IP per minute */
  allEventsPerIpHashPerMinute: 120,
  /** fixed-window size in seconds */
  windowSeconds: 60,
} as const;

/** Maps an event type to its per-session ceiling. */
export function sessionLimitForEventType(eventType: string): number {
  switch (eventType) {
    case "search":
      return ANALYTICS_RATE_LIMITS.searchEventsPerSessionPerMinute;
    case "platform_click":
      return ANALYTICS_RATE_LIMITS.platformClicksPerSessionPerMinute;
    default:
      return ANALYTICS_RATE_LIMITS.viewEventsPerSessionPerMinute;
  }
}

/** Event-type rate-limit class, used only to build counter keys. */
export function eventLimitClass(eventType: string): string {
  if (eventType === "search") return "search";
  if (eventType === "platform_click") return "click";
  return "view";
}

/* ------------------------------------------------------------------ memory */

type MemoryEntry = { count: number; expiresAtMs: number };

/**
 * Process-local fixed-window counter store. See the module header for why
 * this is best-effort only on serverless: no cross-instance state, counters
 * reset on restart.
 */
export class MemoryRateLimitStore implements RateLimitStore {
  readonly provider = "memory";
  readonly distributed = false;
  private entries = new Map<string, MemoryEntry>();
  private lastPruneMs = 0;

  constructor(private readonly nowMs: () => number = Date.now) {}

  async increment(key: string, windowSeconds: number): Promise<number | null> {
    const now = this.nowMs();
    const windowStart = Math.floor(now / (windowSeconds * 1000));
    const windowKey = `${key}:${windowStart}`;

    // Opportunistic prune so the map cannot grow without bound.
    if (now - this.lastPruneMs > windowSeconds * 1000) {
      this.lastPruneMs = now;
      for (const [k, entry] of this.entries) {
        if (entry.expiresAtMs <= now) this.entries.delete(k);
      }
    }

    const existing = this.entries.get(windowKey);
    if (existing) {
      existing.count += 1;
      return existing.count;
    }
    this.entries.set(windowKey, {
      count: 1,
      expiresAtMs: now + windowSeconds * 1000 * 2,
    });
    return 1;
  }
}

/* ---------------------------------------------------------------- provider */

let cachedStore: RateLimitStore | null = null;

export function getRateLimitStore(): RateLimitStore {
  if (cachedStore) return cachedStore;
  cachedStore = new MemoryRateLimitStore();
  return cachedStore;
}

/** Test hook: reset the cached provider. */
export function resetRateLimitStoreForTests() {
  cachedStore = null;
}

export function rateLimitDiagnostics(): {
  provider: string;
  distributed: boolean;
} {
  const store = getRateLimitStore();
  return { provider: store.provider, distributed: store.distributed };
}

/**
 * Checks one counter against a ceiling. Fail-open on store errors.
 */
export async function checkRateLimit(
  store: RateLimitStore,
  key: string,
  limit: number,
  windowSeconds: number = ANALYTICS_RATE_LIMITS.windowSeconds,
): Promise<RateLimitResult> {
  const count = await store.increment(key, windowSeconds);
  if (count === null) return { allowed: true, degraded: true };
  return { allowed: count <= limit, degraded: false };
}
