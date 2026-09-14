# Dentlink E2E Reliability Checkpoint - 2026-09-14

## Session Closeout — 2026-09-14 16:59 KST

- The user confirmed that they performed the merges and initiated staging
  deployment, then requested session closeout and durable memory maintenance.
  Approved implementation, review fixes, verification, maintained documentation
  and skills, commits/pushes and PR delivery are complete. There is no known
  outstanding code or documentation fix in the agreed scope.
- At closeout, all three exact-SHA staging workflows below were still in
  progress; Clinic/Office was in `build-and-push`. New deployment completion and
  its whole-web-E2E verdict are **not yet verified**. Do not treat the earlier
  successful staging runs as evidence for this newly deployed release.
- Next resume: pull personal context, verify live product refs and these exact
  workflow IDs, then inspect deployment and E2E jobs/artifacts independently.
  If a new failure exists, classify build/deployment, setup/account/environment,
  product assertion, nonexecution, flaky and allowed exclusions before deciding
  on a fix. Record the tested deployment versions and scenario scope with the
  result. No automatic monitoring or additional test run was started at closeout.
- Product worktree is clean and remote-synchronized at `f267c4924`. The sibling
  main checkout remains on local `release/v1.86.0` at `0e0878ef1` and must be
  refreshed before reuse. Both worktrees, branches, existing evidence and the
  user's local UI were preserved; no product file changed during closeout.
- Detailed decisions, validation and remaining limitations are retained below.
  Personal progress is canonical here, with a short coordination entry in
  `projects/dentlink-fe.md`; no additional shared-project session document is needed.

## Current Delivery — release integrated and staging deployment started

