# Dentlink Lab i18n closeout checkpoint — 2026-08-06

This is the current resume source for the Lab i18n implementation. Verify all
Git and external-service facts live before continuing.

## Repository And Git State

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Dedicated worktree: `/Users/parkjongsun/Repository/dentlink-client-i18n`
- Branch: `feature/i18n`, tracking `origin/feature/i18n`
- Current local and remote HEAD:
  `c2ce3ddd91dee52040191dfd0100f1d2f125a15c`
  (`chore: master 최신 변경사항 반영`).
- A temporary DSO merge commit `a48b1cb8e` was removed from `feature/i18n`
  with an explicit force-with-lease reset. The branch contains no DSO feature
  history and has since merged the latest master.
- Combined development integration branch `feature/i18n-develop` was created
  at `7a9d7c7a6`; its local branch and worktree were deleted after use. The
  remote branch remains.
- PR #4472 (`feature/i18n-develop` -> `develop`) was merged as
  `ec929a2cfebb038e659b3cb649bbe017c03336c1`. PR #4471 was closed.
- Main implementation commit:
  `0fbc5ff979525d1d9f9233f5b366eda51bcec172`
  (`feat: Lab 정적 UI 문구에 한국어 i18n 적용`)
- Latest merged base:
  `53325bd7928dd575a72e97b7cfb95f2dc914bc6c`
  (`Release/v1.82.2 -> master (#4475)`). It is an ancestor of HEAD.
- The working tree is clean. `HEAD` and `origin/feature/i18n` match.
- The i18n branch restore and integration branch are both pushed.
- The sibling `/Users/parkjongsun/Repository/dentlink-client` worktree owns
  `master`; do not move this feature work there.

## Current Stage

- The full Lab frontend-owned static-text pass is implemented and pushed.
- Lab now displays Korean by default. English is retained as the source text,
  fallback, and future language-expansion resource.
- The earlier language selector, localStorage language preference, and related
  hooks were removed. There is no user-selectable locale in the current scope.
- `feature/i18n` contains only the original i18n work. `feature/DL-15223`
  remains separate. Their combined result is now on `develop` through PR #4472.
- Google Sheets and generated locale JSON are no longer synchronized because
  the live Sheet schema changed after the previous checkpoint. The scripts stop
  safely rather than deleting the new columns.
- The next stage is code review, PM review of English/Korean text, browser/UI
  QA, any follow-up fixes, and then an explicitly requested PR.

## Implemented Architecture

- Runtime: `i18next@22.5.1` and `react-i18next@12.3.1`, initialized once by
  Lab's `LocaleProvider` and statically bundled locale JSON.
- Manifest: `lab/i18n/i18n.manifest.json` is the single source for languages,
  namespaces, default/fallback language, allowed component tags, and Sheet
  schema.
- Languages: `ko` is the fixed default; `en` is the fallback and source
  language.
- Namespaces: `gnb`, `sharedUi`, `dashboard`, `account`, `orders`, `shipping`,
  `settlements`, `patients`, `help`, and `linkTalk`.
- Locale resources: 20 JSON files under
  `lab/src/i18n/locales/{en,ko}/`, plus the generated typed resource map.
- Scope: frontend-owned static UI text only. API response text, user/server
  data, external content, PDF/print output, and terms/privacy screens are
  excluded until separately requested.
- Missing-key policy: non-production exposes an obvious missing marker;
  production falls back to English.

## Spreadsheet And Translation Workflow

- Canonical Sheet:
  `https://docs.google.com/spreadsheets/d/1iuncwk8EIi8ycbc36a0dMn-ZkxaqqMHy1jvyT6ubpq0/edit`
- Tab: `화면 문구 수집`
- The scripts and manifest currently expect row 1 to contain:
  `namespace | key 1 | key 2 | key 3 | key 4 | 영문 | 한글 | 의미`.
- The live Sheet now has a note in row 1 and an 11-column header in row 2:
  `namespace | key 1 | key 2 | key 3 | key 4 | 영문 | 한글 | 의미 | 확인 여부 | 수정 요청 | 랑키 확인여부`.
- `pnpm export:i18n` and `pnpm check:i18n` currently stop on this mismatch. Do
  not delete or overwrite the three PM workflow columns; update the schema and
  scripts deliberately in the next task.
- Key depth is capped at four levels. If a fifth level seems necessary,
  reconsider the namespace or semantic grouping instead of adding a column.
