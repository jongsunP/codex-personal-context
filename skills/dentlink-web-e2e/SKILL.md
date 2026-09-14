---
name: dentlink-web-e2e
description: Diagnose, improve, and verify Dentlink web E2E reliability across local development and full-suite staging runs, including feedback, repeat execution, setup state, and CI result reporting. Use for this web testing workflow, not native app E2E.
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
current `package.json`, runner, and Playwright configuration.
Historical checkpoints and legacy repository skills provide context; revise
procedures when the user's goal or current evidence requires it. This skill
does not authorize branch, worktree, commit, push, PR, or deployment mutations.

## Reliability decisions

- Expected behavior should pass; deviations should be detected. Expected error
  handling is a pass when correctly asserted. Setup failure, no execution, and
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

Use the official commands from that checkout:

- `pnpm e2e:clinic`: local full suite against the development API.
- `pnpm e2e:clinic:stg`: full suite on the deployed staging environment.
- `pnpm e2e:clinic:dev`: full suite on the deployed development environment.
- `pnpm e2e:clinic:headed` / `pnpm e2e:clinic:headed:stg`: the same local or
  staging runner and verdict, with a visible browser.
- `pnpm e2e:check`: browser-free runner, verdict, lifecycle, and helper
  regressions.

Adding a spec path or `--grep` records a `focused` run. Use a whole serial spec
when its tests share state. Keep the runner's reporter/output/config options;
consult the README for accepted arguments. Read the new run's
`e2e-runs/<run>/summary.md` and `verdict.json`, then its reports/traces for
causes. `staging_full_verified` is true only for a passing full staging run.
`pnpm e2e:clinic:ui` / `pnpm e2e:clinic:ui:stg` are diagnostic sessions with
selection and Reload; their green UI counts do not replace that verdict.

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
`scripts/e2e-verdict.cjs`; report them separately from passes. Missing required
setup and serial follow-up tests that never ran are not allowed exclusions.

Let the user inspect changed files/diffs in the same work folder. Execute
autonomously in a controllable terminal. Show the test UI when useful; use
headless runs and artifacts when appropriate. User command execution is a
fallback for an actual tool limitation, not a fixed workflow step.

Report tested scope/version/environment, observed outcomes, resolved causes,
allowed exclusions, and remaining uncertainty. Keep implementation, local
verification, staging verification, CI adoption, and production delivery
separate. Do not declare reliability solely from a count of passing runs.
