# 통합알림센터 앱 영향 화면 검증 — 2026-11-03

## 상태와 범위

**2026-11-03 실행 검증 마감 기록이다. Office `8f09cb1`·Lab `be4512b`에서 실행 가능한 양 OS 영향 화면과 마지막 Help 정상 진입 경로 확인을 마쳤다.** 실역할·실데이터/장비 부족으로 미검증인 범위가 있어 최종 사용자 QA·merge 준비 완료를 뜻하지 않는다. 전체 기능 상태와 BE 대기는 [통합알림센터 체크포인트](dentlink-unified-notification-center.md)를 따른다.

| 제품 | 실제 checkout / branch | 검증 시작 코드 | 현재 추가 수정 |
| --- | --- | --- | --- |
| Office | `/Users/parkjongsun/Repository/dentlink-app` / `feature/DL-17059` | `358b400375ae583d4cf9557126f5fbe3b803ad1b`, base·확인한 origin/main `7f58679` | 타이머 `18033bc` 및 채팅 ID 정규화 `8f09cb1eff03f10c96a6cca52aacaf09751112c7`, push 완료·clean·upstream 0/0·원격 SHA 일치 확인 |
| Lab | `/Users/parkjongsun/Repository/dentlink-lab-app` / `feature/DL-17060` | `7ebc124fe01e4a46edc54b6e142ccae2e239709d`, base `5144103` | 타이머 `3686fc0`, 밀링 `be4512bb8def094e867fbe0753b018858de9a097`, push 완료·clean·upstream 0/0·원격 SHA 일치 확인 |

- 범위는 변경된 공통 딥링크·소속 전환·fetcher/query·알림 provider·bottom sheet의 실제 소비자다. 무관한 기능 전체를 새로 조사하거나 제품 테스트를 추가하지 않았다.
- 실제 로그인·서버 데이터를 재사용했다. 역할·소속·API 응답을 임의 주입하지 않았다. 메시지 전송, 주문 저장·제출, 승인·반려, 결제·등록·삭제는 하지 않았다. Office의 승인된 실제 소속 전환은 검증 후 원래 소속으로 복귀하는 조건이다.
- 시뮬레이터/에뮬레이터 실제 앱, 등록 navigator·렌더된 onPress 호출, OS URL 열기, 화면상 버튼 조작을 사용했다. route 이름만으로 성공 처리하지 않고 본문·응답·뒤로·프로세스 생존을 대조했다. 실제 FCM 발송, 손가락 탭 전수, 실물 QR/HID 장비 검증과는 구분한다.
- 새 알림함·설정은 DEV mock 화면이다. 실제 소속 조회·활성화, 기존 크레딧·청구서 조회 API의 성공과 알림 REST 저장 완료를 합치지 않는다.

## 실행 중 발견하여 보완한 4건

