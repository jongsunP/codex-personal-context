# Dentlink Office App — 현재 체크포인트와 작업 기준

이 문서는 **치과 앱 `Innvoaid/dentlink-app`**의 개인 체크포인트다.
기공소 앱은 [별도 정본](dentlink-lab-app.md)을 따른다. 문서 정리는
2026-10-27에 수행했으며, 아래 날짜별 관찰을 제품·배포의 현재 상태로 재검증한 것은 아니다.
재개 전 정확한 저장소·branch·HEAD·worktree와 최신 사용자 지시를 확인한다.

## 현재 상태와 재개점

| 항목 | 마지막으로 확인·기록한 상태 | 다음 시작점 |
| --- | --- | --- |
| Production 2.2.4.87 | 11/09 iOS·Android v87 활성화 완료. PR344 main 병합, 기본 Git 태그 v2.2.4 생성 | PR345 사용자 추후 머지 대기. .87 Git 태그 복구는 별도 요청 시 이력 정리이며 배포 필수 조치 아님 |
| LinkTalk 운영 iOS SIGSEGV | 10/27 확보 가능한 범위 조사 마감. dSYM 누락으로 정확 원인 미확정 | 일치하는 archive/dSYM 또는 새 재현 증거와 별도 재개 요청이 있을 때 [조사 정본](dentlink-app-linktalk-sigsegv-investigation.md)부터 확인 |
| DL-17038 디자인 컨펌 Render Error | 수정 전 재현, PR338 수정 포함 main의 제한된 실화면 확인 완료. 테스트용 branch·실행 환경 정리 완료 | 새 결함/요청 없으면 대기. 아래 검증 범위를 전체 앱 QA로 확대하지 않음 |
| 권한관리 및 후속 QA | 10/25 Office PR329/331/332/333의 운영 Git 반영 확인. 10/26 전용 worktree 제거 | 새 요청 시 [권한관리 정본](dentlink-permission-management.md)과 기본 checkout 확인 |
| 피드백 DL-15828 / DL-16061 | PR286의 9/11 develop squash 병합·동일 tree 확인은 완료된 이력 | [피드백 정본](dentlink-client-order-feedback.md) 및 아래 이력. 과거 PR286 리뷰·BE 대기 문구를 현재 미완료로 재사용하지 않음 |

## Production 2.2.4.87 전달·main PR — 2026-11-09

