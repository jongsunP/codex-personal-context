# Office 완료·취소 주문 지연 라벨 — DL-17248

## 현재 체크포인트 — 2026-11-05 작업 시작

- 세션: `01a1aa21-103b-7e82-b530-9b203c18cfe9`, `치과앱 완료·취소 주문 지연 라벨`, local Mac / 메인 프로젝트 등록 확인.
- 부모 [DL-17138](https://innovaid.atlassian.net/browse/DL-17138), Office 하위 [DL-17248](https://innovaid.atlassian.net/browse/DL-17248). 웹은 별도 세션, Lab 제외.
- 승인: 구현, 최종 코드 iOS/Android Simulator/Emulator 검증, commit/push, 앱 release 대상 PR, 양 플랫폼 **Staging CodePush**. PR merge·Production·스토어 출시·자동 CodeRabbit 대응 제외.
- 기본 checkout `/Users/parkjongsun/Repository/dentlink-app`의 `feature/DL-17059@09a777ad9` 보존.
- 별도 도구 생성 worktree `/Users/parkjongsun/.codex/worktrees/office-delayed-label/dentlink-app`, `feat/DL-17248`, 시작 SHA `7f586790e0bbd7b288458e29f00654d38ba68da2` (최신 origin/main).
- PR 후보 `release/v2.2.4@ed1d03fa221599bf6b352b062b3d4e1d862f118f`. 실제 전체 diff·현재 Staging 소스·binary 호환성 확인 전 배포하지 않는다.

## 요구사항과 검증 범위

- 실제 `isDelayed === true`이고 `status`가 `COMPLETED`/`CANCELED`인 Office 주문의 라벨 자체를 숨긴다. `false`로 치환하지 않는다.
- 기존 `On Time`, 진행 중 `Delayed`, 날짜는 유지한다. 공통 OrderStatusBadge에서 Office 조건만 변경한다.
- 홈 Track Your Order, 주문목록, 상세 WebView 진입·복귀 및 Owner/Member 조건을 양 플랫폼에서 최종 코드로 확인한다.
- 상세는 웹 변경을 소비하며 네이티브 상세 UI 추가는 없다. Fixtures와 실제 서버 데이터 검증을 구분하고 테스트 주문 강제 완료 등 서버 변경은 하지 않는다.
- 초기 실행 조건: 기존 알림센터 checkout의 Metro PID29705가8081을 사용 중. 기존 프로세스·IDE·기기 세션을 침범하지 않으며 전용 환경 가능 여부 확인 중.
- 현재 구현·런타임 검증·제품 commit/PR/CodePush 미완료. 다음: 최소 변경 검증, 독립 리뷰, 전용 실행 환경과 배포 소스 검증.
- 이 개인 파일만 관리하며 PROJECTS.md/FE 메인 문서는 메인세션 담당. 작업 공간/branch/세션 자동 정리 금지, 사용자 승인 대기.
