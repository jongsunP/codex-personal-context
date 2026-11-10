# Dentlink 통합알림센터 — 현재 체크포인트

**iOS 배너 재표시 2차 JS 수정 · Development v142/v40 — 2026-11-10 16:25 KST:** 사용자 승인(“PR 유지, 개발 CodePush까지, commit/push”)으로 아래 원인 재조사 결과를 반영했다.
- **수정:** 양 앱 `fcmHandler.ts`의 Notifee 탭 경로(`setupForegroundEvent` PRESS, `notifee.getInitialNotification`)에서 `notification.remote?.messageId`를 opened로 기록(+4줄). 로컬 Notifee 알림(remote 없음)·기존 흐름 불변. 테스트 3건 추가(총 8건, 수정 전 2실패/후 통과). 전체 Jest 기존 실패21 동일, tsc 기존 Office6/Lab5, 변경 파일 eslint 오류0·prettier 통과.
- **전달:** Office `feature/DL-17059@d4de608`, Lab `feature/DL-17060@e9108b8` commit/push(원격 일치·clean). Draft PR346/42 본문·상태·base(main) 불변. Development CodePush **Office 2.2.4 iOS/Android v142(이전 v141), Lab 1.0.5 iOS/Android v40(이전 v39)**, history 1회: disabled=false·mandatory·rollout100·설명 SHA·새 hash(Office iOS `8adfa6b6642f…`, Android `3ce7910ba0e5…`, Lab iOS `25af6e03084a…`, Android `9598ed2773af…`). native 변경0, Slack 미게시. 증거 `/tmp/notification-development-codepush-1110-r3/`.
- **남은 확인:** 사용자 iOS 실기기(v142/v40 적용 후) 백그라운드 푸시 탭→랜딩 후 배너 미재표시. 시뮬레이터는 잠금화면 알림 열기 자동화 불가로 런타임 재현 미확보. 루트 `patches/` 새 설치 미적용(iOS Notifee 등)은 별도 네이티브 후속.

**iOS 배너 재표시 · v141에서도 재현 → 원인 재조사(코드 미수정) — 2026-11-10 16:10 KST:** 사용자 실기기 치과앱 Development `2.2.4.141`에서 푸시 탭→앱 열림→상단 배너 재표시→주문상세(웹뷰) 랜딩이 그대로라고 보고. 웹뷰와 무관(배너는 OS/Notifee 표시).
- **원인(소스·빌드 설정 근거):** iOS 알림 delegate 체인에서 **Notifee가 최상위**다. RNFBMessaging·RNNotifee 모두 `UIApplicationDidFinishLaunchingNotification`에서 delegate를 가로채는데 static lib 링크 순서가 `-lRNFBMessaging` → `-lRNNotifee`라 Notifee가 나중에 설정되어 `_originalDelegate=RNFB`가 된다. Notifee 7.8.2는 원격 푸시 탭도 `parseUNNotificationRequest`로 자기 PRESS 이벤트(`notification.remote.messageId`)로 처리하고, 원래 delegate(RNFB)로 넘기는 것은 루트 `patches/@notifee+react-native+7.8.2.patch`(iOS)뿐이다. 그런데 `postinstall`은 `patches/native`만 적용해 **새 설치 시 루트 iOS 패치가 빠진다**(worktree 새 설치로 확인). 따라서 이 패치 없이 빌드된 바이너리에서는 탭 시 RNFB `onNotificationOpenedApp`이 호출되지 않고 랜딩은 Notifee `onForegroundEvent` PRESS로만 동작 → `fab7708`/`f0e2bc7` 수정이 messageId를 Firebase 핸들러에서만 기록해 배너 생략이 작동하지 않는다. 실제 2.2.4 바이너리의 패치 포함 여부는 직접 확인 불가(높은 개연성).
- **재현 시도:** iOS 시뮬레이터(로컬 Debug 앱, 루트 패치가 남은 로컬 node_modules로 빌드)+Metro, `simctl push`(gcm.message_id·content-available) 3건 전달 확인. 잠금화면/알림센터 알림 열기가 자동 탭으로 동작하지 않아 핸들러 로그는 미확보. Metro·log stream 종료, 시뮬레이터 shutdown.
- **수정 방향(미실행, JS만):** Notifee PRESS 경로(`setupForegroundEvent`, `notifee.getInitialNotification`)에서도 `notification.remote?.messageId`를 opened로 기록. 양 앱 동일. 루트 iOS 패치 미적용 문제는 별도 후속(네이티브).

**iOS 푸시 탭 후 배너 재표시 · JS 수정 commit/push·Development CodePush 완료 — 2026-11-10 15:40 KST:** 사용자 관찰(iOS 양 앱, 기존 푸시 탭→앱 진입·랜딩 정상 후 상단 배너1회 더)을 조사 후 사용자 승인으로 **JS만** 수정했다. 승인 조건: 네이티브/심사·사이드이펙트가 애매하면 묻는다, 웹 제외.
- **원인(소스 근거):** 알림 탭으로 앱이 열릴 때 iOS는 `didReceiveRemoteNotification`을 다시 호출할 수 있다(Apple 문서, content-available 푸시). RNFirebase24는 `applicationState != Background`(Inactive 포함)이면 `onMessage`로 보내고, JS `setupForegroundMessage`가 Notifee `displayNotification`(iOS banner)을 다시 만든다. `AppDelegate.willPresent`는 일반 푸시에 `[]`라 OS 원격 배너가 아니다. 실제 payload의 content-available 여부·실기기 재현 로그는 미확인.
- **수정:** 양 앱 `src/configs/utils/fcmHandler.ts` 동일 +46줄. 탭 핸들러(`onNotificationOpenedApp`, firebase `getInitialNotification`)에서 messageId 기록(TTL10분), `onMessage` 진입 시 AppState 기록 → iOS에서 messageId가 탭한 푸시면 로컬 표시만 생략. 비활성 수신은 1초 대기 후 판단(탭 이벤트 순서 대비), 탭 안 된 푸시는 기존처럼 표시. 데이터 갱신/읽음/랜딩·Android·채널톡 경로·네이티브 불변.
- **검증:** 신규 `__tests__/utils/fcmHandler.test.ts` 5건(수정 전3실패/후5통과) 양 앱. 전체 Jest 수정 전후 동일 실패21(기존 E2E Detox·App.test·Office officeListQueryScope), tsc 기존 Office6/Lab5 유지, 변경파일 eslint 오류0·prettier 통과. 실기기/실제 FCM 미검증.
- **전달(사용자 승인):** Office `feature/DL-17059@fab7708`, Lab `feature/DL-17060@f0e2bc7` commit/push(원격 SHA 일치·clean). Draft PR346/42는 상태·base(main)·제목·본문 **변경 없이** 커밋만 포함. `scripts/codepush.js dev all --mute`(TTY 입력은 `script`+지연 입력, 첫 시도는 입력 EOF로 업로드 전 스크립트 자체 취소)로 **Office 2.2.4 iOS/Android v141(이전 v140), Lab 1.0.5 iOS/Android v39(이전 v38)** 게시. history 1회: disabled=false·mandatory·rollout100·설명 SHA·새 packageHash 확인(Office iOS `7632909f…`, Android `fcd00cd9…`, Lab iOS `ea44cf17…`, Android `93ff2811…`). 기존 isv.mp4 asset 크기 경고는 `--force`로 통과(기존 파일). Slack 미게시. 증거 `/tmp/notification-development-codepush-1110-r2/`.
- **main 차이:** 배포 시 origin/main에 Office #345·Lab #41(Production 태그 workflow 1파일)만 추가돼 있었고 번들/Development와 무관해 feature에 통합하지 않았다. PR 병합 전 main 통합 여부는 별도.
- **다음:** 사용자가 iOS 실기기(Development v141/v39 적용 후)에서 백그라운드 상태 푸시 탭→랜딩 후 상단 배너 미재표시, 앱 사용 중 새 푸시 배너 정상 표시를 확인. 실기기/실제 FCM 미검증 상태이며 감시·추가 배포 없이 대기.

