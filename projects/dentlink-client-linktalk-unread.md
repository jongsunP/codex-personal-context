# Dentlink 홈 LinkTalk 미확인 필터 — DL-14984 / DL-16002

이 문서는 Clinic/기공소 홈 LinkTalk 미확인 메시지 필터의 개인 체크포인트다.
다음 세션에서는 이 기록보다 live Git, PR, Jira 상태를 우선하며, 구현 완료와 merge,
스테이징 QA, 배포를 구분한다.

## 범위와 자료

- 상위 Jira:
  [DL-14984](https://innovaid.atlassian.net/browse/DL-14984)
- FE 하위 Jira:
  [DL-16002](https://innovaid.atlassian.net/browse/DL-16002)
- Figma:
  [LinkTalk](https://www.figma.com/file/wi7gmWdZeGrAogiAr6nVFo?node-id=5359%3A60604)
- 제품 범위:
  - Clinic과 기공소의 홈 LinkTalk 목록
  - Clinic 모바일은 기존 정책대로 홈 LinkTalk 목록을 노출하지 않음
  - 기공소 모바일은 기존 바텀시트 흐름을 유지

## 현재 체크포인트 — 2026-08-20

- 전용 worktree:
  `/Users/parkjongsun/Repository/dentlink-client-linktalk-unread`
- branch/upstream: `feature/DL-16002` / `origin/feature/DL-16002`
- worktree: clean, local/remote 동기화
- release 전달 PR:
  [#4513](https://github.com/Innvoaid/dentlink-client/pull/4513)
  - head: `feature/DL-16002`
  - base: `release/v1.85.0`
  - 마지막 live 확인: open, ready for review, mergeable, 동료 승인 대기
  - CodeRabbit: 성공, 미해결 review thread 0개
- 최신 commit:
  - `5607fffd9` `[DL-16002] fix: 링크톡 빈 상태 디자인 보완`
  - `bb9113001` `[DL-16002] fix: 기공소 홈 링크톡 높이 기준 정리`
  - `ac8c50bf5` `fix: 기공소 모바일 내비게이션 DOM 경고 수정`
  - `331f50863` `[DL-16002] feat: 홈 링크톡 미확인 필터 추가`

## 구현 완료 내용

- Clinic/기공소 홈 LinkTalk에 `All (count)`과 `Unread (count)` 칩 필터를 추가했다.
- 미확인 대화가 있으면 최초 진입 시 Unread를 기본 선택한다.
- Unread 조회에 `unreadOnly=true`를 전달하고 필터별 무한 스크롤을 유지한다.
- 전체 건수는 All 응답의 `totalElements`, 미확인 건수는 기존 unread-count API를
  사용한다.
- Clinic Office 전환 시 필터, 카운트, 초기화 상태를 재설정하고 활성 employee ID를
  최신 목록 query key에 포함했다.
- 필터 전환 시 목록을 remount해 스크롤 위치를 초기화한다.
- 최신 목록 API 오류 시 로딩 표시가 영구 유지되지 않도록 오류 이후 빈 배열로
  정리한다.
- Figma에 맞춰 필터 높이, 간격, 색상과 구분선을 반영했다.
- All과 Unread 건수가 모두 0이면 필터를 숨기고 헤더 구분선을 복원한다. 한쪽
  카운트라도 남아 있으면 필터를 유지한다.
- 기공소 모바일 바텀시트는 기존 최대 구성 높이 646px을 보존하면서 공용 drawer
  관례에 맞춰 `min(646px, 85dvh)`로 열린 높이를 안정화했다. 내부 목록은 남은
  높이에서 스크롤한다.
- 기공소 모바일 Navigation의 스타일 전용 `isMain`을 `$isMain` transient prop으로
  바꾸고 effect dependency를 보완해 DOM 경고를 제거했다.
- wide 화면 목록 시작점 `top: 116px`은 LinkTalk 헤더 64px과 필터 52px을 합친
  값이며 필터와 목록 겹침을 방지하기 위해 의도적으로 유지한다.

## 검증과 상태 경계

- 사용자가 로컬에서 요구 기능과 기공소 모바일 스타일 정상 동작을 확인했다.
- Clinic, Lab, Admin TypeScript 검사와 commit hook이 통과했다.
- push hook의 전체 앱 lint는 오류 0개, 저장소 기존 warning 418개로 성공했다.
- shared configs 3건과 shared hooks 24건, 합계 27개 테스트가 통과했다.
- coverage는 생성한 gitignored baseline 대비 변화가 없다.
- 공용 UI 단독 lint/tsc는 저장소의 기존 Storybook plugin 중복과 다수 기존 오류로
  독립 통과 증거로 사용할 수 없다. 세 앱 TypeScript와 push hook 결과를 현재 변경의
  검증 근거로 사용한다.
- 현재 알려진 기능·코드 차단 문제는 없다. CodeRabbit의 함수 선언 방식 관련
  summary nitpick은 비차단 의견이고 review thread로 생성되지 않았다.
- 구현과 로컬 QA는 완료했지만 PR은 아직 merge되지 않았으며 스테이징 QA와 배포도
  완료로 간주하지 않는다.

## 다음 시작점

1. PR #4513의 head, CodeRabbit, 미해결 thread, 동료 승인과 merge 상태를 live로
   다시 확인한다.
2. 새 유효 리뷰가 있으면 현재 코드에 맞는지 검토하고, 사용자가 CodeRabbit 전체
   처리나 수정·푸시를 요청한 범위에서만 반영한다.
3. 동료 승인 후 release merge, 스테이징 배포, 실제 읽음 상태·카운트 갱신 QA를
   별도 상태로 확인한다.
4. merge 후 사용자가 정리를 요청하면 worktree와 로컬 feature branch를 안전하게
   제거하고 main worktree를 최신 `master`로 대기시킨다.
