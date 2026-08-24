# Dentlink Mobile App initial setup checkpoint - 2026-08-24

This is the current resume source for the first local setup of
`Innvoaid/dentlink-app`.

## Project Role And Continuity

- This is a secondary/support project rather than the user's primary project.
- Expect occasional small maintenance and feature tasks, and resume from this
  onboarding checkpoint instead of repeating setup from scratch.
- At the start of future work, sync this personal context and the shared app
  repository, then verify live Git refs and current team documentation.
- The app team's verified feature base is `origin/develop`; keep the `main`
  checkout clean as an administrative reference unless the user asks otherwise.
- For a very small localized task, confirm whether a dedicated worktree is
  necessary before creating one. Use a dedicated feature worktree/session for
  larger work when requested.

## Repository

- Shared repository: `https://github.com/Innvoaid/dentlink-app`
- Main local checkout: `/Users/parkjongsun/Repository/dentlink-app`
- Default branch: `main`
- Verified HEAD: `51aeb1520a1bf6244596b1aab7f83359dfbfaefa`
- The checkout is clean and synchronized with `origin/main`.
- This main checkout is the repository-administration scope. Use a dedicated
  feature worktree/session for substantial implementation when requested.
- Team branch policy uses `develop` as the feature and integration base, not
  `main`. Live verification found `origin/develop` at `b5251df`, and the latest
  Office `v2.2.3` and Lab `v1.0.3` release branches point to the same commit.
  The production tags `office-v2.2.2` and `lab-v1.0.2` are contained in
  `origin/main`.

## Team Onboarding Sources

- `APP 프로젝트 시작`:
  `https://app.notion.com/p/3c6ce072e82f80e58f0fdf8c8d3b9db6`
- `Reactotron 세팅 (네트워크 확인)`:
  `https://app.notion.com/p/3b2ce072e82f80f9a5a9ee60923437ae`
- `APP 모노레포 브랜치 전략`:
  `https://app.notion.com/p/39fce072e82f80f99f47e7161c1adf1f`
- The branch model is present in live remote refs and PR automation. The CI/CD
  checks listed in the strategy document are recommendations rather than a
  fully implemented current gate; the current validation workflow checks app
  version consistency only on a limited path set.

## Local Environment

- Node `v24.4.1`; repository requirement is Node `>=20`.
- Yarn `4.9.1` is activated through Homebrew Corepack.
- Mise `2026.8.11` reads the repository `.tool-versions` and selects Ruby
  `3.2.2` in this checkout.
- The team onboarding page and `Gemfile.lock` specify Ruby `3.4.5`, while the
  committed `.tool-versions` selects `3.2.2`. This is a repository-owned
  source-of-truth conflict to confirm with the app team. The current Ruby
  `3.2.2` environment passes `bundle check` and native dependency/build checks,
  so it is not the present build blocker.
- Root, iOS, and Android Bundler dependencies are installed. The active `pod`
  command is CocoaPods `1.16.2`, while `bundle exec pod` follows the lockfile
  and uses CocoaPods `1.15.2`; Android Fastlane `2.228.0` runs under Ruby
  3.2.2.
- Android Studio Quail 3 `2026.1.3 Patch 1` is installed.
- JDK `17.0.19`, Android SDK root
  `/Users/parkjongsun/Library/Android/sdk`, API 34/35/36, Build Tools 35/36,
  CMake 3.22.1, and NDK 27.0/27.1 are installed. The user explicitly approved
  the additional Android SDK and ARM DBT license terms needed by the API 36
  ARM64 emulator image, and the required terms were accepted.
- `android/local.properties` points to the local SDK and is ignored by Git.
- `~/.zshrc` exports the JDK/Android SDK paths and activates Mise. `~/.npmrc`
  uses the absolute user cache path so npm does not dirty project checkouts.
- The local `.git/info/exclude` ignores `.npm-cache/` because npm initializes
  logging before applying the final absolute cache configuration.
- iOS Pods installed successfully: 123 Podfile dependencies and 159 total
  pods. The Xcode workspace exposes all six Office/Lab environment schemes.
