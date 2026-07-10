import { defineConfig, globalIgnores } from "eslint/config";
import nextVitals from "eslint-config-next/core-web-vitals";
import nextTs from "eslint-config-next/typescript";

const eslintConfig = defineConfig([
  ...nextVitals,
  ...nextTs,
  {
    // eslint-config-next sets settings.react.version to "detect", but the
    // eslint-plugin-react it bundles (7.37.5, the latest release) detects the
    // version via context.getFilename(), an API removed in ESLint 10 — every
    // lint run crashes before checking a single file. Pinning the version
    // skips detection entirely. Keep in sync with the React major/minor in
    // package.json.
    settings: {
      react: {
        version: "19.2",
      },
    },
  },
  // Override default ignores of eslint-config-next.
  globalIgnores([
    // Default ignores of eslint-config-next:
    ".next/**",
    "out/**",
    "build/**",
    "next-env.d.ts",
  ]),
]);

export default eslintConfig;
