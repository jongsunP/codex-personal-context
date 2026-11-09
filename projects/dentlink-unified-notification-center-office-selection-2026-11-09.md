# 치과 선택 디자인 통일 — 2026-11-09 구현/검증

## 범위와 근거

- 사용자 승인: 웹·치과앱 일반 병원 선택과 알림 병원 선택을 함께 수정, 기능/권한 유지, 미정 문구 보존, 검증 후 commit/push·메모리. PR 금지.
- [디자이너 Slack](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794211574467219), [Figma WF](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=490-25079), 이 대화의 스크롤 설명을 대조했다. 일반/알림 모달 문구 중 알림 문구는 PM 검토 대기라 기존 제목·안내를 유지했다.
- 일반 앱490:28447/491:28975/491:29068, 알림 앱491:34596/491:35352, 웹 일반491:29327/491:29218/491:31330, 웹 알림494:36563/494:37112 및 주석을 사용했다. 임의 신규 UX/집계/API를 만들지 않았다.

## Git 결과

| 제품 | checkout / branch | 최종 커밋 | 상태 |
|---|---|---|---|
| Web | `/Users/parkjongsun/Repository/dentlink-client-notification-center`, `feature/DL-17058` | `ed88f08384f624f0171de9fd38cd9dffcc9ec7b2` | 원격 일치, clean, 0/0 |
| Office 앱 | `/Users/parkjongsun/Repository/dentlink-app`, `feature/DL-17059` | `8887a90bd163f85498f1d7afca592c92126a8f64` | 원격 일치, clean, 0/0 |
| Lab 앱 | 기존 checkout | 변경하지 않음 | 이번 구현 범위 아님 |

새 branch/worktree, PR, merge, CodePush/배포는 만들거나 실행하지 않았다. Slack/Figma/Notion/Jira도 이번 구현을 이유로 수정하지 않았다.

## 변경 내용

- 웹6파일: Clinic `OfficeSelectListModal`, `Notifications/NotificationCenter`, 기존 `OfficeSelectListItem` 제거, 공유 `EmployerUI/OfficeSelectionItem`·`OfficeSelectionModal` 신규, `NotificationEmployersModal`에 Clinic 현재 소속 분기 추가. 일반/알림이 같은 카드/행 스타일을 사용한다. Lab은 기존 UI 분기를 보존했다.
- 앱5파일: `EmployeeSelectBottomSheet`, `EmployeeSelectList`, `NotificationOfficeSelectSheet`, `NotificationCenterScreen`, 표시 공통화용 `OfficeSelectList` 신규. 전역 BottomSheet 기본 동작이나 API·읽음·권한 규칙은 수정하지 않았다.
- 현재 카드: 회색배경/radius12,40px 흰 아이콘박스/20px 병원아이콘, 보라색 이름/회색주소. 현재 카드는 선택·미읽음 숫자·화살표가 없다.
- 다른 소속: 긴 이름/주소 여러줄,20px 화살표, 알림 count는 이름 옆. 앱은 외곽 하나+구분선, 웹은8px 간격 개별 카드.
- 웹: desktop480px/최대600px, mobile최대90dvh. header/footer 고정, 현재 카드+목록 본문 함께 scroll. Add New Office 기존 경로 보존.
- 앱: 현재 카드와 결제수단/제목 고정, 하단만 scroll. 일반 외곽450px/알림500px 최대(내부 ScrollView는 테두리2px 제외448/498). 작은 화면에서는 실제 가용 높이로 줄어든다. Payment Method 노출은 OWNER/PAYMENT_MANAGER 그대로다.
- 빈 다른 소속: 제목/목록/제목 아래 빈 여백을 숨기며 일반의 현재 카드·권한별 Payment만 유지한다.

## 재현한 문제와 수정

기존 `EmployeeSelectList`의 `initialActivatedEmployerIdRef`가 처음 열었던 소속을 계속 보존했다. 실제86→145 활성화 성공 뒤 재오픈했을 때 상위 employee는145인데 현재 카드가86, 다른 소속에145가 남아 이전86을 고를 수 없는 것을 iOS 런타임 props/화면으로 확인했다.

초기 ref 대신 현재 `activatedEmployerId`로 현재/다른 목록을 함께 계산하도록 변경했다. 서버 활성화 실패 시 auth를 변경하지 않는 기존 동작은 그대로다. 최종 양OS 일반/알림 각각86→145→86 실제 활성화·재오픈 검증을 통과했다.

## 최종 검증

