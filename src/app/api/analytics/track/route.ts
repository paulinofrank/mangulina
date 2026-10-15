import { createServiceRoleClient } from "@/lib/supabaseService";
import { getRateLimitStore } from "@/lib/analyticsRateLimit";
import { handleTrackRequest } from "./trackHandler";

export async function POST(request: Request) {
  return handleTrackRequest(request, {
    getClient: createServiceRoleClient,
    rateLimitStore: getRateLimitStore(),
  });
}
