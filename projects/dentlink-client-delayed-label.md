# 치과 웹 완료·취소 주문 지연 라벨 — DL-17141

## 현재 체크포인트 — 2026-11-05

- 세션: `치과 웹 완료·취소 주문 지연 라벨`, `01a1aa21-0ebc-75c0-9791-e5b21e524224`. local Mac / 메인 프로젝트 등록과 초기 실행 확인. 메인 세션이 gpt-6-astra/ultra 적용 확인을 기록했다.
- 승인: 웹 구현·검증·commit/push·`release/v1.92.0` 대상 일반 PR까지. merge·배포·자동 CodeRabbit 대응은 제외한다. 앱은 별도 DL-17248 세션 담당이다.
- 요구: OFFICE 서비스의 `isDelayed === true`이면서 `COMPLETED` 또는 `CANCELED`이면 Delayed 라벨만 숨긴다. 기존 false/undefined의 On Time, 날짜·진행 중 표시, LAB 동작 유지.
- 정본: [DL-17141](https://innovaid.atlassian.net/browse/DL-17141), [DL-17138](https://innovaid.atlassian.net/browse/DL-17138). 현재 원문 기준 Frankie 확정 댓글은 부모의 `44831`이다(접수 인계의 44828 참조와 다름). 원문·본문·댓글 실조회 완료.
- checkout: `/Users/parkjongsun/Repository/dentlink-client`. 기존 `feat/e2e-deploy-status@65dd71ddf` clean/upstream 동일 확인 후 보존. 최신 `origin/master@c5a4b5e372fb7734c72a5faec6807e7b554c1dd6`에서 `feat/DL-17141` 생성 확인. 시작 시 동명 local/remote 없음. PR 대상 최신 조회 `origin/release/v1.92.0@05243d50c4125166d723a4c3ed683bdd17cf75f3`.
- 변경 예정: `shared/ui/src/OrderDetailUI/parts/BoxComponent/OrderDetailBoxDeliverySchedule.tsx`의 badge 표시 조건 한 곳. PC/모바일 주문목록은 기존 완료·취소 badge 미표시를 회귀 확인한다.
- 다음: 최소 구현 → 조건 매트릭스/PC·모바일 화면/독립 리뷰 → 정상 hooks·E2E 영향 가드 → commit/push·일반 PR·첨부. 앱 WebView 확인용 로컬 cwd/포트를 최종 보고한다. 다른 checkout·IDE·기존 서버·창배치는 변경하지 않는다.

## 검증·전달

- 진행 중. 초기 체크포인트이며 구현·QA·PR·배포 완료를 의미하지 않는다.
