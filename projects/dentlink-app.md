# Dentlink Mobile App initial setup checkpoint - 2026-08-24

This is the current resume source for the first local setup of
`Innvoaid/dentlink-app`.

## Repository

- Shared repository: `https://github.com/Innvoaid/dentlink-app`
- Main local checkout: `/Users/parkjongsun/Repository/dentlink-app`
- Default branch: `main`
- Verified HEAD: `51aeb1520a1bf6244596b1aab7f83359dfbfaefa`
- The checkout is clean and synchronized with `origin/main`.
- This main checkout is the repository-administration scope. Use a dedicated
  feature worktree/session for substantial implementation when requested.

## Local Environment

- Node `v24.4.1`; repository requirement is Node `>=20`.
- Yarn `4.9.1` is activated through Homebrew Corepack.
- Mise `2026.8.11` reads the repository `.tool-versions` and selects Ruby
  `3.2.2` in this checkout.
- Root, iOS, and Android Bundler dependencies are installed. iOS uses
  CocoaPods `1.16.2`; Android Fastlane `2.228.0` runs under Ruby 3.2.2.
- Android Studio Quail 3 `2026.1.3 Patch 1` is installed.
- JDK `17.0.19`, Android SDK root
  `/Users/parkjongsun/Library/Android/sdk`, API 34/35/36, Build Tools 35/36,
  CMake 3.22.1, and NDK 27.0/27.1 are installed. SDK licenses are accepted.
- `android/local.properties` points to the local SDK and is ignored by Git.
- `~/.zshrc` exports the JDK/Android SDK paths and activates Mise. `~/.npmrc`
  uses the absolute user cache path so npm does not dirty project checkouts.
- iOS Pods installed successfully: 123 Podfile dependencies and 159 total
  pods. The Xcode workspace exposes all six Office/Lab environment schemes.
- No Android Virtual Device exists locally. The existing Apple iOS simulators
  are available; do not assume an Android emulator is configured.

## Verification

- `yarn install --immutable`: completed with existing peer-dependency
  warnings and no install failure.
- `yarn validate:versions`: passed for Office `2.2.2` and Lab `1.0.2` across
  package.json, Android, and Xcode.
- `bundle exec pod install`: passed. CocoaPods emitted OpenTelemetry license,
  duplicate generated UUID, and Hermes script-phase warnings.
- `xcodebuild -workspace DentlinkApp.xcworkspace -list`: passed and recognized
  `DentlinkDevelopment`, `DentlinkStaging`, `DentlinkLabDevelopment`,
  `DentlinkLabStaging`, and both production schemes.
- `./gradlew :app:assembleOfficeDevelopmentDebug`: passed in 12m 36s with
  1,107 tasks. The generated local APK is 264 MB and is ignored by Git.
- Android build warnings are dependency/tooling warnings: SDK XML version,
  older library build-tools declarations, AndroidManifest namespace,
  deprecated APIs, and D8 stack-map warnings. They did not fail the build.
- `yarn typecheck:apps`: failed on the clean current `main` baseline with 12
  TypeScript errors across 9 files. Representative areas are BottomSheet
  spring config, Icon props, order DTO date fields, chat message types, tooth
  icon types, and order product case-group types. No source fix was made during
  environment setup.

## Next Starting Point

1. Open `/Users/parkjongsun/Repository/dentlink-app/android` in Android Studio
   when IDE work is needed; the SDK and JDK are already configured for CLI
   builds.
2. If Android runtime QA is required, create an Android Virtual Device or
   connect a physical device first. Do not confuse the existing iOS simulators
   with an Android AVD.
3. For feature implementation, verify live `origin/main`, Jira, Figma, the
   closest Office/Lab production pattern, and create the requested feature
   worktree/session before editing.
4. Treat the 12 current TypeScript errors as a separate baseline issue rather
   than an initial-setup failure.
