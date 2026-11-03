# 통합알림센터 2026-11-03 구현·검증 경과 기록

이 문서는 당일 단계별 원문을 보존한 **이력**입니다. 안의 “현재”, HEAD, 비밀번호 입력 대기, 서버 유지, FE 잔여 없음은 당시 상태이며 최신 지시가 아닙니다. 최신 상태는 [활성 체크포인트](../dentlink-unified-notification-center.md), 상세 실행 근거는 [앱 검증 기록](../dentlink-unified-notification-center-runtime-2026-11-03.md)을 따릅니다. 18시 마감 후 파란 설정 배너의 1회 영속 이력 누락도 추가 확인되어 활성 체크포인트에 정정됐습니다.

- 보존 기준 개인 컨텍스트 commit: `1c6676d8be6e83099fa79d4001d64491a587519e`
- 보존 원본 SHA-256: `832d9e308d83fcb976c961de7f46b3335061967478e6eb4dfc5fbed75c0198d8`
- 원문 내용은 보존하고 상대 링크의 위치만 보정했습니다.

---

# Dentlink 통합알림센터 — 현재 체크포인트

최종 갱신: 2026-11-03 18:28 KST — 앱 확대 점검의 딥링크/전환 보완4건과 추가 Web/Office 설정 권한·배송 UI 보완까지 검증·commit/push 완료. 세 제품 원격 HEAD 일치·clean 확인. 키체인4계정 실제 DEV 인증 검증 및 DL-17202 진행 중 변경 완료. 실제 알림 BE 연결·일부 실역할/데이터 검증·기존 Office Support API 확인은 남는다. PR·merge·배포는 하지 않았다.

## 설정 권한·서비스 정책 보완 완료 — 2026-11-03 18:26 KST

- 사용자가 권한/기기/서비스별 제공 메뉴 차이의 개발 반영 여부를 질문했고, 실제 정책/현재 UI를 대조하자 MEMBER 범위 변경 UI 및 Payments 권한 분기, Web Clinic Shipping 누락이 확인됐다. 사용자가 **미완료 항목도 진행·검증·최종 브리핑**을 승인했다. 이전 마감 기록을 전체 FE 누락 없음의 근거로 재사용하지 않는다.
- 현재 Notion PRD 5-2~5-5와 #14, Figma 관련 설정 화면을 재대조했다. PRD 최종편집은 10/29 18:44 KST. 필요한 구간을 읽었으며 도구가 누락한 블록이 있어 문서 전체를 완전 조회했다고 주장하지 않는다.
- Office 권한 정본 매핑은 ADMIN→OWNER, BILLING MANAGER→PAYMENT_MANAGER, MANAGER→EDITOR, MEMBER→MEMBER다. 새 ADMIN API enum을 만들지 않는다. 현재 소속에 일치하는 실제 authority를 전달해 MEMBER의 담당 주문 범위 고정/선택 UI 숨김, OWNER·PAYMENT_MANAGER만 Payments 노출을 Web Clinic/Office 앱에 보완했다. 숨긴 원본 설정은 지우지 않고 실제 수신·목록 필터는 BE와 연결할 때 적용한다.
- Web Clinic Shipping은 PRD 채널표와 Office 기존 항목에 근거해 기존 row 형태로 추가했다. 웹의 PUSH 미노출, Lab My Orders 제외, Lab Email/SMS 제외 등 기존 서비스 구분은 유지한다.
- **Lab 밀링 Payments는 미정으로 분류했던 중간 보고를 정정한다.** PRD #14가 MANUFACTURING 하위 Order Updates/Payments를 Resolved로 명시하고 Figma167:25825에도 밀링 결제·주문 업데이트 앱Push가 있어 현재 mock 유지 근거가 충분하다. 채널 요약표 누락만으로 삭제하거나 추가 PM 질문을 만들지 않는다.
- 양 앱 PermissionProvider의 OS 허용→legacy POST 초기화는 현재 production 구설정 및 누락 타입 생성에도 쓰인다. 신규 Employee catalog/default/migration·저장 연결 없이 통째 제거하지 않는다. usePersonalOrdersPreference의 pushEnable 결합도 새 BE 저장 계약으로 이관할 때 함께 정리해야 하며 현재 분리 완료로 표시하지 않는다.
- Web/Office 각각 단독 writer를 배정해 변경 후 독립 리뷰까지 마쳤다. Lab 앱은 이 추가 정책 보완에서 변경하지 않았다. 검사 중 재가동한 이 세션의 runtime을 종료했으며 아래에 결과를 남긴다.

### 최종 코드와 실행 확인

| 제품 | checkout / branch | 원격 반영 HEAD |
| --- | --- | --- |
| Web | `/Users/parkjongsun/Repository/dentlink-client-notification-center` / `feature/DL-17058` | `d11fb875940f76a0254ffc14514fd2b7ae654c28` — 실제 소속 권한 전달·MEMBER 범위선택 숨김·Payments 노출·Shipping 추가 |
| Office | `/Users/parkjongsun/Repository/dentlink-app` / `feature/DL-17059` | `6bf1c584a5884de1b68b6ca40f67a25c56386626` — 실제 권한별 설정 UI·오래된 권한/소속 callback 거부 |
| Lab | `/Users/parkjongsun/Repository/dentlink-lab-app` / `feature/DL-17060` | `be4512bb8def094e867fbe0753b018858de9a097` — 앞선 딥링크/밀링 전환 보완, 이번 정책 재검토로 추가 수정 없음 |

- Web: 실제 로그인한 Clinic/Lab OWNER에서 표시되는 Chrome for Testing의 PC1280·모바일390 설정·Back/닫기, Clinic Shipping 토글·Payments/Scope, Lab 기존 구성 유지 확인. 해당 화면의 uncaught JS·가로 넘침 없음. Clinic 저장계정에 실제 MEMBER 소속은 없어 MEMBER/다른 역할은 실제 controller 하네스10건으로 구분 검증했다.
- Office: 최종 추가 코드에서 iOS 실제 MEMBER→OWNER→MEMBER 전환 및 Android OWNER 설정/뒤로 재검증. MEMBER 범위선택/Payment 숨김, OWNER 표시, 숨긴 원본값 유지, 이전 설정·채널·OS 안내 callback 거부를 확인했다. 실제 TSX 하네스14건과 ESLint 통과. 일부 역할·실제 OS ON 복귀 교차는 기기 미검증이며 전체 최종 QA 완료로 확대하지 않는다. 세부는 [11/3 앱 실행 기록](../dentlink-unified-notification-center-runtime-2026-11-03.md)의 마지막 보완 절을 따른다.
- Web commit/push hook의 Clinic/Lab/Admin 타입검사, lint 및 기존 공통 테스트·검사가 통과했다. 기존 lint warning은 남지만 errors는 없었다. 별도 실제 controller10건·변경분 lint·diff 검사 통과. 제품 테스트/스토리북/개인 상태 파일 추가 없음. 독립 리뷰에서 추가 수정이 필요한 확정 버그/회귀 없음.
- 전용 `browser-profile`을 실제로 다시 열자 Clinic/Lab 모두 재로그인 없이 Home으로 진입했다. 처음 독립 context에서 실패한 `web-auth-state.json`은 양 origin을 실제 탐색한 연결에서 다시 내보냈고, 이후 새 독립 headless context에서도 **두 서비스 로그인 재사용 성공**을 확인했다. 파일0600·profile0700을 유지했다. 파일 존재만으로 성공 판단하지 않았으며 필요 시 이미 검증한 Keychain 계정을 사용한다.
- 새 알림 설정/목록은 여전히 DEV mock 경계다. 실제 수신 대상 제한·조회/집계·저장·읽음/푸시 identity는 BE 계약 이후 연결한다. 이번 UI 완료를 OS 권한과 서버 preference의 완전한 분리나 production 배포 완료로 표현하지 않는다.

