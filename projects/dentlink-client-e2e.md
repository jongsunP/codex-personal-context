# Dentlink E2E Reliability Checkpoint - 2026-09-11

The latest completed scope includes the official execution path, retained
regressions, operational documentation and real full-suite verification below.
The earlier closeout covered defect fixes/runtime evidence but left implementable
runner integration work. The user required that work to be completed now rather
than deferred as an operating task. This section supersedes earlier completion
claims and source digests; historical evidence remains below.

## Current Implementation And Verification — official runner

- Worktree: `/Users/parkjongsun/Repository/dentlink-client-e2e`, branch
  `feature/e2e-reliability`, HEAD `0e0878ef1c5b1cc2dbec44c57a740e0e072cdad7`.
  There are **30 changed/new files**, all uncommitted. Product commit, push, PR
  mutation and deployment are not authorized and have not occurred. The branch
  still has no upstream; do not pull an invented tracking branch or mutate the
  main checkout. Personal context records evidence, not a transferable product
  code diff.
- The objective remains role-neutral: identify the deployed staging version,
  verify all registered web scenarios, and use the result within its tested
  coverage to support production delivery decisions. Native app E2E is excluded.
  The Clinic project contains 109 tests in 16 files with supporting Lab/Admin
  flows; this is not coverage of every product feature.

### Official execution and retained evidence

- `pnpm e2e:clinic` (local), `pnpm e2e:clinic:stg` (staging),
  `pnpm e2e:clinic:dev` (deployed development), and both headed commands now use
  `scripts/e2e-run.cjs`. The three CI workflows use this same runner and run
  `pnpm e2e:check` before browser installation. CI integration has been statically
  checked but has **not been exercised remotely**.
- Each invocation creates a new ignored `e2e-runs/<timestamp-uniqueid>/` folder.
  `summary.md`, `verdict.json`, `run.json`, plan/report JSON, source manifests,
  remote version snapshots, HTML, traces/screenshots and private logs are retained
  together. Existing output folders cannot be overwritten. Local artifacts are
  not automatically deleted; CI retention remains seven days. Never copy raw
  traces, credentials, tokens or account data into personal context.
- The runner collects the selected inventory, verifies remote versions before
  account-mutating tests, executes Playwright, verifies ending versions/source,
  and produces one exit status and human-readable summary. Zero/missing/incomplete
  results, setup/global errors, unexpected nonexecution/skips, flaky outcomes,
  wrong/changed versions and source changes fail the gate. Five exact exclusions
  remain separate: Referral 1, BP 1 and unset-Default-Scanner account scenarios 3.
- Spec/grep selection is recorded as `focused`; only passing full staging sets
  `staging_full_verified=true`. Reporter/output/project/config and other bypass
  options are protected. UI commands remain diagnostic, supporting multiple
  selections and Reload; use official CLI/headed results for the final verdict.
- Source manifests identify HEAD and changed/untracked file contents. A real Git
  regression found that rename detection could conflate a staged rename with a
  restored original. `--no-renames` now records the deleted original explicitly.
- First interruption requests normal cleanup; a second interruption or 30-second
  grace expiry stops the owned CLI and verified descendant process groups.
  Separate detached servers/browser groups are tracked by PID, parent PID, group
  and start time. Unrelated/reused processes are protected. Unverified cleanup
  remains a failed operational result. Tests cover this with real isolated Node
  processes; a forced interruption of the real browser E2E was not performed.
- `e2e/README.md`, the shared E2E skill and spec-writer reference document the
  commands, scope, interpretation and evidence retention without prescribing an
  operator's job role. Stateful serial specs must run as whole files.

### Verification and scope limits

- `pnpm e2e:check`: **100/100 passed** — verdict/version 27, runner 23,
  onboarding lifecycle 28, signup success transition 5, process ownership/cleanup
  17. These tests are stored in the repository, including three real Node process
  fixtures and actual installed-Playwright report fixtures. No product API or
  browser is required for this command.
- E2E TypeScript, changed-file formatting and `git diff --check` passed.
  Independent reviews covered CI wiring, interruption, process ownership and the
  rename regression; actionable findings were fixed and confirmed.
- A real official CLI run with a deliberately nonmatching grep collected zero
  cases, exited 1 and retained a failure summary without executing test bodies:
  `e2e-runs/2026-09-11T10-19-07-277Z-829c293e/`.
- Initial official staging full passed 104 + 5 allowed exclusions with stable
  versions/source at `e2e-runs/2026-09-11T10-19-50-605Z-5332dc23/`.
  This preceded the final process-cleanup and source-rename changes.
- **Official local full: 104 passed / 5 allowed exclusions**, zero failures,
  flaky outcomes, extra nonexecution or global/report errors; gate passed,
  all 109 planned results accounted for; 7.4 minutes.
  Source digest `9051b1563c5bc27a6775039ff7df7da7190c33e8078a8867da09f709b8f20ec6` was unchanged during this run.
  This includes process cleanup integration and precedes only the final
  `--no-renames` source-identification correction plus its regression test.
  The correction does not change product scenarios; it was verified by the
  real-Git regression and the subsequent final staging full run.
- **Final official staging full: 104 passed / 5 allowed exclusions**, zero
  failures, flaky outcomes, extra nonexecution or global/report errors; gate and
  `staging_full_verified` passed; all 109 planned results accounted for;
  3.6 minutes. Final working-copy digest:
  `6b8a0e35265a09fbc54d19aba51e1ecf0bf784abe95bb37b5f8ee255d0fbd75f` across 30 files, unchanged before/after.
- Final staging snapshots at `2026-09-11T10:40:46.597Z` and
  `2026-09-11T10:44:23.410Z` bracket the actual execution. Clinic BUILD_ID
  `t0PqFwz3pmJ2r2XI8QnpJ`, Lab
  `h89hRMxK80RwI58M-iIMe`, Admin
  `GGdLJ50HcBrXPLB2m4kp0` were unchanged. This is boundary
  equality, not continuous deployment monitoring. Earlier evidence ties this
  Clinic ID to deployment run 34564023735 / commit 28e5e0b; Lab/Admin source SHAs
  are not independently claimed.
