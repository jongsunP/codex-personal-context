---
name: dentlink-web-e2e
description: Add or modify Dentlink web E2E scenarios and helpers, diagnose failures, and verify reliability across local development and full-suite staging runs, including feedback, repeat execution, setup state, and CI result reporting. Use for web test authoring and maintenance, not native app E2E.
---

# Dentlink Web E2E

## Purpose and sources

Make the full set of currently registered web scenarios on staging a
trustworthy basis for production delivery decisions within that coverage.
Develop and diagnose locally, then verify the identified deployed staging
version as a whole. This does not mean all product features or native apps.

Read `projects/dentlink-client-e2e.md` in the user's Git-backed
`codex-personal-context` for current scope, evidence, and environment details.
Locate the exact product checkout and read its `e2e/README.md`, the canonical
execution, isolation, artifact, and verdict contract; verify it against the
current `package.json`, runner, and Playwright configuration. For additions or
changes, follow its "테스트 추가·변경 절차" and the linked
`.claude/skills/e2e/references/02-spec-writer.md` authoring guidance; discover
current helpers through `01-function-inventory.md`. Use the current request
and available tools, without requiring Claude-specific arguments or tools.
Historical checkpoints and examples provide context; revise
procedures when the user's goal or current evidence requires it. This skill
does not authorize branch, worktree, commit, push, PR, or deployment mutations.

## Reliability decisions

- Expected behavior should pass; deviations should be detected. Expected error
  handling must be asserted so the test itself passes. Declaring expected
  failure with `test.fail()` is blocked as `expected_failure`, not a pass or
  allowed exclusion. Setup failure, no execution, and
  intentionally unset scenarios must remain distinguishable from success.
- Pick evidence that tests the actual failure mechanism. There is no fixed
  pass count or two-run minimum for completion. Do not repeat until green or
  stop merely because an arbitrary number of attempts elapsed. If a genuine
  external dependency blocks progress, retain evidence and identify it.
- Where relevant, reproduce focused/whole-suite differences, UI reload,
  runner restart, and prior-run state effects. Preserve intentional serial
  scenario dependencies while isolating unrelated scenarios and separate runs.
- Validate account/team/auth preparation and runner-owned data/cleanup. Shared
  auth artifacts or accounts can collide even when ports are separate. Verify
  isolation before running potentially conflicting suites concurrently.
- Compare local and staging versions, API targets, configuration, and data
  preconditions. Different real conditions may explain different results;
  unexplained nondeterminism is still unresolved.
- Use UI, API, logs, and traces to distinguish product, test, and environment
  causes. Retry success alone does not prove a test bug. Preserve visibility
  into intermittent product/server defects rather than hiding them with waits,
  reloads, skip conditions, assertion weakening, or retries.
- Wait for the observable readiness or state transition the scenario requires.
  Keep current isolation measures such as dedicated E2E ports only for their
  demonstrated purpose; improve them when evidence warrants it.

## Execution and reporting

For authoring, use the README's requirement-to-title/assertion mapping and
confirm intended cases in the actual plan/report. Report added, removed, or
excluded coverage. Collection-only inspection is diagnostic; use the README's
direct Playwright examples, including the local URL overrides. Collection
consistency, document checks, or delegation do not establish assertion meaning;
review the code and verify actual behavior and affected regressions.

Use the official commands from that checkout:

- `pnpm e2e:clinic`: local full suite against the development API.
- `pnpm e2e:clinic:stg`: full suite on the deployed staging environment.
- `pnpm e2e:clinic:headed` / `pnpm e2e:clinic:headed:stg`: the same local or
  staging runner and verdict, with a visible browser.
- `pnpm e2e:check`: browser-free runner, verdict, lifecycle, and helper
  regressions.

These user-facing environments are local frontend/development API and staging.
Existing development CI retains the runner's internal development support.

Adding a spec path or `--grep` to a batch command records a `focused` run.
Use a whole serial spec when its tests share state. Keep the runner's
reporter/output/config options; consult the README for accepted arguments. Read the new run's
`e2e-runs/<run>/summary.md` and `verdict.json`, then its reports/traces for
causes. `staging_full_verified` is true only for a passing full staging run.

`pnpm e2e:clinic:ui` / `pnpm e2e:clinic:ui:stg` use that same runner through
`--environment local|staging --ui`, with shared environment, target, auth ID,
and owned-process shutdown safeguards. Native selection and Reload remain
available. Stop interrupts the current selection; account locks remain held
for the session.

Each recorded selection's `runs/<id>/report.json` and `runs/<id>/run.json` preserve its
results and common classification of passes, failures, expected failures,
allowed exclusions, nonexecution, and flaky tests. `session.json`,
`lifecycle.jsonl`, and `summary.md` track session state and global setup/teardown.
Recorded failed selections or failed/incomplete lifecycle evidence fail the session;
later success does not erase earlier failures. `session_closed` means normal
closure, not passing tests; `no_tests` means no recorded selection and is not
success. Native JSON/HTML/trace output can be replaced by subsequent selections;
preserved per-selection JSON does not preserve every earlier attachment.
`source-before.json` and `source-after.json` compare session boundary snapshots;
a remaining difference yields `source_changed`, so do not combine earlier
selections into full verification of current source. This does not track every
intermediate edit and revert. Config/module load errors before reporter creation
may appear only in the UI; check those displays too. `session_closed` or exit
code zero does not prove every UI action/error was observed or full scope ran.
These records lack independent full collection, before/after deployed
versions, and full cleanup evidence, so they are not a release verdict. Use the
README's UI section for artifact boundaries and the staging batch verdict for
the production delivery decision within registered coverage.

Official and direct Playwright configuration reject targets outside the
documented local/development/staging URL roots. This checks configured inputs
and version fetches, not every subsequent browser request or a remote app's
embedded API configuration. Runs mutate real test-server data, including when
the frontend is local. Cleanup covers explicit scenario targets and owned
onboarding artifacts, not all server changes.

Auth files are separated by run under `e2e/.auth/runs/<runId>/`. Account locks
block overlapping API/account use on the same host before login; CI concurrency
coordinates only the configured repository/group. Neither is a distributed
lock across developer machines and other CI runners. Coordinate shared account
use, and preserve unverified lock/meta ownership instead of deleting artifacts
to force progress. Use the README for current recovery and UI Reload details.

Use focused runs for diagnosis, then verify affected whole-suite behavior and
the original reexecution trigger. Select additional runs according to remaining
uncertainty and risk. Staging evidence applies to the deployed version only.
Stop when the evidence addresses the observed cause and relevant regressions;
do not chase absolute reliability through unbounded repetitions.

For CI reporting changes, exercise success and failure paths, including setup
errors, empty/incomplete reports, unexpected nonexecution, and flaky results.
Allowed skips must match the registered file, full title, and exact reason in
`scripts/e2e-verdict.js`; report them separately from passes. Missing required
setup and serial follow-up tests that never ran are not allowed exclusions.

Let the user inspect changed files/diffs in the same work folder. Execute
autonomously in a controllable terminal. Show the test UI when useful; use
headless runs and artifacts when appropriate. User command execution is a
fallback for an actual tool limitation, not a fixed workflow step.

Report tested scope/version/environment, observed outcomes, resolved causes,
allowed exclusions, and remaining uncertainty. Keep implementation, local
verification, staging verification, CI adoption, and production delivery
separate. Do not declare reliability solely from a count of passing runs.
