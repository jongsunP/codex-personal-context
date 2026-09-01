# Dentlink Mobile App setup and current checkpoint - 2026-09-01

This is the current resume source for the first local setup of
`Innvoaid/dentlink-app`.

## Project Role And Continuity

- Dentlink web remains the user's primary workload, while the connected mobile
  app is also an ongoing product-development scope. It is not inactive or
  optional; "secondary" describes relative task volume and priority only.
- Expect both occasional small app tasks and features whose user flow spans web
  and mobile. For cross-surface work, inspect the relevant web and app code,
  API contracts, release paths, and QA impact together.
- Resume from this onboarding checkpoint instead of repeating setup from
  scratch. At the start of future work, sync this personal context and all
  relevant shared repositories, then verify live Git refs and current team
  documentation.
- The app team's verified feature base is `origin/develop`. The first active
  feature now intentionally uses the main local checkout on
  `feature/DL-16061`, so always verify the exact live branch before editing and
  do not assume this path is still on `main`.
- For a very small localized task, confirm whether a dedicated worktree is
  necessary before creating one. Use a dedicated feature worktree/session for
  larger work when requested.

## User Background And Guidance Style

- The user is an experienced frontend developer working primarily with React
  and TypeScript. Assume familiarity with components, hooks, state, API flows,
  types, styling, review, and web delivery; do not teach these from zero.
- The knowledge gap is the mobile ecosystem around otherwise familiar React
  code. Explain unfamiliar concepts by mapping them to web equivalents, then
  focus on the mobile-specific difference and the practical consequence.
- Proactively identify whether a task is JavaScript-only or crosses the native
  boundary; cross-platform or platform-specific; Metro-refreshable or requires
  a native rebuild; simulator-verifiable or needs a physical device; and safe
  for the user to implement or better handed to the app developer.
- The user's intended scope is supporting app functionality connected to a
  web-led feature. The app developer owns deep native work, signing, release
  and store deployment, and final specialist review. Ask before implementation
  when a requested change crosses that boundary or carries material platform
  risk.
- Guide in context while doing the work: explain permissions, lifecycle,
  navigation, storage, networking, push, deep links, build variants, and
  device/simulator constraints only as they become relevant. Keep explanations
  concise but surface risks and validation requirements before they surprise
  the user.
- Start from Git-backed personal context, then verify drift-prone facts against
  the live repository, team documents, Jira, Figma, and API contracts. Do not
  rely on AI memory alone. At handoff, report Android and iOS verification
  separately and identify what still needs the app developer's review.
- In an app-focused session, interpret the user's shorthand `Chrome control`
  as a request to inspect and operate the app directly in the Android emulator
  or iOS simulator. Use the actual Chrome browser only when the user explicitly
  asks for Chrome itself or when Figma, planning, Swagger or another web source
  must be inspected. When both app platforms matter and no order is specified,
  validate Android first and then iOS. Keep app execution in the
  `dentlink-app` IDE window and its integrated Metro terminal rather than the
  web project's IDE.

## Repository

- Shared repository: `https://github.com/Innvoaid/dentlink-app`
- Active local checkout: `/Users/parkjongsun/Repository/dentlink-app`
- Repository default branch: `main`
- Active feature base and PR target: `develop`
- Current branch: `feature/DL-16061`
- Current HEAD: `88066f069ea67bc12cc4ec5e43f647a58afe30b2`
- The checkout is clean and synchronized with
  `origin/feature/DL-16061` as of 2026-08-28 15:44 KST.
- `origin/develop` is `09ca56296de4d83acf81d57851d94a8269d58c20`;
  the feature branch is fourteen commits ahead and three commits behind.
- This first feature was intentionally implemented in the existing checkout.
  For a later substantial feature, use a dedicated feature worktree/session
  only when the user requests it; for a tiny task, ask first.

## Team Onboarding Sources

- `웹 FE를 위한 Dentlink 앱 피처 개발 가이드`:
  `https://app.notion.com/p/3c6ce072e82f80e3818ee8ecb35468fc`
  - Reusable minimum workflow for web-led supporting app features; excludes
    one-time setup status and routes deep native, signing, release, and final
    specialist review to the app developer.
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
- Apple iOS 26.5 simulator devices exist, but the committed project excludes
  `arm64` for `iphonesimulator` in `ios/Podfile`. `MLImage.framework` explains
  the exclusion: its arm64 slice targets a physical iOS device while its
  x86_64 slice targets the simulator. The same constraint remains in the newer
  MLImage `1.0.0-beta8`, so a dependency-version bump alone is not a proven
  fix.

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
  build from the committed dependency graph fails because the MLImage arm64
  slice is an iOS-device binary.
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

## Office Development Runtime Proof - 2026-08-24

- Android Office development was launched on `Dentlink_API_36`, authenticated
  against the development server with the supplied test account, and reached
  the Home dashboard for `frankieDevOffice`. The dashboard showed Action
  Required cards and the Home, LinkTalk, Orders, and Profile tabs.
- iOS Office development was also launched on the iOS 26.5 iPhone 17 Pro ARM64
  simulator, authenticated with the same test account, and reached the same
  Home dashboard.
- The iOS proof used an isolated `/tmp` source copy. Only that copy omitted the
  MLKit face-detection pod/plugin and the simulator arm64 exclusion, and its
  temporary Pods header aliases handled the `react-native-exit-app` Codegen
  path. The shared repository remained clean. Face recognition is therefore
  unavailable in this proof build, and the committed project still needs a
  durable simulator compatibility fix before `yarn ios-office:dev` is a normal
  Apple Silicon workflow.
