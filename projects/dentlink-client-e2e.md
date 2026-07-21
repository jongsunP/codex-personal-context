# Dentlink E2E Stabilization

## Repository

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Local worktree: `/Users/parkjongsun/Repository/dentlink-client-e2e`
- Jira: `DL-15560`
- Release target: `release/v1.79.0`

## E2E Policy

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
- PR [#4400](https://github.com/Innvoaid/dentlink-client/pull/4400) is open against `release/v1.79.0`.
- PR #4400 is non-draft and `APPROVED / MERGEABLE / CLEAN`.
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

1. Merge PR #4400 into `release/v1.79.0`.
2. Confirm staging deployment includes PR #4400.
3. After staging deployment includes PR #4400, run staging Clinic UI full, reload, full for 2 consecutive passes.
4. After staging deployment includes PR #4400, run staging headless `e2e:clinic:stg` twice.
5. Completion target remains `94 passed / 5 intentional skipped / 0 failed` for each staging run.
6. styled-components v6 DOM prop warnings remain a separate backlog item, not a current E2E blocker.

## Next Start Point

1. Pull `codex-personal-context` and `/Users/parkjongsun/Repository/dentlink-client-e2e`.
2. Confirm PR #4400 has merged into `release/v1.79.0` and staging deployment includes HEAD `5dc084e7c`.
3. After deployment, run staging UI 2회 and staging headless 2회.
4. Record every run as `passed / intentional skipped / failed` and classify any failure by the E2E policy.
