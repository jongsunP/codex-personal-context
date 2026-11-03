# Dentlink 통합알림센터 — 현재 체크포인트

최종 갱신: 2026-11-03 19:19 KST — 사용자가 승인한 잔여 1번, **Office/Lab 설정 파란 OS 배너의 기기별 1회 영속 처리**를 보완하고 영향 화면 검증·양 앱 commit/push를 완료했다. 세 feature 원격일치/clean, 로컬 실행 종료. 신규 알림 BE 연결·일부 실제 역할/데이터/OS 조건 검증은 남는다. PR·merge·배포·최종 QA 완료가 아니다.

- **현재 지시:** “2번은 혼자 할 수 없으니 1번까지 마무리하고 기다리자”에 따라 배너 보완을 끝냈다. BE 명세 또는 사용자 재개 요청을 기다리며 자동 구현·폴링·서버 재실행을 하지 않는다.
- **상태 읽는 순서:** 이 문서의 최신 상태 → [앱 화면별 실행 근거](dentlink-unified-notification-center-runtime-2026-11-03.md) → 필요할 때 [11/3 단계별 구현·검증 이력](archive/dentlink-unified-notification-center-2026-11-03-worklog.md). 과거 HEAD/입력 대기/서버 유지 문구를 현재로 재사용하지 않는다.
- **기획 근거:** Notion 정책서와 확인한 Figma/Slack을 대조하되 최신 명시적 사용자 정정을 우선한다. 오늘 필요한 PRD 5-2~5-5/#14는 재대조했고 일부 조회 누락 블록이 있어 전체 본문·댓글을 완전 최신 조회했다고 주장하지 않는다. 이번 마감은 외부 자료 전수 재조사가 아니다.

## 오늘 요구와 최종 상태

| 요구 | 오늘 처리와 현재 상태 |
| --- | --- |
| 알림센터·앱 추가 목록·이메일 범위 분리 | Notion/Jira/개인 정본 분리와 원 조사 세션 인계 완료. 승인 후 코드에서도 이메일 전용 native/association 설정만 분리했고 노티/푸시의 공통 URL 처리·기존 Airbridge/Lab `/q/*`는 유지 |
| FE가 할 수 있는 디자인·연결 선행 작업 | 기존 알림 UI를 유지·보완하고 Web/Office 실제 소속 활성화·Web 팝업/토스트·공통 랜딩 연결을 보완. 실제 알림 데이터/설정 저장/집계/읽음은 DEV mock 및 BE 계약 대기 |
| 추가 Office 조회 목록을 웹 모바일 기준으로 구현 | Credits/Statements 및 기존 REST는 이전 선행 구현. 오늘 크레딧 배지·긴 설명·소속/권한/진입·뒤로를 보완/검증. 별도 메뉴·PDF·Pay Now·미확정 결제내역을 추가하지 않음 |
| 권한·제품·기기별 알림 설정 메뉴 | MEMBER 범위 선택 숨김·담당 범위 고정, OWNER/PAYMENT_MANAGER만 Payments, Web Clinic Shipping 추가. Lab My Orders/Email/SMS 제외·Web Push 미노출 유지. Lab 밀링 Payments는 PRD #14 Resolved와 Figma 근거로 유지 확정 |
| 공통 딥링크·소속 변경 예외 | 실제 활성화 완료 후 이동, 계정/소속 변경·늦은 응답·중복 푸시 callback·Android 구독 타이머·채팅 ID 변환 문제를 보완. 수정 내역은 제품 commit과 실행 기록에 보존 |
| 앱 영향 화면 크래시 점검 | 양 앱 iOS/Android에서 현재 실계정으로 접근 가능한 공통 소비자까지 확대 점검. 발견한 동작 오류 수정 후 영향 화면 재검증. HMR/종료 중 renderer 관찰을 운영 크래시 해결로 합치지 않음 |
| 브라우저 경고·Lab 화면 조작·창 유지 | `--no-sandbox` 제거 및 정상 자동화 표시 확인. 두 제품 실제 표시 창에서도 검증. 별도 headless 검사와 표시 창 조작을 구분하며 창 겹침/가시성을 기능 성공 근거로 삼지 않음 |
| 시뮬레이터·에뮬레이터 복구·서비스별 확인 | 기존 로그인·데이터를 보존해 복구하고 Office/Lab 각각 양 OS 점검. 마지막 종료 지시가 이전 화면 유지 지시를 대체하여 현재 종료 |
| 디자이너 헤더 높이 질문 | 코드값 확인·공유문 전달, 사용자 공유 완료. 알림함/설정50, 공통44, 채팅56 등이며 모든 화면을50으로 변경하지 않음. 실제 물리 픽셀 실측 아님 |
| 로그인·비밀번호 저장 및 이후 재사용 | Mac Keychain에 네 제품 개발 계정 저장, 모두 실제 DEV 로그인/own profile 검증 성공. 전용 profile 및 새 독립 browser context에서 양 웹 로그인 재사용 성공. 공통 재사용 지침 반영, 비밀번호 자체는 Git/로그에 없음 |
| DL-17202 상태 | 17:55 KST 해야 할 일→진행 중 변경·재조회 완료. 설명/댓글/parent/다른 카드 변경 없음. 완료/최종 QA로 전환하지 않음 |
| commit/push·메모리·로컬 마감 | 세 제품 원격 HEAD 일치/clean 확인. 개인 체크포인트와 실행 결과를 원격 보존. 이 작업의 서버/전용 브라우저/기기는 종료, 로그인·앱 데이터 보존 |
| 설정 파란 OS 배너 1회 | 18:46 누락 확인 후 사용자 승인으로 양 앱 보완·push 완료. 실제 표시 후 별도 기기 이력 저장, 현재 표시 유지·닫기/재진입/재시작 시 숨김. 전역 팝업과 별도이며 서버 수신 설정은 바꾸지 않음. 양 OS 실행 및 iOS 권한 전환 제한은 아래 구분 |