- iOS first launch displayed a non-fatal Firebase Messaging development error:
  `messaging/unregistered` from calling `getToken` before remote-message
  registration. Returning from the notification Settings flow allowed login
  and dashboard use; track this as a separate runtime maintenance issue.
- At closeout, Metro was running on port 8081 and both Android and iOS were left
  on the Office Home dashboard. No credential was written to this checkpoint.

## Initial Setup Closeout And Future Work Contract

- The initial objective was to complete as much local app setup and runtime
  proof as possible, not to deliver a new app feature. That objective is
  complete: dependencies, native toolchains, Android Studio and AVD, Xcode and
  Pods, Watchman, Reactotron, Metro, native builds, development-server login,
  and the first Office dashboard were exercised in proportion to the current
  platform constraints.
- This repository remains an active development scope connected to Dentlink
  web. Future work may be mobile-only or span web and mobile; do not interpret
  the app's lower task volume as an instruction to omit mobile implementation
  or QA.
- On every future app session, refresh the Git-backed personal context and the
  live app repository first. Then verify the requested environment, branch,
  related Jira/Figma/API sources, and the closest production pattern before
  editing. Preserve `main` as the clean administrative checkout and base
  feature work on the live `origin/develop` policy unless the team state has
  changed.
- Reuse the verified Android path as the default fast feedback loop. Use the
  installed iOS proof app only for flows that do not require face recognition,
  and keep its temporary nature explicit. Do not claim full iOS readiness until
  a normal build, push registration, and any feature-specific native behavior
  are verified.
- Shared-repository code, commits, pushes, and PR changes still require the
  user's explicit authorization. Curated personal progress history should be
  updated and pushed at meaningful checkpoints. Never persist supplied login
  credentials in source, project notes, or Codex memory.

## Historical DL-15828 / DL-16061 UI Checkpoint - 2026-08-25 19:16 KST

### Cross-surface ownership

- The web implementation has its own canonical checkpoint in
  `projects/dentlink-client-order-feedback.md`; keep web branch, commit and QA
  history there instead of duplicating it here.
- This app repository owns the Office native Profile entry and native feedback
  list/detail screens. The current Order Detail screen remains a Clinic
  `/orders/:orderId` WebView, so its feedback banner/drawer/form remains owned
  by the web repository.
- Web and app are separate builds and cannot directly share TypeScript hooks.
  They must share the server endpoint/DTO meaning, canonical feedback state,
  count and invalidation behavior, while each repository implements its own
  adapter and query layer.

### Git and PR checkpoint

- Branch `feature/DL-16061` is clean at `4a9ec671` and synchronized with its
  upstream.
- Commit `1977ae2f` implements the initial native UI and development-only
  mock/query boundary.
- Commit `55d53263` hides Pending Reviews outside development until the API is
  connected, protects quick-rating finalization on fast exit, preserves detail
  drafts across same-item refetches, and rejects attachments whose size cannot
  be verified.
- Commit `f4156be` adapts the existing shared Photo/Camera/File picker to the
  feedback-specific five-file and total-200-MB policy. It limits image and
  document selection by the remaining attachment count, resolves missing file
  sizes when possible, validates file metadata/format/size/count, preserves
  existing chat defaults and adds focused tests.
- Commit `8ea6723` updates the fixture rating prompt to the current Figma copy,
  `How was this order?`.
- Commit `4a9ec67` applies the current APP Profile layout, dynamic
  `Share Feedback (N)` entry, Profile scroll-to-top FAB, Figma-aligned feedback
  selection layout and the three detail interaction analytics events. It was
  pushed after direct Android and iOS verification.
- Draft PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is open and
  GitHub reports it mergeable at head `4a9ec671`. Its broken literal `\\n` body
  was replaced with normal Markdown earlier; this closeout did not mutate the
  PR body or Draft state.
- CodeRabbit reports success only because it skipped automatic review for a
  Draft PR. No app-developer review, teammate approval, user QA, merge, staging
  QA or deployment has occurred.

### Jira checkpoint - 2026-08-25 19:14 KST

- Parent `DL-15828` remains `진행 중`.
- `DL-16064` (app development environment and WebView/native boundary
  verification) moved through `진행 중` to `완료`. Jira comment `43696`
  records the Android/iOS runtime proof, current native/WebView ownership and
  the remaining iOS/native-contract constraints.
- `DL-16061` (app feedback UI and native integration) moved to `진행 중`.
  Jira comment `43697` links Draft PR #286 and the verified implementation and
  QA, while explicitly separating pending API/DTO/upload, WebView bridge,
  push/deep-link, app-developer review and physical-device QA.
- `DL-16066` (app order-feedback notification) remains `해야 할 일`. Jira
  comment `43698` records the missing trigger/recipient, notification copy and
  mode, FCM payload/feedback identifier, landing/deep-link and WebView/native
  bridge contracts. No speculative implementation was started.
- Story points were not changed because the unresolved integration and
  notification contracts still materially affect scope.

### Implemented app scope

- Office Profile follows the current APP card layout for profile identity,
  Preferences, Notifications, Quick Links and the inline version/sign-out
  footer. Quick Links exposes dynamic `Share Feedback (N)` in development and
  keeps Help Center available in every environment. The Profile scroll-to-top
  FAB is Office-only; Lab retains its previous presentation.
- Native `FeedbackListScreen` provides To Review/Reviewed tabs, counts,
  infinite-list query structure, pull-to-refresh, scroll-to-top FAB, immediate
  Good/Bad save and the non-automatic `Tell Us Why` detail entry.
