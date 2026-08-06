# Dentlink Lab i18n closeout checkpoint — 2026-08-06

This is the current resume source for the Lab i18n implementation. Verify all
Git and external-service facts live before continuing.

## Repository And Git State

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Dedicated worktree: `/Users/parkjongsun/Repository/dentlink-client-i18n`
- Branch: `feature/i18n`, tracking `origin/feature/i18n`
- Current local and remote HEAD:
  `a48b1cb8e13998af4bce23095a49465700139a20`
  (`[DL-15223] feat: DSO 기능 변경사항 병합`)
- The merge has two parents: the prior i18n tip
  `7665e610972a1699c90d7e20d7d0c22b63d58100` and completed DSO branch tip
  `9d82d144b5eb8ece531c627f63f78d0485b46e6e`.
- `origin/feature/DL-15223` and the squashed `origin/develop` integration commit
  `cbfb8dc077cd5b5ac81336545d97c5914ad96e0a` have identical trees.
- Main implementation commit:
  `0fbc5ff979525d1d9f9233f5b366eda51bcec172`
  (`feat: Lab 정적 UI 문구에 한국어 i18n 적용`)
- Latest merged base:
  `6bb4119c137921a23f724819781b6a59004b4e03`
  (`Release/v1.82.0 -> master (#4457)`). It is an ancestor of HEAD.
- Final verified divergence is `origin/master...HEAD = 0 / 30`.
- The working tree is clean. `HEAD` and `origin/feature/i18n` match.
- The merge commit is pushed. No PR has been created.
- The sibling `/Users/parkjongsun/Repository/dentlink-client` worktree owns
  `master`; do not move this feature work there.

## Current Stage

- The full Lab frontend-owned static-text pass is implemented and pushed.
- Lab now displays Korean by default. English is retained as the source text,
  fallback, and future language-expansion resource.
- The earlier language selector, localStorage language preference, and related
  hooks were removed. There is no user-selectable locale in the current scope.
- The completed `feature/DL-15223` DSO work is merged. Seven shared UI conflicts
  were resolved by preserving both DSO behavior/props and Lab i18n fallback.
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

## Verification At This Checkpoint

- Before the DSO merge, `pnpm generate:i18n` and `pnpm check:i18n` passed with
  1,772 keys across 20 locale files.
- After the merge, local read-only locale validation passed with 1,773 keys.
  The additional key is `sharedUi.date.selectWithinDays` in both languages.
- Current `pnpm export:i18n` and `pnpm check:i18n`: safely failed because the
  live Sheet header moved to row 2 and gained three columns. The new local key
  has not been synchronized to the Sheet.
- Clinic, Lab, and Admin `tsc --noEmit`: passed.
- Clinic, Lab, and Admin production builds: passed.
- Lab lint: 0 errors, 192 warnings.
- Push hook full-repository lint: 0 errors, 418 warnings.
- Shared hook tests: 24 passed; coverage delta check passed.
- `git diff --check`: passed.
- Final explicit `git push -u origin feature/i18n`: succeeded at
  `a48b1cb8e`; the pre-push hook completed with 0 lint errors and 418 existing
  warnings, and the shared hook coverage check passed.
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
3. Review commit `0fbc5ff97` for the i18n implementation and merge commit
   `a48b1cb8e` for the completed DL-15223 integration.
4. Reconcile the manifest/scripts with the live Sheet's note row and 11-column
   schema without losing PM workflow data. Then synchronize
   `sharedUi.date.selectWithinDays` and rerun export/generate/check.
5. Have PM review English/Korean wording in the Sheet. Pull approved edits back
   with `pnpm generate:i18n`, then inspect the JSON diff.
6. Run browser QA for fixed Korean display, fallback behavior, long Korean
   text, wrapping/overflow, desktop/mobile layouts, and representative
   `shared/ui` consumers. Include Clinic/Admin regression checks for the merged
   DSO shared-component changes.
7. Apply only review-driven fixes, rerun proportionate checks, and commit/push
   only on explicit user authorization.
8. Before PR creation, fetch the live intended base and reconcile any new
   divergence deliberately. Create the PR only when the user explicitly asks;
   verify the target branch at that time.
