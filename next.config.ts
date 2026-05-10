import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  // Move it to the root level if experimental didn't work
  // If it still warns, you can safely remove it; it's mostly for HMR/Fast Refresh
  // experimental: { }, 
  
  images: {
    unoptimized: true,
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