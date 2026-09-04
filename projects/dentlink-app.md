# Dentlink Mobile App setup and current checkpoint - 2026-09-03

This is the current resume source for the first local setup of
`Innvoaid/dentlink-app`.

The current checkpoint is the final section, **Feedback Session Boundary After
Notification-Center Handoff - 2026-09-03**. Earlier PR review and notification design sections
record the preceding implementation and decisions. Earlier dated
delivery, review, API and runtime results below are historical, not current
claims. The two new notification rows now exist as disabled presentation;
their real setting integration still awaits the deployed BE contract.

## Project Role And Continuity

- Dentlink web remains the user's primary workload, while the connected mobile
  app is also an ongoing product-development scope. It is not inactive or
  optional; "secondary" describes relative task volume and priority only.
- Expect both occasional small app tasks and features whose user flow spans web
  and mobile. For cross-surface work, inspect the relevant web and app code,
  API contracts, release paths, and QA impact together.
- 통합알림센터 문의는 `projects/dentlink-unified-notification-center.md`를 읽는다.
  2026-09-03 후속 지침으로 기기 간 실시간 동기화를 제외하고 REST 기반으로
  변경했다. 읽음·삭제 동기화용 데이터 FCM은 추가하지 않으며 기존 FCM·Notifee
  사용자 푸시는 유지한다. 사용자가 별도 웹·앱 통합 관리 세션을 개설했다.
  공통 딥링크·알림센터 읽음 처리는 그 세션이 담당하고, 이 세션은 기존 피드백
  기능을 담당한다. 현재 별도 worktree 없이 같은 저장소를 참조하므로 공통 파일
  구현 전 브랜치와 작업 범위를 조율한다. 관리 세션 개설을 구현 완료로 간주하지
  않으며, 피드백 구현이나 개별 푸시 작업의 완료 상태와 섞지 않는다.
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
  must be inspected. For ordinary shared app work, use the iOS Simulator as the
  user's fast primary loop and validate Android at a sensible checkpoint before
  CodePush; start on the affected platform for platform-specific work. Keep app
  execution in the `dentlink-app` IDE window and its integrated Metro terminal
  rather than the web project's IDE.
- For remaining-task briefings, distinguish unfinished in-scope implementation
  from normal QA, approval, merge and deployment steps. The user understands
  those delivery steps and does not count them as missing development tasks.
  Do not repeatedly list a general pre-existing upload recovery improvement
  as unfinished feedback work. Defects introduced by the current changes still
  belong in scope and must not be hidden. The notification-setting BE wait is
  acknowledged; resume its actual integration when the user reports release.

## Repository

- Shared repository: `https://github.com/Innvoaid/dentlink-app`
- Active local checkout: `/Users/parkjongsun/Repository/dentlink-app`
- Repository default branch: `main`
- Active feature base and PR target: `develop`
- Current branch: `feature/DL-16061`
- Current HEAD: `c6355a33521c69ed0c3d4cb656245ac7b2ed5e9e`
- The checkout is clean and synchronized with `origin/feature/DL-16061` after
  the user explicitly authorized the merge commit/push at 14:26 KST.
  The pending local merge is complete; no `MERGE_HEAD` or staged changes remain.
- `origin/develop` is `5ec442a2a20be9dbbad9a7f8532de37e69b60a8d`;
  the feature branch now contains it and is 39 commits ahead / 0 behind.
  PR #286 is MERGEABLE. This is develop-to-feature integration only; the PR
  has not been merged into develop and no deployment was performed.
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

## DL-16061 Order Detail WebView Bridge And Review Closeout - 2026-09-01

### Delivered state

- `feature/DL-16061` is synchronized with
  `origin/feature/DL-16061` at
  `28a12947b49e058b136e602a4f53621b95931509`.