| 항목 | 확인된 원인·영향 | 최소 수정 | 검증 및 한계 |
| --- | --- | --- | --- |
| Office Android 일반 chat/contact 링크 | `landBy=push`가 없는 링크는 기존 700ms 대기 중 `subscribe` 재구독 cleanup이 타이머를 삭제했다. 실제 chat 링크가 Home에 남았고 다른 시도는 성공하여 타이밍 경합임을 확인했다 | 타이머를 훅/인증·소속 수명에 귀속하고 최신 `navigateFromUrlRef`로 실행. push 보강·새 목적지·HTTPS 진입은 이전 대기를 취소 | 실제 subscribe 코드 하네스 4/9→9/9. 수정 후 cold/warm 화면 진입은 정상. 이후 실제 메시지 조회에서 별도 문자열 ID 문제가 발견되어 아래 정규화와 함께 양 OS 실제 메시지 조회까지 최종 재검증 완료 |
| Lab Android 일반 chat/contact 링크 | 같은 구독 cleanup 문제. raw 링크는 Home에 남고 `landBy=push`는 실제 화면 진입 | Office와 같은 최소 보완. 기존 700ms 푸시 보강 우선 정책 유지 | 하네스 4/9→9/9. 전체 재시작 후 raw chat·Support 본문, 각 뒤로 복귀, enriched push chat 모두 성공 |
| Lab 밀링 자동 소속 전환의 최신 요청 보호 | `useMillingOrderDeepLink`가 전달한 `isRequestCurrent`를 `useMillingAccountSwitch`가 `handleChangeEmployee`에 넘기지 않아 이전 딥링크의 활성화가 뒤늦게 적용될 수 있었음 | callback을 전달하고 활성화 이후·쿠키 저장 이후·catch에서 무효 요청의 성공 반환/오류 토스트를 막음. 일반 전환의 기본 true 동작 유지 | 실제 두 훅을 실행한 비동기 하네스 4/8→8/8. 실제 SHARED 소속·밀링 주문이 없어 자동 전환 전체 런타임은 미검증. 크래시가 재현된 결함으로 표현하지 않음 |
| Office 채팅 딥링크 메시지 조회 실패 | `matchDeepLinkRoute`가 보존한 문자열 orderId를 ChatDetail→useMessage에 그대로 전달해 기존 service의 Number.isSafeInteger 검사가 HTTP 요청 전에 거절. 실제 iOS raw/push는 화면만 열리고 메시지는 로딩에 남았음 | ChatDetail state 생성 직전에 orderId를 Number로 변환하고 fallback linking config에도 적용. matcher 원문·다른 화면 params·service 유효성 검증·로딩 UI는 유지 | 실제 matcher→state parser→service 하네스 7/12→12/12. 유효 raw/push/click/fallback은 숫자로 요청, 0·음수·NaN·소수·unsafe는 기존 service가 HTTP 전 거절. 최종 양 OS 실메시지 검증은 아래 기록 |

- 두 앱의 타이머 취소 블록은 feature base에도 존재하며 `git blame`상 `3ee31fdf`(2026-05-14)에서 시작했다. 이번 알림센터가 새로 만든 버그로 기록하지 않는다.
- 설치된 React Navigation의 `node_modules/@react-navigation/native/src/useLinking.native.tsx` effect가 `subscribe` 변경 시 cleanup·재구독한다는 구현을 확인했다. 단순 재구독과 훅 실제 종료를 분리한 근거다.
- 최종 diff 독립 재검토에서 추가로 확정한 수명주기·취소 결함은 없었다. 이는 모든 서버/역할/실기기 조건의 안전을 보증하는 의미가 아니다.

## 정적·비동기 검증

| 대상 | 결과 | 근거 |
| --- | --- | --- |
| Office raw 타이머 | 수정 전 4/9, 수정 후 9/9 | `/tmp/office-raw-link-delay-1103.cjs`, `.log` |
| Lab raw 타이머 | 수정 전 4/9, 수정 후 9/9 | `/tmp/lab-raw-link-delay-1103.cjs`, `.log` |
| Lab 밀링 최신 요청 | 수정 전 4/8, 수정 후 8/8 | `/tmp/lab-milling-latest-request-1103.cjs`, `.log` |
| Office 채팅 ID 정규화 | 수정 전 7/12, 수정 후 12/12 | `/tmp/office-chat-order-id-1103.cjs` 실제 parser·service 실행 |
| Office 기존 deepLink/dentlinkWebURL | 2 suites / 71 tests 통과 | `yarn exec jest --config jest.config.js __tests__/utils/deepLink.test.ts __tests__/utils/dentlinkWebURL.test.ts --runInBand --no-cache` |
| Lab 기존 deepLink/dentlinkWebURL | 2 suites / 32 tests 통과 | 같은 명령을 Lab checkout에서 실행 |
| 변경 파일 ESLint / diff | 양 앱 통과 | Office navigation 1파일, Lab navigation·milling 2파일. RootNavigator 추가 읽기 점검은 기존 console warning 3개, error 0 |
| Office TypeScript | 수정 전후 로그 완전 동일, 기존 4파일 6건 | Icon 2, Tooltip 1, MessageText 1, useOrderAddProduct 2. `/tmp/office-raw-link-type-{before,after}-1103.log` |
| Lab TypeScript | 기존 4파일 5건 유지, 변경 파일 오류 없음 | Icon 2, Tooltip 1, configs/types/order 1, MessageText 1. `/tmp/lab-raw-link-type-1103.log` |