### 이번 마감과 다음 시작점

- 실제 cwd·port·PGID를 대조한 뒤 Clinic3000/Lab3005/Office8081을 종료했다. Lab8082는 추가 검증에서 실행하지 않았다. 전용 Chrome for Testing supervisor를 정상 종료해 로그인 상태를 저장했고 CDP9233도 종료했다. 기존 Android AVD/iPhone17Pro를 shutdown하고 해당 DeviceHub 창을 닫았으며 일반 Chrome·IDE·다른 작업은 건드리지 않았다. 로그인 profile·키체인·기기 앱 데이터는 보존했다.
- 구현·검증 상세와 개발 계정 참조·Jira 상태는 이 개인 컨텍스트에 유지한다. 새 비밀번호/토큰/로그인 응답은 Git·로그·채팅에 남기지 않았다. Web/Office/Lab 제품 commit/push는 완료이며 PR·merge·배포는 미실행이다.
- **지금은 추가 정책/API를 가정한 작업 없이 대기한다.** 다음은 BE 목록/집계/수신 설정 및 읽음·푸시 식별 계약을 받아 실제 연결하고 대체한 mock을 제거하는 단계다. OS permission과 legacy preference 초기화의 분리도 같은 계약 이관 때 확인한다.
- 기존 Office Support의 `/office/chat-messages` 404는 아래 Swagger 대조 근거와 함께 BE의 현재 지원/대체 계약 확인이 필요하다. 실역할·실데이터·실수신 FCM·OS 권한 복귀 조건을 마련한 뒤 남은 실행 검증을 수행한다. 확정된 화면/메뉴에 대한 현재 FE 보완을 완료한 것이며 모든 서비스 기능의 최종 QA 완료는 아니다.

### 개발 계정 검증·Jira 확정 결과

