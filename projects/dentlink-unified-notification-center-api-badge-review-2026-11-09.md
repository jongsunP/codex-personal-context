# 통합알림센터 신규 API·앱 배지 검토 — 2026-11-09

> **최신 결정:** 18:30 KST 이후 사용자 회의 공유·[Jira44950](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=44950) 기준, 11.23 배포는 푸시 수·0 초기화·LinkTalk 포함을 유지하고 다른 소속도 포함한다. 신규 미읽음 숫자 payload는 추가하지 않는다. 이번 FE 후속은 푸시 클릭 읽음 연결이다. 아래 회의 전 미정·추천은 이 결정을 대체하지 않는다.

## 회의 결과와 남은 구현

| 항목 | 11.23 배포 기준 | 후속 개선 방향 |
| --- | --- | --- |
| 숫자 기준 | 새 푸시 수 유지. 앱 실행/복귀 때 기존0 초기화 유지 | 실제 미읽음 수 |
| LinkTalk | 현행 포함 유지 | 포함 우선, 불가능하면 현재 푸시 발송 건 범위 검토 |
| 소속 범위 | 다른 소속 포함. Jira에서는 신규 항목으로 명시 | 현재 소속 |
| 푸시 숫자 | 미읽음 숫자를 새로 넣지 않고 현행 유지 | 숫자 포함 |

사용자가 전달한 이번 구현 기준:

```json
{"data":{"deeplink":"dentlink://order/1409/7000012592","deliveryId":"5521"}}
```

- 이동은 `deeplink`, 읽음은 `deliveryId`다. FCM 문자열 ID를 검증해 기존 `PATCH /office/notifications/inbox/read/push` 또는 `/lab/notifications/inbox/read/push`에 `{ "deliveryId": 5521 }`로 보낸다. 기존 API의 클릭 기록 부수 동작은 보존하되 FE에서 별도 클릭 이력 API/분석 이벤트를 추가하지 않는다.
- Office `8887a90`, Lab `8d2f71b`의 서비스/DTO 선언은 준비됐지만 실제 클릭 흐름은 URL·제목만 전달하므로 읽음 호출까지 연결되지 않았다. 이 상태를 구현 완료로 기록하지 않는다. 읽기 전용 Git 확인은 clean·로컬 upstream0/0이며 이번 턴 제품 fetch/pull/수정은 없다.
- 다음에는 FCM·Notifee의 발송ID를 로그인 전 보관·중복 콜백 경로까지 보존한다. 동일 URL의 서로 다른 발송 건을 버리지 않고 같은 발송 건의 중복 요청을 제어한다. 읽음 실패가 정상 랜딩을 막지 않으며 성공 뒤 관련 인박스 데이터를 갱신한다. 실제 BE 발송 payload와 iOS/Android 검증은 구현 후 별도다.
- 배지 PATCH0→GET 전환, 인박스/채팅 합산, 읽음마다 차감, 신규 `unreadCount`·타임스탬프·실시간 동기화는 이번 범위가 아니다. ‘미포함’은 기존 native payload/SDK 설정을 지우라는 뜻이 아니다.
- **다른 소속 포함은 서버 적용 확인이 남는 신규 요구**다. FE 코드만으로 푸시 발송 대상·서버 집계 완료를 증명할 수 없다. 사용자 의도대로 불필요한 새 API 요구 없이 실제 계약·발송을 대조한다.
- 사용자가 직접 수정한 공유용 Notion 표(18:28 KST 수정) 및 Jira44950을 확인했다. 해당 외부 문서는 이번 턴 변경하지 않았으며, 회의 전 추천/대기 설명은 역사적 비교다. 제품 코드·PR·배포 변경 없음.

> **REST 구현 이력:** 이 문서의 조사 당시 미연결 상태는 [11/9 REST 연결 결과](dentlink-unified-notification-center-api-integration-2026-11-09.md)로 갱신됐다. 설정/목록/미읽음/선택·전체 읽음은 세 제품에 연결·push했다. 푸시 클릭 읽음 연결과 실발송 검증은 위 최신 기록을 따른다.

### 회의 결정과 기존 노션 비교 재검토

- 공유용·FE용 Notion을 다시 읽고 현재 선택에 구조적 모순은 발견하지 못했다. OS 숫자와 현재 인박스 숫자가 다름, 웹/인박스 읽음마다 차감하지 않음, 미읽음이 남아도 앱 실행/복귀 때0이 됨은 이번 선택에서 수용하는 동작이다. LinkTalk는 푸시 수 기준에 포함하므로 이번에 채팅 미읽음 GET을 합산할 필요가 없다.
- 현행 유지가 푸시 도착 순서·0 초기화와 신규 푸시 도착 경합 같은 기존 비동기 오차를 해결한 것은 아니다. 실제 미읽음과 즉시 일치한다는 보장은 하지 않는다. 읽음 요청 실패와 기존 배지0 초기화 역시 별개로 유지한다.
- `data.unreadCount` 미추가와 기존 네이티브 배지 전달 제거를 구분한다. [Apple 명세](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/PayloadKeyReference.html)를 재확인: `aps.badge` 생략 시 기존값 유지,0은 제거다. 따라서 새 JSON은 앱이 소비할 data의 예시이며 기존 발송 전체 payload를 이 예시만으로 교체해서는 안 된다. 실제 BE payload는 아직 관찰하지 않았다.
- 실제 남은 검증: 발송ID를 유지하는 푸시 읽음 연결, 동일 URL의 서로 다른 발송 건/중복 콜백 구분, 로그인 전 진입·계정 변경·실패, 다른 소속 포함의 서버 적용. LinkTalk처럼 인박스 기록이 없는 푸시의 deliveryId 제공 및 read/push 응답은 확인 전이며 채팅 읽음을 임의 대체하지 않는다. 새 정책 질문을 만들기보다 기존 계약·실제 payload/응답으로 먼저 확인한다.
- 공유용의 결정표는 최신이나 서두의 검토 단계·FE 추천과 FE용의 정책 대기 설명은 회의 전 상태로 남아 있다. 이번 요청은 비교 확인이므로 외부 문서는 변경하지 않았고, 확정 결정과 기존 비교자료를 구분해 보고한다. 코드/런타임 검증을 새로 수행한 것은 아니다.

