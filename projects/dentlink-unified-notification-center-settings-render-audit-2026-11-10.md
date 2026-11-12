# 통합알림센터 — 알림 수신 설정 화면 렌더 방식 조사 (2026-11-10)

> **2026-11-12 주의:** dev 스웨거에서 알림 설정 GET 응답이 `{view, setting}`에서 `NotificationSettingDto` 하나로 바뀌었다. 이 문서의 `view.employee` 기반 분석은 옛 응답 기준이며, 알림 설정 추가 작업에서 새 구조로 다시 판단한다.

> **범위:** 조사만 했다. 코드 수정·커밋·PR·배포 없음. 별도 세션에서 진행했고 제품 checkout의 브랜치를 바꾸지 않았다(웹은 `git show feature/DL-17058:<path>`로 읽음).
> **기준 ref:** Office 앱 `feature/DL-17059@d4de608`, Lab 앱 `feature/DL-17060@e9108b8`, 웹 `feature/DL-17058@38ca4edae`(로컬 checkout은 `feat/DL-17141-delay-cleanup`이라 ref로 읽음).
> **실서버 응답:** 로그인 토큰이 필요해 이번에는 호출하지 않았다. 대신 11/9 실조회 기록([API 검토 문서](dentlink-unified-notification-center-api-badge-review-2026-11-09.md) “실제 로그인 GET 확인”)의 카테고리 목록을 사용했다. 채널 구성(`toggleChannel`/`channels`)의 실제 값은 당시 증거 파일(`/tmp/notification-*-actual-get-1109.json`)이 지워져 이번에 재확인하지 못했다.

## 1. 결론 요약

- **4개 제품 모두 “서버 배열을 순서대로 돌면서, FE 규칙으로 묶고 FE 사전으로 이름을 붙이는” 방식**이다. 어떤 카테고리·채널을 보여줄지와 기본 순서는 서버 `view`를 따르고, FE에 고정된 카테고리 목록(하드코딩 배열)은 신규 화면에 없다.
- 하지만 **서버 응답과 화면이 1:1이 아닌 지점이 제품마다 있다.** 공통으로 (1) 이름표는 FE 사전에서 가져오고, (2) 같은 도메인을 한 묶음으로 모으는 FE 규칙 때문에 순서가 바뀔 수 있으며, (3) `view.user`(개인 설정)는 어느 제품도 그리지 않고, (4) 상위 토글이 OFF면 하위 채널 체크를 숨긴다. 웹은 추가로 **PUSH 관련 항목·채널을 일부러 뺀다.**
- **묶는 규칙이 제품마다 다르다**(Office 앱: `domain === "ORDERS"`만 묶음 / Lab 앱: `channels`가 있으면 도메인별로 묶음 / 웹: `CREDITS`·`PAYMENTS`만 단독, 나머지는 도메인별). 같은 서버 응답이라도 제품마다 다르게 보일 수 있다.
- 서버 `view`에는 **카테고리·도메인·채널의 표시 이름(displayName)이 없다**(주문 범위 `orderScopes`만 `displayName` 있음). 그래서 “서버대로 이름까지” 그리려면 BE 응답 보완이 먼저 필요하다.
- 구 하드코딩 목록(`ProfileNotificationSection`, push-preferences 기반)은 양 앱에 파일만 남아 있고 **어디서도 import되지 않는다**(현재 화면에 영향 없음).

## 2. Swagger 계약 (dev-api `/v3/api-docs/Office API`, `Lab API`)

`GET /office/notifications/settings`, `GET /lab/notifications/settings` — “화면 구성(view)과 개인 설정 값(setting)을 한 번에 내려준다”.

