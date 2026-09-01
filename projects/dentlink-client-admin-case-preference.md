# Dentlink Admin 주문 Case Preference 배치 — DL-16269

이 문서는 Admin 주문서 Case Preference 배치 개선의 개인 체크포인트다. 다음
세션에서는 이 기록보다 live Git, PR, Jira와 실제 배포 상태를 우선한다.

## 범위와 결정

- Jira: [DL-16269](https://innovaid.atlassian.net/browse/DL-16269)
- 부모 Jira: `DL-16267` (`주문서 생성 2단계 rx가 아래로 내려감`)
- 제품 범위는 Admin 주문 생성·수정이며 Clinic/Lab 화면은 변경하지 않는다.
- Case Preference 데이터와 조회 조건은 기존 구현을 그대로 사용한다. Backend/API
  변경은 없다.
- 기존에는 주문 2단계 왼쪽에서 C.P가 스캐너 주문서 위에 표시됐다. 변경 후에는
  2~4단계의 우측 액션 버튼 아래에서 계속 표시한다.
- 4단계의 액션은 주문 상태에 따라 `Place Order` 또는 `Save Changes`다.
- 공용 주문 UI에는 범용 optional prop `rightBottomComponent`만 추가하고 Admin에서만
  Case Preference 패널을 전달한다. Clinic/Lab은 prop을 전달하지 않는다.
- 버튼 영역과 C.P 패널 사이의 실제 간격은 30px이다.

## 현재 체크포인트 — 2026-09-01

- 메인 checkout: `/Users/parkjongsun/Repository/dentlink-client`
- branch/upstream: `feature/DL-16269` / `origin/feature/DL-16269`
- base: `origin/master` `4fc3b4877458d99439d1474aff03b9eff17ab34a`
- product commits:
  - `e6cb4a3fce4858f4aea184a0d796d5a2eafa492f`
    `[DL-16269] fix: 관리자 주문서 Case Preference 위치 개선`
  - `be31e35967417b05de0b03fe1983d88fac7b6ac1`
    `[DL-16269] fix: Case Preference 리뷰 반영`
- release branch: `release/v1.85.1`
  - `origin/master`와 동일한 `4fc3b4877458d99439d1474aff03b9eff17ab34a`에서
    원격 브랜치를 신규 생성했다.
- release PR: [#4558](https://github.com/Innvoaid/dentlink-client/pull/4558)
  - base/head: `release/v1.85.1` <- `feature/DL-16269`
  - 마지막 live 확인: open, review required
  - CodeRabbit 재검토 성공, unresolved review thread 0개

## 구현 내용

- Admin `OrderForm`에서 C.P 노출 단계를 `PRODUCT`, `OPTION`, `ADDITIONAL`로 확장했다.
- 2단계 일반 상품·Denture 우측 영역, 3단계 Next 아래, 4단계
  Place Order/Save Changes 아래에 동일한 패널을 주입한다.
- 새 패널은 일반 레이아웃 흐름 안에서 렌더링되므로 다른 UI를 overlay하지 않는다.
- 기존 C.P용 `OrderFormLayout.additionalPanelComponent`와 왼쪽 sticky wrapper는 새
  우측 슬롯으로 대체되어 제거했다.
- 기존 `OrderCasePreferencePanel`, employee detail 조회, user Case Preference 조회,
  loading/error/empty 상태, 내부 최대 높이와 스크롤은 유지했다.

## 검증과 상태 경계

- 사용자 로컬 확인: Admin 주문 화면에서 기능과 우측 배치, 최종 30px 간격을 포함한
  화면 노출을 정상으로 확인했다.
- `git diff --check` 통과.
- Clinic, Lab, Admin TypeScript 검사 통과.
- Admin Next.js production build 통과. 기존 TypeScript 최소 권장 버전 및
  Browserslist 데이터 경고만 있었다.
- Clinic/Lab/Admin 전체 lint는 오류 0개, 저장소 기존 warning 합계 419개로 통과했다.
- push hook에서 shared config 3개, shared hook 24개, 합계 27개 테스트와 coverage
  검사가 통과했다.
- CodeRabbit의 유효한 지적 2건을 반영했다. OPTION 단계 C.P는 현재 선택된
  dentist userId를 우선 사용하고 직접 진입·새로고침 시 기존 employee detail 조회를
  fallback으로 유지한다. Product 단계 슬롯은 오류·안내 메시지보다 앞에 배치해 액션
  버튼 아래 30px 간격을 유지한다.
- 후속 커밋에서 Clinic/Lab/Admin TypeScript, 전체 lint 오류 0개(기존 warning 419개),
  Admin production build, 포맷, `git diff --check`, shared 27개 테스트와 coverage hook이
  통과했다. shared UI 단독 lint는 저장소의 Storybook ESLint 플러그인 중복 버전 충돌로
  실행 자체가 막혔으며 Admin 변경 파일 lint는 통과했다.
- CodeRabbit 재검토의 세미콜론 제거 및 function 선언 전환 nitpick은 저장소
  `.prettierrc`의 `semi: true` 및 인접 Order 컴포넌트의 `const` 패턴과 충돌해 적용하지
  않고 PR에 근거를 남겼다.
- 공용 UI standalone `tsc`는 이번 변경과 무관한 기존 generated icon, story 및 누락
  모듈 오류가 있어 독립 기준으로는 통과하지 않는다. 실제 세 앱 TypeScript와 Admin
  build로 이번 prop 연결을 검증했다.
- commit/push/PR 생성까지 완료했다. PR merge, CodeRabbit 처리, release 포함,
  staging QA와 production 배포는 아직 완료로 간주하지 않는다.

## 다음 시작점

1. PR #4558의 동료 리뷰와 승인 상태를 live로 확인한다.
2. 승인 후 `release/v1.85.1` merge와 배포·QA는 각각 별도 상태로 관리한다.
3. merge 후 사용자가 요청하면 메인 checkout을 `master`로 복귀하고 로컬 feature
   branch를 정리한다.
