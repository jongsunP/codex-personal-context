# 기공소 지연 판정 API 통일 — DL-17262

## 현재 체크포인트 — 2026-11-09 인계 재검토·추가 수정 불필요

- **최종 후속 정리:** 사용자가 Office 리팩토링 [PR342](https://github.com/Innvoaid/dentlink-app/pull/342)의 머지·CodePush 완료를 보고했다. 사용자 완료 보고로 기록하며 새 배포 라벨·실기기 수신을 agent가 추가 검증한 것은 아니다. 이는 기존 요구 동작을 바꾸지 않는 Office 리팩토링이며 Lab 앱 추가 변경은 없다. 사용자는 메모리만 갱신하고 대기를 지시했으므로 별도 조회·merge·배포·감시는 하지 않는다. Office 상세 이력은 [Office 체크포인트](dentlink-app-delayed-label.md)를 따른다.
- **후속 웹 대조·정리 관점:** 실제 웹 공통 helper는 Lab에서도 boolean이 아니면 숨기고 true=Delayed/false=On Time, COMPLETED+true 유지로 앱과 같다. Lab 앱의 임시 타입·치과 판별·자체 날짜 계산 제거는 PR36에 완료돼 추가 정리 대상이 없다. 반면 Office 앱에는 미사용 Lab 분기가 남아 있어 기능 버그 수정과 별개인 정리 후보로 보고했다. 웹 목록/상세와 앱의 기존 날짜·배송 가능·상태 노출 조건 차이는 신규 정책 확정 없이 일괄 통일하지 않는다. 이번 질문은 읽기 전용 확인이며 코드·PR·배포 변경은 없다.
- 통합알림센터 채팅에서 사용자의 직접 지시로 기존 isDelayed 요구 충족 여부 재검토를 인계받았다. 원래 담당인 이 채팅에서 두 앱의 코드·확정 요구·Staging 명세를 대조했다. 인계 채팅에는 회신하거나 결과 추적을 요청하지 않았다. 인계 자체를 새 배포 승인으로 해석하지 않았다.
- Lab 전용 worktree를 pull하여 `release/v1.0.5@907832d990a59b8a26a4c06e8df6663166a6f7f6`/원격 동일·clean을 확인했다. Office release도 fetch 후 `4892f1c` 그대로이며 이전 검증 소스와 같다. 기본 알림센터 checkout Office `feature/DL-17059@1f956ae`, Lab `feature/DL-17060@a119ba8`의 파일·브랜치·기기·서비스는 변경하지 않았다.
- **Lab 추가 조치 없음:** `POST /lab/orders/search → SearchOrderData/OrderListLabDto → 홈 카드 → OrderProgressStatus(type=home) → OrderStatusBadge`가 서버 값을 변환 없이 전달한다. 배지는 boolean true=Delayed, false=On Time, 누락/null/비boolean=숨김이며 자체 날짜 계산은 없다. 요청일/예상일 존재·배송 가능·NEW와 호출부 CANCELED 제외는 기존 조건이다. COMPLETED+true는 Office처럼 추가로 숨기지 않는다. Lab Orders는 type=orders여서 이 배지가 없고, 저장소에 남은 OrderOfficeListItem은 소비 경로가 없다.
- Staging Lab 그룹 Swagger HTTP200을 다시 확인했다. `OrderListLabDto.isDelayed`와 상세 `OrderDeliveryScheduleDto.isDelayed`는 optional boolean이며 FE 생성 타입과 일치한다. 명세 필드 존재/필수 여부와 실주문 응답은 구분한다. 새 DEV 조회나 인증 주문 데이터 호출, 기기 QA, OTA history 조회는 하지 않았다.
- Office의 누락/null→On Time과 두 키 부재 시 옛 Lab 분기는 기존 동작이며, Office 명세에 Lab 날짜 필드가 없어 해당 분기는 날짜 가드에서 숨김으로 끝난다. 기존 Office 계약은 완료·취소+true 숨김만 추가하는 것이고 키 누락 숨김을 신규 적용하는 요구는 Lab에만 확정돼 있다. 이 차이를 새 정책/결함으로 간주하지 않았다. 자세한 Office 판정은 `dentlink-app-delayed-label.md`에 기록했다.
- **별도 문제 경계:** DL-17138 댓글44920/주문7000012592의 Home·Orders In Fabrication 대 상세 Completed 제보는 status/detailStatus 상태 문구·아이콘 우선순위 건으로 메인세션 담당이다. 실제 앱 목록 응답은 이번에 확인하지 않았으며 isDelayed 제보나 원인 확정으로 바꾸지 않았다. OrderProgressStatus의 문구·아이콘 조건은 수정하지 않았다.
- 기존 요구 기준 추가 제품 코드 수정·PR·배포는 필요하지 않아 수행하지 않았다. 코드가 이전 최종 검증본 그대로이고 새 위험도 발견되지 않아 관련 실행 증거를 재사용했다. 현재 배포 라벨/실기기 수신/해당 주문 판정의 신규 확인을 주장하지 않는다. 이 채팅에서 결과 보고 후 별도 요청을 기다린다.

## 선행 체크포인트 — 2026-11-06 PR36·Staging v62 완료·정리 후 대기

- **후속 코드상 크래시 검토:** 사용자 요청으로 Office 배포 source `7f325896`의 +8줄 숨김 조건과 Lab release `907832d`의 이번 서버 판정·타입 정리 diff/호출부를 읽기 전용으로 재검토했다. 두 앱 모두 이번 변경이 추가하는 크래시 경로를 발견하지 못했다. Office는 null/undefined 주문을 기존 첫 가드에서 반환하고 누락 status/isDelayed는 안전한 비교만 수행한다. Lab은 주문 null/undefined·키 누락/null/비boolean을 반환하고 날짜는 존재 여부만 검사한다. 새 훅·이펙트·상태/네이티브 변경이 없으며 타입 정리는 런타임 JS를 바꾸지 않는다. 관련 최종 양OS 검증을 재사용할 수 있어 새 기기 조작·재배포·무관한 테스트는 하지 않았다. 이번 변경 때문에 사용자 실기기 크래시 재현 확인이 필요한 항목은 발견하지 못했다. 실제 OTA 수신 여부 확인과는 별개다.
- 사용자 재확인에 따라 공통 `App Deployment Handoff`의 기존 안내만 보완했다: Codex 선행 검증 → 그래도 사용자 기기/직접 관찰이 필요한 구체적 공백이 남을 때만 이유·화면·행동·예상 결과 안내. 선행 검증 지침 자체는 이미 `DEVELOPMENT_STYLE.md`에 있어 중복 추가하지 않았다.
- **최종 마감:** 사용자가 두 앱 코드상 크래시 검토 결과와 지침 보완 보고를 확인한 뒤 “좋아. 작업 내용 정리하고 메모리해놓고 대기”를 요청했다. 이번 PR36 정리·v62 재배포는 Lab iOS/Android만 대상이며 클리닉앱은 변경·재배포하지 않았다. 이전 Office PR340/v343 작업과 이번 Lab 후속 전달을 구분한다. 지침·검토 기록은 `877a4b4`로 푸시하고 로컬 Codex 지침까지 동기화했다.
- **완료/남은 범위:** PR36 병합·Lab 양OS Staging v62 활성화·최종 코드 검증·두 앱 코드 검토·지침 보완 완료. 이번 변경의 크래시 확인을 위해 사용자에게 추가로 요구할 실기기 항목은 없다. 실제 사용자 기기 OTA 수신이나 Staging 주문 목록/상세 판정 일치를 직접 확인한 것으로 확대하지 않는다. 이는 이번 요청의 미완료 작업이나 자동 추가 점검 사유가 아니다. 추가 요청까지 점검·배포·다른 앱 확인 없이 대기한다. 재개 시 release `907832d`/v62와 사용자의 구체적인 관찰 결과부터 확인한다.

- 최신 사용자 승인: PR36에 정정할 사항을 확인하고, 없으면 **스쿼시 머지 후 릴리즈로 CodePush 재진행**. 앞선 PR까지만 범위는 이 요청으로 갱신됐으며 기존 대화의 Lab 양OS Staging 범위를 따른다. Clinic·웹·Production·스토어·release→main 병합은 이번 범위가 아니다.
- 사용자가 백엔드에 직접 확인한 사실: 이번 필드는 예외적으로 **Staging 실응답·Swagger에 먼저 반영**, DEV 응답·명세에는 아직 없다. PR36은 이미 확인된 STG 생성 타입을 반영했으므로 코드 정정은 필요 없었다. PR 설명에 이 환경 차이와 백엔드 확인을 보완하고 오래된 PR까지만 문구를 정리했다. 공통 작업지침은 웹 세션 담당으로 이번에 수정하지 않았다.
- [PR36](https://github.com/Innvoaid/dentlink-lab-app/pull/36)은 **2026-11-06 15:24:31 KST 스쿼시 병합 완료**, `release/v1.0.5@907832d990a59b8a26a4c06e8df6663166a6f7f6`. 병합 시 head `3bdf386` 고정 검사를 사용했다. 병합 전 unresolved review thread·리뷰·댓글은 없었고 관련 자동화는 성공/정상 skip이었다.
- 병합된 release의 전체 tree **`ad69ba53e46110e389fb1f8bcf18f5781e307b43`**가 최종 검증 feature `3bdf386`과 동일하다. 기존 v61 source `c60968a` 대비 4파일 +16/-27만 변경됐고 native·package·lock·env·배포 설정은 동일하다. package/Android/Xcode 모두1.0.5 확인. 양OS 최종 홈 검증을 그대로 재사용했고 기기·로그인·Metro 조작이나 무관한 QA는 반복하지 않았다.
- **Lab iOS·Android Staging v62 / target1.0.5** 업로드 완료. iOS **15:25:45 KST**, Android **15:26:24 KST**. `ENVFILE=env/.env.staging yarn codepush-force:staging-mute`를 위 release source에서 실행했고 양OS bundle·Hermes·업로드 성공. 독립 Revopush history read-back으로 source SHA·enabled·mandatory·rollout100을 확인했다. Slack 발송은 하지 않았다.
- packageHash: iOS `846c2a8ad36024e964d2da8aeea1bbda282ed718c723edaafdba9b603a4b8c16`, Android `1c51d96a8738ff794294dd8ef99615c6aae5db9000792ed25782968dcc92ec7c`. 확인 사본은 `/tmp/dl-17262-cleanup-staging-result.json`. 업로드 후 source와 배지 blob `f4896536e66adc62c6eb45ac747d8509e6639c80` 일치·제품 checkout clean을 확인했다.
- 기존 표시 동작은 유지한다. Lab 서버true→Delayed, false→On Time, 키 누락/비boolean→라벨 숨김, 날짜와 일반/remake 조건 유지. 명시적 가드가 있고 최종 양OS 홈 실행에서 관련 크래시/화면 오류를 관찰하지 못했다. 이번 배포가 실제 사용자 기기에 수신·적용됐는지는 별도이며 확인하지 않았다. 필요 시 사용자 확인은 업데이트 후 홈 Track Your Order의 기존 날짜·라벨 유지 정도면 충분하다.
- 요청한 병합·재배포와 타입/분기 정리는 완료됐다. 실제 인증된 Staging 주문의 목록·상세 판정 일치까지 직접 비교한 것은 아니며, Swagger 직접 확인·사용자의 백엔드 확인·Development fixture 실행 증거를 구분한다. 기본 Lab 알림센터 checkout과 Office 작업은 유지했다. 별도 요청 없이 추가 모니터링·배포·main 통합·브랜치 삭제를 하지 않는다.

## 선행 체크포인트 — 2026-11-06 백엔드 계약 반영 정리·PR36 완료

- 사용자 후속 요청: 백엔드도 이미 Staging 배포됐다고 확인했고, 임시 코드 정리를 **다시 PR까지만** 요청했다. 이번 정리의 merge·CodePush·배포는 미승인이며 미수행이다. 이미 전달한 Lab Staging v61은 그대로 유지한다. Clinic·웹 제품은 수정하지 않았다.
- [PR36](https://github.com/Innvoaid/dentlink-lab-app/pull/36): `feat/DL-17262-api-cleanup → release/v1.0.5`, HEAD `3bdf3862d3e96c98c1d2708f5835d56c73d44bd9`, 일반 OPEN·CLEAN, **4파일 +16/-27**. 배포된 `release/v1.0.5@c60968a` 후속 정리이므로 해당 release에서 분기했다. PR 자동 title/body 작업 성공 후 실제 base/head·diff·일반 상태를 재확인하고 채팅에 첨부했다. GitHub connector의 Lab 저장소404 후 기존 gh를 사용했다.
- **Staging 명세 확인:** `https://stg-api.dentlink.io/v3/api-docs/Lab%20API` HTTP200·OpenAPI3.0.1. 기존 기본 `/v3/api-docs`는404지만 `/v3/api-docs/swagger-config`가 올바른 그룹 주소를 안내한다. `OrderListLabDto.isDelayed`와 `OrderDeliveryScheduleDto.isDelayed` 모두 optional boolean이다. 목록 POST `/lab/orders/search`의 `data[]`와 상세 GET `/lab/orders/{orderId}`의 `data.deliverySchedule` 연결까지 명세에서 확인했다. DEV 전체 명세는 아직 목록 필드가 없으므로 이번 정본으로 사용하지 않았다.
- `swagger-typescript-api@13.13.0`과 저장소 generate 옵션으로 Staging Lab 그룹 명세를 임시 디렉터리에 재생성했다. 그룹 명세로 전체 `Api.ts`를 교체하면 다른 API 타입이 삭제되므로 **생성된 `OrderListLabDto` 블록만 그대로 반영**하고 일치 검증했다. 모델 diff는 `isDelayed?: boolean`과 명세 주석 5줄뿐이다. 생성 결과 `/tmp/dl-17262-generated-staging/Api.ts`, 입력 `/tmp/dl-17262-contract-staging.json`은 임시 자료다.
- 제품 변경: `src/models/Api.ts`; `OrderStatusBadge.tsx`의 임시 interface·Office union·`isOfficeOrder` 제거; `HomeTrackYourOrderSection.tsx`와 `OrderProgressStatus.tsx`의 잘못 남은 Office 타입을 Lab DTO로 정리했다. 후자 두 TSX는 TypeScript 변환 후 실행 JS가 수정 전후 동일함을 확인했다. 배송 가능 여부·NEW·일반/remake 날짜 존재·키 누락 boolean 가드는 유지한다. 서버 판정만 사용하고 날짜 비교/Office 완료·취소 숨김은 추가하지 않는다.
- 독립 코드 검토 문제 없음, 변경 TSX ESLint와 diff 검사 통과. 전체 TypeScript 기존 진단 **5개가 수정 전후 바이트 단위로 동일**하다. Prettier는 배지·진행 상태 통과, 홈 섹션은 수정 전후 동일한 기존 포맷 경고가 있어 무관한 재포맷은 하지 않았다. 새 테스트 파일·네이티브 변경/빌드 없음.
- **최종 양OS 홈 실행 확인:** commit `3bdf386`, Badge blob `f4896536e66adc62c6eb45ac747d8509e6639c80`, Development·전용 Metro8094. true→Delayed, false→On Time, 키 삭제→두 라벨 숨김, remake→Delayed·Remake를 실제 화면에서 확인했고 모든 조건에서 날짜2026/11/10 유지·화면 오류/크래시 미관찰. DEV 응답에는 키가 없어 메모리 fixture로 검증했다. `/tmp/dl-17262-cleanup-runtime/report.json` 및 양OS general/remake PNG가 증거이며 실제 Staging 주문 응답 비교와는 구분한다.
- 검증 도중 기존 Android·Office Metro·Reactotron이 외부에서 종료됐고 원인은 확정하지 않았다. 같은 AVD의 최초 재실행 종료 후 낮은 메모리 설정으로 성공했다. 검증 후 원본 캐시9건·로그인과 Android prefs(8082)를 복원하고 iOS launch override가 지속되지 않음을 확인했다. 이번 Lab8094와 재시작 AVD만 종료했으며 외부에서 종료된 Office/Reactotron은 재시작하지 않았다. 제품 checkout은 clean/pushed다.
- 이전 임시 타입·분기 정리 TODO는 이 PR로 완료했다. **실제 인증된 Staging 주문에서 목록·상세 `isDelayed` 판정이 일치하는지는 이번에 검증하지 않았다.** 서버 계약과 실제 데이터 정합성은 구분한다. 다음 시작점은 사용자 PR36 리뷰이며 별도 요청 없이 merge·배포·추가 모니터링하지 않는다.

## 선행 체크포인트 — 2026-11-06 Staging 양OS CodePush 완료

- 사용자 최신 명시 승인: **기공소앱은 CodePush 진행**, 클리닉앱은 이 세션에서 적용한 isDelayed 변경만 설명. 아래 11/05의 PR까지만 지시는 이 승인으로 갱신됐다. 웹·merge·tag·스토어 제출·Slack 발송은 이번 범위가 아니다.
- **Lab iOS·Android Staging v61 / target1.0.5** 업로드 완료. iOS 2026-11-06 14:55:38 KST, Android 14:56:06 KST. 독립 history read-back으로 양OS enabled·mandatory·rollout100 및 description의 정확한 source SHA를 확인했다. 실제 사용자 기기의 OTA 수신·적용은 이번에 확인하지 않았다.
- 전달 소스는 **`release/v1.0.5@c60968a09b19d03f7220c30cd4a013efe351da0a`**. 기존 밀링 PR35 최종 코드 대비 배지 한 파일만 변경되며 native/lock/package/설정은 동일하다. 배지 blob `997784ff07360e58df162466048b32745760cd8d`도 기존 양OS 최종 검증 코드와 같다. 이전에 우려했던 밀링 변경 누락은 해소됐다.
- packageHash: iOS `e12c0a0ccc566a7aa4c05807360886f7c2a989f24413e565f572f3fa3a88090b`, Android `5aa250795c5012070f229dcf431b2bea887fbb10194f59097e1ca8bda562aa9a`. read-back 사본은 `/tmp/dl-17262-staging-result.json`이며 임시 파일이다.
- 전용 managed worktree `/Users/parkjongsun/.codex/worktrees/lab-delayed-api/dentlink-lab-app`를 복원하고 기존 원격 release를 추적하는 `release/v1.0.5`로 전환했다. `yarn install --immutable`, opaque `.env` 상속·ignored 확인, package/Android/Xcode 1.0.5 일치 확인 후 `ENVFILE=env/.env.staging yarn codepush-force:staging-mute` 실행. 양OS Metro production bundle·Hermes·업로드 성공, 배포 후 HEAD/blob 동일·제품 checkout clean. 알림센터의 기본 checkout·기기·Metro는 건드리지 않았다.
- **앱 구현 요구사항 충족:** Office는 기존 서버 판정에 완료·취소된 지연 라벨 숨김만 추가했고 홈 Track Your Order·Orders 목록에 적용된다. Lab은 자체 날짜 비교를 제거하고 서버 boolean을 사용한다. 키 누락/null/비boolean은 두 라벨 숨김, false는 On Time, true는 Delayed다. Lab에 Office의 추가 완료·취소 숨김을 이식하지 않았으며 기존 날짜·호출 조건은 유지했다.
- **Clinic 이번 신규 CodePush 없음.** 기존 양OS Staging v343/target2.2.4에 PR340 변경이 반영돼 있다. 해당 배포 source `7f325896e3ed0a862a7f8a2099d50c809e576ba1`와 최신 `release/v2.2.4@4892f1c1849833054453f01145b2f012782bb9da`의 전체 tree가 동일함을 확인했다. Office main에는 아직 숨김 변경이 없으므로 main으로 재배포하지 않는다.
- 위험 판단은 변경 구조·기존 양OS 표시/키 누락 실행 증거·배포 번들 성공에 근거한다. 해당 검사 범위에서 새 크래시/회귀는 발견하지 못했으며 전체 앱 무결함이나 실제 배포 기기 적용까지 보장한 것은 아니다. 사용자 확인은 **Lab 홈 Track Your Order의 날짜 유지와 서버 값에 따른 라벨**이면 충분하다. 키가 없을 때 라벨이 없는 것은 합의한 정상 방어 동작이다.
- 남은 일은 정식 배포 전 TODO다: 실제 목록 `data[].isDelayed`와 상세 `data.deliverySchedule.isDelayed`의 boolean·판정 일치 확인, Swagger 생성 타입 갱신, 임시 보완 interface와 분기 정리. 코드 주석은 유지했다. 상세 WebView는 별도 웹 배포 범위이며 이번 OTA로 웹 코드가 전달되지는 않는다. 추가 자동 모니터링 없이 다음 요청을 기다린다.

## 선행 체크포인트 — 2026-11-06 병합 확인·Staging 배포 후보 확인

- 사용자 요청: 클리닉·기공소 앱의 현재 병합 상태를 확인하고 각각 Staging CodePush가 목적이라고 명시했다. 이번 turn은 상태/후보 확인만 수행했으며 CodePush·merge·코드 수정·기기 조작은 하지 않았다. 웹은 계속 별도 세션 범위다.
- PR34가 2026-11-06 14:29 KST `release/v1.0.5`에 squash 병합됐다. 최신 배포 후보는 **`c60968a09b19d03f7220c30cd4a013efe351da0a`**, target1.0.5다. 배지 blob은 검증한 `997784ff07360e58df162466048b32745760cd8d`와 같아 키 누락 숨김/false On Time/true Delayed 및 날짜 계산 제거가 유지된다.
- 선행 밀링 PR35 최종 head `f5b5cfa`와 squash `74e76c5`는 전체 tree가 동일하다. release 후보와 그 밀링 최종 코드의 차이는 배지 **한 파일 +17/-11뿐**이다. 앞서 우려한 19파일 밀링 변경 누락은 현재 release에서 해소됐고 native/lock/package/설정 차이는 없다. 밀링에는 오늘 공정 구분선·생산 옵션 열 너비·태블릿 가로 로그인 수정이 포함되며 그 별도 QA와 지연 배지 검증은 구분한다.
- 현재 Revopush Staging은 양OS **v60**, target1.0.5/enabled/mandatory/rollout100, description `feature/DL-17161 / 밀링센터 QA`다. 정확한 source SHA가 없어 OTA와 특정 Git tree의 동일성까지 확정하지는 않는다. 브랜치 원격 ref `dc16b97`만 보면 PR35 최종 변경을 누락하므로 PR head/tree로 비교했다.
- 다음 전달 소스는 위 release 후보이며 구 작업 branch `feat/DL-17262@50213ad`를 그대로 CodePush하지 않는다. 기존 양OS 배지 검증은 재사용할 수 있다. 실제 업로드·활성화·기기 수신은 아직 수행/확인하지 않았다.
- 기본 Lab checkout `feature/DL-17060@93c5e87`은 다른 알림센터 세션 것으로 clean 보존했다. 이전 전용 task worktree는 archive 상태로 유지했고 새 배포 작업 공간은 아직 만들거나 복원하지 않았다. 정식 배포 전 서버 계약·Swagger 타입/분기 정리 TODO는 유지한다.

## 선행 체크포인트 — 2026-11-05 사용자 기준 확인·PR34 완료·대기

- **최종 사용자 확인:** 웹·앱 구분 없이 기공소의 핵심은 자체 날짜 계산을 없애고 치과처럼 서버 `isDelayed` 판정을 따르는 것이다. 키 누락 라벨 숨김은 예외 방어일 뿐이며, 치과의 완료·취소 숨김을 기공소에 적용하지 않는다. 치과는 기존 서버 판정을 유지하면서 완료·취소된 지연 라벨 숨김 조건만 신규 추가한다. 사용자가 이 정리를 확인하고 “정리하고 메모리하고 대기”를 지시했다.
- **마감 상태:** 앱 PR34, 최종 커밋 `50213ad`, 관련 검증과 코드 주석·후속 TODO까지 완료했다. 제품 checkout은 clean이고 이번 CodePush·merge는 미수행이다. 웹은 해당 세션이 담당한다. 기존 기기·Metro·다른 세션 상태를 유지하며 추가 구현·배포·리뷰 대응·상태 폴링 없이 대기한다. 다음 요청 시 PR 리뷰/전달 범위와 정식 배포 전 TODO부터 이어간다.

- 사용자 최종 정책: 기공소가 서버 `isDelayed`를 치과처럼 제공한다고 전제하고 기존 날짜 비교를 제거한다. 날짜 fallback과 치과의 완료·취소 숨김 정책은 추가하지 않는다. **키가 없으면 두 라벨 모두 숨기고, false는 On Time, true는 Delayed**다. 서버가 나중에 제공하면 다음 조회부터 그 값을 따른다. 정식 배포 전에 주석의 타입 갱신·서버 정합성·임시 분기 정리를 수행한다.
- [DL-17262](https://innovaid.atlassian.net/browse/DL-17262), 부모 [DL-17138](https://innovaid.atlassian.net/browse/DL-17138). Office/Web의 완료 작업과 다른 Lab 앱 하위 카드로 생성했다. Jira 상태는 생성 당시 해야 할 일이며 부모 댓글은 작성하지 않았다.
- 구현 위치: `/Users/parkjongsun/.codex/worktrees/lab-delayed-api/dentlink-lab-app`, `feat/DL-17262`, 시작 `origin/main@26623e0`. 도구로 생성한 별도 worktree이며 기존 `feature/DL-17060`의 알림센터 변경은 보존한다.
- [일반 PR34](https://github.com/Innvoaid/dentlink-lab-app/pull/34): `feat/DL-17262 → release/v1.0.5`, 최종 HEAD/upstream `50213ad53988e8fde46b3f9df704cc35727abb93`, clean·1파일 +17/-11. 커밋 `df9e6e5`(서버 판정 전환), `50213ad`(키 누락 라벨 숨김). 자동 title/body workflow 완료 후 실제 OPEN·일반·base/head·변경 파일 수를 확인하고 채팅에 첨부했다. Github connector의 해당 저장소404 후 기존 gh 인증으로 생성했다.
- 사용자 최종 지시는 **CodePush 하지 말고 PR까지만**, 웹은 웹 세션이 담당한다. 이번에는 merge·CodePush·웹 PR 변경·웹 배포를 하지 않았다. 앞선 조건부 Staging CodePush 승인보다 이 마지막 지시를 우선한다.
- 후속 웹 인계: 웹 PR4837에 `0b01b1427`로 LAB 상세의 키 누락 라벨 숨김이 추가됐다. 이 변경부터는 **LAB 웹도 배포 대상**이고 Lab 앱 상세 WebView는 그 웹 배포를 소비한다. 이전 “LAB 웹 추가 배포 불필요”는 서버 판정 통일만의 범위였다. PR은 release/v1.92.0 대상 미병합·미배포라는 웹 세션 인계이며, 이 앱 세션은 웹 제품·PR을 변경하거나 추가 조회하지 않는다.
- 변경 파일 lint/Prettier/diff 검사 통과. 전체 TypeScript 진단은 수정 전후 모두 5개로 내용까지 동일하며 변경 파일 오류는 없다. 관련 기존 Jest 없음; 요청 없는 테스트 파일은 추가하지 않았다. 별도 코드 검토에서 조치할 결함을 발견하지 못했다.
- 기존 iOS/Android 홈 true/false·완료·remake 4조건 증거를 재사용하고, 최종 방어 처리 후 양OS 홈 키 누락 한 조건씩 추가 확인했다. 실제 서버 새 필드 제공은 아직 미확인이고 query-cache fixture 결과와 구분한다. 정적 최종 typecheck도 기존 5개 진단과 바이트 단위로 동일하다.

## 마지막 승인·배포 판단·후속 작업

- 사용자는 처음 위험이 크면 PR만, 괜찮으면 모든 해당 앱 Staging CodePush까지 승인했다. 서버 필드 누락으로 잘못 표시되는 것은 후속 BE 배포로 해결되니 허용하되 크래시를 방어하라고 정정했고, 최종적으로 키 누락은 정상으로 단정하지 않고 라벨 숨김으로 확정했다.
- 코드 자체는 명시적 boolean guard로 키 누락·null·비boolean을 안전하게 제외한다. 훅·캐시·인증·권한·native 변경 없음. 최종 화면 검사 범위에서 오류·크래시 없음. 줄 수만으로 안전을 단정하지 않는다.
- 별개 OTA 범위 위험: Lab Staging 최신은 양OS v59, target1.0.5, 설명 `feature/DL-17161 / 밀링센터`다. 정확 소스 SHA는 메타데이터로 확정하지 못했다. 현재 `origin/feature/DL-17161@dc16b97`는 main/release `26623e0`보다 4커밋·19파일(+300/-176) 앞서고, 밀링 UI·카메라·공정 선택·번역 변경을 포함한다. native/lock/package 차이는 없으나 task의 main 기반 전체 JS를 그대로 올리면 기존 배포 기능을 되돌릴 가능성이 있어 후보 그대로 OTA하지 않았다. 이후 배포 요청 시 기존 Staging 기능을 보존하는 실제 소스를 먼저 확정한다.
- 치과앱 Staging 양OS v343/target2.2.4/source `7f325896e3ed0a862a7f8a2099d50c809e576ba1`가 최신 history에 남아 있음을 이번 요청으로 단건 조회했다. 이번 작업의 Office 변경은 이미 포함되어 추가 CodePush하지 않았다. 실제 사용자 기기 전체 수신을 새로 확인한 것은 아니다.
- 정식 배포 전 TODO: 목록·상세 실제 boolean/판정 일치 확인 → Swagger `OrderListLabDto` 생성 타입 갱신 → `OrderStatusBadgeLabOrder` 임시 보완 제거와 확정된 기공소 계약 기준으로 불필요한 분기 정리. 현재는 이 후속 요구를 주석과 PR에 기록했으며 임의의 추가 표시 정책·API 계약을 만들지 않는다.
- 다음은 사용자 PR 리뷰다. 자동 CodeRabbit 대응, merge, 배포, 스토어 제출, 타 세션 작업은 수행하지 않는다.

## 인계 후 누락 확인 — 2026-11-05

- 사용자가 다른 세션의 완료 인계 중 미처리 사항을 확인·처리하도록 요청했다. 개인 context와 작업 branch를 pull하여 최신 상태를 확인했고, 웹·통합알림센터의 마지막 turn 및 현재 Lab diff를 대조했다.
- 추가 앱 구현 누락 없음. 웹의 치과 전용 `shouldHideOfficeDelayedBadge`와 웹 목록의 `officeEstimatedArrivalAt` 조건은 Lab 앱에 이식할 대상이 아니다. Lab 앱은 기존 `estimatedArrivalAt` 존재 조건과 서버 `item.isDelayed` 판정을 유지한다. 독립 코드 검토도 같은 결론이며 제품 파일 변경은 없었다.
- 이 인계 확인 당시 파일 해시는 `f64e9b1396d1c0341e12bf085df74465fae3be8f`였으며 기기 점유 때문에 남은 검증은 없었다. 이후 사용자 키 누락 정책 수정은 아래 최종 해시로 별도 확인했다. 통합알림센터의 기기 점유 종료 인계 후에만 기기를 사용했다.
- 당시 웹 후속 [PR4837](https://github.com/Innvoaid/dentlink-client/pull/4837)은 GitHub 단건 조회로 OPEN·미병합·일반 PR, `feat/DL-17141-delay-label@3d3344fef → release/v1.92.0`를 확인했다. 선행 PR4835·4836의 완료와 후속 PR4837의 미전달을 구분한다. 서버 판정 통일만으로는 LAB 웹 배포가 불필요했으나, 이후 키 누락 숨김 요구로 LAB 웹도 변경된 최신 인계가 맨 위에 있다.
- 저장소에 설정된 Swagger URL을 실제 조회했다. DEV `/v3/api-docs`는 HTTP200이며 `OrderListLabDto`에 `isDelayed`가 아직 없고 `OrderDeliveryScheduleDto.isDelayed`는 boolean이다. STG의 같은 설정 URL은 HTTP404이므로 STG 명세/배포 상태를 확인하지 못했다. Swagger는 실제 인증 주문 응답의 필드 제공이나 목록·상세 판정 일치를 증명하지 않는다.
- 새 목록 필드가 명세에 없어 생성 모델 갱신·보완 interface 제거는 후속으로 남겼다. 이 인계 확인 당시 제품 commit/push/PR은 미승인이었으나 이후 사용자의 PR 요청으로 완료했다. 최신 승인·전달 상태는 맨 위 체크포인트를 따른다.

## 최종 홈 화면 검증

- **최종 키 누락 방어:** HEAD `50213ad`, Badge git hash `997784ff07360e58df162466048b32745760cd8d`. 양OS 실제 홈에서 주문 객체의 isDelayed 키 삭제 → 두 라벨 숨김·2026/11/10 날짜 유지·화면 오류/크래시 없음. `/tmp/dl-17262-missing-key/report.json`에 결과/복원 증거. 캐시·로그인 유지, Lab 양쪽8082 및 Office 양쪽8081/Home 전면 복구 완료.
- 아래 네 조건은 boolean 값이 있을 때의 선행 검증이며 최종 guard가 해당 동작을 바꾸지 않아 재사용했다.
- 동일 worktree/Development/Metro 8094의 최종 파일 해시 `f64e9b1396d1c0341e12bf085df74465fae3be8f`(API 선행 조건 주석 포함)로 두 플랫폼을 확인했다.
- 기존 날짜 계산과 반대인 API true는 지연, API false는 정상으로 표시됐다. COMPLETED+true와 remake+true도 지연을 유지했다. 네 사례 모두 화면 날짜 `2026/11/10`을 유지했다. 권한·다른 화면·전체 주문 흐름은 변경과 무관하여 반복하지 않았다.
- 원본 홈 캐시·저장 로그인 유지, fixture 제거, 두 Lab 앱 원래 8082 연결과 두 기기 Office 전면 복원을 확인했다. 기존 Metro·저장소 변경은 보존했다. native rebuild/reinstall 없음.
- 초기 Android 네트워크 오류는 같은 소스 재시작 후 해소됐다. 중간 source/전면의 예기치 않은 전환은 원인 미확인이며 최종 8094 재연결 후 검증했다. 디버거 도우미의 날짜 lookup 오류는 도우미에서 제거했고 제품 렌더 오류로 분류하지 않는다. 실서버 배포·기기 OTA 수신 증거는 아니다.
- 임시 결과 `/tmp/dl-17262-runtime/paired-runtime-report.json`; 해당 폴더에 화면 증거가 있다. API 미배포 전제를 합성 메모리 데이터로 검증한 것이므로 실제 응답 확인은 아래 배포 조건으로 남는다.

## 제품별 표시 위치와 기존 판정

| 제품·기기 | 기존 라벨 위치 | 기존 판정 및 변경 |
| --- | --- | --- |
| 치과 웹 PC·모바일 | 주문목록 | 서버 `row.isDelayed`와 `officeEstimatedArrivalAt` 존재 조건; 기존 완료 날짜 전용·취소 미표시는 유지하며 후속 PR4837에서 치과 숨김 helper를 명시적으로 공통 적용 |
| 치과 웹 PC·모바일·앱 WebView | 주문상세 배송 일정 | 서버 `deliverySchedule.isDelayed`; Office이면서 true·COMPLETED/CANCELED 숨김을 PR4835로 처리했고 후속 PR4837에서 목록과 helper 공통화 |
| 치과앱 iOS·Android | 홈 Track Your Order·주문목록 | 서버 `item.isDelayed`; 위 Office 숨김 조건을 PR340으로 추가, Staging CodePush v343은 완료 |
| 기공소 웹 PC·모바일·앱 WebView | 주문상세 배송 일정 | 기존부터 서버 `deliverySchedule.isDelayed`; Office 숨김 조건 적용 안 함. 후속 키 누락 숨김은 웹 PR4837의 0b01b1427로 추가되어 LAB 웹 배포 필요 |
| 기공소앱 iOS·Android | 홈 Track Your Order | 일반은 `officeDeliveryRequestAt`, remake는 `officeRemakeDeliveryRequestAt`와 `estimatedArrivalAt`를 앱에서 비교하던 것을 서버 `item.isDelayed`로 변경 |

- 기공소앱 Orders 목록에는 이 라벨이 없고, 기공소 웹 홈·목록·보드에도 없다. 치과 웹 홈·보드에도 이 라벨은 없다. 보드의 빨간 달력/날짜나 통계는 이 라벨로 집계하지 않는다.
- 위 위치는 코드상 라벨 경로다. 치과 웹 목록의 실제 응답에 필요한 날짜가 항상 존재한다는 의미가 아니다. 웹 세션은 합성 검증에서 날짜 필드를 보충한 사실과 실제 노출 단정 오류를 사용자에게 정정했다. 실제 서버 응답을 확인한 결과로 확대하지 않는다.
- 기존 Lab 날짜 계산은 요청일이 도착 예정일보다 늦거나 같은 날이면 On Time, 그 외 Delayed였다. 변경 후에는 날짜 관계와 무관하게 서버 true/false를 따른다.
- Lab의 배송 가능 여부·NEW 제외·필수 날짜 존재 조건과 호출부의 CANCELED 제외는 기존 그대로다. COMPLETED+true는 기존처럼 Delayed 표시 대상이다. Office의 추가 terminal 숨김과 혼동하지 않는다.
- `isOfficeOrder`의 `"isDelayed" in item` 분기도 제거했다. 새 필드를 받은 Lab이 Office로 오인되어 잘못된 날짜를 읽고 숨겨지는 문제를 방지한다. 생성 모델은 직접 수정하지 않고 컴포넌트 내부 확장 interface만 사용한다.

## 배포 전에 필요한 위치와 검토

1. **목록 계약:** 대상 환경의 `POST /lab/orders/search?page=0&size=9`, 요청 `{orderStatusFilter:"ALL"}`, 응답 `data[].isDelayed` boolean을 사용한다. 최종 방어 처리로 미제공 시 라벨을 숨긴다. 사용자는 BE가 나중에 제공하는 상황을 허용했으며, 날짜 fallback은 추가하지 않는다. 정식 배포 전 실제 필드·판정 확인은 후속 조건으로 남긴다.
2. **상세 기준과 정합성:** `GET /lab/orders/{orderId}` 응답 `data.deliverySchedule.isDelayed`는 기공소 웹/앱 WebView의 기존 소비값이다. 같은 주문에서 목록과 상세가 같은 판정 기준을 사용하는지 확인한다. 후속 키 누락 숨김을 전달하려면 LAB 웹 배포가 필요하며 웹 세션이 담당한다. 앱 CodePush만으로 WebView 상세는 바뀌지 않는다.
3. **Swagger:** 백엔드 `OrderListLabDto.isDelayed` 반영 후 해당 환경의 swagger-typescript-api 명령으로 앱 `src/models/Api.ts`를 재생성하고 `OrderStatusBadgeLabOrder` 보완 interface를 제거한다. 현재 Swagger 미배포 상태여서 재생성하지 않았다. 코드 주석에도 API 위치·정합성·타입 후속 작업·날짜 fallback 없음이 남아 있다.
4. **프런트 전달:** Lab 앱 iOS·Android 양쪽에 전달한다. 실제 CodePush/스토어 경로와 타깃 바이너리 호환성은 배포가 별도 승인된 시점에 확인한다. 이번 JS 변경 자체에는 native 코드·버전·환경·배포 스크립트 수정이 없다.
5. **치과 전달 범위:** 네이티브 홈/목록은 Office 앱 배포, PC·모바일 상세와 앱 WebView는 Clinic 웹 배포가 각각 필요하다. 기존 Office PR340/Staging v343과 Clinic PR4835/웹 배포 사용자 완료 보고는 각 체크포인트에 보존한다. 현재 새 배포를 한 것으로 표현하지 않는다.

## 실행 환경·다음 시작점

- Lab 전용 Metro 8094, Development, 이 worktree에서 실행했다. main 기반 `yarn start`의 오래된 `--experimental-debugger` 옵션 때문에 `ENVFILE=env/.env.development yarn exec react-native start --port 8094`로 실행했다. 스크립트 자체는 수정하지 않았다.
- `yarn install --immutable` 완료, lock 변경 없음. 기본 worktree `.env`만 opaque 복사하여 ignored·내용 동일 확인, 값은 읽거나 출력하지 않았다. 추적 중인 `env/.env.development`는 덮어쓰지 않았다.
- 기존 Office 8081·Lab 알림센터 8082 서비스는 유지했다. 기기는 iOS/Android를 같은 Lab task/Development source로 함께 전환했고 테스트 후 Lab 원래 8082와 기존 Office 전면 상태로 복구했다. 다른 세션이 변경한 창·코드·로그인을 보존했다.
- 임시 검사 로그 `/tmp/dl-17262-typecheck.log`, `/tmp/dl-17262-metro.log`는 영구 증거 저장소가 아니다. 인증정보·환경 값·고객정보는 개인 기록이나 Git에 남기지 않는다.
- PR34와 최종 누락 방어·관련 검증·후속 정식 배포 조건을 보고하고 대기한다. 이후 사용자 요청 없이 merge·CodePush·추가 감시·다른 세션 전달을 하지 않는다. 개인 context의 승인된 기록 commit/push만 별도로 수행한다.
