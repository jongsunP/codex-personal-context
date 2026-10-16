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

- DLDS와 분리한 별도 기능 세션. **2026-10-16 회의에서 GitHub 기반 적용 방향과 팀 공동 관리를 확정**했다. 현재는 로컬 동기화·dev/stage/prd와 서비스 분리·Variables/Secrets 분류·공개 키 검토·설정 변경 후 배포/복원 등 운영 상세를 조사·설계하는 단계이며 **구현은 보류**다. 회의 의도는 이해 완료다.
- master `8772d688`의 env9개/변수명105개, 배포9개와 GitHub 설정을 읽기 전용으로 재확인했다. 서비스×환경9개 구획과 로컬 단방향 갱신을 제안했으며 구체안은 아직 팀 확정 전이다. 로컬 비밀값 공유 경로와 외부 키의 실제 상태는 추가 확인 대상이며 Vault/Infisical은 참고 후보일 뿐 도입 결정이 아니다.
- [팀 공유용 Notion](https://app.notion.com/p/3face072e82f814b9a6ceaa36e5638af)은 **DEV Team / Development Documents**에 있고 기존 방향 설명 본문·댓글3개를 유지한다. 이번 회의 내용으로 Notion을 수정하거나 제품 코드·설정·Git/PR·배포를 변경하지 않았다.
- [개인 체크포인트](projects/dentlink-client-env-management.md)
- 착수 전 질문별 제안 가능 범위와 필수 사실/정책 확인을 구분해 저장한 뒤 사용자 요청으로 대기 중이다. 기존 비밀값 공유 수단 유무는 미답변이며, 재개 요청 전 추가 조사·문서·구현·설정 변경은 하지 않는다.

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
- 현재 열린 기능 세션과 다른 기기의 첫 대화에서 읽을 체크포인트:
  [projects/dentlink-fe.md](projects/dentlink-fe.md)의 **다른 기기에서 이어가기** 절.
  과거 로컬 브랜치/worktree 정리 이력도 같은 문서에 보존한다.
- 이 색인은 세부 상태를 중복 보관하지 않는다. 과거 SHA, PR 상태, QA·배포 이력은
  각 프로젝트의 최신 체크포인트에서 확인하고 재개 시 live Git과 대조한다.

### Dentlink Billing Statement 명칭 변경 — DL-16796

- 상위 DL-16795의 기존 개별/통합 문서 명칭 변경. Commercial Invoice와 발행·결제 구조는 유지한다.
- 2026-10-15 최신 master 기준 `feature/DL-16796`에서 11파일 명칭 변경, normal commit/push와 합성 PDF8사례 검증 완료. 앱 최신 소스상 네이티브 수정은 불필요하다.
- [PR #4699](https://github.com/Innvoaid/dentlink-client/pull/4699)을 `release/v1.89.0` 대상으로 전달했다. CodeRabbit 완료·미해결0건/추가 수정 없음, 팀 리뷰 대기다. 병합·배포·실계정/앱 다운로드 QA와 첨부 시각 대조는 미완료다.
- 사용자가 개발 완료를 확인하고 메모리화 후 대기를 요청했다. Jira 댓글은 남기지 않고 상태는 사용자가 관리한다. 재개 요청 전 추가 작업·모니터링 없음.
- [개인 체크포인트](projects/dentlink-client-billing-statement.md)

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

### Dentlink DLDS / AI 화면 제작 — DL-16437 / DL-16466 / DL-16471

- 실제 컴포넌트 정비 → AI 프롬프트·하네스 정비 → 필요시 에디터 순서다.
- DLDS는 사용자 재개 요청에 따라 대표 사용 화면 검증과 범용 UI 경계·모음 페이지
  보완까지 진행했다. 전체 완료 여부·남은 범위는 최신 체크포인트를 따른다.
- 최신 지시로 아이콘 추가 전수 대조는 제외하며 누락만 대상으로 한다.
  누락 확인·명칭 정리에 이어 보조 UI 의존성·사용 예제 정비와 검증을 마쳤다.
  **사용자 수동 QA는 전체적으로 괜찮아 보인다는 결과이며 전수 무결함 판정은 아니다.**
  재개 승인에 따라 Password E2E 선택자 수정·16건 재검증과 조사 자료5개 정리를
  마쳤다. **2단계 사용 기준·실험 초안에 이어 첫 DLDS 연락처 수정 화면의 생성·수정·로컬 미리보기 검증**을
  마쳤다. 기존 worktree의 `feature/DL-16471`, `pnpm dev:ai-preview`5178에서 확인한다.
  Figma Code layers에서 원본 master 빈 화면의 독립 생성·프롬프트/요소 선택 수정·ZIP→별도 로컬 실행/타입/빌드까지 시험했다. 기존 Notion에 실제 결과·1GB/초기 FE 설정/adapter 제약·외부 참고·DLDS 방향을 반영했다. 제품 코드는 이번 시험에서 변경하지 않았다. 대표 DLDS 화면 비교와 하네스·에디터의 계속/축소/보류는 사용자/FE팀 논의 대기다. 비개발자용 AI 입력 서비스·완성된 하네스는 아직 없다.
  피드백 Retry/요구사항 외 UI 정리는 PR #4642 병합으로 완료됐다.
  기존 `dentlink-client-dlds` worktree를 보존하며 정확한 저장 상태와 다음 시작점은 체크포인트를 따른다.
- [projects/dentlink-fe-opportunities.md](projects/dentlink-fe-opportunities.md)
- 2단계 검토 초안: [projects/dentlink-ai-dlds-draft.md](projects/dentlink-ai-dlds-draft.md)
- 회의 바로가기: [projects/dentlink-fe-meeting.md](projects/dentlink-fe-meeting.md)

### Dentlink 피드백 요구사항 외 UI 정리 — 완료

- 승인된 피드백 UI 4곳 정리를 PR #4642로 `release/v1.88.0`에 병합했다.
- 작업용 로컬 브랜치를 삭제했고 기본 checkout은 `master`로 복귀했다.
- [projects/dentlink-client-ui-requirements-audit.md](projects/dentlink-client-ui-requirements-audit.md)

### Dentlink Admin LBX — DL-16279 / DL-16387

- 기존 배송 목록·상세 확장, LBX Baby/Mother 생성 및 픽업 생성.
- 백엔드 문제로 이번 배포에서 제외했다. PR #4623은 미병합 종료됐으며
  `feature/DL-16387`은 재개를 위해 보존한다. 테스트 중 실제 생성·수정 요청 금지.
- [projects/dentlink-client-lbx.md](projects/dentlink-client-lbx.md)

### Dentlink Office App

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

- **최신 2026-10-16:** 웹 최종 검토 지적2건과 숨긴 필터 조회를 보완한 PR4700을 사용자가 release에 병합했다.
  최초 주문 확인 전 승인자료 차단, 확인된 주문의 일시적 재조회 실패 시 리메이크/승인 입력 보존을 구분한다.
- **웹:** `/Users/parkjongsun/Repository/dentlink-client-permission`, `feature/DL-16317@f4bfaf1bf`, 원격 동일·clean.
  PR4700 → release/v1.89.0 MERGED, 실제 원격 merge `047fcc585` 확인(13:03:46 KST).
  Clinic 전체35 suites/303 tests·3서비스 타입·정상push린트/커버리지 PASS. frozen설치+정식Clinic production build
  정적195페이지/standalone까지 PASS. 이전 의존성 오류는 pnpm실행경로를 생략한 검증방식 문제로 해소했다.
  병합된 실제 release tree가 검증한 가상 통합 tree와 일치하며 통합 Clinic 타입 PASS. 배포는 미확인이다.
  master 파생 → release → master 전달 경로 유지, 웹 develop은 이번 전달과 무관하다.
- **Office 앱:** `/Users/parkjongsun/Repository/dentlink-app-permission`, 같은 이름의 독립 feature `df3c79a`, 원격 동일·clean.
  주문별 채팅 API·직원/권한별 캐시·2152 세션 보존/상세 연결·승인 조회/비동기 권한·파일 정리·미사용 조건 정리를 완료했다.
  최신 앱 develop62e5864를 feature에 통합해 덴처·생년월일·업로드 대기를 보존했다. 원격 develop은 변경하지 않았다.
  관련26 suites/235 tests·lint오류0·iOS/Android JS bundle PASS, 전체 타입 기존18오류 그대로/추가0.
  [PR329](https://github.com/Innvoaid/dentlink-app/pull/329) → develop OPEN/MERGEABLE.
  CodeRabbit은 자동 대상 release/* 설정으로 skipped(실제 리뷰0). 사용자 지시로 별도 실행 없이 종료했다.
- **Jira:** Web DL-16319 댓글44459, Office DL-16752 댓글44462에 PR 링크/잔여 반영. 둘 다 Ready for Deploy(개발 완료).
- **다음:** 웹 release 통합 완료. 릴리즈/앱 QA 버전 준비 → 같은 병원 Member/Admin 실제 기기·쓰기 QA → 승인 배포.
  Office 앱 PR 상태는 이번에 재확인하지 않았으며 CodePush·배포는 수행하지 않았다.
  새 제품 변경 없이 커밋/원격 동일 상태를 유지하며 사용자 재개 지시 전 대기한다.
- 등록 폴더: `/Users/parkjongsun/Documents/ChatGPT/권한관리 프로젝트`.
- 상세/과거 QA/다음 시작점: [projects/dentlink-permission-management.md](projects/dentlink-permission-management.md).

### Dentlink 통합알림센터 — 사전 검토

- 웹·앱의 REST 조회/읽음/삭제와 딥링크 연결을 다룬다. 별도 알림 SSE·silent FCM
  기반 실시간 동기화는 제외됐다. 공통 구현은 미착수이며 전용 worktree가 없다.
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
  이후 release→develop 동기화 #9도 병합됐다. 웹 `release/v1.88.0`과 별도다.
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
