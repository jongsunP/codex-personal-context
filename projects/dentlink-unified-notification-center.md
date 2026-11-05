# Dentlink 통합알림센터 — 현재 체크포인트

최종 구현: **2026-11-05 — Lab 알림센터 실제 소속 조회·전환 연결**을 기존 API로 구현·검증·commit/push했다. Lab `c6debf246b2a40443a203bbec1c55d6a1266dc29` (`feature/DL-17060`). 실제 소속 목록·활성화를 연결하고 새 소속 알림함을 한 번 복원하며, 가짜 소속 목록은 제거했다. **소속별 미읽음 집계는 추정하지 않고 미제공**이다. 양 OS 실제 단일소속 및 합성 다중소속 검증을 구분했고 실제 다중소속 서버 전환은 테스트 계정 한계로 남는다. PR·배포·최종 QA 단계는 아니다.

직전 구현: **2026-11-05 — Figma399:23417의 Unread 숫자 표시를 Web·Office·Lab에 반영**했다. Web `eb609ddd7`, Office `09a777a`, Lab `91534d2`. All 숫자 없음·Unread 양수만 빨간 배지·0미노출이며, 실제 서버 저장/미읽음 집계는 여전히 명세 대기다. 사용자 확인용 화면 실행은 이후 보류됐고 Cursor 전환을 더 요청하지 않는다. 변경 검증·마감은 아래 Figma 후속 절을 따른다.

상황 점검: **2026-11-05** — BE 설계 변경 없음·Swagger 미배포를 전달받고, 세 제품 코드/Git·Jira·DEV Swagger·정책서 반환 범위를 읽기 전용으로 재대조했다. **Lab 알림센터의 실제 소속 조회·전환은 기존 API로 더 진행할 수 있는 제한적인 FE 잔여 작업**으로 확인했으며, 관련 전부를 BE 대기로 묶던 표현을 정정한다. 이 브레이크포인트 조사와 이후 사용자가 요청한 Figma 구현은 구분한다.

직전 구현 마감: 2026-11-04 — **확정된 알림센터 범위에 맞춰 이메일 작업에서 남은 Android 브라우저 모듈 의존을 양 앱에서 정리**했다. Office `cefac786`, Lab `b92207c`이며 모듈 없는 Android 빌드·양 OS 영향 경로 검증을 완료했다. 누적 네이티브/라이브러리 변경은 없다. 앞선 Credits Email·Lab 밀링 결제 제외도 유지한다. 새 BE 계약·USER 정책/와이어프레임은 계속 대기이며 PR·merge·배포·최종 QA 완료가 아니다.

이전 구현 마감: 2026-11-03 19:19 KST — **Office/Lab 설정 파란 OS 배너의 기기별 1회 영속 처리** 보완·검증·양 앱 commit/push 완료. 이후11/4 범위 정리에서도 배너·인증·OS 권한·실제 서버 수신 설정은 변경하지 않았다.

- **현재 지시:** 허용된 Lab 실제 소속 조회·전환과 후속 Figma 최신 알림·멘션 점검을 완료했다. 확인한 최신 디자인은 이미 반영되어 추가 제품 수정 없이 개인 정본 정리 후 대기한다. PR은 만들지 않는다. 사용자 확인용 실행은 보류 상태이며 검증용 기기·Lab Metro도 종료했다. 미읽음 집계·새 BE 계약·USER 정책을 추측하거나 별도 구현/폴링으로 확장하지 않는다.
- **직전 사용자 확인:** 11/4 사용자가 “요구사항 변경으로 불필요하게 남은 코드를 정상 개발 범위대로 정리한 결과, 추가 심사가 필요한 변경이 없는 것”으로 이해·확인했다. 사용자가 직접 이 결론을 전달할 예정이며 게시 완료로 기록하지 않는다. 제품 커밋·푸시/검증과 로컬 종료는 완료 상태로 유지한다. 당시 ‘즉시 추가할 FE 구현 없음’은 아래11/5 Lab 소속 연결 조사로 보완하며, 조사한 것을 구현 완료로 바꾸지 않는다.
- **추가 자료 확인 — 2026-11-04:** Jira 댓글44798의 설정 템플릿 초안을 현재 세 제품 코드와 대조했고, 후속44802에서 Lab 밀링 결제 제외를 확인했다. 템플릿 초안 자체는 공개 API·BE 배포 완료 근거가 아니다. 후속 구현은 아래 제외 항목 반영에 한정한다.
- **상태 읽는 순서:** 이 문서의 최신 상태 → [앱 화면별 실행 근거](dentlink-unified-notification-center-runtime-2026-11-03.md) → 필요할 때 [11/3 단계별 구현·검증 이력](archive/dentlink-unified-notification-center-2026-11-03-worklog.md). 과거 HEAD/입력 대기/서버 유지 문구를 현재로 재사용하지 않는다.
- **기획 근거:** Notion 정책서와 확인한 Figma/Slack을 대조하되 최신 명시적 사용자 정정을 우선한다. 오늘 필요한 PRD 5-2~5-5/#14는 재대조했고 일부 조회 누락 블록이 있어 전체 본문·댓글을 완전 최신 조회했다고 주장하지 않는다. 이번 마감은 외부 자료 전수 재조사가 아니다.

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
- **PM 후속 자료:** USER 단위 Promotion(SMS/MAIL), Benefits > Credit(PUSH/MAIL)의 정책·와이어프레임과 기존 Employee 설정의 관계를 기다린다. 이미 확정한 기본 알림함 디자인/파란배너1회/추가목록의 웹모바일 디자인/별도메뉴 후속을 다시 질문하지 않는다.
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