- Because the existing product supplied the source English text, the initial
  rollout runs in reverse from ordinary translation intake:
  1. FE finds static text and defines namespace/key.
  2. FE preserves the existing English and adds the proposed Korean in local
     JSON.
  3. `pnpm export:i18n` previews JSON-to-Sheet changes.
  4. Only with explicit edit authorization, FE runs
     `pnpm export:i18n -- --write`; the initial full sync may use
     `--overwrite-existing` deliberately.
  5. PM reviews only the English/Korean wording and meaning in the Sheet.
  6. FE runs `pnpm generate:i18n`, reviews the generated diff, then commits the
     JSON with the consuming code.
- `pnpm check:i18n` validates Sheet-to-JSON consistency. It does not commit,
  deploy, or infer semantic key reuse.
- A duplicate full key, incomplete key depth, missing language value,
  variable mismatch, or allowed-tag mismatch fails generation.
- The script does not infer whether two phrases mean the same thing. FE owns
  namespace/key classification and decides whether one key is safe to reuse.
- The service account should normally have viewer access for generate/check.
  Sheet writes are an exceptional explicit operation using editor access.
  Recheck the live sharing role before the next write; do not assume a
  temporary editor grant was reverted.
- `service-account.json` is optional local authentication, remains ignored,
  and must never be committed.

## Shared UI Compatibility Rule

- A generic `shared/ui` component reads only its own UI behavior text through
  `sharedUi`, always with an English `defaultValue`.
- Lab passes translated business-context labels/options from its domain caller
  or wrapper. The shared component does not infer a route or service domain.
- Lab connects `SharedUiI18nProvider`; Clinic and Admin have no provider in the
  current rollout and therefore keep their existing English defaults.
- This preserves existing consumers, but Clinic/Admin regression should still
  be part of final browser or integration review because many shared
  components changed.

## Project Skill And Team Documentation

- `.claude/skills/i18n/SKILL.md` is synchronized with the implemented model: fixed
  Korean Lab UI, English fallback, no selector/localStorage, four key levels,
  10 namespaces, bidirectional Sheet sync, shared UI ownership, and validation
  commands.
- Its Sheet-schema guidance must be revisited together with the scripts because
  the live Sheet now has a note row and three additional PM workflow columns.
- The Notion briefing was used for the earlier team planning discussion. The
  team subsequently changed direction, and the user explicitly said it no
  longer needs updating. Treat this Git-backed checkpoint and live code as the
  continuation source unless the user asks to revise Notion again.

## Review Direction After Initial Rollout (2026-08-13)

- The first rollout was necessarily reverse-engineered from an already-built
  English product: find existing text, define the FE-owned key, preserve the
  English, propose Korean, then export it for PM review.
- Future feature work should use a forward, design-first flow:
  1. inspect the authoritative Figma design and relevant service behavior;
  2. decide which languages each service actually exposes, such as fixed Korean
     for Lab while preserving Clinic English;
  3. define the namespace/key and English/Korean wording together with the UI;
  4. implement and record every real usage location;
  5. verify the target service and representative shared-component consumers
     before review or deployment.
- The current runtime, manifest, locale resources, Sheet export/generate flow,
  and shared UI provider boundary are reusable foundations for this workflow.
  The repository skill is only partially ready for repeatable AI-assisted
  feature work because it does not yet require Figma-first inspection, a
  service/language exposure matrix, usage-location inventory, Lab reachability
  checks, or Clinic/Admin regression evidence. Add these as a deliberate future
  skill update; do not infer them from translation keys alone.
- Keep the canonical translation Sheet at one row per full key. Add a separate
  one-to-many usage inventory when implementation resumes, with one row per
  actual use site and duplicate usages preserved. Prefer full key, route/page,
  screen state, UI area, component source location, viewport/visibility
  condition, and screenshot or Figma link. Raw x/y coordinates are optional QA
  evidence for a fixed viewport, not a stable primary identifier.
- A sustainable automation target is a hybrid: statically collect literal
  translation references and source locations, then supplement dynamic keys and
  conditional UI with staging/browser evidence. Static text search alone cannot
  prove that a shared component is reachable from a Lab page.
- Current key inventory has 1,772 keys per language. A read-only source scan
  found direct literal calls for 1,513 keys; 259 require dynamic/config or
  reachability review, and 49 dynamic translation call sites explain many of
  those apparent misses. Do not delete the 259 as unused without route and
  runtime verification.
