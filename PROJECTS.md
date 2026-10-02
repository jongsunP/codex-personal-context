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
  [Mobile app](https://github.com/Innvoaid/dentlink-app).
- 기본 경로: `/Users/parkjongsun/Repository/dentlink-client`,
  `/Users/parkjongsun/Repository/dentlink-app`.
- FE 메인세션은 전체 감독·조율, Git-backed 개인 컨텍스트 관리와 필요시
  프로젝트 폴더·세션 설정을 맡는다. 기능별 세션은 정확한 저장소·브랜치 경계
  안에서 작업하며 별도 통합 제품 저장소는 없다.
- 현재 열린 기능 세션과 다른 기기의 첫 대화에서 읽을 체크포인트:
  [projects/dentlink-fe.md](projects/dentlink-fe.md)의 **다른 기기에서 이어가기** 절.
  과거 로컬 브랜치/worktree 정리 이력도 같은 문서에 보존한다.
- 이 색인은 세부 상태를 중복 보관하지 않는다. 과거 SHA, PR 상태, QA·배포 이력은
  각 프로젝트의 최신 체크포인트에서 확인하고 재개 시 live Git과 대조한다.

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

### Dentlink Mobile App

- 웹과 함께 관리하는 FE 제품 범위다. 기본 checkout은 `dentlink-app`, 기본
  브랜치는 `main`이다. 기능 시작 기준/PR 대상은 매번 확인한다.
- 완료한 기능 브랜치와 별도 worktree는 정리됐으며 현재 로컬에는 `main`만 있다.
- [projects/dentlink-app.md](projects/dentlink-app.md)

### Dentlink 권한관리 — DL-16317

- 통합알림센터의 선행 작업. 초기 설정과 Office API 4개 사용처 조사를 마쳤으며,
  권한관리 본 요구사항 분석·설계·구현은 미착수·사용자 지시 대기다.
- 등록 폴더: `/Users/parkjongsun/Documents/ChatGPT/권한관리 프로젝트`.
- 앱 표시 이름은 `권한관리 프로젝트 폴더`. 기존 `권한관리세션`을 유지한다.
- 체크포인트: [projects/dentlink-permission-management.md](projects/dentlink-permission-management.md).

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
