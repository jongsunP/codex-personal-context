# Dentlink Limited Warranty — DL-16258

이 문서는 과거에 보류됐던 Dentlink Limited Warranty 작업을 현재 코드에 복원한
개인 체크포인트다. 다음 세션에서는 이 기록보다 live Git, Jira, PR과 배포 상태를
우선하며 구현·리뷰·merge·스테이징 QA·배포를 구분한다.

## 범위와 근거

- Jira: [DL-16258](https://innovaid.atlassian.net/browse/DL-16258)
- 관련 과거 Jira: [DL-9895](https://innovaid.atlassian.net/browse/DL-9895)
- 과거 구현 원본: 원격 `frankieTemp/DL-10132`, commit `9f65edae9`
- DL-16258은 배포 시점 미확정으로 반영되지 않았던 과거 Warranty 작업을 현재
  기준으로 다시 반영하는 작업이다.
- Jira에 연결된 Notion 정책 문서는 확인 시 삭제 또는 이동된 상태였다. 정책 본문은
  새로 추측하지 않고 과거 구현의 확정 내용을 사용했다.

## 구현 내용

- Clinic과 Lab에 `/warranty` 정적 정책 페이지를 추가했다.
- 정책 본문은 영어로 유지했다. 기존 i18n 운영 기준상 Terms·Privacy 같은 정적 법률
  페이지는 번역 대상에서 제외한다.
- Clinic과 Lab 푸터에 Limited Warranty 진입점을 추가했다.
- 주문 4단계와 리메이크 최종 단계에 Warranty 동의 안내 링크를 추가했다.
- 공용 주문·리메이크 UI는 Clinic/Office와 Lab에서만 안내를 노출하며 Admin과
  System에는 노출하지 않는다. Admin의 존재하지 않는 `/warranty` 경로로 연결되는
  부작용을 방지한다.
- 공용 `LimitedWarrantyAgreement`와 `LimitedWarrantyContent`를 추가해 페이지와
  사전 고지를 공유한다.
- Lab의 일반 UI 문구만 en/ko i18n 키에 추가했고 Google Sheet에도 동기화했다.
- Lab 확장 사이드바의 푸터 항목 증가에 맞춰 메뉴 높이 계산을 조정했다.
- 기존 Terms·Privacy 정책 페이지와 내용은 변경하지 않았다.
- CodeRabbit이 확인한 정책 본문의 명백한 문법·철자 오류 5곳은 법적 의미를 바꾸지
  않는 범위에서 교정했다.

## 현재 체크포인트 — 2026-08-31

- 제품 repository: `/Users/parkjongsun/Repository/dentlink-client`
- 제품 branch/upstream: `feature/DL-16258` / `origin/feature/DL-16258`
- 제품 commit:
  `8d3c8ad1ef5247f42fa68084af8008d7b02fa5a9`
  (`[DL-16258] fix: Limited Warranty 영문 오탈자 수정`)
  - 최초 기능 commit: `b3a7163833c3061d57cd05f9206a0d4dd9afd3d9`
- release 전달 PR:
  [#4556](https://github.com/Innvoaid/dentlink-client/pull/4556)
  - head: `feature/DL-16258`
  - base: `release/v1.86.0`
  - 마지막 live 확인: open, ready for review, mergeable, review required
  - Auto Assign: 성공
  - CodeRabbit: 재검토 성공, 미해결 review thread 0개
- 메인 worktree는 clean한 `master`이며 `origin/master`와 동기화됐다.
- feature branch는 clean하고 원격과 동기화됐으며 PR merge 전이라 로컬과 원격 모두
  보존했다.

## 검증과 상태 경계

- `git diff --check`를 통과했다.
- Clinic, Lab, Admin TypeScript 검사를 통과했다.
- Clinic과 Lab production build를 통과했으며 양쪽 `/warranty` 정적 경로 생성을
  확인했다.
- 변경 파일 대상 lint는 오류 0개다. 저장소 기존 경고와 shared UI의 기존 Storybook
  plugin 중복 문제는 이번 변경과 별개다.
- `export:i18n --write`, `generate:i18n`, `check:i18n`을 통과했다. i18n audit의 기존
  unresolved key 8건은 변경 전후 동일하다.
- push hook은 전체 앱 lint 오류 0개와 shared config 3건, shared hooks 24건의
  테스트를 통과했다. 전체 lint의 기존 warning은 비차단 baseline이다.
- 사용자가 코드와 정책 범위를 확인했다. 실제 release 환경 QA와 배포는 아직 완료로
  간주하지 않는다.

## 결정과 주의사항

- 오래된 branch 자체를 재사용하지 않고 최신 `master`에서 새 Jira branch를 만들어
  필요한 기능만 이식했다. 원격 `frankieTemp/DL-10132`는 보존했다.
- 현재 요구 범위는 Warranty 신규 페이지와 진입점뿐이다. 과거 branch의 Terms 변경이나
  현재 Terms·Privacy 내용 수정은 포함하지 않는다.
- Lab 모바일 하단 내비게이션에는 법률 문서 푸터 진입점을 새로 만들지 않았다. 과거
  요구와 구현은 Clinic Footer, 주문 최종 단계, 리메이크 최종 단계를 명시했고 Lab의
  기존 푸터는 데스크톱 확장 사이드바에 있다.
- PR merge 전에는 로컬 `feature/DL-16258`을 삭제하지 않는다. shared repository의
  추가 수정·push·PR mutation·merge는 사용자의 명시 요청이 있을 때만 수행한다.

## 다음 시작점

1. PR #4556의 동료 review와 merge 상태를 live로 확인한다.
2. 새 리뷰가 추가되면 현재 코드에 유효한지 검토하고 명시된 권한 범위에서 처리한다.
3. 동료 승인 후 `release/v1.86.0` merge, 스테이징 배포와 실제 Clinic/Lab 경로 및
   주문·리메이크 진입점 QA를 각각 별도 상태로 확인한다.
4. merge 후 사용자가 정리를 요청하면 로컬 feature branch를 안전하게 제거하고
   원격 branch 보존 여부는 그때 지시에 따른다.