- The coworker concern about billing/amount keys is valid as a scope audit, but
  Lab does contain real financial UI: settlements pages, conditional order
  settlement prices, invoice Excel controls, and the notification Billing
  filter. Conversely, confirmed shared-only branches also exist: order credit,
  refund-credit/refund-amount, and Estimated Cost UI are guarded from Lab by
  `serviceType !== "LAB"` while their translations are present in Lab resources.
  Classify these cases before PM wording review instead of assuming every shared
  key belongs to Lab. A visible Billing filter may itself require product
  confirmation if Lab is not supposed to expose that category.
- Clinic/Admin do not mount `SharedUiI18nProvider`; without it, shared UI returns
  each component's `defaultValue`. New English shared strings therefore do not
  receive Lab Korean resources. The 25 Korean shared defaults found in the i18n
  diff replace Korean strings that already existed on master, including
  LinkTalk, memo, and password UI; they are not newly introduced Clinic Korean
  regressions. Still compare representative Clinic/Admin screens before and
  after because 360 shared UI files were touched and the provider boundary is
  not a substitute for browser regression QA.
- At this review point no product code, Sheet content, or project skill was
  changed. `feature/i18n` is clean at `c2ce3ddd9` and matches its remote, while
  current `origin/master` is five commits ahead and includes new Lab order
  approval text that has not yet been brought into the i18n review.

## Verification At This Checkpoint

- Before the DSO merge, `pnpm generate:i18n` and `pnpm check:i18n` passed with
  1,772 keys across 20 locale files.
- The temporary integration was locally validated with 1,773 keys. Its added
  `sharedUi.date.selectWithinDays` key is in the `develop` integration, not in
  the restored standalone `feature/i18n` branch.
- Current `pnpm export:i18n` and `pnpm check:i18n`: safely failed because the
  live Sheet header moved to row 2 and gained three columns. The new local key
  has not been synchronized to the Sheet.
- Clinic, Lab, and Admin `tsc --noEmit`: passed.
- Clinic, Lab, and Admin production builds: passed.
- Lab lint: 0 errors, 192 warnings.
- Push hook full-repository lint: 0 errors, 418 warnings.
- Shared hook tests: 24 passed; coverage delta check passed.
- `git diff --check`: passed.
- `feature/i18n` was restored to `7665e6109`, then updated with the latest
  master in merge commit `c2ce3ddd9` and pushed.
- For that master synchronization, Clinic/Lab/Admin typechecks passed; the
  push hook completed with 0 lint errors and 418 warnings; shared/config tests
  3 and shared/hooks tests 24 passed with the coverage check.
- Per the user's explicit fast-path request, commit `7a9d7c7a6` and PR #4472
  were created without running typecheck, lint, tests, or Git hooks. The earlier
  temporary integration checks must not be treated as validation of that exact
  final commit.
- Non-blocking repository warnings remain: Next recommends TypeScript 5.1 or
  newer while the repository uses 5.0.4, Admin Browserslist data is old, and
  existing lint warnings remain.
- The standalone `shared/ui` build still has broad pre-existing baseline
  failures; changed-app integration typechecks/builds did not introduce new
  errors.
- Browser-level visual QA and PM wording approval have not been completed and
  must not be reported as done.

## Next Start Point

1. Pull `codex-personal-context` and read this file.
2. Use only `/Users/parkjongsun/Repository/dentlink-client-i18n`; fetch remotes
   and verify `feature/i18n`, its upstream, clean status, and live divergence.
3. Review commit `0fbc5ff97` for the i18n implementation and `c2ce3ddd9` for
   the latest master synchronization. For the combined development result,
   inspect merged PR #4472 / develop commit `ec929a2cf`.
4. Reconcile the manifest/scripts with the live Sheet's note row and 11-column
   schema without losing PM workflow data, then rerun export/generate/check.
5. Have PM review English/Korean wording in the Sheet. Pull approved edits back
   with `pnpm generate:i18n`, then inspect the JSON diff.
6. Run browser QA for fixed Korean display, fallback behavior, long Korean
   text, wrapping/overflow, desktop/mobile layouts, and representative
   `shared/ui` consumers. Include Clinic/Admin regression checks for the merged
   DSO shared-component changes.
7. Apply only review-driven fixes, rerun proportionate checks, and commit/push
   only on explicit user authorization.
8. Run the skipped validation on the merged `develop` integration when the user
   resumes QA. Future i18n changes should remain on `feature/i18n` and use a
   separate develop-based integration branch when another combined deployment
   is required.
