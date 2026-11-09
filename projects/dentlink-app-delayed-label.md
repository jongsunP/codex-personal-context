# Office 완료·취소 주문 지연 라벨 — DL-17248

## 현재 체크포인트 — 2026-11-09 인계 재검토·추가 수정 불필요

- 사용자 직접 지시의 인계에 따라 기존 isDelayed 요구를 재검토했다. Office 기본 checkout `feature/DL-17059@1f956ae`는 보존하고 원격 release를 fetch한 뒤 `release/v2.2.4@4892f1c1849833054453f01145b2f012782bb9da`를 git show로 읽었다. 이전 Staging source `7f325896`와 동일한 검증 코드이며 새 배포 상태/기기 수신을 조회한 것은 아니다.
- **요구 충족·추가 조치 없음:** HomeTrackOrderCard→OrderProgressStatus와 Orders의 OrderOfficeListItem이 같은 OrderStatusBadge를 호출한다. `GET /office/orders → OrderOfficeListDto`의 서버 판정을 변환하지 않고, true+COMPLETED/CANCELED를 숨긴다. true라면 isDelayed 키가 존재하므로 Office 판별에서 빠지지 않는다. On Time·진행 중 Delayed·기존 날짜 조건은 유지한다. Office 배지는 홈에만 있다는 설명은 틀리며 주문목록에도 있다.
- Staging Office 그룹 Swagger `https://stg-api.dentlink.io/v3/api-docs/Office%20API`에서 `isDelayed?: boolean`, `deliveryRequestAt?` 및 required/nullable 미선언을 확인했다. isDelayed 누락/null은 필요한 날짜가 있고 Office로 판별되면 기존 On Time이다. isDelayed·deliveryRequestAt 두 키가 모두 없으면 옛 Lab 분기로 가지만 Office 계약에는 Lab 요청일 필드가 없어 날짜 가드에서 라벨 없이 반환한다. 새 회귀/요구 누락 근거가 없으며 기공소의 키 누락 숨김을 Office에 새로 이식하지 않는다.
- DL-17138 댓글44920/주문7000012592의 In Fabrication 대 Completed 상태 문구·아이콘 문제는 메인세션 별도 범위다. 실제 앱 목록 응답을 확인한 것은 아니며 status/detailStatus 우선순위를 이 세션에서 수정하지 않는다. 통합알림센터 채팅에는 회신/진행 조회 요청을 하지 않았다.
- 제품 코드·PR·배포·기기를 변경하지 않았고 기존 최종 실행 증거를 재사용했다. 결과는 이 담당 채팅에서 보고하고 다음 구체적인 요청까지 대기한다.

## 선행 체크포인트 — 2026-11-06 전달 상태·코드 검토 완료·대기

- 사용자 최종 확인 후 작업 정리·메모리 저장·대기로 마감했다. Office는 기존 PR340/Staging v343을 유지하며 이번 Lab PR36/v62 후속 작업에 따른 추가 변경·재배포는 없다. 아래 코드 검토에서 새 크래시 경로를 발견하지 못해 추가 사용자 실기기 확인 항목은 없고, 별도 요청 없이 기기/서버 조회·배포·main 통합을 진행하지 않는다.
- 후속 사용자 요청으로 배포 source `7f325896`의 이번 +8줄 숨김 조건과 홈/목록 호출부를 코드상 크래시 관점에서 재검토했다. null/undefined 주문은 기존 첫 가드에서 반환하고, 누락 `isDelayed`·`status`는 단순 비교라 예외를 만들지 않는다. 추가 훅·이펙트·상태 변경이 없고 `null` 렌더 반환도 안전하여 이번 변경의 새 크래시 경로를 발견하지 못했다. 기존 최종 양OS 증거를 재사용했고 새 기기 조작·테스트·배포는 하지 않았다. 이 변경 때문에 사용자가 직접 실기기에서 크래시를 추가 확인할 항목은 발견하지 못했다. Lab v62 후속 정리·배포는 별도 체크포인트 범위다.
- 사용자 요청: 두 앱의 병합·현재 상태를 다시 확인하고 각각 Staging CodePush를 준비할 수 있는지 판단한다. 이번 turn은 상태 확인이며 새 업로드·merge·기기 조작을 하지 않았다.
- PR340은 `release/v2.2.4@4892f1c1849833054453f01145b2f012782bb9da`에 병합돼 있다. 현재 Staging은 iOS·Android 모두 v343/target2.2.4/enabled/mandatory/rollout100이며 description에 정확한 source `7f325896e3ed0a862a7f8a2099d50c809e576ba1`가 있다.
- Staging source와 최신 release의 **전체 Git tree가 동일**(`6bec6cd3b4dca41f56fc9c608cee251d29a4971b`)하므로 새 CodePush가 필요 없다. 코드·native·lock·스크립트 차이 0이고 기존 관련 검증을 반복하지 않았다. 실제 기기 OTA 수신 여부는 이번 조회로 재검증하지 않았다.
- `origin/main@7f586790`에는 지연 라벨 숨김이 아직 없다. main을 배포 소스로 사용하면 되돌아가므로 이후 작업도 실제 release/source를 비교해야 한다. release→main 통합은 별도 승인 단계다.
- 이전 전용 worktree 두 개는 archive 상태이며 새로 복원하지 않았다. 현재 기본 Office checkout `feature/DL-17059@1b1e449`(알림센터)은 clean 상태로 보존했다. 웹과 알림센터 코드·서버·기기는 변경하지 않았다.

