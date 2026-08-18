# Dentlink Lab i18n closeout checkpoint — 2026-08-18

This is the current cross-device resume source for the Lab i18n work. Verify
live Git, Google Sheet, Drive, and browser state before relying on counts or
deployment facts.

## Repository And Git State

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Dedicated worktree:
  `/Users/parkjongsun/Repository/dentlink-client-i18n`
- Branch: `feature/i18n`, tracking `origin/feature/i18n`
- Local and remote HEAD:
  `b4874f8902574b44eaf02cea8a6e59ef42e669b3`
  (`chore: i18n 개발자 시트 컬럼 순서 정리`).
- The worktree was clean after the commit and push.
- No PR was created in this closeout. PR creation remains separately
  authorized work.
- The sibling `/Users/parkjongsun/Repository/dentlink-client` worktree owns
  `master`; do not move this feature implementation there.

## Product Scope And Runtime Decisions

- Lab displays Korean by default. English remains the original source text,
  fallback, and future expansion resource.
- There is no language selector or localStorage language setting in the
  current scope.
- Runtime uses `i18next@22.5.1` and `react-i18next@12.3.1` with statically
  bundled locale JSON.
- `lab/i18n/i18n.manifest.json` owns languages, namespaces, fallback/default
  language, allowed component tags, and Sheet schema.
- Current namespaces: `gnb`, `sharedUi`, `dashboard`, `account`, `orders`,
  `shipping`, `settlements`, `patients`, `help`, and `linkTalk`.
- There are 1,459 keys across 20 locale files under
  `lab/src/i18n/locales/{en,ko}`.
- Scope is frontend-owned static UI text. API response text, user/server data,
  external content, PDF/print output, and terms/privacy remain excluded until
  separately requested.
- Missing keys are obvious in non-production; production falls back to
  English.

## Shared UI Compatibility

- Generic `shared/ui` components read only their own behavior text from the
  `sharedUi` namespace and retain English `defaultValue` behavior.
- Lab supplies translated domain labels/options from the owning Lab caller or
  wrapper.
- Lab mounts `SharedUiI18nProvider`; Clinic and Admin do not currently mount
  it and therefore retain their English defaults.
- Lab English leakage is acceptable during rollout review; newly introduced
  Korean text in Clinic is a release risk and requires representative browser
  regression QA.

## Canonical Sheet And Drive

- Google Sheet:
  `https://docs.google.com/spreadsheets/d/1iuncwk8EIi8ycbc36a0dMn-ZkxaqqMHy1jvyT6ubpq0/edit`
- Screenshot Drive folder:
  `https://drive.google.com/drive/folders/1cMEJxHr-gqYgz84r3qMWATF5VtvamEPt`
- Operational tabs:
  - `비개발자 영역`
  - `개발자 영역`
- Preserved backup tabs:
  - `백업_작업전_2026-08-13`
  - `백업_2탭전환_2026-08-18`
- Do not delete or rewrite the backup tabs without an explicit request.

### Field Ownership

- `비개발자 영역` is one row per full key and is the editable source for:
  - English
  - Korean
  - review memo
- `개발자 영역` is one row per real/static use site and is the generated
  source for:
  - page
  - page path
  - screen state
  - capture URL and marker
  - use status and stable use-site ID
- Developer-area English/Korean cells reference the nondeveloper tab by
  formula.
- The visible developer-area columns are ordered for location review:
  page, page path, screen state, English, Korean, phrase ID, namespace, and
  key. The first three location columns remain frozen while scrolling.
- Capture URL, marker, use status, and use-site ID remain trailing hidden
  system columns.
- Nondeveloper page/screen-state/position/capture cells reference the
  representative developer-area use site by formula.
- Page path stays only in the developer area because one key may have multiple
  use sites and routes.
- Therefore the same field is not manually managed in both tabs.

### Sheet Verification At Closeout

- Nondeveloper catalog rows: 1,459.
- Developer use-site rows: 1,959 after the final export.
- Nondeveloper formula counts:
  - page: 1,459
  - screen state: 1,459
  - position: 1,459
  - capture buttons: 110 representative groups
- Developer formula counts:
  - English: 1,959
  - Korean: 1,959
- Missing page values: 0.
- Missing screen-state values: 0.
- Representative page/screen-state mismatch between tabs: 0.
- Formula display errors in the checked ranges: 0.
- Review memos preserved: 39.
- The developer-column reorder preserved all 1,959 use-site rows, 251 capture
  links covering 201 keys, and 110 representative capture groups.

## Screenshot And Usage Audit State

