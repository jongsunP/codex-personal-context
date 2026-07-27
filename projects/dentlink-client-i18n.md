# Dentlink Lab i18n review checkpoint — 2026-07-27

This is the current resume source for the Lab i18n planning and sample
implementation. Verify every Git fact against the live repository before
continuing.

## Repository And Git State

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Dedicated worktree: `/Users/parkjongsun/Repository/dentlink-client-i18n`
- Branch: `feature/i18n`
- Base and current HEAD:
  `b9c981ea1b52038784521201bf4362917605a3ab`
  (`Release/v1.80.0 -> master (#4426)`)
- At closeout, `HEAD == origin/master` and divergence is `0 behind / 0 ahead`.
- The branch currently tracks `origin/master`; there is no remote
  `feature/i18n` branch yet.
- The sibling `/Users/parkjongsun/Repository/dentlink-client` worktree owns
  `master`. Do not edit or move this work into that worktree.
- Current working tree is intentionally uncommitted: `0 staged`, `26 tracked
  modified`, and `24 untracked` files.
- No Dentlink commit, push, PR, branch recreation, reset, rebase, or amend was
  performed at this checkpoint.
- Local session files `AGENTS.md`, `.agents/`, and `.codex/config.toml` still
  exist and are excluded through the shared Git directory's `info/exclude`.
  Do not stage, delete, or mix them with the i18n changes.

The product changes exist only in this device's uncommitted worktree. This
personal checkpoint is remote-portable, but another device cannot inspect or
continue the actual code diff until the user reviews it and explicitly asks to
commit and push `feature/i18n`. Do not copy the code diff into this personal
context repository as a workaround.

## Current Stage

- The current stage is user review of the code, spreadsheet operating model,
  and Notion briefing.
- Do not make additional product changes while the user is reviewing.
- After review, wait for an explicit request before committing or pushing the
  shared Dentlink repository.
- The implementation is a production-shaped partial Lab sample, not a full
  translation pass.

## Implemented Sample

- Added `i18next` and `react-i18next` for Lab, with English and Korean static UI
  resources.
- Added a Manifest-driven structure at
  `lab/i18n/i18n.manifest.json`. The current namespaces are `gnb`, `sharedUi`,
  `orders`, and `dashboard`.
- Added a read-only Google Sheets pipeline:
  `sheets-client.js` reads the sheet and `generate-locales.js` validates rows,
  generates locale JSON, removes obsolete locale files, and regenerates
  `i18n.resources.generated.ts`.
- Added `LocaleProvider`, localStorage-backed language selection, configured
  default/fallback handling, missing-key policy, typed resources, and the
  temporary Lab language selector.
- Applied sample translations to Layout/navigation, Dashboard, Order List, and
  selected shared DataGrid/Dropdown/SegmentControl text.
- Added a `SharedUiI18nProvider` bridge. Lab supplies translations; services
  without that provider retain existing English through required
  `defaultValue` values.
- Added the Claude Code project skill at
  `.claude/skills/i18n/SKILL.md`. The uppercase filename is intentional and is
  required for skill discovery. The skill documents the current Manifest,
  sheet, generation, code, permission, and validation flow.
- The earlier `setup-sheet.js`, i18n test files, Vitest configuration, and
  `test:i18n` command were intentionally removed. The retained production
  commands are `pnpm generate:i18n` and `pnpm check:i18n`.
- Generated locale JSON and `i18n.resources.generated.ts` belong in the same PR
  and deployment version as the code that consumes them.

## Durable Decisions

### Product Scope

- Initial target is Lab only, with `en` and `ko`, while keeping language and
  namespace additions extensible through the Manifest.
- Translate frontend-owned static UI text only. API response messages and
  server-provided display values are outside the current scope.
- External carrier documents are outside the scope. Dentlink-owned print/PDF
  output can be considered after the web UI pass and will need Korean font and
  output QA.

### Language Runtime

- Do not add `/ko` or `/en` URL routing for the authenticated Lab service.
- Store the user's language in `localStorage`; use the service default when no
  value exists. A future API `uiLanguage` can take priority over localStorage.
- Manifest default/fallback values are structural defaults. Deployment
  environment variables may override them.
- Locale JSON is bundled statically; the browser does not query Google Sheets
  or a translation API at runtime.
- Development and staging expose a visible missing-key marker after fallback
  also fails. Production uses the configured fallback/default behavior and
  does not expose raw internal keys.

### Translation Ownership

- Split JSON by the owner of the phrase, not by every page:
  `gnb` for global navigation UI, `sharedUi` for generic shared component text,
  and domain/function namespaces such as `orders` and `dashboard`.
- Do not use a vague `common` namespace unless a new, clear ownership need is
  agreed later.
- Shared components read their own generic behavior text, such as search,
  reset, no-result, and pagination labels, from `sharedUi`.
- Business-context text, such as order status placeholders and options, is
  translated by the service/domain wrapper or caller and passed through props.
