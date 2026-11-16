# 통합알림센터 재개 현황 — 2026-11-16

현재 상황 파악 요청에 따라 읽기 전용으로 확인했다. 제품 코드·PR·Jira·배포·기기/서버는 변경하지 않았다. 개인 정본은 pull 결과 최신이고 기존 전체 지침 필요 시 동기화·번역시트 중단 규칙을 적용했다.

## 코드와 Development

| 제품 | worktree / branch | HEAD | PR | Development |
| --- | --- | --- | --- | --- |
| Web Clinic/Lab | dentlink-client-notification-center / feature/DL-17058 | a67e1e215 | #4862 OPEN Draft → release/v1.94.0 | develop7c8eef28c의 Clinic43389706697/Lab43389706714 모두 success. 마지막 Messages/스타일 구조 정리는 미배포 |
| Office | dentlink-app / feature/DL-17059 | a6ee48c7 | #346 OPEN Draft → main | iOS/Androidv147, target2.2.4 |
| Lab | dentlink-lab-app / feature/DL-17060 | 2c638fa | #42 OPEN Draft → main | iOSv46/Androidv45, target1.0.5 |

위 경로 루트는 /Users/parkjongsun/Repository. 세 제품 clean·원격동일(0/0). 앱별/OS별 CodePush history를1회조회해 최신 sourceSHA 일치·disabled=false·rollout100을 확인했다. 실제 기기 적용/QA는 이번에 확인한 것이 아니다. 웹 feature와 develop 차이는 마지막 코드 구성 정리 및 release의1.94.0 package버전 반영이다. 웹 master9c4418a8f/release1.94.0 32853e794 유지.

최초 조회 당시 PR본문은 이전 배포를 설명하고 있었다. 이후 사용자 승인으로 아래와 같이 세 PR 본문을 최신화했다. 웹 리뷰8개중 알림센터 지적은 해결 상태이며 기존 밀링FILE1건은 본체 범위 밖으로 유지, 새로 처리하지 않았다.

## Jira와 후속

11/16 10:31KST current Atlassian 조회: 본인 하위22건 전체(isLast=true), **ToDo10/개발완료11/완료1**, 11/13마감 이후 카드변경없음.

