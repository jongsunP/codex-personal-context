# Dentlink 통합알림센터 — 현재 체크포인트

최종 갱신: 2026-11-03 14:05 KST — 오늘 확정한 범위로 Web/Office/Lab 기존 변경을 읽기 점검하고 공통 딥링크·외부 HTTPS 앱 진입·혼재 코드를 분류했다. DEV Swagger도 필요한 계약만 재확인했다. 제품 파일·브랜치·PR·배포·서버·기기는 변경/실행하지 않았으며 코드 분리·추가 구현은 아직 하지 않았다.

## 현재 범위와 완료 경계

- **이번 기능:** Clinic/Lab 웹 알림함·수신 설정, Office/Lab 앱 알림함·수신 설정, 인박스 알림(NOTIFICATION) 클릭 및 앱 푸시(PUSH) 클릭의 랜딩·딥링크·REST 읽음 연결, 합의된 추가 앱 조회 목록이다.
- **추가 조회 목록:** Office 크레딧 잔액·이력과 청구서 목록(DL-17202). 결제내역·PDF·Pay Now 등 미확정 후보를 자동 포함하지 않는다.
- **사용자 확정:** 추가 목록은 노티·푸시 외 별도 메뉴가 없어도 수용한다. 메뉴 개선은 후속이며 현재 작업의 선행 조건이 아니다. 이미 목록이 생겼다는 이유로 시트의 ‘알림센터 오픈’이나 이동 없음 정책까지 임의 변경하지 않는다.
- **이메일은 완전히 별도:** 이메일 CTA·앱 설치 여부에 따른 웹/앱 연결·웹 fallback·SES·이메일 분석/클릭 추적은 이 기능의 검토·구현·검증·완료 조건에 포함하지 않는다. [별도 이메일 체크포인트](dentlink-email-cta-tracking.md)와 DL-17183→DL-17187에서 관리한다.
- 기존 알림 설정의 **Email 수신 채널 표시·저장**은 이메일 CTA/추적과 다른 기능이다. 이번 분리를 승인된 수신 설정 UI 삭제 근거로 확대하지 않는다.
- **현재 구현:** 실제 진입점에 연결한 알림 UI 선행 개발 + 추가 Office 목록의 기존 REST 연결까지 있다. 알림 목록·읽음·수신 설정·소속 전환의 실제 BE 연결은 미완료다. PR·merge·배포·최종 QA 완료가 아니다.

## 코드 범위 점검 결과 — 2026-11-03 14:05 KST

### 확인 범위와 Git

- 기존 선행 변경의 실제 diff·소비자를 세 제품에서 병렬로 읽었다. 각 checkout의 branch/HEAD/upstream/dirty/worktree를 확인하고 feature `pull --ff-only`는 변경 없이 끝났다. 필요한 stable ref를 fetch했으며 merge/rebase/branch 전환은 하지 않았다. 세 feature HEAD는 아래 작업 위치 표와 동일하고 clean/원격 일치다.
- Web 비교 merge-base `57bb759ca08e3752140ceffdae2a5421934ec242`, 최신 origin/master `5452871eac0e23a429995381abf673c580d236b9`. master에만14개, feature에만5개 커밋이다. **원격 feature와 일치한다고 최신 master까지 반영한 것은 아니다.** 실제 구현 재개 시 관련 base 변경 영향만 대조하며 이번에 통합하지 않았다.
- Office origin/main/merge-base `7f586790e0bbd7b288458e29f00654d38ba68da2`, Lab `51441039751b63a08c82a1be9695c805c8af1539`.
- 이번 근거는 정적 코드/계약 점검이다. 테스트·시뮬레이터·에뮬레이터·서버를 실행하지 않았고 신규 회귀 검증 또는 merge 준비 완료가 아니다. Notion/Jira/Slack 원문도 추가 수정하지 않았다.

### 유지·분리할 변경

**URL이 HTTPS라는 이유만으로 이메일 전용은 아니다.** FCM으로 이미 앱에 전달된 주소를 앱 화면으로 바꾸는 코드와, 외부 브라우저가 HTTPS 링크를 눌렀을 때 OS가 앱을 실행하도록 하는 설정은 구분한다.

