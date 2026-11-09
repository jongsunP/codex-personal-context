# 통합알림센터 푸시 클릭 읽음 연결 — 2026-11-09

## 완료 위치

사용자는 확정된 정책 기준으로 FE가 할 수 있는 잔여를 조사하고 있으면 진행하도록 요청했다. 앞서 승인된 구현·검증·commit/push·개인 기록 범위를 이어 수행했으며 PR·merge·배포는 하지 않았다.

| 제품 | 위치·브랜치 | 읽음 연결 | Android 호환 수정 / 최종 HEAD |
| --- | --- | --- | --- |
| Office | `/Users/parkjongsun/Repository/dentlink-app` · `feature/DL-17059` | `78740fc` | `676e7fc6e87783dd6c8dbcef0fbe56600084c0b9` |
| Lab | `/Users/parkjongsun/Repository/dentlink-lab-app` · `feature/DL-17060` | `1e753f8` | `f9ca872b147a1c1ec1faf6320d40d2c9c39588fc` |
| Web | `/Users/parkjongsun/Repository/dentlink-client-notification-center` · `feature/DL-17058` | 기존 REST 연결 유지 | `ed88f08384f624f0171de9fd38cd9dffcc9ec7b2` 변경 없음 |

두 앱의 원격 branch SHA와 HEAD 일치·clean을 확인했다. 브랜치/워크트리는 기존 위치를 유지했다.

## 확정 기준과 구현

- [Jira44950](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=44950) 및 사용자 직접 설명이 기준이다. **PM·BE가 이미 확정한 정책/payload를 새 확인 질문으로 되돌리지 않는다.**
- OS 배지는 새 푸시 수, 로그인/앱 복귀 때 기존 PATCH0, LinkTalk 포함, 다른 소속 포함이다. FE의 새 미읽음 GET·인박스/채팅 합산·-1 차감·unreadCount·실시간 동기화·이메일을 추가하지 않았다. 서버의 다른 소속 발송/집계 적용은 FE 코드 완료와 구분한다.
- `data:{deeplink:"dentlink://order/1409/7000012592",deliveryId:"5521"}`를 받아 숫자 deliveryId로 기존 `PATCH /office/notifications/inbox/read/push` 또는 `/lab/notifications/inbox/read/push`에 `{deliveryId:5521}`을 보낸다. Lab scheme은 `dentlink-lab://`이다.
- 이번 DEV Swagger 재확인: read/push는 직원이 아닌 **사용자 기준**이며 다른 소속의 푸시도 읽음 처리하고 서버 발송 행에 클릭 기록을 남긴다. 소속 전환 성공/랜딩 성공을 읽음의 선행 조건으로 추가하지 않는다.
- FCM initial/opened, Notifee initial/foreground/background PRESS에서 ID를 수집한다. 일반 수신은 읽지 않으며 ID가 없는 기존 푸시도 기존 랜딩/채팅 동작을 유지한다.
- ID는 URL과 별도로 AsyncStorage에 보관하고 로그인·navigation·앱 active 준비 후 처리한다. URL 중복 이동 방지와 ID별 읽음 중복 방지를 분리했다. 같은 URL의 다른 발송ID는 각각 읽고, 같은 ID의 동시 콜백은 1회로 제어한다.
- 계정 세대/사용자 guard, 로그아웃·계정 변경 때 pending 폐기, 요청 문맥 보존으로 이전 클릭을 다른 계정에 넘기지 않는다. hydration 전후 계정 변경도 확인한다. 성공 dedup은 최대500건으로 제한한다.
- 5초 timeout·기존 scoped fetcher를 사용한다. 읽음 실패가 정상 랜딩이나 로그인을 막지 않으며 성공으로 기록하지 않는다. 실패 후 같은 푸시를 다시 누르면 재요청할 수 있다. 자동 무한 재시도/폴링은 없다. 성공 시 해당 사용자/서비스 알림 query를 갱신한다.
- 양 앱 변경은 `asyncStorage.ts`, `fcmHandler.ts`, `RootNavigator.tsx`, `notifications.service.ts`, `useCommonStore.ts` 각5파일이다. 기존 badge reset effect는 변경하지 않았다.

## 실행 중 발견한 Android 기존 호환 오류

- **실제 재현:** 양 앱 Android의 로컬 Notifee 알림을 시스템 알림창에서 눌렀을 때 JS 클릭 callback 이전에 `UnsupportedOperationException: ReactInstanceManager.createReactContext is unsupported`가 발생하고 랜딩/읽음이 실행되지 않았다. 단순 callback 주입 테스트에서는 드러나지 않았고 직접 OS 알림 탭에서 확인했다.
- 현재 source의 RN0.82.1은 legacy ReactInstanceManager 생성이 제거됐으나 Notifee7.8.2가 이를 호출한다. 설치 build151과 source build134/9 차이가 있었지만, 현재 소스에도 같은 원인이 있으므로 재설치만으로 해결되는 문제로 보지 않았다. 운영 배포 바이너리의 동일 재현 여부는 조사하지 않았다.
- **최소 수정:** 실제 postinstall 대상 `patches/native/@notifee+react-native+7.8.2.patch`를 두 앱에 추가했다. Android `NotifeeReactUtils.java` 한 파일의 ReactHost context 조회·초기화, 활성 React instance 대기, UI thread headless 실행, 활성 이벤트 전달 API만 변경했다. 패키지 upgrade·기존 iOS patch·배지 정책은 변경하지 않았다.
- 독립 코드 리뷰에서 context non-null이나 instance 미준비인 cold-start 경합을 발견해 `hasActiveReactInstance`를 진입/실행 직전 모두 검사하도록 보완했다. npm pristine7.8.2에 적용·결과 일치, patch-package 파싱을 확인했다. patch의 빈 context 줄은 unified diff 문법이며 source의 공백 변경이 아니다.
- **배포 경계:** 이 Android 패치는 네이티브 재빌드가 필요하고 JS CodePush만으로 반영되지 않는다. 기존의 ‘이번 범위는 네이티브 변경 없음’ 판단을 이번 수정 이후에도 그대로 재사용하면 안 된다. iOS 네이티브 변경은 없다. 실제 release/store/심사 필요 여부는 적용 대상 Android 바이너리와 배포 방식에 따라 확인하며 이번에는 PR·배포를 하지 않았다.