## 상태와 범위

- [DL-16140 댓글44913](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=44913)의 BE 공지와 실제 DEV Swagger를 대조했다. Office/Lab 알림 수신 설정·인박스 API가 공개되어 있다. BE 공지상 **발송 처리는 개발 중이며 신규 알림 데이터가 아직 쌓이지 않는다**.
- 이번 기록은 공개 계약과 현재 FE 호출 구조를 확인한 결과다. **새 API의 제품 연결, 실사용 계정별 응답·저장 검증, 실제 FCM 발송→랜딩→읽음 E2E가 모두 완료됐다는 의미가 아니다.** 해당 작업·검증·커밋 상태는 기능 체크포인트의 최종 기록을 따른다.
- 알림센터 내 알림과 앱 푸시 클릭을 대상으로 한다. 이메일 CTA·앱 설치 여부에 따른 외부 링크 이동·SES는 별도 작업이다.
- REST 기반을 유지한다. 신규 알림 전용 SSE, 읽음 동기화용 silent/data FCM, 주기적 polling을 추가하지 않는다. 기존 사용자 노출 푸시와 채팅 SDK 처리는 유지한다.

## 공개 API 계약

Office는 아래 `/office`, Lab은 `/lab` 경로다. **7개 경로·8개 HTTP 작업**이며 두 서비스의 기본 구조는 같다.

| 기능 | API | 요청과 응답·범위 |
| --- | --- | --- |
| 설정 화면 구성+설정값 조회 | `GET /office/notifications/settings` | `data:{view:{employee,user},setting:{employee,user}}` |
| 설정 전체 저장 | `PUT /office/notifications/settings` | `{employee:{orderScope,categories},user:{categories}}`. 전체 교체이며 생략한 카테고리는 미설정, 즉 전부 수신으로 초기화 |
| 인박스 목록 | `GET /office/notifications/inbox` | `isUnreadOnly` 기본false, `page` 기본0, `size` 기본10. 최신순 id 내림차순 고정. 응답 `{data:[],page,size,totalElements}` |
| 현재 인박스 미읽음 수 | `GET /office/notifications/inbox/unread` | `data:number`. 현재 소속 직원 알림+개인 알림 |
| 다른 소속 미읽음 | `GET /office/notifications/inbox/employers/unread` | `data:[{employerId,employeeId,employerName,address1,address2,city,unreadCount}]`. 다른 재직 소속을 이름순 제공. **개인 알림 제외** |
| 선택 읽음 | `PATCH /office/notifications/inbox/read/partial` | `{unreadNotificationIds:number[]}`. 현재 인박스에 보이는 미읽음만 처리하며 범위 밖 ID는 변경하지 않음 |
| 전체 읽음 | `PATCH /office/notifications/inbox/read/all` | body 없음. 현재 소속 직원 알림+개인 알림 중 미읽음을 모두 처리 |
| 푸시 클릭 읽음·클릭 기록 | `PATCH /office/notifications/inbox/read/push` | **`{deliveryId:number}` 필수**. 연결된 알림을 읽음으로 변경하고 해당 사용자 푸시 발송 행에 클릭 기록. 직원이 아닌 유저 기준으로 검증하여 다른 소속 푸시도 처리 가능 |

- 인증은 Bearer이며 `Employer-Id`·`Employee-Id` 헤더가 문서화되어 있다. 다만 Swagger의 두 헤더에는 `required:true`가 없으므로 필수 여부를 임의로 확대하지 않는다.
- 목록의 `sort` 파라미터는 Pageable 공통 문서에 있으나 API 설명은 **id 내림차순 고정**이다. 정렬·도메인 필터 기능을 임의로 추가하지 않는다.
- 구 `/messages/notifications*` 조회·읽음·삭제 API는 deprecated로 표시된다. **새 인박스 삭제 경로는 없다.** 새 ID를 구 DELETE API에 보내도 된다고 가정하지 않는다. 최신 확정 UI에 삭제 요구가 남아 있을 때만 대체 계약을 확인한다.

### 설정값 연결 시 지켜야 할 사항

- `view.employee.orderScopes:[{code,displayName}]`: Office에 제공하며 Lab은 빈 목록. Office MEMBER는 서버가 담당 주문으로 고정한다. Lab의 저장 `orderScope`는 설명상 null이다.
- `view.employee/user.categories:[{domain,category,toggleChannel,channels}]`에서 `toggleChannel`은 상위 토글이 담당하는 채널이며, `channels`는 하위 체크박스 목록이다. 빈 배열이면 단독 토글이다. 과거 초안의 `defaultChannel`은 사용하지 않는다.
- 저장값은 `categories:[{category,enabled,channels:Record<string,boolean>}]`다. 상위 토글을 꺼도 하위 채널 값은 보존한다.
- PUT은 전체 교체이므로 **웹에서 숨기는 PUSH·다른 설정 영역·다른 카테고리의 최신 값을 보존한 전체 요청**이 필요하다. UI에 보이는 일부만 보내면 나머지 설정이 초기화될 수 있다.
- 현재 도메인 enum: `ORDERS/PAYMENTS/BENEFITS/USERS/CHAT/MANUFACTURING`.
- 현재 카테고리 enum: `LINKTALK/DENTLINK_SUPPORT/DESIGN_CONFIRMATION/ORDER_UPDATES/FEEDBACK/SHIPPING/MILLING_ORDER_UPDATES/PAYMENTS/CREDITS`. 과거 초안의 `CASE_PREFERENCE`는 없다. 실제 GET catalog·최신 정책을 먼저 대조하고 임의 코드값을 만들지 않는다.
- BE의 domain/category는 데이터 식별자다. 이미 합의한 FE 표시 계층 가공은 가능하되 서로 무관한 row를 합치거나 새 설정 항목을 추정하지 않는다.
- 양 앱의 구 `PermissionProvider`는 `push-preferences` 조회와 production 자동 upsert를 유지한다. 새 설정 연결 시 **OS 권한 변경이 서버 수신 설정을 임의로 초기화하지 않도록** 구 자동 초기화 경로와 함께 정리해야 한다. 현재 `__DEV__`에서만 자동 저장을 건너뛴다.

