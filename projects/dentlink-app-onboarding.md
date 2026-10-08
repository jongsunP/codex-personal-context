# Dentlink 앱 온보딩·작업·배포 지침

## 정본과 적용 범위 — 2026-10-08

사용자 작업 지침과 실제 앱 Git·스크립트를 대조해 정리한 개인 운영 정본이다.
웹·치과 앱·기공소 앱은 독립 저장소이며, 이 문서는 두 네이티브 앱의 공통 판단 기준을 담는다.
기능 상세·QA 이력은 해당 기능 체크포인트에 남긴다. 온보딩 최초 조사에서는 제품 코드·PR·Jira·배포를
변경하지 않았다. 이후 승인된 앱 PR 정리는 아래 최신 체크포인트를 따른다.

| 제품 | 저장소 | 개인 체크포인트 |
| --- | --- | --- |
| 웹·관리자 | `Innvoaid/dentlink-client` | [FE 조율](dentlink-fe.md)·기능별 문서 |
| 치과 앱 Office | `Innvoaid/dentlink-app` | [Office](dentlink-app.md) |
| 기공소 앱 Lab | `Innvoaid/dentlink-lab-app` | [Lab](dentlink-lab-app.md) |

- 최신 사용자 지침과 확인된 live 사실을 우선한다. Notion의 편집일·검증 표시·코드 예시는 현재 적용 증거가 아니다.
- 온보딩의 단일 저장소 설명은 분리 전 자료지만, 작업 대상 release에는 그 구조가 남을 수 있다.
  **선택한 브랜치의 실제 구조·진입점·앱별 package 버전을 우선**한다. main/develop의 `src/`와
  구 릴리스의 `apps/lab`·`shared/`를 구분하고, 레이아웃 변경을 작업에 자동 포함하지 않는다.
- 로컬 개발은 기존 [개발 지침](dentlink-app-development-guideline.md)과
  [실행 체크리스트](dentlink-app-local-development.md)를 함께 읽되 제품별 최신 명령을 확인한다.

## 사용자 확정 정책

### 앱 release·PR

- 앱 PR은 **해당 제품의 이미 존재하는 최신 유효 `release/vX.Y.Z`**를 기본 대상으로 한다.
  매 업무마다 release를 새로 만들지 않는다. 같은 바이너리와 호환되는 CodePush는 기존 release를 유지할 수 있다.
- PR 대상과 feature 시작 커밋은 구분한다. `main`·`develop`·release의 트리, 선행 변경, 작업 의존성을 확인한다.
  웹의 `origin/master` 규칙이나 폐기된 모노레포의 develop 규칙을 앱에 자동 적용하지 않는다.
- 실제 운영 버전과 최근 PR을 확인한다. 과거 `release/office/*`·`release/lab/*`나 태그를 현재 목표로 오인하지 않는다.
- PR 생성·재오픈 후 자동화가 끝나면 **실제 base와 전체 diff를 재확인**한다.
  관련 없는 분리·기능 커밋이 섞이면 선행 통합을 별도로 판단한다. `MERGEABLE/CLEAN`은 범위 검증이 아니다.
- 새 바이너리가 필요한 변경 또는 확정된 출시 계획이 있으면 앱 개발자·실제 배포 계획에 맞춰 버전과 release 신설을 판단한다.
  이 지침은 release 생성·삭제, PR 변경·merge, 태그 생성·배포를 자동 승인하지 않는다.

### 제품별 Jira 카드

- 승인된 신규 업무 접수에서 웹·치과 앱·기공소 앱의 영향을 각각 확인한다.
  영향 있는 제품의 기존 카드를 재사용하고, 묶여 있지만 해당 카드가 없으면 제품별 카드를 만든다.
- 항상 3장을 만들지는 않는다. 대상 아님은 근거를 기록하고, 미확정은 확인 전까지 미확정으로 남긴다.
  기존 담당자 카드와 실제 Jira 계층을 확인해 중복·임의 재배정·불가능한 하위 구조를 피한다.
- 공통 상위 요구·API 계약을 연결하되 요구사항, 제품 PR, 검증, QA, release 통합, 배포 상태는 각 카드에서 관리한다.
  다른 제품의 완료를 해당 제품의 완료 근거로 사용하지 않는다.