## 제품 작업 위치와 Git

2026-11-03 19:19 KST 실제 Git/원격 대조: 세 checkout 모두 dirty·미추적 없음, upstream ahead/behind0·0, `ls-remote` SHA=HEAD. 기존 checkout/branch/worktree를 유지하고 양 앱 배너 관련 파일만 추가 수정했다. 작성 담당들은 검증 완료·제어권 반환 상태다.

| 제품 | checkout | branch / upstream | 원격 반영 HEAD |
| --- | --- | --- | --- |
| Web | `/Users/parkjongsun/Repository/dentlink-client-notification-center` | `feature/DL-17058` / `origin/feature/DL-17058` | `d11fb875940f76a0254ffc14514fd2b7ae654c28` |
| Office | `/Users/parkjongsun/Repository/dentlink-app` | `feature/DL-17059` / `origin/feature/DL-17059` | `b57bfbe8568c0ee8cf2062ab6e430fbf0a369948` |
| Lab | `/Users/parkjongsun/Repository/dentlink-lab-app` | `feature/DL-17060` / `origin/feature/DL-17060` | `1fbcacc27eff258c95b916473f70be4c76bd7ac0` |

- Web 오늘 주요 단위: `5cde12f8f` 이메일 설정 분리 → `eceb6bbe1` 실제 소속 연결 → `056056c92` 전환 취소/모바일 토스트 → `d11fb8759` 권한/Shipping.
- Office: `b78947f` native 분리 → `35425f2` 공통 연결/OS 복귀 → `c85865d` Credits 표시 → `358b400` 중복/소속 경합 → `18033bc` raw 링크 타이머 → `8f09cb1` 채팅 ID → `6bf1c58` 설정 권한 → `b57bfbe` 설정 배너 1회.
- Lab: `04cfe7f` native 분리 → `d8f7fc6` 공통 연결/OS 복귀 → `7ebc124` 활성화 후 소속 확인 → `3686fc0` raw 링크 타이머 → `be4512b` 밀링 취소 요청 보호 → `1fbcacc` 설정 배너 1회.
- 원격 feature 일치는 최신 master/main 전체 반영이나 release 포함을 뜻하지 않는다. 재개 시 필요한 base 변경을 fetch·대조한다. 이번에 merge/rebase/PR/CodePush/배포는 하지 않았다.

## 실제 검증 범위와 한계