- The user merged E2E PR [#4606](https://github.com/Innvoaid/dentlink-client/pull/4606)
  into `release/v1.86.0` at 2026-09-14 16:51:06 KST. Its squash commit is
  `c506661e612b7105a7c8b73f32b96f39ee10b41c`, including the reviewed local-log follow-up.
- The user explicitly authorized deleting remote `stage`, recreating it from
  current remote `master`, and opening `release/v1.86.0 -> stage`. The old stage
  `28e5e0b1ef5ba43c620350e90eaa0fc751db7791` was deleted with an exact lease;
  stage was recreated with a must-not-exist lease at master
  `ddeeb1e868c64f3e1047170f6bc6282a9646ed97`. Both remote refs were verified equal
  before PR creation. Push hooks passed without bypass; only a command-local SSH
  push URL override was used. No local checkout, sibling worktree or protection changed.
- Created [PR #4607](https://github.com/Innvoaid/dentlink-client/pull/4607),
  `[Release] v1.86.0 스테이징 재배포`, with release head `c506661e6` and stage base
  `ddeeb1e86`. It contains the complete release: 16 commits and 188 changed files,
  including other service changes as well as E2E. An independent merge-tree check
  had no conflicts and exactly matched the release tree. All three app path
  filters were covered. This is merge evidence, not runtime QA.
- During final verification, the user (`jongsunP`) had already merged #4607 at
  16:55:48 KST. Live remote `stage` is now merge commit
  `2ce6c29d412f47976f74326b2202bca4b2c123af`; master and release remain unchanged.
  The agent did not merge the PR or dispatch a workflow.
- Exact-merge-SHA Actions started at 16:55:51 KST and were **in progress** when
  checked: Office/Clinic run `34820155085`, Lab `34820155047`, Admin `34820155051`.
  Deployment completion and post-deployment E2E results remain unverified. The
  earlier staging results below belong to their recorded sources/deployments.
- Next: inspect those exact Actions and their actual deployment/E2E outcomes.
  The E2E worktree remains clean on `feature/e2e-reliability` at `f267c4924`;
  preserve it and the user's existing local UI unless cleanup is requested.

## Completed Follow-up — CodeRabbit review and local server logs

- The user requested the complete CodeRabbit review cycle for PR
  [#4606](https://github.com/Innvoaid/dentlink-client/pull/4606), then also
  authorized fixing repetitive local `e2e:clinic:ui` web-server output. The user
  confirmed their own local UI tests passed before requesting the log improvement.
- Current product HEAD is `f267c4924440cfd620edd0f92d92a36d48608a2b`, clean and
  synchronized with `origin/feature/e2e-reliability`. At this checkpoint, PR #4606
  targeted `release/v1.86.0`, with the same title and 49-file overall scope.
  Subsequent release integration and staging progress are recorded above.
- Commit `99f4780c8c555520589c64f90d45ffd1e421b14b`
  (`test: 배포 준비 실패와 온보딩 오류 진단 보완`) fixed both valid minor findings:
  DEV/STG E2E wait steps now reject empty BUILD_ID before curl/sleep, and the
  onboarding shared page attaches the existing API monitor with beforeEach reset
  and afterEach failure annotation. Both threads were answered with validation
  and resolved. CodeRabbit completed that revision successfully with zero
  unresolved threads. No existing build/deploy job or service code changed.
- Review-fix validation: actual workflow shell before/after comparisons passed
  eight empty/matching/mismatched boundaries; shared-page real hook/monitor
  isolation verified 401/403/5xx/network diagnostics, masking, reset isolation,
  timeout and unchanged passing verdict. Regressions were **211/211**, and
  staging onboarding passed **22/22** with no skip/flaky/nonexecution and stable
  targets/source. Evidence: `e2e-runs/2026-09-14T07-13-44-755Z-9990a977/`, source
  `f3622c096aa7a33af053325456d9421f4a872067bef038aec70da151be440cd8` before commit.
  This was focused evidence, not a new whole-suite deployment verdict.
- Commit `f267c4924` (`test: 로컬 웹 서버 로그를 실행별 파일로 분리`) adds local-only
  `webservers/{clinic,lab,admin}.log` under each run. The runner creates directory
  0700/files 0600, rejects preparation failure, clears inherited log overrides,
  and records paths in run/session manifests, initial output and summaries.
  The existing webServer commands append stdout/stderr to these files and emit
  only path notices. UI Reload preserves earlier raw logs; URL readiness,
  nonzero startup exits, test verdict and owned-process cleanup remain intact.
- Cause: Next 16.2.7 forwards browser console warnings/errors to server stderr;
  Playwright 1.60 forwards that stderr through its native UI reporter/stdio
  channel. Redirecting the outer launcher alone cannot quiet the UI. This change
  preserves raw evidence without modifying ChannelTalk/service behavior or
  adding commands/scripts/dependencies. Direct Playwright retains its prior
  output behavior; remote development/staging has no local-server log setup.
- Log validation: **219/219** regressions, E2E TypeScript, JS syntax, formatting,
  skills and independent review passed. Actual isolated native UI with synthetic
  HTTP servers verified path-only UI output, raw stdout/stderr preservation,
  quoted paths, Stop, Reload append/restart, startup failure and owned-server
  termination. Evidence: `/tmp/dentlink-ui-webserver-log-PbhjMF/`.
  Product APIs were not used for this log-only validation. The user's existing
  local UI/servers were left running; recheck their ownership before real runs.
  A new launcher invocation is needed to apply the new log environment.
- Both follow-up commits passed all three app type/lint hooks (existing warnings),
  shared tests **27/27** and coverage comparison. SSH was used with the same
  command-only push URL override; no hook was bypassed. The tested changed-file
  contents matched each resulting commit. Log-change pre-commit source digest:
  `dad18fe37d08d92e142cfb451637861e5c990be144730cec1e3aeb80cf069c8c`.
- Shared README/skill and the personal skill source/installed copy are aligned.
  The final PR description distinguishes the initial whole-staging evidence,
  review-fix focused staging evidence, and isolated log/UI evidence.
- Final live verification: CodeRabbit status for exact head `f267c4924` is
  **success / Review completed**, and the complete paginated thread listing has
  **zero unresolved threads**. This requested review cycle is complete. Vercel
  remains failure with `Deployment was blocked`; this is separate from the
  earlier explicit author-access failure and E2E results. Human approval, merge,
  deployment and remote E2E execution were not completed at that checkpoint.

## Initial Delivery — committed, pushed and release PR opened

- The user explicitly authorized committing/pushing the completed changes and
  creating a PR into `release/v1.86.0`. Commit
  `ec96beedab032982f23eeb5a87a2500de24188f2` (`test: 웹 E2E 실행과 결과 검증 신뢰성 개선`)
  contains all 49 approved files. `feature/e2e-reliability` is clean and tracks
  `origin/feature/e2e-reliability`, with no ahead/behind difference.
- PR [#4606](https://github.com/Innvoaid/dentlink-client/pull/4606),
  **웹 E2E 실행과 결과 검증 신뢰성 개선**, was open and non-draft at creation. Its base was
  `release/v1.86.0` at `1e0754789fd5d3ed250990e05c4582a820b30abe`; its head matches
  the commit above. The release gained one unrelated service wording change
  since this worktree's base. A merge-tree simulation succeeded without conflict;
  the merged result adds only the same 49 E2E/config/docs files to the release.
- Commit hook: Clinic/Lab/Admin type checks passed. Push hook: all three app
  lints had zero errors and existing warnings; shared tests passed **27/27** and
  coverage comparison had no change. The first push lacked the ignored local
  `coverage-baseline.json`; the existing command created it from the tested,
  unchanged service sources. All hooks then passed without being bypassed.
- HTTPS authentication lacked GitHub's `workflow` scope, so the remote rejected
  workflow-file updates. Existing SSH authentication verified the same `jongsunP`
  account and completed the push using a command-only `remote.origin.pushurl`
  override. No persistent remote/auth configuration was changed.
- The pre-commit verified source digest below is historical: committing changes
  HEAD and therefore the runner's source digest. All 49 committed file contents
  were individually checked against that verified snapshot and matched exactly.
  No additional full staging run was claimed after the commit.
- Initial PR checks: Auto Assign and Vercel Preview Comments succeeded;
  CodeRabbit was reviewing. Vercel's deployment status failed with
  `Git author jongsunP must have access to the project on Vercel to create deployments.`
  GitHub reported `MERGEABLE` with merge state `BLOCKED`. These are observed PR
  states, not review approval or E2E failures; refresh them before follow-up.
- Next: inspect the PR's review/check results. Handling CodeRabbit threads is
  authorized when the user requests that review cycle. Team approval, release
  merge, deployment, and actual remote E2E CI remain separate gates. None was
  performed as part of this commit/push/PR request.

## Current Completed Scope — command scope and UI execution contract

The user approved completing all discussed but unfinished follow-ups. Their UI
question was an engineering review request: assess why UI differed and choose
the direction best supported by the existing workflow, trustworthy results and
maintenance cost. Do not reinterpret it as an unconditional demand to make UI
identical to batch execution. Manual operation remains local frontend plus DEV
API, or the deployed staging frontend plus STG API.

- Removed the unrequested `e2e:clinic:dev` package alias and current manual-use
  guidance. Existing DEV deployment CI predates this work; its internal
  `--environment development` compatibility and improved verdict remain.
- Both local/staging UI commands now use `e2e-run.js --ui`, sharing environment
  initialization, exact targets, fresh auth ID and owned-process interruption
  protection with CLI/headed. No new script file or service dependency was added.
- Native UI selection, Run All, Stop and Reload are preserved. Each observed
  selection archives native JSON in `runs/<id>/`, then uses the common verdict
  classifier for passes, expected failures, allowed exclusions, nonexecution and
  other failures. Successful selection wording never claims full deployment QA.
  Later reruns do not overwrite prior failures or reports. Native HTML/trace
  outputs can still be refreshed; archived JSON is not an immutable attachment copy.
- UI setup/teardown writes a private, append-only lifecycle journal. A native
  UI exit 0 cannot hide observed setup/cleanup failures, incomplete cleanup or
  absent evidence. UI session `session_closed` is a session status, not a full
  test verdict. Stop retains session account locks; Reload/close performs global
  cleanup. Sessions with no recorded tests do not pass.
- Source state is recorded before/after UI sessions; changes prevent treating
  older selection results as verification of closing source. Boundary comparison
  does not trace intermediate edit/revert history. Config/module errors before
  reporter creation may appear only in native UI; recorded selections do not
  claim complete observation of all UI actions. Release proof remains the full
  batch contract with independent inventory and deployed-version evidence.
- Installed Playwright 1.60 investigation justified these boundaries: reporter
  onBegin is not awaited, setup/teardown has separate UI lifetime/reporters, and
  UI green counts do not reflect a reporter's final failed override. Actual
  isolated UI reproduced Reload continuing after teardown failure. UI also
  forwards CLI reporter comma text as one reporter name, so UI reporters are
  configured as an array in Playwright config; batch config remains unchanged.
- Verified implementation source digest before the delivery commit was
  `671bb59c6f5c2a52b34c089e03c0dbcec42aada4b4fa4a273dea8d78647ee9d8`.
  At that verification it was 49 uncommitted files on `feature/e2e-reliability`,
  HEAD `0e0878ef1`. The subsequently authorized commit/push/PR is recorded above.
  Product app paths, dependencies, and existing DEV/STG build/deploy jobs remain
  unchanged by this work.

### Follow-up verification

- Browser-free regressions **211/211**, syntax **10/10**, E2E TypeScript,
  formatting, references and independent side-effect review passed. Shared guide
  and skills agree, and the personal skill source/installed copy match and pass
  validation. Existing formatter-option warnings remain baseline.
- Isolated real Playwright UI covered two successful runs, expected failure,
  unapproved skip, Stop after entering the test body, Reload cleanup failure and
  session interruption. Five distinct JSON reports were retained; later cleanup
  success did not erase failure. Source snapshots and process cleanup were also
  checked. Latest evidence:
  `/tmp/dentlink-ui-runner-integration-7V6MVI/integration-summary.json`.
- Real staging native UI: **25/25 login/onboarding**, **3/3 selected rerun**,
  **3/3 after Reload**. Native window close completed with process/session exit 0,
  `session_closed`, two complete setup/teardown attempts, no recorded issue and
  unchanged source. Evidence:
  `e2e-runs/2026-09-14T06-17-07-533Z-57a543bf/`.
- Real local native UI: **25/25 login/onboarding** and **3/3 after Reload**.
  Native window close completed with process/session exit 0, `session_closed`,
  two complete setup/teardown attempts, unchanged source and no recorded issue.
  All local E2E listeners on 3100/3105/3102 were absent after closure. Evidence:
  `e2e-runs/2026-09-14T06-20-36-152Z-0b65a9af/`.
- Final batch staging: **104 passed + 5 allowed exclusions**, all 109 planned
  and reported, 104 executed, zero failure/expected-failure/flaky/nonexecution,
  no verdict issue, gate and `staging_full_verified` true, exit 0. Evidence:
  `e2e-runs/2026-09-14T06-26-44-006Z-ca2c46d1/`,
  `2026-09-14T06:26:44.007Z` to `2026-09-14T06:30:27.225Z`.
  Source remained `671bb59c6f5c2a52b34c089e03c0dbcec42aada4b4fa4a273dea8d78647ee9d8`.
  Stable Clinic/Lab/Admin BUILD_IDs were `t0PqFwz3pmJ2r2XI8QnpJ`,
  `h89hRMxK80RwI58M-iIMe`, `GGdLJ50HcBrXPLB2m4kp0` respectively.
- Real staging UI, local UI and final full staging were sequential. Final
  account/auth/onboard lock and reclaim files: **0**; onboarding recovery meta:
  **0**; listeners on 3100/3105/3102: **0**. Private auth and result artifacts
  remain available; they were not claimed deleted. No product source changed
  during these runs, and all three used separate private auth directories.

All approved follow-up implementation, proportionate verification and maintained
documentation/skills are complete within these evidence boundaries. Commit,
push and PR creation are now complete as recorded above. Review, release
integration and actual remote CI execution remain separate delivery gates.
Future runs must establish their own source, target version and scope.

## Previous Completed Scope — sustainable authoring and result contract

### Latest decision — E2E scripts use .js CommonJS

The user explicitly requested renaming only the ten newly added
`scripts/e2e-*.cjs` files, including the five test files, to `.js`. CommonJS
implementation is retained. The decision follows the existing `.js` CommonJS
scripts: root package.json has no `type`, scripts/package.json is absent, and no
current Node/Playwright compatibility constraint requires the new extension.
This is a project-continuity choice, not a claim that .cjs is unsupported.

- All ten file names, mutual require/require.resolve and CLI/help references,
  package commands/test glob, Playwright import, three CI commands, maintained
  guides and both personal skill copies now use `.js`. The README records the
  convention. Unrelated .cjs/.mjs files and explicit temporary CommonJS fixtures
  were not renamed; historical run artifacts were not rewritten.
- A pre-change content/hash snapshot verified preservation of the existing
  uncommitted work. Script contents differ only by the intended filename-reference
  substitutions. Current source has no remaining reference to those old names.
- `node --check`: **10/10 passed**. Updated `pnpm e2e:check`: **187/187 passed**.
  E2E TypeScript, formatting, diff checks, direct runner help, document links and
  both personal skill validators passed. Independent review found no module or
  test-discovery compatibility problem. Existing service code and dependencies
  remain unchanged, and the prior four order-helper lint errors are baseline.
- Current source digest is
  `396631c7a55efe9b11b1d96f042ff522478d9af175119f8ff75ecfb821e3a775`,
  still **49 changed/new product files**, uncommitted on the same branch and HEAD.
  The real local/staging/DEV results below were obtained immediately before this
  extension-only follow-up. Their original source digests remain recorded. Per
  the user's explicit verification scope, no full staging rerun was added solely
  for this rename; the original runtime verification plan was already completed.
- Product commit/push/PR/deployment authorization was not expanded. The remaining
  delivery boundary is still shared-repository integration and actual remote CI.

### Reliability review and implementation

The user asked whether agent/skill-based authoring would keep the same reliability
principles over time, and explicitly prioritized a sound foundation over speed.
The prior completion statement was too broad: this deeper review found additional
false-success paths and instruction-discovery gaps. The September 14 safety-phase
evidence below remains valid for its recorded source digest, not these new edits.

- Product HEAD and branch remain unchanged; changes are uncommitted and there is
  no upstream. No product commit, push, PR or deployment is authorized by this
  review. No Clinic/Lab/Admin/shared feature source or dependency change is made.
- `AGENTS.md`, root README and `claude.md` route E2E work to the canonical
  `e2e/README.md` authoring/change procedure. Existing shared writer/inventory
  references and the personal skill use that same contract. No new skill adapter
  or duplicate rule document is introduced.
- Authoring maps requirements to files, full test titles and meaningful UI/API
  assertions, then checks actual collected/executed evidence and reports added,
  removed and excluded scope. Discover current specs/helpers instead of using
  stale fixed lists. Current conversation input and available tools are supported;
  `$ARGUMENTS` or a particular Claude agent API is not a prerequisite.
- Actual installed Playwright reproduced `test.fail()` counting a broken
  assertion as an expected outcome with process exit 0. The release verdict now
  counts active expected-failure declarations separately, never as passes, and
  blocks with `expected_failure`. Correct assertions of error handling still pass.
- Actual installed Playwright reproduced config/project grep filtering both plan
  and execution while the official runner labeled it full. A small scope reporter
  captures resolved Clinic filters for both phases; full runs require valid,
  current evidence and unfiltered settings. CLI selection remains focused.
- Required Request Access pending-employee cleanup and default-team restoration
  now propagate failures. Request Access validates all pages (100 rows per page,
  at most 20 pages), stable totals, complete rows and distinct IDs before choosing
  the exact single pending employee. Partial/invalid evidence causes no deletion.
  Context cleanup still runs and independent failure
  causes remain visible. Remote DEV Lab shipment material selection follows
  `E2E_ENV`, rather than the `NODE_ENV=staging` used to disable local servers.
- Existing `tryWithdrawE2eAccountViaApi` is a best-effort auxiliary cleanup, not
  proof of successful withdrawal. Step 2/3 validation does not create an account;
  full signup has a separate asserted withdrawal flow. Its absence/authentication
  ambiguity is not resolved by inventing an API contract or expanding deletion.
- Runtime gates verify the registered execution contract, not whether all product
  requirements were authored or assertions are semantically correct. Registration
  changes such as deletion, testIgnore or conditional definitions require scope
  review. Local account locks are not distributed locks across separate hosts.
- Package changes connect official E2E commands to the common runner and add DEV
  and regression-check commands. UI remains a selection/Reload diagnostic surface
  with target/isolation safeguards; its green counts do not replace full verdicts.

### Follow-up verification — 2026-09-14

- **187/187 regression checks passed** after the final edit: runner 36,
  verdict/version 35, lifecycle/signup 99, process-tree 17. E2E TypeScript,
  script/document formatting and diff checks passed. All changed TS consumers
  were linted; the four existing `no-empty-function` errors in order-setup remain
  baseline. The new Request Access non-null warning was removed and that spec
  passed ESLint with `--max-warnings=0`.
- Independent reviews found and then verified the fixes for expected failures,
  config filtering, cleanup error propagation and Request Access pagination.
  Scope reporting and all changed cleanup consumers have no remaining actionable
  review finding within the inspected scope.
- **Official local full: 104 passed + 5 allowed exclusions**, all 109 planned
  and reported, zero failure/flaky/nonexecution/global errors, gate true,
  473.1 seconds. Evidence:
  `e2e-runs/2026-09-14T05-16-33-868Z-70138db3/`,
  `2026-09-14T05:16:33.869Z` to `2026-09-14T05:24:28.412Z`.
  Source was unchanged within the run:
  `db7a1ac6f71ef62edd9cf2e2550b56f83d6d32ae8b6ae774eda8d45238578659`.
- After local verification, the only product edit replaced `expectedTotal!` in
  the pagination row-count expression with the already validated and identical
  `listBody.totalElements`, removing a lint warning. The regression suite and type
  checks were rerun successfully. Do not claim the two source digests are equal.
  Worktree before the extension follow-up: **49 changed/new files**, source
  `fe488e06259cc16ce40d0c9b842a5d658dbe88984676cc3594681e91c2c2f53c`.
- Maintained Markdown, local links and diagnostic shell syntax were checked.
  Both personal skill source and installed copy passed the actual skill validator
  and matched exactly; the shared Claude frontmatter was checked separately.
- **Official staging full: 104 passed + 5 allowed exclusions**, all 109 planned
  and reported, zero failure/flaky/nonexecution/global errors, gate and
  `staging_full_verified` true, 220.7 seconds. Evidence:
  `e2e-runs/2026-09-14T05-25-12-819Z-221222e9/`,
  `2026-09-14T05:25:12.820Z` to `2026-09-14T05:28:54.729Z`.
  Final source `fe488e06259cc16ce40d0c9b842a5d658dbe88984676cc3594681e91c2c2f53c`
  was unchanged; scope evidence from both collection and execution is valid.
  Clinic/Lab/Admin boundary BUILD_IDs remained respectively
  `t0PqFwz3pmJ2r2XI8QnpJ`, `h89hRMxK80RwI58M-iIMe`,
  `GGdLJ50HcBrXPLB2m4kp0`. This checks the two boundaries, not continuous
  monitoring or backend build identity.
- **Deployed DEV shipment focused: 6/6 passed**, covering the corrected catalog
  branch through order creation, shipment/pickup creation, cancellation and
  shipment editing. Evidence:
  `e2e-runs/2026-09-14T05-29-07-632Z-72a77578/`,
  `2026-09-14T05:29:07.646Z` to `2026-09-14T05:29:40.479Z`, 31.0 seconds.
  Final source was unchanged, scope is focused, and `staging_full_verified` is
  false as intended. DEV boundary BUILD_IDs remained Clinic
  `swqceb-QF-_KF8-FWiBLA`, Lab `EMsE1YefjnEWt3b1tnLyJ`, Admin
  `08egjyCFC1uTRVbpVX4HQ`. This is not a whole DEV suite result.
- Local full, staging full and DEV focused were run sequentially. Final
  account/auth/onboarding lock and reclaim files and onboarding metadata were
  absent; no listener remained on 3100/3105/3102. Private auth/run artifacts remain
  available for diagnosis rather than being claimed deleted. Final source digest
  and unchanged service/dependency paths were rechecked after all runs.

The authorized implementation, maintained instructions, independent review and
available local/staging/affected-DEV verification are complete for this scope.
Product changes are still local and uncommitted; product Git/PR integration and
actual remote CI adoption remain separate delivery gates. No remote workflow,
product push/PR or production deployment has been performed. Subsequent releases
must run the official full staging contract against their own identified version;
these retained results are not evidence for future deployments or missing coverage.

## Previous Completed Scope — safety and documentation alignment

The user authorized implementation and verification of the remaining safeguards
after asking whether all documentation and service side effects were covered.
The September 11 completion below applies to that tested implementation; it did
not establish complete documentation alignment, production-target rejection, or
concurrent-run isolation. This follow-up supersedes that broader completion claim.

- Live worktree remains `/Users/parkjongsun/Repository/dentlink-client-e2e`,
  branch `feature/e2e-reliability`, HEAD `0e0878ef1c5b1cc2dbec44c57a740e0e072cdad7`.
  Product changes remain uncommitted. The branch has no upstream; the attempted
  fast-forward pull could not select a tracking branch. Do not invent one.
- Read-only audit found no Clinic/Lab/Admin/shared feature-code, dependency,
  lockfile, or production workflow changes. DEV/STG E2E runs after deployment;
  failing its new final gate fails the workflow without rolling back deployment.
- Existing limitations: environment overrides could select production; auth
  artifacts were shared across runs; the local onboarding lock did not protect
  overlapping main/Lab/Admin accounts. Real test API state is changed and order,
  shipment, and feedback scenarios do not fully roll back their changes.
- New artifact-directory omission: `e2e-runs/` was Git-ignored but not excluded
  from local Docker build context or its builder-stage `COPY . .`.
- Documentation gaps included Scanner prerequisites, exact allowed-skip reasons,
  the root guide's dev-only CI statement, README auth/fixture descriptions, and
  the personal skill's official runner entry points.
- Authorized follow-up: implement target rejection and run/account isolation,
  exclude execution artifacts from Docker, align maintained docs and skill copies,
  then run proportionate regressions and identified staging full-suite verification.
  Product behavior and data deletion scope must not be expanded incidentally.
  Distributed account locking across separate hosts is not available from local
  filesystem locks; report the actual local/CI coordination boundary.

### Implemented safeguards and maintained guidance

- The runner, direct Playwright configuration/UI, and version capture validate
  exact local/DEV/STG URL roots before collection or account login. Local uses
  localhost 3100/3105/3102 plus DEV API. Remote DEV now defaults to the deployed
  DEV sites rather than ordinary development ports. Explicit invalid overrides,
  mixed environments, production/unknown hosts, credentials, query strings,
  alternate ports and API paths are rejected. Version redirects are checked
  before following them. Error output does not expose supplied URL secrets.
- Runner preparation causes now precede downstream missing-report diagnostics.
  A missing source snapshot is `source_unverified`, not a claimed source change.
- Every official run gets a fresh auth ID shared by collection and execution.
  Direct/UI config initializes an ID and retains it for Reload in that process.
  Clinic, onboarding, Lab shipment/status/feedback use
  `e2e/.auth/runs/<runId>/`; actual run directories have mode 0700.
- Same-host locks protect each normalized API/account pair plus the exact auth
  directory. Overlapping accounts are blocked even when the onboarding account
  differs. Partial acquisition releases only owned locks. Existing exact meta is
  preserved for recovery; ambiguous noncanonical legacy artifacts block login
  instead of being guessed or deleted. Normalized v2 artifacts remain separable.
- Lock-release failures now attempt all releases and propagate an aggregate
  failure while preserving preparation, browser-close, and cleanup causes. This
  fixes the cross-review finding where a leftover lock could accompany green
  teardown and block another run in the same UI process.
- `.dockerignore` excludes E2E auth, report/trace output and `.next-e2e` builds.
  Static checks covered 17 generated paths and preserved source paths; an actual
  Docker build was not run and final image tracing is not claimed.
- README, shared skill/references and root `claude.md` now agree on commands,
  fixtures/auth, exact allowed skips, Scanner prerequisites, CI, data effects,
  recovery and isolation limits. Personal skill source and installed copy match.
  Both personal copies passed the actual `quick_validate.py` using a temporary
  isolated Python environment with PyYAML. The shared `.claude` skill retains its
  existing platform-specific `argument-hint`; its YAML/body were checked without
  treating the Codex validator's different allowed-key schema as a defect.

### Verification — 2026-09-14

- Final source digest:
  `a1eb1d23385928c34c5d3d7a7c2be3b4d04752f4681c709e67c88e3e80b7b366`,
  **35 changed/new product files**, all uncommitted, same HEAD as above. This
  digest was unchanged across the real local, staging and deployed-DEV checks
  and rechecked after completion. No Clinic/Lab/Admin/shared source changes.
- `pnpm e2e:check`: **127/127 passed** (runner 26, verdict/version 33,
  lifecycle/config 46, signup 5, process-tree 17). E2E TypeScript, affected-file
  formatting, Markdown and diff checks passed. Lint passed for the main changed
  lifecycle/config/consumer files. Four empty-function lint findings in
  `order-setup.ts` were verified against HEAD as pre-existing; only its auth-path
  import/constant changed. Independent cross-review has no remaining findings.
- Real production-API negative checks: official runner and direct config both
  exited 1 before collection/account login. The final runner evidence has
  `status=unsafe_target`, `collection=null`, `execution=null`, gate false, and no
  source-change claim. Evidence:
  `e2e-runs/safety-rejected-api-final-20260914/`.
- **Official local full: 104 passed + 5 allowed exclusions**, zero failures,
  flaky outcomes, unapproved skips, extra nonexecution or global/report errors;
  109 planned/reported, gate true, 435.3 seconds. Evidence:
  `e2e-runs/2026-09-14T02-26-31-502Z-bdfae997/`.
- During that real local run, a separate official deployed-DEV signin run was
  rejected by the existing account lock before login: 3 collected, 0 executed,
  one setup error, gate false. All seven original account locks retained the
  local owner's PID, and the local full run completed successfully. Evidence:
  `e2e-runs/2026-09-14T02-32-47-833Z-470b5b09/`.
- **Official staging full: 104 passed + 5 allowed exclusions**, zero failures,
  flaky outcomes, unapproved skips, extra nonexecution or global/report errors;
  109 planned/reported, gate and `staging_full_verified` true, 212.3 seconds.
  Evidence: `e2e-runs/2026-09-14T02-34-11-869Z-4005ec0d/`.
  Version snapshots at `2026-09-14T02:34:12.679Z` and
  `2026-09-14T02:37:45.490Z` bracketed execution with unchanged BUILD_IDs:
  Clinic `t0PqFwz3pmJ2r2XI8QnpJ`, Lab `h89hRMxK80RwI58M-iIMe`,
  Admin `GGdLJ50HcBrXPLB2m4kp0`. This is boundary equality, not continuous
  monitoring or independent Lab/Admin source-commit attribution.
- After the DEV lock was released, deployed-DEV signin **3/3 passed** with a
  separate auth directory. It briefly overlapped the end of the staging run
  (DEV report start 02:37:42.920Z, staging ended 02:37:45.553Z), and both passed.
  This is a focused cross-environment check, not two concurrent full suites.
  Evidence: `e2e-runs/2026-09-14T02-37-41-979Z-e813db27/`; full-staging flag false.
- Final checks found no onboarding meta, account/auth/onboarding locks or reclaim
  files, and no listeners on owned ports 3100/3105/3102. Three separate real auth
  directories remained with mode 0700, ignored and Docker-excluded. Auth files
  are retained private state, not claimed to have been deleted.
- Regression/type/format and negative-run logs are under
  `/tmp/dentlink-e2e-safety-20260914/`. Never copy raw credentials, tokens or
  private traces into personal context.

### Remaining boundary and next starting point

The approved safeguard, documentation and local/staging verification scope is
complete. User implementation did not require a service feature change or wider
data deletion. Local API/account locks and configured CI concurrency do not
provide a distributed lock across machines; coordinate shared test-account use.
Target checks cover configured inputs and version requests, not every later
browser request or a deployed application's embedded API settings. UI lifecycle
and forced-interruption regressions were checked with controlled fixtures; a new
real Playwright UI Reload/forced-browser-interruption sequence was not run here.

Product commit/push/PR and deployment have not been performed. Actual remote CI
execution of this code remains a delivery gate after authorized product Git
integration; read-only GitHub checks found no queued/running jobs during this
verification. Do not count local invocation of the official runner as remote CI.
Five documented exclusions and broader feature coverage remain separate from
this completed scope. Use this source digest and these September 14 artifacts,
not the historical September 11 evidence below, for the current implementation.

---

## Historical Closeout — 2026-09-11 official runner

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
  `scripts/e2e-run.js` (renamed in the latest follow-up above). The three CI workflows use this same runner and run
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
  onboarding lifecycle 28, signup success transition 5, process ownership/cleanup 17. These tests are stored in the repository, including three real Node process
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

| Run                                              | Result and interpretation                                                                                                                                                                                                                               |
| ------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `local-baseline`                                 | Global sign-in setup failed; 0 test bodies executed. This reproduced the setup defect and is not a test pass.                                                                                                                                           |
| `local-full-1`                                   | 98 passed, 2 ISV failures, 5 allowed skips, 4 serial follow-up tests not run. This failed run led to the DEV catalog/preset correction.                                                                                                                 |
| Final local focused (`local-isv-final`)          | 11 passed, 3 allowed skips; 0 failure, flaky, nonexecution or report errors; all 14 collected results accounted for.                                                                                                                                    |
| `local-full-final`                               | **104 passed, 5 allowed skips**; 0 failure, flaky, nonexecution, interruption, unapproved skip or setup/report errors. All **109** collected results accounted for; 8.0 minutes; source hash unchanged. This precedes the final signup-wait correction. |
| First staging full (`staging-full-final`)        | 93 passed, 1 signup preparation failure, 5 allowed skips, 10 serial follow-up tests not run; 0 flaky. The gate correctly failed. Versions and source digest were stable.                                                                                |
| Final local signup (`local-signup-final`)        | **16/16 passed**, no skips/failures/flaky; the two complete specs consuming the corrected helper.                                                                                                                                                       |
| Final staging signup (`staging-signup-final`)    | **16/16 passed**, no skips/failures/flaky; source/version checks passed.                                                                                                                                                                                |
| Final staging full (`staging-full-after-signup`) | **104 passed, 5 allowed skips**, 0 failure/flaky/extra nonexecution/interruption/preparation or report errors; all **109** planned results accounted for; **3.6 minutes**; source/version checks passed.                                                |

The same onboarding UI runner also exercised the relevant execution boundaries:

| UI boundary                      | Evidence                                               |
| -------------------------------- | ------------------------------------------------------ |
| First fixed run                  | 22/22 passed; fresh office 1628 deleted with HTTP 200. |
| Run All again in the same runner | 22/22 passed; fresh office 1629 deleted with HTTP 200. |
| Final fixed-code Reload          | 22/22 passed; fresh office 1631 deleted with HTTP 200. |

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

| Run                                                                                                                               | Commit    | Actual result                                               | Feedback                                                |
| --------------------------------------------------------------------------------------------------------------------------------- | --------- | ----------------------------------------------------------- | ------------------------------------------------------- |
| [develop 34554799750](https://github.com/Innvoaid/dentlink-client/actions/runs/34554799750/job/103128701283), 12:04 KST complete  | `01bfc93` | 85 passed, 4 failed, 5 skipped, 15 subsequent tests not run | Test 4: Completed-order feedback question not visible   |
| [prior stage 34555286833](https://github.com/Innvoaid/dentlink-client/actions/runs/34555286833/job/103132256089), 12:24 complete  | `516c971` | 87 passed, 3 failed, 5 skipped, 14 subsequent tests not run | Test 1: dentist selection timeout in Lab order creation |
| [latest stage 34564023735](https://github.com/Innvoaid/dentlink-client/actions/runs/34564023735/job/103156513198), 14:20 complete | `28e5e0b` | Global setup failed before test bodies; report 0/0/0        | Not run                                                 |

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