- 사용자가 Staging 확인 완료 후 상용 CodePush와 main 대상 PR 생성을 승인했다. 범위를 질문해 **치과 앱만 배포, 기공소 앱은 다른 담당자가 배포**한다고 확인했다. PR 병합·Git 태그 변경·스토어 출시는 승인 범위에 포함하지 않는다.
- 배포 소스는 `release/v2.2.4@caa7ed685743665f596e175afbadbf98d5e47bd9`다. 사용자 확인 Staging iOSv345/Androidv344와 동일 소스이며 PR340/342/343의 지연 라벨·주 상태 표시 변경을 포함한다. package/Android/Xcode 버전은 모두2.2.4로 일치하고 `yarn validate:versions`가 통과했다. 이전 상용 main 대비 native/lock/entry/config 변경은 없다.
- **상용 배포 완료:** Office iOS·Android 모두 Production **v87**, target **2.2.4**, **enabled·mandatory·rollout100%**를 활성화 후 각각 재조회했다(18:29:56~57 KST). 이는 전체 대상 배포 설정이며 모든 기기의 설치 완료나 앱스토어 새 버전 출시를 뜻하지 않는다.
- 패키지 해시: iOS `4c5c301de3e2212250f94c2806ec3f4c283ce1c33f5dfe6396deea754b460bad`, Android `1a3059e7710e3c320c66ef952b7f8c0025e25fcf61d65565074a1976e88e7d2a`. 제품·OS별 임시 경로를 격리하고 Production 환경으로 새 번들 생성 → disabled 업로드 → 소스 검증 → 활성화 순서로 처리했다. 양쪽 source map의 App.tsx/OrderProgressStatus/OrderStatusBadge가 배포 SHA 파일과 일치했다.
- 첫 활성화 patch는 실패했고 iOS 신규v87이 여전히 disabled임을 확인했다. 이후 특정v87의 disabled만 false로 바꾸는 patch가 양OS에서 성공했고 기존 mandatory/rollout100이 유지됐다. 추가 업로드나 라벨 증가 없이 완료했으며 최초 실패 원인은 확정하지 않는다.
- **검증 범위:** 기존 양OS 홈·Orders 최종 코드 검증과 사용자가 이번 배포 전에 확인한 Staging QA를 재사용했다. 상태 blob `66ab1b92b22059db00d8f34cd258bd55c571828e`, 배지 blob `3b812a65c517ff3b6e463fa8477e35dafe09898b`가 검증 코드와 일치한다. 확인 범위에서 새 크래시/회귀 문제는 발견하지 못했으나 운영 전 기기 무결함을 보장하지 않는다. 배포 후 기기 수신·오류 지표를 자동 추적하지 않았다. 사용자가 이미 확인한 화면을 다시 필수 QA로 요구하지 않는다.
- **[PR344](https://github.com/Innvoaid/dentlink-app/pull/344)** 생성 후 실제 base `main`, head `release/v2.2.4@caa7ed6`, OPEN·일반 PR·미병합·mergeable을 확인했다. 기존 main `7f586790e0bbd7b288458e29f00654d38ba68da2`와의 예상 병합 tree는 release tree `421fab8080748f1baca8d7f06d984fa41a3db445`와 같다. 현재 main 대비 실제 화면 코드 차이는 상태/배지2파일이며 commit 이력의 ISV는 현재 main과 화면 코드 차이가 없다.
- **배포 직후 남았던 사항:** 기본 태그 부재 때문에 PR344 병합 시 v2.2.4.87 대신 v2.2.4가 만들어지는 조건을 발견했다. 이후 사용자 승인으로 자동화 수정 PR345까지 준비했으나, 작업 중 PR344가 먼저 병합됐다. 현재 병합·태그 상태와 다음 행동은 아래 후속 기록을 따른다. 상용 CodePush 활성화 완료 여부와 Git 후속을 구분한다.
- Jira Office DL-17248·DL-17303은 이미 `app office-v2.2.4.87`(15333)에 포함돼 있어 유지했다. 다른 제품의 누락4건 수정은 [FE 조율 기록](dentlink-fe.md)을 따른다. Jira 상태·댓글·버전 released 표시는 변경하지 않았다.
- 배포에 재사용한 `/Users/parkjongsun/.codex/worktrees/order-status-office/dentlink-app`은 detached 배포 SHA에서 원래 `feat/DL-17303@5d3daf702d49417767856fff23803ab8b57455ce`로 복귀했고 clean·upstream 동일을 확인했다. 기본 checkout과 다른 세션의 작업, 기존 branch/worktree는 보존했다. 제품 코드/환경 값 변경·새 제품 커밋·Slack 전송은 없다.
- 로컬 실행 증거: `/var/folders/42/51l4h0fx28d2_q1448z695dw0000gn/T/dentlink-office-production-20261109-_prz2h64/report.json` 및 각OS release/activate 로그·source map. 임시 파일은 다른 디바이스에 복구되는 정본이 아니며, 핵심 배포 사실은 이 기록에 보존한다.

## 자동 Git 태그 후속 수정 PR345 — 2026-11-09

- **사용자 최종 지시:** 두 앱의 수정 PR은 나중에 직접 머지할 예정이므로 정리·기록 후 대기한다. 이 마감에서 PR 상태나 배포를 다시 조회하지 않았다. 새 지시 전 리뷰 처리·병합·태그 복구·재배포·자동 감시를 하지 않는다. 태그 하나의 누락은 이미 배포된 앱의 동작에 영향을 주지 않는 이력상의 문제이며 긴급 필수 후속으로 다루지 않는다.
- 사용자는 자동 태그 설정의 코드 수정·검증·커밋·푸시·PR까지만 승인했고 직접 머지하겠다고 했다. 최신 origin/main `7f586790`에서 `feat/v2.2.4-codepush-tag`를 만들고 **57b8eabb713ec019f49fc7614a960b35302ef29f**를 푸시했다. 변경은 `.github/workflows/tag-production-codepush.yml` 한 파일이다.
- 유효한 숫자 suffix를 기본 태그 검사 전에 계산한다. suffix가 있으면 최대+1, 없고 base가 있으면 .1, 둘 다 없으면 base를 생성한다. suffix .0과 없음도 구분한다. trigger·checkout·태그 push·GitHub Release 생성·배포 라벨 조건은 변경하지 않았다. Revopush 실제 라벨을 조회해 동기화하는 기능은 아니다.
- **검증:** 실제 YAML의 next_tag shell을 추출해 임시 Git 저장소에서8조건 통과. 기본 태그 없음+.86에서 수정 전 v2.2.4를 재현했고 수정 후 v2.2.4.87 확인. 태그 없음/base만/base+.86/.0/숫자 정렬/다른 버전 및 부적합 suffix 제외도 확인했다. YAML 파싱·Bash 문법·Prettier·diff check 통과, 독립 diff 검토에서 새 결함 없음. 앱 runtime 변경이 없어 앱 재실행은 하지 않았다. 임시 증거 `/var/folders/42/51l4h0fx28d2_q1448z695dw0000gn/T/dentlink-office-tag-check-Tt4dH9/results.json`.
- **[PR345](https://github.com/Innvoaid/dentlink-app/pull/345)** 생성 후 실제 base main, head feat/v2.2.4-codepush-tag@57b8eab, 일반 PR·OPEN·미병합, 변경1파일, 라벨없음을 확인했다. 이번 feat/ branch는 태그 job 대상이 아니고 Deploy:CodePush 라벨도 없어 수정 PR 자체가 태그나 재배포를 시작하지 않는다.
- **동시 변경 확인:** 최종 PR 메타데이터 확인 중 PR344가 **18:45:30 KST**에 main으로 병합된 사실을 확인했다. merge SHA **fd775498f20e38a642b317f9d7713f66c005423a**, 원격 main도 동일하다. 원격 기본 태그 **v2.2.4**가 이 커밋을 가리키며, 확인 시점 **v2.2.4.87은 없다**. 사용자가 직접 머지하겠다고 했고 이 세션은 merge 명령을 실행하지 않았다.
- 처음 계획했던 PR345→PR344 순서는 현재 적용할 수 없어 PR345 본문을 실제 상황으로 갱신했다. **PR345를 머지해도 이번 v2.2.4.87 태그는 소급 생성되지 않는다.** 현재 CodePush와 Git 릴리즈 기록을 맞추려면 배포 코드의 PR344 병합 커밋에 별도 태그 정리가 필요하다. PR까지만 승인된 범위이므로 태그 추가/삭제·GitHub Release 변경·workflow 재실행·CodePush 재배포는 하지 않았다. PR345 검토/머지는 사용자에게 남긴다.
- 기존 order-status-office worktree는 원래 feat/DL-17303@5d3daf7로 복귀·clean·upstream 동일 확인. 신규 branch는 원격과 로컬에 보존했다. 기본 checkout/다른 작업·Lab·Jira는 변경하지 않았다. PR 전달 후 자동 리뷰·Actions·배포 결과 폴링 없이 마감한다.

## 저장소·업무 경계

- 저장소: [Innvoaid/dentlink-app](https://github.com/Innvoaid/dentlink-app)
- 기본 checkout: `/Users/parkjongsun/Repository/dentlink-app`, 기본 branch `main`.
- **10/29 사용자 변경:** 일반 feature는 최신 `origin/main`에서 시작하고 해당 release를 PR 대상으로 한다. release는 main으로 병합하며 develop은 운용하지 않는다. 실제 준비 시
  [앱 배포 정책](../SESSION_WORKFLOW.md#dentlink-app-release-and-delivery-policy)과
  [앱 온보딩](dentlink-app-onboarding.md)의 현재 지침을 먼저 읽는다.
  앱 개발자의 10/12 전달 흐름 중 다른 부분은 과거 참고이며, 현재 전략이나 배포 승인으로 재사용하지 않는다.
- Office/Lab은 9/30 저장소 분리 이후 별도 제품이다. 이 저장소의 `APP_SERVICE_TYPE=OFFICE`,
  `/office/patients/consolidate` 확인은 10/06 기록이다. 과거 공용 Lab 빌드·경로를 현재
  기공소 앱 작업 위치로 사용하지 않는다.
- 신규 작업의 세션·worktree 선택은 [공통 접수 규칙](../SESSION_WORKFLOW.md#new-work-intake-and-session-routing)을
  따른다. 완료한 `feature/DL-16061`을 신규 작업에 재사용하거나 옛 전용 worktree를
  그대로 복원하지 않는다. 제품 commit/push/PR/배포 권한도 현재 요청 범위에서 확인한다.
- 통합알림센터는 [별도 기능 정본](dentlink-unified-notification-center.md)이 담당한다.
  관련 요청일 때 최신 계약·공통 파일 소유권을 확인하며, 옛 피드백 세션의 지시를
  통합알림센터 구현 승인으로 취급하지 않는다.

## 운영 iOS LinkTalk SIGSEGV 조사 — 2026-10-27

- [Slack 알림](https://innovaidhq.slack.com/archives/C0CC6EDL78T/p1793086505051709)의 실제 이벤트는
  Office iOS Production 2.2.4(1)·CodePush v86·iOS27.0.1에서 15:26:12 KST 발생한
  LinkTalk 화면 전환 크래시다. 조사 시점 동일 issue는 사용자1명·세션1개·1건이다.
  메시지 전송/조회는200이며 main thread의 화면 그리기 경로에서 SIGSEGV가 발생했다.
- **정확 원인은 미확정이다.** Datadog UI가 운영 앱 dSYM UUID
  `04104800-AA3D-383D-837F-765EA917D131` 누락을 명시하며 최상위 앱12프레임을 해석할 수 없다.
  오전 디자인 컨펌 JS Render Error 및 별도 v84 Hermes native crash와 동일 원인으로 판단하지 않는다.
- Git main의 PR338 수정 포함과 v86 기기 적용은 확인했지만 OTA bundle→exact SHA 매핑은
  미확인이다. 이 한 기기의 관찰을 양OS 전체 적용·기능 QA로 확대하지 않는다.
- 사용자는 dSYM 위치를 모르며 확보 가능한 범위까지만 조사를 요청했다. 제품 수정·PR·댓글·배포·
  시뮬레이터 재실행 없이 마감했다. 상세 근거와 재개 조건은 [전용 조사 기록](dentlink-app-linktalk-sigsegv-investigation.md)을 따른다.

## DL-17038 디자인 컨펌 검증·마감 — 2026-10-27

- **수정 전 재현:** 사용자가 임시 `feature/DL-17038-crash-repro@6b0c6e3`에서 실행한
  `DesignConfirmationScreen`에 `Maximum update depth exceeded` Render Error가 나타났다.
  이 확인 자체는 네이티브 프로세스 강제 종료의 증거가 아니다.
- **유입 이력:** 권한관리 원본 `5c9e57e1dbaa1d81490291676a40edb723d38106`(10/15),
  PR329 squash `43f787909d29f4899a04fad04d3f452d98b53cad`(10/19).
  `useOrderConfirm`의 빈 승인값이 안정된 useState 참조에서 매 렌더 `?? {}`로 바뀌어,
  tracking memo → Zustand 동기화 effect → 재렌더가 로딩 중 반복됐다.
- **검증 공백:** 화면 테스트가 hook을 안정된 완료 데이터로, store setter를 mock으로
  대체해 실제 조합의 순환을 놓쳤다. hook 단독 검사에는 화면 effect가 없었다.
  당시 실제 Member 검증은 홈·결제 배너·주문 필터 중심이며 디자인 컨펌 실진입 완료 근거는
  찾지 못했다. 모든 사람이 전혀 테스트하지 않았다는 의미는 아니다.
- **동료 수정:** PR338 `40b879e`는 빈 객체를 `useRef`로 유지하고 실제 hook/store의
  로딩→데이터 도착→이탈 회귀 테스트를 추가했다. 검증한 main은 후속 ISV PR339까지 포함한
  `7f586790e0bbd7b288458e29f00654d38ba68da2`다. 수정 전 버전과 native/package/lock 변경은 없었다.

| 검증 | 확인한 결과 | 확인하지 않은 범위 |
| --- | --- | --- |
| 코드 검사 | DesignConfirmationScreen/useOrderConfirm 2 suites·36 tests PASS | 전체 프로젝트 테스트·모든 화면 QA |
| 실제 iOS 화면 | iPhone17 Pro/iOS26.5, Office Development2.2.4(151), main의 Metro, Member 계정. Planning Approval(동일 DesignConfirmationScreen) 진입·첨부·Approve/Reject 표시와 조회 성공 | 승인/반려 전송, 사용자 최초 재현의 정확한 주문/approval 일치, 다른 역할·Android·실기기·운영 OTA QA |
| 네이티브 실행 조건 | 설치된 호환 DEV 앱 + 현재 main의 Metro 사용 | 설치 바이너리 exact source SHA, 신규 네이티브 빌드 |

검증 명령은 `yarn test --config jest.config.js --runInBand --watch=false`에
`__tests__/features/designConfirm/screens/DesignConfirmationScreen.test.tsx`와
`__tests__/libs/useOrderConfirm.test.tsx`를 지정했다. package.json의 오래된 별도 Jest 설정은
사용하지 않았다. 로컬 화면·로그 `/tmp/dentlink-office-screen-check-20261027.png`,
`/tmp/dentlink-office-main-confirm-loaded.png`, `/tmp/dentlink-office-confirm-regression.log`는
임시 증거이며 다른 PC에 자동 복구되지 않는다.

### 최종 정리 상태

- 테스트용 `feature/DL-17038-crash-repro`의 정확한 SHA는
  `6b0c6e337871b2daf96d5afc88cee6a1e952db89`다. main 조상임을 확인해 로컬만 `git branch -d`로
  삭제했으며 고유 커밋 손실·원격 삭제는 없다. 제품 소스 수정·새 제품 커밋/푸시·PR·배포도 없다.
- 마지막 관찰의 기본 checkout은 main `7f58679`·origin/main과0/0·clean,
  기존 다른 feature4개와 worktree1개다. 이 값은 10/27 정리 시점의 기록이며 재개 시 다시 확인한다.
- iPhone17 Pro `5C0E7639-2345-4B3F-9979-56AFDDA1C708`는 Shutdown,
  Device Hub GUI·Office Metro·Reactotron 종료,8081/9090 listener없음을 확인했다.
  앱 데이터·설치 앱·의존성·env·공용 CoreSimulator/Watchman·다른 작업은 유지했다.
- 임시 inspector 도우미와 테스트 설정은 제거했다. 추가 필수 정리 없이 대기하며,
  아래 영향 목록을 확인하려고 실행 환경을 자동으로 다시 켜지 않는다.

## 앱 작업의 필수 실검증

[App Screen Runtime Verification Before Merge](../DEVELOPMENT_STYLE.md#app-screen-runtime-verification-before-merge)가 정본이다.
**영향 화면·진입 경로·권한·행동·기대 결과 특정 → 에이전트가 최종 코드를
시뮬레이터/에뮬레이터에서 검증 → 결과와 사용자 확인 목록 전달 → 사람의 최종 QA** 순서다.
공통 코드의 간접 영향도 포함하고 후속 코드 수정 후 해당 범위를 재검증한다.
자동 검사나 사용자 QA는 에이전트 검증을 대체하지 않으며 미검증은 최종 QA 인계·머지 준비를 막는다.

이번 권한관리의 영향 목록은 다음과 같다. **이 목록 전체를 실행 완료했다는 의미는 아니다.**
각 새 작업의 최종 diff·진입 경로에 맞춰 구체화한다.

| 영향 화면 | 권한·조건별 주요 확인 |
| --- | --- |
| 홈 | Action Required 진입, Admin/Billing Manager 결제 영역 허용과 다른 역할 제한 |
| 주문·환자 목록, 검색/필터 | Member 본인 담당 범위·의사 선택 제한, 다른 역할 기존 기능 |
| 주문 상세·WebView | 본인/타의사 주문 열람·수정, 접근 거절, 네이티브 화면 이동 |
| 신규 주문·Case·Draft 재개 | 담당자 고정, 본인/타의사/미지정 Draft, 첨부와 다음 단계 |
| ISV 주문 작성 | 담당자·환자 선택과 저장, Member/비Member 차이 |
| 디자인·플래닝 컨펌 | 최초 로딩·진입·첨부·복귀, 본인/타의사 승인·반려 허용/제한 |
| LinkTalk 목록·대화·지원 대화 | 조회 범위, 읽기/쓰기·첨부·템플릿 이동, 권한 변경 |
| 피드백 상세 | 열람·저장·첨부 권한, 담당/직원 전환 및 저장 중 권한 변경 |

역할은 Admin(OWNER) / Billing Manager(PAYMENT_MANAGER) / Manager(EDITOR) / Member(MEMBER)다.
Member 본인/타의사 담당과 전환·로딩·거절 상태, 영향 있는 각 플랫폼을 분리한다.

## 로컬 개발·설명 방식

- 사용자는 React/TypeScript 웹·앱 FE를 담당한다. 앱을 부차적 업무로 빼거나 React 기초부터
  설명하지 않는다. 생소한 모바일 개념은 웹과의 차이·실무 영향 중심으로 간결하게 설명한다.
- JS만의 변경인지 네이티브 변경인지, 플랫폼 공통/전용인지, Metro 갱신/새 빌드가 필요한지,
  시뮬레이터/실기기 대상인지 먼저 나눈다. 서명·스토어·깊은 네이티브 영역의 협업 경계도 구분한다.
- 앱 세션의 `Chrome control`은 문맥상 앱 직접 조작 요청이면 시뮬레이터/에뮬레이터로 해석한다.
  Chrome 자체 또는 Figma·기획·Swagger 웹 자료 확인은 실제 브라우저를 사용한다.
- 현재 실행 절차는 [개발 가이드](dentlink-app-development-guideline.md),
  정확한 도구·명령·경로는 [로컬 실행 가이드](dentlink-app-local-development.md)를 따른다.
  일반 JS/TS 공통 작업의 빠른 반복은 iOS, 플랫폼 전용 문제는 해당 플랫폼부터 진행한다.
  실행 방식은 [Local Development And User Preview](../SESSION_WORKFLOW.md#local-development-and-user-preview)를 따른다.
  Codex 단독 개발은 내부 실행을 허용하고, 사용자 직접 확인은 정확한 IDE checkout의 하단 서비스 터미널과 외부 화면을 사용한다. 명시적 앱 내부 실행 예외와 사용자 배치를 보존하며, 두 방식의 앱 런타임·크래시 검증 기준은 동일하다.
- 10/27에는 Xcode27.1의 DeviceHub와 기존 DEV 설치 앱+Metro를 사용했다.
  의존성은 `yarn install --immutable`로 lock에 맞췄다. 설치 바이너리 재사용 가능성은 새 작업의
  native/package 차이를 확인해 판단한다. 과거 MLImage Simulator 아키텍처 제약을 해결 완료로
  기록하지 않으며 신규 네이티브 빌드가 필요할 때 해당 상태를 다시 확인한다.
- 구현 미완료와 일반 QA·승인·병합·배포 단계를 구분해 보고한다. 과거 피드백 기록의 BE 대기나
  일반 업로드 개선을 새 미완료 과제로 자동 재등록하지 않고 실제 신규 요구사항·결함을 기준으로 한다.

## 운영 전달·복구 자료의 마지막 기록

- 10/25 PR329/331/332/333, PR335의 운영 Git 포함과 main `49031ad`·release/v2.2.4 tree 동일성을
  확인했다. 양OS Productionv84/target2.2.4/mandatory100% 활성 및 각OS Stagingv341과 패키지 일치를
  확인했지만 OTA package→exact Git SHA·전 기기 QA·스토어 출시를 확인한 것은 아니다.
  10/27의 iOSv86 단일 이벤트 관찰과 서로 다른 시점·범위다.
- 10/26 `dentlink-app-permission` worktree는 제거했다. 기존 feature4개 refs는 보존했다.
  당시 env9개·debug keystore1개는
  `/Users/parkjongsun/.local/share/codex-closeout/20261026-permission-folders/files/office-permission/`에
  rename 보존하고 manifest에 경로를 남겼다. 실제 값·백업은 이 Git 문서로 다른 PC에 복사되지 않는다.
  이 기록만으로 오래된 경로나 refs를 복구·삭제하지 않는다.
- 세부 이력은 [정리 전 전체 기록](archive/dentlink-app-history-through-2026-10-27.md)에
  원문 보존했다. 과거 `Current branch`, `Next Starting Point`, 실행 유지 지시는 작성 당시의
  이력이며 현재 작업 지시가 아니다. PR286 피드백 전달·후속 QA·기존 환경 설치 증거가 필요할 때만 읽는다.

## 다음 요청 시

1. 개인 컨텍스트와 필요한 정본을 갱신하고 Office/Lab/웹 범위·담당 세션을 특정한다.
2. 정확한 checkout·live Git·현재 작업 소유권을 확인한다. 과거 SHA를 새 base로 자동 사용하지 않는다.
3. 승인된 범위의 실제 코드·API·디자인과 최종 영향 화면/권한 목록을 확인한다.
4. 필요한 실행 환경을 준비하고 위 실검증 순서로 진행한다. 새 요청 전에는 구현·QA·서버·배포를 재개하지 않는다.