- 사용자 담당 하위 카드에 구체적인 제목·필요한 본문·짧은 진행 댓글을 정리한다.
  상위 댓글은 명시 요청할 때만 작성한다. 카드 분리가 세션·폴더·worktree 분리를 강제하지 않는다.
- 이번 지침 저장은 기존 Jira 전체 재분류 요청이 아니다. 신규·재개 업무에 적용하며 기존 대량 정리는 별도 범위다.
  공통 세부 규칙은 [Jira Work Updates](../AI_WORKFLOW.md#jira-work-updates)를 따른다.

## 앱 업무의 기본 순서

1. 개인 컨텍스트 동기화 → 제품별 Jira/요구·디자인/API 범위 → 정확한 앱 저장소·작성 세션 확인.
2. live Git의 branch·HEAD·upstream·dirty·worktree·원격 release·PR·전체 diff를 확인하고 작업 기준을 정한다.
3. 네이티브 영향과 실제 설치 바이너리 호환성을 확인해 CodePush 또는 스토어 경로를 판단한다.
4. 해당 제품의 가까운 코드·생성 API·팀 문서·환경별 설정을 대조한다. 미확정 BE 계약이나 UI를 임의로 추가하지 않는다.
5. 구현·코드 검증 → 해당 플랫폼 로컬 QA → 적절한 시점의 다른 플랫폼·필요 실기기 QA를 구분한다.
6. 승인 범위 안에서 commit/push/PR을 처리하고 실제 release 대상·리뷰·diff를 다시 확인한다.
7. merge·태그·업로드·활성화·설치·스토어 제출·심사·출시·서버 호환성을 각각 확인하고 개인 체크포인트를 저장한다.

## CodePush와 스토어·버전 개념

| 항목 | 판단·확인 |
| --- | --- |
| CodePush 후보 | JS/TS·스타일·지원 asset. 설치 바이너리에 필요한 네이티브 기능이 이미 있는지 확인 |
| 새 바이너리 | 네이티브 코드·SDK/Pods/Gradle·권한·플랫폼 설정·아이콘/시작 화면 또는 새 네이티브 의존성 |
| 앱 버전 | 현재 분리된 저장소의 루트 package 버전, Android versionName, iOS MARKETING_VERSION 일치 |
| 플랫폼 빌드 | Android versionCode와 iOS Build Number는 별도. Office/Lab 버전도 독립 |
| Git 태그 | 소스 시점. 현재 분리된 저장소는 `vX.Y.Z`, 후속 `vX.Y.Z.N` 형태이나 실제 workflow를 재확인 |
| CodePush 라벨 | Revopush의 앱·플랫폼·deployment별 실제 라벨. Git 태그 접미사와 숫자가 같다고 가정하지 않음 |
| 실행 증거 | 제품·repo/HEAD·OS·환경·기기·바이너리 버전/빌드·설치 방식·실제 적용 라벨 |

- `targetBinaryVersion`은 checkout의 앱 package 버전을 사용한다. 다른 설치 버전까지 자동 지원하지 않는다.
- Development/Staging 업로드, Production disabled 업로드, 활성화·rollout·기기 적용을 별도 상태로 확인한다.
  현재 tag workflow는 Git 태그·GitHub Release만 만들며 OTA 업로드나 스토어 출시를 수행하지 않는다.
- Debug/Metro는 CodePush 경로를 검증하지 않는다. OTA는 맞는 바이너리의 Release 실행·설치/재실행 증거가 필요하다.
- iOS DEV/STG는 TestFlight, Android DEV/STG는 Firebase App Distribution 경로를 사용한다.
  Production Fastlane의 iOS App Store Connect 업로드와 Android Play production draft는 심사 제출·출시와 다르다.
- 테스터 초대·접근·정확한 빌드 설치·기능 QA도 별도다. 초대 안내 문서 열람은 실제 권한·설치 완료 증거가 아니다.
- CodePush mandatory와 서버 metadata의 스토어 강제 업데이트 `isForceUpdate`는 다른 기능이다.
  강제 스토어 업데이트는 대상 스토어에서 실제 설치 가능한 버전과 BE 호환성을 먼저 확인한다.

## 온보딩에서 유지할 모바일 판단 기준

- 첫 설치·Cold Start·foreground/background·복귀·OS 종료/재실행·업데이트 전후를 기능 영향에 맞게 검증한다.
  Metro 연결·첫 화면·로그인·실제 기능 QA·실기기·양 플랫폼 확인 범위를 서로 대체하지 않는다.
- 푸시는 FCM 수신/토큰, Notifee 표시/클릭/채널, 각 서비스의 제어 메시지와 앱 이동을 구분한다.
  permission·로그인·CodePush·navigation 준비·중복 메시지·그룹 전환을 관련 시나리오에서 확인한다.
- 딥링크는 OS 등록·Airbridge 전달/fallback·JS 경로/그룹 전환·앱 준비 이후 이동을 나눠 확인한다.
  설치 후 Deferred 복원과 설치 앱 내부의 준비 대기는 별개다. Scheme 성공은 Universal/App Link 성공을 뜻하지 않는다.
- WebView 브릿지는 웹 발신·앱 수신·화면별 응답을 함께 확인한다. 오래된 예시 이벤트 목록을 전체 계약으로 보지 않는다.
  앱/환경별 실제 스킴과 route·필수 인자를 확인하며 `openurl` 전달 성공과 목표 화면 진입을 구분한다.
- OS 알림 권한과 서버 사용자 알림 설정은 별개다. 토큰 갱신 콜백뿐 아니라 store 변경을 감지하는 등록 경로까지 추적한다.
  Firebase/APNs 설정 존재나 Console 발송 성공으로 표시·클릭·조회·배지까지 성공했다고 보고하지 않는다.
- Lab 승인 문구 변경은 [번역 지침](dentlink-lab-app.md)의 리소스·앱 운영 Sheet·PM 확인·생성·검증까지 포함한다.
  문구를 커밋하기 전 실제 key/Sheet 대조를 진행하고 PM 상태·다른 작업을 보존한다. Office 영문 UI와 웹 Sheet는 별개다.
- 카메라·사진·파일·알림 등 권한과 Safe Area·키보드·뒤로가기·작은 화면을 관련 변경에서 확인한다.
  문서의 QA 항목이나 스마트 배너 제안을 새 UI 요구사항으로 자동 채택하지 않는다.
- Reactotron은 개발 연결·네트워크 관찰 도구다. SDK·패치 파일·설정 존재는 실제 연결·설치 적용을 증명하지 않는다.
- 채널톡은 현재 Office 범위이며 Lab 기능으로 자동 확대하지 않는다. 제품별 통계/로그는 실제 설정·기존 이벤트 계약을 따른다.
- 오류 보고에는 재현 시점·진입 경로·앱/OS/환경·바이너리·적용 라벨·설치/업데이트 경로를 기록한다.
  인증 정보·환자 데이터·env/키 첨부의 실제값은 개인 문서에 복사하지 않는다.

## 최신 앱 PR 정리 — 2026-10-08

- [앱 전달 정책](../SESSION_WORKFLOW.md#dentlink-app-release-and-delivery-policy)에 요청한 변경만
  최종release에 전달하는 기준을 추가했다. 분리 이력이 섞이면 release에서 새 feature를 만들고
  실제 필요한 변경만 옮긴다. broad foundation PR을 기본 선행 조건으로 삼지 않는다.
- Office #318은 이미 release 대비 배지3파일뿐이어서 그대로 유지했다. 최신 APPROVED/CLEAN이다.
- Lab 기능은 #6 `feature/lab/DL-16652-release / e3bf335` → 기존release/v1.0.4(20파일),
  번역 운영 문서는 독립 #5 `feature/lab-i18n-workflow-release / 2fb6e8b` → 같은release(3문서)다.
  기존 #2/#3와 불필요한 기반 #4는 CLOSED/미병합이며 source branch는 보존했다.
  둘 다 올바른base·전체diff·검사완료·MERGEABLE/CLEAN·미해결0을 확인했다. 실제merge/배포는 미실행이다.
- 세부 검증·QA 경계는 [DL-16652](dentlink-patient-list-design.md)와 [번역 전달](dentlink-lab-app-i18n.md)을 따른다.
  아래 live 표와 diff확대 기록은 이번 정리 이전의 정책 조사 이력이다.

## 이전 live 확인과 문서 차이 — 2026-10-08 정책 조사

| 제품 | 최신 정식 원격 release | 확인된 최근 PR |
| --- | --- | --- |
| Office | `release/v2.2.4` / `14557194c12f8836362d3663b27ab3b621c0478a` | #314·#316 병합, #317·#318 open; 모두 해당 release 대상 |
| Lab | `release/v1.0.4` / `cb585775ca21e27949e67758a5933139cfc567d8` | #2·#3 open; 모두 해당 release 대상 |

다음은 발견된 상태이며, 이번 지침 작업에서 제품 코드·PR·release를 수정하지 않았다.

- 양 앱 `auto-pr-title.yml`은 Jira feature PR 생성·재오픈 시 base를 develop으로 변경한다.
  사용자 기본 release 정책과 충돌하므로 PR 실제 base read-back을 기본 절차로 둔다. 자동화 변경은 별도 작업이다.
- Lab release는 **분리 이전 monorepo 트리**이며 현재 main/develop에는 분리·기존 수정 등 6개 추가 커밋이 있다.
  #3은 현재 981파일·7커밋(+2740/-39781), #2는 991파일·10커밋(+3419/-39975)이다.
  앱별 최신 release라는 이유로 이 선행 통합 차이를 무시하지 않는다. 자세한 #3 상태는 [번역 전달](dentlink-lab-app-i18n.md)이다.
- 양 앱 원격에는 현재 버전의 후속 태그만 있고 기본 `v2.2.4`/`v1.0.4` 태그가 없다.
  현 workflow는 기본 태그가 없으면 먼저 그것을 만든다. 다음 태그를 `.82`/`.12`로 단정하지 않는다.
- 배포 라벨 workflow는 실제 Development 명령과 환경 전달 제한이 있고 Store job은 주석이다.
  PR 라벨을 붙였다는 사실을 Production/Store 배포 성공으로 보고하지 않는다.
- Office native 자동 패치 범위와 루트 Notifee/Airbridge 패치 위치가 다르다.
  깨끗한 설치 시 실제 적용 여부는 미검증이다. 관련 SDK/빌드 작업에서 재확인하며 이번에 수정하지 않았다.
- 현재 native 강제 업데이트의 점 제거식 버전 비교에는 버전 순서를 왜곡할 여지가 있다.
  실제 metadata·스토어·실기기 강제 업데이트는 이번에 검증하지 않았다.
- 최신 DeepLink 문서와 기존 경로가 공존하고 현재 코드가 양쪽을 지원할 수 있다.
  문서 하나만 보고 경로를 통일·삭제하지 않는다. 원격 Airbridge/OS 연결 설정·실기기 복원은 별도 검증이다.

## 자료 열람 기록

- 원본: [APP 온보딩](https://app.notion.com/p/3cece072e82f80aaae7cf98e9dd19aa9), 편집 2026-09-15.
  fetch는 `truncated=true`, alias 21개 원본을 표시하지 않았다. 사용자가 2026-10-08 실제 링크 21개를 제공해 대조했다.
- 아래 21개 목록은 사용자 원본 링크 기준이며 모두 반환 본문을 읽었다. 확인 가능한 관련 하위 문서도 분석하고,
  문서별 미해석 블록·역사 정보는 완독/현재 적용과 구분한다. 비밀 첨부·키/계정 이미지는 열지 않았다.
- Notion `verification=unverified`는 모두 동일하며 편집일이 현행성을 보장하지 않는다.
  `truncated`/`unknown` 미제공도 `false/0`이라는 의미가 아니다.

| 번호 | 사용자 제공 문서 | 마지막 편집 UTC 날짜 | 본문 반환 한계 |
| --- | --- | --- | --- |
| 1 | [APP 프로젝트 시작](https://app.notion.com/p/3c6ce072e82f80e58f0fdf8c8d3b9db6) | 2026-08-24 | 제한 메타 미제공·분리 전 구조 |
| 2 | [APP 배포 프로세스](https://app.notion.com/p/269ce072e82f80039e1de9c798213eef) | 2025-09-10 | 제한 메타 미제공·이후 명령/적용 시점과 대조 |
| 3 | [Revopush(CodePush) 정리](https://app.notion.com/p/23ace072e82f80a88079fd00af3f1548) | 2026-09-01 | truncated=true·외부 객체 1개 미해석 |
| 4 | [DeepLink 관리](https://app.notion.com/p/24cce072e82f80c1b289d9d83dc5c497) | 2026-06-19 | 제한 메타 미제공·아래 16개 버전 조회 |
| 5 | [Fastlane](https://app.notion.com/p/2a8ce072e82f805fb462e21ee048d8d7) | 2026-09-01 | truncated=true·Match 외부 객체 1개 미해석 |
| 6 | [RN↔WebView 브릿지](https://app.notion.com/p/2a1ce072e82f80428e2ded605bd19545) | 2025-11-04 | 제한 메타 미제공·부분 이벤트 예시 |
| 7 | [Airbridge 서비스](https://app.notion.com/p/3cece072e82f80fca091c251c5b2df50) | 2026-09-01 | 제한 메타 미제공 |
| 8 | [딥링크·디퍼트·유니버셜 링크](https://app.notion.com/p/3cece072e82f80ff9950d263410a6199) | 2026-09-01 | 제한 메타 미제공 |
| 9 | [Notifee](https://app.notion.com/p/3cece072e82f8080a2f6f96a0134129e) | 2026-09-01 | 제한 메타 미제공·패치 설명은 현행 대조 |
| 10 | [Firebase Console Messaging(FCM)](https://app.notion.com/p/3cece072e82f80628d39f9ee25a53381) | 2026-09-01 | 제한 메타 미제공·공식 명칭은 Cloud Messaging |
| 11 | [앱 다국어 기능](https://app.notion.com/p/3cece072e82f80cfa59ee5b7e91f6dc9) | 2026-09-01 | 제한 메타 미제공·Lab 전용 |
| 12 | [앱 채널톡 기능](https://app.notion.com/p/3cece072e82f80d2903acf0a6051a2f3) | 2026-09-01 | 제한 메타 미제공·Office 전용 |
| 13 | [Reactotron 세팅](https://app.notion.com/p/3b2ce072e82f80f9a5a9ee60923437ae) | 2026-09-04 | 제한 메타 미제공 |
| 14 | [딥링크 테스트 방법](https://app.notion.com/p/3cece072e82f80b08d69d52892296591) | 2026-09-03 | 제한 메타 미제공·myapp 스킴은 예시 |
| 15 | [In-App 업데이트 기능](https://app.notion.com/p/3d0ce072e82f8012b472d788b6a41a5b) | 2026-09-03 | 제한 메타 미제공·native 강제 업데이트 |
| 16 | [앱 버전 정책](https://app.notion.com/p/3d0ce072e82f80c59166cf38a1714f58) | 2026-09-03 | 제한 메타 미제공·버전/경로/태그 예시는 과거 |
| 17 | [기능 릴리즈 처리 순서](https://app.notion.com/p/3d0ce072e82f80f89b48e38184e9ab11) | 2026-09-03 | 제한 메타 미제공·현재 자동화와 단계별 대조 |
| 18 | [APP 모노레포 브랜치 전략(deprecated)](https://app.notion.com/p/39fce072e82f80f99f47e7161c1adf1f) | 2026-10-06 | 제한 메타 미제공·현행 정책으로 사용하지 않음 |
| 19 | [Testflight(iOS) 사용자 초대](https://app.notion.com/p/3d1ce072e82f8088b278ffa239403f12) | 2026-09-04 | 제한 메타 미제공·실제 초대/설치 미검증 |
| 20 | [App Tester(Android) 사용자 초대](https://app.notion.com/p/3d1ce072e82f809ba335d3a193276ffa) | 2026-09-04 | 제한 메타 미제공·실제 권한/설치 미검증 |
| 21 | [현재 로컬 코드 기준 앱 버전 찾기](https://app.notion.com/p/3d1ce072e82f8082b6c0d2cb47f1438d) | 2026-09-04 | 제한 메타 미제공·설정값과 실제 배포는 별개 |

추가로 확인한 연결·보조 자료:

- DeepLink 관리 DB는 `has_more=false`로 **16개 버전 문서 전체**를 조회했다.
  최신 [Office 2.2.4 / Lab 1.0.4](https://app.notion.com/p/3e3ce072e82f8040a09bf55e4b16b05c)는 2026-09-28 편집이다.
  버전별 기록은 역사이며 DB의 배포 완료 표시가 오늘의 설치·배포 증거는 아니다.
  v1.8.0.11의 Figma unknown_mention은 해석하지 못했다.
- [CI 파이프라인](https://app.notion.com/p/2afce072e82f808da5a7e29b9974905d)은 2026-09-15 편집이며
  feature→release 정책 참고와 배포 제안·예시가 섞여 있다. 실제 자동 동작은 live workflow로 확인하되,
  작업 정책은 최신 사용자 지침을 우선한다.
- [APP 기공소 분리 설계(deprecated)](https://app.notion.com/p/391ce072e82f80c18322e5237a2a47c7)는
  모노레포 당시 경계 설계이며 현재 두 저장소 구조를 대체하지 않는다.
- [FE APP 파트 온보딩](https://app.notion.com/p/21bce072e82f809eb2d0ef88b707cac7)은 2025-08-04 편집,
  truncated=true·외부 객체 4개 미해석이다. 오래된 실행/설치 절차를 현재 규칙으로 복사하지 않았다.
  직접 연결된 [개발 Convention](https://app.notion.com/p/24f2db18356d4991bf71bc8698264fae)과
  [Commit](https://app.notion.com/p/05bca3cf3f3c4ab2a27e9e6af02706ef)·
  [배포](https://app.notion.com/p/27c78698ab1a4a02a26bf3646133cd43)·
  [PR](https://app.notion.com/p/b828070add00404487e44e27e9feebb3)·
  [Coding](https://app.notion.com/p/17a50663044749678f00e572d0ef4d68)의 실제 하위 4개를 읽었다.
  웹 규칙과 과거/신규 공존 규칙을 앱에 일괄 적용하지 않는다. 즐겨찾기 4개는 관련 범위가 확인되지 않았다.
- [과거 Dentlink 앱 배포](https://app.notion.com/p/385511f94f2e42f5a8d4a7b1b3ed23da)와
  [Web-to-App 스마트 배너](https://app.notion.com/p/37ace072e82f8076ad78edcfba577e0b)도 대조했다.
  수동 env 교체나 신규 배너 UI를 이번 기본 작업으로 채택하지 않았다.
- 직접 참조된 [Revopush 시작 가이드](https://docs.revopush.org/intro/getting-started)·
  [SDK](https://github.com/revopush/react-native-code-push)·
  [이전 Microsoft SDK](https://github.com/microsoft/react-native-code-push)·
  [Airbridge Web SDK](https://help.airbridge.io/en/developers/web-sdk)의 관련 내용을 대조했다.
  지원표 차이는 SDK 자동 업그레이드 승인이 아니다.

실제 소스 근거:

- [Office PR 목록](https://github.com/Innvoaid/dentlink-app/pulls)·
  [Lab PR 목록](https://github.com/Innvoaid/dentlink-lab-app/pulls), 제품별 main/develop/release tree·PR base/diff.
- [Office README](https://github.com/Innvoaid/dentlink-app/blob/main/README.md)·
  [Lab README](https://github.com/Innvoaid/dentlink-lab-app/blob/main/README.md), package scripts·버전 검증·Fastlane·
  auto-pr-title/pr-label-deploy/tag-production-codepush workflow·관련 src 통신/알림/버전 코드를 읽기 전용으로 확인했다.
- 실제 Production 활성화/rollout/기기 적용, 스토어 심사/출시, Firebase/APNs/Airbridge 콘솔,
  현재 테스트 계정 접근·초대는 확인하지 않았다. 별도 승인·실제 증거가 필요한 운영 단계다.
