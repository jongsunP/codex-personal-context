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

## 현재 체크포인트 — 2026-08-28

- 기존 구현 PR [#4513](https://github.com/Innvoaid/dentlink-client/pull/4513)은
  `release/v1.85.0`에 merge됐다.
- QA 후속 PR [#4544](https://github.com/Innvoaid/dentlink-client/pull/4544)은
  `feature/DL-16226`에서 `release/v1.85.0` 대상으로 merge됐다.
  - `c81cfa384` `[DL-16226] fix: 링크톡 미읽음 카운트 동기화`
  - `7d5455b59` `[DL-16227] fix: Case Preference 빈 상태 안내`
- DL-16226은 Clinic/기공소에서 필터 전환 시 목록뿐 아니라 미읽음 카운트도
  재조회해 두 표시가 어긋나는 문제를 수정한다.
- DL-16227은 기존 Case Preference 데이터 소스와 노출 조건은 유지하고, 전체
  preference가 비어 있을 때 안내 문구만 표시한다.
- commit hook의 Clinic/Lab/Admin TypeScript 검사가 통과했다. push hook도 전체
  lint 오류 0개(기존 warning 418개), shared config 3건·hook 24건과 coverage delta
  변화 없음으로 통과했다.
- 사용자 요청에 따라 전용 worktree와 로컬 `feature/DL-16002`,
  `feature/DL-16226` 브랜치를 제거했다. 원격 브랜치는 보존했다.
- 현재 로컬 Dentlink 웹 worktree는 메인 `master`와 진행 중인 주문 피드백
  `feature/DL-15828`만 유지한다.
- 스테이징 배포를 위해 원격 `stage`를 삭제한 뒤 최신 `origin/master`
  (`8e05cbb84`)와 동일하게 재생성했다. `release/v1.85.0`에서 `stage`로 향하는
  배포 PR [#4545](https://github.com/Innvoaid/dentlink-client/pull/4545)을 생성했다.
  마지막 live 확인 기준 mergeable이며 Auto Assign과 CodeRabbit은 진행 중이다.

## 기존 구현 체크포인트 — 2026-08-20

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

1. 배포 PR #4545의 check, review, merge 상태를 live로 다시 확인한다.
2. 새 유효 리뷰가 있으면 현재 코드에 맞는지 검토하고, 사용자가 CodeRabbit 전체
   처리나 수정·푸시를 요청한 범위에서만 반영한다.
3. PR #4545 merge 후 스테이징 배포와 실제 읽음 상태·카운트 갱신 QA를 별도
   상태로 확인한다.
4. 로컬 브랜치와 worktree는 이미 제거됐으므로 추가 수정이 필요하면 원격
   `feature/DL-16226`에서 새 로컬 작업 환경을 준비한다.
