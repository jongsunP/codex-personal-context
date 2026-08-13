# Dentlink Lab i18n closeout checkpoint — 2026-08-13

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
- `HEAD` and `origin/feature/i18n` still match. The working tree now has
  uncommitted management-only changes for usage auditing, the live Sheet
  schema, and the repeatable i18n workflow. No product UI behavior or locale
  wording was changed in this pass.
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
- The Sheet scripts now support the live note row, row-2 header, and three PM
  workflow columns without deleting them. One wording conflict remains between
  the Sheet and JSON and is intentionally pending PM/FE review.
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
- Row 1 contains the product-term note and row 2 has the 11-column header:
  `namespace | key 1 | key 2 | key 3 | key 4 | 영문 | 한글 | 의미 | 확인 여부 | 수정 요청 | 랑키 확인여부`.
- The manifest, reader, and exporter now use that structure. Export preserves
  existing PM workflow values by full key and never removes the three columns.
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

- `.claude/skills/i18n/SKILL.md` is synchronized with the implemented model and
  the next operating model: fixed Korean Lab UI, English fallback, no selector/
  localStorage, four key levels, 10 namespaces, bidirectional Sheet sync,
  shared UI ownership, Figma-first future work, service-language exposure,
  usage auditing, and Clinic regression evidence.
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
  The repository skill now requires Figma-first inspection, a service/language
  exposure decision, usage-location inventory, Lab reachability checks, and
  Clinic/Admin regression evidence for repeatable AI-assisted feature work.
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
- `feature/i18n` remains at `c2ce3ddd9` and matches its remote. The current
  audit changes are uncommitted; locale JSON and product rendering code remain
  untouched. Recheck `origin/master` before a later product-change pass.
- Authenticated browser inspection was performed on 2026-08-13 against
  `https://dev-lab.dentlink.io/` and `https://dev-portal.dentlink.io/` across
  representative routes and open UI states. Korean names/data and English API/
  message content are not evidence of a static-translation leak. This remains
  representative inspection, not complete shared-component regression QA.
- There is currently no linked Figma source or dedicated order/settlement/
  Billing test-data set. Continue code-based usage classification first and
  mark visual/state evidence as pending where the current development data
  cannot expose it.
- Font replacement is intentionally deferred until the designer supplies the
  target font. When supplied, recheck Korean/English family and weight support,
  loading/fallback behavior, line wrapping, button/table widths, and responsive
  layouts rather than treating it as a cosmetic-only swap.

## Team Feedback And Current Execution Scope

- The user authorized management and audit work on 2026-08-13: static usage
  analysis, authenticated Lab/Clinic inspection, separate Sheet analysis tabs,
  and reusable audit/skill documentation. Product rendering behavior, locale
  wording, and key deletion were explicitly left out of scope.
- Planned delivery sequence: wording review -> development-server wording
  deployment -> PD visual review on the deployed site -> design-fix follow-up.
- Continue using all of the following as review criteria:
  1. one-to-many key usage locations, preserving duplicate use sites and using
     coordinates only as optional viewport-specific evidence;
  2. whether shared UI introduces new Korean static text into Clinic, where
     Lab English is acceptable but Clinic Korean is a release risk;
  3. whether Lab resources contain keys that cannot actually render in Lab,
     including the team's Billing/amount concern. Treat “Lab has no Billing” as
     a hypothesis to verify against product behavior and reachability, not as a
     confirmed fact;
  4. the transition from this reverse migration to a Figma-first, service-aware
     English/Korean design and implementation workflow that an AI skill can
     repeat in normal feature work.
- Figma references, dedicated state-specific test data, and the final font are
  not currently available. Their absence must be reported as pending evidence,
  not filled in by assumption.

## Usage Audit And Sheet Checkpoint — 2026-08-13

- Added the uncommitted `pnpm audit:i18n` workflow and
  `lab/scripts/i18n/audit-usage.js`. It combines TypeScript-AST references,
  Lab page/import reachability, dynamic-call inventory, optional browser
  observations, and current Sheet consistency without changing locale JSON.
- The canonical `화면 문구 수집` tab was not changed. Four separate analysis
  and review tabs were created or refreshed:
  - `화면 검수표`: 449 actual Lab screen occurrences across 15 captured
    routes/states. It is the second and primary human-review tab and includes a
    development-server link, screen/function, UI area, rendered text,
    English/Korean source, manual wording/design/change decisions, key
    candidates, viewport, and secondary coordinates;
  - `사용처 자동 분석`: 3,071 data rows, preserving duplicate use sites;
  - `검토 필요 키`: 585 data rows, with manual FE/product/note columns
    preserved on refresh;
  - `Clinic 공용 UI 점검`: 35 data rows.
- Static results: 1,772 catalog keys, 1,513 keys with literal references,
  1,281 keys with a statically reachable Lab use, 259 without a literal
  reference, 49 dynamic translation call sites, and zero unknown literal keys.
  The 259 are review candidates, not automatic deletion candidates.
- Browser evidence covered 15 Lab routes/states and 7 Clinic routes. It added
  801 filtered Lab observations covering 241 keys. Route, screen state, UI
  area, and source location are the primary identifiers; viewport coordinates
  are secondary evidence only.
