# 통합알림센터 재개 준비 · 다른 에이전트 이력 동기화

- 확인: 2026-11-12 19시대 KST, 사무실 Codex 통합알림센터 세션.
- 요청: 다른 에이전트의 기록·세팅·지침과 알림센터 변경을 파악하고 이 세션을 최신 상태로 맞춘다. 초기 목적은 추가 개발보다 재개 준비다.
- 이번 실행: 공통/프로젝트 정본과 Claude/Codex 관련 메모리·세션 정보, 세 제품 Git/PR, Jira·Notion·Slack·Swagger·DEV GET·Figma 본문을 대조했다. 개인 지침/체크포인트를 보완했다. 제품 코드, 브랜치, PR, 배포, 서버/기기 실행은 변경하지 않았다. 외부 자료도 읽기 전용이다.
- 여기서 '완료'한 것은 동기화/지침 점검이다. 아래 제품 구현은 다른 에이전트가 이미 한 일이며, 이번 Codex가 새로 개발·검증했다고 보고하지 않는다.

## 1. 공통 운영에서 받아들인 변경

- 사무실/집 × Claude/Codex는 독립 메인 세션을 둔다. 큰 기능은 기능 전체를 맡는 상시 작업 세션 하나가 담당한다. 기존 Codex 구성은 유지하며 Claude와 똑같은 배치로 바꾸지 않는다. 인계 후 요청 없는 추적·폴링·중복 검증을 하지 않는다.
- 이 세션은 기존 통합알림센터 기능 맥락을 이어받는다. Claude의 같은 기능 기록은 확인했지만 메시지를 보내거나 병렬 작성을 시작하지 않았다. 제품 변경 전 다시 현재 작성자/dirty/HEAD를 확인한다.
- 개인 정본은 이 저장소. `claude-personal-context` 원격 아카이브는 읽거나 복원하지 않았다. 현재 Claude 로컬 메모리와 Codex 로컬 메모리는 관련 기록만 참조했다. 별도 OpenAI 이름의 로컬 Git 저장소는 확인되지 않아 OpenAI 측 정보는 현재 Codex 설정·메모리·채팅 등록 정보로 대조했다.
- `AGENT_INBOX.md`의 사무실 Codex 및 공통 항목 중 자신의 적용 상태를 갱신했다. 다른 기기/에이전트의 항목은 처리하지 않는다. `setup-local-codex.sh`로 최신 공통 문서를 로컬에 동기화했다.
- Lab 번역은 현재 ko/en 코드만 관리한다. 과거 Sheets 동기화 명령을 실행하지 않는다. Swagger 생성물은 그대로 커밋하고 보정은 FE 가공 계층에 둔다.
- 사용자 앱 미리보기는 에이전트 밖 실행과 양 OS/Reactotron 연결까지 한 세트다. 혼자 작업할 때 내부 실행은 허용된다. 제품별 양 OS는 같은 소스·환경·Metro를 사용한다. 별도 제품은 별도 Metro(보통 Office8081/Lab8082). Xcode27.2의 실제 시뮬 UI는 DeviceHub이며 로컬 `.command` 실행 파일이 마련돼 있다. 이번에는 기존 화면/프로세스를 조작하지 않았다.
- 신규 브랜치 `feat/<Jira>`, 기존 feature 브랜치 유지, 앱 PR 제목/스쿼시 규칙, 명시적인 배포 승인 경계도 최신 정본대로 적용한다.

## 2. 정확한 제품 위치와 Git/PR

| 제품 | checkout | branch / HEAD | 원격·PR 상태 |
| --- | --- | --- | --- |
| 웹 Clinic/Lab | `/Users/parkjongsun/Repository/dentlink-client-notification-center` | `feature/DL-17058` / `7968ad66b1fc3bce231daea471d0e062685e7c0d` | clean, upstream과 0/0. PR4862 → release/v1.94.0, Draft/[WIP]/DRAFT, 리뷰 대기 |
| Office 앱 | `/Users/parkjongsun/Repository/dentlink-app` | `feature/DL-17059` / `4ed34bfb62a990386e8babc9fe5a431ccb317eed` | clean, 0/0. Draft PR346 → main |
| Lab 앱 | `/Users/parkjongsun/Repository/dentlink-lab-app` | `feature/DL-17060` / `0f03901acec94fae2f20236374c57e04ef2be244` | clean, 0/0. Draft PR42 → main |