### 개인 알림과 다른 소속 count

- 사용자 설명: A 인박스=A 소속 알림+개인 알림, B 인박스=B 소속 알림+같은 개인 알림이다. 개인 알림은 어느 소속에서 읽더라도 같은 사용자 읽음 상태가 반영되어야 한다.
- 신규 Swagger는 현재 인박스 count에 개인 알림을 포함하고, 다른 소속 count에서는 제외한다고 명시한다. FE가 다른 소속 count에 개인 미읽음을 임의로 더하지 않는다.
- **개인 알림을 소속별로 중복 합산하면 안 된다.** 향후 앱 전체 숫자가 필요할 때도 개인 알림은 한 번만 계산해야 한다.
- 이 API 범위와 다른 소속 선택 화면의 노출 기준·홈 레드닷 등 최종 UX 정책은 구분한다. API 설명만으로 아직 미정인 모든 표시 정책이 확정됐다고 기록하지 않는다.

### 랜딩과 푸시 식별자

- `InboxNotificationDto`는 `{id,domain,category,title,content,landingUrl,isRead,sentAt}`이다. 시스템 알림의 category는 null이다. 목록에 웹/앱 별도 URL, 소속 ID, deliveryId, 아이콘 필드는 없다.
- `landingUrl` 하나가 웹/앱별로 선택되는지에 대한 client/platform 파라미터·헤더는 Swagger에 없다. 앱의 `service-type`은 OFFICE/LAB 구분이고 웹/앱 플랫폼 구분이 아니다. **시트의 Web/App 랜딩을 응답에 어떤 방식으로 반영하는지** 실제 응답 또는 BE 설명을 확인해야 한다.
- 앱 내 클릭·푸시 클릭의 **최종 앱 목적지**가 같다면 공통 딥링크 하나를 재사용할 수 있다. 그러나 푸시의 발송 식별자·유입 정보는 화면 주소와 별도이며, 같은 URL만으로 서로 다른 발송 건을 식별할 수는 없다.
- 이번 공개 계약에서는 푸시 읽음에 notificationId 대신 **deliveryId**를 사용한다. FCM payload의 정확한 위치·형식과 로그인 전 보관 경로에서 보존할 방법은 실제 발송 계약을 확인해 연결한다. 이동 URL 중복 억제와 발송 건별 읽음 처리를 혼동하지 않는다.
- 기존 앱 pushType는 구 설정 API와 FE enum 상수를 함께 사용한다. Amplitude `pushType` 분류는 별도다. 새 domain/category 전환을 이유로 분석 이벤트 명칭까지 자동 변경하지 않는다.

## 앱 OS 배지 API의 현재 동작

| 항목 | 확인 결과 |
| --- | --- |
| API | `PATCH /app/users/own/devices/badge-count` |
| 인증·요청 | Bearer, **필수 `Device-Token` 헤더**, body `{badgeCount:number}`. 정수·최소0 |
| 현재 FE가 보내는 값 | 항상0 |
| 호출 시점 | 로그인/FCM 토큰 준비 후 최초1회, 앱 foreground 복귀 |
| 성공 후 | `notifee.setBadgeCount(0)` |
| 실패 시 | 네트워크·HTTP 오류 등 요청이 reject되면 성공 콜백의 로컬0 처리도 하지 않음. 현재 서비스는 응답 본문의 업무 오류 code를 별도 검사하지 않으므로 모든 BE 업무 실패에 대한 보장으로 확대하지 않음. mutation 자동 재시도 설정 없음. 최초 처리 플래그는 이미 true라 다음 복귀 등의 호출까지 남을 수 있음 |
| 의미 | 기기별 푸시 배지 초기화. **인박스 읽음 API나 인박스 미읽음 수와 연동되지 않음** |

- Office `RootNavigator.tsx:114,349,490,502`, Lab `RootNavigator.tsx:158,409,652,664`에서 같은 흐름을 확인했다. 양 앱 `AppService.updateBadgeCount`는 숫자와 Device-Token을 서버에 전달한다.
- 현재 구조는 **앱을 열면 기기 배지를 지우는 방식**이다. 알림센터 안 읽은 알림이0이라는 의미가 아니며, 푸시를 읽었다는 서버 기록도 아니다.
- Swagger로 확인되는 것은 Device-Token 대상 갱신까지다. 서버 내부 증가 방식, 전체 소속/개인/채팅 포함 범위, 발송 payload에 적용하는 방법, 읽음 시 자동 갱신은 문서에 없다.

### iOS와 Android 차이