| 필드 | 의미(Swagger 설명) |
| --- | --- |
| `view.employee.categories[]` | `{domain, category, toggleChannel, channels[]}` — **“배열 순서가 화면 표시 순서”** |
| `toggleChannel` | 카테고리 토글이 담당하는 채널 |
| `channels[]` | 토글 아래 체크로 노출할 채널, **빈 배열이면 단독 토글** |
| `view.employee.orderScopes[]` | `{code, displayName}` — 치과만, 기공소는 빈 목록 |
| `view.user.categories[]` | 개인(유저) 설정 카테고리 — 기공소는 빈 목록 |
| `setting.*.categories[]` | `{category, enabled, channels{채널:boolean}}` — 생략한 카테고리는 “전부 수신” |

- 카테고리·도메인·채널에는 **표시 이름 필드가 없다**. 도메인으로 묶어 그리라는 규칙도 계약에 없다(도메인은 값만 제공).
- 11/9 실조회 카탈로그: Office employee `LINKTALK/DESIGN_CONFIRMATION/ORDER_UPDATES/FEEDBACK/SHIPPING/PAYMENTS/CREDITS`, user `CREDITS`, orderScopes 2개. Lab employee `LINKTALK/DENTLINK_SUPPORT/DESIGN_CONFIRMATION/ORDER_UPDATES/MILLING_ORDER_UPDATES`, user·orderScopes 빈 배열. Office employee `CREDITS`는 PUSH만 제공(11/9 통합 문서 기록).

## 3. 제품별 비교표

