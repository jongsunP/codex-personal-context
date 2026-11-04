# Dentlink 통합알림센터 — 현재 체크포인트

최종 구현 마감: 2026-11-04 — PM의15:49 수정 요청에 따라 **치과 Credits Email 수신 채널을 Web/Office UI에 추가**했다. Web `873fb2556`, Office `826eebd` commit/push·원격 일치/clean 확인, PC/모바일 웹·앱 양 OS 영향 화면 검증 완료. 앞서 완료한 Lab 밀링 결제 알림 제외(`5d21853`)는 유지한다. USER 단위 알림은 정책·와이어프레임 후속 공유 예정이며 새 BE 계약·실제 저장 연결은 계속 대기다. PR·merge·배포·최종 QA 완료가 아니다.

이전 구현 마감: 2026-11-03 19:19 KST — **Office/Lab 설정 파란 OS 배너의 기기별 1회 영속 처리** 보완·검증·양 앱 commit/push 완료. 이번11/4 작업은 Lab 제외 항목만 반영했으며 배너·인증·OS 권한·실제 서버 수신 설정은 변경하지 않았다.

- **현재 지시:** 확정된 Lab 제외 반영 후, 추가로 전달한 Slack을 확인하고 처리하라는 승인에 따라 치과 Credits Email UI까지 반영했다. BE 명세·USER 단위 정책/와이어프레임 또는 사용자 재개 요청을 기다리며 자동 구현·폴링·서버 재실행을 하지 않는다.
- **추가 자료 확인 — 2026-11-04:** Jira 댓글44798의 설정 템플릿 초안을 현재 세 제품 코드와 대조했고, 후속44802에서 Lab 밀링 결제 제외를 확인했다. 템플릿 초안 자체는 공개 API·BE 배포 완료 근거가 아니다. 후속 구현은 아래 제외 항목 반영에 한정한다.
- **상태 읽는 순서:** 이 문서의 최신 상태 → [앱 화면별 실행 근거](dentlink-unified-notification-center-runtime-2026-11-03.md) → 필요할 때 [11/3 단계별 구현·검증 이력](archive/dentlink-unified-notification-center-2026-11-03-worklog.md). 과거 HEAD/입력 대기/서버 유지 문구를 현재로 재사용하지 않는다.
- **기획 근거:** Notion 정책서와 확인한 Figma/Slack을 대조하되 최신 명시적 사용자 정정을 우선한다. 오늘 필요한 PRD 5-2~5-5/#14는 재대조했고 일부 조회 누락 블록이 있어 전체 본문·댓글을 완전 최신 조회했다고 주장하지 않는다. 이번 마감은 외부 자료 전수 재조사가 아니다.

## 2026-11-04 앱 심사 일정·네이티브 영향 확인 — 읽기 전용

- 사용자 지정 [FE 스레드](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793784745210489)의 부모18:32:25 및 답글6개(마지막18:37:05 KST, 더 없음)를 확인했다. Daniel은 라이브러리 변경으로 이번 주 심사·다음 주 월요일11/9 배포를 생각하지만 요일은 유연하며 병원앱도 가능하면 함께 올리겠다고 했다. Joy는 주문 상세 작업을 다음 날 마무리할 것으로 보고 동시 배포 여부를 검토 중이다. 심사 제출·배포 완료나 알림센터 포함 확정이 아니다.
- Frankie의18:36:57 답변은 “현재 기준 네이티브 변경은 없을 것 같지만 다시 검토 후 답변”이라는 잠정 의견이다. 실제 누적 diff에는 양 앱 Android 네이티브 변경이 남지만, **이메일을 제외한 확정 요구사항 때문에 새 네이티브 변경·심사가 필수라는 뜻은 아니다.** 사용자 후속 지적에 따라 코드의 잔존과 요구사항의 필요성을 구분해 재검토했다. 앞서 모듈의 존재만으로 심사 빌드 포함을 우선 안내한 판단은 부정확했다.

| 제품 | 현재 feature / 비교 기준 | 실제 기능 누적 네이티브 변경 |
| --- | --- | --- |
| Office | `826eebd`, upstream 일치·clean. fetch 후 main과 merge-base 모두 `7f586790` | `android/app/src/main/java/com.innovaid.android.dentlink/BrowserPackage.kt` 신규40줄 + `MainApplication.kt` 등록1줄. 최초 추가 `9ae3cf3` |
| Lab | `5d21853`, upstream 일치·clean. fetch 후 main `26623e0`, merge-base `5144103`, main-only4/feature-only14 | 같은 위치의 `BrowserPackage.kt` 신규40줄 + `MainApplication.kt` 등록1줄. 최초 추가 `28ebcd8` |