- Native `FeedbackDetailsScreen` provides rating, reason, comment, attachment
  UI, fixed Submit action, unsaved-change protection and Android hardware-back
  handling. Its selected rating fills the remaining row while unselected
  ratings and reason chips retain content width on both platforms.
- Detail interaction analytics now include `reviewdetail_select_reason`,
  `reviewdetail_add_comments` and `reviewdetail_img_upload`, in addition to the
  existing list/detail entry events.
- Good/Bad uses an immediate `RATING` mutation. The current To Review screen
  keeps the rated card; leaving and re-entering promotes it to Reviewed in the
  development mock. Detail Submit uses a separate `DETAIL` mutation.
- Photo/Camera/File entry reuses the existing native picker and permission
  boundary. Feedback configures the shared picker independently with a maximum
  of five files, remaining-selection limits, total 200 MB, supported-format and
  positive-size checks, Figma-aligned sheet behavior and feedback-only copy.
  Existing chat callers retain their previous defaults. The feedback draft
  still stores only local metadata because the upload/API contract is absent.
- The repository/query/types boundary is development-only mock data. Staging
  and production neither fabricate feedback data nor expose Pending Reviews.

### Verification and current risk

- Codex directly verified the current source on Android API 36
  `Dentlink_API_36`: Profile top/bottom, dynamic count, scroll-to-top FAB,
  To Review/Reviewed lists, detail layout, upload area and Photo/Camera/File
  sheet. The Android check exposed a zero-width unselected-chip regression;
  `flex-grow`/`flex-shrink` replaced `flex: 0` and the fixed result was
  rechecked on-screen.
- Codex directly verified the current source on the temporary iOS 26.5 iPhone
  17 Pro simulator proof: Profile top/bottom and FAB, feedback list, detail
  rating/reason layout, upload area and Photo/Camera/File sheet. Temporary QA
  route/offset triggers were removed before the final diff, and a normal app
  relaunch returned to the authenticated Home screen.
- These checks are Codex simulator/emulator evidence, not user QA,
  physical-device QA or app-developer approval.
- Targeted ESLint over all seven changed files passes with zero output. The
  focused feedback utility test passes 8/8 with `jest.config.js` selected
  explicitly, and `git diff --check` passes.
- Office runs the current source on both simulators, and Lab development Metro
  bundles were regenerated from the final source for Android and iOS; both
  passed. This closes a compile-level Lab regression check, not Lab runtime QA.
- Office and Lab full typechecks still fail on the same nine untouched
  baseline diagnostics; the feature files add no diagnostic.
- Android and iOS system photo pickers enforce five initial selections; iOS
  also shows four remaining after one attachment. Document-file selection,
  permission denial, real upload, slow/offline API, physical devices,
  push/deep link and a fresh native iOS rebuild remain unverified.
- Office-only feedback screens are statically imported through shared
  `AllScreens`, so they are included in the Lab Metro bundle. Both Lab bundles
  pass; whether to split app-specific navigation is an app-developer review
  item rather than an unapproved refactor.

### Live Figma recheck - 2026-08-25 18:25 KST

- Rechecked the official Figma file `Lu8GEh1TUU5hOfj2FCPRYn` at Profile
  `160:38938`, Feedback `160:40593`, Order `160:38179` and Analytics
  `269:66717`, including representative APP frames and annotations rather than
  relying on the earlier handoff.
- The current APP list frames `160:41475` and `160:41530` confirm the native
  `Share Feedback` header, To Review/Reviewed counts, information banner,
  Good/Bad actions, `Tell Us Why`, `Edit`, rating badge and scroll-to-top FAB.
  The implemented list covers these current core states.
- The current detail frames `289:70322` and `289:70789` make the added mobile
  attachment states explicit: empty/uploaded lists, remove action,
  Photo/Camera/File bottom sheet, five-file error, size error and unsupported
  type error. The implementation covers the functional picker/list/validation
  boundary and applies the current Figma error-toast copy.
- Figma's picker footer still says `up to 5 files, total size up to 2G`, while
  its size-error toast says 200 MB and the latest Notion policy says five files
  and total 200 MB. Keep 200 MB until product/design makes the source of truth
  consistent.
- Profile annotation `160:40576` calls the menu `Share Feedback(N)`, while an
  older visible Profile frame says `Pending Reviews (3)`. The annotation is the
  explicit APP behavior requirement, so the app now uses dynamic
  `Share Feedback (N)` and keeps the development-only exposure boundary until
  the live API exists.
- Order APP frame `160:38775` adds a completed-order feedback banner and a
  post-rating confirmation toast. The current real app order detail is a
  Clinic WebView, so banner ownership and landing into the native feedback
  detail still require an explicit WebView/native bridge and identifier
  contract rather than a guessed navigation change.
- The APP analytics frames preserve `review_feeback_click`,
  `review_detail_click` and `review_edit_click` and also specify
  `reviewdetail_select_reason`, `reviewdetail_add_comments` and
  `reviewdetail_img_upload`; all six are now represented in the app flow.
- The current Figma file therefore does not expose another clearly safe core
  screen to implement now. Remaining work is contract clarification, exact
  copy/artwork polish and device/API QA, not an omitted major APP page.

### External inputs still required

- Deployed Swagger and generated models still have no order-feedback endpoint
  or DTO. Do not invent API names, eligibility, pagination/count, upload or
  notification contracts.
- Notification payload/category, landing route, deep-link mapping and the
  WebView-to-native bridge are not implemented.
