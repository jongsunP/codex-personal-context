# 2026-11-13 알림센터 제품 간 동작 누락 보완

## 요청과 원인

- 사용자가 실기기에서 기공소앱 설정 저장 중 깜박임을 제보하고 수정·양OS 검증·커밋푸시·Development CodePush를 승인했다. 이후 ‘알림 설정뿐 아니라 이번 개발자체’에서 같은 누락이 있으면 함께 조치하도록 범위를 넓혔다. 알림함·읽음·소속 전환·헤더·랜딩·OS 처리의 관련 구현을 비교하며, 이메일·별도 홈3건·밀링 전담 기능으로 확대하지 않는다. 기존 PR을 유지한다.
- 기존 기공소 코드의 `isSaving`이 전체 `disabled`에 합쳐져 모든 글자와 Switch 배경·손잡이 색상을 바꿨다. 저장 완료 후 색이 돌아오므로 화면이 깜박이는 경로가 있었다. 전체 remount나 스피너 삽입이 원인은 아니다.
- 앞선 검증은 기공소에 치과앱과 같은 스피너가 없다는 점만 확인하고, 저장 중 색상까지 대조하지 못했다. 당시 ‘기공소 추가 조치 불필요’는 불충분한 판단으로 정정한다. 사용자 QA가 기본적인 동작 검증을 대신하는 흐름으로 운영하지 않는다.

## 제품별 대조

| 대상 | 확인 결과 | 조치 |
| --- | --- | --- |
| Clinic/Lab 웹 `2484bd91a` | 저장 busy와 오류 disabled 분리. aria-busy/inert로 입력만 막고 기존 색상·위치 유지. 이전 최종 코드 성공·실패 검증 자료와 대조 | 추가 제품 코드 변경 없음 |
| Office 앱 `0b19ce6` 이후 | 상위/하위 색상 깜박임은 없음. 같은 저장 중 범위 선택만 눌려 선택이 무시되는 경로와 페이지 경계 중복 행 방어 누락 발견 | 범위 선택도 입력만 차단, Lab과 같은 ID별 중복 제거 |
| Lab 앱 `c31f311` 이후 | 저장 상태와 실제 오류·권한 disabled를 분리하여 상위/하위 입력만 막음. 기존 disabled 색상과 OS 권한 안내, 저장/실패 처리는 유지 | 알림설정의 화면·Settings·Group 3파일만 수정 |

- 독립 검토: Settings props의 Navigator 전달, 상위/하위 핸들러 및 접근성 차단, 오류·권한 표시 유지, 새 null/훅 순서 문제 없음. 공용 Switch·API·네이티브·분석 이벤트를 바꾸지 않는다.
- 웹 증거: `/tmp/web-settings-stable-failure-1113.json`의 Clinic/Lab `stable:true`, `/tmp/web-settings-stable-success-1113.json`의 Lab 저장/원복. 이 표현을 이번 웹 재배포 결과 조회나 새로운 웹 런타임 검증으로 확대하지 않는다.
- Office 근거: NotificationCenterScreen의 최초 조회 전용 isLoading, NotificationSettingSection의 input/visual 분리, 앞선 최종 코드 양OS 저장 중 위치/차단·성공/실패 증거. 변경 없는 제품은 불필요한 재수정·재배포를 하지 않는다.

## 설정 외 추가 대조

- Lab 다른 소속 목록: 일반 소속 전체를 그대로 쓰던 부분을 기존 미읽음 API의 양수 소속 중 실제 전환 가능한 다른 소속으로 맞춘다. 서버 순서·현재 소속 카드·활성 소속 재확인·기존 권한은 유지한다. ‘일반 선택은 전체, 알림 선택은 미읽음이 있는 소속’이라는 이미 확인된 요구사항이다.
- Lab 헤더 빨간 점: 현재 소속뿐 아니라 다른 소속 미읽음도 확인한다. 기존 다른 소속 API query를 헤더/알림함이 같은 캐시로 공유한다. Office와 동일한 기존 요구이며 OS 아이콘 배지 정책 변경이 아니다.
- Office 범위 버튼/시트: 저장·조회 중 입력과 접근성만 차단하며 색상·문구는 바꾸지 않는다. 페이지 중복은 처음 표시된 순서를 유지하고 동일 ID의 뒤 응답을 반영한다.
- 웹의 소속 전환 로딩과 Unread 목록 재조회는 기존 의도된 처리다. 실제 동작을 비교하지 않고 모든 로딩을 제거하지 않는다. 미읽음 수가 늦게 도착하는 초기 탭 선택은 별도 대조 중이다.
- 사용자 추가 요청으로 DL-17425 최신 본문·댓글·연결 명세를 기존 이벤트와 재대조했다. **새 이벤트 요청·기존 미구현 이벤트 없음.** 아래 근거에 따라 불필요한 이벤트 추가/명칭 변경은 하지 않는다.