- A shared component must not infer the route or business context.

### Spreadsheet And Key Management

- Canonical sheet:
  `https://docs.google.com/spreadsheets/d/1iuncwk8EIi8ycbc36a0dMn-ZkxaqqMHy1jvyT6ubpq0/edit`
- Sheet name: `화면 문구 수집`.
- Columns are `서비스`, `화면/기능`, `위치·UI`, `영문`, `한글`, `의미`, and
  `key`.
- PM/non-developers own visible text, translations, meaning, and approval. FE
  owns `namespace.key`, code integration, and generated-resource review.
- PM records the same visible phrase for each screen/use site. FE normally uses
  independent keys and may reuse one key only when meaning and change timing
  are genuinely identical.
- The generator rejects duplicate full `namespace.key` values, missing
  translations for keyed rows, invalid keys, mismatched variables, and
  mismatched allowed component tags.
- The script cannot infer semantic equivalence. FE must choose the namespace
  and whether multiple use sites should reuse a key. When a representative row
  owns a shared key, record the other use sites in the work/PR description
  because an empty key cell cannot distinguish reuse from unfinished work.

### Automation And Permissions

- Keep the Sheets API service account read-only and shared as a viewer. The
  checked-in client also requests the read-only Sheets scope.
- PM and developers edit and approve the sheet using their normal accounts.
- An AI agent edits the sheet only as an explicit, exceptional user request;
  it is not the regular content owner.
- Automate the mechanical portion only: read approved sheet data, generate
  JSON, and validate consistency. Meaning, context, editing, and approval stay
  with the human owners.
- `service-account.json` remains a supported local authentication option and
  must stay ignored. It is not required when environment credentials or gcloud
  Application Default Credentials are available. Never store credentials in
  this context repository.
- CI integration for `pnpm check:i18n` is documented as a future option and is
  not implemented. It would validate only; it would not edit the sheet,
  generate a commit, or deploy automatically.

## Team Documentation

- Notion briefing:
  `https://app.notion.com/p/innovaid/3a6ce072e82f80b08d9bf9f3a00e7826`
- The Notion page was re-reviewed and synchronized with the current code on
  2026-07-27. It includes decisions and tradeoffs, the Manifest and namespace
  model, shared UI ownership, spreadsheet generation, language/namespace
  changes, QA, rollout scope, code examples, and the Claude Code `/i18n`
  appendix.
- A final `역할 분담과 자동화 범위` section records that PM, FE, API scripts,
  and AI have different responsibilities and that full sheet automation is not
  the current operating model.

## Verification At This Checkpoint

- Live `git fetch origin master --prune` confirmed the HEAD/base relationship
  above.
- Current `git diff --check` passed.
- Earlier in the same session, `pnpm check:i18n` passed with `55 keys across 8
  locale files`.
- Earlier in the same session, Lab typecheck and build passed.
- Lab lint completed with `0 errors / 196 warnings`; the warnings are existing
  project warnings and were not treated as failures.
- Claude Code `2.1.209` is installed, its local doctor reported no installation
  issues, the i18n skill YAML frontmatter parsed successfully, and stale skill
  examples/path assumptions were removed.
- Notion was fetched again after the final edits and the new role/automation
  section was confirmed.
- Browser-level English/Korean visual QA, responsive long-text QA, and final
  team demo are still review items; do not report them as completed.

Before commit, rerun the proportional checks because the working tree remains
uncommitted and may change during user review.

## Next Start Point

1. Pull `codex-personal-context` and read this file before relying on chat
   history.
2. Confirm the exact worktree is
   `/Users/parkjongsun/Repository/dentlink-client-i18n`. On the original device,
   fetch rather than destructively pulling/rebasing the dirty worktree.
3. Verify branch, HEAD, `origin/master`, worktree list, staged state, and the
   full untracked-file list. Preserve all existing user changes.
4. If working from another device before the feature branch is pushed, stop:
   the implementation is still local-only. Use the original device for review
   and delivery unless the user has since pushed the branch.
5. Read the live Notion page and check the spreadsheet's sharing state. The
   service account should be a viewer; verify this rather than assuming the
   previous temporary editor permission was reverted.
6. Continue only from the user's review feedback. Do not broaden the sample or
   add CI automation yet.
7. When the user explicitly asks to commit, use the repository's commit skill
   and separate dependencies/runtime+generation, shared UI integration, Lab
   sample application, and stable documentation/skill as appropriate after
   inspecting the final diff.
8. Rerun at least `pnpm check:i18n`, Lab typecheck, Lab lint, Lab build,
   `git diff --check`, `git status -sb`, and `git diff --stat`. Validate
   `shared/ui` proportionally if its final diff remains.
9. When the user explicitly asks to push, do not run plain `git push` because
   the current upstream is `origin/master`. Push exactly with
   `git push -u origin feature/i18n` so no feature changes target master.
10. Create or update a PR only on an explicit request and verify the intended
    target branch at that time.