- Reason/category mapping, count timing after immediate rating and the
  design-policy attachment conflict remain pending.
  Current implementation follows the latest Notion policy of five files and
  total 200 MB, not the Figma `2G` annotation or older 10-file/5-MB text.
- App-developer review is the next human gate. The PR must remain Draft until
  review and external contracts make it genuinely merge-ready.

## DL-15828 / DL-16061 API Integration Closeout - 2026-08-27 17:17 KST

### Git and delivery state

- `feature/DL-16061` is clean and synchronized at `ddf9f0e`.
- Commit `ddf9f0e` replaces the development mock boundary with the deployed
  feedback API, query/cache behavior and multipart attachment integration.
- Draft PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is open,
  mergeable and points to `ddf9f0e`; GitHub `add-labels` and CodeRabbit report
  success. Draft state, app-developer approval, merge, staging QA and deployment
  remain distinct and incomplete.
- The full development Swagger regeneration was deterministic but contained
  thousands of unrelated model changes, including removal of
  `OrderUpdateAdditionalDto.hasPhoto`. That generated drift was removed from
  this feature. Only the feedback transport contract is temporarily isolated
  in `shared/configs/types/feedback.ts`; replace it with generated types after
  the app team accepts the full Swagger diff.

### Implemented contract

- The app now uses deployed list endpoints for To Review and Reviewed, detail
  GET by `orderId`, initial POST with `templateVersion`, and full-replacement
  PUT. Server questions, categories, keywords and file IDs are canonical.
- Query keys include employee and employer identity plus `orderId`; count,
  list and detail invalidation preserve the immediate Good/Bad and separate
  detail Submit behavior.
- The existing employee multipart upload path is reused without an invented
  `callBy=FEEDBACK` presign field. Feedback sends completed `fileId` values in
  the FILE answer. Failure abort, staged-file cleanup, unmount races and
  omission-based server-file removal are handled.
- Feedback keeps the five-file, total-200-MB, positive-size, filename and file
  format policy. Existing chat upload callers retain their defaults.
- Order details remain Clinic WebView-owned. Notification, FCM payload and
  deep-link work remain isolated in `DL-16066` and were not guessed.

### Current runtime proof

- Android API 36 `Dentlink_API_36` and iOS 26.5 iPhone 17 Pro simulator were
  both booted with Metro running in the `dentlink-app` Cursor terminal.
- Codex directly verified the current `ddf9f0e` JavaScript on both platforms
  against the development API: Profile `Share Feedback (0)`, To Review 0,
  Reviewed 1, order `9000009126`, hospital `frankieDevOffice`, detail GET,
  server question/keyword layout and Photo/Camera/File sheet.
- Both platforms display the feedback attachment policy as five files and
  total 200 MB. No unexpected layout, navigation or runtime defect was found.
- The iOS proof still uses the previously installed temporary simulator app;
  a fresh committed-source Apple Silicon build remains blocked by the known
  MLImage/react-native-exit-app native maintenance boundary. The existing
  non-fatal `messaging/unregistered` development overlay also remains a
  separate baseline issue.
- Real POST, PUT and file upload were not executed because they mutate
  development data. Physical-device permission/camera behavior, user QA and
  app-developer approval are still separate evidence gates.

### Code verification and Jira

- Feedback Jest suites pass 14/14. Changed-file ESLint, Prettier and
  `git diff --check` pass.
- Office and Lab typechecks have the same nine untouched baseline diagnostics;
  the feedback implementation adds no TypeScript error. Removing generated
  Swagger drift also removed the eight unrelated `hasPhoto` consumer errors.
- Jira `DL-16061` description and comment `43748` contain the final scope and
  evidence; its status is `Ready for Deploy` because FE development is
  complete. `DL-16064` remains Complete, `DL-16066` remains To Do pending its
  notification contract, and parent `DL-15828` remains In Progress.

## DL-16061 Review-Ready Final Checkpoint - 2026-08-27 18:08 KST

### Git, PR and review state

- `feature/DL-16061` is clean and synchronized with its upstream at
  `9f66fa34cecc366fc9f0a74e9a3392f220cf6147`.
- Commit `aa8baf6` preserves detail answers during replacement PUT, strengthens
  upload cleanup and fixes inactive-query and unmount behavior found during
  review. Commit `9f66fa3` separates per-file and total attachment-size copy.
- PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is OPEN,
  mergeable and no longer Draft. `add-labels` and CodeRabbit are successful;
  all six review threads are resolved and the unresolved count is zero.
- Focused feedback tests pass 15/15. Changed-file lint and formatting,
  `git diff --check`, and Office/Lab new-error classification were completed
  before the final push. The nine application type diagnostics are the same
  untouched baseline errors rather than feedback regressions.

### Final Android runtime proof

- Metro was started from the integrated terminal of the Cursor IDE opened for
  `/Users/parkjongsun/Repository/dentlink-app`, and Android API 36
  `Dentlink_API_36` connected to the Office development app.
- Current development data showed Profile `Share Feedback (5)`, To Review 5
  and Reviewed 5. This supersedes the earlier time-sensitive 0/1 data snapshot.
- Completed order `9000009126` opened its Clinic `/orders/:orderId` WebView and
  displayed the rated `Glad to hear!` feedback banner. Selecting the banner
  opened native `Feedback Details` for the same order, including the selected
  Good rating and the `Image Upload` area.
- No matching fatal React Native runtime error was found. The modal was closed
  without changing feedback data. Real Good/Bad POST, detail PUT, file upload
  and removal were intentionally not executed because they mutate development
  data.