- After completion, both development/staging onboarding meta and lock paths were
  absent. No listener remained on owned ports 3100/3105/3102. The main checkout's
  unrelated server was not stopped.
- Read the actual results at:
  - `/Users/parkjongsun/Repository/dentlink-client-e2e/e2e-runs/2026-09-11T10-32-08-960Z-343e4b0e/summary.md`
  - `/Users/parkjongsun/Repository/dentlink-client-e2e/e2e-runs/2026-09-11T10-40-45-910Z-9dffd9d1/summary.md`
  - Regression log: `/tmp/dentlink-e2e-reliability-20260911/official-regression-final.log`

### Next starting point

The previously deferred implementation items 1–3 are now completed: official
execution, retained regressions, and operating guidance with actual verification.
Use the official commands for future runs; the old `/tmp/dentlink-e2e-reliability-20260911/run-suite.cjs` wrapper
is historical and is no longer required. Do not rerun to reach a fixed pass count.
New code, a changed deployment or a new failure warrants proportionate validation.

Remaining delivery gates are product commit/push/PR and actual remote CI adoption,
subject to explicit authorization. Do not imply those have occurred. Additional
feature coverage and the five excluded setup cases remain separately identified
coverage/maintenance work, not failures silently counted as passes.

---

## Earlier Implementation And Verification — before official runner integration

- Active worktree: `/Users/parkjongsun/Repository/dentlink-client-e2e`.
  Branch: `feature/e2e-reliability`; HEAD:
  `0e0878ef1c5b1cc2dbec44c57a740e0e072cdad7`. The implementation is uncommitted
  working-copy changes, not changes contained in that HEAD. Product commit,
  push, PR mutation and deployment are not authorized and have not been done.
- The current Clinic project collects **109 tests in 16 files**. It includes
  Clinic scenarios plus supporting Lab/Admin flows; it does not establish
  coverage of every web/Admin or native feature. Local tests use isolated
  Clinic/Lab/Admin ports 3100/3105/3102 and `.next-e2e`; staging uses the deployed
  sites. Run local and staging sequentially because auth/account state is shared.
- Source manifests identify the final working-copy digest as
  `26c507f75e76b480153a9a73a82a3ba212e6d89ad024d1fe1a751846381ab397`
  across 23 changed/new product-repository files. Final local signup, staging
  signup and staging full runs used this unchanged digest. Earlier local full
  and first staging full runs used
  `71f771bba26538024181b4c9b259896b56752cd8da062f550031a319ea525a9f`,
  before the final signup-wait correction; the local full suite was not rerun
  after that one-function change. Its complete 16-test consumer scope was
  reverified locally instead. Uncommitted implementation remains in this
  worktree; personal context preserves its evidence, not a transferable code diff.

### Implemented Changes

- Three CI workflows now use a shared verdict helper that compares runner
  process outcome, JSON report results/aggregates and the collected test list.
  Setup errors, zero execution, missing results, serial follow-up nonexecution,
  unapproved skips and flaky outcomes fail the gate. Five exclusions are allowed
  only by exact file, test title and reason: Referral 1, BP 1 and the dedicated
  unset-Default-Scanner scenarios 3. Missing mandatory signup, shipment or
  feedback setup now throws instead of skipping a group.
- Version evidence records the source commit and Clinic/Lab/Admin BUILD_IDs
  before and after execution, and binds the report to the same environment,
  API target and site URLs. Version changes, unavailable evidence and a
  different-origin redirect fail the gate. The shared tracked environment
  configuration is used by development and staging CI. The verdict/version
  regression suite passed **27 tests**; independent review findings were
  addressed. The new CI workflows have not yet been run remotely.
- The reproduced global sign-in failure came from selecting `Sign in` when
  the actual submit button is `Log in`; the helper now clicks the scoped login
  form submit control. The DEV ISV catalog lacks `NaturalI`, so its DEV preset
  was corrected while the staging preset was preserved. API diagnostics were
  strengthened to expose relevant request/response failures.
- Onboarding retains its 22 existing serial scenarios but creates a fresh
  office in the file's `beforeAll` for each execution attempt. Global setup
  owns default authentication and the runner lock; exact `ownerRunId` plus
  `attemptId` metadata identifies the file attempt. The parent teardown can
  recover its own worker's leftover attempt, while another runner's metadata
  is protected. Cleanup failure preserves metadata and fails explicitly;
  ambiguous HTTP/schema failures cannot be mistaken for confirmed absence.
  Prefix/age-based bulk office deletion was removed. Browser-close failure
  releases the runner lock/environment ownership and retains the original error.
- An actual UI run exposed HTTP 401 in the active-office check because the
  helper sent a quoted local-storage token. It now normalizes the token exactly
  as the product fetcher does. Saved token values were not logged. Completed
  onboarding state and missing required preparation now produce setup/assertion
  failures instead of suppressing execution with skips.
- The first staging whole-suite run exposed a separate signup preparation
  timeout: send/verify API responses succeeded and the UI showed `Verified`,
  but a nested `codeInput.isDisabled()` inside a poll waited 90 seconds for an
  input removed on verification success. The helper now asserts the persistent
  `Verified` button directly, without adding retry or increasing timeout.
  Error/unsuccessful verification still fails. A six-case isolated regression,
  product-code review and real 16-test consumer runs verified the correction.
- The shared E2E README/skill/references and personal skill source plus installed
  copy now follow the operating purpose below: no fixed pass-count gate,
  retry-success diagnosis shortcut, three-fix stop rule or blanket reload/timeout
  workaround. The objective does not prescribe an operator's job role.

### Runtime Evidence