- 두 앱 모두 merge-base→feature 기준 iOS/entitlements/Manifest/Gradle·Podfile/lock/package 의존성 변경은 없다. Lab 최신 main에만 들어온 기존 밀링/배포 변경을 feature 신규 변경으로 잘못 세지 않았다. 새 npm 라이브러리·OS 권한은 추가하지 않았다.
- **잔존 원인:** 모듈은 Office `9ae3cf3`·Lab `28ebcd8`의 이메일 HTTPS 진입 작업에서, 미지원 웹 링크를 브라우저로 돌릴 때 앱으로 재진입하는 것을 막으려고 추가됐다. Office `b78947f`, Lab `04cfe7f`에서 이메일용 도메인/OS 연결은 분리했지만 이 모듈과 JS 호출은 남겼다. 현재 공통 알림 경로가 호출한다는 사실만으로 새 native가 필수인 것은 아니다.
- **확정 범위 재검토:** Office에는 portal HTTPS 앱 등록이 더 이상 없고 기존 scheme/Airbridge만 남는다. Lab의 자체 웹 등록은 기존 `/q/*`이며 `resolveIncomingUrl`에서 QR을 먼저 처리해 앱 scheme 또는 null로 끝나므로 현재 일반 browser fallback을 거치지 않는다. 지원 노티/푸시 URL은 기존 앱 화면/action으로 변환된다. 남은 일반 미지원 HTTPS는 기존 `Linking.openURL` 재사용으로 처리할 코드상 근거가 있다. 다만 기존 Airbridge 도메인은 앱에 계속 등록돼 있어 raw URL을 무조건 일괄 치환하지 않고 분기·회귀를 확인해야 한다.
- **전달 영향:** 현재 구현을 그대로 유지하려면 이 모듈이 Android 바이너리에 포함돼 있어야 한다. 현재 origin/main에는 없으며, 모듈이 없는 구 바이너리에 JS만 배포하면 해당 브라우저 열기는 catch 후 false로 끝난다(현재 Android에 Linking 대체 경로 없음). 이것을 앱 전체가 반드시 크래시한다거나 모든 알림 화면에 새 native가 필요하다는 뜻으로 확대하지 않는다. iOS는 기존 Linking 경로이며 이번 기능 누적 native 변경 없음.
- **다음 시작점:** 추가 심사를 전제로 삼기보다 알림센터 범위에서 불필요해진 native 의존을 기존 JS 기능으로 정리할 수 있는지 우선 처리한다. 사용자 후속 구현 지시를 받은 뒤 모듈·등록·호출을 함께 정리하고 지원 노티/푸시, 미지원 HTTPS, 소속 실패, 기존 Airbridge/Lab QR 경계를 양 OS에서 검증한다. 이번은 소스 감사만 했으며 대체 구현·기기 검증·CodePush 호환성 확정은 아직 하지 않았다. 현 요구사항만으로 별도 심사 필요를 단정하거나 이메일 작업을 다시 포함하지 않는다.
- 이번에는 코드·branch/worktree·PR·릴리즈·배포·runtime·Slack/외부 문서를 변경하지 않았다. 필요한 main/feature ref만 fetch하고 두 저장소의 정확한 누적 diff/소비자를 읽었다. 실제 포함 여부·통합은 사용자 후속 지시에 따른다.

## 2026-11-04 PM 수정 요청 — Credits 메일 및 USER 단위 알림 예고