Office service의 숫자 가드는 main에도 존재한다. 외부 URL이 만든 runtime params는 TypeScript 선언만으로 number가 되지 않으므로 화면 진입·route 확인에 더해 실제 query 타입/성공·메시지 본문을 확인했다. Lab은 해당 service 가드와 호출 계약이 달라 동일 실패가 관찰되지 않았으며 추정만으로 변경하지 않았다.

타이머 하네스는 실제 `subscribe` 본문을 추출하여 대기 700ms, chat/contact 재구독, 최신 handler, 실제 unmount, enriched push 우선, 다른 raw 경로, 일반 경로, HTTPS, 계정 변경을 확인했다. 실제 native 실행을 대체하지 않으며 제품 저장소에는 테스트 파일을 추가하지 않았다. 임시 `/tmp` 자료는 이후 삭제될 수 있어 이 문서에 결과와 재현 조건을 남긴다.

## Office 양 OS 화면별 기록

실제 역할: iOS는 MEMBER 및 OWNER 소속, Android는 OWNER 소속으로 확인했다. PAYMENT_MANAGER·EDITOR·VIEWER 실소속은 확보하지 않았다. iOS는 iPhone 17 Pro 시뮬레이터의 development 앱, Android는 `emulator-5554`의 development 앱이다. Office Metro는 8081이다.