- 사용자가 Mac 보안창에서 네 제품 계정을 저장한 뒤 검증을 요청했다. Web Clinic, Web Lab, Office app, Lab app **모두 키체인 값을 로컬 검증 프로세스 안에서만 읽어 실제 DEV 로그인 및 own profile 조회 성공**을 확인했다. HTTP200·code0000·accessToken 존재·서비스 일치·프로필 계정 일치를 검증했다. 비밀번호/토큰/응답 본문은 출력·Git저장하지 않았다.
- 검증 경로: Web `/office/auth/login`·`/lab/auth/login`, 앱 `/app/auth/login`, 이어 해당 서비스 `/users/own`. 소속 활성화, 디바이스 등록, 푸시 설정 API는 호출하지 않았다. 독립 HTTP 세션을 사용했으며 기존 앱/브라우저 저장 상태를 덮어쓰지 않았다. 이는 인증 정보의 정확성 검증이고 각 제품 UI 재로그인 자동화를 실행한 것은 아니다.
- 보안 입력창은 사용자가 닫았고 `entry-status.json`은 closed·savedAccounts4다. `keychain-references.json`에 비밀 없는 서비스/계정 참조와 verifiedAt을 저장했다. `credential-validation.json`에는 제품별 성공 boolean/HTTP상태만 있으며 둘 다0600이다. 다음 로그인은 기존 유효 세션 우선, 필요할 때 이 키체인 계정을 사용한다.
- [DL-17202](https://innovaid.atlassian.net/browse/DL-17202)는 사용자 승인으로 **해야 할 일→진행 중**으로 17:55 KST 변경하고 재조회 확인했다. 제목은 ‘[치과앱] 알림센터 연계 크레딧·청구서 목록 추가’. 설명·댓글·parent·다른 카드는 변경하지 않았다.

## 앱 실행 범위 확대·오류 보완 — 2026-11-03 17:50 KST

- 사용자가 이전 앱 크래시 이력을 들어 수정 화면뿐 아니라 공통 코드의 영향 화면을 실제 시뮬레이터·에뮬레이터에서 확인하도록 요청했다. 앞선 일부 화면·정적 검사만으로 앱 전체가 검증됐다고 표현하지 않는다. **화면이 열림, 데이터 조회 성공, 실제 본문, 체류 후 오류, 뒤로가기까지 구분**한다.
- Office/Lab 각 iOS·Android에서 현재 계정으로 열 수 있는 알림함·설정·목록·채팅·주문 상세·추가 조회 화면·프로필·도움말과 공통 소비자를 확인했다. 실제 DRAFT·피드백 상세가 있는 Office Android에서는 해당 화면도 조회·뒤로를 확인했다. 저장·주문 제출·승인·결제·메시지 전송은 하지 않았다. 새 알림 데이터는 여전히 DEV mock이다.
- 상세 화면/진입/실역할/데이터/결과/미검증은 [11/3 앱 런타임 검증 기록](../dentlink-unified-notification-center-runtime-2026-11-03.md)에 유지한다. 직접 navigator/onPress 호출, 실제 화면 탭, OS URL 진입과 실제 FCM 수신을 구분했다.

| 제품 | 이번 추가 수정 | 저장·검증 |
| --- | --- | --- |
| Office | Android raw chat/contact 딥링크의 700ms 대기가 재구독 때 사라지는 기존 경합. URL 문자열 orderId가 기존 숫자 전용 채팅 API에서 거절돼 메시지가 계속 로딩되는 문제 | `18033bc` + `8f09cb1`. 최종 양 OS cold restart 후 raw/push 및 기존 목록행의 숫자 ID·실제 query success·메시지 본문·10초 체류·뒤로 확인. 원격 `feature/DL-17059` HEAD 일치/clean |
| Lab | 같은 Android raw 링크 대기 경합. 밀링 딥링크의 최신 요청 callback을 소속 활성화까지 전달하지 않던 누락 | `3686fc0` + `be4512b`. 양 OS 최종 raw/push·채팅/주문 왕복·접근 가능한 밀링 화면 확인. 실제 SHARED 자동전환은 해당 소속/데이터 없어 미검증이며 비동기 하네스8/8로 별도 검증. 원격 `feature/DL-17060` HEAD 일치/clean |
| Web | 이번 앱 확대 점검에서 추가 코드 변경 없음 | `056056c92bb73dc75fc03e1bcd4a6b3389dc6bc3`·원격 feature 일치/clean 유지 |

- 자동 검사: 양 앱 raw 타이머 각9/9, Office 실제 parser→service ID12/12, Lab 밀링 guard8/8. 기존 Office71·Lab32 테스트 및 관련 ESLint 통과. 전체 tsc의 기존 오류 Office6건/Lab5건은 수정 전후 동일하고 변경 파일 신규 오류 없음. 제품 테스트 파일·불필요한 문서/스토리북은 추가하지 않았다.
- Lab HMR 직후 `getSnapshot of null` 개발 RedBox를 관찰했다. 해당 시도는 검증에서 제외했고 전체 재시작 후 최종 양 OS에서 미재현이었다. 훅 순서 보존 문제 가능성은 추정이며 원인 확정/운영 크래시 해결로 보고하지 않는다.
- Android WebView renderer code -1은 처음 크래시를 의심했지만 두 로그 모두 로딩 중 Back 직후였다. 주문 상세·결제수단·Help 재진입에서 실제 본문·40~58초 체류가 정상이며 활성 화면 크래시는 재현되지 않았다. 기존 WebView 복구/설정은 main과 같고 이 로그만으로 추가 패치를 만들지 않았다.

### 남은 실제 문제와 검증 조건

1. **Office 기존 Support 본문 조회:** 양 OS의 `/office/chat-messages`가 404이며 17:40 KST DEV Swagger에도 없다. 주문용 `/office/chat-messages/orders/{orderId}`는 Support 대체 계약이 아니다. BE가 지원 기능/현재 조회 경로를 확인해야 한다. 기존 로딩 종료 처리가 성공에만 연결된 상태도 기록했으며 임의 새 API/오류 UX를 추가하지 않았다.
2. **실데이터·역할 미검증:** Office iOS DRAFT/Feedback 상세 대상, PAYMENT_MANAGER/EDITOR/VIEWER, Lab SHARED/다중소속 및 유효 밀링 상세·공정·자재 데이터, 인증 해제/deferred·NoAccess 조건 등이 필요하다. 빈 화면·권한 차단·하네스를 정상 데이터 화면의 검증으로 대체하지 않는다. 실제 촬영·QR/HID/FCM은 별도 기기·실수신 조건이 필요하다.
3. **기존 남은 연결:** 신규 알림 BE 계약·목록/집계/설정 저장·읽음/푸시 identity 연결은 그대로 대기한다. 현재 모든 역할의 최종 QA 인계·merge 준비 완료가 아니다. 이메일 범위도 별도 대기한다.
4. **제한된 진입의 관찰:** Android Help 정상 Profile→root→board→article→Back은 정상이다. 직접 boardId로 시작한 테스트의 history 왕복은 일반 메뉴 경로 결함으로 확정하지 않고 직접 외부 진입의 후속 확인 여지로 남긴다. Lab 결제 Forbidden의 화면상 뒤로는 정상이며 OS Back만으로 팝업이 닫히는 기존 null 화면 관찰도 상세 기록에 남긴다.

### 로컬 종료와 개발 계정 저장

- 이번 audit의 Office8081/Lab8082 프로세스는 포트·cwd·PGID가 기록과 맞는 것을 확인하고 종료했다. Android `Dentlink_API_36` 종료, iPhone17Pro shutdown 및 DeviceHub 기기창 닫기 완료. 3000/3005/8081/8082/9233 listener 없음, adb 기기 없음, booted simulator 없음을 확인했다. 기존 앱 로그인/전용 브라우저 프로필은 보존했다.
- 사용자 순서에 따라 앱 점검 후 Mac 보안 입력창을 준비했다. Swift AppKit의 NSSecureTextField에서 입력받아 Security의 SecItemAdd/Update로 이 Mac 키체인에 저장한다. 프로그램 stdout/stderr는 폐기하며 비밀번호를 인수·파일·Git·로그·대화로 전달하지 않는다.
- 비밀 없는 실행 위치: `~/.local/share/codex-test-sessions/dentlink/development/secure-login-entry/secure-login-entry`. 창이 닫혀 있으면 이 실행 파일을 실행한다. 서비스는 Web Clinic/Web Lab/Office app/Lab app, 환경은 development로 한정한다.
- 키체인 service 참조는 `codex.dentlink.development.{web-clinic|web-lab|app-office|app-lab}`. 같은 디렉터리의 `keychain-references.json`은 서비스·계정 참조만 저장하고 비밀번호는 포함하지 않는다. directory0700·소스/참조/status0600·실행파일0700이다. 개인 일반 브라우저/기존 키체인 전체를 열람하지 않는다.
- 창 표시 직후 확인은 `ready`, 저장 계정0개였다. **입력창 준비와 실제 비밀번호 저장, 실제 로그인 성공은 다른 상태**다. 사용자가 입력 후 저장 완료를 알리면 status/참조와 필요한 서비스 로그인만 확인한다. 입력 중 화면/값을 캡처하거나 비밀번호를 출력하지 않는다. 공통 [Reusable Local Test Login](../../SESSION_WORKFLOW.md#reusable-local-test-login) 지침은 계속 적용한다.

## 최종 코드 검토·마감 — 2026-11-03 16:45 KST

- 사용자가 브라우저의 보안 경고가 사라지고 정상 자동화 표시만 보이며 시뮬레이터·에뮬레이터도 잘 보인다고 확인했다. 이어 오늘 정책·개발 방향을 포함한 마감 검토와 미완료 처리, 로컬 종료를 요청했다. **이 명시적 종료 지시가 앞선 화면/서버 유지 지시를 대체한다.**
- 오늘 확정 범위는 웹/앱 알림함·수신 설정, 노티/푸시 공통 랜딩·읽음 연결, Office 크레딧 잔액·이력/청구서 목록이다. 추가 목록은 기존 웹 모바일 디자인을 따르며 별도 메뉴 없이 노티/푸시 진입만 우선 허용한다. 이메일 CTA·설치 여부 연결·SES·분석은 별도 범위를 유지한다. BE 미정 API·식별자·enum을 새로 가정하지 않았다.
- 16:25의 기록/Git 대조 후 이번에는 실제 코드·공통 소비자·비동기 실행과 화면 가려짐까지 추가 검토했다. 그 결과 아래 5건을 발견하고 수정했다. 이는 새 기획 추가가 아니라 승인된 동작의 예외 상황 보완이다.

| 제품 | 최종 검토에서 수정한 문제 | 최종 검증 |
| --- | --- | --- |
| Web | 소속 A→B 이동 도중 A로 복귀한 뒤 일반 B 진입 시 과거 팝업/토스트가 되살아나는 문제. 모바일 토스트가 전체화면 알림 모달 뒤에 가려지는 문제. 기존 entry에 대상 소속 적용 여부를 보관하고 해당 Toast만 기존 modal-root Portal로 옮김 | 실제 React hook 재현은 수정 전 2건 실패→9/9 통과. Clinic/Lab PC1280·모바일390에서 정상 전환/팝업·토스트1개/실제 Toast 최상단 표시/소멸 후 잔여 overlay 없음/실패 시 소속 유지/재열림·넘침·pageerror 없음. 화면 검증은 headless+합성 API이며 실제 계정 mutation 아님. 기존 association8개·변경 lint·Clinic/Lab/Admin 타입검사·필수 push 훅 통과(기존 경고 유지) |
| Office | raw Linking 처리 중 FCM 중복 보강이 소속 활성화 전에 주문 GET/sideEffect를 실행하는 문제. 주문 조회 중 사용자가 바꾼 소속·계정을 오래된 랜딩이 되돌리는 문제. 중복 상태 조회 제거, 활성화 후 user/service/employer/employee/request guard를 두 진입점에 적용 | 실제 소스 harness11건·기존77 tests·변경 lint 통과. iOS/Android 최종 bundle에서 guard 존재 확인. OS URL로 Profile/Help/Credit·실제 주문 상세 확인, 실제 존재 주문 URL→landBy=push URL 연속 진입 정상. 이것은 실제 FCM 수신 증거가 아님. 인박스/설정은 렌더된 onPress를 CDP로 호출해 표시 확인, Android Back/iOS onPress로 Home 복귀 |
| Lab | 소속 활성화 뒤 USER 갱신 또는 쿠키 저장을 기다리는 동안 다른 소속으로 바뀌어도 이전 랜딩이 계속되는 문제. 각 await 이후 목표 소속·계정·service·요청을 재확인 | 실제 함수 비동기 harness 수정 전5건 실패→10/10 통과. 기존53 tests·변경 lint 통과. 양OS 최종 bundle 확인, 현소속 Profile/Help 정상·잘못된 소속 차단·알림함/설정 화면 확인. 일부 진입은 기존 onPress/CDP 호출이며 물리 탭 QA와 구분. 실제 다중소속 계정이 없어 경합은 harness 근거 |

- Office/Lab 기기 확인은 기존 로그인·원래 소속을 유지했고 OS 권한·수신 설정·계정 정보를 변경하지 않았다. Help/Credit/주문 조회는 실데이터 읽기, 알림함/설정은 DEV mock이다. 기존 밀링·채팅·action과 정상 토큰 갱신을 보존했다. 이번 수정은 TS/TSX뿐이며 새 native 빌드는 필요하지 않았다. 제품 테스트 파일을 추가/수정하지 않았다.
- 근거: Web `/tmp/notification-web-1103/{clinic,lab}-review-final.json` 및 `*-review-{1280,390}-{success,failure}.png`; `/tmp/notification-entry-review-1103.cjs`; Office `/tmp/office-review-1103.cjs`, `/tmp/office-1103-review-{ios,android}-{profile,help,credit,order,inbox,settings}.png`; Lab `/tmp/lab-1103-review-{ios,android}-{profile,help,inbox,settings}.png`. 임시 검증 파일과 인증 상태는 제품 커밋에 넣지 않았다.
- **마감 Git:** Web `056056c92bb73dc75fc03e1bcd4a6b3389dc6bc3`, Office `358b400375ae583d4cf9557126f5fbe3b803ad1b`, Lab `7ebc124fe01e4a46edc54b6e142ccae2e239709d`. 16:45 실제 ls-remote와 HEAD 일치 및 세 checkout clean 확인. 작업 branch는 그대로이며 PR·merge·배포·CodePush 없음.
- **실행 환경 종료:** 이번 전용 Chrome9233만 정상 종료하고 로그인 상태를 보존했다. Clinic3000/Lab3005/Metro8081·8082는 정확한 cwd/프로세스 그룹 확인 후 종료했다. `Dentlink_API_36` 종료, iPhone17Pro `Shutdown`과 DeviceHub 기기창 닫기를 확인했다. 3000/3005/8081/8082/9233 listener 없음, adb 연결 기기 없음, 해당 qemu 프로세스 없음. 일반 사용자 Chrome/IDE·앱 데이터·저장 프로필은 유지한다. 검토 중 수정 검증을 위해 잠깐 재기동한 환경까지 모두 종료했다.
- **개발 외 요청:** Notion/Jira의 원 조사·추가 앱 목록·이메일 범위 분리와 원 세션 인계는 앞선 기록대로 완료됐다. 이번 마감에 원문을 다시 수정하거나 Slack에 게시하지 않았다. 로컬 로그인 세션 보존·공통 지침 동기화·브라우저 경고 조치 완료, 디자이너 헤더 확인은 사용자가 공유 완료했다. 비밀번호를 새로 저장한 것은 아니다. 추가 미답변 요청은 발견하지 못했다.
- **다음 시작점:** 새 BE 목록/설정/집계·푸시 식별/읽음/클릭 명세 또는 추가 정책/디자인을 받은 뒤 필요한 변경분만 대조하고 연결한다. 실제 데이터로 대체된 mock을 제거하고 Lab 소속 목록·기존 OS 권한→구 preference 결합을 함께 정리한다. 미정 배너/메시지 hide 정책, 실제 iOS OS ON 복귀·전체 역할/로그인·실수신 FCM 검증은 남는다. 현재 단계는 FE 선행 작업 마감이며 최종 QA/merge 준비 완료가 아니다. 사용자 재요청까지 폴링·추가 구현 없이 대기한다.

## 로컬 환경 복구 이력 — 2026-11-03

아래는 최종 종료 전 복구 과정이다. 현재 실행 상태는 위 마감 기록을 따른다.

- 개발은 BE 목록/설정/집계·푸시 읽음/클릭 계약 또는 추가 기획·디자인 변경을 기다린다. 새 자료/재개 요청이 오면 변경분을 대조한다. 제품 코드를 추가 변경하거나 자동 외부 폴링·PR 작업을 하지 않는다. 세 제품은 위 완료 SHA와 원격 일치/clean 상태를 재확인했다.
- **브라우저 경고 조치:** 이전 테스트 Chrome의 --no-sandbox를 제거하고 기본 보안 샌드박스 상태로 재실행했다. Browser.getBrowserCommandLine에서 sandboxDisabled:false, automationEnabled:true를 확인했다. 자동화 제어 표시도 활성화했다. 앞선 ‘원인 확인만 완료/경고 미조치’ 기록을 이 결과가 대체한다.
- **다음 브라우저 재사용:** 먼저9233 listener를 확인해 살아 있으면 기존 CDP에 붙는다. 새 기동이 필요할 때는 위 영구 프로필을 사용하고 --no-sandbox를 추가하지 않는다. Playwright로 띄운다면 chromiumSandbox:true로 기본 샌드박스를 유지한다. 이전 임시 login.cjs의 기본 옵션을 그대로 재사용하지 않는다.
- **실행 수명 보완:** 점검 중 Web3000/3005·검증Chrome9233·Lab Metro8082의 종료를 발견했다. 담당 에이전트가 종료하지 않았음을 확인했고, 이전 exec 세션이 사라졌으며 로그에 종료 원인이 남지 않아 정확한 원인은 확정하지 않는다. 웹·Lab Metro는 분리된 프로세스 세션으로, Chrome은 macOS LaunchServices로 재기동했다. Office Metro8081은 살아 있어 재시작하지 않았다.
- **로그인 보존:** 종료된 전용 임시 브라우저 프로필을 값 열람 없이 Git 밖 `~/.local/share/codex-test-sessions/dentlink/development/browser-profile`로 복사해 재사용했다(0700). 이전 auth-state.json(0600)도 유지한다. 재로그인 없이 Clinic/Lab 모두 홈·알림함을 열었고, 준비된 서버에서 새로고침 후 pageerror0/알림 dialog1개씩 확인했다. 재시작 중 발생한 이전 devtools chunk 오류는 새로고침 후 재현되지 않았다.
- **창 표시 확인:** 두 창은 기존 위치·크기(외부 모니터의 동일 좌표에 최대화)를 복원했다. 하나씩 전면으로 가져와 실제 알림함을 확인했으며 마지막 Lab 페이지에서 visibility:visible, focused:true, dialogCount:1을 확인했다. 창 두 개 자체가 제품 오류 원인이라는 근거는 없다. 창이 겹치면 한쪽이 가려질 수 있으므로 ‘두 창에서 동시에 조작이 보인다’고 설명하지 않는다. 반복 headless 검증과 사용자 표시 창 조작을 계속 구분한다.
- **현재 런타임:** Clinic3000 PID39188, Lab3005 PID39187, Office Metro8081 PID21312, Lab Metro8082 PID39778, 전용Chrome9233 PID39157. exact cwd를 확인했고 실제 PID는 재개 때 다시 확인한다. 로컬 실행 메타/제한 로그는 같은 전용 디렉터리의 web-runtime.json/runtime-logs에 보관하며 인증 내용은 출력/커밋하지 않는다.
- 로그인 재사용 공통 지침과 ~/.codex 동기화는 완료다. 비밀번호를 새로 저장한 것은 아니다. 앱·웹 창과 서버를 유지하며 개발 대기로 돌아간다.

### 미완료 재점검과 Android 복구 — 2026-11-03 16:25 KST

- 사용자가 디자이너 공유 완료 후 원래 작업과 오늘 미완료 항목의 재점검을 요청했다. 현재 구현 기록·세 제품 Git을 대조했으며 새 BE 명세나 정책을 가정하지 않고 추가할 필수 구현 누락은 확인되지 않았다. 아래 14:05 표는 착수 전 조사 이력이므로 완료된 연결을 다시 미구현으로 취급하지 않는다.
- Android는 창만 가려진 것이 아니라 emulator 프로세스와 adb 기기가 없었다. 기존 `Dentlink_API_36`을 분리된 프로세스로 다시 실행했고 데이터 초기화·앱 재설치 없이 부팅 완료와 로그인 유지를 확인했다. 저장된 부팅 snapshot은 로드되지 않았지만 기존 앱 데이터는 유지됐다. 종료 원인은 확정하지 않는다.
- `emulator-5554`의 기존 Office Development 앱을 열고 Home→알림함을 확인했다. Metro8081에 해당 Android 앱이 연결됐고 iOS Lab은 Metro8082 연결을 유지했다. adb reverse8081/8082/9090을 복구했다. Android PID40590·창3623(2906,83 / 388×891)은 당시 확인값이며 다음 실행 시 다시 확인한다. 기존 기기 창을 전면 표시했고 다른 창의 배치는 변경하지 않았다.
- 실제 에뮬레이터 창 캡처 `/tmp/dentlink-android-window-restored-20261103.png`와 기기 화면을 확인했다. 이는 앱 실행·화면 복구 근거이며 mock 알림의 BE 저장 성공이나 새 전체 회귀 검증은 아니다. 실행 메타는 Git 밖 전용 로그인 디렉터리의 `android-runtime.json`(0600)에 기록했다.
- Clinic3000·Lab3005·Office Metro8081·Lab Metro8082·전용Chrome9233 listener와 제품 서버의 정확한 cwd를 재확인했다. 브라우저 샌드박스 조치·로그인 재사용 지침은 앞선 정리로 완료됐다. 비밀번호를 새로 저장하지 않았고 디자이너 별건을 제품 변경으로 확대하지 않았다.
- **다음 시작점:** 최신 BE 목록/수신 설정/집계·푸시 식별/읽음/클릭 계약을 받아 실제 연결과 대체 mock 제거를 진행한다. Lab 실제 소속 데이터, 기존 OS 권한과 구 preference 저장 결합, 배너/메시지 hide 미정 정책을 함께 확인한다. 실제 iOS OS ON 복귀·전체 역할/로그인·실수신 FCM 검증 제한은 유지한다. 이번 재점검에서 제품 코드는 추가 변경하지 않았으며 PR·배포·이메일 작업은 진행하지 않았다. 로컬 화면과 서버는 켜둔다.

## 별도 디자이너 문의: 앱 헤더 높이 — 2026-11-03

사용자가 현재 시뮬레이터의 알림 헤더와 다른 화면 높이를 질문했다. 제품 변경 없이 양 앱의 코드값을 확인하고 복사 가능한 공유문을 전달했다. **실제 렌더 픽셀 실측은 아니다.** 수치는 RN 논리 단위(iOS pt)이며 App.tsx의 상단 safe area는 별도다.

| 영역 | 높이 | 코드 근거 |
| --- | --- | --- |
| 양 앱 알림함 / 알림 설정 | 50 / 50 | Office NotificationInbox.tsx:45·NotificationSettings.tsx:43, Lab 동일 파일:80·:54 |
| 공통 뒤로가기 / Office Credits·Statements | 44 | configs/constants/constant.ts, components/app-ui/Layout/Header.tsx 기본값; 추가 목록은 override 없음 |
| 양 앱 채팅 상세 | 56 | features/chat/screens/ChatDetailScreen.tsx |
| Orders/Profile/LinkTalk 큰 제목 영역 | 54 | components/app-ui/Layout/Layout.tsx screenTitle |
| Lab 홈 소속 표시 | 64 | features/home/components/HomeProfileHeader.tsx |
| Lab 밀링 공정 / 자재 헤더 | 48 / 56 | MillingProcessHeader.tsx / MillingMaterialHeader.tsx |

모든 화면을50으로 바꾸라는 구현 지시는 아니며, 이 문의를 알림센터 추가 요구로 합치지 않는다.

## 이번 구현 승인과 기준 — 2026-11-03

- 사용자는 범위 점검 뒤 공통/이메일 코드 분리 → 알림센터 연결 보완 → 추가 앱 목록 → 실행 검증 → commit/push·메모리 정리 순서로 진행을 승인했다. PR·merge·배포는 제외한다.
- 추가 Office 크레딧 잔액·이력과 청구서 목록은 별도 Figma/디자인 발주를 기다리지 않는다. **현재 웹에 구현된 모바일 디자인을 기준으로 앱에 적용**하고 기존 구현의 부족한 부분을 보완한다. 결제내역·PDF·Pay Now·추가 메뉴까지 자동 확장하지 않는다.
- BE 미정 필드·푸시 식별 key·새 API를 임의 정의하지 않는다. 실제 소속 전환은 기존 API로 연결하며, 서버 알림/설정 데이터가 없는 부분은 개발 전용 mock 경계를 유지한다.
- 현재 웹·두 앱 모두 이 세션 내부에서 저장소별 단독 작성자를 배정했다. 다른 활성 기능 세션과의 중복 작성은 확인되지 않았다.
- 사용자 웹 테스트 로그인 완료. 이후 반복 로그인을 줄이기 위해 전용 로컬 프로필/기기 세션 보존과 필요 시 로컬 보안 저장소의 테스트 비밀번호 재사용을 공통 지침에 승인했다. [공통 로그인 재사용 규칙](../../SESSION_WORKFLOW.md#reusable-local-test-login). 비밀번호 자체를 제공받거나 새로 저장한 것은 아니다.
- 시뮬레이터 창은 이 Mac의 DeviceHub `devices://device/open?id=5C0E7639-2345-4B3F-9979-56AFDDA1C708`로 연다. `Simulator.app`은 없으며 iPhone17Pro/iOS26.5 기기창 표시를 확인했다.

## 이번 구현·검증 결과 — 2026-11-03

### 구현한 것

- **Web:** 실제 소속 목록/기존 활성화 API를 사용해 전환 성공 후 대상 홈→알림 팝업 한 번 열기·토스트까지 연결했다. 실패·계정 변경·늦은 응답은 이전 동작을 적용하지 않는다. Clinic 전환 직후 첫 소속으로 되돌아가는 캐시 경합, Lab PC/모바일 host가 팝업을 중복 여는 문제를 실행 중 발견해 수정했다. 랜딩은 기존 hook을 공유하고 제공된 URL만 사용한다.
- **Office:** 알림 소속 선택에 실제 소속/활성화 API를 연결했다. 성공 전 현재 소속을 바꾸지 않고, 성공 후 인박스를 유지한다. 일반 딥링크의 기존 setEmployerId 경로도 같은 활성화 완료를 기다린다. 명시적 대상 헤더·토큰 refresh·계정/소속 변경·후속 링크의 늦은 응답을 보호했다. 취소된 조회의 불필요한 Error 토스트는 제거하고 실제 오류는 유지했다.
- **Lab:** 공통 딥링크의 auth store 선변경/실패 rollback 대신 실제 소속 활성화 성공 후 이동한다. 기존 주문/채팅/Support/action·탭·밀링 소비자를 보존한다. Lab 소속 선택 UI는 미읽음/ID 계약 대기 mock이므로 실제 데이터 연결 완료로 보고하지 않는다.
- **두 앱:** 실제로 받은 landingUrl만 공통 처리에 전달한다. 상대 경로는 현재 서비스 origin과 기존 지원 경로 검증을 재사용하며 protocol-relative 외부 주소는 내부 경로로 변환하지 않는다. OS 설정으로 나간 뒤 정상 복귀하여 허용됐을 때 선택한 항목만 적용하고, 미허용·재시작·계정/소속 변경 등은 임시 선택을 폐기한다. 현재 적용 대상은 mock 설정이며 REST 저장 완료가 아니다.
- **추가 Office 목록:** 웹 모바일 실제 화면/코드와 대조해 Credits 이력의 유형 배지·긴 설명 표시를 보완했다. Credits/Statements 기존 REST 연결을 유지하고 사용자/병원 크레딧·필터·청구서 역할 제한을 실행 확인했다. PDF·Pay Now·결제내역·추가 메뉴는 새로 만들지 않았다.
- **이메일 분리:** 이메일 전용 OS 진입/association 설정만 제거했다. 공통 파싱/로그인 대기·기존 Airbridge·Lab /q/*·browser fallback은 보존했다. 자세한 복구/분리 경계는 아래와 이메일 정본에 있다.

### 최종 코드의 검증 근거

| 제품/환경 | 실제 확인한 경로·결과 | 범위/제약 |
| --- | --- | --- |
| Clinic Web | 저장 인증을 새 브라우저 context에 로드→실제 다른 병원 선택→활성화 성공→홈/팝업/토스트→원소속 복귀. PC1280·모바일390/320 넘침 없음·pageerror0 | 알림/설정 데이터는 mock. 실패·늦은 응답은 합성/단위 검증 |
| Lab Web | 실제 로그인→홈/알림/설정, PC1280·390/320 정상. 합성 API 성공/실패 전환과 모바일 시작 전환에서 dialog1개·토스트 확인 | 실제 테스트 계정 다른 소속0개. 실서버 다중 소속 성공은 미검증. 자동화 context에서만 개발도구/QA 위젯 overlay 숨김 |
| Office iOS | 새 native Debug 빌드. Home→인박스→실제 소속 전환 후 인박스 유지·설정·전체읽음·Home 다른소속 점, 원소속 복귀. User/Office Credits·필터·OWNER Statements 조회, MEMBER 접근 차단/Home 복귀. 임시 상대 landing 클릭→해당 소속 Credits, 기존 Support/Feedback | 실제 OS ON 변경 후 복귀는 iOS에서 미검증. iOS 설정 링크가 Settings 홈을 열어 환경 제약 기록 |
| Office Android | 새 native Debug 빌드·기존 로그인 유지. Credits/Statements·인박스/설정. OS OFF 유지→Back은 기존 선택 유지, 선택 항목→OS ON→Back은 해당 PUSH만 ON | 해당 계정 소속1개. OS OFF 변경으로 프로세스 재시작됨을 관찰; 임시 선택 폐기 경계 유지 |
| Lab Android | 새 Debug 빌드. Home/인박스/설정·상대 /help 클릭. 실제 OS 스위치 ON→Back→선택 항목만 ON/다른 항목 OFF·정상 설정 화면 | am start 강제 task 복귀에서 흰 화면 관찰, 실제 사용자 Back 복귀에서는 재현 안 됨. 흰 화면 캡처는 성공 근거 제외 |
| Lab iOS | 기존 로그인 유지·8082 최종 JS로 Home→인박스→설정. OS 미허용 복귀 값 유지/정상 화면. 같은 소속 Profile, 잘못된 소속 차단, 기존 /q/o/ 주문 상세 | 안내 확인 callback은 한글 자동화 selector 한계로 디버거 호출 보완. iOS OS ON 실제 변경은 미검증. 다중소속 성공은 harness 검증 |

- **자동 검사:** Web Clinic/Lab/Admin 타입검사·전체 lint 필수 훅 통과(기존 경고만), Lab association8개·임시 랜딩/헤더6개. Office 관련8 suites/123개·변경 ESLint 오류0, 전체 타입검사 기존6진단/변경 소스 신규 오류 없음. Lab 기존32개+임시 harness31건·변경 ESLint 오류0; 전체 타입검사는 기존4파일5진단 동일. 단위/합성 결과를 실제 서버/기기 성공과 구분한다.
- OS 검증 때 기존 PermissionProvider가 보내려는 구 preference 저장 요청은 임시 런타임 interceptor로 차단해 실계정 수신값을 바꾸지 않았다. 이후 interceptor/fixture를 제거하고 OS 원상태·원소속·mock 상태를 복원했다. 임시 검증 코드는 제품 커밋에 없다.
- 근거: `/tmp/notification-web-1103/`의 final/synthetic/mobile-switch 로그·스크린샷, `/tmp/office1103-native-notifications.log`, `/tmp/office1103-android-grant.log`, `/tmp/lab-1103-os-back-final.png`, `/tmp/lab-1103-ios-denied-return.png`. 실제 푸시 수신→BE 읽음/클릭 저장, 전체 역할과 로그아웃/재로그인 전체 흐름까지 완료한 것은 아니다. **현재는 최종 사용자 QA/merge 준비 완료 선언이 아니다.**

### 로컬 화면·로그인 재사용

- 사용자 배치대로 Clinic3000·Lab3005는 서로 다른 Chrome for Testing 창이다. CDP9233에서 별도 windowId를 확인했고 창 크기/위치는 바꾸지 않았다. 반복 검증 일부는 별도 headless였으며, 사용자가 진행을 볼 수 있도록 요청한 뒤 root가 기존 Lab 창에서 알림함→알림 설정을 실제 조작해 열어두었다. headless 실행을 사용자 창 조작으로 보고하지 않는다. 사용자는 이후에도 Lab 조작이 보이지 않는다고 회신했다. CDP의 페이지 전환은 확인했지만 사용자 디스플레이에서의 가시성까지 확인한 것으로 기록하지 않는다. 후속 작업에서는 사용자가 보고 있는 실제 창과 조작 대상을 먼저 대조한다.
- 초기에는 샌드박스 경고 원인만 확인해 창을 유지했다. 이후 사용자가 로컬 환경 정리를 승인해 위 최신 절처럼 해당 옵션을 제거하고 전용 프로필로 재기동했다. 웹 지연 당시 Next 재컴파일 부하와 브라우저 경고를 구분한다.
- 웹 인증 상태는 Git 밖 `/Users/parkjongsun/.local/share/codex-test-sessions/dentlink/development/web-auth-state.json`에 저장했고 새 context에서 양제품 로그인 재사용을 검증했다. 폴더0700/파일0600. 현재 열린 임시 browser profile을 사용자 확인 중 이동/종료하지 않았다.
- 공통 AGENTS/SESSION_WORKFLOW에 전용 로컬 로그인 재사용과 필요 시 로컬 보안 저장소의 테스트 비밀번호 사용 기준을 추가했다. **이번에는 로그인 상태를 저장했으며 비밀번호를 새로 제공받거나 저장한 것은 아니다.**
- Clinic3000/Lab3005, Office Metro8081/Lab8082, Android emulator-5554, iPhone17Pro DeviceHub를 유지한다. 두 앱을 각각 양 OS에서 확인했으며 마지막 표시 제품은 Android Office, iOS Lab이다. 세션 정리 요청만으로 화면/서버를 종료하지 않는다.

## 현재 범위와 완료 경계

- **이번 기능:** Clinic/Lab 웹 알림함·수신 설정, Office/Lab 앱 알림함·수신 설정, 인박스 알림(NOTIFICATION) 클릭 및 앱 푸시(PUSH) 클릭의 랜딩·딥링크·REST 읽음 연결, 합의된 추가 앱 조회 목록이다.
- **추가 조회 목록:** Office 크레딧 잔액·이력과 청구서 목록(DL-17202). 결제내역·PDF·Pay Now 등 미확정 후보를 자동 포함하지 않는다.
- **사용자 확정:** 추가 목록은 노티·푸시 외 별도 메뉴가 없어도 수용한다. 메뉴 개선은 후속이며 현재 작업의 선행 조건이 아니다. 이미 목록이 생겼다는 이유로 시트의 ‘알림센터 오픈’이나 이동 없음 정책까지 임의 변경하지 않는다.
- **이메일은 완전히 별도:** 이메일 CTA·앱 설치 여부에 따른 웹/앱 연결·웹 fallback·SES·이메일 분석/클릭 추적은 이 기능의 검토·구현·검증·완료 조건에 포함하지 않는다. [별도 이메일 체크포인트](../dentlink-email-cta-tracking.md)와 DL-17183→DL-17187에서 관리한다.
- 기존 알림 설정의 **Email 수신 채널 표시·저장**은 이메일 CTA/추적과 다른 기능이다. 이번 분리를 승인된 수신 설정 UI 삭제 근거로 확대하지 않는다.
- **현재 구현:** 실제 진입점의 알림 UI, 추가 Office 목록의 기존 REST 조회, Web/Office 실제 소속 선택·활성화, 양 앱 공통 딥링크의 소속 활성화와 OS 정상 복귀 연결까지 보완했다. 알림 목록·읽음·수신 설정·소속별 미읽음 집계는 아직 개발용 mock/계약 대기이며, Lab 소속 선택 UI도 mock이다. PR·merge·배포·최종 QA 완료가 아니다.

## 코드 범위 점검 결과 — 2026-11-03 14:05 KST

**착수 전 조사 이력이다.** 아래 표의 미구현 상태와 다음 순서는 당시 기준이며, 이후 구현 결과는 문서 상단과 현재 작업 위치 절을 우선한다.

### 확인 범위와 Git

- 기존 선행 변경의 실제 diff·소비자를 세 제품에서 병렬로 읽었다. 각 checkout의 branch/HEAD/upstream/dirty/worktree를 확인하고 feature `pull --ff-only`는 변경 없이 끝났다. 필요한 stable ref를 fetch했으며 merge/rebase/branch 전환은 하지 않았다. 당시 Web6dca5142b·Officee983956·Labc312011은 clean/원격 일치였다. 이후 구현한 현재 HEAD는 아래 작업 위치 표를 따른다.
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

아래는 코드 범위 점검 전 마감 이력이다. 현재 다음 시작점은 문서 상단의 최신 구현 결과와 남은 일 절을 따른다.

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

2026-11-03 이번 구현을 각 제품 feature에 commit/push했다. root가 실제 `git ls-remote`와 로컬 HEAD 일치를 다시 확인했으며 세 checkout은 clean이다. PR·merge·배포·CodePush는 수행하지 않았다.

| 제품 | checkout | branch | 최종 HEAD |
| --- | --- | --- | --- |
| Web | `/Users/parkjongsun/Repository/dentlink-client-notification-center` | `feature/DL-17058` | `056056c92bb73dc75fc03e1bcd4a6b3389dc6bc3` |
| Office | `/Users/parkjongsun/Repository/dentlink-app` | `feature/DL-17059` | `8f09cb1eff03f10c96a6cca52aacaf09751112c7` |
| Lab | `/Users/parkjongsun/Repository/dentlink-lab-app` | `feature/DL-17060` | `be4512bb8def094e867fbe0753b018858de9a097` |

- Web `5cde12f8f` 이메일 설정 분리, `eceb6bbe1` 알림 연결·소속 전환. Office `b78947f` native 분리, `35425f2` 공통 연결·OS 복귀, `c85865d` Credits 표시. Lab `04cfe7f` native 분리, `d8f7fc6` 공통 연결·OS 복귀.
- 최종 검토 보완: Web `056056c92` 전환 취소/모바일 토스트, Office `358b400` 중복 푸시/준비된 소속 경합, Lab `7ebc124` 활성화 후 최종 소속 확인. 앞선 런타임 증거에 더해 상단의 최종 수정본 검증을 수행했다.
- 새 branch/worktree·새 PR은 만들지 않았다. 최신 Web master의14개 변경을 대조했고 현재 작업과 관련한 필수 충돌을 발견하지 않아 전체 merge/rebase는 하지 않았다. 원격 feature 일치와 최신 master 반영은 다른 상태다.
- 새 알림 화면은 Web development/앱 __DEV__ 제한과 mock 경계를 유지한다. 사용자가 보는 로컬 화면 구현과 운영 배포/서버 저장 완료를 구분한다. Storybook·제품 저장소의 개인 인계 파일은 추가하지 않았다.
- 실행 근거와 제한은 상단 표를 따른다. 이후 동작 변경이 생기면 영향 사례를 최종 코드로 다시 검증한다.

### 문서 분리와 코드 분리

- 11/3 승인 구현에서 Web 이메일 association 16파일은 `6dca5142b` 직전 내용으로 복원했다. 기존 Lab `/q/*` handler·assetlinks·Airbridge는 유지한다. 원 커밋은 이력에 남으며 전체 feature revert나 이력 재작성은 하지 않았다.
- Office portal HTTPS native 등록과 Lab q외 HTTPS 신규 등록만 분리했다. 앱에 이미 전달된 URL 해석·로그인 pending·최신 링크 보호·지원 업무 화면 전환은 노티/푸시에서도 사용하므로 유지했다.
- Android browser module/fallback은 미지원 URL과 기존 소비자가 사용해 보존했다. URL이 HTTPS라는 이유만으로 이메일 전용으로 분류하지 않는다.
- 이메일 작업은 별도 재개 지시 전까지 대기한다. native 도메인 제거를 검증하기 위한 로컬 빌드는 알림센터 범위 분리 검증이며 이메일 구현 재개가 아니다.

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

1. 최신 BE 공유본/Swagger에서 알림 목록·소속별 집계, Employee별 수신 catalog·default·migration, 푸시 식별·클릭/읽음 계약의 변경분을 확인한다. 미정 payload·enum이나 알림 외부 경로를 발명하지 않는다.
2. 실제 목록/설정/읽음/미읽음 데이터를 현재 controller에 연결하고 대체된 mock·개발 분기를 정확히 제거한다. Lab 선택 UI도 실제 소속·미읽음 데이터와 연결한다.
3. 기존 PermissionProvider의 OS 허용→구 preference upsert, Office My Orders의 pushEnable 결합을 새 저장 계약에 맞춰 정리한다. 이번 정상 복귀 callback 보완만으로 OS/서버 분리가 끝난 것은 아니다.
4. 새 푸시 identity로 중복 callback·같은 화면의 서로 다른 알림을 구분하고 올바른 계정/소속에서 읽음·클릭을 요청한다. 현재 실제 FCM 발송부터 REST 완료까지 끝난 상태가 아니다.
5. 최종 코드/실데이터로 전체 역할·권한·iOS/Android 영향 화면을 다시 검증한 뒤 사용자 QA·PR·release를 별도 진행한다. 현재 PR 생성 권한은 없다.

설정 화면 새 파란 배너의 영속 노출 주기와 Lab Home 최근 메시지/Support·자동 메시지 hide 범위는 후속 근거를 확인한다. 기존 전역 OS OFF 1회 팝업과 새 설정 배너를 혼용하지 않는다. 실제 구현 시 문서/코드로 먼저 해결하고 남는 결정만 사용자에게 질문한다. 추가 목록의 별도 메뉴와 이메일 자동 앱 실행을 알림센터의 선행 조건으로 추가하지 않는다.

## 정본 자료·Jira·이력

- 정책: [Notion PRD](https://app.notion.com/p/innovaid/3c7ce072e82f811184a8e647444f01fd). 화면: [Figma](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=2-6). 원 기획: [FigJam](https://www.figma.com/board/U9Qpm6ACzjGFKyrCoaAuvA?node-id=33-3714).
- 결정 근거: [UX 논의](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793063024060739), [푸시 클릭/읽음](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793244658608799), [앱 추가 목록 회의](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793596568281269). 최신 명시적 사용자 정정과 날짜 있는 후속 결정을 오래된 문장보다 우선한다.
- 알림센터 상위 [DL-16140](https://innovaid.atlassian.net/browse/DL-16140). 공통 DL-17057, Web DL-17058/17061/17062, Office DL-17059/17063/17064/17065, Lab DL-17060/17066/17067/17068, UX 사전 검토 DL-17048. 실제 카드 상태·범위는 재개 시 확인하며 카드명만으로 제외 범위를 복원하지 않는다.
- 추가 목록: DL-17174→DL-17202, 후보 검토 DL-17179. 원본 앱 비교 세션 역할은 [모바일웹/앱 차이 체크포인트](../dentlink-mobile-web-app-parity.md)를 참조한다.
- 마지막 DEV Swagger 조사: **11/3 14:01 KST**. 기존 목록·부분/전체읽음·미읽음·구 preference 계약을 재확인했다. 정확한 공개 명세의 범위/미확인 사항은 상단 결과를 따른다.
- 과거 FE API 제안서는 확정 BE 계약이 아니다. 상세 조사·UX 합의·소스/기기 증거·공수 산정·이전 정확한 Git 이력은 [2026-11-03 분리 전 전체 이력](dentlink-unified-notification-center-through-2026-11-03.md)에 보존했다. 과거 ‘현재/다음’ 지시는 최신 범위를 되돌리지 않는다.

## 운영 경계

- 이 세션은 통합알림센터 기능을 Web/Office/Lab 함께 담당하며 [FE 상위 세션](../dentlink-fe.md)은 공통 조율을 담당한다. 새 세션·worktree를 자동 생성하지 않는다.
- 제품마다 정확한 저장소·활성 작성자를 확인한다. Web 신규 일반 작업은 최신 origin/master, 두 앱은 origin/main 기반 feature/<Jira>→해당 release→main이다. 남은 develop을 신규 기준으로 쓰지 않는다.
- 11/3 사용자가 이번 FE 선행 범위의 구현·검증·세 제품 commit/push를 승인했다. PR 생성·merge·배포는 승인 범위가 아니다. 다음 미정 정책/새 기능을 자동 확장하지 않는다.
- Slack은 읽기 전용이며 자동 폴링은 중단 상태를 유지한다. 팀 공유 문서와 개인 작업 메모를 구분하고 의미 있는 마감에 개인 컨텍스트를 commit/push한다. 제품 commit/push는 해당 작업의 명시적 승인을 따른다.
