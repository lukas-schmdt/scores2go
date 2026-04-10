{{flutter_js}}
{{flutter_build_config}}

// Drive the Flutter loader manually so we can suppress the default loading
// indicator and let our HTML splash screen (in index.html) own the loading UI.
_flutter.loader.load({
  onEntrypointLoaded: async function (engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();
    await appRunner.runApp();
  },
});
