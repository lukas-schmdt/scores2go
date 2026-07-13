# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
flutter run                     # run on connected device / Chrome
flutter run -d chrome           # run as web app
flutter build apk               # Android release
flutter build web               # web release (output: build/web)
flutter analyze                 # lint (uses flutter_lints)
flutter test                    # run all tests
flutter test test/foo_test.dart # run a single test file
flutter gen-l10n                # regenerate lib/l10n/app_localizations*.dart from ARB files
```

> **Important:** The generated files `lib/l10n/app_localizations.dart`, `app_localizations_en.dart`, and `app_localizations_de.dart` are committed to the repo. After editing an ARB file, either run `flutter gen-l10n` or manually mirror the change in all three generated files — the app will not compile otherwise.

## Architecture

### Flutter app (`lib/`)

The app uses **flutter_bloc** throughout. State lives in BLoCs; widgets only emit events and render state.

**Auth gate** — `main.dart` → `AuthBloc` drives the root: unauthenticated shows `AuthScreen`, authenticated shows `HomeScreen` wrapped in its BLoC providers. Backend is **Supabase** (URL and anon key are hardcoded in `main.dart`).

**Navigation** — `HomeScreen` has no `Scaffold` drawer. It uses a `BottomNavigationBar` on mobile (< 600 px) and a `NavigationRail` on tablet/desktop. Four tabs: Browse → Favorites → Collections → Settings (Profile). The `CustomDrawer` widget exists but is not mounted anywhere currently.

**Responsive breakpoints** (`lib/common/layout/breakpoints.dart`):
- `kMobileBreakpoint = 600` — switches to NavigationRail
- `kWideBreakpoint = 1200` — rail expands with labels

**Score data flow:**
```
lib/data/scores.dart (buildScoresList)
  → lib/data/scores/definitions/<score>/<score>.dart  (Score object)
  → ScoresRepository.scores (locale-aware getter)
  → ScoresBloc / ScoreEntryBloc
```

Score definitions are pure Dart — no network calls. Each score folder contains:
| File | Purpose |
|---|---|
| `<score>.dart` | Builds the `Score` object; wires the other three |
| `<score>_function.dart` | Pure function `ScoreResult fn(Score)` — the calculation |
| `<score>_visibility.dart` | Controls which variable groups/items are shown given current state |
| `<score>_i10n.dart` | Score-specific strings as a hardcoded `Map<locale, Map<key, String>>` |
| `<score>_doc.md` | In-app documentation (bundled as a Flutter asset) |

**Two localization systems run in parallel:**
1. **ARB / `AppLocalizations`** — UI chrome strings (navigation labels, settings, disclaimer, etc.). Source: `lib/l10n/app_en.arb` / `app_de.arb`. Access: `AppLocalizations.of(context)!.keyName`.
2. **`ScoreI10n`** — score-specific strings (variable labels, options, descriptions). Each score has its own `*_i10n.dart` subclassing `ScoreI10n`. Access: `_i10n.t(lang, 'key')`. Falls back to `'en'` if the requested locale is missing.

**`Score.doc` vs `Score.docUrl`:**
- `doc`: `String? Function(String locale)` — returns an asset path; rendered as in-app Markdown tab.
- `docUrl`: `String? Function(String locale)` — returns an external URL opened in the browser. When both are set, `docUrl` takes precedence and no Markdown tab is shown.

**Supabase tables used:**
- `user_favorites` — columns: `user_id`, `score_id`, `position`

### Adding a new score

1. Create `lib/data/scores/definitions/<name>/` with the four Dart files and a `.md` doc.
2. Register the asset folder in `pubspec.yaml` under `flutter.assets`.
3. Add `build<Name>Score(lang)` to `lib/data/scores/scores.dart` (`buildScoresList`). The assert there enforces unique `Score.id` values.
4. If adding a landing-page card: update `landing/index.html` (scores array) and `landing/sitemap.xml`.

### Landing page (`landing/`)

Static HTML — no build step. Language switching is client-side JS using `navigator.language` with a `localStorage` override. The `disclaimer.html` page follows the same pattern.

Score page `docUrl`s must include `.html` (e.g. `.../scores/ramsay.html`) — the server does not resolve extensionless URLs.
