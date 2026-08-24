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
- Root, iOS, and Android Bundler dependencies are installed. The active `pod`
  command is CocoaPods `1.16.2`, while `bundle exec pod` follows the lockfile
  and uses CocoaPods `1.15.2`; Android Fastlane `2.228.0` runs under Ruby
  3.2.2.
- Android Studio Quail 3 `2026.1.3 Patch 1` is installed.
- JDK `17.0.19`, Android SDK root
  `/Users/parkjongsun/Library/Android/sdk`, API 34/35/36, Build Tools 35/36,
  CMake 3.22.1, and NDK 27.0/27.1 are installed. SDK licenses are accepted.
- `android/local.properties` points to the local SDK and is ignored by Git.
- `~/.zshrc` exports the JDK/Android SDK paths and activates Mise. `~/.npmrc`
  uses the absolute user cache path so npm does not dirty project checkouts.
- The local `.git/info/exclude` ignores `.npm-cache/` because npm initializes
  logging before applying the final absolute cache configuration.
- iOS Pods installed successfully: 123 Podfile dependencies and 159 total
  pods. The Xcode workspace exposes all six Office/Lab environment schemes.
- No Android Virtual Device exists locally and no physical Android device is
  connected. Apple iOS 26.5 simulator devices exist, but the current project
  excludes `arm64` for `iphonesimulator` in `ios/Podfile`; on this Apple
  Silicon Mac, Xcode therefore exposes only the generic simulator placeholder
  for the app scheme and cannot select an installed simulator device.

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
- `:app:assembleOfficeDevelopmentDebug` was re-run from the repository root
  with the Office development env and passed incrementally in 10 seconds. The
  refreshed local debug APK is about 266 MB.
- Android build warnings are dependency/tooling warnings: SDK XML version,
  older library build-tools declarations, AndroidManifest namespace,
  deprecated APIs, and D8 stack-map warnings. They did not fail the build.
- `yarn typecheck:apps`: failed on the clean current `main` baseline with 12
  TypeScript errors across 9 files. Representative areas are BottomSheet
  spring config, Icon props, order DTO date fields, chat message types, tooth
  icon types, and order product case-group types. No source fix was made during
  environment setup.
- Both Office and Lab typechecks reproduce the same 12-error baseline.
- Source-only lint over `apps` and `shared` reports 19 errors and 119 warnings.
  The repository `yarn lint` command also scans generated Android build output,
  causing more than 20,000 findings, so it is not currently a usable clean
  baseline.
- `yarn test` fails before test execution because Jest finds both
  `jest.config.js` and the `package.json` Jest configuration. With
  `jest.config.js` selected explicitly and `__tests__` isolated, 47 tests pass
  and 4 fail across two suites (`App.test.tsx` and `dentlinkWebURL.test.ts`).
- `yarn start` fails because React Native 0.82 no longer accepts the configured
  `--experimental-debugger` option. `yarn metro-log` starts Metro 0.83.7
  successfully and is the current local workaround.
- `react-native doctor` reports no Android SDK version, but API 34/35/36 and
  Build Tools 35/36 are present and the compileSdk 36 Android build succeeds;
  treat that doctor result as a detection false negative. Watchman is not
  installed.
- The README framework versions are stale: live dependencies are React Native
  0.82.1, React 19.1.1, and TypeScript 5.9.3, not the versions shown at the top
  of the README.

## Next Starting Point

1. For the shortest path to runnable local development, create an Android
   Virtual Device in Android Studio or connect a physical Android device. Use
   `yarn metro-log` until the stale `yarn start` script is corrected.
2. Before using an iOS simulator on this Apple Silicon Mac, correct and verify
   the project-level `arm64` simulator exclusion; the installed simulator
   runtime alone is not currently sufficient.
3. Treat the typecheck, source lint, Jest configuration/test failures, stale
   start script, and README version mismatch as shared-repository baseline
   issues. Fix them only in an explicitly authorized feature or maintenance
   scope; initial environment setup itself is complete.
4. For feature implementation, verify live `origin/main`, Jira, Figma, the
   closest Office/Lab production pattern, and create the requested feature
   worktree/session before editing.
