import type { NextConfig } from "next";
import createNextIntlPlugin from "next-intl/plugin";

const withNextIntl = createNextIntlPlugin("./src/i18n/request.ts");

function getSupabaseImageHostname() {
  const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || process.env.SUPABASE_URL;

  if (!supabaseUrl) return "srulenjahemkuxtkfmzt.supabase.co";

  try {
    return new URL(supabaseUrl).hostname;
  } catch {
    return "srulenjahemkuxtkfmzt.supabase.co";
  }
}

const supabaseImageHostname = getSupabaseImageHostname();

const nextConfig: NextConfig = {
  allowedDevOrigins: ["10.0.0.3"],

  images: {
    remotePatterns: [
      {
        protocol: "https",
        hostname: supabaseImageHostname,
        port: "",
        pathname: "/storage/v1/object/public/**",
      },
      ...(supabaseImageHostname === "srulenjahemkuxtkfmzt.supabase.co"
        ? []
        : [
            {
              protocol: "https" as const,
              hostname: "srulenjahemkuxtkfmzt.supabase.co",
              port: "",
              pathname: "/storage/v1/object/public/**",
            },
          ]),
      {
        protocol: "https",
        hostname: "yt3.ggpht.com",
        port: "",
        pathname: "/**",
      },
      {
        protocol: "https",
        hostname: "lh3.googleusercontent.com",
        port: "",
        pathname: "/**",
      },
      {
        protocol: "https",
        hostname: "*.googleusercontent.com",
        port: "",
        pathname: "/**",
      },
    ],
  },
};

export default withNextIntl(nextConfig);
