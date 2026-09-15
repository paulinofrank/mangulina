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

  async redirects() {
    return [
      {
        source: "/songs/pagame-tu-vicio-antony-santos",
        destination: "/songs/pegame-tu-vicio-antony-santos-6",
        permanent: true,
      },
      {
        source: "/es/songs/pagame-tu-vicio-antony-santos",
        destination: "/es/songs/pegame-tu-vicio-antony-santos-6",
        permanent: true,
      },
    ];
  },

  async rewrites() {
    return {
      beforeFiles: [],
      afterFiles: [
        {
          // Paths with a dot skip the locale middleware (see the proxy.ts
          // matcher), so a mistyped /foo.html reached [locale] as the locale
          // "foo.html" and got Next's unstyled 404. afterFiles runs once public/
          // files and static routes (robots.txt, sitemap.xml, icons) have had
          // their chance, so whatever is left is a missing page: send it to the
          // English tree, where [locale]/not-found.tsx renders with a 404.
          source:
            "/:path((?!(?:en|es|_next|_vercel|api|admin|auth|debug|sitemaps)(?:/|$)).*\\..*)",
          destination: "/en/:path",
        },
      ],
      fallback: [],
    };
  },

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