| 제품 | 알림센터/공통 유지 | 이메일·외부 웹 연결로 분리할 후보 | 분리 주의 |
| --- | --- | --- | --- |
| Web | 앞4개 feature 커밋의 알림함·설정·반응형·소속 UI, 기존 업무 화면/활성화 API | 마지막 `6dca5142b`의16파일: Clinic `.well-known` rewrite/handler·AASA·assetlinks 신규와 Lab AASA 경로 확대/관련 검사 | 이 커밋은 알림 UI import 의존이 없어 경계가 명확하다. Lab 기존 `app-links.ts`·handler·assetlinks·`/q/*`는 base부터 있던 기능이므로 폴더 통째로 삭제하지 않는다. |
| Office | `3d53d95`의 Credits/Statements·기존 API, 해당 앱 경로, `eff8111`/`e983956`의 파싱·로그인 pending·최신 이동 보호 | `9ae3cf3`에 추가된 portal HTTPS OS 진입 설정: Android host/filter/alias·bools, iOS associated domain4개 | 같은 커밋에 화면 경로·소속 활성화·푸시 URL 변환도 섞여 있다. 전체 revert 금지. `useNavigationConfig`, `dentlinkWebURL`, browser/native module은 동작·호출 관계별로 구분한다. |
| Lab | `0954134` 파싱 보완, `c312011` 로그인/연속 URL 보호와 기존 밀링 소비자 경합 방어 | `28ebcd8`의 기존 `/q/` 밖 HTTPS filter/alias, BrowserPackage/browser fallback 확장 | 같은 커밋의 path ID 우선·지원 경로 제한은 공통 보호다. 기존 `/q/*`와 Airbridge 등록을 보존하며 신규 밀링 개발로 취급하지 않는다. iOS feature diff는 없다. |

- 두 앱 `src/configs/utils/fcmHandler.ts:125`에서 `convertURLForApp`을 이미 사용한다. Office는 배너 `BannerPopup.tsx:106`, 채팅 `MessageText.tsx:129`, 공통 진입도 소비한다. 지원 업무 URL→앱 경로 변환을 이메일이라는 이유로 제거하면 노티/푸시 및 기존 소비자에 영향을 준다.
- 기존 scheme/Airbridge SDK와 등록, 기존 `push_click` 등은 유지한다. 이번 Web diff에는 SES·이메일 DB 클릭 기록·신규 이메일 분석 이벤트 구현이 없다. 수신 설정의 Email 토글도 제거 대상이 아니다.
- **브라우저 fallback은 혼재 영역:** Office `src/libs/useNavigationConfig.ts:297` 등, Lab 같은 파일 `:205` 등에서 unsupported/소속 불일치 HTTPS 처리가 Android native browser module을 호출한다. 이메일 전용 사용과 기존 노티·푸시 소비를 구분한 뒤 분리 범위를 결정하고 JS 호출부와 native 등록을 함께 맞춘다. native 파일만 빼거나 함수 전체를 일괄 제거하지 않는다.

### 실제로 남아 있는 FE 연결

| 작업 | 지금 확인한 상태 | FE에서 준비/연결할 부분 | 최종 계약과 함께 연결할 부분 |
| --- | --- | --- | --- |
| 알림 항목 클릭 | Office `NotificationCenterScreen.tsx:129`, Lab `:104` 및 Web `NotificationCenterMock.tsx:115`는 mock 읽음만 처리. 실제 랜딩 없음 | 실제로 제공된/확정된 landing URL을 기존 URL 처리·업무 화면으로 연결하는 제품 controller. 표시 UI와 이동/읽음 책임 분리 | 새 알림센터 자체 외부 경로·푸시 식별 key는 미정이며 임의 생성하지 않는다. 실제 읽음 성공/중복 처리는 계약과 맞춘다. |
| 소속 전환 | 새 소속 UI는 mock. 일부 앱 기존 링크는 auth store sideEffect를 먼저 수행 | 기존 활성화 API의 성공→현재 소속 갱신→랜딩 순서 재사용. Web 성공 후 대상 팝업·토스트 일회 복원 | 실제 목록/소속별 미읽음 데이터·권한을 연결. mock ID로 실서버 전환하지 않는다. |
| OS 설정 복귀 | 두 앱 모두 안내/설정 열기만 연결. 선택 항목·복귀 저장 연결 없음 | 선택 대상 보관, OS 복귀 조회, 계정/소속 변경·재시작 시 폐기, 정상 복귀 시 해당 항목만 적용할 callback 연결 | 실제 수신 설정 저장·기존값 보존·초기화/마이그레이션 계약. 서버 성공 전 저장 완료 표시 금지 |
| 추가 Office 목록 | Credits/Statements 기존 REST 조회와 앱 route는 존재 | 계약상 해당 화면으로 가는 노티/푸시에서 기존 경로 재사용·최종 진입 검증. 별도 메뉴는 추가하지 않아도 됨 | 시트의 알림센터 오픈/이동 없음 목적지를 목록 존재만으로 바꾸지 않음 |