## Amplitude 재확인

- Jira DL-17425 본문과 전체 댓글1개, 연결 Notion `405ce072e82f80d093a4c38fa643febe` 본문·전체 토론1개, 이벤트13개/property7개 상세를 재확인했다.
- Notion은 11/13 15:00:55 KST에 완료 상태로 변경됐으나 이벤트는 이전13종 그대로다. 상세의 마지막 수정은 최초 조사시점13:54KST 이전이며 새 이벤트/속성 요청이 없다.
- 실제 호출 경로: Clinic 웹11종·Lab 웹9종, Office 앱13종·Lab 앱11종. 웹 OS 안내 비대상, Lab 주문범위 UI 비대상 차이는 정상이다.
- 설정 변경은 성공 readback 뒤1회, 실패/동일값/중복/옛 소속 요청은 제외한다. 기존 사용자 승인에 따른 All/Unread 문자열, scope배열, enabled 값과 원문 `cilck` 철자 유지. 재대조는 코드/명세 증거이며 실제 Amplitude 서버 수집 확인으로 확대하지 않는다.
- 임시 상세: `/tmp/dl17425-analytics-recheck-1113.md`.

## API 재호출 추가 요청

- 사용자는 알림센터가 여러 페이지 헤더에 노출되므로 마운트·페이지 이동마다 불필요한 중복 요청이 있는지 웹·양앱 대조를 요청했다. 호출 최소화 자체가 목표는 아니며 최신성·권한·소속변경을 위한 합당한 재조회는 수용한다.
- 같은 product/user/employee/employer query key와 singleton QueryClient를 공유해 동시 동일 요청은 합쳐지고 단순 렌더링마다 요청하지 않는다. 앱의 유지된 탭은 매번 재마운트된다고 볼 수 없다.
- 웹 실제 SPA 경로 이동 재현: 최초/헤더 재마운트 때 unread·다른 소속 각1회, 닫힌 inbox/settings0회. 창 focus/visibility만 바꿀 때0회. 이 페이지 재조회는 실시간 동기화 없이 최신 미읽음을 확인하는 수단으로 유지한다.
- 앱의 헤더 캐시 차이는 현재 Office always/stale0, Lab current30초·other stale0다. 호출 수를 줄이기 위해 새 TTL을 임의 통일하지 않는다. AppState 복귀·읽음·푸시 읽음·저장 이후 갱신도 유지한다. Office 오류 재시도 최대4시도와 Lab retry false는 실패 재시도이며 무조건 중복과 구분한다.
- **확정 중복:** 양앱 설치 QueryCore5.83.1로 warm cache+mount 조회 진행 중 focus invalidate를 재현했다. 기본은 start2/abort1/complete1, `cancelRefetch:false`는 start1/abort0/complete1이다. cold cache는 둘 다1회, 신선한 캐시에서도 invalidate 시 새 조회1회로 최신화가 유지된다. 화면 focus의 invalidate 옵션만 보완하며 읽음/저장 후의 오래된 요청 취소는 그대로 둔다.
- **초기 감사 제안 정정:** Office settings GET은 알림함의 알림 범위 선택지·현재값에도 필요하므로 ‘아직 설정 화면을 안 열었다’는 이유로 제거하면 안 된다. Lab 설정 사전조회와 숨긴 inbox의 활성 상태는 현재 Navigator가 상위 데이터/화면을 함께 소유한 구조다. 활성 화면 분리와 초기 필터 결정 전 목록 지연은 구조·전환 검증이 필요한 선택적 최적화로 남기며, 이번에 새 인터페이스나 대규모 변경을 추가하지 않는다.
- query lifecycle 근거는 `/tmp/notification-app-api-lifecycle-1113.md`, 실제 라이브러리 재현 결과는 `/tmp/notification-focus-refetch-dentlink-{app,lab-app}-1113.json`. 정확한 전송 횟수를 본 경우와 코드상 발생 조건을 구분한다.

## 공통 지침 보완