| 화면 / 진입 | 실제 역할·데이터 | iOS 결과 | Android 결과 / 현재 상태 | 미검증·제한 |
| --- | --- | --- | --- | --- |
| Home·Profile / 탭 | 실제 소속·주문·메뉴 | 렌더·왕복 정상 | 실제 서버정보·메뉴·왕복 정상 | Office 일반 Home 소속 sheet 별도 실행 미검증 |
| 알림함·안읽음·설정·주문범위 / Home 벨 | DEV mock, 실제 MEMBER/OWNER | 렌더·설정 이동·sheet 정상, 타이머 수정 후 왕복 재확인 | DEV 목록·설정 렌더·뒤로 정상 | 실제 알림 목록·설정 저장 API 성공 아님 |
| 알림의 다른 병원 선택 | 실제 다중 소속 | MEMBER→OWNER 전환, 인박스 유지·토스트, 원 소속 복귀 성공. 타이머 수정 후 재확인 | 실제 단일 소속이라 선택 UI 미노출, 다중소속 성공 미검증 | 전체 역할별 전환/실패 조합은 미완 |
| Credit USER / OFFICE / 각 딥링크 | 실제 조회 가능 소속 | USER Earned/Expired 내역, OFFICE 빈내역·뒤로 정상. 소속 변경 후 데이터 갱신 확인 | USER 잔액·Earned/Used/Expired 실제 이력, OFFICE 빈내역·뒤로 정상 | 모든 역할/데이터 유형 완료로 확대하지 않음 |
| Statements / billing/statement | MEMBER·OWNER, 실제 청구서 | MEMBER 접근 시 Home 복귀, OWNER 실제 카드 조회·뒤로 정상 | OWNER 실제 여러 청구서 카드·상태·금액·뒤로 정상 | PAYMENT_MANAGER 실역할 미확보 |
| PaymentMethod / 기존 경로 | OWNER 기존 결제수단·AutoPay | 조회·뒤로 정상 | 기존 카드·AutoPay·Assignment 본문, 약 58초 활성 체류·뒤로 정상 | 추가·삭제·결제 미실행 |
| Orders·Patients / 탭 | 실제 주문·환자 | 목록·탭 정상 | 실제 주문·환자 목록 렌더 정상 | 필터/권한 모든 조합 미완 |
| 신규 주문 / Place Order | 실제 환자·케이스 | 환자 선택→케이스 목록→새 폼·뒤로 정상 | 새 주문 전체 흐름은 미검증, 기존 DRAFT의 제품 단계는 아래 별도 확인 | 새 Next는 서버 DRAFT 생성/갱신이므로 실행하지 않음 |
| 기존 DRAFT / 주문 링크 | Android에 실제 DRAFT 존재 | 확인한 소속 모두 0건으로 미검증 | 타이머 보완 후 단계 4→3→2 조회·뒤로 성공 | 제출·저장·제품 변경 안 함. iOS 실제 DRAFT 미확보 |
| OrderDetail·채팅 주문정보 / 행·상단 버튼 | 실제 주문 | WebView 완전 렌더·채팅 왕복 정상 | 실채팅↔주문정보 왕복 및 실제 WebView 본문, 약 40초 활성 체류·뒤로 정상 | 유효 shipment 없음, 배송 특정 링크 미검증 |
| DesignConfirmation / confirm·Home 카드 | 실제 approval | Planning 본문·첨부·버튼·뒤로 정상 | Home 실제 Design 카드→AwaitingApproval·내장 본문→OS Back Home 정상 | 승인·반려 미실행, 모든 approval 유형 검증 아님 |
| CasePreference·DesignApproval 설정 / Profile | 현재 서버 설정 | intro→질문 폼·뒤로, 설정 조회 정상 | 실제 intro→Occlusion 질문폼→OS Back 정상, 서버 설정값 조회·뒤로 정상 | 선택·저장·Change 안 함 |
| Feedback 목록·상세 / Profile·deep link | iOS 대상 0건, Android 실제 대상 존재 | ToReview/Reviewed 빈목록·뒤로 정상, 상세 미검증 | 타이머 보완 후 실제 상세→목록 복귀 성공 | Submit 미실행, iOS 실제 상세 데이터 미확보 |
| LinkTalk 전체/안읽음·ChatDetail / 탭·행·링크 | 실제 채팅 | 최종 재시작 후 raw/push의 number ID·두 query success·실본문·각 10초·Back, 기존 행 왕복 정상 | 최종 재시작 cold raw/warm push의 number ID·query success·실본문·각 10초·Back, 기존 행 왕복 정상 | 실제 FCM 발송부터 진입 전체는 미검증. 이전 헤더만 열린 캡처는 조회 성공 근거에서 제외 |
| DentlinkSupport / contact | 실제 MEMBER·OWNER | 화면 진입·뒤로 가능, GET 404로 조회 실패 | raw 진입은 정상, GET 404 확인 | 기존 Support 오류 처리/BE 확인 필요, 정상 본문 조회로 처리하지 않음 |
| ChannelTalk action / 기존 버튼 | 현재 빌드 SDK disabled·unbooted | 화면 열리지 않아 환경상 미검증 | SDK 실제 실행은 미검증, 강제 활성화하지 않음 | 강제 활성화·상담 생성 안 함 |
| Help root·board·article / Profile·링크 | 실제 게시판·게시글 | WebView 본문·실제 글·헤더 뒤로 정상 | Profile 원래 버튼→root→UserGuide board→실제 article, 화면상 header Back→board→root→Profile 정상 | 직접 boardId 진입의 후속 history는 아래 별도 한계. 모든 게시글 유형 확인 아님 |
| BillingPolicy / 기존 문서 | 실제 USD 정적 asset | 문서·닫기 정상 | 실제 문서 본문·OS Back Home 정상 | 결제 처리 검증 아님 |
| ISV·환자폼·사진안내 / Home·등록 화면 | 실제 환자/가능 소속 | 초기 환자목록·폼·뒤로 정상 | 실제 환자목록·담당의·초기폼, Add New Patient 빈 모달·OS Back 정상 | Done/Next·환자 생성·후속 저장·사진 업로드 미실행 |
| FaceRecognitionCamera / 사진 안내·등록 화면 | 실제 카메라 환경/권한 | 실기기 전용 안내·뒤로 정상 | CAMERA 권한 없는 직접 등록 화면 진입에서 overlay·권한 경고·OS Back 확인 | Android는 사진가이드 권한 준비를 우회한 제한 조건. 정상 촬영 성공 아님, 촬영·권한 변경 안 함 |
| EximbayPopup | 유효 등록 요청 URL 필요 | 미검증 | 미검증 | 신규 카드 등록 없이 유효 requestId 없음 |
| Signin·ForgotPassword·NoAccess | 별도 실제 인증/소속 상태 필요 | 로그인 유지로 미검증 | cold deferred는 로그인 유지 상태만 확인 | 실제 로그아웃 후 deferred/권한 없음 상태는 미검증 |
| SimpleLogin·Hidden | DEV 관리 화면 | 제외 | 제외 | SimpleLogin은 생체인증이 아닌 테스트 계정 화면. 비밀번호/환경 변경하지 않음 |