| Run | Result and interpretation |
| --- | --- |
| `local-baseline` | Global sign-in setup failed; 0 test bodies executed. This reproduced the setup defect and is not a test pass. |
| `local-full-1` | 98 passed, 2 ISV failures, 5 allowed skips, 4 serial follow-up tests not run. This failed run led to the DEV catalog/preset correction. |
| Final local focused (`local-isv-final`) | 11 passed, 3 allowed skips; 0 failure, flaky, nonexecution or report errors; all 14 collected results accounted for. |
| `local-full-final` | **104 passed, 5 allowed skips**; 0 failure, flaky, nonexecution, interruption, unapproved skip or setup/report errors. All **109** collected results accounted for; 8.0 minutes; source hash unchanged. This precedes the final signup-wait correction. |
| First staging full (`staging-full-final`) | 93 passed, 1 signup preparation failure, 5 allowed skips, 10 serial follow-up tests not run; 0 flaky. The gate correctly failed. Versions and source digest were stable. |
| Final local signup (`local-signup-final`) | **16/16 passed**, no skips/failures/flaky; the two complete specs consuming the corrected helper. |
| Final staging signup (`staging-signup-final`) | **16/16 passed**, no skips/failures/flaky; source/version checks passed. |
| Final staging full (`staging-full-after-signup`) | **104 passed, 5 allowed skips**, 0 failure/flaky/extra nonexecution/interruption/preparation or report errors; all **109** planned results accounted for; **3.6 minutes**; source/version checks passed. |

The same onboarding UI runner also exercised the relevant execution boundaries:

| UI boundary | Evidence |
| --- | --- |
| First fixed run | 22/22 passed; fresh office 1628 deleted with HTTP 200. |
| Run All again in the same runner | 22/22 passed; fresh office 1629 deleted with HTTP 200. |
| Final fixed-code Reload | 22/22 passed; fresh office 1631 deleted with HTTP 200. |

- An intermediate Reload had 22 passing leaf results, but an intervening lint
  edit reset the UI aggregate to zero. Keep that observation separate from the
  final unchanged-code Reload evidence above. These runs exercise observed
  lifecycle failure modes; their count is not a completion threshold.
- After the later UI runner was stopped, no onboarding metadata/lock or owned
  local server ports remained. Worker termination/failure recovery boundaries
  also received browser-free stub regression checks; a real forced worker crash
  was not part of these recorded UI passes.
- E2E TypeScript, changed-file formatting/lint and diff checks passed. Browser-free
  regressions separately covered lifecycle ownership, the quoted-token request
  and fail-closed cleanup/global-close handling. These are supporting evidence,
  not substitutes for the recorded runtime runs.
- The first staging failure was initially missed in partial progress-log tails;
  the final aggregate corrected that statement. Subsequent progress checks read
  cumulative result rows across the whole log. Treat final structured reports
  and their plan/version checks as authoritative, not the last visible tests.

### Staging Version Evidence And Next Starting Point