| 제품 | 현재 렌더 방식 | 서버 의존 여부 | 서버 응답과 다른 점 | 근거(파일:라인) | 서버 의존으로 바꿀 때 영향·필요 작업(추정) |
| --- | --- | --- | --- | --- | --- |
| **치과앱 (Office)** | `view.employee.categories`를 순서대로 돌며 `domain === "ORDERS"`인 항목만 “Order” 섹션 하나로 모으고 나머지는 각자 단독 섹션. 이름은 FE 사전. 채널은 서버 `channels` 그대로 체크박스 | 항목 존재·순서·채널 목록·켜짐 값: **서버** / 이름·묶음·섹션 제목: **FE** | ① 이름 FE 고정(`CREDITS`는 사전과 별도로 “Office Credits”로 강제, LinkTalk는 “LinkTalk App Push”) ② “Order” 섹션 제목 FE 고정, ORDERS 항목이 서버에서 떨어져 있어도 첫 ORDERS 위치로 모임 ③ ORDERS 외 도메인은 같은 도메인이어도 묶지 않음 ④ `view.user`(Office user `CREDITS`) 미표시 — 저장 시 값은 보존 ⑤ 상위 OFF면 채널 체크 숨김 ⑥ 사전에 없는 코드는 영문 코드 그대로 노출 ⑦ 주문 범위는 서버 `displayName` 사용, MEMBER·옵션1개 이하면 숨김 | `src/configs/utils/notificationSettings.ts:14-32`(이름 사전), `:44`(employee만), `:52-58`(ORDERS 묶음·“Order”), `:64-67`(Office Credits), `:68,77`(미설정=ON); `NotificationSettingSection.tsx:39`(OFF면 채널 숨김); `NotificationCenterScreen.tsx:125-136`(주문 범위 조건); `NotificationSettings.tsx:63`(“Orders to notify me about” 고정) | 이름을 서버로 옮기려면 BE에 카테고리/도메인/채널 `displayName` 추가 필요(현재 없음). 묶음 규칙은 “서버 도메인으로 연속 묶기” 같은 공통 규칙을 정하거나 BE가 그룹 필드를 줘야 함. user 영역 노출 위치는 기획 미정(DL-17235). 순수 FE 변경은 `notificationSettings.ts` 1개 함수 + 테스트 수준 |
| **기공소앱 (Lab)** | `view.employee.categories`를 순서대로 돌며 **`channels`가 비어 있으면 단독**, 있으면 **도메인별 그룹**(제목=도메인 한글 사전). 이름은 한글 FE 사전 → `translateLabText`로 번역 | 항목 존재·순서·채널·값: **서버** / 이름·그룹 제목·묶음: **FE** | ① 이름·그룹 제목 FE 고정(`ORDER_UPDATES`와 `MILLING_ORDER_UPDATES`가 둘 다 “주문 업데이트”, 그룹 제목 “주문”/“밀링센터 주문”으로만 구분) ② 같은 도메인이라도 `channels`가 빈 항목은 그룹 밖으로 빠짐(서버 채널 구성이 바뀌면 화면 위치가 바뀜) ③ 같은 도메인 항목이 떨어져 있으면 첫 위치로 모임 ④ `view.user` 미표시(현재 Lab은 빈 배열이라 실영향 없음) ⑤ 상위 OFF면 채널 숨김 ⑥ 주문 범위 UI 없음(서버도 Lab은 빈 목록이라 일치) | `src/configs/utils/notificationSettings.ts:17-44`(도메인·카테고리·채널 사전), `:68`(employee만), `:74-87`(channels 유무로 단독/그룹), `:90`(이름), `:91,99`(미설정=ON); `NotificationSettingsGroup.tsx:36`(OFF면 채널 숨김) | Office 앱과 동일하게 `displayName` BE 보완 필요. 묶음 규칙을 Office/웹과 하나로 맞추려면 기획 확인 후 `toNotificationSettingGroups` 수정. 번역 키(`translateLabText`) 체계를 서버 이름으로 대체할지 결정 필요 |
| **치과웹 (Clinic)** | 공용 `shared/ui/.../NotificationCenter.tsx`가 `view.employee.categories`를 순서대로 돌며 **`toggleChannel === "PUSH"`인 항목은 건너뛰고**, 채널에서도 **`PUSH`를 제거**. `CREDITS`·`PAYMENTS`는 단독 카드, 나머지는 **도메인별 그룹**. 이름은 i18n `catalog.*` 키(기본값 영어) | 항목 존재·순서·값: **서버(단, PUSH 필터 후)** / 이름·그룹·단독 여부: **FE** | ① **서버에 있는데 안 보임:** PUSH 담당 항목(예: LinkTalk — 11/9 기준 앱 전용 푸시로 추정) 전체, 그리고 각 항목의 PUSH 체크(예: Office Credits가 PUSH만이면 하위 체크 없이 토글만) ② 단독 여부를 `CREDITS`/`PAYMENTS` 코드로 FE 고정 ③ 도메인 그룹 제목·이름 FE i18n 고정 ④ 같은 도메인 항목이 떨어져 있으면 첫 위치로 모임 ⑤ `view.user` 미표시 ⑥ 상위 OFF면 채널 숨김 ⑦ 저장값에 서버 `channels` 키 하나라도 boolean이 아니면 **목록 대신 오류**(전체 PUT 덮어쓰기 방지용) ⑧ 주문 범위는 서버 `displayName`, MEMBER·옵션1개 이하면 숨김 | `shared/ui/src/NotificationUI/NotificationCenter.tsx:103`(employee만), `:106`(PUSH 항목 제외), `:112`(CREDITS/PAYMENTS 단독), `:116`(이름), `:117,127`(미설정=ON), `:122-123`(PUSH 채널 제외), `:130-146`(도메인 묶음), `:297-301`(주문 범위 조건); `useNotificationCopy.ts:44-76`(이름 사전); `NotificationSettings.tsx:106`(OFF면 채널 숨김); `shared/models/src/notifications/notifications.apis.ts:48-66`(불완전 값이면 오류) | PUSH 제외는 “푸시는 앱에서만 설정” 정책에 따른 의도된 동작(코드 주석)이라 바꾸려면 기획 결정 필요(또는 BE가 웹/앱용 view를 나눠 주는 방식). 이름 서버화는 BE `displayName` 필요. 단독/그룹 규칙은 3제품 공통 규칙 합의 후 공용 함수 1곳 수정으로 Clinic·Lab 웹 동시 반영 |
| **기공소웹 (Lab)** | 치과웹과 **같은 공용 컴포넌트**(`product="lab"`). 동작 동일, 주문 범위는 `product === "clinic"`일 때만 | 치과웹과 동일 | 치과웹 ①~⑦과 동일. Lab 카탈로그 기준 PUSH 담당 항목(LinkTalk·Dentlink Support로 추정)이 웹에서 빠지고, 주문 계열만 남음(추정 — 실제 채널 값 미재확인) | `lab/src/components/Notifications/NotificationCenter.tsx:158`(`product="lab"`), 나머지 근거는 치과웹과 동일 | 치과웹과 동일(공용 코드 1곳 수정으로 함께 반영) |

