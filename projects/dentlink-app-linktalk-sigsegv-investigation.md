# Office iOS LinkTalk SIGSEGV 조사

## 결론과 범위 — 2026-10-27 16:49 KST

- 요청: [Slack Datadog 알림](https://innovaidhq.slack.com/archives/C0CC6EDL78T/p1793086505051709)의 원인·제품·환경·버전·화면·행동·배포 관계를 읽기 전용 조사한다.
- 확인된 현상은 Office iOS 운영 앱에서 채팅 메시지를 보낸 후 LinkTalk 목록으로 전환하는 시점의 main-thread native SIGSEGV다. 화면 그리기 호출 경로는 확인했지만 앱 최상위 프레임의 함수명·소스가 없어 결함 원인은 확정하지 못했다.
- 사용자는 dSYM 보관 위치를 모른다고 답했으며, 완전한 해결이 불가능해도 확보 가능한 범위까지만 조사하라고 요청했다. 추가 자료·구현 승인을 요구하며 작업을 확장하지 않는다.
- **최종 정리:** 현재 증거로는 오전 디자인컨펌 오류와 별개 오류로 분류한다. 발생 화면과 스택이 다르지만 완전히 무관하다는 확정은 아니다. 정확한 원인은 미확정이며, 화면 그리기 중 네이티브 메모리 접근 오류가 난 것까지 확인했다.
- **사용자 마감 요청:** 위 결론을 확인한 뒤 조사 내용을 개인 메모리에 저장하고 마무리하라고 요청했다. 새 요청 전 추가 조사·실행·수정·모니터링 없이 종료한다.
- 제품 코드·제품 커밋/푸시·PR·병합·배포·Jira/Slack/Datadog 댓글이나 상태를 변경하지 않았다. 시뮬레이터·Metro를 실행하지 않았다. 새 폴더·worktree·제품 브랜치를 만들지 않았다.
- 개인 컨텍스트의 다른 세션 변경 및 `projects/dentlink-fe.md`는 보존한다. 본 조사 기록과 Office 정본 연결만 이번 개인 기록 범위다.

## 이벤트와 영향

| 항목 | 관측한 값 |
| --- | --- |
| Datadog issue | [d5629b34-d1d8-11f1-b947-da7ad0900002](https://app.datadoghq.com/error-tracking/issue/d5629b34-d1d8-11f1-b947-da7ad0900002) |
| Monitor | [337287804](https://app.datadoghq.com/monitors/337287804), event8872188250843658327 |
| 실제 발생 | 2026-10-27 15:26:12.201 KST |
| Datadog 수신 | 16:34:24.535 KST (`intake_time`/`discovery_timestamp`) |
| Slack 알림 | 16:35:05 KST, parent1793086505.051709, 조사 당시 댓글 없음 |
| 제품 | application dentlink-app / ca92b61f-5def-47cc-9a54-b26570a49298; service com.innovaid.dentlink; usr.serviceType OFFICE |
| 환경·버전 | production / native version2.2.4 / build_version1 / context.codepushLabel .86 |
| 기기·OS | Apple iPhone17,4 arm64e / iOS27.0.1 / build24A446 |
| 화면 | LinkTalkAllTabScreen, 직전 ChatDetailScreen |
| 세션 | 51ccf9d4-0a03-4c43-9ec8-7e988e4799b6, session replay 없음 |
| 오류 | SIGSEGV (SEGV_ACCERR), is_crash=true, Thread0 |
| 동일 issue 영향 | 최근30일 보존 범위 aggregate COUNT1 / session cardinality1 / usr cardinality1; firstSeen=lastSeen=15:26:12.201 |

이 수치는 해당 issue의 관측 범위다. 전체 앱 크래시가 1건이라는 뜻이 아니며, Android/Lab/Web가 안전하다는 일반 보장도 아니다. 해당 issue에서는 iOS Office 외 발생 근거를 찾지 못했다. 역할/권한 상세는 이벤트에 없으므로 Member 등으로 추정하지 않는다.

Monitor query는 `.new().rollup("count").by("issue.id").last("1d") > 0`이다. 제목의 ‘재발’만으로 과거 동일 원인 재발이라 판단하지 않는다. 이 issue는 최초 관측과 최종 관측이 동일하다.

발생→수신 지연은 약68분12초다. [Datadog iOS crash 문서](https://docs.datadoghq.com/error_tracking/frontend/mobile/ios/)는 앱 크래시 후 다음 실행 시 보고한다고 설명한다. 지연과 이 동작은 일치하지만 실제 재실행 시각·지연 원인을 이 기록만으로 확정하지 않는다.

## 직전 실행 경로

Datadog SDK API로 해당 세션의 시간 범위 2026-10-27 00:00–08:00 UTC를 조회했다. 97개 이벤트를 반환했고 status done, 추가 cursor 없음이다. 세션 요약은 view9/action8/resource71/error1/crash1이다. 이벤트의 세부 시각은 계측 종류별 차이가 있으므로 마지막 tap/view/crash의 수십~수백ms 순서를 실제 사용자 입력 순서로 단정하지 않는다.

1. 15:25:15 LinkTalk 탭 선택, LinkTalkUnreadTabScreen 진입.
2. 15:25:16 ChatDetailScreen 진입, 주문·메시지 조회 및 읽음 처리200. 약55.7초 체류.
3. 15:26:07.388 `POST /office/chat-messages/orders/{orderId}` 200. 이후 같은 주문의 메시지 조회(size10/20)는 모두200.
4. 15:26:12 전후 ChatDetailScreen의 일반 RCTView tap, LinkTalkAllTabScreen 전환/JS long task, native crash 기록. 버튼명·키보드 상태·정확한 제스처는 미확인.
5. 같은 세션의 다른 JS error는 없고, 위 채팅 업무 API에는 오류 응답이 없다. 세션 초반 외부 AppsFlyer skadnetwork404는 있었지만 이번 native crash의 인과 근거는 없다.

해당 session.id의 Datadog Logs 조회(15:20–16:40 KST)는0건이다. 로그 부재는 오류가 없었다는 증거가 아니다. APM trace나 Session Replay에 의한 추가 원인 증거는 확보하지 못했다.

## 스택과 결정적인 한계

- Datadog 원본의 `_dd.error.deobfuscation.status=success`만으로 symbolication 성공을 선언하면 안 된다. 실제 Chrome의 Error Tracking Pretty 화면은 **Symbolication failed** 및 **no dSYM could be detected**를 명시한다.
- 누락/invalid UUID: `04104800-AA3D-383D-837F-765EA917D131`, DentlinkApp arm64. 이미지 load address `0x10230c000`.
- 최상위 앱 프레임0–11은 주소뿐이다. 상대 offset은 `23020140, 21113492, 21099640, 23004472, 22997116, 22999472, 23000912, 24849352, 21463152, 21623676, 21645864, 21646228`.
- 해석된 하위 시스템 프레임: 12/13 `UIGraphicsPushContext`; 14 `-[UIView(CALayerDelegate) drawLayer:inContext:]`; 15 `CABackingStoreUpdate_`; 16 `CA::Layer::display_`; 18 `CA::Layer::layout_and_display_if_needed`; 19 `CA::Context::commit_transaction`; 20 `CA::Transaction::commit`.
- ErrorTracking getIssue의 `functionName=UIGraphicsPushContext`는 하위 시스템 프레임의 대표명이다. crash top frame이나 Apple UIKit 자체 결함이 확정된 것이 아니다.
- 따라서 네이티브 UI drawing 중 메모리 접근 권한 오류는 확인되지만, 어느 앱 코드/SDK가 잘못된 접근을 만들었는지, 최초 유입 커밋/PR, 이미 수정됐는지는 미확정이다. Hermes/Fabric/Reanimated/screens/Datadog 중 하나를 임의 원인으로 지목하지 않는다.
- 이 Mac의 Xcode Archives 및 제품 build 폴더 없음. Office DerivedData는 simulator/외부 SDK 산출물뿐이며 일치 production dSYM을 찾지 못했다. GitHub Actions artifacts0, Release v2.2.4.86 assets0. 저장소 Fastlane에서 dSYM 업로드 절차를 찾지 못했다. 이 조사 범위의 부재이며 다른 빌드 Mac의 파일 존재 여부는 모른다.

## 배포·버전과 현재 소스

- Office checkout `/Users/parkjongsun/Repository/dentlink-app`: main `7f586790e0bbd7b288458e29f00654d38ba68da2`, origin/main 동일·clean. `git pull --ff-only` 최신 확인.
- Revopush iOS Production v86: 10/27 10:59:37.681 KST 게시, targetBinaryVersion2.2.4, active, mandatory, rollout100%. description 빈 값. packageHash `672c2c5ee5bce40bee8dd547959cfc4e2907ae2cfe1780f68df8f741af63da0c`.
- `src/hooks/useCodepushInfo.ts:13,24`는 `CodePush.getUpdateMetadata().label`을 `.86`으로 가공한다. 따라서 이벤트의 `.86`은 기기 적용 라벨 근거다. 서버 게시/활성과 별도로 확인했다.
- `context.appVersion=2.2.3`은 설치 버전이 아니다. `src/navigations/RootNavigator.tsx:332`는 API `appMetadata.appVersion.version`을 넣는다. native event version2.2.4와 이 값의 차이만으로 잘못된 바이너리 설치라고 해석하지 않는다.
- Git tag v2.2.4.85=PR338 `40b879ef`, v2.2.4.86=main `7f586790`. v84→v86 소스 diff는 디자인컨펌 hook/테스트와 ISV hook 3파일이며 native/package/lock 변경 없음. 현재 소스에서 이번 LinkTalk crash를 수정했다는 근거 없음.
- OTA v86→exact Git SHA는 미확인. bundle blob read는403, 게시 description에는 SHA가 없다. v85 게시08:42:39.770은 PR338 main 병합08:45:59보다 앞선다. 태그/라벨 숫자 일치를 bundle source 증명으로 사용하지 않는다. PR338은 main에 포함되지만 조회한 origin/develop fc127bd의 조상에는 미포함이다.

## 오전 디자인컨펌 오류와 비교

- 오전 사용자 재현은 DesignConfirmationScreen의 JS `Maximum update depth exceeded` Render Error다. 권한관리 원본5c9e57e / PR329 squash43f7879의 불안정한 빈 객체 참조가 원인이며 PR338/40b879e로 수정됐다. 자세한 실검증 범위는 [Office 정본](dentlink-app.md)에 있다.
- Datadog의 별도 native SIGSEGV issue3개도 비교했다. `9437ec1e-d0e7-11f1-b305-da7ad0900002`, `2260bb4c-d0cf-11f1-9498-da7ad0900002`, `d0444baa-d185-11f1-bc0a-da7ad0900002`의 최신 샘플은 DesignConfirmationScreen·v84이며 Hermes top frame/Thread18·13·9에서 발생했다. 같은 native binary UUID이지만 이번 Thread0/app+UIKit drawing signature와 다르다. 기존 issue의 RESOLVED 상태는 원인 입증이 아니다.
- 이번 세션에는 디자인컨펌 진입이나 같은 JS error가 없다. 같은 SIGSEGV 명칭과 같은 앱 버전이라는 이유만으로 오전 결함의 재발 또는 수정 실패라고 연결할 수 없다. 서로 완전히 무관하다고 증명한 것도 아니다.

## 코드상 후보와 다음 시작점

현재 main의 경로 확인이며 OTA exact source와 동일하다는 확정은 아니다.

- `src/libs/useMessage.ts:307`: 전송 성공 후 scrollToIndex(0), 최신 메시지 조회, 300ms 뒤 전체 메시지 refetch.
- `src/features/chat/screens/ChatDetailScreen.tsx:629`: blur/unmount 때 채팅 상태 정리와 조건부 LATEST_CHAT invalidate. Header goBack 또는 iOS 뒤로가기 제스처가 가능한 native-stack 전환이다.
- `src/features/chat/components/message/MessageInput.tsx:365,427`: 입력 blur의 LayoutAnimation 및 keyboardWillHide의 scheduleLayoutAnimation. 키보드 유지 상태로 화면을 닫았다면 layout와 native 화면 전환이 겹치는 경로를 확인할 만하지만 실제 keyboard 상태는 이벤트에 없다.
- 돌아오는 목록은 `LinkTalkListSection` FlashList다. 화면 drawing 후보에는 목록 텍스트/이미지/아이콘도 포함되며 현재 스택으로 하나를 우선 원인으로 선택할 수 없다.
- 위 iOS 입력 layout/blur 동작은 2026-05-26 c0854baa(PR251)부터 있던 코드다. 목록 이탈 갱신 기본 경로는 2026-03-05 5dec83ec, 조건 보완은05-14 3ee31fdf다. 이 커밋들을 crash 유입 커밋으로 확정한 것이 아니다.
- 최소 후속: 정확 UUID의 production dSYM/archive 확보 → 앱 프레임 해석 → v86 source 매핑 → 해석된 코드에 맞춰 필요 시 동일 바이너리/OS에서 전송 후 키보드 유지/숨김 및 헤더/제스처 복귀를 분리 검증한다. dSYM 업로드·구현·재현 실행은 이번에 수행하지 않았다.
- 현재 조사 마감. 추가 polling/자동 모니터링/제품 변경은 하지 않는다. 새 증거와 사용자 재개 요청 시 개인 컨텍스트 및 해당 제품 live Git부터 갱신한다.