- Watchman `2026.07.27.00` and Reactotron `3.11.0` are installed through
  Homebrew. Reactotron is available at `/Applications/Reactotron.app` and was
  opened successfully.
- Android Emulator `37.1.11`, the API 36 Google APIs ARM64 system image, and a
  Pixel 8 AVD named `Dentlink_API_36` are installed. The AVD boots and connects
  through ADB as `emulator-5554`; no physical Android device is required for
  the verified local development path.
- Apple iOS 26.5 simulator devices exist, but the current project excludes
  `arm64` for `iphonesimulator` in `ios/Podfile`. `MLImage.framework` explains
  the exclusion: its arm64 slice targets a physical iOS device while its
  x86_64 slice targets the simulator. Xcode therefore exposes only the generic
  simulator placeholder for the app scheme on this Apple Silicon Mac.

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
- With `Dentlink_API_36` booted and `yarn metro-log` running,
  `yarn android-office:dev` passed in 29 seconds, installed
  `com.innovaid.android.dentlink.development`, and launched `MainActivity`.
  Metro completed both Office bundles, connected to Android 16/API 36, and the
  app displayed its push-notification onboarding screen without a fatal
  runtime error.
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
  treat that doctor result as a detection false negative. After installing
  Watchman, Doctor recognizes Node, Yarn, Watchman, Xcode, Ruby, CocoaPods, and
  `.xcode.env`. ADB now recognizes the installed `Dentlink_API_36` AVD.
- An explicit Office development x86_64 simulator build passed using Rosetta,
  a temporary derived-data directory, and temporary header-path links for the
  `react-native-exit-app` Codegen headers. The app bundle is
  `DentlinkDevelopment.app` with ID `com.innovaid.dentlink.development`.
- The generated x86_64 app cannot be installed into the only available iOS
  26.5 ARM64 simulator runtime (`Failed to find matching arch`). An arm64
  simulator build reaches the final link but fails because the MLImage arm64
  slice is an iOS-device binary. Therefore native iOS compilation is proven,
  but actual iOS simulator launch is not currently available on this runtime.
- The `react-native-exit-app` package also references its generated header via
  paths CocoaPods does not expose in this build. The temporary `/tmp` links
  prove the package can compile, but a durable shared-repository fix still
  needs a maintenance scope.
- The README framework versions are stale: live dependencies are React Native
  0.82.1, React 19.1.1, and TypeScript 5.9.3, not the versions shown at the top
  of the README.
- Reactotron is wired into both Office and Lab development apps and the desktop
  app is installed. Both tracked `ReactotronConfig.js` files use
  `10.10.7.18`, while the Mac's current active address is `10.10.7.46`.
  For verification, the Office host was temporarily set to `localhost`,
  `adb reverse tcp:9090 tcp:9090` was applied, and Reactotron confirmed one
  Android 16/API 36 connection. The source was then restored, leaving the
  shared repository clean. A durable cross-developer host strategy remains a
  separate maintenance decision; the current address was not committed.

## Next Starting Point

1. For the verified Android path, boot `Dentlink_API_36`, run
   `yarn metro-log`, then run `yarn android-office:dev`. If Reactotron is
   needed, use the verified `localhost` plus `adb reverse tcp:9090 tcp:9090`
   approach temporarily or first authorize a durable shared configuration fix.
2. For iOS simulator development on Apple Silicon, resolve the MLImage
   simulator binary constraint and the `react-native-exit-app` Codegen header
   exposure. Merely removing the Podfile arm64 exclusion is not sufficient.
   A physical iPhone is the shorter current iOS runtime path if signing access
   is available.
3. Treat the typecheck, source lint, Jest configuration/test failures, stale
   start script, and README version mismatch as shared-repository baseline
   issues. Fix them only in an explicitly authorized feature or maintenance
   scope; initial environment setup itself is complete.
4. For feature implementation, refresh and use live `origin/develop` as the
   default base, then verify Jira, Figma, and the closest Office/Lab production
   pattern before creating the requested feature worktree/session. Keep this
   `main` checkout as the production/admin reference unless the user requests a
   different working model.