- Twenty-seven sharp, masked screenshots were uploaded at Chrome 100% zoom.
- Long pages and scrollable modals use separate top/lower captures; one image
  may cover multiple keys using marker numbers.
- Runtime audit accepted 251 visible occurrences covering 201 distinct keys.
- Screenshots are grouped by page/screen state to avoid repeating a capture
  button on every row.
- Captures and marker links are already reflected in the Sheet.
- Runtime/browser observation JSON is temporary and may contain actual account,
  patient, address, or email text. Never commit it or upload it unmasked. The
  final durable outputs are the sanitized Sheet and masked Drive images.

## Permanent Tooling

- `lab/scripts/i18n/generate-locales.js`: Sheet to locale JSON and `--check`.
- `lab/scripts/i18n/export-locales-to-sheet.js`: locale/manifest data to the
  two-tab Sheet structure and cross-tab formulas.
- `lab/scripts/i18n/sheets-client.js`: authenticated Sheet reader/writer and
  schema parser.
- `lab/scripts/i18n/audit-usage.js`: static/runtime use-site audit, Lab
  reachability, Clinic shared-UI review, and Sheet usage/capture refresh.
- `lab/i18n/catalog/README.md` and `.claude/skills/i18n/SKILL.md` document the
  repeatable operating workflow.
- The service account should normally be viewer-only. Temporarily grant editor
  access only for an explicitly authorized Sheet write, then review whether it
  should be returned to viewer access.
- `service-account.json` remains local and ignored; never commit it.

## Verification Completed

- `pnpm check:i18n`: passed, 1,459 keys across 20 locale files.
- Lab typecheck: passed.
- Clinic typecheck: passed.
- Admin typecheck: passed.
- Commit hook typechecks: passed.
- Push hook lint: 0 errors, 418 existing warnings.
- Shared config/hook coverage tests: 27 tests passed.
- `git diff --check`: passed before commit.
- Google Sheet formula/value read-back and visual inspection: passed.
- Project commit and push: passed.

## Team Feedback That Still Governs The Work

- The initial rollout was reverse-engineered from an already-built English
  product. Future work should be Figma/design first, then service-language
  exposure, key ownership, implementation, Sheet review, and QA.
- Before wording/PD review, prove that each retained key is actually usable by
  Lab. Do not keep or remove Billing/amount keys merely from their names; verify
  route and product behavior.
- A common component needs only representative capture coverage when its text,
  state, and presentation are identical. Capture separately when domain meaning
  or passed labels/options differ.
- Coordinates are automation evidence only. Human review uses the annotated
  screenshot and marker number.
- Completion means each retained key is either linked to an observable screen
  state or has an explicit blocked/pending reason.

## Remaining Work And Next Start Point

1. Pull `codex-personal-context`, then pull/verify
   `/Users/parkjongsun/Repository/dentlink-client-i18n` on
   `feature/i18n` at or after `b4874f890`.
2. Recheck the live Sheet/Drive before relying on the counts above.
3. Continue exhaustive coverage in this order:
   - visit every Lab route and open all reachable tabs, drawers, dropdowns,
     modals, scroll segments, empty/error states, and conditional controls;
   - run Lab locally and use existing development/test data for states that the
     development server cannot expose;
   - when local execution still cannot expose a state, record the exact route,
     permission, data, and user action required, then ask the user to open that
     state for capture.
4. Keep the human-facing Sheet simple. Add captures and markers through the
   developer usage rows; the nondeveloper tab must continue to read the
   representative values by formula.
5. Classify every uncaptured key as reachable/captured, data-or-permission
   blocked, defensive, or genuinely unused. Remove only keys whose absence from
   Lab is verified.
6. Perform PM wording review, development-server wording deployment, PD visual
   review, and approved design fixes.
7. Perform final fixed-Korean Lab QA and representative Clinic/Admin shared-UI
   regression QA.
8. Create or update a PR only when explicitly requested.

No current Figma link, dedicated state-complete test-data set, or final Korean
font has been supplied. Treat those as pending inputs rather than inventing
them.

## Relevant History

- Main Lab Korean-default implementation commit:
  `0fbc5ff979525d1d9f9233f5b366eda51bcec172`.
- The temporary DSO merge was removed from `feature/i18n`; the i18n and DSO
  feature histories remain separate.
- Combined development delivery used `feature/i18n-develop`; PR #4472 was
  merged into `develop`. That integration branch is not the source branch for
  continuing i18n work.
- The current management/audit closeout supersedes the earlier one-tab Sheet
  experiments. Preserve the backup tabs for historical comparison, but use
  `비개발자 영역` and `개발자 영역` as the operational model.
