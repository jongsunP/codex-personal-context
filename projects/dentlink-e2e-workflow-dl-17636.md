# DL-17636 웹 E2E 실행·알림 정책 조사

## 조사 결과 — 2026-11-25, 구현 승인 대기

현재 코드·Jira·Slack 원문·완료된 Actions 사례를 읽기 전용으로 조사했다. **PR 생성/갱신 자체로 전체 E2E를 실행하지 않는다. 배포와 E2E 결과는 이미 분리돼 있다. 인용된 DEV 알림과 최신 STG 실행은 제품 테스트 실패가 아니라 브라우저 설치 실패로 인한 미실행이다.** 알림 정책 변경과 실행 환경 복구를 함께 검토해야 한다.

- 기준 master `9084878eaa93ea4fe39df0f376afa4456c5fec55`, 확인한 develop `b8eca5f31d3f7a2ce8169a3dae0ebbd5d609698f`, stage `7565eb0bab92610a829421aac5c0b01159e0ba03`. 세 ref의 `.github/workflows/`, `e2e-deployment.js`, `e2e-run.js`, `e2e-verdict.js`, `playwright.config.ts`는 동일했다.
- 제품 변경·의존성 설치·테스트/서버/브라우저 실행·PR/Jira/Slack 쓰기·배포 없음. 조사용 worktree는 detached·tracked clean으로 남겼다. 개인 기록만 저장한다.

### 실제 실행과 Slack 의미