- 양 앱은 현재 origin/main을 포함한다. 웹 feature에는 최신 master `9c4418a8f`의 Admin invoice/version 커밋 1개가 아직 없다. 최신화를 수행하지는 않았다.
- 웹 develop `feb488a21`에는 11/10 CodeRabbit 보완 `38ca4edae`가 이미 포함돼 있다(PR4865 포함, 4863/4864/4865 병합 기록). '이 보완이 아직 develop에 없다'는 과거 설명은 현재 상태가 아니다.
- 반면 **11/12 새 설정 API 이전은 develop에 없다.** DEV BE 응답은 이미 바뀌었으므로 개발서버의 구형 설정 화면과 최신 feature 코드는 다르다. 구형 develop 코드/새 응답의 불일치를 확인했으며, 이번에 브라우저에서 오류를 재현한 것은 아니다.
- 마지막 이 세션의 앱 Development CodePush 기록은 Office2.2.4 v142/Lab1.0.5 v40(11/10)이다. 11/12 변경은 Git push 완료이며 새 배포가 아니다. 이번에 OTA 서버/기기 수신 상태를 다시 조회하지 않았다.
- PR 본문은 일부 11/10 검증·SHA 기준이다. 최신 구현/검증을 정리한 뒤 PR 업데이트가 필요하며 이번 동기화에서는 수정하지 않았다.

## 3. 다른 에이전트가 추가·변경한 알림센터

- 설정 GET/PUT 경로는 유지: `/office/notifications/settings`, `/lab/notifications/settings`. 응답은 과거 `{view, setting}`에서 `{user, employee}` 및 카테고리 배열로 교체됐다.
- 표시 순서는 **user → employee**, 각 영역은 서버 순서. 도메인/카테고리 표시명은 PM 매핑을 적용하며 연속된 행만 그룹화한다. 주문 범위 선택은 서버 `orderScopeOptions`가 2개 이상일 때만 보인다. FE가 역할을 임의 추론하지 않는다.
- 저장은 최신 GET 전체를 바탕으로 변경한 항목만 반영하되 전체 교체 계약을 지킨다. 읽기용 메타(`domain`, `toggleChannel`, `orderScopeOptions`)를 제거하고 숨긴 채널 값은 보존한다. null 주문 범위·생략된 선택 필드는 계약대로 처리한다.
- 생성 `NotificationApi.ts` 수작업 파일은 제거했다. 필요한 FE 타입은 별도 가공 계층으로 옮겼다. 필수 categories 누락, null 행·채널·인박스/소속 원소는 서비스 오류→기존 Retry로 처리하고 불완전한 응답에서 PUT을 막는 보완이 이미 push됐다.
- Swagger 재생성에 따른 Office 상품 DTO 이름 충돌은 `catalog.types.ts`와 기존 주문/ISV import 보정으로 분리했다. Lab/Web 밀링 파라미터 타입 보정도 포함돼 있어 공용 소비처 확인을 알림 화면만으로 끝내면 안 된다. 생성물 큰 diff를 모두 새 제품 기능으로 해석하지 않는다.
- **웹 PUSH 숨김은 임시 추론이다.** `toggleChannel === PUSH`는 노출 플랫폼의 뜻이 아니어서 MAIL까지 잘못 숨길 가능성이 있다. DL-17114 댓글44994에서 사용자가 별도 노출 키를 요청했다. 현재는 유지하며 키가 확정되면 웹/앱 모두 해당 계약으로 바꾼다.
- PM은 User Credits 제외 방향을 언급했지만 최신 사용자 지시는 매핑/서버 항목을 당장 숨기지 않는 것이다. 현재 Office DEV 응답에도 user CREDITS가 있다. 확정 반영 전 임의 제거하지 않는다.
- OS OFF 설정 화면 배너는 **상시 노출**, 앱 진입 안내 팝업은 **화면과 관계없이 기기당 1회**다. 오래된 '설정 화면 배너도 1회'는 대체됐다. Office 팝업의 `Get Lab Updates Instantly`는 현재 디자인과 같아 유지하기로 한 결정이다.

## 4. 현재 근거와 확인 한계