- PM [45036](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=45036): **11/17 STG QA 예정**. 부모 fixVersion v1.94.0, releaseDate **11/23**, unreleased.
- BE [DL17114#44994](https://innovaid.atlassian.net/browse/DL-17114?focusedCommentId=44994) 노출키 질문은 댓글전체2건에후속답변없음. [DL16140#45009](https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=45009) 상하위 저장/실제수신 확인도 최신15댓글에서후속답변없음.
- ToDo10: 설정계약17415/16/17, 본체외Home17062/65/68, 향후배지17418/19, 별도E2E17426, Office주문상세17436. 밀링범위제외17420은완료. Figma/Notion 전체재조사는안했으므로 디자인변경없음을live확정한것은아니다.
- Office 자체주문상세는 **release/v2.2.5@ca259592**, 11/13 17:12 DL17175 PR341에있다. origin/main/알림feature에는없다. Git포함관계로1.93제품배포완료를단정하지않고 DL17436유지. 1.93배포/통합기준확보후치과앱만appLandingUrl/pushdeeplink·권한/복귀/read·대상바이너리호환대조. 기공소앱제외.

## 다음 시작점

완료한본체/DEV상태와 미배포웹정리·STGQA일정을먼저브리핑. PR본문최신화는후속승인으로완료. BE계약/본체외Home·배지·별도E2E/Office새화면후속은분리한다. 번역시트후속없음. 별도지시없는배포·구현·추가감시는하지않는다.

## 후속 승인: 배포 없이 PR 설명·기록 정리 완료

사용자는 웹의 마지막 리팩터링을 배포하지 않고 현재 개발서버로 기능 QA를 이어가며, 웹·앱 PR 설명과 메모리만 정리하도록 승인했다. 미배포 변경은 문구 훅 명칭·스타일 코드 구성과 릴리즈 버전 표기로 기존 화면/문구/API/동작을 유지한다. 현재 개발서버 QA가 미배포 리팩터링 자체의 배포 검증이라는 뜻은 아니며, 해당 커밋의 로컬 검증은 11/13 기록을 따른다.

- Web PR4862: DEVPR4891/7c8eef28c·양배포 success, 설정 즉시 표시/실패 복구, 실제 저장 확인 GET 근거, 마지막 Messages/스타일 리팩터링 미배포를 반영했다.
- Office PR346: Development v147 양OS/target2.2.4/sourcea6ee48c7, 즉시 반응·65 tests·양OS 검증·대표 iOS 실제 API 원복과 실기기 QA 경계를 반영했다. 자체 주문 상세 연결은 DL17436 후속이다.
- Lab PR42: iOSv46/Androidv45/target1.0.5/source2c638fa, 동일 저장 UX·16 tests·양OS 검증·대표 Android 실제 API 원복과 실기기 QA 경계를 반영했다.
- 세 PR 본문을 재조회해 반영 및 title/base/Draft/head 불변을 확인했다. Office에는 Jira 연동의 DL17436 링크 정의만 자동 추가됐다. Lab 커넥터 접근 제한은 gh로 보완했다. 리뷰/상태/머지/댓글 추가는 하지 않았다.
- 제품3저장소 clean, 새 코드·제품 커밋·배포 없음. 새 정책이나 작업 상태 변경이 없어 Jira/Notion은 수정하지 않았다. 문서 수정이므로 기존 최종 코드 검증 근거를 사용하고 테스트를 재실행하지 않았다.
- 현재 DEV로 QA 계속 가능. Web a67e1e215 미배포 유지, 앱 추가 CodePush 불필요. PR 설명 최신화는 남은 일에서 제외한다. 별도 요청 전 STG/추가 배포·구현·감시 없음.

## 후속: 웹 CodeRabbit 리뷰 확인

- 사용자 질문으로 PR4862의 리뷰 본문·스레드·최신 HEAD를 조회했다. 기존 스레드8건 중7건 해결, 알림센터 관련 미해결0건이다. 해결된7건에는 밀링 관련 과거 지적도 포함되므로 '알림센터7건'으로 표현하지 않는다.
- 유일한 기존 미해결은 11/13의 [밀링 START 값/FILE 재요구 지적](https://github.com/Innvoaid/dentlink-client/pull/4862#discussion_r4559061326)이다. 사용자 범위 제외를 유지하며 이번 세션에서 수정·resolve·추가 BE 질문을 하지 않는다.
- 자동 리뷰가 paused여서 마지막 검토18e64650c 이후 최신a67e1e215는 미검토로 표시됐다. 11/16 10:59 KST [일회성 review 요청](https://github.com/Innvoaid/dentlink-client/pull/4862#issuecomment-6905220555)을 게시했고 **11:14 KST 검토 결과 새 알림센터 지적4건**이 나왔다. 자동 리뷰 설정이나 Draft 상태는 바꾸지 않았다.
- 최초 별도 대조는 리팩터 전후 스타일39개·문구·콜백·DOM 동등 및 옛 import 잔존0을 확인한 것이며, 전체 변경에 결함이 없다는 증명이 아니었다. 이후 봇 지적을 아래와 같이 실제 재현/계약 확인 후 보완했다. 봇 처리 오류로 제외된 Clinic/Lab host와 test4파일은 별도 코드 대조·host 테스트로 보완했다.

| 새 지적 | 수정과 검증 |
| --- | --- |
| 저장 중 시작한 조회가 늦게 완료되어 저장 확인값을 덮음 | 성공 캐시 반영 전 같은 설정 조회를 취소하고 계정·소속·화면 생명주기 재확인. 수정 전 테스트 실패/수정 후 통과. 정상 GET/PUT/readback 횟수 정책은 그대로 |
| 저장 후 키보드 포커스 유실 | inert 직전 요소를 기억하고 해제 후 같은 화면의 연결·표시·활성 요소에만 복원. 헤더로 옮긴 포커스를 빼앗지 않고 삭제·비활성·문맥 변경은 복원하지 않음 |
| 비활성 주문 범위 메뉴에 옵션 잔존 | 기존 Dropdown에 disabled 전달. 실제 Chromium에서 수정 전 옵션2개 잔존, 수정 후 즉시 닫힘·재활성화 후 자동 재열림 없음 |
| employeeId 생략 시 다른 소속 행 누락 | 최신 DEV Swagger의 선택 속성 확인. employeeId 우선, 생략 때만 employerId가 일치하는 유일한 기존 전환 가능 소속 사용. ID 모순·중복·미소속은 임의 선택 금지. 양host 전달/누락/불일치/중복 회귀 검증 |

- **최종 Web:** `feature/DL-17058@8374225c168010058eacbd28cac957d26e00cdbf`, 커밋·푸시·clean. 기존 PR4862의 head만 따라 갱신, base release/v1.94.0·Draft 유지. 새4스레드에 근거 답변 후 resolve했다. 기존 밀링 FILE은 별도 범위라 그대로 둔다. 코드·리뷰 설명은 최신화했고 **추가 배포 없음**.
- **검증:** 알림 hook33 + Clinic12/Lab4 host = 관련49테스트 통과. UI2건은 실제 NotificationSettings/DLDS를 번들한 임시 headless Chromium에서 Clinic/Lab 각5포커스조건 + Clinic 메뉴1조건 통과, pageerror0. 실제 API·전체 서비스·실기기 QA가 아니다. 새 테스트 파일/스토리북/서버 쓰기 없음. Clinic/Lab/Admin tsc와 정상 pre-push lint·Admin DLDS guard·공유 coverage 검사 통과(기존 warning 유지). 실데이터 E2E는 기존 사용자 제외 지시에 따라 SKIPPED.
- **남은 영향:** WebDEV7c8eef28c에는 이번4건 보완과 앞선 구조정리가 없다. 일반 기능 QA는 기존 개발본으로 계속할 수 있으나 이 수정 효과 확인은 추후 승인된 배포가 필요하다. 앱 코드·CodePush는 그대로다.
- **앱 관련 읽기전용 발견:** Office NotificationCenterScreen의 employeeId/employerId 필수 검사, Lab의 employeeId 매칭도 해당 ID가 생략되면 항목 제외 가능성이 있다. 실제 누락 응답을 관측한 것은 아니다. 이번 웹 PR 범위를 넘어 앱 코드를 수정하지 않았으며, 다음 앱 작업 시 기존 소속 정보로 같은 안전한 매칭을 적용할지 확인한다. 이 항목을 이미 수정/검증된 것으로 보고하지 않는다.
- 임시 UI 근거 `/tmp/notification-settings-ui-review-1116.cjs`/`.json`; 재개에 필요한 결론은 이 정본에 보존했다. 사용자 창·로컬 실행 환경을 바꾸지 않았고 자체 headless만 종료했다.
- 최종 재조회: 봇의 일회성 검토는 `Review finished`, 전체12스레드 중11개 resolved·남은1개는 위 밀링 FILE. 새 알림센터 미해결0. PR head8374225c1/base/Draft/제목 유지·본문 exact match 확인. 수정 커밋에 대한 별도 전체 리뷰를 다시 강제 호출한 것은 아니며 이번 검토 지적의 수정·검증·답변·해결 후 추가 미해결 유무를 확인한 결과다.

## 후속 승인: 양앱 소속 ID 누락 보완

사용자: “배포 제외하고 그전까지만 할꺼면 양앱 보완이지? 맞으면 진행해줘”. 개인 정본·양앱 pull은 최신, 시작 시 clean. 웹은 앞선8374225c1 그대로 두고 앱의 같은 경계만 구현·검증·커밋푸시했다.

- Office `feature/DL-17059@e8ee70188ac0861b07617b46e8f6ba560faaba01`, Lab `feature/DL-17060@27a521f2eef3eccb7fda1789fc4e3806b098af3d`; 두 저장소 원격 일치0/0·clean.
- **매칭:** employeeId가 있으면 우선 사용한다. 없을 때만 employerId가 유일한 기존 소속과 일치하는 경우 연결한다. 제공된 직원 ID 불일치에서 fallback하지 않고, 직원/소속 ID 모순·중복 후보·미소속·현재 소속·0 미읽음은 제외한다. 이름이나 배열 순서로 ID를 추측하지 않는다.
- **Office:** 화면에서 일반 병원 선택과 같은 `user.employee` 원본으로 ID·이름·주소를 확인하고, 표시와 선택에 동일한 확인 결과를 사용한다. 생성 DTO는 이미 optional이므로 모델 변경 없음. 화면1개와 기존 테스트1개 수정.
- **Lab:** 기존 활성 소속 hook이 FE 표시 타입에 employerId를 함께 전달하고 화면에서 매칭한다. 선택 후 기존 소속 재조회·activation 문맥 검증 유지. 제품3파일과 기존 테스트 기대객체1줄 수정. 새 테스트 파일/스토리북/새 API/네이티브/권한 정책 변경 없음.
- **정적 검증:** Office 기존 화면 Jest26, Lab 기존 hook/service Jest27 통과. Lab 실제 소스 매칭 경계13조건은 임시 스크립트로 확인(수정 전 누락 재현). 변경 lint·diff check 통과. 전체 typecheck는 Office6/Lab5 기존 진단으로 실패하며 HEAD 소스를 가상 치환한 컴파일과 동일함을 확인했다. 전체 타입 검사 성공으로 표현하지 않는다. 별도 에이전트의 양앱 diff 검토에서 추가 결함 없음.
- **최종 런타임:** iPhone17Pro/iOS26.5와 Dentlink_API_36/Android16을 제품별로 함께 전환하며 실제 최종 앱 실행. Office Metro8081, Lab8082. Office 양OS 각8조건·Lab 양OS 각10조건: 정상 ID, ID 생략, 모순·미소속·현재 소속·0 제외, 선택에 올바른 ID 전달, 전환 실패 후 기존 소속/입력 복구. Lab은 중복 employer 후보 제외·명시 employee 우선도 실제 화면에서 확인했다. 렌더된 실제 화면 callback을 CDP로 호출하고 네이티브 스크린샷을 직접 대조한 결과이며, 실기기 터치 QA나 실제 서버 전환 성공으로 확대하지 않는다.
- **테스트 데이터 경계:** 실제 서버에서 ID 누락은 관측하지 않았다. Office는 실제 가입 소속과 런타임 count fixture를 대조했다. Lab 계정의 실제 소속은1개로, 추가 소속·count 응답은 메모리 fixture로 확인했다. 서버 activation은 캡처 후 의도된 실패로 끝내 서버 전환 쓰기0; 실제 알림 읽음/설정 저장·푸시 발송도 하지 않았다. 기공소 실제 다중 소속 계정을 새 필수 과제로 만들지 않는다. 전환 성공 경로/권한 자체는 이번에 수정하지 않았다.
- 원본 service·쿼리 복원 완료, 양앱 양OS LogBox0. Android crash buffer의 Bluetooth OS 프로세스 오류는 앱과 별개였고 Dentlink crash/ANR 없음. 시작 때 기기/Metro가 모두 꺼져 있었으므로 검증 종료 후 자체 앱·Metro·시뮬·에뮬을 종료했다. 사용자 창배치는 변경하지 않았다.
- 임시 근거 `/tmp/notification-{office,lab}-affiliation-{ios,android}-1116.json`, `*-restored-1116.json`, native png와 `/tmp/notification-affiliation-crash-1116.log`. 장기 결론은 본 문서로 보존한다.
- PR346/42의 기존 main·Draft·[WIP] 유지, 최신 수정·검증·미배포 범위를 본문에 반영했다. Lab connector404는 기존 gh로 보완했다. 새 PR/merge/배포/CodePush 없음. 기존 카드 개발완료 상태/BE 대기 자체에 변화가 없어 Jira/Notion 추가 수정 없음.
- **다음:** 이번 보완은 OfficeDEVv147/v147·LabDEVv46/v45에 없으며, WebDEV7c8eef28c도 앞선 웹 보완 전 상태다. 사용자가 배포를 승인하면 최신 작업브랜치 전달 후 해당 효과 QA. 그 전에는 추가 구현·배포·폴링하지 않는다. 기존 BE 노출/발송 확인과 본체외 후속은 그대로 분리한다.

## 사용자 마감: 배포는 재요청 후

사용자는 웹·양앱 모두 배포를 제외한 현재 FE 가능 범위를 마감하고 기록 후 대기하도록 요청했다. 세 제품 HEAD는 위 최종값과 같고 원격 일치0/0·clean을 재확인했다. 새로운 검토나 코드 변경은 하지 않았다. 현재 확인된 본체 범위의 FE 보완은 완료이며, 배포·배포 후 QA와 기존 BE/디자인·본체외 후속은 별도로 남긴다. 최신 보완은 개발환경에 전달되지 않았다. 개인 정본·Claude/Codex 메모리 정리 후 대기하고, 배포는 사용자가 다시 요청할 때만 진행한다. 자동 모니터링·추가 조사 없음.

## 설정 새 구조 역제안과 Swagger 대기

2026-11-16 15:12 KST. 사용자 요청은 기록만이며 구현 시작 아님. Jira45070 공유는 사용자 보고로 기록했고 외부 문서 원문을 다시 읽지 않았다.

- 기존 `category.enabled` + `toggleChannel` + 하위채널 구조 대신 모든 제어값을 `channels`로 통합하는 제안을 BE와 논의/공유했다. 최종 Swagger는 사용자가 알려줄 예정이며 자동 조회하지 않는다.
- `channels[0]`은 원본 순서 기준 상위, `[1..]`은 하위. 플랫폼 필터로 첫 번째를 재계산하지 않는다. 최소1개, 단독PUSH도 첫 channel로 OS권한 동작을 구분. NOTIFICATION/PUSH/MAIL은 기존 enum에 맞춘 예시다.
- 채널별 platforms로 노출, 상위가 안 보이면 카테고리도 안 보이는 제안. 하위 플랫폼이 상위 플랫폼 범위를 벗어나지 않는 일관성이 필요하다. 모든 채널을 GET으로 받아 원본 보존, UI만 노출 필터한다.
- 추가 예정 `configurableAuthorities:[ADMIN,MEMBER]`는 권한별 노출. 적용 위치/필수성/빈배열/누락과 실제 앱 role 대응은 새 명세로 확인할 항목이며 지금 추정하거나 별도 질문을 반복하지 않는다. UI노출은 기존 BE권한검증을 대신하지 않는다.
- PUT은 기존 employee/user/categories·orderScope 계약의 틀을 유지하는 제안이며 개별 category 항목은 category와channels의channel/enabled만. GET의 읽기전용 표시메타는제외,숨겨진행/채널도원본값전송,상위변경은같은category의숨긴하위까지전체ON/OFF,다른category/scope는그대로.
- 장점: 상위enabled/채널메타 중복 제거, 치과·기공소 웹앱 동일한 표시 규칙, 단독PUSH 식별 가능. tradeoff: 순서가단순정렬이아닌상위의미계약이며 BE/FE모델·저장·검증 동시전환이필요. 기존category.enabled 필수검사와toggleChannel사용이있어현코드그대로새응답사용불가. 기존원본보존·전체PUT·실패복구구조는재사용가능해불필요한새API/프레임워크는요구하지않는다.
- 이전 `toggleChannel 유지`는 구 구조에서 같은동작을보존할때의추천이다. 새구조에서첫channel자체가상위정체를표현하므로그유지권고를새계약에그대로강제하지않는다.
- 재개: 사용자 Swagger 안내 → 계약/실응답/권한메타 확인 → 승인된제품범위(웹만 우선인지 양앱 동시인지 포함) 확인 → 타입·GET표시·PUT원본보존·OS권한·이벤트 매핑 변경 → 웹/양앱 실제영향조건검증 → 승인된커밋푸시/배포단계. 지금단계는메모리만.
- 기존미배포분: Web8374225c1/Officee8ee7018/Lab27a521f. 로컬clean·추적원격0/0, 기존PR/DEV그대로. 새코드/배포/QA/기기조작없음. 본체외기록과BE기타확인은이번제안완료로일괄닫지않는다.

공유: https://innovaid.atlassian.net/browse/DL-16140?focusedCommentId=45070

## 지정 Slack 4개 동기화

2026-11-16 15:20 KST 조사 마감. 사용자 목적은 다른 담당자들의 작업/논의 상태를 현재 FE 구현과 맞추는 것이며 구현·외부쓰기·배포 승인이 아니다. 지정4개 부모+답글53개, pagination 모두 끝 확인. 반복폴링하지 않음. 코드대조는 Web8374225c1·Officee8ee7018·Lab27a521f이며 개발서버/새API/실기기 QA를 새로 수행하지 않았다.

| 스레드 | 이번 확인 마지막 댓글 | 내용/상태 |
|---|---|---|
| [표시명 매핑](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794306299283819) | 11/16 11:40:55 ·1794796855.986009 | Yoonie가 User Credit을 우선 포함하는 방향으로 설명. 11/12 제외발언보다최신. 매핑유지, UI영역은오전와이어참고요청. BE완료확인으로단정하지않음. |
| [디자인 변경·카운트](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794533798159559) | 11/16 13:26:49 ·1794803209.181669 | Leo의질문에PM이개인알림도인박스미확인카운트포함확인. 다른치과카운트는제외. 11/13 CasePreference제거·OfficeCredit표기·LabFeedback제거·MillingOrderUpdates한개·문구·Amplitude는기존작업이력. CP/SCRP 별도디자인은알림센터범위로편입하지않음. |
| [유저 알림 와이어·정책](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794793695731349) | 11/16 14:44:50 ·1794807890.507579 | 11/23포함방향(개발완료아님),Oli디자인정리중. 치과user영역→office영역,웹앱순서통일. Lab유저단위없음. LabPC/모바일설정순서이미지공유완료. Feedback은BE가NOTIFICATION/PUSH만발송,MAIL없다고정정. |
| [조회필터·수신범위 분리](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794796366327219) | 11/16 15:12:05 ·1794809525.232639 | Yoonie/Leo/Mina논의후Mina최종정리:치과조회/수신독립,Member양쪽내주문한정. Lab조회/수신독립,Member알림은담당or책임주문한정,홈/목록은본인필터기본진입이나해제해서전체조회가능. Mina시트커버추가예고,Kyle-Leo싱크요청있음. 시트실제수정완료/담당기능코드완료로확대하지않음. |

### FE 대조와 다음 영향

- Web/Office는이미user.CREDITS와employee.CREDITS매핑을구분하고user→employee순서로그린다. 다만개인/소속영역제목·설명을넣은새UI는없다. 설정데이터지원과새디자인반영을구분한다. Lab도user배열을읽는기반은있으나새정책상BE빈배열이면표시없음. 실제현재GET응답을이번다시조회한것은아니다.
- Oli14:24목록:치과 UserCredit / LinkTalk / Order(DesignConfirmation,OrderUpdates,Shipping,Feedback) / OfficeCredit / Payments;Lab LinkTalk / DentlinkSupport / Order(DesignConfirmation,OrderUpdates) / MillingOrderUpdates. PM14:32웹앱순서통일·user설명간소화·office설명삭제. 기존각scope내순서는서버배열그대로이므로새서버순서를수용할기반. 최종문구/항목은PM재전달예정이었고Oli14:03라이팅은제안상태;그문구그대로확정/임의구현하지않는다.
- 개인알림 count는 FE재계산이아니라/inbox/unread와/inbox/employers/unread각서버응답사용. 개인읽음뒤관련쿼리재조회기반도있다. 이번확정은집계정책확인이지새실데이터정확성검증아님. 과거계정단위단일읽음정책도유지.
- Office주문/링크톡필터AsyncStorage,웹URL조회필터는알림orderScope와독립되어있다. OfficeMember주문목록은필터UI숨김·myOrderOnly생략으로BE권한필터따름(링크톡은true강제);서버가true강제한다는Leo설명과구분. 동일권한이름이라고Lab에치과제한복사금지.
- Lab현재알림범위선택UI없음(앱). 웹공통UI는authorityType+selectedScope+options>1조건이지만Labhost가authorityType을전달하지않음. 따라서다른권한의선택기능까지제공하기로확정/명세반영되면FE추가연결대상. Member발송대상담당or책임판정은BE범위이며FE가임의집계하지않는다. 현Lab앱목록요청에담당/책임필터없으나타담당자브랜치/배포상태는이번조사안함.
- 새로운channels첫항목상위·platforms/configurableAuthorities계약과UI후속을함께대조할시점은사용자Swagger안내후. 이번댓글만으로공유한새구조의BE구현완료를추정하지않는다.

### 자료 충돌과 확인 한계

- PM14:20:Studio공유PRD는QA자동화용임의문서라혼란있어Notion으로정리예고,유저단위는Artifact참고하며문구/항목재전달예정. 따라서원문표현중user_push_setting유지·LinkTalk을채널로분류·CasePreference설정가능·idempotency_key발송보장등은BE의정정대상이며FE코드를그문구대로추가/삭제하지않는다. LinkTalk은카테고리이며문서의SMS언급만으로SMS설정UI추가금지.
- 첨부F0CJT9AARSL(10:55정책표),F0CJUGG87KJ(14:44LabPC/모바일설정),F0CHXNQF41L(개인카운트정책)을읽고이미지직접확인. 첫표에는11/23이후추가/user_push_setting등오래된표현이남아있어최신댓글의포함방향과BE정정이우선. 카운트첨부의'미정'표기도동일스레드PM답변으로해소됨.
- Claude Artifact최신웹본문은도구접근불가. 따라서최신와이어실화면/최종Figma전체까지확인했다고하지않는다. 이번Notion/Sheet/다른담당브랜치의실제수정완료는확인하지않았으며필요시새작업에서범위정해대조. Studio서비스/CP/밀링상세작업은재개하지않음.
- 기존PR와미배포보완/사용자Swagger대기유지. 새일은개인설정영역UI·정렬/노출계약·조건부Lab범위선택반영이며이미완료된필터분리/이벤트/카운트연결을다시미구현으로되돌리지않는다.