- Web Clinic/Lab 실제 OWNER PC1280·모바일390 설정/Back/닫기, Clinic Shipping 토글, Lab 기존 구성 유지 확인. 실제 Clinic 다른 소속 전환은 이전 오늘 실행으로 확인했고, 실패/경합 및 Lab 다중 소속은 별도 합성 검사로 구분한다. 현재 웹 계정에 MEMBER 소속이 없어 실제 MEMBER 검증은 못 했다.
- Office/Lab 확대 실행은 `8f09cb1`/`be4512b`에서 수행했다. 이후 Office `6bf1c58` 설정 변경은 Android 실제 OWNER, iOS MEMBER→OWNER→MEMBER 전환과 오래된 callback 거부를 **해당 영향 화면에서** 재검증했다. 모든 화면을 마지막 SHA에서 다시 전수 실행했다고 확대하지 않는다.
- 마지막 배너 변경 `b57bfbe`/`1fbcacc`는 양 앱 Android 실제 OS ON→OFF→ON과 첫 표시·닫기·재진입·cold restart를 통과했다. Lab iOS는 실제 OS OFF에서 첫 표시·닫기·재진입·cold restart와 mock 표시소속 변경을 확인했다. Office iOS는 실제 OS ON 미노출·이력 미기록을 확인했고, OFF는 native 권한 조회 응답만 임시 대체해 화면·영속·실제 MEMBER→OWNER→MEMBER를 확인했다. **iOS 실제 OS 토글 성공, 실제 로그아웃/계정 변경/재설치, Lab 실제 다중소속 검증으로 확대하지 않는다.** 변경 파일 lint 오류0·실제 컴포넌트 하네스 Office10/Lab11 통과, 독립 코드 검토 추가 결함 없음.
- 기존 Web 타입/lint/필수 push 검사·공통 테스트와 관련 임시 실제 소스 하네스, Office/Lab 기존 tests·관련 ESLint 통과. 앱 전체 tsc의 기존 Office6진단/Lab5진단은 남고 변경 파일 신규 진단은 없었다. 테스트 수치는 수행 차수마다 범위가 달라 임의 합산하지 않는다. 상세는 실행 문서/당일 이력을 따른다.
- 실제로 받은 URL을 OS로 여는 검증과 실제 FCM 수신→REST 저장은 다르다. iOS 실제 OS ON 복귀, 일부 실제 역할·로그인/deferred·Lab 다중소속/SHARED·유효 밀링 상세 및 실물 QR/HID/촬영은 남는다. 미검증을 사용자 QA에 넘겨 완료 처리하지 않는다.
- 기존 **Office Support `/office/chat-messages` 404**는 양 OS 실제 조회와17:40 DEV Swagger에서 확인했다. 주문용 endpoint는 대체 계약이 아니다. 현재 지원/대체 조회 경로를 BE에 확인해야 하며 이번 알림 변경에서 임의 새 API/오류 UX를 만들지 않았다.

## 로컬 환경·개발 계정 마감