## 4. “서버에 있는데 안 보임 / 서버에 없는데 보임 / FE 고정” 정리

- **서버에 있는데 안 보임:** `view.user.categories` 전 제품(Office user `CREDITS` 해당) · 웹의 `toggleChannel=PUSH` 항목과 모든 `PUSH` 채널 · 상위 OFF일 때 하위 채널 체크(전 제품, 디자인 의도).
- **서버에 없는데 보임:** 신규 화면 기준 **없음**. 섹션/그룹 제목(“Order”, “주문”, “밀링센터 주문”, 웹 도메인명)은 서버 항목이 아니라 FE가 만든 묶음 머리글이다. Office 앱 “Orders to notify me about” 문구도 FE 고정.
- **FE가 고정하는 것:** 모든 카테고리·도메인·채널 이름, 묶음 규칙(제품마다 다름), Office `CREDITS`→“Office Credits”, 웹 `CREDITS/PAYMENTS` 단독 처리, 미설정 카테고리 기본 ON 해석(계약 문구 따름).
- **순서:** 기본은 서버 배열 순서. 다만 같은 묶음 항목이 서버 배열에서 떨어져 있으면 첫 항목 위치로 모여 순서가 달라질 수 있다(현재 11/9 카탈로그 순서에서는 ORDERS 항목이 연속이라 실제로 뒤섞이지는 않을 것으로 추정 — 실응답 미재확인).

## 5. 남은 확인 / 다음 단계(승인 시)

1. 실제 로그인 계정으로 Office·Lab `GET .../settings` 응답을 다시 받아 `toggleChannel`/`channels`를 표의 추정과 대조(사용자 토큰 필요). 사용자가 “서버대로 안 그린다”고 본 구체 항목을 알려주면 위 표의 어느 원인인지 바로 특정 가능.
2. BE: 카테고리/도메인/채널 `displayName`(및 필요 시 그룹 키) 제공 가능 여부.
3. 기획: 웹 PUSH 제외 유지 여부, 3제품 공통 묶음 규칙, user 영역 노출 위치(DL-17235).
4. 코드 수정은 사용자 승인 후. 수정 범위는 앱 각 `notificationSettings.ts` 1개, 웹 공용 `NotificationCenter.tsx` 1개 + 각 테스트로 작다(JS만, 네이티브 영향 없음).

## 6. 사용자 확정 기준과 매핑 누락 점검 (2026-11-10 후속)

**확정 기준(사용자):** `view` 아래 `employee`→`user`를 디자인 순서대로, 각 `categories` 배열을 서버 순서대로 **그대로** 그린다. 서버의 displayName은 **제거될 예정**이다. FE는 서버의 공통 대문자 코드(병원·기공소 공통)로 매핑된 글자를 보여주고, 매핑이 없으면 대문자 값을 그대로 노출한다. 기공소는 기존 다국어 설정을 따라 영어면 디자인 영어, 한글이면 한글로 보인다. 매핑이 없는 값은 바로 보고한다. (수정 착수는 별도 승인 대기)

**매핑 누락(Swagger enum 전체 기준: domain 6·category 9·channel 5·orderScope 2):**

