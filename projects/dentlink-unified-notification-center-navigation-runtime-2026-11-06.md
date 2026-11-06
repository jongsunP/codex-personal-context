# 알림 랜딩 복귀·SpringBoard 점검 — 2026-11-06

## 승인 범위와 변경

- 사용자가 앞선 라우트 조사 후 앱 수정을 승인했다. Web은 변경하지 않는다. 평소에는 Codex 단독 실행이 기본이며 직접 로컬 확인을 요청할 때만 사용자용 미리보기 구성을 준비한다. 두 방식 모두 앱 크래시/실행 검증은 필요하다.
- Office/Lab 각 `NotificationCenterScreen`, `RootNavigator`, `useNavigationConfig` 3파일을 변경했다. 내부 알림은 현재 알림함의 route key와 함께 공통 랜딩 함수로 연결한다. 별도 영속 이력이나 신규 BE API는 추가하지 않는다.
- 같은 소속의 내부 알림은 기존 알림함 위에 목적지를 추가한다. 뒤로가기는 같은 알림함으로 돌아가며 필터·기존 화면 이력을 보존한다. 전환된 소속은 새 Home→새 알림함→목적지로 구성해 이전 소속 화면을 복원하지 않는다.
- 외부 push/deep-link는 출발 알림함 정보를 전달하지 않으므로 기존 복귀 규칙을 유지한다. 탭/action, 채팅의 특수 복귀, 로그인 전 deferred, 주문 완료 후 업무 흐름을 일반 화면 push로 덮어쓰지 않는다. Office DRAFT 진입에는 기존 `shouldReturnOnBack` 옵션을 내부 알림에서만 전달한다.
- 화면 이탈·계정 변경·다른 요청으로 무효화된 비동기 응답은 뒤늦게 랜딩하지 않는다. 내부 출발 화면의 root key뿐 아니라 실제 leaf `NotificationInbox`를 확인한다. 정상 취소에 소속 전환 실패 토스트도 띄우지 않는다.

## 최종 코드 실행 근거

| 대상 | 방법·확인 | 결과·경계 |
| --- | --- | --- |
| Office Android API36 | 실제 UI 탭으로 User Credits 반복2회, Office Credits, Statements 진입·헤더/기기 Back, 외부 credit 링크 | 내부는 알림함, 외부는 기존 Home으로 복귀. 기존 REST 조회 화면 표시 확인. 첫 실행의 오래된 JS와 Home 공지 가림을 해소한 뒤 최종 시나리오 통과 |
| Office iOS26.5 | 실제 실행 중인 앱의 렌더된 버튼/item handler 호출, native 화면 및 navigation state 대조 | User/Office Credits·Statements 왕복에서 같은 알림함 route key와 All 필터 유지. 외부 credit 링크 후 Home 복귀. XCTest 충돌 때문에 전체 물리 탭 자동화 통과로 표현하지 않음 |
| Office Android 실제 소속 전환 | 기존 activate API로 원 소속→다른 소속의 credit→뒤로→원 소속으로 복구 | 대상 소속의 새 알림함 복귀 스택 확인, 원래 auth 문맥 복원. 신규 미읽음/읽음 API 검증 아님 |
| Office Android 늦은 응답 | activate 응답만 런타임 지연 대체, 기다리는 중 알림함 이탈 후 완료 | Home 유지, 기존 소속 유지, 잘못된 실패 토스트 없음. 원 함수는 finally에서 복원. 실제 서버 지연 재현과 구분 |
| Lab iOS26.5 | 임시 런타임 mock에 기존 help/paymentMethod 목적지 부여, 실제 item 및 popup handler·native stack 확인 | Help Center 왕복에 같은 알림함/All 유지. PaymentMethod는 기존 Forbidden 정책이며 팝업 Back으로 알림함 복귀. 결제수단 기능 구현/권한 허용으로 해석하지 않음. 외부 help 링크 후 Home 복귀 |
| Lab Android API36 | 같은 임시 데이터의 실제 UI 탭 | Help Center→알림함, Forbidden 안내→뒤로→알림함, 외부 help→Home을 검증. 테스트 selector의 영문/한글 차이는 테스트만 수정하며 제품 오류로 기록하지 않음 |