- **Web 전환 주의:** Clinic `OfficeSelectListModal.tsx:31`의 onSelectCompleted는 서버 성공 전 호출된다. 성공 토스트를 바로 달지 말고 기존 `OrganizationOffices.tsx:45`의 성공/실패 경계를 재사용한다. Lab `LabEmployeeSwitchBoundary.tsx:39`는 자식을 unmount하고 `resetLabContext.ts:28`에서 toast를 초기화하므로 이번 전환의 출처·이전/다음 이름·팝업 재열기를 경계를 통과하는 일회성 정보로 전달한다. 이를 위한 영속 저장/신규 BE API는 필수가 아니다.
- **앱 소속 주의:** Office 새 finance 등은 requiresEmployeeContext를 기다리지만 기존 order/chat/confirm 경로는 여전히 sideEffect 중심이다. Lab은 `useEmployeeProfile.ts:37`의 서버 활성화 성공 절차와 `useNavigationConfig.ts:92`의 store 우선 절차가 다르다. 읽음 직전 모든 링크에서 올바른 소속 준비가 완료된 것으로 가정하지 않는다. 기존 주문 상태 분기·같은 채팅 유지·action 동작을 보존한다.
- **OS/서버 분리 미완료:** Office/Lab 기존 `PermissionProvider.tsx`가 OS 허용 때 기존 preference 초기화를 계속 호출하며 Office `usePersonalOrdersPreference.ts:65`는 pushEnable:true도 전송한다. 새 OS 조회 hook만으로 결합이 제거된 것은 아니다. 기존 동작을 임의 제거하지 않고 신규 계약에 따라 책임을 옮긴다.
- 새 알림 UI는 Web development/앱 __DEV__ 진입 제한과 mock 상태다. 실제 controller/API/권한 검증 이전에 환경 제한만 풀어 완료로 만들지 않는다.

### DEV Swagger 재확인 — 14:01 KST