- 18:46 종료 후 배너 검증에만 Office8081/Lab8082·Android AVD·iPhone17Pro를 잠시 재실행했다. **19:19 KST 다시 종료:** 3000/3005/8081/8082/9233 listener 없음, Android adb 기기 없음, booted simulator 없음, 해당 iPhone 창 닫힘을 확인했다. 각 기기 원래 소속/Home·OS 권한·테스트 함수/인터셉터를 복원하고 로그인·앱 데이터는 유지했다. Web 서버/브라우저는 재실행하지 않았으며 일반 Chrome·IDE·다른 세션은 건드리지 않았다.
- 로그인 참조는 Git 밖 `~/.local/share/codex-test-sessions/dentlink/development/`. `browser-profile`0700, `web-auth-state.json`0600이며 새 독립 context 재사용까지 검증했다. 기기 앱 데이터·로그인은 보존했다.
- Keychain service는 `codex.dentlink.development.{web-clinic|web-lab|app-office|app-lab}`. `secure-login-entry/keychain-references.json`에는 비밀 없는 참조만, `credential-validation.json`에는 검증 결과만 보관한다. 네 계정 모두 실제 DEV login·own profile HTTP200/정상코드/서비스·계정 일치 검증 완료이며 보안 입력창은 closed다.
- 계정 추가/변경이 필요할 때의 로컬 보안 입력창은 위 전용 디렉터리의 `secure-login-entry/secure-login-entry` 실행 파일이다. 비밀번호를 채팅으로 받지 않고 사용자 직접 보안 입력을 사용한다.
- 재사용은 유효 profile/기기 세션 우선, 필요할 때 키체인. 저장 경로/지침은 [Reusable Local Test Login](../SESSION_WORKFLOW.md#reusable-local-test-login)을 따르며 비밀번호·토큰·실제 계정 응답을 Git/로그/대화에 옮기지 않는다. 이 Mac의 보관 성공이 다른 컴퓨터로 비밀번호가 동기화됐다는 뜻은 아니다.

## 문서·카드와 인계

- Notion은 같은 Development Documents 위치에서 원 조사 대문·앱 추가 단일 문서·이메일 대문으로 분리했다. 사용자 최종 확인 완료. 본문/의견/기존 공유 링크를 보존했고 불필요한 앱 추가 중간 대문은 제거했다.
- 원 조사: [모바일 웹 대비 앱 미지원 기능 현황](https://app.notion.com/p/innovaid/3fece072e82f80d5a02fda9a76cd51b7). 앱 추가: [앱 지원 추가 항목 검토·구현](https://app.notion.com/p/innovaid/40cce072e82f81439d7bc253192e966b). 이메일: [이메일 CTA 대문](https://app.notion.com/p/innovaid/40dce072e82f819ca557c474effabaea), 하위 범위/FE·BE비교/SES조사3개.
- DL-17174→DL-17202는 Office 추가 목록 구현(진행 중), DL-17179는 후보 검토 이력, DL-17183→DL-17187은 별도 이메일. 카드 분리/본문은 앞선 승인 작업으로 정리했고 마지막 상태 변경은 DL-17202만 수행했다. 이번 마감에 Notion/Jira/Slack을 다시 수정하지 않았다.
- 원 앱 미지원 조사 세션(`01a17657-caad-70f1-9a40-dbde874a3d42`)에 범위·문서 위치·이메일 분리·메뉴 후속 기준을 인계했고 수신/idle을 확인했다. 이번 배너 보완은 기존 알림 설정 범위라 새 카드/페이지·원 조사 세션 재개가 필요 없다. 사용자의 Jira/Notion 추가 정리 질문에도 현재 구조·범위 정리가 완료됐다고 답했고, 이번 구현 결과는 개인 체크포인트에 기록한다.

## 현재 범위와 완료 경계

- **이번 기능:** Clinic/Lab 웹 알림함·수신 설정, Office/Lab 앱 알림함·수신 설정, 인박스 알림(NOTIFICATION) 클릭 및 앱 푸시(PUSH) 클릭의 랜딩·딥링크·REST 읽음 연결, 합의된 추가 앱 조회 목록이다.
- **추가 조회 목록:** Office 크레딧 잔액·이력과 청구서 목록(DL-17202). 결제내역·PDF·Pay Now 등 미확정 후보를 자동 포함하지 않는다.
- **사용자 확정:** 추가 목록은 노티·푸시 외 별도 메뉴가 없어도 수용한다. 메뉴 개선은 후속이며 현재 작업의 선행 조건이 아니다. 이미 목록이 생겼다는 이유로 시트의 ‘알림센터 오픈’이나 이동 없음 정책까지 임의 변경하지 않는다.
- **이메일은 완전히 별도:** 이메일 CTA·앱 설치 여부에 따른 웹/앱 연결·웹 fallback·SES·이메일 분석/클릭 추적은 이 기능의 검토·구현·검증·완료 조건에 포함하지 않는다. [별도 이메일 체크포인트](dentlink-email-cta-tracking.md)와 DL-17183→DL-17187에서 관리한다.
- 기존 알림 설정의 **Email 수신 채널 표시·저장**은 이메일 CTA/추적과 다른 기능이다. 이번 분리를 승인된 수신 설정 UI 삭제 근거로 확대하지 않는다.
- **현재 구현:** 실제 진입점의 알림 UI, 추가 Office 목록의 기존 REST 조회, Web/Office 실제 소속 선택·활성화, 양 앱 공통 딥링크의 소속 활성화와 OS 정상 복귀 연결까지 보완했다. 알림 목록·읽음·수신 설정·소속별 미읽음 집계는 아직 개발용 mock/계약 대기이며, Lab 소속 선택 UI도 mock이다. PR·merge·배포·최종 QA 완료가 아니다.

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
- Office 정책상의 Admin은 `OWNER`, Billing Manager는 `PAYMENT_MANAGER`, Manager는 `EDITOR`다. 현재 소속에 일치하는 실제 authority를 사용하며 새 `ADMIN` API enum을 발명하지 않는다.
- MEMBER의 My Orders 수신은 Assigned Dentist 기준이다. 알림 수신 설정과 홈/주문/LinkTalk 조회 필터는 이름만으로 합치지 않는다. Office `usePersonalOrdersPreference`의 `pushEnable:true` 결합도 함께 점검한다.
- LinkTalk/Support Push 설정은 자동 이벤트 채팅 자체를 끄는 의미가 아니다.
- OS OFF에서 특정 PUSH 선택→OS 설정→정상 복귀 후 권한 ON이면 선택한 항목만 저장한다. 재시작·계정/소속 변경 등 흐름이 끊기면 과거 선택을 버리고 서버 저장값을 유지한다. 임의 유효시간이나 복잡한 복구 정책을 발명하지 않는다.
- 기존 `PermissionProvider`의 OS 허용과 서버 preference 초기화/upsert 결합은 남아 있다. 새 OS 조회 hook이 있다는 이유로 분리가 완료됐다고 판단하지 않는다.
- **전역 OS OFF 팝업:** 10/30 17:30 기기별 로컬 1회 노출 선행 구현 완료. 실제 표시 후 기록하며 계정·병원 변경으로 초기화하지 않는다. 재설치·이력 유실로 재노출되는 것은 수용한다.
- **설정 화면 파란 배너:** “가능하면 기기 내 1회, 재설치/이력 유실에 따른 재노출 수용” 합의에 따라 11/3 구현·push 완료. 양 앱이 각각 별도 `NOTIFICATION_PERMISSION_BANNER_SHOWN` 기기 키를 사용하며 전역 팝업 키와 혼용하지 않는다. 저장 이력 확인 전에는 숨기고, 설정 화면 focus·앱 active 상태의 실제 `onLayout`에서 기록한다. 현재 배너는 닫기/화면 이탈까지 유지하고 재진입·재시작부터 숨긴다. 계정/소속별 mock reset과 분리했고 로그아웃 코드도 이 키를 지우지 않는다. OS ON으로 실제 노출되지 않았으면 이력을 소비하지 않으며, 저장 실패/이력 유실에 따른 재노출은 수용한다. 서버 설정·문구·OS 설정 action은 변경하지 않았다.
- **도메인/카테고리 표시:** 10/30 18:01 사용자 결정으로 BE 계층/명칭을 그대로 노출할 의무가 없다. 같은 원본 row 안에서 하위 카테고리를 상위처럼 보이게 하거나 도메인을 숨길 수 있다. 저장 식별자를 유지하고 무관한 row는 합치지 않는다. `title`, `key/label` 분리는 준비됐지만 실제 enum/catalog adapter는 미확정이다. [디자인 기준](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=314-23253)

### 소속 전환·미읽음 표시

- 올바른 employer/employee 활성화 후 해당 소속 알림을 보여준다. 웹은 성공 후 대상 알림 팝업 한 번 자동 열기·토스트까지 가능한 방향이며 앱은 대상 스크린으로 연결한다.
- 알림에서 이동했는지, 이전/이후 병원명은 이번 이동의 임시 정보로 처리한다. 이 목적만으로 영속 저장·신규 BE API를 요구하지 않는다. **Web·Office 소속 조회/활성화는 기존 실제 API로 연결**했으며 Web 팝업·토스트까지 보완했다. Lab 알림 소속 선택 UI와 소속별 미읽음은 아직 mock/계약 대기다.
- 벨 미읽음 점은 모든 소속 중 미읽음 존재 여부, 현재 목록·전체읽음은 현재 소속 기준이다. 위치별 숫자/점과 집계 응답은 최종 디자인·BE 계약에 맞춘다.

## 남은 일과 다음 시작 순서

| 순서 | 할 일 | 필요한 조건 / 완료 기준 |
| --- | --- | --- |
| 1 | 새 BE 명세와 기존 구현 대조 | 목록/페이지·필터, 소속별 미읽음, Employee catalog/default/migration/설정 저장, 푸시 식별·클릭/읽음 계약을 확인. 새 API/notificationId 필수를 먼저 요구하지 않음 |
| 2 | 실제 데이터 연결 및 mock 제거 | 제공된 계약 범위부터 연결, 대체된 mock만 정확히 삭제. Lab 소속 선택/미읽음 포함. 숨긴 채널을 임의 덮어쓰지 않음 |
| 3 | OS와 기존 서버 preference 이관 | PermissionProvider의 OS 허용→legacy upsert와 Office My Orders의 pushEnable 결합을 새 저장 계약에 맞춰 분리. 구 production 설정 초기화를 계약 없이 통째 제거하지 않음 |
| 4 | 푸시 읽음/클릭·실역할 실행 검증 | 현재 로그인·해당 소속 준비와 identity를 검증한 뒤 REST 연결. 실제 FCM 수신·중복/동일화면의다른알림, 실패/삭제, 실제 역할/OS/기기 조건 검증 후 사용자 QA |
| 5 | PR/release | 구현·에이전트 실행 검증·사용자 QA를 구분. 현재 PR 생성/merge/배포 지시는 없으며 자동 진행하지 않음 |

- **병행 확인:** 기존 Office Support의 현재 BE 조회 계약과 필요한 실제 역할/데이터를 확보하면 해당 미검증을 해소할 수 있다. 메일 CTA/SES·추가 메뉴·새 디자인 발주를 알림센터 선행 조건으로 만들지 않는다.
- **남은 정책 근거:** Lab Home 최근 메시지/Support·자동 메시지 hide의 적용 범위는 후속 명시 근거를 확인한다. 파란 배너 1회는 이미 합의·구현된 항목이므로 다시 정책 미정/불필요한 질문으로 되돌리지 않는다.
- **누락 보완 이력:** 18:46 마감에서 배너 영속 처리가 빠져 있음을 정정했고, 사용자의 “1번까지 마무리 후 대기” 승인으로 19:19 보완을 마쳤다. 현재 승인 범위에서 더 임의 확장하지 않고 위 BE 계약 확인부터 재개한다.

## 정본 자료·Jira·이력

- 정책: [Notion PRD](https://app.notion.com/p/innovaid/3c7ce072e82f811184a8e647444f01fd). 화면: [Figma](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=2-6). 원 기획: [FigJam](https://www.figma.com/board/U9Qpm6ACzjGFKyrCoaAuvA?node-id=33-3714).
- 결정 근거: [UX 논의](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793063024060739), [푸시 클릭/읽음](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793244658608799), [앱 추가 목록 회의](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793596568281269). 최신 명시적 사용자 정정과 날짜 있는 후속 결정을 오래된 문장보다 우선한다.
- 알림센터 상위 [DL-16140](https://innovaid.atlassian.net/browse/DL-16140). 공통 DL-17057, Web DL-17058/17061/17062, Office DL-17059/17063/17064/17065, Lab DL-17060/17066/17067/17068, UX 사전 검토 DL-17048. 실제 카드 상태·범위는 재개 시 확인하며 카드명만으로 제외 범위를 복원하지 않는다.
- 추가 목록: DL-17174→DL-17202, 후보 검토 DL-17179. 원본 앱 비교 세션 역할은 [모바일웹/앱 차이 체크포인트](dentlink-mobile-web-app-parity.md)를 참조한다.
- 마지막 DEV Swagger 조사: **11/3 14:01 KST**. 기존 목록·부분/전체읽음·미읽음·구 preference 계약을 재확인했다. 정확한 공개 명세 범위는 [당일 14:05 점검 이력](archive/dentlink-unified-notification-center-2026-11-03-worklog.md)을 따른다. 17:40에는 기존 Office Support 404 경로를 추가 대조했다. 문서 마감 때 Swagger 전체를 다시 조회하지 않았다.
- 과거 FE API 제안서는 확정 BE 계약이 아니다. 상세 조사·UX 합의·소스/기기 증거·공수 산정·이전 정확한 Git 이력은 [2026-11-03 분리 전 전체 이력](archive/dentlink-unified-notification-center-through-2026-11-03.md)에 보존했다. 과거 ‘현재/다음’ 지시는 최신 범위를 되돌리지 않는다.

## 운영 경계

- 이 세션은 통합알림센터 기능을 Web/Office/Lab 함께 담당하며 [FE 상위 세션](dentlink-fe.md)은 공통 조율을 담당한다. 새 세션·worktree를 자동 생성하지 않는다.
- 제품마다 정확한 저장소·활성 작성자를 확인한다. Web 신규 일반 작업은 최신 origin/master, 두 앱은 origin/main 기반 feature/<Jira>→해당 release→main이다. 남은 develop을 신규 기준으로 쓰지 않는다.
- 11/3 사용자가 이번 FE 선행 범위의 구현·검증·세 제품 commit/push를 승인했다. PR 생성·merge·배포는 승인 범위가 아니다. 다음 미정 정책/새 기능을 자동 확장하지 않는다.
- Slack은 읽기 전용이며 자동 폴링은 중단 상태를 유지한다. 팀 공유 문서와 개인 작업 메모를 구분하고 의미 있는 마감에 개인 컨텍스트를 commit/push한다. 제품 commit/push는 해당 작업의 명시적 승인을 따른다.
