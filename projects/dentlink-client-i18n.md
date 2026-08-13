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
  analysis, authenticated Lab/Clinic inspection, a single shared Sheet view,
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

## Current Sheet And Audit Checkpoint — 2026-08-13

- The shared Google spreadsheet now has only two visible tabs:
  `화면 문구 수집` and `백업_작업전_2026-08-13`.
- The backup is excluded from automation and was verified as the preserved
  pre-restructure shape: the row-1 note, exact 11 headers, 1,772 unique key
  rows, and 1,774 total rows. It has a warning-only protected range.
- The canonical `화면 문구 수집` tab has 22 columns, 1,772 unique keys, and
  2,685 use-site rows plus the note/header. Existing English, Korean, meaning,
  `확인 여부`, `수정 요청`, and `랑키 확인여부` values match the backup with
  zero mismatches.
- The four provisional technical tabs (`화면 검수표`, `사용처 자동 분석`,
  `검토 필요 키`, and `Clinic 공용 UI 점검`) were deleted only after checking
  that their manual review columns contained zero human edits.
- The single shared table intentionally repeats a full key for distinct use
  sites. The generator groups rows with identical English/Korean values into
  one JSON key and fails if translations conflict. Usage is identified mainly
  by page/function, state, area, source evidence, and development URL;
  viewport/coordinates remain secondary.
- Latest runtime-assisted audit results: 1,772 catalog keys, 1,513 literal-key
  references, 197 indirectly recognized keys, 1,476 statically Lab-reachable
  keys, 62 unresolved candidates, 49 dynamic call sites, and zero unknown
  literal keys. The 62 are 48 unused candidates plus 14 keys whose wording
  duplicates another used key; none may be removed automatically.
- Runtime evidence contains 939 observations covering 274 keys and 483 screen
  occurrences. The Clinic/shared audit found zero new Korean regression
  candidates in the representative routes, but it is not exhaustive UI QA.
- Billing/financial keys are not uniformly unused. Credit/cost groups behind
  confirmed non-Lab conditions are marked as exclusions, while settlement and
  Billing notification wording observed in Lab remains a product decision.
- One Sheet/JSON wording conflict remains approval-gated:
  `sharedUi.filters.open` is `필터 열기` in JSON and `필터` in Sheet. No locale
  JSON, product component, key inventory, or deployment behavior was changed.

## Reusable Tooling And Skill State

- Uncommitted shared-repository work updates the manifest, Sheets client,
  locale export/generate scripts, catalog guide, package command, and Claude
  i18n skill; it adds `lab/scripts/i18n/audit-usage.js`.
- `sheets-client.js`, `generate-locales.js`, and
  `export-locales-to-sheet.js` are permanent Sheet/JSON operating tools.
  `audit-usage.js` is also retained as a repeatable maintenance tool for use
  locations, Lab reachability, unused/duplicate candidates, and shared UI
  regression checks. It now writes only the canonical tab and no longer creates
  technical tabs.
- Browser runtime observation JSON and the one-off backup creation code are
  temporary evidence and are not added to the repository.
- `.claude/skills/i18n/SKILL.md` assumes the initial reverse migration is
  complete and guides future work through Figma/operating-screen review,
  service-aware wording/key ownership, Sheet sync, PM review, JSON generation,
  and Lab/Clinic/Admin QA. It documents the single-tab and duplicate-use rules.
- Skill validation, JavaScript syntax checks, `pnpm audit:i18n`, Prettier,
  `git diff --check`, Sheet write/read-back, and backup/current-value comparison
  passed. Prettier emitted only the repository's existing unknown-option
  warnings.
- `pnpm export:i18n` passes with 1,772 local keys, zero missing, zero stale, and
  the one conflict above. `pnpm check:i18n` fails only because
  `ko/sharedUi.json` is stale against that undecided Sheet value. App typecheck,
  lint, build, exhaustive browser QA, and PM/PD review were not run in this pass.
- Shared repository changes remain uncommitted and unpushed on
  `feature/i18n`; commit/push still requires explicit user authorization.

## Next Start Point

### Agreed execution order

- Do not treat all 1,772 current keys as screenshot targets.
- First re-audit and remove only keys proven unused by Lab after checking
  literal and dynamic references, shared UI consumers, route reachability,
  conditional rendering, and Clinic/Admin side effects. Review duplicate
  ownership and Lab-excluded Billing/amount groups in the same gate.
- Freeze the remaining Lab key inventory, then create only as many annotated
  screenshots as required by distinct page, UI state, and viewport. Reuse one
  screenshot for multiple key rows by assigning marker numbers.
- The shared Sheet should eventually add a screenshot link and marker number.
  Raw coordinates are automation evidence, not a human-facing location method.
- Completion means every remaining key is either linked to an annotated screen
  state or has an explicit blocked/pending reason; unclassified keys must be
  zero. Data/permission-dependent states must not be silently omitted.

1. Pull `codex-personal-context`, then use only
   `/Users/parkjongsun/Repository/dentlink-client-i18n` and verify live Git and
   Sheet state before relying on this checkpoint.
2. Review the uncommitted automation/skill diff and the single shared
   `화면 문구 수집` tab. Do not modify the `백업_작업전_2026-08-13` tab.
3. Have FE/PM decide whether `sharedUi.filters.open` should be `필터` or
   `필터 열기`, then run `pnpm generate:i18n` and inspect the JSON diff.
4. Have FE/product classify the 48 unused candidates, 14 duplicate-wording
   candidates, and Lab Billing/amount scope before deleting or merging keys.
5. Let PM/PD review wording and layout from the semantic use locations. Add
   annotated screenshot evidence only where route/area/state is insufficient.
6. Run fixed-Korean Lab visual QA and representative Clinic/Admin regression
   QA. Apply only approved wording/design/key changes, then run proportionate
   typecheck/lint/build checks.
7. Commit and push the shared branch only when explicitly requested. Use a
   separate `origin/develop`-based integration branch for another combined
   development deployment if needed.