[공개 DEV 명세](https://dev-api.dentlink.io/v3/api-docs)를 인증 없는 읽기 GET200으로 확인했다(970paths). 실제 업무 데이터 조회·읽음/설정 mutation은 하지 않았다.

- 기존 `GET /messages/notifications`: id/serviceType/size, DTO id/landingUrl/isRead/sentAt/options. 기존 `PATCH /messages/notifications/read/partial`: unreadNotificationIds[], 전체읽음은 serviceType 선택이다.
- `/messages/notifications/unread`는 boolean, `/messages/notifications/employers`는 string 목록이다. 이것만으로 신규 전체/안읽음 페이지네이션·소속별 ID/개수·집계 요구를 충족한다고 단정하지 않는다.
- 구 앱 preference 조회는 preferenceId/pushEnable/enablePersonalOrders/settings이고 PATCH는 pushEnable·enablePersonalOrders required다. Employee별 domain/category/channel catalog·저장/기본값·푸시 클릭 식별/기록의 새 계약은 현재 공개 명세에서 확인하지 못했다. **BE 내부 개발/공유 계약이 없다는 뜻은 아니다.**
- 푸시 URL dedup은 현재 같은 URL4초 기준이다. 같은 랜딩의 다른 알림과 같은 푸시의 중복 콜백을 구분할 실제 identity 계약이 필요하다. notificationId 직접 전달을 필수로 고정하지 않는다.
- 기존 웹의 노출·스크롤 읽음 hook을 새 클릭 기준 알림함에 그대로 이식하지 않는다. 현재 API의 호출 자체와 새 정책을 만족하는 연결은 별개다.

### 다음 구현 재개 순서

1. 위 분류를 기준으로 이메일 전용 변경의 보존/분리 단위를 적용하고, 최신 Web master 관련 변경 영향을 확인한다. 임의 이력 삭제/전체 revert/새 branch 생성은 하지 않는다.
2. 기존 API를 활용한 소속 전환 성공 경계, 알림 클릭→공통 랜딩, OS 설정 복귀 상태 흐름을 제품별로 연결한다. 계약이 정해진 경로만 사용하고 서버 저장 완료로 과장하지 않는다.
3. 최신 BE 공유본·정책 변경을 필요한 항목만 대조해 목록/집계/수신 설정/읽음/푸시 식별 연결을 진행하고 실제 데이터로 교체한 mock을 정확히 제거한다.
4. 최종 코드로 웹·두 앱 영향 화면/역할/iOS·Android를 검증한다. 지금은 위 점검 결과를 저장한 상태이며 분리·구현·runtime·PR·배포는 이번에 실행하지 않았다.

## 문서 정리·원 조사 인계 이력 — 2026-11-03 13:54 KST

아래는 코드 범위 점검 전 마감 이력이다. 현재 다음 시작점은 위 14:05 점검 결과를 따른다.

- 사용자가 최종 Notion 변경을 확인했다. 문서·Jira·개인 정본의 범위 정리는 완료이며 코드 작업을 재개한 상태가 아니다.
- 마감 확인: Web/Office/Lab 세 checkout이 clean이고 각각의 HEAD가 실제 원격 feature SHA와 일치했다. 제품 commit/push 상태 확인이며 PR·배포·새 런타임 성공을 뜻하지 않는다.
- Jira DL-17202/17187/17179의 부모·본문·담당·상태를 다시 읽어 작업 분리를 확인했다. 기존 상태(17202 해야 할 일, 17187 진행 중, 17179 완료)는 유지했다. 필요한 새 카드나 추가 내용 분리는 발견하지 못했다.
- 사용자 승인으로 원 **앱 미지원 기능 우선순위 세션**(`01a17657-caad-70f1-9a40-dbde874a3d42`)에 최신 범위·Notion 위치·이메일 분리·추가 목록의 메뉴 후속 기준을 전달했다. 원 조사는 완료/대기를 유지하며 중복 조사·파일 수정·제품 작업을 시작하지 않도록 명시했다. 대상 세션의 수신 확인과 idle 복귀까지 확인했다.
- 남은 핵심은 기존 feature 내 공통 딥링크/이메일 전용 변경의 구분, 최신 BE 계약 대조 후 알림 목록·설정·소속·푸시 읽음과 추가 목록의 실제 진입 연결, 최종 코드 검증이다. 기존 UI와 조회 목록의 성과는 보존한다.
- 이번 마감에 새 정책/디자인/Swagger 변경분을 전수 조사하지 않았다. 따라서 과거 미정 항목이 오늘도 미정인지·새 API가 아직 없는지 단정하지 않고 다음 작업 시작 시 필요한 변경분을 확인한다.
- **다음 시작점:** 사용자 재개 요청 → 정확한 checkout/작성자 확인 → 기존 코드 범위 분류 → 최신 정책·BE와 대조 → 가능한 연결 작업. 이메일 연구나 구현을 자동 재개하지 않는다. 현재는 추가 실행·폴링 없이 대기한다.

## 이번 문서 정리 완료 — 2026-11-03

### Notion: 같은 상위 위치의 세 영역

사용자의 최종 정정은 **작업 개념을 Jira처럼 분리하되, 모든 문서를 같은 대문/하위 페이지 규격에 맞추지는 않는 것**이다. 원 조사 대문·앱 추가 단일 문서·이메일 대문을 같은 Development Documents data-source(`26366594-1ec5-423c-b7c3-35abe1e047f2`) 직속에 둔다. 앱 추가 문서는 하나여서 불필요한 신규 대문을 제거하고 기존 문서를 직접 배치했다. 이메일은 자료가 여러 개여서 대문과 하위 3개 문서를 유지한다. 기존 본문·표·공유 링크를 보존했다.

| 영역 | 현재 문서 | 보존·분리한 내용 |
| --- | --- | --- |
| 원본 앱 미지원 조사 | [모바일 웹 대비 앱 미지원 기능 현황](https://app.notion.com/p/innovaid/3fece072e82f80d5a02fda9a76cd51b7) | Clinic/Lab 1차 조사·통합 회의 원본 그대로 유지 |
| 알림센터 병행 앱 목록 | [앱 지원 추가 항목 검토·구현](https://app.notion.com/p/innovaid/40cce072e82f81439d7bc253192e966b) | 단일 문서를 상위에 직접 배치. 기존 본문·표·사용자 의견 유지, 불필요한 중간 대문 없음 |
| 별도 이메일 작업 | [이메일 CTA 웹·앱 연결·추적 — 대문](https://app.notion.com/p/innovaid/40dce072e82f819ca557c474effabaea) | 하위에 [작업 범위·진행 정리](https://app.notion.com/p/innovaid/40cce072e82f81fda0e2d123259d5501), FE/BE 비교, SES 조사 세 문서를 같은 깊이로 배치 |

- 후보 표의 이메일 행만 분리했으며 나머지 6개 후보 행·사용자 의견은 보존했다. 과거 ‘앱 화면 없음/미선정’ 설명은 현재 구현 상태가 아니라 이전 조사임을 표시했다.
- 팀 공유 Notion에는 범위·상태·일반 기술 근거를 두고 개인 확인 순서·작업 권한·기록 관리는 개인 컨텍스트에 둔다.
- PRD·Figma·FigJam·Sheet·Slack 기획 원문은 수정하지 않았다. 이번 정리는 원문 전체의 신규 업데이트 조사나 폴링이 아니다.

### Jira: 기존 카드 정리

- [DL-17202](https://innovaid.atlassian.net/browse/DL-17202), DL-17174 하위: Office 크레딧·청구서 목록과 노티/푸시 진입 연결·검증. 메뉴 결정 대기를 제거하고 미확정 결제내역은 제외했다.
- [DL-17179](https://innovaid.atlassian.net/browse/DL-17179), DL-17174 하위: 후보 검토 완료 이력과 문서 제목·DL-17202 연결을 정리했다. 이메일은 현재 후보 검토 범위에서 제외했다.
- [DL-17187](https://innovaid.atlassian.net/browse/DL-17187), DL-17183 하위: 이메일 CTA 웹·앱 연결·분석/SES·BE 연동을 별도 담당한다. 배포일뿐 아니라 알림센터 개발·완료 범위에서도 분리했다.
- 기존 담당·상태를 유지했다. 새 카드·댓글·상위 카드·다른 담당 카드 변경은 없다. 저장 응답으로 최종 본문을 확인했다. 후속 Notion 대문 추가 이후에도 Jira의 기존 상세 링크는 유효하므로 불필요하게 교체하지 않았다.

## 제품 작업 위치와 검증 근거

아래는 **2026-11-03 브레이크포인트에서 로컬 Git·실제 원격 feature SHA를 재확인**한 결과다. 세 checkout 모두 clean이고 각 HEAD와 원격 feature가 일치한다. 마지막 코드 구현·기기 실행 근거는 11/2 이력이며 이번에 원격 제품 배포나 새 런타임을 검증한 것은 아니다.

| 제품 | checkout | branch | HEAD |
| --- | --- | --- | --- |
| Web | `/Users/parkjongsun/Repository/dentlink-client-notification-center` | `feature/DL-17058` | `6dca5142ba4b179c92d580bc19a4b089f9718b6d` |
| Office | `/Users/parkjongsun/Repository/dentlink-app` | `feature/DL-17059` | `e983956b17202e436ebda323eb2b471403ba2b38` |
| Lab | `/Users/parkjongsun/Repository/dentlink-lab-app` | `feature/DL-17060` | `c3120118a1d9628be900fa96051e5eae36c59ce4` |

- **Web:** 실제 헤더·모바일 메뉴에 알림함·수신 설정·소속 선택 UI를 연결했다. 전체/안읽음·목록 상태·전체읽음·소속 이동 토스트 등은 선행 UI이며 새 알림 데이터/설정/활성화는 메모리 mock 상태다.
- **두 앱:** 실제 Home bell/Root 경로의 알림함·설정·소속 선택, OS 상태 조회/설정 안내와 전역 OS OFF 1회 팝업을 선행 구현했다. 서버 설정 저장·실제 소속 활성화·푸시 읽음 연결은 아직 아니다.
- **Office 추가 목록:** 크레딧 잔액·이력과 청구서 목록에 기존 REST를 연결했다. 지정된 노티/푸시의 최종 진입·계정/소속·권한은 실제 계약과 맞춰 검증해야 한다.
- **공통 URL 처리:** 로그인 전 URL 보관·탭 복원·최신 URL 소비·늦은 이전 요청의 화면 덮어쓰기 방지를 보완했다. 기존 특수 동작과 다른 기능 소비자를 보존해야 한다.
- 웹 PC/모바일 및 양 앱 iOS/Android UI 실행 검증 이력이 있다. 11/2 최종 코드의 Office Credits/Statements 실조회, 두 앱 탭/deferred·주문/Help 검증과 제한은 [전체 이력](archive/dentlink-unified-notification-center-through-2026-11-03.md)에 보존했다.
- 실제 로그아웃·재로그인 전체 경로, 실제 푸시 중복 콜백, 전체 역할·권한 및 최종 BE 연결 QA를 모두 끝낸 것은 아니다. 전체 tsc/lint의 기존 범위 밖 오류와 변경 범위 통과를 구분한다. 이후 코드 변경 시 영향 화면·소비자·역할을 최종 코드로 다시 실행 검증한다.
- 새 Storybook 파일은 제거했다. 실제 화면을 구현하며 불필요한 Storybook·개인 인계 파일을 제품 저장소에 추가하지 않는다.

### 문서 분리와 코드 분리

- 기존 feature에는 공통 URL 처리와 이메일을 고려한 HTTPS/native 도메인·AASA/assetlinks 변경이 함께 있다. **이번에는 코드 분리·제거를 하지 않았다.**
- 11/3 코드 범위 점검으로 공통 노티/푸시·추가 목록·외부 웹 진입·혼재 영역을 구분했다(상단 결과). 아직 실제 코드 분리는 하지 않았다. 전체 revert 대신 기존 소비자를 보존하는 변경 단위로 적용해야 한다.
- 이메일 전용 검증/서명·배포 문제를 알림센터 차단 조건으로 되돌리지 않는다. 실제 공통 코드나 전달 단위에 영향이 있는 부분만 이 기능에서 다룬다.

## 유지할 기능 정책

### 알림 목록·읽음·랜딩

- 목록·읽음은 기존 REST를 우선 재사용한다. 기기 간 실시간 동기화·알림 전용 SSE·읽음 동기화용 silent/data FCM·대체 주기적 폴링은 제외한다. 기존 사용자 노출 FCM/Notifee와 Lab 배송·픽업 SSE는 유지한다.
- 소속별 최신순, 전체/안읽음 탭, LinkTalk 인박스 제외가 기준이다. 노출·스크롤만으로 읽지 않으며 개별 클릭·전체읽음·푸시 클릭을 읽음 계기로 삼는다. ‘개별 읽음 제외’는 별도 읽음 버튼을 두지 않는 의미다.
- 현재 요구에는 삭제 UI·신규 FE 삭제 호출이 없다. 기존 DELETE API 폐기나 다른 사용처 제거까지 확정한 것은 아니다.
- [PM 10/29 13:55 답변](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793249757598429)에 따라 푸시는 클릭 기준이며 대상 삭제·권한 없음으로 랜딩하지 못해도 읽음 대상이다. 인증·해당 소속 준비 후 요청하고 요청 실패는 읽음 완료로 기록하지 않는다.
- `notificationId` 직접 전달은 필수가 아니다. 다른 정보 조합도 가능하되 같은 화면으로 가는 서로 다른 알림을 구분해야 한다. 업무 ID·랜딩 URL만으로 알림 identity를 추측하거나 과거 알림까지 임의 일괄 읽음 처리하지 않는다.
- 알림 읽음과 자체 BE 푸시 클릭 이력은 별개다. BE가 한 API에서 읽음까지 처리할지 FE가 따로 호출할지·식별정보/전달 위치는 최신 계약으로 확인한다.
- 같은 알림의 FCM/Linking/Notifee 중복 콜백 제어와 같은 화면으로 가는 다른 알림 처리는 구분한다. 로그인 대기·employerId→해당 employeeId 확인/활성화·특수 딥링크 동작을 보존한다.
- Web/App 및 NOTIFICATION/PUSH 랜딩은 [알림 현황표](https://docs.google.com/spreadsheets/d/1w1xwwEWRE0KgiJsOvldxIFbtNgWguohurf5kemIrW_g/edit?gid=614410508#gid=614410508)로 대조한다. 이메일 CTA 표와 혼용하지 않는다.

### 수신 설정·OS 권한

- Employee 기준 서버 수신 설정을 웹·앱에서 공유하고 기기 OS 권한은 분리한다. 웹 PUSH 조작은 숨긴다. Office/Lab 지원 채널을 구분하며 Office 구성을 Lab에 그대로 복제하지 않는다.
- 신규 가입·신규 소속 PUSH ON, 기존 PUSH 선택 보존 방향을 유지한다. 실제 초기값·마이그레이션은 BE 계약으로 확인한다. **Lab My Orders는 제외 확정**이며 과거 제안/티켓 제목으로 되살리지 않는다.
- 상위 OFF는 하위 OFF, 상위 다시 ON은 하위 기본 ON이다. 하위를 모두 OFF해도 상위까지 자동 OFF하지 않는다. 숨긴 채널을 저장 시 덮어쓰지 않도록 실제 catalog/저장 규칙과 맞춘다.
- MEMBER의 My Orders 수신은 Assigned Dentist 기준이다. 알림 수신 설정과 홈/주문/LinkTalk 조회 필터는 이름만으로 합치지 않는다. Office `usePersonalOrdersPreference`의 `pushEnable:true` 결합도 함께 점검한다.
- LinkTalk/Support Push 설정은 자동 이벤트 채팅 자체를 끄는 의미가 아니다.
- OS OFF에서 특정 PUSH 선택→OS 설정→정상 복귀 후 권한 ON이면 선택한 항목만 저장한다. 재시작·계정/소속 변경 등 흐름이 끊기면 과거 선택을 버리고 서버 저장값을 유지한다. 임의 유효시간이나 복잡한 복구 정책을 발명하지 않는다.
- 기존 `PermissionProvider`의 OS 허용과 서버 preference 초기화/upsert 결합은 남아 있다. 새 OS 조회 hook이 있다는 이유로 분리가 완료됐다고 판단하지 않는다.
- **전역 OS OFF 팝업:** 10/30 17:30 기기별 로컬 1회 노출 선행 구현 완료. 실제 표시 후 기록하며 계정·병원 변경으로 초기화하지 않는다. 재설치·이력 유실로 재노출되는 것은 수용한다.
- **설정 화면 파란 배너:** 마지막 조사에서 노출 주기·닫기/재노출 정책은 미정이었다. 전역 팝업과 같은 UI로 취급하거나 팝업까지 미구현으로 되돌리지 않는다.
- **도메인/카테고리 표시:** 10/30 18:01 사용자 결정으로 BE 계층/명칭을 그대로 노출할 의무가 없다. 같은 원본 row 안에서 하위 카테고리를 상위처럼 보이게 하거나 도메인을 숨길 수 있다. 저장 식별자를 유지하고 무관한 row는 합치지 않는다. `title`, `key/label` 분리는 준비됐지만 실제 enum/catalog adapter는 미확정이다. [디자인 기준](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=314-23253)

### 소속 전환·미읽음 표시

- 올바른 employer/employee 활성화 후 해당 소속 알림을 보여준다. 웹은 성공 후 대상 알림 팝업 한 번 자동 열기·토스트까지 가능한 방향이며 앱은 대상 스크린으로 연결한다.
- 알림에서 이동했는지, 이전/이후 병원명은 이번 이동의 임시 정보로 처리할 수 있다. 이 목적만으로 영속 저장·신규 BE API를 요구하지 않는다. 현재 선택/토스트 mock을 실제 활성화 완료로 보고하지 않는다.
- 벨 미읽음 점은 모든 소속 중 미읽음 존재 여부, 현재 목록·전체읽음은 현재 소속 기준이다. 위치별 숫자/점과 집계 응답은 최종 디자인·BE 계약에 맞춘다.

## 남은 일과 다음 코드 작업 순서

지금은 코드 범위 점검 완료 후 대기한다. 아래 장기 순서와 함께 상단 14:05의 구체적인 다음 작업을 따른다. 이번 점검에서 구현을 시작하지 않았다.

1. 정확한 checkout·Git·활성 작성자를 다시 확인하고, 이번에 분류한 공통 딥링크/이메일 전용/혼재 변경을 필요한 전달 단위로 정리한다. 기존 완료 작업을 보존한다.
2. 최신 Notion 정책·Figma 변경 및 DEV Swagger를 현재 구현과 대조한다. 과거 조사 전체를 재시작하지 않는다. 새 API를 요구하기 전에 실제 명세를 확인한다.
3. 목록·미읽음/소속별 집계·수신 catalog/default/migration·읽음/푸시 클릭·Web/App 랜딩 계약에 맞춰 연결 범위를 정한다. 미확정 BE payload/enum을 임의 확정하지 않는다.
4. 노티/푸시→로그인 준비→올바른 소속→지정 화면/동작 및 정책상 읽음을 연결한다. 추가 Office 목록도 시트에서 정한 진입으로 검증한다. 별도 메뉴·이메일 자동 앱 실행을 선행 조건으로 추가하지 않는다.
5. 실제 API 연결 시 임시 catalog/ID/mock store·data·개발 분기를 정확히 제거한다. OS/preference 결합·숨긴 채널·소속/계정 전환·중복 콜백도 함께 검증한다.
6. 최종 코드로 웹 PC/모바일과 두 앱 iOS/Android의 영향 화면·공통 소비자·역할/권한을 실행 검증한다. 정적 검사·에이전트 검증·사용자 QA·PR·merge·release·배포를 구분한다.

남은 구체적 확인은 목록/집계·설정 catalog·기존값 보존·푸시 식별/클릭 계약, 파란 설정 배너 정책, Lab Home 최근 메시지/Support·자동 메시지 숨김의 실제 범위 등이다. **해당 구현에 도달했을 때 최신 문서/코드로 먼저 해결하고 정말 남는 결정만 사용자에게 질문한다.** 전체 기획·BE가 미완성이라는 이유로 확정 UI까지 다시 미착수로 돌리지 않는다.

## 정본 자료·Jira·이력

- 정책: [Notion PRD](https://app.notion.com/p/innovaid/3c7ce072e82f811184a8e647444f01fd). 화면: [Figma](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=2-6). 원 기획: [FigJam](https://www.figma.com/board/U9Qpm6ACzjGFKyrCoaAuvA?node-id=33-3714).
- 결정 근거: [UX 논의](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793063024060739), [푸시 클릭/읽음](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793244658608799), [앱 추가 목록 회의](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793596568281269). 최신 명시적 사용자 정정과 날짜 있는 후속 결정을 오래된 문장보다 우선한다.
- 알림센터 상위 [DL-16140](https://innovaid.atlassian.net/browse/DL-16140). 공통 DL-17057, Web DL-17058/17061/17062, Office DL-17059/17063/17064/17065, Lab DL-17060/17066/17067/17068, UX 사전 검토 DL-17048. 실제 카드 상태·범위는 재개 시 확인하며 카드명만으로 제외 범위를 복원하지 않는다.
- 추가 목록: DL-17174→DL-17202, 후보 검토 DL-17179. 원본 앱 비교 세션 역할은 [모바일웹/앱 차이 체크포인트](dentlink-mobile-web-app-parity.md)를 참조한다.
- 마지막 DEV Swagger 조사: **11/3 14:01 KST**. 기존 목록·부분/전체읽음·미읽음·구 preference 계약을 재확인했다. 정확한 공개 명세의 범위/미확인 사항은 상단 결과를 따른다.
- 과거 FE API 제안서는 확정 BE 계약이 아니다. 상세 조사·UX 합의·소스/기기 증거·공수 산정·이전 정확한 Git 이력은 [2026-11-03 분리 전 전체 이력](archive/dentlink-unified-notification-center-through-2026-11-03.md)에 보존했다. 과거 ‘현재/다음’ 지시는 최신 범위를 되돌리지 않는다.

## 운영 경계

- 이 세션은 통합알림센터 기능을 Web/Office/Lab 함께 담당하며 [FE 상위 세션](dentlink-fe.md)은 공통 조율을 담당한다. 새 세션·worktree를 자동 생성하지 않는다.
- 제품마다 정확한 저장소·활성 작성자를 확인한다. Web 신규 일반 작업은 최신 origin/master, 두 앱은 origin/main 기반 feature/<Jira>→해당 release→main이다. 남은 develop을 신규 기준으로 쓰지 않는다.
- 제품 commit/push는 기존 명시 권한 범위에서만 수행하고 PR·merge·배포는 별도 권한이다. 현재 요청은 코드 범위 점검이므로 제품 파일 변경/실행을 재개하지 않는다.
- Slack은 읽기 전용이며 자동 폴링은 중단 상태를 유지한다. 팀 공유 문서와 개인 작업 메모를 구분하고 의미 있는 마감에 개인 컨텍스트만 commit/push한다.
