# Projects

Common Codex guidance lives in the repository root. Each project has a personal
configuration, current checkpoint, and history under `projects/`; see
`projects/README.md` for the required structure and lifecycle.

This index records project identity, scope, and canonical links. Read the
linked file's current checkpoint for status, evidence, and the next step.
Keep changing SHAs, PR states, local inventories, and delivery details there
instead of maintaining another copy here.

## Repository Folder

The user's personal repositories are generally located under:

```text
/Users/parkjongsun/Repository
```

Check this folder first when finding or continuing local projects.

## Projects

### Dentlink 웹 env Git 제외·환경변수 관리

- DL-16821의 환경변수 Git 제외·사람 수동 관리 전환과 후속 로컬 정리 기록이다.
- 실제 활성 env, 과거 백업, 제품 배포, 기능 QA, 팀원 로컬 준비를 구분한다.
  완료된 전환을 별도 키 보안 과제나 새 실행의 승인으로 확대하지 않는다.
- [개인 체크포인트](projects/dentlink-client-env-management.md) · [팀 운영 문서](https://app.notion.com/p/3fece072e82f81bf9edfe7a5b959a03c)

### 사무실 의자 구매·헤드레스트 개선 조사

- 회사 지원금30만원, 배송·필수옵션 포함 총예산40만원. 통짜 쿠션 좌판을 유지하면서 머리 하중에 헤드판이 뒤로 회전하지 않는 의자를 찾는다.
- 아르코 선택과 후보 조사 종료까지 기록했다. 구매 결정과 결제·수령·실사용은 구분하며,
  후속 사용 상태는 아래 정본을 따른다.
- 이번 메모리의 중심은 사용자 구매 판단 방식이다. [구매 판단 흐름](DECISION_FRAMEWORK.md#product-purchase-decisions)에 일반 원칙을 저장했다. 추가 조사 없이 대기하며 사용자가 의자 수령 후 전하는 사용 후기부터 재개한다. [사례·조사 이력](projects/office-chair-research.md)

### Action Sports Journal

- Repository: `https://github.com/jongsunP/action-sports-journal-app`
- Local path: `/Users/parkjongsun/Repository/action-sports-journal-app`
- Product: action sports life log platform
- Current design center: Session

Domain flow:

```text
ActivityGroup -> Session -> AnalysisResult -> ShareResult
```

Important principle:

AI is one product feature, not the whole product.

Current preference:

- MVP-centered development
- Validate real user flow before large infrastructure
- Do not prematurely add database, login, production backend, RAG, coupons,
  expenses, calendar, or unrelated product features

For detailed current state, read:

- Personal current checkpoint and history:
  `projects/action-sports-journal-app.md`
- Cross-project personal continuation context: `HANDOFF.md`
- Stable team-owned project documentation when relevant:
  project-local `README.md`, `AGENTS.md`, and architecture/product docs

### Dentlink Frontend Coordination

- Shared repositories: [Web/Admin](https://github.com/Innvoaid/dentlink-client),
  [Office app](https://github.com/Innvoaid/dentlink-app),
  [Lab app](https://github.com/Innvoaid/dentlink-lab-app).
- 기본 경로: `/Users/parkjongsun/Repository/dentlink-client`,
  `/Users/parkjongsun/Repository/dentlink-app`,
  `/Users/parkjongsun/Repository/dentlink-lab-app`.
- FE 메인세션은 전체 감독·조율, Git-backed 개인 컨텍스트 관리와 필요시
  프로젝트 폴더·세션 설정을 맡는다. 기능별 세션은 정확한 저장소·브랜치 경계
  안에서 작업하며 별도 통합 제품 저장소는 없다.
- 신규 작업의 세션·폴더·worktree 선택은
  [SESSION_WORKFLOW.md의 업무 접수 기준](SESSION_WORKFLOW.md#new-work-intake-and-session-routing)을 따른다.
- 기능별 보관/대기 상태와 다른 기기의 첫 대화에서 읽을 체크포인트:
  [projects/dentlink-fe.md](projects/dentlink-fe.md)의 **다른 기기에서 이어가기** 절.
  세션 배정·정리의 공통 결과는 이 조율 문서에, 상세 상태는 각 기능 정본에 둔다.
- 현재 Mac을 기본 실행 PC로 두고 휴대폰·다른 컴퓨터에서 원격 제어한다.
  실행 환경 자체를 다른 PC로 이전하는 경우와 구분하며 연결 PIN 확인도
  [Phone Remote Continuity](SESSION_WORKFLOW.md#phone-remote-continuity)를 따른다.

### Dentlink Billing Statement 명칭 변경 — DL-16796

- 개별/통합 문서 명칭 변경이며 Commercial Invoice와 발행·결제 구조는 유지한다.
- 완료한 전달·운영 포함·정리 이력이며, 별도 실계정 다운로드 QA와 구분한다.
  새 후속 요청 전 자동 재개하지 않는다. [개인 체크포인트](projects/dentlink-client-billing-statement.md)

### Dentlink 치과 주문목록 아이콘·텍스트 정렬 — DL-16655

- Web Clinic 주문 행 정렬 수정의 사용자 완료 확정 이력이다.
- 구현·검증·병합 확인·정리 상태와 Git 커밋 목록 차이 질의 및 개선 검토안(미적용)은
  [개인 체크포인트](projects/dentlink-client-order-list-alignment.md)에 보존한다.

### Dentlink 기공소 환자목록 디자인·API 대응 — DL-16652

- 웹 Lab·기공소 앱의 환자목록 디자인·API 대응이며 전역 Remake 배지만 Office 앱에도 적용했다.
- 이번 화면 전용 표로, 기존 공통 테이블이나 공식 디자인시스템을 바꾼 작업이 아니다.
- 완료·사용자 앱 확인·웹 운영 확인·잔여 브랜치 정리와 검증 한계는 아래 정본에 보존한다.
  옛 배포 진행 중 기록을 현재 대기 업무로 되돌리지 않는다.
- [projects/dentlink-patient-list-design.md](projects/dentlink-patient-list-design.md)

### Dentlink 타기공소 주문 조회 가드 — DL-16596 — 완료

- 타기공소 추가금·채팅 읽음 요청 차단과 디자인 조회·기존 승인 흐름 유지 작업이다.
- 사용자 완료 확인 이후 과거 배포/QA 대기 항목을 새 후속 업무로 만들지 않는다.
- 구현·리뷰·검증·Jira 이력은 [projects/dentlink-client-other-lab-guard.md](projects/dentlink-client-other-lab-guard.md)에 정리했다.

### Dentlink DLDS / Studio 갤러리 / AI 화면 제작

- DL-16437·DL-16466·DL-16830의 디자인시스템/패키지 통합, DL-17046 Studio 갤러리,
  DL-16471 하네스 검토는 서로 다른 단계다. 최신 승인 범위와 재개 조건은 정본 최상단을 따른다.
- 제품 운영 사용, npm 공개/소비 확인, Studio 갤러리 QA, 하네스 완성을 구분한다.
  과거 계획이나 준비된 작업 공간만으로 하네스 작업·자동 조회를 재개하지 않는다.
- [현재 체크포인트와 상세 이력](projects/dentlink-fe-opportunities.md) · [2단계 초안](projects/dentlink-ai-dlds-draft.md) · [회의 자료](projects/dentlink-fe-meeting.md)

### Dentlink 피드백 요구사항 외 UI 정리 — 완료

- 승인된 피드백 UI 4곳 정리의 완료 이력이다. 미착수 조사로 되돌리지 않는다.
- [projects/dentlink-client-ui-requirements-audit.md](projects/dentlink-client-ui-requirements-audit.md)

### Dentlink Admin LBX — DL-16279 / DL-16387

- 기존 배송 목록·상세 확장, LBX Baby/Mother 생성 및 픽업 생성.
- **유지 목적:** 원본은 최신 master 코드를 따라가면서 LBX 작업 코드를 살린다. 기능 수정은 먼저 원본에 반영·push하고, 원본 기반 별도 전달 브랜치로 develop/stage에 테스트용 반영한다. 운영 홀드로 release에서는 제외하며 원본에 다른 환경 기능을 역병합하지 않는다.
- 원본·전달본·개발 배포·정리의 최신 상태와 복구 근거는 정본에만 기록한다.
- 실제 업무 API·화면 QA와 운영 릴리스는 별도이며, 테스트 중 실제 생성·수정 요청 금지는 유지한다.
- [projects/dentlink-client-lbx.md](projects/dentlink-client-lbx.md)

### Dentlink Office App

- 치과·기공소 앱의 모바일웹 대비 기능 차이와 WebView/모바일 제한 구분은
  [모바일웹·앱 기능 비교 조사](projects/dentlink-mobile-web-app-parity.md)를 따른다(2026-10-19 정적 조사, 실기기 QA 별도).
- `dentlink-app`은 앱 저장소 분리 이후 Office 전용이다.
  실제 checkout, 기능 시작 기준과 작업 공간은 매번 live Git으로 확인한다.
  일반 feature PR은 `develop`이 기본 대상이며 release는 QA·배포 단계다.
  [공통 앱 지침](projects/dentlink-app-onboarding.md)을 따른다.
- [projects/dentlink-app.md](projects/dentlink-app.md)

### Dentlink 치과 앱 주문 상세 403 조사 — 추가 확인 대기

- 웹뷰 일부 API의 status 0과 403 이동에 관한 제한된 조사이며 정확한 원인은 미확정이다.
- BE 앞단 로그 또는 사용자 재현 결과와 명시 재개 지시를 기다린다.
  조사·공유 완료를 원인 해결이나 코드 수정·운영 검증으로 확대하지 않는다.
- [개인 체크포인트](projects/dentlink-app-order-detail-403-investigation.md)

### Dentlink Office iOS LinkTalk SIGSEGV 조사

- 채팅 후 목록 전환 시 네이티브 크래시 조사다. 오전 디자인컨펌 Render Error와 구분한다.
- 확보 가능한 범위의 조사 마감과 원인 미확정을 함께 유지하며 새 요청 없이 재개하지 않는다.
- [개인 체크포인트](projects/dentlink-app-linktalk-sigsegv-investigation.md)

### Dentlink Lab App

- 기공소 네이티브 앱은 별도 저장소 `Innvoaid/dentlink-lab-app`을 사용한다.
  기본 경로는 `/Users/parkjongsun/Repository/dentlink-lab-app`이며 실제 checkout은 확인한다.
  일반 feature PR은 `develop`이 기본 대상이며 CodePush마다 새 release를 만들지 않는다.
  [공통 앱 지침](projects/dentlink-app-onboarding.md)에서 바이너리·태그·배포와 자료 현행성을 구분한다.
- [projects/dentlink-lab-app.md](projects/dentlink-lab-app.md)

### Dentlink 권한관리 — DL-16317

- 웹·Office·Lab 권한관리와 후속 QA 이력이다. 원 작업과 DL-17011의 최종 완료 기록을 구분한다.
- Git 포함, OTA 활성, 실제 기기 QA와 사용자 배포 확인의 근거를 혼동하지 않는다.
  과거 QA 대기·보존 브랜치 목록을 현재 미완료 업무나 현행 로컬 상태로 해석하지 않는다.
- [현재 체크포인트와 재개점](projects/dentlink-permission-management.md) · [Office](projects/dentlink-app.md) · [Lab](projects/dentlink-lab-app.md)

### Dentlink 모바일웹·앱 비교 / 우선순위 — DL-17012

- 모바일웹 대비 Office·Lab 앱 기능 차이, 담당별 1차 조사와 통합 2차 작업 목록을 관리한다.
- 최신 사용자 승인 범위·우선순위·Notion 변경을 정본에서 확인한다.
  조사·문서 정리와 제품 구현은 별개이며 과거 담당 범위를 최신 승인보다 우선하지 않는다.
- [개인 체크포인트](projects/dentlink-mobile-web-app-parity.md)

### Dentlink 통합알림센터 — 구현 착수

- 웹·Office·Lab 알림 목록·설정·딥링크를 함께 구현한다. 2026-10-29 사용자 착수 승인 후 확정 디자인의 선행 UI부터 병행한다.
  제품별 정책·제외 범위·공수와 일정 가정은 아래 정본의 최신 확인을 따른다.
- 이 기능 세션에서 제품별 작업 위치·작성자를 분리하며, 미확정 BE 계약과 제품 commit/push/PR/배포 권한은 구분한다.
- [projects/dentlink-unified-notification-center.md](projects/dentlink-unified-notification-center.md)

### Dentlink E2E Stabilization

- 웹 E2E 실행 신뢰성·CI 판정 개선, 고정 그룹과 검증 이력이다.
  로컬/DEV/STG 및 단독/전체 시나리오의 검증 범위를 구분한다.
- [projects/dentlink-client-e2e.md](projects/dentlink-client-e2e.md)

### Dentlink 주문 피드백 수집 / 관리자 피드백 목록

- DL-15828과 후속 DL-16443·DL-16534의 계약·구현·QA·release/stage 전달 이력을 관리한다.
- 배포 완료와 실제 화면 QA는 별도로 확인한다.
- [projects/dentlink-client-order-feedback.md](projects/dentlink-client-order-feedback.md)

### Dentlink Lab i18n

- 기공소 다국어 구현과 운영 절차를 관리한다.
- 기공소 기능의 문구 변경은 번역 리소스·시트 반영·검증까지 기본 범위다.
  웹은 아래 i18n 문서, 별도 Lab 앱은 [앱 정본](projects/dentlink-lab-app.md)의 절차를 따른다.
- Lab 앱의 팀 에이전트 지침 반영은 [앱 i18n 전달 기록](projects/dentlink-lab-app-i18n.md)을 따른다.
  웹과 Lab 앱은 저장소·시트·전달 이력이 별개다.
- [projects/dentlink-client-i18n.md](projects/dentlink-client-i18n.md)

### Dentlink DSO Dashboard — DL-15223

- 완료한 구현과 QA 이력. 전용 worktree·로컬 브랜치는 정리됐다.
- [projects/dentlink-client-dso.md](projects/dentlink-client-dso.md)

### Dentlink 홈 LinkTalk 미확인 필터

- DL-16002 및 후속 QA 이력. 전용 worktree·로컬 브랜치는 정리됐다.
- [projects/dentlink-client-linktalk-unread.md](projects/dentlink-client-linktalk-unread.md)

### Dentlink Admin Invitation 필터 — DL-16004

- 완료한 구현과 QA 이력. 전용 worktree·로컬 브랜치는 정리됐다.
- [projects/dentlink-client-admin-invitation-filter.md](projects/dentlink-client-admin-invitation-filter.md)

### Dentlink Admin 주문 Case Preference 배치 — DL-16269

- PR #4558 병합 확인. 현재 전용 worktree·로컬 브랜치는 없다.
- [projects/dentlink-client-admin-case-preference.md](projects/dentlink-client-admin-case-preference.md)

### Dentlink Limited Warranty — DL-16258

- 정책 변경·배포 제외·재전달을 포함한 상세 이력은 체크포인트에 보존한다.
  관련 로컬 브랜치는 정리됐으며 과거 전달 상태를 현재 작업 지시로 해석하지 않는다.
- [projects/dentlink-client-limited-warranty.md](projects/dentlink-client-limited-warranty.md)
