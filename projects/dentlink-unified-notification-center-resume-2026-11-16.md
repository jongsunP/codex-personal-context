# 통합알림센터 재개 현황 — 2026-11-16

2026-11-16 사용자 최종 변경: 앱 코드 변경마다 시뮬/에뮬 검증을 필수로 반복하지 않는다. 최초 기능 개발·사용자 요청·크래시/랜딩/권한/네이티브 등 구체 위험이 있을 때 필요한 범위만 실행한다. 저위험 리뷰/타입/문구 정리는 관련 테스트·정적검사 중심이고 미변경 동작의 기존 근거를 재사용한다. 단순 SHA/PR base 변경만으로 기기 재검증하지 않는다. 기존 공통 지침의 일괄 필수 문구를 정본에서 교체했고 제품코드/배포 변경은 없다. 이번 준비는 마감, 추가 리뷰·BE 후속 대기.

**최신 상태:** 릴리즈 추가분 통합·리뷰 보완·최종 검증·커밋푸시·기존 정식 PR 갱신 완료, 미배포. Web fed97af3f / Office ef29e3e6 / Lab 916610e. 추가 리뷰 결과·BE 후속 대기. 아래 과거 최신화/리뷰 상태는 당시 이력이며 마지막 마감 절을 따른다.

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

## 15:26 사용자 마감

현재 확인된 범위에서는 새 디자인·Swagger 없이 추가할 본체 FE 구현 없음. 기존 미배포 웹/양앱 보완·PR은 유지. 개인/소속 영역 UI, channels 중심 새 GET/PUT·platforms/configurableAuthorities, 기공소 범위 선택은 확정 자료와 실제 계약을 보고 재개한다. 사용자 안내 전 자동 조회·구현·배포 없음. 이번 마감은 개인 기록만 갱신하며 새 코드/검증/배포를 수행하지 않았다.

### 15:35 최종 확인 — FE 대기 자료 두 가지

- 사용자 정리: 기다리는 것은 알림 설정 화면 디자인과 알림 설정 API 구조다. 현재 추가 FE 구현은 없으며 미배포분은 별도 배포 요청 대기.
- **15:26의 ‘새 디자인·Swagger 없이 추가 구현 없음’은 둘이 함께 나와야 시작한다는 의미가 아니다.** 기존 user/employee 항목은 현재 카드 UI로 표시하는 기반이 있으며, 새 Swagger가 먼저 나오면 새 GET/PUT·플랫폼·권한 처리를 기존 UI에 먼저 연결할 수 있다. 디자인은 개인/병원 구역의 제목·설명·배치를 마무리할 자료다.
- 신규 계약은 아직 미구현이므로 서버가 구조만 바꾸면 현 category.enabled 필수 검사 등과 호환되지 않는다. 재개 시 BE/FE 반영 순서와 실제 응답을 대조한다. 사용자 제공 전 자동 조회/사전 구현 금지.
- 기공소 수신 범위도 같은 설정 계약에서 확인할 사항. 개인 알림 서버 발송/읽음/카운트는 BE 처리·이후 통합 검증이며 별도의 FE 신규 구현 의존성으로 늘리지 않는다. 기존 필터 분리는 완료이고 별도 CP/담당자 기능을 여기서 재개하지 않는다.
- 이번에는 기록만 갱신했으며 제품 코드/PR/배포/기기 변경 없음. 사용자 새 디자인·Swagger 안내까지 대기.

### 15:49 재개 기준 확인

사용자가 Swagger 완료 시 다시 알리기로 했다. 새 계약을 FE에 연결·검증하면 새 디자인 없이도 user/employee의 해당 플랫폼·권한 노출 항목을 서버 순서대로 기존 UI에 표시/저장할 수 있다. toggleChannel 기반 옛 노출 필터는 새 계약으로 교체하고 기존 FE 문구 매핑은 활용한다. 이 기능 연결과 최종 개인/병원 구역 디자인 적용은 분리한다. 현재 새 계약 미구현·기존 미배포 보완 유지. 사용자 안내 전 구현/배포/자동 조회 없음. 이번 기록 외 제품 상태 변경 없음.


### 16:00 Jira 설정 후속 3건 제목·본문 정리 완료

사용자 요청은 Jira 3개 카드 정리와 메모리뿐이며 코드/배포는 금지였다.

