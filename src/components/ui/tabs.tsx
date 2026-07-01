"use client";

import * as React from "react";
import * as TabsPrimitive from "@radix-ui/react-tabs";

const Tabs = TabsPrimitive.Root;

function TabsList({
  className = "",
  ...props
}: React.ComponentProps<typeof TabsPrimitive.List>) {
  return (
    <TabsPrimitive.List
      className={`inline-flex flex-wrap items-center gap-1 rounded-xl border border-black/5 bg-white p-1 shadow-sm ${className}`}
      {...props}
    />
  );
}

function TabsTrigger({
  className = "",
  ...props
}: React.ComponentProps<typeof TabsPrimitive.Trigger>) {
  return (
    <TabsPrimitive.Trigger
      className={`rounded-lg px-4 py-2 text-xs font-medium uppercase tracking-[0.16em] text-gray-500 outline-none transition hover:text-[#CE1126] focus-visible:ring-2 focus-visible:ring-[#CE1126]/40 disabled:cursor-not-allowed disabled:opacity-50 data-[state=active]:bg-[#CE1126] data-[state=active]:text-white data-[state=active]:shadow-sm ${className}`}
      {...props}
    />
  );
}

function TabsContent({
  className = "",
  ...props
}: React.ComponentProps<typeof TabsPrimitive.Content>) {
  return (
    <TabsPrimitive.Content
      className={`outline-none focus-visible:ring-2 focus-visible:ring-[#CE1126]/40 ${className}`}
      {...props}
    />
  );
}

export { Tabs, TabsList, TabsTrigger, TabsContent };
