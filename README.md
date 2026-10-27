# Scores2Go

**Open-source clinical score calculator for web, Android and iOS.**

Scores2Go puts common clinical scores (ICU severity, sedation, delirium, sepsis, hepatology and more) into one fast, clean app. Every score comes with a structured input form, an instant result with interpretation, and a documentation page with references.

👉 **[Open the web app](https://lukas-schmdt.github.io/scores2go/app/)** · [Landing page & score docs](https://lukas-schmdt.github.io/scores2go/)

> ⚠️ **Disclaimer:** Scores2Go is intended for research and educational purposes only. It is not a medical device and must not replace clinical judgement. See the [full disclaimer](https://lukas-schmdt.github.io/scores2go/disclaimer.html).

---

## Features

- **21 published clinical scores**, each implemented as a pure, unit-tested Dart function
- **No account required.** Browse and calculate every score anonymously
- **Optional sign-in** to keep favorites, build your own score collections and send feedback
- **Bilingual:** English and German, for the UI and for every score
- **Responsive:** bottom navigation on phones, navigation rail on tablets and desktop
- **Offline-capable web app** (PWA, offline-first)
- **Light and dark theme**
- **Fully open source**

## Available Scores

| Area | Scores |
| --- | --- |
| ICU severity & mortality | APACHE II, SAPS II, SAPS 3, SOFA, MODS |
| Sepsis & early warning | qSOFA, NEWS2 |
| Sedation | RASS, Ramsay |
| Delirium | CAM-ICU, ICDSC, Nu-DESC |
| Neurology | Glasgow Coma Scale (GCS) |
| Pulmonology | Horovitz quotient (PaO₂/FiO₂) |
| Cardiology & vascular | CHA₂DS₂-VASc, Wells score (PE), Wells score (DVT) |
| Cardiac surgery | EuroSCORE II |
| Hepatology | MELD, MELD 3.0 |
| Neonatology | Finnegan Neonatal Abstinence Score |

Each score has its own documentation page (EN/DE) with variables, interpretation and references on the [landing page](https://lukas-schmdt.github.io/scores2go/).

## Tech Stack

- **[Flutter](https://flutter.dev) & Dart.** One codebase for web, Android and iOS
- **[flutter_bloc](https://bloclibrary.dev)** for state management
- **[Supabase](https://supabase.com)** for auth and user data (favorites, collections, feedback), secured with row-level security
- **Static HTML landing page** (no build step)
- **GitHub Actions → GitHub Pages** for deployment

## Getting Started

### Prerequisites

- Flutter SDK (stable channel, Dart ≥ 3.8)

### Run locally

```bash
git clone https://github.com/lukas-schmdt/scores2go.git
cd scores2go
flutter pub get
flutter run -d chrome     # or any connected device
```

### Useful commands

```bash
flutter test              # run all tests
flutter analyze           # lint
flutter gen-l10n          # regenerate localizations after editing lib/l10n/*.arb
flutter build web         # web release build  → build/web
flutter build apk         # Android release build
```

## Project Structure

```text
lib/
├── auth/                 # sign-in, sign-up, password reset (AuthBloc)
├── data/scores/
│   └── definitions/      # one folder per score
│       └── <score>/
│           ├── <score>.dart             # Score definition (variables, metadata)
│           ├── <score>_function.dart    # pure calculation: Score → ScoreResult
│           ├── <score>_visibility.dart  # which inputs are shown for the current state
│           └── <score>_i10n.dart        # score-specific EN/DE strings
├── l10n/                 # ARB files + generated AppLocalizations (UI strings)
└── ...
landing/                  # static landing page + per-score docs (EN in scores/, DE in scores/de/)
supabase/rls.sql          # row-level security policies (source of truth)
test/scores/              # unit tests per score + smoke test over all scores
```

Score definitions contain no network calls. Each calculation is a pure function, which keeps scores easy to review and test.

## Deployment

Every push to `main` triggers [`.github/workflows/deploy-pages.yml`](.github/workflows/deploy-pages.yml), which:

1. builds the Flutter web app (`--base-href /app/`, offline-first PWA),
2. combines it with the static `landing/` site,
3. deploys both to GitHub Pages: landing page at `/`, app at `/app/`.

## Contributing

Issues and pull requests are welcome, especially:

- bug reports on score calculations (please include the inputs, the expected result and a source),
- requests for new scores,
- translation improvements.

When proposing a new score or a correction, please cite the original publication. Every score in this app has to be traceable to its primary source.

## Support

If Scores2Go is useful to you, you can [buy me a coffee](https://buymeacoffee.com/lukas.schmdt) ☕
