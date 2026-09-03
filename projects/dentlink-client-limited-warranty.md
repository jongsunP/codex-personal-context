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

## 현재 체크포인트 — 2026-09-03

- 제품 repository: `/Users/parkjongsun/Repository/dentlink-client`
- 제품 branch/upstream: `feature/DL-16258` / `origin/feature/DL-16258`
- 제품 commit:
  `8d3c8ad1ef5247f42fa68084af8008d7b02fa5a9`
  (`[DL-16258] fix: Limited Warranty 영문 오탈자 수정`)
  - 최초 기능 commit: `b3a7163833c3061d57cd05f9206a0d4dd9afd3d9`
- release 전달 PR:
  [#4556](https://github.com/Innvoaid/dentlink-client/pull/4556)
  - head: `feature/DL-16258`
  - base: `release/v1.85.1`
  - 사용자가 2026-09-03 14:44 KST에 기존 `release/v1.86.0`에서 대상을 변경했다.
  - 사용자가 2026-09-03 14:51 KST에 merge했으며 GitHub에서 MERGED를 확인했다.
  - squash merge commit: `8d0744936b12e872c48c6715e3d17a85da070054`
  - merge 전 CodeRabbit 성공, 미해결 review thread 0개를 확인했다.
- 메인 worktree의 실제 checkout은 `feature/DL-16269`, HEAD `be31e3596`이며 clean하다.
  이번 검토·배포 준비에서는 로컬 checkout, 제품 코드, feature branch를 변경하거나
  정리하지 않았다.
- 사용자의 명시 요청으로 원격 `stage`를 삭제한 뒤 당시 최신 원격 `master`와 동일한
  `4fc3b4877458d99439d1474aff03b9eff17ab34a`에서 다시 생성했다.
  - 삭제 전 stage: `5328a2f97a45eb3d947e8be0feb24818386c979c`
  - 삭제 전 stage 대상 열린 PR은 없었고, 보호 규칙 우회는 사용하지 않았다.
  - 이전 stage 반영 PR #4560, #4562, #4565는 이미 merge된 이력이다.
- 신규 스테이징 전달 PR:
  [#4566](https://github.com/Innvoaid/dentlink-client/pull/4566)
  - head: `release/v1.85.1` / `8d0744936b12e872c48c6715e3d17a85da070054`
  - base: `stage` / `4fc3b4877458d99439d1474aff03b9eff17ab34a`
  - 생성 후 OPEN, ready for review, MERGEABLE, auto-merge 미설정을 확인했다.
  - Warranty뿐 아니라 현재 1.85.1의 전체 변경 8개 commit을 전달한다.
  - 이번 작업 범위는 PR 생성까지다. PR merge·실제 배포·스테이징 QA는 사용자가
    별도로 진행하며 완료로 간주하지 않는다. `develop`은 변경하지 않았다.

## 검증과 상태 경계

- `git diff --check`를 통과했다.
- Clinic, Lab, Admin TypeScript 검사를 통과했다.
- Clinic과 Lab production build를 통과했으며 양쪽 `/warranty` 정적 경로 생성을
  확인했다.
- 변경 파일 대상 lint는 오류 0개다. 저장소 기존 경고와 shared UI의 기존 Storybook
  plugin 중복 문제는 이번 변경과 별개다.
- `export:i18n --write`, `generate:i18n`, `check:i18n`을 통과했다. i18n audit의 기존
  unresolved key 8건은 변경 전후 동일하다.
- Warranty 번역 3개는 Sheet의 두 운영 탭에서 번역값과 문구 ID뿐 아니라 페이지,
  화면 상태, 경로, 사용 상태까지 채워진 것을 공개 read-back으로 확인했다. 캡처와
  위치 번호는 runtime 관찰이 없어 비어 있으며 정상이다.
- i18n Sheet 자동화 스크립트와 운영 README 변경은 이 branch와 PR에서 제거했다.
  공통 운영 개선은 독립 branch `feature/i18n-sheet-workflow`와 PR #4557로 이동했으며,
  Warranty가 다시 홀드되어도 별도로 검토·merge할 수 있다.
- Warranty PR의 CodeRabbit 검토는 성공했고 미해결 review thread는 0개다. 이전에
  이 PR에 달렸던 Sheet 운영 리뷰는 분리 후 outdated·resolved 상태다.
- push hook은 전체 앱 lint 오류 0개와 shared config 3건, shared hooks 24건의
  테스트를 통과했다. 전체 lint의 기존 warning은 비차단 baseline이다.
- 사용자가 코드와 정책 범위를 확인했다. 실제 release 환경 QA와 배포는 아직 완료로
  간주하지 않는다.
- 2026-09-03 대상 변경 검토에서 base `9d0e0a1f4`와 Warranty head `8d3c8ad1e`를
  `git merge-tree`로 합쳐 충돌 없음을 확인했다. 추가되는 것은 Warranty commit 2개뿐이며
  기존 1.85.1 번역값은 모두 보존되고 en/ko에 Warranty 키 3개씩만 추가된다.
- 병합 tree `130c731f6fabc316fe76d9c7caaa205e9c207bd6`를 메모리 내 파일 오버레이로
  TypeScript compiler에 제공하여 Clinic/Lab/Admin 전체 타입 진단 0건을 확인했다.
  checkout이나 제품 파일을 수정하지 않았고 `git diff --check`도 통과했다.
- 실제 squash merge 후 release tree가 위 검증 tree와 동일함을 확인했다. 분리된 i18n
  운영 PR #4557도 이미 1.85.1에 포함되어 있다. 대상 변경 검토에서 브라우저 화면 QA와
  production build를 새로 실행한 것은 아니다.

## 결정과 주의사항

- 오래된 branch 자체를 재사용하지 않고 최신 `master`에서 새 Jira branch를 만들어
  필요한 기능만 이식했다. 원격 `frankieTemp/DL-10132`는 보존했다.
- 현재 요구 범위는 Warranty 신규 페이지와 진입점뿐이다. 과거 branch의 Terms 변경이나
  현재 Terms·Privacy 내용 수정은 포함하지 않는다.
- Warranty branch에는 제품 기능과 Warranty 전용 Lab 번역 키만 남겼다. 공통 i18n
  운영 코드를 다시 합치지 않는다.
- Lab 모바일 하단 내비게이션에는 법률 문서 푸터 진입점을 새로 만들지 않았다. 과거
  요구와 구현은 Clinic Footer, 주문 최종 단계, 리메이크 최종 단계를 명시했고 Lab의
  기존 푸터는 데스크톱 확장 사이드바에 있다.
- Warranty는 이제 1.85.1에 포함되어 있다. 완료된 release는 기존 회사 전략대로
  `master`와 이후 활성 release인 `release/v1.86.0`에 순방향 반영해야 한다.
- PR merge가 로컬 branch 정리 권한을 자동으로 의미하지 않는다. 로컬 정리와 shared
  repository의 추가 수정·push·PR mutation·merge는 사용자의 명시 요청이 있을 때만
  수행한다.

## 다음 시작점

1. 사용자가 이어서 요청할 때 PR #4566과 원격 stage/release 상태를 live로 확인한다.
   PR 생성만 요청된 현재 상태에서 리뷰·merge·배포를 자동으로 진행하거나 감시하지 않는다.
2. 사용자가 PR merge와 스테이징 배포를 진행한 뒤, QA 요청이 있으면 실제 Clinic/Lab
   `/warranty`, 푸터, 주문·리메이크 진입점을 확인한다. 배포와 QA는 각각 별도 증거로 판단한다.
3. 1.85.1 release가 완료되면 `master`와 이후 release로의 반영을 별도 요청 범위에서
   확인한다. 이전 Warranty feature PR을 1.86.0에 다시 만드는 것으로 대체하지 않는다.
4. 사용자가 정리를 요청하면 로컬 feature branch의 보존 상태를 확인한 뒤 제거하고,
   원격 branch 보존 여부는 그때 지시에 따른다.