**개발 배포 브레이크포인트 이후 · 웹 CodeRabbit 후속 — 2026-11-10:** 직전 배포/개인 컨텍스트 `0bcd18b` 정리 완료 뒤 사용자가 웹 CodeRabbit 확인을 요청했다. 릴리즈 [PR4862](https://github.com/Innvoaid/dentlink-client/pull/4862)의 미해결 지적1건을 현재 코드로 검증·수정하고 `feature/DL-17058@38ca4edae374c5e130e15f85b512129438be60eb`로 commit/push했다. 같은 feature의 개발서버 PR4863은 이미 병합된 상태이며 이번 변경은 아직 develop에 포함되지 않았다.

- **수정:** All 탭에서 알림 개별/전체 읽음 후 모든 inbox 쿼리를 reset하여 불러온 페이지/목록이 사라지는 문제. 공유 `useNotificationCenter`에서 Unread만 exact reset하고 All은 exact invalidate한다. 기존 다른 소속·미읽음 집계 갱신과 실패 처리는 유지한다. Web Clinic/Lab 공통이며 앱은 변경하지 않았다.
- **검증:** 기존 코드의 실제 QueryClient/renderHook에서3페이지45행이 읽음 후0행으로 비는 실패2건을 재현했다. 수정 후 요청 응답 대기 중/완료 후 페이지 유지·읽음 상태/카운트 갱신·Unread 복귀 첫페이지를 확인했다. 공통19+Clinic5+Lab4=28 tests, Clinic/Lab/Admin 전체tsc, 변경 lint/format/diff, 저장소 pre-push lint/커버리지·guard 통과. E2E는 사용자 기존 제외 지시를 유지했다. 제품1파일·기존 테스트1파일만 수정했다.
- **리뷰 완료:** [원 지적](https://github.com/Innvoaid/dentlink-client/pull/4862#discussion_r4521266513)에 수정/검증 근거를 답변하고 해결 처리했다. CodeRabbit이 `38ca4ed`에서 해결됐다고 표시했고, 14:36 KST 후속 재검토가 해당 HEAD에서 **success·미해결 스레드0**으로 완료됐다. 독립 코드 리뷰 추가 지적도 없었다. 별도의 Docstring Coverage57.14%/기준80% 경고는 남으며 기능 결함이나 미해결 스레드와 구분한다. 사용자 결정으로 주석 보완은 추후 검토한다.
- **전달 경계:** 릴리즈 PR의 검증 내역을 현재 커밋으로 정렬했다. PR 병합·새 develop PR·개발서버 재배포는 하지 않았다. 사용자가 지금 보고 있는 개발서버에는 이번 후속 수정이 아직 없으며, 앱 Office v140/Lab v38과 양 앱 PR은 직전 브레이크포인트 그대로다. 개인 기록을 commit/push하고 사용자 QA/리뷰 결과 또는 별도 배포 요청까지 대기한다.

**개발 환경 전달·사용자 실기기 QA 전 브레이크포인트 — 2026-11-10 14:24 KST:** 사용자는 웹을 직접 병합하고 배포를 시작했다고 전달했으며 **기록만** 요청했다. 양 앱은 기존 검증된 feature에서 Development CodePush를 명시 승인했다. Office `feature/DL-17059@ef901809`와 Lab `feature/DL-17060@3632931`의 코드·PR을 그대로 두고 배포만 실행했다.

- **배포 완료:** Office `2.2.4` iOS/Android 각각 **v140**, Lab `1.0.5` iOS/Android 각각 **v38**. 네 대상 모두 업로드 성공 후 history를1회 조회하여 버전·소스 설명·라벨·활성(`isDisabled=false`)·mandatory·rollout100을 확인했다. 기존 앱별 `scripts/codepush.js dev all --mute`를 순차 실행했고 Slack은 게시하지 않았다. [배포 상세·증거·다음 순서](dentlink-unified-notification-center-delivery-2026-11-10.md#개발-환경-전달-완료--2026-11-10-1424-kst).
- **웹 구분:** 사용자 확인은 ‘병합·배포 시작’까지다. 어떤 PR/merge SHA인지 또는 서버 배포 완료·정상 동작을 독립 검증한 것으로 확대하지 않는다. GitHub Actions/개발서버를 추가 조회하거나 감시하지 않았다.
- **PR·코드:** Office Draft346→main, Lab Draft42→main의 코드/본문/상태/대상은 이번 배포에서 변경하지 않았다. 사용자가 코드를 확인했고 앱 개발자 리뷰를 받을 예정이다. 앱 소스 HEAD는 배포 전후 동일하고 양 checkout은 clean이다. 새 네이티브 빌드·스토어 제출은 없다.
- **검증 경계:** 직전 최종 코드의 양OS 화면/소속/딥링크 회귀 확인과 번들 생성 근거를 재사용했다. 이번 배포 성공은 실기기에 새 OTA가 적용됐거나 실제 FCM/APNs와 BE 읽음까지 통과했다는 뜻은 아니다. 기존 Android 라이브러리 호환 오류는 별도 후속으로 유지하며 본체 추가 개발로 다시 묶지 않는다.
- **다음 시작점:** 사용자는 웹 **개발서버**와 양 앱 **실기기**에서 확인한다. 알림함 읽음·랜딩·뒤로가기, 설정/OS 권한 복귀·소속 전환, 실제 `deliveryId` 푸시 클릭→랜딩→읽음을 중심으로 결과를 받는다. 사용자 QA/앱 개발자 리뷰 뒤 재현된 본체 문제만 이어서 처리한다. 자동 모니터링·추가 개발·PR 병합·상용 배포는 하지 않고 대기한다. 기존 로컬 창/서버는 이번 요청으로 조작하거나 종료하지 않았다.

**PR 질문 재검토·치과앱 딥링크 예외 보완 — 2026-11-10:** 사용자가 웹 공통 인증/의존성/날짜 처리와 양 앱 FCM·딥링크·권한 Provider의 영향을 질문했고, 조사 뒤 남은 수정을 반영하도록 승인했다. Office `feature/DL-17059@ef901809fffeba92b78297fe198e8a700f62f572`를 commit/push하고 [기존 Draft PR346](https://github.com/Innvoaid/dentlink-app/pull/346)에 수정·검증을 반영했다. 원격 SHA 일치·clean. Web `2635a55b0`, Lab `3632931`은 추가 결함이 확인되지 않아 코드 변경 없이 유지했다.

- **수정:** Office가 소속 목록에 없는 병원의 주문/알림함/크레딧 앱 경로를 그대로 웹 주소 뒤에 붙이던 분기를 제거했다. 기존 전환 실패 토스트와 현재 화면/소속을 유지하고 처리한 보관 링크를 정리한다. 기존 피드백의 명시적 웹 매핑과 정상 소속 이동은 보존한다. 제품 수정1파일·회귀 테스트1파일이며 native/package 변경은 없다.
- **재검토:** `PermissionProvider`의 OS 권한→서버 수신설정 자동동기화 제거는 확정 정책이며 권한 요청/FCM 토큰 등록은 유지된다. `pushReadRevision`은 읽음 대기 목록 처리 신호이고 OS 배지/미읽음 수가 아니다. 기존 채팅/밀링/일반 소속 전환도 공통 경로의 영향 범위임을 확인했으며 신규 확정 결함은 위1건이었다.
- **날짜/웹:** Clinic/Lab 웹은 기존 국가별 dateFormat과 브라우저 시간대, Office는 소속 국가 dateFormat과 기기 시간대, Lab은 user.countryCode 기반 기존 formatDate와 기기 시간대를 사용한다. 병원 timezone을 임의로 새 적용하지 않았다. Web4개 시간대 날짜경계/offset/DST/국가별 형식 등56개 확인 및 scoped 인증 테스트3개 통과. Lab 관련 lint 오류0. Admin에 이번 날짜 formatter 신규 사용처 없음.
- **최종 Office 검증:** 관련 Jest5 suites/102 tests, 변경파일 lint/format/diff-check 통과. 전체tsc는 기존6진단만 유지. 최종 코드 양OS에서 native OS URL 진입→비소속 오류 안내/웹 이동 없음, 정상 소속 알림함 진입, 렌더된 인박스 랜딩 핸들러→비소속 화면/소속 유지, Home 복귀를 확인했다. 양OS LogBox 빈 상태·Reactotron 연결, Android crash buffer 전후 동일. 임시 관찰 wrapper는 제거했고 실제 읽음/설정 저장은 실행하지 않았다. 실제 FCM/APNs 발송 검증을 대신하지 않는다.
- **현재/다음:** 기존 외부 Terminal Office Metro8081·양OS Home·Reactotron을 유지했다. 웹/IDE는 조작하지 않았다. PR 병합·CodePush·서버 배포는 아직 하지 않았으며 별도 실행 승인 경계와 기존 Android Notifee/대상 바이너리 검증 잔여는 유지한다. 상세와 이후 순서는 [배포 준비 기록](dentlink-unified-notification-center-delivery-2026-11-10.md)을 따른다.

**개발 배포 준비·PR4개·후속 분리 완료 — 2026-11-10 13:46 KST:** 사용자 승인으로 최신 기준 브랜치를 통합·검증·push하고 PR을 준비했다. 실제 배포/PR 병합은 하지 않았다. [정확한 위치·검증·배포 순서·잔여 전체](dentlink-unified-notification-center-delivery-2026-11-10.md)가 현재 준비 정본이다.

- **Web:** `feature/DL-17058@2635a55b0`에 최신 `master@bafb0b1b6` 통합. 사용자 명시 승인대로 원격 develop 삭제 후 같은 master SHA로 재생성하고 복구 bundle 보존. [PR4862→release/v1.94.0](https://github.com/Innvoaid/dentlink-client/pull/4862), [PR4863→develop](https://github.com/Innvoaid/dentlink-client/pull/4863). 두 서비스의 develop push/path 배포 조건이 최종 diff와 일치한다. 웹 배포는 사용자 진행이다.
- **Apps:** Office `feature/DL-17059@5ad23a1`, Lab `feature/DL-17060@3632931`에 최신 main 통합. [Office Draft346](https://github.com/Innvoaid/dentlink-app/pull/346)·[Lab Draft42](https://github.com/Innvoaid/dentlink-lab-app/pull/42)는 이번 사용자 예외 지시로 **main 대상**이다. Draft/DRAFT/[WIP] 조건 확인. 실제 대상 바이너리 푸시 검증은 미완이며 기본 화면 검증과 구분한다. **CodePush는 feature→Development를 별도 실행 승인 후** 진행한다.
- **검증:** Web 알림 테스트26·양서비스 전체tsc·lint 오류0, Office 관련167·Lab59 tests와 양OS JS bundle 생성 통과. 양 앱 최종 코드의 양OS 홈/알림함/설정/뒤로가기, Lab 홈 프로필 시트 정상. 이번 기본 확인에서 새 오류/종료는 관찰하지 않았으나 기존 Android 클릭 전달 오류·Lab reload 종료 원인의 해결은 아니다. 앱 기존 전체tsc 진단은 Office6/Lab5 그대로다. 사용자 지시로 **이번 E2E 실행 제외**; 기존 E2E 코드/CI를 삭제하지 않았다.
- **정리:** Jira Home3건 `[본체 외]`·ToDo, 본체 카드 실제 개발/QA·PR 상태 정렬, DL-17202 개발완료, 이메일 DL-17187 별도 진행중 유지. SP·담당자·부모 불변. Notion FE 참고의 패치 포함 등 오래된 표현을 정정하고 PM/BE 현행 배지 결정은 유지했다. 당일 프롬프트와 과거 구현을 혼동하지 않는다.
- **환경/다음:** 검증용 Lab8082는 종료하고 기존 외부 Terminal Office8081·양OS 병원앱·Reactotron 구성으로 복귀한다. 웹/IDE 창은 그대로다. 다음은 사용자의 웹 PR 병합·개발배포 및 별도 승인된 앱 Development CodePush, 이후 실제 데이터/푸시 QA다. 배포 직전 정책·Sheet·Swagger·Figma·필요한 FigJam/Jira 변경분 재대조 계획과 이메일/Android/Home3건 등 후속을 문서에 보존했다. 자동 배포·리뷰·추가 기능·감시는 시작하지 않는다.

**본체/연관 기능 경계 확정·Android 기존 호환 패치 분리 — 2026-11-10:** 사용자는 알림센터 본체와 같은 상위 Jira에 묶인 홈 연관 기능을 구분하도록 정정했다. **본체는 웹·앱 알림함/알림 설정/읽음/푸시 클릭·랜딩**이며 현재 확정된 계약 기준 독립 FE 개발은 완료, 실제 BE 발송과 서버 저장·집계의 통합 검증/QA는 별도다. **DL-17062 웹 홈 시스템 메시지, DL-17065 Office 홈 필터·최초 안내, DL-17068 Lab 홈 서포트 최근 메시지**는 카드/부모를 유지하되 별도 연관 기능으로 보고한다. 이 세 기능의 잔여를 이유로 알림센터 본체 전체가 미개발이라고 표현하지 않는다. 아래 과거 ‘Home3건 때문에 전체 미완료’ 문구는 이 기준으로 해석한다.

- **Android 분리 결정:** 이번 푸시 요구는 기존 클릭 흐름의 `deliveryId`를 읽음 REST로 보내는 JS 변경이다. 검증 중 발견한 RN/Notifee 기존 네이티브 호환 결함을 이번 기능의 필수 신규 개발/심사 조건으로 묶지 않는다. 사용자의 제외 가능성 조사 질문을 Codex가 실행 승인으로 잘못 해석해 양 앱의 `patches/native/@notifee+react-native+7.8.2.patch`를 삭제·커밋·푸시했다. 사용자가 조사만 요청했다고 정정했고, Codex는 이를 인정했다. 사용자는 이미 진행했다면 계속 정리하라고 했으며, 이후 추가 구현/배포 없이 기록·환경 정리만 마무리했다. 기존 iOS 패치, JS 읽음/랜딩, 라이브러리 버전은 유지한다.
- **제품 커밋·푸시:** Office `feature/DL-17059@9e2a1fc15b2d8cbf8872b1b9c38cca8a74997f59`, Lab `feature/DL-17060@4756446a8ef296780a70295a79a336caf987d032`. 각각 삭제1파일98줄만 커밋했고 원격SHA 일치·clean을 확인했다. Web은 `ed88f0838` 그대로다. PR·merge·배포는 하지 않았다.
- **검증/한계:** node_modules에도 남은 Android 패치를 원복하여 pristine7.8.2와 동일함을 확인하고 양 앱 Android 개발 빌드를 통과했다. 최종 APK에서 홈/알림함과 해당 네이티브 이벤트 경로를 점검했다. **deliveryId 없는 기존 형태의 OS 로컬 알림 클릭에서 양 앱 모두 기존 `createReactContext` 오류가 재현되고 Home에 머물렀다.** 이를 새 읽음 API 문제나 운영 바이너리의 장애 확정으로 확대하지 않으며 별도 결함으로 보존한다. Lab 수동 reload/디버거 재확인 중 Fabric MountingCoordinator SIGSEGV1건도 관찰했고 재실행 후 화면은 정상 표시됐지만 원인과 패치 제외와의 연관성은 미확정이다. ‘패치 제외=오류 해결/푸시 QA 통과’가 아니다.
- **배포 판단:** 이번 기능이 추가한 native/package/lock 순변경은 공통조상 대비0이다. 최신 release와의 통합·실제 배포 바이너리와 이번 JS의 호환성·신규 회귀 여부는 배포 준비 시 대조한다. 패치가 빠진 이번 JS 배포를 이 별도 결함 때문에 자동으로 새 빌드/스토어 심사와 묶지 않는다. 추후 실제 네이티브 배포 필요 시 패치를 재검토하며 이메일 작업 자체에 심사가 필수라고 미리 정하지 않는다.
- **기록/환경:** [별도 Android 호환 후속](dentlink-android-notification-compatibility-followup.md)에 재현, 원본 커밋, 복원 근거와 검증 한계를 보존했다. 사용자에게 열어둔 Office 양 기기·외부 Terminal Metro·Reactotron 구성으로 복귀하며 웹/IDE 배치를 유지한다. 다음은 승인된 개발 배포 준비 또는 실제 서버 데이터 QA이며 연관 홈 기능·이메일·네이티브 후속을 자동 재개하지 않는다.


**기공소 Home 대기 기준 정정·사용자 로컬 확인 준비 — 2026-11-10:** 사용자가 BE와 협의 중인 방향을 추가 설명하고 저장·push 후 대기를 요청했다. **Lab Home 최근 메시지는 신규 API 대기가 아니라 디자인·세부 기획 대기**로 구분한다. 기존 Dentlink Support API를 재사용해 최근 메시지1건을 조회·표시하는 방안을 우선 검토하며, 현재 별도 신규 endpoint를 요청하지 않는다. 디자인/기획 확정 후 실제 기존 응답과 대조하고 부족한 부분이 확인될 때만 보완 요청한다. 재사용 방안은 아직 확정 구현/검증 완료가 아니며, 아래 과거 잔여 설명을 이 최신 기준으로 해석한다.

- **앱 미리보기:** Office `/Users/parkjongsun/Repository/dentlink-app`·`feature/DL-17059@b939fce7f567c40639185da2d2509c35130fc7cb` clean/pull ff-only 확인 후, 같은 Office DEV/Metro8081로 iPhone17Pro iOS26.5와 Android Dentlink_API_36을 실행했다. 양 기기 Home 표시·최신 알림 service 모듈 있음/구 mock store 없음·LogBox 빈 상태를 확인했다. Android 최초 캐시 JS는 reload로 최신화했다. Lab앱을 한쪽 기기에 섞지 않았다.
- **독립 실행/디버거:** macOS Terminal의 Metro 창789(`/dev/ttys001`)과 Devices 창790(`/dev/ttys002`)을 사용한다. Metro5746→yarn5731→zsh5696→login5695→Terminal5655, emulator5933→zsh5703→login5701→Terminal5655의 소유 관계를 확인했다. 현재 PID는 재사용 보장 값이 아니며 다음 재개 시 재확인한다. Codex 종료 생존 실험은 수행하지 않았다. ADB8081/9090 reverse와 양 기기 Reactotron localhost socket readyState1, 하단 두 기기 선택 목록 펼침/Timeline을 확인했다. Terminal/시뮬/에뮬/Reactotron은 **사용자가 확인하도록 유지**한다. 기존 IDE/브라우저/계정 데이터는 변경하지 않았고 새 제품 코드·설정 파일 변경은 없다.
- **웹은 사용자 실행:** `/Users/parkjongsun/Repository/dentlink-client-notification-center`·`feature/DL-17058@ed88f08384f624f0171de9fd38cd9dffcc9ec7b2` clean. 루트의 별도 터미널에서 `pnpm dev:clinic`(localhost3000), `pnpm dev:lab`(localhost3005). 명령/포트는 실제 package script로 확인했으며 이번 요청에서 웹 서버·브라우저·IDE를 대신 실행하지 않았다.
- **다음:** 앱 환경은 켜둔 채 사용자 직접 확인과 후속 요청을 기다린다. Home 디자인·기획 또는 실제 발송 데이터가 준비되면 해당 범위부터 재개한다. 임의 추가 구현·주기 조회·PR·배포는 하지 않는다.


**양 앱 appLandingUrl 연결·검증·push — 2026-11-10:** 사용자는 API/기획 잔여를 먼저 답변하고, 확정된 `appLandingUrl` 연결 및 추가 기획·디자인 없이 가능한 FE 작업을 진행하도록 승인했다. 최신 DEV Swagger와 현재 소비 코드를 기준으로 양 앱만 수정했다. 아래 같은 날 ‘미착수’는 이 구현 이전 조사 기록이다.

- **API 개수 정정:** Jira DL-16140 댓글44913의 ‘4개’는 Office 설정·Lab 설정·Office 인박스·Lab 인박스의 **Swagger API 묶음4개**다. 실제 HTTP 작업은 각 서비스8개/총16개, 경로는 각7개다. 기본 알림센터에 필수 신규 endpoint를 더 요구할 근거는 현재 없다. 실제 발송·기존 catalog 보완과 신규 endpoint를 구분한다.
- **제품 결과:** Office `/Users/parkjongsun/Repository/dentlink-app`·`feature/DL-17059@b939fce7f567c40639185da2d2509c35130fc7cb`, Lab `/Users/parkjongsun/Repository/dentlink-lab-app`·`feature/DL-17060@2374041f28b5fcc02261205af4a3eade4caf69ef`. 양 앱 commit/push 후 원격 SHA 일치·ahead/behind0·clean 확인. Web `feature/DL-17058@ed88f0838`은 변경하지 않았다. PR·merge·배포 없음.
- **변경:** 최신 Swagger에서 생성한 `InboxNotificationDto` 선언의 `appLandingUrl?: string | null`을 기존 scoped `NotificationApi.ts` export 경계에 반영했다. 양 앱 `NotificationCenterScreen`의 목록 매핑은 `item.appLandingUrl ?? undefined`를 사용한다. 앱 주소가 null/누락이면 기존 읽음 처리만 하고 이동하지 않으며 웹용 `landingUrl`로 우회하지 않는다. Push의 `data.deeplink`·deliveryId 읽음·소속/계정 보호·OS 배지 현행·이메일 제외는 그대로다. 각 제품 변경은 생성 타입과 화면 매핑 두 파일뿐이다.
- **정적 검증:** Office 관련 기존 Jest4 suites/58개, Lab 딥링크·소속 전환 기존 Jest2 suites/30개 통과. 양 앱 변경 파일 ESLint·diff-check 통과, 독립 diff review 지적 없음. 전체 typecheck는 기존 Office6건/Lab5건 유지, 변경 파일 신규 진단 없음. Lab은 compiler host에 HEAD 파일을 공급한 비교에서도 같은5건을 확인했다. 기존 공통 Icon/Tooltip·주문/채팅 타입 오류 해결 작업으로 확대하지 않았다.
- **최종 코드 런타임:** iPhone17Pro iOS26.5와 Dentlink_API_36 Android에서 Office/Lab을 제품별로 함께 전환해 검증했다. 실제 로그인 인박스 GET은 네 조합 모두0건이었다. 따라서 REST adapter에서만 임시 목록/읽음 응답을 제공해 (1) 웹·앱 목적지가 다를 때 앱 주소 우선 (2) null (3) 키 누락 (4) 읽음 후 이동/주소 없으면 유지 (5) 뒤로가기→같은 인박스를 확인했다. Office는 Credits, Lab은 HelpCenter 실제 목적지 화면까지 열었다. Android는 실제 화면 좌표/접근성 항목 터치와 하드웨어 뒤로가기, iOS는 최종 렌더된 화면 handler·navigation stack·스크린샷으로 확인했다. 실제 FCM 발송/서버 읽음 저장 E2E나 모든 경로/권한 전수 QA로 확대하지 않는다.
- **검증 환경 정리:** Android Office 초기 실행이 예전 캐시 JS를 읽어 최신 Metro로 reload 후 위 최종 검증을 수행했다. Lab 검사 준비 중 수동 테스트 호출의 누락 config/잘못된 item 선택으로 생긴2개 오류는 임시 검사 스크립트를 고쳐 재확인했으며 제품 오류로 기록하지 않는다. 최종 네 조합 LogBox 로그는 비었고 이번 실행 구간 새 Dentlink iOS crash report·Android crash 로그는 발견하지 못했다. 기존 과거 crash 원인 미확정은 해결됐다고 바꾸지 않는다. 임시 adapter/목록 query는 제거했고 가짜 읽음 ID를 서버에 보내지 않았다. 이번에 직접 시작한 Metro8081/8082·양 앱·시뮬/에뮬은 종료, 사용자 IDE/브라우저/로그인 데이터는 유지했다. 임시 증거는 `/tmp/dentlink-notification-1110/*-proof.json`, `*-landed*.png`이며 영구 보존은 보장하지 않는다.
- **추가 작업 재검토/보류:** DL-17065 Office Home 필터/최초 안내는 정책의 웹·앱 독립 저장·재로그인 유지·MEMBER 숨김·최초1회 원칙을 인지했다. Figma2:6의 `My Orders Only`는 Orders22:4333/248:24215, LinkTalk22:5760에서 확인되며 Home 안내의 위치·문구는 확인되지 않았다. 기존 `usePersonalOrdersPreference`도 구 push preference/`pushEnable:true`에 결합돼 그대로 재사용하지 않는다. DL-17068 Lab Home 최근 메시지는 PRD#19 대상·위치/동작 미정, DL-17062 웹 Home 시스템 메시지 제외는 목록·미읽음 집계의 기존 서버 응답 처리 대조가 남는다. 명세가 부족한 부분을 임의 UI/로컬 필터로 덮지 않았다. 따라서 ‘전체 개발 완료/기획 잔여0’라고 보고하지 않는다.
- **다음 시작점:** 실제 발송 데이터가 준비되면 `appLandingUrl` 실응답→랜딩과 실제 `deliveryId` push→읽음 저장·집계를 검증한다. Home3개 잔여는 각 확정 근거에 따라 착수하며 사용자 개인 설정 상세 후속/DL-17235를 이번 배포의 무조건적 차단으로 확대하지 않는다. 이번 요청에서는 Jira·Notion·Slack·Sheet·Figma를 변경하지 않았고, 개인 기록만 최신화했다.

**잔여 API·기획·디자인 재대조 — 2026-11-10:** 사용자의 “남은 것/API가 얼마나 더 필요한지, 기획·디자인 추가가 꼭 필요한지” 질문에 읽기 전용으로 현재 코드·Jira·PRD 본문/댓글·병원 선택 Slack·DEV Swagger를 재확인했다. Jira 본인13개 상태는 개발완료10/투두3 그대로이며 제품 코드·Jira·Notion은 수정하지 않았다.

- **즉시 FE 후속 발견:** DEV `/v3/api-docs` HTTP200(984paths)의 `InboxNotificationDto`에 nullable `appLandingUrl`이 있다. 양 앱 `src/models/NotificationApi.ts`와 `NotificationCenterScreen.tsx`는 여전히 `landingUrl`만 사용한다. 생성 타입/목록 매핑/앱 랜딩을 새 필드 기준으로 대조·보완할 작업이 남았다. 명세 변경 시각 자체는 확인하지 않았으며 이번 재대조에서 발견한 차이다. 과거의 “당장 FE 추가 없음”보다 이 근거를 우선한다. 현재는 조사만 했고 연결 구현은 미착수다.
- **필수 신규 endpoint 확정 없음:** Office/Lab별7경로·8HTTP 작업(설정GET/PUT, 목록/미읽음/타소속GET, 개별/전체/푸시읽음PATCH)은 공개·연결 상태다. Office Home은 기존 `/office/orders`의 `myOrderOnly`, Lab 최근 메시지는 기존 `/lab/chats/latest`, 웹 홈 제외는 기존 chats/latest·unread-count 재사용부터 검토한다. 정책에 따른 기존 응답 보완 가능성과 신규 API 필요를 구분한다.
- **기획/디자인 잔여:** Lab 홈 최근 메시지 #19의 정확한 대상·위치·읽음/빈 상태·웹/앱 적용 범위, Office 홈 필터/최초 안내의 실제 화면·문구와 저장 연결 대조, 병원 선택 안내 문구 PM 확정이다. 기본 알림함·설정 디자인 전체를 다시 기다리는 것은 아니다. PRD 반환 최종 편집은11/9 18:50:20 KST이며 미결 표의 오래된 벨 위치·OS 조작/배지 항목은 사용자 최신 확정 기준을 되돌리지 않는다.
- **USER 설정은 별도 후속 구분:** PRD5-6 본문에는 프로필 설정/User Credit PUSH·MAIL 방향이 있지만 #20–22는 Open이다. DL-17235 현재 본문은 정책·와이어프레임 후속 및11.23 이후 연내 대응 가능성을 기록한다. 따라서 개인 설정 세부화를 이번 배포의 무조건적 차단 사항으로 확대하지 않는다. 기존 settings의 `view.user`/`setting.user`가 이미 있어 새 endpoint부터 요구하지 않는다.
- **BE 남은 확인은 실제 데이터·기존 응답 중심:** 실제 deliveryId 발송→읽음 저장/권한·집계 QA, 기존 catalog의 Credits MAIL·CASE_PREFERENCE 정책 대조. catalog 값은11/9 실조회 근거이며 이번에는 실계정으로 재조회하지 않았다. 배지 현행 유지·이메일 별도·삭제UI 제외 결정을 유지한다. 다음 승인 시 양 앱 appLandingUrl 연결부터 진행하고 Home 작업은 확정 기준/기존 API를 확인해 이어간다.

**Jira 제목·본문 실제 범위 최종 정렬 — 2026-11-09:** 사용자의 “투두3개 제목/내용을 실제에 맞추고 개발완료도 맞추라”는 요청으로 본인13개를 갱신·재조회했다. **개발완료10 / 투두3 / 진행 중0**은 그대로이며 SP·담당자·부모13개도 전후 동일하다. [전체 현재 제목·상태·잔여 근거](dentlink-unified-notification-center-jira-closeout-2026-11-09.md).

- **투두는 남은 기능만 명시:** DL-17062 웹 홈 링크톡 목록의 제외 대상 시스템 메시지 처리, DL-17065 Office 앱 홈 ‘나의 주문만 보기’ 필터·최초 안내 추가, DL-17068 Lab 앱 홈 최근 메시지1건 표시·대화 이동 추가. 이미 완료된 웹 병원 선택·전환·랜딩은 DL-17058 범위에 모았으며 SP를 이동하거나 새로 산정하지 않았다.
- **개발완료는 실제 구현에 맞춤:** 공통 헤더 진입·목록/읽음 REST·설정 조회/저장·OS 안내/복귀·소속 전환/랜딩·deliveryId 푸시 읽음을 각 제품 카드에 기재했다. OS OFF 배너는 상시 표시/자동팝업만 기기1회라는 최신 기준으로 본문을 정정했다. 실제 발송 E2E·iOS 권한 실기기·Android native 패치 재빌드·QA/배포 경계는 남겼다.
- **정책 재확인:** Office 홈 필터의 웹/앱 독립 저장·재로그인 유지·MEMBER 토글 숨김·앱 최초1회 안내는 PRD에 이미 명시돼 있다. 실제 연결과 기본값/저장 단위·화면/문구는 착수 때 대조한다. Lab 최근 메시지의 세부 범위는 PRD #19 미결이다. 새 코드 구현은 시작하지 않았다.
- **변경 범위:** Jira13개 제목/본문과 개인 기록만 수정했다. 상태·SP·기존 댓글·상위/타인 카드·별도DL-17202·Notion·제품 코드는 건드리지 않았다. 개인 컨텍스트 commit/push 후 다음 요청까지 대기한다.

**Jira 상태 의미 사용자 정정·반영 — 2026-11-09:** 사용자는 **남은 것/미착수=투두, 실제 작업 중=진행 중, 불필요해진 것=완료, 작업된 것=개발완료**로 지정했다. 공통 AI_WORKFLOW에 저장하고 본인13개에 반영했다. 기존 완료17048/17057도 요청된 작업이 끝난 카드이므로 Ready for Deploy, ON HOLD였던17062/17065/17068은 해야 할 일로 전환했다. **현재 개발완료10 / 투두3 / 진행 중0 / 불필요 완료0 / ON HOLD0**이며 각 SP·담당자·부모 유지와 실제 상태를 재조회 확인했다. 아래 과거 완료2·개발완료8·ON HOLD3은 이전 정리 이력이다.

- **전체 개발 완료 아님:**17065 Office Home My Orders·최초 안내와17068 Lab Home 최근 메시지는 신규 기능 미착수/기준 확인 잔여,17062는 이미 완료된 병원 선택·랜딩 외 Home 메시지 연계/문구 잔여다. 불필요한 카드 전체로 확정된 것은 없어 완료로 닫지 않았다. PRD 최신 응답에서도 Home My Orders/최초1회 안내 및 Lab 최근 메시지 요구가 남아 있음을 확인했다. 미정/미착수를 ‘할 일 없음’으로 숨기지 않으며 이번 상태 정리는 새 코드 구현 승인이 아니다.
- **범위/기록:** Jira 상태5개만 추가 변경, SP/제목/본문/기존 댓글·상위/타인 카드는 유지. 실제 발송 QA·Android native patch 적용/배포 조건은 그대로다. 공통 상태 규칙과 개인 정본을 commit/push하고 추가 요청을 기다린다.

**사용자 최종 보고 기준 승인·대기 — 2026-11-09:** 사용자는 ‘요청·작업 / 결과’ 표를 앞으로의 보고 방식으로 승인하고, **오늘 준 프롬프트를 빠짐없이 대조하되 오늘 요청하지 않은 작업은 넣지 말 것**을 재강조했다. 중간 추가 요청도 포함하며 커밋 날짜·누적 이력으로 범위를 정하지 않는다. 이 기준은 공통 SESSION_WORKFLOW에 반영·push됐다. 최종 당일 목록은 BE 명세/API 연결, APP 랜딩·시트 확인, 배지 결정, 병원 선택 디자인, 푸시 읽음, 검증 중 발견한 Android 클릭 오류 수정, Jira 정리, 마무리 기록이다. 기존 크레딧·청구서 보완은 이 보고에서 제외한다. 요청 처리와 기록을 마쳤으며 **사용자의 새 요청·기획/BE 확정 전까지 대기**한다. 기존 실발송 QA·Android native 전달 조건·보류 정책은 그대로 남기고 코드/문서/외부 서비스의 추가 변경이나 자동 조회를 시작하지 않는다.

**당일 보고 기준 정정 — 2026-11-09:** 사용자의 ‘오늘 시킨 것/작업 결과’는 **오늘 준 프롬프트 기준**이며 커밋 일자나 누적 작업 기준이 아니다. 크레딧·청구서 보완을 보고에서 빼면서 오늘 명시적으로 요청한 API·랜딩·시트 작업까지 제외한 후속 정정도 잘못이었다. 사용자는 오늘 API 링크도 제공했다고 다시 지적했다. [Jira44913](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=44913) 명세 확인 및 ‘명세가 나온 API는 웹·병원앱·기공소앱 모두 연결’ 요청, 이후 랜딩/시트·푸시 읽음·OS 배지 안건은 당일 요청 목록에 포함한다. 이들과 병원 선택 디자인, 발견한 Android 클릭 오류 수정, Jira·commit/push·개인 기록은 처리 완료다. 초기 크레딧·청구서 보완은 이번 당일 요청 보고에서 제외하되 실제 수행 이력은 보존한다. 기존 정책 대기·실발송 QA·Android native 전달 조건은 완료로 확대하지 않는다.

**Jira 현재 작업 정합성·당일 마감 정리 — 2026-11-09:** 사용자 요청으로 DL-16140 하위 Frankie 담당13개를 실제 구현/검증·남은 정책과 대조했다. UX 완료1개는 유지, 나머지12개 제목·정의·진행 댓글/상태를 정리했다. **완료2 / 개발 완료(Ready for Deploy)8 / ON HOLD3**, 각 SP·담당자·부모 유지와 원격 본문/상태를 재조회 확인했다. 불필요한 카드 전체는 없어 보관/삭제하지 않았으며 Lab My Orders의 제외 확정만 범위에서 제거했다. [카드별 결과·오늘 요청/처리·다음 시작점](dentlink-unified-notification-center-jira-closeout-2026-11-09.md).

- **보류 카드:** DL-17062는 이미 완료한 웹 전환/랜딩 외 Home LinkTalk 정책·미정 문구, DL-17065는 Office Home My Orders/최초 안내의 저장·초기화 기준, DL-17068은 Lab 최근 메시지·Support/시스템 메시지 적용 범위다. 초기 카드의 미정 범위를 숨기지 않고 남긴 것이며 알림 본체를 다시 미구현으로 되돌리지 않는다.
- **완료와 한계:** 공개 REST·양 앱 푸시 읽음·최신 병원 선택 UI는 구현/검증/push 완료. 실제 BE 발송/서버 읽음 E2E, iOS 권한 실기기 및 실제 역할/집계 QA와 Android native patch 배포 포함은 별도다. Ready for Deploy는 Jira의 ‘요구사항에 대해 개발 완료’ 전이이며 PR/QA/배포 완료나 배포 허가는 아니다.
- **경계:** 상위/다른 담당자 카드·별도DL-17202·Notion·Slack·Sheet·제품 코드/런타임은 이번 정리에서 변경하지 않았다. 3제품 HEAD/clean/upstream0·0은 직전 완료 기록과 일치한다. 현재 독립 FE 추가 구현은 없으며 정책/실발송 자료 또는 사용자 재요청 시 이어간다.


**푸시 클릭 읽음 연결·Android 클릭 오류 수정 완료 — 2026-11-09:** 사용자의 ‘확정 기준으로 남은 FE 작업이 있으면 진행’ 요청에 따라 Office `feature/DL-17059@676e7fc6e87783dd6c8dbcef0fbe56600084c0b9`, Lab `feature/DL-17060@f9ca872b147a1c1ec1faf6320d40d2c9c39588fc`를 구현·검증·push했다. 원격 SHA 일치·clean. Web은 `ed88f083` 그대로다. **PR·merge·배포 없음.** [구현·검증·배포 경계 상세](dentlink-unified-notification-center-push-read-2026-11-09.md).

- **완료:** 확정된 `data.deliveryId`를 FCM/Notifee 클릭에서 보관해 로그인·앱 준비 후 기존 `/office|lab/notifications/inbox/read/push`에 보낸다. URL 이동과 읽음 식별을 분리하고 중복/같은URL 다른ID·로그인 전 클릭·계정 변경·실패 후 재클릭을 처리했다. 배지 새 푸시 수·PATCH0·LinkTalk 포함은 유지했다. 이미 확정된 PM·BE 계약을 다시 질문하지 않는다.
- **검증:** 두 앱×iOS/Android callback/제어 응답 검증, 기존 Office54/Lab22 tests, lint 오류0 통과. Android는 시스템 알림창 직접 탭→요청1회→인박스 및 프로세스 종료 후 클릭 재진입까지 확인했다. 새 iOS crash report0/Android crash buffer 전후 동일. 실제 BE 발송과 서버 읽음 저장 E2E는 별도다.
- **추가 수정/중요:** 실제 Android 클릭 검사에서 RN0.82.1/Notifee7.8.2의 legacy ReactInstanceManager 오류가 두 앱에 재현돼 `patches/native`에 최소 ReactHost 호환 패치를 적용했다. 두 앱 Android native 개발 빌드·직접 클릭 재검증 PASS. **이 패치의 적용에는 Android 네이티브 재빌드가 필요하며 CodePush만으로 반영되지 않는다.** iOS native 변경은 없고 운영 바이너리 동일 오류 재현까지 확인한 것은 아니다. 과거 ‘네이티브 변경/심사 불필요’ 결론을 새 패치에 그대로 적용하지 않는다.
- **남음/다음:** 확정 범위의 독립 FE 구현 잔여는 더 찾지 못했다. 실제 BE 발송 데이터로 서버 읽음/다른 소속 집계를 검증하고 배포 시 Android 패치 포함 방식을 확인한다. 미정 문구/설정, iOS 권한 실기기 QA, 별도 View/PDF·이메일·배지 개선은 기존 경계를 유지한다. Notion 공유용 결정표는 보존하면서 과거 추천/대기 문구와 FE 구현 결과를 정리했다.


**11.23 배포 배지 정책 확정·푸시 payload 공유 — 2026-11-09:** 사용자가 회의 결과를 전달하고 [DL-16140 댓글44950](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=44950)에 게시했다. 댓글(18:30:46 KST)과 사용자가 직접 갱신한 [PM·BE 공유용 표](https://app.notion.com/p/413ce072e82f81968f43c0563590b495)를 읽기 전용으로 확인했다. 아래 과거의 ‘배지 정책 결정 대기’ 및 FE 미읽음 추천안보다 이 결정을 우선한다.

- **이번 배포:** OS 배지는 새 푸시 수, 로그인/앱 복귀 시0 초기화 유지, LinkTalk 포함, 다른 소속 포함, 신규 미읽음 숫자 payload 추가 없음. `PATCH /app/users/own/devices/badge-count {badgeCount:0}`를 unread GET으로 바꾸거나 읽음마다 -1 하지 않는다. 현행 유지 지시를 기존 네이티브/APNs·SDK 필드 삭제나 변경 허가로 해석하지 않는다.
- **신규 범위 구분:** Jira는 다른 소속 포함을 **‘신규(다른 소속 포함)’**으로 적었다. 서버의 기존 집계가 이미 이를 충족한다고 단정하지 않는다. LinkTalk·다른 소속 집계의 서버 적용은 별도이며 FE에서 인박스/채팅 수를 임의 합산하지 않는다.
- **푸시 전달 기준:** 사용자가 `data: {deeplink:"dentlink://order/1409/7000012592",deliveryId:"5521"}`를 공유했다. `deeplink`는 이동, `deliveryId`는 기존 `PATCH /office/notifications/inbox/read/push` 또는 `/lab/notifications/inbox/read/push`의 `{deliveryId:5521}` 요청에 사용한다. Lab의 앱 scheme은 `dentlink-lab://`를 유지한다. 이 전달 형식을 구현 기준으로 삼되 실제 BE 발송·수신 검증 완료와 구분한다. 새 클릭 이력 API나 분석 이벤트는 추가하지 않는다.
- **현재 코드 대조:** Office `feature/DL-17059@8887a90`, Lab `feature/DL-17060@8d2f71b`, 모두 clean·로컬 upstream0/0. 두 앱 모두 배지 PATCH0 유지. 푸시 읽음 서비스/DTO는 있으나 FCM/Notifee 클릭·로그인 전 보관은 URL 중심이어서 실제 `deliveryId` 읽음 호출은 **아직 미연결**이다. 이번 턴에는 제품 코드·기기·서버를 변경하지 않았다.
- **다음 작업:** 위 payload의 ID를 클릭→로그인 준비→읽음 호출까지 보존하고 URL 이동 중복 방지와 발송ID별 읽음 중복 방지를 구분한다. 기존 랜딩·소속 확인, 실패 시 정상 랜딩 유지, 성공 후 인박스 갱신을 검증한다. OS 배지 정책 변경과 섞지 않으며 실발송 E2E는 별도 확인한다.
- **후속 개선으로 보관:** 실제 미읽음 수 / LinkTalk 포함 우선(불가 시 현재 푸시 발송 건 범위 검토) / 현재 소속 / 푸시 숫자 포함. 이번 배포 구현 범위가 아니며 기존 FE 추천의 ‘전체 소속·LinkTalk 제외’를 확정안으로 재사용하지 않는다. 실시간 동기화·이메일 작업 제외는 유지한다.
- **기록 경계:** 사용자의 Jira 댓글·Notion 표는 변경하지 않았다. 개인 체크포인트와 [상세 배지 기록](dentlink-unified-notification-center-api-badge-review-2026-11-09.md)만 최신화한다. 공유용/FE용의 회의 전 설명은 최신 결정으로 보지 않는다. PR·배포 없음.

**치과 선택 디자인 통일 구현·검증·푸시 완료 — 2026-11-09:** 아래 사전 확인 뒤 사용자가 웹·치과앱의 일반 병원 선택과 알림 병원 선택을 함께 구현하고 검증·commit/push·메모리까지 완료하도록 승인했다. Web `feature/DL-17058@ed88f08384f624f0171de9fd38cd9dffcc9ec7b2`, Office `feature/DL-17059@8887a90bd163f85498f1d7afca592c92126a8f64`를 원격 SHA 일치·clean으로 확인했다. **PR·merge·배포는 하지 않았다.** [변경 범위와 최종 실행 검증](dentlink-unified-notification-center-office-selection-2026-11-09.md).

- **반영:** 현재 소속 회색 카드, 병원 아이콘·이름/주소·다른 소속 행·화살표·미읽음 표시를 정렬했다. 웹은 현재 카드+목록 본문이 함께 스크롤되고 제목/닫기/일반 Add New Office는 고정된다. 치과앱은 현재 카드→권한별 Payment Method→다른 소속 순서이며 상단은 고정하고 목록만 일반 최대450/알림 최대500 내에서 스크롤한다. 작은 화면의 가용 높이도 함께 제한한다. 긴 이름/주소는 줄바꿈, 단일 소속은 빈 목록 제목/영역 제거. 공통 행 표시를 재사용하며 새 API·기기 배지 정책은 추가하지 않았다.
- **기능 보존/추가 수정:** 기존 소속 조회·활성화·실패/중복 방지·일반/알림 토스트·알림 재열기와 Payment OWNER/PAYMENT_MANAGER 권한을 유지했다. 실제 앱 재진입 검증에서 초기 소속 ref가 전환 이후에도 예전 병원을 현재 카드로 표시하는 문제를 재현해 제거했다. 실제 활성 소속을 따라 현재/다른 목록이 같이 갱신되며 양 OS에서86→145→86 전환/재오픈을 확인했다. **알림 제목·안내 문구는 PM 미확정이므로 기존 문구 유지**, 일반 Change Office는 확정된 일반 시안을 적용했다.
- **검증:** 웹 desktop/mobile 일반·알림 렌더/스크롤·닫기·Add New Office 및 실제 활성화 API 전환·원복 통과. Clinic/Lab/Admin 타입검사, 기존 알림 회귀9개, 수정 파일 lint/push hook 통과. Office는 iOS/Android 같은 DEV checkout/Metro의 최종 코드로 일반/알림 전환·재진입·Payment 진입, 상단 고정/하단 스크롤, 긴 문구·미읽음 배지, 권한별 표시/단일 소속, 작은 Android 화면 높이를 확인했다. 실제 other-unread API는0건이므로 **미읽음·권한별·단일 소속 조건은 임시 런타임 fixture 검증**이며 실제 집계/비OWNER 서버권한 QA로 확대하지 않는다. fixture·소속·화면 크기를 원복했다. 신규 iOS crash report 없음, Android crash 로그 전후 동일.
- **기존 제한/다음:** Office 전체 tsc의 기존6진단과 웹 i18n의 기존 로그인key/locale stale는 그대로이며 변경 파일 신규 타입/lint 오류는 없다. Lab 앱·Lab 홈 선택 UI는 변경하지 않았고 공유 웹 Lab 모달은 기존 분기 표시/닫기만 회귀 확인했다. 이번 승인 범위의 남은 코드 작업은 없다. 다음은 PM 알림 문구 확정 또는 별도 BE/배지 결정 수신 시 해당 범위만 대응한다. 배지 안건은 계속 대기하며 이메일/다른 제품 범위를 재개하지 않는다.

**치과 선택 모달 디자인 변경 사전 확인 — 2026-11-09:** 사용자가 배지 안건을 대기하고 [디자이너 Slack 스레드](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794211574467219)의 기존 치과 선택+알림 치과 선택 UI 통일을 우선 확인하도록 요청했다. [Figma WF 페이지](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=490-25079)를 실제 프레임·주석·스크린샷과 현재 Web/Office/Lab 코드로 읽기 전용 대조했다. **이번 턴은 확인만 했으며 제품 코드/브랜치/서버/기기/외부 문서를 변경하지 않았다.**

- **최신 요구와 확정 구분:** Slack17:07 시안공유,17:24 알림 모달 문구 PM 검토 요청,17:28 PM은 내일 검토 예정,17:37 디자이너는 일반/알림 형태 통일과 상단 병원 영역에 동의했다. 스크롤 상세는 구두 설명 예정이었고 사용자가 이 대화에서 직접 보완: 앱 일반 선택은 Payment Method가 있어 상단 고정/다른 병원 목록만 스크롤, 앱 알림도 같은 구조; 웹은 현재 병원+다른 병원 본문이 함께 스크롤. Slack의 ‘최근 병원’은 Figma `Current Dental Clinic Name`/주석 ‘현재 병원’과 현재코드의 활성 소속으로 해석하며 방문이력 기능을 새로 만들지 않는다.
- **Figma 확인:** 일반 선택 section490:26325, 알림 선택491:32113. 앱 일반490:28447(짧은목록),491:29068/491:29470(max 상단/하단); 앱 알림491:34596/491:35352; PC 일반491:29327/491:29592, 알림494:36563/494:36719; 모바일웹 일반491:31330/491:31625, 알림494:37112/494:37202. 링크는 PAGE여서 최초 get_design_context는 nothing selected였지만 metadata/use_figma로 자식 위치를 찾고 실제 frame context/screenshots로 확인했다. 앱 알림 큰 프레임 sparse 응답은 현재 카드491:34632/행491:34644 고품질 context 및 전체스크린샷으로 보완했다. 디자인 내용/댓글은 쓰기 하지 않았다.
- **스타일/치수:** 현재 병원은 상단 회색(#F9F9F9)·radius12 카드, 보라색16bold 이름/12medium 주소,40px 아이콘박스/20px 병원아이콘. 다른 병원 행은 병원아이콘 제거·20px 오른쪽화살표·padding12·이름16bold/주소12medium, 긴 이름/주소는 말줄임 없이 여러줄. 알림은 병원명 옆 미읽음 count를 추가. 앱은 한 외곽 박스 안 행 구분선, 웹은8px간격 개별 radius12 카드로 표현한다. 앱 일반 다른병원목록 max450px(491:31969), 앱 알림 목록 max500px(493:36107), 모바일웹 sheet max90dvh(491:31999/494:37336), PC MAX HEIGHT 시안은 높이600/폭480. 작은 화면에서는 기존 safe area/가용 높이 한도를 함께 고려한다.
- **일반 선택 기능:** 앱 Payment Method를 현재병원 아래·다른병원목록 위로 이동하고 타이틀/카드아이콘/화살표를 변경한다. 기존 OWNER/PAYMENT_MANAGER 노출권한과 웹 Add New Office/기존소속전환 동작을 보존한다. 현재 카드에는 시안상 count/이동 화살표가 없으며 새 미읽음 집계를 임의 추가하지 않는다. 알림 타이틀 `Unread at Other Offices`, 섹션 `Unread Notifications`는 현재 시안이나 PM문구검토 전 상태를 구분한다. 무관한 Org/그래프 주석의 복사 잔존은 이 변경요구로 채택하지 않는다.
- **현재 코드 차이:** Web Clinic `clinic/src/components/Office/OfficeSelectListModal.tsx`/`OfficeSelectListItem.tsx`는 현재소속을 첫행에 넣되 현재주소를 전달하지 않고 desktop max550·기존아이콘/여백을 사용한다. `shared/ui/src/NotificationUI/NotificationEmployersModal.tsx`에는 현재소속 prop/카드가 없으며 제목/안내도 본문스크롤에 들어간다. 새 현재소속 표시 데이터와 같은 row스타일이 필요하다. 양쪽은 기존 `GET /office/users/own/employee?type=activate`를 사용하므로 이번 디자인 때문에 새 API는 필요 없다.
- **Office 앱 차이:** `src/features/common/components/EmployeeSelectList.tsx`는 현재행고정+다른목록 max320 scroll, `EmployeeSelectBottomSheet.tsx`의 Payment는 목록 아래다. `src/features/notifications/components/NotificationOfficeSelectSheet.tsx`는 title/hint를 FlatList header에 넣어 함께스크롤하고 현재소속을 제외한다. 새 상단카드/Payment순서/하단스크롤/450·500 제한과 행스타일 보완 필요. 기존 query·활성화·전환중중복방지·실패토스트는 재사용하며 전역 BottomSheet 기본값을 무작정 바꾸지 않는다.
- **Lab 경계:** Lab 웹 일반선택은 `lab/src/components/LabSwitch/LabSwitchModal.tsx`의 anchored224px메뉴, Lab 앱 홈은 `HomeProfileBottomSheet`(소속/계정/밀링,85%높이)로 Office와 다르다. Lab의 `EmployeeSelectList`는 Home이 아니라 NoAccess 경로 소비다. 공유 Web 알림모달과 Lab 알림 선택 영향은 확인하되 치과 시안을 근거로 기존 기공소 홈 UI/밀링까지 교체하지 않는다.
- **Git/다음:** Web8b9cd986c(feature/DL-17058), Officebc2f5a9(feature/DL-17059), Lab8d2f71b(feature/DL-17060), 각 clean/local upstream0·0. fetch/pull/코드실행은 하지 않았으며 다른 활성 작성자 유무를 Git만으로 단정하지 않는다. 후속 구현 시 정확한 작업범위/작성상태 확인 후 현재카드/행→웹스크롤→앱Payment/스크롤→긴텍스트·빈다른소속·전환·Payment권한·양OS검증 순서. 배지 정책·푸시계약 대기는 그대로 유지한다.

**OS 앱 아이콘 숫자 안건3 · 회의 전 문서 정리 완료 — 2026-11-09:** [대문](https://app.notion.com/p/413ce072e82f814eaf0ed235193ffe5f) 아래의 [PM·BE 공유용](https://app.notion.com/p/413ce072e82f81968f43c0563590b495)과 [FE 참고용](https://app.notion.com/p/413ce072e82f814b917ec5868f047420)을 사용자 최신 요청에 따라 다시 정리했다. 공유용은 선택·결과·사례 중심 약2.2천자, FE용은 현재 코드·기존 API 재사용·payload·연결/검증 중심 약5.4천자로 축약했다. 기존 페이지/공유 주소와 대문 구조를 유지했다.

- **빠뜨리지 않을 독립 결정:** (1) 새 푸시 수 유지/실제 미읽음 전환 (2) **LinkTalk 미읽음 포함 여부** (3) 현재/전체 소속과 개인1회 집계 (4) 푸시 숫자 포함/제외. LinkTalk를 일반 주의사항이나 집계 범위 문구에만 묻어두지 말라는 사용자 정정을 명시적으로 반영했다. 모두 결정 대기이며 배지 코드 미변경.
- **선택별 차이:** 푸시에 숫자를 넣으면 종료 상태 갱신 가능·역순 오차 허용, 빼면 해당 숫자 덮어쓰기를 피하는 대신 다음 조회까지 이전값/0 유지. **푸시 숫자 제외와 현재 PATCH0 유지가 같은 선택은 아니다.** 인박스만 집계하면 LinkTalk 푸시에도 숫자0일 수 있지만 다른 인박스 미읽음5를 임의0으로 지우면 안 된다. Android 활성 알림/런처 표시 한계도 구분한다.
- **현행/계약:** 양 앱 로그인/foreground에서 `PATCH /app/users/own/devices/badge-count {badgeCount:0}` 뒤 iOS setter0, Android Notifee setter는 no-op. 서버 숫자가 푸시 수라는 것은 사용자 전달 BE 설명이다. 실제 미읽음을 채택하면 서버 읽음 정본+GET 재조회로 연결하며 새 API를 먼저 요구하지 않는다. `data.unreadCount`는 선택적 앱 데이터, iOS 자동 배지는 최종 APNs `aps.badge`라는 차이를 FE용 예시에 반영했다. 빈 문자열은 예시로 쓰지 않으며 이는 새 확정 BE 계약이 아니다.
- **Jira:** DL-16140 댓글44945는 현 공유용 링크와 일치,44941은 deliveryId 요청 후 BE 답변 전임을 확인했다. 상위 댓글은 수정/추가하지 않았다. 사용자 소유 공통 설계 카드 [DL-17057 댓글44948](https://innovaid.atlassian.net/browse/DL-17057?focusedCommentId=44948)에 완료/대기·문서 링크를 기록하고 진행 중을 유지했다. 다른 사람 카드/상태 변경 없음.
- **개발 상태:** Web `feature/DL-17058@8b9cd986c`, Office `feature/DL-17059@bc2f5a9`, Lab `feature/DL-17060@8d2f71b`는 최신 읽기 전용 점검에서 clean/local upstream0·0. 확정 REST·랜딩 선행 구현은 완료했지만, 실제 푸시 클릭 readPush는 미연결이며 발송 데이터 기반 최종 검증도 남는다. 현재 계약에서 필수로 추가할 독립 FE 작업은 발견하지 않았다. ‘모든 기능·최종 QA 완료’로 확대하지 않는다.
- **회의용 FE 추천 추가(미확정):** 사용자 요청으로 공유용 ‘결정할 사항’ 표 아래에 추천과 감수할 차이를 추가했다. 개인1회+해당 앱에서 접근 가능한 전체 소속의 인박스 미읽음, 이번 집계에서는 LinkTalk 제외, 푸시에 절대 미읽음 수 포함+앱 GET 보정을 제안한다. LinkTalk 푸시에도 배지0, 현재 인박스보다 큰 전체 합계, 역순/웹 읽음 후 지연, Android 표시 차이가 감수 대상이다. 중복 차감/다른 미읽음 삭제는 감수 대상이 아니다. 기존 API 전체 집계 가능성과 PATCH0/SDK/푸시 충돌 확인을 FE용에도 명시했다. 사용자 최종 정책 선택이나 구현 승인은 아니며 기존 회의 결과 대기를 유지한다.
- **최종 설명 정정·대기 확정:** 공유용의 모호한 ‘인박스 읽음과 별개입니다’를 ‘알림을 하나씩 읽을 때마다1씩 줄이지 않습니다’로 교체했다. ‘푸시가 쌓이며1→2→3 증가 → 앱 실행/복귀 시0 초기화, 인박스 미읽음이 남아 있어도0’ 예시와 초기화 시점을 명시했고 사용자가 이해를 확인했다. 이는 기존 동작 설명을 고친 것으로 정책/코드 변경이 아니다. 사용자는 PM·BE 회의 후 배지 결정을 전달하기로 했으며 추가 작업·자동 조회 없이 대기한다. Notion/Jira 추가 정리 요청의 미완료 사항은 없다.
- **다음 시작점:** 사용자가 회의 후 배지4가지 결정과 BE의 실제 deliveryId payload를 전달하면 기존 API로 가능한지 먼저 대조하고 연결·실제 FCM/양OS 검증을 진행한다. 현재는 대기. 제품 코드·서버·디바이스·Sheet·Slack·PR·배포 변경 없음. [상세 논의/이번 정리](dentlink-unified-notification-center-api-badge-review-2026-11-09.md#후속--회의-전-공유용fe용-재정리와-jira-정합성)를 이어 사용한다.

**PM 시트 반영·편집 권한 실확인 — 2026-11-09 15:36 KST:** 사용자 요청으로 DL-16140 댓글44940과 실제 Google Drive/Sheets를 읽기 전용 대조했다. 연결 계정 `jongsun@dentlink.app`과 동일 계정의 파일 권한 `writer`를 확인했다. ‘전체 알림(PM)’(gid614410508) P열에서 댓글44939 요청 대상 **62셀 전부 기대값 일치**, 누락/오반영0. Lab scheme34셀 및 개별 주소 보완·Credits/Statements·인박스 주소·P175 `밀링센터는 일단 보류`까지 반영됐다. 이전 댓글 전용/403 상태는 해소됐으며 쓰기 시험이나 시트 수정은 하지 않았다.

- 안건1은 BE 전달 댓글44935 및 PM 실제 시트 반영까지 완료. 인박스 URL FE 구현은 직전 제품 commit 유지.
- 안건2는 deliveryId 전달 요청 댓글44941을 실제 확인했으며 BE의 payload 필드/예시 답변 대기. 푸시 클릭 읽음 연결은 아직 미구현.
- 안건3 OS 배지는 현 PATCH0 구조·iOS/Android 차이·서버 unread GET 방향을 설명한 논의 단계다. 채팅 포함 등 집계 범위와 발송 배지 일치 기준은 미확정이며 코드 변경 없음.


**인박스 딥링크 연결·검증·push 완료 — 2026-11-09 14:58 KST:** 사용자가 PM 문안의 ‘인박스 URL 추후 기입’ 대신 FE 연결을 먼저 처리하도록 승인했다. Office `feature/DL-17059@bc2f5a9e3676461c93be90094abf2e834e353c77`, Lab `feature/DL-17060@8d2f71bef4e03c66e58727b2bb6338d3bd2806ad` commit/push·원격 HEAD 일치·clean 확인. `dentlink://notifications`, `dentlink-lab://notifications` 및 선택적 `?employerId=...`를 기존 로그인 준비·소속 전환·화면 이동 흐름에 연결했다. 같은 인박스 자기 랜딩은 화면을 중복 생성하지 않으며 다른 소속이면 새 소속 인박스 한 개를 유지한다. 동일 경로 중복 방지에서도 대상 소속을 구분한다.

- **검증:** 양 앱×iOS/Android 실제 OS URL 진입·종료 후 재진입·Home 복귀·소속 없는 링크의 현재 문맥 유지·자기 랜딩 중복 없음. Office는 실제 소속86→145→86, Lab은 소속85 유지/미소속 ID 거절까지 확인. Office 관련 Jest42, Lab 기존 관련56 통과; lint/diff-check 통과, 전체 tsc는 기존 Office6/Lab5 오류 유지. 새 Dentlink 앱 crash report 없음. 실제 FCM 발송/로그아웃 후 재로그인 E2E 완료로 확대하지 않는다.
- **PM 문안:** 모든 수정 요청을 `셀: 기존 값 → 변경 값`으로 통일하고 기존 값이 다른 P65/P66와 P101은 분리한다. P142/P146은 `알림 인박스 오픈 → dentlink://notifications`, P148/P150은 `알림 인박스 오픈 → dentlink://notifications?employerId=${employerId}`로 실제 URI 제공. P175는 `공란 → 확인 필요` 유지. 시트는 PM 소유이며 직접 수정/외부 게시하지 않는다.
- **경계/다음:** Web·이메일·native 등록·푸시 읽음 payload·OS badge 계약은 변경하지 않았다. PR/merge/배포 없음. PM 전달문 제공 후 기존 안건2(푸시 읽음 값 예시)·3(OS badge) 논의를 사용자와 이어간다. 세부 실행 근거는 [API·랜딩 후속 기록](dentlink-unified-notification-center-api-integration-2026-11-09.md) 참조.


**기존 App 랜딩 대조 완료·PM 수정 요청 준비 — 2026-11-09:** 사용자의 BE 공유 댓글44930을 확인하고 최신 PM 시트 NOTIFICATION/PUSH115행(Office67/Lab48)을 현재 코드·순수 URL 파서·화면 소비와 대조했다. 신규 Credits/Statements 외에도 Office 주문 소속 ID(P65/P66/P101), 배송 경로(P120/P121), Lab scheme34셀·P13 수신 소속·P172 서포트·P176:P183 밀링 완전 주소를 보완해야 한다. 밀링 접수 P175 앱 공란은 목적지 확인 대상으로만 남겼다. 기존 주소 전체가 수정 불필요하다는 뜻이 아님을 바로잡았으며 [행별 결과](dentlink-unified-notification-center-api-integration-2026-11-09.md)에 보존했다. 시트 수정은 PM에게 요청할 문안만 제공하고 제품 코드/기기/서버는 변경하지 않았다. 실제 발송 E2E 검증으로 확대하지 않는다.

**랜딩 안건 1·시트 반영 대기 — 2026-11-09:** 인박스/푸시/향후 이메일의 최종 앱 목적지 URL은 재사용 가능하되 이메일 HTTPS 진입·앱 열기는 별도임을 정리했다. Airbridge 발급은 커스텀 스킴 딥링크의 필수 조건이 아니다. 사용자 승인으로 현재 Office Credits/Statements 주소와 인박스 URL 연결 예정 표시를 시트에 기록하려 했으나 연결 계정의 댓글 전용 권한으로 Google API403이 반환되어 **시트 변경은 적용되지 않았다**. 주소/대상13셀/기입 대기안과 기존 목적지 변경 확인 경계는 [REST·랜딩 후속 기록](dentlink-unified-notification-center-api-integration-2026-11-09.md)에 보관한다. 제품 코드·이메일·푸시 읽음·배지는 이번 후속에서 변경하지 않았다.

**신규 알림 REST 연결·검증·제품 push 완료 — 2026-11-09:** 사용자 승인으로 확정 명세를 Web/Office/Lab에 연결했다. 아래 같은 날짜의 ‘API 조사·미연결’ 기록은 이 구현 전 시점이다.

- **완료:** Web `feature/DL-17058@8b9cd986c`, Office `feature/DL-17059@c18673e`, Lab `feature/DL-17060@c516f3c` commit/push·원격 HEAD 일치·clean 확인. 설정 GET/PUT, 목록·현재/다른 소속 미읽음, 개별/전체 읽음 연결과 mock 제거, OS/서버 수신 설정 분리를 완료했다. PR·merge·배포 없음.
- **실제 보완:** 저장/읽음의 정상 `0001 No Content` 응답을 반영했다. 설정 PUT 직후 GET 이전값 반환을 양 서비스에서 재현하여 저장 항목만 최대4회 제한 확인하고, 미확인 결과를 성공으로 표시하지 않도록 했다. 계정/소속 수명·A→B→A·웹 token refresh의 이전 소속 요청을 보호한다.
- **검증:** 양 웹 실제 저장/복구/503 유지, 양 앱×양OS 실제 저장/복구, 제어 목록 페이지·선택/전체 읽음·실패·중복·랜딩을 확인했다. Android 양 앱 실제 OS 설정→허용→복귀 때 선택 PUSH만1회 저장. iOS는 Lab 차단 팝업/취소 및 Office 허용 상태 저장까지이며 실제 허용 변경·복귀는 미검증이다. 실제 서버 발송 데이터0이라 실제 FCM·실알림 ID E2E는 남는다. 최종 구간 새 앱 crash 증거 없음, 이전 Office native crash 원인 미확정은 유지한다.
- **미정 유지:** 실제 push `deliveryId` payload와 공용 inbox `landingUrl`의 Web/App 구분, OS 배지는 미변경. 개인 USER 설정 위치와 employee CREDITS의 MAIL 부재 등 미확정 catalog는 임의 UI/API로 만들지 않았다.
- **사용자 다음 논의:** BE 질문은 아직 전달하지 않았다. (1) 시트 App 랜딩 하나/기존 pushType의 역할 (2) deliveryId를 실은 구체적인 푸시 읽음 예시 (3) 현재 푸시 수/앱 진입0 배지와 서버 unread GET 방식의 차이를 먼저 사용자에게 설명한다. 사용자에 따르면 현재 BE 숫자는 푸시 알림 수다. 추가 결정 전 배지/푸시 payload를 임의 구현하지 않는다.
- **로컬:** 이번 검증용 웹/Metro/격리 브라우저와 앱 실행은 종료했다. 로그인·기기 데이터·권한 및 사용자 창 배치를 보존했고, 시뮬/에뮬 장치 자체는 유지했다.
- **상세:** [REST 구현·검증·세 안건](dentlink-unified-notification-center-api-integration-2026-11-09.md). API 조사 원문은 [계약·배지 검토](dentlink-unified-notification-center-api-badge-review-2026-11-09.md), 기존 크레딧/청구서 보완은 별도 기록을 유지한다.


**재개·기존 API 보완 및 신규 알림 계약 조사 — 2026-11-09:** 사용자의 재개 요청에 따라 11/6 예약한 Office 크레딧·청구서 모바일웹 보완을 진행했고, DL-16140 댓글44913·44922·44926/DEV Swagger/알림 현황 시트 앱 랜딩을 읽기 전용 대조했다. 후속 배지 질문도 양 앱 현재 코드·실제 Swagger·OS 공식 문서로 조사했다. 아래 11/6의 ‘재개 대기’는 당시 기록이며 이번 완료 범위는 이 절을 따른다.

- **제품 완료·원격:** Office `/Users/parkjongsun/Repository/dentlink-app`·`feature/DL-17059`에서 `60bfad3`(크레딧 자동 적용 GET/PATCH·설명 펼침·웹과 같은 Learn More·아이콘/청구서 표시 보완), `893c4323e194ef9385845a63556c71c34bb273ce`(기존 딥링크 매칭 오류)를 commit/push했다. Lab `/Users/parkjongsun/Repository/dentlink-lab-app`·`feature/DL-17060@f36f181ac80befe7faf04bd09a4ca30aac8434d5`에 같은 파서 교정을 commit/push했다. 양 앱 ls-remote 일치·clean 확인. Web `feature/DL-17058@dea89193`는 변경하지 않았다. PR·merge·배포 없음.
- **실제 효과:** User Credits 자동사용 설정은 저장/서버 재조회, 실패 복구·중복 탭 방지·계정별 요청 문맥을 보호한다. Office Credits에는 해당 토글이 없다. 주문 단일 ID가 병원 ID로 오해석되던 파서를 고쳤으며 고정 shipment/articles/boards 경로와 기존 fallback을 보존한다. 새 랜딩 정책·이메일 연결을 추가한 것이 아니다.
- **검증:** Office Jest 파서30+자동사용4, Lab 기존 Jest6, 변경 파일 lint/diff-check 통과. Office 전체 타입검사는 기존6진단으로 실패, 변경 파일 신규0. iOS26.5/Android API36에서 Office 실제 크레딧/청구서 GET·자동사용 저장 후 재조회/원값복구·설명 표시·Help 진입/복귀, 알림함→크레딧→알림함과 양 앱 외부 주문 링크→실제 상세를 확인했다. Lab 알림함→Help→알림함은 임시 런타임 랜딩값으로 확인했고 실제 푸시 수신/읽음 QA가 아니다. Android는 실제 화면 터치/OS intent와 실제 렌더 handler를 병용했고, iOS는 simctl URL·최종 렌더 handler/native stack·스크린샷 근거다. iOS 물리 터치 전수 자동화로 확대하지 않는다.
- **발견·잔여:** Android Office 최초 cold start에 RN Fabric `MountingCoordinator::pullTransaction` SIGSEGV1회(11:54:18)가 있었다. Finance 진입 전의 초기 화면 로드 시점이며 원인/이번 코드 연관은 미확정이다. 재시작 후 Home→finance/주문/복귀, 추가 cold start에서는 재발하지 않았고 Lab 새 fatal도 없었다. ‘크래시 해결/최종 QA 준비 완료’로 기록하지 않는다. Learn More 목적지는 공개 웹 배포 JS와 동일한 `/help/articles/31`이지만 인증된 DEV 게시글 GET이404/code0002를 반환한다. 다른 문서/운영 URL로 임의 대체하지 않았고 정상 콘텐츠 표시 검증은 남는다. Statements View는 기존 앱 결제내역 화면이 없고 웹 재사용 시 Pay Now·PDF 범위가 함께 노출되어 이번 작은 보완에서 보류했다.
- **신규 알림 API 확인:** Office/Lab 각각 설정·인박스·현재 미읽음·다른 소속 미읽음 GET4개가 실제 로그인 OWNER 계정에서200/code0000이었다. 목록/집계는0으로, BE 공지의 발송 미완료 상태와 일치한다. 새 API 제품 연결·설정 PUT/읽음 PATCH·실제 FCM E2E는 아직 하지 않았다. 계약 명확한 설정/목록 연결은 이제 FE에서 진행 가능하다. `toggleChannel`, 상위OFF 때 자식값 보존, PUT 전체교체/숨긴채널 보존을 적용해야 한다. 구 PermissionProvider의 production 설정 자동 upsert와 함께 전환해야 한다.
- **최소 계약 확인:** 현재 응답 `landingUrl` 하나에 시트 Web/App 목적지를 어떻게 선택해주는지, 새 푸시 읽음의 `deliveryId`가 FCM 어디에 오는지는 확인이 필요하다. 최종 앱 목적지 하나는 앱 내/푸시에서 재사용 가능하지만 NOTIFICATION/PUSH별 목적지가 다르면 구분은 유지한다. 이메일 HTTPS 진입/미설치 fallback은 별도 범위이며 앱 URL 하나만으로 자동 해결되지 않는다.
- **배지 결론:** 양 앱은 `PATCH /app/users/own/devices/badge-count {badgeCount:0}`를 로그인/foreground 때 호출한 뒤 로컬 배지를 지운다. 인박스 읽음과 같은 집계가 아니며 Android Notifee setter는 no-op이다. 배지=미읽음으로 바꾸려면 개인/전체소속/채팅 포함범위와 서버의 읽음·발송 숫자 계약을 맞춰야 한다. 현재 소속+개인 count를 앱 전체 숫자로 임의 사용하지 않는다. 배지 정책·코드는 이번에 바꾸지 않았다. 이미 보인 push 발송을 취소하는 것과 해당 기기의 OS 알림을 제거하는 것은 다르다. 신규 실시간 동기화는 추가하지 않는다.
- **상세 정본:** [신규 API·배지·랜딩 검토](dentlink-unified-notification-center-api-badge-review-2026-11-09.md), [추가 화면 보완·한계](dentlink-unified-notification-center-finance-parity-2026-11-06.md). 외부 Jira/Slack/Sheet/Notion/Figma는 수정하지 않았다.
- **로컬 마감:** 이번 검증을 위해 시작한 Office8081/Lab8082 Metro와 Android AVD/iPhone 시뮬레이터를 종료했다. 기존 로그인·기기 데이터·OS 권한은 보존했고 크레딧 자동사용은 원래 false로 복구했다. 사용자 브라우저·IDE·외부 터미널을 재배치하거나 종료하지 않았다.
- **다음 시작점:** 신규 알림 설정/목록/읽음 query/service/type 연결과 mock 완전 제거를 단계적으로 진행한다. 랜딩 응답 구분·deliveryId payload·OS 배지 의미/서버 집계는 확인된 범위만 적용한다. Office DEV Help 콘텐츠404와 native cold-start 재발 여부를 실제 검증 조건으로 남긴다. Statements View/결제·PDF는 승인 없이 확장하지 않는다.

**다음 재개 시 실행할 지시 확정 — 2026-11-06:** 사용자는 다음에 작업 재개를 요청하면 아래 기준으로 진행하라고 명시했다. **지금 구현하라는 지시는 아니며 재개 요청까지 대기한다.** 병원앱 크레딧·청구서를 기존 모바일웹 기능·디자인·API를 활용해 보완하고, PDF·큰 범위 확장은 제외한다. View는 기존 화면 재사용 가능성부터 확인한다. 완료 후 최종 코드로 시뮬레이터·에뮬레이터 영향 범위를 검증하고 제품 commit/push·개인 메모리 정리까지 진행한다. **PR은 만들지 않는다.** 다음 재개 요청을 받으면 이 범위의 권한을 다시 묻지 않으며, 새로운 범위/의사결정이 필요한 경우만 구분한다. 지금은 개인 기록만 갱신하고 기존 실행 환경·제품 코드를 유지한다.

**추가 앱 화면의 모바일웹 대체 목적 재확인 — 2026-11-06:** 사용자가 현재 User Credits·Statements와 모바일웹을 직접 비교하며 누락을 확인했다. 목적은 조회만 보여주는 것이 아니라 **기존 모바일웹의 API·정책·디자인을 활용해 앱에서도 가능한 기능을 제공**하는 것이다. 앱 특성에 맞추되 자동사용 설정·정책 링크 등을 ‘READ 범위’라는 이유만으로 생략하지 않는다. PDF처럼 큰 별도 작업과 새 BE/디자인/기획이 필요한 항목은 구분한다. **조사·기록만 승인됐으며 실제 보완은 사용자 다음 승인 대기다.**

- **판단 정정:** 앞선 ‘FE에서 더 할 것 없음/추가 목록 기능 충분’은 이 두 화면의 기능 대조가 부족한 결론이었다. 알림센터 본체의 BE 대기는 유지하되, Office 크레딧 자동사용 GET/PATCH·설명 펼침, Learn More, User/Office 아이콘·청구서 배지 등 FE 보완 후보가 남아 있다. 웹의 기존 API가 있어 모두 신규 BE 대기로 묶지 않는다.
- **View 경계:** 청구서 상세가 아니라 청구서 번호로 검색된 결제내역 목록으로 이동한다. 기존 화면 재사용 가능성을 확인할 수 있으나 결제내역·Pay Now·PDF를 자동 확장하지 않는다. PDF 제외는 유지한다.
- **현재 코드/검증:** Office `feature/DL-17059@1f956ae`, Web `feature/DL-17058@dea89193` 유지, 제품 변경 없음. 실제 앱의 크레딧/청구서 조회 success와 웹 표시값, 코드의 빈목록/오류/권한 처리를 확인했다. 전체 예외 조건 QA를 새로 수행한 것은 아니다. 현재 앱·외부 터미널·Reactotron과 사용자 창 배치는 유지한다.
- **다음 시작점:** [상세 대조·사용자 목적·보완 제안](dentlink-unified-notification-center-finance-parity-2026-11-06.md)을 기준으로 사용자 승인을 받은 뒤 진행한다. 아래 과거 대기/완료 기록이 이 신규 확인사항을 덮어쓰지 않는다. Jira/Notion/제품 commit·PR·배포는 이번 정리에서 변경하지 않는다.

**사용자 앱 로컬 확인 환경 재개 — 2026-11-06 18:49 KST:** 사용자가 앱 미리보기를 요청했다. 개인 정본 및 Office 체크아웃을 `pull --ff-only`하고 clean·`feature/DL-17059@1f956ae`를 확인했다. 기존 Codex 내부 Metro8081/8082는 이 세션 소유/cwd를 확인한 뒤 종료하고, macOS Terminal에서 Office Metro8081과 Android AVD를 실제 실행했다. 지속 Terminal은 Metro11419·Devices11422 두 창이며 Metro4615→yarn4583→zsh4570→login4569→Terminal4552, emulator4799→zsh4585→login4584→Terminal4552의 소유 관계를 확인했다. Codex 종료 생존 실험 자체는 하지 않았다.

- iPhone17Pro/iOS26.5와 Android Dentlink_API_36/API36 모두 같은 Office DEV/Metro8081·현재 JS로 연결했고, Reactotron 클라이언트 양쪽 readyState1 및 하단 기기 선택 목록 펼침을 확인했다. Android ADB8081/9090 reverse를 복원했다. 기존 로그인·기기 데이터는 유지했다.
- iPhone 뷰어가 Connecting display에 머물러 DeviceHub/시뮬레이터를 정상 재시작했다. 외부 Terminal의1회 iOS startup이 끝난 후 유휴창11515는 닫았다. DeviceHub의 View→Hide Sidebar→Zoom to Fit으로 실제 화면을 복구했다. Maestro/XCTest는 사용하지 않았다. 마지막 실제 화면에서 iPhone Home·Android Statements(사용자가 이동 중)·Reactotron 양 기기와 외부 실행 터미널을 확인했다.
- 사용자 기존 선호대로 상단 두 터미널·하단 Android/iPhone/Reactotron 배치를 가깝게 준비했다. 증거 `/tmp/notification-user-preview-ready.png`. 단순 준비를 기능 전수 QA로 확대하지 않는다. 제품 코드·웹·정책·PR·배포 변경 없음. 앱 환경을 켜 둔 채 사용자의 직접 확인/후속 요청을 기다린다.

**개인 알림·병원별 미읽음 표시 후속 논의 — 2026-11-06:** 사용자가 [Slack 공유 스레드](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793956736165019) 확인만 요청했다. 읽기 전용으로 부모 글과 답글2개를 확인했으며 최신은 사용자 Frankie의18:20:55 KST 댓글(`1793956855.366729`)이다. 조회 시 PM/BE의 최종 결정 답변은 없었다. 제품 코드·외부 문서/댓글/읽음 상태는 변경하지 않는다.

- **사용자가 설명한 기준:** A 인박스는 A병원 알림+개인 알림, B 인박스는 B병원 알림+동일한 개인 알림이다. 개인 알림 한 건의 읽음은 사용자 단위로 공유되어 어느 소속에서 조회해도 동일해야 한다. 모든 개인 알림/다른 병원 그룹 알림을 일괄 읽는다는 뜻이 아니며 기기 간 실시간 동기화를 추가하는 근거도 아니다. BE 실제 저장/조회 계약은 별도로 확인한다.
- **PM 검토안·미확정:** 다른 병원 선택은 그 병원의 미읽음 그룹 알림이 있을 때만 해당 병원을 보여주고 숫자에서도 개인 알림을 제외하는 방향이다. 인박스에는 개인 알림이 함께 보이고 홈 레드닷도 개인/그룹 미읽음을 포함하므로, 병원 선택2건→해당 인박스Unread3건처럼 기준 차이가 생길 수 있다. 그룹만 집계할지, 개인까지 포함할지는 아직 확정하지 않는다.
- **사용자가 공유한 우려:** 홈 아이콘 레드닷, 인박스 Unread 탭의 활성화/카운트, 모두 읽음 범위, 병원 변경 목록의 레드닷/카운트 **4곳의 일관성**을 함께 정해야 한다. 개인 알림 읽음 후 병원별 숫자 유지, 개인 알림만 남았을 때 홈 점은 켜지지만 다른 병원 목록은 비는 상태, 현재 인박스 모두 읽음 뒤 다른 병원 그룹 알림이 남은 상태를 구분한다. 숫자가 모두 같아야 한다는 확정 요구가 아니라 서로 다른 집계 범위가 사용자에게 오류처럼 보이지 않는지에 대한 의견이다.
- **다음 연결 시 확인:** 확정된 정책으로 USER/소속별 미읽음·목록·읽음 결과의 갱신 범위를 대조한다. 현재 인박스 모두 읽음에 개인 알림을 포함하는지, Unread 탭 활성화가 뜻하는 구체 동작도 확정 전 가정하지 않는다. Slack 사례는 점/숫자의 의미가 다른 참고 사례이며 Dentlink와 같은 구조의 업계 표준은 아니다. 결론 전 코드 변경·추가 폴링 없이 대기한다.
- **가독성 편집 후 재확인:** 사용자 요청으로 같은 스레드의 수정 본문과 답글3개를 읽었다. 최신 추가 댓글은18:32:16 KST(`1793957536.315629`)의 서비스 사례 분리본이다. 주요 우려·2/3개 수치 예시·상황별 영향에 강조/단락을 적용하고, 네 표시의 일관성 요약과 Slack 참고 사례를 별도 댓글로 나눴다. 내용 방향은 유지됐고 새 정책 결정이나 필수 수정할 내용은 확인되지 않았다. ‘싱크’는 네 곳의 숫자를 무조건 동일하게 하라는 요구가 아니라 표시 기준과 읽음 후 반영의 일관성 우려로 해석한다. 이런 비개발자 대상 공유 방향(가독성·구체 예시·근거·우려 전달, 고정 폼 아님)을 공통 지침에 반영한다. Slack 자체는 수정하지 않았다.

**사용자 마감·대기 확정 — 2026-11-06:** 사용자가 실행 창/환경은 직접 정리했다고 알렸고, 원래 기능 작업과 SpringBoard에 즉시 할 일이 없으면 누락 확인·메모리 후 마감하도록 요청했다. 제품3곳의 Git을 다시 확인했으며 Web `dea89193`, Office `1f956ae`, Lab `a119ba8` 모두 clean·upstream0/0이고 직전 원격 검증 완료 기록과 일치한다. 이번 승인된 FE 구현·영향 범위 검증·commit/push·공통 실행 방식 지침 반영에서 새 누락이나 당장 수정할 미완은 확인되지 않았다.

- **대기 사유:** 실제 알림 목록/읽음·수신 설정·미읽음 집계·푸시 연결의 새 BE 계약, USER/Employee·Lab Home 미정 정책, 실제 iOS OS 토글/비OWNER 서버권한 검증 조건은 기존 잔여다. FE 선행 완료를 이들 최종 연동/QA 완료로 확대하지 않는다. 기존 전체 타입검사 진단도 별도로 남겨 두었다.
- **SpringBoard:** 충돌 자동화 방식 회피와 대체 검증은 완료했다. 현재 즉시 필요한 추가 조치는 없으며 재발하거나 별도 요청을 받으면 기록된 원인/환경부터 재확인한다. 근본 해결·경고 숨김 완료로 바꾸지 않는다.
- **실행·권한 경계:** 사용자 정리 상태를 존중해 창·서버·기기를 다시 열거나 조작하지 않았다. PR/배포/외부 문서 변경·자동 폴링·다른 세션 연락도 하지 않는다. 개인 컨텍스트만 commit/push하고 사용자 후속 요청 또는 새 명세까지 대기한다.

**앱 내부 알림 랜딩의 뒤로가기 보완 완료 — 2026-11-06:** 앞선 조사 후 사용자가 앱 구현을 승인했다. Office `feature/DL-17059@1f956ae2971654159e01accfcb26350a4711da9b`, Lab `feature/DL-17060@a119ba8`에 각3파일을 commit/push했다. Web은 `feature/DL-17058@dea89193` 그대로이며 이번 코드 변경/재검증 대상이 아니다. 양 앱 원격 반영·clean을 확인했다. PR·merge·배포는 하지 않았다.

- **동작:** 앱 내부 알림→목적지→뒤로는 기존 알림함을 보존한다. 같은 소속은 같은 알림함 route key/All 필터가 유지된다. 다른 소속으로 실제 전환한 링크는 새 소속 Home→알림함→목적지로 만들어 이전 소속 화면을 복원하지 않는다. 외부 push/deep-link·탭/action·채팅 등 특수 경로는 기존 복귀 동작을 유지한다.
- **검증:** Office Android 실제 UI에서 Credits/Statements 왕복·반복·기기Back·외부 링크, 실제 소속 전환/원복과 지연 응답 후 이탈 조건을 확인했다. Lab Android는 기존 Help Center 및 Forbidden 안내 후 알림함 복귀, 외부 링크 Home 복귀를 확인했다. iOS 양 앱은 실제 실행한 최종 코드의 렌더된 handler/native stack·화면으로 확인했으며 전체 물리 탭 자동화 완료로 주장하지 않는다. 임시 런타임 데이터/함수는 복원했다. Jest Office36/Lab6 통과, lint 오류0, 전체 tsc는 기존 Office6/Lab5 진단으로 실패·변경 파일 신규0이다. [실행 근거·한계](dentlink-unified-notification-center-navigation-runtime-2026-11-06.md).
- **SpringBoard:** 사용자 반복 종료 질문을 함께 조사했다. 11/5–6 로그4건이 동일 Apple XCTest 접근성 초기화 충돌이며 이번 iOS Maestro 시각과 일치했다. 앱 프로세스에도 같은 충돌 이력이 있어 단순 무시하지 않는다. iOS Maestro/XCTest를 중단하고 다른 실행 검증 방식으로 전환한 뒤 새 crash report는 관찰되지 않았다. 경고 전역 숨김/Apple 파일 삭제는 하지 않았으며 근본 해결로 기록하지 않는다.
- **운영/다음:** 기본은 Codex 단독 작업, 사용자 요청 시만 독립 미리보기 구성이라는 최신 지시를 공통 SESSION_WORKFLOW에 명문화했다. 검증 마감 당시 양 기기를 같은 Office DEV 코드로 복원했으며, 이후 실행 환경은 사용자가 정리했다. 이번 복귀 보완에 신규 API는 필요 없으며 알림 목록·읽음·설정·집계/실제 FCM 계약·미정 정책은 기존 대기 범위 그대로다. 현재 승인 범위의 추가 수정은 없고 후속 요청 또는 명세를 기다린다.

아래 랜딩 조사는 위 구현 전의 근거다. 당시 ‘구현 미승인’·Home 복귀 설명을 최신 앱 구현 상태로 재사용하지 않는다.

**랜딩 후 뒤로가기 점검 — 2026-11-06:** 사용자가 Office의 알림→크레딧→헤더 뒤로가기에서 Home으로 가는 것을 보고 웹·양 앱의 라우트/복귀 의미를 확인하도록 요청했다. 이번은 조사이며 새 복귀 정책/제품 수정 승인이 아니다. Web `feature/DL-17058@dea89193`, Office `feature/DL-17059@420d415`, Lab `feature/DL-17060@93c5e87` clean 기준으로 확인했다.

- **Web Clinic/Lab:** 각 `useNotificationLanding.ts`가 `router.push`하므로 브라우저 뒤로가기는 이전 방문 URL로 간다. 알림함은 URL이 아닌 팝업 상태이고 클릭 시 닫으므로 팝업을 자동 복원하지 않는다(`shared/ui/src/NotificationUI/NotificationCenterMock.tsx:191`). 화면 자체 뒤로/닫기 버튼은 개별 화면의 기존 규칙이다. 다른 병원 알림 확인 후 홈에서 팝업을 한 번 여는 entry 기록은 일반 랜딩의 back 복원과 별개이며, browser back이 활성 병원까지 되돌리는 계약도 아니다. 현재 웹 기본 DEV mock에는 landingUrl이 없어 이번 확인은 코드 호출 경로 근거이며 실제 알림 URL 왕복 QA가 아니다.
- **Office/Lab 앱:** 알림 클릭이 출발 화면 없이 `landingUrl`만 deferred로 전달하고, `RootNavigator`에서 공통 `navigateToDeepLinkState`를 호출한다. 일반 목적지는 `navigationRef.reset([BottomTabNavigator, 목적지])`가 되어 알림함이 이력에 남지 않는다(Office `useNavigationConfig.ts:566,883–892`, Lab `:482,723–732`). Header 기본은 `navigation.goBack()`이며 홈 하드코딩이 아니다. `BottomTabNavigator` 초기 탭이 Home이므로 크레딧/청구서 등 일반 랜딩의 뒤로는 Home이다. 외부 push도 같은 reset 흐름이다. 채팅 push의 LinkTalk 복귀·동일 채팅 유지, WebView 내부 history 등의 기존 특수 동작은 별도로 유지해야 한다.
- **구분/다음 시작점:** 랜딩 URL은 목적지이며 복귀 화면을 결정하지 않는다. 앱의 내부 알림 클릭은 알림함 이력을 보존하고, 외부 push는 실제 진입 이력/기존 목적지별 복귀 규칙을 따르도록 구분하는 것이 보완 후보다. 아직 이를 확정 요구나 구현 완료로 기록하지 않는다. 병원 전환이 포함되면 이전 소속의 화면을 잘못 복원하지 않도록 추가 고려한다. 이 보완 자체에는 신규 BE API가 필요하지 않으나 실제 읽음/푸시 식별 계약 대기는 별개다. 사용자 방향 확인 후 구현한다.
- **검증 범위:** 제품 코드·브랜치·서버·창 배치·화면 이동은 변경하지 않았다. 켜진 Office 기기의 navigation state를 읽기 전용으로 보조 조회했으나 사용자 화면이 이동해 Android 알림함 스택만 관찰했고, 새 양OS 크레딧 back 실증으로 주장하지 않는다. 이번 결론은 최종 코드 호출 경로와 사용자의 관찰을 대조한 것이다.

**앱·웹 로컬 확인 배치 최종 승인·대기 — 2026-11-06:** 사용자가 현재 앱·웹 화면 배치 모두 원하는 스타일이라고 확인하고 마지막 확인·메모리·대기를 요청했다. 앱은 바로 아래 좌표표와 동일한 상단 Android/Metro 두 실행 터미널·하단 Android/iPhone/Reactotron이며 실제 화면으로 재확인했다. 웹은 별도 데스크톱의 Cursor IDE(`dentlink-client-notification-center`, `feature/DL-17058`)와 하단 내장 터미널2개, 별도 일반 Chrome 한 창 안의 `[DEV-Office] localhost:3000`·`[DEV-Lab] localhost:3005` 두 탭 구성이다. Cursor와 로컬 Chrome은 각각 AX x0/y30/1920×1050이며 해당 데스크톱에서 필요할 때 전환해 보는 구성이다. 탭을 분리하거나 창 크기를 임의 변경하지 않는다.

- 앱 배치 실제 캡처 `/tmp/preview-layout-app-final-1106.png`, 웹 Chrome/Cursor 각각 `/tmp/preview-layout-web-{chrome,cursor}-final-1106.png`로 확인했다. Chrome은 Lab 알림 설정을 열어둔 사용자 상태였고 Cursor의 하단 실행 터미널 두 개를 확인했다. 단순 창 확인을 새 기능 QA나 모든 로그 무오류 확인으로 확대하지 않는다.
- 웹은 다른 데스크톱에 있어 잠시 기존 Chrome·Cursor를 활성화해 확인한 뒤 기존 Reactotron 화면으로 돌아왔다. 실행 중 서비스·앱·탭 내용·창 위치/크기를 변경하지 않았다. 앱 양 기기는 사용자 확인 중인 User Credits 화면 그대로다. 기존 Android 그래픽 오류 평가와 간헐 알림 클릭 누락 미재현 기록은 유지하며 추가 조사/모니터링을 시작하지 않는다.
- 공통 로컬 확인 지침의 실제 배치 참조를 앱·웹 모두로 보완한다. 같은 디스플레이에서는 이 구성을 우선 재사용하고 환경이 다르면 최대한 유사하게 맞춘다. 제품 코드·Jira·Notion·PR·배포 추가 변경 없음. 개인 컨텍스트 commit/push 후 현재 켜둔 환경을 유지하고 사용자 새 요청까지 대기한다.

**사용자 최종 앱 창 배치·터미널 오류 확인 — 2026-11-06:** 사용자가 다시 조정한 최종 배치를 화면과 Accessibility 좌표로 확인했다. 상단 좌측 Android 실행 터미널, 상단 우측 Metro, 하단 좌측 Android·중앙 iPhone·우측 Reactotron이다. 주 모니터 U32J59x의 논리 해상도1920×1080(scale2.0), AX 좌상단 기준 위치/크기다. 현재 배치를 건드리지 않았으며 같은 모니터 환경의 다음 로컬 확인 세팅에서 우선 재사용/복구하고, 화면 환경이 다르면 상대 배치를 최대한 맞춘다. 다른 창이나 사용자의 새 배치를 과거 좌표로 덮어쓰지 않는다.

| 창 | x | y | 너비 | 높이 |
|---|---:|---:|---:|---:|
| Android 실행 Terminal | 47 | 36 | 870 | 343 |
| Metro8081 Terminal | 935 | 36 | 982 | 343 |
| Android Emulator | 47 | 381 | 297 | 688 |
| Android 도구 막대 | 344 | 409 | 54 | 506 |
| iPhone17Pro DeviceHub | 412 | 380 | 313 | 698 |
| Reactotron | 747 | 380 | 1173 | 700 |

- 최종 화면 `/tmp/app-preview-layout-1106-final.png`에서 양 OS User Credits가 표시되고 Reactotron 기기 선택 목록도 펼쳐져 있음을 확인했다. 이미 사용자가 이동한 화면은 그대로 유지했다.
- Android Terminal의 `Failed to make display surface context current: 12301/12299`, `Failed to bind to post worker context`, `Failed to create window surface for DisplaySurfaceGl`는 gfxstream/EGL의 호스트 에뮬레이터 화면 렌더링 오류다. [공식 소스](https://fuchsia.googlesource.com/third_party/android/device/generic/vulkan-cereal/+/ba29ba979efcfc2c2cd0f67d4060f451df459fcd/stream-servers/gl/DisplaySurfaceGl.cpp)의 메시지와 대조했다. 창 크기/배치 변경 관련 가능성은 있으나 발생 트리거는 확정하지 않았다. 현재 실제 화면·ADB device·앱PID14515·Hermes 응답(route CreditScreen/ready true)은 정상이다. crash buffer에는 14:46·15:40의 `com.google.android.bluetooth` 이력만 있었고 Dentlink 앱의 새 크래시 근거는 없었다. 무조건 무해하다고 단정하지 않으며, 화면 검어짐/멈춤이 재발하면 에뮬레이터 그래픽 설정·재시작을 검토한다. 현재 사용자의 확인을 방해할 재시작/설정 변경은 하지 않았다.
- Metro의 DevTools 연결/종료(code1005) 반복은 이번 디버거 조회 시 연결 이력과 구분했다. 현재 Metro 오류 문구는 없고 앱 실행이 중단된 상태가 아니다. 공통 창 배치 선호를 지침에 기록하고 개인 컨텍스트만 commit/push한다. 제품 코드·Jira·PR·배포 변경 없음. 실행 환경 유지·사용자 추가 요청까지 대기.

**로컬 확인용 목데이터 표시·터미널 정리 — 2026-11-06 16:24 KST:** 사용자가 목데이터 제약을 감안하고 직접 더 확인하겠으며, URL 없는 항목 제목에 임시 표시 후 마감하도록 요청했다. 현재 켜진 Office의 `src/store/useNotificationMockStore.ts`에서 URL 없는 4개 제목에 `[DEV · 랜딩 없음]`만 추가했다. `[DEV] User Credits`·`Office Credits`·`Statements`의 기존 실제 조회 진입은 유지했다. 이 표시는 운영 문구/정책이 아니며 실제 API 연결 시 mock store와 함께 제거한다. Web/Lab의 코드와 현재 화면은 확대 변경하지 않았다.

- Office `feature/DL-17059@420d415`: 4개 title만 변경, lint·diff-check 통과. iOS17Pro/26.5·Android API36에서 실제 알림 All 화면의 표시·줄바꿈과 기존 DEV 진입 항목 보존을 확인했고 `/tmp/no-landing-label-{ios,android}.yaml` 통과 및 최종 화면 캡처를 남겼다. 제목만 변경했으므로 직전 양 OS 랜딩 검증은 재사용하며 새 전수 QA로 주장하지 않는다. 사용자가 직접 볼 수 있게 양 기기 All 화면·Metro·Reactotron을 유지한다. 간헐 클릭 누락의 미재현 상태는 앞 기록 그대로다.
- 유휴 iOS Terminal6895(ttys008)를 `busy=false` 확인 후 닫았다. iOS 앱83189·Metro82384·Android emulator82988의 실행 유지 확인. 현재 계속 쓰는 외부 Terminal은 Metro6893·Android6894 두 창이다. 1회 실행 후 로그도 없는 iOS 전용 창은 상시 유지할 필요가 없다는 사용자 보완을 공통 지침에 반영했다. 다음 새 세팅은 유휴 창에서 iOS 실행을 마친 뒤 같은 창에서 Android를 실행할 수 있으며, 현재 실행 중인 기기를 창 통합만을 위해 재시작하지 않는다. PR·배포 없음. 사용자 추가 피드백/BE 명세까지 대기하며 켜둔 환경을 종료하지 않는다.

**알림 클릭 랜딩 추가 확인 — 2026-11-06 16:19 KST:** 사용자가 항목을 여러 번 누른 뒤 크레딧이 열리는 듯했다고 보고했다. DEV 전용 행/기존 표시용 행과 기기는 구분하지 못했다고 확인했다. 현재 Office `feature/DL-17059@d728310`를 유지한 채 iOS17Pro/26.5·Android API36에서 홈→알림 All→`[DEV] User Credits` 3회 재진입, `[DEV] Office Credits`, `[DEV] Statements` 진입과 조회 목록 표시·뒤로 이동을 각각 통과했다(양 OS 각 5회). Android의 빠른 탭/뒤로 이동도 보완 관찰했으나 사용자 보고의 간헐적 클릭 누락은 재현되지 않았다. 현시점에서 보고 원인을 특정하거나 모든 조건에 문제가 없다고 단정하지 않는다.

- `[DEV]` 세 행은 기존 공통 딥링크를 통해 실제 API 조회 화면으로 간다. 아래 기존 `Credit received`·`Payment completed` 등에는 `landingUrl`이 없고 현재 읽음 표시만 변경한다. 이를 운영 랜딩 정책/미구현 화면으로 오해하지 않도록 사용자가 눌렀을 수 있는 두 종류를 구분했다. 임의 목적지/안내 문구를 추가하지 않았다.
- 인앱 클릭 경로는 `setDeferredDeeplink → RootNavigator → navigateToDeepLinkState`; 외부 Linking/FCM의 1.5초 dedup는 직접 적용되지 않는다. 같은 URL 처리 ref/비동기 소비 경합 가능성은 코드 검토 가설이며 실제 원인으로 확정하지 않았고 추측성 변경하지 않았다. 청구서는 기존 OWNER/PAYMENT_MANAGER 접근 제한 유지. Lab은 동일 전달 구조를 읽기 전용 대조했으며 이번 신규 조회 화면 대상은 Office이므로 새 Lab 기기 QA로 보고하지 않는다.
- 근거: `/tmp/landing-repeat-{android,ios}.yaml` Maestro 통과, 실제 기기 화면/런타임 route·pending 시각 관찰. 클릭→이동 수백 ms와 완료 후 pending 해제를 관찰했으며 영구 무반응/오류는 확인하지 못했다. 진단은 URL/화면/시각만 수집하고 임시 store 구독·storage 타이밍 래퍼를 복구했다. 제품 코드 수정·commit/push 없음(기존 d728310 원격 일치·clean 유지), 새 API 가정·PR·배포 없음. 양 기기는 알림 All 화면으로 돌려놓고 외부 Terminal/Metro·Reactotron 연결을 유지한다. 같은 DEV 행의 첫 클릭 누락이 다시 보이면 해당 OS·행·직전 이동 순서로 재현하여 이어간다.

**사용자 로컬 확인 구성 최종 보완 — 2026-11-06:** Reactotron 3.11.0은 선택된 연결의 타임라인만 표시한다. 당시 iOS와 Android의 실제 소켓은 모두 정상 연결됐지만 선택 대상이 iOS라 iPhone 로그만 표시된 것이며 새 연결 장애가 아니었다. 하단 연결 선택 목록이 펼쳐져 iOS26.5·Android16 두 항목과 현재 선택 표시가 보이는 실제 화면을 확인했다(`/tmp/reactotron-expand-current-1106.png`). 설치본 `ConnectedFooter`는 `useState(false)`여서 펼침 상태를 재실행 이후 보존하지 않는다. 설치 앱을 임의 개조하지 않고, 앞으로 사용자 로컬 세팅 시 두 기기 debugger 연결 확인과 하단 선택 목록 펼침까지 수행한다. 공통 지침에 추가했으며 앱·웹·터미널·창 배치를 유지한다.

**DL-17202 확인·DEV 진입 추가 — 2026-11-06 16:00 KST:** Jira의 실제 범위는 병원앱 User/Office Credits와 Statements 조회이며 결제내역·PDF·Pay Now는 포함하지 않는다. 화면·기존 REST 연결은 구현되어 있다: `GET /office/credits/own/accounts`, `/office/credits/own/details`, `/office/payments/invoices`. 해당 조회 화면만을 위한 새 API는 필요하지 않다. 공통 알림 클릭의 landingUrl 처리와 세 경로는 있었으나 기존 기본 mock에는 이동 주소가 없어 사용자가 바로 열 수 없었다. `src/store/useNotificationMockStore.ts`에 `[DEV] User Credits`, `[DEV] Office Credits`, `[DEV] Statements` 확인용 행 3개와 기존 딥링크를 추가했다. 운영 문구·랜딩 계약·메뉴 요구를 정하지 않았으며 실제 알림 API 연결 시 기존 mock 계층과 함께 제거한다. 조회 결과는 mock이 아닌 기존 API 데이터다. Office `feature/DL-17059@d72831045360c53f15b1399f0cd3427af554cdf4` commit/push 및 원격 일치·clean 확인. Web/Lab 코드는 변경하지 않았다.

- iOS17Pro/26.5와 Android API36에서 기존 로그인으로 실제 DEV 알림 행을 눌러 세 화면 진입·User Credits 실이력·Office Credits 빈이력·Statements 실제 카드·뒤로 복귀를 확인했다. iOS 첫 청구서 캡처는 로딩 중이므로 `Billing Cycle` 본문 표시를 기다린 재검증으로 보완했다. 양 기기는 All 탭의 세 확인용 행을 볼 수 있게 두었다. 클릭 후 Unread에서 사라져도 All에서 다시 열 수 있다. 초기 Android 홈 공지와 iOS 실행 전경/DEV scheme 차이로 자동화 시도 일부가 실패했지만 정상 전경 및 `dentlink-dev://home`으로 준비한 후 실제 행 클릭 검증은 통과했다. 네이티브/권한/로그인·서버 데이터 변경은 하지 않았다. lint·diff-check 통과, fixture 추가만으로 불필요한 새 단위 테스트는 만들지 않았다.
- 근거: `/tmp/dl17202-{ios,android}-{entry,user-credit,office-credit,statements}.png`, iOS 최종 `/tmp/dl17202-ios-office-credit-loaded.png`, `/tmp/dl17202-ios-statements-loaded.png`, `/tmp/dl17202-ios-ready.png`; Maestro `/tmp/dl17202-{ios-entry,ios-data,android-full}.yaml`. 로컬 임시 증거로 장기 보존을 보장하지 않는다. 기존 역할·필터·페이지네이션/재시도 검증은 11/3·11/6 기록을 활용했고 새 전수 QA로 주장하지 않는다.
- Jira [DL-17202 댓글44863](https://innovaid.atlassian.net/browse/DL-17202?focusedCommentId=44863)에 완료·확인 방법·남은 검증을 기록했다. 실제 NOTIFICATION/PUSH 최종 랜딩·소속 정보의 통합 검증이 범위에 남으므로 `진행 중` 유지. 사용자 조건부 상태 변경 요청을 최종 QA/배포 완료 승인으로 확대하지 않았다. PR·배포 없음. 즉시 PM/BE 신규 API 요구 없음; 실제 계약 전달 시 연결·검증 재개.
- 사용자가 Reactotron 일시 끊김 자체보다 로컬 준비 시 두 기기 모두 연결 확인을 요구했다. `AGENTS.md`·`SESSION_WORKFLOW.md`에 공통 기준을 추가했다. 최종 양 앱 Reactotron readyState1 확인. 앞으로 debugger를 먼저 열고 iOS·Android 연결을 각각 검증하며 한 기기만 연결된 상태를 세팅 완료로 보고하지 않는다. 현재 서버·기기·웹/IDE는 유지한다.

**로컬 미리보기 재개 — 2026-11-06 15:45 KST:** 사용자가 웹·앱 실행을 요청한 후 웹은 직접 실행하기로 범위를 줄였다. Cursor `--classic --reuse-window`로 `/Users/parkjongsun/Repository/dentlink-client-notification-center`·`feature/DL-17058@dea89193`와 내부 터미널을 열었다. 웹3000/3005는 꺼져 있으며 사용자가 `pnpm dev:clinic`, `pnpm dev:lab`으로 실행한다. 병원앱은 `/Users/parkjongsun/Repository/dentlink-app`·`feature/DL-17059@1b1e449d`의 외부 Terminal Metro8081(PID82384, ttys006)과 Android AVD(PID82988, ttys007), 기존 iPhone17Pro/iOS26.5를 사용한다. 양 OS DEV 홈과 동일8081 연결, Metro·Android의 Terminal 소유 관계를 확인했다. Reactotron9090 초기 준비 때 iOS만 연결됐고 Android는 연결 종료(readyState3) 상태였다. 후속 사용자 확인 요청으로 앱 화면/프로세스를 재시작하지 않고 기존 Reactotron 클라이언트만 재연결했다. Android readyState1·connected true와 ADB→Reactotron9090 ESTABLISHED, 기존 iOS 연결 유지를 확인했다. 다음 시작에는 Reactotron을 앱보다 먼저 열고 양 OS 디버거 연결까지 확인한다. 로그인과 제품 코드를 유지했으며 웹 실행 추가 시도는 사용자 요청으로 중단했다. Codex 실제 종료 생존 테스트는 하지 않았다. 앱·터미널·Cursor를 유지하고 대기한다.

**역할·화면 분리의 목적 — 2026-11-06:** 사용자는 에이전트에 일을 맡긴 뒤 다른 업무를 병행하는 경우가 많다. Testing Chrome/사용자 일반 Chrome 분리, 외부 실행과 로컬 미리보기 구분은 사용자 업무의 포커스·입력·탭·화면을 빼앗지 않고 독립적으로 작업/확인하도록 하는 공통 목적이다. 직접 보고 있을 때만 적용하는 선호가 아니다. 웹의 핵심은 **코드 변경+실행 명령/로그+변경 화면**, 앱의 핵심은 **변경 화면+Reactotron 같은 디버깅 도구+실행 명령/로그**다. Cursor+내부 터미널+일반 Chrome은 현재 익숙한 웹 조합일 뿐 고정 규칙이 아니며 더 적합한 대체 조합도 가능하다. 앱 IDE는 필수가 아니다. 정확한 창 위치/개수/프로그램 이름보다 관찰·제어 목적과 Codex 독립 실행을 충족한다. 공통 지침에 반영하며 이번 의도 정리를 이유로 현재 기기·서버·창을 변경하거나 새 디버깅 도구를 실행하지 않는다.

**미리보기 프로세스 경계 정정 — 2026-11-06:** 사용자가 Codex 종료·재실행 뒤 앱 기기가 꺼졌다고 알렸다. 실제 확인에서 외부 Terminal의 Metro31402/ttys006/8081은 살아 있었고 iOS booted0·Android emulator 없음이었다. 따라서 외부 터미널이 로그 읽기 전용이었다는 설명은 틀리며, Metro 이전은 실제 실행으로 완료됐지만 Android emulator는 이전 Codex exec(session91915)에 남아 있었다. iOS 종료의 정확한 트리거는 확인하지 못했다. Metro1개 공유 설명은 맞지만 독립 기기 실행을 위한 추가 터미널까지 불필요하다는 뜻으로 받아들이게 한 인계는 불충분했다.

사용자는 ‘평소 내부 개발·제어는 Codex에서 진행해도 되지만, 로컬 직접 확인 요청 시에는 앱 실행 전체가 Codex 종료와 독립되어야 하며 추가 터미널도 허용’이라고 명확히 재확인했다. 이 기준을 공통 지침에 추가한다. 살아 있는 Metro는 유지하고 새 외부 Terminal의 Android창(ttys005)에서 기존 AVD를 실행하고, iOS창(ttys007)에서 기존 시뮬레이터 부팅·앱 실행을 수행했다. Android emulator48654→외부 zsh48627→Terminal31240의 실제 소유 관계를 확인했다. iOS/ADB의 launchd 소유는 정상이며 억지로 Terminal 자식으로 바꾸지 않는다. Codex를 실제 종료하는 생존 테스트는 하지 않았으므로 수행한 것으로 기록하지 않는다. 최종 양 OS Office DEV가 같은8081에 연결됐고 실제 Home 캡처를 확인했다. Android 홈 공지만 Close로 닫았다. 외부 Terminal 창3개는 Metro(ttys006, 실행 중)·Android(ttys005, emulator 실행 중)·iOS(ttys007, 부팅/앱실행 완료 후 프롬프트)다. 기존 로그인·설치·권한과 제품 코드를 유지했다. 실행을 켜둔 채 대기한다.

**로컬 확인 기본 구성 확정 — 2026-11-06:** 사용자는 현재의 앱 확인 화면(외부 Terminal+시뮬+에뮬)과 웹 확인 화면(IDE 하단 서비스 터미널+외부 브라우저)을 각각 기본 세팅으로 확인했다. 정확한 창 좌표나 특정 Space까지 재현하라는 뜻이 아니라 사람이 명령·로그·서비스 화면을 보기 편한 구성이다. Codex가 내부에서 단독 작업할 때는 이 구성이 필수가 아니며, 사용자가 로컬 확인용 세팅을 요청할 때 적용한다. 병원앱 한 제품의 양 OS가 같은8081을 쓰므로 외부 Metro 터미널1개가 맞다. 기공소앱도 함께 실행할 때만 별도 Metro/포트가 필요하며 기기 수대로 터미널을 추가하지 않는다. 이 기준을 공통 `AGENTS.md`·`SESSION_WORKFLOW.md`에 반영하고 로컬 지침에도 동기화한다. 현재 Office8081·웹3000/3005는 유지하고 Lab8082는 꺼진 상태 그대로 둔다. 기존 배치를 불필요하게 변경하거나 앱·서버를 재시작하지 않는다. 기능 구현·검증의 완료/BE 대기 범위는 유지하며 새 요청까지 대기한다.

**최신 실행 상태 — 2026-11-06 외부 Terminal 전환:** 사용자가 앱 실행 로그를 Codex 밖에서 직접 보도록 요청하여, 앱·기기는 유지하고 Office Metro만 macOS Terminal 창으로 옮겼다. 기존 적합한 idle Terminal 창4581을 재사용했고 제목은 `Dentlink Clinic DEV · Metro 8081`, TTY는 `/dev/ttys006`이다. 정확한 `/Users/parkjongsun/Repository/dentlink-app`·`feature/DL-17059@1b1e449d`에서 `yarn react-native start --port 8081 --no-interactive 2>&1 | tee -a /Users/parkjongsun/Library/Logs/Codex/Dentlink/office-metro-8081.log`를 실행한다. 현재 PID31402는 실제 외부 Terminal TTY 소속이며 이전 Codex 내부 PID30872/session83819를 대체했다. 단일8081 리스너·Metro cwd·status running·양 OS Office DEV inspector 재연결·Terminal 창 visible/busy와 연결 로그를 확인했다. iOS 앱PID29923/AndroidPID14629는 유지했고 시뮬/에뮬·앱·로그인·화면을 종료/재시작하거나 웹을 조작하지 않았다. 창 크기/배치는 임의 변경하지 않았다.

- 별도 터미널에서 `tail -n 100 -F /Users/parkjongsun/Library/Logs/Codex/Dentlink/office-metro-8081.log`로 확인한다. 해당 tail만 Ctrl+C로 끝내도 Metro/앱은 유지된다.
- 로그는 로컬 전용(디렉터리0700·파일0600), Git 밖이다. 기록 시작 전 과거 출력은 소급하지 않는다. 현재 Metro의 실행/번들/연결/경고 출력이며 JS console 전체나 네이티브 전체 로그를 추가 수집하는 설정은 아니다. `--client-logs`는 켜지 않았다.
- 앱을 직접 보며 확인할 때는 이번처럼 외부 Terminal에서 실행 명령과 로그를 볼 수 있게 한다. 같은 로컬 미리보기를 다시 실행할 때 위 방식과 경로를 재사용하되 실제 PID·checkout·포트를 확인한다. 외부 Metro 실행 창의 Ctrl+C는 Metro를 종료한다. 별도 `tail` 창의 Ctrl+C와 구분한다. 이번 변경은 실행 환경만이며 제품 코드/PR/배포 변경은 없다. 앱을 계속 켜둔 채 다음 사용자 요청을 기다린다.

**미리보기 재개 — 2026-11-06:** 최종 검증/정리 후 사용자가 병원앱만 시뮬·에뮬에 켜두도록 요청했다. 개인 정본·Office를 ff-only 최신화했고 제품 변경 없이 `/Users/parkjongsun/Repository/dentlink-app`·`feature/DL-17059@1b1e449d`의 같은 DEV/Metro8081로 양 기기를 실행했다. iPhone17Pro/iOS26.5(`5C0E7639-2345-4B3F-9979-56AFDDA1C708`)의 `com.innovaid.dentlink.development`, Android `Dentlink_API_36`/emulator-5554의 `com.innovaid.android.dentlink.development`가 동일 Metro inspector에 연결되고 로그인된 Home을 표시하는 것을 확인했다. 기존 공지는 Close로 닫고 로그인·권한·소속·창 배치는 변경하지 않았다. iOS 기존 소속86/213과 Android1409/1889는 각 저장 상태대로 유지하며, 제품/작업본/서버는 동일하다.

- **지금 유지:** Office Metro8081(PID29832/session89130), Android AVD(PID29559/session91915), iOS DeviceHub 창. Lab8082는 실행하지 않았다. 사용자가 켠 웹·일반 Chrome·IDE는 조작하지 않았다. PID/session은 재개 시 다시 확인한다.
- **실행 메모:** 기존 `yarn start`는 package script의 구식 `--experimental-debugger` 인수 때문에 종료돼 제품 코드 수정 없이 `yarn react-native start --port 8081`로 실행했다. Metro cwd와 양 제품 식별자를 확인했고 새 빌드·재설치·전체 QA를 하지 않았다.
- **다음:** 아래 검증·push 완료 및 BE/정책 대기 범위는 유지한다. 이번 앱 미리보기는 켜둔 채 사용자 직접 확인/새 요청을 기다리며 추가 폴링·구현하지 않는다. 아래 ‘앱 종료’는 직전 마감 당시 상태다.

**최신 마감 — 2026-11-06:** 사용자 요청한 Android 제한 재확인→앱 commit/push·종료→Clinic/Lab 웹 기본 흐름 검증을 완료했다. **현재 확인 범위의 추가 FE 수정 잔여는 없다.** Office `feature/DL-17059@1b1e449d`, Lab `feature/DL-17060@93c5e874`를 push했고 Web `feature/DL-17058@dea89193f`는 이번 재검증에서 추가 결함이 없어 기존 원격 상태를 유지했다. 세 제품 clean·upstream0/0·원격 SHA 일치를 확인했다. PR·merge·배포는 없다.

- **검증:** Android Office/Lab 짧은 재실행·알림/설정 왕복에서 새 ANR/crash0. 최초 멈춤의 원인은 미확정이다. 웹 양 제품 PC/모바일 너비·실제 Clinic 소속 전환/원복·제어한 권한/실패 복구·기존 목적지 연결의 최종15건 통과, pageerror0. [앱 테스트 보고서](dentlink-unified-notification-center-runtime-2026-11-06.md)와 [웹 테스트·중간 요청 결과](dentlink-unified-notification-center-web-runtime-2026-11-06.md)에 실제 API/DEV mock/기기 한계를 구분했다.
- **실행 상태:** 시뮬·에뮬·앱 Metro8081/8082 및 본 세션의 Testing Chrome/드라이버 종료. 사용자 일반 Chrome·창 배치·IDE 웹 서버3000/3005는 유지했다. 설치·로그인·권한 데이터는 보존했다.
- **브라우저 지침:** 일반 Chrome Apple Events JavaScript를 사용자 승인대로 활성화하고 실제 읽기로 검증했다. 이후 Testing Chrome으로 돌아가 검증을 완료했다. Testing Chrome→기존 일반 Chrome→컴퓨터 유즈 우선순위를 공통 지침에 저장하고 로컬 동기화했다.
- **남음:** 새 BE 목록/읽음/삭제/설정/미읽음·실제 푸시 계약 연결, USER/Employee 및 Lab Home 미정 정책, iOS 실제 OS 토글·실제 비OWNER 서버권한 확인. Lab 실제 다중소속은 사용자 확인대로 잔여 범위에서 제외한다. 새 요청/명세 전 추가 폴링·구현하지 않는다.

아래11/6 기록은 위 마감에 이르기 전의 경과다. 과거 ‘로컬 변경·미푸시·기기 유지’ 표현을 현재 상태로 재사용하지 않는다.

**11/6 후속 사용자 확인:** 이번 Lab 앱은 단일소속 전제이며 밀링센터 계정 전환은 이번 소속 검증과 무관하다. **Lab 실제 다중소속 검증은 잔여 작업에서 제외**한다. 아래 과거 ‘다중소속 계정 확보 필요’는 당시 기록이며 현재 완료 조건이 아니다. OS 확인의 잔여는 iOS 실제 OFF/ON 실기기 확인으로 한정하고, Android OS 변경 및 iOS 앱 복귀/배너/팝업/토글 로직의 기존 검증은 유지한다. 현재 확정 범위에서 추가로 재현된 FE 수정 잔여는 없고 제품 수정 commit/push를 완료했다. BE·정책 확정 후 실제 연결/검증은 별도다. Android 일시적 멈춤의 원인 미확정은 별도 관찰 사항이며 해결 완료로 표현하지 않는다.

**검증 작업 방식 재확인:** 사용자는 이번의 요구사항별 실제 실행→기존 동작 대조→실패/지연/이탈/중복 재현→원인 수정→최종 재검증→실제/제어 응답 및 범위 밖 한계 구분이라는 작업 방향을 원하는 방식으로 확인했다. 보고서 형식만의 선호가 아니며, 다음 관련 검증에서도 이 접근을 따른다.

**앞선 후속 — 2026-11-06 앱 4개 축 테스트:** 사용자 기준(OS/소속 전환/권한/기본 알림)으로 Office·Lab 양OS를 검증했다. Office는 실제 활성화 API 전환/원복·다른 병원 크레딧 랜딩, Lab은 실제 단일소속 조회·실패/복구를 확인했다. 새로 발견한 **딥링크 전환 실패 무안내(양 앱)**와 **Lab 실패 deferred 링크 자동 반복**을 보완했다. 앞선 OS2건 포함 로컬 변경은 Office6/Lab4파일이며 **제품 commit/push는 아직 하지 않았다.** 실제/제어 응답·권한/BE/기기 한계를 구분한 [11/6 앱 테스트 보고서](dentlink-unified-notification-center-runtime-2026-11-06.md)가 최신 검증 정본이다. 두 기기는 Office DEV8081로 맞추고 미리보기/로그인/창 배치를 유지한다.

**앞선 후속 — 2026-11-06 OS 알림·앱 복귀 점검:** 사용자에게 보이는 Office/Lab 양 OS에서 알림 설정을 점검하고 FE 누락2건을 로컬 수정했다. Office `feature/DL-17059@933d054b`+5파일, Lab `feature/DL-17060@a6432e2`+3파일이며 **이번 수정은 아직 제품 commit/push하지 않았다.** Android 실제 OS OFF/ON·복귀, iOS 실제 미허용 상태와 제어된 권한 응답 보완 검증을 구분한다. 신규 수신 설정은 아직 DEV mock이며 실제 BE 저장 완료가 아니다. 검증 후 두 기기를 같은 Office DEV/Metro8081로 복원했고 서버·화면은 켜 둔다. 상세는 아래11/6후속 절을 따른다.

**사용자 로컬 확인 재개 — 2026-11-06:** 개인 정본과 세 제품의 clean 상태를 확인하고 `git pull --ff-only` 후 기존 원격 HEAD를 유지했다. Web `/Users/parkjongsun/Repository/dentlink-client-notification-center`·`feature/DL-17058`·`dea89193f`, Office `/Users/parkjongsun/Repository/dentlink-app`·`feature/DL-17059`·`933d054b`, Lab `/Users/parkjongsun/Repository/dentlink-lab-app`·`feature/DL-17060`·`a6432e2`. 사용자가 앱 실행만 요청했으므로 웹/IDE는 실행·조작하지 않았다. 웹은 루트에서 `pnpm dev:clinic`(3000), 별도 터미널에서 `pnpm dev:lab`(3005)로 직접 실행한다. iPhone17Pro(5C0E7639-2345-4B3F-9979-56AFDDA1C708)·Android Dentlink_API_36(emulator-5554)을 둘 다 같은 Office DEV/Metro8081로 실행했고 정상 로그인 화면(Home/Profile)·같은 Metro의 양 제품 식별자를 확인했다. Lab Metro8082도 준비했지만 기기는 Office를 표시한다. Android 시작 중 ANR/번들 로드 실패 화면이 있었고 데이터 삭제 없이 Office만 재시작했다. 재확인 시 ADB reverse 목록이 비어 있어8081/8082/9090 연결을 다시 등록한 뒤 Office가 정상 로드됐다. ANR의 정확한 원인은 단정하지 않는다. 홈 공지는 Close로 닫았고 설치·로그인·권한은 유지했다. 제품 코드 변경/추가 QA/PR/배포는 없으며 앱 미리보기는 켜 둔다. 과거 다른 채팅은 조회·조율하지 않았다.

직전 원격 반영: **2026-11-05 — 웹·병원앱·기공소앱 기본 흐름 재현·수정·최종 검증·commit/push 완료.** Web `dea89193f`, Office `933d054b`, Lab `a6432e2` 원격 반영·clean·upstream0/0을 확인했다. 조회 실패/재시도·미읽음 표시·늦은 소속 전환 응답·OS 권한 미확인 조작·기공소 iOS 오류 안내 가림을 기존 UI/동작 기준으로 보완했다. [이번 실행 근거와 한계](dentlink-unified-notification-center-runtime-2026-11-05.md)를 정본으로 삼는다. PR·merge·배포·신규 BE 연결·최종 제품 QA 완료는 아니다.

**진행 기준 — 2026-11-05:** 이번 재현된 FE 기본 흐름 결함은 보완했고, 현재 승인 범위의 미완 수정은 없다. 신규 BE API·미읽음 집계, USER 설정/집계(#20–22) 및 Lab Home 최근 메시지(#19)는 계속 확정 대기다. 기존 Clinic3000/Lab3005·앱 Metro/로그인/창 배치는 유지했고 두 기기는 같은 Office8081/Home으로 복원했다. 다른 채팅과 기기 사용 충돌은 사용자 승인으로 조율·종료 인계했다. 새 요청 전 자동 폴링·추가 구현·PR·배포는 하지 않는다.

**대기 확인 — 2026-11-05:** 사용자가 이번 작업 마감·메모리 정리 후 대기를 요청했고, 앞서 기기 충돌로 조율한 다른 세션에는 직접 재확인·작업 재개를 지시했다고 알렸다. 이 세션은 기기 점유를 종료했다. 사용자는 다른 업무와 알림센터를 독립적으로 유지하도록 재확인했다. 더 필요한 인계는 없으므로 다른 세션에 추가 전달·응답 요청·진행 조회를 하지 않으며 기기·서버도 재전환하지 않는다. 마감 당시 Office8081/Home 복원은 당시의 검증 결과로만 보존하고, 이후 실제 전면 앱 상태는 다른 작업에 따라 달라질 수 있다. 다음 요청 시 정확한 checkout·Git·실행 소스를 다시 확인한다. 이번 제품 수정·검증·push 완료 및 BE/정책 대기 범위는 그대로다.

직전 push 완료: **2026-11-05 — 최신 Slack/Figma의 OS OFF 배너·팝업과 Shipping 배치를 반영·검증·commit/push 완료.** 양 앱 설정 배너는 OS OFF 동안 상시 표시, 자동 팝업은 기기별1회 유지, 문구·레이아웃은 최신 시안을 따른다. Clinic/Office Shipping은 정책/BE 근거에 따라 Orders 하위 한 번만 표시한다. Web `3f44fc507`, Office `ddf9e766`, Lab `1b328196`. 새 BE 연결·PR·배포·최종 전체 QA 완료가 아니다.

직전 구현: **2026-11-05 — Lab 알림센터 실제 소속 조회·전환 연결**을 기존 API로 구현·검증·commit/push했다. Lab `c6debf246b2a40443a203bbec1c55d6a1266dc29` (`feature/DL-17060`). 실제 소속 목록·활성화를 연결하고 새 소속 알림함을 한 번 복원하며, 가짜 소속 목록은 제거했다. **소속별 미읽음 집계는 추정하지 않고 미제공**이다. 양 OS 실제 단일소속 및 합성 다중소속 검증을 구분했고 실제 다중소속 서버 전환은 테스트 계정 한계로 남는다. PR·배포·최종 QA 단계는 아니다.

직전 구현: **2026-11-05 — Figma399:23417의 Unread 숫자 표시를 Web·Office·Lab에 반영**했다. Web `eb609ddd7`, Office `09a777a`, Lab `91534d2`. All 숫자 없음·Unread 양수만 빨간 배지·0미노출이며, 실제 서버 저장/미읽음 집계는 여전히 명세 대기다. 사용자 확인용 화면 실행은 이후 보류됐고 Cursor 전환을 더 요청하지 않는다. 변경 검증·마감은 아래 Figma 후속 절을 따른다.

상황 점검: **2026-11-05** — BE 설계 변경 없음·Swagger 미배포를 전달받고, 세 제품 코드/Git·Jira·DEV Swagger·정책서 반환 범위를 읽기 전용으로 재대조했다. **Lab 알림센터의 실제 소속 조회·전환은 기존 API로 더 진행할 수 있는 제한적인 FE 잔여 작업**으로 확인했으며, 관련 전부를 BE 대기로 묶던 표현을 정정한다. 이 브레이크포인트 조사와 이후 사용자가 요청한 Figma 구현은 구분한다.

직전 구현 마감: 2026-11-04 — **확정된 알림센터 범위에 맞춰 이메일 작업에서 남은 Android 브라우저 모듈 의존을 양 앱에서 정리**했다. Office `cefac786`, Lab `b92207c`이며 모듈 없는 Android 빌드·양 OS 영향 경로 검증을 완료했다. 누적 네이티브/라이브러리 변경은 없다. 앞선 Credits Email·Lab 밀링 결제 제외도 유지한다. 새 BE 계약·USER 정책/와이어프레임은 계속 대기이며 PR·merge·배포·최종 QA 완료가 아니다.

이전 구현 마감: 2026-11-03 19:19 KST — **Office/Lab 설정 파란 OS 배너의 기기별 1회 영속 처리**를 당시 합의대로 구현했다. **11/5 14:49 Slack 후속으로 배너는 OS OFF 동안 상시 노출로 변경됐으며 아래 최신 정책이 우선한다.** 자동 안내 팝업의 기기별 1회는 별개로 유지한다.

- **현재 지시/완료 범위:** 앱4개 축 테스트·재현 결함 보완·Android 제한 최종 확인·제품 push·종료와 Clinic/Lab 웹 후속 검증·공통 브라우저 지침 반영까지 완료했다. Office6/Lab4파일 수정은 원격 반영됐고 웹은 추가 코드 변경이 없다. 실제 비OWNER 서버권한/iOS 실제 OS 토글/신규 알림·설정 BE 통합은 남는다. Lab 다중소속은 이번 잔여가 아니다. PR·배포 없이 사용자 검토 또는 새 BE/정책 전달 후 재개한다.
- **직전 사용자 확인:** 11/4 사용자가 “요구사항 변경으로 불필요하게 남은 코드를 정상 개발 범위대로 정리한 결과, 추가 심사가 필요한 변경이 없는 것”으로 이해·확인했다. 사용자가 직접 이 결론을 전달할 예정이며 게시 완료로 기록하지 않는다. 제품 커밋·푸시/검증과 로컬 종료는 완료 상태로 유지한다. 당시 ‘즉시 추가할 FE 구현 없음’은 아래11/5 Lab 소속 연결 조사로 보완하며, 조사한 것을 구현 완료로 바꾸지 않는다.
- **추가 자료 확인 — 2026-11-04:** Jira 댓글44798의 설정 템플릿 초안을 현재 세 제품 코드와 대조했고, 후속44802에서 Lab 밀링 결제 제외를 확인했다. 템플릿 초안 자체는 공개 API·BE 배포 완료 근거가 아니다. 후속 구현은 아래 제외 항목 반영에 한정한다.
- **상태 읽는 순서:** 이 문서 최신 상태 → [11/6 웹·브라우저 마감](dentlink-unified-notification-center-web-runtime-2026-11-06.md) → [11/6 앱 테스트](dentlink-unified-notification-center-runtime-2026-11-06.md) → [11/5 기본 흐름 재검증](dentlink-unified-notification-center-runtime-2026-11-05.md) → 필요한 경우 [11/3 앱 화면별 실행 근거](dentlink-unified-notification-center-runtime-2026-11-03.md)·[이전 상세 이력](archive/dentlink-unified-notification-center-2026-11-03-worklog.md). 과거 HEAD/진행 중/입력 대기 문구를 현재로 재사용하지 않는다.
- **기획 근거:** Notion 정책서와 확인한 Figma/Slack을 대조하되 최신 명시적 사용자 정정을 우선한다. 오늘 필요한 PRD 5-2~5-5/#14는 재대조했고 일부 조회 누락 블록이 있어 전체 본문·댓글을 완전 최신 조회했다고 주장하지 않는다. 이번 마감은 외부 자료 전수 재조사가 아니다.

## 2026-11-06 후속 — OS 알림 변경·복귀와 FE 분리 보완

- **기준:** 11/5 최신 요구대로 설정의 파란 배너는 OS OFF 동안 계속 표시하고 자동 안내 팝업만 기기별1회다. 이전 ‘배너1회’ 요구로 되돌리지 않는다. Push선택→OS설정→정상복귀/허용 시 선택 항목만 ON, 허용하지 않음·취소·흐름 이탈 시 기존값 유지다. 현재 새 알림센터 화면과 설정은 DEV mock으로 실제 서버 저장과 분리한다.
- **발견/수정1:** Office Android 실제 OFF→ON에서 기존 PermissionProvider가 legacy upsert를 호출하는 것을 재현했다. 호출1건은 임시 런타임 interceptor로 전송 전에 차단해 실제 서버전송0이다. 양 앱 `PermissionProvider`에서 DEV 신규 미리보기의 기존 자동초기화를 차단했다. 실제 권한 조회/상태·스토리지 갱신과 비DEV 기존 제품 동작은 유지한다. 수정 후 양 앱 실제 Android 복귀에서 legacy 호출0을 확인했다. 기존 API가 모든 설정을 ON으로 만든다는 의미로 확대하지 않는다.
- **발견/수정2:** Office 실제 화면 컴포넌트 테스트에서 화면 blur 후 지연된 권한 완료가 이전 선택을 켜는 결함을 먼저 재현했다. 양 앱 `useNotificationPermissionRequest.cancelPending`으로 대기 선택과 진행 중 조회 결과를 무효화하고, 화면 blur에 연결하며 적용 직전에 focus도 확인한다. OS 설정의 AppState 왕복은 정상 유지한다. 앱/계정/소속 전환이나 재시작을 넘어 선택을 복구하지 않는다.
- **Office Android 실제:** 네이티브 설정 OFF→앱 재진입 시 배너·Push 안내, 취소/허용하지 않고 복귀 시 미변경, ON복귀 시 선택한 Design Push만 ON·비선택 Updates Push는 OFF 유지·배너숨김을 확인했다. 두 항목 OFF 초기값은 기존 mock store의 제어된 fixture이며 서버 저장값이 아니다. 자동 팝업은 해당 확인키만 초기화해 최초 노출/실제 layout 후 저장을 확인하고, 앱 완전 재실행 시 재노출하지 않으며 설정 배너는 계속 보이는 것을 확인했다.
- **Lab Android 실제:** 동일 기기 쌍을 Lab DEV/Metro8082로 함께 전환했다. 실제 OS OFF·재시작 후 배너/안내, 허용하지 않은 복귀 시 두 Push OFF 유지, OS ON복귀 시 Design만ON/UpdatesOFF·배너숨김·legacy 호출0을 확인했다. 기존 확인키true에서 자동팝업은 재노출하지 않았다. 초기 OS는 ON이었고 최종 ON으로 복원했다.
- **iOS 범위:** Office 네이티브 권한은 granted였으나 이 iOS26.5 시뮬레이터의 Settings/앱설정에 Notifications 토글이 없어 실제 OFF→ON 조작은 검증하지 못했다. 네이티브 권한 조회 함수의 일시적인 blocked 응답으로 배너·자동팝업·취소·미허용복귀를 확인하고 원래 granted 응답으로 복원하여 선택항목만ON·배너숨김·legacy 호출0을 확인했다. Lab은 실제 denied 상태에서 배너·안내·OS설정왕복/미변경을 확인했으며, ON 경로만 일시적인 granted 응답으로 보완했다. 실제 iOS OS 토글 성공으로 기록하지 않는다. 모든 주입은 원복하고 앱 재시작으로 제거했다.
- **최종 코드 검사:** Office 관련 Jest26/26, Lab 기존 affiliation-switch24/24, 양 앱 기존 pushPreference 각3, Provider 실제컴포넌트 임시 하네스8(DEV 호출0·비DEV 기존 호출 유지)과 변경파일 lint/diff-check가 통과했다. Lab 테스트 파일은 저장소 지침에 따라 추가/수정하지 않았다. 독립 diff검토에서 추가 명확한 결함은 없었다. 화면이탈 race의 근거는 컴포넌트/훅 회귀이며, 별도 기기 race 주입 시도는 pending조회가 시작되지 않아 유효 증거에서 제외했다.
- **검증 중 주의:** 새 hook 편집 중 Office iOS FastRefresh의 `Rendered more hooks than during previous render`가 나타났으나 완전 종료/재실행한 최종 코드에서는 영향 경로에서 재현되지 않았다. Android 알림허용 취소 때 프로세스 재시작/번들 재로딩을 관찰했으며 앱 크래시로 단정하지 않는다. Lab 첫 Maestro `launchApp` 경로는 도구 기본 권한허용이 OS OFF를 되돌려 유효 검증에서 제외하고, ADB실행/실제설정/권한을 변경하지 않는 화면조작으로 다시 통과했다. 초기 테스트의 없는 selector 실패·전환 중 캡처도 제품 결함으로 기록하지 않는다.
- **기기/원복:** iPhone17Pro/iOS26.5 `5C0E7639-2345-4B3F-9979-56AFDDA1C708`, Android `Dentlink_API_36/emulator-5554`. Office 두 기기 OS허용ON, Lab Android ON/iOS denied 원상 유지. mock설정·기존함수·확인키를 원복했다(OfficeAndroid true/iOS null, Lab두기기true). 로그인·소속·설치 데이터는 보존했다. Lab을 종료하고 양 기기를 Office DEV/8081의 정상 Home으로 복원했다. 사용자 창 위치/크기·웹/IDE는 변경하지 않고 Metro8081/8082와 미리보기를 유지한다.
- **근거:** `/tmp/notification-android-final-on-1106.{json,png}`, `/tmp/notification-android-first-notice-1106.png`, `/tmp/notification-android-notice-restart-1106.png`, `/tmp/notification-android-banner-reenter-1106.png`, `/tmp/notification-ios-final-{off-return,on}-1106.json`, `/tmp/notification-lab-{android-final-on,ios-on-state}-1106.json`, `/tmp/notification-lab-ios-off-return-1106.json`, `/tmp/notification-lab-ios-controlled-on-1106.png`, `/tmp/notification-office-restored-{ios,android}-1106.png`; 회귀 `/tmp/notification-focus-{before,after}-1106.log`, Provider `/tmp/notification-permission-provider-1106.cjs`. 임시 증거는 로컬파일이며 장기 재실행을 보장하지 않는다.
- **남음/다음 시작점:** 실제 수신 설정 저장·재조회·다른 기기 최신 설정·저장실패 처리는 신규BE 계약 연결 후 확인한다. 새 알림센터를 비DEV에서 활성화할 때 legacy Provider 경계를 함께 최종 전환해야 한다. 실제 iOS OS OFF→ON은 Notifications 설정을 제공하는 환경/실기기에서 추가 확인이 필요하다. 제품로컬 변경 Office5/Lab3이 남았으므로 차후 commit/push 상태를 혼동하지 않는다. 이번에 새 API·네이티브/의존성·이메일·PR·배포는 변경하지 않았다.

## 2026-11-05 마감 — 세 제품 기본 흐름 재현·보완

- **사용자 우려에 대한 결론:** 단순 소속 전환 무반응은 FE 버그였고, 추가 리뷰에서도 정상 경로만으로 놓치기 쉬운 실패·지연·화면 이탈 문제가 실제로 재현됐다. 아래 과거 후보표의 항목은 이번 승인 후 재현·보완했으며 실제/제어된 응답/미검증을 [실행 기록](dentlink-unified-notification-center-runtime-2026-11-05.md)에 분리했다. 모든 조합의 무결성을 보증하거나 새 BE 미완성을 이번 FE 오류의 원인으로 돌리지 않는다.
- **Web `dea89193f`:** 가짜 다른 소속 미읽음 점 제거, Lab 전환 불가 상태의 캐시 진입점 제거, Clinic/Lab 소속 조회 오류·재시도·로딩 연결. Clinic5/Lab4 회귀 및 실제 로그인 PC·모바일 기본흐름, Clinic 실제 소속 전환/실패/원복 통과. Lab 실제 단일소속 한계 유지.
- **Office `933d054b`:** 화면 이탈 후 늦은 소속 응답 무효화, 직원정보 로딩·재시도, OS 권한 미확인 중 직접 Push만 잠금. 관련29테스트와 양OS 최종 영향 흐름을 확인했다. 정상 조회는 실API, 전환 실패·지연/권한 경계는 제어된 응답이며 실제 서버 쓰기를 차단했다.
- **Lab `a6432e2`:** 소속 재조회 실패 시 기존 행 유지·최초 실패 Retry, OS 권한 미확인 조작 보호, iOS 시트 뒤 오류 Toast 가림을 dismiss 완료 후 기존 문구1회로 수정. hook24·화면 격리8 및 양OS 최종 표시/재시도/설정·인박스 복귀 통과. 단일소속 실계정+합성 다중소속임을 구분했다.
- **기준선/남음:** 변경 lint·관련 회귀 통과. 앱 전체 타입은 Office6/Lab5 기존 오류 동일이며 웹 기존 번역 감사 누락/시트 충돌은 덮지 않았다. 새 알림 REST·설정 저장·미읽음 집계·푸시 읽음/클릭 연결·USER 후속 정책은 대기다. 기존 정책/설정 부모·하위 관계·Email 동작·실시간 동기화 제외·이메일 별도 범위는 유지했다.
- **원복/인계:** 테스트 주입·소속/계정/mock 상태를 복원했고 실제 native 권한·설치/로그인은 유지했다. 동일 iPhone17Pro·emulator5554를 Office8081/Home으로 복원, 웹3000/3005와 Metro는 유지했다. 다른 채팅의 Lab DL17262와 기기 충돌은 사용자 승인 메시지로 점유를 조율하고 완료 인계했다. 이전 혼선 캡처는 최종 Office 검증에서 제외했다.
- **Git/마감:** 세 제품 각각 최종 소스 hash를 검증 코드와 대조하고 원격 SHA 일치·clean·ahead/behind0/0을 확인했다. 개인 컨텍스트의 이 문서와 실행 기록만 commit/push한다. PR·merge·배포·Slack/Jira/Notion/Figma 변경은 없다. 이후 새 명세/사용자 요청을 기다린다.

## 2026-11-05 후속 — 추가 기본 흐름 점검과 디자인 미확정 기록

- **사용자 전달:** 기존 병원 선택과 API가 같은 건은 디자이너와 논의했고 기존 UI를 고려할 예정이나 디자인은 아직 확정되지 않았다. [Figma48:12796 댓글1995951639](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=48-12796&m=dev#1995951639). 이번 도구에서 댓글 원문에 접근되지 않았고 해당 댓글 번호의 알림 메일도 없었으므로 사용자 전달을 근거로 기록한다. 새 UI 확정/반영 완료로 바꾸지 않는다.
- **사용자 우려/답변:** 가볍게 둘러봐도 기본적인 병원 전환이 안 되는 것은 웹에서도 앱 크래시와 비슷한 신뢰 문제이며, 웹·Office·Lab 전체에 유사 문제가 남을 가능성을 물었다. 기존 클릭 무반응은 신규 BE 미완성이 아니라 FE 조회 상태 처리 버그였고 수정 전/후 테스트로 원인을 확인했다. 정상 경로 검증만으로 ‘FE 추가 작업 없음’이라고 보고한 범위가 지나치게 넓었다. 완료한 개별 수정과 전체 기본 흐름의 신뢰성은 구분한다.
- **이번 범위:** 세 제품 최종 HEAD/clean을 확인하고 알림 진입·설정·소속 선택/전환의 기존 UI 및 loading/error/empty·중복·소속/계정 변경·화면 이탈을 독립 읽기 리뷰했다. 아래는 코드상 연결 누락/위험이며 이번에 실제 화면 재현·제품 수정·추가 전체 QA는 하지 않았다.

| 대상 | 코드에서 확인한 잔여 / 재현할 조건 | 근거·다음 확인 |
| --- | --- | --- |
| Clinic/Lab Web | 실제 단일소속 host에도 mock 가짜 소속2개의 미읽음을 합산해 현재 알림을 모두 읽어도 헤더 점이 남을 수 있음 | `NotificationCenterMock.tsx`65–98/164. 실제 다른 소속 미읽음을 추정하지 않고 현재 제공된 preview 상태와 표시 관계를 재현·정리 |
| Lab Web | canSwitch=false가 돼도 캐시된 소속이 있으면 목록은 표시되고 클릭 guard만 막을 수 있음 | `NotificationCenter.tsx`57–62/85–94/166–184. 기존 `LabSwitchModal`은 노출 자체를 canSwitch로 제한. 일반 소속 변경 시 cache clear 경로가 있어 조건부 위험이며 실제 갱신 경계 재현 필요 |
| Clinic/Lab Web | 첫 소속 GET 실패와 실제 다른 소속0개를 같은 값으로 처리해 진입점이 없어짐 | host `employers.length ? ... : null`. 기존 Lab 선택창의 loading/error/retry/empty 패턴과 대조해 재현. 새 BE API 없이 확인 가능 |
| Office | A→B 전환 대기 중 같은 A 소속 딥링크가 다른 화면으로 reset해도 늦은 B 응답이 소속을 바꿀 수 있는 경로 | `NotificationCenterScreen.tsx`170은 `handleChangeEmployee`의 유효성 callback을 넘기지 않음. helper103–129는 auth/소속만 확인. 다른 계정/소속 보호는 있으나 화면 이탈 경계는 별도 기기 재현 필요 |
| Office | 기존 employee/권한 조회 전·실패 시 설정 sections=[]로 빈 카드 영역만 보임 | `NotificationCenterScreen.tsx`117–134/`NotificationSettings.tsx`76. 공통 오류 Toast와 별개로 조회 중/실패/설정 없음의 구분 및 기존 재시도 패턴 확인 |
| Lab app | 선택 전 소속 재조회가 실패하면 캐시가 있어도 isError 때문에 otherLabs=[]가 되어 시트가 비고 진입배너도 사라짐 | `useNotificationLabSwitch.ts`25–42/101–103, screen187, sheet131. enabled:false query여서 같은 화면 즉시 재시도 없음. 기존 검증의 ‘활성화 실패 후 행 복구’와 다른 분기이며 집중 재현·보완 필요 |
| Lab app | OS 권한 조회 전/실패를 blocked=false로 취급해 Push ON 안내를 건너뛸 수 있음 | screen52/77–81/107–110, `NotificationSettingsGroup.tsx`38–54. 실제 저장은 mock이지만 FE 상태 연결 문제 후보. 권한 불명/확인 중을 구분하고 Office의 같은 경계도 함께 확인 |
| Lab app | 열린 iOS 선택 시트 뒤에 오류 Toast가 가려질 가능성 | `CustomBottomSheetModal`의 FullWindowOverlay와 App root Toast 레이어가 다름. 기존 runtime은 행 복구만 증명하며 Toast 가시성 결함으로 확정하지 않았음. 실제 캡처로 확인 후 판단 |

- **다음 시작점:** 위 항목을 사용자 흐름으로 재현하고 문제로 확인한 것만 기존 제품 패턴으로 보완한다. 새 디자인/카피/정책을 임의로 만들지 않는다. 특히 웹 Clinic/Lab 및 앱 Office/Lab 양 OS에서 진입→조작→결과와 조회 지연/실패→복구, 닫기/화면 이탈의 관찰 결과를 구분한다. 앞선 통과 근거를 재사용하고 무관한 앱 전체 기능/역할 조합을 늘리지는 않는다. 현재 코드의 미완 BE 연결과 별개인 기본 기능 안정화가 우선이며, 이 목록을 실제 재현/수정 완료로 표현하지 않는다.

## 2026-11-05 후속 — 소속 선택 무반응·목록 차이·웹/앱 로딩 표시

- **사용자 질문에 대한 결론:** Clinic 기존 `OfficeSelectListModal`과 알림 `NotificationCenter` 모두 `useUserOwnEmployeeListQuery("activate")`로 `GET /office/users/own/employee`를 조회하고, 이름은 같은 `employer.name`을 표시한다. 활성화도 같은 `PATCH /office/employee/activates`다. 기존 선택창은 현재 병원을 체크해 맨 위에 표시하고 알림의 ‘다른 병원’ 목록은 현재 소속을 제외한다. 현재 소속 유무로 목록이 다르게 보인다는 사용자의 추정이 맞으며 다른 API/가짜 소속으로 대체한 것이 아니다. 알림에만 있던 선택사항 `employer.id` 필터는 실제 전환 식별자인 employee id를 기준으로 정리했다. 이 누락 가능성과 클릭 무반응은 서로 다른 문제다.
- **웹 원인:** `affiliations.isFetching`을 클릭 함수에서만 읽고 렌더에서 구독하지 않아, 캐시가 있는 재조회 중 부모 렌더 후 동일한 데이터가 반환되면 클릭 함수에 과거 조회 중 상태가 남을 수 있었다. 실제 query가 idle인데 화면 버튼은 활성 상태이고 API 호출은0회인 경로를 수정 전 코드에서 재현했다. 렌더에 조회 상태를 연결하고 `isLoading`/`isSwitching`을 구분하여 목록 영역에 기존 DLDS `LoadingSpinner(85px)`를 표시한다. 조회 중 닫기는 허용하고 실제 활성화 중 중복/닫기 방지는 유지한다. Lab 웹의 같은 사용처에도 반영했고 기존 쓰기/업로드 보호 조건은 변경하지 않았다.
- **웹 검증·마감:** 수정 전 실패/수정 후 통과한 회귀 테스트2개(동일 데이터 재조회 후 전환, 선택사항 employer id 누락)를 추가했다. 기존 저장 로그인으로 실제 Clinic3000에서 조회 지연→목록 복구, 합성 활성화503→기존 소속 유지, 실제 활성화 지연→성공→원 소속 복귀를 확인했다. 실제 공용 모달 PC1280/모바일390에서 로딩/닫기/활성화 중 잠금/복구와 pageErrors0을 확인했다. 실제 Lab 웹 다중소속 전환의 추가 증거는 아니다. 변경 lint·Clinic/Lab/Admin 타입·필수 push 훅(lint 오류0, Admin guard9, configs21, hooks32, coverage 기준) 통과. Web4파일 `fe17a40748dcbd9b66b17ccd4c3ab61fb9853168` push 완료·원격 일치·clean·0/0이다. 근거 `/tmp/notification-switch-final-1105.cjs`, `/tmp/notification-selector-ui-results-1105.json`, `/tmp/notification-clinic-refetch-before-1105.log`, `/tmp/notification-switch-web-{commit,push}-1105.log`.
- **Office 변경·검증:** 기존 일반 소속 전환의 `ModalLayout + Spinner36`을 재사용해 시트를 닫은 뒤 진행 중임을 표시하고, 동기 ref로 중복 선택/시트 재열기를 막았다. API·문구·실패 정책은 유지한다. 동일 최종 코드/DEV/8081의 iOS·Android에서 실패 시 소속 유지, 지연 중 dim/spinner, 중복 방지, 실제 서버 전환 및 원 소속 복귀를 확인했다(각 OS 실제 PATCH2건, 다른 쓰기0). 실패 첫 선택은 기기 UI 터치, 지연/중복/복원은 실제 화면 callback+기기 캡처로 검증했으며 전부 수동 E2E라고 확대하지 않는다. 주입·인터셉터·임시 상태를 복원했다. lint/diff 통과, 전체 타입은 기존6진단과 동일하다. Office1파일 `52bbdfa179fdd1034653c12f968606b2bc8bfdb7` push 완료·원격 일치·clean·0/0. 근거 `/tmp/office-notification-switch-loading-runtime-1105.md`.
- **Office 검증 도구 한계:** 최초 iOS Maestro 검증에서 XCTest의 `XCTAutomationSession initWithAccessibilityFramework:dataSource:` SIGSEGV와 앱/SpringBoard 종료가 관찰됐다. 변경 RN 코드의 호출 스택은 아니므로 제품 결함으로 단정하지 않았다. 기존 로그인으로 재실행하고 XCTest를 사용하지 않은 최종 코드 검증에서는 종료가 없었다. 전체 무크래시 보장으로 표현하지 않는다.
- **Lab 변경·검증:** 같은 stale 상태 버그는 확인되지 않았으나 조회/선택 재조회/활성화 동안 목록이 조용히 비활성화돼 기존 `LoadingSpinner`로 진행 표시를 추가했다. `useNotificationLabSwitch`의 `isFetching`을 렌더에 연결하고 목록은 로딩 동안 항목 대신 스피너를 표시한다. 기존 취소·잠금·오류 토스트는 보존한다. 대상 lint/diff·훅21테스트 통과, 전체 타입은 기존5진단만 남는다. 실제 계정은 단일소속이므로 auth/권한을 바꾸지 않고 목록 응답에 합성 소속1개를 넣어, iOS·Android 같은 최종 코드/DEV/8082에서 최초 조회→행 복구→실제 항목 터치→선택 재조회/활성화 대기→합성 실패→원 소속/행 복구를 확인했다. 실제 PATCH를 보내지 않았으며 성공한 서버 다중소속 전환으로 확대하지 않는다. 양 OS 검증 중 크래시/error overlay는 관찰하지 않았다. Android 자동화 도구의 spinner 애니메이션 대기는 제품 오류와 구분한다. 원 service/query 상태·interceptor를 복원하고 switching=false/pending없음/auth동일을 확인했다. runtime 파일3개 SHA를 commit 직전 대조했고 Lab `a5b4480bd8555405c57d523f459333e67a24bfc6` push·원격 일치·clean·0/0 완료. 근거 `/tmp/lab-switch-loading-runtime-1105.md`, `/tmp/lab-switch-loading-sourcehash-1105.json`.
- **공통 지침:** 웹에서 보고된 문제라도 같은 동작/실패 가능성이 있는 앱을 함께 좁게 확인한다. 조회/실행 때문에 동작할 수 없다면 해당 영역에 제품의 기존 로딩을 보여 주며 클릭을 무표시로 버리지 않는다. 새 디자인이 없다는 이유로 기존 로딩 동작을 생략하지 않는다. 이를 `DEVELOPMENT_STYLE.md`에 보강했다.
- **계속 남는 범위:** 실제 알림 목록/읽음/설정/미읽음과 USER 정책 등 기존 BE/정책 대기는 변경하지 않는다. 실제 소속 API를 쓰는 것과 알림 본문/mock 데이터를 구분한다. Lab 실제 다중소속 계정으로 서버 전환 검증은 계정 확보가 필요하다. 이번 후속은 소속 전환 버그/피드백 보완이며 알림센터 전체·최종 QA·PR/배포 완료가 아니다.
- **마감/사용자 로컬:** Web `/Users/parkjongsun/Repository/dentlink-client-notification-center`·`feature/DL-17058`, Office `/Users/parkjongsun/Repository/dentlink-app`·`feature/DL-17059`, Lab `/Users/parkjongsun/Repository/dentlink-lab-app`·`feature/DL-17060` 유지. 기존 Clinic3000/Lab3005와 Office8081/Lab8082 서버는 종료/대체하지 않았다. 양 기기는 Lab 검증 후 같은 Office8081/DEV/Home으로 복원했고 창 위치/크기·브라우저 그룹은 유지했다. 사용자 일반 Chrome은 JS 자동제어 설정을 바꾸지 않았고 실제 로그인 검증은 별도 headless 세션에서 했다. 그 과정에 기존 DevTools의 열린 탭/페이지 내 상태는 바뀔 수 있으므로 표시 창 자체의 모든 조작을 검증했다고 주장하지 않는다. `setup-local-codex.sh` 공통 지침 동기화 완료. 질문/처리/검증/미완 범위를 보고하고 추가 요청을 기다린다.

## 2026-11-05 후속 — 기존 토스트 연결·웹/앱 공용 UI 사용 감사

- **사용자 기준:** 새로운 요구/디자인이 아닌 일상적인 동작은 제품의 기존 UX를 따른다. 같은 컴포넌트를 가져와 임의 위치/호출 방식으로 표시하는 것도 올바른 재사용으로 보지 않는다. 공유 컴포넌트 자체의 버그와 사용처의 의도적 차이를 구분한다. 이를 `AGENTS.md`와 `DEVELOPMENT_STYLE.md/Existing UI First`의 웹·앱 공통 지침으로 기록했다. 새 화면/정책을 ‘상식’으로 발명하라는 뜻은 아니다.
- **Web 원인·수정:** `NotificationCenterMock`가 공용 DLDS Toast를 사용하되 `modal-root` Portal·`BOTTOM_CENTER`·별도 state/타이머로 직접 렌더했다. 이 경로를 제거하고 Clinic/Lab의 기존 `useToast.openToast`를 `onShowToast`로 전달한다. 기존 전역 ToastMessage가 위치/레이어/3초 표시를 처리하며 PC 우측 상단·모바일 헤더 아래로 통일한다. initialOpen 한 구간을 ref로1회 소비해 불안정한 callback identity/StrictMode 재실행으로 중복 표시하지 않으며 다음 전환은 정상 허용한다. 실제 소속 활성화/목적지 준비 조건·메시지 문구·실패 처리·읽음/미읽음 데이터는 변경하지 않았다.
- **Web 추가 감사:** 알림 진입·설정·소속 선택·모달의 닫기/뒤로가기·포커스/스크롤 복원·Dropdown/Switch/Checkbox를 기존 공용 구현과 비교했다. 토스트/앞선 아이콘 외 추가로 수정할 명확한 이탈은 찾지 못했다. PC 팝업/모바일 전체 화면은 확인된 요구이고 헤더 종의 IconBadge hover는 기존 공통 동작이므로 유지한다.
- **Office 감사:** 정확한 `feature/DL-17059@be825ad6`·최신 origin·clean을 확인했다. 전환 Toast.show(success/error)는 기존 EmployeeProfile과 같은 CustomToast→공통 ToastMessage 경로(bottom55/2초)이며 위치/renderer override가 없다. Popup·CustomBottomSheetModal·Layout/Header·Switch·Typography/Icon 및 추가 목록의 Layout/Spinner/Chip/RootStack을 재사용한다. 빨간 배지/OS배너/335폭 팝업 등은 확인된 Figma/웹모바일 기준 차이여서 유지한다. 근거 `/tmp/office-notification-common-ui-audit-1105.md`.
- **Lab 감사:** `feature/DL-17060@193ee8b5`·최신 origin·clean을 확인했다. RootNavigator/useNotificationLabSwitch의 토스트는 공통 Toast.show→CustomToast/appToastConfig(bottom55/2초)를 사용한다. disableLabI18n은 이미 번역된 소속명 문장의 중복 번역 방지이며 스타일 차이가 아니다. Layout/Header·CustomBottomSheetModal·Switch·useUiStore.popup 재사용을 확인했다. 헤더50/팝업335/Unread pill은 명시 디자인이라 유지한다. 양 앱은 코드/기기/Metro 변경이 없어 기존 최종 코드 런타임 근거를 재사용하며 새 전체 QA 완료로 확대하지 않는다.
- **Web 검증:** 실제 `NotificationCenterMock + 각 제품 useToast + ToastMessage`를 임시 headless Chromium에서 Clinic/Lab × PC1280/모바일390으로 렌더했다. PC top85/92·right20, 모바일 top77/72·left12(기존 제품 헤더 여백) 및 단일 토스트를 확인했다. StrictMode/연속 재렌더1회·3초 자동 닫힘·다음 진입 재표시·진입 소비 후 재표시 없음 통과, pageErrors0. 원본 코드 diff를 별도 읽기 리뷰했고 계정/소속 key·준비 후 진입 경계는 보존됐다. scoped ESLint/diff 및 commit 훅의 Clinic/Lab/Admin 타입검사 통과. 근거 `/tmp/notification-toast-results-1105.json`, `/tmp/notification-toast-check-1105.cjs`, `/tmp/notification-toast-{clinic,lab}-{1280,390}-1105.png`. 사용자 실제 로그인/다중소속 서버 전환을 이번에 재실행한 증거는 아니다.
- **마감:** Web3파일 `38153dc1a58ba601a26238d0b247f61388a9d9da` commit/push·원격 SHA 일치·clean·ahead/behind0/0 확인 완료. 필수 push 훅의 Clinic/Lab/Admin lint 오류0(기존 경고 유지), Admin guard9·configs21·hooks32·coverage baseline 검사 통과. 근거 `/tmp/notification-toast-push-1105.log`. 제품 공용 토스트 자체·앱 코드·새 API·Jira/Notion/Slack·PR/배포는 변경하지 않았다. 사용자 미리보기 서버/브라우저/기기는 그대로 유지하고 후속 요구 또는 BE/정책 확정을 기다린다.

## 2026-11-05 후속 — 웹 아이콘 버튼 hover/pressed 보완

- **요구·근거:** 사용자가 웹 톱니바퀴의 길게 누르기·설정 X의 hover 이상을 지적하고 동일 방식 아이콘까지 디자인대로 수정·검증·commit/push하도록 승인했다. Figma `QLIzKYWzFFlptCYzN36Iq4`의 인박스 헤더 `I89:13848;48:10910`, 설정 헤더 `I167:25417;98:20975`와 아이콘 `I89:13848;48:10916`, `I167:25417;98:20983`, `I167:25417;98:20978`를 design context·스크린샷으로 대조했다. 해당 아이콘은24px이며 별도 네모 배경·테두리 상태의 지정 근거를 찾지 못했다.
- **원인·변경:** DLDS ghost/black Button의 hover gray100·pressed gray300와 기본 radius6이 남아 있었다. `NotificationUI/NotificationIconButton.tsx`에서 기존 Button을 국소 확장하고 투명 배경·border/radius0·24px 중앙정렬을 적용했다. 인박스 뒤로가기/설정, 설정 뒤로가기/X, 소속 선택 X의5곳에서 재사용한다. 기존 SVG·색상·onClick·aria-label·설정 복귀 식별자·소속 전환 중 disabled를 보존했다. 공용 Button의 키보드 focus-visible 표시도 유지한다.
- **범위 점검:** 새 NotificationUI와 Clinic/Lab 알림 진입부를 확인했다. 기존 헤더 종의 IconBadge hover는 별도 공통패턴이므로 이번 ghost Button 보완과 구분하며 변경하지 않았다. 텍스트 버튼·필터·목록 행·토글·전역 DLDS/DLOS·앱·API는 변경하지 않았다. Storybook/제품 테스트용 화면도 추가하지 않았다.
- **검증:** 실제 최종 컴포넌트를 임시 headless Chromium에서 렌더하여 Clinic/Lab × PC1280/모바일390의18개 아이콘 상태를 확인했다. 기본/hover/pressed 배경 투명·border0·shadow없음·24px SVG, 포인터 조작 outline없음, Tab focus-visible2px, Enter/Space, 설정 진입/뒤로가기/닫기/모바일 목록 닫기 및 소속 선택 중 닫기 비활성화가 통과했고 pageErrors0이다. 눌린 상태의 톱니/X/뒤로가기 캡처도 Figma 원본과 시각 대조했다. 변경 scoped ESLint·diff-check와 commit 훅의 Clinic/Lab/Admin 타입검사가 통과했다. 근거 `/tmp/notification-icon-results-1105.json`, `/tmp/notification-icon-check-1105.cjs`, `/tmp/notification-icon-*-pressed.png`. 이 검증은 실제 컴포넌트 상태 검증이며 사용자 표시 창·서버 API 전체 QA로 확대하지 않는다.
- **검증 과정:** 최초 ESLint 호출은 저장소의 기존 중첩 Storybook/react-hooks 버전 충돌로 실행되지 않아 설정 변경 없이 `--no-eslintrc --config shared/ui/.eslintrc.cjs --resolve-plugins-relative-to shared/ui`로 통과했다. 임시 브라우저 스크립트의 포커스 transition 대기·React 재렌더 대기·모바일 모달 진입 순서를 보완한 뒤 최종18건을 통과했으며 이는 제품 오류 수정과 구분한다.
- **Git/다음 시작점:** Web `feature/DL-17058`·`39689690c81c4f70e8183366be8fe0d78b8d2bee`(4파일)로 commit/push했고 `ls-remote` 원격 SHA 일치·clean·ahead/behind0/0을 확인했다. 필수 push 훅의 Clinic/Lab/Admin lint는 오류0(기존 warning 유지), Admin guard9·configs21·hooks32·coverage baseline 검사가 통과했다. 근거 `/tmp/notification-icon-push-1105.log`. 기존 PR은 없으며 새 PR·배포·앱 재실행·사용자 웹 서버/창 배치 변경은 없다. 사용자 로컬 확인 또는 후속 정책/BE 계약 변경을 기다린다.

## 2026-11-05 후속 승인 — 제품 commit/push·앱 다시 실행

- **원격 보존:** Web `6a0bd7caf1dc05502730e1d85b69442cc461586f`(시간 표시5파일), Office `cbd7a41`(헤더)→`be825ad6c0ad9cf08c7ee64bb5f52d721ef0ea64`(시간/배너), Lab `4765855`(헤더)→`b0372cd`(시간/번역)→`193ee8b5668f345357bea5dd9d9a6fd9ffb90b5d`(배너). 각 기존 feature/DL-17058·17059·17060에서 승인 파일만 commit/push했고 원격 ls-remote 일치·clean·upstream0/0를 확인했다. 새 branch/worktree·PR·merge·배포는 없다.
- **검증 재사용/필수 검사:** 앞선 최종 코드와 동일함을 소스 hash로 확인해 Web33경계/6렌더·Office양OS/Jest10·Lab양OS/경계20/Jest3 근거를 재사용했다. Web commit/push hook의 Clinic/Lab/Admin 타입·lint 오류0(기존 경고만), Admin guard9·shared configs21/hooks32·coverage 검사를 통과했다. 앱의 기존 타입 진단 Office6/Lab5는 이번 추가 오류가 아니며 신규 변경은 없다.
- **앱 미리보기:** 시작 시 두 기기/Metro가 종료된 상태여서 기존 설치·로그인을 유지해 재실행했다. Office8081 PID93362/session66913(cwd dentlink-app), Lab8082 PID93363/session90547(cwd dentlink-lab-app), Android AVD Dentlink_API_36:5554/session2873, iPhone17Pro/iOS26.5 UDID5C0E7639-2345-4B3F-9979-56AFDDA1C708. 실행 ID는 재개 시 재확인한다. 두 기기 모두 Office8081의 정확한 앱 식별자로 연결됐으며 홈 공지를 Close로 닫고 벨→알림함을 실제 터치해 열었다. 기존 권한·계정·소속·설정은 변경하지 않았다. 실제 표시 창까지 캡처해 정상 알림함을 확인했으며 새 API 연결이나 전체 QA 재실행 근거로 확대하지 않는다.
- **iOS 표시 도구:** 이 Mac은 기존 Simulator.app 경로 대신 `/Applications/Xcode.app/Contents/Applications/DeviceHub.app`을 사용한다. `open -a <해당 경로> --args -CurrentDeviceUDID <기존 UDID>`로 기존 기기 창을 표시했다. Accessibility process 이름은 DeviceHub, CoreGraphics 창 owner는 Device Hub다. 기존 창 위치/크기를 임의 조정하지 않았다.
- **근거/마감:** `/tmp/office-final-pushed-{ios,android}-1105.png`, 실제 창 `/tmp/office-preview-visible-{ios,android}-1105.png`; 기존 서버를 덮어쓰거나 웹/IDE를 조작하지 않았다. 사용자 요청대로 웹 서버는 시작하지 않았고 앱 미리보기는 켜둔다. 개인 체크포인트를 새 제품 SHA로 갱신·commit/push 후 다음 명세/요청을 기다린다.

## 2026-11-05 TOBE 주석 재감사·FE 누락 보완

- **사용자 요청:** 공통 헤더 주석 누락을 계기로 현재 자료를 다시 검토하고 확정된 FE 잔여가 있으면 보완한다. 이전 헤더 수정과 같은 로컬 코드 범위이며 제품 commit/push·PR·배포는 하지 않는다. 새 API나 미정 UX는 만들지 않는다.
- **확인 범위:** Figma2:6의 공통 헤더12:1495·Clinic 인박스25:6370·설정29:11438·Lab97:14844·개념158:22451 안의 표시된 주석/한국어 텍스트125개를 추출하고 세 제품 호출부와 대조했다. 숨긴 프레임·Assets·스펙아웃은 현 요구로 되살리지 않는다. 시간89:13617/89:18603·OS 안내211:22646/211:22660·배너405:23592는 실제 디자인 컨텍스트와 렌더를 확인했다. 모든 과거 댓글의 전수 재확인으로 표현하지 않는다.
- **Slack 재확인:** [Oli14:49 답글](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793857787199209)은 이번에도 부모 스레드와 함께 읽었다. Unread 숫자·자동 팝업1회/설정 배너상시·Shipping·Credits Email은 이미 반영됐으며 사용자의 링크 재질문에도 이 점을 안내했다. 추가 게시·반응·읽음 조작·폴링은 없다.
- **신규 정책 인지:** Notion PRD 최종수정 **11/5 15:16:25 KST** 응답의5-6을 읽었다. USER/Employee 수신 단위 분리, 한 이벤트의 양쪽 중복 발송 금지, 같은 도메인/카테고리 체계, 동일 인박스 최신순 노출 방향을 확인했다. USER는 template domain 이름과 다른 개념이다. #20 설정 위치/SMS 동의, #21 모든 소속 노출·계정 읽음·전환기 집계 제외 제안/BE 저장, #22 이벤트 목록은 Open이다. Lab Home 최근 메시지도 #19의 대상·위치·읽음·웹/앱 범위가 미정이다. 본문 truncated/unknown block1개·댓글 preview 제한이 있어 전체 본문/모든 댓글을 완전 조회했다고 하지 않는다.

| 대조한 요구 | 이번 판단 |
| --- | --- |
| 1뎁스 공통 헤더·기존 Profile 알림 영역 | 앞선 로컬 헤더 수정 및 DEV에서 구영역 숨김과 일치. 운영 전환/legacy 제거는 실연동 뒤 |
| 초기 All/Unread·클릭/전체읽음·빈 상태·선택적 카테고리 | 현재 UI 동작과 일치. 별도 수정 없음. 실제 읽음 저장은 여전히 mock |
| 권한/제품별 채널·Shipping·Credits Email | 최신 정책/BE/Slack 기준 구현 유지. 옛 중복 시안으로 항목 추가하지 않음 |
| 알림 시간 | 고정 예시 문자열만 있던 누락 확인. `<1시간 분 / <24시간 시 / 이후 국가별 날짜` 계산을 세 제품에 보완 |
| OS 안내 배너 전체 탭 | CTA만 눌리던 누락 확인. 양 앱 전체 배너가 기존 안내 팝업을 여는 단일 버튼이 되도록 보완 |
| 모든 소속 미읽음 점·전환 배너·숫자 | 소속 조회/전환과 별개로 실제 집계 계약 대기. 미제공 값을0 또는 가짜 집계로 만들지 않음 |
| USER 설정·Lab Home 최근 메시지 | 정책의 새 개념과 Open항목을 분리해 기록. 위치/범위/계약 없이 화면 신설하지 않음 |

- **구현 경계:** 기존 날짜 유틸과 국가별 포맷을 재사용하고 신규 인박스용 formatter만 추가한다. mock 내부 시각에서 표시 문자열을 만들며 서버 timestamp 필드명을 확정하지 않는다. 타이머/폴링은 추가하지 않는다. 잘못된 시각은 빈 표시, 미래는 음수 대신0분으로 처리한다. 배너는 기존 문구·아이콘·레이아웃과 callback을 유지하고 중첩 버튼을 제거한다. 자동 팝업1회/OS OFF 배너상시/정상복귀 선택항목ON 정책은 바꾸지 않는다.
- **Web 검증 완료:** 새 helper와 mock/controller, Clinic/Lab 기존 `activeEmployeeDateFormatAtom` 전달의5파일을 로컬 수정했다. 경계/언어/국가33건 및 최종 실제 컴포넌트의 PC1280·모바일390 × Clinic US/GB·Lab KR 6개가 통과했고 pageErrors0이다. 변경 lint·Clinic/Lab 전체 타입검사·diff 통과. 서버 없이 임시 headless Chromium에서 검사한 근거이며 사용자 표시 창/실로그인 전체 흐름 검증으로 확대하지 않는다. 임시 브라우저 종료, 기존 웹 창/서버 유지. 근거 `/tmp/dentlink-web-notification-time-check-results-1105.json`, `/tmp/dentlink-web-time-render-results-1105.json`.
- **Office 검증 완료:** 기존 헤더5파일을 보존하고 이번 helper·경계 테스트·mock·화면·배너5파일을 추가 수정했다. Jest10/10·변경 lint/diff 통과, 전체 타입은 직전 검사와 동일한 기존6진단이다. iOS/Android Office8081에서 분/시간/날짜 목록, 배너의 CTA가 아닌 본문 실제 탭→기존 안내 팝업→Cancel을 확인했다. 실제 OS granted는 유지하고 조회 응답만 blocked로 일시 대체했으며 auth/mock/권한 원복·서버 쓰기0·가드 제거를 확인했다. 전체 diff+신규2파일 SHA256 `b2908b88c1dd2f1d0222370208e835c259e3e2263645d4b45fbb7c6237fa5cc4`. 근거 `/tmp/office-notification-time-banner-runtime-1105.md`.
- **Lab 검증 완료:** 기존 헤더5파일에 이번 helper·mock·화면·배너·번역3파일을 더한 총12파일이다. 시간 경계/ko·en/국가20건·기존 번역 Jest3건·lint/diff 통과, 전체 타입 기존5진단 외 신규0이다. iOS/Android Lab8082에서 분/시간/국가 날짜, 배너 본문 실제 탭→안내 팝업→취소·복귀를 확인했고 영향 경로 크래시/오류창은 관찰되지 않았다. 실제 iOS denied·Android granted는 바꾸지 않고 조회만 blocked로 대체했으며 양쪽 원복·서버 쓰기0을 확인했다. 접근성 그룹 때문에 초기 자동 선택자가 실패한 것은 선택자만 수정했고 제품 코드는 변경하지 않았다. 최종12파일 SHA256 `ecf39905574be7282eb8b4019a3769d8330861063b81d23cc20c0c52f6e31507`. 근거 `/tmp/lab-notification-time-banner-runtime-1105.md`.
- **코드·화면 검토:** 주 세션도 세 제품 변경 diff와 날짜 helper/테스트를 읽고 Web PC/모바일, Office iOS 목록/팝업, Lab Android 목록/iOS 팝업 캡처를 직접 대조했다. 실제 알림 API 저장·모든 소속 집계·전체 역할/푸시 QA·merge 준비 완료로 확대하지 않는다. 이후 코드 변경은 없다.
- **마감/다음 시작점:** Web `3f44fc507`+5파일, Office `ddf9e766`+10파일, Lab `1b328196`+12파일의 로컬 변경이다. 각 기존 feature/DL-17058·17059·17060을 유지하며 제품 commit/push·PR·외부 문서 변경은 없다. 최종 양 기기는 Office8081/Home이며 inspector의 제품 식별자·PID29705의 Office checkout을 확인했다. Lab8082·별도 작업8093·웹·기존 창 배치는 보존한다. 이번에 확인한 확정 UX 누락은 보완했으며 다음은 실제 BE 계약/미읽음 집계, USER #20–22와 Lab Home #19의 확정 근거를 받아 대조하는 단계다. 자동 추가 조사·폴링은 하지 않는다. 개인 정본만 commit/push한다.

## 2026-11-05 사용자 승인 후속 — 주요 화면 공통 알림 진입

- **요구 근거 정정:** 사용자 승인 후 직접 확인한 [공통 헤더 화면12:1495](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=12-1495)와 [TOBE 주석36:11358](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=36-11358)에 Home·Orders·LinkTalk·Profile 1뎁스 헤더 적용이 명시돼 있다. 주석을 확인하지 않고 '별도 디자인 요구 없음'이라 설명·기록한 것을 정정한다. 현재 구현 범위는 확인한 디자인 요구와 일치한다. 사용자가 이후 필요시 제거 가능하다고 말한 것은 향후 변경 권한이며 현재 요구가 임의 UX라는 뜻은 아니다.
- **구현 범위:** Office·Lab의 Home, Orders(동일 헤더를 쓰는 하위 탭 포함), LinkTalk, Profile에 같은 `NotificationBellButton`을 사용한다. 기존 Home의 navigation·미읽음 점 연결을 해당 컴포넌트로 옮기고 세 주요 화면의 지원 버튼 앞에 추가한다. 공용 Layout/Header의 기본 동작을 바꾸거나 전역 오버레이를 추가하지 않는다. 알림함 자체·인증·상세·작성·카메라 및 별도 Lab 밀링 헤더는 그대로 둔다.
- **현재 데이터 경계:** `__DEV__` 진입 제한과 기존 mock 미읽음 표시를 유지한다. Lab은 기존 소속 context 검증·같은 context에서 초기화하지 않는 reset을 재사용한다. 새 API, 실제 푸시/읽음 연결, 운영 노출, 메뉴 정책 확정 또는 배포를 뜻하지 않는다.
- **같은 주석의 다른 요구 대조:** 기존 프로필 Notification 영역 제거는 양 앱 `ProfileOfficeSection`/`ProfileLabSection`의 `!__DEV__`로 새 DEV 화면에서 숨겨져 있다. 운영용 기존 컴포넌트/API까지 삭제된 것은 아니며 새 알림 설정 실연동·운영 전환 시 구영역을 정리한다. 빨간 점은 '현재 또는 다른 소속 중 미읽음 존재'가 요구이며 이 모든 소속 기준은 기존 계획에도 기록돼 있다. Office는 `hasOtherOfficeUnread || items.some(!isRead)`의 mock UI 분기, Lab은 현재 context의 mock 미읽음만 구현돼 있다. 양 앱 실제 모든 소속 집계는 계약·실데이터 연결 전이며 완료로 표현하지 않는다.
- **12:1495의 Promotional SMS:** Profile 시안 Preferences에 해당 토글이 있으나 현재 `ProfileSettingsSection`에는 없다. 11/4 PM이 예고한 USER Promotion(SMS/MAIL) 후속 정책·와이어프레임/계약 대기 대상으로 유지하며, 옛 시안만으로 현 Employee 알림 설정에 임의 이관하지 않는다. 이번은 요구·상태 확인만 수행했고 추가 코드·기기·외부 문서 변경은 없다.
- **작업 위치:** Office `/Users/parkjongsun/Repository/dentlink-app`·`feature/DL-17059`·기준 `ddf9e766`, Lab `/Users/parkjongsun/Repository/dentlink-lab-app`·`feature/DL-17060`·기준 `1b328196`. 각 5파일의 로컬 변경이며 제품 commit/push는 하지 않는다. Web `feature/DL-17058`·`3f44fc507`은 변경하지 않는다.
- **정적 검증:** 양 앱 변경파일 ESLint·diff-check 통과. Office typecheck는 기존6진단 로그와 동일, Lab은 기존5진단이며 변경파일 신규 진단이 없다. 새 네이티브/패키지/환경 변경은 없다.
- **최종 런타임 검증:** Office→Lab 순서로 각 제품의 양 기기를 동일 작업본·DEV 환경에 맞춰 함께 전환했다. Office·Lab 각각 iOS/Android에서 Home·Orders·LinkTalk·Profile의 벨→알림함→원래 탭 복귀가 모두 통과했다. 기존 지원 버튼과 헤더 제목 겹침 없음, 알림함 내 벨 중복 없음, 기존 미읽음 점 표시를 확인했다. 역할/설정/소속/알림 읽음 상태를 바꾸거나 API·mock 응답을 주입하지 않았다. 기존 인접 화면 전체 QA나 서버 저장 검증으로 확대하지 않는다.
- **개발 중 관찰/복원:** Office 훅 이동 직후 Fast Refresh 상태에서 양 기기에 `getSnapshot` null 오류가 보였으나, 로그인 데이터를 유지한 cold 재실행 뒤에는 재현되지 않았고 최종 왕복 검증에서도 오류가 없었다. 개발 중 Fast Refresh 상태와 최종 코드의 재실행 결과를 구분한다. 검증 종료 후 사용자 미리보기인 Office 양 기기·Metro8081·Home으로 복원하며 기존 창 배치·웹·서버는 유지한다.
- **근거:** `/tmp/office-common-header-bell-runtime-1105.md`, `/tmp/lab-common-header-bell-runtime-1105.md`, 각 `/tmp/{office,lab}-header-{ios,android}-*-1105.png`. Office Profile iOS와 Lab Profile Android 캡처는 주 세션도 직접 시각 대조했다. 제품 최종 diff는 각 5파일이며 검사 후 코드 추가 변경은 없다.
- **다음 시작점:** 이번 로컬 변경을 보존한 상태에서 사용자 화면 확인 또는 새 정책·BE 계약을 기다린다. 추후 제품 커밋/푸시·PR·배포는 별도 지시 범위에서 수행한다. 외부 기획 문서·Jira·Slack은 이번 사용자 UX 변경 때문에 수정하지 않는다.

## 2026-11-05 Slack 마지막 댓글·Figma 최신 멘션 반영

- **공통 기기 운용 후속 확정:** 사용자 요청으로 이후 단독·병행 작업 모두 제품별 iOS/Android를 같은 작업본과 환경에 맞춰 함께 전환한다. Office/Lab 작업 자체는 분리 가능하나 iOS와 Android에 서로 다른 작업을 배정하는 것은 명시 지시가 있을 때만 예외다. 이전 Office iOS/Lab Android 병행 검증 방식은 이후 기본 운용으로 재사용하지 않는다. 공통 정본은 SESSION_WORKFLOW의 Paired iOS And Android Environments다. 이번은 지침 정리이며 현재 맞춰둔 Office 양 기기·서버·제품 코드는 변경하지 않는다.
- **후속 로컬 확인 — 15:23 KST:** 사용자 관찰대로 iOS Office Home에는 벨이 있고 Android Office Home에는 없었다. iOS는 이 세션의 `/Users/parkjongsun/Repository/dentlink-app`·`feature/DL-17059`·`ddf9e766`·Metro8081에 연결돼 있다. Android의 같은 Office Development 앱은 별도 `/Users/parkjongsun/.codex/worktrees/office-delayed-label/dentlink-app`·`feat/DL-17248`·`7f325896`·Metro8093에 연결돼 있었으며, adb reverse도 기기8081→호스트8093이었다. 해당 코드에는 NotificationCenter/Bell이 없고 알림센터 브랜치 Home에는 명시적으로 있다. 앱 종류 차이나 알림센터 코드 누락이 아닌 실행 연결 차이다. 이 확인은 읽기 전용으로 했고 사용자는 이후 **개발 작업을 마감한 뒤 별도 로컬 미리보기로 양 기기를 동일한 알림센터 Office 작업본에 맞춰 열기**를 명시적으로 요청했다. 웹은 사용자가 checkout/branch로 직접 실행하며 Codex가 재설정하지 않는다.
- **별도 미리보기 연결 완료 — 15:26 KST:** Android의 기기8081을 알림센터 Office Metro8081로 다시 연결하고 기존 Development 앱 프로세스만 재실행했다. iOS/Android 두 inspector 연결이 동일8081에 있음을 확인했고, 각각 Home의 벨을 실제 탭해 Notification/Unread3/목록3건 화면을 열어두었다. 실제 캡처 `/tmp/office-{ios,android}-preview-inbox-1105.png`. 앱 재설치·제품 코드·branch·로그인·권한·소속·알림 읽음 변경 없이 창 배치와 기존 서버를 유지했다. 별도 작업의8093 서버는 종료하지 않았다. **사용자 직접 미리보기에서는 요청한 동일 제품/작업본을 양 기기에 맞추고 실제 연결과 화면을 함께 확인한다.** 병행 검증 중 기기별 연결이 달라질 수 있다는 사실은 미리보기 인계에서 혼재를 방치하는 이유가 되지 않는다. 현재 알림 데이터는 API 연결 전 DEV mock임을 유지하며 추가 개발/QA 완료로 확대하지 않는다.
- **대기 브레이크포인트 재확인:** 확정된 웹·앱 UI/공통 흐름의 FE 선행 작업은 수정·검증·세 제품 push까지 완료했다. 현재 FE가 단독으로 추가 진행할 확정 작업은 없으며, 공개될 BE 목록·읽음·수신 설정·미읽음 계약 및 USER 후속 정책/디자인을 받아 대조·연결하고 대체한 mock을 제거하는 것이 다음 시작점이다. 전체 기능·최종 QA·배포 완료를 뜻하지 않는다. 사용자는 이 상태를 저장한 뒤 현재 켜진 iOS/Android의 제품·로컬 연결과 알림 표시 차이를 확인하도록 요청했으며, 이는 새 기능 구현 재개와 구분한다.
- **확인한 최신 요청:** [Oli 14:49:47 답글](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793857787199209), 부모1793774409.809179·답글11개를 확인했다. Unread 탭만 숫자(기반 구현 완료), 앱 OS OFF 자동 안내 팝업1회/설정 배너상시, Order 하위 Shipping, Credits Email이다. Credit Email은 기존11/4 구현을 보존한다.
- **Figma 근거:** 오늘 사용자 멘션 메일14:50:20/14:50:24/14:51과 실제 댓글 #40/#50/#51을 직접 화면에서 열어 문맥·위치를 확인했다. #40 PM 최신 문구는 `Get Lab updates instantly`, `Go to Settings`; Lab 한글은 ‘알림으로 주문 현황과 치과 메시지를 바로 확인하세요.’다. #50은 OS OFF 배너, #51은 권한별 알림 설정 목록 위치다. 댓글/반응/해결·디자인 편집은 하지 않았다. Figma 화면 열람 자체의 읽음 표시는 서비스에서 변할 수 있으므로 미변경을 보장하지 않는다.
- **디자인 원본:** 배너405:23592, 자동팝업248:24758, 설정팝업405:27110, 권한섹션405:25991 및 Web167:25417/405:27128/167:25673, App405:25725/410:28040/410:28402를 대조했다. 배너 닫기 없음·가로 벨30/본문14/화살표14, 팝업335/제목20/본문16·간격2/20을 기존 컴포넌트로 맞춘다.
- **Shipping 판단:** 앱 시안의 Order 하위+별도 Shipping 중복은 그대로 복제하지 않는다. 사용자가 정책 우선, 불명확하면 BE/웹 기준으로 처리하도록 지시했다. Notion OFFICE 표는 Orders 하위 Shipping 한 건(Notification/Push), BE44798 초안도 ORDERS/SHIPPING 한 row이며 웹 시안도 Order 내부 한 번이다. 기존 식별자·값·채널을 보존하고 Web Clinic/Office에서 Order Updates 다음·Feedback 이전으로 이동한다. Lab에는 해당 항목을 신설하지 않는다. 이 판단 기준은 모든 프로젝트 공통 AGENTS/DEVELOPMENT_STYLE에96b6fd2로 기록·push·로컬 동기화했다.
- **정책서 확인 범위:** Notion PRD 반환 최종수정11/4 15:45:28 KST. 필요한 OFFICE 기본값/역할표·Shipping은 확인했다. 반환은 truncated=true이며 unknown block1개(drive embed)이므로 전체 원문/댓글 완전 조회로 표현하지 않는다. 오래된 ‘OS OFF 조작 불가’ 문구보다 이후 사용자·PM 합의의 선택→OS 설정→정상복귀 흐름을 유지한다. 서버 초기값·마이그레이션은 제공될 계약과 대조하며 preview mock의 ON/OFF를 서버 기본값으로 취급하지 않는다.
- **범위:** USER Promotion/Benefits 정책·와이어프레임 예고와 아직 공개되지 않은 새 알림 API는 별도 대기다. 소속 전환·미읽음·읽음·네이티브 설정·이메일 CTA를 이번 스타일/표시 보완으로 확장하지 않는다.
- **Web 완료:** `feature/DL-17058`의 `3f44fc50724c5ea971c0654fdfbecd62e427ba51`, 원격 동일·clean·ahead/behind0/0. 변경은 Clinic mock 설정의 Shipping 배치1파일이다. PC1280/모바일390 실제 NotificationCenterMock→설정 컴포넌트에서 Shipping 한 번·Order 순서·인접 토글 독립·Credit Email 보존을 확인했고 pageErrors0이다. 통합 로그인 화면 재검증으로 표현하지 않는다. 필수 commit/push hook의 Web3제품 타입·lint(기존 warning만)·Admin guard·configs21/hooks32·coverage 기준 검사 통과. 증거 `/tmp/dentlink-web-shipping-results-1105.json`, `/tmp/dentlink-web-shipping-{1280,390}-1105.png`.
- **Office 완료:** `feature/DL-17059`의 `ddf9e766c3a1220ede5515cc972ed0661621a3e3`, 원격 동일·clean·0/0. 최종7파일로 배너 상시/닫기 제거·기존 Popup 선택적 bodyStyle(기본값400 보존)/공통 안내335·Shipping 단일 배치를 반영했다. iOS 대표 계정에서 자동팝업 실제 표시/NOTICE 이력 저장·취소, 수동 안내→실제 Settings 앱 이동·복귀, 설정 재진입 배너 유지/자동팝업 미반복, ON 응답 시 숨김, Shipping OFF/ON과 Order Updates/Feedback 보존을 확인했다. **iOS 실제 권한은 granted이며 OS OFF/ON 조회 응답을 런타임 대체한 조건 검증**이다. 시뮬레이터가 앱별 알림 설정 대신 Settings 대문을 열어 실제 OS 토글 검증과 구분한다. 조회 함수·저장키3개·mock 복원 및 legacy 쓰기 차단 가드 제거 완료. lint/diff 통과, 전체 tsc 기존6진단·변경파일 신규0. 증거 `/tmp/office-notification-policy-runtime-1105.md`, `/tmp/office-ios-policy-{auto-popup,banner,manual-popup,shipping-on}-1105.png`.
- **Lab 완료:** `feature/DL-17060`의 `1b328196fc15ba39064836a8ba222bfab862d6e2`, 원격 동일·clean·0/0. 최종9파일로 같은 배너/팝업을 적용하고 한글/영문 registry를 정리했다. Android 대표 한국어 계정에서 **실제 OS ON→OFF**, 배너 재진입·닫기 없음, 새 문구·취소, 자동팝업 실제 onLayout 후 이력 저장·재시작 미재노출, 앱 알림 설정 이동→ON 복귀 시 배너 숨김을 확인했다. OS ON·NOTICE 이력true 복원, 임시 legacy 쓰기 interceptor 제거, 로그인/소속 유지. fatal/RedBox 관찰 없음. 기존 Jest24/24·lint/diff 통과, 전체 tsc 기존5진단·변경파일 신규0. 증거 `/tmp/lab-notification-policy-runtime-1105.md` 및 그 안의 캡처/실행 파일.
- **검증 범위·마감:** 코드 영향에 맞춰 Web PC/모바일 실제 컴포넌트, Office iOS, Lab Android를 검증했다. 권한 로직을 바꾸지 않아 무관한 역할·전체 기능/OS 조합을 재실행하지 않았다. 실제 새 API 저장·전체 발송/권한 QA·release 준비 완료로 확대하지 않는다. 기존 앱 Metro8081/8082와 기기창·로그인·사용자 창 배치를 유지했고 다른 checkout의3000 서버는 건드리지 않았다. 제품/개인 정본 push 후 추가 확인·폴링 없이 대기한다.

## 2026-11-05 창 배치 공통 지침과 조사 제외 후속 확정

- 사용자가 `/api/qa-users`는 별도 언급 전까지 신경 쓰지 않도록 명시했다. 해당 로그는 조사·수정·반복 보고 및 미완료 과제에서 제외한다. 아래 과거 화면 관찰 기록이 추가 조사 재개 근거가 되지 않는다.
- 이미 열린 적절한 화면을 재사용하고 창 위치·크기·모니터/데스크톱·창/탭 구성을 가능한 그대로 유지한다. 이는 사용자 로컬 확인뿐 아니라 모든 에이전트 화면 조작의 공통 원칙으로 [Existing Windows And Layout](../SESSION_WORKFLOW.md#existing-windows-and-layout)에 반영했다. 필요한 화면 내부 조작·탭 선택을 금지한다는 뜻은 아니다.
- 공통 지침·개인 메모리만 정리·commit/push한다. 현재 서버·브라우저·시뮬레이터·에뮬레이터는 유지하며 새 조사/제품 작업/폴링 없이 다음 요청을 기다린다.

## 2026-11-05 공통 로컬 실행 방식 확정과 현재 화면 확인

- **사용자 의도:** Codex 단독 개발과 사용자 직접 로컬 확인을 구분한다. 단독 작업은 Codex 내부 터미널/웹 실행을 허용하고, 직접 확인은 정확한 IDE/worktree의 하단 통합 터미널에서 서비스를 실행해 외부 브라우저·시뮬레이터·에뮬레이터를 확인한다. IDE 내장 브라우저는 필요 없다. 앱 영향 화면·권한·크래시 검증은 두 방식 모두 동일하다. 정본은 [Local Development And User Preview](../SESSION_WORKFLOW.md#local-development-and-user-preview)이며 과거 IDE 터미널 일괄 금지를 대체했다.
- **웹 실제 상태:** Cursor에 `dentlink-client-notification-center`/`feature/DL-17058`이 열려 있고 하단에 두 node 터미널이 있다. Clinic3000 PID32098/cwd `.../clinic`, Lab3005 PID32294/cwd `.../lab`의 부모를 Cursor terminal pty-host까지 추적해 IDE 내부 실행임을 확인했다. 외부 일반 Chrome의 두 서비스 탭에서 로그인된 양 서비스 홈을 각각 직접 캡처했다. Lab 탭 확인 후 원래 Clinic 활성 탭으로 복원했고 창 위치·크기·그룹은 바꾸지 않았다.
- **앱 실제 상태:** iOS DeviceHub의 Office 알림함과 Android 에뮬레이터의 Lab 알림함이 실행 중이다. iOS는 기기창 캡처, Android는 창 존재 확인과 adb 기기 화면 캡처로 현재 표시를 확인했다. 현재 두 앱 Metro는 앞선 명시적 앱 자체 실행 허용에 따라 Codex 관리8081/8082에서 유지한다. 지침 정리를 이유로 실행 위치를 옮기거나 재시작하지 않았다.
- **확인 범위:** 실행 구성과 현재 화면 확인이며 전체 앱 크래시·권한 QA를 새로 완료했다는 뜻은 아니다. 웹 터미널에 `/api/qa-users`500, `ChannelService.shutdown()` 코드 프레임 및 styled-components 경고가 남아 있는 것을 관찰했다. 현재 양 홈은 표시되지만 로그 발생 시점·원인·알림센터 관련성은 이번 범위에서 판정하지 않았으며 제품 수정도 하지 않았다.
- **마감/다음:** 공통 지침과 관련 앱 가이드의 충돌 문구, 이 체크포인트를 정리·commit/push하고 로컬 확인 환경을 유지한다. 신규 구현·PR·외부 문서 수정·전체 검증 재실행은 없다. 사용자 종료/다음 작업 지시를 기다린다.

## 2026-11-05 사용자 로컬 확인용 실행 재개

- 사용자가 앱 실행을 요청하고 웹 Cursor IDE/서버는 직접 열기로 했다. 개발 대기·PR 미생성은 유지하며 제품 코드/브랜치/설치를 바꾸지 않는다. 웹 워크트리는 `/Users/parkjongsun/Repository/dentlink-client-notification-center`, `feature/DL-17058` (`eb609ddd7`)이다. 이 루트의 별도 IDE 터미널에서 `pnpm dev:clinic`(3000), `pnpm dev:lab`(3005)을 사용한다. Codex가 웹 서버를 시작하지 않았다.
- **Office iOS:** `/Users/parkjongsun/Repository/dentlink-app`, `feature/DL-17059` (`09a777a`), clean·ff-only 최신 확인. 기존 iPhone17Pro/iOS26.5 `5C0E7639-2345-4B3F-9979-56AFDDA1C708`와 설치된 Development 앱을 재사용했다. Metro8081 PID29705/session22271의 실제 cwd를 확인했고 DeviceHub 창에서 최신 영문 알림함/Unread3 배지를 직접 캡처했다. 기존 홈 공지 팝업은 Close로 닫았고 로그인·권한·배너 이력은 유지했다.
- **Lab Android:** `/Users/parkjongsun/Repository/dentlink-lab-app`, `feature/DL-17060` (`c6debf2`), 기존 Dentlink_API_36/emulator-5554. Metro8082 PID29653/session3011, AVD PID29649/session3630. Quick Boot의 과거 실행화면이 복원돼 기존 앱 프로세스만 cold 재실행해 최신 bundle/소속 hook을 확인했다. 앱 재설치/데이터 삭제/권한 변경은 없다. 최종 Home→벨→알림함을 직접 열어 한글 안읽음 빨간 배지2와 단일소속의 다른 기공소 버튼 미노출을 확인했다(`/tmp/lab-android-final-visible-1105.png`).
- 사용자 화면 확인용이며 추가 전체 QA나 실제 알림 API 검증이 아니다. 알림 내용/읽음/설정/미읽음은 여전히 DEV mock이고 Lab 실제 소속 목록/전환은 기존 API 연결이다. 실행 상태를 유지하며 사용자의 종료/다음 지시를 기다린다. PID/세션은 다음 재개 때 다시 확인한다.

## 2026-11-05 대기 전 확인 — MEMBER 권한과 다중소속 검증 구분

- 사용자는 MEMBER 권한과 다중소속 계정 모두 별도로 확인해야 한다고 재확인했다. 두 항목은 서로 다른 검증 축이며 현재 구현 전체가 미완료라는 뜻은 아니다. 필요한 기록 정리 후 추가 기획·디자인·BE 명세 또는 재개 요청까지 대기한다. **최종 사용자 확인:** 남은 항목의 의미·조건을 이해하고 기록한 상태이며, 현재 FE가 단독으로 추가 처리할 확정 작업은 없어 대기한다는 설명에 동의했다. 명세·정책 또는 실제 검증 계정이 준비되면 해당 항목부터 재개하고, 이를 전체 실제 검증 완료로 표현하지 않는다.
- **MEMBER 권한:** 소속 안에서 역할에 따라 보이는 설정·수신 범위·접근 가능한 화면이 맞는지 확인한다. 현재 Office 소스의 MEMBER 범위 선택 숨김/assigned 고정, OWNER·PAYMENT_MANAGER만 Payments 표시·변경 조건을 재확인했다. 11/3 실제 Office iOS MEMBER→OWNER→MEMBER의 메뉴 변화를 검증했고11/4 MEMBER Credit/Email 경로도 확인했다. 이를 미검증으로 되돌리지 않는다. 새 BE 연결 뒤 실제 수신 대상·목록/저장 권한·서버 권한 변경, 다른 제품/OS/역할의 미검증 조합은 별도로 남는다. 이번 대기 정리에서 런타임은 재실행하지 않았다.
- **다중소속:** 한 로그인 계정이 여러 병원/기공소에 속한 경우 올바른 employer/employee로 전환되고 대상 알림함이 열리는지 확인한다. Office iOS의 실제 MEMBER↔OWNER 소속 전환은 기존 검증 근거가 있고, Lab은 실계정이 단일소속뿐이므로 실제 다중소속 activation 성공은 미검증이다. Lab 양 OS 합성 전환/경합 검증과 실제 서버 전환 증거를 구분한다. 실제 다중소속 계정을 확보하면 역할이 다른 소속 간 전환도 함께 검증한다.
- **USER 정책 후속은 별개:** 예정된 USER 단위 Promotion/Benefits 정책은 계정 단위 설정 범위이며 MEMBER라는 직원 역할을 뜻하지 않는다. 기존 Employee 권한 분기를 임의로 이관하지 않는다.
- 제품 코드·기기·외부 문서 변경 없이 위 검증 구분과 완료된 Lab 연결에 남아 있던 과거형 ‘mock/조사만’ 요약을 현재 상태로 정리했다. 개인 정본 commit/push 후 대기하며, 새 미정 정책·미읽음 값을 가정하거나 테스트용 서버 권한/소속을 임의로 만들지 않는다.

## 2026-11-05 후속 점검 — Figma 최신 알림·멘션

- **확인 범위/시각:** 11/5 13:28 KST 기준. 연결 계정의 Frankie(박종선) 신원을 확인한 뒤 10/29 이후 이 알림센터 파일의 Figma 알림 메일7건(추가 페이지 없음)을 읽고, 로그인한 Chrome의 실제 댓글·답글·핀 위치를 접근성 트리와 해당 창 캡처로 대조했다. 새 알림/관련 댓글 중심의 점검이며 파일 전체의 모든 과거 댓글 재검토로 확대하지 않는다. Figma API는 디자인 본문/이미지, 브라우저는 댓글 위치 검증에 사용했다.
- **오늘 #49 / #41:** Oli의11/5 12:15:52 본인 멘션(#49)은 [399:23417 TOBE 주석](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=399-23417)에 붙어 있다. Yoonie의 ‘unread만 카운트’ 제안(#41)에도 Oli가12:57:01 ‘적용했습니다!’로 답했고 같은 주석 위치를 직접 확인했다. **Unread 양수만 숫자·0숨김·All 숫자 없음·모바일/PC 공통**은 이미 Web/Office/Lab에 구현·검증·push되어 있다. 디자인 적용 답변과 제품 구현 근거는 별개로 대조했다.
- **#47 문구:** 10/30 12:00:05 Yoonie 답변의 국문 ‘기기 알림이 꺼져 있어요.’ / ‘알림을 켜서 중요 알림을 빠르게 받아보세요’ / ‘알림 켜기’는 파란 OS 안내 배너에 붙은 내용이다. 전역 최초 안내 팝업의 문구 변경 요구가 아니다. Lab `NotificationPermissionBanner.tsx`·번역에 이미 반영되어 있고 Office는 댓글대로 기존 영문을 유지한다.
- **#48 아이콘:** 10/29 18:08:12 Oli의 ‘기공소도 아이콘 위치 동일’ 멘션은 일반 Home의 헤드셋 왼쪽 벨 위치다. Office `EmployeeProfile`과 Lab `HomeProfileHeader` 모두 벨→헤드셋 순서/gap12로 구현되어 있다. 밀링 전용 홈의 QR/프로필 헤더를 바꾸라는 근거로 확대하지 않는다.
- **결론:** 확인한 최신 요구의 누락이나 사용자에게 새로 물어야 할 사항은 발견하지 못했다. 따라서 이번 점검에 따른 추가 제품 변경/테스트 재실행은 없다. 기존 USER 정책·와이어프레임 및 새 알림 API/미읽음 계약 대기는 유지한다. 오래된 댓글의 이미 답변된 질문을 다시 만들지 않는다.
- **검증/기록 경계:** Web `eb609ddd7`, Office `09a777a`, Lab `c6debf2`의 clean·upstream0/0를 재확인했다. 댓글 작성·수정·해결·반응 또는 명시적인 읽음 변경 조작은 하지 않았다. 실제 댓글 열람 후 Figma 자체 미읽음 표시가3→2로 감소한 것은 관찰했으므로 읽음 상태까지 전혀 변하지 않았다고 보고하지 않는다. 메일 추적 링크는 열지 않았다. 임시 근거 `/tmp/dentlink-figma-thread{41,47,48}-1105.{txt,png}` 및 `/tmp/dentlink-figma-review-window-1105.png`는 제품 Git에 추가하지 않는다.
- **마감/다음:** 이번에 연 Figma 탭만 정리하고 로컬 서버/기기는 재시작하지 않는다. 개인 정본만 commit/push한다. 다음에는 추가 기획·디자인·BE 명세 또는 실제 다중소속 검증 조건을 받으면 해당 변경분부터 이어간다. PR은 생성하지 않는다.

## 2026-11-05 후속 완료 — Lab 실제 소속 조회·전환

### 범위와 구현

- **작업 위치:** `/Users/parkjongsun/Repository/dentlink-lab-app`, 기존 `feature/DL-17060`. 시작 `91534d2`, 최종 `c6debf246b2a40443a203bbec1c55d6a1266dc29`. 시작 clean·단일 worktree·upstream 일치 확인 후 `git pull --ff-only` 최신 상태에서 작업했다. 최종 원격 feature SHA 일치·ahead/behind0/0·clean 확인. Web/Office 제품 변경, 새 branch/worktree, PR/merge/release/배포는 없다.
- **기존 API 재사용:** `GET /lab/users/own/employee?type=activate`로 실제 전환 가능한 소속을 조회하고 `PATCH /lab/employee/activates`를 기존 `useEmployeeProfile.handleChangeEmployee`로 호출한다. 화면 진입과 선택 직전에 목록을 갱신하고 최신 목록에 없어진 대상은 활성화하지 않는다. 이름·주소는 응답을 표시하며 명세가 없는 소속별 미읽음 수/미읽음 소속 여부는 만들지 않는다.
- 전용 `useNotificationLabSwitch`에서 기존 계정 전환 잠금과 대상 ID·로그인 사용자·소속 검증을 재사용한다. 중복 선택, 오래된 화면 callback, 계정/소속 왕복, 선택창 닫기·화면 이탈 뒤 응답을 막는다. 실제 활성화 성공으로 Root가 재생성되는 것은 사용자 취소와 구분한다. 기존 밀링 복귀 소속 값은 변경하지 않는다.
- 성공 시 기존 WebView 쿠키 초기화 플래그를 사용하고, 사용자/대상 소속에 묶인 **비영속·1회성** `pendingNotificationCenter`를 Root가 소비한다. 대상 프로필·navigation 준비 후 새 소속 알림함을 한 번 열고 기존 전환 토스트를 표시한다. 다른 계정/소속 또는 새 deferred 딥링크가 있으면 과거 알림함 복원을 폐기한다. 일반 소속 전환이나 QR/밀링 이동에 알림함을 끼워 넣지 않는다.
- fake A/B/C 소속·선택 상태를 제거했다. 알림 내용·읽음·설정은 여전히 **현재 인증 문맥에 묶인 DEV 메모리 mock**이며 실제 소속 변경 때 초기화한다. Home 벨의 mock 참조도 함께 정리했다. 실제 소속 시트는 이름·주소만 표시하고 숫자 배지/접근성의 ‘안읽음 N’을 생략한다. 미제공을0으로 바꾸지 않는다.
- 새 UI의 `__DEV__` 제한, OS 배너/권한 정책, 기존 푸시/QR, 네이티브·패키지·환경설정은 유지한다. 이번 변경으로 새 알림 저장/설정/읽음 API, 실제 푸시 읽음 연결 또는 운영 노출이 완료된 것은 아니다. 외부 문서/댓글/상태 변경이나 신규 Swagger 조회는 하지 않았다.

### 최종 코드 검증과 한계

| 화면·진입 | 조건·행동 / 기대 | 에이전트 결과 | 남은 실제 확인 |
| --- | --- | --- | --- |
| Lab Home→벨→알림함→설정→복귀 | 실제 INTERNAL/OWNER 단일 소속. 소속 GET 성공, 가짜 다른 소속 없음, 읽음 후 홈 점 갱신 | iOS26.5/iPhone17Pro·Android API36 모두 통과. 알림 내용/읽음 자체는 DEV mock | 실제 알림 API 연결 후 재검증 |
| 알림함→다른 기공소 선택 | 합성 2소속의 이름·주소 표시, 미읽음 배지·접근성 숫자 없음 | 양 OS 화면 직접 확인 통과 | 실제 다중 소속 계정으로 목록/권한 확인 |
| INTERNAL→SHARED→INTERNAL | 실제 화면에서 선택, 대상 알림함1회 복원, 뒤로 해당 유형 Home | 네트워크를 차단한 합성 API 응답으로 양 OS 통과. 성공 경로/뒤로는 Maestro 터치 | 실제 서버 activation을 통한 왕복 전환 |
| 선택 중 실패·중복·취소·계정 변경 | GET/PATCH 실패 시 기존 소속 유지, 중복 activation1회, 오래된 응답/콜백 폐기 | 각 OS9/9 합성 런타임 케이스 통과. 지연/경합은 실제 렌더 callback·store를 CDP로 조작 | 실발송/실제 역할·소속을 포함한 통합 QA |

- 실제 저장 계정은 양 OS 모두 활성 소속1개/다른 소속0개였다. **실제 서버 activation PATCH는 보내지 않았으며 다중소속 서버 성공·실제 다중소속 권한 검증은 미완료**다. 합성 검증을 실제 API 전환 완료 근거로 확대하지 않는다.
- SHARED Home에는 기존부터 알림 벨이 없다. 새 메뉴/벨은 만들지 않았고 SHARED→INTERNAL 검증은 기존 인박스 route를 검증용으로 열어 수행했다. 성공한 전환 직후 새 알림함 복원은 정상이다. 메뉴 개선은 별도 범위다.
- 실제 앱 화면·React Navigation·기존 활성화 helper는 최종 소스로 실행했다. 합성 케이스는 Axios adapter/fetch/XHR의 실제 통신을 차단하고 auth persist도 메모리로 대체했다. 이후 원 계정·adapter·저장소를 복원하고 저장된 로그인/사용자/소속 일치와 실제 소속 GET을 재확인했다. 크래시·프로세스 재시작은 관찰되지 않았다.
- 자동 검증: 전환 훅21개 + 기존 URL/deeplink32개, **3 suites/53 tests 통과**. 훅 테스트의 API/query/profile helper는 mock임을 파일에도 명시했다. 변경 파일 ESLint error0/Root 기존console warning3, Prettier/diff 검사 통과. 전체 타입검사는 기존5진단(Icon2·Tooltip·order type·MessageText)만 남고 신규 진단 없음.
- 독립 검토에서 Home의 삭제된 mock scopes 잔존 참조를 발견해 수정한 뒤, 해당 최종 코드로 양 OS Home까지 재검증했다. 검증한 tracked source diff SHA256 `67bcf85a6cfcefa26ef210cd0d58649da3999471bfbc27951c72f9d31a01b55c`, 새 훅 `be19e1762eb41ba7b72b0ea3f3c69dfc531058f7b7d594e38174231559cb7bdc`가 commit 직전과 일치한다.
- 상세 임시 증거 `/tmp/lab-affiliation-runtime-1105.md`, 실제 단일소속 `/tmp/lab-{ios,android}-actual-single-inbox-1105.png`, 합성 선택 `/tmp/lab-{ios,android}-synthetic-selector-1105.png`, 경합 `/tmp/lab-{ios,android}-switch-cases-1105.json`. 증거 파일·계정·토큰은 제품 Git에 넣지 않았다.
- **마감/다음:** Lab8082·iOS·Android를 종료했고 로그인/권한은 보존했다. 현재 허용된 Lab 소속 연결 잔여는 완료다. 다음에는 공개된 알림 API 묶음별 계약/USER 정책을 확인하여 실제 저장·목록·미읽음·푸시 읽음을 연결하고 대체한 mock을 제거한다. 실제 다중소속 계정 확보 시 해당 전환을 추가 검증하며, 그 전에는 최종 사용자 QA/merge 준비 완료로 선언하지 않는다.

## 2026-11-05 브레이크포인트 — 구현 상태와 대기 조건

> 아래는 Lab 실제 소속 연결 전의 조사 시점 기록입니다. 해당 잔여는 위 후속 구현 절에서 완료됐으며, 미읽음/새 알림 API 대기는 유지합니다.

### 확인한 근거와 범위

- 개인 정본 `ccd58e9`에서 clean 확인·`git pull --ff-only` 최신 상태 확인 후 조사했다. 세 제품은 아래 기록의 Web `873fb2556`, Office `cefac786`, Lab `b92207c`이며 원격 feature SHA 일치·clean·ahead/behind0/0를 재확인했다. 최신 master/main 통합을 뜻하지 않으며 제품 fetch/pull/merge/rebase는 하지 않았다.
- [DL-16140](https://innovaid.atlassian.net/browse/DL-16140)의 현재 댓글8개를 확인했다. BE [44798](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=44798)은11/4 12:29:28 수정본 그대로이고, 최신 [44802](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=44802)는13:06:40 Lab 밀링 결제 제외다. BE 개인설정/인박스 카드 DL-17114·17115는 진행 중이며 새 계약 본문은 없다. 초안에 이미 답변된 치과/기공소 구분·Support·밀링 업데이트·과거 `defaultChannel` 질문은 다시 만들지 않는다.
- **DEV Swagger 11:17:50 KST:** [원문](https://dev-api.dentlink.io/v3/api-docs) HTTP200,977 paths/1491 schemas, SHA256 `fe9427183b408bba82dd94735b98821f59c8147db82cec94621bfc7f5ab3b01c`. 이전11/4의974/1490과 전체 문서는 달라졌지만 신규 알림설정 템플릿/개인설정 계약은 공개되지 않았다. `orderScopes`·`toggleChannel`은0건이다. 과거 원문 파일이 없어 새3개 path를 특정하지 않았고, 전체 Swagger 불변이라고 표현하지 않는다.
- [Notion PRD](https://app.notion.com/p/innovaid/3c7ce072e82f811184a8e647444f01fd) 반환 편집 시각은11/4 15:45:28 KST다. 필요한5-2/5-3/5-5·권한/기본값 표를 대조했고 일반 댓글은13개 모두 조회했으며 최신은10/29 18:51:34 KST다. 본문 응답에 truncated/unknown block1개가 있어 전체 본문 완전 재조회로 보고하지 않는다. Figma·FigJam·Sheet·Slack 전체를 오늘 다시 읽은 것은 아니며 이전 확인된 디자인·합의 근거를 재사용했다.
- [DL-17235](https://innovaid.atlassian.net/browse/DL-17235)는11/4 PM 수정에 따른 Credits Mail 보완 및 **USER 단위 구조/정책·와이어프레임 후속** 카드다. 카드 상태가 할 일이어도 이미 반영한 Credits Mail UI를 미구현으로 되돌리지 않는다. [DL-17202](https://innovaid.atlassian.net/browse/DL-17202)는 합의된 Office 조회 화면과 알림 랜딩 통합 작업으로 진행 중을 유지한다.

### 완료된 선행 구현과 실제 연결 경계

| 영역 | 현재 구현되어 있는 것 | 남은 것 |
| --- | --- | --- |
| Clinic/Lab 웹 | PC/모바일 알림 팝업·설정, 전체/안읽음·읽음 동작 UI, 권한/제품별 항목, 실제 소속 조회·활성화, 알림 전환 후 팝업1회 열기·토스트 | 새 목록/읽음/설정/미읽음은 로컬 mock. 새 UI는 development에서만 노출하고 다른 환경은 기존 알림 유지 |
| Office/Lab 앱 | 알림함·설정 화면, Home 진입, 권한/제품별 표시, OS 안내/정상 복귀 흐름·기기별1회 이력, 공통 딥링크의 로그인/소속 준비·화면/action 이동 | 새 알림 데이터/읽음/설정/미읽음은 mock. 알림함 새 route와Home벨은 `__DEV__` 제한, 실제 서버 연결 후 운영 전환 필요 |
| 소속 전환 | Web/Office 실제 소속 조회·활성화, Lab 공통 딥링크의 실제 소속 준비와 기존 전환 기반 | **Lab 알림센터 선택 UI만 mock 소속을 바꿈. 기존 API로 조회/전환 연결을 더 진행할 수 있음.** 소속별 미읽음 집계는 별도 대기 |
| Office 추가 목록 | 크레딧 잔액·이력, 청구서 목록의 웹 모바일 디자인/기존 REST 조회·권한/소속 처리 | 최종 NOTIFICATION/PUSH 랜딩값과 통합 검증. 별도 메뉴 없는 상태는 사용자 수용, 추가 메뉴 설계는 선행 조건 아님 |
| OS와 서버 설정 분리 | OS 조회·앱 복귀 확인과 신규 UI 흐름 준비 | 기존 `PermissionProvider`의 OS 허용→구 preference upsert, Office My Orders의 `pushEnable:true` 결합이 남음. 실제 새 설정 저장 계약에 맞춰 이관 필요 |
| 검증·전달 | 11/3~11/4 기록의 웹 PC/모바일·양 앱 iOS/Android 영향 경로 실행, 정적 검사, 제품 commit/push | 오늘 runtime 재실행 없음. 실제 FCM→읽음/클릭 저장·일부 역할/다중소속/OS·로그인 케이스, 최종 통합QA·PR·release·배포는 미완료 |

### API별 재사용 기반과 필요한 계약

아래는 필요한 **계약 묶음**이며 모두 신규 endpoint를 요구한다는 의미가 아니다. 일부부터 공개되면 해당 범위를 연결하고 대체한 mock을 삭제한다.

| 묶음 | 현재 공개·사용 가능한 기반 | 남은 계약/연결 |
| --- | --- | --- |
| 설정 템플릿 | Jira의 `orderScopes`, `categories[{domain,category,toggleChannel,channels}]` 초안 | 실제 path·요청·응답, Office/Lab/권한별 지원 범위. 후속 PM Credits MAIL 반영 여부도 확인 |
| 개인 설정 조회·저장 | 구 `/app/users/own/push-preferences`, 항목별 `/push-settings/{id}`는 존재 | 새 웹·앱 공통 개인값, 상위/채널 독립 ON/OFF, 초기값·기존 사용자 이관·숨긴 Web Push 보존. 구 API를 신규 계약으로 오인하지 않음 |
| 알림 목록 | `GET /messages/notifications`, query `id/serviceType/size`, `landingUrl/isRead` 등 응답 | 안읽음 필터·페이지, 새 domain/category 표시, 제품/채널별 랜딩 전달 방식. 새 endpoint나 특정 필드명을 먼저 강제하지 않음 |
| 미읽음·다른 소속 | `/messages/notifications/unread` boolean, `/messages/notifications/employers` string[] | 전체 소속 미읽음 존재·각 소속 ID와 개수 연결. 소속명/주소는 기존 조회 재사용 가능 |
| 읽음 | `PATCH /messages/notifications/read/partial`에 `{unreadNotificationIds:[]}`, `/read/all` | 실제 목록 식별자·소속/필터 범위에 연결. 새 읽음 API나 푸시의 notificationId 직접 전달을 필수로 요구하지 않음 |
| 푸시 클릭 이력·읽음 연결 | 기존 FCM/Notifee/딥링크·읽음 REST | 발송건↔알림 매칭, 대상 소속, 클릭 기록/읽음 처리의 API 분담. 한 API나 별도 API 여부는 BE 계약으로 확인 |
| Office 추가 목록 | `/office/credits/own/accounts`, `/office/credits/own/details`, `/office/payments/invoices` | 이미 실제 조회 연결. 신규 API 대기가 아니라 최종 알림 랜딩 통합·실제 데이터 검증 대상 |

### 남은 정책·디자인·검증과 지금 가능한 것

- **FE 단독 잔여 후보:** Lab `src/services/user.service.ts`의 `GET /lab/users/own/employee?type=activate`·`PATCH /lab/employee/activates` 및 `useEmployeeProfile.handleChangeEmployee`가 이미 있다. `useMillingAccountSwitch`의 재조회/경합 보호/활성화/쿠키 처리 패턴을 참고해 알림센터의 실제 소속 선택·전환을 연결할 수 있다. 밀링 전용 동작을 그대로 끌어오지 않는다. ‘미읽음 있는 소속만’과 숫자는 집계 계약이 필요하므로 표시 정책을 임의 변경하거나 mock 알림을 실데이터로 가장하지 않는다. 실제 Lab 다중 소속 검증 계정/데이터는 확보되지 않은 검증 조건이다. **오늘은 조사만 했고 구현하지 않았다.**
- **PM 후속 자료:** USER 단위 Promotion(SMS/MAIL), Benefits > Credit(PUSH/MAIL)의 정책·와이어프레임과 기존 Employee 설정의 관계를 기다린다. 이미 확정한 기본 알림함 디자인/추가목록의 웹모바일 디자인/별도메뉴 후속(파란배너는 위11/5 후속 정책이 우선)을 다시 질문하지 않는다.
- **관련 홈/채팅 적용:** Office Home My Orders의 웹·앱별 표시/최초 안내는 알림 수신 범위와 동일 개념이 아니다. 실제 저장·초기화 계약과 대조할 때 구분한다. Lab 최근 메시지/Support 노출·자동 이벤트 메시지 hide의 적용 범위/배치도 후속 근거 확인이 남으며, 오래된 DL-17068 제목으로 제외된 Lab My Orders를 되살리지 않는다.
- **기존 연관 장애:** Office Support `/office/chat-messages`는 이전 실제404에 이어 오늘 Swagger에도 없다. 현재 지원/대체 조회 계약 확인이 필요하다. 새로운 알림 API를 만들어야 한다는 근거로 확대하지 않는다.
- **심사:** 현재 확정 범위의 양 앱 native/package/lock 누적 변경0이 유지된다. 이메일 잔존 의존을 요구사항에 맞춰 정리한 결과이며 심사를 피하기 위한 기능 축소가 아니다. 현재 알림센터 때문에 추가 native 심사 선반영을 요청할 필요는 없다. 실제 release/CodePush 대상 호환·통합검증은 전달 단계에서 별도 확인한다.
- **다음 순서:** Lab 실제 소속 연결의 제한된 FE 잔여 → 공개되는 API 묶음별 실제 연결/mock 제거/구 preference 이관 → USER·관련 홈 정책 변경분 반영 → 실제 발송/권한/다중소속 포함 최종 검증 → 사용자 승인 범위의 PR/배포 단계. 새 계약이 나오기 전 저장 규칙을 추측해 선연결하지 않는다. 오늘은 새 제품 구현·외부 질문/댓글/상태 변경 없이 개인 정본을 정리한다.

### 후속 사용자 요청 — 현재 구현 화면 확인 환경

- **후속 정정:** 사용자가 화면을 보기 위한 웹·앱 실행은 바로 하지 않아도 된다며 보류하고, 아래 Figma `399:23417` 확인·반영을 요청했다. Cursor IDE 전환을 더 요구하거나 사용자 확인용 웹 서버를 대신 켜지 않는다. 앱의 변경 검증에 필요한 실행과 사용자 확인용 창 준비를 구분한다.
- 사용자가 보고서를 읽고 현재까지의 화면을 직접 보기 위해 Web Clinic/Lab·시뮬레이터·에뮬레이터 실행을 요청했다. **이번 웹은 명시적 지시에 따라 Cursor 내부 터미널에서 실행하며 Codex 별도 웹서버로 대체하지 않는다.** 앱은 Codex 자체 실행을 허용했다. 이는 이 요청의 실행 방식이며 공통 기본 지침을 무단 수정하지 않는다.
- **앱 화면 준비 완료:** 기존 로그인/빌드/디바이스를 보존하고 Office8081(PID3396, cwd `dentlink-app`)·Lab8082(PID3397, cwd `dentlink-lab-app`)를 재기동했다. DeviceHub의 iPhone17Pro/iOS26.5에 Office 영문 알림함, Android Dentlink_API_36:5554에 Lab 한글 알림함이 실제 표시된다. 각 Home→벨로 진입했으며 현재 crash/RedBox 없음. 양 기기에 두 제품이 설치돼 필요 시 전환 가능하다. 신규 설치·권한 변경·제품 코드 변경 없이 창/서버를 켜두었다. 알림은 mock이며 전체 QA 재실행이나 실제 BE 연동 검증이 아니다. 화면 근거 `/tmp/office-inbox-preview-final-1105.png`, `/tmp/lab-preview-now-1105.png`; 세션 Office43643/Lab41797/Android74859. PID/세션은 다음 재개 때 재확인한다.
- 웹은 기존 env/의존성이 있고3000/3005는 비어 있으나 Cursor가 Agents 화면으로 열리며 IDE/새 터미널 전환이 반응하지 않았다. 사용자에게 웹 워크트리를 IDE 화면으로 열어달라고 요청했고, 이 단계에서는 웹서버를 별도 실행하지 않았다. 초기화나 사용자 Cursor 종료는 하지 않았다.
- 이 요청은 코드 추가 구현·PR·배포가 아니라 현재 코드의 화면 확인 환경 준비다. 11/4 로컬 종료 기록은 당시 마감 근거로 보존하되 현재 실행 상태로 재사용하지 않는다.

## 2026-11-05 Figma 후속 — Unread 탭 숫자 표시

- 사용자 제공 [Figma399:23417](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=399-23417)은 화면 전체가 아니라 TOBE 주석이다. **Unread 버튼에만 숫자,0이면 숫자 미노출,1이상만 표시,모바일·PC 공통**을 명시한다. `All` 숫자나 전체 알림 개수·읽음 처리 정책을 추가하는 요구가 아니다.
- 원본 context/screenshot 및 상위 구조를 읽기 전용으로 확인했다. `[치과] 알림센터*알림 인박스`에 `APP & Mobile Web`과 PC 모달이 있으며, 인접399:23403/23346/23360이0/1/22 세 상태다. 양수는 Unread 텍스트 오른쪽 빨간 pill, 높이16/최소폭20/좌우4/간격4,흰 숫자10/line15/700이다. Figma·댓글은 수정하지 않았다.
- 기존 Web·Office·Lab은 All/Unread 텍스트만 있었으므로 미읽음 숫자가 미구현이었다. 공유 웹 Inbox 및 양 앱 Inbox에 `unreadCount` 입력을 추가하고 Unread에만 양수일 때 표시한다. 숫자 모름/0이면 숨긴다. 현재 mock controller가 **필터 적용 전 현재 소속 전체 목록**에서 계산하며, 표시 중인 페이지/안읽음 탭 길이를 총수로 추정하지 않는다. 읽음/전체읽음·소속 변경은 기존 상태 처리를 따른다.
- 새 BE endpoint·payload·숫자 상한 규칙을 만들지 않는다. 실제 연결 때 **현재 소속 전체 미읽음 집계값**이 필요하며, 기존 Swagger boolean만으로 숫자를 알 수 없다는 계약 확인 항목을 추가한다. 개발용 mock 계산을 실제 서버 집계 완료로 보고하지 않는다.
- 기존 토큰/컴포넌트를 재사용한다. 앱의 숫자는 이미 포함된 LatoLatin-Bold를 사용한다. 웹에는 Lato 자산/토큰이 없어 기존 Typography의 Pretendard를 유지하며 새 폰트/라이브러리를 도입하지 않는다. 따라서 숫자 글꼴까지 Figma와 동일하다고 주장하지 않는다. Lab 공용 Chip의 괄호 숫자/0표시 동작은 다른 사용처까지 바꾸지 않고 해당 화면만 보완한다.
- 코드 변경은 제품별 Inbox/현재 mock 연결의2파일씩이며 Storybook·영구 테스트·별도 상품 화면을 추가하지 않았다. 독립 소스 검토에서 미읽음 전달/선택 탭/기존 번역·접근성 상태에 추가 결함을 찾지 못했다. 최종 실행·검사·커밋은 아래 마감 결과를 따른다.

| 제품 | 최종 코드·검증 | 범위와 한계 |
| --- | --- | --- |
| Web Clinic/Lab | `eb609ddd72b4e9f618ae0585aabcee979136c9d4`. 실제 공유 컴포넌트를 서버 없이 Chromium에 마운트해 PC1280/모바일390, 미제공·0·1·22, All/Unread 전환, 목록1개와 외부총수22 분리, Clinic/Lab mock3→개별읽음2→같은행재클릭2→전체읽음0 확인 | 초기 스타일에서 gap 값만 있고 flex가 없어 실제간격0인 문제를 root 육안 검토로 찾아 수정했다. 최종실측 텍스트→배지4px/세로중심차0,높이16/최소폭20,숫자10/line15/700,red600/white. 폰트는 Pretendard 유지. 브라우저오류0이며 통합제품 로그인 화면 검증은 실행 보류로 하지 않음 |
| Office | `09a777ad92b8c356e71db0877aef1678f45fdb55`. Inbox·controller2파일만 변경. 기존 LatoLatin-Bold/body4/red600 재사용, 소속별mock전체수 입력 | iOS/Android 영향 화면 실행·숫자/읽음/필터 검증. 기존 전체typecheck6진단 유지, 변경파일 신규진단 없음 |
| Lab | `91534d29e703de3edabee563f08f8c7671143f80`. Inbox·controller2파일만 변경. 공용Chip의다른소비자는유지하고 이 화면 Unread 배지만 보완 | iOS/Android 영향 화면 실행·숫자/읽음/필터 검증. 기존 전체typecheck5진단 유지, 변경파일 신규진단 없음 |

- 웹 필수 pre-commit의 Clinic/Lab/Admin 타입검사, pre-push3제품lint(error0/기존warnings), Admin guard9·shared21+32 및coverage변화없음 통과. UI ESLint의 기본 실행에서 기존 Storybook plugin 중복 로드가 있어 UI config를 독립 지정해 변경 파일을 검사했으며 Git hook은 우회하지 않았다.
- 양 앱 변경 파일 ESLint/Prettier/diff 검사 통과. 네이티브·공용Chip·번역문구·BE요청은 변경하지 않았다. 지금 확인한 mock 읽음/숫자 동작을 실제 REST 읽음/FCM/최종 QA 완료로 확대하지 않는다.
- **양 앱 최종 실행:** Office/Lab 각각 iOS·Android에서0/1/22·All/Unread 전환 중 배지 유지·개별읽음 감소·전체읽음0숨김을 확인했다. 22건은 메모리 mock에만 주입하고 복원했다. 상세는 `/tmp/apps-unread-badge-runtime-1105.md`; 이번 변경 화면의 최종 코드 검증이며 실발송/실서버 읽음은 아니다.
- **마감:** 세 제품 기존 feature 브랜치에 위 HEAD로 commit/push하고 각각 ls-remote 일치·clean·ahead/behind0/0 확인. PR·외부 문서/댓글 변경 없음. 사용자 확인용 실행 보류를 반영해 웹서버는 시작하지 않았고, 변경 검증용으로 재기동했던 iOS/Android·Metro8081/8082도 종료했다. 로그인·기기 데이터·권한은 유지한다. Cursor IDE 전환 요청은 더 이상 대기 조건이 아니다.
- 원본 세 상태 이미지는 `/tmp/notification-figma-399-{23403,23346,23360}-1105.png`, 웹 최종렌더 `/tmp/dentlink-unread-{1280,390}-22-1105.png`, 결과 `/tmp/dentlink-web-unread-render-results-1105.json`. 대표앱은 `/tmp/office-ios-count22-all-1105.png`, `/tmp/lab-android-count22-all-1105.png`. 임시산출물을 제품 저장소에 추가하지 않았다.

## 2026-11-04 확정 범위에 맞춘 잔존 코드 정리·검증

- **최신 사용자 기준:** 심사를 피하려고 기능을 바꾸는 것이 아니라, 지금까지 확정한 통합알림센터 범위와 코드·기록을 일치시킨다. 이메일 CTA는 별도이며 노티/푸시 공통 랜딩, 기존 Airbridge·Lab QR, 합의된 추가 조회 화면과 Email 수신 설정은 유지한다.
- [FE 심사 일정 스레드](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793784745210489)를 재조회했다. 부모18:32:25와 답글6개(마지막18:37:05 KST, 더 없음)이며, Daniel은 라이브러리 변경으로 이번 주 심사·다음 주 월요일11/9 배포를 고려하되 요일은 유연하다고 했다. Joy의 주문 상세 동시 배포는 검토 중이다. 이 일정에 알림센터 포함을 확정하거나 Slack에 답변을 게시하지 않았다.
- **이전 판단 정정:** 양 앱에 네이티브 코드가 남았다는 사실만으로 이번 심사 빌드 포함을 요구한 안내는 부정확했다. Office `9ae3cf3`·Lab `28ebcd8`의 이메일 HTTPS 진입 보완으로 추가한 브라우저 모듈이, Office `b78947f`·Lab `04cfe7f`의 도메인 분리 후에도 남았다. 공통 호출자가 있다는 이유와 새 native가 필수라는 판단을 혼동했다.
- **코드 정리:** 양 앱 `BrowserPackage.kt`와 `MainApplication.kt` 등록을 제거하고 `browser.ts`는 기존 `Linking.openURL` 및 실패 boolean을 재사용한다. 지원 URL 변환·로그인 대기·소속 준비·기존 화면/action은 유지했다. Office는 이미 OS/SDK가 받은 미해석 Airbridge HTTP(S) 주소만 수신입구3곳에서 재전달하지 않게 한다. 인박스/FCM의 최초 직접 호출은 보존하며, SDK가 해석한 앱/일반 웹 URL도 통과한다. Lab은 기존 Dentlink 웹 도메인 분기와 QR 우선 처리로 경계가 분리돼 추가 가드가 필요 없다.
- **누적 범위 확인:** 두 앱 모두 feature merge-base 대비 Android/iOS·Manifest/entitlements·package/lock의 변경0. Office 기준 `7f586790`, Lab 기준 `5144103`이며 Lab 최신 main `26623e0`에만 있던 다른 밀링/배포 변경을 이번 feature의 수정으로 오인하지 않는다. 웹 `873fb2556`은 이메일 확장 `6dca5142b`의16파일이 모두 추가 전 상태와 동일하므로 수정하지 않았다. 기존 Lab `/q/*`는 유지한다.

| 제품·최종 코드 | 최종 실행·검사 근거 | 결과와 한계 |
| --- | --- | --- |
| Office `cefac786` | 기존 Jest77건/3suite, 실제 소스 임시 검사14건, 변경 lint/diff. 모듈 제거 Android 빌드·재설치 후 native 모듈 없음 확인. Android OWNER/iOS MEMBER에서 Credit 실제 조회·Back, 인박스/설정, 일반HTTPS·잘못된소속 브라우저 처리, raw/resolved Airbridge 경계 | 영향 경로 정상, 관찰된 fatal/render loop0. Android push는 합성 URL이며 실제 FCM 발송 아님. 초기 SDK/deferred/오류 분기는 합성 검사, 실제 캠페인 서버·로그아웃 E2E는 미실행 |
| Lab `b92207c` | 기존 딥링크6건·실제 소스24건, lint/diff. Android 새APK의 DEX 및 runtime 모듈 없음. 양 OS 기존 INTERNAL/OWNER/DIRECTOR에서 Home·인박스/설정, raw/push 채팅 실제본문, 대표 `/q/o` 주문 상세·Back, Airbridge 형식 URL, 일반HTTPS 브라우저 이동 | 영향 경로 정상. 실제 FCM 발송·캠페인 서버·QR 촬영/모든 QR유형 검증으로 확대하지 않음. 전체 tsc5건은 기존 진단과 동일, 변경 파일 신규 진단0 |

- **독립 검토:** 웹 범위 감사와 양 앱 최종 diff를 별도 담당자가 재검토했고 새 결함·필요 공통 기능 삭제를 발견하지 못했다. exact host/resolved 경계 추가8케이스 통과. 새 제품 테스트 파일이나 라이브러리를 추가하지 않았다.
- **Git·로컬 마감:** Office `cefac78668b77a1fd3781cfa01b7da0860808a03`, Lab `b92207c5e36747e811a23001868cde9b46c860bc` commit/push·ls-remote 일치·clean 확인. Web은 `873fb2556` 그대로다. Office 첫 push의 GitHub `commit_refs_rules` 서버 오류는 재시도 성공으로 해소됐고 개인 컨텍스트의 이전 미반영2커밋도 원격 반영했다. 양 앱의 원래 소속/Home·로그인·OS 권한을 유지하고 임시 observer/변수를 제거했다. Metro8081/8082·Android·iOS·해당 DeviceHub 창 종료, 남은 로컬 서버 없음.
- **전달할 결론:** 현재 확정 범위의 알림센터 때문에 이번 심사 빌드에 추가로 선반영을 요청할 네이티브 변경은 없다. 실제 release 통합·CodePush 대상 호환·최종 QA·배포는 별도 단계이며 이번 정리로 완료 처리하지 않는다. 새 BE 계약/USER 정책 대기 상태도 그대로다.
- **기록 경계:** Notion/Jira의 기존 이메일 분리 정의는 바꾸지 않았다. 새 댓글·상태 변경·PR·merge·배포는 하지 않았다. 상세 실행 근거는 `/tmp/office-native-scope-cleanup-20261104.md`, `/tmp/lab-native-scope-cleanup-20261104.md`이며 주요 결과는 이 표에 Git으로 보존한다.

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

2026-11-05 최신 후속: 기존 checkout/branch/worktree에서 Unread 숫자·Lab 실제 소속 연결에 이어 OS OFF 배너/팝업·Shipping 위치를 반영했다. 앞선 Lab 밀링 결제 제외·Clinic Credits Email·이메일 잔존 native 정리는 유지한다. 검증·원격·로컬 실행 상태는 각 날짜의 최신 마감 기록을 따른다.

| 제품 | checkout | branch / upstream | 원격 반영 HEAD |
| --- | --- | --- | --- |
| Web | `/Users/parkjongsun/Repository/dentlink-client-notification-center` | `feature/DL-17058` / `origin/feature/DL-17058` | `6a0bd7caf1dc05502730e1d85b69442cc461586f` |
| Office | `/Users/parkjongsun/Repository/dentlink-app` | `feature/DL-17059` / `origin/feature/DL-17059` | `be825ad6c0ad9cf08c7ee64bb5f52d721ef0ea64` |
| Lab | `/Users/parkjongsun/Repository/dentlink-lab-app` | `feature/DL-17060` / `origin/feature/DL-17060` | `193ee8b5668f345357bea5dd9d9a6fd9ffb90b5d` |

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

- **11/5 최신:** 사용자 확인용 화면 실행은 보류했다. 후속 Unread 배지 검증을 위해 재기동한 기존 시뮬레이터·에뮬레이터와 Metro8081/8082는 종료했다. 웹은 서버 없이 실제 컴포넌트 렌더로 검사했으며3000/3005는 이 세션에서 시작하지 않았다. 기존 로그인·키체인·권한 유지. 아래11/4 이전 종료 기록은 당시 근거다.
- **11/4 확정 범위 정리 후 최종 마감:** Office/Lab 양 OS 영향 검증을 위해 재실행한 Metro8081/8082·Android AVD·iPhone17Pro·해당 DeviceHub 창을 모두 종료했다. 3000/3005/8081/8082 listener 없음, adb 기기0·booted simulator0 확인. 양 앱 원래 Home/소속·로그인·OS 권한과 Keychain은 보존했다. Office Android OWNER/iOS MEMBER, Lab 양 OS 기존 소속에서 확인한 범위와 미검증은 최신 범위 정리 절을 따른다.
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
- **Office Credits Mail 추가:** 11/4 15:49 PM 수정 요청으로 Web/Office UI의 Email 수신 채널을 추가했다. 서버 초기값·저장·마이그레이션은 명세 확인 대상이다. 11/5 최신 PRD5-6에서 USER/Employee 수신 단위 분리·중복 발송 금지·동일 인박스 최신순 노출 방향을 확인했다. USER는 domain 이름과 다른 개념이다. 설정 위치·기존 프로모션 동의 관계(#20), 소속 공통 노출·계정 읽음·전환기 집계 제외 제안(#21), 이벤트/채널 목록(#22)은 Open이므로 Employee 설정을 임의로 이관하지 않는다.
- **Lab 밀링센터 주문 > 결제 제외:** 11/4 Leo 답변44802 기준으로 mock 설정/샘플 제거 완료. 밀링 주문 업데이트는 유지한다. 이 결정은 실제 밀링 업무 결제나 Clinic/Office 결제·크레딧의 제외를 뜻하지 않는다.
- 신규 가입·신규 소속 PUSH ON, 기존 PUSH 선택 보존 방향을 유지한다. 실제 초기값·마이그레이션은 BE 계약으로 확인한다. **Lab My Orders는 제외 확정**이며 과거 제안/티켓 제목으로 되살리지 않는다.
- 상위 OFF는 하위 OFF, 상위 다시 ON은 하위 기본 ON이다. 하위를 모두 OFF해도 상위까지 자동 OFF하지 않는다. 숨긴 채널을 저장 시 덮어쓰지 않도록 실제 catalog/저장 규칙과 맞춘다.
- Office 정책상의 Admin은 `OWNER`, Billing Manager는 `PAYMENT_MANAGER`, Manager는 `EDITOR`다. 현재 소속에 일치하는 실제 authority를 사용하며 새 `ADMIN` API enum을 발명하지 않는다.
- MEMBER의 My Orders 수신은 Assigned Dentist 기준이다. 알림 수신 설정과 홈/주문/LinkTalk 조회 필터는 이름만으로 합치지 않는다. Office `usePersonalOrdersPreference`의 `pushEnable:true` 결합도 함께 점검한다.
- LinkTalk/Support Push 설정은 자동 이벤트 채팅 자체를 끄는 의미가 아니다.
- OS OFF에서 특정 PUSH 선택→OS 설정→정상 복귀 후 권한 ON이면 선택한 항목만 저장한다. 재시작·계정/소속 변경 등 흐름이 끊기면 과거 선택을 버리고 서버 저장값을 유지한다. 임의 유효시간이나 복잡한 복구 정책을 발명하지 않는다.
- 기존 `PermissionProvider`의 OS 허용과 서버 preference 초기화/upsert 결합은 남아 있다. 새 OS 조회 hook이 있다는 이유로 분리가 완료됐다고 판단하지 않는다.
- **전역 OS OFF 팝업:** 10/30 17:30 기기별 로컬 1회 노출 선행 구현 완료. 실제 표시 후 기록하며 계정·병원 변경으로 초기화하지 않는다. 재설치·이력 유실로 재노출되는 것은 수용한다.
- **설정 화면 파란 배너:** 11/5 14:49 Slack 및 Figma405:23592 기준으로 **OS OFF 동안 상시 표시**하며 닫기 버튼은 없다. 과거 기기1회 배너 키/조회/저장은 제거하고 기존 저장값은 더 이상 노출 판단에 사용하지 않는다. OS ON이면 숨긴다. 자동 안내 팝업의 `NOTIFICATION_PERMISSION_NOTICE_SHOWN` 기기1회 정책과 구분한다. 11/3 배너1회 구현은 과거 이력이며 현재 정책이 아니다.
- **도메인/카테고리 표시:** 10/30 18:01 사용자 결정으로 BE 계층/명칭을 그대로 노출할 의무가 없다. 같은 원본 row 안에서 하위 카테고리를 상위처럼 보이게 하거나 도메인을 숨길 수 있다. 저장 식별자를 유지하고 무관한 row는 합치지 않는다. `title`, `key/label` 분리는 준비됐지만 실제 enum/catalog adapter는 미확정이다. [디자인 기준](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=314-23253)

### 소속 전환·미읽음 표시

- 올바른 employer/employee 활성화 후 해당 소속 알림을 보여준다. 웹은 성공 후 대상 알림 팝업 한 번 자동 열기·토스트까지 가능한 방향이며 앱은 대상 스크린으로 연결한다.
- 알림에서 이동했는지, 이전/이후 병원명은 이번 이동의 임시 정보로 처리한다. 이 목적만으로 영속 저장·신규 BE API를 요구하지 않는다. **Web·Office·Lab 소속 조회/활성화는 기존 실제 API로 연결**했으며 Web 팝업·토스트, Lab 대상 알림함1회 복원까지 보완했다. 11/6 사용자 확인으로 Lab 다중소속 서버 전환은 이번 잔여에서 제외하며, 필요한 제품의 미읽음 집계 계약은 계속 대기다.
- 벨 미읽음 점은 모든 소속 중 미읽음 존재 여부, 현재 목록·전체읽음은 현재 소속 기준이다. 위치별 숫자/점과 집계 응답은 최종 디자인·BE 계약에 맞춘다.

## 남은 일과 다음 시작 순서

| 순서 | 할 일 | 필요한 조건 / 완료 기준 |
| --- | --- | --- |
| 1 | 실제 권한·OS 미검증 해소 | Office 실제 병원 전환은11/6 확인. 비OWNER 서버 권한과 iOS 실제 OS OFF/ON은 별도 실계정/실기기 검증. Lab 다중소속은11/6 사용자 확인으로 이번 범위 제외. 미읽음은 계약 대기 |
| 2 | 새 BE 명세와 기존 구현 대조 | 목록/페이지·필터, 소속별 미읽음, Employee catalog/default/migration/설정 저장, 푸시 식별·클릭/읽음 계약을 확인. 새 API/notificationId 필수를 먼저 요구하지 않음 |
| 3 | 실제 데이터 연결 및 mock 제거 | 제공된 계약 범위부터 연결, 대체된 mock만 정확히 삭제. 소속별 미읽음 포함. 숨긴 채널을 임의 덮어쓰지 않음 |
| 4 | OS와 기존 서버 preference 이관 | PermissionProvider의 OS 허용→legacy upsert와 Office My Orders의 pushEnable 결합을 새 저장 계약에 맞춰 분리. 구 production 설정 초기화를 계약 없이 통째 제거하지 않음 |
| 5 | 푸시 읽음/클릭·실역할 실행 검증 | 현재 로그인·해당 소속 준비와 identity를 검증한 뒤 REST 연결. 실제 FCM 수신·중복/동일화면의다른알림, 실패/삭제, 실제 역할/OS/기기 조건 검증 후 사용자 QA |
| 6 | PR/release | 실제 연결 후 새 UI의 DEV 제한 해제·운영 진입 전환. 구현·에이전트 실행 검증·사용자 QA를 구분. 현재 PR 생성/merge/배포 지시는 없으며 자동 진행하지 않음 |

- **병행 확인:** 기존 Office Support의 현재 BE 조회 계약과 필요한 실제 역할/데이터를 확보하면 해당 미검증을 해소할 수 있다. 메일 CTA/SES·추가 메뉴·새 디자인 발주를 알림센터 선행 조건으로 만들지 않는다.
- **남은 정책 근거:** Lab Home 최근 메시지/Support·자동 메시지 hide의 적용 범위는 후속 명시 근거를 확인한다. 배너는11/5 최신 합의의 OS OFF 상시 노출, 자동팝업만 기기1회를 따른다. 이미 해소한 내용은 정책 미정으로 되돌리지 않는다.
- **11/5 USER 후속 확인:** PRD5-6의 수신 단위 분리·동일 인박스 방향은 확인했다. 남은 것은 #20 설정 위치/기존 SMS 동의 관계, #21 소속 공통 노출·계정 읽음·전환기 집계 제안 확정과 BE 저장 구조, #22 이벤트/채널 목록이다. Promotion(SMS/MAIL), Benefits > Credit(PUSH/MAIL)은 후보이며 실제 catalog/계약으로 확정하지 않는다. 기존 Credits Mail UI는 유지한다. Lab Home 최근 메시지는 본문에 요구가 있으나 대상·위치·읽음·웹/앱 범위 #19가 Open이므로 새 UI를 임의로 추가하지 않는다.
- **앱 전달 전 확인:** 이메일 분리 후 잔존했던 Android 모듈은 제거·기존 JS 방식으로 대체·영향 기기 검증까지 완료했다. 현재 기능 때문에 추가 native 심사 선반영을 요구하지 않는다. 실제 release/CodePush 대상 호환과 Lab main-only 변경의 통합 여부는 전달 단계에서 별도로 대조하며 자동 merge/rebase는 하지 않는다.
- **누락 보완 이력:** 11/3 배너 영속 보완,11/4 후속 승인에 따른 Lab 밀링 결제 알림 제외까지 완료했다. 다음은 공개 BE 계약을 실제로 확인한 범위부터 이어가며, 임의 API/정책 가정이나 자동 조회·폴링은 하지 않는다.

## 정본 자료·Jira·이력

- 정책: [Notion PRD](https://app.notion.com/p/innovaid/3c7ce072e82f811184a8e647444f01fd). 화면: [Figma](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=2-6). 원 기획: [FigJam](https://www.figma.com/board/U9Qpm6ACzjGFKyrCoaAuvA?node-id=33-3714).
- 결정 근거: [UX 논의](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793063024060739), [푸시 클릭/읽음](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1793244658608799), [앱 추가 목록 회의](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793596568281269). 최신 명시적 사용자 정정과 날짜 있는 후속 결정을 오래된 문장보다 우선한다.
- 알림센터 상위 [DL-16140](https://innovaid.atlassian.net/browse/DL-16140). 공통 DL-17057, Web DL-17058/17061/17062, Office DL-17059/17063/17064/17065, Lab DL-17060/17066/17067/17068, UX 사전 검토 DL-17048. 실제 카드 상태·범위는 재개 시 확인하며 카드명만으로 제외 범위를 복원하지 않는다.
- 추가 목록: DL-17174→DL-17202, 후보 검토 DL-17179. 원본 앱 비교 세션 역할은 [모바일웹/앱 차이 체크포인트](dentlink-mobile-web-app-parity.md)를 참조한다.
- 마지막 DEV Swagger 조사: **11/5 11:17:50 KST**, 신규 설정 계약은 미공개. 전체 문서 변경과 필요한 계약 미공개를 구분하며 수치·API별 결과는 위11/5 점검을 따른다. 11/3 기존 API 검토는 [당일 14:05 점검 이력](archive/dentlink-unified-notification-center-2026-11-03-worklog.md), Office Support404 실행은 별도 실행 기록을 따른다.
- 과거 FE API 제안서는 확정 BE 계약이 아니다. 상세 조사·UX 합의·소스/기기 증거·공수 산정·이전 정확한 Git 이력은 [2026-11-03 분리 전 전체 이력](archive/dentlink-unified-notification-center-through-2026-11-03.md)에 보존했다. 과거 ‘현재/다음’ 지시는 최신 범위를 되돌리지 않는다.
- **11/4 산정 역추적 완료:** [Tom의 Slack](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793765218878199)은 AI로 Jira 카드를 만드는 것은 좋으나 스토리포인트 점검이 필요하다고만 했다. 사용자는 통합알림센터를 지적했을 가능성을 제시했지만 특정 카드·기간 과다·잘못된 근거는 원문에 없다. 이후 메인세션에서 사용자 요청으로 FE 하위13개와 [공통 설계 DL-17057](https://innovaid.atlassian.net/browse/DL-17057), [상위 일정 댓글44666](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=44666)을 읽었다. 현재 등록 합계31SP와 당시 병행13작업일/잔여12일 설명을 확인했으며 오늘의 잔여공수로 해석하지 않는다.
- **검토 결과:** 합산 `37-7.5+UX1+설계0.5=31SP`는 맞고 Lab의 Office 패턴 재사용도 이미 반영돼 있다. 다만 31SP=186시간과 사용자1명+Codex의13일=78사람시간을 연결하는 측정 기준·생산성 근거, `1+0.5+max(8.5,11.5,9.5)` 병행식의 공통 인간 검토/통합·선행 관계, 카드별24시간/18시간 등 계획치를 뒷받침하는 비교·실측 근거가 부족하다. 별도QA를 빼면서 필수 최종 앱 검증은 유지한 공수 배분도 불분명하다. 검토 요청은 타당하지만 명백한 과다 산정·중복 계산이나 Tom의 실제 지적 이유가 입증된 것은 아니다. PM의 기존 구두 일정 싱크 댓글44669도 보존한다.
- **사용자 결정:** 원문·Jira 점수·기존 일정은 수정하지 않고 앞으로 [공통 산정 지침](../DEVELOPMENT_STYLE.md#dentlink-story-point-estimation)을 적용한다. 이번은 읽기 전용 역추적과 개인 지침 정비이며 새로운 점수·납기를 확정하지 않았다. 사용자 요청대로 기록 정리 후 대기하고 별도 지시 없이 기존 카드를 재산정하거나 제품 작업을 재개하지 않는다.

## 운영 경계

- 이 세션은 통합알림센터 기능을 Web/Office/Lab 함께 담당하며 [FE 상위 세션](dentlink-fe.md)은 공통 조율을 담당한다. 새 세션·worktree를 자동 생성하지 않는다.
- 제품마다 정확한 저장소·활성 작성자를 확인한다. Web 신규 일반 작업은 최신 origin/master, 두 앱은 origin/main 기반 feat/<Jira>→해당 release→main이다. 11/4 이후 신규 브랜치에는 feat/를 쓰고 기존 feature/ 원본은 별도 지시 없이 바꾸지 않는다. 남은 develop을 신규 기준으로 쓰지 않는다.
- 11/3 사용자가 이번 FE 선행 범위의 구현·검증·세 제품 commit/push를 승인했다. PR 생성·merge·배포는 승인 범위가 아니다. 다음 미정 정책/새 기능을 자동 확장하지 않는다.
- Slack은 읽기 전용이며 자동 폴링은 중단 상태를 유지한다. 팀 공유 문서와 개인 작업 메모를 구분하고 의미 있는 마감에 개인 컨텍스트를 commit/push한다. 제품 commit/push는 해당 작업의 명시적 승인을 따른다.