- **iOS:** Notifee `setBadgeCount`로 아이콘 숫자를 설정할 수 있다. 설치된 라이브러리는0을 내부적으로−1로 변환하여 **OS 알림 목록을 지우지 않고 아이콘 배지만 제거**한다(`NotifeeCore.m:737–742`).
- **Android:** 설치된 Notifee `setBadgeCount`는 아무 작업 없이 resolve한다(`NotifeeApiModule.ts:728–730`). Android의 알림 점·숫자는 활성 알림과 런처 지원에 따른다. 동일 함수 호출로 iOS와 같은 숫자 제어가 된다고 보장할 수 없다.
- foreground 로컬 알림을 만드는 현재 `notifee.ts`는 `ios.badgeCount`·Android 숫자를 넘기지 않는다. `foregroundPresentationOptions.badge:true`는 표시 허용이며 숫자가 아니다.
- iOS 원격 푸시에 badge 숫자가 있으면 기존 아이콘 값을 덮어쓸 수 있다. FE가 초기화한 숫자와 BE의 다음 발송 숫자 기준이 다르면 다시 불일치할 수 있다.
- 참고: [Notifee setBadgeCount](https://notifee.app/react-native/reference/setbadgecount/), [Notifee iOS 배지](https://notifee.app/react-native/docs/ios/badges/), [Android 배지](https://developer.android.com/develop/ui/views/notifications/badges).

### 채팅 경계와 남은 정책

- ChannelTalk은 SDK unread/배지 콜백·제어 푸시를 별도로 사용한다. LinkTalk 앱 내부 미읽음도 `CHAT_UNREAD_COUNT`·`LATEST_CHAT`로 별도 갱신한다. 이 값을 알림센터 count와 같은 값으로 취급하지 않는다.
- 앱 아이콘 배지는 하나이므로 인박스 count로 덮어쓰려면 **개인+모든 소속의 알림인지, 현재 소속만인지, 채팅도 포함하는지** 기준이 필요하다. 기존 ‘앱 열면0’을 유지한다면 그 자체로 새 집계 API가 필요한 것은 아니다.
- 인박스 미읽음과 일치시키기로 한다면 무조건0 초기화를 바꾸고 읽음 성공·앱 복귀 등의 정상 REST 갱신 시점에 맞춘다. 현재 인박스 count를 전체 배지로 바로 사용하면 다른 소속 알림이 빠진다.
- 다른 기기·웹에서 읽은 결과가 닫힌 앱의 배지에 즉시 반영되는 것은 현재 REST만으로 보장하지 않는다. 신규 동기화 기능은 추가하지 않고 다음 앱 복귀/조회/일반 푸시 때 갱신하는 범위를 유지한다.
- 기존 코드의 잠재 경합: foreground에서 초기화 요청→응답 전 background→새 푸시 도착→늦은 성공 콜백이 무조건0을 설정하면 새 배지를 지울 수 있다. 계정·토큰·현재 앱 상태 확인이 필요한 코드상 가능성이며, 이번 조사에서 실기로 재현한 장애는 아니다.
- 인박스 읽음, OS 아이콘 숫자, OS 알림 목록은 각각 다른 상태다. 어느 하나의 성공을 다른 상태의 성공으로 표시하지 않는다.

### BE에 필요한 최소 확인 — 기존 구현으로 해소되면 새 API 요구 없음

1. 현재 badge-count에 저장·발송하는 숫자는 무엇의 합계인가? 기기별 수신 건수인지, 사용자 미읽음인지와 소속/개인/채팅 포함 범위를 확인한다.
2. 신규 인박스 선택·전체 읽음 및 `read/push` 성공 시 **서버의 기기 배지 값도 갱신되는가**, 아니면 FE가 기존 badge-count를 별도 호출해야 하는가?
3. 다음 일반 푸시에 내려주는 배지 숫자는 어떤 필드·계산 기준인가? 특히 iOS APNs badge와 Android 숫자/표시 방식, 앱에서 초기화·읽음 처리한 이후의 값이 같은 기준을 쓰는지 확인한다.

위는 앱 배지 정책을 실제 연결할 때 필요한 확인이다. 알림센터 조회·설정 등 독립적으로 진행 가능한 작업 전체를 막거나 새로운 서버 기능이 필수라고 확대하지 않는다.

## 근거 보관

- 조회 원문: `https://dev-api.dentlink.io/v3/api-docs/swagger-config`, Office/Lab/App 그룹.
- 임시 원문 스냅샷: `/tmp/notification-swagger-{office,lab,app}-1109.json`.
- 알림 API 7 paths/19 schemas 추출: `/tmp/notification-contract-{office,lab}-1109.json`.
- 코드: 양 앱 `src/navigations/RootNavigator.tsx`, `src/services/app.service.ts`, `src/queries/useAppQueries.ts`, `src/configs/utils/notifee.ts`, `src/configs/utils/fcmHandler.ts`, `src/libs/useChannelTalk.ts`; 웹 `shared/models/src/messages/messages.apis.{clinic,lab}.ts`.
- 임시 파일의 장기 보존은 보장하지 않는다. 본문 계약·한계와 최종 작업 상태를 개인 정본에 함께 보존한다.

## 실제 로그인 GET 확인과 시트 대조

- 11/9 Office·Lab 기존 DEV OWNER 계정의 각 설정/인박스(size1)/미읽음/다른 소속 미읽음 **GET4개 모두200/code0000**. 인박스 totalElements0·각 미읽음0이었다. 설정 PUT/읽음 PATCH는 빈 발송 데이터에 임의 실행하지 않았다. `/tmp/notification-{office,lab}-actual-get-1109.json`에 비밀정보 없이 응답 구조/카운트 증거를 보관했다.
- Office 실제 catalog는 employee `LINKTALK/DESIGN_CONFIRMATION/ORDER_UPDATES/FEEDBACK/SHIPPING/PAYMENTS/CREDITS`, user `CREDITS`다. 해당 OWNER는 `MY_ORDERS_ONLY` 설정과 전체/담당 scope 선택 목록을 받았다.
- Lab 실제 catalog는 employee `LINKTALK/DENTLINK_SUPPORT/DESIGN_CONFIRMATION/ORDER_UPDATES/MILLING_ORDER_UPDATES`이며 `orderScope:null`, user categories와 orderScopes는 빈 배열이었다. 실제 다른 권한/개인 설정 저장까지 검증한 것이 아니다.
- [알림 현황표](https://docs.google.com/spreadsheets/d/1w1xwwEWRE0KgiJsOvldxIFbtNgWguohurf5kemIrW_g/edit?gid=614410508) `전체 알림(PM)` A1:P189, O=Web/P=App 랜딩을 확인했다. 앱 목적지 컬럼 하나를 채널별 행에서 재사용할 수 있으나 채널별 목적지가 다른 행은 보존한다.
- 실행 문자열로 정리할 때 남는 항목: Lab 행의 Office scheme, 배송 경로의 employerId 위치, ‘알림센터/인박스 오픈’·‘액션 없음’ 문구, `/dentlinksupport`와 기존 `contact/:employerId`, 밀링 relative path의 선행 slash/실제 ID 의미. 빈 셀이나 변수 이름 차이를 모두 PM의 미정 정책으로 확대하지 않는다. 대상 서버/앱·기존 파서로 FE에서 정리 가능한 것과 실제로 목적지가 달라지는 사항을 구분한다.
- 단일 주문 ID 경로 오인은 양 앱 파서에서 수정했다. 고정 경로 수가 많은 매칭을 먼저 보고 같은 경우 완성된 경로를 우선하며, 기존 부분 경로 fallback은 유지한다. Office30/Lab6테스트와 양 앱 실제 주문 상세 랜딩 검증을 거쳤다. 시트의 모든 문자·채널·실제 푸시 payload가 검증 완료라는 뜻은 아니다.
- BE의 pushType 질문: 기존 앱은 구 push-preferences API와 FE enum/필수타입 상수를 함께 사용한다. 서버 코드값을 바꾸면 설치된 구 버전과의 호환도 필요하다. FCM URL에서 추출하는 Amplitude pushType은 별도이므로 새 domain/category로 자동 변경하지 않는다.

## 적용 순서

1. 새 타입 생성/내보내기와 실제 GET 계약에 맞춰 service/query를 연결하고, 권한별 설정·목록·읽음의 mock을 단계적으로 대체한다.
2. 설정 PUT 전체교체에서 숨긴 PUSH/다른 영역의 값을 잃지 않게 하고, 구 production 자동 push-preferences 저장 경로를 함께 정리한다.
3. Web/App landingUrl 선택 계약, deliveryId payload 위치/형식과 deferred 보존을 확인하고 실제 푸시 데이터로 검증한다.
4. OS 배지를 기존 ‘열면0’로 유지할지 또는 미읽음 기준으로 바꿀지는 정책/서버계약 확인 뒤 적용한다. 이번 조사에서는 배지 코드를 변경하지 않았다.

## OS 배지 안건3 최종 논의와 Notion 공유 — 2026-11-09

### 공유 위치와 상태

- [대문 · 통합알림센터 OS 앱 아이콘 숫자 검토](https://app.notion.com/p/413ce072e82f814eaf0ed235193ffe5f)
- [01 · PM·BE 공유용](https://app.notion.com/p/413ce072e82f81968f43c0563590b495): 어려운 구현 용어를 줄이고 비교·예시·선택의 결과·필요한 결정을 표로 정리했다.
- [02 · 개발 참고용](https://app.notion.com/p/413ce072e82f814b917ec5868f047420): 실제 코드/API·작동 원리·payload 예시·정합성·네이티브 한계·역할·후속 검증·공식 출처를 보관했다.
- 기존 `Development Documents`에 대문, 그 아래 두 페이지 구조다. 다른 문서를 이동하거나 수정하지 않았다. 저장된 3페이지의 본문·계층·누락 여부를 확인했고 도구의 표현 치환 경고는 정확한 본문 재조회 후 수정해 해소했다.
- 사용자 요청은 공유 자료 작성이다. **배지 개선 정책 확정이나 구현 지시가 아니다.** 제품 코드·서버·디바이스·Slack/Jira/Sheet·PR/배포 변경 없음.

### 논의의 결론과 미정 사항

1. **기존 방식의 이유:** 현재 PATCH0는 ‘새 푸시가 왔음을 표시하고 앱 방문 시 지움’ 목적에 타당하다. 틀리거나 시대에 뒤진 구현으로 단정하지 않는다. 실제 미읽음이 남아 있어도 지울 수 있다는 제품 의미 차이가 핵심이다.
2. **제안:** 통합알림센터의 실제 미읽음 수를 표시하려면 BE 읽음 상태를 정본으로 삼고 앱 실행/복귀·읽음 성공 등의 GET 재조회로 지원 OS 배지를 갱신하는 편이 맞는다. HTTP 메서드 이름을 PUT/PATCH→GET으로 단순 교체하는 것이 아니다. 읽음 변경 요청은 계속 필요하다.
3. **서버 오류와 표시 지연 분리:** 웹→인박스→푸시가 같은 알림을 여러 번 읽어도 서버 unread→read는 한 번만 반영해야 한다. 원자적·반복 안전 처리로 해결할 문제이지 감수할 오차가 아니다. 이미 읽은 알림의 푸시 클릭 이력은 별도로 남길 수 있다. 앱의 -1 명령으로 합계를 관리하지 않는다.
4. **푸시 숫자 포함 선택:** 발송 시점의 절대 unread를 iOS `aps.badge`에 넣으면 앱이 닫혀 있어도 갱신 가능하다. FCM 순서1→3→2 또는 GET 뒤 오래된 푸시가 도착하면 다시 오래된 표시가 될 수 있고 다음 조회에서 보정한다. ‘앱 한번 열면 이후 항상 정확’이라고 약속하지 않는다.
5. **푸시 숫자 제외 선택:** 해당 새 푸시의 badge 덮어쓰기를 막는 대신 새 알림의 숫자 증가도 표시하지 못한다. 이전값/0이 다음 앱 조회까지 남는다. 푸시 자체는 계속 보낼 수 있다. 이미 발송된 큐나 다른 SDK의 배지 writer까지 없어진다는 뜻은 아니다.
6. **동기화 한계:** 웹에서 읽은 뒤 앱을 닫아두면 다음 앱 조회 또는 최신 숫자를 담은 일반 푸시까지 차이가 남는다. 새 푸시가 없다면 앱 조회까지 기다린다. 열려 있는 앱도 조회 계기가 없으면 즉시 동기화되지 않는다. 신규 realtime/silent/data sync/polling은 여전히 제외한다.
7. **OS 차이:** iOS 숫자는 앱 setter/aps.badge로 제어한다. Android Notifee setBadgeCount는 no-op이며 활성 알림·제조사/런처 정책을 따른다. 모든 Android에서 정확한 인박스 숫자 표시를 약속하지 않는다. 앱 내부 unread는 공통 서버 기준으로 제공 가능하다.
8. **OS 알림과 읽음:** 발송 회수와 기기 내 표시 알림 제거는 다르다. 앱이 실행될 때 OS 알림 ID를 식별해 해당 표시 알림을 제거하는 기능은 가능하다. 서버 읽음·아이콘 배지·알림 목록은 독립 상태이며, 알림을 닫았다고 읽음으로 추정하지 않는다. 배지는 수신/클릭의 증거도 아니다.
9. **timestamp·version:** 필드를 보내는 것만으로 OS가 최신값을 비교하지 않는다. 비교 코드가 실행되는 경로에서는 도움이 되며 고도화 시 발송 시각보다 서버 상태 버전이 적절하다. GET/푸시의 동일 범위·계정·버전 및 shared state가 필요하다. 오래된 배지값 무시와 알림 내용 폐기는 다르다.
10. **네이티브/실시간 고도화:** iOS NSE는 조건·시간 제한·원본 fallback·동시 처리 문제가 있다. 원본 badge 생략 후 extension에서만 설정하면 오래된 fallback 대신 갱신 누락 가능성이 남는다. Android도 직접 처리/자동 표시 경로·실행 제한·런처 문제를 구분한다. WebSocket만으로 종료 앱을 해결하지 못한다. 추가 설계/빌드/검증 범위이며 현 최소안에 자동 포함하지 않는다.
11. **남은 결정:** 푸시 수 유지/실제 unread 전환, 현재/전체소속·개인·채팅 포함 범위, 푸시 숫자 포함/제외, Android 표시 한계 수용. 개인 알림은 소속별로 반복 합산하지 않는다. 사용자는 비교를 이해한 상태이고 아직 최종 정책을 선택하지 않았다.

### 최소 개발 고려와 현재 확인

- 현재 Office `feature/DL-17059@bc2f5a9e3676461c93be90094abf2e834e353c77`, Lab `feature/DL-17060@8d2f71bef4e03c66e58727b2bb6338d3bd2806ad`를 읽기 전용 재확인했고 clean이다. 기존 `readPush/markPushRead`는 선언뿐 실제 호출이 없다. 새 GET→OS 배지 연결도 없다. 기능 브랜치 코드 확인이며 운영 검증이 아니다.
- `PATCH badge-count` 서비스는 HTTP 성공과 응답 본문 업무 성공을 별도 검사하지 않는다. 네트워크/HTTP reject 시0 setter 미실행이라고 좁혀 기록하며, 이번 문서 작업에서 새로 코드 수정하지 않는다.
- 기존 현재 unread+다른 소속 group 합계를 쓰는 후보가 있으므로 신규 GET API를 먼저 요구하지 않는다. 두 요청의 snapshot 차이·소속/권한·누락·실패 처리와 목표 집계 범위를 확인하고 부족할 때만 응답 확장/집계 API를 검토한다.
- 기존 PATCH0·BE의 다음 푸시 카운터·구버전 앱이 충돌하지 않게 전환해야 한다. ChannelTalk 제어 푸시/배지 경로도 확인한다. SDK/APNs 내부가 OS 숫자를 어떻게 쓰는지까지 검증한 것은 아니다.
- 계정/소속/Device-Token 전환·늦은 응답·foreground/background 전환·GET 실패/역순을 보호한다. 실패를0으로 처리하지 않는다. 읽음 성공과 랜딩 성공을 혼동하지 않는다.
- 정책 선택 후 기존 API 재사용 가능 여부→FE/BE 전환→실제 푸시 검증 순서다. 검증 계획은 새 문서에 있으며 이번 턴에 runtime 테스트를 수행한 것이 아니다.

### 공식 근거와 주장 한계

- [FCM 전달 순서](https://firebase.google.com/docs/cloud-messaging/customize-messages/collapsible-message-types): 순서 미보장. collapse는 대기 메시지 대체이며 모든 순서를 해결하지 않는다.
- [Apple payload](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/PayloadKeyReference.html): aps.badge 절대값·0 제거·생략 유지. 사용자 timestamp는 OS 비교 표준키가 아니다.
- [Notifee iOS badges](https://notifee.app/react-native/docs/ios/badges/), [Android badges](https://developer.android.com/develop/ui/views/notifications/badges): 기기 표시의 주체·플랫폼 한계.
- [OneSignal](https://documentation.onesignal.com/docs/en/badges): iOS SDK 기본 앱 진입 배지·알림 제거. 현재 ‘방문하면 지움’ 정책의 사례이지 Dentlink 알림 목록 제거를 입증하지 않는다.
- [Sendbird](https://docs.sendbird.com/docs/chat/sdk/v4/ios/push-notifications/configuring-preferences/register-push-notification-credentials), [Stream](https://getstream.io/chat/docs/php/push-template/): 전체 unread를 push badge에 사용. 내부 역순 보정 방법이나 역순을 허용한다는 정책은 미확인이다.
- [Slack realtime](https://slack.engineering/real-time-messaging/)은 2023 WebSocket 자료. [네이티브 알림](https://slack.engineering/into-the-clouds/)은 2017/2020 자료로 현재 알고리즘 전체가 아니다. [모바일 지연](https://slack.com/resources/using-slack/customize-your-notifications-in-slack)과 [badge 불일치 문제 안내](https://slack.com/help/articles/360001559367-Troubleshoot-Slack-notifications/)를 함께 확인했다.
- [Apple NSE](https://developer.apple.com/documentation/UserNotifications/UNNotificationServiceExtension), [수신 알림 수정](https://developer.apple.com/documentation/usernotifications/modifying-content-in-newly-delivered-notifications), [background update](https://developer.apple.com/documentation/usernotifications/pushing-background-updates-to-your-app): 실행 조건·시간/전달 제한이 있어100% 보장으로 제시하지 않는다.
- 카카오톡의 정확한 배지 내부 구현은 미확인이다. ‘업계에서 가장 많이 쓴다’, ‘유명 서비스는 완전히 해결’, ‘Sendbird/Stream도 모두 역순을 그냥 감수’라고 단정하지 않는다.

### 후속 — 공유용 간결화와 인박스 없는 LinkTalk 푸시

- 사용자 피드백: 공유용이 너무 길고 FE 설명서 같으므로 긴 질문형 제목·OS 원리·timestamp 구현 설명을 줄인다. 같은 공유용 페이지를4절(방식 비교/선택과 고려사항/참고 사례/결정할 것)·약2,278자로 축약했다. 개발용은 상세를 유지하고 새 우려만 추가했다. 이 편집은 정책 변경이 아니다.
- [시트 전체 알림(PM) A167:P172](https://docs.google.com/spreadsheets/d/1w1xwwEWRE0KgiJsOvldxIFbtNgWguohurf5kemIrW_g/edit?gid=614410508&range=A167:P172) 읽기 전용 확인:169·170행 `LINKTALK_NEW_MESSAGE_BY_ORDER_OFFICE/LAB` 채널 PUSH,172행 `LINKTALK_NEW_MESSAGE_BY_DENTLINK` PUSH이며 발송 조건에 ‘링크톡 기존 정책과 동일하게 Notification 미발송’ 명시. 시트 수정 없음.
- 인박스 미읽음과 푸시 건수는 일치하지 않는다. 인박스만 집계하면 LinkTalk 새 메시지 푸시가 도착해도 인박스0이면 iOS 배지0/없음일 수 있다. OS 알림창에 실제 푸시가 없다는 뜻은 아니다. Android는 활성 알림·런처에 따라 점/숫자가 보일 수 있어 양 OS 모두0으로 단정하지 않는다.
- LinkTalk라는 이유로 항상 badge0을 보내면 기존 다른 인박스 미읽음5까지 지워지는 오류다. 배지 필드를 생략해 기기 기존값을 유지하거나, 선택한 집계의 실제 최신 합계5를 보낸다. 생략은 최신값 보정이 아니므로 웹 읽음 후5가 남을 수도 있다. 실제 합계0이 확인된 경우와 푸시 종류만으로0을 결정하는 경우를 구분한다.
- 코드 read-only 확인: Office `src/services/linktalk.service.ts:232–264`, Lab 같은 파일189–214. 별도 `GET /office|lab/chats/unread-count`, `POST /office|lab/chats/read/{chatId}?lastReadMessageId=…` 사용. 하단 LinkTalk 미읽음과 OS 배지는 별도이고 ChannelTalk 고객지원 SDK와도 다르다.
- 채팅까지 배지에 포함한다면 메시지/채팅방 단위, 담당 주문 필터·`chatType`/`myOrdersOnly`, 현재/전체 소속 범위를 맞춰야 한다. 기존 탭 숫자를 단순 합산하지 않는다. 채팅 포함 정책·새 API 필요성을 이번 문서 작성으로 확정하지 않는다.
- 인박스 기록 없는 PUSH의 `/inbox/read/push`가 클릭 기록만 처리하는지 등은 BE 계약 확인 대상이다. 채팅 읽음·인박스 읽음을 자동 동일시하지 않는다. 개발용에 인박스0/5에서 LinkTalk 푸시 및 인박스 없는 푸시 클릭의 후속 검증 계획을 추가했다. 실제 구현/런타임 QA를 한 것은 아니다.


### 후속 — 회의 전 공유용/FE용 재정리와 Jira 정합성

- 사용자 최신 요청: 공유용부터 다시 정리하고 개발용도 복잡한 심화문서가 아닌 FE 참고용으로 줄인다. Notion/Jira 정리 후 지금 독립적으로 가능한 개발이 있는지 확인하고, 없다면 사용자가 미정 안건을 회의한다. 이번에는 제품 구현 허가로 확대하지 않는다.
- 누락 정정: LinkTalk 포함 여부를 ‘주의사항’ 수준에만 넣었던 것을 바로잡아 **별도 결정 행**으로 표시했다. 결정4개는 숫자의 의미(현재 푸시 수/실제 미읽음), LinkTalk 포함, 현재/전체 소속·개인1회, 푸시 숫자 포함이다. 현재 값은 모두 미확정이다.
- PM용 같은 페이지를 약2,178자로 전면 정리: 현재/변경 비교 → 독립 결정4개와 푸시 포함/제외 결과 → 중복 읽음·지연·LinkTalk·기기 차이·고도화 비용 → OneSignal/Sendbird/Stream/Slack 짧은 공식 사례. OS별 긴 설명이나 네이티브 상세는 제외했다. ‘푸시 숫자 제외’라도 앱 GET 미읽음 표시는 가능하며 PATCH0 현행 유지와 다르다는 점을 명확히 썼다.
- FE용 같은 페이지는 약5.4천자로 축약: 현재 PATCH0 코드, 연결 완료/미완료, 기존 GET/읽음 API, deliveryId 흐름, 정책별 작업과 검증만 정리했다. 44941 기본 payload는 그대로 유효하며 선택적 `data.unreadCount:"3"`와 FCM `apns.payload.aps.badge:3`를 구분했다. 숫자 필드 추가는 제안이지 BE 확정 계약이 아니다. 실제 값은 빈 문자열이 아니며 data만으로 iOS OS 자동 배지가 설정되지 않는다.
- PM의 기존 클릭 기준도 보존: 푸시 클릭 시 읽음, 삭제/권한 등의 랜딩 실패도 읽음 대상. 읽음 요청 실패를 성공으로 기록하지 않으며 정상 랜딩을 막지 않는 흐름. LinkTalk 채팅 읽음은 기존 별도 API이고 인박스 없는 푸시의 read/push 동작은 계약 확인 전이다.
- 대문에는 숫자기준/LinkTalk/소속/푸시숫자4개 결정 대기를 명시했다. 페이지 이동·삭제나 추가 대문 없이 기존 공유 링크를 유지했다. Notion 각 replace/update 성공 응답을 확인했고 자식 페이지는 보존했다.
- Jira live: DL-16140 44945(Frankie 11/9 16:49:41 KST)는 현재 PM 문서 링크,44941은 deliveryId 요청이며 최신5댓글 내 추가 BE 답변 없음.44940은 PM 시트 반영/권한 완료 답변. 기존 상위 댓글을 재작성하거나 중복 게시하지 않았다.
- DL-17057 설명/최신댓글과 Frankie 담당을 확인한 뒤 진행 댓글44948 추가. 확정 REST/랜딩 완료, 실제푸시 읽음/payload·배지4개정책·실데이터 QA 남음을 기록했다. 카드 상태는 진행 중을 유지했다. 다른 작업 카드의 상태를 임의 완료하지 않았다.
- 제품 읽기 전용 점검 결과: Web8b9cd986cf58ef4deb64b72d20b0d0b37527b8b4, Officebc2f5a9e3676461c93be90094abf2e834e353c77, Lab8d2f71bef4e03c66e58727b2bb6338d3bd2806ad clean/local upstream0·0. 이 문서 정리에서 원격 재fetch나 새 코드/테스트/런타임 실행은 하지 않았다. 현재 확정 계약에서 필수로 추가할 독립 FE 구현은 발견하지 못했다. 실제 FCM readPush 연결·실데이터 검증까지 완료된 것은 아니다.
- 다음: 회의 결과와 실제 payload를 받고 기존 API 재사용 검토 → 승인된 연결 → 양 제품×iOS/Android 실제 푸시 검증. 기존 USER:CREDITS 위치/MAIL catalog 등 잔여 기획·계약과 기존 원인 미확정 crash 기록은 이 정리로 해소하지 않는다. 배지 정책이나 실시간 동기화 범위를 임의 확정하지 않고 대기한다.


### 최종 문구 보완과 회의 결과 대기

- 사용자가 ‘인박스 읽음과 별개입니다’를 이해하기 어렵다고 지적했다. 공유용 페이지의 현재 방식 셀을 ‘알림을 하나씩 읽을 때마다1씩 줄이지 않습니다’로, 앱 진입 셀을 ‘앱을 열거나 복귀하면0으로 초기화합니다’로 바꿨다. 표 아래에 푸시1→2→3 증가/앱 진입0의 예시와 미읽음이 남아도0이 될 수 있다는 설명을 추가했다. 사용자 수정한 표 폭/구조 등 나머지 내용은 유지했다. Notion update 성공 확인.
- 사용자 최종 이해: 현재는 증가하다 앱 실행/복귀 때0으로 초기화하며 개별 읽음마다 -1/-2 차감하는 구조가 아니다. 설명 수정이지 배지 정책을 기존안으로 최종 선택한 것이 아니다. BE 서버 내부 카운터 구현을 직접 확인한 것으로 확대하지 않는다.
- 마감: 노션 두 문서와 대문, Jira44948 기록은 정리됐다. 마지막 문구 개선으로 Jira를 중복 갱신할 필요는 없다. 배지 방식은 사용자가 PM·BE 회의 후 전달한다. 푸시 읽음 deliveryId 계약/실발송 검증 등 기존 미완료는 그대로 보존하며, 회의 전 임의 제품 코드 변경·추가 모니터링 없이 대기한다.


### 회의용 FE 추천 추가 — 정책 확정 아님

- 사용자 요청: 공유용 ‘결정할 사항’ 아래에 FE 추천을 넣고, 추천을 선택했을 때 놓치거나 감수할 차이도 함께 적는다. 표 컬럼을 바꾸지 않고 바로 아래에 추천 절을 삽입했으며 기존 사용자 표 폭/문구를 보존했다.
- 추천 조합: 실제 미읽음 기준, 개인1회+해당 앱에서 접근 가능한 전체 소속 인박스 합계, 이번 배지 집계에서는 LinkTalk 제외, 일반 푸시에 절대 미읽음 수 포함 및 앱 실행/복귀/읽음 뒤GET보정. LinkTalk 푸시와 채팅 화면의 미읽음 표시는 유지한다.
- 감수할 차이: 링크톡만 미읽음이면 아이콘0 가능, 전체소속 합계와 현재 인박스 숫자 다름, 푸시 역순과 웹 읽음 후 미조회에 따른 지연, Android 기종/런처별 점·숫자 차이. 이중 차감이나 남은 인박스 숫자의 임의 초기화는 허용하는 오차가 아니다.
- FE용에도 같은 추천과 선행 확인을 반영: 기존 API로 전체 소속 집계를 중복 없이 계산 가능한지와 기존 PATCH0·SDK·푸시 배지 변경 경로 충돌 확인 필요. LinkTalk 합산 제외만으로 배지 충돌까지 없어지는 것은 아니다. 새 API 필수나 작은 공수 확정을 뜻하지 않는다.
- 두 Notion update 성공 응답 확인. Jira의 기존 결정 대기 기록44948은 여전히 맞아 중복 댓글을 추가하지 않았다. 제품 코드/정책 변경 없음. PM·BE 회의 결과 대기 유지.