- Lab은 원래 단일소속 계정이며 실제 다중소속 성공은 이번 범위 밖이다. 기존 공통 guard·전환 코드를 검토했으며 임의 계정/소속 계약을 만들지 않았다.
- iOS 자동화 충돌 이후에는 Maestro/XCTest를 재실행하지 않았다. CDP의 실제 컴포넌트 callback과 네이티브 상태 확인은 정적 테스트가 아니지만 물리 터치 검증과도 구분한다. Android는 실제 UI 조작으로 확인했다.
- 알림 데이터·읽음·서버 수신 설정·미읽음 집계 및 실제 FCM 수신/클릭 REST end-to-end는 여전히 계약 대기다. 새 런타임 샘플 목적지는 테스트용이며 실제 시트 정책/제품 mock에 추가하지 않는다.
- Office Jest 3 suites/36 tests, Lab 기존 deepLink 6 tests 통과. 양 앱 변경 파일 ESLint 오류0(각 기존 console 경고3), diff-check 통과. 전체 TypeScript는 Office 기존6건/Lab 기존5건으로 실패하며 변경 파일 신규 진단은 없었다. 전체 타입검사 성공으로 표현하지 않는다.
- 독립 코드 리뷰에서 Lab source leaf 검사와 Office 취소 후 실패토스트 방지를 보완했다. 최종 코드로 실행 검증했다. 생성 API/네이티브 파일·라이브러리·웹·새 테스트 파일·PR·배포는 변경하지 않았다.

## SpringBoard 반복 종료

- SpringBoard는 iOS 홈 화면·앱 전환 등을 담당하는 시스템 프로세스이며 제거하거나 끌 대상이 아니다. 이 경고 자체가 Dentlink 앱 크래시라는 뜻은 아니지만 반복 종료를 정상으로 취급하지 않는다.
- 11/5 15:51·18:43, 11/6 15:53·17:08의 SpringBoard 로그4건이 같은 `EXC_BAD_ACCESS/SIGSEGV`·주소0x20·`XCTAutomationSession` 접근성 초기화 프레임을 가리킨다. 현재 17:08 Maestro/XCTest 실행 직후 같은 충돌이 발생했다.
- 직전 Office 앱 프로세스의 11/5 18:43 크래시도 같은 Apple `XCTAutomationSupport` 프레임이므로 “시스템 문제라 앱에는 영향 없음”이라고 단정하지 않는다. 현재 알림 뒤로가기 JS가 원인이라는 근거는 없으며 자동화 환경 충돌 근거가 강하다.
- 환경: Xcode27.2(27B52), iOS26.5(23F77), Maestro2.6.1. WebCore/WebKit 접근성 bundle의 동일 클래스 중복 경고가 함께 있었으나 Apple 파일을 수정/삭제하지 않는다. [유사 공개 이슈](https://github.com/mobile-dev-inc/maestro/issues/3494)는 참고이며 해결된 버전의 증거가 아니다.
- **이번 조치:** 충돌하는 iOS Maestro/XCTest 방식 중단, 앱 재실행, 직접 화면·runtime/native state 방식으로 대체 검증. 이후 검증 구간에 새 SpringBoard/Dentlink crash report는 관찰되지 않았다. 근본 해결/영구 재발 방지는 아직 입증되지 않았다.
- 경고를 전역으로 숨기거나 crash reporter를 끄지 않았다. 재발 시 동일 프레임인지 먼저 확인하고 Simulator 재시작 또는 호환되는 Xcode/runtime/자동화 조합을 별도 검증한다. 자동화 없이 사용자 조작에서도 발생하면 별도 원인 조사 대상이다.
- Android crash buffer의 Bluetooth 시스템 프로세스 SIGABRT는 Dentlink 앱과 구분했다. 이번 앱 최종 관찰에서 Dentlink fatal/LogBox error는 없었다.

## 로컬 근거 파일

- `/tmp/notification-back-office-android-result.log`, `notification-back-office-ios-result.json`, `notification-back-office-ios-external.json`
- `/tmp/notification-back-office-cross-result.json`, `notification-back-office-guard-result.json`
- `/tmp/notification-back-lab-android-result.log`, `notification-back-lab-android-remaining-result.log`, `notification-back-lab-ios-result.json`, `notification-back-lab-ios-external.json`, `notification-back-lab-ios-popup-result.json`
- `/tmp/notification-back-office-jest.log`, `notification-back-office-typecheck.log`, `lab-back-navigation-typecheck.txt`
- `~/Library/Logs/DiagnosticReports/SpringBoard-2026-11-06-170835.ips`, `Retired/DentlinkDevelopment-2026-11-05-184339.ips`
- 로컬 /tmp 증거는 임시 파일이다. 위에 결과와 한계를 Git-backed 정본으로 보존하며 민감한 계정·토큰·비밀번호는 기록하지 않는다.