| 제품 | 누락 | 영향 |
| --- | --- | --- |
| 치과앱 | **orderScope `ALL_ORDERS`/`MY_ORDERS_ONLY` 매핑 없음** — 지금은 서버 `displayName`만 사용(`NotificationCenterScreen.tsx:125-131`, displayName 없으면 옵션 제외) | displayName 제거 시 **주문 범위 선택 UI가 사라짐**(옵션 0개 → `canSelectOrderScope` false) |
| 치과앱 | domain 이름 사전 없음(`ORDERS`→"Order"만 하드코딩, `notificationSettings.ts:57`) — PAYMENTS/BENEFITS/USERS/CHAT/MANUFACTURING 없음 | 디자인이 도메인 제목을 보여주면 대문자 노출 |
| 치과앱·기공소앱·웹 | `employee`/`user` 영역 제목 매핑 없음(현재 user 영역을 그리지 않음) | user 영역을 그리면 제목 문구 필요(디자인 확인) |
| 치과웹 | **orderScope 매핑 없음** — `NotificationCenter.tsx:174-178` displayName 없으면 옵션 제외 | 치과앱과 동일하게 주문 범위 선택이 사라짐 |
| 기공소앱 | channel `SMS`·`SLACK`은 registry 없음(문자 그대로 "SMS"/"Slack", 한·영 동일) | 실질 영향 없음 |
| 기공소앱 | 나머지 domain 6·category 9·channel 3은 한글 사전→registry→en/ko 모두 존재 | — |
| 기공소웹 | `sharedUi.json` en/ko `notifications.catalog`에 domain 6·category 9·channel 전부 존재(`SLACK`은 코드 상수 "Slack") | — |
| 치과웹 | clinic에는 `sharedUi.json` 없음 → i18n `defaultValue`(영어)로 표시. clinic `public/locales/ko`가 존재하므로 한글 모드가 실제 쓰이면 영어로 보임(사용 여부 미확인) | 다국어 대상이 기공소뿐이면 영향 없음 |

**누락은 아니지만 제품 간 문구 차이(기획 대조 필요):** LINKTALK 앱 "LinkTalk App Push/링크톡 앱 푸시" vs 웹 "LinkTalk"(ko도 LinkTalk) · DENTLINK_SUPPORT 앱 "덴트링크 서포트 앱 푸시" vs 웹 ko "덴트링크 고객지원" · BENEFITS 앱 "크레딧/Credits" vs 웹 "혜택/Benefits" · PAYMENTS 치과앱 "Payment" vs 기타 "Payments" · CREDITS 치과앱 "Office Credits" vs 웹 "Credit" vs 기공소앱 "Credits" · PUSH 앱 "App Push" vs 웹 "Push" · ORDERS 기공소앱 en "Orders" vs 기타 "Order".

## 7. 구현 — 서버 GET 배열 그대로 렌더 (2026-11-10, commit·push 완료)

**commit·push(사용자 지시):** Office `feature/DL-17059@b50a8d5`, Lab `feature/DL-17060@0a8245d`, Web `feature/DL-17058@bad9e697c`(worktree, pre-commit 타입검사 통과). 모두 원격 일치·clean. PR 본문·상태·배포 변경 없음.

**사용자 지시:** Swagger 자동 생성 파일은 건드리지 않고 FE 사용 코드에서만 displayName을 제거한다. GET 응답의 `view.employee.categories` → `view.user.categories` 배열 순서대로, 서버가 준 것은 하나도 빠짐없이 그린다. employee/user는 서버 묶음 객체일 뿐 화면 구분·제목이 없다. 글자는 코드 매핑, 없으면 대문자 코드 그대로. 매핑 목록은 사용자가 따로 공유한다(치과·기공소 공통 한 세트, 다국어 설정에 따라 영/한).