- The branch contains the current `origin/develop` and is 30 commits ahead with
  no base commits missing. PR
  [#286](https://github.com/Innvoaid/dentlink-app/pull/286) remains OPEN,
  non-Draft and MERGEABLE.
- The WebView-to-native navigation contract is the existing `NAVIGATION`
  message with `screen: "FeedbackDetailsScreen"` and
  `params: { orderId, entryPoint: "order-detail" }`. The existing
  `DentlinkWebView` handler passes these params to React Navigation, so no new
  web-to-app bridge message type was added.
- After a native detail PUT succeeds from the order-detail entry point, the
  detail screen uses the established navigation-result pattern to `popTo` the
  existing `OrderDetailScreen`. The parent consumes a one-time completion param
  on focus and reloads its WebView so the web-owned feedback banner reads the
  new server state. Cancel, back and mutation failure do not send completion or
  reload the WebView. Feedback-list, push and deep-link entry behavior is
  unchanged.
- The corresponding Clinic web action still must send the confirmed
  `NAVIGATION` message when it runs inside the app; ordinary web continues to
  open its web feedback drawer.

### Review fixes and verification

- Commit `b188e18` also closes verified CodeRabbit findings: safe-area memo
  dependency, push-preference loading guard, login-dependent device update,
  post-`RNFS.stat` upload-size validation, local WebView host matching,
  infinite-list memoization, MIME-less image analytics classification and
  feedback mutation URL boundary tests.
- Commit `f1e6c3a` preserves completed server file IDs when cleanup deletion
  fails and retries them on the next upload and hook unmount. This closes the
  remaining CodeRabbit review-body finding without changing caller contracts.
- Commit `507f2b3` records unmount and superseded upload sessions, moves files
  completed afterward into the cleanup queue, retries deletion up to three
  times and blocks post-unmount state/toast updates. Commit `28a1294` then moves
  completed-file state publication behind the current-session check so a late
  prior upload cannot pollute the new upload state.
- All prior human and CodeRabbit review threads were answered and resolved.
  The bottom safe-area general PR comment was verified against the shared
  `Layout` inset behavior and answered because general issue comments have no
  resolve control. The manual CodeRabbit review of `b188e18` completed; the
  subsequent manual reviews of `f1e6c3a` and `507f2b3` completed; the final
  `28a1294` trigger returned a successful skipped status because reviews are
  disabled for the base branch. No unresolved review thread remains.
- The generated contract has multipart completion PATCH and abort DELETE only.
  If completion succeeds server-side but its response is lost, the app cannot
  recover `fileId` from `uploadId` or safely assume PATCH replay is idempotent.
  Full recovery requires a BE idempotency guarantee or lookup endpoint; this
  limitation is documented in the PR and resolved review rationale.
- Changed-file ESLint has zero errors; Prettier and `git diff --check` pass.
  Focused feedback, deep-link, WebView URL and error-handler Jest coverage
  passes 5 suites and 46/46 tests.
- Office/Lab typecheck still reports the same ten baseline diagnostics in
  unrelated existing files. No changed file introduces a new type diagnostic.
- This closeout is code and static-test proof. The cross-repository WebView
  action plus native return reload still needs an integrated runtime pass after
  the web-side change is committed and served. Real FCM, safe POST/PUT/upload
  data, physical camera permissions, human approval, merge and deployment
  remain separate gates.

### Next starting point

1. Confirm the matching Clinic web branch commits and serves its app-only
   `NAVIGATION` action, then test order detail WebView -> native feedback detail
   -> successful Submit -> refreshed WebView banner. Also verify cancel/back
   does not reload as a completed save.
2. Continue PR #286 human review. Do not merge or deploy without the app
   developer's approval and the normal release decision.
3. When BE deploys the actual `UserPushSettingUpdateDto.pushType` values,
   regenerate and review Swagger before adding only the delivered Office
   notification rows. Do not guess the enum values.

## DL-16061 Upload Failure Isolation And Notification Design - 2026-09-03

### Delivered code and authorization

- The user explicitly authorized commit, push and Git-backed memory closeout.
  Two purpose-separated commits are pushed to `feature/DL-16061` and visible
  in PR #286 at `1ddbdcfc5ed9d16ea92eb23854078bfff662aa2d`. App checkout is
  clean. No PR body/review mutation, Jira update, base merge or deployment was
  included in this request.
- `67b4cc0` (`shared/libs/useFileUpload.ts`) consolidates failure UI in the
  outer upload catch and checks the mounted/current upload session before
  clearing file IDs or showing delayed errors. An obsolete multipart failure
  cannot overwrite a newer upload's state or emit a duplicate toast. Existing
  multipart abort and completed-file cleanup/retry remain in place.
- `1ddbdcf` (`shared/features/profile/sections/ProfileNotificationSection.tsx`)
  adds Office-only `Case Preference` and `Order Feedback` rows after LinkTalk,
  reusing the existing notification row and compact switch. Figma descriptions
  are `Set Preference for better fit cases` and
  `Rate cases for better-fit results`. Existing supported rows and Lab stay
  unchanged; no native code, dependencies or generated models changed.

### Design versus API readiness

- Figma node `160:39015` in file `Lu8GEh1TUU5hOfj2FCPRYn` was read through
  design context and its screenshot. Profile layout and Pending Reviews
  already existed; the two notification rows were absent before this change.
- Both new rows are intentionally disabled and visually off until BE mapping
  exists. Their displayed value is a UI placeholder, not a claim about actual
  server notification delivery. They send no PATCH or analytics and stay
  disabled when Enable All is used. Do not describe them as connected toggles.
- `https://dev-api.dentlink.io/v3/api-docs`, read at 2026-09-03 11:17 KST,
  still exposes eight `UserPushSettingUpdateDto.pushType` values:
  `ORDER_NEW`, `ORDER_APPROVAL`, `ORDER_PENDING`, `ORDER_TRACKING`,
  `ORDER_EXTRA_FEE`, `CHAT_ORDER`, `CHAT_DENTLINK`, `ORDER_UPDATE`.
  Neither new notification type is deployed in this contract. No enum or
  payload name was guessed and no generated file was hand-edited.
- This setting contract is separate from the already implemented FCM
  `data.deeplink` routing and `push_click` Amplitude classification. No new
  FCM field is required merely to draw or wire these preference rows.

### Verification and next start

- Changed-file ESLint, Prettier and `git diff --check` pass. Prettier reports
  existing unsupported import-order options, not formatting failures.
- Existing focused feedback/repository/deep-link/WebView/error suites pass
  46/46. A transient mocked-hook regression harness reproduced the old upload
  bug against HEAD before the fix and passed seven cases against the fix:
  stale completion failure, missing ETag, current failure, silent errors,
  unmount, prior-batch cleanup and delayed toast after a new upload.
- A transient React component harness passed six notification checks: Office
  row order/copy, inert pending rows, existing toggle API/analytics, Enable All,
  unavailable preference query, and Lab isolation. Hooks and rendering
  primitives were mocked. No new test/support files were left in the app repo.
- No emulator, simulator, real push/settings mutation or deployment QA was
  performed in this code-only closeout; do not upgrade earlier runtime proof.
- Current independently actionable confirmed FE code is complete for this
  request. After BE deployment, regenerate/review Swagger, replace the pending
  rows with actual generated-type mappings in the existing setting list, and
  connect GET `/app/users/own/push-preferences` and PATCH
  `/app/users/own/push-settings/{pushSettingId}`. Verify defaults/upsert,
  Enable All, permission/loading/error and analytics behavior at that time.
- Continue to require new explicit authorization for later app commit/push.
  Read this checkpoint and live feature Git before resuming; do not treat
  a design placeholder, code completion, review approval or deployment as
  interchangeable states.

## DL-16061 PR Refresh And Review - 2026-09-03

- The user explicitly requested app commit/push, memory closeout and PR
  refresh/review. App HEAD is now `5994f1fca27c165e891f3781bf79fe5952b353b7`
  on `feature/DL-16061`, equal to its upstream and clean. The session started
  clean at `1ddbdcf`; new code was added only after validating the follow-up
  CodeRabbit findings below.
- PR #286 remains OPEN/non-Draft. Its body now records the latest HEAD,
  obsolete upload-session failure fix, disabled notification design, accurate
  validation counts and the boundary between UI placeholders and connected
  server preferences. The previous mergeable/current-develop claim was removed.
- Fetched `origin/develop` is `5ec442a2a20be9dbbad9a7f8532de37e69b60a8d`.
  Feature history is 34 commits ahead and 3 behind. A non-mutating
  `git merge-tree --write-tree HEAD origin/develop` confirmed conflicts in
  `shared/configs/i18n/locales/en.ts`, `shared/configs/i18n/textRegistry.ts`
  and `shared/configs/utils/dentlinkWebURL.ts`. GitHub also reports
  CONFLICTING/DIRTY. No develop merge or conflict edit was performed; do not
  describe the PR as merge-ready. GitHub's PR base SHA was stale compared to
  the separately fetched live branch ref.
- The old outside-diff review `5076958062` is addressed by `67b4cc0`.
  General review bodies have no resolve button; implementation evidence and
  the manual review request are in
  https://github.com/Innvoaid/dentlink-app/pull/286#issuecomment-5519414222.
  CodeRabbit's initial conversational response at
  https://github.com/Innvoaid/dentlink-app/pull/286#issuecomment-5519420314
  found no new blocker, but its separate incremental review completed at
  11:35:46 KST with two outside-diff findings in review `5097191737`.
- Commit `2f76e04` (`fix: 업로드 중단 실패 정리 재시도 보완`) changes only
  `shared/libs/useFileUpload.ts`: upload-start cleanup now explicitly allows
  three attempts; failed multipart aborts retain `uploadId` in a separate Set.
  The existing bounded cleanup loop removes only successful IDs and retries
  aborts and completed-file deletions at failure, next upload and unmount.
  File IDs and upload IDs remain distinct; no endpoint, native dependency,
  persistence layer or caller interface changed.
- Both new findings are addressed with evidence in
  https://github.com/Innvoaid/dentlink-app/pull/286#issuecomment-5519513624.
  CodeRabbit explicitly verified both fixes and found no new blocker in
  https://github.com/Innvoaid/dentlink-app/pull/286#issuecomment-5519521124.
  The subsequent formal review of `2f76e04` completed at 11:47:48 KST and
  raised two new inline findings in review `5097250295`. Conversational bot
  reassurance is not equivalent to the final formal review/check outcome.
- Commit `5994f1f` (`fix: multipart 전송 종료 후 중단 처리`) fixes the second
  finding: `runWithConcurrency` waits for all workers to settle after any
  worker rejection, then throws the original error. Abort cannot race the
  remaining part PUT requests or temporary-file cleanup. Reply evidence is
  https://github.com/Innvoaid/dentlink-app/pull/286#discussion_r3920594072;
  thread `PRRT_kwDOLCkD486ewYJE` is resolved.
- One valid review limitation remains OPEN: thread
  `PRRT_kwDOLCkD486ewYJC`,
  https://github.com/Innvoaid/dentlink-app/pull/286#discussion_r3920574073.
  Hook-local IDs cannot survive all cleanup retries failing and the hook
  disappearing. An account/employer/environment-scoped app-wide or persistent
  queue would address known-ID recovery but expands the shared upload state
  architecture and requires a scope decision. Do not falsely resolve this as
  fixed or conflate it with the separate lost-completion-response BE gap.
  The explicit deferral explanation is comment `3920589577`. Of 16 total
  inline review threads, 15 are resolved and this one is unresolved.
- The review cycle pauses for that scope decision. Auto-review on this base
  branch is disabled; `5994f1f` has local validation but no completed formal
  follow-up run. After the decision, handle the queue finding if authorized,
  request a standalone `@coderabbitai review`, and verify the run plus all
  threads. A mixed prose/comment command was treated as chat once; a standalone
  command reliably triggered the formal incremental review.
- Rerun checks: existing focused Jest suites 46/46, changed-file ESLint,
  Prettier and `git diff --check` pass. In-memory TypeScript comparison of
  current code against `28a1294` versions of the two changed files produced
  Office 11 baseline/current errors and Lab 11 baseline/current errors, with
  zero new diagnostics. No reset, stash, source replacement or generated
  model edits were used. This supersedes the older ten-error environment
  snapshot; whole-project typecheck is not passing.
- An additional transient actual-hook/React-renderer regression harness
  passed eight cases with mocked APIs/native modules: normal success, bounded
  abort retries and one toast, retry next upload, completed-file retry next
  upload, independent abort/file IDs, queued cleanup on unmount, old-session
  failure after new success, and late failure after unmount. No persistent
  test/helper files were added. These are code-level checks, not real upload QA.
- The next transient hook harness reproduced the abort/active-PUT race on
  `2f76e04` and passed three cases on `5994f1f`: second worker succeeds, second
  worker fails, and both workers succeed normally. Abort waits until the other
  PUT and part-file cleanup settle; normal completed fileId behavior remains.
  Focused Jest 46/46, lint/format/diff and the Office/Lab baseline comparison
  were rerun after this last edit with the same passing/no-new-error outcome.
- The existing upload cleanup queue is hook-local and best effort with bounded
  deletion retries. It does not guarantee durable cleanup after all retries
  fail and the hook is gone. Lost multipart completion-response recovery also
  remains outside the available BE lookup/idempotency contract; no new endpoint
  or persistence architecture was invented to satisfy an old resolved review.
- No new emulator/simulator, FCM, API-mutation, merge or deployment proof was
  added. Next: ask whether to expand to the account-scoped shared cleanup queue;
  separately obtain authority for develop conflict integration/revalidation.
  Human review and later notification API wiring after actual BE enum release
  are still separate. This is a saved breakpoint, not review-zero or merge-ready.

## DL-16061 Account-Scoped Cleanup Review - 2026-09-03

- User requested work on the outstanding review after the preceding scope
  question. The app-wide cleanup queue finding is now in scope; develop
  integration/merge is not included. App `feature/DL-16061` is pushed and clean
  at `919a884557f7d421a946b12adfc337b497ca048f`.
- `80c1cb5` moves known failed file deletion and multipart-abort IDs from hook
  refs to `useCommonStore.pendingFileCleanups`, deduplicated by kind/id/scope.
  API URL, user, employee, employer and service identify each scope. No token,
  file content or presigned URL is retained in the queue.
- Existing hooks process that common queue on mount, next upload, error,
  unmount, authenticated-state restoration and AppState foreground. Up to
  three attempts occur per run; concurrent hooks share a per-scope run.
  Logout and other-account contexts leave the original queue untouched; the
  matching account can resume it without relying on the old hook instance.
- Chosen implementation is app-wide in-memory state, one of the original
  review's alternatives. It survives screen unmount/remount, not complete app
  process termination. No new native dependency, storage engine, API, generated
  model or helper/test file was added. Dedicated network-reconnect detection is
  not installed; the next listed resume event handles recovery.
- `ScopedRequestConfig` flows through existing file services and queries.
  The request interceptor rejects stale-context requests before using auth
  headers. Guarded uploads cannot apply another account's refresh results;
  cleanup errors skip global logout/refresh side effects and remain queued.
  Requests without the options preserve their existing behavior. This guard is
  necessary because merely filtering the queue before Axios dispatch would
  still permit a later login switch to change the request's credentials.
- Changed files: `shared/libs/useFileUpload.ts`,
  `shared/store/useCommonStore.ts`, `shared/services/file.types.ts`,
  `shared/services/file.service.ts`, `shared/queries/useFileQueries.ts`,
  `shared/configs/utils/fetcher.ts`, and
  `apps/office/src/features/feedback/screens/FeedbackDetailsScreen.tsx`.
- Validation: existing Jest 5 suites / 46 tests pass. A transient source-level
  harness initially passed 17 checks, including one baseline remount-loss
  reproduction and 16 checks for the fix: remount, duplicate entries/hooks,
  account/user/employee/employer/service/environment isolation, logout/relogin, foreground,
  guarded dispatch, cleanup 401/403, in-flight old-account errors, query/service
  forwarding, old refresh success/failure, normal and guarded refresh behavior,
  silent errors and old-upload/new-upload state isolation. It used actual
  React, Zustand, Axios and interceptors but mocked native modules and network
  transport; no real API mutation or simulator proof is claimed.
- Six-file ESLint has zero errors and one pre-existing unused generated-type
  import warning. Prettier and diff checks pass. Office/Lab each have 11
  pre-existing TypeScript diagnostics and zero new errors, compared against
  the six HEAD (`5994f1f`) file versions via an in-memory compiler host.
- Follow-up review `5097388237` on `80c1cb5` completed at 12:15 KST with no
  new blocking threads and two nitpicks. Both were verified against the actual
  source before fixing them in `2f4d6b7`: queue removal uses scope/kind/id value
  matching, and previous cleanup runs in the background rather than delaying
  new upload initiation. Scope/session checks and retry behavior are preserved.
  The transient harness now passes 19/19 including preservation of other queue
  entries and a new upload completing while the prior cleanup response is held.
  Related Jest still passes 46/46; the follow-up two files pass lint/format/diff,
  and Office/Lab again have 11 baseline diagnostics and zero additions against
  `80c1cb5`. No shared test/helper files or real-network mutations were added.
- The next review `5097447018` on `2f4d6b7` completed at 12:26 KST with two
  outside-diff findings. `b30e4a8` addresses them: local filesystem paths always
  refresh actual file size before max-size/presign/part-range calculation;
  FeedbackDetailsScreen also refreshes those sizes before aggregate validation
  and does not silently trust stale size on stat failure. Non-finite, zero and
  negative filesystem sizes fail before presign.
- Android `content://` provider URIs intentionally retain valid picker sizes.
  `useDeviceSystem` passes document URIs directly, while the installed RNFS
  Android stat implementation requires an accessible `_data`/File path. A
  blanket RNFS.stat requirement would regress existing document uploads.
  No speculative copy-to-local flow or new native dependency was introduced.
- Active BlobUtil tasks are tracked and canceled on hook unmount. Session
  guards prevent further PUT or completion when stat/presign/part preparation
  resolves after unmount; existing wait-all-workers logic includes temporary
  part cleanup and precedes abort. A completion PATCH already in flight cannot be
  recalled; its returned fileId enters cleanup as before, and lost completion
  response recovery still requires the known BE contract.
- Final transient harness passes 32/32: the previous 19 plus refreshed/stale/
  invalid sizes, content-provider preservation, presign and part byte ranges,
  unmount during active parts/stat/presign/part preparation/in-flight completion,
  and the actual feedback size resolver's aggregate/unreadable behavior.
  All transport/native operations remain mocked. Jest passes 46/46; the latest
  two-file lint/format/diff checks pass and Office/Lab still have 11 existing
  diagnostics with zero additions against `2f4d6b7`.
- Review `5097495166` on `b30e4a8` completed at 12:37 KST and identified a
  further minor outside-diff race: a newly queued ID could miss the last
  snapshot of the active cleanup run and wait until another lifecycle trigger.
  `919a884` records attempted entries with each shared run. Waiters exclude
  those entries and process only newly pending entries in a separate bounded
  run, preserving per-scope sharing and no recursive retry expansion.
  Regression validation reproduces the old behavior and verifies old ID = 3
  requests, new ID = 3 requests, including multiple waiting hook instances.
  The harness now passes 34/34, Jest 46/46, latest hook lint/format/diff pass,
  and Office/Lab have zero new diagnostics against `b30e4a8` (11 each).
- Final combined validation reran all seven changed files against the starting
  `5994f1f` versions in memory: Office/Lab 11 baseline and 11 current, zero new
  diagnostics. Seven-file ESLint has zero errors and the same pre-existing
  OrderFileUploadDto warning; Prettier and full commit-range diff checks pass.
  PR verification was consolidated to these latest results instead of a stack
  of intermediate counts. No native build or device QA was added.
- Existing review thread `PRRT_kwDOLCkD486ewYJC` was answered and resolved in
  https://github.com/Innvoaid/dentlink-app/pull/286#discussion_r3920674976.
  PR body is updated to the new code and explicit process-lifetime boundary.
  Follow-up body nitpicks were answered in comment `5519824568` and the two
  outside-diff findings in `5519935908` and `5519992149`. A fourth standalone
  manual review was requested in comment `5519992257` and completed on
  `919a884` at 12:44:53 KST. Comment `5519993334` confirms Review finished;
  the latest summary in `5393229878` explicitly says no actionable comments
  and names the reviewed range `b30e4a8..919a884`. All 16 review threads are
  resolved, with no pagination beyond the inspected set. There is no new
  formal review object for this zero-finding run, so the completion evidence
  is the exact-HEAD status plus the updated recent-review summary.
- Develop remains three commits ahead of the feature base with the same three
  known integration conflicts, reconfirmed with non-mutating merge-tree on
  the final HEAD. No merge, deployment, Jira/design change or fresh Android/iOS
  run was performed for this review task.
- Breakpoint: current requested CodeRabbit work is handled and pushed in four
  commits (`80c1cb5`, `2f4d6b7`, `b30e4a8`, `919a884`). PR #286 remains OPEN,
  non-Draft and CONFLICTING; app-developer approval is not inferred from bot
  completion. Next obtain explicit authority if develop conflict integration
  is requested, or refresh the real BE pushType contract when it is released.
  Runtime/real mutation QA and unknown multipart completion-response recovery
  remain separate from the completed code review scope.

## DL-16061 Local Develop Conflict Resolution - 2026-09-03

- The user's next request was to handle the remaining conflict files.
  Refreshed both repositories and confirmed the app began clean on `919a884`
  with `origin/develop` at `5ec442a`. No PR merge or develop branch mutation
  was performed. `git merge --no-commit --no-ff origin/develop` is in progress
  locally; there is no new app commit or push.
- Resolved all three conflicts: `shared/configs/i18n/locales/en.ts`,
  `shared/configs/i18n/textRegistry.ts`, and
  `shared/configs/utils/dentlinkWebURL.ts`. The first two now exactly match
  develop's generated output, including the new disabled-order interpolation
  and existing 200MB text. No sheet sync or speculative regeneration ran.
- Preserved develop's new local host allowlist entry and native order
  restriction/popup behavior, alongside feedback routes and the order-detail
  completion-result reload. The new order-navigation interceptor only handles
  `OrderScreen`, so `FeedbackDetailsScreen` still follows the existing bridge.
- Detected one integration regression in the automatic result: develop sets
  both Office/Lab development WebViews to `http://10.10.7.44:3000`, failing
  two existing environment tests. Kept this branch's established remote dev
  portal/lab URLs instead. Staging/production URLs and exact-host/protocol
  safeguards are unchanged. Develop's Reactotron debug-host changes were
  retained; no new local host strategy was invented.
- Validation: nine existing Jest suites, 67/67 tests pass. Transient
  source-level checks cover order restrictions versus feedback navigation,
  cancel versus successful Submit reload, en/ko registry resolution, 200MB
  preservation, and local-host/protocol routing (11 assertions). Native modules
  were not executed; no real API mutations, Metro, emulator, simulator or
  native build was started for this conflict-only task.
- ESLint over all 16 incoming JS/TS files: zero errors and four warnings,
  identical to develop. Office/Lab TypeScript each remain at 11 diagnostics,
  zero additions versus pre-merge HEAD via in-memory compiler-host overrides.
  URL/order-detail formatting and both diff checks pass. The two generated
  translation files fail Prettier both before and after; their canonical
  generated formatting was preserved, not mass-reformatted.
- Breakpoint at 13:02 KST: 17 staged merge files, no unmerged index entries,
  no unstaged changes, `MERGE_HEAD=5ec442a2a20be9dbbad9a7f8532de37e69b60a8d`.
  The work is local only; another device does not have these code changes.
  PR #286 and Jira were not updated, and the remote conflict indication cannot
  clear until the user authorizes the merge commit/push. Next inspect this
  index, obtain app commit/push authorization, then refresh the PR review state.
- Follow-up final recheck at 13:05 KST: origin refs are unchanged and all 16
  PR review threads remain resolved (no pagination); remote CodeRabbit is
  SUCCESS for `919a884`, not for the uncommitted merge. No additional feature
  defect or code edit was identified in this pass. The merge index is unchanged.
- Expanded unit coverage passes 15 suites / 125 tests with
  `yarn test --config jest.config.js --runInBand --watch=false
  --testPathIgnorePatterns '/e2e/' '__tests__/App.test.tsx'`.
  The unfiltered command reports 6 failing suites / 22 failing tests, all from
  known pre-existing test-runner boundaries: five Detox suites require their
  own worker, and the old App smoke test imports nonexistent root `../App`,
  which resolves to the app.json metadata object on this case-insensitive Mac.
  Those tests/config and root app.json are unchanged from HEAD; these are not
  new merge failures. No Detox device launch succeeded or device QA is claimed.
- Version validation passes: Office 2.2.3 and Lab 1.0.3 agree across app
  package.json, Android and Xcode. Both diff checks pass. Generated translation
  output and incoming order/popup/scanner files were also confirmed identical
  to develop; only the intentional URL default preservation and feature bridge
  integration differ where expected. No further app commit/push authority was
  inferred from the user's general request to finish all possible work.

## DL-16061 Develop Merge Delivery And Review - 2026-09-03

- The user explicitly requested commit, push, memory closeout, and handling
  subsequent review. Committed the reviewed 17-file merge index as `c6355a3`
  (`chore: develop 병합 및 피드백 충돌 정리`) and pushed to
  `origin/feature/DL-16061`. Parents are `919a884` and `5ec442a`; no force push,
  protected-branch update, PR merge, deployment or native build was performed.
- GitHub reports PR #286 MERGEABLE. All three previous integration conflicts
  are resolved remotely; the branch is clean with 39 ahead / 0 behind develop.
  PR description now explains the integration, intentionally preserved remote
  development WebView URLs, current validation and remaining QA boundaries.
- Re-ran the expanded unit test command after commit: 15 suites / 125 tests
  pass. The earlier 16-file lint, baseline TypeScript, version, generated-format
  and diff results remain applicable to the identical committed tree. The
  known unfiltered Jest/Detox/App smoke-test configuration failures remain
  separate and were not hidden or fixed by unrelated source changes.
- Automatic review returned SUCCESS with `Review skipped` because this PR
  targets develop rather than the configured release/default branches.
  Requested a real incremental review in comment `5520959146`; CodeRabbit
  acknowledged it in `5520962101` and exact-HEAD status became pending at
  14:27:47 KST. Do not mistake the initial skipped status or earlier `919a884`
  zero-finding summary for review of this merge.
- Exact-HEAD CodeRabbit status changed to `Review completed` / SUCCESS at
  14:31:29 KST. The recent-review summary in comment `5393229878` explicitly
  names `919a884..c6355a3`, selects dentlinkWebURL and OrderDetailScreen, and
  reports no actionable comments (run `de96be6d-0ddd-4b9a-a527-d987ad8f8ca9`).
  No new formal review object was created for this zero-finding run; the status
  and exact-range summary are the completion evidence.
- Final GraphQL inspection confirms all 16 review threads resolved and no
  next page. No review correction or second app commit was needed. PR body was
  updated again with the 14:32 KST review result and actual proof boundaries.
- Final breakpoint: app `c6355a3` is pushed, clean and MERGEABLE, with zero
  unresolved review threads and 125 passing unit tests. No local merge work is
  stranded, so another device can resume by pulling the feature branch and
  this context. Do not interpret this as app-developer approval, PR merge,
  deployment or new Android/iOS/real-API QA. Existing BE notification pushType
  integration and unknown multipart completion-response recovery stay at the
  previously documented external contract boundaries.

## DL-16061 Whole-Project Status Recheck - 2026-09-03

- Read-only briefing recheck at 14:35-14:41 KST reconfirmed app `c6355a3`
  clean and pushed, develop `5ec442a` included, and PR #286 OPEN/non-Draft,
  MERGEABLE/CLEAN with successful checks and all 16 review threads resolved.
  Human approval, PR merge and deployment have not been inferred.
- Live development Swagger returned HTTP 200 at 14:35 KST. Its
  `UserPushSettingUpdateDto.pushType` still has the nine existing order/chat
  values, with no Case Preference or Order Feedback values. Both Office
  settings rows already have disabled UI; their actual GET/POST/PATCH state,
  enable-all behavior and interaction events await the real backend contract.
- Found the dedicated BE dependency: DL-16285, assigned to Leo, is In Progress
  (updated 2026-09-03 10:42 KST). Its description covers user control of C.P.
  and feedback request pushes and specifically mentions C.P. template 127.
  Recheck this card and deployed Swagger together before implementing the
  remaining settings connection; do not guess enum spelling from UI labels.
- Live Jira: DL-16061, DL-16066 and DL-16229 remain Ready for Deploy;
  DL-16064 is Done. DL-16061's description still says Draft/Share Feedback and
  14 tests; DL-16066 still names the older `/my/feedback` URL. These are stale
  descriptions, not the latest code contract. No Jira edit was made in this
  reporting-only turn; description refresh remains documentation work.
- Swagger still exposes DELETE/PATCH but no GET for employee/user multipart
  upload IDs. Unknown-fileId recovery after a lost successful completion
  response remains the prior BE contract boundary, not an ordinary upload
  implementation gap. Known cleanup IDs are retained in process memory.
- This briefing refreshed Git/PR/Jira/Swagger and relevant source code. It did
  not repeat all Figma/FigJam/Notion design review or Android/iOS runtime QA.
  Today's 125 passing unit tests and baseline diagnostics belong to the same
  committed tree; historical visual proof must not be presented as a new
  runtime test of the upload fixes or develop integration.

## DL-16061 Jira And Task-Scope Closeout - 2026-09-03

- The user clarified that the remaining-task list should contain concrete
  feature implementation only. BE notification-setting release is already
  acknowledged and the user will announce availability. Ordinary QA/review/
  release steps and general shared-upload response-loss recovery are not
  unfinished feedback tasks. A regression caused by this change remains in
  scope; this clarification does not waive real defects or validation honesty.
- Refreshed personal context and the exact app checkout. App remains clean
  and synchronized at `c6355a3`, containing develop `5ec442a` (0 behind / 39
  ahead). There was no code change or additional app commit/push to perform.
- With explicit authorization, updated DL-16061 and DL-16066 descriptions at
  14:51 KST: Pending Reviews wording, native/WebView ownership and successful
  Submit return, current employer-scoped routes, actual analytics mapping,
  pushed/reviewed status, 125-test evidence and historical runtime boundaries.
  Preserved unrelated model-drift context and linked BE follow-up DL-16285.
- Preserved historical comments and added current corrections: DL-16061
  comment `43884`, DL-16066 `43885`, and DL-16229 `43886`. The analytics comment
  explicitly supersedes old my/feedback, uncommitted/payload-wait/conflict
  wording. Kept the original analytics Notion description and web session's
  historical completion record; did not claim a fresh web-code review.
- Readback confirmed both updated descriptions and all three comments.
  DL-16061, DL-16066 and DL-16229 remain Ready for Deploy; no transition,
  assignee or unrelated-card mutation was made. Jira-description cleanup is
  now complete, superseding the preceding status-only checkpoint.
- PR #286 is still OPEN/non-Draft, MERGEABLE/CLEAN, checks successful; all 16
  threads are resolved with no next page. No new PR review correction or PR
  mutation was necessary. No fresh test/device run was performed for this
  documentation-only closeout; earlier same-tree evidence remains labeled.
- Next development starting point: after the user announces the BE setting
  release, refresh DL-16285 and deployed Swagger, regenerate/diff the model
  through the official command, then connect only the actual new pushType
  rows to existing settings read/write/enable-all behavior. Until then there
  is no identified immediately actionable unfinished feedback implementation.

## Feedback Session Boundary After Notification-Center Handoff - 2026-09-03

- The user created a separate unified-notification-center session and asked
  for a copyable context handoff. That session owns the new common deep-link
  hospital/screen/read-receipt work; this session continues the existing
  DL-15828/DL-16061 feedback scope only. The shared routing files can overlap,
  so neither session should silently switch the shared checkout or mix new
  notification-center work into the feedback branch.
- Read-only investigation found existing employerId-to-employeeId mapping,
  FCM/Notifee/Linking/Airbridge and deferred navigation. Common notification
  read handling is not implemented. A proposed URL notificationId must be the
  REST NotificationDto.id, not orderId or a transport/OS ID. Different create/
  update notifications landing on the same route need distinct IDs; preserve
  navigation dedup separately from notification read identity.
- Development Swagger was inspected at 15:09 KST: existing authenticated
  PATCH /messages/notifications/read/partial accepts unreadNotificationIds.
  Employee-Id/Employer-Id context must match the target authorized membership.
  Query-name/payload mapping, already-read semantics and read-on-navigation-
  failure policy are not confirmed BE contracts. No new read API or payload
  field was implemented here. REST-only/no cross-device realtime scope stands.
- Feedback branch still clean at `c6355a3`. A user-supplied development
  CodePush log failed at CLI asset validation for the existing 1,549,611-byte
  ISV video, unchanged from develop. Installed CLI 0.0.15 supports --force to
  bypass its 500 KiB check; the scripts' --mandatory is unrelated. Explained
  per-platform --force commands, but did not edit scripts/video or execute a
  release. A subsequent successful user deployment has not been verified.
- This handoff does not authorize implementation, branch creation, commits,
  pushes, PR changes or deployment in the destination session beyond its own
  current user instructions. No product code/Jira mutation was made here.

## DL-16061 CodePush Script Develop Sync - 2026-09-03

- The user explicitly requested merging develop, committing and pushing.
  Refreshed origin refs and merged `aa82c4c` into `feature/DL-16061` without
  conflicts. Merge commit `364030e76b2ca16200af576d33e4556aca17bc8b`
  (`chore: develop CodePush 강제 배포 옵션 병합`) is pushed; its parents are
  `c6355a3` and `aa82c4c`. Worktree is clean, upstream divergence is 0/0,
  and fetched develop is fully included (0 behind / 40 ahead).
- Only package.json changed: 20 CodePush scripts now include --force on each
  relevant iOS/Android release command, across development/staging/production.
  It bypasses the CLI's 500 KiB asset guard, not the feedback attachment
  policy. Existing targets, mandatory/disabled flags, dependencies, native
  files and feedback source remain unchanged. No release command was run.
- Verified that all changes are exactly --force additions, all 20 commands
  pass shell syntax-only checks, package.json passes Prettier, and the staged
  diff passes whitespace checks. Prettier emitted only the existing ignored
  import-order-option warnings. No full app tests or device QA were repeated
  for this scripts-only merge, and no new CodeRabbit review is claimed.
- The existing PR receives the pushed branch commit automatically. No PR
  description, Jira state or unrelated notification-center code was changed.
  Remaining feedback feature boundary is unchanged: connect the disabled
  notification settings after the user announces the actual BE pushType release.

## DL-16061 Notification Settings API Delivery - 2026-09-03

- Supersedes the preceding disabled-placeholder / BE-wait checkpoints. The
  user announced the two deployed types and explicitly authorized code,
  commit, push and memory closeout. Development Swagger was checked at
  18:21 KST and the official generation repeated at 18:25-18:28 KST.
  `UserPushSettingUpdateDto.pushType` and `PushSettingListDto.type` now expose
  `USER_CASE_PREFERENCE` and `ORDER_FEEDBACK`. `ORDER_WORKFLOW` is additional
  older model drift, not a third new feedback UI row.
- Confirmed existing contracts: GET/POST `/app/users/own/push-preferences`,
  individual PATCH `/app/users/own/push-settings/{pushSettingId}` with
  `pushType` and `pushEnable`. The similarly named PATCH with `preferenceId`
  controls overall/personal-order settings, not an individual row.
- Office now has functional Case Preference and Order Feedback switches
  using the existing service/query/UI components. Figma `160:39015` copy,
  order and compact switches are preserved; the Lab four-row list is unchanged.
  Missing new Office settings use the existing POST initialization and a
  fresh GET before using the returned setting IDs. Existing disabled settings
  are not deliberately enabled by an individual toggle.
- POST documentation distinguishes adding missing types (new entries true)
  from an already complete set (all entries true). Enable All therefore
  refetches after POST and PATCHes any remaining false entries. Failed or
  partial writes refetch server state and show one existing error toast;
  optimistic state is cleared and retry remains possible. Local save guards,
  shared upsert pending state and provider initialization guard prevent the
  tested duplicate-tap / permission-plus-missing-types initialization paths.
  Follow-up actions check the original account/employer/employee/service scope.
- Both rows emit the existing `push_preference_click` with on/off status.
  Order Feedback reuses `pushType: "Order Feedback"`. Notion lacked a Case
  Preference property value; the user explicitly approved adding
  `pushType: "Case Preference"` in the async clarification on this turn.
  This does not change `push_click`, employer-scoped feedback URLs, WebView
  bridge, or unified-notification-center/read handling owned by another task.
- `yarn swagger-typescript-api-dev` was run against a temporary output and
  then the official target; both Api.ts files match byte-for-byte. Full
  generated output is committed, never manually edited or partially selected.
  Incidental generated changes include Admin feedback detail/list contracts,
  reviewer metadata, system feedback-notification methods/categories, finance
  manual exchange DTO/method, and comments. No existing field removal or
  `hasPhoto` change was found, and no new handwritten Admin consumer was added.
- Delivered two commits on `feature/DL-16061`: `1c56bc6` (generated Swagger
  models) and `a301e78e4ccc4e2d750623c70dbff9435acaa74b` (five handwritten
  files: enum.ts, pushPreference.ts, PermissionProvider.tsx,
  useProfileNotification.ts, ProfileNotificationSection.tsx). Push/readback
  succeeded at 18:42 KST; worktree clean, upstream 0/0. PR #286 is OPEN,
  non-Draft, MERGEABLE and points at a301e78. No new CodeRabbit review is
  claimed; no PR body, Jira, deployment script or native dependency changed.
- Verification on the final code: 15 Jest suites / 125 tests pass with
  existing Detox and legacy App smoke exclusions; five-file ESLint/Prettier
  and diff whitespace checks pass. Temporary, uncommitted mock-transport
  verification passes 23/23 cases including both switches on/off, analytics,
  fresh IDs, Enable All, denied OS permission, account change, partial errors,
  duplicate taps, initialization overlap, UI rows and endpoint shapes.
  Office and Lab type checks each retain exactly the baseline 11 diagnostics;
  no new diagnostic remains. Existing ignored Prettier options and deprecated
  react-test-renderer warnings are unchanged tooling boundaries.
- No authenticated setting writes, emulator/simulator/device visual QA,
  native build, Metro start or CodePush release was performed for this delta.
  The user's earlier CodePush predates these two commits; testing this new
  behavior on that installed deployment requires a later explicitly authorized
  deployment. Do not label historic visual checks as proof of this change.
- Remote develop now contains ancestry-only merge `967ba71b` (#294); the
  incoming three-dot file diff is empty. It was fetched, not merged here.
  Do not claim current develop ancestry is fully contained based on the older
  aa82c4c checkpoint. No further known feedback implementation is blocked by
  these two push types; resume with live Git and fresh external changes.
- Sources: https://dev-api.dentlink.io/v3/api-docs; Jira DL-16285 and DL-16229
  (both read as Ready for Deploy); Figma Lu8GEh1TUU5hOfj2FCPRYn node
  160:39015; analytics Notion 3c6ce072e82f8001bc20ef404c74059b,
  pushType 21ece072e82f808ba1cff20e603f89fe and push_preference_click
  21ece072e82f80ba925ccd44cb43a747; explicit Case Preference user approval.

## DL-16061 WebView Deployment Follow-up - 2026-09-03

- The user observed Order Details remaining above Feedback Details with no
  native navigation. App and web source inspection confirmed the existing
  NAVIGATION / FeedbackDetailsScreen / orderId / entryPoint=order-detail
  contract; no app code was changed during this investigation.
- The user subsequently identified that the development web server did not
  contain the feature code and reported that web redeployment was underway.
  Treat this as the user-confirmed cause, not a newly verified app defect or
  proof that redeployment/integrated runtime testing has completed.
- App source remains clean and pushed at a301e78, with the new notification
  settings already delivered. No additional app-code task is currently
  identified from this report. After the web deployment, check actual native
  transition and close/Submit return only if requested; investigate the app
  bridge if a correctly emitted message still fails to navigate. CodePush
  and remotely hosted WebView web deployment are separate artifacts.

## Personal Local App Development Loop - 2026-09-04

- Canonical reusable checklist:
  `projects/dentlink-app-local-development.md`. Treat it as an executable
  personal-memory playbook: the user may follow it manually, or Codex may run
  the same sequence when asked. It is not product code and grants no commit,
  push or deployment authority.
- Master personalized workflow:
  `projects/dentlink-app-development-guideline.md`. It defines the normal
  iOS-first local loop, Android checkpoint, explicit Development CodePush gate,
  physical-device options and stage-by-stage briefing. This supersedes the old
  blanket Android-first personal default; historical task-specific Android-
  first QA records remain historical evidence rather than a current rule.
- The user will now develop the mobile app regularly rather than only observe
  app-developer work. Keep the team's package scripts as the canonical launch
  commands, while preparing a repeatable personal workspace around them.
- When the user asks to start local iOS Office development, prepare the exact
  `dentlink-app` IDE window, its integrated terminal, the iOS Simulator, Metro,
  and Reactotron as one working set. Verify the live branch/worktree first,
  then use `yarn ios-office:dev` from that IDE terminal and confirm both the
  rendered app and Reactotron connection/log traffic. Use the corresponding
  Lab command only when the task is explicitly Lab.
- When the user asks for local Android Office development, use the same pattern
  with the Android emulator and `yarn android-office:dev`. After the emulator
  is connected, apply `adb reverse tcp:9090 tcp:9090` before app load/reload;
  repeat it after an emulator reboot or reconnect. Confirm Reactotron shows an
  Android connection and Timeline traffic rather than assuming success from a
  completed build alone.
- Reactotron is part of the normal local debugging workspace because it covers
  API/network timeline, AsyncStorage and application logs. React Native
  DevTools, the device screen and native IDE logs remain complementary rather
  than interchangeable. Reactotron configuration is imported only in
  `__DEV__`; a CodePush/release bundle is not evidence of a Reactotron-capable
  local session.
- Local debug uses the source from the currently checked-out Git branch through
  Metro. The `dev`, `staging` and `production` suffixes select API/environment,
  scheme/flavor and app configuration; they do not select a Git branch.
  `codepush-force-*:dev` is a remote Development deployment command, not a
  substitute for `ios-*:dev` or `android-*:dev` local execution.
- Start Metro only in the integrated terminal of the IDE opened for the exact
  project. If that IDE has not been prepared, ask the user before starting it
  elsewhere. Prefer the team's working command path; the current repository's
  `yarn start` has a known obsolete debugger flag, while `yarn metro-log`
  starts Metro when it must be run separately.
- Live proof on 2026-09-04: the already installed Office Android development
  app was attached to Metro in the `dentlink-app` Cursor terminal, reloaded,
  and Reactotron displayed one Android 16/API 36 connection plus AsyncStorage
  Timeline traffic. The required host split is Android `localhost` through
  ADB reverse and iOS the current Mac LAN address.
- Current app checkout is clean and synchronized at `a301e78` after the user
  explicitly requested discarding all local changes on 2026-09-04. The
  temporary Office Reactotron platform/IP split and the unrelated Android
  Studio `android/gradle.properties` parallel-tooling change were both removed,
  restoring the tracked files to HEAD. The personal rule remains: temporarily
  set each developer's own Reactotron IP only while needed and never publish
  that local edit; do not propose a shared environment-variable refactor unless
  the team later requests one.
- Live workflow review on 2026-09-04 confirmed the package scripts use Debug by
  default and separate `*-release` commands. Office Development CodePush has
  combined, iOS-only and Android-only commands; choose the narrowest target.
  Revopush `release-react` defaults `--development` to false, so CodePush is not
  a Reactotron/`__DEV__` debugging path. The committed Podfile still excludes
  arm64 for Simulator, and MLImage's arm64 slice is device-only while x86_64 is
  the Simulator slice. Reuse the installed iOS Development proof app with Metro
  for ordinary JS work; do not present `yarn ios-office:dev` as a proven clean
  Apple Silicon rebuild until that native constraint is resolved. The iPhone
  17 Pro simulator currently contains the arm64
  `com.innovaid.dentlink.development` proof app, verified directly in its
  simulator container on 2026-09-04.
- Read-only Chrome inspection of Revopush at 16:08 KST confirmed separate
  `Dentlink-Office-iOS` and `Dentlink-Office-Android` applications, each with
  Development, Staging and Production deployments. Both Office Development
  deployments showed last release `v124`; no site setting, release, key or
  deployment was changed. The dashboard displayed a Free-plan production-use
  warning, which is an account/production continuity concern rather than a
  blocker for defining the user's Development workflow.

## DL-16061 Feature-Branch Development CodePush Readiness - 2026-09-04

- Live Git was refreshed before the assessment. `feature/DL-16061` is clean and
  synchronized with `origin/feature/DL-16061` at
  `a301e78e4ccc4e2d750623c70dbff9435acaa74b`. PR #286 remains OPEN,
  non-Draft, MERGEABLE/CLEAN; human approval and merge remain separate gates.
- Compared with current `origin/develop` `967ba71b`, the branch reports 42
  commits ahead and one behind. The single develop-only commit is the
  `Release/office/v2.2.3 -> main (#294)` merge. Both of its parents are already
  ancestors of the feature branch and every file changed by that merge has
  identical content on the feature branch, so there is no missing develop code
  that blocks feature-branch QA.
- The PR comparison contains 54 files with 5,514 additions and 376 deletions.
  It includes the complete confirmed feedback FE scope plus shared upload,
  profile notification, permission, navigation/deep-link, API and generated
  model changes. It contains no iOS/Android native file, dependency lockfile,
  Office version or environment-file change. The shared `useFileUpload` delta
  can affect existing Office chat/order/profile/design-confirmation upload
  flows, so those are side-effect QA surfaces even though no known code defect
  or incomplete confirmed FE requirement remains.
- Current Office version is `2.2.3`; `.env` matches the Office Development
  environment. Read-only release-bundle verification produced both iOS and
  Android bundles and successfully converted each with Hermes. The existing
  shared `isv.mp4` is 1,549,611 bytes and exceeds the CLI's 500 KiB asset guard;
  the current `--force` scripts intentionally bypass that pre-existing warning.
- The planned delivery loop is valid: publish the clean feature branch to the
  shared Office Development CodePush deployment for QA, apply QA fixes on the
  feature branch, merge it into develop, then publish develop as the final
  integrated Development CodePush. A later develop release supersedes the
  temporary feature-branch release; CodePush itself does not merge Git state.
- CodePush packages the local working tree, including any uncommitted files,
  rather than a PR object. Reconfirm the exact branch, clean status, Office
  Development environment and matching `2.2.3` installed binary before every
  publication. The combined command publishes mandatory iOS first and Android
  second, so a second-platform failure can leave a temporary partial release;
  prefer the platform-specific commands when staged verification is desired.
- No CodePush release was executed during this readiness assessment. Within the
  confirmed FE code scope there is no known blocker or missing implementation
  before QA. Development BE availability and the separately deployed WebView
  order-detail bridge remain runtime prerequisites, not unfinished app code.

## DL-16061 Notification Settings UX Follow-up - 2026-09-04

- Resumed from remote and fast-forwarded `feature/DL-16061` from `a301e78` to
  `cabe4a5`. The incoming app-developer commit adds service-specific required
  push-type calculation, tests, and a repeated-initialization guard; it was
  preserved as the new base rather than overwritten.
- Reviewed the Feedback Details unsaved-change popup. The exact `Leave this
  page?` / `Changes you made may not be saved.` interaction already exists in
  `CasePreferenceScreen`, with a similar guard in `DesignConfirmationScreen`.
  Figma and the original feedback Notion requirement do not explicitly demand
  it, but it follows an established app pattern, so the user decided to keep it
  and no popup code was changed.
- Fixed the Profile notification-setting flicker where changing one row made
  every switch temporarily render with disabled colors during mutation and
  background refetch. The request/account/upsert guards still block duplicate
  or conflicting interaction, while only the initial unavailable query state
  uses the visible disabled styling. Other switch values and colors remain
  stable during a single-row save.
- Delivered commit `a693de6` (`fix: 알림 설정 스위치 깜박임 방지`) with only
  `shared/features/profile/sections/ProfileNotificationSection.tsx`; push to
  `origin/feature/DL-16061` succeeded. Final worktree and upstream status must
  still be refreshed live when resuming.
- Changed-file ESLint, Prettier and diff whitespace checks pass. The focused
  push-preference Jest suite passes 3/3 after explicitly selecting
  `jest.config.js`; the unqualified test command first stopped on the
  repository's pre-existing duplicate Jest configuration. `typecheck:apps`
  retains the same 11 baseline diagnostics and reports no new error in the
  changed file. No emulator, simulator, device, Metro or CodePush runtime QA
  was performed for this small visual-state correction.

## DL-16061 Feature-Branch Development CodePush v125 - 2026-09-04

- The user explicitly authorized publishing the current feedback feature
  branch to both Office Development CodePush deployments and requested the
  process remain visible. Preflight confirmed `feature/DL-16061` clean and
  synchronized at `a693de6cfe335d58490e075f723a9b6b52939178`, Office version
  `2.2.3`, `.env` byte-identical to the Office Development environment, and no
  native/dependency/environment-file delta from develop.
- Opened the exact `dentlink-app` Cursor workspace and used its visible
  integrated terminal. Published with the narrow platform scripts in sequence:
  `yarn codepush-force-office-ios:dev`, then
  `yarn codepush-force-office-android:dev`. The first Android command entry was
  mistyped by UI automation and failed before invoking a script; the exact
  command was then entered and completed successfully. No partial Android
  release resulted from the typo.
- CLI output confirmed successful mandatory Development releases for
  `Dentlink-Office-iOS` and `Dentlink-Office-Android`, target binary version
  `2.2.3`. The existing 1,549,611-byte `isv.mp4` exceeded the 500 KiB advisory
  limit on both bundles, but the committed `--force` policy allowed completion.
- Read-only Revopush verification at 17:23-17:24 KST confirmed Development
  `v125` on both apps: Enabled, Mandatory Yes, rollout 100%, iOS 7.7 MiB and
  Android 7.68 MiB. This proves publication, not physical-device update receipt
  or feature QA after installation.
- Post-release Git verification remains clean and synchronized at `a693de6`;
  the CodePush commands restored the Development environment file and did not
  create a product-code change. The Revopush browser was left on the Android
  application result page for the user to inspect.
- The user then confirmed update receipt and the target behavior on both iOS
  and Android physical devices: changing an individual notification setting no
  longer makes the other switches flicker, and the setting-change flow behaves
  normally. This closes the runtime QA gap for the `a693de6` visual-state fix;
  it does not independently re-verify every other feedback feature flow.

## DL-16061 Feature-Branch Staging CodePush v312 - 2026-09-04

- After explicitly reviewing the expected missing-BE behavior, the user
  authorized publishing the same feedback feature commit to both Office
  Staging CodePush deployments. Preflight confirmed
  `feature/DL-16061` clean and synchronized at
  `a693de6cfe335d58490e075f723a9b6b52939178`, target version `2.2.3`.
- Used the exact `dentlink-app` Cursor integrated terminal and the narrow
  platform commands in sequence: `yarn codepush-force-office-ios:staging`
  and `yarn codepush-force-office-android:staging`. Both CLI releases
  completed successfully as mandatory Staging updates. The known 1.48 MiB
  `isv.mp4` advisory was bypassed by the committed `--force` option.
- Read-only Revopush verification at 17:39-17:40 KST confirmed Staging `v312`
  for both `Dentlink-Office-iOS` and `Dentlink-Office-Android`: target `2.2.3`,
  Enabled, Mandatory Yes, rollout 100%, iOS 7.7 MiB and Android 7.68 MiB. The
  previous `v311` entry is Disabled on both platforms.
- The user stated that the feedback backend was not yet available in Staging
  and accepted the resulting degraded feedback flow. Current app code is
  expected to keep the app alive: Profile omits the pending count on query
  error, list/detail show retry UX, and push detail returns with an error toast.
  This is code-path analysis, not yet real Staging 404 or feature QA evidence.
- Post-release app Git remains clean and synchronized at `a693de6`; no product
  file was changed by the publication. Revopush was left open on the iOS
  Staging result page. Physical-device update receipt and Staging behavior
  remain separate verification steps.