변경 없는 화면은 앞선 실제 실행 근거를 재사용했고, 타이머/ID 보완에 영향받는 채팅 진입은 최종 `8f09cb1` 전체 재시작 후 양 OS에서 다시 확인했다. iOS는 raw Back→Home·push Back→LinkTalkAll, Android는 raw Back→Home·push Back→기존 LinkTalkUnread를 확인했다. query 키의 orderId가 number이며 실제 메시지 조회 성공을 확인해 이전 문자열 ID·헤더만 열린 증거와 구분했다. 최종 iOS/Android 모두 프로세스 유지·치명 로그/렌더 반복/잘못된 ID 오류가 없었고, 원 소속 Home으로 복귀했다. Support 404와 데이터·역할별 미검증은 남는다.

## Lab 양 OS 화면별 기록

실제 조건은 INTERNAL·OWNER·DIRECTOR의 단일 소속이다. SHARED/EXTERNAL·VIEWER 또는 두 소속을 임의로 만들지 않았다. Android `emulator-5554`, iOS development 시뮬레이터이며 Lab Metro는 8082다. `be4512b` 최종 코드에서 가능한 조회·뒤로·raw/push·알림 반복 진입을 양 OS로 마쳤다. 아래 데이터/권한 제한은 미검증으로 남는다.