- The human review sheet excludes noisy interpolation-only parent matches,
  groups multiple keys that share the exact same rendered phrase/location as
  candidates instead of guessing ownership, and keeps duplicate real UI
  occurrences. Its manual columns use dropdowns and are preserved by a hidden,
  stable occurrence ID when the audit reruns. Running the audit without a
  runtime observation file does not clear this sheet.
- The audit found 29 keys behind confirmed non-Lab conditions: order credit,
  refund amount/credits, order-summary completion, and estimated-cost groups.
  These remain in locale JSON until the team confirms removal.
- Billing/financial keys are not uniformly unused. Current Lab observations
  include `gnb.navigation.settlement`, `settlements.info.currency`, and
  `sharedUi.notifications.filters.billing`; the notification modal visibly
  renders the Billing category as `결제`. Whether that category belongs in Lab
  remains a product decision.
- Clinic does not mount `SharedUiI18nProvider`. Across the 7 observed Clinic
  routes there were zero exact Korean catalog matches introduced by the Lab
  resources. All 25 Korean `defaultValue` entries found in shared UI existed
  as Korean on `origin/master`, so the audit found zero new Clinic regression
  candidates. This is representative evidence, not exhaustive UI QA.
- One real Sheet/JSON conflict is pending rather than auto-fixed:
  `sharedUi.filters.open` is `필터 열기` in JSON and `필터` in Sheet row 97.
- No locale key, Korean/English wording, product component, or deployment state
  was changed. The next product pass should begin only after FE/product review
  of the analysis tabs.

## Confirmed Review Operating Model — 2026-08-13

- The shared operating surface must be one Google spreadsheet and one visible
  tab, `화면 문구 수집`, for FE, PM, and PD together. Additional technical
  tabs may exist as generated evidence but should be hidden from the normal
  collaboration flow.
- In the shared table, namespace and key-depth columns are FE-owned technical
  data. English, Korean, and meaning are PM-owned review data. Screen location
  and review evidence connect the two so a non-developer can understand where
  each phrase appears without reading code.
- A usable location is semantic and visual: page/function, UI state, precise
  human-readable UI path, development-server link, and an annotated screenshot
  around the phrase. Viewport coordinates remain secondary automation evidence
  only.
- The single visible table may intentionally contain one row per real screen
  occurrence, including repeated full keys or repeated wording. The supporting
  script must group identical full keys for JSON generation, keep their English
  and Korean values synchronized, and stop on conflicting translations rather
  than choosing one silently.
- Before rebuilding the shared table, FE must audit the current code and key
  inventory completely: literal and dynamic references, Lab reachability,
  conditional or inaccessible states, shared UI ownership, Clinic/Admin Korean
  regression risk, duplicate ownership, Billing/financial product scope, and
  Sheet/JSON conflicts. An unobserved runtime phrase is not enough to delete a
  key.
- Only after that technical gate should remaining keys be mapped to exact
  human-readable locations and exposed to PM/PD. The previously generated
  `화면 검수표` and analysis tabs are provisional evidence, not the final
  collaboration structure; keep them for now and hide or replace them after
  the audit is complete.
- Product behavior, locale wording, and key deletion remain approval-gated.
  Codex may complete independent analysis, tooling, hidden-sheet maintenance,
  and evidence collection, but must report product decisions or unavailable
  evidence instead of guessing.

## Verification At This Checkpoint

- Before the DSO merge, `pnpm generate:i18n` and `pnpm check:i18n` passed with
  1,772 keys across 20 locale files.
- The temporary integration was locally validated with 1,773 keys. Its added
  `sharedUi.date.selectWithinDays` key is in the `develop` integration, not in
  the restored standalone `feature/i18n` branch.
- Current `pnpm export:i18n`: succeeds in preview mode with 1,772 local keys,
  zero missing, zero stale, and one wording conflict.
- Current `pnpm check:i18n`: reaches content validation and fails only because
  `ko/sharedUi.json` differs from the one pending Sheet value above. Do not run
  generate until that wording is decided.
- `pnpm audit:i18n`, runtime-assisted audit, JavaScript syntax checks, and
  `git diff --check`: passed. No app typecheck/build was run because this pass
  did not modify product TypeScript/TSX behavior.
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
4. Continue the code/key audit to classify every current key before changing
   the shared Sheet layout or asking PM/PD to review it. Resolve dynamic-key
   families, service conditions, duplicate ownership, and Clinic/Admin impact;
   request product decisions only where code and runtime evidence cannot decide.
5. Rebuild the visible `화면 문구 수집` collaboration table from the audited
   key inventory, including semantic locations and annotated screen evidence;
   hide supporting technical tabs instead of deleting their evidence.
6. Have PM review English/Korean wording in that table. Pull approved edits
   back with `pnpm generate:i18n`, then inspect the JSON diff.
7. Run browser QA for fixed Korean display, fallback behavior, long Korean
   text, wrapping/overflow, desktop/mobile layouts, and representative
   `shared/ui` consumers. Include Clinic/Admin regression checks for the merged
   DSO shared-component changes.
8. Apply only review-driven fixes, rerun proportionate checks, and commit/push
   only on explicit user authorization.
9. Run the skipped validation on the merged `develop` integration when the user
   resumes QA. Future i18n changes should remain on `feature/i18n` and use a
   separate develop-based integration branch when another combined deployment
   is required.
