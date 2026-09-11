---
name: dentlink-web-e2e
description: Diagnose, improve, and verify Dentlink web E2E reliability across local development and full-suite staging runs, including feedback, repeat execution, setup state, and CI result reporting. Use for this web testing workflow, not native app E2E.
---

# Dentlink Web E2E

## Purpose and sources

Make the full staging suite a trustworthy basis for production delivery
decisions within the tested coverage. Develop and diagnose locally, then
verify the identified deployed staging version as a whole.

Read `projects/dentlink-client-e2e.md` in the user's Git-backed
`codex-personal-context` for current scope, evidence, and environment details.
Locate the exact product checkout and use its current code/configuration.
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

Use focused runs for diagnosis, then verify affected whole-suite behavior and
the original reexecution trigger. Select additional runs according to remaining
uncertainty and risk. Staging evidence applies to the deployed version only.
Stop when the evidence addresses the observed cause and relevant regressions;
do not chase absolute reliability through unbounded repetitions.

For CI reporting changes, exercise success and failure paths, including setup
errors, empty/incomplete reports, unexpected nonexecution, and flaky results.
Allowed skips need a documented reason; report them separately from passes.

Let the user inspect changed files/diffs in the same work folder. Execute
autonomously in a controllable terminal. Show the test UI when useful; use
headless runs and artifacts when appropriate. User command execution is a
fallback for an actual tool limitation, not a fixed workflow step.

Report tested scope/version/environment, observed outcomes, resolved causes,
allowed exclusions, and remaining uncertainty. Keep implementation, local
verification, staging verification, CI adoption, and production delivery
separate. Do not declare reliability solely from a count of passing runs.
