// analyticsConfig.ts
// Static, client-safe facts about how the analytics system is configured.
// No server-only imports here so this can be used from both server diagnostics
// (analyticsHealth.ts) and client tab components.
export const ANALYTICS_CONFIG = {
  visitorIdStrategy: "Anonymous localStorage UUID (key: mangulina_visitor_id)",
  dedupTimezone: "America/Santo_Domingo",
  rollupRefreshInterval: "Every 15 minutes",
  vercelAnalyticsInstalled: true,
  speedInsightsInstalled: true,
  vercelProductionOnly: true,
} as const;