| 화면 / 진입 | 실제 데이터·조건 | Android 결과 | iOS 결과 / 현재 상태 | 미검증·제한 |
| --- | --- | --- | --- | --- |
| Home·Profile·소속정보 / 탭·sheet | 실제 INTERNAL 소속 | 본문·sheet·왕복 정상 | Home·Profile 본문·왕복, Maestro 실제 탭으로 소속 sheet 열기·닫기 정상 | 실제 다중소속 전환 미검증 |
| ProfileLabEdit / 등록 navigator | 실제 기공소 정보 | 편집폼 조회·뒤로 정상 | 최종 코드 조회·뒤로 정상 | 저장 안 함 |
| 알림함·설정·소속 선택 / Home 벨 | DEV mock | 최종 bundle에서 화면·뒤로 정상. offscreen back 선택 결과는 제외 | 최종 Home→인박스→설정→인박스→Home 정상 | 실제 알림 REST/미읽음 집계 아님 |
| Orders·Patients / 탭 | 실제 주문·환자 | 실응답·본문·탭 정상 | 최종 코드 조회·뒤로 정상 | 역할별 조회 제한 미완 |
| LinkTalk 전체/안읽음·ChatDetail / 탭·행·링크 | 실제 채팅·주문 | 원래 행 왕복 및 최종 raw/push 진입·본문·10초 후 뒤로 정상 | 실본문·목록 왕복 정상. raw→Back Home, push→Back LinkTalk 정상 | 실제 FCM 수신 미검증 |
| OrderDetail·채팅 주문정보 / 버튼·링크 | 실제 주문 | WebView/주문정보·뒤로 정상 | 최종 코드 조회·뒤로 정상 | 유효 배송 데이터/개별 배송 링크 미검증 |
| DesignConfirmation / confirm | 실제 approval | 본문·뒤로 정상 | 최종 코드 조회·뒤로 정상 | 첨부 외부 URL에 기존 호스트 오타가 있어 WebView 오류. 승인/반려 안 함 |
| DentlinkSupport / contact | 실제 Support 데이터 | 최종 raw contact→실본문→Home 복귀 정상 | 최종 코드 조회·뒤로 정상 | 메시지 전송 안 함 |
| ChannelTalk action | 현재 서비스 disabled | 비활성 확인, SDK 진입 미검증 | 동일 구현 | 강제 활성화 안 함 |
| Help / 기존 링크 | 실제 도움말 | 기존 최종 확인 | 최종 링크→본문→뒤로 정상 | 모든 게시글 유형 확인 아님 |
| PaymentMethod / 기존 링크 | base부터 결제관리 불가 | Forbidden 표시 및 팝업의 실제 뒤로→Home 정상 | Forbidden 및 뒤로→Home 확인 | OS Back으로 팝업만 닫힌 상태는 정상 복귀 근거에서 제외 |
| MillingOrderList / 기존 밀링 진입 | 실제 검색 결과 0건 | 목록 API·빈상태 확인 | 실목록 0건 확인 | 실제 MillingOrderDetail·자동 대상 소속 전환 미검증 |
| Production 목록·상세·Correction·Rework | SHARED 및 workOrder/lot 필요 | 목록의 현재 소속 이용불가 표시 확인, 상세 등 미검증 | 동일 | 역할/데이터 임의 조작 안 함 |
| ProcessScan·MaterialOutbound / QR 탭 버튼 | 현재 카메라 진입 가능 | 카메라/스캔 UI·뒤로 확인 | 스캐너 fallback·뒤로 확인 | 실제 QR 처리·재고 변경 안 함 |
| ProcessForm·ResourceScan·MaterialStock·Detail | SHARED 및 operation/material/stock 필요 | 데이터 화면 미검증 | 동일 조건 | 유효 실대상 필요 |
| MaterialForm·Entry / 등록 navigator | SHARED 데이터 없음 | 권한 안내·빈 폼 마운트·뒤로만 확인 | 빈 폼·뒤로 확인 | 정상 데이터/저장 검증으로 보지 않음 |
| MaterialQrScan·HomeLabScan / 등록 navigator | 에뮬레이터 카메라 | 테스트 카메라 패턴·뒤로 확인 | fallback·뒤로 확인, 권한 authorized지만 후면 카메라 장치 없음 | 실물 스캔·촬영·메시지 전송 안 함 |
| MaterialList 메뉴 | 기존 feature flag false | 제외 | 제외 | 임의 활성화하지 않음 |
| BannerPopup·메시지 URL·HID reader | 실제 노출 자료/장비 필요 | 현재 팝업·일반 URL·HID 없어 정적 소비자 확인만 | 동일 | 디자인 첨부 링크/MessageTemplate와 일반 메시지 URL을 혼동하지 않음 |
| Signin·로그인 전 deferred·NoAccess | 실제 인증/접근불가 상태 필요 | 미검증 | 미검증 | 현재 OWNER에서는 NoAccess 미등록. 직접 navigate 경고를 크래시로 세지 않음 |

## 오류·제약의 판정

### HMR getSnapshot 오류

