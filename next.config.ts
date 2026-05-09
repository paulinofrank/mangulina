import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  images: {
    unoptimized: true, // ← makes localhost image loading MUCH faster
    remotePatterns: [
      {
        protocol: 'https',
        hostname: 'srulenjahemkuxtkfmzt.supabase.co',
        port: '',
        pathname: '/storage/v1/object/public/**',
      },
    ],
  },
};

export default nextConfig;
