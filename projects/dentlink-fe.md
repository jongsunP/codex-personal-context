# Dentlink Frontend Coordination

웹·관리자, 치과 앱, 기공소 앱을 조율하는 최상위 개인 체크포인트입니다.
상세 구현·SHA·PR·QA·배포 증거는 각 담당 문서를 정본으로 사용합니다.
아래 단계는 **2026-10-27 개인 문서 대조 결과**이며 제품·외부 서비스의 새 실조회 결과가 아닙니다.

## 웹 v1.90.0 배포 기준 확인 — 2026-10-27

- 사용자 요청으로 원격 refs와 실행 대상을 한 번 확인했다. `release/v1.90.0`과 `prd/clinic/v1.90.0`, `prd/clinic-ohio/v1.90.0`, `prd/lab/v1.90.0`, `prd/admin/v1.90.0`은 모두 **`4168fba5aad347e6958412057b4bf35d856f4473`**를 가리킨다. 릴리스 커밋에서 태그를 만들어 배포한다는 목적과 일치한다.
- 아래 Actions는 해당 태그 push로 시작했고 실행 `head_sha`도 모두 위 커밋이다. **18:06 KST 메타데이터 조회 당시 진행 중**이었으며 완료 결과는 재조회하지 않았다.

| 서비스 | 시작 시각 KST | 실행 |
| --- | --- | --- |
| Clinic | 18:02:09 | [40477752750](https://github.com/Innvoaid/dentlink-client/actions/runs/40477752750) |
| Lab | 18:03:13 | [40477879968](https://github.com/Innvoaid/dentlink-client/actions/runs/40477879968) |
| Admin | 18:03:48 | [40477951931](https://github.com/Innvoaid/dentlink-client/actions/runs/40477951931) |

- 같은 exact SHA의 PRD workflow·Dockerfile을 대조했다. 태그 커밋 checkout → 해당 소스 build context → `prd-${github.sha}` 이미지로 전달하며 다른 브랜치 재checkout은 없다. Clinic workflow 하나가 서울·Ohio 양쪽을 처리한다.
- 이번 확인은 **배포 기준/실행 대상 일치**다. 최종 성공·serving revision·서비스 안정화·사용자 QA의 증거는 아니다. 특히 Lab/Admin은 workflow에서 안정화를 기다리지 않으므로 성공 상태만으로 확대하지 않는다. 자동 후속 감시는 시작하지 않으며 결과 확인은 사용자 요청과 공통 배포 확인 주기를 따른다.
- 제품 코드·branch·tag·배포 설정은 변경하지 않았다. 기본 checkout은 `feature/DL-17011@9dcb644d5`·clean·upstream0/0 그대로이며 로컬 checkout과 원격 태그 배포 기준을 혼동하지 않는다.

## 현재 업무 색인 — 2026-10-27

| 업무 | 담당 정본에 기록된 단계·재개 경계 | 상세 정본 |
| --- | --- | --- |
| 메인세션 | 상시 중앙 조율·개인 컨텍스트 관리. 보관하지 않고 유지 | 이 문서의 Session Ownership |
| LBX / DL-16387 | 원본 수정·별도 develop 전달 및 사용자 개발 배포 완료 기록. 원본 보존·운영 홀드 유지 | [LBX](dentlink-client-lbx.md) |
| 디자인시스템정비 | 원천/통합 운영 반영 완료. DL-17046 Studio 갤러리는 관련 동료 코드와 사용자 재개 지시 대기. 하네스는 별도 판단 | [DLDS](dentlink-fe-opportunities.md) |
| 통합알림센터 | 사전 기획·디자인 검토와 산정. 제품 구현 미착수 | [통합알림센터](dentlink-unified-notification-center.md) |
| DL-17012 앱 미지원 기능 우선순위 | Notion 최종 표 정리·검토 완료, 추가 요청 대기. 제품 구현 아님 | [모바일웹·앱 비교](dentlink-mobile-web-app-parity.md) |
| 권한관리 / DL-16317 | 배포·정리 완료 기록. 이후 발견된 회귀·후속 QA는 개별 근거로 구분 | [권한관리](dentlink-permission-management.md) |
| 후속 QA / DL-17011 | 구현·PR 병합 후 10/27 사용자 배포 완료·추가 QA 없음 확인. 업무 종료·세션 보관 요청 기록 | [권한관리](dentlink-permission-management.md) |
| Office 컨펌 오류 / DL-17038 | 수정 전 Render Error 재현·수정본 한정 검증·임시 브랜치/런타임 정리 완료 | [Office 앱](dentlink-app.md) |
| Office LinkTalk SIGSEGV | 확보 가능한 범위 조사 마감. 일치 dSYM 부재로 정확 원인 미확정, 증거 확보와 별도 재개 요청 대기 | [전용 조사](dentlink-app-linktalk-sigsegv-investigation.md) |
| Billing Statement / DL-16796 | 운영 포함·정리 완료 기록, 추가 예정 작업 없음 | [Billing](dentlink-client-billing-statement.md) |
| 웹 env / DL-16821 | 운영 반영·기본 로컬 실행 준비·정리 완료 기록. 별도 보안/DEV 후속 자동 재개 금지 | [환경변수](dentlink-client-env-management.md) |

- 세션 보관 요청과 실제 앱 보관 상태, Git 병합과 서버 배포, 에이전트 검증과 사용자 QA를 구분합니다.
- 제품 저장소의 현재 branch/worktree/env·배포 상태는 필요할 때 live 확인합니다. 이 표에 변동 SHA나 개수를 중복 기록하지 않습니다.
- 담당 문서가 이후 갱신되면 그 최신 기록을 따르며, 이 색인의 오래된 단계로 되돌리지 않습니다.

## 담당 세션 식별자

기존 세션을 찾기 위한 기록입니다. 다른 PC에 프로젝트/대화를 자동 복원하거나 현재 실행·보관 상태를 보증하지 않습니다.

| 업무 | 기록된 세션 이름 | ID |
| --- | --- | --- |
| 메인 | 메인세션 | `01a08f0c-2057-7852-ae8d-0cf950a91fd3` |
| 디자인시스템 | 디자인시스템정비세션 | `01a0a2eb-da08-7131-aaaf-6c14f0cfc204` |
| DL-17012 | DL-17012 기공소 앱 미지원 기능 우선순위 | `01a17657-caad-70f1-9a40-dbde874a3d42` |
| DL-17011 | DL-17011 관리자 그룹 회원 권한 수정 이력 조사 | `01a17658-54e4-7b42-bd92-d0f790d7f2bd` |
| SIGSEGV | 앱 SIGSEGV 오류 원인 조사 | `01a17c4f-57cb-7592-8b7e-b8b937ee7d32` |
| API 조회 | API 사용처 확인 세션 | `01a17b41-6ead-7fc1-9387-42f68aaa86e2` |

## Scope

- Web/Admin repository: `/Users/parkjongsun/Repository/dentlink-client`
- Office app repository: `/Users/parkjongsun/Repository/dentlink-app`
- Lab app repository: `/Users/parkjongsun/Repository/dentlink-lab-app`
  (https://github.com/Innvoaid/dentlink-lab-app)
- 2026-10-06 사용자 확정: 앱은 최근 Office/Lab 저장소로 분리됐다. 앞으로 앱 업무는
  제품을 먼저 구분하고 [Office 앱](dentlink-app.md) 또는 [Lab 앱](dentlink-lab-app.md)의
  정본과 실제 Git을 확인한다. 웹 반응형과 네이티브 앱 적용도 구분한다.
- Durable context: `/Users/parkjongsun/Repository/codex-personal-context`
- Active AI workflow: Codex only. The remote `claude-personal-context`
  repository is retained only as an archive and is not loaded by default.

## Session Ownership

- **원격화 구분(2026-10-27):** 기본 의미는 켜진 이 Mac의 기존 세션을 휴대폰에서 그대로 이어 쓰는 것이다. 다른 PC로 실행 환경을 옮겨 Git 기반 컨텍스트를 복구하는 경우와 구분하고, 각 세션에서 같은 의미를 다시 묻지 않는다. 신규 세션은 정상 등록·프로젝트·호스트·초기 턴 확인과 초기 개인 기록 저장/푸시를 기본으로 챙긴다. 연결 설정은 사용자가 관리한다. 사용자의 '메모리화 후 휴대폰에서 보였다'는 경험은 관찰로 기록하며 Git 저장이 모바일 표시를 유발한다는 인과나 현재 표시 완료를 단정하지 않는다. 정본은 [Phone Remote Continuity](../SESSION_WORKFLOW.md#phone-remote-continuity)이다.
- **메인세션 유지 규칙(2026-10-27):** 이 최상위 세션 `01a08f0c-2057-7852-ae8d-0cf950a91fd3`는 보관하지 않고 계속 유지·대기한다. 보관/영구 종료 요청이나 다른 작업 세션용으로 보이는 대상 불명확 마감 지시가 들어오면 사용자에게 대상을 먼저 되묻는다. 메인 자체가 대상임을 재확인하기 전에는 보관하지 않으며, 일반적인 기록 정리·대기는 그대로 수행한다. 이 추가 확인은 다른 기능 세션 전체에 적용하지 않는다. 정본은 [Dentlink FE Main Session Retention](../SESSION_WORKFLOW.md#dentlink-fe-main-session-retention)이다.
- 직전의 'QA 없이 배포 완료, 정리 후 세션 보관' 메시지는 사용자가 다른 세션에 쓸 내용을 잘못 보낸 것으로 철회했다. 그 메시지를 근거로 SIGSEGV 조사나 다른 업무의 배포/완료 상태를 변경하지 않는다.
- 2026-10-27 **API 사용처 확인 세션** (`01a17b41-6ead-7fc1-9387-42f68aaa86e2`,
  local·메인 프로젝트)은 단순 API 사용처 확인용으로 계속 유지한다.
  원격에서도 찾을 수 있도록 이름·ID·용도만 기록하며, 조회 과정과 개별 결과는
  매번 저장하지 않고 재사용할 결정이나 원칙만 필요할 때 짧게 남긴다.
  Git 원격의 이 기록은 Codex 모바일 목록 동기화 완료를 확인한 근거는 아니다.
- 메인세션은 항상 Dentlink FE 전체를 감독·조율하는 최상위 세션이다.
  신규 업무 접수, 웹·앱 영향 범위, 공통 결정·우선순위, 진행 상태,
  release·배포 단계, 구현 세션 인계와 마무리를 관리한다.
- Git-backed `codex-personal-context`를 관리하며 세션 간 결정·진행 기록을
  정제·동기화한다. 상세 이력은 기능별 문서에, 공통 결정과 조율 상태는 이 문서에 둔다.
  의미 있는 정리 시 개인 컨텍스트를 커밋·푸시한다.
- 필요한 경우 프로젝트 폴더와 세션의 설정·연결·이동·정리를 맡는다.
  실제 폴더, 앱의 표시 이름·연결 경로, 기존 세션 소속·실행 경로를 각각 확인하고
  기존 세션 이력과 진행 중인 제품 작업을 보존한다.
- 메인세션의 폴더는 `/Users/parkjongsun/Documents/ChatGPT/메인 프로젝트`다.
  개인 조율·자료용 폴더이며 전용 제품 저장소나 worktree를 연결하지 않는다.
  위 상시 역할은 2026-09-28 사용자가 재확인한 운영 원칙이다.
- Sessions are created primarily for a feature or responsibility, not for a
  device or repository. One feature session may inspect and implement both its
  web and app portions across the relevant separate product repositories.
- Every code or Git mutation must still name and confirm the exact product
  repository, branch, and worktree. A shared feature scope does not combine Git
  histories or permit writing from an ambiguous directory.
- 2026-10-06 사용자 지침: 구현은 작은 작업도 별도 기능 세션이 기본이며,
  메인세션은 접수·분류·조율·마감을 맡는다. 짧은 작업은 현재 폴더에서 세션만,
  규모가 있고 여러 차례 이어갈 작업은 전용 폴더·worktree·세션으로 분리한다.
  판단이 불명확하거나 작업 충돌·필수 결정이 있을 때만 사용자에게 확인한다.
  상세 운영 정본은 [SESSION_WORKFLOW.md](../SESSION_WORKFLOW.md#new-work-intake-and-session-routing)이며,
  메인세션 직접 구현은 사용자가 선택하는 예외다. 기존 작업 이력은 이 지침으로 재배치하지 않는다.
- 2026-10-06 사용자 추가 지침: 새 작업 세션은 별도 지정이 없으면 메인세션과 같은
  모델·추론 수준을 명시하고 실제 적용값도 확인한다. 같은 설정을 사용할 수 없으면
  사용 가능한 최고 등급을 선택하며, 상세 정본은
  [모델·추론 기본값](../AI_WORKFLOW.md#new-session-model-and-reasoning-default)이다.
- Keep one active writing session per worktree. Repository main-checkout
  sessions are optional helpers for branch/worktree/release administration,
  not permanent web-versus-app session boundaries.
- Shared repository mutations still require the user's explicit authorization.
- 웹 신규 작업의 기준은 최신 `origin/master`로 확정돼 있다. Jira 예정 릴리즈나
  현재 checkout이 release라는 이유로 master 기준을 다시 묻지 않는다. 해당 release에
  이미 반영한 작업의 후속 수정·QA만 release 기반 예외이며, 상세 정본은
  [브랜치 전략](../SESSION_WORKFLOW.md#dentlink-release-train-branch-strategy)을 따른다.

## Top-Level Session Start

1. Pull `codex-personal-context` and read the common guidance plus this file.
2. Read the relevant web and app checkpoints before relying on prior chat.
3. Fetch/pull the relevant product repositories only as required by the current task,
   then verify exact path, branch, HEAD, upstream, dirty state, and worktree.
4. Classify each new request as web, app, or shared before deciding the owning
   implementation session and release target.
5. Apply the canonical size/continuation routing rule: separate feature session
   by default, with a dedicated folder/worktree for substantial continuing
   work. Resolve unclear scope or ownership only when necessary, and do not
   reuse a completed feature branch.
6. Reconcile Jira, Notion, Figma, Swagger, and live code when the new request
   depends on them; do not re-fetch every external source without a task-driven
   reason.

## 상시 작업 지침의 정본

- 앱의 최종 코드·영향 화면·권한별 에이전트 실행 검증 → 결과/확인표 전달 → 사람의 최종 QA: [앱 검증 지침](../DEVELOPMENT_STYLE.md#app-screen-runtime-verification-before-merge).
- 앱 PR·release·CodePush·스토어 경계와 개발자 참고 흐름: [앱 온보딩](dentlink-app-onboarding.md), [공통 앱 전달 정책](../SESSION_WORKFLOW.md#dentlink-app-release-and-delivery-policy). 참고 흐름으로 확정 정책을 조용히 바꾸지 않습니다.
- 제품별 Jira 카드·상위 댓글 제한: [AI_WORKFLOW](../AI_WORKFLOW.md#jira-work-updates).
- 기공소 정적 문구 변경 시 i18n·시트·검증: [공통 기준](../SESSION_WORKFLOW.md#dentlink-lab-translation-work), [웹](dentlink-client-i18n.md), [Lab 앱](dentlink-lab-app-i18n.md).
- 완료 브랜치 정리 시 현재 진행 중 release 원본 보존: [브랜치 정리 이력과 기준](dentlink-branch-cleanup-20261016.md). 제품 Git 정리는 별도 승인과 live 근거가 필요합니다.

## 다른 기기에서 이어가기

- **휴대폰으로 같은 Mac에 접속:** 기존 세션·프로젝트·코드 환경을 그대로 사용합니다. [Phone Remote Continuity](../SESSION_WORKFLOW.md#phone-remote-continuity)를 따르며 다른 PC 복구와 혼동하지 않습니다.
- **다른 PC로 실행 환경 변경:** 개인 컨텍스트 clone/pull → [BOOTSTRAP](../BOOTSTRAP.md#read-order) → 이 색인에서 해당 정본을 읽고 목적·결정·남은 일·재개 조건을 복구합니다.
- 기존 대화 전체·앱의 프로젝트 등록·인증·env·의존성·서버·임시 증거는 개인 컨텍스트 pull만으로 복원되지 않습니다. 절대 경로는 당시 기기 기록이며 실제 대상 경로를 확인합니다.
- 문서 복구만으로 구현·QA·서버 실행·배포·보류 해제가 승인되지 않습니다. 실제 재개 시 제품 Git과 작업 소유권을 다시 확인합니다.
- 여러 세션이 개인 컨텍스트 checkout을 공유하면 수정 파일을 나누고 stage/commit/push는 조율합니다. 다른 세션 변경을 임의로 포함하지 않습니다.

## 과거 조율 이력

[2026-10-27 정리 전 전체 이력](archive/dentlink-fe-history-through-2026-10-27.md)에 이전 세션 배정, 브랜치·폴더·env 정리, 피드백/E2E·release 전환, 웹/앱 초기 인계와 상세 PR 기록을 보존했습니다.
보관본의 '현재·대기·다음 시작점'은 당시 상태이며 위 최신 색인이나 담당 정본을 대체하지 않습니다. 정확한 과거 경위가 필요할 때만 읽습니다.
