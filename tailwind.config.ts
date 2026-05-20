import type { Config } from 'tailwindcss';

const config: Config = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        ink: 'var(--color-ink)',
        wikicrimson: 'var(--color-wikicrimson)',
        flagblue: 'var(--color-flagblue)',
        canvas: 'var(--color-canvas)',
      },
      fontFamily: {
        outfit: 'var(--font-outfit)',
        serif: 'var(--font-serif)',
      },
    },
  },
  plugins: [],
};

export default config;