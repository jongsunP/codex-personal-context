# Dentlink Office App — 현재 체크포인트와 작업 기준

이 문서는 **치과 앱 `Innvoaid/dentlink-app`**의 개인 체크포인트다.
기공소 앱은 [별도 정본](dentlink-lab-app.md)을 따른다. 문서 정리는
2026-10-27에 수행했으며, 아래 날짜별 관찰을 제품·배포의 현재 상태로 재검증한 것은 아니다.
재개 전 정확한 저장소·branch·HEAD·worktree와 최신 사용자 지시를 확인한다.

## 현재 상태와 재개점

| 항목 | 마지막으로 확인·기록한 상태 | 다음 시작점 |
| --- | --- | --- |
| LinkTalk 운영 iOS SIGSEGV | 10/27 확보 가능한 범위 조사 마감. dSYM 누락으로 정확 원인 미확정 | 일치하는 archive/dSYM 또는 새 재현 증거와 별도 재개 요청이 있을 때 [조사 정본](dentlink-app-linktalk-sigsegv-investigation.md)부터 확인 |
| DL-17038 디자인 컨펌 Render Error | 수정 전 재현, PR338 수정 포함 main의 제한된 실화면 확인 완료. 테스트용 branch·실행 환경 정리 완료 | 새 결함/요청 없으면 대기. 아래 검증 범위를 전체 앱 QA로 확대하지 않음 |
| 권한관리 및 후속 QA | 10/25 Office PR329/331/332/333의 운영 Git 반영 확인. 10/26 전용 worktree 제거 | 새 요청 시 [권한관리 정본](dentlink-permission-management.md)과 기본 checkout 확인 |
| 피드백 DL-15828 / DL-16061 | PR286의 9/11 develop squash 병합·동일 tree 확인은 완료된 이력 | [피드백 정본](dentlink-client-order-feedback.md) 및 아래 이력. 과거 PR286 리뷰·BE 대기 문구를 현재 미완료로 재사용하지 않음 |

## 저장소·업무 경계

- 저장소: [Innvoaid/dentlink-app](https://github.com/Innvoaid/dentlink-app)
- 기본 checkout: `/Users/parkjongsun/Repository/dentlink-app`, 기본 branch `main`.
- 일반 feature의 기준·PR 대상은 `develop`이다. 실제 준비 시
  [앱 배포 정책](../SESSION_WORKFLOW.md#dentlink-app-release-and-delivery-policy)과
  [앱 온보딩](dentlink-app-onboarding.md)의 현재 지침을 먼저 읽는다.
  앱 개발자의 10/12 전달 흐름은 별도 합의 전 참고이며 자동 정책 교체나 배포 승인이 아니다.
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
  IDE는 사용자가 관리하며 명령은 정확한 checkout의 필요할 때 여는 Codex 터미널에서 실행한다.
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
