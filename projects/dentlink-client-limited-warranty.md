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

### 후속 결정: 이번 1.85.1 배포에서 제외

- 사용자가 Warranty를 이번 배포에서 제외한다고 알렸다. 기존 merge/스테이징 배포
  이력은 유지하되, 다음 배포 대상에서는 기능을 제거해야 한다.
- 제외 검토 당시 `origin/release/v1.85.1`의 최신 commit은
  `8d0744936b12e872c48c6715e3d17a85da070054`이며, Warranty PR #4556의 squash
  commit 하나가 마지막에 추가된 상태였다. 이 commit만 되돌려 직전
  `9d0e0a1f4f1728969842ab0a2269638ec1d91987`의 제품 상태로 복구했다.
- 제외 범위는 Warranty 페이지·진입점·공용 고지·전용 번역 등 해당 commit의 16개
  파일이다. 독립 i18n 운영 개선 PR #4557과 나머지 1.85.1 변경은 유지한다.
- 제외 검토 당시 Warranty commit은 `origin/release/v1.85.1`과 `origin/stage`에만
  포함되어 있었다. `origin/master`와 `origin/release/v1.86.0`은 `4fc3b4877`이었다.
- 사용자 후속 지시로 최신 release의 `8d0744936`에서 새 branch
  `feature/DL-16258-release-hold`를 만들고, 원본 commit의 16개 파일 역변경만 적용했다.
  별도 worktree는 만들지 않았으며 메인 checkout에서 작업했다.
- 제외 commit: `af496bb345aa4ad28790de699156ebc9cc85635f`
  (`[DL-16258] fix: 1.85.1 배포에서 워런티 제외`). 해당 commit은 push됐고,
  로컬 branch/upstream은 `feature/DL-16258-release-hold` /
  `origin/feature/DL-16258-release-hold`, worktree는 clean하다.