- Lab에 훅을 추가한 직후 HMR에서 `getSnapshot of null` RedBox가 관찰됐다. 그 상태에서 시도한 payment/back·Home sheet는 검증 근거에서 제외했다.
- 앱 프로세스를 완전히 재시작한 뒤 최신 bundle·타이머 코드 확인, Home 및 raw/push 화면 왕복 성공, 이후 getSnapshot·fatal·JavascriptException·render loop가 없었다. Office도 훅 변경 뒤 전체 재시작을 요구했다.
- 정적 확인상 `RootNavigator`는 모든 훅을 첫 조기 return보다 먼저 호출하고 `useNavigationConfig`의 새 store/effect도 조건 없이 최상위에서 실행한다. 조건부 훅 호출은 발견하지 않았다.
- HMR이 이전 훅 상태를 보존하면서 새 호출 순서와 맞지 않았을 가능성은 **추정**이다. cold restart에서 미재현이라는 사실과 원인 확정을 구분한다. 운영 크래시가 해결됐다고 확대하지 않는다.

### Office Support 404

- `DentlinkSupportScreen.tsx`, `useMessage.ts`, `linktalk.service.ts`, `useLinkTalkQueries.ts`는 `7f58679`·확인한 `origin/main`·feature HEAD의 blob이 동일하다. 관련 마지막 변경은 2026-10-19 `43f7879`다.
- Support는 `useMessage({ chatType: "DENTLINK" })` → `LinkTalkService.findChatMessages` → `GET /office/chat-messages`를 사용한다. 조회 실패가 실제 두 OS/소속에서 관찰됐다.
- 일반 진입의 `isScreenLoading`은 true로 시작하고 `useMessage.ts` 1023~1026의 조회 성공 때만 false가 된다. 기존 오류 처리 부족이 404 후 로딩 잔류를 설명한다. push 진입의 별도 갱신 흐름은 일반 진입과 구분한다.
- 이번 fetcher의 `accountContext` 변경은 이 조회가 전달하지 않는 옵션이며, 취소 에러 toast 제외는 정상 HTTP 404를 바꾸지 않는다. 신규 알림센터 회귀라는 근거는 찾지 못했다.
- **17:40 KST 현재 DEV 공개 Swagger 재확인:** [정본 API 문서](https://dev-api.dentlink.io/v3/api-docs)의 `/office/chat-messages`는 없고 주문 ID가 필수인 `/office/chat-messages/orders/{orderId}`만 확인됐다. `/office/chats/unread-count`의 DENTLINK enum은 본문 조회 대체 계약이 아니다. Lab `/lab/chat-messages?chatType=DENTLINK`는 유지된다.
- 따라서 기존 Office Support 호출과 현재 DEV 공개 계약의 불일치 및 실제 404는 확인했다. 서버에서 기능을 없앤 것인지 대체 경로/명세가 누락된 것인지는 확정하지 않았다. **BE의 Support 본문 조회 계약 확인이 필요한 잔여 문제**이며, 임의로 주문 API로 바꾸거나 새 오류 UI를 만들지 않았다. `/tmp/office-support-swagger-1103.json`에 최소 조사 근거가 있다.

### Android WebView renderer 로그의 정정

- Office 결제수단·주문 상세의 처음 캡처는 로딩 중이었다. 그 직후 Back 때 Chromium의 renderer code -1 로그가 있어 처음에는 활성 화면 장애를 의심했다.
- 시각을 대조하면 두 로그 모두 Back 직후였고 ActivityManager도 해당 renderer를 `isolated not needed`로 종료했다. 같은 주문 상세 재진입은 실제 본문 로드 뒤 총 약 40초, 결제수단은 약 58초 유지됐으며 Help도 본문/체류 정상, 활성 화면에서 같은 오류는 재현되지 않았다.
- 해당 화면·공통 WebView·Android 설정·라이브러리 버전은 base/main과 동일하다. 기존 `DentlinkWebView`에는 `onRenderProcessGone` 재마운트 처리가 있다. 종료 시 `destroy`와 활성 화면의 자발적 renderer 실패를 구분하며 code -1 단독 로그로 원인/제품 크래시를 확정하지 않는다.
- 이 관찰을 해결했다는 별도 제품 패치는 만들지 않았다. 최초 로딩 캡처는 정상 본문 증거에서 제외하고 충분히 기다린 재확인 캡처를 사용했다.

### 실행 근거의 한계

- Lab Android 최종 재시작 후 프로세스 fatal/JavascriptException/getSnapshot/render loop 0. 시작 단계의 ReactNoCrashSoftException·Dev loading window 메시지는 기록하되 이후 동일 프로세스 탐색 성공과 구분했다.
- Lab iOS 최종 `be4512b` 전체 재시작 후 같은 프로세스 유지, 최근 실행 구간 Fatal/Maximum update depth/getSnapshot/JavascriptException 0, 당일 앱 DiagnosticReport 없음. 원 소속 Home으로 복귀한 상태에서 root에 기기를 반환했다.
- offscreen header를 고른 CDP back, 다음 탐색과 겹친 자동 screenshot은 성공 근거에서 제외하고 실제 화면상 back으로 다시 확인했다.
- Lab iOS raw chat는 기존 Home 스택을 유지하므로 Back→Home이 정상이다. 테스트 스크립트가 push와 같은 LinkTalk 복귀를 기대해 false로 기록한 한 건은 기대값 오류다. 실제 Home 렌더·프로세스 유지와 별도 push→LinkTalk 복귀를 확인해 구분했다.
- Office Android Help의 직접 boardId 등록 진입에서는 후속 Back 때 board/article 왕복을 관찰했다. 정상 Profile 메뉴→root 진입에서는 article→board→root→Profile 복귀를 확인해 일반 Help 경로의 결함으로 확정하지 않았다. 직접 외부 board 진입의 history는 필요 시 별도 재현 대상으로 남긴다.
- `ChatDetailOrderInfo`는 독립 스크린이 아닌 실제 ChatDetail의 주문정보 버튼/컴포넌트 경로다. 별도 화면을 검증했다고 부풀리지 않는다.
- `/tmp/office-crash-audit-1103.md`, `/tmp/office-crash-audit-android-supplement-1103.md`, `/tmp/lab-crash-audit-1103.md`와 각 runtime 담당자의 최종 screenshot·로그가 상세 증거다. 원시 이벤트/계정·비밀번호·토큰·환자정보는 이 문서에 복사하지 않는다.

## 남은 검증과 마감 상태

1. 가능한 양 OS 실행 결과와 마지막 Help 정상 경로 확인을 위 표에 반영했다. 채팅 타이머/ID 수정은 최종 코드 전체 재시작 후 실제 조회·본문·10초 체류·뒤로까지 재검증했다.
2. 실제 역할·밀링 데이터·실기기 장비가 없어 못 한 검증과 Office Support의 기존 DEV 404는 남는다. 필요 시 해당 실조건 및 BE의 Support 조회 계약을 확보해 이어간다.
3. 두 앱 추가 수정은 root가 commit/push했으며 위 최종 SHA의 원격 일치, checkout clean·upstream 0/0까지 확인했다. 이 상세 기록과 메인 체크포인트를 개인 컨텍스트의 같은 마감 커밋으로 저장한다.
4. root가 audit의 포트·cwd·PGID를 대조한 뒤 Office8081/Lab8082 종료, Android emulator 종료, iPhone17Pro shutdown·기기창 닫기를 완료했다. 3000/3005/8081/8082/9233 listener 및 실행 중 기기 없음 확인. 로그인 상태는 보존했다. 이후 승인된 Mac 개발 계정 보안 입력창만 열어 사용자 입력을 기다린다. 실제 비밀번호 저장과 앱 로그인 검증 완료는 별도다.
5. 남은 실역할·데이터/환경 검증과 BE 알림 명세 연결이 해소되기 전에는 최종 사용자 QA 인계·merge 준비 완료라고 표시하지 않는다. PR·merge·배포는 이번 기록 작업에서 실행하지 않는다.