| 제품 | 변경 | 검증 |
| --- | --- | --- |
| 치과앱 `feature/DL-17059@d4de608` + 미커밋 | `notificationSettings.ts`: employee→user 순서, 연속된 같은 묶음만 합침(순서 불변, 섹션 key 중복 방지), `getNotificationOrderScopeLabel`(매핑 비어 있음→코드 노출). `NotificationCenterScreen.tsx`: displayName 사용 제거, user 영역 저장 경로 허용. 테스트 fixture displayName 제거, 새 테스트 1건 | 관련 Jest 3 suites/29 tests 통과, 변경 파일 eslint 0·prettier 통과, tsc 기존 6건 동일 |
| 기공소앱 `feature/DL-17060@e9108b8` + 미커밋 | `notificationSettings.ts`: employee+user, 연속 묶음만 합침. 새 테스트 `__tests__/utils/notificationSettings.test.ts` 2건 | 2 tests 통과, tsc 기존 5건 동일 |
| 웹 `feature/DL-17058@38ca4edae` + 미커밋(worktree `~/Repository/dentlink-client-notification-center`) | 공용 `NotificationCenter.tsx`: employee+user, **PUSH 항목·PUSH 채널 제외 제거**, domain 없는 항목도 단독 표시, 연속 묶음만 합침, 주문 범위는 `copy.orderScopes[code] ?? code`. `useNotificationCopy.ts` `orderScopes` 빈 매핑 추가. `notifications.types.ts` displayName 제거. `notifications.settings.ts` PUSH 저장 차단 제거. 훅 테스트 1건 새 기준으로 수정 | shared/hooks vitest 19, clinic jest 5, lab jest 4 통과, clinic/lab tsc 0, shared/ui eslint(패키지 설정) 통과 |

- 화면 실행 확인(웹 브라우저·앱 기기)은 아직 안 했다. 웹 공용 UI 렌더 자체의 자동 테스트는 기존에도 없다.
- **현재 서버가 displayName을 줘도 FE는 쓰지 않으므로, 매핑을 채우기 전까지 주문 범위가 `ALL_ORDERS`/`MY_ORDERS_ONLY`로 보인다.**
- 치과앱 `CREDITS`→"Office Credits" 특례는 그대로라 user 영역 `CREDITS`도 "Office Credits"로 보인다. 공통 매핑 반영 때 정리 대상.
- 배포(CodePush·웹) 없음.

**실제 사용되는 값만 추린 매핑 검토표(11/9 실조회 카탈로그 기준, 현재 FE 문구):**

| 서버값 | 영어(현재) | 한글(현재, 기공소) |
| --- | --- | --- |
| LINKTALK | LinkTalk App Push (웹 LinkTalk) | 링크톡 앱 푸시 (웹 LinkTalk) |
| DENTLINK_SUPPORT | Dentlink Support App Push (웹 Dentlink Support) | 덴트링크 서포트 앱 푸시 (웹 덴트링크 고객지원) |
| DESIGN_CONFIRMATION | Design Confirmation | 디자인 컨펌 |
| ORDER_UPDATES | Order Updates | 주문 업데이트 |
| FEEDBACK | Feedback | 피드백 |
| SHIPPING | Shipping | 배송 |
| MILLING_ORDER_UPDATES | Order Updates (치과앱 Milling Order Updates) | 주문 업데이트 |
| PAYMENTS | Payments (치과앱 Payment) | 결제 |
| CREDITS | Credits (치과앱 Office Credits, 웹 Credit) | 크레딧 |
| PUSH (채널) | App Push (웹 Push) | 앱 푸시 (웹 푸시) |
| MAIL (채널) | Email | 이메일 |
| ORDERS (그룹 제목) | Order (기공소앱 Orders) | 주문 |
| MANUFACTURING (그룹 제목) | Milling Center Order (기공소앱 …Orders) | 밀링센터 주문 |
| CHAT (그룹 제목, 웹에서 LinkTalk 표시 시) | Chat | 채팅 |
| ALL_ORDERS (주문 범위) | 없음 | 없음 |
| MY_ORDERS_ONLY (주문 범위) | 없음 | 없음 |

채널·도메인은 실제 GET의 `channels`/`domain` 재확인 전 추정이 섞여 있다(카테고리 목록은 11/9 실조회).

## 8. 최종 매핑표 제안과 주문 범위 매핑 반영 (2026-11-10, 미커밋)

