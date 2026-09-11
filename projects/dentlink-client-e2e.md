# Dentlink E2E Current Audit - 2026-09-11

This read-only audit supersedes older current-state claims below. No product
file was changed and no actual test, server or CI workflow was started.

- Web checkout: clean `release/v1.86.0` / `0e0878ef1`, live remote identical,
  main checkout only. Use `/Users/parkjongsun/Repository/dentlink-client`.
- Both development and staging `playwright test --list --project=clinic`
  collect **109 tests in 16 files**: signup/validation 24, sign-in 3, onboarding
  22, orders 26, Lab shipment 6, Lab status 12, LinkTalk 1, billing 5, feedback
  10. Collection success is not a test pass. `clinic` includes Lab/Admin flows
  but does not cover every web/Admin or native feature.
- Local E2E starts Clinic/Lab/Admin at 3100/3105/3102 with `.next-e2e`;
  staging uses deployed sites. Actual local/staging runs must remain sequential
  because auth artifacts are shared. Three Default Scanner tests explicitly
  skip; Referral/BP settings add two conditional skips. Other missing setup
  conditions can skip further groups, including all ten feedback tests.

## Operating Purpose And Current Scope — clarified 2026-09-11

- This improvement covers web E2E, including feedback. Native app E2E is
  excluded from the current work.
- The operating goal is for a PM to run the full suite against the deployed
  staging release before production delivery and trust the result within the
  tested coverage. Local development and focused checks support that workflow;
  final staging whole-suite evidence is still required.
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
  implementation immutable. PM execution should have predictable preparation
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
  by `setup-local-codex.sh`. The shared repository's legacy
  `.claude/skills/e2e/SKILL.md` still contains a two-pass completion gate,
  retry-success-equals-test-bug diagnosis, and a three-attempt stop rule.
  Those rules are superseded for this task. Align that team-owned file during
  authorized product work; it was not changed in this personal-context update.

## Recent CI Evidence — 2026-09-11

| Run | Commit | Actual result | Feedback |
| --- | --- | --- | --- |
| [develop 34554799750](https://github.com/Innvoaid/dentlink-client/actions/runs/34554799750/job/103128701283), 12:04 KST complete | `01bfc93` | 85 passed, 4 failed, 5 skipped, 15 subsequent tests not run | Test 4: Completed-order feedback question not visible |
| [prior stage 34555286833](https://github.com/Innvoaid/dentlink-client/actions/runs/34555286833/job/103132256089), 12:24 complete | `516c971` | 87 passed, 3 failed, 5 skipped, 14 subsequent tests not run | Test 1: dentist selection timeout in Lab order creation |
| [latest stage 34564023735](https://github.com/Innvoaid/dentlink-client/actions/runs/34564023735/job/103156513198), 14:20 complete | `28e5e0b` | Global setup failed before test bodies; report 0/0/0 | Not run |

- Each Playwright process exited 1 despite automatic workflow/job success.
  Latest stage timed out clicking Sign in at `e2e/clinic/utils/signin.ts:80`
  from global setup. Root cause remains unclassified. Other observed failures
  include ISV option waits, Lab shipment patient GET waits, and an access-request
  account login API 400. These symptoms do not establish product regressions.
- Automatic dev/stage workflows use `continue-on-error: true` without final
  failure propagation. Parsing checks `.stats.unexpected` only, ignoring
  global errors and zero executions; latest stage incorrectly sent
  `All tests passed`. Flaky counts are omitted. Manual stage E2E has a final
  failed-count gate but retains the zero-count global-error gap.
- These three workflow files match the inspected release/develop/stage refs.
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
- Next work: correct CI failure reporting, classify and address current
  whole-suite reliability failures, then fill targeted web feedback gaps.
  Use the operating purpose above to select validation evidence. Native app
  work is deferred. The initial audit did not implement or run the suite;
  ongoing implementation and validation now belong to the task below.
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
