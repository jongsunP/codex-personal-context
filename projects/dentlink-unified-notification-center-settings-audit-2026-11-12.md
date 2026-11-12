# 통합알림센터 — 실제 설정 저장 및 기존 리뷰 확장 감사 (2026-11-12)

## 요청과 범위

- 사용자는 웹·Office·Lab의 실제 설정 API 응답과 화면을 대조하고, FE에서 가능한 보완은 검증·commit/push한 뒤 메모리하고 대기하도록 요청했다. **이번 후속 작업은 배포하지 않는다.** 기존 PR과 앞선 DEV 전달은 유지한다.
- 마지막 보완 의도: 이전 리뷰에 기본 규약·크래시 방어 누락이 있었다면, 리뷰에 안 나온 곳에도 같은 문제가 있을 수 있다. 새 리뷰만 또는 resolved 여부만 확인하지 않고 **이번 기능 전체 diff의 같은 유형 누락**을 점검한다.
- Web61/Office95/Lab63개 변경 파일을 기능군으로 분류했다. 생성 API의 모든 무관한 endpoint나 전체 제품 QA를 전수 완료했다는 뜻이 아니다. 관련 최종 코드 증거를 재사용하고 새 위험/수정만 추가 검증한다.
- Slack·Figma·Jira는 근거 조회만 했다. BE/PM 질문은 사용자가 이미 보낸 것과 새 필수 질문을 구분한다.

## 실제 응답과 표시·저장 판단