- `staging-full-final` started with version evidence captured at
  `2026-09-11T09:08:59.818Z` (18:08:59 KST): Clinic
  `t0PqFwz3pmJ2r2XI8QnpJ`, Lab `h89hRMxK80RwI58M-iIMe`, Admin
  `GGdLJ50HcBrXPLB2m4kp0`. The Clinic BUILD_ID matches the known deployment
  from [CI run 34564023735](https://github.com/Innvoaid/dentlink-client/actions/runs/34564023735)
  at `28e5e0b`. This deployed product revision is distinct from the uncommitted
  test working copy at HEAD `0e0878ef1`; Lab/Admin BUILD_IDs identify their
  deployments without claiming an independently verified source commit.
- Final whole-suite snapshots at `2026-09-11T09:24:33.566Z` and
  `2026-09-11T09:28:08.987Z` (18:24:33–18:28:08 KST) contain those same three
  BUILD_IDs. They bracket the actual test run and match its environment/API/site
  metadata and source digest. This establishes starting/ending version equality,
  not continuous version monitoring. Final teardown left no onboarding meta/lock
  or owned local server ports.
- Authorized implementation and runtime verification are complete. The product
  working copy is ready for review; committing/pushing it, creating/updating a PR,
  integration/deployment and exercising the new workflows remotely remain separate
  steps requiring explicit authorization. Do not rerun the same matrix solely to
  reach a fixed pass count; new code, failures or a changed deployment justify
  proportionate revalidation.
- The feedback spec's ten scenarios cover initial Bad feedback, changing it to
  Good, attachment persistence, rereading saved feedback and direct-URL entry.
  `isReviewable: false/undefined`, an initial Good POST and attachment-failure
  recovery are additional coverage candidates, not validated cases implied by
  the ten existing tests. Run the complete stateful feedback spec.
- The corrected signup-wait helper also has two one-off `clinic-scripts`
  consumers for permanent-account/environment setup. They were not run as
  regression tests. Current JSON does not reliably label every hook failure;
  the first staging preparation diagnosis came from trace/source evidence,
  while the automated gate retained failed + follow-up-not-run classification.
  Explicit preparation annotations are a possible follow-up, not implemented
  automatic cause inference.
- Detailed local evidence is under
  `/tmp/dentlink-e2e-reliability-20260911/`: `local-baseline.log`,
  `local-full-1.log`, `local-isv-final-verdict.json`,
  `local-full-final-verdict.json`, corresponding `*-source.json` files and
  runtime logs, `ci-verdict-tests.log`, `local-onboarding-ui.log`, and
  `staging-full-final-*`, `local-signup-final-*`, `staging-signup-final-*`,
  `staging-full-after-signup-*`, `signup-verification-diagnosis.json` and
  `verification-summary.md`. Each final run has plan/report/verdict/source
  artifacts, and staging runs also have before/after version snapshots.
  These are temporary local artifacts; the sanitized facts above are the durable
  checkpoint. Do not copy raw traces, credentials, tokens or account data into
  personal context.

## Operating Purpose And Current Scope — clarified 2026-09-11

- This improvement covers web E2E, including feedback. Native app E2E is
  excluded from the current work.
- The operating goal is to verify the full suite against the identified
  staging release before production delivery and provide trustworthy results
  within the tested coverage. Local development and focused checks support that
  workflow; final staging whole-suite evidence is required for delivery decisions.
- Reliability means expected behavior passes and real deviations are detected
  under equivalent, explicit preconditions. Correctly rejecting invalid input
  can be a passing test. A test's own setup, leftover account/data/session
  state, or execution order must not create unexplained outcome changes.
- Compare the execution boundaries relevant to the observed problem: focused
  versus whole-suite runs, UI Reload, runner stop/restart, and local versus
  staging. Record tested and deployed versions; real version/configuration
  differences can justify different results and must be explained.
- There is no fixed run count, including no two-pass minimum, that defines
  completion. Choose sufficient evidence for the change and the failure modes,
  reproduce the original trigger, verify correction and affected whole-suite
  behavior, and disclose unresolved instability. Repeating until green is not
  evidence that a problem is resolved. Historical two-run checks below are
  examples of evidence collected at that time, not a current gate.
- Preserve the intent of existing port isolation (3100/3105/3102), auth/team
  preparation, runner ownership, and cleanup. Inspect whether those measures
  work before retaining or changing them; their history does not make the
  implementation immutable. Suite execution should have predictable preparation
  and cleanup rather than require undocumented manual repair.
- Diagnose product, test, and environment causes from current UI, API, and
  trace evidence. A pass on retry does not establish a test-code fault; it can
  expose an intermittent product or server defect. Do not weaken assertions,
  retry until green, or add skips to hide the cause.
- Report pass, product/test failure, execution/setup error, allowed skip,
  unexpected nonexecution, and flaky results accurately. Intentional unset
  scenarios need explicit reasons. A zero-test/setup failure is not success.
- For this work, IDE visibility is for reviewing edited files and diffs.
  Codex may execute and iterate in its own terminal; visible test UI is useful
  but is not a prerequisite when headless execution with artifacts is better.
- Current personal skill source: `skills/dentlink-web-e2e/SKILL.md`, installed
  by `setup-local-codex.sh`; source and installed copy are aligned. During this
  implementation, the shared `.claude/skills/e2e/SKILL.md` and references were
  also aligned with this purpose. The initial audit's two-pass, retry-success
  and three-attempt-rule findings below are resolved in the current working copy.

## Initial Read-Only Audit — historical snapshot from 2026-09-11

This audit preceded the dedicated worktree and implementation above. It did
not change product files or start tests, servers or CI workflows. Its defects
and preparation state are historical observations, not current operating rules.

- At audit time the web checkout was clean `release/v1.86.0` / `0e0878ef1`,
  identical to its remote, and the main checkout was the only worktree.
- Development and staging collection each found 109 tests in 16 files:
  signup/validation 24, sign-in 3, onboarding 22, orders 26, Lab shipment 6,
  Lab status 12, LinkTalk 1, billing 5 and feedback 10. Collection itself was
  not runtime verification.
- Then-current missing preparation could skip additional groups, including
  all ten feedback tests. This was a defect: required preparation now throws,
  and only the five explicitly approved exclusions can pass the final gate.
- The shared legacy skill then prescribed a two-pass gate, treated retry success
  as proof of a test bug and stopped after three fix attempts. Those operating
  rules have since been corrected in the current implementation above.

### CI Evidence Captured By The Initial Audit

| Run | Commit | Actual result | Feedback |
| --- | --- | --- | --- |
| [develop 34554799750](https://github.com/Innvoaid/dentlink-client/actions/runs/34554799750/job/103128701283), 12:04 KST complete | `01bfc93` | 85 passed, 4 failed, 5 skipped, 15 subsequent tests not run | Test 4: Completed-order feedback question not visible |
| [prior stage 34555286833](https://github.com/Innvoaid/dentlink-client/actions/runs/34555286833/job/103132256089), 12:24 complete | `516c971` | 87 passed, 3 failed, 5 skipped, 14 subsequent tests not run | Test 1: dentist selection timeout in Lab order creation |
| [latest stage 34564023735](https://github.com/Innvoaid/dentlink-client/actions/runs/34564023735/job/103156513198), 14:20 complete | `28e5e0b` | Global setup failed before test bodies; report 0/0/0 | Not run |

- Each Playwright process exited 1 despite automatic workflow/job success.
  That latest stage run timed out clicking Sign in at `e2e/clinic/utils/signin.ts:80`
  from global setup. Its cause was unclassified at audit time; the current local
  reproduction and locator correction are recorded above. Other observed failures
  include ISV option waits, Lab shipment patient GET waits, and an access-request
  account login API 400. These symptoms do not establish product regressions.
- At audit time automatic dev/stage workflows used `continue-on-error: true`
  without final failure propagation. Parsing checked `.stats.unexpected` only,
  ignoring global errors and zero executions; latest stage incorrectly sent
  `All tests passed`. Flaky counts were omitted. Manual stage E2E had a final
  failed-count gate but retained the zero-count global-error gap. The current
  working copy corrects these gaps; it has not been integrated or deployed.
- Those three workflow files matched the inspected release/develop/stage refs.
  Automatic runs include the full Clinic suite and feedback. Artifacts are
  retained for seven days. No workflow was dispatched or rerun during this audit.

## Feature And Execution Boundaries

- Feedback uses ten stateful serial tests; run the complete spec. Historical
  9/8 staging and 9/11 local DEV API 10/10 results are prior-run evidence, not
  proof that later CI passed. Current coverage and data-cleanup gaps are in
  `projects/dentlink-client-order-feedback.md`.
- Native app Detox exists: five files, 21 declarations, no dedicated feedback
  UI E2E, and static Android configuration mismatches. Its current success was
  not verified. App feedback's 53/53 Jest evidence is not native E2E. Details
  remain in `projects/dentlink-app.md`.
- The initial audit proposed correcting CI reporting and investigating
  whole-suite reliability. Current implementation, completed local evidence and
  the pending staging verdict are recorded at the top of this checkpoint.
  Additional feedback coverage remains separately scoped; native app work is
  deferred. Use the operating purpose above to select validation evidence.
- Old worktree names, `codex/` branch examples, IDE-terminal requirements and
  v1.79 expected counts below are historical; use the current common guidance.

## Dedicated Worktree Preparation — 2026-09-11

- The user approved an independently named branch and a dedicated worktree,
  Codex project, and feature session. No Jira is assigned; the selected branch
  is `feature/e2e-reliability`.
- Created `/Users/parkjongsun/Repository/dentlink-client-e2e` from the live
  `origin/release/v1.86.0` at
  `0e0878ef1c5b1cc2dbec44c57a740e0e072cdad7`. At creation the checkout was
  clean with no upstream; preparation did not commit/push product code,
  mutate a PR, deploy, or run E2E.
- The main checkout remains on `release/v1.86.0`. The new worktree is the
  implementation target; the top-level session remains coordinator.
- The user registered the exact worktree as Codex project
  `dentlink-client-e2e`, ID `602e3503-5579-4d51-9f9a-28f4633d1fba`.
- Created task `웹 E2E 신뢰성 개선`, ID
  `01a08f83-fae9-7343-8998-218ce4a9cfec`, host `local`, directly in the saved
  worktree using environment `local`. No duplicate worktree was created.
- The task completed its read-only Git acceptance check. The complete startup
  prompt was delivered automatically as a follow-up and the implementation
  turn is active at top-level closeout. The user also received a copyable
  reference copy and does not need to send it again. Product commit/push,
  PR mutations, environment changes, and deployment remain separately
  authorized operations. No new E2E result is claimed by this handoff.
- At handoff the worktree needed its own dependency/browser preparation. Do not
  copy node_modules, auth, build caches, or reports from another checkout.
  Tracked environment files are already present; the main checkout's ignored
  `lab/.env.local` needs an explicit necessity/override assessment before use.
- Check ownership of 3100/3105/3102 before starting local servers:
  `reuseExistingServer` can silently point tests at another checkout. Local and
  staging runs share auth artifacts, and different worktrees can still share
  server account/team state and onboarding locks.
- The user confirmed the future synchronization model: after v1.86 reaches
  master, a still-active E2E branch can integrate the latest master under an
  explicit synchronization instruction, check its intended PR release, and
  revalidate. A completed/merged feature branch is not reused for new work.
- The top-level session is now a coordination standby checkpoint. Continue
  implementation and runtime work in `웹 E2E 신뢰성 개선`; return to the main
  session for cross-feature decisions, integration/release coordination, or
  final handoff and explicitly requested cleanup.

---

## Historical staging-verification wait checkpoint - 2026-07-22

The following is historical evidence, not the current release state.

- Use `/Users/parkjongsun/repository/dentlink-client`, not a dedicated E2E
  worktree, unless the user explicitly requests another worktree.
- PR [#4411](https://github.com/Innvoaid/dentlink-client/pull/4411)
  (`[DL-15560] ISV Step3 선택 안정화`) was squash-merged into
  `release/v1.79.0` as `6ee361e87` on 2026-07-22.
- Its final source HEAD was
  `fe8126b18 [DL-15560] test: ISV Step3 선택 안정화` and changed only
  `e2e/clinic/steps/order/order-step3-option.ts`.
- The focused staging spec passed twice at
  `7 passed / 3 intentional skipped / 0 failed`; the full 100-test matrix has
  not been rerun after that final fix.
- Current action is to wait until staging contains `6ee361e87`, then use the
  main workspace to run staging Clinic UI full, Reload, full twice and local
  Clinic UI full, Reload, full twice. Each run must reach
  `95 passed / 5 intentional skipped / 0 failed`.
- Do not change E2E code before classifying any failure as version regression,
  existing issue, new scenario, or environment setup.

---

# Dentlink E2E Stabilization

## Repository

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Historical local worktree: `/Users/parkjongsun/Repository/dentlink-client-e2e`
- Jira: `DL-15560`
- Release target: `release/v1.79.0`

## Historical E2E Policy — superseded by the current operating purpose above

- 원래 통과하는 시나리오는 실행 시점이나 반복 횟수와 무관하게 안정적으로 통과해야 한다.
- 원래 실패해야 하는 시나리오는 계속 실패해야 한다.
- 버전업 이후 실패는 버전 회귀, 기존 문제, 신규 시나리오, 환경 세팅 문제로 구분한다.
- 기존 문제는 바로 수정하고, 버전 회귀는 대응하며, 신규 시나리오에 세팅이 필요하면 사용자에게 보고한다.
- 최종 완결 기준은 로컬 전체 2회 연속 통과와 스테이징 전체 2회 연속 통과다.

## Current Checkpoint — 2026-07-20

### Integration State

- 선행 PR [#4387](https://github.com/Innvoaid/dentlink-client/pull/4387)이 `release/v1.78.0`에 머지됐고, 해당 릴리즈 기준 커밋은 `619b1c22b0683d6b489193f1c1c45d503adfb05d`다.
- 후속 작업 브랜치 `codex/DL-15560-turnaround-response-race`는 위 커밋과 정확히 같은 기준에서 생성됐다.
- 핵심 수정 커밋: `f775668a358e50b8d2e9c9c87ac2b3626788339a`
- CodeRabbit 검토 설명 커밋을 포함한 현재 HEAD: `1bf5044718b04230de34a4f53f15349f4a9fe575`
- PR [#4391](https://github.com/Innvoaid/dentlink-client/pull/4391)이 `release/v1.78.0` 대상으로 열려 있다.
- PR은 `APPROVED / MERGEABLE / CLEAN`이며 CodeRabbit 체크가 통과했고 미해결 리뷰 스레드는 0건이다.
- 공유 저장소 작업 트리는 clean이며 브랜치는 `origin/codex/DL-15560-turnaround-response-race`를 추적한다.

### Completed Changes

- React Query v5 이후에도 Step2 상품 쿼리가 카테고리 선택을 따라가도록 `categoryId`를 `watch`로 구독한다.
- 늦게 완료된 폼 초기화가 사용자의 카테고리 선택을 덮지 않도록 주문·초기 카테고리별 초기화와 동기 base reset을 적용했다.
- 기존 주문의 비동기 `caseGroups` 복원은 sequence, category, 값 스냅샷이 모두 같을 때만 반영한다.
- 같은 컴포넌트에서 주문 ID가 바뀌면 새 주문을 정상 초기화하고, 상품 조회가 일시 실패하면 복원을 재시도할 수 있게 했다.
- Step4 날짜 클릭 전에 응답 리스너를 등록해 pickup POST 200 이후 재호출되는 turnaround-date GET 200까지 순서대로 대기한다.

### Verification

- 핵심 수정 기준 로컬 Clinic UI 전체 실행 후 Reload 전체 실행까지 2회 모두 `94 passed`, `5 skipped`, `0 failed`였다.
- 핵심 수정 기준 로컬 Clinic CLI 전체 실행도 별도 2회 모두 `94 passed`, `5 skipped`, `0 failed`였다.
- 최종 독립 리뷰에서 주문 전환, 상품 복원 실패 재시도, 값 스냅샷 경계조건을 추가 보완했다. 이 보완은 신규 주문 E2E 경로의 동작을 바꾸지 않으며 최종 커밋에서 타입·포맷·lint 정적 검증을 통과했다.
- 의도적 스킵 5건:
  - Referral 코드 세팅 대기 1건
  - BP 파트너 키 세팅 대기 1건
  - Default Scanner 미설정 전용 계정 세팅 대기 3건
- 최종 커밋에서 Clinic 타입 검사, Prettier, `git diff --check`가 통과했다.
- 변경 파일 lint는 오류 0건이며 기존 `setMethods` 의존성 경고 1건만 있다.
- push hook의 Clinic/Lab/Admin 타입 검사와 coverage 검사는 통과했다. 전체 lint는 기존 경고 419건, 오류 0건으로 성공했다.
- 최종 경계조건 보완 뒤 기존 주문 편집·동일 페이지 주문 전환에 대한 별도 브라우저 smoke는 실행하지 않았다.
- CodeRabbit의 `splintedToothNumbers` 재지정 제거 제안은 적용하지 않았다. 비동기 복원 중 빈 `caseGroups`를 본 공용 UI effect가 splint를 임시 정리하므로, hydration 시 서버 기준 splint를 함께 복원해야 기존 주문 값이 사라지지 않는다. 코드에 의도를 주석으로 남겼고 CodeRabbit도 설명을 수용해 지적을 철회했으며 스레드를 resolve했다.
- PR #4391 코드는 아직 스테이징에 배포되지 않았으므로 유효한 스테이징 결과는 없다. 배포 전 Step2 실패는 기존 배포본 결과이며 이번 패치 검증으로 보지 않는다.

### Remaining Work

1. PR #4391을 리뷰·머지한다.
2. 해당 커밋이 포함된 `release/v1.78.0`의 스테이징 배포 완료를 확인한다.
3. 스테이징 Clinic UI에서 전체 실행, Reload, 전체 실행으로 2회 검증한다.
4. 스테이징 Clinic CLI도 별도 2회 실행한다.
5. 네 실행이 모두 `94 passed / 5 intentional skipped / 0 failed`이면 E2E 안정화 작업을 완결한다.
6. 실패가 있으면 버전 회귀, 기존 문제, 신규 시나리오, 환경 세팅 문제로 다시 분류한 뒤 대응한다.

### Separate Backlog

- styled-components v6에서 style-only props가 DOM으로 전달되는 경고가 대량 발생한다.
- 현재 E2E 실패와 직접 연결되지는 않았으며 별도 범위로 조사한다.
- Default Scanner 미설정 상태는 기존 계정을 변경하거나 API로 모킹하지 않고, 추후 전용 계정을 만든 뒤 의도적 스킵 3건을 활성화한다.

## Current Checkpoint — 2026-07-21

### Integration State

- Active worktree: `/Users/parkjongsun/Repository/dentlink-client-e2e`
- Current branch: `codex/DL-15560-lab-shipment-photo`
- Current HEAD: `5dc084e7c` (`[DL-15560] fix: 온보딩 실행 잠금 생존 확인 보완`)
- Core E2E commit: `cc37538aa` (`[DL-15560] test: E2E 반복 실행 안정화`)
- Branch is clean and synchronized with `origin/codex/DL-15560-lab-shipment-photo`.
- Latest `origin/master` was merged into the branch without conflicts.
- PR [#4400](https://github.com/Innvoaid/dentlink-client/pull/4400) was squash-merged into `release/v1.79.0` on 2026-07-21.
- Release merge commit: `9a85b3e01` (`[DL-15560] E2E 반복 실행 안정화 (#4400)`). Its tree is identical to source branch HEAD `5dc084e7c`.
- CodeRabbit re-review passed, both inline review threads are resolved, and there are no unresolved review threads.

### Completed Changes

- Lab shipment photo selection now scopes the Patient Photo "No" radio to the exact question block to avoid strict-mode ambiguity.
- Lab status `Pending Order -> New` now reselects turnaround date, waits for `PUT /orders/{id}/additional`, and asserts the response status is `NEW` before proceeding.
- UI reload and overlapping runner lifecycle were hardened so onboarding temporary offices are owned by the creating runner and cleaned by captured teardown state.
- Onboarding auth/meta/lock artifacts are isolated by API + onboarding account fingerprint, preventing local and staging runs from sharing `onboard-meta` or deleting the wrong environment's employer ID.
- Global setup/teardown preserves exact meta when cleanup cannot be proven, retries previous cleanup before creating a new office, and removes owned artifacts only after confirmed cleanup.
- `globalTeardown` config was removed in favor of the `globalSetup` returned teardown closure.
- `process.kill(pid, 0)`의 `EPERM`을 살아 있는 프로세스로 처리해 활성 runner lock을 stale로 오인하지 않도록 보완했다.
- CodeRabbit의 저장소 규칙 제안에 따라 onboarding run 객체 타입 2건을 `interface`로 정리했다.

### Verification

- Commit hook for `cc37538aa` ran clinic/lab/admin TypeScript checks successfully.
- Push hook completed with existing lint warnings (`419 warnings`, `0 errors`) and coverage check unchanged from baseline.
- Local `e2e:clinic:ui` on the final code after merging `origin/master`:
  - Run 1: `94 passed / 5 skipped / 0 failed`
  - Reload + Run 2: `94 passed / 5 skipped / 0 failed`
- Local `e2e:clinic` on the final code after merging `origin/master`:
  - Run 1: `94 passed / 5 skipped / 0 failed` in 6.1m
  - Run 2: `94 passed / 5 skipped / 0 failed` in 5.7m
- Temporary onboarding employers observed during final runs were deleted, and no `dentlink-e2e-onboard-*` lock remained afterward.
- `git diff --check origin/release/v1.79.0...HEAD` passed.
- Review follow-up commit `5dc084e7c`에서 E2E TypeScript, Prettier, `git diff --check`가 통과했다.
- Review follow-up commit hook의 Clinic/Lab/Admin TypeScript 검사가 통과했고, push hook도 기존 lint 경고 419건·오류 0건 및 coverage baseline 변화 없음으로 통과했다.
- CodeRabbit의 환자 사진 질문 공백 제안은 적용하지 않았다. 질문이 형제 `Typography`로 나뉘어 상위 DOM `textContent`가 실제로 `thepatient`로 결합되므로 literal space를 넣으면 locator가 깨진다. 근거를 답변했고 CodeRabbit이 지적을 철회했다.
- Expected intentional skips remain 5:
  - Referral code setup 1
  - BP partner key setup 1
  - Default Scanner unset dedicated account setup 3

### Remaining Work

1. Wait for the user to confirm staging deployment includes release commit `9a85b3e01`.
2. Run staging Clinic UI full, Reload, full using Computer Use for 2 consecutive passes.
3. Run local Clinic UI full, Reload, full using Computer Use for 2 consecutive passes.
4. Each run target is `94 passed / 5 intentional skipped / 0 failed`.
5. Stop each UI runner normally and confirm onboarding teardown removes its temporary employer and releases the lock.
6. Classify every failure as version regression, existing issue, new scenario, or environment setup before changing code.
7. styled-components v6 DOM prop warnings remain a separate backlog item, not a current E2E blocker.

### UI Execution Boundary

- Always use `/Users/parkjongsun/Repository/dentlink-client-e2e` for this E2E work.
- Use only the IDE connected to this worktree and that IDE's existing terminal; do not use another Dentlink worktree or IDE.
- Use Computer Use to operate and observe the Playwright UI runner directly.

## Final Closeout — 2026-07-21

### Integration State

- PR [#4405](https://github.com/Innvoaid/dentlink-client/pull/4405) (`[DL-15560] ISV Step3 및 회원가입 E2E 변경 반영`)이 `release/v1.79.0`에 머지됐고 스테이징에 배포됐다.
- 해당 릴리즈 커밋은 `205b18b2d`이며, 최종 검증 시점의 최신 `origin/release/v1.79.0` HEAD는 `4bed4aece82c3ca152d4cd117fd4b7f651473e13`이다.
- E2E 워크트리는 변경사항 없이 clean하고, 브랜치를 체크아웃하지 않은 detached HEAD 상태로 위 원격 릴리즈 커밋을 정확히 가리킨다.
- 추가 E2E 코드 수정, 커밋, 푸시, PR은 필요하지 않다.

### Final Diagnosis

- 스테이징 ISV Step3의 `Option value price is not found` 400 응답은 E2E 코드 회귀가 아니라 어드민 상품/가격 세팅 문제였다.
- 사용자가 어드민 세팅을 정상화한 뒤 ISV 단독 시나리오 4개가 모두 통과했고, 이어진 전체 반복 검증에서도 같은 문제가 재발하지 않았다.
- 따라서 현재 결론은 환경 세팅 문제 해결 완료이며, 이 실패를 위한 별도 코드 대응은 필요하지 않다.
- 회원가입 테스트 분리 반영으로 전체 테스트 수는 100개, 현재 기대값은 `95 passed / 5 intentional skipped / 0 failed`다.

### Final UI Verification

- 스테이징 `e2e:clinic:ui:stg`:
  - Run 1: `95 passed / 5 intentional skipped / 0 failed`
  - Reload + Run 2: `95 passed / 5 intentional skipped / 0 failed`
- 로컬 `e2e:clinic:ui`:
  - Run 1: `95 passed / 5 intentional skipped / 0 failed`
  - Reload + Run 2: `95 passed / 5 intentional skipped / 0 failed`
- ISV Step3, 주문 Step4, Lab Shipment, Lab Status를 포함해 의도적 스킵 외 모든 UI 시나리오가 로컬과 스테이징에서 반복 통과했다.
- 각 UI runner 종료 후 소유한 onboarding 임시 employer 삭제와 run lock 해제를 확인했다.

### Intentional Skips And Backlog

- 의도적 스킵 5건은 그대로 유지한다.
  - Referral 코드 세팅 대기 1건
  - BP 파트너 키 세팅 대기 1건
  - Default Scanner 미설정 전용 계정 세팅 대기 3건
- Default Scanner 미설정 테스트는 기존 계정 변경이나 API 모킹 없이 추후 전용 계정을 만든 뒤 활성화한다.
- styled-components v6 DOM prop 경고는 별도 backlog이며 현재 E2E blocker가 아니다.

## Next Start Point

1. 현재 DL-15560 E2E 안정화 작업은 UI 완결 기준을 충족했으므로 추가 작업 없이 종료한다.
2. 재개가 필요하면 먼저 `codex-personal-context`와 E2E 워크트리를 pull/fetch하고 최신 `release/v1.79.0` 상태를 확인한다.
3. 새 코드 수정이 필요하면 detached release HEAD에서 직접 작업하지 말고 최신 `release/v1.79.0` 기준의 새 `codex/` 브랜치를 만든다.
4. 추후 남은 작업은 의도적 스킵용 세팅 5건 활성화 또는 styled-components 경고의 별도 조사뿐이다.

## Reopened Checkpoint — 2026-07-21 (PR #4411)

이 섹션은 위 `Final Closeout` 이후 ISV Step3 옵션 구성이 다시 변경되고 반복 실패가 확인되어 재개된 최신 상태다. 다음 세션에서는 위 종료 판단보다 이 체크포인트를 우선한다.

### Integration State

- PR [#4408](https://github.com/Innvoaid/dentlink-client/pull/4408) (`[DL-15560] ISV Step3 옵션 이관 원복`)이 `release/v1.79.0`에 머지되고 스테이징에 배포됐다.
- 새 작업 브랜치 `codex/DL-15560-isv-step3-ready`는 당시 최신 `origin/release/v1.79.0` 커밋 `c6da49ba375f0d1c58a0fb710bd43db745797e99`에서 생성했다.
- 수정 커밋은 `fe8126b189752062bdbf8a44b117e530efad70f1` (`[DL-15560] test: ISV Step3 선택 안정화`)이다.
- PR [#4411](https://github.com/Innvoaid/dentlink-client/pull/4411) (`[DL-15560] ISV Step3 선택 안정화`)을 `release/v1.79.0` 대상으로 생성했다.
- 마지막 확인 시 PR은 `OPEN / non-draft / MERGEABLE`이며 `mergeStateStatus: BLOCKED`다. CodeRabbit과 `add-reviews` 체크는 모두 통과했으므로 코드 충돌이나 체크 실패가 아니라 필수 리뷰/승인 상태를 다음 세션에서 확인해야 한다.
- E2E 워크트리는 브랜치 `codex/DL-15560-isv-step3-ready`, HEAD `fe8126b18`이며 `origin/codex/DL-15560-isv-step3-ready`와 동기화된 clean 상태다.

### Latest Diagnosis And Changes

- 사용자가 배포 후 실행한 전체 100개 테스트에서는 아래 ISV 실패 외 별도 이상이 없었다.
- 실패 위치는 `e2e/clinic/specs/03_orders/step4-ui-state.spec.ts`의 첫 ISV Step4 진입 테스트였다. Step3 `PUT /orders/{id}/option` 응답이 발생하지 않고 90초 타임아웃이 났다.
- 실패 화면에서는 필수 Treatment Preference 중 하나가 사라져 `Required information is missing.` validation이 발생했다.
- React Hook Form의 `useFieldArray.update`가 옵션 필드를 재마운트하는 동안 상·하위 필수 선택이 초기화될 수 있으므로, E2E가 각 클릭 뒤 이전 버튼의 detach와 새 선택 요약 반영을 기다리도록 수정했다.
- 선택 트리 갱신이 끝난 뒤 누락된 필수 옵션만 계층 순서대로 복구하고, 최종 안정 구간 후 모든 선택이 동시에 유지되는지 검증한다.
- `Natural` 요약 검증이 기존 `Natural I`를 부분 일치로 오인하던 직접 원인도 확인했다. 요약값 끝까지 정확히 일치하도록 바꿔 Preferred Shade 누락을 실제로 탐지한다.
- Step3 validation이 보이면 존재하지 않는 저장 응답을 90초 기다리지 않고 `Order option step validation failed`로 즉시 원인을 표시한다.
- 변경 파일은 `e2e/clinic/steps/order/order-step3-option.ts` 한 개뿐이며 실제 Clinic 앱 코드는 수정하지 않았다.

### Verification

- 최종 코드로 스테이징 `step4-ui-state.spec.ts` 전체를 IDE 터미널에서 2회 연속 실행했다.
  - Run 1: `7 passed / 3 intentional skipped / 0 failed`
  - Run 2: `7 passed / 3 intentional skipped / 0 failed`
- 해당 파일의 의도적 스킵 3건은 Default Scanner 미설정 전용 계정 세팅 대기 테스트다.
- E2E TypeScript 검사, Clinic 전체 TypeScript, Prettier, 변경 파일 ESLint, `git diff --check`가 통과했다.
- commit hook의 Clinic/Lab/Admin TypeScript 검사가 통과했다.
- push hook은 기존 lint 경고 `419 warnings / 0 errors`와 coverage baseline 변화 없음으로 통과했다.
- 각 반복 실행의 onboarding 임시 employer가 teardown에서 삭제됐고 lock 파일은 남지 않았다.
- 최종 수정 이후 전체 100개 테스트는 아직 다시 실행하지 않았다. 사용자의 직전 전체 실행에서 본 ISV 한 건 외 별도 이상이 없었다는 결과와, 수정 후 관련 스펙 2회 통과까지만 확정 상태다.

### Remaining Work / Next Session Start

1. 먼저 `codex-personal-context`와 `/Users/parkjongsun/Repository/dentlink-client-e2e`를 pull/fetch한다.
2. 브랜치 `codex/DL-15560-isv-step3-ready`, HEAD `fe8126b18`, PR #4411의 실제 상태와 CodeRabbit/review/check를 확인한다.
3. CodeRabbit 지적이 있으면 E2E 정책에 맞는지 판단해 반영 또는 근거를 답변하고 스레드를 resolve한다.
4. PR #4411이 merge 가능하면 사용자에게 보고한다. 사용자가 머지·스테이징 배포 완료를 알리기 전에는 release 기준 최종 스테이징 검증으로 간주하지 않는다.
5. 머지·배포 후 `release/v1.79.0`을 pull하고, 반드시 `dentlink-client-e2e` IDE와 그 IDE의 기존 터미널만 사용해 스테이징 UI 전체 실행 → Reload → 전체 실행을 2회 검증한다.
6. 새 helper가 로컬 환경의 Crown/Ideal 옵션에도 회귀를 만들지 않았는지 로컬 UI 전체 실행 → Reload → 전체 실행 2회도 검증한다.
7. 전체 기대값은 각 실행 `95 passed / 5 intentional skipped / 0 failed`다. 엄격한 기존 4-command 검증 매트릭스를 마무리할 경우 `e2e:clinic:stg`와 `e2e:clinic` CLI도 각각 2회 실행한다.
8. 실패가 나오면 바로 수정하지 말고 버전 회귀, 기존 문제, 신규 시나리오, 환경 세팅 문제로 먼저 분류한다.

### Unchanged Intentional Skips And Backlog

- 의도적 스킵 5건은 Referral 코드 1건, BP partner key 1건, Default Scanner 미설정 전용 계정 3건이다.
- Default Scanner 미설정 테스트는 기존 계정 변경이나 API 모킹 없이 추후 전용 계정을 만든 뒤 활성화한다.
- styled-components v6 DOM prop 경고는 별도 backlog이며 현재 E2E blocker가 아니다.