| 사례 | 확인 결과 |
| --- | --- |
| [인용 Slack](https://innovaidhq.slack.com/archives/C09613TBE5A/p1795601977296599), 11/25 19:19:37 KST | `준비 또는 결과 판정 실패`, 결과 숫자 공란, `버전 증거 확인 실패` 표시. 스레드 5개 답글에서 운영 방식 재검토를 제안했으며 STG만 유지한다는 확정은 없었다. |
| [DEV 배포 45591778833](https://github.com/Innvoaid/dentlink-client/actions/runs/45591778833) → [E2E 45593541053](https://github.com/Innvoaid/dentlink-client/actions/runs/45593541053) | 배포/새 버전 확인/artifact 인계 성공. 독립 E2E의 prepare·의존성 설치·runner 회귀 검사 성공. 브라우저 설치 실패 후 실제 E2E step은 skipped. 배포 SHA `b8eca5f31…`. |
| [STG E2E 45354330257](https://github.com/Innvoaid/dentlink-client/actions/runs/45354330257), 11/24 | 같은 브라우저 설치 실패와 E2E 미실행. prepare는 성공. 테스트 소스 `7565eb0ba…`, 인계된 부모 배포 `45351484623/attempts/1`. 부모 배포 job 목록은 별도 조회하지 않았다. |
| [DEV 44677058654](https://github.com/Innvoaid/dentlink-client/actions/runs/44677058654), 11/20 및 [44471269057](https://github.com/Innvoaid/dentlink-client/actions/runs/44471269057), 11/19 | job/step 조회에서도 브라우저 설치 실패 → E2E skipped. 이 두 건은 상세 로그 원인까지 추가 조사하지 않았다. |

DEV 11/25·STG 11/24 로그의 직접 오류는 `Cannot install dependencies for ubuntu26.04-x64 with Playwright 1.60.0!` 및 `Playwright does not support chromium on ubuntu26.04-x64`다. `ubuntu-latest`가 실제로 `ubuntu-26.04` 이미지 `20261116.202.1`을 사용했다. 현재 lock도 Playwright 1.60.0이다. 이 두 실행을 DEV 기능 변경·assertion 실패로 설명할 근거는 없다.

두 실행 모두 `e2e-runs/ci`가 없어 artifact는 업로드되지 않았다. Upload step의 success는 보고서 존재를 뜻하지 않는다. Slack은 `if: always()`라 앞 단계 실패에도 발송되고, runner output이 없어서 일반 fallback 문구·빈 카운터가 표시된다. `버전 증거 확인 실패` 역시 이 사례에서는 실제 BUILD_ID 불일치 확인이 아니라 runner 미실행에 따른 출력 부재다. 마지막 gate는 `process=skipped, verdict=missing`으로 실패했다.

11/20~25 공개 FE 채널 검색에서는 이 fallback 알림 7건(DEV 2/STG 5)을 확인했다. 최근 Actions 목록 DEV 8개·STG 6개는 모두 failure였으나 모든 실행의 원인을 분석한 것은 아니다. **STG만 알리도록 바꿔도 현재의 STG 준비 실패 알림은 남는다.**

### 현행 실행·알림 연결

| 진입점 | E2E 실행 조건·범위 | Slack |
| --- | --- | --- |
| DEV 배포 | `develop` push 중 `clinic/**` 변경 또는 배포 `workflow_dispatch`. 해당 배포 workflow 완료 후 독립 E2E가 수신하고 부모 성공일 때 진행. 배포 SHA의 전체 Clinic suite로 DEV Clinic/Lab/Admin 사용. | E2E job까지 진행하면 성공/실패/준비 실패 모두 결과 발송. |
| STG 배포 | `stage` push 중 `clinic/**` 변경, `stg/clinic/**` 태그, 또는 배포 수동 실행. 부모 성공 후 독립 전체 E2E. | 자동 실행은 시작 알림 없이 결과만 발송. |
| STG 직접 실행 | E2E `workflow_dispatch` 또는 `repository_dispatch: clinic-stg-e2e`. 기본 checkout `stage`; target URL은 STG portal로 제한. 부모 없는 수동 검증으로 기록. | 시작 + 결과, 기본 FE 채널. 입력으로 채널 지정 가능. |
| DEV 직접 실행 | 현재 DEV E2E workflow에는 수동 trigger가 없다. 내부 runner의 development 지원은 존재한다. | 수동화 선택 시 별도 진입점 설계 필요. |
| PR 생성·갱신 | 전체 E2E trigger 없음. PR Actions는 Auto Assign, 경로에 따른 Admin DLOS Guard·packages_publish 검사. 최근 PR 실행 6건도 이 구성이었다. | 배포 후 E2E 알림과 별개. PR merge가 develop/stage의 배포 push 조건을 만족하면 그 배포 뒤 실행할 수 있다. |

Lab/Admin 단독 배포·shared-only 변경을 모두 자동 E2E가 포괄하는 구조가 아니다. 자동 수신 대상은 Clinic 배포 workflow 두 개뿐이다. 운영 배포에 연결된 전체 E2E trigger도 현재 저장소에서는 발견하지 못했다. 외부 시스템의 별도 dispatch 운영이나 GitHub 사용자 개인 알림 설정은 조사하지 않았다.

PR 전 에이전트 **E2E 영향 가드**는 diff/호출 흐름 분석과 기록 검사다. `NEEDS_RUN`도 실행 여부와 별개로 기록하며 실제 E2E 실행은 별도 승인 대상이다. `.husky/pre-push`는 lint·Admin guard·coverage이고 전체 Playwright 실행이 아니다. 따라서 PR 전체 E2E를 제거하는 변경은 현재 필요하지 않다.

### 실패 판정과 구분해야 할 것

- 성공한 부모의 SHA·BUILD_ID·run/attempt·저장소·artifact identity를 검증하고 배포 SHA를 checkout한다. workflow definition/control code는 기본 브랜치 revision이다. E2E run 목록의 `head_branch=master`를 DEV/STG 제품 테스트 소스로 오해하면 안 된다.
- 부모 실패/취소 시 prepare와 E2E job은 skip된다. 구형 inline E2E임을 확인한 경우 독립 실행만 skip하고 기존 경로를 안내한다. 새 형식의 인계 누락/불일치는 실패다.
- E2E prepare 실패는 본문 실행을 막지만 별도 E2E job의 실패 알림/gate로 표시한다. E2E 실패가 이미 성공한 부모 배포 결과를 바꾸지는 않는다. 단, 배포 쪽 버전 확인·인계 자체 실패는 여전히 부모 workflow failure다.
- 두 E2E workflow에는 `continue-on-error`가 없다. artifact/Slack/final gate는 `always()`. 실제 runner의 성공과 `gate_passed=true`가 모두 있어야 최종 gate가 성공한다.
- CI retry는 최대 2회, worker는 1개다. 재시도 후 통과는 flaky이며 공식 verdict는 실패로 남긴다. 허용 제외는 정확한 파일·전체 제목·사유로 등록된 5개뿐이다. 미허용 skip·serial 후속 미실행·0건·전역 오류·보고서 누락/불완전·`test.fail()`은 통과가 아니다.
- 기대 Clinic BUILD_ID 불일치와 실행 전후 Clinic/Lab/Admin 버전 변경은 검증 무효로 실패한다. DEV 변경이 잦으면 발생할 수 있는 구조지만, 이번 설치 실패 사례의 원인은 아니다.
- 환경별 concurrency + `cancel-in-progress:false`는 진행 중 E2E를 새 E2E가 취소하지 않게 한다. 배포 자체를 잠그지는 않는다. 현재 queue 설정은 없으며 기본 pending 교체 동작 때문에 모든 배포가 반드시 끝까지 검증된다고 보장할 수 없다. [GitHub concurrency 계약](https://docs.github.com/en/actions/reference/workflows-and-actions/workflow-syntax#jobsjob_idconcurrency)
- 별도 주의점: STG 직접 실행의 시작 Slack이 실패하면 이후 테스트가 막힐 수 있다. 결과 Slack 실패도 테스트 성공 여부와 별개로 job을 빨갛게 만들 수 있다. 이번 두 사례의 원인은 아니며 알림 수정 시 회귀 확인 항목이다.

### 최소 변경 선택지와 권장안 — 미승인

공통 우선 조치는 두 E2E 실행 job의 `ubuntu-latest`를 **`ubuntu-24.04`로 고정**하는 안이다. 제품·시나리오·Playwright 버전 변경 없이 확인된 설치 문제에 대응하는 작은 변경이다. [Playwright v1.60.0 의존성 정의](https://github.com/microsoft/playwright/blob/v1.60.0/packages/playwright-core/src/server/registry/nativeDeps.ts#L453)에 Ubuntu 24.04가 있으며 26.04 정의는 없다. 최신 일반 설치 문서는 26.04도 나열하므로 이번 고정 버전의 호환 근거로 대체하지 않는다. 실제 설치/E2E 성공은 아직 검증하지 않았다.

| 정책 | 장점·한계 | 판단 |
| --- | --- | --- |
| DEV 자동 E2E 유지, DEV 결과 Slack만 중단. STG 자동/직접 E2E와 결과 알림 유지 | 채널 소음을 바로 줄이고 DEV 진단 기록은 남는다. 실행 비용·DEV 데이터 변경·Actions 실패 표시는 남으며 DEV 실패는 Actions에서 찾아봐야 한다. | **1차 권장.** 현재 요청을 가장 작게 해결한다. |
| DEV 배포 후 자동 E2E 중단, 필요할 때 수동 실행. STG 유지 | DEV 실행 비용·데이터 간섭도 줄인다. 조기 회귀 발견이 줄고 현재 없는 DEV 수동 진입점을 추가해야 한다. | DEV 검증 자체를 활용하지 않는다고 결정하면 선택. |
| E2E Slack 전부 중단, Actions/artifact만 유지 | 채널 소음이 가장 작다. STG 준비 실패·테스트 실패도 사람이 직접 열어봐야 한다. | 명시적인 결과 확인 담당/절차 없이는 비권장. |

권장 STG 결과는 실행당 한 번, **검증 통과 / 테스트 실패 / 준비 실패·미실행 / 배포 버전 변경으로 검증 무효**를 구분한다. 예: `배포 성공 · E2E 미실행 — 브라우저 설치 실패`. runner 출력이 없으면 카운터는 `미집계`로 표시하고 존재하지 않는 테스트 보고서 대신 실행 로그 링크를 안내한다. 모든 STG 결과를 받을지 실패/미실행만 받을지는 사용자 결정이며, 기본 제안은 통과 확인도 가능한 짧은 결과 1건 유지다.

판정은 유지한다. 알림을 끄거나 이유를 구분하는 것과 실패를 통과로 바꾸는 것은 별개다. retry 확대·skip 추가·assertion 약화·테스트 `continue-on-error`로 초록색을 만들지 않는다. 알림 장애 격리가 필요하면 Slack step만 별도로 다루고 테스트 verdict/gate를 보존한다. 중복 알림 상태 저장·자동 이슈 생성·실패 시나리오 수정은 최소안에 넣지 않는다.

### 남은 결정과 다음 시작점

1. DEV는 알림만 중단할지, 자동 E2E도 중단하고 수동화할지 결정한다.
2. STG는 짧은 모든 결과 1건을 유지할지, 실패/미실행만 보낼지 결정한다.
3. 위 정책과 Ubuntu 이미지 고정의 구현 승인을 받은 뒤에만 `feat/DL-17636` 등 허용된 작업 브랜치와 diff를 준비한다. 현재 detached 조사 상태에서 제품 수정은 하지 않았다.
4. 후속 구현 검증에는 정상·테스트 실패·준비 실패·출력 누락·버전 변경·알림 장애 경로를 포함한다. 실제 데이터에 닿는 E2E 재실행은 별도 승인 범위를 확인한다. YAML 수정/설치 성공을 전체 E2E 성공으로 기록하지 않는다.
5. receiver 정의는 master, 배포 SHA에서 읽는 runner/config와 producer는 환경 브랜치라는 경계를 보존한다. 이번 관련 경로는 동일하지만 적용 시점의 ref를 다시 확인한다. 승인 없는 병합·배포·원격 변경·자동 모니터링은 없다.

### 주요 현행 코드 근거

- [DEV E2E](https://github.com/Innvoaid/dentlink-client/blob/9084878eaa93ea4fe39df0f376afa4456c5fec55/.github/workflows/clinic_dev_e2e.yml), [STG E2E](https://github.com/Innvoaid/dentlink-client/blob/9084878eaa93ea4fe39df0f376afa4456c5fec55/.github/workflows/clinic_stg_e2e.yml)
- [배포 identity](https://github.com/Innvoaid/dentlink-client/blob/9084878eaa93ea4fe39df0f376afa4456c5fec55/scripts/e2e-deployment.js), [runner](https://github.com/Innvoaid/dentlink-client/blob/9084878eaa93ea4fe39df0f376afa4456c5fec55/scripts/e2e-run.js), [verdict](https://github.com/Innvoaid/dentlink-client/blob/9084878eaa93ea4fe39df0f376afa4456c5fec55/scripts/e2e-verdict.js)
- [PR 영향 가드](https://github.com/Innvoaid/dentlink-client/blob/9084878eaa93ea4fe39df0f376afa4456c5fec55/.codex/skills/e2e-guard/SKILL.md), [일반 pre-push](https://github.com/Innvoaid/dentlink-client/blob/9084878eaa93ea4fe39df0f376afa4456c5fec55/.husky/pre-push), [공식 실행/판정 계약](https://github.com/Innvoaid/dentlink-client/blob/9084878eaa93ea4fe39df0f376afa4456c5fec55/e2e/README.md)
- 기존 #4831/#4832 분리 이력은 `projects/dentlink-client-e2e.md`의 11/5 기록으로만 참고했다. 현재 코드와 실제 실행을 우선하며 이전 현행 유지 결정은 이번 재검토 요청을 막지 않는다.

## 범위와 초기 준비 — 2026-11-25

- Jira: https://innovaid.atlassian.net/browse/DL-17636 . 담당 Frankie, 해야 할 일, 댓글 0개를 현재 플러그인으로 확인했다.
- 전용 세션 `01a2125e-41c6-7221-9255-7629c3a4b101` (`E2E 실행·알림 정책 조사 · DL-17636`). 실제 turn metadata의 모델 `gpt-6-astra`, reasoning `xhigh` 확인.
- 조사만 승인. 코드/workflow·Jira·PR·제품 브랜치/원격 변경·배포·테스트/서버/브라우저 실행은 하지 않는다. Slack은 읽기 전용이다.
- 개인 컨텍스트 `git pull --ff-only` 후 공통 지침과 기존 `projects/dentlink-client-e2e.md`, `dentlink-web-e2e` 스킬을 읽었다. 사무실 Codex/모든 에이전트 인박스에 이 세션이 추가 처리할 미완료 항목은 없었다.
- 새 managed worktree: `/Users/parkjongsun/Repository/dentlink-client-dl-17636/dentlink-client`. 이 세션이 `create_worktree`로 최신 `origin/master@9084878eaa93ea4fe39df0f376afa4456c5fec55`에서 생성했다. detached·tracked clean이며 실제 폴더, Git 등록, `read_thread`의 persisted cwd가 모두 일치한다.
- 주 checkout/다른 worktree를 전환·수정하지 않았다. 동일 저장소 주 worktree의 eligible ignored/untracked env 6개를 승인된 스크립트로 불투명 복사하고 byte equality·ignore를 확인했다. 값은 열거나 출력하지 않았다. 실행 준비/로그인/테스트 성공을 의미하지 않는다.
- 초기 확인: Jira가 인용한 Slack은 2026-11-25 19:19:37 KST DEV E2E의 `준비 또는 결과 판정 실패` 알림이다. 현재 정책 제안은 확정 요구사항이 아니다.
- 초기 체크포인트는 `47a9c42`로 commit/push했다. 공통 `projects/dentlink-fe.md`는 메인 소유이므로 편집하지 않았다. 조사 결과는 이 파일과 Claude 보조 메모리 `project_dl17636_e2e_workflow_audit.md`에 보존한다.
