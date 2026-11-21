# TC DARK - ONE STATE PANEL

TC DARK is an independent companion app for One State players. It provides a dark/red dashboard, French and English interface, searchable modules, and a personal studio for organizing notes and goals.

## Requirements
- Flutter SDK 3.19 or newer
- Dart SDK 3.3 or newer
- Android platform support

## Run locally
```bash
flutter pub get
flutter run
```

## Build Android APK locally
```bash
flutter build apk --release
```
The APK is generated at `build/app/outputs/flutter-apk/app-release.apk`.

## Build with GitHub Actions
Every push to `main` starts the Android build workflow. When the workflow succeeds, download the `TC-DARK-Android-APK` artifact from the Actions run.

## Scope
This project is a standalone companion interface. It does not modify the One State game, connect to game servers, provide cheats, or automate gameplay.
