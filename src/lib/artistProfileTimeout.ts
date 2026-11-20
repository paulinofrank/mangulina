// Share one deadline across the reads in each artist profile loading phase.
export function artistProfileTimeout() {
  return AbortSignal.timeout(8_000);
}