## 선행 체크포인트 — 2026-11-05 Staging 배포·사용자 PR 병합 완료·대기

- 세션: `01a1aa21-103b-7e82-b530-9b203c18cfe9`, `치과앱 완료·취소 주문 지연 라벨`, local Mac / 메인 프로젝트 등록 확인.
- 부모 [DL-17138](https://innovaid.atlassian.net/browse/DL-17138), Office 하위 [DL-17248](https://innovaid.atlassian.net/browse/DL-17248). 웹은 별도 세션, Lab 제외.
- 구현·최종 코드 iOS/Android 검증·commit/push·일반 PR 완료. 사용자가 코드 위험 판단 후 작업 브랜치에서 Staging CodePush를 재승인하여 **양 플랫폼 v343 업로드·활성화 완료**. 이후 **사용자가 PR을 직접 병합**했다. Production·스토어 출시·자동 CodeRabbit 대응은 미승인/미수행.
- 사용자가 "배포된건 확인했어. 다 되면 정리하고 대기"라고 전달했다. 배포는 사용자 확인 완료로 기록하며, 어느 기기/플랫폼의 전체 화면 QA까지 확인했는지는 확대 해석하지 않는다. 추가 배포 조회·기기 조작·자동 감시는 하지 않고 대기한다.
- 기본 checkout `/Users/parkjongsun/Repository/dentlink-app`의 `feature/DL-17059@09a777ad9` 보존.
- 별도 도구 생성 worktree `/Users/parkjongsun/.codex/worktrees/office-delayed-label/dentlink-app`, `feat/DL-17248`, 시작 SHA `7f586790e0bbd7b288458e29f00654d38ba68da2` (최신 origin/main).
- [PR #340](https://github.com/Innvoaid/dentlink-app/pull/340): `feat/DL-17248 → release/v2.2.4`, 1파일 +8/-0. 사용자 병합 보고 후 단건 조회로 merged/closed 확인. 병합 시각 KST 2026-11-05 15:12:22, merge SHA `4892f1c1849833054453f01145b2f012782bb9da`. 기존 PR base는 `ed1d03fa221599bf6b352b062b3d4e1d862f118f`였다.
- 구현 커밋 `9da6f9324eb0b140e955f6c27eba3aad11602af9`, 최종 HEAD `7f325896e3ed0a862a7f8a2099d50c809e576ba1`.
- main/release의 같은 ISV 변경이 별도 커밋으로 존재해 초기 PR 비교에 불필요한 이력이 보였다. 메인세션의 명시 요청에 따라 release를 feature에 정상 merge/push해 정리했다. 전후 src/ios/android/yarn.lock 내용은 동일했다.
- Jira DL-17248만 진행 중으로 변경하고 결과 댓글 `44833`에 PR·로컬 검증·배포 미반영을 기록했다. 부모와 다른 제품 카드는 변경하지 않았다.

## 요구사항과 검증 범위

- 실제 `isDelayed === true`이고 `status`가 `COMPLETED`/`CANCELED`인 Office 주문의 라벨 자체를 숨긴다. `false`로 치환하지 않는다.
- 기존 `On Time`, 진행 중 `Delayed`, 날짜는 유지한다. 공통 OrderStatusBadge에서 Office 조건만 변경한다.
- 이번에 홈·목록 및 상세/Owner·Member까지 검증했으나, 사용자가 무관한 권한/경로 검증을 과도하게 확대한 점을 정정했다. 이후 범위는 실제 코드 영향과 오류 가능성으로 정한다. 이번 배지 숨김은 대표 계정의 관련 표시 조건·날짜 유지 확인이면 충분하며 권한 반복은 불필요하다.
- 상세는 웹 변경을 소비하며 네이티브 상세 UI 추가는 없다. Fixtures와 실제 서버 데이터 검증을 구분하고 테스트 주문 강제 완료 등 서버 변경은 하지 않는다.
- 변경 파일 `src/features/orderList/components/OrderStatusBadge.tsx` 8줄. 홈 `HomeTrackOrderCard → OrderProgressStatus → OrderStatusBadge`, 목록 `OrderOfficeListItem → OrderStatusBadge`가 영향 경로다.
- PROJECTS.md/FE 메인 문서는 메인세션 담당. 이번에는 사용자의 작업지침 업데이트 요청으로 공통 검증 지침도 수정했다. 작업 공간/branch/세션은 자동 정리하지 않는다.

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

## Staging CodePush 결과

- 사용자 지시: 코드 자체가 깨질 가능성을 기준으로 판단하고, 위험이 낮으면 merge 없이 작업 브랜치로 Staging CodePush를 진행한다. 기존 null guard 뒤의 표시 반환 조건만 추가되었고 훅·상태·권한·API·native 변경이 없어 저위험으로 판단했다. 줄 수만으로 무위험이라고 단정하지 않았다.
- 실행: `ENVFILE=env/.env.staging yarn codepush-force:staging-mute`, 작업 worktree/`feat/DL-17248@7f325896e3ed0a862a7f8a2099d50c809e576ba1`. `index.js`, target 2.2.4, mandatory, enabled, rollout 100%. Slack 알림·Git tag/merge·native build·version 변경 없음.
- **iOS Staging v343**: KST 2026-11-05 15:00:08, package hash `fbe90f3f4bd78f538d01c106e9f2dac3740fcd59040e75edc5ac647ab8234520`.
- **Android Staging v343**: KST 2026-11-05 15:01:00, package hash `8547adbb7e1509a8fc8c4762c8679c20de6c683c1ee230baf7854e73614d4454`.
- CLI 종료 0 및 배포 history의 label/target/enabled/mandatory/rollout/전체 source SHA를 확인했다. 증거 `/tmp/dl-17248-codepush-result.json`. 이후 사용자가 배포 확인을 보고했다. 이는 사용자 확인이며 agent가 실제 Staging 기기의 OTA 수신·적용을 독립 관찰한 것으로 기록하지 않는다.
- 기존 ISV 영상 asset 1.48MiB가 500KiB 경고를 냈으나 기존 force 경로로 업로드 성공했다. 이번 표시 변경으로 추가된 asset은 아니다. 제품 worktree는 clean이며 최종 소스는 그대로다.

### 이전 배포 조사 이력

- 작업 전 양 플랫폼 Staging은 v342, target 2.2.4, enabled/mandatory=true/rollout=100%, 업로드 KST 2026-10-27 08:45:30(iOS)/08:45:40(Android)였다. 위 v343으로 갱신되었다.
- 설명이 비어 있어 조회 history만으로 v342의 정확한 Git SHA를 확정하지 못했다. Production 태그 `v2.2.4.86`은 Staging 소스 증거가 아니다. main/release의 src/native/lock tree가 같다는 사실로 이 공백이 해결되지는 않는다.
- OTA bundle 다운로드/디코딩 추가 조사는 메인 지시로 중단했다. 이번 재승인 후 PR/head·release 대비 1파일+8줄·native/lock/package 동일·2.2.4 호환성을 확인하고 새 배포에 source SHA를 명시했다. 이전 v342의 정확 SHA 불명은 역사적 한계로 유지한다.
- release wrapper에는 Slack 자동 알림이 있다. 별도 메시지 승인 없이 실행하지 않으며 무알림 경로를 검토한다.

## 다음 시작점과 환경 보존

- 사용자가 "머지했어. 우선 다 된거 같으니 정리하고 대기"라고 지시했다. 이번 승인 범위의 구현·Staging 배포·PR 병합은 완료이며 남은 자동 작업 없이 대기한다. 병합 후 재배포·추가 감시·브랜치/작업 공간 삭제는 하지 않는다. 변경 요청 시 실제 영향 검사/화면만 재확인한다. Production·스토어는 별도 승인이다.
- 사용자는 작은 JS 수정에 비해 소요 시간이 길다고 지적했다. 필수 화면 검증은 유지하되 환경 우회·배포 소스 조사·반복 확인으로 과도하게 확대하지 말고, 충분한 검증 증거가 확보되면 마감한다.
- 사용자에게 홈 Track Your Order와 주문목록에서 완료·취소 Delayed 숨김, 진행 중 Delayed·기존 On Time·날짜 유지를 확인하도록 안내했다. 이번 앱 변경 때문에 권한별 반복이나 상세 화면 확인을 추가로 요구하지 않는다. 사용자 배포 확인과 PR 병합이 완료되었으며 추가 검증 작업은 없다. 별도 웹 작업은 이 앱 마감 범위로 확대하지 않는다.
- 공통 검증 지침은 개인 context commit `818aa0b`에 저장·push 후 `setup-local-codex.sh`로 Mac의 AGENTS/DEVELOPMENT_STYLE/SESSION_WORKFLOW까지 동기화했다. 앱 실행 확인은 유지하되 단순 UI는 관련 조건만, 권한/상태/훅/native 위험은 관련 경로만 확인하며 충분한 증거 후 중복 검증을 중단한다.
- 추가 사용자 지시로 모든 앱 배포 후 위험 판단·사람이 볼 화면/행동/기대 결과를 먼저 안내하는 App Deployment Handoff를 공통 지침에 반영했다. 사용자 확인 후 정리·대기하며, 이 흐름을 따로 요청받을 때까지 미루지 않는다.
- 전용 Metro 8093, iOS `5C0E7639-2345-4B3F-9979-56AFDDA1C708`, Android `emulator-5554` 보존. Android reverse 8081→8093/9090은 유지하고 임시 3000 reverse는 제거했다. 기존 checkout Metro PID29705/8081은 침범하지 않았다.
- credentials는 출력/파일/Git에 기록하지 않고 기존 전용 테스트 로그인만 재사용했다. 임시 도구는 `/tmp`에만 두었으며 팀 제품 저장소에 개인 QA/인계 파일을 추가하지 않았다.
