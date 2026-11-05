# 기공소 지연 판정 API 통일 — DL-17262

## 현재 체크포인트 — 2026-11-05 PR34 완료, CodePush 미수행

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
