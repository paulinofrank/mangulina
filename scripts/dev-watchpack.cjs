// Next.js 16.3 watches the project's parent to detect directory deletion.
// On Windows, projects directly under a drive root expose protected system
// files to that scan. Preload in the dev server and its restart workers only.
if (process.platform === "win32") {
  const watchpackPath = require.resolve("next/dist/compiled/watchpack");
  const Watchpack = require(watchpackPath);
  const systemFile = /^[a-z]:[\\/](?:DumpStack\.log(?:\.tmp)?|hiberfil\.sys|pagefile\.sys|swapfile\.sys)$/i;

  require.cache[watchpackPath].exports = class WindowsDevWatchpack extends Watchpack {
    constructor(options = {}) {
      // Next's route watcher already has its own ignore filter. Only adjust
      // unfiltered watchers, including the config/directory-deletion watcher.
      super(options.ignored === undefined
        ? { ...options, ignored: (pathname) => systemFile.test(pathname) }
        : options);
    }
  };
}
