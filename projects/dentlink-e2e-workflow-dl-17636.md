# DL-17636 웹 E2E 실행·알림 정책 조사

## 현재 상태 — 2026-11-25, 최소 구현·v1.95.0 PR 완료

- 최신 사용자 승인: “방금은 질문이지 실행하라는건 아니었어. 괜찮다는거맞으면 진행해. PR 까지만. 1.95.0릴리즈에”. 앞선 가능 여부 질문 당시에는 읽기 전용 확인만 했으며, 이 명시 승인 이후 구현·커밋·push·PR 생성을 진행했다. 이전 구현 보류 기록은 이 승인으로 갱신됐다.
- [PR #4959 — 웹 E2E 실행 환경과 결과 알림 정리](https://github.com/Innvoaid/dentlink-client/pull/4959): `release/v1.95.0` 대상, OPEN·일반 PR·미병합·mergeable true, 1커밋/4파일(+167/-77) 확인. GitHub 파일 목록과 로컬 diff 일치.
- 제품 worktree: `/Users/parkjongsun/Repository/dentlink-client-dl-17636/dentlink-client`. 현재 `feat/DL-17636-release-v1.95.0@c2bfd6d76076fc444f1778b18ae21d77cc479bfb`, origin 같은 SHA·tracked clean.
- 최신 `origin/master@9084878eaa93ea4fe39df0f376afa4456c5fec55`에서 `feat/DL-17636`으로 시작했다. master/release의 squash 이력 차이로 무관한 Lab 4파일이 PR에 노출되어, 관련 4파일의 원본이 동일함을 확인한 뒤 `origin/release/v1.95.0@5ac812a430b12f775502a93a4a2b865f9d24785e` 기반 전달용 브랜치에 이번 변경만 담았다. 원래 `feat/DL-17636`은 로컬 master 시작점에 보존했고 push하지 않았다.
- **현재 영향:** 코드와 PR만 준비됐다. 가드/제품 화면/BE/실제 env/GitHub·Slack 설정 변경 없음. 병합·배포·Actions 수동 실행·실계정/브라우저 E2E·Slack 시험 발송 없음.
- 사용자 후속 요청에 따라 [Jira 작업 댓글 45345](https://innovaid.atlassian.net/browse/DL-17636?focusedCommentId=45345)에 구현 결과·248개 회귀/타입/lint 검증·PR 링크·미병합/미배포·master 반영 필요를 기록했다. 쓰기 응답의 댓글 본문과 ID 확인. Jira 조회 당시 상태는 진행 중이며, 상태/본문은 변경하지 않았다. 앞으로 승인된 PR 생성 후 관련 Jira 댓글과 채팅 요약을 함께 남기는 요청도 AI_WORKFLOW에 기록했다.
- **남은 단계:** 사용자 PR 검토·병합 결정. 자동 E2E는 master의 workflow 정의를 읽으므로 릴리즈 PR 병합만으로 정책이 즉시 바뀌지 않으며 이후 master 반영이 필요하다. 실제 Ubuntu 브라우저 설치 및 전체 E2E 성공은 아직 미검증이다. 추가 PR/전파/실행/CodeRabbit 대응/자동 감시는 별도 요청 전 진행하지 않는다.

### 구현과 검증

- `.github/workflows/clinic_dev_e2e.yml`, `clinic_stg_e2e.yml`: E2E 실행 job만 `ubuntu-24.04`로 고정하고 Playwright 캐시 key에 OS 버전을 포함했다. 준비 job·트리거·concurrency·artifact·실패 gate·retry/skip 계약은 유지했다.
- DEV 결과 Slack step만 제거했다. E2E 실행과 Actions 결과/증거, 부모 배포의 기존 알림은 유지했다.
- STG는 기존 runner 판정을 그대로 사용한다. 출력이 없고 runner가 skipped/미시작이면 `준비 실패 · 테스트 미실행`, 실행 결과는 있으나 판정 출력이 없으면 `결과 확인 불가`로 표시한다. 빈 숫자는 `미집계`, 버전은 `미수집`, checkout 전 중단은 깨진 commit 링크 대신 설명을 남긴다. 로그/리포트 링크와 기존 수동 시작 알림은 유지했다.
- `scripts/e2e-deployment.test.js`: 실제 workflow payload를 성공·실패·flaky·미실행·불완전 보고·판정 부재·중단 10개 조합으로 평가하는 회귀 보완. 기존 인계/실패 gate 검증 유지. `e2e/README.md` 운영 정책 동기화.
- 브라우저 없는 `pnpm e2e:check` **248/248 통과**(관련 deployment 검증 15개 포함), workflow YAML/JS Prettier 검사·git diff check 통과. 원본 관련 파일은 master/release가 동일하여 동일 변경을 전달했다. Playwright 1.60.0 설치 패키지에서도 Ubuntu24.04 의존성 정의를 확인했다.
- 커밋 훅 Clinic/Lab/Admin 타입 검사 통과. push 훅 lint 오류0(기존 경고 Clinic226/Lab180/Admin396), Admin 가드9/9, 공통 테스트169/169(config77/hook92), 커버리지 변화0 통과. 기존 E2E 영향 가드 check 통과; 앱 코드 변경이 없어 영향 분석 대상 아님, 가드 코드/지침/마커 변경 없음.
- 새 worktree 준비 이슈만 해결했다: Next 자동 타입 파일 부재로 첫 commit 훅 실패 → 설치된 Next 공식 타입 생성 함수로 Git-ignored `next-env.d.ts` 생성 후 통과. 첫 push는 coverage baseline 부재로 실패 → 이 worktree에서 변경 전 release SHA로 일시 이동해 공통 coverage 실행/ignored baseline 생성 후 feature로 복귀, 정상 훅 재실행·push 성공. 실제 env 값은 읽거나 바꾸지 않았다. 의존성·치아 아이콘 빌드 출력도 ignored 로컬 준비이며 PR에는 포함하지 않았다.

## 구현 전 통합 작업 방향 — 2026-11-25 (현재 상태는 위 구현/PR 기록 우선)

| 항목 | 확인한 상황 | 추천 작업 방향 |
| --- | --- | --- |
| E2E 실행 환경 | 확인한 DEV/STG 사례는 Ubuntu26.04·Playwright1.60.0 호환 문제로 브라우저 설치 실패, 실제 테스트 미실행. | 두 E2E 실행 job을 Ubuntu24.04로 고정해 실행을 복구한다. 설치 성공과 실제 시나리오 결과는 별도로 검증한다. |
| DEV 실행·알림 | Clinic 배포 성공 후 자동 전체 E2E, 준비 실패까지 매번 Slack 결과 발송. | 자동 실행과 Actions 결과는 유지하고 DEV 결과 Slack만 중단한다. 자동 실행 자체 중단·수동화는 1차안에서 제외한다. |
| STG 결과 알림 | 준비 실패 때 포괄적인 실패 문구·빈 카운터가 표시된다. | 기존 runner 판정을 재사용해 통과/테스트 실패/버전 변경을 보여주고, 출력이 없으면 준비 실패·미실행과 미집계/로그 링크를 명확히 안내하는 최소 수정. 새로운 원인 분류 엔진·단계별 상세 진단은 만들지 않는다. 짧은 결과 1건과 기존 수동 시작 알림은 유지한다. |
| PR 전체 E2E | PR 생성·갱신 이벤트 자체로 전체 브라우저 E2E를 실행하지 않는다. | 현행 유지. 제거할 PR 자동 전체 E2E는 없다. |
| PR 영향 가드 | 앱 코드 변경 시 에이전트의 PR 생성 전·열린 PR 추가 push 전에 정적으로 분석한다. 분석 기록 재사용은 이미 있고, 실제 소요시간·병목은 측정하지 않았다. | **현행 유지. 이번 개선 범위에서 제외한다.** 가드 지침·스크립트·캐시·병목 측정 작업을 추가하지 않는다. |
| 배포·실패 판정 | 배포와 E2E 결과는 이미 분리돼 있고, 미실행·flaky·미허용 skip·버전 변경은 통과가 아니다. | 현재 분리와 실패 판정을 유지한다. 알림을 줄이려고 retry/skip/assertion을 완화하거나 테스트 실패를 성공으로 바꾸지 않는다. |
| 변경 범위·기준 | 기존 조사용 detached worktree가 있다. 자동 receiver는 master의 workflow 정의를 읽는다. | FE 저장소 `dentlink-client`의 E2E workflow·알림 표시와 직접 관련된 기존 계약 테스트/필수 문서만 수정하는 범위다. 가드·제품 화면·BE 변경 제외. 구현 시 최신 origin/master에서 feat/DL-17636으로 시작한다. master 반영과 필요한 릴리즈/환경 전파, 병합·배포는 별도 승인이다. |

### 최소 범위 재산정·코드 외 영향 — 최신 제안

- 원래 요청의 CI/E2E 실행·알림 정리는 남기고, 추가 제안했던 영향 가드 개선을 뺀다. 더 작은 1차안으로 STG의 기존 상태 출력을 재사용하며 새 분류 엔진·단계별 진단·Slack 실패 격리 재설계도 넣지 않는 방향을 권장한다. 기존 판정/실패 gate·수동 시작 알림은 보존한다.
- 계획치는 설정/DEV 알림 약 10~20분, STG 표시 최소 수정 약 15~30분, 관련 계약 회귀/정적 검사/최종 diff 검토 약 30~60분으로 **합계 약 1~2시간**의 검토용 초안이다. 기존 구조/테스트 재사용과 위 범위 축소를 근거로 다시 산정했으며 실측·고정 AI 배수·완료 약속이 아니다. 사용자1명+Codex 방식의 수정·개발자검증 순작업 범위이고, 실제 GitHub E2E·대기·QA·리뷰·병합/배포와 발견된 기존 실패의 수정은 별도다. 예상 외 실패가 있으면 원인과 추가 범위를 보고하고 넓히지 않는다.
- 필요한 제품 작업은 저장소 파일 수정과 로컬 검증이다. 현재 제안에는 GitHub 설정/Secrets/Variables, 실제 env, Slack 앱/채널 설정, BE/서버 인프라의 수동 변경이 필요하지 않다. Ubuntu 선택도 workflow YAML 변경이다. 코드 외 서비스 설정을 바꾸거나 실제 Slack 시험 발송을 하지 않는다.
- 운영되는 workflow에 실제 반영하려면 이후 승인된 commit/push/PR·master 병합/필요 전파와 실행 확인이 필요하다. 로컬 코드 수정 완료와 실제 적용 완료를 구분한다. 사용자의 표현은 여전히 "구현한다면"이라는 사전 논의이며 착수 승인은 아니다.

### 영향 가드 설명의 정확한 경계

- GitHub PR 이벤트에 걸린 공통 CI가 아니라 Codex/Claude의 로컬 작업 절차다. Codex는 AGENTS/PR 스킬에 따라 직접 검사하고, Claude는 저장소 `.claude/settings.json`의 Bash PreToolUse 훅이 `gh pr create`·열린 PR의 `git push`에 대한 기록을 확인한다. 모든 개발자의 일반 터미널/GitHub UI PR에 자동 강제되는 것으로 설명하지 않는다.
- 대상은 `clinic/`, `lab/`, `admin/`, `shared/`의 앱 변경이다. PR 제목·본문만 수정하거나 열린 PR이 없는 브랜치의 선행 push는 대상이 아니며, 이후 PR 생성 시 검사한다.
- `check.sh`는 기록과 앱 diff 해시를 비교하는 검사이며 영향 분석 자체를 수행하지 않는다. 기록이 유효하면 재사용하고, 기록이 없거나 앱 diff가 바뀌면 에이전트가 다시 분석한다. 분석의 소요시간을 실제 브라우저 E2E 실행시간으로 설명하지 않는다.
- 흐름 매핑과 기록 재사용은 기존에도 있으므로 새로운 기능처럼 중복 구현하지 않는다. 전체 시나리오를 매번 상세 분석한다거나 현재 가드가 특정 시간 이상 걸린다고 입증한 것은 아니다. 개선 시 현재 병목과 중복을 먼저 확인한다.
- 저위험 판정은 확장자·파일 개수만으로 면제하는 규칙이 아니다. 단순 문구/스타일 변경도 locator·표시/클릭 가능성에 영향을 줄 수 있어 관련 의존 근거를 확인한다. 불확실성을 숨기거나 사용자의 명시적 지시 없이 SKIPPED 기록을 만드는 방안은 제외한다.
- 후속 설명 때 로컬 HEAD와 live origin/master SHA가 모두 `9084878eaa93ea4fe39df0f376afa4456c5fec55`임을 확인하고 `.codex/skills/e2e-guard/SKILL.md`, `.codex/skills/github-pr/SKILL.md`, `scripts/e2e-guard/check.sh`, `.claude/settings.json`, `.husky/pre-push`를 읽었다. 가드·테스트를 실제 실행하거나 파일을 수정하지 않았다.

## 이전 확대 범위 견적 — 최신 최소 범위 견적으로 대체

사용자가 구현 전 난이도·시간·결정할 내용을 모두 논의할 수 있는지 질문했다. 구현 승인은 아니다. 기존 배포/E2E 분리, verdict 분류, 인계·gate 회귀 검사, 가드 흐름 매핑·diff 해시 기록을 재사용하는 **작은 1차 변경**을 가정한다. 이미 완료한 조사는 다시 비용에 넣지 않는다.

| 남은 작업 | 난이도 | 예상 순작업 시간 |
| --- | --- | --- |
| E2E job Ubuntu 고정·DEV 결과 Slack 중단 | 낮음 | 0.5~1시간 |
| STG 결과 분류·빈 결과/로그 안내·알림 실패 처리 | 중간 | 1~2시간 |
| 영향 가드의 관련 범위·분석 종료 기준 정리 및 대표 diff 대조 | 중간 | 1~2시간 |
| 변경 YAML·기존 계약/판정 회귀·정상/실패/미실행 경로 검증·최종 diff 검토 | 중간 | 1~2시간 |

합계 **3.5~7시간**은 사용자 1명+Codex 방식의 구현·개발자 검토/검증을 위한 계획 초안이다. 실측이나 약속된 완료시간이 아니며, 약 6시간을 하루 순작업으로 보는 기준이다. 실제 역할별 작업시간·AI 단축률은 측정하지 않았다. 별도 사용자/팀 QA·QA 후속 수정·PR 리뷰 대기·병합/배포·GitHub 실제 E2E 실행과 대기·새 시나리오 실패 원인 수정은 제외한다. 가드의 새 판정 엔진·증분 캐시·모든 개발자에게 적용되는 강제 훅 재설계도 제외하며 이를 원하면 별도 재산정한다.

구현 전 추가로 정할 사항과 추천값:

1. **가드 개선 깊이:** 1차는 기존 기록 재사용을 유지하며 Codex/Claude 지침·분석 범위·종료 기준을 맞추는 수준을 권장한다. 대표 변경을 대조하고 실제 다음 PR에서 병목을 확인한다. 속도 향상 수치를 사전 보장하거나 파일 종류만으로 검사 면제하지 않는다.
2. **Slack 자체 실패의 영향:** 알림 실패 때문에 테스트가 막히거나 테스트 성공을 실패로 오해하지 않도록 알림 실패만 별도 경고로 분리하는 방향을 권장한다. 실제 테스트 실패·미실행 gate는 그대로 유지한다. 기존 계약 테스트가 모든 `continue-on-error`를 금지하므로 Slack에 한정된 예외와 테스트/준비/gate 보호를 명시적으로 함께 검증해야 한다. Slack을 직접 발송하는 검증은 승인 없이 하지 않는다.
3. **실제 검증 범위/시점:** 구현 중에는 브라우저 없는 계약·판정 검증을 하고, 별도로 승인된 적용/검증 단계에서 GitHub 브라우저 설치와 STG 전체 E2E를 확인하는 방향이다. E2E는 실제 테스트 데이터를 바꾸므로 실행 승인을 구분한다. 설치 복구 후 나타나는 기존 제품/시나리오 실패까지 이번에 수정할지는 별도 결정하며 자동 범위 확대하지 않는다.

DEV 자동 실행 유지·결과 Slack 중단, STG 짧은 모든 결과, PR 전체 E2E 미실행, 배포/실패 판정 유지가 앞서 정리한 권장 기본값이다. 기존 수동 시작 알림은 우선 보존하는 범위로 잡으며 변경을 원하면 구현 전에 확정한다. 범위·정책·완료 기준은 사전 합의 가능하지만 실제 실행 성공과 가드 시간 단축 효과는 실행 후 확인할 사항이다. 아직 제품 변경·테스트·Jira 수정은 없다.

## 조사 결과 — 2026-11-25, 제안 미승인

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

1. 위 최신 통합 표를 후속 작업 방향으로 사용한다. 권장 기본값은 DEV 자동 실행 유지·Slack 중단, STG 기존 판정을 재사용한 결과 표시 최소 수정, 영향 가드 현행 유지·개선 제외다. 사용자가 요청한 것은 현재 방향 정리까지이며 구체 구현·실행·commit/push·PR 승인 범위를 분리해 확인한다.
2. 구현 승인을 받은 뒤 최신 origin/master에서 `feat/DL-17636`을 준비한다. 특정 릴리즈 QA/후속 수정이면 그때 승인된 릴리즈 기반 예외를 적용한다. 현재 detached 조사 상태에서 제품 수정은 하지 않았다.
3. 후속 구현 검증에는 정상·테스트 실패·준비 실패·출력 누락·버전 변경·알림 장애 경로를 포함한다. 실제 데이터에 닿는 E2E 재실행은 별도 승인 범위를 확인한다. YAML 수정/설치 성공을 전체 E2E 성공으로 기록하지 않는다.
4. 가드 개선·지침 변경·성능 측정은 이번에서 제외한다. 별도 사용자 요청이 있을 때만 이전 추가 제안을 다시 검토한다.
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