- 사용자 요청: [수정 작업 공유 스레드](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793774409809179)를 확인하고 처리할 사항이 있으면 진행. 부모15:40:09 및 [Yoonie 답글15:49:02](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793774942782799), 답글1개/더 없음까지 읽었다. Slack은 읽기 전용이며 게시·반응·읽음 상태 변경·폴링은 하지 않았다.
- **이번 확정 변경:** 치과 Credits 수신 채널에 Mail 추가. 연결된 [Notion OFFICE 권한별 표](https://app.notion.com/p/innovaid/3c7ce072e82f811184a8e647444f01fd#3470192568044aeca30c23b5d747e6a7)와 Slack 첨부 `F0CEP5HTP0E` 이미지를 직접 대조했다. Credits는 모든 역할에 허용되고 Notification/Push/Mail을 지원한다. Web은 기존대로 Push를 숨기고 Email만, Office 앱은 기존 Push에 Email을 추가한다. Lab 변경은 없다.
- **자료 최신화 범위:** Notion 반환 편집 시각15:45:28 KST. 해당 권한표는 Mail이 추가됐지만 위 가입 기본값 표의 Credit Mail은 아직 `-`다. 지원 채널은 최신 PM 명시 지시로 반영하되, 서버 초기값·기존 사용자 마이그레이션을 확정하지 않는다. 페이지 응답은 truncated/unknown block1개이므로 전체 본문·모든 댓글을 완전 재검토했다고 주장하지 않는다.
- **정책·와이어프레임 후속 공유 예정:** USER 단위에 Promotion(SMS, MAIL), Benefits > Credit(PUSH, MAIL)을 추가/정리하겠다는 예고다. 기존 Promotional SMS·Promotional Mail(도스 추가 요청)·유저 크레딧 메일/푸시를 설명한 AS-IS와 TO-BE를 기록한다. 이번에 새 화면·섹션·진입점·서버 계약을 만들거나 기존 수신 동의를 옮기지 않는다.
- **USER 후속 적용 기준:** 현재 Employee/소속별 설정과 USER 설정을 구분한다. 표시 위치, 기존 Credits와의 관계, 소속 전환과 무관하게 유지할 값, 조회·저장·알림 귀속은 예정된 정책/와이어프레임/BE 계약을 받은 뒤 대조한다. 알림 설정의 Mail 수신 채널이며 별도 이메일 CTA·SES·앱 설치 랜딩 작업을 재개한 것이 아니다. 지금 불필요한 확인 질문을 추가하지 않는다.
- **선행 구현 범위:** Web Clinic `notificationMockData.ts`의 Credit에 기존 Email 채널 배열을 연결하고, Office `useNotificationMockStore.ts`의 Credit에 기존 `email()`을 추가했다. 새 문구·번역·식별자·API·USER 범위 모델은 추가하지 않았다. Web 상위 초기 OFF/Office 초기 ON 등 기존 mock 예시는 유지하며, 신규 채널의 mock 표시값을 서버 기본값으로 취급하지 않는다. 실제 저장은 신규 BE 명세 연결 때 구현한다.
- **검증:** Web 실제 OWNER 저장 로그인으로 PC1280/모바일390에서 Credit ON→Email 표시, Email만 OFF 시 상위 유지, 상위 OFF/ON과 채널 복원·뒤로 확인. Lab 양언어 데이터 불변·Web Push 미노출 확인. 필수3서비스 타입/lint 오류0·admin9/shared21+32 통과. Office는 최종 코드의 Android OWNER/iOS MEMBER에서 Email/Push 각각 변경 시 다른 채널 유지, 부모 OFF/ON·복귀를 확인했다. Email은 실제 기기 탭, 일부 다른 토글은 원래 onPress 실행과 native 렌더/state 대조 근거로 구분한다. 양 OS 관찰된 fatal/render loop0, 실제 OS 권한/서버 설정은 변경하지 않았다.
- **독립 코드 검토:** 추가 결함 없음. 기존 소속별 mock 갱신/초기화, 권한 노출, 상위/하위 변경 로직을 재사용한다. Office OS 차단 조건은 `channel.key === 'push'`에만 적용되어 Email을 차단하지 않는다. 실제 OS OFF 전환은 이번 실행에서 하지 않았으며 해당 조건은 소스 근거다. BE 저장/실제 메일 발송·전체 QA·merge 준비 완료는 아니다.
- **전달·마감:** Web `873fb2556bee54bcc2bfe836478048cb78ee91c9`, Office `826eebd110eaf48c8c1c2bacb4690d09a637cb1c` 각각 commit/push·원격 SHA 일치·clean 확인. 임시 Clinic3000·Office8081·전용 브라우저·양 기기/DeviceHub 창 종료, 로그인·기존 권한·데이터 보존. Lab은 `5d21853` 그대로이며 재실행/수정하지 않았다. PR·외부 문서/댓글 변경 없음.
- **실행 근거:** `/tmp/notification-credit-web-1104-final.md`, `/tmp/clinic-credit-email-1104-{1280,390}.png`, `/tmp/office-credit-mail-runtime-1104.md`. 실제 서버 저장이나 메일 발송까지 완료했다고 표현하지 않는다. 개인 정본 기록·commit/push 후 대기한다.

## 2026-11-04 BE 설정 템플릿 초안 확인 — 수정본 기준

- 정본: [DL-16140 댓글44798](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=44798), Leo. 작성12:23:26, **최종 수정12:29:28 KST**. 설정 조회를 템플릿/개인설정으로 나눌 예정이며, 현재 댓글은 **치과(OFFICE)·기공소(LAB) 예시가 구분**돼 있다. 템플릿 설계 예시이며 공개 API·BE 배포 완료 공지가 아니다.
- 최신 필드는 `orderScopes`, `categories[{domain,category,toggleChannel,channels}]`다. `defaultChannel`·`orderScopeOptions`는 최초12:23 버전에 있던 이름이며 현재 필드로 재사용하지 않는다.
- Office는 범위 `ALL_ORDERS`/`MY_ORDERS_ONLY`와 설정8개다. CHAT/LINKTALK(PUSH, 추가채널 없음), ORDERS/DESIGN_CONFIRMATION·ORDER_UPDATES(NOTIFICATION, PUSH/MAIL), ORDERS/FEEDBACK·SHIPPING(NOTIFICATION, PUSH), USERS/CASE_PREFERENCE(NOTIFICATION, PUSH/MAIL), PAYMENTS/PAYMENTS(NOTIFICATION, MAIL), BENEFITS/CREDITS(NOTIFICATION, PUSH). 이는12:29 BE 예시 기준이다. **후속15:49 PM 요구로 Credits MAIL을 UI에 추가했으므로 실제 catalog/설정 명세 연결 시 이 채널이 반영됐는지 대조한다.** 웹은 Push 표시를 제외한다.
- Lab은 `orderScopes:null`, CHAT/LINKTALK·DENTLINK_SUPPORT(PUSH, 추가채널 없음), ORDERS/DESIGN_CONFIRMATION·ORDER_UPDATES(NOTIFICATION, PUSH), MANUFACTURING/MILLING_ORDER_UPDATES(NOTIFICATION, PUSH)의5개다. Support Push와 밀링 주문 업데이트는 **이미 예시가 있다**. 기존 Lab UI의6개 중 밀링센터 결제만 예시에 없었으나, 후속 답변44802에서 **범위 제외**로 해소됐고 아래 승인 구현으로5개에 맞췄다.
- **이 초안에 남겨둔 BE 질문은 해소:** 밀링센터 결제의 domain/category를 추가 요구하지 않는다. 병원/기공소 구분, Support, 밀링 주문 업데이트, 과거 이름 `defaultChannel`도 다시 묻지 않는다. `toggleChannel`/`channels`는 현재 상위/하위 UI 구조와 대응 가능하며 개인설정 조회·저장 초안이 나오면 독립 ON/OFF 상태·식별자·초기값·숨긴 채널 보존을 대조한다.
- BE domain/category를 화면 배치 그대로 노출할 의무는 없다. Shipping·Case Preference·Credit의 독립 영역과 표시는 FE가 가공하고 원래 row 식별자를 보존한다. 필드·정렬·표시명·기존 authority 기반 노출 제한 때문에 불필요한 신규 API를 먼저 요구하지 않는다.
- 검토 근거: Web `shared/ui/src/NotificationUI/notificationMockData.ts`·`NotificationSettings.tsx`, Office/Lab `src/store/useNotificationMockStore.ts` 및 설정 화면/타입. Web `d11fb8759`, Office `b57bfbe`, Lab `1fbcacc`에서 읽기만 했다. Figma/Notion 전수 재조사·제품 코드/branch/PR/runtime·외부댓글 쓰기는 하지 않았다.
- **조사 정정:** Codex가 최초12:23 버전을 읽은 후12:29 수정본을 재조회하지 않고 ‘기공소 예시 여부/Support·밀링 전체 코드/defaultChannel 의미’의 질문을 안내했다. 사용자 지적 후 원문 재조회로 오류를 확인·사과했다. [사용자 답글44800](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=44800)의 마지막 수정12:38:15에는 defaultChannel과 Support·밀링 결제/업데이트 질문이 남아 있었다. 사용자가 수정할 복사문은 **밀링센터 결제 한 항목만** 남기며 Codex가 외부 댓글을 직접 수정하지 않는다. 이전 커밋83af533/4762a9e의 초안 표현은 이 정정으로 대체한다.
- **사용자 최종 질문 확인:** [새 답글44801](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=44801), 2026-11-04 12:43:26 KST에 **‘기공소의 밀링센터 주문 > 결제 항목은 어떤 domain/category로 제공되는지’만 질문**한 것을 확인했다. 이전44800은 현재 댓글 목록에 없고 최종 질문 정리는 적절하다. 이 질문의 후속 답변은 아래44802로 반영했다.
- **최신 BE 답변 확인:** [Leo 답글44802](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=44802), 2026-11-04 13:06:40 KST: “기공소 밀링센터 주문 > 결제는 알림센터 스펙 아웃입니다!” 기존11/3 PRD #14/Figma 근거의 유지 판단보다 최신인 명시적 범위 답변이다. 해당 항목은 알림 설정·알림 샘플에서 제외할 대상으로 정리한다. **밀링 주문 업데이트·실제 밀링 업무 결제 기능·Clinic/Office 결제/크레딧/추가 조회 화면은 제거하지 않는다.**
- **Jira 확인 단계의 경계:** 당시에는 제품 코드·runtime·Jira/Notion/Slack을 변경하지 않았고 Web `d11fb8759`/Lab `1fbcacc` clean을 확인했다. 후속 사용자 승인으로 아래 최소 구현만 진행했다. Swagger는 다시 조회하지 않았으며 **마지막 확인12:33에는 신규 설정 계약이 미반영**이었다. 이 답변을 새 API 배포 완료로 해석하지 않는다.

### 후속 승인 구현·검증 — 2026-11-04

- Web `shared/ui/src/NotificationUI/notificationMockData.ts`의 Lab 밀링 결제 설정5줄 제거. Clinic ko/en 전체 mock 데이터는 이전 HEAD와 동일하고, Lab 인박스 `mock-payment`는 실제로 밀링 주문 업데이트를 표시하므로 보존했다.
- Lab 앱 `src/store/useNotificationMockStore.ts`의 결제 설정·결제 예시 알림17줄 및 해당 항목에만 쓰이던 `notificationPayment` en/ko·registry10줄 제거. 남은 참조 없음 확인. 실제 밀링 업무 결제, 밀링 주문 업데이트, Clinic/Office 결제·크레딧·추가 목록은 그대로다. 현재 Lab README/AGENTS의 로컬 번역 관리 기준을 적용했으며 Google Sheet는 수정하지 않았다.
- 검증: Web 필수 Clinic/Lab/Admin 타입·lint 오류0(기존 경고 유지), admin guard9·shared21/32 테스트 통과. Lab 변경4파일 ESLint·diff 통과, 명시한 `jest.config.js`로 기존 번역 테스트3/3 통과. 첫 Jest 시도의 다중 config 선택 오류는 명시 config로 해소했고 제품 설정을 바꾸지 않았다. 독립 diff 검토에서 추가 결함 없음.

| 최종 코드·실행 조건 | 영향 화면·행동 | 결과 / 한계 |
| --- | --- | --- |
| Web Lab `08505823a`, 저장 로그인, PC1280·모바일390 | 설정→뒤로→전체 인박스 | 결제 설정 없음, 주문/밀링 업데이트 유지, JS pageErrors0. Headless 실제 브라우저 검증이며 사용자 표시 창 조작은 아님. Clinic은 변경 없는 ko/en 데이터 전체 대조 및 이전 실행 근거 재사용 |
| Lab Android `5d21853`, 기존 INTERNAL·OWNER·DIRECTOR 단일 소속, OS ON | Home 벨→전체 인박스→설정→밀링 상위/Push OFF·ON→소속 시트→재진입·Home | 각 mock 소속3알림·5설정, 결제 없음·밀링 업데이트 유지. 실제 탭으로 토글 복원, 시트2행 열기/닫기·Home 벨 정상, fatal 관찰0 |
| Lab iOS `5d21853`, 같은 기존 실계정, OS OFF | 같은 화면 경로·밀링 상위 OFF·ON·Push 안내 취소·시트 왕복 | 결제 없음·3알림/5설정 유지. 안내 팝업은 실제 좌표 탭으로 취소, OS 설정 이동 없음. 계정 문맥·원래 mock 소속/토글 유지, fatal 관찰0. OS OFF→ON이나 실제 다중소속 검증은 아님 |

- 양 앱/웹 전체 재검증이나 BE 실제 저장·푸시 읽음·최종 사용자 QA 완료로 확대하지 않는다. 이번에는 API/생성 모델·네이티브 설정·권한 정책·서버 데이터·새 메뉴·새 테스트 파일·PR·외부 문서를 변경하지 않았다.
- 세부 증거: `/tmp/notification-web-1104-final.md`, `/tmp/lab-settings-1104-{1280,390}.png`와 대응 inbox 캡처. 앱은 `/tmp/lab-milling-removal-runtime-20261104.md`, `/tmp/lab-milling-{ios,android}-1104-{inbox,settings,milling-off,sheet,reentry,home}.png`. 앱 기본 `yarn start`의 오래된 debugger 옵션은 현 CLI에서 거부되어 제품 파일 변경 없이 `yarn react-native start --port 8082`로 검증했다.
- **로컬 마감:** 이번 실행한 Lab Web3005·Metro8082·전용 headless 브라우저·Android AVD·iPhone17Pro/DeviceHub 창을 종료했다. 기존 로그인/앱 데이터/권한/배너 이력은 보존했다. Office Metro·제품 코드는 재실행/수정하지 않았다. 개인 체크포인트를 원격 보존하고 확정 계약 또는 사용자 재개 요청을 기다린다.

### 후속 DEV Swagger 확인 — 2026-11-04 12:33 KST

- 사용자 지시: 실제 Swagger에 있으면 가능한 계약 범위로 진행하고 없으면 인지/정리/메모리한다. [DEV OpenAPI 원문](https://dev-api.dentlink.io/v3/api-docs)을 직접 HTTP GET하여200 확인. 웹 열기 도구는 접근 오류였으나 직접 조회는 성공했다. 974 paths/1490 schemas, SHA256 `65e61e41dbd9547954ec082bee3b3bffc59a20861a36f5ec53b522959d507028`, 근거 `/tmp/dentlink-notification-swagger-20261104.json`.
- **결과: 새 설정 템플릿·개인설정 계약은 공개 DEV Swagger에서 미확인.** 전체 path의 summary/description/operationId·schema/property를 대조했다. 최초 이름 `orderScopeOptions`/`defaultChannel`뿐 아니라 수정본 `orderScopes`/`toggleChannel`도 이12:33 응답에0건임을 후속 독립 대조했다. BE 내부 구현 여부나 미공개 endpoint 존재까지 부정하지 않는다.
- 이름이 비슷한 기존 API는 대체 계약이 아니다. `/admin/messages/templates/notifications`는 제목/본문/타입/랜딩을 관리하는 관리자 발송 템플릿, `/codes/preference`는 `key/optionValues[]` 코드, `/app/users/own/push-preferences`는 `preferenceId/pushEnable/enablePersonalOrders/settings[{id,type,enable}]`의 구 앱 설정이다.
- 따라서 이번 조건부 구현은 시작하지 않고 수정된 초안과 최소 확인사항만 기록한다. 제품 코드/API 생성물·branch·PR·서버·기기는 그대로 종료 상태다. 후속 명세/답변을 받으면 실제 공개 계약을 다시 대조하며 그 전 자동 조회·폴링은 하지 않는다.

## 2026-11-03 요구와 마감 상태

| 요구 | 오늘 처리와 현재 상태 |
| --- | --- |
| 알림센터·앱 추가 목록·이메일 범위 분리 | Notion/Jira/개인 정본 분리와 원 조사 세션 인계 완료. 승인 후 코드에서도 이메일 전용 native/association 설정만 분리했고 노티/푸시의 공통 URL 처리·기존 Airbridge/Lab `/q/*`는 유지 |
| FE가 할 수 있는 디자인·연결 선행 작업 | 기존 알림 UI를 유지·보완하고 Web/Office 실제 소속 활성화·Web 팝업/토스트·공통 랜딩 연결을 보완. 실제 알림 데이터/설정 저장/집계/읽음은 DEV mock 및 BE 계약 대기 |
| 추가 Office 조회 목록을 웹 모바일 기준으로 구현 | Credits/Statements 및 기존 REST는 이전 선행 구현. 오늘 크레딧 배지·긴 설명·소속/권한/진입·뒤로를 보완/검증. 별도 메뉴·PDF·Pay Now·미확정 결제내역을 추가하지 않음 |
| 권한·제품·기기별 알림 설정 메뉴 | MEMBER 범위 선택 숨김·담당 범위 고정, OWNER/PAYMENT_MANAGER만 Payments, Web Clinic Shipping 추가. Lab My Orders/Email/SMS 제외·Web Push 미노출 유지. Lab 밀링 Payments는11/3 당시 PRD #14/Figma 근거로 유지했으나 **11/4 Leo 답변44802로 범위 제외·후속 코드 제거 완료** |
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

2026-11-04 최종 후속 마감: 기존 checkout/branch/worktree를 유지했다. Web은 Lab 밀링 결제 제외와 Clinic Credits Email, Lab은 밀링 결제 제외, Office는 Credits Email까지 각 commit/push·원격 SHA 일치/clean 확인했다. 작성 담당들은 검증·정리를 끝내고 제어권을 반환했다.

| 제품 | checkout | branch / upstream | 원격 반영 HEAD |
| --- | --- | --- | --- |
| Web | `/Users/parkjongsun/Repository/dentlink-client-notification-center` | `feature/DL-17058` / `origin/feature/DL-17058` | `873fb2556bee54bcc2bfe836478048cb78ee91c9` |
| Office | `/Users/parkjongsun/Repository/dentlink-app` | `feature/DL-17059` / `origin/feature/DL-17059` | `826eebd110eaf48c8c1c2bacb4690d09a637cb1c` |
| Lab | `/Users/parkjongsun/Repository/dentlink-lab-app` | `feature/DL-17060` / `origin/feature/DL-17060` | `5d21853bb7cd2efa17fbe65d13a0c3cf35442ee1` |

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

- **11/4 Credits Email 후속 마감:** Clinic Web3000/Office Metro8081·전용 브라우저·양 OS 기기/DeviceHub 창을 실행해 영향 검증한 뒤 종료했다. 기존 로그인·권한·앱 데이터는 보존했다. 앞선 Lab 검증 서버/기기도 계속 종료 상태다.
- **11/4 후속 검증 마감:** 위 밀링 결제 제외 검증에 필요한 Lab Web3005/Metro8082·iOS/Android만 잠시 실행 후 종료. 3000/3005/8081/8082/9233 listener 없음, adb 기기 없음, booted simulator 없음을 재확인했다. 아래11/3 보관 로그인·Keychain·기기 데이터는 그대로다.
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
- **Office Credits Mail 추가:** 11/4 15:49 PM 수정 요청으로 Web/Office UI의 Email 수신 채널을 추가했다. 서버 초기값·저장·마이그레이션은 명세 확인 대상이다. USER 단위 Promotion/Benefits 알림 추가는 별도 정책·와이어프레임 공유 예정이며, 현재 Employee 설정을 임의로 이관하지 않는다.
- **Lab 밀링센터 주문 > 결제 제외:** 11/4 Leo 답변44802 기준으로 mock 설정/샘플 제거 완료. 밀링 주문 업데이트는 유지한다. 이 결정은 실제 밀링 업무 결제나 Clinic/Office 결제·크레딧의 제외를 뜻하지 않는다.
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
- **11/4 후속 정책 대기:** USER 단위 Promotion(SMS/MAIL), Benefits > Credit(PUSH/MAIL)의 정책·와이어프레임을 받으면 현재 Employee 설정과의 경계 및 화면/계약을 대조한다. 현재 Credits Mail 지원은 먼저 반영했으나 실제 초기값·저장 계약을 추측하지 않는다.
- **앱 전달 전 필수 확인:** 이메일 분리 후 잔존한 Android `DentlinkBrowser` 의존의 필요성을 재검토했고, 확정 알림센터 요구 때문에 추가 심사가 필수인 근거는 없다. 기존 JS 방식으로 정리·회귀 검증할 일이 남아 있다. 현재 feature에 native2파일이 남은 상태를 수정 완료/CodePush 호환 확정으로 표현하지 않는다. Lab main-only4커밋의 반영 여부도 실제 통합 전에 대조하며 자동 merge/rebase는 하지 않는다.
- **누락 보완 이력:** 11/3 배너 영속 보완,11/4 후속 승인에 따른 Lab 밀링 결제 알림 제외까지 완료했다. 다음은 공개 BE 계약을 실제로 확인한 범위부터 이어가며, 임의 API/정책 가정이나 자동 조회·폴링은 하지 않는다.

## 정본 자료·Jira·이력

- 정책: [Notion PRD](https://app.notion.com/p/innovaid/3c7ce072e82f811184a8e647444f01fd). 화면: [Figma](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=2-6). 원 기획: [FigJam](https://www.figma.com/board/U9Qpm6ACzjGFKyrCoaAuvA?node-id=33-3714).
- 결정 근거: [UX 논의](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793063024060739), [푸시 클릭/읽음](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793244658608799), [앱 추가 목록 회의](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793596568281269). 최신 명시적 사용자 정정과 날짜 있는 후속 결정을 오래된 문장보다 우선한다.
- 알림센터 상위 [DL-16140](https://innovaid.atlassian.net/browse/DL-16140). 공통 DL-17057, Web DL-17058/17061/17062, Office DL-17059/17063/17064/17065, Lab DL-17060/17066/17067/17068, UX 사전 검토 DL-17048. 실제 카드 상태·범위는 재개 시 확인하며 카드명만으로 제외 범위를 복원하지 않는다.
- 추가 목록: DL-17174→DL-17202, 후보 검토 DL-17179. 원본 앱 비교 세션 역할은 [모바일웹/앱 차이 체크포인트](dentlink-mobile-web-app-parity.md)를 참조한다.
- 마지막 DEV Swagger 조사: **11/4 12:33 KST**. 설정 템플릿 초안과 같은 신규 계약은 미공개이며 위 후속 확인에 근거를 남겼다. 11/3 기존 목록·부분/전체읽음·미읽음·구 preference 검토는 [당일 14:05 점검 이력](archive/dentlink-unified-notification-center-2026-11-03-worklog.md), Office Support 404와17:40 공개 계약 불일치는 실행 기록을 따른다.
- 과거 FE API 제안서는 확정 BE 계약이 아니다. 상세 조사·UX 합의·소스/기기 증거·공수 산정·이전 정확한 Git 이력은 [2026-11-03 분리 전 전체 이력](archive/dentlink-unified-notification-center-through-2026-11-03.md)에 보존했다. 과거 ‘현재/다음’ 지시는 최신 범위를 되돌리지 않는다.
- **11/4 산정 역추적 완료:** [Tom의 Slack](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793765218878199)은 AI로 Jira 카드를 만드는 것은 좋으나 스토리포인트 점검이 필요하다고만 했다. 사용자는 통합알림센터를 지적했을 가능성을 제시했지만 특정 카드·기간 과다·잘못된 근거는 원문에 없다. 이후 메인세션에서 사용자 요청으로 FE 하위13개와 [공통 설계 DL-17057](https://innovaid.atlassian.net/browse/DL-17057), [상위 일정 댓글44666](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=44666)을 읽었다. 현재 등록 합계31SP와 당시 병행13작업일/잔여12일 설명을 확인했으며 오늘의 잔여공수로 해석하지 않는다.
- **검토 결과:** 합산 `37-7.5+UX1+설계0.5=31SP`는 맞고 Lab의 Office 패턴 재사용도 이미 반영돼 있다. 다만 31SP=186시간과 사용자1명+Codex의13일=78사람시간을 연결하는 측정 기준·생산성 근거, `1+0.5+max(8.5,11.5,9.5)` 병행식의 공통 인간 검토/통합·선행 관계, 카드별24시간/18시간 등 계획치를 뒷받침하는 비교·실측 근거가 부족하다. 별도QA를 빼면서 필수 최종 앱 검증은 유지한 공수 배분도 불분명하다. 검토 요청은 타당하지만 명백한 과다 산정·중복 계산이나 Tom의 실제 지적 이유가 입증된 것은 아니다. PM의 기존 구두 일정 싱크 댓글44669도 보존한다.
- **사용자 결정:** 원문·Jira 점수·기존 일정은 수정하지 않고 앞으로 [공통 산정 지침](../DEVELOPMENT_STYLE.md#dentlink-story-point-estimation)을 적용한다. 이번은 읽기 전용 역추적과 개인 지침 정비이며 새로운 점수·납기를 확정하지 않았다. 사용자 요청대로 기록 정리 후 대기하고 별도 지시 없이 기존 카드를 재산정하거나 제품 작업을 재개하지 않는다.

## 운영 경계

- 이 세션은 통합알림센터 기능을 Web/Office/Lab 함께 담당하며 [FE 상위 세션](dentlink-fe.md)은 공통 조율을 담당한다. 새 세션·worktree를 자동 생성하지 않는다.
- 제품마다 정확한 저장소·활성 작성자를 확인한다. Web 신규 일반 작업은 최신 origin/master, 두 앱은 origin/main 기반 feat/<Jira>→해당 release→main이다. 11/4 이후 신규 브랜치에는 feat/를 쓰고 기존 feature/ 원본은 별도 지시 없이 바꾸지 않는다. 남은 develop을 신규 기준으로 쓰지 않는다.
- 11/3 사용자가 이번 FE 선행 범위의 구현·검증·세 제품 commit/push를 승인했다. PR 생성·merge·배포는 승인 범위가 아니다. 다음 미정 정책/새 기능을 자동 확장하지 않는다.
- Slack은 읽기 전용이며 자동 폴링은 중단 상태를 유지한다. 팀 공유 문서와 개인 작업 메모를 구분하고 의미 있는 마감에 개인 컨텍스트를 commit/push한다. 제품 commit/push는 해당 작업의 명시적 승인을 따른다.