### Jira and handoff state

- `DL-16064` remains `완료`, `DL-16061` remains `Ready for Deploy`,
  `DL-16066` remains `해야 할 일`, and parent `DL-15828` remains `진행 중`.
- Jira comment `43750` records the latest commit, PR readiness, final Android
  WebView-to-native runtime proof, mutation-QA exclusion and remaining delivery
  gates.
- The next human gate is now app-developer review of PR #286. This checkpoint
  does not claim app-developer approval, physical-device QA, merge, release QA
  or deployment.

## DL-16066 Feedback Notification Deep-Link Closeout - 2026-08-27

### Git and PR state

- `feature/DL-16061` is clean and synchronized with its upstream at
  `c33515aa8931bcef701dd03325105cad9a8f212c`.
- Commit `c33515a` adds the order-feedback notification deep link and its
  focused tests. No generated model, native project, environment or release
  file was changed.
- PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is OPEN,
  non-Draft and mergeable at head `c33515a`; `add-labels` and the CodeRabbit
  status are successful. The six existing review threads remain resolved, but
  no new CodeRabbit review was submitted for `c33515a` at this checkpoint.
  App-developer approval, merge, staging QA and deployment remain incomplete.

### Confirmed contract and implementation

- The existing FCM contract is reused without new product fields: the backend
  supplies `/my/feedback?orderId={orderId}` through `data.deeplink`.
  `orderId`, not `feedbackId`, is the feedback identity. No speculative
  `type`, `webPath` or new scheme was added.
- Relative and Dentlink Portal feedback URLs convert to the current app scheme.
  The route is Office-only; Lab does not expose the feedback route.
- A valid positive safe-integer `orderId` resets navigation to the native
  feedback list. The list waits until employee and employer identity are ready,
  performs the detail GET explicitly, and opens `FeedbackDetailsScreen` only
  after canonical server data is returned.
- Missing, invalid, unauthorized or failed detail lookup leaves the user on the
  feedback list and uses the existing error toast. Back or close from a
  successfully opened detail returns to that native list. The flow never opens
  the Clinic order-detail WebView.
- Existing Firebase and Notifee cold-start, foreground, background and duplicate
  notification handling remains the owner of delivery and deduplication; this
  change only maps the confirmed URL into the native feedback navigation.

### Validation and remaining proof gates

- Focused Jest validation passes 21/21 across deep-link, URL-conversion and
  feedback repository suites. Changed-file ESLint, Prettier and
  `git diff --check` pass.
- `yarn typecheck:apps` still reports the same nine untouched repository
  baseline diagnostics. None points to the nine files changed by `c33515a`.
- Android API 36 directly verified valid warm, cold and background URL entry,
  duplicate-entry deduplication, detail-to-list back behavior and failed-order
  fallback using the development API.
- iOS 26.5 Simulator verified the same JavaScript/navigation cases with the
  previously installed development binary and current Metro bundle. This is
  not proof that the current native source rebuilds: the known Apple-Silicon
  simulator MLImage binary/architecture blocker remains.
- A real backend-generated FCM notification was not available. Actual delivery
  and tap behavior therefore remains backend/integration QA even though direct
  URL lifecycle behavior is proven. Physical-device QA is also separate.
- Jira was not mutated during this closeout. Reconcile `DL-16066` live before
  changing its status or posting delivery evidence.

## DL-16061 Current-HEAD Runtime And Review Closeout - 2026-08-28 11:39 KST

### Git, PR and code verification

- `feature/DL-16061` is clean and synchronized with its upstream at
  `b060294fcb8aa60da2c99c1bcea0f4e8b96d459c`.
- Commit `2902cef` limits its fixes to multi-upload busy state, rating-only
  overlays, deep-link refetch result races and unused staged-file cleanup.
  Commit `b060294` only normalizes Profile formatting. No code defect was
  found during the final runtime pass, so no additional app commit was made.
- PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is OPEN,
  non-Draft and mergeable at `b060294`. Auto labels and CodeRabbit are
  successful; the description now records the current-head Android and iOS
  proof. App-developer human review has been requested and remains the next
  human gate.
- The last focused verification remains feedback Jest 31/31, changed-source
  ESLint with zero errors, source Prettier and `git diff --check` pass, and the
  same nine unrelated Office/Lab baseline type diagnostics with no feedback
  regression. `origin/develop` merge-tree has no conflict.

### Current-head direct runtime proof

- Metro ran from the integrated terminal of the Cursor IDE opened for the
  exact `/Users/parkjongsun/Repository/dentlink-app` project. The final pass
  loaded current `b060294` JavaScript on Android API 36 and iOS 26.5.
- Android directly showed Office Home and Profile `Share Feedback (1)`, To
  Review 1, Reviewed 1, reviewed order `9000009126`, canonical detail GET,
  `Image Upload`, Photo/Camera/File selection, maximum five files and total
  200 MB, direct `dentlink-dev://my/feedback?orderId=9000009126` navigation,
  and detail close back to the native feedback list.
- iOS directly showed the same native list/detail data and attachment sheet.
  The direct feedback URL opened the native list and canonical detail, and
  closing the sheet and detail returned to the list. This used the previously
  installed development proof binary with the IDE Metro's current JavaScript;
  it is runtime proof, not a fresh current-native-source build.
- The simulator's existing ChannelTalk banner and non-fatal
  `messaging/unregistered` LogBox notice were dismissed before the iOS flow.
  They are baseline development-environment behavior and were not introduced
  by the feedback changes.
