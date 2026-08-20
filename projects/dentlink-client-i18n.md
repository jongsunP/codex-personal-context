# Dentlink i18n and typography delivery checkpoint — 2026-08-20

This is the durable delivery checkpoint for the Dentlink Lab i18n, operational
Sheet, and cross-service Pretendard work. Live Git and Google Sheet state still
take precedence if later work changes them.

## Current Delivery State

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Dedicated worktree:
  `/Users/parkjongsun/repository/dentlink-client-i18n`
- Branch: `feature/i18n`, tracking `origin/feature/i18n`
- Local and remote HEAD:
  `dc44bc492` (`fix: 다국어 시트 정합성과 누락 문구 보완`).
- The pushed head still has no commit divergence from `origin/feature/i18n`,
  but the worktree now has 22 modified files for the first direct design-QA
  follow-up. These changes are intentionally uncommitted and unpushed.
- The earlier deployment confirmation referred to the staging test flow, not a
  completed production release. The planned development cleanup is complete,
  and the work now waits for design QA and the final release path.
- Current package version in Lab, Clinic, and Admin: `1.84.0`.

Current release integration plan:

- Draft PR [#4461](https://github.com/Innvoaid/dentlink-client/pull/4461)
  is currently open and clean as `feature/i18n -> master`; it is a temporary
  comparison PR, not yet the final release PR.
- The desired production release is `v1.84.0`, planned for Monday,
  2026-08-24. As of the 2026-08-20 live Git check,
  `origin/release/v1.84.0` does not yet exist, so final release-branch wiring
  remains pending.
- `release/v1.85.0` is the following release train, planned for Monday,
  2026-08-31.
- After i18n is finalized as `release/v1.84.0`, propagate the finalized release
  forward into both `master` and `release/v1.85.0`. Do not use the historical
  `feature/i18n` branch as the propagation source after release finalization.
- Continue `v1.85.0` feature integration on its release branch. After that
  release is finalized and deployed, propagate `release/v1.85.0` back into
  `master`.
- PR [#4512](https://github.com/Innvoaid/dentlink-client/pull/4512) is the
  concrete current example of the normal delivery flow: the small DL-16004
  implementation branch was created from current `origin/master`, while its
  PR targets `release/v1.85.0` because that is its intended deployment train.
  It is one feature in that release, not evidence that the 1.85 contents are
  complete.

## Preliminary Parallel-Release Risk Check — 2026-08-20

This check was intentionally performed before either the i18n work for 1.84 or
the complete 1.85 feature set was finalized. It is a planning checkpoint only,
not merge approval or a request to integrate branches now.

- At the check time, `origin/master` and `origin/release/v1.85.0` both pointed
  to `9b57bec96`, while remote `feature/i18n` contained that master plus 22
  commits.
- PR #4512 has no overlapping files or Git conflict with remote i18n.
- A simulated aggregate of the then-open 1.85 PRs followed by remote i18n
  predicted four semantic conflict surfaces:
  - `shared/ui/src/Order/OrderForm/OrderAdditionalInfoComponent/PatientPhotoConfirm.tsx`
  - `shared/ui/src/OrderDetailUI/parts/BoxComponent/OrderDetailBoxAdditionalInfo.tsx`
  - `shared/ui/src/OrderDetailUI/parts/BoxComponent/OrderDetailBoxTitle/OrderDetailBoxTitleDesktop.tsx`
  - `shared/ui/src/OrderDetailUI/parts/BoxComponent/OrderDetailBoxTitle/OrderDetailBoxTitleMobile.tsx`
- These conflicts appeared manageable, but resolving text conflicts alone is
  not final proof. Preserve newer feature behavior, reapply translations only
  to surviving UI, confirm the 1.85 version bump, and run integration QA after
  the finalized 1.84 release is propagated into the finalized 1.85 contents.
- Because both release contents and the local i18n work are still changing,
  repeat the live graph, overlap, merge simulation, and QA assessment at the
  actual integration point rather than relying on this snapshot.

Final follow-up commits:

- `b47ef8cb0` — `fix: 다국어 시트 역할별 인터페이스 정리`
- `8a337bd13` — `chore: 서비스 버전 1.84.0 반영`
- `1d1b2fda1` — `ui: Clinic과 Admin Pretendard 폰트 정책 적용`
- `dc44bc492` — `fix: 다국어 시트 정합성과 누락 문구 보완`

## Lab i18n Runtime

- Lab displays Korean by default. English remains the source language,
  fallback, and future expansion resource.
- Runtime uses `i18next@22.5.1` and `react-i18next@12.3.1` with statically
  bundled locale JSON.
- `lab/i18n/i18n.manifest.json` is the schema source for languages,
  namespaces, keys, and Sheet columns.
- Current catalog: 1,497 keys across 20 files under
  `lab/src/i18n/locales/{en,ko}`.
- Current namespaces: `gnb`, `sharedUi`, `dashboard`, `account`, `orders`,
  `shipping`, `settlements`, `patients`, `help`, and `linkTalk`.
- There is no language selector or persisted language choice in the current
  scope.

## Canonical Google Sheet

- Sheet:
  `https://docs.google.com/spreadsheets/d/1iuncwk8EIi8ycbc36a0dMn-ZkxaqqMHy1jvyT6ubpq0/edit`
- Operational tabs: `비개발자 영역`, `개발자 영역`
- Preserved backup tabs: `백업_작업전_2026-08-13`,
  `백업_2탭전환_2026-08-18`
- Backup tabs were not changed during the final structural correction.

The two operational tabs are role-specific views of the same canonical message
table, not independent datasets:

- Both tabs contain exactly 1,497 data rows after the direct design-QA export.
- Every message ID is unique and the ID sequence is identical in both tabs.
- Shared fields are connected by formulas and have one owning tab rather than
  duplicated manual input.
- `페이지`, `화면 상태`, and `페이지 경로` expose one representative use site
  only. They never expose a multiline list of all routes.
- Multiple technical use-site identifiers remain aggregated only in the hidden
  developer `사용처 ID` column.
- The previously problematic row 24 representative path is `/` in both tabs.

Nondeveloper columns:

`영문 | 한글 | 개발자에게 확인 요청 | PM·디자이너에게 확인 요청 | 페이지 |
화면 상태 | 위치 번호 | 캡처 | 페이지 경로 | 문구 ID`

Developer columns:

`PM·디자이너에게 확인 요청 | 영문 | 한글 | 페이지 | 화면 상태 | 위치 번호 |
캡처 | 페이지 경로 | 개발자에게 확인 요청 | 문구 ID | namespace | key |
사용 상태 | 사용처 ID`

`비개발자 영역` owns English, Korean, and `개발자에게 확인 요청`.
`개발자 영역` owns `PM·디자이너에게 확인 요청`. Every other shared field is
formula-linked or generated. Writable columns are yellow; generated/read-only
columns are gray and protected with warning-only ranges.

Request ownership is explicit:

- `개발자에게 확인 요청`: PM or designer asks a developer about wording, context,
  or exposure conditions.
- `PM·디자이너에게 확인 요청`: a developer or automated audit asks PM/design for
  a product or wording decision, including screen-versus-JSON differences.
- Current unresolved counts are nine PM/design-to-developer requests and one
  developer-to-PM/design request. The user intentionally deferred all ten on
  2026-08-20 rather than treating them as code blockers.

Final Sheet read-back verified:

- 1,497 unique IDs in each tab and identical row order
- zero missing, stale, translation conflicts, misplaced requests, or role-view
  formula-link issues
- nine developer requests and one PM/designer request preserved in both views
- a duplicate `페이지 경로` header found during final closeout was restored to
  `개발자에게 확인 요청`; a full export then passed read-back verification
- hidden use status and use-site IDs preserved
- capture expansion is paused by user decision; existing links remain and no
  new captures are required before design QA

## Typography Policy

All three projects now use Pretendard and the same Dentlink letter-spacing
policy:

- heading and title variants: `0px`
- body variants: `-0.1px`
- shared UI reads `--dentlink-letter-spacing-heading` and
  `--dentlink-letter-spacing-body`, with legacy theme values only as fallback.

Service details:

- Lab: local Pretendard Medium/Bold WOFF2 via `next/font/local`.
- Clinic: local Pretendard Medium/Bold WOFF2 via `next/font/local`; all previous
  Clinic Lato source references and font assets were removed.
- Clinic PDF: five PDF routes and five PDF document components now use
  Pretendard Regular/SemiBold/Bold TTF.
- Admin: its existing full Pretendard web and PDF setup remains; its theme and
  root variables now use the same heading/body letter spacing as Lab/Clinic.

## Verification And Known Environment Limits

Completed verification:

- `pnpm audit:i18n`: 1,497 keys, 1,497 reachable, zero unresolved keys, zero
  unknown literal keys, and zero review rows.
- `pnpm export:i18n`: 1,497 local keys with zero missing, stale, conflicts,
  role-view link issues, or misplaced review requests.
- `pnpm check:i18n`: 1,497 keys verified across 20 locale files.
- Font asset hashes match their existing Lab/Admin source files.
- Clinic source and public assets contain zero remaining Lato references.
- Clinic and Admin development roots returned HTTP 200.
- Runtime computed styles confirmed Pretendard, heading `0px`, and body
  `-0.1px` in both projects.
- All five Clinic PDF routes and all five new Clinic font asset URLs returned
  HTTP 200 without font compilation errors.
- Lab, Clinic, and Admin typechecks passed before commit and in the commit hook.
- The push hook completed Clinic/Lab/Admin lint with zero errors and 418
  existing warnings, and shared config/hook coverage tests passed (27 tests).
- Prettier and `git diff --check` passed before the final commit.

Known local verification limit:

- `pnpm --filter @dentlink/ui build` still fails on broad pre-existing package
  errors including generated icon unused imports, stale stories, and missing
  legacy modules. All three consuming app typechecks pass, so no error was
  traced to the changed shared order-title component.

## Design QA Follow-up In Progress — 2026-08-20

Eight directly actionable DL-15676 child items are implemented locally and
their translation source has been exported to the canonical Sheet:

- DL-16010: translate the order-list status dropdown from known order-status
  enum keys while retaining the API display name as the fallback.
- DL-16011 and DL-16022: translate the shipping print menu, label/sticker
  selection modal, control buttons, empty/search/list labels, unavailable-label
  toast, and sticker size-setting modal. Printed label/sticker document content
  remains excluded from this scope.
- DL-16012: add the confirmed Korean line break to the shipping notice and make
  the common popup description honor intentional newlines.
- DL-16018: use the requested `mono.400` equivalent icon color for Lab's
  Add New Patient action while preserving Clinic/Admin behavior.
- DL-16020 and DL-16021: apply the requested Lab-only Change Status width and
  Design Upload View left padding without changing Clinic/Admin rendering.
- DL-16023: translate the remaining hardcoded Back action in the skip-design
  flow.

Jira status was changed to `진행 중` for all eight implemented cards:
DL-16010, DL-16011, DL-16012, DL-16018, DL-16020, DL-16021, DL-16022, and
DL-16023. Do not mark them complete until the changes are committed, deployed,
and rechecked.

The Sheet export added 28 keys and intentionally updated the single confirmed
`shipping.policy.description` Korean newline conflict. Current verification:

- Lab, Clinic, and Admin typechecks pass.
- `pnpm check:i18n` verifies 1,497 keys across 20 locale files.
- `pnpm audit:i18n` reports all 1,497 keys reachable with zero unresolved or
  unknown literal keys and zero Clinic regression candidates.
- `git diff --check` passes.
- `@dentlink/ui` full build remains blocked only by the broad pre-existing
  generated-icon, story, missing legacy-module, and unused-code errors; no new
  error was reported in the changed files.

Do not implement the following three items until their missing decision or
reproduction evidence is provided:

- DL-16013: status chips currently encode English-oriented per-status fixed
  widths in shared UI. Recommended direction is intrinsic width with fixed
  horizontal padding and no wrap, but design must confirm exact spacing and
  whether the rule is Lab-only or cross-service.
- DL-16019: the current Step 4 Scan control already reads the `orders` i18n key
  and both English/Korean values exist. Reproduce against the latest deployed
  revision and identify the exact overlapping element before changing code.
- DL-16024: the order-category popup needs the exact intended Korean line-break
  position from design before changing the translation.

## Durable Operating Rules

- Do not edit, delete, or include tabs whose names start with `백업_` in Sheet
  automation.
- Keep one canonical row per full key in both operational tabs.
- Do not expand representative page/state/path cells into multiline use-site
  lists.
- Keep PM/design-to-developer and developer-to-PM/design requests in separate
  columns.
- Translation changes are made in `비개발자 영역`; generated technical fields
  and hidden IDs are not manually duplicated across tabs.
- Runtime observation JSON may contain real account or patient data. Keep it
  temporary, local, ignored, and never upload it unmasked.
- `service-account.json` remains local and ignored. Grant Sheet edit permission
  only for an explicitly authorized write.

## Capture Progress Snapshot — 2026-08-20

Capture expansion is temporarily paused, not cancelled. The current priority is
to preserve existing work and respond to design QA; the user may resume and
complete the capture catalog later.

- 27 actual capture images exist.
- 201 of 1,497 message keys are connected to a capture (about 13%).
- 27 of 110 currently identified page/state groups have a capture (about 25%).
- 83 currently identified page/state groups show `캡처 준비 중`.
- A conservative overall completion estimate is 15–20% because modal,
  permission, error, and data-dependent states may reveal additional groups and
  increase the current total of 110.

This snapshot came from a read-only Sheet inspection; no capture or Sheet data
was changed during the measurement.

## Remaining Delivery Work

Pause at the current local design-QA checkpoint and wait for the user to return
with designer answers for DL-16013, DL-16019, and DL-16024. Ask for:

- DL-16013: auto-width versus fixed-width status chips, exact horizontal
  spacing and single-line rule, and Lab-only versus cross-service scope.
- DL-16019: the exact overlapping element plus screenshot, route, viewport,
  selected data, and deployed revision because the current source already
  translates Scan.
- DL-16024: the exact Korean sentence and intended line-break position.

After those answers, implement only the confirmed three corrections, rerun the
cross-service and i18n checks, and request explicit authorization before
committing or pushing the 22-file product change set. The nine
`개발자에게 확인 요청` rows and one `PM·디자이너에게 확인 요청` row are deferred
human decisions, not code blockers. The remaining PM/design request concerns
the `Additional Information` heading; clear it only after the latest Korean
heading is deployed and verified. Capture expansion remains paused.

This is still not production-closeout complete. The latest follow-up commit is
pushed but deployment of that exact revision is not yet confirmed. Create or
select the final `release/v1.84.0` delivery path, recheck the complete PR diff
against that release, and run assembled-release QA before merging. After the
1.84 release is finalized, forward-propagate it to `master` and
`release/v1.85.0`.
