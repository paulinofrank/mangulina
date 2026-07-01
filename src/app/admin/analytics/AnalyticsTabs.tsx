"use client";

import type { ReactNode } from "react";
import { Tabs, TabsList, TabsTrigger, TabsContent } from "@/components/ui/tabs";
import GoogleAnalyticsTab from "./GoogleAnalyticsTab";
import VercelAnalyticsTab from "./VercelAnalyticsTab";

/**
 * Top-level tabbed shell for the admin analytics area.
 *
 * `overview` and `product` are rendered on the server and passed in as slots so
 * their data fetching stays server-side. Radix only mounts the active tab's
 * content, so the client-side Product Analytics dashboard does not fetch until
 * its tab is opened.
 */
export default function AnalyticsTabs({
  overview,
  product,
}: {
  overview: ReactNode;
  product: ReactNode;
}) {
  return (
    <Tabs defaultValue="overview" className="w-full">
      <TabsList className="mb-6">
        <TabsTrigger value="overview">Overview</TabsTrigger>
        <TabsTrigger value="product">Product Analytics</TabsTrigger>
        <TabsTrigger value="google">Google Analytics</TabsTrigger>
        <TabsTrigger value="vercel">Vercel Analytics</TabsTrigger>
      </TabsList>

      <TabsContent value="overview">{overview}</TabsContent>
      <TabsContent value="product">{product}</TabsContent>
      <TabsContent value="google">
        <GoogleAnalyticsTab />
      </TabsContent>
      <TabsContent value="vercel">
        <VercelAnalyticsTab />
      </TabsContent>
    </Tabs>
  );
}