## 검증 결과와 한계

| 검증 | 결과 | 구분 |
| --- | --- | --- |
| Office/Lab × iOS/Android final JS | 정상 클릭, 같은ID FCM/Notifee 중복, 같은URL 다른ID, invalid/없는ID, 랜딩 실패에도 읽음, 업무 실패 후 재클릭 통과 | 실제 RN 실행·등록 callback + 일시적 네트워크 adapter 제어. 가짜 deliveryId를 실제 BE에 보내지 않음 |
| Office/Lab 로그인/계정 경계 | 로그인 전0요청→준비 후1요청, 익명 클릭→A로그인→로그아웃→B로그인 시 폐기, HTTP403 읽음 실패가 로그아웃을 만들지 않음, 일반 수신은 읽지 않음 | 대표 iOS 런타임에서 auth/readiness fixture. 실제 비밀번호 재로그인 전체를 수행한 것은 아님 |
| Android 네이티브 개발 빌드 | 두 앱 assembleDevelopmentDebug 성공. Office57초/Lab25초 최종 빌드, 각 checkout·8081/8082 | 현재 source로 rebuild/install, 기기/사용자 데이터 초기화하지 않음 |
| Android 실제 시스템 알림창 탭 | 양 앱 background 로컬 알림 탭→각 read/push 요청 정확히1회→인박스 도착 | Notifee 실제 native 이벤트. 읽음 응답은 제어했으며 BE/FCM 실발송 E2E는 아님 |
| Android cold start | 양 앱 프로세스가 없는 것을 확인한 후 기존 형태(ID 없음) 로컬 알림 탭→JS 기동→로그인 유지→인박스 도착 | PID 부재 근거 포함. cold start의 실제 deliveryId 서버 저장은 별도 실발송 확인 |
| 정적·기존 회귀 | Office4 suites54 tests, Lab3 suites22 tests PASS. 변경 lint 오류0, 앱 source diff 검사 통과 | 전체 타입검사의 기존 Office6/Lab5 진단은 유지. lint warning 존재 |
| 안정성·원복 | 최종 화면 정상, 새 iOS Dentlink crash report0, Android crash buffer 전후 동일14322bytes | 중간 Notifee 오류는 nonfatal 이벤트 유실로 별도 재현/수정. crash buffer가 빈 것이라고 표현하지 않음 |

실제 BE deliveryId 발송 데이터가 없어 **실발송→실제 서버 읽음 저장→iOS/APNs·Android/FCM 실기기 전체 흐름은 남아 있다.** 등록 callback·로컬 OS 알림 테스트를 실제 BE 발송 QA 완료로 표현하지 않는다. iOS OS 알림 권한 변경/복귀의 실기기 잔여는 이전 기록대로 별도다.

임시 증거(영구 보존 보장 없음): `/tmp/push-read-{office,lab}-basic-proof-1109.json`, `*-ios-edges-proof-1109.json`, `*-native-android-proof-1109.json`, `*-native-android-cold-proof-1109.json`, `*-cold-process-1109.json`, `/tmp/push-read-final-crash-proof-1109.json`, 두 native build 로그와 최종 PNG. 어댑터·auth fixture·테스트 알림은 원복/제거했다.

## 기록과 다음 시작점

- Notion 대문도 결정 대기 문구를 확정된 이번 배포 기준으로 갱신했다. 이번 검증에 직접 띄운 Metro8081/8082와 Android 에뮬레이터·Office/Lab 앱 프로세스는 종료했으며, 원래 열려 있던 iOS 시뮬레이터 창·사용자 브라우저/IDE 배치는 변경하지 않았다.
- [Notion PM·BE 공유용](https://app.notion.com/p/413ce072e82f81968f43c0563590b495)은 사용자 결정표를 유지하고 서두/회의 전 추천의 지위만 최신화했다. [FE용](https://app.notion.com/p/413ce072e82f814b917ec5868f047420)은 payload 확정·읽음 연결·검증 한계·Android 호환 패치의 배포 경계를 기록했다. Jira/Slack 댓글·상태는 변경하지 않았다.
- 웹의 기존 REST/일반·알림 병원 선택 디자인, 이전 크레딧 보완을 다시 미완료로 되돌리지 않는다. 확정 범위에서 현재 FE가 추가로 독립 구현할 잔여는 찾지 못했다.
- 다음은 실제 BE 발송 테스트 데이터 수신→실제 푸시/읽음·다른 소속 집계 확인이다. Android 호환 패치의 대상 바이너리/배포 포함 방법도 확인한다. 미정 설정 항목·문구, 청구서 View/PDF, 이메일, 실제 미읽음 배지 고도화는 임의로 재개하지 않는다.