| 구분 | 결과 / 근거 | 한계 |
|---|---|---|
| 웹 일반 desktop/mobile | 실제 다중 소속·긴 이름/주소, 고정 header/Add New Office, 본문 함께 scroll, 닫기/포커스, 기존 추가경로 통과 | 추가 병원을 생성하지는 않음 |
| 웹 일반 전환 | 기존 실제 활성화 API로213(86)→387(145)→213(86) 및 원복 | 테스트계정 |
| 웹 알림 desktop/mobile | 현재 카드/이름 옆 count, 긴 문구, scroll, 실제 활성화·토스트·알림함 재열기·원복 통과, pageerror0 | count/단일 소속은 fixture |
| 웹 Lab 공유 영향 | 기존 모달 표시/닫기 유지 | synthetic 소속/미읽음, 실제 Lab 전환 아님 |
| Office 일반 양OS | Payment 진입/복귀, 실제 소속전환/재진입/원복, 현재·Payment 고정/목록 scroll, 긴 이름·주소 통과 | iOS는 렌더 handler/native scroll와 실제 화면·좌표 확인, Android는 실제 tap/swipe 사용 |
| Office 알림 양OS | 기존 문구/현재 카드/이름옆1·2·3자리 숫자, 상단고정/하단scroll, 실제 활성화·재오픈/원복 통과 | actual other-unread GET은0건. 기존 소속 ID를 사용하는 임시 응답 fixture로 표시 조건만 구성 |
| Payment 권한 양OS | OWNER=true, PAYMENT_MANAGER=true, MEMBER=false | React Query의 임시 권한 조건. 비OWNER 실제 서버권한 QA를 한 것은 아님 |
| 단일 소속 양OS | 다른 소속0개에서 빈 heading/list 제거, 현재·Payment 유지 | 임시 user.employee fixture, 복원 확인 |
| 작은 Android 화면 | 임시1080×1740, 논리높이662.86에서 알림 내부목록401.90로 제한·화면내 유지 | 원래1080×2400로 원복 |
| 크래시 | 새 iOS Dentlink/SpringBoard report 없음, Android crash buffer는 시작 전후 동일 | 이전 native/ANR 원인의 해결 선언이나 전체 기능 QA 아님 |

최종 코드로 앱을 다시 실행한 후 확인했다. iOS XCTest/Maestro는 과거 SpringBoard 문제 때문에 사용하지 않았다. 기존 DEV 바이너리에 해당 checkout의 최종 JS를 Metro8081로 공급했으며 새 네이티브 빌드를 수행한 것은 아니다. 두 기기 모두 원래 소속86/employee213·8개 소속과 원래 service 함수를 복원했고 임시 권한/user/other-unread 변경이 남지 않음을 확인했다.

마감 시 이번 검증용 웹3000/3005·테스트브라우저9233, Office 앱 실행·Metro8081·이번에 시작한 Android 에뮬레이터를 종료했다. 기존 사용자 브라우저/창 배치를 바꾸거나 처음부터 booted였던 iOS 기기를 shutdown하지 않았다.

정적검사:
- 웹 Clinic/Lab/Admin 타입검사, 기존 알림 회귀9개, 수정파일lint·diff-check·push hook 통과.
- 웹 i18n audit/check는 기존 `SigninForm`의 `account.auth.actions.logIn` 누락/8개 locale stale로 실패. 이번 번역파일 변경 없음.
- 앱 수정5파일 ESLint·diff-check 통과. 전체 tsc는 기존6진단(Icon2,Tooltip1,MessageText1,useOrderAddProduct2)으로 실패하며 변경파일 신규0.

로컬 근거(임시 파일이며 장기 정본은 위 결과):
- `/tmp/office-selector-runtime-proof.json`, `/tmp/office-selector-final-footer-proof.json`, `/tmp/office-selector-single-proof.json`, `/tmp/office-selector-lab-runtime-proof.json`
- `/tmp/selector-normal-flow-proof-1109.json`, `/tmp/selector-roles-empty-proof-1109.json`, `/tmp/selector-notification-proof-1109.json`, `/tmp/selector-small-screen-proof-1109.json`, `/tmp/selector-crash-final-proof-1109.json`
- 대표 이미지 `/tmp/office-selector-normal-desktop.png`, `/tmp/office-selector-normal-mobile.png`, `/tmp/office-selector-notification-mobile.png`, `/tmp/office-selector-ios-normal-1109.png`, `/tmp/office-selector-ios-notification-scrolled-1109.png`, `/tmp/office-selector-android-notification-scrolled-1109.png`, `/tmp/office-selector-android-small-1109.png`

## 남은 사항

이번 승인된 구현 범위는 완료했다. 알림 모달 새 문구는 PM 확정 후 교체한다. OS 배지 방식은 계속 회의/결정 대기이며 변경하지 않았다. 실제 알림 집계/푸시 등 기존 BE·정책 대기 항목은 이 UI 검증으로 완료 처리하지 않는다. Lab 앱·Lab 일반 선택/밀링·이메일 작업은 확장하지 않는다. 사용자가 다음 작업 또는 명세를 전달하면 현재 checkpoint부터 재개한다.