- Good/Bad, Submit and real file upload were deliberately not executed because
  they change shared development data. Camera/permission and actual file
  transfer still require suitable test data and preferably a physical device.

### Jira and remaining boundaries

- `DL-16061` and `DL-16066` both remain `Ready for Deploy`. Comments `43760`
  and `43761` record the current-head two-platform runtime and the distinction
  between direct URL proof and actual backend FCM delivery.
- No further safe FE code work is known at this checkpoint. Remaining work is
  downstream or externally gated: app-developer review feedback, actual
  backend-generated FCM receipt/tap, mutation-safe POST/PUT/upload data,
  physical-device camera/permission QA, merge, staging QA and deployment.
- Metro, the Android emulator and the iOS simulator were left running at this
  closeout so the user can inspect the verified screens. Treat that as
  transient session state and recheck it on resume.

## DL-16061 V2 Feedback UX Lifecycle Closeout - 2026-08-28 14:08 KST

### Confirmed UX contract and implementation

- Commit `277fc43` is pushed to `feature/DL-16061`. It aligns the native
  feedback flow with the cross-surface V2 UX contract without changing the
  feedback API, generated models, attachment limits or screen layout.
- A successful Good/Bad POST keeps the current To Review card and tab count
  through `ratingOverlays`, exposes `Tell Us Why`, and does not refetch the
  collection simply because the user enters or leaves the detail screen.
- Closing detail without Submit preserves the same To Review overlay. A
  successful detail PUT clears only that order's overlay and synchronizes
  list/count state. Feedback-list entry returns to the list, while other
  entry contexts keep their existing navigation stack with `goBack()`.
- An actual tab switch, pull-to-refresh, feature re-entry or foreground resume
  on the focused list clears the local overlay and reloads server-canonical
  collections. Direct deep links still enter through the native list and are
  not forced into the Reviewed tab.
- Rating and detail mutations guard duplicate actions. The global mutation
  error handler now excludes the feedback save endpoint so the screen-owned
  retry toast appears once instead of being duplicated.

### Verification and review boundary

- Focused feedback/error-handler Jest suites pass 17/17. Changed-file ESLint
  has zero errors and one existing unused-variable warning in
  `shared/queries/errorHandlers.ts`; Prettier and `git diff --check` pass.
- Office and Lab typechecks still report the same nine unrelated baseline
  diagnostics. No diagnostic points to the six files in `277fc43`.
- No Android emulator or iOS simulator was booted at this checkpoint, and the
  project IDE was not prepared. In accordance with the user's standing rule,
  Metro was not started elsewhere. The V2 POST/back/PUT lifecycle therefore
  has code-level proof but no new mutation-data runtime proof.
- PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is OPEN,
  non-Draft and mergeable at `277fc43`. Auto labels and CodeRabbit are green.
  The app developer had already reviewed/commented on the previous `b060294`
  head, so `277fc43` remains a new review delta; it is not app-developer
  approval, merge, staging QA or deployment.

## DL-16061 V2 Current-Head Runtime Closeout - 2026-08-28 14:49 KST

### Final code and delivery state

- Commit `8fc02c4` is pushed to `feature/DL-16061`, and the branch is clean and
  synchronized with `origin/feature/DL-16061`.
- The final change makes feedback mutation success handlers await collection
  invalidation. Rating POST still avoids an immediate collection refetch, while
  detail PUT waits for list/count synchronization before the screen-owned
  navigation callback can run. This closes the stale-card/count transition
  race without changing the V2 presentation-overlay contract.
- Focused feedback/error-handler Jest suites pass 17/17. Changed-file ESLint,
  Prettier and `git diff --check` pass.
- PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is OPEN,
  non-Draft and mergeable at `8fc02c4`. Auto labels and CodeRabbit are green,
  but the app developer's recorded review/comment predates this final V2 delta.
  Human approval, merge, staging QA and deployment remain incomplete.

### Android and iOS proof with shared E2E data

- Metro remained in the integrated terminal of the Cursor IDE opened for the
  exact app project. Android API 36 and iOS 26.5 both loaded the current
  JavaScript and logged into the shared `e2e.clinic` development account.
- Both platforms directly verified Profile, native Share Feedback, To Review,
  Reviewed, server-canonical detail questions/options, hospital name and the
  Photo/Camera/File attachment sheet. The sheet displays maximum five files and
  total 200 MB.
- The shared E2E account changed from To Review/Reviewed `31/7` to `29/9` and
  finally `28/10` during the pass. After a complete feature exit and re-entry,
  Android and iOS both converged on `28/10`, proving re-entry synchronization.
  Treat these counts as transient shared-server data, not a durable fixture.
- An Android coordinate intended for the upload area overlapped the fixed
  Submit control and re-submitted already-reviewed order `9000009204` once.
  No rating, comment or attachment value was changed. This is not complete PUT
  QA and should not be treated as intentional mutation coverage.
- Actual new Good/Bad POST, changed-detail PUT, file transfer/removal, physical
  camera/permission behavior and backend-generated FCM delivery remain separate
  QA gates. The known non-fatal iOS `messaging/unregistered` simulator warning
  is unchanged and unrelated to feedback.

## DL-16061 Pagination Boundary Closeout - 2026-08-28 15:44 KST

### Implementation and delivery state

- Commit `88066f0` (`fix: 피드백 목록 페이지 누락 방지`) is pushed to
  `feature/DL-16061`; the checkout is clean and synchronized with its
  upstream.
- The To Review presentation overlay now retains only the saved feedback item
  and its current list anchor. It is merged with canonical server items
  without rewriting the React Query cache, duplicating an order or slicing a
  canonical last item out of the visible collection.
