# Dentlink Lab i18n closeout checkpoint — 2026-08-04

This is the current resume source for the Lab i18n implementation. Verify all
Git and external-service facts live before continuing.

## Repository And Git State

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Dedicated worktree: `/Users/parkjongsun/Repository/dentlink-client-i18n`
- Branch: `feature/i18n`, tracking `origin/feature/i18n`
- Current local and remote HEAD:
  `2b5d0acfd924cc1b51f8835f838085143f27671d`
  (`chore: master 최신 변경사항 반영`)
- Main implementation commit:
  `0fbc5ff979525d1d9f9233f5b366eda51bcec172`
  (`feat: Lab 정적 UI 문구에 한국어 i18n 적용`)
- Latest merged base:
  `6bb4119c137921a23f724819781b6a59004b4e03`
  (`Release/v1.82.0 -> master (#4457)`). It is an ancestor of HEAD.
- Final verified divergence is `origin/master...HEAD = 0 / 7`: the branch
  contains the checked master state and has seven feature commits on top.
- The working tree is clean. `HEAD` and `origin/feature/i18n` match.
- Both commits above are pushed. No PR has been created.
- The sibling `/Users/parkjongsun/Repository/dentlink-client` worktree owns
  `master`; do not move this feature work there.

## Current Stage

- The full Lab frontend-owned static-text pass is implemented and pushed.
- Lab now displays Korean by default. English is retained as the source text,
  fallback, and future language-expansion resource.
- The earlier language selector, localStorage language preference, and related
  hooks were removed. There is no user-selectable locale in the current scope.
- Google Sheets and generated locale JSON are synchronized at this checkpoint.
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
- Current schema:
  `namespace | key 1 | key 2 | key 3 | key 4 | 영문 | 한글 | 의미`
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

- `.claude/skills/i18n/SKILL.md` is synchronized with the final model: fixed
  Korean Lab UI, English fallback, no selector/localStorage, four key levels,
  10 namespaces, bidirectional Sheet sync, shared UI ownership, and validation
  commands.
- The Notion briefing was used for the earlier team planning discussion. The
  team subsequently changed direction, and the user explicitly said it no
  longer needs updating. Treat this Git-backed checkpoint and live code as the
  continuation source unless the user asks to revise Notion again.

## Verification At This Checkpoint

- `pnpm generate:i18n`: passed.
- `pnpm check:i18n`: passed with 1,772 keys across 20 locale files.
- Final Sheet export preview: 0 missing, 0 stale, 0 conflicts.
- Clinic, Lab, and Admin `tsc --noEmit`: passed.
- Clinic, Lab, and Admin production builds: passed.
- Lab lint: 0 errors, 192 warnings.
- Push hook full-repository lint: 0 errors, 418 warnings.
- Shared hook tests: 24 passed; coverage delta check passed.
- `git diff --check`: passed.
- Final explicit `git push origin feature/i18n`: succeeded; everything was up
  to date after hook validation.
- Non-blocking repository warnings remain: Next recommends TypeScript 5.1 or
  newer while the repository uses 5.0.4, Admin Browserslist data is old, and
  existing lint warnings remain.
- Browser-level visual QA and PM wording approval have not been completed and
  must not be reported as done.

## Next Start Point

1. Pull `codex-personal-context` and read this file.
2. Use only `/Users/parkjongsun/Repository/dentlink-client-i18n`; fetch remotes
   and verify `feature/i18n`, its upstream, clean status, and live divergence.
3. Review commit `0fbc5ff97` for the i18n implementation and merge commit
   `2b5d0acfd` for the master synchronization.
4. Have PM review English/Korean wording in the Sheet. Pull approved edits back
   with `pnpm generate:i18n`, then inspect the JSON diff.
5. Run browser QA for fixed Korean display, fallback behavior, long Korean
   text, wrapping/overflow, desktop/mobile layouts, and representative
   `shared/ui` consumers. Include Clinic/Admin regression checks where shared
   defaults changed.
6. Apply only review-driven fixes, rerun proportionate checks, and commit/push
   only on explicit user authorization.
7. Before PR creation, fetch the live intended base and reconcile any new
   divergence deliberately. Create the PR only when the user explicitly asks;
   verify the target branch at that time.
