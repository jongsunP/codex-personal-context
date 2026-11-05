# 기공소 지연 판정 API 통일 — DL-17262

## 현재 체크포인트 — 2026-11-05 로컬 구현·관련 검증 완료, 전달 미수행

- 사용자 승인: 기공소가 서버 `isDelayed`를 치과처럼 제공한다고 전제하고 기존 날짜 비교를 제거한다. fallback은 두지 않는다. 치과의 완료·취소 숨김 정책을 기공소에 추가하지 않는다. 기존 라벨 위치·플랫폼별 판정과 실제 배포 전 필요한 API를 지금 보고하고 코드 주석에도 남긴다.
- [DL-17262](https://innovaid.atlassian.net/browse/DL-17262), 부모 [DL-17138](https://innovaid.atlassian.net/browse/DL-17138). Office/Web의 완료 작업과 다른 Lab 앱 하위 카드로 생성했다. Jira 상태는 생성 당시 해야 할 일이며 부모 댓글은 작성하지 않았다.
- 구현 위치: `/Users/parkjongsun/.codex/worktrees/lab-delayed-api/dentlink-lab-app`, `feat/DL-17262`, 시작 `origin/main@26623e0`. 도구로 생성한 별도 worktree이며 기존 `feature/DL-17060`의 알림센터 변경은 보존한다.
- 제품 diff는 `src/features/orderList/components/OrderStatusBadge.tsx` 한 파일, 미커밋이다. 새 Lab commit/push/PR/merge/CodePush는 미승인·미수행이다. 이전 Office 배포 승인을 Lab로 확대하지 않는다.
- 변경 파일 lint/Prettier/diff 검사 통과. 전체 TypeScript 진단은 수정 전후 모두 5개로 내용까지 동일하며 변경 파일 오류는 없다. 관련 기존 Jest 없음; 요청 없는 테스트 파일은 추가하지 않았다. 별도 코드 검토에서 조치할 결함을 발견하지 못했다.
- iOS/Android Development의 최종 소스 홈 4조건씩 검증과 원래 기기 연결 복구를 완료했다. 실서버가 새 목록 필드를 제공한다는 증거는 아직 없으며 사용자 확인 계약에 따른 query-cache fixture 검증과 구분한다.

## 최종 홈 화면 검증

- 동일 worktree/Development/Metro 8094의 최종 파일 해시 `f64e9b1396d1c0341e12bf085df74465fae3be8f`(API 선행 조건 주석 포함)로 두 플랫폼을 확인했다.
- 기존 날짜 계산과 반대인 API true는 지연, API false는 정상으로 표시됐다. COMPLETED+true와 remake+true도 지연을 유지했다. 네 사례 모두 화면 날짜 `2026/11/10`을 유지했다. 권한·다른 화면·전체 주문 흐름은 변경과 무관하여 반복하지 않았다.
- 원본 홈 캐시·저장 로그인 유지, fixture 제거, 두 Lab 앱 원래 8082 연결과 두 기기 Office 전면 복원을 확인했다. 기존 Metro·저장소 변경은 보존했다. native rebuild/reinstall 없음.
- 초기 Android 네트워크 오류는 같은 소스 재시작 후 해소됐다. 중간 source/전면의 예기치 않은 전환은 원인 미확인이며 최종 8094 재연결 후 검증했다. 디버거 도우미의 날짜 lookup 오류는 도우미에서 제거했고 제품 렌더 오류로 분류하지 않는다. 실서버 배포·기기 OTA 수신 증거는 아니다.
- 임시 결과 `/tmp/dl-17262-runtime/paired-runtime-report.json`; 해당 폴더에 화면 증거가 있다. API 미배포 전제를 합성 메모리 데이터로 검증한 것이므로 실제 응답 확인은 아래 배포 조건으로 남는다.

## 제품별 표시 위치와 기존 판정

| 제품·기기 | 기존 라벨 위치 | 기존 판정 및 변경 |
| --- | --- | --- |
| 치과 웹 PC·모바일 | 주문목록 | 서버 `row.isDelayed`; 기존 완료 날짜 전용·취소 미표시 분기로 지연 라벨이 이미 숨겨져 있어 추가 수정 없음 |
| 치과 웹 PC·모바일·앱 WebView | 주문상세 배송 일정 | 서버 `deliverySchedule.isDelayed`; Office이면서 true·COMPLETED/CANCELED인 경우 숨김을 추가한 웹 PR4835로 처리 |
| 치과앱 iOS·Android | 홈 Track Your Order·주문목록 | 서버 `item.isDelayed`; 위 Office 숨김 조건을 PR340으로 추가, Staging CodePush v343은 완료 |
| 기공소 웹 PC·모바일·앱 WebView | 주문상세 배송 일정 | 기존부터 서버 `deliverySchedule.isDelayed`; Office 숨김 조건 적용 안 함, 이번 추가 수정 없음 |
| 기공소앱 iOS·Android | 홈 Track Your Order | 일반은 `officeDeliveryRequestAt`, remake는 `officeRemakeDeliveryRequestAt`와 `estimatedArrivalAt`를 앱에서 비교하던 것을 서버 `item.isDelayed`로 변경 |

- 기공소앱 Orders 목록에는 이 라벨이 없고, 기공소 웹 홈·목록·보드에도 없다. 치과 웹 홈·보드에도 이 라벨은 없다. 보드의 빨간 달력/날짜나 통계는 이 라벨로 집계하지 않는다.
- 기존 Lab 날짜 계산은 요청일이 도착 예정일보다 늦거나 같은 날이면 On Time, 그 외 Delayed였다. 변경 후에는 날짜 관계와 무관하게 서버 true/false를 따른다.
- Lab의 배송 가능 여부·NEW 제외·필수 날짜 존재 조건과 호출부의 CANCELED 제외는 기존 그대로다. COMPLETED+true는 기존처럼 Delayed 표시 대상이다. Office의 추가 terminal 숨김과 혼동하지 않는다.
- `isOfficeOrder`의 `"isDelayed" in item` 분기도 제거했다. 새 필드를 받은 Lab이 Office로 오인되어 잘못된 날짜를 읽고 숨겨지는 문제를 방지한다. 생성 모델은 직접 수정하지 않고 컴포넌트 내부 확장 interface만 사용한다.

## 배포 전에 필요한 위치와 검토

1. **새로 필요한 목록 계약:** 대상 환경의 `POST /lab/orders/search?page=0&size=9`, 요청 `{orderStatusFilter:"ALL"}`, 응답 `data[].isDelayed`가 실제 boolean으로 제공돼야 한다. 필드 누락 시 현재 기존 falsy 분기상 On Time이므로 백엔드 제공 전에 앱을 배포하면 안 된다. 날짜 fallback을 추가해 이 조건을 숨기지 않는다.
2. **기존 상세 기준과 정합성:** `GET /lab/orders/{orderId}` 응답 `data.deliverySchedule.isDelayed`는 기공소 웹/앱 WebView의 기존 소비값이다. 같은 주문에서 목록과 상세가 같은 판정 기준을 사용하는지 확인한다. 상세 프런트는 이번 변경으로 새 배포가 필요하지 않다.
3. **Swagger:** 백엔드 `OrderListLabDto.isDelayed` 반영 후 해당 환경의 swagger-typescript-api 명령으로 앱 `src/models/Api.ts`를 재생성하고 `OrderStatusBadgeLabOrder` 보완 interface를 제거한다. 현재 Swagger 미배포 상태여서 재생성하지 않았다. 코드 주석에도 API 위치·정합성·타입 후속 작업·날짜 fallback 없음이 남아 있다.
4. **프런트 전달:** Lab 앱 iOS·Android 양쪽에 전달한다. 실제 CodePush/스토어 경로와 타깃 바이너리 호환성은 배포가 별도 승인된 시점에 확인한다. 이번 JS 변경 자체에는 native 코드·버전·환경·배포 스크립트 수정이 없다.
5. **치과 전달 범위:** 네이티브 홈/목록은 Office 앱 배포, PC·모바일 상세와 앱 WebView는 Clinic 웹 배포가 각각 필요하다. 기존 Office PR340/Staging v343과 Clinic PR4835/웹 배포 사용자 완료 보고는 각 체크포인트에 보존한다. 현재 새 배포를 한 것으로 표현하지 않는다.

## 실행 환경·다음 시작점

- Lab 전용 Metro 8094, Development, 이 worktree에서 실행했다. main 기반 `yarn start`의 오래된 `--experimental-debugger` 옵션 때문에 `ENVFILE=env/.env.development yarn exec react-native start --port 8094`로 실행했다. 스크립트 자체는 수정하지 않았다.
- `yarn install --immutable` 완료, lock 변경 없음. 기본 worktree `.env`만 opaque 복사하여 ignored·내용 동일 확인, 값은 읽거나 출력하지 않았다. 추적 중인 `env/.env.development`는 덮어쓰지 않았다.
- 기존 Office 8081·Lab 알림센터 8082 서비스는 유지했다. 기기는 iOS/Android를 같은 Lab task/Development source로 함께 전환했고 테스트 후 Lab 원래 8082와 기존 Office 전면 상태로 복구했다. 다른 세션이 변경한 창·코드·로그인을 보존했다.
- 임시 검사 로그 `/tmp/dl-17262-typecheck.log`, `/tmp/dl-17262-metro.log`는 영구 증거 저장소가 아니다. 인증정보·환경 값·고객정보는 개인 기록이나 Git에 남기지 않는다.
- 사용자에게 현황·변경·배포 선행 API를 보고한 뒤 새 전달 지시를 기다린다. 자동 commit/push/PR/배포·다른 세션 전달은 하지 않는다. 개인 context의 승인된 기록 commit/push만 별도로 수행한다.