- After a Good/Bad POST makes the server To Review collection shorter, the app
  refetches every already-loaded infinite-query page before asking React Query
  for the next page. A failed refetch blocks the stale offset request and
  exposes a retry action instead of silently skipping an item.
- Tab, account, refresh, foreground and detail-Submit synchronization
  boundaries invalidate the current presentation scope. Late rating,
  pagination or refresh responses cannot recreate an overlay in a newer
  screen scope. Detail Submit now clears the current screen overlays only
  after the mutation-owned list/count synchronization has completed.
- PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is OPEN,
  non-Draft and mergeable at `88066f0`. Auto labels and CodeRabbit report
  success. The app developer must review this newest pagination delta;
  merge, staging QA and deployment remain separate and incomplete.

### Verification boundary

- Focused feedback repository and utility suites pass 18/18. Changed-file
  ESLint and Prettier, plus `git diff --check`, pass.
- Office/Lab `typecheck:apps` still reports the same nine unrelated baseline
  diagnostics. No diagnostic points to the four files changed by `88066f0`.
- Android API 36 with the shared `e2e.clinic` development account executed a
  real Good POST for order `9000009193`. The current To Review screen kept
  `23/17`, the Good badge and `Tell Us Why`; opening and closing detail without
  Submit preserved that state. Scrolling through the last page exposed 23
  distinct cards with no offset omission. Switching tabs then restored the
  server-canonical `22/18` counts and showed the order in Reviewed.
- iOS 26.5 loaded the same current JavaScript, converged on `22/18`, showed
  order `9000009193` in Reviewed and opened/closed its native detail screen.
  The Good mutation was not repeated on iOS. This remains runtime proof using
  the existing simulator binary, not a fresh native build or physical-device
  proof.
- Shared E2E counts and order availability are time-sensitive test data. No
  Jira mutation, changed-detail PUT, real file transfer/removal,
  physical-device camera/permission QA or backend-generated FCM delivery was
  performed in this pagination closeout.

## DL-16061 Planning And Analytics Reconciliation - 2026-08-31

### Delivered changes and validation

- Branch `feature/DL-16061` is clean and synchronized with its upstream at
  `a6e28c76e9b6f2a468f8bd5d13578a8445fcc733`.
- Commit `abac780` changes the Office Profile quick link from
  `Share Feedback (N)` to the latest confirmed `Pending Reviews (N)` copy.
- Commit `a6e28c7` records `reviewdetail_img_upload` only after a successful
  image upload; a generic File upload no longer emits the image event.
- Focused feedback repository and utility suites pass 18/18. Both changed
  files pass ESLint and Prettier, and `git diff --check` passes.
- Office/Lab typechecks still report the same nine unrelated baseline
  diagnostics. Neither changed file adds a diagnostic.
- Current feedback attachment policy is maximum five files and 200 MB total.
  Figma's remaining `2G` text is stale; do not change the unrelated existing
  order-upload policy that legitimately shows 2 GB.
- Profile navigation keeps `Case Preferences` because it opens multiple saved
  preferences. The future notification-setting row should use the singular
  feature/category label `Case Preference`.
- The newly deployed admin feedback search API is not an app UI scope. Do not
  choose or implement an admin screen from this app session.

### Durable backend questions for notification settings

Before adding the new Office Profile notification rows, ask BE only these two
questions and preserve the current three-row implementation until answered:

1. What exact `pushType` values should `Case Preference` and `Order Feedback`
   use with `/app/users/own/push-preferences`, and how should the existing
   GET/POST/PATCH flow create and update them?
2. Which stable FCM payload field distinguishes `1st Feedback` from recurring
   `Order Feedback` so the existing `push_click` event can send the confirmed
   `pushType` property without inferring it from notification copy?

Do not invent new enum values, derive the distinction from title/body text, or
implement the notification rows before this contract is available. Designer
and PM decisions are not currently blocking: use 200 MB and the singular
notification label `Case Preference`; a source-file wording cleanup is enough.

## Next Starting Point

1. Ask the app developer to review the latest `abac780` and `a6e28c7` delta in
   PR #286. If feedback arrives, verify and address only valid findings before
   any merge decision.
2. Ask BE the two notification-setting questions recorded above. After the
   contract is confirmed, implement only the new Profile notification rows and
   the `push_click` property mapping supported by that contract.
3. When the backend can send a real notification, verify that
   `data.deeplink` contains `/my/feedback?orderId={orderId}` and test actual
   cold, warm, background and duplicate taps. Do not add `type` or `webPath`
   unless the shared contract changes explicitly.
4. The Android Good/Bad POST and list transition have direct evidence. When
   safe eligible data is provided, verify changed-detail PUT, file
   upload/removal and remaining cache transitions. Validate Android first,
   then iOS or a physical device for camera and permission behavior.
5. Treat a fresh iOS native build as a separate app-maintenance scope. The
   installed simulator binary proves current JavaScript behavior but does not
   resolve the committed MLImage simulator architecture constraint.
6. When the app team accepts the full generated Swagger drift, regenerate the
   whole model in a separate reviewed commit and replace the temporary feedback
   transport types. Do not partially hand-edit generated files.
7. Continue to run servers from the integrated terminal of the IDE opened for
   the exact app project. If that IDE is not prepared, ask the user before
   starting Metro directly elsewhere.
8. For later feature implementation, refresh this context and live Git first,
   then verify the active branch, Jira/Figma/API and closest production pattern.
   Keep shared app commits and pushes behind explicit user authorization.