- 사용자의 핵심은 단순히 제보된 앱 하나를 고치는 것이 아니라, 같은 요구사항을 구현한 제품들에서 정책/기술적 이유가 없는 차이는 동작과 구현 기준을 맞추는 것이다.
- `DEVELOPMENT_STYLE.md`의 Existing UI First에 동일 제품 흐름 대조, 일시적 busy와 실제 disabled 구분, 색상·opacity·로딩·위치·중복입력·실패복구의 전후 확인, 미확인 제품/OS를 완료로 처리하지 않는 규칙을 추가했다.
- 무조건 동일 파일 구조나 공용 추상화를 만들라는 뜻은 아니다. 필요한 제품별 차이는 보존하고 적절한 기존 구현을 따른다.
- Claude 메모리에도 같은 원칙을 기록한다. 개인 정본·로컬 Codex 지침 동기화는 작업 마감에 완료한다.

## 최종 검증·전달

- Web `b6cffe2f84b441d7e70270f36a84e38de5e6ed3a`: 최초 미읽음 지연 응답의 탭 보정과 open invalidate 중복 취소 방지. Clinic/Lab 각7조건(지연0/양수·수동 탭 유지·읽음 후 유지·재열기·소속 자동진입) 총14개 실제 화면 fixture 통과. 관련 hooks12/Clinic5/Lab4 tests·type·변경lint·정상 Git 훅 통과. 원격 동일·clean. **웹 재배포 없음.**
- Office `1eaa023df86748d9058ada35c0ce64f330e3c4f9`: 저장 중 범위 입력 차단, 알림 ID별 중복 제거, focus 중복 취소 방지. 동일 DEV 양OS에서 저장 대기·성공·실패 복구, 색상/위치, 중복페이지, 실제 주문 상세 WebView 랜딩·알림함 복귀 확인. 최종 옵션 추가 뒤 새 프로세스의 첫진입/설정/랜딩 왕복 재확인. 관련33 tests/lint/diff 통과, 전체tsc는 기존6진단.
- Lab `3a6624eb2a4c91dcbbea1fe9f14a4c0b49352fdc`: 저장 표시 유지 `ce08a9b`, 소속 목록/헤더 점 `45c06b7`, focus 중복 취소 방지 `3a6624e`. 양OS 저장 전/pending 전체 픽셀 차이0·입력 차단·성공/실패 복구·이벤트 성공1/실패0. 현재/다른소속 미읽음 조합과 가입/비소속/0/오류 목록 검증. 최종 양OS 첫진입/재진입 GET4종 각1시작·1완료·취소0, 내부 설정 왕복 추가조회0. lint/diff 통과, 전체tsc는 기존5진단.
- 최종 앱 LogBox0, 새 앱 crash/ANR 미관찰. 개발 중 Lab Fast Refresh의 hook 상태 충돌은 프로세스 재시작 뒤 재검증했고 최종 오류로 남지 않았다. 기존 OS Bluetooth crash는 앱 오류와 구분했다.
- 실제 GET을 기준으로 제어 응답·현재 렌더된 핸들러/CDP·native 화면/좌표를 사용했다. 물리 터치 전수나 실기기 FCM/APNs/실제 Amplitude 수집 완료가 아니다. 이번 추가 확인의 서버 설정·읽음 쓰기0·분석 외부송신0, 임시 함수/캐시/SDK 원복. Office/Lab 두OS를 각각 같은 소스/DEV로 함께 전환하고 기기 사용 순서를 나눴다.
- 자체 웹 서버/테스트 브라우저·앱/Metro만 정리하며 사용자 창은 유지한다. 기존 PR4862/346/42의 base/Draft 상태는 보존한다.
- Development CodePush는 아래 iOS 제보 조사 동안 잠시 보류했으며, 원인이 미확정이고 추가 푸시 코드를 바꾸지 않기로 해 **검증 완료한 기존 수정만 게시 완료**했다. Office iOS/Android **v146**(2.2.4, `1eaa023`), Lab iOS **v45**/Android **v44**(1.0.5, `3a6624e`). 모두 enabled/mandatory/100%, 직전 source가 조상이고 native/package/lock/assets/config 변경0, assetHash 동일. 제품·OS별 TMPDIR 격리·직렬 게시·활성 history1회 확인으로 종료했다. 실제 기기 적용을 추적하거나 이 iOS 제보의 해결 배포로 표현하지 않는다.
- 본인 하위 Jira17058/17059/17060에 각각45027/45028/45029로 결과·전달 여부 기록. 부모·다른 사람 카드·스토리포인트 미수정, 기존 개발완료 상태 유지. 원 PR 본문은 최종 기능·검증·전달 상태로 정돈하고 base/Draft/DRAFT/[WIP] 유지.
- 게시 증거 `/tmp/apps-dev-ux-api-delivery-1113.md`와 동명폴더 `publication-summary.json`. Office packageHash iOS `29c8960247c0ff9b7148af40c4aa2356e4007d948e5f6db860805264fe13e06c`, Android `18e034a8212ad4667cf3c9b62d91c9d313b64b6b700d1f13a04a33b86f798008`; Lab iOS `c401ebc709ea698e0bffac4176771fcd04caed7e6eb0d8cf6d891428f756bb29`, Android `0393d7df5cfe31a290c4e737c2fe1e2de8366ae5523cda38ed8754ac4da8fb40`.
- 사용자 확인은 Lab 저장 시 글자/토글 깜박임 없음, Office 저장 중 범위 입력 차단·복구, 기존 알림 진입/복귀 위주다. 새 iOS 제보는 아래와 같이 별도이며 이번 DEV 업데이트로 해결됐다고 하지 않는다.