| 출처 | 이번 확인 | 결론/한계 |
| --- | --- | --- |
| [Notion 정책](https://app.notion.com/p/innovaid/3c7ce072e82f811184a8e647444f01fd) | 마지막 수정 11/11 13:56 KST, 본문·제공된 discussion preview | 최신 정책과 새 서버 계약 우선. 일부 과거 독립 설정 표현/목업은 새 계약과 불일치. 모든 댓글·첨부를 열었다는 뜻은 아님 |
| [BE DL-17114](https://innovaid.atlassian.net/browse/DL-17114?focusedCommentId=44978) | 44978 새 GET/PUT 계약, 최신44994 노출 키 요청 | 19시대 조회 시 노출 키 답변 없음. 상위DL16140 댓글만 읽으면 새 BE 계약을 놓침 |
| [DL-16140](https://innovaid.atlassian.net/browse/DL-16140)와 자식 | 상태·본문/필요 댓글 조회 | 본인 카드 본체 개발 상태와 Home3 ToDo가 분리돼 있음. 이번엔 상태/본문/SP 변경 없음 |
| [PM 표시명 Slack](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794306299283819) | 현재 스레드 읽음 | User Credits 제외 언급과 사용자의 매핑 유지 지시를 구분 |
| [DEV Swagger](https://dev-api.dentlink.io/v3/api-docs) | HTTP200, 실제 설정 schema 확인 | `{employee,user}` 현재 제공. 생성 재실행은 하지 않음 |
| DEV 실응답 | 기존 Keychain 테스트 계정으로 Office/Lab 각1개 로그인 후 설정 GET만, 모두HTTP200/code0000 | 새 구조, Office userCREDITS 있음, Labuser비어있음, Lab주문범위null/options빈배열, 양쪽 플랫폼 구분키없음. 설정PUT/소속변경/기기등록은 하지 않음. 전체 권한/계정 QA 증거가 아님 |
| [Figma OS 정책173:28434](https://www.figma.com/design/QLIzKYWzFFlptCYzN36Iq4?node-id=173-28434), 권한405:25991, Lab167:25825/182:22523 | 본문·인스턴스 내부 문구 직접 조회 | 배너/팝업 정책 일치. Credit순서·Shipping중복·LabEmail 등 오래된 샘플 잔존. 정책/BE 우선. 도구에 일반 댓글/멘션/파일수정시각 조회 기능이 없어 최신 댓글은 확인 못함 |
| [FigJam68:463](https://www.figma.com/board/U9Qpm6ACzjGFKyrCoaAuvA?node-id=68-463) | 지정 섹션과 알림 관련33:3702 조회 | 68:463은 MEMBER 권한 섹션. 알림 섹션은 과거 목업/이미지 중심. 새 확정 변경 근거 없음 |
| [알림 현황표](https://docs.google.com/spreadsheets/d/1w1xwwEWRE0KgiJsOvldxIFbtNgWguohurf5kemIrW_g/edit?gid=614410508#gid=614410508) | 최종수정11/11 09:54:38 KST, 현재173행. 주요 랜딩·등록 경로 대조 | 과거189행 기준 셀 번호를 재사용하지 않는다. 크레딧/청구서/알림함 경로는 현재 Office 등록과 일치. 밀링 보류 P175→P159, 상세 P176:P183→P160:P167, 서포트 P172→P156. 일부 `${scheme}` 템플릿은 실제 발송 전 Office `dentlink`/Lab `dentlink-lab` 치환이 전제. 새 FE 경로/API가 필요하다는 변화는 발견하지 못했으며 전체 실발송 QA는 아님 |

로그인 토큰·비밀번호·계정/소속 ID는 출력·기록하지 않았다. 로그인에 따른 다른 기기 세션의 영향까지 검증한 것은 아니다.

## 5. 앱 지침 점검 결과와 실제 남은 일

- **점검 완료:** 생성 모델 전용/styled-components 규칙은 이미 Office·Lab CLAUDE/AGENTS에 있었다. 규칙 부재보다는 구현·최종 diff 검토에서의 적용 누락이다. 당시 어느 단계에서 읽지 않았는지는 단정하지 않는다.
- 개인 `DEVELOPMENT_STYLE.md`에 앱 구현 경계(팀 규칙 최종 대조, 서비스의 중첩 응답 검증, 불완전 응답 전체 저장 방지)를 보완했다. 앱 플레이북의 Office만/8081만/IDE터미널 강제 문구를 최신 양제품·외부 실행 원칙으로 교체했다. 팀 저장소 지침은 변경하지 않았다.
- **스타일 잔존:** Office의 NotificationScopeSelectSheet, NotificationOfficeSelectSheet, NotificationPermissionBanner, NotificationSettings, NotificationCenterScreen 5곳; Lab의 NotificationPermissionBanner, NotificationLabSelectSheet 2곳에 StyleSheet.create가 남아 있다. 기능/레이아웃을 바꾸지 않고 기존 규칙에 맞춰 정리할 대상이다.
- **최종 런타임 잔여:** 이미 push한 인박스 스타일/응답 검증 후 최종 코드의 화면 재확인은 아직 없다. 이전 설정 이전 시점의 양OS 증거로 이를 대체하지 않는다. 설정/인박스/시트 및 실제 변경한 공용 소비처의 실패·재시도를 영향에 맞게 확인한다.
- **리뷰:** Lab PR42의 3개 스레드가 미해결 상태지만 대응 코드는 push됐다. 웹 PR4862의 설정 관련2건도 코드 대응 후 스레드는 남았고, 밀링 FILE2건은 DL-17195 별도 계약이다. Office PR346 inline 미해결 스레드는 없었다. 코드 반영과 리뷰 해결 상태를 구분한다.
- **배포/QA:** 새 설정 API를 반영한 웹 개발 배포와 앱 CodePush는 별도 승인 후. PR 병합/배포/실제 사용자·FCM QA를 이번 준비 완료에 포함하지 않는다. 선택적 CodeRabbit 주석 커버리지 경고는 사용자의 보류 결정 유지.

## 6. 이전 기억을 대체하는 Android/실기기 결과

- 11/10 사용자 실기기에서 양 iOS 중복 배너 수정 확인이 이미 완료됐다. 'iOS 확인 대기'라는 과거 상태를 반복하지 않는다.
- 별도 Android Notifee 패치는 Galaxy S23에서 패치 적용 시 background/cold start 클릭 정상, 미적용 시 background 실패·cold start는 getInitialNotification 경유 성공이 확인됐다. 미적용이면 모든 상태가 항상 실패한다고 말하지 않는다.
- Office PR348과 Lab PR44는 11/11 각각 release/v2.2.5·release/v1.0.6에 병합됐다. 알림센터 feature/main에 자동으로 합쳐진 것은 아니다. 현재 feature의 native/package/lock 순변경은 main 대비0으로 확인했다. 향후 OTA 판단은 실제 바이너리/JS 조합 기준이다.

## 7. 재개 순서와 범위

1. 새 작업 시작 직전 현재 작성자·Git/기기 소스를 다시 확인한다. 이번 동기화로 기존 작업을 되돌리거나 다른 세션 작업을 중복 실행하지 않는다.
2. 앱 스타일 잔존7곳을 기존 동작 그대로 정리하고, 이미 반영된 리뷰 수정까지 포함한 최종 코드의 관련 화면·공용 소비처를 양OS에서 검증한다. BE 응답/디자인을 임의로 확대하지 않는다.
3. 알림센터 리뷰 스레드·PR 본문을 현재 코드/검증으로 정리한다. 밀링 FILE 계약은 별도 범위로 유지한다.
4. BE 노출 키가 나오면 웹/앱 조건을 그 계약에 맞춘다. 아직 키 이름·필수성·형식을 추정 구현하지 않는다.
5. 배포가 승인되면 최신 feature와 대상 branch/native를 다시 대조하고 개발 환경에 전달한다. 사용자 실기기/개발서버 QA와 코드 검증을 분리한다.

본체는 웹·양 앱 알림함/설정/소속/읽음/푸시 딥링크다. 이메일/SES/DL-17183·17187, Home3(DL-17062/17065/17068), 별도 Android 네이티브 배포는 분리한다. 추가 앱 목록 DL-17202는 관련 작업 이력을 유지하며 이번 동기화를 신규 목록 개발로 확대하지 않는다. REST 기반·실시간 동기화 제외·OS 배지 현행 푸시 수 및 0 초기화·푸시 deliveryId 읽음 계약은 유지한다.
