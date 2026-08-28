# Dentlink Admin Invitation 필터 — DL-16004

이 문서는 Admin의 이메일 알림과 CRM Invitation 필터 작업에 대한 개인
체크포인트다. 다음 세션에서는 이 기록보다 live Git, PR, Jira 상태를 우선하며,
구현 완료와 merge, 스테이징 QA, 배포를 구분한다.

## 범위와 요구사항

- Jira: [DL-16004](https://innovaid.atlassian.net/browse/DL-16004)
- 제품 범위: Dentlink Admin
- 이메일 알림 `/notifications/email` 필터에 `EMPLOYEE_INVITATION`을 추가한다.
  선택 시 `?templateType=EMPLOYEE_INVITATION`이 적용되어야 한다.
- CRM `/crm`의 First Funnel Channel 필터에 `INVITATION`을 추가한다. 선택 시
  `?firstFunnelChannel=INVITATION`이 적용되어야 한다.

## 기존 체크포인트 — 2026-08-20

- 전용 worktree:
  `/Users/parkjongsun/Repository/dentlink-client-invitation-filter`
- branch/upstream: `feature/DL-16004` / `origin/feature/DL-16004`
- worktree: clean, local/remote 동기화
- 최신 commit:
  `0ca8b9da6f09a06511894a1b4e8e29e6e7762c48`
  (`[DL-16004] fix: 어드민 Invitation 필터 옵션 추가`)
- release 전달 PR:
  [#4512](https://github.com/Innvoaid/dentlink-client/pull/4512)
  - head: `feature/DL-16004`
  - base: `release/v1.84.0`
  - 마지막 live 확인: open, ready for review, mergeable, 동료 승인 필요
  - CodeRabbit와 Auto Assign check: 성공
  - 미해결 review thread: 0개

## 구현 내용

- `shared/models/src/message/message.types.ts`의 메일 템플릿 필터 맵에
  `EMPLOYEE_INVITATION`을 추가했다.
- `admin/src/pages/crm/index.tsx`의 First Funnel Channel 선택지에
  `INVITATION`을 추가했다.
- `shared/models/src/crm/dashboard/dashboard.types.ts`의 CRM 조회 query 타입에
  `INVITATION`을 추가해 UI 선택값과 API query 타입을 일치시켰다.
- 변경은 3개 파일의 3개 항목 추가로 제한됐으며 Admin 필터 범위 외 동작은 바꾸지
  않았다.

## 검증과 상태 경계

- 사용자가 로컬에서 요구 기능의 정상 동작을 확인한 뒤 commit, push, PR 생성을
  승인했다.
- CodeRabbit summary에는 두 상수의 파일 하단 배치를 제안하는 비차단 nitpick이
  있으나 review thread로 생성되지 않았고, 현재 유효한 차단 이슈는 없다.
- 구현과 로컬 QA는 완료했지만 당시 PR은 아직 merge되지 않았다.
- 스테이징 QA와 실제 배포도 완료로 간주하지 않는다.
- 이 PR은 `release/v1.84.0`에 포함시키기 위한 기능 전달 PR이며, 동료 승인과 merge
  후 해당 릴리즈의 스테이징 검증을 거쳐 배포되는 흐름이다.

## 작업 방식 메모

- 이 작업처럼 매우 작은 범위라면 새 worktree를 만들기 전에 사용자에게 메인
  worktree에서 진행할지 확인한다. 이번 작업은 이미 전용 worktree를 만든 뒤였으므로
  그대로 유지했다.
- shared Dentlink 저장소의 추가 commit, push, PR 수정, merge는 사용자의 명시
  요청이 있을 때만 수행한다.

## 당시 다음 시작점

1. PR #4512의 head, check, review, merge 상태를 live로 다시 확인한다.
2. 새 유효 리뷰가 생기면 현재 코드에 맞는지 검토하고, 명시된 권한 범위에서만
   반영·해결한다.
3. 동료 승인 후 release merge, 스테이징 QA, 배포를 각각 별도 상태로 확인한다.
4. merge 후 사용자가 정리를 요청하면 worktree와 로컬 feature branch를 안전하게
   제거하고 main worktree를 최신 `master`로 대기시킨다.

## 종료 기록 — 2026-08-28

- PR #4512가 `release/v1.84.0`에 merge된 것을 live로 확인했다.
- 사용자 요청에 따라
  `/Users/parkjongsun/Repository/dentlink-client-invitation-filter` worktree와 로컬
  `feature/DL-16004` 브랜치를 제거했다.
- `origin/feature/DL-16004`는 삭제하지 않고 보존했다.