근거: [DL-17114 BE44978](https://innovaid.atlassian.net/browse/DL-17114?focusedCommentId=44978), [사용자44994](https://innovaid.atlassian.net/browse/DL-17114?focusedCommentId=44994), 이번 DEV Swagger `/v3/api-docs`, 실제 GET/PUT 및 화면.

| 항목 | 확인 결과 | 이번 조치 / 다음 경계 |
| --- | --- | --- |
| 노출 기준 | `toggleChannel`은 부모 토글이 제어할 채널이다. 웹/앱 노출 플랫폼 정보가 아니다. 현재 Swagger와 실제 응답에는 별도 플랫폼 키가 없다. | 웹 PUSH 부모 숨김은 기존 임시 호환 처리로 유지. 실제 현재 PUSH 부모는 LinkTalk/Support 단독 토글이라 MAIL 동반 손실은 없었다. 미래 PUSH+MAIL 행까지 안전하다는 뜻은 아니다. 이미 문의한44994 답변 후 명시적 노출 키로 교체한다. |
| 단독 토글 | `channels: []`는 자식 체크 없이 부모 `enabled`만 저장하는 행이다. | 임의 PUSH 자식을 만들지 않고 받은 빈 배열을 유지. 키 생략도 허용하되 PUT에서 그대로 생략; `null`은 불완전 응답으로 거절. |
| 상위 OFF와 실제 발송 | PRD의 정책은 상위 OFF 시 해당 항목의 모든 채널 수신 중단이다. 최신 DTO는 상위 `enabled:false`와 하위 선택값 보존을 허용하며 BE 예시도 OFF 부모 아래 PUSH=true다. | FE는 상위 OFF를 실제 PUT한다. 다만 BE가 상위 OFF를 하위 발송에도 적용하는지는 화면/GET/PUT 검증으로 알 수 없다. 하위 값 보존이 전체 발송 차단까지 검증됐다는 뜻은 아니다. 아래 후속 확인을 따른다. |
| 표시 순서·글자 | user 영역 먼저, 영역 내 categories/channels는 서버 순서. FE는 확정된 표시명만 매핑한다. | 사용자/병원 Credits를 각각 표시하고 미래 정책을 가정해 숨기지 않았다. 기존 generic settingCategories fallback도 유지. |
| 전체 PUT | 생략된 카테고리는 기본 ON으로 초기화될 수 있는 전체 교체 계약이다. | 최신 전체 GET에서 선택한 값만 바꾸고 숨긴 항목·OFF 부모의 채널 값·다른 영역을 보존. domain/toggleChannel/orderScopeOptions는 전송하지 않는다. |
| 불완전 응답 | categories 목록·행·중첩 채널의 null/잘못된 값은 화면 크래시 또는 불완전 PUT의 원인이 된다. | 기존 서비스 방어와 실패/Retry 경로 확인. 빈 배열과 누락/손상은 구분. |
| 주문 범위·권한 | Lab scope=null/options=[]·user.categories=[] 실제 확인. Office OWNER 현재 화면 대조. MEMBER 서버 제한은 기존 계약/테스트와 재대조했다. | 이번 실제 쓰기는 대표 OWNER 계정으로 수행. 모든 역할 실계정 QA를 이번에 새로 끝냈다고 하지 않는다. |
| OS 권한 | OS 권한은 서버 수신 설정과 별도. NOTIFICATION 부모는 OS 권한과 무관, PUSH 부모/자식만 안내 대상. | OS 차단에서 조작 시 서버 값을 임의 저장하지 않는 기존 흐름을 유지. 과거 OS→구 설정 API 자동 upsert가 제거됐는지 재대조. |
| 동시 저장 | FE의 직렬 저장·계정/소속 가드·저장 후 GET 확인이 있다. | 여러 기기의 동시 전체 PUT을 서버 원자성까지 보장하지는 않는다. 이를 임의 새 API 요구나 실시간 동기화 구현으로 확대하지 않는다. |

## 실제 화면·서버 저장 검증

- **검증 환경:** 웹은 정확한 feature checkout의 localhost3000/3005 화면을 DEV 실제 API에 연결했다. 운영/배포 서버 화면 자체를 확인한 것으로 표현하지 않는다. 앱은 기존 DEV Debug 설치 위 해당 feature Metro를 양OS에 연결했다.
- **Clinic 웹:** 실제 DEV 응답과 화면 대조 → 부모 ON→OFF→ON, PUT 성공 후 GET 확인. OFF에서 Email UI가 접혀도 저장된 자식값 유지. 마지막 전체 GET이 시작 값과 정확히 같음을 확인했다.
- **Lab 웹:** 실제 DEV 응답과 화면 대조 → Design Confirmation ON→OFF→ON. 숨긴 LinkTalk/Support/PUSH·행 순서·자식값 보존, null orderScope 미전송 확인. 전체 GET 원복 확인, 웹 두 서비스 pageerror0.
- **Office 앱:** 같은 소스의 양OS. iOS Design Confirmation Email OFF 실제 저장 → Android REST 새 조회에서 OFF 확인 → Android ON 저장으로 원복. 마지막 전체 응답이 시작 값과 같고 다른 설정은 변하지 않았다.
- Office 단독 PUSH의 OS차단 안내는 제어된 상태를 주입해 팝업 및 PUT0을 확인했다. 실제 iOS 시스템 권한 전환 검증이라고 표현하지 않는다. 모든 임시 wrapper는 원복했다.
- **Lab 앱:** Android 실제 OS granted에서 단독 Support PUSH ON→OFF→ON, iOS 실제 OS denied에서 Design Confirmation NOTIFICATION ON→OFF→ON. 실제 PUT4회와 확인 GET, 전체 응답 정확 원복. user0/employee5, null scope와 readonly 메타 제외, OFF 중 자식 PUSH 값 보존 확인. 화면 조작은 rendered handler/CDP 및 캡처를 사용했으며 물리 탭 전수 QA라고 하지 않는다.
- 실제 PUT 뒤 GET이 잠깐 이전 값을 반환한 웹 사례에서도 기존 유한 readback(최대4회)이 확인 후 상태를 표시했다. 주기적 polling을 추가하지 않았다.
- 설정 쓰기는 같은 계정의 웹/앱 간 순서를 조율해 실행했으며, 테스트 결과를 남긴 뒤 전체 설정을 원복했다. 인증정보·토큰·응답의 개인정보는 이 문서에 저장하지 않는다.

## 기존 리뷰와 지적 밖의 유사 문제

| 위험 유형 / 기존 지적 | 확장 확인 위치 | 결과 |
| --- | --- | --- |
| null 배열 원소로 앱 렌더 크래시 | 알림 서비스/시트뿐 아니라 Office 추가 Credit·Statements 서비스와 FlatList | **새 누락 발견.** 두 금융 목록은 배열 여부만 검사해 `[null]`을 통과시켰다. item.id/status 접근 전에 서비스가 거절하도록 최소 보완하고 기존 Retry 경로로 보낸다. 수정 전 서비스가 `[null]`을 통과시키는 회귀 재현 실패를 확인했다. 수정은 정상/빈 배열을 유지하고 손상된 페이지를 오류로 처리한다. 별도 에이전트 읽기 전용 검토에서도 권한·query key·scope·페이지 계산·Retry 동작의 변경이 없음을 확인했다. 최종 기기 결과는 아래 기록. |
| 임의 UI 문구 | 알림/설정/추가 금융 화면의 신규 문구, 공통 오류 처리 | 금융 전용 `Unable to load ...` 설명은 별도 승인 근거 없이 중복 추가돼 제거하고 기존 Retry 유지. 빈 알림 helper는 아래 Figma 원문에서 확인했으므로 유지. |
| 생성 모델/스타일/파일 구조 | 앱 models·신규 화면, 웹 models/UI 경계·테스트 파일 | 앱 생성 전용 models·styled 규칙과 이미 처리한 리뷰 반영 재확인. 웹 새 테스트563줄은500줄 지침에 맞게 의미 단위 분리(테스트 동작/개수 유지). |
| 데이터 유실·숨김값 | 3제품 settings GET→mapper→전체 PUT→readback·scope guard | 현재 API의 숨긴 값/자식값을 보존하는 실제 저장 확인. 플랫폼 키만 미정. |
| 공유 인증·병원 전환·네비게이션 | fetcher/axiosInstance, PermissionProvider, RootNavigator, EmployeeProfile, URL parser/FCM, 공용 Popup | 기존 인자의 기본 동작과 선택적 가드, stale account/scope 방어를 재대조. 앞선 최종 양OS Home/Orders/LinkTalk/Profile/Support/상세Back 증거 재사용. |
| 읽음 큐 실패가 랜딩 차단 | FCM callback→queuePushNotificationRead→저장소 전체 호출 경계 | 단편 코드만 보면 의심할 수 있으나 Office 호출부 catch·Lab 큐 내부 catch가 이미 있다. Lab 실제 큐의 rehydrate/get/set 실패3건을 임시 시험해 Android Linking 계속됨 확인. **확인된 버그가 아니므로 중복 catch를 넣지 않았다.** |
| All 읽음 후 페이지/스크롤 | 웹 useNotificationCenter 및 회귀 테스트 | All은 invalidate, Unread만 reset하는 기존 리뷰 수정 유지. |
| generated Swagger의 공용 소비자 | 웹 밀링 wire/FILE 및 앱 기존 소비처 | FILE 구현은 별도 PR4866/release1.93에 있고 현재1.94 대상에는 아직 없다. DL17420 통합 대기로 유지; 중복 구현/임의 릴리즈 병합/허위 resolve 없음. |

### 리뷰 상태의 정확한 의미

- Web4862 기존7thread를 현재 코드와 대조했다. 설정/표시명/읽음 등6건 resolved 근거 유지. **밀링 FILE `PRRT_kwDOJnA7-862hGtQ` 1건은 별도 통합 미완으로 열려 있다.** 선택적 주석 커버리지 경고는 사용자 보류를 유지한다.
- Office346 inline thread0, Draft로 bot검토 미실행 안내가 있다. 이를 CodeRabbit 승인으로 표현하지 않는다.
- Lab42 개발자3건(생성모델·styled·nested null)은 해결 반영을 다시 확인했다. 공용 로직의 기존 기능 QA 요청은 위 영향 범위 검증과 연결한다. resolved가 기능 전체 승인이라는 뜻은 아니다.

### 빈 목록 문구의 확인된 디자인 근거

- Clinic 앱 [29:11711](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=29-11711): `No notifications` / `New notifications will appear here.` — text29:12097/12098.
- 웹 [48:11209](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=48-11209): 동일 문구 — text29:13148/13149.
- Lab 앱 [138:21126](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=138-21126): `새로운 알림이 없습니다.` 단독 — text138:21138.
- 이번에 실제 design context와 screenshot을 확인했다. 이전 검토 문서의 '빈 목록 helper 출처 미확인'은 이 결과로 해소한다. 디자인 원본은 변경하지 않았다.

## 남은 확인과 다음 시작점

1. **BE에 새로 중복 문의할 필요 없음:** DL17114 사용자44994의 노출 플랫폼 키 답변 대기. 답변이 오면 현재 PUSH 추론을 명시적 키로 교체하고 세 제품의 표시/전체 저장을 확인한다.
2. 기존 Office GET/PATCH push-preferences 사용 경고는 유효하다. 담당 주문 필터 호출이 남아 있어 새 설정 API가 나왔다고 BE가 일괄 삭제하면 안 된다.
3. 실제 FCM/APNs 수신·cold start·최종 바이너리/실기기 QA, 웹 FILE 릴리즈 통합은 별도 증거가 필요하다. 이번 실 설정 저장이 전체 푸시 QA를 대신하지 않는다.
4. 이메일/SES, 배지 개선, Home3, 별도 Android native/스토어, 선택적 주석 커버리지는 기존 범위 밖/보류로 유지한다.
5. 다음 사용자 재개 때 이 감사 결과와 위 남은 일부터 보고한다. 이번 수정은 commit/push까지만 하며 **앞서 배포한 DEV/CodePush가 이번 후속 수정까지 포함하지는 않는다.**

## 최종 검증 / Git 기록

- Office `feature/DL-17059@94334d2a5bf06659d4d470288086945f0a69e591`: 금융 서비스2개 null 행 방어, Credit/Statements 임의 오류 설명 제거(기존 Retry 유지), 최소 서비스 회귀 테스트. 원격 동일·clean 확인. 양OS 실제 DEV 목록→HTTP 경계 null 행 제어 주입→서비스 거절/Retry→원래 API 복원·실제 Retry→정상 목록 재조회 통과. 임시 검증 함수 모두 복구 후 Home 복귀, 마지막 Android crash buffer 비어 있음. 기존 v143 이후 수정이므로 배포에는 미포함. 최종3 suites/11 tests(신규 null 회귀2건 포함)·lint·diff-check 통과, tsc는 기존6진단 그대로이며 통과로 표현하지 않는다.

- Web `feature/DL-17058@2a65e8eec98db04ed34e2b83fb5d6da5ff5fea9d`: 테스트2파일만 정리·push. 설정8/읽음4(기존12) 통과, Clinic/Lab/Admin type 및 정상 Git 훅의 lint/Admin guard/shared coverage 통과. E2E는 사용자 명시 제외에 따라 정식 SKIPPED 기록. 원격동일·clean.
- Lab `feature/DL-17060@d018b85530ca0fd698e372948b5cbf72e3c826e7`: 이번 추가 코드 변경 없음·원격동일·clean. 기존 설정/서비스12건, 임시 FCM 검증11건(기존8+오류경계3) 통과. 양OS 최종 queryErrors/LogBox/Android crash buffer에 오류 없음. iOS 실기기 OS 전환·실제 발송은 별도.
- 웹 push 뒤 PR4862 단회 재확인: OPEN/Draft 유지, guard SUCCESS, 기존7thread 중 별도 FILE1건만 unresolved. 새 bot검토가 이번 테스트 분리 SHA까지 완료됐다고 표현하지 않는다.
- 기존 리뷰는 실제 코드와 재대조했으며, 해결 표시만 보고 승인으로 판단하지 않았다. 이번 task의 결과를 전체 제품 무결성 보증으로 확대하지 않는다.
- 임시 자세한 근거: `/tmp/web-1112-settings-audit.md`, `/tmp/lab-1112-settings-audit.md`, `/tmp/office-1112-settings-audit.md`. `/tmp`는 영구 기록이 아니므로 핵심 결과는 본 문서에 보존한다.

- 공통 지침 `DEVELOPMENT_STYLE.md` Feedback And Completion에 기본 규약·크래시 방어 누락 리뷰를 계기로 같은 위험 유형을 기능 전체/다른 제품/공용 소비자로 넓혀 확인하고, resolved 표시 대신 실제 근거를 남기는 원칙을 보완했다. 기존 관련 최종 증거는 재사용하며 무관한 전제품 QA까지 확대하지 않는다.

- 실행 정리: 이번 Clinic/Lab 웹 서버·테스트 브라우저, Office/Lab Metro8081/8082 및 해당 검증 앱 프로세스를 종료했다. 사용자 기존 창·기기 배치를 변경하거나 디바이스 자체를 임의 종료하지 않았다. 자동 감시/새 예약 없음.

## 이후 Slack 질문 확인 — 구 조회 필터 API 교체

[Leo 댓글1794488063.213869](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794488063213869)(11/12 21:54): 구 GET/PATCH push-preferences 데이터는 이제 사용하지 않으므로 새 API로 교체 가능한지와 화면 정책을 질문. 사용자는21:55 확인하겠다고 답했다. 이 메시지는 구현 승인으로 취급하지 않고 답변 초안만 제공한다.

- 현재 새 알림 설정 화면은 이미 GET/PUT `/office/notifications/settings`를 사용한다. 남은 구 API 소비는 **주문목록·LinkTalk 조회 필터**, LinkTalk 미읽음 집계/하단 탭 배지/채팅 복귀 캐시다.
- **앞선 조사 표현 정정:** Home 주문 목록 자체는 `useHomeOrdersData.ts`의 `myOrderOnly:false` 고정이다. '홈 필터가 구 API 사용 중'이라고 하지 않는다. 하단 LinkTalk 배지의 간접 소비와 구분한다.
- MEMBER는 주문목록 토글 숨김·조회 파라미터 생략, LinkTalk는 내 주문 고정. 새 알림 orderScope는 서버가 MY_ORDERS_ONLY 고정한다. 비 MEMBER는 목록 필터 선택 가능.
- 단순히 새 employee.orderScope로 치환하면 조회 필터를 전체로 바꿀 때 알림 수신 범위도 전체가 되고, 반대 변경도 조회/LinkTalk 숫자에 영향을 준다. 기술적 연결은 가능하나 **조회 필터와 수신 범위를 같은 설정으로 연동할지** 확인이 필요하다. 로컬로 분리한다면 기존 서버 저장 특성을 잃을 수 있으므로 이번 답변 요청만으로 바꾸지 않는다.
- 기존 API 제거는 FE 이관/배포 전 일괄 승인하지 않는다. 제품 코드·Slack 작성·배포 변경 없음.

## 후속 사용자 결정과 상위 OFF 의미 확인

- 위 Slack 질문 당시의 '조회 필터와 알림 수신 범위 연동 여부 미정'은 이후 사용자 결정으로 해소됐다. **알림 수신 설정은 새 서버 API, 주문목록·LinkTalk 조회 필터는 기존 기기 내부 저장소로 분리**한다. 기기 간 값 차이와 기존 값 초기화는 허용하며 이관·동기화를 만들지 않는다. 권한 제한은 유지한다. 사용자에게 코드 수정·검증·commit/push 권한을 받았으며 **배포는 금지**다. 완료 코드와 검증은 체크포인트의 최신 기록을 따른다.
- `channels: []`는 BE44978에 명시된 정상적인 단독 토글이다. 예: `LinkTalk App Push [ON/OFF]` 한 줄. UI 깨짐을 허용하거나 FE가 하위 PUSH를 만들어 보정하는 것이 아니다. 이 사유로 BE 추가 작업을 요청하지 않는다.
- 웹·앱 노출 구분 키는 사용자44994로 이미 요청했으며 여전히 답변 대기다. 중복 질문하지 않는다.
- '숨긴 값 보존'을 두 경우로 구분한다: **다른 카테고리·영역/웹에 미노출된 설정 보존**, **상위 OFF 항목의 하위 선택값 보존**. 앞의 범위를 임의로 바꾸지 않는 것은 유지한다. 뒤의 저장값 보존은 실제 수신 중단과 별개다.
- PRD(최종 수정11/11)의 화면별 변경·8-3·8-5에는 상위 OFF 시 전 채널 미발송·인박스 미적재가 남아 있다. 생성 DTO의 '꺼도 channels 값은 보존'과 함께 성립하려면 BE가 상위 OFF를 전체 발송 차단에 적용해야 한다. **현재 서버 발송 로직은 확인하지 않았다.**
- BE에 필요한 확인은 한 가지다: **`enabled:false`이고 하위 PUSH·MAIL 값이 true여도 해당 항목의 모든 채널 발송이 중단되는가?** 그렇다면 하위 선택값 보존과 정책이 양립한다. 아니라면 실제 수신 정책과 충돌하므로 BE 답변 후 맞춘다. 이번 조회 필터 분리 작업에 섞어 임의로 하위 값을 일괄 false/true로 바꾸지 않는다.
- 과거 체크포인트의 'OFF면 하위 OFF, 다시 ON이면 하위 기본 ON'을 현재 저장값 변경 규칙으로 재사용하지 않는다. PRD의 재활성화 복원 방식은 미정이며 최신 API는 하위 값 보존을 명시한다. 전체 발송 중단 정책까지 폐기된 것으로 해석하지 않는다.

## 승인된 로컬 조회 필터 분리 완료 — 23시대

- **Office:** 기존 `feature/DL-17059`에서 `94334d2a` → **`9d3b54ecf5a49e2339def991e9d46f9f280c0895`**, 원격 일치·clean. 기존 PR346 OPEN/Draft→main 유지, merge/CodePush 없음. 구 API의 생성 선언은 손대지 않았다.
- `usePersonalOrdersPreference`는 기존 `useOrderStore`의 local bool/setter만 사용한다. 실제 사용되지 않는 옛 Profile 설정 화면·hook·helper와 해당4 API/query wrapper를 정리했다. 디바이스 토큰/배지/login API는 유지한다. Web 및 Lab 현행 소스에서 구 GET/PATCH 활성 호출은 없어 이번 코드 변경은 Office뿐이다. Lab의 미사용 구 선언/체인이나 과거 배포본까지 제거됐다는 뜻은 아니다.
- 계정/소속 경계는 해당 bool만 초기화한다. 공용 logout(빠른 계정 전환 포함), 토큰 만료, 성공·유효한 소속 활성화가 대상이며 실패/오래된 활성화는 값을 바꾸지 않는다. 기존 일반 로그아웃/소속 전환의 전체 필터 초기화는 그대로다. AsyncStorage의 늦은 복원이 사용자의 새 선택/초기화를 덮지 않도록 방어했다.
- **독립 diff 검토:** 정리 중 구 API와 무관한 `ApiResponseVoid` generic이 제거된 부분은 발견 즉시 복구 후 최종 검증했다. 빠른 계정 전환의 공용 logout이 일반 signout을 우회하는 점도 보완했다. 새 알림 설정 orderScope에 목록 필터를 연결하지 않았다.
- **정적:** 6 suites/29 tests 통과(로컬 저장/늦은 복원/직접 logout, 목록·LinkTalk query scope, 소속 성공/실패, OrderSearchForm, 토큰 만료, error handler). 변경 lint 오류0·기존warning9, diff-check 통과. tsc는 기준94334d2a와 같은6진단(Icon2·Tooltip1·MessageText1·useOrderAddProduct2)으로 통과라고 표현하지 않는다.
- **최종 런타임:** Office DEV iOS2.2.4(151)/Android2.2.4(134), 동일 feature/Metro8081. 실제 OWNER에서 Orders false→true, Orders/LinkTalk/미읽음 요청의 true 반영·양OS 강제종료 후 재실행 시 true 보존 확인. 서버 알림 orderScope는 MY_ORDERS_ONLY이면서 local은 처음false였고, 필터 조작 전후 실제 알림 설정 GET 전체가 동일했다.
- **권한 검증 경계:** MEMBER는 서비스 응답을 일시적으로 제한한 제어 검증이며 서버 권한 변경/실제 MEMBER 계정 검증이 아니다. 양OS Orders/LinkTalk 토글 숨김·LinkTalk 내 주문 강제·Orders 파라미터 생략 확인. 최종 실제 OWNER/로컬false/원래 service 함수로 원복하고 알림 설정 정상 화면을 확인했다. Home은 기존false 유지.
- **요청/오류:** 모니터한 흐름에서 구 API0·알림 설정 PUT/PATCH0, 서버 설정 변경 없음. Android crash buffer 비어 있음, Metro 오류 없음, 최근 Office iOS crash report 없음. LogBox accessor는 사용할 수 없어 'LogBox 전체 비어 있음'이라고 하지 않는다. 렌더된 React handler/CDP와 실제 기기 캡처로 확인했으며 물리 탭 전수 QA는 아니다.
- 이번 검증용 Office 프로세스와 Metro8081만 종료했다. 기기 자체·기존 사용자 창·Reactotron은 유지했다. 상세 임시 근거 `/tmp/office-local-order-filter-1112.md`의 핵심은 본 문서에 보존했다.
- **미배포:** 앞선 Office DEV v143에는 이번 로컬 분리와94334d2a 금융 보완이 없다. 구 앱의 호출 가능성이 남으므로 서버 API 삭제 시점은 배포 범위와 별개로 확인한다. 사용자는 이번 코드 수정·commit/push까지만 승인했다.
