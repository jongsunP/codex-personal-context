# Projects

Common Codex guidance lives in the repository root. Each project has a personal
configuration, current checkpoint, and history under `projects/`; see
`projects/README.md` for the required structure and lifecycle.

## Repository Folder

The user's personal repositories are generally located under:

```text
/Users/parkjongsun/Repository
```

Check this folder first when finding or continuing local projects.

## Projects

### Dentlink 웹 env Git 제외·환경변수 관리

- **2026-10-26 기본 master 로컬 준비·전용 worktree 제거·세션 보관 완료.** PR4713/4740/4743은 웹 v1.89.0 운영에 포함됐고 DL16821도 완료다. 기존 작업 공간 유지 지시는 최신 메인 정리 지시로 대체됐다.
- 사용자의 명시 요청으로 DEV/E2E 설정을 기본 저장소에 정리하고 의존성·패키지 빌드·3서비스 로그인 페이지 HTTP200을 확인했다. 서비스 STG/PRD 원본은 제한 권한 로컬 백업에 보존했다. 남은 완료 로컬 브랜치2개도 제거했고 원격은 그대로다. 일반적인 실제 값 수동 관리 원칙은 유지한다.
- 10/20 STAGE 전체 E2E 성공과 10/22 DEV ISV 실패2건, 이번 운영 배포 성공은 구분한다. 운영 기능 QA·팀원 로컬 준비·별도 키 보안 과제는 완료로 확대하지 않는다. 추가 실행은 새 지시 후 진행한다.
- [개인 체크포인트](projects/dentlink-client-env-management.md) · [팀 운영 문서](https://app.notion.com/p/3fece072e82f81bf9edfe7a5b959a03c)

### 사무실 의자 구매·헤드레스트 개선 조사

- 회사 지원금30만원, 배송·필수옵션 포함 총예산40만원. 통짜 쿠션 좌판을 유지하면서 머리 하중에 헤드판이 뒤로 회전하지 않는 의자를 찾는다.
- 2026-10-15 SIZEOF 베이직 S까지 비교한 뒤 아르코 구매결정서대로 진행하기로 최종 재확인하고 다른 후보 조사도 종료했다. 현재 의자가 크다는 불편은 없으며 전방 헤드 위치·통짜 쿠션 좌판 선호가 우선이다. 결제·승인·수령·실사용 완료는 미확인이다.
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
  2026-10-26 웹은 최신 master 기본 worktree1개, 로컬 master/LBX만 남겼다. 메인·LBX·디자인시스템·통합알림센터 세션을 유지하고 env는 보관했다. 로컬 준비와 복구 자료는 최상단 정본에 기록했다.
  10/25 배포 후 4세션 마감과 로컬15개/원격14개 정리 이력도 같은 문서에 보존한다.
  2026-10-16 로컬 브랜치 4개·worktree 1개·원격 브랜치 158개 정리 이력도 같은 문서에 보존한다.
  원격은 출시 완료154개와 사용자 확인 후 폐기한 frankieTemp 백업4개다.
  진행 중·공용·타인 항목과 대체 적용을 확인하지 못한 invoiceTemplete는 유지했다.
- 이 색인은 세부 상태를 중복 보관하지 않는다. 과거 SHA, PR 상태, QA·배포 이력은
  각 프로젝트의 최신 체크포인트에서 확인하고 재개 시 live Git과 대조한다.

### Dentlink Billing Statement 명칭 변경 — DL-16796

- 개별/통합 문서 명칭 변경이며 Commercial Invoice와 발행·결제 구조는 유지한다.
- **2026-10-25 PR4699의 v1.89.0 운영 포함·11파일 변경 보존 확인.** 담당/상위/QA Jira는 이미 완료다. 복구 검증 후 `feature/DL-16796`의 로컬·원격을 삭제하고 세션을 보관했다.
- 추가 예정 작업은 없다. 10/26 별도 Billing 폴더 없음 확인, 기본 제품 저장소 유지. 실계정 다운로드 기능 QA를 새로 수행한 것은 아니다. [개인 체크포인트](projects/dentlink-client-billing-statement.md)

### Dentlink 치과 주문목록 아이콘·텍스트 정렬 — DL-16655

- Web Clinic 주문 행 정렬 수정, 사용자 직접 병합한 release 대상 PR #4675. 2026-10-12 사용자 완료 확정·추가 작업 없음, 로컬 정리 완료·세션 보관 요청.
- 구현·검증·병합 확인·정리 상태와 Git 커밋 목록 차이 질의 및 개선 검토안(미적용)은
  [개인 체크포인트](projects/dentlink-client-order-list-alignment.md)에 보존한다.

### Dentlink 기공소 환자목록 디자인·API 대응 — DL-16652

- **2026-10-12 사용자 앱 확인 완료·전체 업무 종결·세션 보관 요청.** 웹은 사용자 직접 상용 배포 진행 중이다.
  Lab양OSProductionv13/1.0.4/active/mandatory/100%와 main→develop15 사용자병합/tree동일 이력을 보존한다.
  Jira 완료 상태·개인기록·전용 로컬 환경 정리 후 새 요청 전 추가 개발·QA·배포조회·동기화 없이 종결한다.
  이번 업무 완료 선언은 온보딩의 참고·합의 대기 정책을 자동 변경하지 않는다.
- 웹 Lab·기공소 앱의 최종 Figma·배포된 DEV API 대응이다. 전역 Remake 배지만 Office 앱에도 적용했다.
- 기존 메인 프로젝트 폴더의 별도 기능 세션과 제품별 worktree를 사용한다. 최신 전달 브랜치는 아래 정본을 따른다.
- 이번 화면 전용 표이며 기존 공통 테이블이나 공식 디자인시스템의 변경은 아니다.
- 웹기능/스테이징4677은 사용자병합, 웹배포완료는 사용자보고다. 클리닉318의 사용자병합도 live확인했다.
- Lab 기능6/문서5는 사용자병합, 최신release/v1.0.4@f000ae2c에서 iOS/Android Staging CodePush를 각각 배포했다.
  양쪽 v31·바이너리1.0.4·활성·mandatory·100%를 서버검증했다. 실기기OTA/기능QA는별도다. 옛Lab2/3/4는닫힌이력이다.
  이후사용자NEW아이콘제보를확인해Lab카드만Figma14px/#959595로보정한PR8을같은release로전달했다.
  PR8사용자병합59e6a56c 후Lab iOS16:01/Android16:02 Staging v32재배포완료·1.0.4/활성/100%서버확인했다.
  v32실제적용/아이콘QA는별도다. Clinic최신release에는같은결함근거없어추가수정/배포없다.
  신규번역시트·검증·실기QA/OTA 및 외부검사 한계는 정본을 따른다.
- [projects/dentlink-patient-list-design.md](projects/dentlink-patient-list-design.md)

### Dentlink 타기공소 주문 조회 가드 — DL-16596 — 완료

- 타기공소 추가금·채팅 읽음 요청 차단과 디자인 조회·기존 승인 흐름 유지. [PR #4663](https://github.com/Innvoaid/dentlink-client/pull/4663)은 release/v1.88.0 `9baeca42f`에 사용자 merge 완료.
- 2026-10-12 사용자 완료 확인·추가 작업 없음. 과거 배포/QA 대기 항목은 이 세션의 후속 작업에서 제외하고 세션을 보관한다.
- 로컬 feature/임시 worktree 정리 완료, 남은 임시 후보 파일 제거. 원격 branch·검증 화면 및 다른 작업 checkout/worktree는 보존한다.
- 구현·리뷰·검증·Jira 이력은 [projects/dentlink-client-other-lab-guard.md](projects/dentlink-client-other-lab-guard.md)에 정리했다.

### Dentlink DLDS / AI 화면 제작 — DL-16437 / DL-16466 / DL-16830 / DL-16471

- **2026-10-25 DLDS·DLOS 통합·빌드 복구·QA 관련 5개 PR의 웹 운영 포함 확인.** 10/26에는 사용자 요청으로 세션을 유지하되 기존 worktree2개·제품 브랜치3개·Studio 로컬 브랜치를 복구 백업 후 정리했다. Studio 원격 브랜치1개는 쓰기 권한403으로 남았다.
- 미완료 하네스와 env/auth·생성/검증 자료는 `/Users/parkjongsun/.codex/backups/2026-10-26-dlds-fresh-start/`에 보존한다. 원본 제품/Studio clone·stash·다른 작업은 유지한다. 다음 요청에서 최신 master 기반 새 환경을 준비하며, 기존 worktree 경로는 더 이상 사용하지 않는다. 과거 OPEN/배포 실패 기록은 현재 상태가 아니다.
- 제품 workspace 패키지의 운영 사용과 정식 npm0.1.7 공개·Studio 반영·하네스 완성은 별개다. master 통합 이후의 공개/소비 확인과 하네스 범위는 새 지시에 따라 진행한다. PAUSED 자동화는 유지한다.
- [현재 체크포인트와 상세 이력](projects/dentlink-fe-opportunities.md) · [2단계 초안](projects/dentlink-ai-dlds-draft.md) · [회의 자료](projects/dentlink-fe-meeting.md)

### Dentlink 피드백 요구사항 외 UI 정리 — 완료

- 승인된 피드백 UI 4곳 정리를 PR #4642로 `release/v1.88.0`에 병합했다.
- 작업용 로컬 브랜치를 삭제했고 기본 checkout은 `master`로 복귀했다.
- [projects/dentlink-client-ui-requirements-audit.md](projects/dentlink-client-ui-requirements-audit.md)

### Dentlink Admin LBX — DL-16279 / DL-16387

- 기존 배송 목록·상세 확장, LBX Baby/Mother 생성 및 픽업 생성.
- **2026-10-26 로컬 준비 완료:** 최신 master c597f1fb3에서 같은 `feature/DL-16387`을 재구성해 필요한19파일을 `f389c13cf`로 저장했다. 3서비스 타입·DLOS 가드·변경 lint/format·합성 통합9개를 통과했다. 기본 checkout은 master clean으로 복귀했다.
- 원격은 옛 원본 b69dd84b6을 유지하며 새 로컬 브랜치의 과거 upstream 연결은 해제했다. 원본 bundle과 검증 자료는 담당 정본 경로에 있다. 새 제품 push/PR/배포는 없고 LBX 세션·운영 홀드를 유지한다. 10/16 PR4709 develop 전달·배포 성공과 이번 로컬 준비를 구분한다.
- 실제 업무 API·화면 QA와 운영 릴리스는 별도이며, 테스트 중 실제 생성·수정 요청 금지는 유지한다.
- [projects/dentlink-client-lbx.md](projects/dentlink-client-lbx.md)

### Dentlink Office App

- 치과·기공소 앱의 모바일웹 대비 기능 차이와 WebView/모바일 제한 구분은
  [모바일웹·앱 기능 비교 조사](projects/dentlink-mobile-web-app-parity.md)를 따른다(2026-10-19 정적 조사, 실기기 QA 별도).
- `dentlink-app`은 앱 저장소 분리 이후 Office 전용이다. 기본 checkout은 `main`이며
  기능 시작 기준과 작업 공간은 매번 live Git으로 확인한다.
  일반 feature PR은 `develop`이 기본 대상이며 release는 QA·배포 단계다.
  [공통 앱 지침](projects/dentlink-app-onboarding.md)을 따른다.
- [projects/dentlink-app.md](projects/dentlink-app.md)

### Dentlink 치과 앱 주문 상세 403 조사 — 추가 확인 대기

- 2026-10-12 앱·웹 코드와 Amplitude·Datadog RUM/서버 로그/APM 조사 및 Notion 팀 공유 문서 정리를 완료했다. 웹뷰 일부 API의 status 0과 403 이동을 관측했으나 정확한 원인은 미확정이다.
- 사용자 팀 공유 완료 보고 후 개인 메모리만 저장·세션 보관 요청. 코드·Jira·PR·배포 변경은 없으며 자동 재개하지 않는다. BE 앞단 로그 또는 사용자 재현 결과와 재개 지시가 다음 시작점이다.
- 2026-10-14 마감: 웹 `/403` 이동 조건과 메모리 직원 권한/저장된 직원 ID의 구분, 주문 상세의 4개 허용 권한을 체크포인트에 보강했다. 원인 미확정 상태를 유지하며 사용자 재요청으로 메모리 저장 후 세션을 보관한다.
- [개인 체크포인트](projects/dentlink-app-order-detail-403-investigation.md)

### Dentlink Lab App

- 기공소 네이티브 앱은 별도 저장소 `Innvoaid/dentlink-lab-app`을 사용한다.
  기본 checkout은 `/Users/parkjongsun/Repository/dentlink-lab-app`의 `main`이다.
  일반 feature PR은 `develop`이 기본 대상이며 CodePush마다 새 release를 만들지 않는다.
  [공통 앱 지침](projects/dentlink-app-onboarding.md)에서 바이너리·태그·배포와 자료 현행성을 구분한다.
- [projects/dentlink-lab-app.md](projects/dentlink-lab-app.md)

### Dentlink 권한관리 — DL-16317

- **2026-10-25 웹 권한·후속9PR의 운영 포함과 앱 관련 변경의 운영 Git 포함 확인.** Office 양OS Productionv84/2.2.4, Lab 양OSv17/1.0.5 활성은 확인했으며 OTA exact Git SHA·전 기기 QA와는 구분한다.
- 10/25 웹 refs 로컬8개·원격7개 정리 후 10/26 전용 웹/Office·리뷰 worktree3개를 제거하고 설정25개를 별도 보관했다. `feature/v1.89.0-qa`와 Office4개·Lab3개 앱 refs 및 기본 저장소는 유지했다. 담당24카드는 이미 Done이며 세션 보관 상태를 유지한다.
- Lab웹 번역2키 Sheet 보류와 앱 기존 타입 진단의 현행성은 별도다. 원격 release→master는10/26 PR4776 통합을 확인했다. 새 QA 요청 전 추가 작업은 하지 않는다.
- [현재 체크포인트와 재개점](projects/dentlink-permission-management.md) · [Office](projects/dentlink-app.md) · [Lab](projects/dentlink-lab-app.md)

### Dentlink 통합알림센터 — 사전 검토

- 웹·앱의 REST 조회/읽음/삭제와 딥링크 연결을 다룬다. 별도 알림 SSE·silent FCM
  기반 실시간 동기화는 제외됐다. 공통 구현은 미착수이며 전용 worktree가 없다.
- 2026-10-26 이번 메인 정리 대상이 아니라는 사용자 정정에 따라 세션을 보관 해제해 유지한다. 사전 검토를 보존하며 새 요청 때만 재개한다.
- [projects/dentlink-unified-notification-center.md](projects/dentlink-unified-notification-center.md)

### Dentlink E2E Stabilization

- 웹 E2E 실행 신뢰성·CI 판정 개선과 검증 이력이다. 전용
  `dentlink-client-e2e` worktree와 로컬 브랜치는 2026-09-14 정리됐다.
- [projects/dentlink-client-e2e.md](projects/dentlink-client-e2e.md)

### Dentlink 주문 피드백 수집 / 관리자 피드백 목록

- DL-15828과 후속 DL-16443·DL-16534의 계약·구현·QA·release/stage 전달 이력을 관리한다.
  DL-16443·DL-16534 전용 worktree와 로컬 전달 브랜치는 2026-09-28 정리됐다.
- 배포 완료와 실제 화면 QA는 별도로 확인한다.
- [projects/dentlink-client-order-feedback.md](projects/dentlink-client-order-feedback.md)

### Dentlink Lab i18n

- 다국어 구현과 운영 절차. 완료한 전용 worktree·로컬 브랜치는 정리됐다.
- 기공소 기능의 문구 변경은 번역 리소스·시트 반영·검증까지 기본 범위다.
  웹은 아래 i18n 문서, 별도 Lab 앱은 [앱 정본](projects/dentlink-lab-app.md)의 절차를 따른다.
- Lab 앱의 팀 에이전트 지침 반영은 [앱 i18n 전달 기록](projects/dentlink-lab-app-i18n.md)을 따른다.
  기존 앱 PR #3은 문서 전용 #5로 대체됐고, #5는 사용자 병합으로 `release/v1.0.4`에 반영됐다.
  이후 release→develop #9와 main 운영 전달도 완료됐다. 2026-10-16 문서용 worktree와
  잔여 로컬·원격 브랜치를 정리했다. 웹 `release/v1.88.0`과 별도다.
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