## 사용자 iOS 푸시 제보 — 별도 조사, 코드 미수정

- 사용자는 Office `2.2.4.145`에서 앱을 켜면 상단 OS 알림이 표시된다고 했고, 확인 질문에 **푸시를 누른 것이 아니라 앱 아이콘으로 열었다**고 답했다. 알림 종류·실제 payload/수신 로그는 아직 없다.
- v145 소스 `0b19ce6`에 기존 iOS 탭 중복 방지 `fab7708`과 Notifee PRESS/initial messageId 기록 `d4de608`이 모두 포함된다. 현재 `1eaa023`과 v145의 FCM/Notifee/native 차이는0이다. 최근 Android 네이티브 심사와 분리한다.
- 기존 방어는 탭 이벤트에서 기록한 동일 messageId에 한정된다. 일반 아이콘 실행 후 지연 onMessage, ID 없음/불일치, active 상태에서 onMessage가 탭 기록보다 먼저 오는 순서는 해당 방어 밖이다. 앱 실행만으로 과거 알림을 재생하는 일반 FCM 코드는 없으며 수신 콜백이 있어야 로컬 Notifee 배너가 생성된다.
- 임시 진단에서 AppState active만 바꾸면 표시0, 아이콘 실행 후 과거 메시지를 onMessage로 전달하면1, 동일ID를 재전달하면2회를 확인했다. 기존8건+추가6건·기존 FCM/Notifee18개를 통과했으나 실제 네이티브/FCM이 왜 해당 이벤트를 전달했는지는 아직 미확정이다.
- `getDisplayedNotifications()`의 remote.messageId 대조는 후보이며 이미 삭제된 알림·타이밍 경쟁·실제 본 여부를 모두 해결하지 않는다. sentTime/AppState만으로 정상 지연 알림까지 무조건 숨기거나 새 심사/네이티브 작업을 임의 추가하지 않았다.
- 다음 실제 수신 검증에서 messageId·sentTime·수신경로·기존 OS 표시 여부를 구분해야 한다. 기존 실푸시 발송 제외를 유지해 이번에는 발송/실기기 재현을 실행하지 않았다. 상세 `/tmp/notification-push-replay-1113.md`.

## 운영 지침·다음 시작점

- 사용자의 제품 간 같은 동작 정합성 원칙을 공통 DEVELOPMENT_STYLE/Claude 메모리에 기록. 한 제품만 확인하고 다른 제품도 완료로 간주하지 않는다. 기능 차이가 없는 동작을 맞추되 기존 제품별 정책·권한과 확인된 디자인 차이는 보존한다.
- 메인에서 전달된 11/13 브라우저 지침 aa3f90f/065061d와 교체 AGENTS를 확인했다. 일반 조사/자동화는 연결 도구·인앱/비표시 우선, CfT는 격리 기준, 반복 visible launch/close 금지. 관련 하위 에이전트에도 전달했고 별도 브라우저 시험·메인 회신·감시는 하지 않았다.
- 다음 요청에서 웹 미배포 `b6cffe2f8`와 앱 위 Development 상태를 구분한다. 새 iOS 앱 아이콘 배너 제보의 실제 수신 메타를 확보할지 결정한다. BE 노출키44994·발송 적용45009, 실기기/실푸시 체크리스트와 본체외 경계는 종전 그대로이며 반복 문의/폴링하지 않는다.