| 카드 | 갱신 제목 | 상태 |
| --- | --- | --- |
| [DL-17415](https://innovaid.atlassian.net/browse/DL-17415) | [후속] [FE] 웹(Clinic/Lab) 알림 설정 새 API 구조·권한별 노출·화면 반영 | 해야 할 일 |
| [DL-17416](https://innovaid.atlassian.net/browse/DL-17416) | [후속] [FE] Office 앱 알림 설정 새 API 구조·권한별 노출·개인 영역 반영 | 해야 할 일 |
| [DL-17417](https://innovaid.atlassian.net/browse/DL-17417) | [후속] [FE] Lab 앱 알림 설정 새 API 구조·권한별 노출·수신 범위 반영 | 해야 할 일 |

- 본문은 현재 상태/진행 순서 → 작업 범위 → 완료 기준 → 근거 링크로 교체. Swagger가 먼저면 기존 UI로 기능을 연결하고 새 디자인은 후속 반영한다. 원본 channels[0] 상위, platforms/권한 노출, 같은 category 하위 전체 연동·다른 범위 보존, 앱 OS 안내/복귀와 분석 유지, 제품별 실제 응답 검증을 명시했다.
- Lab 개인 알림 영역은 만들지 않는다. Lab 수신 범위 UI는 최종 계약에서 실제 필요한 연결만 보완하며 선택지/기본값을 발명하지 않는다. Office 개인/병원 구역의 최종 디자인은 별도 마무리 단계다.
- API 구조는 사용자 공유 방향이며 최종 필드/필수값/권한 정보 적용 위치는 Swagger를 따른다. 새 계약이 이미 구현됐다는 의미가 아니다.
- 쓰기 필드는 summary/description 두 개뿐. 15:59:41~43 KST 갱신 후 세 카드 재조회: 제목·본문 일치, status10015 유지, 전체 customFields·assignee·parent 동일. SP 변경 없음. 상위 댓글/새 카드/Notion/Slack/제품 코드/PR/배포 변경 없음.
- 다음 시작점: 사용자 Swagger 안내를 받은 뒤 새 타입·조회·노출·저장·권한/OS 흐름을 제품별 연결하고 검증. 새 디자인은 나오는 대로 반영. 지금은 구현·배포·자동 조회 없이 대기.

## 새 알림 설정 API 연결 — 2026-11-16

사용자가 새 Swagger 연결을 승인했다. 새 디자인 없이 가능한 기능을 Web Clinic/Lab·Office 앱·Lab 앱에 연결하고, 검증 후 커밋푸시하되 배포는 하지 않는 범위다. 아래는 같은 날 앞선 Swagger 대기 기록보다 최신이다.

### 구현과 현재 영향

- DEV `/v3/api-docs`와 양제품 실제 인증 GET을 대조했다. category `enabled`·`toggleChannel` 제거, 원본 `channels[0]` 상위/나머지 하위, 채널별 `enabled/platforms` 구조로 소비 타입·GET 표시·PUT·저장 확인·OS 안내·분석 이벤트를 변경했다. 기존 generator 출력에서 관련 DTO만 동기화했다.
- WEB/APP은 채널별 platforms로 표시한다. 원본 상위가 해당 플랫폼에서 숨김이면 카테고리 전체를 숨기며 자식을 상위로 승격하지 않는다. platforms 생략은 현재 Swagger상 선택 속성이므로 UI 미노출·원본 보존; 손상/null/잘못된 enum은 저장 가능한 응답으로 취급하지 않는다. 첫 채널이 필요한 새 계약이므로 channels 누락/빈 배열은 정상 단독 토글이 아니다. 단독 토글은 1채널 배열이다. 과거 구계약 `channels:[]` 설명과 구분한다.
- 기존 전체 PUT 틀은 유지하되 category + channels의 channel/enabled만 보내며 readonly 메타는 제외한다. 상위 ON/OFF는 같은 category의 숨겨진 자식까지 전체 적용; 다른 category와 user/employee 범위는 보존한다. 단일 자식 변경은 그 채널만 바꾼다.
- UI 즉시 반영·중복 저장 차단·실패 복구·확인 GET은 유지했다. 즉시 표시용 원본을 갱신할 때 channel.platforms를 잃어 항목이 사라지지 않도록 보완했다. 새로운 mock/Storybook/화면/네이티브 변경 없음.
- 실제 Office 응답에는 개인 CREDITS와 소속 항목이 있어 기존 UI에 표시/저장된다. Lab은 user.categories=[]·orderScope=null·orderScopeOptions=[]로 개인 영역/범위 선택을 임의 추가하지 않았다. 신 디자인의 구역 제목/설명/배치는 후속이다.

### 검증

- Web: 관련43테스트, Clinic/Lab/Admin 타입검사 통과. 양웹 실제 인증 GET과 화면 대조, 지연/실패 UI Office4·Lab3조건 통과. 실제 상위 OFF→PUT→GET에서 숨겨진 PUSH 포함 하위 전체OFF, 다른 범위 보존, ON후 전체 원본복구 확인. 브라우저 JS오류0. 사용자 제외한 실데이터 E2E는 실행하지 않는다.
- Office: 기존4suite73tests·변경 lint 통과. Lab: 기존3suite22tests·변경 lint·실제응답 기반18조건 통과. 앱 전체 타입검사는 기존 Office6/Lab5 오류가 남아 통과로 보고하지 않는다. 변경 설정 파일의 타입 진단은 없다.
- 최종 코드 런타임: iPhone17Pro/iOS26.5와 Dentlink_API_36/Android16을 제품별 함께 전환. Office 양OS 각각 자식OFF/ON·상위OFF/ON, Lab Android 같은4조건. Lab iOS는 실제 OS권한 거부 상태에서 PUSH 안내/취소0PUT과 상위OFF/ON을 확인했다. 각 저장 직후 UI반응·행 유지·1PUT·실GET확인·전체 설정 원복, LogBox0을 확인했다. 렌더된 실제 화면 핸들러를 CDP로 실행하고 네이티브 스크린샷을 직접 대조했으며 실기기 터치 QA로 확대하지 않는다.
- Android 양앱 추가: 실제 POST_NOTIFICATIONS 권한을 adb로 revoke한 후 앱 실행→PUSH 안내0PUT→네이티브 팝업 확인 탭→권한 grant 및 앱 복귀→선택한 LinkTalk만1PUT/ON을 확인. 권한/서버 값 원복. iOS 실기기의 OS설정 왕복은 이번 검증 아님. 실제 푸시 발송/수신·모든 권한 계정의 실응답 검증도 하지 않았다.
- Android 앱 crash/ANR 기록 없음. 시작 시 꺼져 있던 자체 기기/Metro는 검증 후 종료했고 사용자 창 배치는 변경하지 않았다. 계정/토큰/비밀번호는 기록하지 않는다.
- 근거: `/tmp/notification-web-new-settings-{read,runtime,office-live-put,lab-live-put}-1116.json`, `/tmp/notification-new-contract-{office,lab}-{ios,android}-1116.json`, 각 native png, `/tmp/notification-{office,lab}-os-return-1116.json`, `/tmp/notification-new-contract-crash-1116.log`. 임시 근거가 사라져도 본 기록으로 결과/한계를 복구한다.

### 남은 확인과 다음 시작점

1. `configurableAuthorities`는 새 Swagger 전체와 실제 GET 모두에 없다. 적용 위치/권한값/생략 의미를 임의 구현하지 않았다. 기존 BE항목 제한과 FE권한 처리는 유지하며 키가 제공되면 노출 조건만 연결한다.
2. CategorySettingDto.channels 설명의 “꺼도 나머지 채널 값은 보존”은 사용자 확정 상하위 전체ON/OFF와 다르다. FE는 최신 사용자 합의대로 전체값을 함께 저장했고 실제 PUT/GET도 정상 반영된다. BE에는 이 설명 정합성만 확인하면 되며, 이 확인 때문에 임의로 숨김보존 UX로 바꾸지 않는다. 실제 발송 엔진까지 검증한 것은 아니다.
3. 새 디자인 후 최종 구역/문구/배치를 적용한다. 현재 기능 연결은 완료, 권한키/디자인까지 완료로 합치지 않는다. 해당 Jira3건은 완료 부분을 댓글에 보존하고 남은 작업 때문에 해야 할 일로 둔다. 스토리포인트/상위카드/타인 작업은 변경하지 않는다.
4. 기존 PR 유지, 이번 개발서버/CodePush 배포 없음. 서버만 새 계약이 되어도 구 FE가 자동 호환되지는 않는다. 사용자의 다음 배포 승인 시 최신 3제품을 함께 반영하고 배포본 QA를 구분한다. 기존 본체외Home·OS배지·이메일·Office자체주문상세 후속은 별도 유지한다.

### 작업 방식 지침

사용자는 이번 테스트 갱신을 승인했고, 앞으로도 지침 예외·의미 있는 선택은 권장안과 짧은 이유를 듣고 판단하는 일반 작업스타일이라고 명시했다. AI_WORKFLOW의 Collaborative Decisions And Guideline Exceptions와 AGENTS 참조, 로컬 Codex 사본·Claude feedback 메모리에 반영했다. 이미 승인된 일반실행은 반복 질문하지 않는다. 이번 승인을 테스트수정 상시허용으로 확대하지 않고 기존 명시 승인 규칙은 유지한다.

최종 코드: Web `feature/DL-17058@3878e774f35e5a97d34482c04c732bc5358ccb70`, Office `feature/DL-17059@91b8531bdbaf7f7f3f74575e68937a541da13328`, Lab `feature/DL-17060@cfa102240640a1998d2d593c3c442ac55817bc90`. 기존 PR4862/346/42 본문 최신화, base/Draft 유지. 웹 정상 Git 훅(type3제품·hooks75·lint/coverage) 통과, E2E guard는 사용자 제외 지시로 SKIPPED. 기존 리뷰 상태와 새 계약 리뷰 실행 여부를 구분하며 새 승인/전체리뷰 완료로 표현하지 않는다.

마감 확인: 세 제품 clean·원격일치. Office/Lab 기존 미해결 리뷰0(Office실제리뷰0, Lab과거리뷰만 있으므로 신규승인완료아님); 웹 미해결1은 사용자가 제외한 기존 밀링FILE로 알림센터관련0이며 새전체리뷰를 강제로 실행하지 않았다. 앱 PR workflow CodePush skipped, 배포0. Jira17415댓글45083·17416댓글45085·17417댓글45084에 기능완료/검증/남은범위를 기록하고 세카드 모두해야할일로정리. 본문은현재명세와남은기능정의만수정, SP/parent불변. `configurableAuthorities`와상하위설명확인은 사용자에게알릴내용이며BE에게대신전송하지않았다. 개인정본+Claude/Codex메모리동기화완료후배포승인/새자료대기.

## 권한 노출 키 현재 범위 제외

**2026-11-16 사용자 후속 결정 — configurableAuthorities 제외:** BE가 실수로 누락했다고 사용자에게 전달했고, 사용자는 이 키를 우선 현재 작업 범위에서 제외하라고 했다. 현 Web/Office/Lab 코드는 해당 키를 사용하지 않으므로 코드 추가 수정은 없다. 기존 권한 제한은 유지하며 기능 완료·배포의 필수 대기 조건으로 분류하지 않는다. 사용자가 수정된 명세를 알려주면 그때 후속 반영한다. 자동 Swagger 조회·BE 재질문 없음. 새 디자인 후속 및 별도 상하위 설명 정합성 확인은 그대로이고 배포 금지도 유지한다. Jira17415/16/17의 작업 정의와 기존 PR 설명에서 현재 미완료 사유처럼 보이는 부분만 정리한다.


## 양앱 최신 main 통합·릴리즈 PR 준비 — 2026-11-16

사용자 승인: 양앱 최신 main 반영, 충돌 해결, 시뮬·에뮬 검증, 커밋푸시, 기존 PR 대상 변경까지. 배포·CodePush·PR 병합은 금지. 웹은 이번 요청에서 수정하지 않았다.

| 제품 | 작업 경로 / 브랜치 | 통합 main | 최종 HEAD | 기존 PR 대상 |
| --- | --- | --- | --- | --- |
| Office | dentlink-app / feature/DL-17059 | 851c7889 | 987dbdd3 | [346](https://github.com/Innvoaid/dentlink-app/pull/346) → release/v2.2.5 |
| Lab | dentlink-lab-app / feature/DL-17060 | 691c012 | 27032b4 | [42](https://github.com/Innvoaid/dentlink-lab-app/pull/42) → release/v1.0.6 |

경로 루트는 /Users/parkjongsun/Repository. 양앱 원격 일치·clean, 최신 main 포함을 확인했다. 기존 PR의 OPEN Draft·DRAFT 라벨·[WIP] 제목을 유지하며 본문만 통합 코드·검증·미배포 기준으로 최신화했다. 새 릴리즈 브랜치나 버전은 만들지 않았다.

### 통합과 범위

- Office: SVG export 충돌 정리. feature의 새 Swagger와 main 주문상세의 TimelineDto 이름 충돌은 main의 기존 Office 타입 구조를 그대로 보존한 OfficeTimelineDto와 소비부 타입 import로 해결했다. 생성 API 파일은 이 이유로 다시 생성하지 않았다.
- Lab: PermissionProvider 충돌은 폐기한 구 알림 수신 설정 API 초기화를 복원하지 않고 현재 OS 권한·갱신 흐름을 유지했다. 밀링 공정 유틸은 main의 검증 및 기존 새 Swagger 타입 보완을 함께 유지하는 최소 병합이다. 밀링 신규 작업을 알림센터에 추가한 것이 아니다.
- 최신 main의 iOS 알림 권한 검사·Android Notifee ReactHost 패치·Amplitude 의존성/네이티브 버전은 그대로 수용했다. 양앱의 main 대비 ios/android/patches/native/package.json/yarn.lock 추가 차이는 없다. 이번 알림센터가 별도 네이티브 동작을 신설한 것으로 보고하지 않는다.
- **주문상세 자체는 별도 업무라는 사용자 정정 준수.** OrderDetailScreen과 기존 주문상세 테스트는 main 그대로 두었다. 누락된 native mock 추가 요청은 승인받지 않았으므로 수정하지 않았다. 최소 타입 충돌 해결과 알림 연결 검증만 이 범위다.

### 치과앱 주문상세 랜딩

- **새 주소 필요 없음:** 기존 `dentlink://order/{employerId}/{orderId}` 유지, DEV는 dentlink-dev scheme. native 주문상세 스크린으로 내부 연결하므로 이 전환만으로 Sheet/BE appLandingUrl 변경은 없다. Lab은 기존 WebView 상세 유지.
- 실제 발견·수정: 다른 병원 URL 진입 시 이전 병원의 native 상세가 마운트된 상태로 auth가 변경되어 이전 주문을 새 병원으로 조회하고 403/로그아웃되는 문제를 재현했다. 알림 연결부 `useNavigationConfig`와 기존 전환 hook의 선택 callback만 보완했다. 전환 API 성공 후 이전 소속 화면을 해제하고 auth를 반영한다. API 실패 시 기존 화면을 유지한다.
- 추가 재현·수정: auth 변경에 따른 NotificationInbox 내부 key 재생성을 사용자 이탈로 오판하여 소속만 바뀌고 상세로 이동하지 않는 경우. auth 전에는 leaf key를 확인하고 반영 후에는 안정적인 root route key·화면명으로 정상 재마운트를 허용한다. 요청/계정/실제 사용자 이동 취소 방어는 유지한다.
- 상세 화면 내부의 기존 활성화·조회 로직은 수정하지 않았다. 구독 해제와 라우트 재생성 문제를 확인한 것이며 모든 상세 기능을 다시 QA한 것은 아니다.

### 최종 검증

- Office: 관련 기존 테스트 159개 통과, 최종 연결 경계는 저장소 밖 임시 회귀검증 21개 통과(수정 전 실패 재현 포함). 신규 테스트 파일/기존 주문상세 테스트 수정 없음. 관련 lint 오류 없음. 전체 tsc는 기존 6개 진단만 남음. main 주문상세 테스트 1suite는 기존 RNGestureHandler native mock 누락으로 실행 실패했으며 해당 범위는 사용자 지시대로 그대로 둠.
- Lab: 관련 8suite/76 tests 통과, lint 오류 없음. 전체 tsc 기존 5개 진단만 남음. 병합 신규 타입 오류는 해결. main에서 받은 native patch의 기존 공백 경고는 구분했다.
- 양앱 iOS·Android 신규 로컬 빌드 성공(Office2.2.5, Lab1.0.6). iPhone17Pro/iOS26.5와 Android16/API36을 제품별 같은 소스·환경으로 함께 전환해 확인했다.
- 양앱 실제 DEV 인박스 → 읽음 PATCH → 주문상세(Office native, Lab WebView) → 헤더 뒤로가기 → 인박스 복귀 확인. Office 최종 양OS에서 같은 병원 실제 row와 다른 병원 실제 URL을 사용한 callback 진입, OS URL 다른 병원 진입, 로그인 유지·정확한 병원/주문·복귀를 확인했다. 다른 병원 인박스 검증 일부는 실제 URL을 넘긴 런타임 fixture이며 실제 발송한 푸시 증명은 아니다.
- 설정: Office 양OS·Lab Android에서 하위/상위 OFF→ON 4개 변경, 각1PUT·즉시 반영·전체 서버값 원복 확인. Lab iOS는 OS 차단 상태의 PUSH 안내·취소(0PUT), 상위 OFF/ON·원복 확인. Lab Android OS 차단→재시작→안내취소→허용·복귀를 확인했고 취소한 설정의 자동저장0. 마지막 연결부 수정은 설정 저장 코드를 바꾸지 않아 같은 최종 구현의 앞선 증거를 재사용했다.
- 최종 확인 경로의 양OS LogBox0, Dentlink 앱 crash/ANR 없음. Android crash buffer의 Bluetooth OS 프로세스 오류는 별개이며 버퍼 전체가 비었다고 하지 않는다. 실제 FCM/APNs 발송·실기기 OTA·전체 주문상세 기능 QA는 미실행이다.
- 설정은 원래 값으로 복원했고 테스트 알림 일부는 읽음 처리했다. Office 최종 소속은 두 기기 모두86. 시작 시 꺼져 있던 자체 실행 기기·Metro8081/8082를 종료했다. 다른 작업의 headless emulator5556 등은 건드리지 않았다.
- 임시 증거: `/tmp/notification-main-office-{ios,android}-final-*.json/png`, `/tmp/notification-main-lab-{ios,android}-{settings,landing,back}-1116.json`, native build logs. 재개에 필요한 결론은 본 문서에 보존한다.

### 현재 영향·다음 시작점

- **미배포.** 기존 DEV Office v147/v147(target2.2.4, sourcea6ee48c7), Lab v46/v45(target1.0.5, source2c638fa)는 이번 작업으로 바뀌지 않았다. 웹 새 API 연결3878e774f도 이번 요청에서는 변경/배포하지 않았다.
- 이번 앱 branch는 main의 네이티브 버전 Office2.2.5/Lab1.0.6 기준이다. 이후 OTA 요청 시 실제 대상 바이너리·전체 native diff·SHA를 다시 확인하며 구2.2.4/1.0.5 대상으로 무조건 내보내지 않는다.
- DL17436의 주문상세 랜딩 확인 범위는 코드/로컬 검증까지 완료했지만 이번 요청에서 Jira 상태는 변경하지 않았다. 위 오전의 main 미포함/미착수 기록은 과거 상태다.
- 새 알림 설정 디자인, 사용자 안내 후 configurableAuthorities 후속, Swagger 상하위 설명 정합성 확인은 기존대로 분리. configurableAuthorities는 현 범위 제외이며 완료 필수 대기로 되돌리지 않는다. 배포/실기기 QA는 별도 승인 후 진행한다. 추가 폴링·자동배포 없음.

## 정식 리뷰 PR 전환·후속 기준 브랜치 동기화 — 2026-11-16

사용자는 웹·치과앱·기공소앱 모두 실제 정식 PR로 준비하도록 승인했다. 이후 새 기준 브랜치 변경이 있으면 맞추되 필요한 영향 검증만 하고 전체 검수는 반복하지 말라고 명시했다. PR ready 전환은 리뷰 승인·릴리즈 병합·배포 완료가 아니다.

| 제품 | 최종 head | PR 대상 | 상태 |
| --- | --- | --- | --- |
| Web Clinic/Lab | 558a36df0 | #4862 → release/v1.94.0 | OPEN, Draft=false, DRAFT/[WIP] 제거 |
| Office | 987dbdd3 | #346 → release/v2.2.5 | OPEN, Draft=false, DRAFT/[WIP] 제거 |
| Lab | dbcd1ad9 | #42 → release/v1.0.6 | OPEN, Draft=false, DRAFT/[WIP] 제거 |

- 각 PR의 기존 나머지 제목·라벨·리뷰어를 유지했다. 본문의 ‘Draft 유지’ 문구는 정식 리뷰 요청 상태로 고쳤고 검증 한계·미배포 이력은 보존했다. 새 리뷰어 지정·댓글·강제 봇 리뷰 요청은 하지 않았다.
- **Office:** main/release851c7889가 그대로여서 코드 재수정 없음. 미해결 리뷰0·충돌없음, 전환 전 add-labels 성공/codepush_job skipped 확인. skipped는 배포한 것이 아니다.
- **Lab:** 앞선 준비 후 main/release가691c012→a6e18282로 이동했다(밀링 주문목록 isRemake 서버필터 #47/#48). PR이 CONFLICTING으로 재계산되어 최신main을 추가 통합했다. 생성 Api.ts의 구 설정 enabled/toggleChannel 블록과 새 channels 계약 충돌만 있었으며, 오늘 Swagger 생성물의 기검증 Category/Channel DTO를 그대로 보존하고 main의 새 isRemake 계약·3실소스 파일은 그대로 받았다. 새로운 API 구조를 추정하거나 밀링 기능을 자체 수정하지 않았다.
- Lab8suite76tests·실소스lint·diff검사 통과, tsc기존5진단만. 설정/FCM/PermissionProvider/deepLink소스·의존성/native는 앞선 검증코드와 동일하므로 재빌드·저장/푸시 전체시험을 반복하지 않았다. 현재 통합JS를 기존 검증빌드에 연결해 iOS/Android 실제 홈→인박스→설정 GET/렌더, 신규채널 구조, OS차단/허용 표시, LogBox0 확인. 이번에는 설정/읽음 서버쓰기0. 임시근거 `/tmp/notification-lab-ready-{ios,android}-settings-1116.json/png`. 자체 실행 기기/Metro8082 종료.
- **Web:** master9c4418a8f는 그대로이나 release1.94.0이32853e794→3852aca7f로 이동했다(주문서 필수값·단계 이동 검증 #4873). 알림 변경과 파일 교집합0, merge-tree 충돌없음. 최신 release를 작업 branch에 통합했고 알림이 사용하는 DropdownPrimitive·자체Button과 새필수표시/Stepper 변경은 직접 겹치지 않음을 확인했다. RedDot 기본값도 유지. 자체 기능 재작성 없음. 관련 공유43+Clinic12+Lab4 tests 통과, 정상Git훅의 Clinic/Lab/Admin 타입·lint(기존경고) 및 config49/hooks75 tests도 통과했다. E2E 제외 기록은 최종 merge-base 기준 SKIPPED로 재기록해 guard를 통과했고 실행한 것으로 표시하지 않는다. 전체E2E·전수검수는 하지 않았다.
- 웹의 기존 밀링 FILE START 검토1스레드는 사용자 명시 범위 밖이므로 강제로 resolve하지 않았다. 알림센터 리뷰는 처리된 기존 상태이며 이번 정식PR전환을 새 코드 전체에 대한 봇/인간 승인으로 표현하지 않는다. GitHub 리뷰 승인 요건(REVIEW_REQUIRED)은 정상적인 다음 단계다.
- 세 제품 최종 clean·원격일치·PR base/head/draft/라벨을 확인했다. PR준비를 끝내고 병합·배포·CodePush는 하지 않았다. 기존 개발서버와 기기OTA 상태는 그대로다. 새로운 변경/리뷰가 생길 때만 해당 영향 범위를 처리하며 자동 감시·반복전수조사하지 않는다.

## 최신: 릴리즈 추가분 통합·리뷰 보완 완료, 추가 리뷰/BE 대기 — 2026-11-16

- **완료:** Web `fed97af3f`(release/v1.94.0의 f0e180fe0 포함), Office `ef29e3e6`(main851c7889·release/v2.2.5 b1121e72 포함), Lab `916610e`(main/release/v1.0.6 a6e18282 포함) 커밋·푸시. 기존 정식 PR4862/346/42 대상 유지·본문 최신화. 사용자 추가 웹/Office 마케팅 수신 동의 통합, 기공소 최신 기준 포함. 릴리즈 PR 병합·배포·CodePush 없음.
- **리뷰 보완:** Office 새 inline6건 수정·답변·resolve. 실패 푸시 읽음 큐 보존, 읽음 후 settings 재조회 제외, 소속 전환 중 직원 조회 보존, 지연 주문조회 탐색 가드, 소속별 금융 랜딩 중복 구분, 크레딧 날짜 시간대 일치. Lab은 공통2건(읽음 실패 큐·설정 재조회)만 맞췄다. 주문상세 본체/기존 상세 테스트·밀링은 별개 소유로 유지.
- **검증:** 웹 알림59+정상훅(type/lint/config49/hooks75), Clinic PC/모바일 실제 프로필·알림 설정 공존 확인. Office 영향 기존60+외부35, Lab14 tests. Office2.2.5/Lab1.0.6 양OS 최종JS에서 관련 화면·랜딩·재시도 검증, LogBox0. 기존 타입오류 Office6/Lab5는 그대로이며 전체타입통과로 표현하지 않는다. 실제 FCM/APNs·OTA·전체 QA는 별도.
- **현재 리뷰 상태:** Web은 수동1회 요청 후 Review triggered, 결과 재조회하지 않음. Office 기존6건 해결 후 수동1회 요청은 Incremental review skipped(봇: 이미 검토한 커밋은 재검토하지 않으며 review 명령은 자동 리뷰 일시중지 때 적용); 최신 head의 별도 새 리뷰 완료로 단정하지 않음. Lab은 요청1회 후 봇응답 미확인. 요청/진행과 완료 구분, 무한 폴링 없음. Web 기존 밀링FILE 미해결1건은 범위 밖 유지.
- **다음:** 사용자는 추가 CodeRabbit 결과와 BE 후속이 남음을 알고 이번 준비를 마감하도록 했다. 재개 시 현재 head/리뷰를 한 번 확인해 유효한 새 지적만 처리하고, 사용자 전달 BE 명세·새 설정 디자인을 해당 범위에 반영한다. 현재 알려진 이유만으로 양앱 대규모 재수정/전수검수를 반복하지 않는다. configurableAuthorities는 사용자가 현 범위에서 제외했고 새명세 안내 후 대응. 본체외 Home·이메일·OS배지 개선은 별개. 자동 조회·병합·배포 없이 대기.

### 이번 검증과 기록 경계

- Web PR4862는 마케팅 release f0e180fe0를 충돌 없이 통합했다. 알림 소스와 직접 교집합0. 최종 Clinic PC1440/mobile390의 마이페이지 마케팅 표시·펼침·알림벨→설정을 실제 DEV GET으로 확인(JS 오류0, 서버쓰기0). Lab 마케팅 기능을 새로 추가하지 않았다.
- Office release 통합 커밋543d3c88, 리뷰 보완ef29e3e6590c578bc685591db4f3190d28dfe480. 공통 useUserQueries의 ScopedRequestConfig 중복 import 정리. 관련 기존6suite60+외부회귀35 통과, lint오류0/기존경고8. 최종 양OS 2.2.5에서 Profile마케팅/알림설정·교차소속native주문랜딩/인박스복귀·크레딧실조회 및 NY/Seoul 날짜경계 확인. 로그인유지·403없음. Android 처음 설치는 실제2.2.4였으므로 오전 생성된2.2.5(135) APK를 재설치하고 최종 확인했다. 신규native수정/새빌드 없음.
- Office reviewer nitpick의 최신 GET fixture도 현재 동작을 검증하도록 보강했다. outside-diff의 주문생성 extractOptions·밀링생성DTO 계약은 이 기능 밖이므로 임의 수정하지 않고 PR에 경계를 기록했다. 주문상세본체/테스트는 main 그대로다.
- Lab 최종916610e8e1f4c2ca9f67d0f558444059ad1d1acf, source2files+기존test2files. 14tests/lint오류0·기존경고10. 실제1.0.6양OS설정렌더·OS차단/허용 차이 유지. 읽음 응답을 제어해 실패큐보존→다음flush성공→제거/중복없음, push/inbox읽음 후 실제 DEV목록·미읽음·다른소속GET은 유지하고 settings GET0/값불변 확인. 읽음서버쓰기0·실제푸시발송0. 임시서비스/저장소원복. Office/Lab 앱과 자체Metro8081/8082종료, 기기는부팅유지.
- Lab 테스트보강은 사용자에게 AGENTS360의 명시승인 규칙을 설명했고 사용자가 허용했다. 대상 __tests__/queries/useNotificationQueries.test.tsx와 __tests__/utils/fcmHandler.test.ts는 모두 이번알림센터브랜치에서 추가한 파일(release대비A; 원커밋2c638fa/f0e2bc7)임을 확인해 사용자에게 설명했다. 다른 업무 기존테스트를 확장한 것이 아니다.
- 웹은 동일 읽음 성공 경로가 이미 inbox/unread/otherEmployers만 갱신해 settings를 제외하므로 추가 수정 불필요. Lab은 Office와 query-key형태가 달라 배열마지막 settings를 검사했다. 제품별 차이를 무시하고 그대로 복사하지 않았다.
- Web review요청 https://github.com/Innvoaid/dentlink-client/pull/4862#issuecomment-6912944494 / 접수6912954174. Office 재요청6913173027 / skip응답6913175079. Lab 요청 https://github.com/Innvoaid/dentlink-lab-app/pull/42#issuecomment-6912838512 . 이후 지속 polling 없음.
- 임시검증근거: /tmp/office-release-review-{ios,android}-final-1116.json, profile/credit/date fixture이미지; /tmp/lab-review-final-{ios,android}-read-1116.json 및 settings이미지. 실제기기/푸시발송·OTA검증으로 확대하지 않는다.
- 기존개발배포 Web7c8eef28c, Officev147(target2.2.4), Labv46iOS/v45Android(target1.0.5)는 그대로다. 신규준비코드를 자동배포하지 않았고 다음전달시 실제바이너리/버전조건을 다시 확인한다.
