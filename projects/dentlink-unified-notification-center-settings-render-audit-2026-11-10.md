# 통합알림센터 — 알림 수신 설정 화면 렌더 방식 조사 (2026-11-10)

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
