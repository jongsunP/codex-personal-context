# Office 완료·취소 주문 지연 라벨 — DL-17248

## 현재 체크포인트 — 2026-11-05 PR 검토 대기

- 세션: `01a1aa21-103b-7e82-b530-9b203c18cfe9`, `치과앱 완료·취소 주문 지연 라벨`, local Mac / 메인 프로젝트 등록 확인.
- 부모 [DL-17138](https://innovaid.atlassian.net/browse/DL-17138), Office 하위 [DL-17248](https://innovaid.atlassian.net/browse/DL-17248). 웹은 별도 세션, Lab 제외.
- 구현·최종 코드 iOS/Android 검증·commit/push·일반 PR 완료. **최신 사용자 지시: PR을 먼저 검토하고 CodePush는 다시 승인한 뒤 진행.** 최초 Staging 승인보다 이 지시가 우선한다. 이번 작업의 OTA 업로드/활성화·PR 병합·Production·스토어 출시는 수행하지 않았다. 자동 CodeRabbit 대응도 미승인.
- 기본 checkout `/Users/parkjongsun/Repository/dentlink-app`의 `feature/DL-17059@09a777ad9` 보존.
- 별도 도구 생성 worktree `/Users/parkjongsun/.codex/worktrees/office-delayed-label/dentlink-app`, `feat/DL-17248`, 시작 SHA `7f586790e0bbd7b288458e29f00654d38ba68da2` (최신 origin/main).
- [PR #340](https://github.com/Innvoaid/dentlink-app/pull/340): `feat/DL-17248 → release/v2.2.4@ed1d03fa221599bf6b352b062b3d4e1d862f118f`. 마지막 조회 시 open/non-Draft/unmerged, 1파일 +8/-0.
- 구현 커밋 `9da6f9324eb0b140e955f6c27eba3aad11602af9`, 최종 HEAD `7f325896e3ed0a862a7f8a2099d50c809e576ba1`.
- main/release의 같은 ISV 변경이 별도 커밋으로 존재해 초기 PR 비교에 불필요한 이력이 보였다. 메인세션의 명시 요청에 따라 release를 feature에 정상 merge/push해 정리했다. 전후 src/ios/android/yarn.lock 내용은 동일했다.
- Jira DL-17248만 진행 중으로 변경하고 결과 댓글 `44833`에 PR·로컬 검증·배포 미반영을 기록했다. 부모와 다른 제품 카드는 변경하지 않았다.

## 요구사항과 검증 범위

- 실제 `isDelayed === true`이고 `status`가 `COMPLETED`/`CANCELED`인 Office 주문의 라벨 자체를 숨긴다. `false`로 치환하지 않는다.
- 기존 `On Time`, 진행 중 `Delayed`, 날짜는 유지한다. 공통 OrderStatusBadge에서 Office 조건만 변경한다.
- 홈 Track Your Order, 주문목록, 상세 WebView 진입·복귀 및 Owner/Member 조건을 양 플랫폼에서 최종 코드로 확인한다.
- 상세는 웹 변경을 소비하며 네이티브 상세 UI 추가는 없다. Fixtures와 실제 서버 데이터 검증을 구분하고 테스트 주문 강제 완료 등 서버 변경은 하지 않는다.
- 변경 파일 `src/features/orderList/components/OrderStatusBadge.tsx` 8줄. 홈 `HomeTrackOrderCard → OrderProgressStatus → OrderStatusBadge`, 목록 `OrderOfficeListItem → OrderStatusBadge`가 영향 경로다.
- 이 개인 파일만 관리하며 PROJECTS.md/FE 메인 문서는 메인세션 담당. 작업 공간/branch/세션 자동 정리 금지, 사용자 승인 대기.

## 최종 코드 검증 결과와 한계

- iPhone 17 Pro/iOS 26.5/Office Development 2.2.4(151), Android API 36/Office Development 2.2.4(134)에서 전용 Metro 8093의 최종 소스를 실행했다.
- 실제 서버 `employee_own` 응답으로 Owner/Member 권한을 확인했다. 양 플랫폼 × 양 역할 × 홈/목록 × 완료/취소/진행 중 × isDelayed true/false = **48개 화면 조합 PASS**.
- 상태 조합은 조회 캐시에만 임시 fixture를 적용했다. 서버 주문 상태 변경은 없었다. 완료+true 라벨 없음·날짜 유지, 완료+false On Time, 취소 양쪽 라벨 없음·날짜 `-`, 진행 중 true Delayed/false On Time을 확인했다.
- 원본 서버 주문의 상세 WebView 본문 진입·뒤로가기와 로컬 웹 `localhost:3000` 연결을 역할별로 확인했다. 완료·취소 지연 실주문 전체 확인이나 배포된 웹 변경 검증을 의미하지 않는다. 웹 수정은 별도 DL-17141/[Web PR #4835](https://github.com/Innvoaid/dentlink-client/pull/4835) 범위다.
- 홈 카드→DEV 상세→홈 복귀와 목록→상세→목록 복귀를 두 플랫폼·역할에서 각각 확인했다. Android 증거는 `/tmp/dl17248-android-evidence/android-runtime-report.json`과 `final-restore-result.json`에 있다. Android 관찰 범위에서 앱 crash 기록은 없었다. 초기 OS ANR 안내와 iOS 디버그 도구의 모듈 탐색으로 유발한 redbox는 제품 변경 결함으로 판정하지 않았으며 iOS는 재시작 후 정상 화면을 재확인했다.
- iOS 임시 fixture/URL override를 복원하고 원래 Member 소속으로 재시작하여 실제 role 응답·홈·임시 데이터 없음 확인. Android 원래 Owner 로그인과 URL/fixture를 복원하고 실제 role 응답을 확인했다.
- 기본 도구가 Android를 인식하지 못하고 iOS 좌표 조작도 실패하여 사용자 대안 조작 승인 후 Maestro/ADB로 완료했다. 앞으로도 기본 도구→가능한 대안→모두 막힐 때 보류하라는 공통 지침 기록은 메인세션 담당.
- 변경 파일 ESLint/Prettier, diff 공백 검사, 버전 일치 검사 PASS. 실제 배지 소스 96조합 PASS(원본과 다른 것은 완료/취소+true 두 경우), 관련 OrderDetailScreen Jest 24개 PASS, 독립 코드 리뷰 이슈 없음.
- 전체 TypeScript는 원본과 동일한 오류 6개(Icon 2/Tooltip 1/MessageText 1/useOrderAddProduct 2), 신규 0개. 전체 lint는 변경 외 범위 50 errors/157 warnings로 실패한다. 전체 검사가 모두 통과했다고 표현하지 않는다.
- 임시 증거: `/tmp/dl-17248-ios/`의 Maestro 결과/화면과 `owner-matrix-results.json`, `/tmp/dl-17248-badge-check-results.json`, `/tmp/dl-17248-ts-diagnostics-results.json`, `/tmp/dl-17248-jest.log`, `/tmp/dl-17248-lint.log`. iOS Member 초기 조합은 세션 CUA AX 관찰 기록에 있다. `/tmp` 자료는 영구 보관을 보장하지 않는다.

## CodePush 읽기 전용 조사

- 조사 당시 양 플랫폼 Staging은 v342, target 2.2.4, enabled/mandatory=true/rollout=100%, 업로드 KST 2026-10-27 08:45:30(iOS)/08:45:40(Android). 이번 작업에서 바뀐 배포가 아니다.
- 설명이 비어 있어 조회 history만으로 v342의 정확한 Git SHA를 확정하지 못했다. Production 태그 `v2.2.4.86`은 Staging 소스 증거가 아니다. main/release의 src/native/lock tree가 같다는 사실로 이 공백이 해결되지는 않는다.
- OTA bundle 다운로드/디코딩 추가 조사는 메인 지시로 중단했다. 재승인 시 당시 PR/head·실제 Staging source·binary 호환성·변경 범위를 다시 확인한다.
- release wrapper에는 Slack 자동 알림이 있다. 별도 메시지 승인 없이 실행하지 않으며 무알림 경로를 검토한다.

## 다음 시작점과 환경 보존

- 사용자 PR 검토 대기. 변경 요청 시 영향 검사/화면을 다시 확인한다. **별도 재승인 전 CodePush를 시작하지 않는다.** merge·Production·스토어는 각각 별도 승인이다.
- 사용자는 작은 JS 수정에 비해 소요 시간이 길다고 지적했다. 필수 화면 검증은 유지하되 환경 우회·배포 소스 조사·반복 확인으로 과도하게 확대하지 말고, 충분한 검증 증거가 확보되면 마감한다.
- 사용자 QA 기대값은 PR 본문의 표에 정리했다. 배포본 QA와 상세 웹 변경 확인은 해당 버전 제공 이후 남아 있다.
- 전용 Metro 8093, iOS `5C0E7639-2345-4B3F-9979-56AFDDA1C708`, Android `emulator-5554` 보존. Android reverse 8081→8093/9090은 유지하고 임시 3000 reverse는 제거했다. 기존 checkout Metro PID29705/8081은 침범하지 않았다.
- credentials는 출력/파일/Git에 기록하지 않고 기존 전용 테스트 로그인만 재사용했다. 임시 도구는 `/tmp`에만 두었으며 팀 제품 저장소에 개인 QA/인계 파일을 추가하지 않았다.