- 제외 PR [#4567](https://github.com/Innvoaid/dentlink-client/pull/4567)을
  `feature/DL-16258-release-hold -> release/v1.85.1`로 생성했다. 사용자가
  2026-09-03 16:05 KST에 merge했으며 GitHub의 MERGED 상태를 확인했다.
  squash merge commit과 최신 release HEAD는
  `b9fba70b41b5cd782b298a6204d9c1a96e3b0131`이다. 현재 릴리즈 파일에서는 워런티가
  제외됐으며 원본 및 제외 commit의 이력은 남아 있다.
- release에서 제외해도 이미 배포된 스테이징 화면은 자동으로 바뀌지 않는다.
  향후 Warranty 재출시 버전은 미정이며 원본 `feature/DL-16258`은 보존한다.

### 워런티 제외 후 스테이징 재배포 완료

- 사용자의 명시 지시로 원격 `stage`를 삭제하고 당시 최신 원격 `master`의
  `4fc3b4877458d99439d1474aff03b9eff17ab34a`에서 재생성했다.
  - 삭제 전 stage: `24b5af7b74a24fa83125d0dd3e5c934c634a2cce` (PR #4566 merge)
  - 열린 stage 대상 PR 0개, protected=false, 유효 branch rules=[]를 확인했다.
  - 삭제 직전 master/stage/release ref가 검사한 SHA와 같은지 재확인한 뒤 ref 삭제와
    생성을 수행했다. 보호 규칙 우회는 사용하지 않았다.
- [PR #4568](https://github.com/Innvoaid/dentlink-client/pull/4568)
  `[배포] 워런티 제외된 release/v1.85.1 스테이징 반영`을 16:09 KST에 생성했다.
  - head: `release/v1.85.1` / `b9fba70b4`
  - base: `stage` / `4fc3b4877` (= 당시 최신 `origin/master`)
  - 생성 당시 OPEN·일반 PR, MERGEABLE·CLEAN, 자동 merge 미설정으로 확인했다.
  - 사용자가 2026-09-03 16:13 KST에 merge했으며 GitHub에서 MERGED를 확인했다.
    merge commit: `5cb3ddaf387ebfc4df0cbffcf7abee505863bf27`.
  - release 전체 9개 commit, 최종 diff 25개 파일(+851/-409)을 전달했다. 커밋 이력에
    워런티 추가와 제외가 모두 있지만 최종 결과에는 워런티가 없다.
- 삭제 전 stage와 현재 release의 차이는 워런티 역변경 16개 파일뿐이다. 다른 1.85.1
  변경은 보존됐다. 실제 release tree는 검증된 제외 commit `af496bb34`의 tree
  `5ef3ed825237336d8b4538f6d61bc8e77101ff3a`와 같고 `git diff --check`도 통과했다.
- 이번 전달 작업에서 제품 코드와 로컬 checkout은 변경하지 않았다. 로컬은
  `feature/DL-16258-release-hold` / `af496bb34`, clean이며 `develop`은 변경하지 않았다.
- 사용자가 PR #4568 merge와 스테이징 배포 완료를 알렸다. merge는 GitHub에서 직접
  확인했고, 배포 완료는 사용자 확인 기준이다. 실제 배포 workflow·서버 SHA·화면 QA는
  별도로 확인하지 않았다. 운영 배포는 별도 상태이며 현재 추가 작업 없이 대기한다.

### 제외 변경 검증

- 결과 tree `5ef3ed825237336d8b4538f6d61bc8e77101ff3a`가 Warranty merge 직전
  `9d0e0a1f4`의 tree와 정확히 일치한다. 변경은 16개 파일, 6줄 추가·425줄 삭제뿐이며
  독립 i18n 운영 개선과 나머지 release 파일은 그대로 보존됐다.
- `git diff --check` 및 Clinic/Lab/Admin 전체 타입 검사를 통과했다. 기본 pre-commit
  hook에서도 세 앱 타입 검사를 통과했다.
- `pnpm check:i18n`은 제외 후 1,585개 key·20개 locale JSON으로 통과했다. 제외 전
  release 상태에서는 gnb/orders en/ko 4개 파일의 stale 오류가 있었다. 현재 공용 시트와
  제외 후 JSON이 일치하며, 이번 작업에서 시트를 쓰거나 JSON을 일괄 재생성하지 않았다.
- `pnpm audit:i18n`의 기존 `unresolvedKeyCount=9`는 전후 동일하다.
  `unknownLiteralCount=0`, `clinicRegressionCandidateCount=0`을 유지했다.
- 기본 push hook을 우회 없이 통과했다. 앱 lint의 기존 경고는 남아 있고, 공용 설정
  테스트 3건과 공용 hooks 테스트 24건을 통과했다. coverage 비교는 기본 비강제 경로이며
  이번 변경으로 별도 테스트 파일이나 검사 artifact를 추가하지 않았다.
- Warranty component·경로 상수·전용 번역 참조를 소스에서 다시 검색해 남은 참조가
  없음을 확인했다. 실제 브라우저 화면 QA와 production build는 이번 제외 작업에서는
  실행하지 않았다.

### 기존 전달 이력

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
  - 생성 당시 base: `stage` / `4fc3b4877458d99439d1474aff03b9eff17ab34a`
  - 사용자가 2026-09-03 14:58 KST에 merge했으며 GitHub에서 MERGED를 확인했다.
  - merge commit: `24b5af7b74a24fa83125d0dd3e5c934c634a2cce`
  - Warranty뿐 아니라 당시 1.85.1의 전체 변경 8개 commit을 전달했다.
  - 사용자가 후속 메시지에서 스테이징 배포 완료를 알렸다. 배포는 사용자 확인 기준이며,
    이번 후속 기록에서 배포 workflow나 서버의 실제 SHA를 별도로 검사하지 않았다.
  - 실제 화면 QA와 운영 배포는 별도 상태다. `develop`은 이번 작업에서 변경하지 않았다.

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
- 사용자가 코드와 정책 범위를 확인했고 2026-09-03 스테이징 배포 완료도 알렸다.
  스테이징 기능 QA 및 운영 배포까지 완료한 것으로 확대 해석하지 않는다.
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
- Warranty는 PR #4567 merge로 1.85.1의 현재 파일에서 제외됐다. 제외 변경이 반영된
  최종 release를 기존 회사 전략대로 `master`와
  이후 활성 release인 `release/v1.86.0`에 순방향 반영한다. Warranty를 1.86.0에
  자동으로 재출시하는 의미는 아니다.
- PR merge가 로컬 branch 정리 권한을 자동으로 의미하지 않는다. 로컬 정리와 shared
  repository의 추가 수정·push·PR mutation·merge는 사용자의 명시 요청이 있을 때만
  수행한다.

## 다음 시작점

1. 워런티 제외 PR #4567과 스테이징 전달 PR #4568은 merge됐고, 사용자가 스테이징
   배포 완료를 알렸다. 추가 작업 없이 대기하며 리뷰·배포를 자동으로 진행하지 않는다.
2. 추후 QA 요청이 오면 실제 워런티 제외 화면과 배포 버전을 확인한다. 이전 PR #4566
   배포는 Warranty 포함 버전이며 이번 #4568 배포와 구분한다. 운영 배포는 별도다.
3. 이후 Warranty 재개 요청이 오면 원본 feature와 새 목표 release의 live Git을 비교해
   재적용 방법을 정한다. 이번 제외를 제품 기능 영구 폐기나 원본 branch 정리로 해석하지
   않는다.