- 주문 범위 매핑을 기존 디자인 리소스로 채움: 치과앱 예전 알림 범위 선택(`ProfileNotificationScopeBottomSheet`)과 i18n(`texts.allOrders`, `profile:titles.myOrdersOnly`)의 **All Orders/전체 주문, My Orders Only/내 주문만 보기**. 치과앱 `notificationSettings.ts` `orderScopeLabels`, 웹 `useNotificationCopy.ts` `orderScopes`(i18n `catalog.allOrders/myOrdersOnly`, 기본값 영어). 기공소는 주문 범위 미사용이라 변경 없음. Figma API는 토큰 만료(403)로 이번에 재확인하지 못함.
- 검증: 치과앱 관련 Jest 17 통과·eslint 0, 웹 hooks vitest 16·clinic jest 5 통과·clinic tsc 0·shared/ui eslint 0. commit 미실시.

| 서버값 | 영어 | 한글 |
| --- | --- | --- |
| LINKTALK | LinkTalk App Push | 링크톡 앱 푸시 |
| DENTLINK_SUPPORT | Dentlink Support App Push | 덴트링크 서포트 앱 푸시 |
| DESIGN_CONFIRMATION | Design Confirmation | 디자인 컨펌 |
| ORDER_UPDATES | Order Updates | 주문 업데이트 |
| FEEDBACK | Feedback | 피드백 |
| SHIPPING | Shipping | 배송 |
| MILLING_ORDER_UPDATES | Order Updates | 주문 업데이트 |
| PAYMENTS | Payments | 결제 |
| CREDITS | Credits | 크레딧 |
| PUSH | App Push | 앱 푸시 |
| MAIL | Email | 이메일 |
| ORDERS | Order | 주문 |
| MANUFACTURING | Milling Center Order | 밀링센터 주문 |
| CHAT | Chat | 채팅 |
| ALL_ORDERS | All Orders | 전체 주문 |
| MY_ORDERS_ONLY | My Orders Only | 내 주문만 보기 |

이 표는 한 코드에 한 문구로 정리한 **제안**이며, 현재 코드에는 제품별 문구 차이(예: 웹 LinkTalk/Push/Credit, 치과앱 Office Credits/Payment)가 남아 있다. 사용자 확정 후 네 제품을 이 표로 맞춘다.

## 9. 실제 DEV 응답 대조 (2026-11-10, 사용자 제공)

- `view`가 화면 구성, `setting`이 사용자 선택값(사용자 설명).
- **Office:** orderScopes `ALL_ORDERS`("All Orders")·`MY_ORDERS_ONLY`("Assigned Orders"); employee 순서 LINKTALK(CHAT, PUSH, [])→DESIGN_CONFIRMATION(ORDERS,[PUSH,MAIL])→ORDER_UPDATES(ORDERS,[PUSH,MAIL])→FEEDBACK(ORDERS,[PUSH])→SHIPPING(ORDERS,[PUSH])→PAYMENTS(PAYMENTS,[MAIL])→CREDITS(BENEFITS,[PUSH]); user CREDITS(BENEFITS,[PUSH]).
- **Lab:** orderScopes [], orderScope null; employee LINKTALK(CHAT,PUSH,[])→DENTLINK_SUPPORT(CHAT,PUSH,[])→DESIGN_CONFIRMATION(ORDERS,[PUSH])→ORDER_UPDATES(ORDERS,[PUSH])→MILLING_ORDER_UPDATES(MANUFACTURING,[PUSH]); user [].
- 사용자 결정: MY_ORDERS_ONLY는 **"My Orders Only"**(서버 표시명 "Assigned Orders" 대신, 현재 코드와 일치). 매핑 키는 `영역(employee/user).카테고리` → `카테고리` → 코드 순으로 찾는 방식 제안(CREDITS employee/user 구분용, 미구현).
- 같은 응답이라도 앱/웹 묶음 규칙 차이로 모양이 다름: Lab 앱은 LINKTALK·DENTLINK_SUPPORT를 제목 없는 단독 카드로, 웹은 "채팅" 그룹으로 묶음. Office도 앱은 LINKTALK 단독, 웹은 "Chat" 그룹.