## DL-16061 Full Breakpoint Reconciliation - 2026-09-01 18:42 KST

### Live delivery state

- `feature/DL-16061` is clean and synchronized with
  `origin/feature/DL-16061` at
  `8f3ad05fedc4a038c5c035c36901936585aa8df6`.
- The branch contains the live `origin/develop`
  `5e8375f34841ea597a0f4a492105aad944c1594d` and is 26 commits ahead with no
  base commits missing.
- The final safety commit `99535e8` removes an invalid React hook call from
  ordinary notification-permission functions and reads the OS version through
  `react-native-device-info` directly. This avoids an `Invalid hook call` in
  the notification permission/token path. The adjacent unused import was also
  removed.
- Commit `8f3ad05` supports the final backend feedback-link shape with
  `employerId` in the path, switches the authenticated employer through the
  existing deep-link side effect, and extends the route and analytics-path
  tests. The no-employer and `/my/feedback` forms remain compatibility inputs.
- PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is OPEN,
  non-Draft and MERGEABLE at `8f3ad05`; Auto PR Labels and CodeRabbit
  are successful. There is still no human approval, merge, staging QA or
  deployment proof.
- Compared with `origin/develop`, the feature changes no `android/`, `ios/`,
  package manifest or lockfile. Its TypeScript, JavaScript and bundled-asset
  surface is technically CodePush-compatible; the app developer still owns the
  final deployment method and target-version decision.

### Canonical app contract and document reconciliation

- The current app-owned deep links are
  `dentlink://feedback/{employerId}` for the native list and
  `dentlink://feedback/{employerId}?orderId={orderId}` for detail. Development
  runtime uses the matching `dentlink-dev` scheme. The route applies the
  existing `setEmployerId` side effect before the employee/employer-scoped
  feedback request.
- `/my/feedback[?orderId=...]` remains a web/legacy compatibility input and is
  converted to the app feedback route. The earlier no-employer `feedback`
  shape also remains a compatibility input, not the backend's current
  canonical link.
- For `push_click`, feedback URLs with `orderId` map to `1st Feedback`; list
  URLs without `orderId` map to `Order Feedback`. The seven feedback events,
  `feedbackType: Good/Bad`, and app-only `pendingreviews_click` are present.
- Live Jira, Notion feature/analytics pages, Figma feedback/Profile/empty-state
  and analytics nodes, FigJam notification planning, current code and generated
  Swagger were reconciled. The implemented native screens, server-canonical
  question/category/keyword flow, screen-only rating overlay, Profile count,
  5-file/200-MB attachment policy and analytics match the confirmed scope.
- The only known unimplemented planned app UI is the Office notification rows
  `Case Preference` and `Order Feedback`. The current generated
  `UserPushSettingUpdateDto.pushType` still lacks values for both, so the app
  must not invent enum values or send guessed PATCH requests. BE is expected to
  deploy either both types or only `Order Feedback`; implement only the actual
  generated contract after deployment.
- Jira `DL-16066` and the PR description still describe the older canonical
  `/my/feedback` route and older HEAD/test/runtime evidence. `DL-16061` also
  contains older verification counts. Their workflow statuses are still
  appropriate (`Ready for Deploy`), but the descriptions are documentation
  debt and were not mutated during this read-only final review.

### Final verification boundary

- Focused feedback/deep-link repository and utility tests pass: 5 suites,
  43/43 tests. All five files in `8f3ad05` pass Prettier and ESLint with zero
  errors, and `git diff --check` passes.
- The broader app Jest command requires an explicit config because the repo
  has two Jest configurations. With `jest.config.js`, existing Detox suites
  are incorrectly included without a Detox worker and `App.test.tsx` has an
  existing invalid-element failure; focused feedback suites remain green.
- Office/Lab typecheck still reports ten baseline diagnostics and no current
  feedback/deep-link regression. Keep baseline failures distinct from changed
  file validation.
- Metro was started in the integrated terminal of the Cursor IDE opened for the
  exact `dentlink-app` project. Android API 36 rebuilt and reinstalled the
  current Office development app successfully in 42 seconds, then the final
  employer-path list and order-detail deep links opened the native list and
  canonical detail GET. Android hardware back returned from detail to the list.
- iOS 26.5 loaded the same current Metro JavaScript through the previously
  installed proof binary. The final employer-path list and detail links opened
  the same native server data, and closing detail returned to the list. This is
  current JavaScript/navigation proof, not a fresh native-source iOS build. The
  known non-fatal `messaging/unregistered` development error remains visible.
- Both runtime passes used read-only list/detail navigation. No Good/Bad POST,
  changed-detail PUT, file transfer or removal was executed.
- Actual backend-generated FCM delivery/tap, mutation-safe POST/PUT/file upload,
  physical camera/permission behavior, fresh iOS native build, human review,
  merge and deployment remain separate gates, not unfinished FE code in this
  breakpoint.

### Next starting point

1. Ask the app developer to review the latest `8f3ad05` delta in PR #286 and
   address only verified findings with fresh commit/push authorization.
2. When BE deploys exact `pushType` values for both notification rows or only
   `Order Feedback`, regenerate/review Swagger and implement only the delivered
   rows through the existing preference flow.
3. When a real feedback notification and safe mutation data exist, verify FCM
   cold/warm/background taps, PUT and file upload/removal. Run Android first,
   then iOS/physical-device checks where platform behavior matters.
4. Refresh this context, live Git, Jira/Figma/Notion and deployed Swagger before
   resuming. Do not start another Metro process while the correct app IDE
   terminal is already serving it.