2026-11-05 후속 구현: 기존 checkout/branch/worktree에서 Unread 숫자 표시를 추가했다. 앞선 Lab 밀링 결제 제외·Clinic Credits Email·이메일 잔존 native 정리는 유지한다. 검증·원격·로컬 실행 상태는 각 날짜의 최신 마감 기록을 따른다.

| 제품 | checkout | branch / upstream | 원격 반영 HEAD |
| --- | --- | --- | --- |
| Web | `/Users/parkjongsun/Repository/dentlink-client-notification-center` | `feature/DL-17058` / `origin/feature/DL-17058` | `eb609ddd72b4e9f618ae0585aabcee979136c9d4` |
| Office | `/Users/parkjongsun/Repository/dentlink-app` | `feature/DL-17059` / `origin/feature/DL-17059` | `09a777ad92b8c356e71db0877aef1678f45fdb55` |
| Lab | `/Users/parkjongsun/Repository/dentlink-lab-app` | `feature/DL-17060` / `origin/feature/DL-17060` | `91534d29e703de3edabee563f08f8c7671143f80` |

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
| 1 | Lab 실제 소속 조회·전환 연결 | 11/5 확인한 기존 API·전환 로직 재사용 가능. 미읽음 조건/숫자는 별도 계약 대기, 실제 다중소속 검증 필요. 오늘은 조사만 수행 |
| 2 | 새 BE 명세와 기존 구현 대조 | 목록/페이지·필터, 소속별 미읽음, Employee catalog/default/migration/설정 저장, 푸시 식별·클릭/읽음 계약을 확인. 새 API/notificationId 필수를 먼저 요구하지 않음 |
| 3 | 실제 데이터 연결 및 mock 제거 | 제공된 계약 범위부터 연결, 대체된 mock만 정확히 삭제. 소속별 미읽음 포함. 숨긴 채널을 임의 덮어쓰지 않음 |
| 4 | OS와 기존 서버 preference 이관 | PermissionProvider의 OS 허용→legacy upsert와 Office My Orders의 pushEnable 결합을 새 저장 계약에 맞춰 분리. 구 production 설정 초기화를 계약 없이 통째 제거하지 않음 |
| 5 | 푸시 읽음/클릭·실역할 실행 검증 | 현재 로그인·해당 소속 준비와 identity를 검증한 뒤 REST 연결. 실제 FCM 수신·중복/동일화면의다른알림, 실패/삭제, 실제 역할/OS/기기 조건 검증 후 사용자 QA |
| 6 | PR/release | 실제 연결 후 새 UI의 DEV 제한 해제·운영 진입 전환. 구현·에이전트 실행 검증·사용자 QA를 구분. 현재 PR 생성/merge/배포 지시는 없으며 자동 진행하지 않음 |

- **병행 확인:** 기존 Office Support의 현재 BE 조회 계약과 필요한 실제 역할/데이터를 확보하면 해당 미검증을 해소할 수 있다. 메일 CTA/SES·추가 메뉴·새 디자인 발주를 알림센터 선행 조건으로 만들지 않는다.
- **남은 정책 근거:** Lab Home 최근 메시지/Support·자동 메시지 hide의 적용 범위는 후속 명시 근거를 확인한다. 파란 배너 1회는 이미 합의·구현된 항목이므로 다시 정책 미정/불필요한 질문으로 되돌리지 않는다.
- **11/4 후속 정책 대기:** USER 단위 Promotion(SMS/MAIL), Benefits > Credit(PUSH/MAIL)의 정책·와이어프레임을 받으면 현재 Employee 설정과의 경계 및 화면/계약을 대조한다. 현재 Credits Mail 지원은 먼저 반영했으나 실제 초기값·저장 계약을 추측하지 않는다.
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
