> 2026-10-27 개인 컨텍스트 정리 전 전체 기록입니다. 아래의 현재 상태·다음 작업·실행 지시는 각 기록 작성 시점의 이력이며 지금의 실행 지시가 아닙니다.
> 최신 상태와 재개 지침은 [현재 문서](../dentlink-app.md)를 먼저 읽습니다.
> 원본: `projects/dentlink-app.md`, 기준 commit `a3ddbe53af45bfbde4d63658404e0020e7d0c7ef`, 원문 SHA-256 `712bcc1f7cd8f3de60b801cef8d4fc9620d6f2c2c6822d70c37f5eef90a8b49c`.
> 원문은 삭제 없이 보존했고 이동에 필요한 Markdown 상대 링크에만 `../`를 추가했습니다.

# Dentlink Office App setup and current checkpoint

## 운영 iOS LinkTalk SIGSEGV 조사 — 2026-10-27

- [Slack 알림](https://innovaidhq.slack.com/archives/C0CC6EDL78T/p1793086505051709)의 실제 이벤트는 Office iOS Production 2.2.4(1)·CodePush v86·iOS27.0.1에서 15:26:12 KST 발생한 LinkTalk 화면 전환 크래시다. 조사 시점까지 동일 issue는 사용자1명·세션1개·1건이다. 메시지 전송/조회는200이며 main thread의 화면 그리기 경로에서 SIGSEGV가 발생했다.
- **정확 원인 미확정:** Datadog UI가 운영 앱 dSYM UUID `04104800-AA3D-383D-837F-765EA917D131` 누락을 명시하며, 최상위 앱12프레임을 해석할 수 없다. 오전 디자인컨펌 JS Render Error 및 별도 v84 Hermes native crash와 동일 원인이라고 판단하지 않는다. Git main의 PR338 수정 포함과 v86 기기 적용은 확인했으나 OTA bundle→exact SHA 매핑은 미확인이다.
- 사용자는 dSYM 위치를 모른다고 답하고 확보 가능한 범위까지만 조사를 요청했다. 제품 수정·커밋/푸시·PR·댓글·배포·시뮬레이터 재실행 없이 마감한다. 후속 확정은 일치하는 archive/dSYM 또는 새 재현 증거와 별도 재개 요청이 있을 때다. 상세 근거·비교·다음 시작점은 [전용 조사 기록](../dentlink-app-linktalk-sigsegv-investigation.md)을 따른다.

## 크래시 검증 마감·실행 환경 종료 — 2026-10-27

- 사용자 요청으로 아래 재현 원인·수정본 검증·검증 공백·머지 전 화면별 QA 절차를 개인 정본에 보존하고 마감했다. 수정 전 오류 재현, 권한관리 원본5c9e57e/PR329 유입, PR338 수정 포함 main의 관련36테스트 및 iOS/DEV/Member 컨펌 진입·첨부 표시 확인이 완료 범위다. 승인·반려 전송·다른 역할/Android/실기기·운영 적용은 검증 완료로 확대하지 않는다.
- 테스트용 **`feature/DL-17038-crash-repro`만 로컬에서 삭제**했다. 정확한 SHA `6b0c6e337871b2daf96d5afc88cee6a1e952db89`와 main의 조상임을 확인한 뒤 `git branch -d`로 삭제해 고유 커밋 손실이 없다. 원격에 만든 브랜치가 아니므로 원격 삭제는 없다. 기본 checkout은 **main `7f586790e0bbd7b288458e29f00654d38ba68da2`**, origin/main과0/0·clean이며 기존 다른 feature4개와 worktree1개는 유지한다.
- **종료 확인:** iPhone17 Pro `5C0E7639-2345-4B3F-9979-56AFDDA1C708`는 Shutdown, Device Hub GUI·Office Metro·Reactotron은 종료됐고8081/9090 listener가 없다. 설치 앱과 시뮬레이터 데이터·의존성·env는 유지하며 공용 CoreSimulator/Watchman 서비스나 다른 작업 프로세스는 종료하지 않았다.
- 이번 임시 inspector 도우미와 테스트 설정 파일은 정리하고, 전후 화면 캡처·테스트 로그는 기존 `/tmp` 경로에 둔다. 이 파일들은 임시 로컬 증거이며 다른 기기에서 복원되는 자료가 아니다. 핵심 사실·정확한 SHA·검증 명령·범위는 이 Git 문서에 보존한다.
- **다음 시작점:** 새 요청이 있을 때 개인 컨텍스트 pull → 해당 앱 live Git/작업 범위 확인 → 필요한 화면·권한별 실행 환경 준비부터 시작한다. 이번 검증 건의 추가 필수 정리는 없으며 새 요청 전 재실행·추가 QA·제품 수정·병합·배포 없이 대기한다. 아래 실행 유지/재현 대기 문구는 각 단계 당시 이력이다.

## DL-17038 재현·유입 이력·수정본 확인 — 2026-10-27

- 사용자가 수정 전 임시 브랜치에서 직접 실행한 화면을 캡처해 `DesignConfirmationScreen`의 **Maximum update depth exceeded** Render Error를 확인했다. 네이티브 프로세스 강제 종료를 확인한 것은 아니다. 재현 화면: `/tmp/dentlink-office-screen-check-20261027.png`.
- **유입 확정:** 권한관리 원본 `5c9e57e1dbaa1d81490291676a40edb723d38106`(10/15), PR329 squash `43f787909d29f4899a04fad04d3f452d98b53cad`(10/19). `useOrderConfirm`의 빈 승인값이 안정된 useState 참조에서 매 렌더 `?? {}`로 바뀌었다. 화면의 tracking memo → Zustand 동기화 effect → 재렌더가 연결되어 데이터 로딩 중 반복 갱신이 발생한다. 기존 화면 effect 자체는 이전 코드이며, 이번 권한관리 변경의 회귀다.
- **검증 공백:** 기존 화면 테스트는 hook을 안정된 완료 데이터로 대체하고 store setter도 mock 처리했다. hook 단독 테스트는 실제 화면 effect가 없어 둘의 상호작용을 놓쳤다. 개인 기록의 실제 Member 검증은 홈·결제 배너·주문 필터 중심이며 디자인 컨펌 실진입 완료 근거는 찾지 못했다. 테스트 통과를 실제 화면 검증으로 보완하지 못한 공백을 인정하며, 모든 사람이 전혀 테스트하지 않았다고 추정하지 않는다.
- **동료 수정:** PR338 `40b879e`는 빈 객체를 `useRef`로 유지하고 실제 hook/store의 로딩→데이터 도착→이탈 회귀 테스트를 추가했다. 최신 fetch의 main은 후속 ISV PR339까지 포함한 **`7f58679`**다. 기본 checkout을 이 main으로 ff-only 전환했으며 원격동일·clean, 수정 전 임시 `feature/DL-17038-crash-repro@6b0c6e3`는 보존한다. 두 버전 간 native/package/lock 변경은 없다.
- **수정본 검증:** `yarn test --config jest.config.js --runInBand --watch=false`로 DesignConfirmationScreen/useOrderConfirm **2 suites /36 tests PASS**. package.json의 오래된 별도 Jest 설정은 사용하지 않았다. iPhone17 Pro/iOS26.5·Office Development2.2.4(151)·현재 main의 Metro에서 Member 계정으로 현재 홈의 승인 대기 주문9000009855/approval1721에 딥링크 진입해 **Planning Approval(동일 DesignConfirmationScreen), 첨부 미리보기, Approve/Reject 버튼 표시와 조회 성공**을 확인했다. `/tmp/dentlink-office-main-confirm-loaded.png`, `/tmp/dentlink-office-confirm-regression.log`가 로컬 증거다. 이전 사용자 재현의 정확한 주문/approval ID는 따로 확인되지 않았다.
- **경계:** 이번 직접 확인은 위 iOS/DEV/Member의 진입·로딩·표시에 한정된다. 승인·반려 전송, 전 역할/양OS·실기기·운영 OTA 적용 QA는 수행하지 않았다. 제품 소스 수정·새 제품 커밋/푸시·PR·배포 없음. 현재 main 화면과 Metro/Reactotron은 유지하여 사용자 최종 확인을 이어갈 수 있다.
- **상시 개선:** [머지 전 실검증 정본](../../DEVELOPMENT_STYLE.md#app-screen-runtime-verification-before-merge)에 영향 화면 목록 작성 → 에이전트 실제 검증 → 화면/진입 경로/권한/기대 동작/결과를 담은 사용자 최종 QA 안내 순서를 추가했다. 오류 0%를 보장하지 않으며, 미검증을 완료로 처리하지 않는 것이 기준이다.

이번 권한관리의 **검증 대상 목록**은 아래와 같다. 이번에 이 목록 전체를 실행 완료했다는 의미는 아니다. 각 작업에서는 실제 최종 diff와 진입 경로에 맞게 구체화한다.

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

역할은 Admin(OWNER) / Billing Manager(PAYMENT_MANAGER) / Manager(EDITOR) / Member(MEMBER)로 나누며 Member 본인/타의사 담당과 작업에 해당하는 전환·로딩·거절 상태를 구분한다.

## 크래시 수정 전 사용자 재현 환경 — 2026-10-27

- **요청:** 최신 치과 앱에서 동료가 방금 병합한 수정만 제외한 임시 로컬 브랜치와 iOS 시뮬레이터를 준비한다. 권한관리 변경은 유지하며 크래시 재현은 사용자가 직접 한다.
- **정확한 기준:** [PR338](https://github.com/Innvoaid/dentlink-app/pull/338), `[DL-17038] 디자인 컨펌 화면 크러쉬 이슈`, myungjael, main 대상, 10/27 08:45:59 KST 병합. merge `40b879ef3e5acb551ac96a9103b3a3c6ebd2f105`의 직전 parent는 `6b0c6e337871b2daf96d5afc88cee6a1e952db89`다. 이 parent의 tree는 기존 운영 main49031ad와 동일하며 권한관리 통합43f7879를 포함한다.
- **로컬:** `/Users/parkjongsun/Repository/dentlink-app`의 main을 ff-only로 최신40b879e에 맞추고, parent6b0c6e3에서 `feature/DL-17038-crash-repro`를 생성·checkout했다. upstream 없음·clean. 최신 main과의 차이는 `src/libs/useOrderConfirm.ts`와 해당 디자인 컨펌 테스트 2파일뿐이다. 새 제품 커밋/푸시·PR·원격 변경·배포는 없다. 별도 worktree도 만들지 않았다.
- **환경 준비:** 기존 node_modules의 Datadog2.14.8이 lock 지정3.7.0과 달라 `DdSdkReactNative.addAttributes` 시작 오류가 발생했다. 제품 코드를 우회 수정하지 않고 `yarn install --immutable`로 지정 의존성을 정렬한 뒤 재실행하여 홈 진입을 확인했다. 기존 peer warnings는 있고 제품 추적 파일은 변경되지 않았다.
- **실행:** iPhone17 Pro/iOS26.5, UDID `5C0E7639-2345-4B3F-9979-56AFDDA1C708`, 기존 Office Development `com.innovaid.dentlink.development` 2.2.4(151) 설치 앱 + 현재 임시 브랜치의 Metro8081. Reactotron9090 연결 확인. 시뮬레이터 네이티브 바이너리를 새로 빌드한 것은 아니며 설치 바이너리의 exact source SHA는 미확인이다. 제외한 PR 자체에는 native/package/lock/entry 변경이 없다.
- **GUI:** 이 Mac의 Xcode27.1에서는 기존 Simulator.app 대신 `/Applications/Xcode.app/Contents/Applications/DeviceHub.app`를 사용했다. `devices://device/open?id=<UDID>`로 기기창을 열고 실제 화면 캡처·onscreen 창을 확인했다. 앱 홈 위 DEV 공지 팝업이 표시돼 있으며 사용자가 Close 후 진행할 수 있다.
- **현재/다음:** Metro·Reactotron·기기 창을 켜두고 사용자 재현을 기다린다. 디자인 컨펌 진입·승인/거절·크래시 재현은 실행하지 않았다. 원복 요청 시 현재 dirty/서버 소유권을 확인하고 main40b879e(또는 그때의 최신 승인 기준)으로 전환한다. 임시 브랜치 삭제·새 수정·배포는 자동 실행하지 않는다.

## 권한관리 전용 worktree 정리 — 2026-10-26

- 사용자 완료 업무 폴더 정리 승인으로 `dentlink-app-permission`을 제거했다. HEAD e4fb1aca는 원격 동일·clean/미추적0이며 PR329/331/332/333의 변경은 운영 main49031ad에 보존된다. 최종 통합7e6663b와 main은 동료 ISV3파일 외967파일이 같고 release와 main의 전체 tree가 같다. squash 이력을 단순 commit ancestry로 대체하지 않는다.
- 로컬·원격 feature4개와 기본 `/Users/parkjongsun/Repository/dentlink-app`은 유지했다. 전용 worktree의 node_modules는 기본 저장소를 가리키는 symlink였으며 링크만 제거하고 대상의 inode/존재를 확인했다. Yarn install-state와 해당 worktree watch만 정리했고 공용 Watchman은 유지했다.
- env9개와 debug keystore1개는 내용 조회/복사 없이 `/Users/parkjongsun/.local/share/codex-closeout/20261026-permission-folders/files/office-permission/`으로 rename 보존했다. 제한 권한과 메타데이터 일치를 검증했다. 원래 경로는 상위 manifest에 기록했고 실제 값은 사람이 관리한다.
- 제품 코드·브랜치·PR·OTA·Jira 변경은 없다. Productionv84의 exact source SHA/전 기기 QA 경계는 10/25 기록대로 유지한다. 다음 요청은 기본 저장소 확인 후 필요한 worktree를 다시 준비해 이어간다.

## 운영 반영 확인·원본 작업 보존 — 2026-10-25

- 권한관리 담당 세션의 배포 후 정리에서 **읽기 전용으로** 확인했다. Office PR329/331/332/333은 develop 병합 완료이고, 오늘 PR335 release/v2.2.4→main도 병합됐다. `main@49031ad64983715f87f92b4998284da1dbae7c23`과 원격release 전체tree가 같다. 기존 통합7e6663b 대비 차이는 동료 DL-16957 ISV3파일뿐이며 나머지967파일은 같아 우리 권한·다운로드·간격 수정의 누락/되돌림은 발견되지 않았다. 현재 열린 PR은 없다.
- 양OS **Production v84 / target2.2.4 / 활성 / mandatory / rollout100%** 확인. iOS10/25 17:07:25, Android17:08:25 KST 게시이며 각OS 패키지 hash는 최신 **Stagingv341**과 동일하다. `v2.2.4.84` Git태그는 위 main을 가리킨다. OTA description이 비어 있어 **OTA 패키지→정확한 Git SHA 직접 대응은 미확인**이며, 기기 전체 적용·기능 QA·스토어 배포 성공으로 확대하지 않는다. 이번 세션은 OTA를 새로 게시/변경하지 않았다.
- `/Users/parkjongsun/Repository/dentlink-app-permission`은 `feature/DL-16929@e4fb1aca264e14987acac8f1752d52ad9ed54e68` clean·원격동일. 기존 `feature/DL-16317@f037c80153b328bbb14fcafd5fb756a59fd4cc8e`, `feature/DL-16317-qa@1fa59edf58f8d2dc8fc4ac8af17a9016be3a6149`, `feature/DL-16927@b2e29d324ce95ae27c61dfa9fee3b5abe6bb9134` 및 현재브랜치의 로컬·원격을 모두 보존했다. 제품 refs/파일/worktree·기본checkout을 가리키는 node_modules 링크·env/인증은 변경하지 않았다.
- 관련 Jira16752/16859/16927/16929는 이미 Done이며 상태/댓글 변경 없음. 기존 사용자v340 간격 확인을 유지하되 운영v84의 OS별 QA로 확장하지 않는다. 운영 exactSHA 증거가 필요해지면 담당 배포 근거를 받아 대조하고, 지금은 새 QA/사용자 지시 전 추가 조치 없이 보존한다. 웹 정리 결과는 [권한관리 정본](../dentlink-permission-management.md)을 따른다.

## 최신 전달 완료 — 2026-10-22 DL-16929 템플릿 메시지 간격·Staging v340

- **최종 사용자 QA 확인:** 사용자가 치과 앱 스테이징에서 **v340 적용 및 메시지 간격 수정 결과를 직접 확인**했다고 알렸다. Jira DL-16929도 현재 **완료** 상태로 실조회했다. OS는 별도로 명시하지 않았으므로 양OS 각각의 실기기 QA 완료로 확대하지 않는다. 이 건의 개발·전달·사용자 확인은 종결하며 추가 필수 조치 없이 대기한다. 제품/Jira 상태·댓글·배포 추가 변경 없이 개인 기록만 commit/push한다.
- **승인/원인:** 사용자가 Lab DL-16904와 같은 문제가 Office에도 있는지 코드 확인을 요청했고, 최신 develop에서도 연속 템플릿의 상단 간격이0px인 것을 확인했다. 이어 수정·검증·커밋·푸시·PR병합·CodePush·별도 Jira 카드 생성을 명시 승인했다. 기존 권한관리 전달 흐름대로 develop 통합 후2.2.4 Staging에 전달하며, 이번 건도 권한 정책과 별개인 기존 표시 문제다.
- **코드:** `/Users/parkjongsun/Repository/dentlink-app-permission`, 최신 `origin/develop@1f89d867861ed77eb6fca48a71e0d99f5999dca4`에서 **feature/DL-16929** 생성. `src/features/chat/components/message/MessageTemplate.tsx:483`의 기본 margin-top만0→4px(1파일+1/-1), 날짜 경계/프로필10px·일반메시지·버튼/API/권한 유지. 별도조기반환 LAB_DIRECTOR_PROFILE은 변경대상 아님. native/package/lock/env/의존성 변경0, 신규 제품/테스트/스토리 파일0.
- **검증:** 변경파일 ESLint 전후오류0/경고0, 기존 MessageTemplate·MessageActions **2 suites/19 tests PASS**, diff검사 및 package/Android/Xcode2.2.4 버전일치 PASS. 독립 검토에서 Lab확정수정과동일·상위6px/일반4px중복없음·추가결함없음. 이번 스타일1줄변경에 전체타입/전체테스트·네이티브빌드·실기기시각QA는 실행하지 않았다.
- **Git/PR:** 커밋 **e4fb1aca264e14987acac8f1752d52ad9ed54e68** `fix: 치과 앱 연속 템플릿 메시지 간격 보완`, push·[PR333](https://github.com/Innvoaid/dentlink-app/pull/333) 생성·세션연결. 자동화 후 base develop/head/1파일 diff와checks확인; CodeRabbit은 develop대상제외로 skipped, 강제실행없음. 16:28:14 KST **develop@7e6663be17fb4bd7aed62bc2824e6bd362208dc6**로 스쿼시병합. 검증head와통합tree동일, 이전다운로드PR332/권한/동료소스보존.
- **배포:** 병합SHA git archive의 격리소스에서 `yarn install --immutable` 성공(기존peer경고), 추적970파일원본blob일치·2.2.4재확인. 직접CLI로 Slack알림없이 양OS Metro/Hermes번들·Staging게시1회씩성공. Android **v340/16:29:57 KST**, iOS **v340/16:30:38 KST**, **target2.2.4/활성/mandatory/rollout100%** 및 description의source7e6663b/PR333을서버재조회로확인. 각OS map의 `src/` JS/TS341파일이배포원본과일치. 기존isv.mp4 1.48MiB경고는기존force경로로처리.
- **증거/경계:** Android packageHash `7b50fabe944b5ce5f62b6363a4df3b13bdeaa7a27de9f7457859825ec68bc589`, iOS `34264d45b0e2e1e1f6e66ee8d403644713f0d7f7139270f99f297da14caea17f`. 직전양OS Stagingv339/2.2.4 source1f89d86확인→1줄JS스타일만추가. Production/Development/Lab/웹·release/main동기화·태그·스토어변경없음. 업로드성공은실제기기수신/화면QA성공과구분한다.
- **Jira/마감:** 중복확인후 DL-16317 하위 Frankie 담당 **[DL-16929](https://innovaid.atlassian.net/browse/DL-16929)** 생성, 본문에문제/범위/기대결과/원본Lab카드작성. 배포후 **READY FOR QA**로상태변경했고 부모/기존카드댓글·Slack쓰기는없다. feature/DL-16929는원격동일·clean, 이전branch/worktree보존. 배포임시소스/node_modules삭제, `/tmp/dl16929-*` 로그·번들·maps·metadata보존. 요청된개발·통합·전달완료, 다음은필요시실제2.2.4/v340의연속템플릿4px QA결과접수이며 추가지시전대기한다.

## 최신 전달 완료 — 2026-10-22 DL-16927 Android 파일명 수정·Staging v339

- **승인/범위:** Lab DL-16917의 `#` 파일명 다운로드 실패를 설명한 뒤 사용자가 치과 앱도 동일한지 확인하고 수정·CodePush를 요청했다. Office 최신 develop에서도 같은 `react-native-blob-util@0.22.0` 및 Android URI 경로 처리를 확인했다. 사용자가 PR 검토 후 병합·CodePush를 승인했고, 이후 정리·마무리·대기를 요청했다. 권한 정책이 아닌 Android 다운로드 구현 결함이다.
- **코드/PR:** `/Users/parkjongsun/Repository/dentlink-app-permission`에서 최신 `origin/develop@4e0597bb4ed7d69a280321d433d959d5974694b1` 기준 **feature/DL-16927** 생성. `src/hooks/useFileDownload.ts` 1파일 +4/-1로 Android 저장 파일명에서 `#/%`를 `_`로 치환하고 원인 주석을 추가했다. 일반 파일명·확장자·중복 번호·iOS·API·권한·원본 URL은 유지한다. 커밋 **b2e29d324ce95ae27c61dfa9fee3b5abe6bb9134**, 원격 push 및 [PR332](https://github.com/Innvoaid/dentlink-app/pull/332) → develop 생성·자동화 후 base/diff 재확인.
- **병합:** 15:06:20 KST에 사용자 승인으로 PR332를 스쿼시 병합했다. 통합 SHA **1f89d867861ed77eb6fca48a71e0d99f5999dca4**, 검증 feature head와 전체 tree 동일. 최신 권한 PR329/331과 동료 비밀번호 찾기 PR330을 모두 유지한다. 구 release/v2.2.4에는 이 작업들이 없어 배포 기준으로 사용하지 않았다. release/main 동기화·태그·스토어 배포는 수행하지 않았다.
- **검증:** 기존 관련 3 suites / **50 tests PASS**, 실제 파일명 함수의 특수문자·일반명·한글·확장자·중복 번호·URI 경로 일치 검사 PASS. package/Android/Xcode **2.2.4** 버전 일치·diff 검사 PASS. 전체 타입 **기존18진단과 byte 동일**, 해당 파일 ESLint **기존1error/29warnings와 동일**, 신규 진단0이다. 독립 코드 검토 추가 문제0. 새 테스트/스토리/제품 파일·의존성·native 변경 없음. 실기기 QA는 미수행이다.
- **배포 복구/환경:** 최초 원본 worktree 시도는 node_modules가 메인 checkout으로 연결되어 Metro가 `@babel/runtime/helpers/interopRequireDefault`를 찾지 못해 **업로드 전 실패**, 서버 v338 유지 확인. 기존 전달 방식대로 통합 commit의 임시 git archive에서 `yarn install --immutable` 성공(기존 peer 경고), 추적970파일이 원본 blob과 동일함을 검증했다. outputDir가 `CodePush`로 끝나야 하는 CLI 형식도 업로드 전 바로잡았다. 제품 Metro 설정·기존 node_modules 연결은 수정하지 않았다.
- **CodePush:** 직접 CLI로 Slack 알림 없이 Office **Android·iOS Staging v339**, **대상2.2.4 / 활성 / mandatory / rollout100%** 게시·서버 read-back 완료. Android **15:08:51 KST**, iOS **15:09:41 KST**. description에 통합 SHA·DL-16927·PR332 기록. 양 OS Metro/Hermes 번들·업로드 성공, 소스맵의 자체 앱 JS/TS **343파일씩 원본과 일치**. 기존 `isv.mp4` 1.48MiB 경고는 기존 `--force` 경로로 처리했다. Android hash `c5a8b9976a8963974c74c22b98ea13360141f50b82daa2c8d8cf5e62a7c9cffb`, iOS hash `ff8eac2340d959141d259e5127a1892c504436b7d400994397baac593f043b05`.
- **기존 OTA와 경계:** 배포 전 양 OS v338/2.2.4는 활성이나 설명이 없어 원본 SHA를 확정하지 않았다. 직전 v337의 develop472ecd9와 최신 통합 소스 사이 native/package/lock/entry 차이0이다. 기존 OTA 수동 비활성화·롤백·Production/Development/Lab/웹 배포는 하지 않았다. iOS 동작은 그대로이고 동일 통합 소스만 맞췄다.
- **Jira/보존:** 중복 조회 후 별도 치과 카드 [DL-16927](https://innovaid.atlassian.net/browse/DL-16927)을 DL-16317 하위 Frankie 담당으로 생성, 정의만 본문에 작성하고 배포 후 **READY FOR QA** 상태로 전환했다. 부모/기존 카드 댓글·Slack 쓰기는 없다. PR 본문에 전달 상태를 반영했다. 원본 checkout은 feature/DL-16927@b2e29d3로 복귀·clean·origin 동일이며 기존 feature/worktree는 보존한다. 배포용 임시 archive/node_modules만 정리하고 로그·번들·maps·metadata는 `/tmp/dl16927-*`에 보존한다.
- **사용자 마감 확인/재개:** 이후 사용자는 기공소 앱의 수정 결과를 확인했으며, 치과 앱은 별도로 실행 확인하지 않았지만 배포 기준 브랜치 병합과 동일 소스 CodePush가 완료됐다면 작업 완료로 봐도 된다는 판단을 전달했다. 이에 **치과 앱 개발·검증·develop 병합·Staging 전달 범위는 완료**로 마감한다. 치과 실기기 다운로드 QA를 수행한 것으로 기록하지 않으며, 추가 QA를 이번 세션의 필수 잔여 작업으로 강제하지 않는다. 현재 추가 필수 FE 조치는 없다. Jira 상태를 임의 Done으로 바꾸지 않고 개인 기록만 commit/push 후 대기한다. 실제 사용/후속 QA에서 문제가 전달되거나 새 지시가 있을 때만 재개하며, 그전에는 추가 조회·수정·배포·브랜치 정리를 하지 않는다.

## 최신 — 2026-10-20 DL-16859 앱 QA PR331 생성 완료

- 사용자 후속 승인으로 `dentlink-app-permission`의 기존 `feature/DL-16317-qa@1fa59ed`를 push하고 [PR331](https://github.com/Innvoaid/dentlink-app/pull/331) OPEN/비Draft → `develop@43f7879`로 생성했다. 기존 PR329는 병합 완료 상태이며 새 PR에는 DL-16859의 1커밋·7파일만 있다. 로컬/원격 일치·clean을 확인했다.
- 추가 코드 변경 없이 기존 20 tests PASS·lint 오류 0·타입 기존 18진단/추가 0 및 기기 QA 미수행을 PR에 명시했다. 병합·CodePush·Jira 변경은 하지 않았다. 기존 Staging v336은 유지하며 리뷰/병합 후 develop 전체 CodePush는 별도 사용자 지시에 따른다.
- 웹은 DL-16850 논의·처리 후 기존 웹 QA를 한 PR로 묶을 예정이며 현재 로컬 미푸시다. 자세한 상태는 [권한관리 체크포인트](../dentlink-permission-management.md)를 따른다.

## 최신 — 2026-10-20 DL-16859 앱 QA 로컬 커밋 완료, 제품 푸시 보류

- 사용자 승인에 따라 `/Users/parkjongsun/Repository/dentlink-app-permission`의 기존 `feature/DL-16317-qa`에서 DL-16859를 수정·검증·로컬 커밋했다. HEAD `1fa59edf58f8d2dc8fc4ac8af17a9016be3a6149`, base develop `43f7879`, upstream 없음·clean이며 기존 원본 feature/worktree는 보존했다.
- Member의 LinkTalk My Orders Only 스위치를 숨기고 목록·미읽음·하단 탭 배지·읽음 캐시의 실제 조회 조건을 본인 주문으로 통일했다. 공용 hook에서 LinkTalk 전용 실효 값을 계산하며 기존 저장 preference와 푸시 알림 설정은 바꾸지 않는다. 확정된 직원 권한으로만 조회하고 역할 전환 시 조건·캐시도 일치시킨다.
- 기존 소스 5파일과 테스트 2파일 수정, 신규 파일 없음. 관련 4 suites/20 tests PASS, 변경 lint 오류 0/기존 경고 1, diff-check PASS. 전체 타입 검사는 현재 로컬 의존성 환경에서 기존 18진단이 있으며 동일 환경의 수정 전후 비교에서 신규 진단 0이다. 전체 타입 통과·시뮬레이터 QA·네이티브 빌드 완료를 의미하지 않는다.
- 제품 push/PR·Jira·CodePush·배포는 하지 않았다. 이번 웹 6건과 앱 1건을 로컬 커밋으로 보관하고 DL-16850은 별도 논의한다. 웹 DL-16864/16858 및 앞선 DL-16851의 앱 WebView 반영은 웹 배포 이후이며 앱에 중복 구현하지 않았다.
- 이후 사용자 일괄 push 지시 → develop PR/병합 → develop 전체 Staging CodePush 정책을 유지한다. 기존 Staging v336은 변경하지 않았다. 상세 커밋·범위·검증·다음 시작점은 [권한관리 체크포인트](../dentlink-permission-management.md)를 따른다.

## 이전 — 2026-10-20 권한관리 앱 QA 브랜치 준비

- 사용자 요청으로 permission worktree에 `origin/develop@43f787909d29f4899a04fad04d3f452d98b53cad` 기준 `feature/DL-16317-qa`를 생성·checkout했다. upstream 없음·diff0·clean이며 기존 feature/DL-16317은 보존했다. 이후 앱 QA 수정은 이 브랜치에 로컬 커밋으로 모으고 제품 push는 보류한다.
- DL-16851 앱 증상은 웹 주문상세 WebView의 경고 누락이다. 웹 커밋 `b8233cb9a`로 모바일/앱까지 대응하므로 별도 앱 코드·커밋·CodePush는 불필요하다. 웹도 아직 미푸시/미배포이며 웹 배포 후 실제 앱 화면 QA가 남는다.
- 제품 push/PR·Jira·배포 변경 없음. 상세 근거와 다음 시작점은 [권한관리 체크포인트](../dentlink-permission-management.md)를 따른다.

## 최신 대기 — 2026-10-19 권한관리 PR329 develop 병합 완료

- 사용자 병합을 실조회로 확인했다. PR329 MERGED→develop, 18:13:16 KST, merge/current remote develop `43f787909d29f4899a04fad04d3f452d98b53cad`.
- 현재 양OS Staging v336/2.2.4는 featuref037c80에서 전달된 빌드로 유지한다. 이번 메시지로 별도 CodePush하지 않는다. 기존 feature/worktree도 보존한다.
- develop43f7879와 featuref037c80의 전체 소스 tree가 동일(355364f3d6b8c6971030170cad74dbe78e9a4be9), 변경0파일·네이티브/의존성차이0이다. 병합만을 이유로 재배포할 필요가 없다.
- 이후 이 권한관리 QA는 **작업브랜치 수정·검증 → develop PR/병합 → develop 전체 Staging CodePush** 순서다. 이전 feature 직접 전달 예외는 반복하지 않으며 전달 시 통합 변경·바이너리 호환성을 확인한다.
- QA 결과/추가 지시를 기다린다. 앱 PR 병합은 더 이상 잔여 작업이 아니며 실제 기기 적용/QA는 별도다. 자세한 근거는 [권한관리 체크포인트](../dentlink-permission-management.md)를 따른다.

## 현재 대기 — 2026-10-19 사용자 QA 결과 전달 대기

- 사용자 지시로 정리 후 대기한다. 양OS Staging v336/2.2.4 전달 및 PR329 최신 head 승인 확인을 유지하며, 추가 확정 수정은 없다.
- 앱 PR329 미병합·실제 기기 적용/QA는 별도다. QA 결과 또는 사용자 후속 지시가 오면 재개하며 그전에는 추가 조회·배포·병합하지 않는다.
- 브랜치/worktree·시뮬레이터/Metro를 보존한다. [권한관리 체크포인트](../dentlink-permission-management.md)의 종료 기록을 따른다.

## 최신 리뷰 확인 — 2026-10-19 PR329 최신 head 승인, 추가 수정 없음

- PR329는 OPEN→develop/headf037c80 유지, 최신 head에 myungjael LGTM/APPROVED(05:59:58Z), reviewDecision APPROVED·MERGEABLE/CLEAN 확인.
- 전체 리뷰 스레드/인라인 댓글 각각0건, 미해결 지적 없음. CodeRabbit은 develop 대상 제외로 Review skipped이며 기존 지시대로 강제 실행하지 않았다.
- 제품 코드·테스트·커밋·병합·CodePush 변경 없음. Staging 양OS v336 유지, 앱 개발자 리뷰는 승인 완료이며 사용자/팀의 병합과 실제 기기 QA는 별도다.
- 정확한 근거와 웹 배포 진행 경계는 [권한관리 체크포인트](../dentlink-permission-management.md) 최신 절을 따른다.

## 현재 전달 상태 — 2026-10-19 사용자 재승인으로 Office Staging v336 배포 완료

- 사용자가 웹 stage 재전달 준비 후 앱도 기존 작업브랜치로 Staging CodePush를 다시 하도록 명시 승인했다. `feature/DL-16317@f037c80153b328bbb14fcafd5fb756a59fd4cc8e`를 양OS Staging **v336/2.2.4/mandatory/100%/enabled**로 전달했다.
- 각 명령1회 exit0·서버 history·소스 설명/설정 확인. 격리 git archive967파일/immutable 설치/주요SDK와 native baseline 일치, 소스맵341자체파일 일치 검증. 기존 영상 크기 경고는 이전과 같은 force 경로로 성공.
- PR329 OPEN→develop·headf037c80 유지, 본문 최신 v336/이전 v335 이력 반영. 원본worktree clean·Member시뮬레이터/Metro보존, Production/Development/Lab 및 태그/스토어/Slack/Jira 변경 없음.
- 임시격리source/node_modules만 삭제했고 번들/maps/logs/metadata는 보존했다. `/tmp/dl16317-stg-codepush-repeat-current.json` 및 [권한관리 체크포인트](../dentlink-permission-management.md) 참조.
- 웹 PR4719 release병합 확인 후 master기준 stage 재생성 및 PR4720 release→stage 준비 완료. 웹 PR4720은 정리 중 사용자 병합(stage4b28c28a6)됐고 3제품 배포가 진행 중이다. 배포 최종 성공·앱 실제 기기v336적용/QA·개발자리뷰/병합·운영전달은 별도다.

## 이전 전달 상태 — 2026-10-19 권한별 API 설명 주석 PR329 반영 완료

- 사용자 승인에 따라 기존 `feature/DL-16317`에 `f037c80153b328bbb14fcafd5fb756a59fd4cc8e`를 커밋·푸시했다. HomePaymentReplacementBanner.tsx 주석5줄만 변경했으며 ESLint/diff PASS, 원격 일치·clean이다.
- PR329 OPEN/비Draft→develop 최신 head·본문 반영·현재 작업 attach 확인. 앱 직접 호출이 없는 웹 결제GET3개와 기존 배너의 OWNER/PAYMENT_MANAGER 조건을 구분했다.
- 앱 런타임 변경이 없어 별도 CodePush는 필요 없다. 실제 양OS Staging v335/2.2.4 소스는 기존 `5c3504d`이며 본문 기록을 보존했다. Developmentv139·Production·Lab·Jira 변경 없음.
- 웹은 새 feature/DL-16317-api-permissions@5bdad60e6를 PR4719→release/v1.89.0으로 전달했다. 미병합·미배포이며 반영 후 권한별 확인이 남는다.
- 앱 개발자 PR리뷰·develop 병합·전체QA/운영 출시는 별도다. [권한관리 체크포인트](../dentlink-permission-management.md) 최신 절에 정확한 API 표와 검증 근거를 보존했다.

## 이전 확인 — 2026-10-19 Editor 결제 API 후속, 앱 로직 추가 불필요

- 웹 Staging Editor에서 결제 건수 2건과 v2 결제수단 목록 GET 403을 확인해 웹 중앙 query를 보완했다. 앱에는 세 API의 네이티브 실제 호출이 없고 생성 선언만 존재한다.
- 앱 `feature/DL-16317@5c3504d`의 HomePaymentReplacementBanner.tsx에 기존 US + OWNER/PAYMENT_MANAGER 최초/복귀 조회 조건 설명 주석 5줄만 추가했다. ESLint/diff PASS, 동작 변경 없음, 아직 로컬 미커밋 상태다.
- 기존 PR329 OPEN→develop, 양OS Staging v335/2.2.4, Development v139는 그대로다. 별도 앱 CodePush가 필요한 변경은 없다.
- 제품 Git 전달 전이며 다음 재개는 웹 새 feature→release PR 및 앱 기존 브랜치 주석 커밋 전달 여부다. 실제 계정 QA·앱 개발자 리뷰·운영 출시는 기존대로 별도다.
- 경로·역할별 API 표·서버/브라우저/로컬 검증 증거와 다음 시작점은 [권한관리 체크포인트](../dentlink-permission-management.md) 최신 절을 따른다.

## 이전 전달 상태 — 2026-10-19 권한관리 Staging v335·QA 준비

- 사용자가 웹·앱 QA 요청 완료를 확인했다. 추가 작업·조회·모니터링 없이 QA 결과 전달까지 대기한다.
- 사용자 명시 승인으로 이번에만 `feature/DL-16317@5c3504d`에서 Office iOS·Android **Staging v335**를 직접 CodePush했다.
  target2.2.4·mandatory·100%활성, 양명령 성공·서버 history·source map 제품339파일 일치 확인. 최신 틀니 캐시·채팅 타입 보완 포함.
- PR329는 앱 개발자 리뷰를 위해 **OPEN→develop·미병합** 유지한다. 본문에 전달 상태를 갱신했으며 일반 배포 정책을 변경한 것은 아니다.
  Developmentv139(be332c5)·Production·Lab 앱은 그대로다. 원본feature/worktree와 사용자 Member 시뮬레이터·Metro를 보존한다.
- Office Jira DL-16752를 **READY FOR QA**로 변경하고 업데이트 적용 조건·권한별 QA 범위를 기록했다. 실제 기기 v335 적용/전체QA는 아직이다.
  웹은 사용자 Staging 반영 확인/추가조회 중단 지시에 따라 DL-16319도 READY FOR QA로 정리했다. 양카드 상태·댓글 저장 확인 완료.
  Clinic Actions 최종 성공은 추가 조회하지 않았으며 사용자 확인과 독립 검증 경계는 [권한관리 체크포인트](../dentlink-permission-management.md)에 남겼다.
- 다음은 Staging2.2.4 앱에서 업데이트 적용 후 Admin/Member 통합QA 및 앱 개발자의 PR리뷰다. 추가 확정 FE개발·필수BE문의는 없고 QA결과를 기다린다.
  배포 아티팩트/설정/hash·검증 경계·이번 직접feature 배포 예외는 상세 체크포인트에 보존한다.

## 이전 전달 상태 — 2026-10-19 최종 리뷰 보완·PR329 반영 / 이후 배포 사용자 담당

- 앱 기존 `feature/DL-16317@5c3504d`에 틀니 저장 후 직원별 캐시 갱신(586381f)과 최근 채팅 응답 타입 보완을 커밋·푸시했다.
  기존 PR329 OPEN→develop·MERGEABLE/CLEAN, 로컬/origin 동일·clean. 새파일·UI·문구·정책·네이티브/lock/env 변경 없음.
- 확정 회귀는 틀니 워크플로 생성/변경 후 옵션 단계 무한 로딩·이전 옵션 표시 가능성이며 기존 테스트에2케이스로 수정 전 실패/수정 후 성공을 확인했다.
  최종 관련23 suites235 tests·3파일lint/diff PASS. exact 의존성 tsc는 origin/develop과 동일한 기존6진단(신규0), 전체통과는 아니다.
- 웹 stage 재생성→release/v1.89.0 PR4717 생성 후 사용자 병합 확인. 웹 최근 결제배너/앱 승인 연계 부분 재검토에서 추가 수정은 없었다.
- 기존 Development v139는 be332c5이므로 최신 두 커밋은 아직 미배포다. 사용자 지시에 따라 코드/PR까지만 정리했고 앱 병합·CodePush는 하지 않았다.
  Staging 통합 QA에는 최신PR이 포함된 Staging 앱이 필요하며 Development 앱은 dev-portal을 본다. 전체실기기QA·성능계측은별도다.
- 상세 SHA·증거·웹전달 상태는 [권한관리 체크포인트](../dentlink-permission-management.md) 최신 절을 따른다.

## 이전 전달 상태 — 2026-10-19 Member QA 보완 및 Development v139

- `dentlink-app-permission`의 `feature/DL-16317@be332c5`에 필터 두 탭50:50과 홈 결제 안내 API의 전체 역할 조건을 커밋·푸시했다.
  서버 보안 설정상 OWNER/PAYMENT_MANAGER만 허용하므로 EDITOR/VIEWER/MEMBER/권한미확정에서는 조회·배너표시를 막는다.
  앱에서확인한Member403은기존결제배너권한누락이며주문요약0/0/0으로카드가없는현상과별개다.
- iOS시뮬레이터 실제Member·Reactotron으로원인/수정/필터를확인했고,기존필터3개+최종배너임시10개검증통과(임시파일삭제).
- 사용자승인으로최종be332c5를Office iOS/Android **Development v139**에배포했다. 양OS2.2.4·mandatory·100%활성·exit0·서버read-back·source map일치확인.
  PR329 OPEN→develop·미병합. 실기기v139적용/전체QA·Staging/Production은별도다. fresharchive immutable설치로공유node_modules미변경.
- 배포 후 사용자가 앱 홈 오류 해소와 필터 디자인 적용을 확인했다. 사용 OS/적용 라벨 및 전체 역할 QA는 별도다.
- 웹도같은서버기준으로QA PR4716→release/v1.89.0 생성,미병합·미배포. 상세원인/근거/hash/다음순서는[권한관리체크포인트](../dentlink-permission-management.md)를따른다.

## 이전 전달 상태 — 2026-10-19 권한관리 feature Development v138 CodePush

- 사용자 승인으로 `feature/DL-16317@6437dbb` 전체 번들을 Office iOS·Android **Development v138**로 배포했다.
  대상2.2.4·mandatory·100% 활성 read-back 완료. PR329는 OPEN→develop·미병합이며 Staging/Production·웹/Lab 전달은 이번 대상이 아니다.
- `dentlink-app-permission/node_modules`의 외부 symlink에는 lock과 다른 Amplitude·Datadog 및 누락된 Firebase analytics가 있었다.
  공유 의존성은 건드리지 않고 HEAD archive+`yarn install --immutable` 격리 환경으로 정상 번들·Hermes·업로드했다.
  package/lock/native는 release와 동일하다. 후속 배포/검증 때 공유 node_modules의 일치를 별도 확인한다.
- 실제 기기 OTA 적용과 QA는 사용자 요청까지 대기한다. 브랜치/worktree는 보존하며 자세한 라벨·hash·검증·다음 순서는
  [권한관리 체크포인트](../dentlink-permission-management.md)를 따른다.

## 이전 정리 상태 — 2026-10-16

- 출시된 Remake 작업 `feature/DL-16652` 원격 브랜치를 삭제했다. PR #318의 병합 커밋은
  main 및 v2.2.4.82/.83 출시 태그에 포함되고 관련 3파일은 현재 main과 같다.
  Production 양OS v83 활성·설치 기록도 확인했으나 OTA 설명의 정확한 소스 SHA 증명과는 구분한다.
- 기본 local `main / a32aa691199db8c7c0d866af0293a6b9970d8a8d`은 clean이며
  origin/main보다 18커밋 뒤인 상태를 유지했다. 정리 목적으로 관련 없는 최신화를 하지 않았다.
- 권한관리 `feature/DL-16317 / df3c79a`와 `dentlink-app-permission` worktree는
  PR #329 미병합·미출시이므로 보존했다. 이 저장소의 로컬 브랜치/worktree 삭제는 없다.
- 삭제 전 Git bundle은 공용 Git 디렉터리의
  `codex-closeout/released-branch-cleanup-20261016/office-released-branches.bundle`에 있다.
  현재 전체 인벤토리와 삭제 기준은 [FE 정리 기록](../dentlink-fe.md)을 따른다.

## 앱 공통 작업 정책 — 2026-10-08

- [앱 온보딩·작업·배포 정본](../dentlink-app-onboarding.md)을 함께 읽는다.
  후속 사용자 정정으로 일반 feature PR은 `develop`이 기본 대상이다. 같은 바이너리의 호환 CodePush는 기존 release를 유지한다.
- 최초 확인 당시 release는 `release/v2.2.4 / 14557194c12f8836362d3663b27ab3b621c0478a`였다.
  #314·#316 병합/#317·#318 open 기록은 당시 이력이며 현재 전달 상태는 최신 체크포인트를 따른다.
- 제품별 Jira 카드와 merge·태그·OTA 업로드/활성화/설치·스토어 심사/출시 상태를 분리한다.
  온보딩 최초 조사는 지침 정리였으며 제품 코드·PR·release·배포를 변경하지 않았다.
  이후 승인된 동기화 PR 생성은 아래 별도 기록을 따른다.

## release → develop 동기화 — 2026-10-08

- 사용자 승인으로 [PR #321](https://github.com/Innvoaid/dentlink-app/pull/321)을 생성했다.
  `release/v2.2.4 / a00efb1e78ee192a3512b2ab6ad9260ce160a6d2` → `develop`이며
  생성 당시 develop `52966b80` 대비 release 고유 6커밋·develop 고유 5커밋이었다.
  전체 diff는 33파일(+3166/-148)이며 기존 #314·#316·#317·#318·#319·#320 반영 내용을 포함한다.
  기존 iOS 프로젝트·Gemfile.lock 변경도 포함되므로 native 변경 없음으로 보고하지 않는다.
- 기존 양 브랜치의 범위·전체 diff·공백 검사·병합 충돌 없음과 자동화 이후 실제 develop 대상을 확인했다.
  이 동기화 준비에서 새 기능 QA·네이티브 빌드는 실행하지 않았다.
- GitHub에서 `jongsunP`의 병합을 확인했다: 16:08:37 KST,
  merge commit `04ed4e5b41ea0d4686b40b5d652c0b8d99645e8d`.
  메인 세션은 PR 생성까지만 실행했으며 병합·배포는 실행하지 않았다.
- 이후 작업은 별도 세션에서 진행한다는 사용자 지시에 따라 메인에서는 지침 정리만 마무리한다.

## 앱 저장소 분리 및 업무 범위 — 2026-10-06

- 사용자 확정: Office/Lab 앱이 최근 별도 저장소로 분리됐다. 앞으로도 모든 앱 업무에서
  제품을 먼저 구분하며 이 문서는 **Office 앱 `Innvoaid/dentlink-app`**의 정본이다.
- live `origin/develop`에 2026-09-30의 `[DL-16313] 치과 & 기공소 git repository 분리 (#310)`
  (`3b0ea8d`)가 포함돼 있다. 현재 `APP_SERVICE_TYPE=OFFICE`, 환자목록 API는
  `/office/patients/consolidate`다. 과거 공용 `shared/features` 또는 Lab 빌드를 현재 경로로 사용하지 않는다.
- 기공소 앱은 [dentlink-lab-app.md](../dentlink-lab-app.md)의 별도 저장소·runtime·release를 따른다.
  DL-16652 환자 목록은 웹 Lab·Lab 앱만 대상이다. 이후 확정된 **전역 Remake 배지**만
  Office에도 적용했으며 아래 최신 전달 기록을 따른다.
- 이 확인에서 Office 저장소는 fetch만 했다. 기본 checkout은 `main / 19f6810`,
  `origin/main` 대비 1커밋 뒤이며 권한관리 worktree도 존재한다. 아래 2026-09-28의
  단일 worktree·로컬 동기화 상태는 당시 기록이며 현재 상태로 재사용하지 않는다.

## DL-16652 현재 확인 — 2026-10-08 Clinic 재검토·추가 수정 없음

- 사용자 양앱검증/필요수정 승인 후 최신 origin/release/v2.2.4@a00efb1e를 독립 재검토했다.
  실제 transformer는 white path를 유지하며 일반 NEW는 purple600 원24px 안 white teeth12px다.
  Clinic 환자카드는 caseStatus 텍스트로 해당 치아 경로를 쓰지 않는다. #318 Remake 수정과도 무관하다.
- 소스 기준 같은 대비 결함이 없어 Clinic 추가 변경/커밋/PR/배포는 하지 않았다.
  실제 Clinic 설치본 화면/OTA bundle 확인은 별도이며 정상 실기기 QA 완료로 확대하지 않는다.
- Lab 카드만 [PR8](https://github.com/Innvoaid/dentlink-lab-app/pull/8) →release/v1.0.4로 원본14px/#959595 보정을 전달했다.
  이후 사용자 병합59e6a56c와 Lab 양플랫폼 Staging v32 재배포를 완료했다. Clinic 추가 배포는 없다.
  실제 Lab v32 적용/화면QA는 별도이며 상세는 [DL-16652 정본](../dentlink-patient-list-design.md)을 따른다.

## 이전 확인 — 2026-10-08 검토 중 아이콘 양 앱 비교

- 사용자 Lab 실물 제보에 따라 Office도 읽기 전용으로 확인했다. 최신 release/v2.2.4@a00efb1e와
  기존81584b82의 OrderProgressStatus/SvgTeethFilled/Icon/PatientCard/KO 리소스는 byte 동일하다.
- 검토 중 NEW는 보라색 primary600 원(24px) 위 흰색 teeth(12px)라 Lab 새 환자 카드의
  흰 배경/고정 white 결함과 다르다. Office 환자 카드는 별도 caseStatus 텍스트 배지다.
  #318은 Remake 3파일만 변경해 검토 중 아이콘은 손대지 않았다. Office 소스에 같은 대비 결함 근거는 없다.
- 실제 Office 기기 화면은 사용자 확인 중이며 이번 조사에서 제품 코드/PR/배포/Jira는 변경하지 않았다.
  기공소 카드 결함과 보정 시작점은 [DL-16652 정본](../dentlink-patient-list-design.md)에 둔다.

## 이전 확인 — 2026-10-08 클리닉 사용자 병합

- 사용자가 #318을 병합했다고 알렸고 live MERGED를 확인했다. merge
  bf9e897ef72d37190cc52c84cd796ce2ec6a0e3c, 15:02:42 KST다.
  root가 대신 병합하거나 클리닉 source/PR을 추가 수정한 것은 아니다. CodePush 적용/배포QA는 별도다.
- 아래 OPEN/승인대기는 이전 상태다. Lab 후속 릴리스 충돌 해결은 별도 제품의
  [DL-16652 최신 정본](../dentlink-patient-list-design.md)을 따른다.

## 이전 확인 — 2026-10-08 변경 범위 재점검·PR 유지

- 사용자 앱 PR 전체 정리 지시로 #318을 최신release/v2.2.4(14557194c)와 다시 비교했다.
  HEAD81584b82의 전체 diff는 배지3파일(+16/-14)뿐이고 나머지 tracked 파일은 release와 동일하다.
  커밋8개에 기존 이력이 있어도 추가 실제변경이 없어 새브랜치/PR 재작성은 불필요하다.
- 기존 [PR #318](https://github.com/Innvoaid/dentlink-app/pull/318)을 유지하고 본문에 scope audit를 추가했다.
  최신 live 상태는 OPEN/non-Draft/MERGEABLE/CLEAN·**APPROVED**, CodeRabbit SUCCESS·미해결0·
  검사pending0·autoMergeRequest=null이다. 실제 merge·배포·제품코드 변경은 하지 않았다.
- 변경patch 불변으로 아래 버전/lint/renderer3 및 release/fulltsc8진단 동일·신규0 근거를 보존한다.
  새 기기/실제Remake/OTA 확인은 아니며 최신 공통 정리는 [DL-16652](../dentlink-patient-list-design.md)에 둔다.

## 이전 확인 — 2026-10-08 릴리스 동기화 완료

- 사용자 승인 외 준비 실행 지시로 기존 feature에 최신release/v2.2.4(14557194c)를 충돌 없이 동기화했다.
  Merge commit81584b8201edffd00b2261aaa5d7322be493bd1e를 push했고 release ref는 변경하지 않았다.
- PR #318은 OPEN/non-Draft/MERGEABLE/REVIEW_REQUIRED/BLOCKED, release 뒤처짐0·3파일(+16/-14)이다.
  3파일과3958bytes기능patch는ffcdc736과동일하다. 새branch/코드재작성/별도기반PR없이 사람승인만남았다.
- 버전2.2.4/diff/scopeESLint/badgePrettier/renderer3 PASS. generatedindex의Prettier는release동일기저형식문제다.
  최신release와syncHEAD의 fulltsc8개/exit2·5765bytes로그가byte동일해신규오류0이며 전체검사통과는아니다.
- 새HEAD CodeRabbit SUCCESS·추가actionable0·미해결0, 기존리뷰를동기화결과에승계한완료다.
  PR본문을갱신했고 실제PRmerge·배포·태그·메인세션보고·Jira변경은하지않았다.
  기존기기/실제OfficeRemake/OTA미검증경계와 다음시작점은 [DL-16652 정본](../dentlink-patient-list-design.md)을따른다.

## DL-16652 iOS 후속 QA — 2026-10-08 이전 확인

- PR #318은 OPEN/non-Draft/MERGEABLE/CLEAN, HEAD `ffcdc73`는 소스·원격 동일하다. 새 제품 수정은 없다.
  최종 Figma/댓글의 primary600·reset16·text14/21·gap4는 기존 구현과 일치한다.
- DeviceHub 입력 연결이 회복돼 own iOS 26.5에서 정식 cached Debug 앱 2.2.4(151)+최신 Metro8090을
  확인했다. 정상 로그인·serviceType OFFICE 및 승인 QA 계정 일치가 확인됐다. 오늘 새 native build는 없다.
- 현재 자동 활성 employee/employer는 dotenv의 inline 주석 제거·정수 정규화 후 clinic QA 지정 ID와
  모두 일치한다. 최초 false는 검사 helper 오류로 정정했다. 그룹 활성화·서버 변경 없이 Home/Orders 및
  초기 대기 8건 중 가시 2행을 확인했다. 실제 Remake 미발견이며 필터 Reset/Done·wheel 시도는 수행 확증/
  가시행 변화가 없어 필터 초기화·paging 성공으로 계산하지 않는다. 전체 계정/8행 Remake 0건은 아니다.
- 실제 Office Remake·별도 iOS local fixture는 미검증으로 남기고 기존 renderer 3/3 증거와 구분한다.
  own sim·Metro8090·본인 root.env를 정리했으며 원본 env/lock/설정 불변·ffcdc73 clean/원격 동일이다.
  PR #318 본문 갱신/readback·자동 검사 SUCCESS를 확인했다. 전체 다음 시작점은 [DL-16652 정본](../dentlink-patient-list-design.md)에 둔다.
  아래 DeviceHub timeout·authstore false는 10월 7일 확인 이력이며 현재 입력/로그인 상태가 아니다.

## DL-16652 Office Remake 전달 — 2026-10-06~07 이력

- 사용자가 디자이너 구두 답변으로 웹·앱 모든 Remake 배지 사용처의 변경을 확정했다.
  Office 환자 목록은 바꾸지 않았고 OrderListRemakeBadge→OrderOfficeListItem의 배지만 변경했다.
  상세는 웹View의 /orders/:id이므로 웹 공용 Remake 변경을 사용한다. 회차 선택 탭은 제외했다.
- worktree `/Users/parkjongsun/Repository/dentlink-app-patient-remake`, `feature/DL-16652`.
  base origin/develop `52966b80f7b5fae20b14ad530f2ae7e0ce79a1d3`, HEAD/원격
  `ffcdc736a327e0fbe0293aa0d4d868ca6561b216`, clean·0/0 확인. 최초 `ed604e6` 후 최신 Figma 색상만 보정했다.
- [PR #318](https://github.com/Innvoaid/dentlink-app/pull/318) → develop, OPEN/non-draft/MERGEABLE/CLEAN.
  공통 배지·16px 원본 SVG·자동 export3파일만 포함한다. 자동 제목/본문/라벨 검사는 성공했다.
  CodeRabbit SUCCESS는 develop 자동 리뷰 제외에 따른 skip이며 실제 리뷰 완료로 표현하지 않는다.
- 배경/테두리/여백 없는 reset16+text14/21+gap4, **text/icon primary600**으로 통일했다.
  23시 원본의 Default/Pressed/Long/Short/main 색상 변경을 확인해 primary700에서 최소 보정했다.
  기존 Remake 문구·번역은 유지하며 신규 시트 행이 없다.
- renderer3/lint0/Prettier/diff와 Android·iOS Metro bundle 통과. 최초 shared node_modules에서는
  Datadog2.14.8이 현재 manifest와 달랐고 baseline/final 타입18개가 동일했다.
  전용 checkout에 immutable 의존성을 설치해 Datadog3.7.0/RN0.82.1을 맞췄으며 primary 공유
  의존성과 product manifest/lock/환경/서명은 보존했다. 새 환경의 baseline/final 타입6개도 byte동일·신규0이다.
- 정상 developmentDebug APK2.2.4/code134 재빌드(1m50s)·fresh Android36 AVD 설치 후 표준
  index.bundle/Metro8090으로 실제 로그인·Home·주문 목록과5회 scroll을 확인했다. 가시 Remake0여서
  **Office 실제 주문의 새 배지 표시 자체는 미검증**이며 renderer3과 Lab 합성 기기 배지를 대체 증거로
  혼동하지 않는다. 10월6일 새 의존성 기준 iOS Metro bundle exit0/75assets를 확인했고,
  아래10월7일 정식 native build/startup 확인과 구분한다. 실물/로그인 이후 iOS UI·배포는 미실행이다.
- 본인 Metro8090·AVD5582를 종료하고 임시 AVD를 삭제했으며 기존 adb 서버와 다른 runtime은 보존했다.
- 10월7일 잠금 버전 Ruby3.4.10/Bundler2.7.2/CocoaPods1.16.2를 독립 설치하고 canonical
  `pod install --deployment --repo-update`를 완료했다. stale AmplitudeSessionReplay0.12.8 index를
  공식 목록 갱신으로 해결했으며 버전/lock/SDK/서명/영구 설정은 바꾸지 않았다.
- 정식 DentlinkDevelopment Debug arm64 빌드가 성공했다. 2.2.4(151)을 own iPhone16/iOS26.5에
  정상 설치·실행하고 표준 Metro8090과 미인증 EN 알림 안내 화면을 확인했다.
  현재 resolved target/runtime 모두 arm64여서 과거 x86_64 불일치는 이번 target에 적용되지 않는다.
- Xcode27 DeviceHub의 Cua 공식경로/bundle ID 선택이 각각35초/5초 timeout/window0으로 실패했다.
  공식 simctl io는 tap/type를 제공하지 않아 현재 도구로 실제 로그인은 진행 불가다.
  iOS authstore 없음/loggedIn false, QA group binding·주문 목록·실제 Remake는 미확인이다.
  등록된 물리 iPhone2대도 disconnected/shutdown으로 연결 기기0대다. 제품 실패로 표현하지 않는다.
- 본인 생성 pbxproj와 ignored root.env를 원복하고 own iOS sim·Metro8090을 정리했다.
  원래 env/lock/설정 불변·ffcdc73 clean/원격 동일, PR318 iOS 결과 본문 반영/readback과
  미해결 리뷰0개를 확인했다. 추가 제품 수정·커밋은 필요하지 않았다.
- 기존 primary와 권한관리 worktree는 보존했다. 앱 PR 미생성 지시는 이후 사용자 PR 승인으로 변경됐다.
  병합·배포는 하지 않았다. 제품 공통 정본은 [DL-16652](../dentlink-patient-list-design.md)다.

This is the current resume source for the first local setup of
`Innvoaid/dentlink-app`.

The current scope checkpoints are **앱 저장소 분리 및 업무 범위** and **DL-16652 Office Remake 전달** above.
**Local Audit And Sync - 2026-09-28** below is historical. **FE Handoff Acceptance And Develop Integration -
2026-09-11** preserves earlier delivery context; the E2E audit adds verification boundaries.
Earlier PR review, notification design and
delivery sections record the preceding implementation and decisions. Earlier
dated delivery, review, API and runtime results below are historical, not
current claims.

## Local Audit And Sync - 2026-09-28

- 사용자 전체 로컬 정리 요청으로 확인했다. 기본 `dentlink-app` checkout과 로컬
  `main`만 있고 별도 worktree·stash·미커밋 파일은 없다.
- `fetch --prune`으로 원격에서 이미 삭제된 두 추적 ref
  (`origin/feature/DL-16292`, `origin/wip/transfer`)를 정리했다. 원격은 변경하지 않았다.
- clean 상태에서 `pull --ff-only`로 `e0f4d5d`부터
  `7403721151f3d2135799a995bccdd2214783822d`까지 갱신했다. 로컬/원격 0/0·clean 확인.
- 이번 작업은 동기화와 정리이며 구현·새 QA·배포 완료 증거가 아니다. 다음 기능 작업의
  base/target은 재개 시 확인한다. 이전 기능 전달·삭제 이력은 아래에 유지한다.

## Local Branch Cleanup Completed - 2026-09-14

- The user authorized cleanup after the read-only audit below. Rechecked the
  clean feature checkout, absence of extra worktrees/active writing tasks, and
  exact local/remote feature preservation before changing local Git state.
- Switched the main app checkout to `main` and fast-forwarded it from
  `51aeb15` to `e0f4d5dd996a691b32a5ba288d826abb039105ce` using `--ff-only`.
  It is clean, tracks `origin/main`, and has 0/0 divergence.
- Deleted only local `feature/DL-16061` with `git branch -d`. Git warned that
  the original feature SHA is not an ancestor of HEAD because PR #286 was
  squash-merged. Before deletion, its tree was verified identical to squash
  `c205fe0`, which is an ancestor of current main; the remote feature remains
  unchanged at `a8f3a6cbb81c218b7ab16bed8e7d4b71fab45dd7`.
- Only local branch `main` and the main worktree
  `/Users/parkjongsun/Repository/dentlink-app` remain. No stash existed or was
  created. No product commit/push, remote deletion, PR change, test run, or
  deployment was performed. Existing ignored runtime/build files were retained.
- Future app work starts by checking this main checkout and the current
  feature base/target; do not restore the completed feature branch as an active
  implementation branch.

## Previous Local Branch And Worktree Audit - 2026-09-14

- Read-only audit after fetching origin found only the main app worktree at
  `/Users/parkjongsun/Repository/dentlink-app`. It is checked out on
  `feature/DL-16061` at `a8f3a6c`, clean with no non-ignored untracked files,
  synchronized 0/0 with its preserved remote branch.
- PR #286 is merged; the feature tree exactly matches its squash result
  `c205fe0752e06c17866bc3873c94a5b6e2e492c2`. That squash is now contained in
  `origin/develop`, `origin/main`, and `origin/release/office/v2.2.3.73`.
  This verifies code preservation/integration, not a fresh deployment or QA run.
- `feature/DL-16061` is a completed local branch cleanup candidate. It is the
  currently checked-out branch, so actual deletion requires a prior checkout
  switch and the user's explicit cleanup instruction. No deletion or switch
  was performed for this status question.
- The other local branch is `main` at `51aeb15`, 15 commits behind origin with
  no local-only commits. Keep it as the default branch; being behind is a
  synchronization issue, not evidence that it is unnecessary.
- There is no extra registered worktree and no app-path active writing task
  in the current task inventory; `통합알림센터세션` is idle. Recheck ownership
  and dirty state immediately before any requested cleanup.

## Project Role And Continuity

- The user currently owns frontend work across both Dentlink web and mobile
  app. Do not treat the app as an optional or secondary scope merely because
  the user's earlier workload and experience were web-centered.
- Expect both occasional small app tasks and features whose user flow spans web
  and mobile. For cross-surface work, inspect the relevant web and app code,
  API contracts, release paths, and QA impact together.
- 통합알림센터 문의는 `projects/dentlink-unified-notification-center.md`를 읽는다.
  2026-09-03 후속 지침으로 기기 간 실시간 동기화를 제외하고 REST 기반으로
  변경했다. 읽음·삭제 동기화용 데이터 FCM은 추가하지 않으며 기존 FCM·Notifee
  사용자 푸시는 유지한다. 사용자가 별도 웹·앱 통합 관리 세션을 개설했다.
  공통 딥링크·알림센터 읽음 처리는 그 세션이 담당하고, 이 세션은 기존 피드백
  기능을 담당한다. 현재 별도 worktree 없이 같은 저장소를 참조하므로 공통 파일
  구현 전 브랜치와 작업 범위를 조율한다. 관리 세션 개설을 구현 완료로 간주하지
  않으며, 피드백 구현이나 개별 푸시 작업의 완료 상태와 섞지 않는다.
- Resume from this onboarding checkpoint instead of repeating setup from
  scratch. At the start of future work, sync this personal context and all
  relevant shared repositories, then verify live Git refs and current team
  documentation.
- The app team's verified feature base is `origin/develop`. The main local
  checkout returned to `main` after the completed feedback feature was cleaned
  up. Always verify the live checkout and current base/target before new work.
- For a very small localized task, confirm whether a dedicated worktree is
  necessary before creating one. Use a dedicated feature worktree/session for
  larger work when requested.

## User Background And Guidance Style

- The user is an experienced frontend developer working primarily with React
  and TypeScript who now handles both Dentlink web and app work. Assume
  familiarity with components, hooks, state, API flows, types, styling,
  review, and web delivery; do not teach these from zero.
- The knowledge gap is the mobile ecosystem around otherwise familiar React
  code. Explain unfamiliar concepts by mapping them to web equivalents, then
  focus on the mobile-specific difference and the practical consequence.
- Proactively identify whether a task is JavaScript-only or crosses the native
  boundary; cross-platform or platform-specific; Metro-refreshable or requires
  a native rebuild; simulator-verifiable or needs a physical device; and safe
  for the user to implement or better handed to the app developer.
- The user's current scope includes web and app frontend delivery. Deep native
  work, signing, store deployment, and final platform-specialist review may
  still require the app developer. Ask before implementation when a requested
  change crosses that boundary or carries material platform risk.
- Guide in context while doing the work: explain permissions, lifecycle,
  navigation, storage, networking, push, deep links, build variants, and
  device/simulator constraints only as they become relevant. Keep explanations
  concise but surface risks and validation requirements before they surprise
  the user.
- Start from Git-backed personal context, then verify drift-prone facts against
  the live repository, team documents, Jira, Figma, and API contracts. Do not
  rely on AI memory alone. At handoff, report Android and iOS verification
  separately and identify what still needs the app developer's review.
- In an app-focused session, interpret the user's shorthand `Chrome control`
  as a request to inspect and operate the app directly in the Android emulator
  or iOS simulator. Use the actual Chrome browser only when the user explicitly
  asks for Chrome itself or when Figma, planning, Swagger or another web source
  must be inspected. For ordinary shared app work, use the iOS Simulator as the
  user's fast primary loop and validate Android at a sensible checkpoint before
  CodePush; start on the affected platform for platform-specific work. Run app
  commands in a visible, on-demand Codex terminal rooted at the exact app
  checkout; the user manages the IDE separately and Codex must not operate its
  terminal.
- For remaining-task briefings, distinguish unfinished in-scope implementation
  from normal QA, approval, merge and deployment steps. The user understands
  those delivery steps and does not count them as missing development tasks.
  Do not repeatedly list a general pre-existing upload recovery improvement
  as unfinished feedback work. Defects introduced by the current changes still
  belong in scope and must not be hidden. The notification-setting BE wait is
  acknowledged; resume its actual integration when the user reports release.

## Repository

- Shared repository: `https://github.com/Innvoaid/dentlink-app`
- Active local checkout: `/Users/parkjongsun/Repository/dentlink-app`
- Repository default branch: `main`
- Active feature base and PR target: `develop`
- Current branch: `feature/DL-16061`
- Current HEAD: `a8f3a6cbb81c218b7ab16bed8e7d4b71fab45dd7`
- The checkout is clean and synchronized with `origin/feature/DL-16061`.
- PR #286 was squash-merged into `develop` at 15:09:46 KST on 2026-09-11 as
  `c205fe0752e06c17866bc3873c94a5b6e2e492c2`, whose tree exactly matches the
  feature HEAD. `origin/develop` is now
  `f75d7d9b27a3bb32e69726dd6e6f8792c756a710`, including subsequent PR #295.
  `origin/main` and `origin/release/office/v2.2.3` remain at `967ba71`.
  Preserve the current checkout until the user explicitly requests cleanup;
  do not reuse this completed feature branch for new work.
- This first feature was intentionally implemented in the existing checkout.
  For a later substantial feature, use a dedicated feature worktree/session
  only when the user requests it; for a tiny task, ask first.

## Team Onboarding Sources

- `웹 FE를 위한 Dentlink 앱 피처 개발 가이드`:
  `https://app.notion.com/p/3c6ce072e82f80e3818ee8ecb35468fc`
  - Reusable minimum workflow for web-led supporting app features; excludes
    one-time setup status and routes deep native, signing, release, and final
    specialist review to the app developer.
- `APP 프로젝트 시작`:
  `https://app.notion.com/p/3c6ce072e82f80e58f0fdf8c8d3b9db6`
- `Reactotron 세팅 (네트워크 확인)`:
  `https://app.notion.com/p/3b2ce072e82f80f9a5a9ee60923437ae`
- `APP 모노레포 브랜치 전략`:
  `https://app.notion.com/p/39fce072e82f80f99f47e7161c1adf1f`
- The branch model is present in live remote refs and PR automation. The CI/CD
  checks listed in the strategy document are recommendations rather than a
  fully implemented current gate; the current validation workflow checks app
  version consistency only on a limited path set.

## Local Environment

- Node `v24.4.1`; repository requirement is Node `>=20`.
- Yarn `4.9.1` is activated through Homebrew Corepack.
- Mise `2026.8.11` reads the repository `.tool-versions` and selects Ruby
  `3.2.2` in this checkout.
- The team onboarding page and `Gemfile.lock` specify Ruby `3.4.5`, while the
  committed `.tool-versions` selects `3.2.2`. This is a repository-owned
  source-of-truth conflict to confirm with the app team. The current Ruby
  `3.2.2` environment passes `bundle check` and native dependency/build checks,
  so it is not the present build blocker.
- Root, iOS, and Android Bundler dependencies are installed. The active `pod`
  command is CocoaPods `1.16.2`, while `bundle exec pod` follows the lockfile
  and uses CocoaPods `1.15.2`; Android Fastlane `2.228.0` runs under Ruby
  3.2.2.
- Android Studio Quail 3 `2026.1.3 Patch 1` is installed.
- JDK `17.0.19`, Android SDK root
  `/Users/parkjongsun/Library/Android/sdk`, API 34/35/36, Build Tools 35/36,
  CMake 3.22.1, and NDK 27.0/27.1 are installed. The user explicitly approved
  the additional Android SDK and ARM DBT license terms needed by the API 36
  ARM64 emulator image, and the required terms were accepted.
- `android/local.properties` points to the local SDK and is ignored by Git.
- `~/.zshrc` exports the JDK/Android SDK paths and activates Mise. `~/.npmrc`
  uses the absolute user cache path so npm does not dirty project checkouts.
- The local `.git/info/exclude` ignores `.npm-cache/` because npm initializes
  logging before applying the final absolute cache configuration.
- iOS Pods installed successfully: 123 Podfile dependencies and 159 total
  pods. The Xcode workspace exposes all six Office/Lab environment schemes.
- Watchman `2026.07.27.00` and Reactotron `3.11.0` are installed through
  Homebrew. Reactotron is available at `/Applications/Reactotron.app` and was
  opened successfully.
- Android Emulator `37.1.11`, the API 36 Google APIs ARM64 system image, and a
  Pixel 8 AVD named `Dentlink_API_36` are installed. The AVD boots and connects
  through ADB as `emulator-5554`; no physical Android device is required for
  the verified local development path.
- Apple iOS 26.5 simulator devices exist, but the committed project excludes
  `arm64` for `iphonesimulator` in `ios/Podfile`. `MLImage.framework` explains
  the exclusion: its arm64 slice targets a physical iOS device while its
  x86_64 slice targets the simulator. The same constraint remains in the newer
  MLImage `1.0.0-beta8`, so a dependency-version bump alone is not a proven
  fix.

## Verification

- `yarn install --immutable`: completed with existing peer-dependency
  warnings and no install failure.
- `yarn validate:versions`: passed for Office `2.2.2` and Lab `1.0.2` across
  package.json, Android, and Xcode.
- `bundle exec pod install`: passed. CocoaPods emitted OpenTelemetry license,
  duplicate generated UUID, and Hermes script-phase warnings.
- `xcodebuild -workspace DentlinkApp.xcworkspace -list`: passed and recognized
  `DentlinkDevelopment`, `DentlinkStaging`, `DentlinkLabDevelopment`,
  `DentlinkLabStaging`, and both production schemes.
- `./gradlew :app:assembleOfficeDevelopmentDebug`: passed in 12m 36s with
  1,107 tasks. The generated local APK is 264 MB and is ignored by Git.
- `:app:assembleOfficeDevelopmentDebug` was re-run from the repository root
  with the Office development env and passed incrementally in 10 seconds. The
  refreshed local debug APK is about 266 MB.
- With `Dentlink_API_36` booted and `yarn metro-log` running,
  `yarn android-office:dev` passed in 29 seconds, installed
  `com.innovaid.android.dentlink.development`, and launched `MainActivity`.
  Metro completed both Office bundles, connected to Android 16/API 36, and the
  app displayed its push-notification onboarding screen without a fatal
  runtime error.
- Android build warnings are dependency/tooling warnings: SDK XML version,
  older library build-tools declarations, AndroidManifest namespace,
  deprecated APIs, and D8 stack-map warnings. They did not fail the build.
- `yarn typecheck:apps`: failed on the clean current `main` baseline with 12
  TypeScript errors across 9 files. Representative areas are BottomSheet
  spring config, Icon props, order DTO date fields, chat message types, tooth
  icon types, and order product case-group types. No source fix was made during
  environment setup.
- Both Office and Lab typechecks reproduce the same 12-error baseline.
- Source-only lint over `apps` and `shared` reports 19 errors and 119 warnings.
  The repository `yarn lint` command also scans generated Android build output,
  causing more than 20,000 findings, so it is not currently a usable clean
  baseline.
- `yarn test` fails before test execution because Jest finds both
  `jest.config.js` and the `package.json` Jest configuration. With
  `jest.config.js` selected explicitly and `__tests__` isolated, 47 tests pass
  and 4 fail across two suites (`App.test.tsx` and `dentlinkWebURL.test.ts`).
- `yarn start` fails because React Native 0.82 no longer accepts the configured
  `--experimental-debugger` option. `yarn metro-log` starts Metro 0.83.7
  successfully and is the current local workaround.
- `react-native doctor` reports no Android SDK version, but API 34/35/36 and
  Build Tools 35/36 are present and the compileSdk 36 Android build succeeds;
  treat that doctor result as a detection false negative. After installing
  Watchman, Doctor recognizes Node, Yarn, Watchman, Xcode, Ruby, CocoaPods, and
  `.xcode.env`. ADB now recognizes the installed `Dentlink_API_36` AVD.
- An explicit Office development x86_64 simulator build passed using Rosetta,
  a temporary derived-data directory, and temporary header-path links for the
  `react-native-exit-app` Codegen headers. The app bundle is
  `DentlinkDevelopment.app` with ID `com.innovaid.dentlink.development`.
- The generated x86_64 app cannot be installed into the only available iOS
  26.5 ARM64 simulator runtime (`Failed to find matching arch`). An arm64
  build from the committed dependency graph fails because the MLImage arm64
  slice is an iOS-device binary.
- The `react-native-exit-app` package also references its generated header via
  paths CocoaPods does not expose in this build. The temporary `/tmp` links
  prove the package can compile, but a durable shared-repository fix still
  needs a maintenance scope.
- The README framework versions are stale: live dependencies are React Native
  0.82.1, React 19.1.1, and TypeScript 5.9.3, not the versions shown at the top
  of the README.
- Reactotron is wired into both Office and Lab development apps and the desktop
  app is installed. Both tracked `ReactotronConfig.js` files use
  `10.10.7.18`, while the Mac's current active address is `10.10.7.46`.
  For verification, the Office host was temporarily set to `localhost`,
  `adb reverse tcp:9090 tcp:9090` was applied, and Reactotron confirmed one
  Android 16/API 36 connection. The source was then restored, leaving the
  shared repository clean. A durable cross-developer host strategy remains a
  separate maintenance decision; the current address was not committed.

## Office Development Runtime Proof - 2026-08-24

- Android Office development was launched on `Dentlink_API_36`, authenticated
  against the development server with the supplied test account, and reached
  the Home dashboard for `frankieDevOffice`. The dashboard showed Action
  Required cards and the Home, LinkTalk, Orders, and Profile tabs.
- iOS Office development was also launched on the iOS 26.5 iPhone 17 Pro ARM64
  simulator, authenticated with the same test account, and reached the same
  Home dashboard.
- The iOS proof used an isolated `/tmp` source copy. Only that copy omitted the
  MLKit face-detection pod/plugin and the simulator arm64 exclusion, and its
  temporary Pods header aliases handled the `react-native-exit-app` Codegen
  path. The shared repository remained clean. Face recognition is therefore
  unavailable in this proof build, and the committed project still needs a
  durable simulator compatibility fix before `yarn ios-office:dev` is a normal
  Apple Silicon workflow.
- iOS first launch displayed a non-fatal Firebase Messaging development error:
  `messaging/unregistered` from calling `getToken` before remote-message
  registration. Returning from the notification Settings flow allowed login
  and dashboard use; track this as a separate runtime maintenance issue.
- At closeout, Metro was running on port 8081 and both Android and iOS were left
  on the Office Home dashboard. No credential was written to this checkpoint.

## Initial Setup Closeout And Future Work Contract

- The initial objective was to complete as much local app setup and runtime
  proof as possible, not to deliver a new app feature. That objective is
  complete: dependencies, native toolchains, Android Studio and AVD, Xcode and
  Pods, Watchman, Reactotron, Metro, native builds, development-server login,
  and the first Office dashboard were exercised in proportion to the current
  platform constraints.
- This repository remains an active development scope connected to Dentlink
  web. Future work may be mobile-only or span web and mobile; do not interpret
  the app's lower task volume as an instruction to omit mobile implementation
  or QA.
- On every future app session, refresh the Git-backed personal context and the
  live app repository first. Then verify the requested environment, branch,
  related Jira/Figma/API sources, and the closest production pattern before
  editing. Preserve `main` as the clean administrative checkout and base
  feature work on the live `origin/develop` policy unless the team state has
  changed.
- Reuse the verified Android path as the default fast feedback loop. Use the
  installed iOS proof app only for flows that do not require face recognition,
  and keep its temporary nature explicit. Do not claim full iOS readiness until
  a normal build, push registration, and any feature-specific native behavior
  are verified.
- Shared-repository code, commits, pushes, and PR changes still require the
  user's explicit authorization. Curated personal progress history should be
  updated and pushed at meaningful checkpoints. Never persist supplied login
  credentials in source, project notes, or Codex memory.

## Historical DL-15828 / DL-16061 UI Checkpoint - 2026-08-25 19:16 KST

### Cross-surface ownership

- The web implementation has its own canonical checkpoint in
  `projects/dentlink-client-order-feedback.md`; keep web branch, commit and QA
  history there instead of duplicating it here.
- This app repository owns the Office native Profile entry and native feedback
  list/detail screens. The current Order Detail screen remains a Clinic
  `/orders/:orderId` WebView, so its feedback banner/drawer/form remains owned
  by the web repository.
- Web and app are separate builds and cannot directly share TypeScript hooks.
  They must share the server endpoint/DTO meaning, canonical feedback state,
  count and invalidation behavior, while each repository implements its own
  adapter and query layer.

### Git and PR checkpoint

- Branch `feature/DL-16061` is clean at `4a9ec671` and synchronized with its
  upstream.
- Commit `1977ae2f` implements the initial native UI and development-only
  mock/query boundary.
- Commit `55d53263` hides Pending Reviews outside development until the API is
  connected, protects quick-rating finalization on fast exit, preserves detail
  drafts across same-item refetches, and rejects attachments whose size cannot
  be verified.
- Commit `f4156be` adapts the existing shared Photo/Camera/File picker to the
  feedback-specific five-file and total-200-MB policy. It limits image and
  document selection by the remaining attachment count, resolves missing file
  sizes when possible, validates file metadata/format/size/count, preserves
  existing chat defaults and adds focused tests.
- Commit `8ea6723` updates the fixture rating prompt to the current Figma copy,
  `How was this order?`.
- Commit `4a9ec67` applies the current APP Profile layout, dynamic
  `Share Feedback (N)` entry, Profile scroll-to-top FAB, Figma-aligned feedback
  selection layout and the three detail interaction analytics events. It was
  pushed after direct Android and iOS verification.
- Draft PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is open and
  GitHub reports it mergeable at head `4a9ec671`. Its broken literal `\\n` body
  was replaced with normal Markdown earlier; this closeout did not mutate the
  PR body or Draft state.
- CodeRabbit reports success only because it skipped automatic review for a
  Draft PR. No app-developer review, teammate approval, user QA, merge, staging
  QA or deployment has occurred.

### Jira checkpoint - 2026-08-25 19:14 KST

- Parent `DL-15828` remains `진행 중`.
- `DL-16064` (app development environment and WebView/native boundary
  verification) moved through `진행 중` to `완료`. Jira comment `43696`
  records the Android/iOS runtime proof, current native/WebView ownership and
  the remaining iOS/native-contract constraints.
- `DL-16061` (app feedback UI and native integration) moved to `진행 중`.
  Jira comment `43697` links Draft PR #286 and the verified implementation and
  QA, while explicitly separating pending API/DTO/upload, WebView bridge,
  push/deep-link, app-developer review and physical-device QA.
- `DL-16066` (app order-feedback notification) remains `해야 할 일`. Jira
  comment `43698` records the missing trigger/recipient, notification copy and
  mode, FCM payload/feedback identifier, landing/deep-link and WebView/native
  bridge contracts. No speculative implementation was started.
- Story points were not changed because the unresolved integration and
  notification contracts still materially affect scope.

### Implemented app scope

- Office Profile follows the current APP card layout for profile identity,
  Preferences, Notifications, Quick Links and the inline version/sign-out
  footer. Quick Links exposes dynamic `Share Feedback (N)` in development and
  keeps Help Center available in every environment. The Profile scroll-to-top
  FAB is Office-only; Lab retains its previous presentation.
- Native `FeedbackListScreen` provides To Review/Reviewed tabs, counts,
  infinite-list query structure, pull-to-refresh, scroll-to-top FAB, immediate
  Good/Bad save and the non-automatic `Tell Us Why` detail entry.
- Native `FeedbackDetailsScreen` provides rating, reason, comment, attachment
  UI, fixed Submit action, unsaved-change protection and Android hardware-back
  handling. Its selected rating fills the remaining row while unselected
  ratings and reason chips retain content width on both platforms.
- Detail interaction analytics now include `reviewdetail_select_reason`,
  `reviewdetail_add_comments` and `reviewdetail_img_upload`, in addition to the
  existing list/detail entry events.
- Good/Bad uses an immediate `RATING` mutation. The current To Review screen
  keeps the rated card; leaving and re-entering promotes it to Reviewed in the
  development mock. Detail Submit uses a separate `DETAIL` mutation.
- Photo/Camera/File entry reuses the existing native picker and permission
  boundary. Feedback configures the shared picker independently with a maximum
  of five files, remaining-selection limits, total 200 MB, supported-format and
  positive-size checks, Figma-aligned sheet behavior and feedback-only copy.
  Existing chat callers retain their previous defaults. The feedback draft
  still stores only local metadata because the upload/API contract is absent.
- The repository/query/types boundary is development-only mock data. Staging
  and production neither fabricate feedback data nor expose Pending Reviews.

### Verification and current risk

- Codex directly verified the current source on Android API 36
  `Dentlink_API_36`: Profile top/bottom, dynamic count, scroll-to-top FAB,
  To Review/Reviewed lists, detail layout, upload area and Photo/Camera/File
  sheet. The Android check exposed a zero-width unselected-chip regression;
  `flex-grow`/`flex-shrink` replaced `flex: 0` and the fixed result was
  rechecked on-screen.
- Codex directly verified the current source on the temporary iOS 26.5 iPhone
  17 Pro simulator proof: Profile top/bottom and FAB, feedback list, detail
  rating/reason layout, upload area and Photo/Camera/File sheet. Temporary QA
  route/offset triggers were removed before the final diff, and a normal app
  relaunch returned to the authenticated Home screen.
- These checks are Codex simulator/emulator evidence, not user QA,
  physical-device QA or app-developer approval.
- Targeted ESLint over all seven changed files passes with zero output. The
  focused feedback utility test passes 8/8 with `jest.config.js` selected
  explicitly, and `git diff --check` passes.
- Office runs the current source on both simulators, and Lab development Metro
  bundles were regenerated from the final source for Android and iOS; both
  passed. This closes a compile-level Lab regression check, not Lab runtime QA.
- Office and Lab full typechecks still fail on the same nine untouched
  baseline diagnostics; the feature files add no diagnostic.
- Android and iOS system photo pickers enforce five initial selections; iOS
  also shows four remaining after one attachment. Document-file selection,
  permission denial, real upload, slow/offline API, physical devices,
  push/deep link and a fresh native iOS rebuild remain unverified.
- Office-only feedback screens are statically imported through shared
  `AllScreens`, so they are included in the Lab Metro bundle. Both Lab bundles
  pass; whether to split app-specific navigation is an app-developer review
  item rather than an unapproved refactor.

### Live Figma recheck - 2026-08-25 18:25 KST

- Rechecked the official Figma file `Lu8GEh1TUU5hOfj2FCPRYn` at Profile
  `160:38938`, Feedback `160:40593`, Order `160:38179` and Analytics
  `269:66717`, including representative APP frames and annotations rather than
  relying on the earlier handoff.
- The current APP list frames `160:41475` and `160:41530` confirm the native
  `Share Feedback` header, To Review/Reviewed counts, information banner,
  Good/Bad actions, `Tell Us Why`, `Edit`, rating badge and scroll-to-top FAB.
  The implemented list covers these current core states.
- The current detail frames `289:70322` and `289:70789` make the added mobile
  attachment states explicit: empty/uploaded lists, remove action,
  Photo/Camera/File bottom sheet, five-file error, size error and unsupported
  type error. The implementation covers the functional picker/list/validation
  boundary and applies the current Figma error-toast copy.
- Figma's picker footer still says `up to 5 files, total size up to 2G`, while
  its size-error toast says 200 MB and the latest Notion policy says five files
  and total 200 MB. Keep 200 MB until product/design makes the source of truth
  consistent.
- Profile annotation `160:40576` calls the menu `Share Feedback(N)`, while an
  older visible Profile frame says `Pending Reviews (3)`. The annotation is the
  explicit APP behavior requirement, so the app now uses dynamic
  `Share Feedback (N)` and keeps the development-only exposure boundary until
  the live API exists.
- Order APP frame `160:38775` adds a completed-order feedback banner and a
  post-rating confirmation toast. The current real app order detail is a
  Clinic WebView, so banner ownership and landing into the native feedback
  detail still require an explicit WebView/native bridge and identifier
  contract rather than a guessed navigation change.
- The APP analytics frames preserve `review_feeback_click`,
  `review_detail_click` and `review_edit_click` and also specify
  `reviewdetail_select_reason`, `reviewdetail_add_comments` and
  `reviewdetail_img_upload`; all six are now represented in the app flow.
- The current Figma file therefore does not expose another clearly safe core
  screen to implement now. Remaining work is contract clarification, exact
  copy/artwork polish and device/API QA, not an omitted major APP page.

### External inputs still required

- Deployed Swagger and generated models still have no order-feedback endpoint
  or DTO. Do not invent API names, eligibility, pagination/count, upload or
  notification contracts.
- Notification payload/category, landing route, deep-link mapping and the
  WebView-to-native bridge are not implemented.
- Reason/category mapping, count timing after immediate rating and the
  design-policy attachment conflict remain pending.
  Current implementation follows the latest Notion policy of five files and
  total 200 MB, not the Figma `2G` annotation or older 10-file/5-MB text.
- App-developer review is the next human gate. The PR must remain Draft until
  review and external contracts make it genuinely merge-ready.

## DL-15828 / DL-16061 API Integration Closeout - 2026-08-27 17:17 KST

### Git and delivery state

- `feature/DL-16061` is clean and synchronized at `ddf9f0e`.
- Commit `ddf9f0e` replaces the development mock boundary with the deployed
  feedback API, query/cache behavior and multipart attachment integration.
- Draft PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is open,
  mergeable and points to `ddf9f0e`; GitHub `add-labels` and CodeRabbit report
  success. Draft state, app-developer approval, merge, staging QA and deployment
  remain distinct and incomplete.
- The full development Swagger regeneration was deterministic but contained
  thousands of unrelated model changes, including removal of
  `OrderUpdateAdditionalDto.hasPhoto`. That generated drift was removed from
  this feature. Only the feedback transport contract is temporarily isolated
  in `shared/configs/types/feedback.ts`; replace it with generated types after
  the app team accepts the full Swagger diff.

### Implemented contract

- The app now uses deployed list endpoints for To Review and Reviewed, detail
  GET by `orderId`, initial POST with `templateVersion`, and full-replacement
  PUT. Server questions, categories, keywords and file IDs are canonical.
- Query keys include employee and employer identity plus `orderId`; count,
  list and detail invalidation preserve the immediate Good/Bad and separate
  detail Submit behavior.
- The existing employee multipart upload path is reused without an invented
  `callBy=FEEDBACK` presign field. Feedback sends completed `fileId` values in
  the FILE answer. Failure abort, staged-file cleanup, unmount races and
  omission-based server-file removal are handled.
- Feedback keeps the five-file, total-200-MB, positive-size, filename and file
  format policy. Existing chat upload callers retain their defaults.
- Order details remain Clinic WebView-owned. Notification, FCM payload and
  deep-link work remain isolated in `DL-16066` and were not guessed.

### Current runtime proof

- Android API 36 `Dentlink_API_36` and iOS 26.5 iPhone 17 Pro simulator were
  both booted with Metro running in the `dentlink-app` Cursor terminal.
- Codex directly verified the current `ddf9f0e` JavaScript on both platforms
  against the development API: Profile `Share Feedback (0)`, To Review 0,
  Reviewed 1, order `9000009126`, hospital `frankieDevOffice`, detail GET,
  server question/keyword layout and Photo/Camera/File sheet.
- Both platforms display the feedback attachment policy as five files and
  total 200 MB. No unexpected layout, navigation or runtime defect was found.
- The iOS proof still uses the previously installed temporary simulator app;
  a fresh committed-source Apple Silicon build remains blocked by the known
  MLImage/react-native-exit-app native maintenance boundary. The existing
  non-fatal `messaging/unregistered` development overlay also remains a
  separate baseline issue.
- Real POST, PUT and file upload were not executed because they mutate
  development data. Physical-device permission/camera behavior, user QA and
  app-developer approval are still separate evidence gates.

### Code verification and Jira

- Feedback Jest suites pass 14/14. Changed-file ESLint, Prettier and
  `git diff --check` pass.
- Office and Lab typechecks have the same nine untouched baseline diagnostics;
  the feedback implementation adds no TypeScript error. Removing generated
  Swagger drift also removed the eight unrelated `hasPhoto` consumer errors.
- Jira `DL-16061` description and comment `43748` contain the final scope and
  evidence; its status is `Ready for Deploy` because FE development is
  complete. `DL-16064` remains Complete, `DL-16066` remains To Do pending its
  notification contract, and parent `DL-15828` remains In Progress.

## DL-16061 Review-Ready Final Checkpoint - 2026-08-27 18:08 KST

### Git, PR and review state

- `feature/DL-16061` is clean and synchronized with its upstream at
  `9f66fa34cecc366fc9f0a74e9a3392f220cf6147`.
- Commit `aa8baf6` preserves detail answers during replacement PUT, strengthens
  upload cleanup and fixes inactive-query and unmount behavior found during
  review. Commit `9f66fa3` separates per-file and total attachment-size copy.
- PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is OPEN,
  mergeable and no longer Draft. `add-labels` and CodeRabbit are successful;
  all six review threads are resolved and the unresolved count is zero.
- Focused feedback tests pass 15/15. Changed-file lint and formatting,
  `git diff --check`, and Office/Lab new-error classification were completed
  before the final push. The nine application type diagnostics are the same
  untouched baseline errors rather than feedback regressions.

### Final Android runtime proof

- Metro was started from the integrated terminal of the Cursor IDE opened for
  `/Users/parkjongsun/Repository/dentlink-app`, and Android API 36
  `Dentlink_API_36` connected to the Office development app.
- Current development data showed Profile `Share Feedback (5)`, To Review 5
  and Reviewed 5. This supersedes the earlier time-sensitive 0/1 data snapshot.
- Completed order `9000009126` opened its Clinic `/orders/:orderId` WebView and
  displayed the rated `Glad to hear!` feedback banner. Selecting the banner
  opened native `Feedback Details` for the same order, including the selected
  Good rating and the `Image Upload` area.
- No matching fatal React Native runtime error was found. The modal was closed
  without changing feedback data. Real Good/Bad POST, detail PUT, file upload
  and removal were intentionally not executed because they mutate development
  data.

### Jira and handoff state

- `DL-16064` remains `완료`, `DL-16061` remains `Ready for Deploy`,
  `DL-16066` remains `해야 할 일`, and parent `DL-15828` remains `진행 중`.
- Jira comment `43750` records the latest commit, PR readiness, final Android
  WebView-to-native runtime proof, mutation-QA exclusion and remaining delivery
  gates.
- The next human gate is now app-developer review of PR #286. This checkpoint
  does not claim app-developer approval, physical-device QA, merge, release QA
  or deployment.

## DL-16066 Feedback Notification Deep-Link Closeout - 2026-08-27

### Git and PR state

- `feature/DL-16061` is clean and synchronized with its upstream at
  `c33515aa8931bcef701dd03325105cad9a8f212c`.
- Commit `c33515a` adds the order-feedback notification deep link and its
  focused tests. No generated model, native project, environment or release
  file was changed.
- PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is OPEN,
  non-Draft and mergeable at head `c33515a`; `add-labels` and the CodeRabbit
  status are successful. The six existing review threads remain resolved, but
  no new CodeRabbit review was submitted for `c33515a` at this checkpoint.
  App-developer approval, merge, staging QA and deployment remain incomplete.

### Confirmed contract and implementation

- The existing FCM contract is reused without new product fields: the backend
  supplies `/my/feedback?orderId={orderId}` through `data.deeplink`.
  `orderId`, not `feedbackId`, is the feedback identity. No speculative
  `type`, `webPath` or new scheme was added.
- Relative and Dentlink Portal feedback URLs convert to the current app scheme.
  The route is Office-only; Lab does not expose the feedback route.
- A valid positive safe-integer `orderId` resets navigation to the native
  feedback list. The list waits until employee and employer identity are ready,
  performs the detail GET explicitly, and opens `FeedbackDetailsScreen` only
  after canonical server data is returned.
- Missing, invalid, unauthorized or failed detail lookup leaves the user on the
  feedback list and uses the existing error toast. Back or close from a
  successfully opened detail returns to that native list. The flow never opens
  the Clinic order-detail WebView.
- Existing Firebase and Notifee cold-start, foreground, background and duplicate
  notification handling remains the owner of delivery and deduplication; this
  change only maps the confirmed URL into the native feedback navigation.

### Validation and remaining proof gates

- Focused Jest validation passes 21/21 across deep-link, URL-conversion and
  feedback repository suites. Changed-file ESLint, Prettier and
  `git diff --check` pass.
- `yarn typecheck:apps` still reports the same nine untouched repository
  baseline diagnostics. None points to the nine files changed by `c33515a`.
- Android API 36 directly verified valid warm, cold and background URL entry,
  duplicate-entry deduplication, detail-to-list back behavior and failed-order
  fallback using the development API.
- iOS 26.5 Simulator verified the same JavaScript/navigation cases with the
  previously installed development binary and current Metro bundle. This is
  not proof that the current native source rebuilds: the known Apple-Silicon
  simulator MLImage binary/architecture blocker remains.
- A real backend-generated FCM notification was not available. Actual delivery
  and tap behavior therefore remains backend/integration QA even though direct
  URL lifecycle behavior is proven. Physical-device QA is also separate.
- Jira was not mutated during this closeout. Reconcile `DL-16066` live before
  changing its status or posting delivery evidence.

## DL-16061 Current-HEAD Runtime And Review Closeout - 2026-08-28 11:39 KST

### Git, PR and code verification

- `feature/DL-16061` is clean and synchronized with its upstream at
  `b060294fcb8aa60da2c99c1bcea0f4e8b96d459c`.
- Commit `2902cef` limits its fixes to multi-upload busy state, rating-only
  overlays, deep-link refetch result races and unused staged-file cleanup.
  Commit `b060294` only normalizes Profile formatting. No code defect was
  found during the final runtime pass, so no additional app commit was made.
- PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is OPEN,
  non-Draft and mergeable at `b060294`. Auto labels and CodeRabbit are
  successful; the description now records the current-head Android and iOS
  proof. App-developer human review has been requested and remains the next
  human gate.
- The last focused verification remains feedback Jest 31/31, changed-source
  ESLint with zero errors, source Prettier and `git diff --check` pass, and the
  same nine unrelated Office/Lab baseline type diagnostics with no feedback
  regression. `origin/develop` merge-tree has no conflict.

### Current-head direct runtime proof

- Metro ran from the integrated terminal of the Cursor IDE opened for the
  exact `/Users/parkjongsun/Repository/dentlink-app` project. The final pass
  loaded current `b060294` JavaScript on Android API 36 and iOS 26.5.
- Android directly showed Office Home and Profile `Share Feedback (1)`, To
  Review 1, Reviewed 1, reviewed order `9000009126`, canonical detail GET,
  `Image Upload`, Photo/Camera/File selection, maximum five files and total
  200 MB, direct `dentlink-dev://my/feedback?orderId=9000009126` navigation,
  and detail close back to the native feedback list.
- iOS directly showed the same native list/detail data and attachment sheet.
  The direct feedback URL opened the native list and canonical detail, and
  closing the sheet and detail returned to the list. This used the previously
  installed development proof binary with the IDE Metro's current JavaScript;
  it is runtime proof, not a fresh current-native-source build.
- The simulator's existing ChannelTalk banner and non-fatal
  `messaging/unregistered` LogBox notice were dismissed before the iOS flow.
  They are baseline development-environment behavior and were not introduced
  by the feedback changes.
- Good/Bad, Submit and real file upload were deliberately not executed because
  they change shared development data. Camera/permission and actual file
  transfer still require suitable test data and preferably a physical device.

### Jira and remaining boundaries

- `DL-16061` and `DL-16066` both remain `Ready for Deploy`. Comments `43760`
  and `43761` record the current-head two-platform runtime and the distinction
  between direct URL proof and actual backend FCM delivery.
- No further safe FE code work is known at this checkpoint. Remaining work is
  downstream or externally gated: app-developer review feedback, actual
  backend-generated FCM receipt/tap, mutation-safe POST/PUT/upload data,
  physical-device camera/permission QA, merge, staging QA and deployment.
- Metro, the Android emulator and the iOS simulator were left running at this
  closeout so the user can inspect the verified screens. Treat that as
  transient session state and recheck it on resume.

## DL-16061 V2 Feedback UX Lifecycle Closeout - 2026-08-28 14:08 KST

### Confirmed UX contract and implementation

- Commit `277fc43` is pushed to `feature/DL-16061`. It aligns the native
  feedback flow with the cross-surface V2 UX contract without changing the
  feedback API, generated models, attachment limits or screen layout.
- A successful Good/Bad POST keeps the current To Review card and tab count
  through `ratingOverlays`, exposes `Tell Us Why`, and does not refetch the
  collection simply because the user enters or leaves the detail screen.
- Closing detail without Submit preserves the same To Review overlay. A
  successful detail PUT clears only that order's overlay and synchronizes
  list/count state. Feedback-list entry returns to the list, while other
  entry contexts keep their existing navigation stack with `goBack()`.
- An actual tab switch, pull-to-refresh, feature re-entry or foreground resume
  on the focused list clears the local overlay and reloads server-canonical
  collections. Direct deep links still enter through the native list and are
  not forced into the Reviewed tab.
- Rating and detail mutations guard duplicate actions. The global mutation
  error handler now excludes the feedback save endpoint so the screen-owned
  retry toast appears once instead of being duplicated.

### Verification and review boundary

- Focused feedback/error-handler Jest suites pass 17/17. Changed-file ESLint
  has zero errors and one existing unused-variable warning in
  `shared/queries/errorHandlers.ts`; Prettier and `git diff --check` pass.
- Office and Lab typechecks still report the same nine unrelated baseline
  diagnostics. No diagnostic points to the six files in `277fc43`.
- No Android emulator or iOS simulator was booted at this checkpoint, and the
  project IDE was not prepared. In accordance with the user's standing rule,
  Metro was not started elsewhere. The V2 POST/back/PUT lifecycle therefore
  has code-level proof but no new mutation-data runtime proof.
- PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is OPEN,
  non-Draft and mergeable at `277fc43`. Auto labels and CodeRabbit are green.
  The app developer had already reviewed/commented on the previous `b060294`
  head, so `277fc43` remains a new review delta; it is not app-developer
  approval, merge, staging QA or deployment.

## DL-16061 V2 Current-Head Runtime Closeout - 2026-08-28 14:49 KST

### Final code and delivery state

- Commit `8fc02c4` is pushed to `feature/DL-16061`, and the branch is clean and
  synchronized with `origin/feature/DL-16061`.
- The final change makes feedback mutation success handlers await collection
  invalidation. Rating POST still avoids an immediate collection refetch, while
  detail PUT waits for list/count synchronization before the screen-owned
  navigation callback can run. This closes the stale-card/count transition
  race without changing the V2 presentation-overlay contract.
- Focused feedback/error-handler Jest suites pass 17/17. Changed-file ESLint,
  Prettier and `git diff --check` pass.
- PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is OPEN,
  non-Draft and mergeable at `8fc02c4`. Auto labels and CodeRabbit are green,
  but the app developer's recorded review/comment predates this final V2 delta.
  Human approval, merge, staging QA and deployment remain incomplete.

### Android and iOS proof with shared E2E data

- Metro remained in the integrated terminal of the Cursor IDE opened for the
  exact app project. Android API 36 and iOS 26.5 both loaded the current
  JavaScript and logged into the shared `e2e.clinic` development account.
- Both platforms directly verified Profile, native Share Feedback, To Review,
  Reviewed, server-canonical detail questions/options, hospital name and the
  Photo/Camera/File attachment sheet. The sheet displays maximum five files and
  total 200 MB.
- The shared E2E account changed from To Review/Reviewed `31/7` to `29/9` and
  finally `28/10` during the pass. After a complete feature exit and re-entry,
  Android and iOS both converged on `28/10`, proving re-entry synchronization.
  Treat these counts as transient shared-server data, not a durable fixture.
- An Android coordinate intended for the upload area overlapped the fixed
  Submit control and re-submitted already-reviewed order `9000009204` once.
  No rating, comment or attachment value was changed. This is not complete PUT
  QA and should not be treated as intentional mutation coverage.
- Actual new Good/Bad POST, changed-detail PUT, file transfer/removal, physical
  camera/permission behavior and backend-generated FCM delivery remain separate
  QA gates. The known non-fatal iOS `messaging/unregistered` simulator warning
  is unchanged and unrelated to feedback.

## DL-16061 Pagination Boundary Closeout - 2026-08-28 15:44 KST

### Implementation and delivery state

- Commit `88066f0` (`fix: 피드백 목록 페이지 누락 방지`) is pushed to
  `feature/DL-16061`; the checkout is clean and synchronized with its
  upstream.
- The To Review presentation overlay now retains only the saved feedback item
  and its current list anchor. It is merged with canonical server items
  without rewriting the React Query cache, duplicating an order or slicing a
  canonical last item out of the visible collection.
- After a Good/Bad POST makes the server To Review collection shorter, the app
  refetches every already-loaded infinite-query page before asking React Query
  for the next page. A failed refetch blocks the stale offset request and
  exposes a retry action instead of silently skipping an item.
- Tab, account, refresh, foreground and detail-Submit synchronization
  boundaries invalidate the current presentation scope. Late rating,
  pagination or refresh responses cannot recreate an overlay in a newer
  screen scope. Detail Submit now clears the current screen overlays only
  after the mutation-owned list/count synchronization has completed.
- PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is OPEN,
  non-Draft and mergeable at `88066f0`. Auto labels and CodeRabbit report
  success. The app developer must review this newest pagination delta;
  merge, staging QA and deployment remain separate and incomplete.

### Verification boundary

- Focused feedback repository and utility suites pass 18/18. Changed-file
  ESLint and Prettier, plus `git diff --check`, pass.
- Office/Lab `typecheck:apps` still reports the same nine unrelated baseline
  diagnostics. No diagnostic points to the four files changed by `88066f0`.
- Android API 36 with the shared `e2e.clinic` development account executed a
  real Good POST for order `9000009193`. The current To Review screen kept
  `23/17`, the Good badge and `Tell Us Why`; opening and closing detail without
  Submit preserved that state. Scrolling through the last page exposed 23
  distinct cards with no offset omission. Switching tabs then restored the
  server-canonical `22/18` counts and showed the order in Reviewed.
- iOS 26.5 loaded the same current JavaScript, converged on `22/18`, showed
  order `9000009193` in Reviewed and opened/closed its native detail screen.
  The Good mutation was not repeated on iOS. This remains runtime proof using
  the existing simulator binary, not a fresh native build or physical-device
  proof.
- Shared E2E counts and order availability are time-sensitive test data. No
  Jira mutation, changed-detail PUT, real file transfer/removal,
  physical-device camera/permission QA or backend-generated FCM delivery was
  performed in this pagination closeout.

## DL-16061 Planning And Analytics Reconciliation - 2026-08-31

### Delivered changes and validation

- Branch `feature/DL-16061` is clean and synchronized with its upstream at
  `a6e28c76e9b6f2a468f8bd5d13578a8445fcc733`.
- Commit `abac780` changes the Office Profile quick link from
  `Share Feedback (N)` to the latest confirmed `Pending Reviews (N)` copy.
- Commit `a6e28c7` records `reviewdetail_img_upload` only after a successful
  image upload; a generic File upload no longer emits the image event.
- Focused feedback repository and utility suites pass 18/18. Both changed
  files pass ESLint and Prettier, and `git diff --check` passes.
- Office/Lab typechecks still report the same nine unrelated baseline
  diagnostics. Neither changed file adds a diagnostic.
- Current feedback attachment policy is maximum five files and 200 MB total.
  Figma's remaining `2G` text is stale; do not change the unrelated existing
  order-upload policy that legitimately shows 2 GB.
- Profile navigation keeps `Case Preferences` because it opens multiple saved
  preferences. The future notification-setting row should use the singular
  feature/category label `Case Preference`.
- The newly deployed admin feedback search API is not an app UI scope. Do not
  choose or implement an admin screen from this app session.

### Durable backend questions for notification settings

Before adding the new Office Profile notification rows, ask BE only these two
questions and preserve the current three-row implementation until answered:

1. What exact `pushType` values should `Case Preference` and `Order Feedback`
   use with `/app/users/own/push-preferences`, and how should the existing
   GET/POST/PATCH flow create and update them?
2. Which stable FCM payload field distinguishes `1st Feedback` from recurring
   `Order Feedback` so the existing `push_click` event can send the confirmed
   `pushType` property without inferring it from notification copy?

Do not invent new enum values, derive the distinction from title/body text, or
implement the notification rows before this contract is available. Designer
and PM decisions are not currently blocking: use 200 MB and the singular
notification label `Case Preference`; a source-file wording cleanup is enough.

## Next Starting Point

1. Ask the app developer to review the latest `abac780` and `a6e28c7` delta in
   PR #286. If feedback arrives, verify and address only valid findings before
   any merge decision.
2. Ask BE the two notification-setting questions recorded above. After the
   contract is confirmed, implement only the new Profile notification rows and
   the `push_click` property mapping supported by that contract.
3. When the backend can send a real notification, verify that
   `data.deeplink` contains `/my/feedback?orderId={orderId}` and test actual
   cold, warm, background and duplicate taps. Do not add `type` or `webPath`
   unless the shared contract changes explicitly.
4. The Android Good/Bad POST and list transition have direct evidence. When
   safe eligible data is provided, verify changed-detail PUT, file
   upload/removal and remaining cache transitions. Validate Android first,
   then iOS or a physical device for camera and permission behavior.
5. Treat a fresh iOS native build as a separate app-maintenance scope. The
   installed simulator binary proves current JavaScript behavior but does not
   resolve the committed MLImage simulator architecture constraint.
6. When the app team accepts the full generated Swagger drift, regenerate the
   whole model in a separate reviewed commit and replace the temporary feedback
   transport types. Do not partially hand-edit generated files.
7. Continue to run servers from the integrated terminal of the IDE opened for
   the exact app project. If that IDE is not prepared, ask the user before
   starting Metro directly elsewhere.
8. For later feature implementation, refresh this context and live Git first,
   then verify the active branch, Jira/Figma/API and closest production pattern.
   Keep shared app commits and pushes behind explicit user authorization.

## DL-16061 Full Breakpoint Reconciliation - 2026-09-01 18:42 KST

### Live delivery state

- `feature/DL-16061` is clean and synchronized with
  `origin/feature/DL-16061` at
  `8f3ad05fedc4a038c5c035c36901936585aa8df6`.
- The branch contains the live `origin/develop`
  `5e8375f34841ea597a0f4a492105aad944c1594d` and is 26 commits ahead with no
  base commits missing.
- The final safety commit `99535e8` removes an invalid React hook call from
  ordinary notification-permission functions and reads the OS version through
  `react-native-device-info` directly. This avoids an `Invalid hook call` in
  the notification permission/token path. The adjacent unused import was also
  removed.
- Commit `8f3ad05` supports the final backend feedback-link shape with
  `employerId` in the path, switches the authenticated employer through the
  existing deep-link side effect, and extends the route and analytics-path
  tests. The no-employer and `/my/feedback` forms remain compatibility inputs.
- PR [#286](https://github.com/Innvoaid/dentlink-app/pull/286) is OPEN,
  non-Draft and MERGEABLE at `8f3ad05`; Auto PR Labels and CodeRabbit
  are successful. There is still no human approval, merge, staging QA or
  deployment proof.
- Compared with `origin/develop`, the feature changes no `android/`, `ios/`,
  package manifest or lockfile. Its TypeScript, JavaScript and bundled-asset
  surface is technically CodePush-compatible; the app developer still owns the
  final deployment method and target-version decision.

### Canonical app contract and document reconciliation

- The current app-owned deep links are
  `dentlink://feedback/{employerId}` for the native list and
  `dentlink://feedback/{employerId}?orderId={orderId}` for detail. Development
  runtime uses the matching `dentlink-dev` scheme. The route applies the
  existing `setEmployerId` side effect before the employee/employer-scoped
  feedback request.
- `/my/feedback[?orderId=...]` remains a web/legacy compatibility input and is
  converted to the app feedback route. The earlier no-employer `feedback`
  shape also remains a compatibility input, not the backend's current
  canonical link.
- For `push_click`, feedback URLs with `orderId` map to `1st Feedback`; list
  URLs without `orderId` map to `Order Feedback`. The seven feedback events,
  `feedbackType: Good/Bad`, and app-only `pendingreviews_click` are present.
- Live Jira, Notion feature/analytics pages, Figma feedback/Profile/empty-state
  and analytics nodes, FigJam notification planning, current code and generated
  Swagger were reconciled. The implemented native screens, server-canonical
  question/category/keyword flow, screen-only rating overlay, Profile count,
  5-file/200-MB attachment policy and analytics match the confirmed scope.
- The only known unimplemented planned app UI is the Office notification rows
  `Case Preference` and `Order Feedback`. The current generated
  `UserPushSettingUpdateDto.pushType` still lacks values for both, so the app
  must not invent enum values or send guessed PATCH requests. BE is expected to
  deploy either both types or only `Order Feedback`; implement only the actual
  generated contract after deployment.
- Jira `DL-16066` and the PR description still describe the older canonical
  `/my/feedback` route and older HEAD/test/runtime evidence. `DL-16061` also
  contains older verification counts. Their workflow statuses are still
  appropriate (`Ready for Deploy`), but the descriptions are documentation
  debt and were not mutated during this read-only final review.

### Final verification boundary

- Focused feedback/deep-link repository and utility tests pass: 5 suites,
  43/43 tests. All five files in `8f3ad05` pass Prettier and ESLint with zero
  errors, and `git diff --check` passes.
- The broader app Jest command requires an explicit config because the repo
  has two Jest configurations. With `jest.config.js`, existing Detox suites
  are incorrectly included without a Detox worker and `App.test.tsx` has an
  existing invalid-element failure; focused feedback suites remain green.
- Office/Lab typecheck still reports ten baseline diagnostics and no current
  feedback/deep-link regression. Keep baseline failures distinct from changed
  file validation.
- Metro was started in the integrated terminal of the Cursor IDE opened for the
  exact `dentlink-app` project. Android API 36 rebuilt and reinstalled the
  current Office development app successfully in 42 seconds, then the final
  employer-path list and order-detail deep links opened the native list and
  canonical detail GET. Android hardware back returned from detail to the list.
- iOS 26.5 loaded the same current Metro JavaScript through the previously
  installed proof binary. The final employer-path list and detail links opened
  the same native server data, and closing detail returned to the list. This is
  current JavaScript/navigation proof, not a fresh native-source iOS build. The
  known non-fatal `messaging/unregistered` development error remains visible.
- Both runtime passes used read-only list/detail navigation. No Good/Bad POST,
  changed-detail PUT, file transfer or removal was executed.
- Actual backend-generated FCM delivery/tap, mutation-safe POST/PUT/file upload,
  physical camera/permission behavior, fresh iOS native build, human review,
  merge and deployment remain separate gates, not unfinished FE code in this
  breakpoint.

### Next starting point

1. Ask the app developer to review the latest `8f3ad05` delta in PR #286 and
   address only verified findings with fresh commit/push authorization.
2. When BE deploys exact `pushType` values for both notification rows or only
   `Order Feedback`, regenerate/review Swagger and implement only the delivered
   rows through the existing preference flow.
3. When a real feedback notification and safe mutation data exist, verify FCM
   cold/warm/background taps, PUT and file upload/removal. Run Android first,
   then iOS/physical-device checks where platform behavior matters.
4. Refresh this context, live Git, Jira/Figma/Notion and deployed Swagger before
   resuming. Do not start another Metro process while the correct app IDE
   terminal is already serving it.

## DL-16061 Order Detail WebView Bridge And Review Closeout - 2026-09-01

### Delivered state

- `feature/DL-16061` is synchronized with
  `origin/feature/DL-16061` at
  `28a12947b49e058b136e602a4f53621b95931509`.
- The branch contains the current `origin/develop` and is 30 commits ahead with
  no base commits missing. PR
  [#286](https://github.com/Innvoaid/dentlink-app/pull/286) remains OPEN,
  non-Draft and MERGEABLE.
- The WebView-to-native navigation contract is the existing `NAVIGATION`
  message with `screen: "FeedbackDetailsScreen"` and
  `params: { orderId, entryPoint: "order-detail" }`. The existing
  `DentlinkWebView` handler passes these params to React Navigation, so no new
  web-to-app bridge message type was added.
- After a native detail PUT succeeds from the order-detail entry point, the
  detail screen uses the established navigation-result pattern to `popTo` the
  existing `OrderDetailScreen`. The parent consumes a one-time completion param
  on focus and reloads its WebView so the web-owned feedback banner reads the
  new server state. Cancel, back and mutation failure do not send completion or
  reload the WebView. Feedback-list, push and deep-link entry behavior is
  unchanged.
- The corresponding Clinic web action still must send the confirmed
  `NAVIGATION` message when it runs inside the app; ordinary web continues to
  open its web feedback drawer.

### Review fixes and verification

- Commit `b188e18` also closes verified CodeRabbit findings: safe-area memo
  dependency, push-preference loading guard, login-dependent device update,
  post-`RNFS.stat` upload-size validation, local WebView host matching,
  infinite-list memoization, MIME-less image analytics classification and
  feedback mutation URL boundary tests.
- Commit `f1e6c3a` preserves completed server file IDs when cleanup deletion
  fails and retries them on the next upload and hook unmount. This closes the
  remaining CodeRabbit review-body finding without changing caller contracts.
- Commit `507f2b3` records unmount and superseded upload sessions, moves files
  completed afterward into the cleanup queue, retries deletion up to three
  times and blocks post-unmount state/toast updates. Commit `28a1294` then moves
  completed-file state publication behind the current-session check so a late
  prior upload cannot pollute the new upload state.
- All prior human and CodeRabbit review threads were answered and resolved.
  The bottom safe-area general PR comment was verified against the shared
  `Layout` inset behavior and answered because general issue comments have no
  resolve control. The manual CodeRabbit review of `b188e18` completed; the
  subsequent manual reviews of `f1e6c3a` and `507f2b3` completed; the final
  `28a1294` trigger returned a successful skipped status because reviews are
  disabled for the base branch. No unresolved review thread remains.
- The generated contract has multipart completion PATCH and abort DELETE only.
  If completion succeeds server-side but its response is lost, the app cannot
  recover `fileId` from `uploadId` or safely assume PATCH replay is idempotent.
  Full recovery requires a BE idempotency guarantee or lookup endpoint; this
  limitation is documented in the PR and resolved review rationale.
- Changed-file ESLint has zero errors; Prettier and `git diff --check` pass.
  Focused feedback, deep-link, WebView URL and error-handler Jest coverage
  passes 5 suites and 46/46 tests.
- Office/Lab typecheck still reports the same ten baseline diagnostics in
  unrelated existing files. No changed file introduces a new type diagnostic.
- This closeout is code and static-test proof. The cross-repository WebView
  action plus native return reload still needs an integrated runtime pass after
  the web-side change is committed and served. Real FCM, safe POST/PUT/upload
  data, physical camera permissions, human approval, merge and deployment
  remain separate gates.

### Next starting point

1. Confirm the matching Clinic web branch commits and serves its app-only
   `NAVIGATION` action, then test order detail WebView -> native feedback detail
   -> successful Submit -> refreshed WebView banner. Also verify cancel/back
   does not reload as a completed save.
2. Continue PR #286 human review. Do not merge or deploy without the app
   developer's approval and the normal release decision.
3. When BE deploys the actual `UserPushSettingUpdateDto.pushType` values,
   regenerate and review Swagger before adding only the delivered Office
   notification rows. Do not guess the enum values.

## DL-16061 Upload Failure Isolation And Notification Design - 2026-09-03

### Delivered code and authorization

- The user explicitly authorized commit, push and Git-backed memory closeout.
  Two purpose-separated commits are pushed to `feature/DL-16061` and visible
  in PR #286 at `1ddbdcfc5ed9d16ea92eb23854078bfff662aa2d`. App checkout is
  clean. No PR body/review mutation, Jira update, base merge or deployment was
  included in this request.
- `67b4cc0` (`shared/libs/useFileUpload.ts`) consolidates failure UI in the
  outer upload catch and checks the mounted/current upload session before
  clearing file IDs or showing delayed errors. An obsolete multipart failure
  cannot overwrite a newer upload's state or emit a duplicate toast. Existing
  multipart abort and completed-file cleanup/retry remain in place.
- `1ddbdcf` (`shared/features/profile/sections/ProfileNotificationSection.tsx`)
  adds Office-only `Case Preference` and `Order Feedback` rows after LinkTalk,
  reusing the existing notification row and compact switch. Figma descriptions
  are `Set Preference for better fit cases` and
  `Rate cases for better-fit results`. Existing supported rows and Lab stay
  unchanged; no native code, dependencies or generated models changed.

### Design versus API readiness

- Figma node `160:39015` in file `Lu8GEh1TUU5hOfj2FCPRYn` was read through
  design context and its screenshot. Profile layout and Pending Reviews
  already existed; the two notification rows were absent before this change.
- Both new rows are intentionally disabled and visually off until BE mapping
  exists. Their displayed value is a UI placeholder, not a claim about actual
  server notification delivery. They send no PATCH or analytics and stay
  disabled when Enable All is used. Do not describe them as connected toggles.
- `https://dev-api.dentlink.io/v3/api-docs`, read at 2026-09-03 11:17 KST,
  still exposes eight `UserPushSettingUpdateDto.pushType` values:
  `ORDER_NEW`, `ORDER_APPROVAL`, `ORDER_PENDING`, `ORDER_TRACKING`,
  `ORDER_EXTRA_FEE`, `CHAT_ORDER`, `CHAT_DENTLINK`, `ORDER_UPDATE`.
  Neither new notification type is deployed in this contract. No enum or
  payload name was guessed and no generated file was hand-edited.
- This setting contract is separate from the already implemented FCM
  `data.deeplink` routing and `push_click` Amplitude classification. No new
  FCM field is required merely to draw or wire these preference rows.

### Verification and next start

- Changed-file ESLint, Prettier and `git diff --check` pass. Prettier reports
  existing unsupported import-order options, not formatting failures.
- Existing focused feedback/repository/deep-link/WebView/error suites pass
  46/46. A transient mocked-hook regression harness reproduced the old upload
  bug against HEAD before the fix and passed seven cases against the fix:
  stale completion failure, missing ETag, current failure, silent errors,
  unmount, prior-batch cleanup and delayed toast after a new upload.
- A transient React component harness passed six notification checks: Office
  row order/copy, inert pending rows, existing toggle API/analytics, Enable All,
  unavailable preference query, and Lab isolation. Hooks and rendering
  primitives were mocked. No new test/support files were left in the app repo.
- No emulator, simulator, real push/settings mutation or deployment QA was
  performed in this code-only closeout; do not upgrade earlier runtime proof.
- Current independently actionable confirmed FE code is complete for this
  request. After BE deployment, regenerate/review Swagger, replace the pending
  rows with actual generated-type mappings in the existing setting list, and
  connect GET `/app/users/own/push-preferences` and PATCH
  `/app/users/own/push-settings/{pushSettingId}`. Verify defaults/upsert,
  Enable All, permission/loading/error and analytics behavior at that time.
- Continue to require new explicit authorization for later app commit/push.
  Read this checkpoint and live feature Git before resuming; do not treat
  a design placeholder, code completion, review approval or deployment as
  interchangeable states.

## DL-16061 PR Refresh And Review - 2026-09-03

- The user explicitly requested app commit/push, memory closeout and PR
  refresh/review. App HEAD is now `5994f1fca27c165e891f3781bf79fe5952b353b7`
  on `feature/DL-16061`, equal to its upstream and clean. The session started
  clean at `1ddbdcf`; new code was added only after validating the follow-up
  CodeRabbit findings below.
- PR #286 remains OPEN/non-Draft. Its body now records the latest HEAD,
  obsolete upload-session failure fix, disabled notification design, accurate
  validation counts and the boundary between UI placeholders and connected
  server preferences. The previous mergeable/current-develop claim was removed.
- Fetched `origin/develop` is `5ec442a2a20be9dbbad9a7f8532de37e69b60a8d`.
  Feature history is 34 commits ahead and 3 behind. A non-mutating
  `git merge-tree --write-tree HEAD origin/develop` confirmed conflicts in
  `shared/configs/i18n/locales/en.ts`, `shared/configs/i18n/textRegistry.ts`
  and `shared/configs/utils/dentlinkWebURL.ts`. GitHub also reports
  CONFLICTING/DIRTY. No develop merge or conflict edit was performed; do not
  describe the PR as merge-ready. GitHub's PR base SHA was stale compared to
  the separately fetched live branch ref.
- The old outside-diff review `5076958062` is addressed by `67b4cc0`.
  General review bodies have no resolve button; implementation evidence and
  the manual review request are in
  https://github.com/Innvoaid/dentlink-app/pull/286#issuecomment-5519414222.
  CodeRabbit's initial conversational response at
  https://github.com/Innvoaid/dentlink-app/pull/286#issuecomment-5519420314
  found no new blocker, but its separate incremental review completed at
  11:35:46 KST with two outside-diff findings in review `5097191737`.
- Commit `2f76e04` (`fix: 업로드 중단 실패 정리 재시도 보완`) changes only
  `shared/libs/useFileUpload.ts`: upload-start cleanup now explicitly allows
  three attempts; failed multipart aborts retain `uploadId` in a separate Set.
  The existing bounded cleanup loop removes only successful IDs and retries
  aborts and completed-file deletions at failure, next upload and unmount.
  File IDs and upload IDs remain distinct; no endpoint, native dependency,
  persistence layer or caller interface changed.
- Both new findings are addressed with evidence in
  https://github.com/Innvoaid/dentlink-app/pull/286#issuecomment-5519513624.
  CodeRabbit explicitly verified both fixes and found no new blocker in
  https://github.com/Innvoaid/dentlink-app/pull/286#issuecomment-5519521124.
  The subsequent formal review of `2f76e04` completed at 11:47:48 KST and
  raised two new inline findings in review `5097250295`. Conversational bot
  reassurance is not equivalent to the final formal review/check outcome.
- Commit `5994f1f` (`fix: multipart 전송 종료 후 중단 처리`) fixes the second
  finding: `runWithConcurrency` waits for all workers to settle after any
  worker rejection, then throws the original error. Abort cannot race the
  remaining part PUT requests or temporary-file cleanup. Reply evidence is
  https://github.com/Innvoaid/dentlink-app/pull/286#discussion_r3920594072;
  thread `PRRT_kwDOLCkD486ewYJE` is resolved.
- One valid review limitation remains OPEN: thread
  `PRRT_kwDOLCkD486ewYJC`,
  https://github.com/Innvoaid/dentlink-app/pull/286#discussion_r3920574073.
  Hook-local IDs cannot survive all cleanup retries failing and the hook
  disappearing. An account/employer/environment-scoped app-wide or persistent
  queue would address known-ID recovery but expands the shared upload state
  architecture and requires a scope decision. Do not falsely resolve this as
  fixed or conflate it with the separate lost-completion-response BE gap.
  The explicit deferral explanation is comment `3920589577`. Of 16 total
  inline review threads, 15 are resolved and this one is unresolved.
- The review cycle pauses for that scope decision. Auto-review on this base
  branch is disabled; `5994f1f` has local validation but no completed formal
  follow-up run. After the decision, handle the queue finding if authorized,
  request a standalone `@coderabbitai review`, and verify the run plus all
  threads. A mixed prose/comment command was treated as chat once; a standalone
  command reliably triggered the formal incremental review.
- Rerun checks: existing focused Jest suites 46/46, changed-file ESLint,
  Prettier and `git diff --check` pass. In-memory TypeScript comparison of
  current code against `28a1294` versions of the two changed files produced
  Office 11 baseline/current errors and Lab 11 baseline/current errors, with
  zero new diagnostics. No reset, stash, source replacement or generated
  model edits were used. This supersedes the older ten-error environment
  snapshot; whole-project typecheck is not passing.
- An additional transient actual-hook/React-renderer regression harness
  passed eight cases with mocked APIs/native modules: normal success, bounded
  abort retries and one toast, retry next upload, completed-file retry next
  upload, independent abort/file IDs, queued cleanup on unmount, old-session
  failure after new success, and late failure after unmount. No persistent
  test/helper files were added. These are code-level checks, not real upload QA.
- The next transient hook harness reproduced the abort/active-PUT race on
  `2f76e04` and passed three cases on `5994f1f`: second worker succeeds, second
  worker fails, and both workers succeed normally. Abort waits until the other
  PUT and part-file cleanup settle; normal completed fileId behavior remains.
  Focused Jest 46/46, lint/format/diff and the Office/Lab baseline comparison
  were rerun after this last edit with the same passing/no-new-error outcome.
- The existing upload cleanup queue is hook-local and best effort with bounded
  deletion retries. It does not guarantee durable cleanup after all retries
  fail and the hook is gone. Lost multipart completion-response recovery also
  remains outside the available BE lookup/idempotency contract; no new endpoint
  or persistence architecture was invented to satisfy an old resolved review.
- No new emulator/simulator, FCM, API-mutation, merge or deployment proof was
  added. Next: ask whether to expand to the account-scoped shared cleanup queue;
  separately obtain authority for develop conflict integration/revalidation.
  Human review and later notification API wiring after actual BE enum release
  are still separate. This is a saved breakpoint, not review-zero or merge-ready.

## DL-16061 Account-Scoped Cleanup Review - 2026-09-03

- User requested work on the outstanding review after the preceding scope
  question. The app-wide cleanup queue finding is now in scope; develop
  integration/merge is not included. App `feature/DL-16061` is pushed and clean
  at `919a884557f7d421a946b12adfc337b497ca048f`.
- `80c1cb5` moves known failed file deletion and multipart-abort IDs from hook
  refs to `useCommonStore.pendingFileCleanups`, deduplicated by kind/id/scope.
  API URL, user, employee, employer and service identify each scope. No token,
  file content or presigned URL is retained in the queue.
- Existing hooks process that common queue on mount, next upload, error,
  unmount, authenticated-state restoration and AppState foreground. Up to
  three attempts occur per run; concurrent hooks share a per-scope run.
  Logout and other-account contexts leave the original queue untouched; the
  matching account can resume it without relying on the old hook instance.
- Chosen implementation is app-wide in-memory state, one of the original
  review's alternatives. It survives screen unmount/remount, not complete app
  process termination. No new native dependency, storage engine, API, generated
  model or helper/test file was added. Dedicated network-reconnect detection is
  not installed; the next listed resume event handles recovery.
- `ScopedRequestConfig` flows through existing file services and queries.
  The request interceptor rejects stale-context requests before using auth
  headers. Guarded uploads cannot apply another account's refresh results;
  cleanup errors skip global logout/refresh side effects and remain queued.
  Requests without the options preserve their existing behavior. This guard is
  necessary because merely filtering the queue before Axios dispatch would
  still permit a later login switch to change the request's credentials.
- Changed files: `shared/libs/useFileUpload.ts`,
  `shared/store/useCommonStore.ts`, `shared/services/file.types.ts`,
  `shared/services/file.service.ts`, `shared/queries/useFileQueries.ts`,
  `shared/configs/utils/fetcher.ts`, and
  `apps/office/src/features/feedback/screens/FeedbackDetailsScreen.tsx`.
- Validation: existing Jest 5 suites / 46 tests pass. A transient source-level
  harness initially passed 17 checks, including one baseline remount-loss
  reproduction and 16 checks for the fix: remount, duplicate entries/hooks,
  account/user/employee/employer/service/environment isolation, logout/relogin, foreground,
  guarded dispatch, cleanup 401/403, in-flight old-account errors, query/service
  forwarding, old refresh success/failure, normal and guarded refresh behavior,
  silent errors and old-upload/new-upload state isolation. It used actual
  React, Zustand, Axios and interceptors but mocked native modules and network
  transport; no real API mutation or simulator proof is claimed.
- Six-file ESLint has zero errors and one pre-existing unused generated-type
  import warning. Prettier and diff checks pass. Office/Lab each have 11
  pre-existing TypeScript diagnostics and zero new errors, compared against
  the six HEAD (`5994f1f`) file versions via an in-memory compiler host.
- Follow-up review `5097388237` on `80c1cb5` completed at 12:15 KST with no
  new blocking threads and two nitpicks. Both were verified against the actual
  source before fixing them in `2f4d6b7`: queue removal uses scope/kind/id value
  matching, and previous cleanup runs in the background rather than delaying
  new upload initiation. Scope/session checks and retry behavior are preserved.
  The transient harness now passes 19/19 including preservation of other queue
  entries and a new upload completing while the prior cleanup response is held.
  Related Jest still passes 46/46; the follow-up two files pass lint/format/diff,
  and Office/Lab again have 11 baseline diagnostics and zero additions against
  `80c1cb5`. No shared test/helper files or real-network mutations were added.
- The next review `5097447018` on `2f4d6b7` completed at 12:26 KST with two
  outside-diff findings. `b30e4a8` addresses them: local filesystem paths always
  refresh actual file size before max-size/presign/part-range calculation;
  FeedbackDetailsScreen also refreshes those sizes before aggregate validation
  and does not silently trust stale size on stat failure. Non-finite, zero and
  negative filesystem sizes fail before presign.
- Android `content://` provider URIs intentionally retain valid picker sizes.
  `useDeviceSystem` passes document URIs directly, while the installed RNFS
  Android stat implementation requires an accessible `_data`/File path. A
  blanket RNFS.stat requirement would regress existing document uploads.
  No speculative copy-to-local flow or new native dependency was introduced.
- Active BlobUtil tasks are tracked and canceled on hook unmount. Session
  guards prevent further PUT or completion when stat/presign/part preparation
  resolves after unmount; existing wait-all-workers logic includes temporary
  part cleanup and precedes abort. A completion PATCH already in flight cannot be
  recalled; its returned fileId enters cleanup as before, and lost completion
  response recovery still requires the known BE contract.
- Final transient harness passes 32/32: the previous 19 plus refreshed/stale/
  invalid sizes, content-provider preservation, presign and part byte ranges,
  unmount during active parts/stat/presign/part preparation/in-flight completion,
  and the actual feedback size resolver's aggregate/unreadable behavior.
  All transport/native operations remain mocked. Jest passes 46/46; the latest
  two-file lint/format/diff checks pass and Office/Lab still have 11 existing
  diagnostics with zero additions against `2f4d6b7`.
- Review `5097495166` on `b30e4a8` completed at 12:37 KST and identified a
  further minor outside-diff race: a newly queued ID could miss the last
  snapshot of the active cleanup run and wait until another lifecycle trigger.
  `919a884` records attempted entries with each shared run. Waiters exclude
  those entries and process only newly pending entries in a separate bounded
  run, preserving per-scope sharing and no recursive retry expansion.
  Regression validation reproduces the old behavior and verifies old ID = 3
  requests, new ID = 3 requests, including multiple waiting hook instances.
  The harness now passes 34/34, Jest 46/46, latest hook lint/format/diff pass,
  and Office/Lab have zero new diagnostics against `b30e4a8` (11 each).
- Final combined validation reran all seven changed files against the starting
  `5994f1f` versions in memory: Office/Lab 11 baseline and 11 current, zero new
  diagnostics. Seven-file ESLint has zero errors and the same pre-existing
  OrderFileUploadDto warning; Prettier and full commit-range diff checks pass.
  PR verification was consolidated to these latest results instead of a stack
  of intermediate counts. No native build or device QA was added.
- Existing review thread `PRRT_kwDOLCkD486ewYJC` was answered and resolved in
  https://github.com/Innvoaid/dentlink-app/pull/286#discussion_r3920674976.
  PR body is updated to the new code and explicit process-lifetime boundary.
  Follow-up body nitpicks were answered in comment `5519824568` and the two
  outside-diff findings in `5519935908` and `5519992149`. A fourth standalone
  manual review was requested in comment `5519992257` and completed on
  `919a884` at 12:44:53 KST. Comment `5519993334` confirms Review finished;
  the latest summary in `5393229878` explicitly says no actionable comments
  and names the reviewed range `b30e4a8..919a884`. All 16 review threads are
  resolved, with no pagination beyond the inspected set. There is no new
  formal review object for this zero-finding run, so the completion evidence
  is the exact-HEAD status plus the updated recent-review summary.
- Develop remains three commits ahead of the feature base with the same three
  known integration conflicts, reconfirmed with non-mutating merge-tree on
  the final HEAD. No merge, deployment, Jira/design change or fresh Android/iOS
  run was performed for this review task.
- Breakpoint: current requested CodeRabbit work is handled and pushed in four
  commits (`80c1cb5`, `2f4d6b7`, `b30e4a8`, `919a884`). PR #286 remains OPEN,
  non-Draft and CONFLICTING; app-developer approval is not inferred from bot
  completion. Next obtain explicit authority if develop conflict integration
  is requested, or refresh the real BE pushType contract when it is released.
  Runtime/real mutation QA and unknown multipart completion-response recovery
  remain separate from the completed code review scope.

## DL-16061 Local Develop Conflict Resolution - 2026-09-03

- The user's next request was to handle the remaining conflict files.
  Refreshed both repositories and confirmed the app began clean on `919a884`
  with `origin/develop` at `5ec442a`. No PR merge or develop branch mutation
  was performed. `git merge --no-commit --no-ff origin/develop` is in progress
  locally; there is no new app commit or push.
- Resolved all three conflicts: `shared/configs/i18n/locales/en.ts`,
  `shared/configs/i18n/textRegistry.ts`, and
  `shared/configs/utils/dentlinkWebURL.ts`. The first two now exactly match
  develop's generated output, including the new disabled-order interpolation
  and existing 200MB text. No sheet sync or speculative regeneration ran.
- Preserved develop's new local host allowlist entry and native order
  restriction/popup behavior, alongside feedback routes and the order-detail
  completion-result reload. The new order-navigation interceptor only handles
  `OrderScreen`, so `FeedbackDetailsScreen` still follows the existing bridge.
- Detected one integration regression in the automatic result: develop sets
  both Office/Lab development WebViews to `http://10.10.7.44:3000`, failing
  two existing environment tests. Kept this branch's established remote dev
  portal/lab URLs instead. Staging/production URLs and exact-host/protocol
  safeguards are unchanged. Develop's Reactotron debug-host changes were
  retained; no new local host strategy was invented.
- Validation: nine existing Jest suites, 67/67 tests pass. Transient
  source-level checks cover order restrictions versus feedback navigation,
  cancel versus successful Submit reload, en/ko registry resolution, 200MB
  preservation, and local-host/protocol routing (11 assertions). Native modules
  were not executed; no real API mutations, Metro, emulator, simulator or
  native build was started for this conflict-only task.
- ESLint over all 16 incoming JS/TS files: zero errors and four warnings,
  identical to develop. Office/Lab TypeScript each remain at 11 diagnostics,
  zero additions versus pre-merge HEAD via in-memory compiler-host overrides.
  URL/order-detail formatting and both diff checks pass. The two generated
  translation files fail Prettier both before and after; their canonical
  generated formatting was preserved, not mass-reformatted.
- Breakpoint at 13:02 KST: 17 staged merge files, no unmerged index entries,
  no unstaged changes, `MERGE_HEAD=5ec442a2a20be9dbbad9a7f8532de37e69b60a8d`.
  The work is local only; another device does not have these code changes.
  PR #286 and Jira were not updated, and the remote conflict indication cannot
  clear until the user authorizes the merge commit/push. Next inspect this
  index, obtain app commit/push authorization, then refresh the PR review state.
- Follow-up final recheck at 13:05 KST: origin refs are unchanged and all 16
  PR review threads remain resolved (no pagination); remote CodeRabbit is
  SUCCESS for `919a884`, not for the uncommitted merge. No additional feature
  defect or code edit was identified in this pass. The merge index is unchanged.
- Expanded unit coverage passes 15 suites / 125 tests with
  `yarn test --config jest.config.js --runInBand --watch=false
  --testPathIgnorePatterns '/e2e/' '__tests__/App.test.tsx'`.
  The unfiltered command reports 6 failing suites / 22 failing tests, all from
  known pre-existing test-runner boundaries: five Detox suites require their
  own worker, and the old App smoke test imports nonexistent root `../App`,
  which resolves to the app.json metadata object on this case-insensitive Mac.
  Those tests/config and root app.json are unchanged from HEAD; these are not
  new merge failures. No Detox device launch succeeded or device QA is claimed.
- Version validation passes: Office 2.2.3 and Lab 1.0.3 agree across app
  package.json, Android and Xcode. Both diff checks pass. Generated translation
  output and incoming order/popup/scanner files were also confirmed identical
  to develop; only the intentional URL default preservation and feature bridge
  integration differ where expected. No further app commit/push authority was
  inferred from the user's general request to finish all possible work.

## DL-16061 Develop Merge Delivery And Review - 2026-09-03

- The user explicitly requested commit, push, memory closeout, and handling
  subsequent review. Committed the reviewed 17-file merge index as `c6355a3`
  (`chore: develop 병합 및 피드백 충돌 정리`) and pushed to
  `origin/feature/DL-16061`. Parents are `919a884` and `5ec442a`; no force push,
  protected-branch update, PR merge, deployment or native build was performed.
- GitHub reports PR #286 MERGEABLE. All three previous integration conflicts
  are resolved remotely; the branch is clean with 39 ahead / 0 behind develop.
  PR description now explains the integration, intentionally preserved remote
  development WebView URLs, current validation and remaining QA boundaries.
- Re-ran the expanded unit test command after commit: 15 suites / 125 tests
  pass. The earlier 16-file lint, baseline TypeScript, version, generated-format
  and diff results remain applicable to the identical committed tree. The
  known unfiltered Jest/Detox/App smoke-test configuration failures remain
  separate and were not hidden or fixed by unrelated source changes.
- Automatic review returned SUCCESS with `Review skipped` because this PR
  targets develop rather than the configured release/default branches.
  Requested a real incremental review in comment `5520959146`; CodeRabbit
  acknowledged it in `5520962101` and exact-HEAD status became pending at
  14:27:47 KST. Do not mistake the initial skipped status or earlier `919a884`
  zero-finding summary for review of this merge.
- Exact-HEAD CodeRabbit status changed to `Review completed` / SUCCESS at
  14:31:29 KST. The recent-review summary in comment `5393229878` explicitly
  names `919a884..c6355a3`, selects dentlinkWebURL and OrderDetailScreen, and
  reports no actionable comments (run `de96be6d-0ddd-4b9a-a527-d987ad8f8ca9`).
  No new formal review object was created for this zero-finding run; the status
  and exact-range summary are the completion evidence.
- Final GraphQL inspection confirms all 16 review threads resolved and no
  next page. No review correction or second app commit was needed. PR body was
  updated again with the 14:32 KST review result and actual proof boundaries.
- Final breakpoint: app `c6355a3` is pushed, clean and MERGEABLE, with zero
  unresolved review threads and 125 passing unit tests. No local merge work is
  stranded, so another device can resume by pulling the feature branch and
  this context. Do not interpret this as app-developer approval, PR merge,
  deployment or new Android/iOS/real-API QA. Existing BE notification pushType
  integration and unknown multipart completion-response recovery stay at the
  previously documented external contract boundaries.

## DL-16061 Whole-Project Status Recheck - 2026-09-03

- Read-only briefing recheck at 14:35-14:41 KST reconfirmed app `c6355a3`
  clean and pushed, develop `5ec442a` included, and PR #286 OPEN/non-Draft,
  MERGEABLE/CLEAN with successful checks and all 16 review threads resolved.
  Human approval, PR merge and deployment have not been inferred.
- Live development Swagger returned HTTP 200 at 14:35 KST. Its
  `UserPushSettingUpdateDto.pushType` still has the nine existing order/chat
  values, with no Case Preference or Order Feedback values. Both Office
  settings rows already have disabled UI; their actual GET/POST/PATCH state,
  enable-all behavior and interaction events await the real backend contract.
- Found the dedicated BE dependency: DL-16285, assigned to Leo, is In Progress
  (updated 2026-09-03 10:42 KST). Its description covers user control of C.P.
  and feedback request pushes and specifically mentions C.P. template 127.
  Recheck this card and deployed Swagger together before implementing the
  remaining settings connection; do not guess enum spelling from UI labels.
- Live Jira: DL-16061, DL-16066 and DL-16229 remain Ready for Deploy;
  DL-16064 is Done. DL-16061's description still says Draft/Share Feedback and
  14 tests; DL-16066 still names the older `/my/feedback` URL. These are stale
  descriptions, not the latest code contract. No Jira edit was made in this
  reporting-only turn; description refresh remains documentation work.
- Swagger still exposes DELETE/PATCH but no GET for employee/user multipart
  upload IDs. Unknown-fileId recovery after a lost successful completion
  response remains the prior BE contract boundary, not an ordinary upload
  implementation gap. Known cleanup IDs are retained in process memory.
- This briefing refreshed Git/PR/Jira/Swagger and relevant source code. It did
  not repeat all Figma/FigJam/Notion design review or Android/iOS runtime QA.
  Today's 125 passing unit tests and baseline diagnostics belong to the same
  committed tree; historical visual proof must not be presented as a new
  runtime test of the upload fixes or develop integration.

## DL-16061 Jira And Task-Scope Closeout - 2026-09-03

- The user clarified that the remaining-task list should contain concrete
  feature implementation only. BE notification-setting release is already
  acknowledged and the user will announce availability. Ordinary QA/review/
  release steps and general shared-upload response-loss recovery are not
  unfinished feedback tasks. A regression caused by this change remains in
  scope; this clarification does not waive real defects or validation honesty.
- Refreshed personal context and the exact app checkout. App remains clean
  and synchronized at `c6355a3`, containing develop `5ec442a` (0 behind / 39
  ahead). There was no code change or additional app commit/push to perform.
- With explicit authorization, updated DL-16061 and DL-16066 descriptions at
  14:51 KST: Pending Reviews wording, native/WebView ownership and successful
  Submit return, current employer-scoped routes, actual analytics mapping,
  pushed/reviewed status, 125-test evidence and historical runtime boundaries.
  Preserved unrelated model-drift context and linked BE follow-up DL-16285.
- Preserved historical comments and added current corrections: DL-16061
  comment `43884`, DL-16066 `43885`, and DL-16229 `43886`. The analytics comment
  explicitly supersedes old my/feedback, uncommitted/payload-wait/conflict
  wording. Kept the original analytics Notion description and web session's
  historical completion record; did not claim a fresh web-code review.
- Readback confirmed both updated descriptions and all three comments.
  DL-16061, DL-16066 and DL-16229 remain Ready for Deploy; no transition,
  assignee or unrelated-card mutation was made. Jira-description cleanup is
  now complete, superseding the preceding status-only checkpoint.
- PR #286 is still OPEN/non-Draft, MERGEABLE/CLEAN, checks successful; all 16
  threads are resolved with no next page. No new PR review correction or PR
  mutation was necessary. No fresh test/device run was performed for this
  documentation-only closeout; earlier same-tree evidence remains labeled.
- Next development starting point: after the user announces the BE setting
  release, refresh DL-16285 and deployed Swagger, regenerate/diff the model
  through the official command, then connect only the actual new pushType
  rows to existing settings read/write/enable-all behavior. Until then there
  is no identified immediately actionable unfinished feedback implementation.

## Feedback Session Boundary After Notification-Center Handoff - 2026-09-03

- The user created a separate unified-notification-center session and asked
  for a copyable context handoff. That session owns the new common deep-link
  hospital/screen/read-receipt work; this session continues the existing
  DL-15828/DL-16061 feedback scope only. The shared routing files can overlap,
  so neither session should silently switch the shared checkout or mix new
  notification-center work into the feedback branch.
- Read-only investigation found existing employerId-to-employeeId mapping,
  FCM/Notifee/Linking/Airbridge and deferred navigation. Common notification
  read handling is not implemented. A proposed URL notificationId must be the
  REST NotificationDto.id, not orderId or a transport/OS ID. Different create/
  update notifications landing on the same route need distinct IDs; preserve
  navigation dedup separately from notification read identity.
- Development Swagger was inspected at 15:09 KST: existing authenticated
  PATCH /messages/notifications/read/partial accepts unreadNotificationIds.
  Employee-Id/Employer-Id context must match the target authorized membership.
  Query-name/payload mapping, already-read semantics and read-on-navigation-
  failure policy are not confirmed BE contracts. No new read API or payload
  field was implemented here. REST-only/no cross-device realtime scope stands.
- Feedback branch still clean at `c6355a3`. A user-supplied development
  CodePush log failed at CLI asset validation for the existing 1,549,611-byte
  ISV video, unchanged from develop. Installed CLI 0.0.15 supports --force to
  bypass its 500 KiB check; the scripts' --mandatory is unrelated. Explained
  per-platform --force commands, but did not edit scripts/video or execute a
  release. A subsequent successful user deployment has not been verified.
- This handoff does not authorize implementation, branch creation, commits,
  pushes, PR changes or deployment in the destination session beyond its own
  current user instructions. No product code/Jira mutation was made here.

## DL-16061 CodePush Script Develop Sync - 2026-09-03

- The user explicitly requested merging develop, committing and pushing.
  Refreshed origin refs and merged `aa82c4c` into `feature/DL-16061` without
  conflicts. Merge commit `364030e76b2ca16200af576d33e4556aca17bc8b`
  (`chore: develop CodePush 강제 배포 옵션 병합`) is pushed; its parents are
  `c6355a3` and `aa82c4c`. Worktree is clean, upstream divergence is 0/0,
  and fetched develop is fully included (0 behind / 40 ahead).
- Only package.json changed: 20 CodePush scripts now include --force on each
  relevant iOS/Android release command, across development/staging/production.
  It bypasses the CLI's 500 KiB asset guard, not the feedback attachment
  policy. Existing targets, mandatory/disabled flags, dependencies, native
  files and feedback source remain unchanged. No release command was run.
- Verified that all changes are exactly --force additions, all 20 commands
  pass shell syntax-only checks, package.json passes Prettier, and the staged
  diff passes whitespace checks. Prettier emitted only the existing ignored
  import-order-option warnings. No full app tests or device QA were repeated
  for this scripts-only merge, and no new CodeRabbit review is claimed.
- The existing PR receives the pushed branch commit automatically. No PR
  description, Jira state or unrelated notification-center code was changed.
  Remaining feedback feature boundary is unchanged: connect the disabled
  notification settings after the user announces the actual BE pushType release.

## DL-16061 Notification Settings API Delivery - 2026-09-03

- Supersedes the preceding disabled-placeholder / BE-wait checkpoints. The
  user announced the two deployed types and explicitly authorized code,
  commit, push and memory closeout. Development Swagger was checked at
  18:21 KST and the official generation repeated at 18:25-18:28 KST.
  `UserPushSettingUpdateDto.pushType` and `PushSettingListDto.type` now expose
  `USER_CASE_PREFERENCE` and `ORDER_FEEDBACK`. `ORDER_WORKFLOW` is additional
  older model drift, not a third new feedback UI row.
- Confirmed existing contracts: GET/POST `/app/users/own/push-preferences`,
  individual PATCH `/app/users/own/push-settings/{pushSettingId}` with
  `pushType` and `pushEnable`. The similarly named PATCH with `preferenceId`
  controls overall/personal-order settings, not an individual row.
- Office now has functional Case Preference and Order Feedback switches
  using the existing service/query/UI components. Figma `160:39015` copy,
  order and compact switches are preserved; the Lab four-row list is unchanged.
  Missing new Office settings use the existing POST initialization and a
  fresh GET before using the returned setting IDs. Existing disabled settings
  are not deliberately enabled by an individual toggle.
- POST documentation distinguishes adding missing types (new entries true)
  from an already complete set (all entries true). Enable All therefore
  refetches after POST and PATCHes any remaining false entries. Failed or
  partial writes refetch server state and show one existing error toast;
  optimistic state is cleared and retry remains possible. Local save guards,
  shared upsert pending state and provider initialization guard prevent the
  tested duplicate-tap / permission-plus-missing-types initialization paths.
  Follow-up actions check the original account/employer/employee/service scope.
- Both rows emit the existing `push_preference_click` with on/off status.
  Order Feedback reuses `pushType: "Order Feedback"`. Notion lacked a Case
  Preference property value; the user explicitly approved adding
  `pushType: "Case Preference"` in the async clarification on this turn.
  This does not change `push_click`, employer-scoped feedback URLs, WebView
  bridge, or unified-notification-center/read handling owned by another task.
- `yarn swagger-typescript-api-dev` was run against a temporary output and
  then the official target; both Api.ts files match byte-for-byte. Full
  generated output is committed, never manually edited or partially selected.
  Incidental generated changes include Admin feedback detail/list contracts,
  reviewer metadata, system feedback-notification methods/categories, finance
  manual exchange DTO/method, and comments. No existing field removal or
  `hasPhoto` change was found, and no new handwritten Admin consumer was added.
- Delivered two commits on `feature/DL-16061`: `1c56bc6` (generated Swagger
  models) and `a301e78e4ccc4e2d750623c70dbff9435acaa74b` (five handwritten
  files: enum.ts, pushPreference.ts, PermissionProvider.tsx,
  useProfileNotification.ts, ProfileNotificationSection.tsx). Push/readback
  succeeded at 18:42 KST; worktree clean, upstream 0/0. PR #286 is OPEN,
  non-Draft, MERGEABLE and points at a301e78. No new CodeRabbit review is
  claimed; no PR body, Jira, deployment script or native dependency changed.
- Verification on the final code: 15 Jest suites / 125 tests pass with
  existing Detox and legacy App smoke exclusions; five-file ESLint/Prettier
  and diff whitespace checks pass. Temporary, uncommitted mock-transport
  verification passes 23/23 cases including both switches on/off, analytics,
  fresh IDs, Enable All, denied OS permission, account change, partial errors,
  duplicate taps, initialization overlap, UI rows and endpoint shapes.
  Office and Lab type checks each retain exactly the baseline 11 diagnostics;
  no new diagnostic remains. Existing ignored Prettier options and deprecated
  react-test-renderer warnings are unchanged tooling boundaries.
- No authenticated setting writes, emulator/simulator/device visual QA,
  native build, Metro start or CodePush release was performed for this delta.
  The user's earlier CodePush predates these two commits; testing this new
  behavior on that installed deployment requires a later explicitly authorized
  deployment. Do not label historic visual checks as proof of this change.
- Remote develop now contains ancestry-only merge `967ba71b` (#294); the
  incoming three-dot file diff is empty. It was fetched, not merged here.
  Do not claim current develop ancestry is fully contained based on the older
  aa82c4c checkpoint. No further known feedback implementation is blocked by
  these two push types; resume with live Git and fresh external changes.
- Sources: https://dev-api.dentlink.io/v3/api-docs; Jira DL-16285 and DL-16229
  (both read as Ready for Deploy); Figma Lu8GEh1TUU5hOfj2FCPRYn node
  160:39015; analytics Notion 3c6ce072e82f8001bc20ef404c74059b,
  pushType 21ece072e82f808ba1cff20e603f89fe and push_preference_click
  21ece072e82f80ba925ccd44cb43a747; explicit Case Preference user approval.

## DL-16061 WebView Deployment Follow-up - 2026-09-03

- The user observed Order Details remaining above Feedback Details with no
  native navigation. App and web source inspection confirmed the existing
  NAVIGATION / FeedbackDetailsScreen / orderId / entryPoint=order-detail
  contract; no app code was changed during this investigation.
- The user subsequently identified that the development web server did not
  contain the feature code and reported that web redeployment was underway.
  Treat this as the user-confirmed cause, not a newly verified app defect or
  proof that redeployment/integrated runtime testing has completed.
- App source remains clean and pushed at a301e78, with the new notification
  settings already delivered. No additional app-code task is currently
  identified from this report. After the web deployment, check actual native
  transition and close/Submit return only if requested; investigate the app
  bridge if a correctly emitted message still fails to navigate. CodePush
  and remotely hosted WebView web deployment are separate artifacts.

## Personal Local App Development Loop - 2026-09-04

- Canonical reusable checklist:
  `projects/dentlink-app-local-development.md`. Treat it as an executable
  personal-memory playbook: the user may follow it manually, or Codex may run
  the same sequence when asked. It is not product code and grants no commit,
  push or deployment authority.
- Master personalized workflow:
  `projects/dentlink-app-development-guideline.md`. It defines the normal
  iOS-first local loop, Android checkpoint, explicit Development CodePush gate,
  physical-device options and stage-by-stage briefing. This supersedes the old
  blanket Android-first personal default; historical task-specific Android-
  first QA records remain historical evidence rather than a current rule.
- The user will now develop the mobile app regularly rather than only observe
  app-developer work. Keep the team's package scripts as the canonical launch
  commands, while preparing a repeatable personal workspace around them.
- When the user asks to start local iOS Office development, open a visible
  Codex-managed terminal for the exact `dentlink-app` checkout, plus the iOS
  Simulator, Metro, and Reactotron as one working set. Verify the live
  branch/worktree first, then use `yarn ios-office:dev` only when a native
  rebuild is needed and confirm both the rendered app and Reactotron
  connection/log traffic. The user manages the IDE separately. Use the
  corresponding Lab command only when the task is explicitly Lab.
- When the user asks for local Android Office development, use the same pattern
  with the Android emulator and `yarn android-office:dev`. After the emulator
  is connected, apply `adb reverse tcp:9090 tcp:9090` before app load/reload;
  repeat it after an emulator reboot or reconnect. Confirm Reactotron shows an
  Android connection and Timeline traffic rather than assuming success from a
  completed build alone.
- Reactotron is part of the normal local debugging workspace because it covers
  API/network timeline, AsyncStorage and application logs. React Native
  DevTools, the device screen and native IDE logs remain complementary rather
  than interchangeable. Reactotron configuration is imported only in
  `__DEV__`; a CodePush/release bundle is not evidence of a Reactotron-capable
  local session.
- Local debug uses the source from the currently checked-out Git branch through
  Metro. The `dev`, `staging` and `production` suffixes select API/environment,
  scheme/flavor and app configuration; they do not select a Git branch.
  `codepush-force-*:dev` is a remote Development deployment command, not a
  substitute for `ios-*:dev` or `android-*:dev` local execution.
- Start Metro only in a visible Codex-managed terminal rooted at the exact
  checkout. Open the terminal while it is active and close it after command
  work is complete; do not use or depend on an IDE terminal. Prefer the team's
  working command path; the current repository's `yarn start` has a known
  obsolete debugger flag, while `yarn metro-log` starts Metro when it must be
  run separately.
- Live proof on 2026-09-04: the already installed Office Android development
  app was attached to Metro in the `dentlink-app` Cursor terminal, reloaded,
  and Reactotron displayed one Android 16/API 36 connection plus AsyncStorage
  Timeline traffic. The required host split is Android `localhost` through
  ADB reverse and iOS the current Mac LAN address.
- Current app checkout is clean and synchronized at `a301e78` after the user
  explicitly requested discarding all local changes on 2026-09-04. The
  temporary Office Reactotron platform/IP split and the unrelated Android
  Studio `android/gradle.properties` parallel-tooling change were both removed,
  restoring the tracked files to HEAD. The personal rule remains: temporarily
  set each developer's own Reactotron IP only while needed and never publish
  that local edit; do not propose a shared environment-variable refactor unless
  the team later requests one.
- Live workflow review on 2026-09-04 confirmed the package scripts use Debug by
  default and separate `*-release` commands. Office Development CodePush has
  combined, iOS-only and Android-only commands; choose the narrowest target.
  Revopush `release-react` defaults `--development` to false, so CodePush is not
  a Reactotron/`__DEV__` debugging path. The committed Podfile still excludes
  arm64 for Simulator, and MLImage's arm64 slice is device-only while x86_64 is
  the Simulator slice. Reuse the installed iOS Development proof app with Metro
  for ordinary JS work; do not present `yarn ios-office:dev` as a proven clean
  Apple Silicon rebuild until that native constraint is resolved. The iPhone
  17 Pro simulator currently contains the arm64
  `com.innovaid.dentlink.development` proof app, verified directly in its
  simulator container on 2026-09-04.
- Read-only Chrome inspection of Revopush at 16:08 KST confirmed separate
  `Dentlink-Office-iOS` and `Dentlink-Office-Android` applications, each with
  Development, Staging and Production deployments. Both Office Development
  deployments showed last release `v124`; no site setting, release, key or
  deployment was changed. The dashboard displayed a Free-plan production-use
  warning, which is an account/production continuity concern rather than a
  blocker for defining the user's Development workflow.

## DL-16061 Feature-Branch Development CodePush Readiness - 2026-09-04

- Live Git was refreshed before the assessment. `feature/DL-16061` is clean and
  synchronized with `origin/feature/DL-16061` at
  `a301e78e4ccc4e2d750623c70dbff9435acaa74b`. PR #286 remains OPEN,
  non-Draft, MERGEABLE/CLEAN; human approval and merge remain separate gates.
- Compared with current `origin/develop` `967ba71b`, the branch reports 42
  commits ahead and one behind. The single develop-only commit is the
  `Release/office/v2.2.3 -> main (#294)` merge. Both of its parents are already
  ancestors of the feature branch and every file changed by that merge has
  identical content on the feature branch, so there is no missing develop code
  that blocks feature-branch QA.
- The PR comparison contains 54 files with 5,514 additions and 376 deletions.
  It includes the complete confirmed feedback FE scope plus shared upload,
  profile notification, permission, navigation/deep-link, API and generated
  model changes. It contains no iOS/Android native file, dependency lockfile,
  Office version or environment-file change. The shared `useFileUpload` delta
  can affect existing Office chat/order/profile/design-confirmation upload
  flows, so those are side-effect QA surfaces even though no known code defect
  or incomplete confirmed FE requirement remains.
- Current Office version is `2.2.3`; `.env` matches the Office Development
  environment. Read-only release-bundle verification produced both iOS and
  Android bundles and successfully converted each with Hermes. The existing
  shared `isv.mp4` is 1,549,611 bytes and exceeds the CLI's 500 KiB asset guard;
  the current `--force` scripts intentionally bypass that pre-existing warning.
- The planned delivery loop is valid: publish the clean feature branch to the
  shared Office Development CodePush deployment for QA, apply QA fixes on the
  feature branch, merge it into develop, then publish develop as the final
  integrated Development CodePush. A later develop release supersedes the
  temporary feature-branch release; CodePush itself does not merge Git state.
- CodePush packages the local working tree, including any uncommitted files,
  rather than a PR object. Reconfirm the exact branch, clean status, Office
  Development environment and matching `2.2.3` installed binary before every
  publication. The combined command publishes mandatory iOS first and Android
  second, so a second-platform failure can leave a temporary partial release;
  prefer the platform-specific commands when staged verification is desired.
- No CodePush release was executed during this readiness assessment. Within the
  confirmed FE code scope there is no known blocker or missing implementation
  before QA. Development BE availability and the separately deployed WebView
  order-detail bridge remain runtime prerequisites, not unfinished app code.

## DL-16061 Notification Settings UX Follow-up - 2026-09-04

- Resumed from remote and fast-forwarded `feature/DL-16061` from `a301e78` to
  `cabe4a5`. The incoming app-developer commit adds service-specific required
  push-type calculation, tests, and a repeated-initialization guard; it was
  preserved as the new base rather than overwritten.
- Reviewed the Feedback Details unsaved-change popup. The exact `Leave this
  page?` / `Changes you made may not be saved.` interaction already exists in
  `CasePreferenceScreen`, with a similar guard in `DesignConfirmationScreen`.
  Figma and the original feedback Notion requirement do not explicitly demand
  it, but it follows an established app pattern, so the user decided to keep it
  and no popup code was changed.
- Fixed the Profile notification-setting flicker where changing one row made
  every switch temporarily render with disabled colors during mutation and
  background refetch. The request/account/upsert guards still block duplicate
  or conflicting interaction, while only the initial unavailable query state
  uses the visible disabled styling. Other switch values and colors remain
  stable during a single-row save.
- Delivered commit `a693de6` (`fix: 알림 설정 스위치 깜박임 방지`) with only
  `shared/features/profile/sections/ProfileNotificationSection.tsx`; push to
  `origin/feature/DL-16061` succeeded. Final worktree and upstream status must
  still be refreshed live when resuming.
- Changed-file ESLint, Prettier and diff whitespace checks pass. The focused
  push-preference Jest suite passes 3/3 after explicitly selecting
  `jest.config.js`; the unqualified test command first stopped on the
  repository's pre-existing duplicate Jest configuration. `typecheck:apps`
  retains the same 11 baseline diagnostics and reports no new error in the
  changed file. No emulator, simulator, device, Metro or CodePush runtime QA
  was performed for this small visual-state correction.

## DL-16061 Feature-Branch Development CodePush v125 - 2026-09-04

- The user explicitly authorized publishing the current feedback feature
  branch to both Office Development CodePush deployments and requested the
  process remain visible. Preflight confirmed `feature/DL-16061` clean and
  synchronized at `a693de6cfe335d58490e075f723a9b6b52939178`, Office version
  `2.2.3`, `.env` byte-identical to the Office Development environment, and no
  native/dependency/environment-file delta from develop.
- Opened the exact `dentlink-app` Cursor workspace and used its visible
  integrated terminal. Published with the narrow platform scripts in sequence:
  `yarn codepush-force-office-ios:dev`, then
  `yarn codepush-force-office-android:dev`. The first Android command entry was
  mistyped by UI automation and failed before invoking a script; the exact
  command was then entered and completed successfully. No partial Android
  release resulted from the typo.
- CLI output confirmed successful mandatory Development releases for
  `Dentlink-Office-iOS` and `Dentlink-Office-Android`, target binary version
  `2.2.3`. The existing 1,549,611-byte `isv.mp4` exceeded the 500 KiB advisory
  limit on both bundles, but the committed `--force` policy allowed completion.
- Read-only Revopush verification at 17:23-17:24 KST confirmed Development
  `v125` on both apps: Enabled, Mandatory Yes, rollout 100%, iOS 7.7 MiB and
  Android 7.68 MiB. This proves publication, not physical-device update receipt
  or feature QA after installation.
- Post-release Git verification remains clean and synchronized at `a693de6`;
  the CodePush commands restored the Development environment file and did not
  create a product-code change. The Revopush browser was left on the Android
  application result page for the user to inspect.
- The user then confirmed update receipt and the target behavior on both iOS
  and Android physical devices: changing an individual notification setting no
  longer makes the other switches flicker, and the setting-change flow behaves
  normally. This closes the runtime QA gap for the `a693de6` visual-state fix;
  it does not independently re-verify every other feedback feature flow.

## DL-16061 Feature-Branch Staging CodePush v312 - 2026-09-04

- After explicitly reviewing the expected missing-BE behavior, the user
  authorized publishing the same feedback feature commit to both Office
  Staging CodePush deployments. Preflight confirmed
  `feature/DL-16061` clean and synchronized at
  `a693de6cfe335d58490e075f723a9b6b52939178`, target version `2.2.3`.
- Used the exact `dentlink-app` Cursor integrated terminal and the narrow
  platform commands in sequence: `yarn codepush-force-office-ios:staging`
  and `yarn codepush-force-office-android:staging`. Both CLI releases
  completed successfully as mandatory Staging updates. The known 1.48 MiB
  `isv.mp4` advisory was bypassed by the committed `--force` option.
- Read-only Revopush verification at 17:39-17:40 KST confirmed Staging `v312`
  for both `Dentlink-Office-iOS` and `Dentlink-Office-Android`: target `2.2.3`,
  Enabled, Mandatory Yes, rollout 100%, iOS 7.7 MiB and Android 7.68 MiB. The
  previous `v311` entry is Disabled on both platforms.
- The user stated that the feedback backend was not yet available in Staging
  and accepted the resulting degraded feedback flow. Current app code is
  expected to keep the app alive: Profile omits the pending count on query
  error, list/detail show retry UX, and push detail returns with an error toast.
  This is code-path analysis, not yet real Staging 404 or feature QA evidence.
- Post-release app Git remains clean and synchronized at `a693de6`; no product
  file was changed by the publication. Revopush was left open on the iOS
  Staging result page. Physical-device update receipt and Staging behavior
  remain separate verification steps.

## DL-16311 Profile UI Alignment and Staging CodePush - 2026-09-04

- Figma Profile frame `160:39015` was rechecked at 100% in Dev Mode. The user
  confirmed a newer design decision that all Office Profile cards use a 12px
  radius, overriding the older 8px value still visible in the Figma frame.
- Updated the Office user, Preferences, Notifications and Quick Links cards
  from `theme.radius.m` to `theme.radius.l`. Home already used the 12px token.
- Replaced the Quick Links external-window glyph with the exact Figma 22×22
  asset, including its 5px-radius tile and centered 11×11 filled up-right
  arrow. Normalized the Preferences filled gear to the current 24px Dentlink
  icon geometry so it no longer stretches the older irregular viewBox.
- Home and Office Profile now set the root top Safe Area background to
  `mono200` while focused and restore white when leaving. Lab Profile remains
  white. This changes the top safe-area strip only; bottom-tab safe area is
  unaffected.
- Delivered app commits `fa03860` (`fix: 프로필 화면 디자인 정합성 개선`) and
  `7546923` (`fix: 퀵 링크 아이콘 원본 반영`), followed by `c71cffb`
  (`fix: 퀵 링크 아이콘 전체 에셋 적용`) after the complete Figma SVG was
  provided. All commits were pushed to `origin/feature/DL-16061`.
- Changed-file Prettier, ESLint, generated SVG exports and `git diff --check`
  pass. `yarn typecheck:apps` reproduces the existing 11 diagnostics and adds
  no error in the changed files. No device/simulator visual QA was claimed at
  this checkpoint.
- Used the exact `dentlink-app` Cursor integrated terminal and published the
  final `c71cffb` checkout with the narrow platform commands
  `yarn codepush-force-office-ios:staging` and
  `yarn codepush-force-office-android:staging`. Both CLI releases succeeded;
  the known 1.48 MiB `isv.mp4` advisory was bypassed by the committed
  `--force` policy.
- Fresh Revopush pages verified Staging `v313` for both
  `Dentlink-Office-iOS` and `Dentlink-Office-Android`: target `2.2.3`, Enabled,
  Mandatory Yes, rollout 100%, iOS 7.7 MiB and Android 7.68 MiB at 18:36 KST.
  Publication is proven; device update receipt and visual QA remain separate.
- Post-publication app Git is clean and synchronized with
  `origin/feature/DL-16061` at `c71cffb`; no environment or product file was
  left modified by the CodePush scripts.

## DL-16311 Profile UI Follow-up Checkpoint - 2026-09-04

- Physical-device review of Staging `v313` exposed two follow-up issues in the
  just-added Profile alignment work: the Preferences gear did not match the
  exact Figma asset, and changing between gray Home/Profile and white tabs
  could visibly flash the root top Safe Area color.
- Replaced `SvgSystemSettingFilled.svg` with the exact Figma 22x22 asset: the
  outer gear uses `#A3ADB7` and the inner circle is white. This corrects the
  earlier 24x24 substitute rather than introducing a second Profile icon.
- Removed competing Home/Profile focus cleanup writes to the global Safe Area
  color. `RootNavigator` now derives the final color from the active nested
  route: Office Home/Profile use `mono200`, and other routes use white. The
  existing Design Confirmation capture-mode `mono900` override remains
  unchanged.
- Delivered and pushed commits `a5807a8` (`fix: Preferences 아이콘 원본 반영`)
  and `ed0683c` (`fix: Safe Area 전환 깜박임 개선`). Physical-device review
  then proved route-state centralization alone was still late: gray
  Home/Profile to white LinkTalk consistently retained gray for a frame, while
  white Orders to LinkTalk did not reproduce it.
- Added a synchronous bottom-tab press update so Home/Profile choose `mono200`
  and Orders/LinkTalk/Place Order choose white before navigation renders. The
  RootNavigator derivation remains the fallback for programmatic navigation
  and deep links. Commit `6856bcd` (`fix: 탭 Safe Area 전환 시점 보완`) was
  pushed; the app checkout is clean and synchronized with
  `origin/feature/DL-16061` at `6856bcd`.
- Changed-file Prettier and ESLint pass with only three pre-existing
  `RootNavigator` console warnings. SVG exports, `git diff --check`, and
  `yarn typecheck:apps` pass. Device receipt and visual confirmation of these
  two follow-up fixes are not yet recorded.
- The user directly entered the exact Office iOS Staging CodePush command after
  UI automation repeatedly omitted a character before script execution.
  Revopush was refreshed read-only and confirms iOS Staging `v314`, target
  `2.2.3`, Enabled, Mandatory, rollout 100%, published at 18:50 KST. The failed
  automated command entries stopped at Yarn script lookup and created no
  releases.
- At the last verified point, Android Staging remains `v313`; the follow-up
  commits are not yet proven published to Android. iOS `v314` also predates
  `6856bcd`, so the final tab-press timing fix is not yet published to either
  platform. Recheck Revopush before assuming this is still current.
- A full audit of all APP-specific frames in the feedback Figma was started
  only after this breakpoint. The user then explicitly paused the audit, so no
  audit finding or additional code change should be inferred. Resume by
  inventorying the Design page sections (`마이페이지`, `Pending Reviews 화면`,
  and APP-owned parts of `주문상세 (앱.웹)`) and comparing only the current
  variants against the native Profile, feedback list/detail, navigation and
  attachment implementation.

## DL-16311 Safe Area Final Timing Fix and APP Audit Start - 2026-09-04

- Live Git confirms `feature/DL-16061` is clean and synchronized with
  `origin/feature/DL-16061` at `6856bcd455c8cbcebd7fc4329cee806378822dc5`.
- The final Safe Area timing fix adds a bottom-tab `tabPress` update before the
  route render: Office Home/Profile select `mono200`, while Orders/LinkTalk and
  the remaining tabs select white. The centralized `RootNavigator` route
  derivation remains the fallback for programmatic navigation and deep links.
  No API, analytics, navigation destination or Lab color behavior changed.
- The user will perform the next CodePush directly. Codex must not publish or
  operate Revopush for this checkpoint; CodePush receipt and physical-device
  confirmation of `6856bcd` remain separate until the user reports them.
- The next active task is a full design-to-code audit of current APP-owned
  feedback Figma variants: Office Profile, Pending Reviews list/detail/input,
  order-detail WebView to native feedback navigation, notification settings,
  and Amplitude annotations. Exclude superseded variants and web-only UI. Audit
  first and report confirmed mismatches before making another shared/global UI
  change.

## DL-16311 Physical-Device Closeout - 2026-09-04

- The user completed the final runtime check after publishing the current
  feature branch and confirmed that every DL-16311 Profile UI item now behaves
  correctly. This includes the 12px card radii, exact Preferences and Quick
  Links icons, Profile visual alignment, and the root top Safe Area color.
- The previously reproducible gray-to-white transition lag is closed by user
  evidence: changing from gray Home/Profile to white Orders/LinkTalk now updates
  the Safe Area color immediately with the tab transition. No remaining
  DL-16311 visual defect is known at this breakpoint.
- This is user-reported physical-device acceptance of commit `6856bcd`; the
  exact Revopush release number was not independently re-read by Codex at this
  checkpoint. Product code remains clean and synchronized at that commit.
- Continue the separate feedback APP Figma audit already in progress. Do not
  reopen DL-16311 unless a new regression is reproduced.

## DL-15828 APP Functional and Major-Visual Audit - 2026-09-04

- Completed the requested breakpoint audit without changing product code.
  Live app Git is clean and synchronized at
  `feature/DL-16061` / `6856bcd455c8cbcebd7fc4329cee806378822dc5`.
- Rechecked the authenticated Figma Design page's four current sections:
  `주문상세 (앱.웹)`, `마이페이지`, `Pending Reviews 화면`, and
  `엠플 이벤트`. Current native Profile, feedback list, feedback detail,
  rating/detail CTA states, attachment picker, scroll FAB, order-detail
  WebView-to-native route, and native-submit WebView refresh behavior match the
  APP-owned variants. The user had already completed physical-device QA for
  DL-16311 at this breakpoint; the audit did not repeat runtime QA.
- Rechecked Jira DL-15828 and its APP-related children. DL-16061, DL-16064,
  DL-16066 and DL-16311 are Complete. DL-16229 is Ready for Deploy. Remaining
  unfinished children visible on the parent are BE, release-note, popup, or QA
  work and are not a newly missing APP FE implementation.
- Rechecked the Notion analytics specification linked from DL-16229. App code
  matches `review_feeback_click` with `feedbackType=Good|Bad`,
  `review_detail_click`, `review_edit_click`,
  `reviewdetail_select_reason`, `reviewdetail_add_comments`,
  `reviewdetail_img_upload`, `reviewdetail_submit_click`,
  `pendingreviews_click`, and the existing feedback `push_click` classification.
- The only confirmed source drift is documentation copy: a Figma attachment
  annotation still says total size up to `2G`, while the previously confirmed
  product policy and current app implementation are maximum 5 files and total
  200 MB. Keep the 200 MB implementation; this is not an app-code defect.
- Static verification: six focused Jest suites pass (49/49 tests),
  `git diff --check` passes, changed-file ESLint has 0 errors and 15 existing
  warnings, and all non-generated changed files pass Prettier. Generated
  `shared/models/Api.ts` and generated `shared/assets/svg/index.ts` retain their
  generator formatting and were not hand-edited. `yarn typecheck:apps`
  reproduces the existing 11 repository diagnostics; none points to a feedback
  feature file changed by this audit.
- Remote refresh found `origin/develop` one release-merge commit ahead at
  `967ba71`; no merge was performed. GitHub PR #286 is still open, non-draft,
  mergeable/CLEAN, and its current checks report success. This is branch timing,
  not a missing design implementation.
- No additional major APP FE task is confirmed at this breakpoint. Resume for
  the pending pixel-level visual audit described below, or for a new
  Figma/Notion/Jira change, a newly deployed API contract, reviewer action, or
  a reproduced regression. Reconcile those sources and live Git again before
  modifying code.

## DL-15828 APP Visual-Audit Scope Clarification - 2026-09-04

- The user's reason for requesting the audit was not basic functional
  completeness: physical QA had exposed subtle design differences such as the
  wrong Preferences/Quick Links SVGs, card radius, and one-frame Safe Area
  color lag. Future use of `전수조사` for this feature must prioritize those
  rendered-detail mismatches.
- The completed pass proves no large missing APP screen, state, CTA, navigation
  bridge, attachment policy, analytics event, or Profile integration. No major
  code task is currently known.
- It did not compare every icon and every visual property in every current APP
  frame one by one. Do not describe the pixel-level visual audit as complete.
- The optional follow-up is an exact current-variant checklist covering SVG
  path/viewBox/size/color, typography, spacing, padding, alignment, radius,
  border/background, Safe Area, state variants, and iOS/Android rendering.
  Compare only APP-owned frames; order-detail content remains web-owned except
  for the native navigation bridge.
- No app code changed for this clarification. The functional checkpoint and
  user-completed QA remain valid; detailed visual inspection can resume later
  from clean app commit `6856bcd`.

## DL-15828 Staging QA Entry Breakpoint - 2026-09-07

- This checkpoint was created before fixing newly filed QA cards. The user
  reports that the feature is already available for Staging QA, and Jira now
  has active QA work under DL-15828. Treat deployed-artifact QA and Git branch
  integration as separate states.
- Live app Git is clean and synchronized at
  `feature/DL-16061` / `6856bcd455c8cbcebd7fc4329cee806378822dc5`.
  The branch is 51 commits ahead and one release-merge commit behind
  `origin/develop`. GitHub PR #286 is open, non-draft, MERGEABLE/CLEAN, with
  successful visible checks, but its exact head commit is not contained by a
  remote develop or release branch. No app code, commit, push, merge or PR
  mutation was made during this audit.
- Rechecked the current Notion PRD, Figma APP feedback section, Jira children,
  generated push types and the feature code. The implemented product contract
  remains intact: native Profile entry/count and notification settings,
  native feedback list/detail, rating POST then optional detail PUT,
  5 attachments / 200 MB, deep-link and order-detail WebView bridge,
  Amplitude events, and server-owned questions/options.
- The Notion PRD was last edited on 2026-09-07 and marks the main Clinic/app
  QA rows as reflected. Source-copy drift remains: one Notion screen note says
  maximum 10 uploads and one Figma attachment annotation says 2G, while the
  QA table, confirmed decision and app implementation remain maximum 5 files
  and total 200 MB. Do not change app limits from those stale annotations.
- Focused verification passed: six Jest suites / 49 tests, feedback-related
  changed-file ESLint with zero errors, and `git diff --check` against
  `origin/develop`. `yarn typecheck:apps` still reports the same 11 known
  repository diagnostics; none is in a native feedback feature file and no new
  diagnostic was introduced by this checkpoint.
- Jira's currently filed QA queue is deliberately not fixed in this audit:
  - DL-16324: Mobile Web/App Share Feedback UI alignment. The screenshot calls
    out native header/tab spacing and tab background; app code is in scope.
  - DL-16325: remove the 16px gap between the Share Feedback tab and info
    banner; app and web surfaces should each be checked.
  - DL-16330: native tab switching always shows a spinner. Current code swaps
    the entire list for `LoadingSpinner` while a newly keyed tab query is
    loading, so this is a direct app QA item.
  - DL-16322: category image should be shown instead of the observed thumbnail.
    App currently renders the API `categoryThumbnailUrl`; determine with live
    payload/design whether this is app rendering or server data before changing
    the mapper.
  - DL-16321 and DL-16327 concern rating-dependent copy in the order-detail
    feedback banner. Order-detail content is WebView-owned, so handle in the
    Clinic web repository unless the native bridge itself is reproduced as the
    cause.
  - DL-16323 explicitly concerns Mobile Web button sizing and is not an app
    repository task.
- PR #286's body is operationally stale: it cites older head `c6355a3`, older
  merge/test evidence, says the two notification switches are disabled pending
  Swagger, and says Staging QA has not started. The current code already has
  generated `USER_CASE_PREFERENCE` and `ORDER_FEEDBACK` push types and active
  settings integration. Refresh the PR description before final review/merge,
  but do not confuse this documentation cleanup with a product-code defect.
- Next safe starting point: refresh personal context and app Git again, then
  process the direct app QA cards one at a time, beginning with DL-16324,
  DL-16325 and DL-16330. For each card compare the attached Jira evidence with
  the exact current Figma APP frame, apply a minimal fix, and verify iOS and
  Android where the visual/runtime issue requires it. Keep WebView-owned cards
  in the Clinic web workstream.

## DL-15828 Pre-QA Detailed Visual Audit - 2026-09-07 16:02 KST

- This is the requested independent design audit before processing the filed
  Jira QA cards. No product code, PR or Jira state was changed. Live app Git is
  clean and synchronized at `feature/DL-16061` /
  `6856bcd455c8cbcebd7fc4329cee806378822dc5`.
- The audit used the exact `dentlink-app` IDE and its visible terminals. Android
  Development ran on `Dentlink_API_36` with Metro from this checkout and the
  data-rich `e2e.clinic@dentlink.app` account. Runtime inspection covered the
  Office Profile, To Review, Reviewed, long-list scrolling, feedback detail,
  attachment picker and leave-page confirmation. No rating POST or detail PUT
  was sent because this pass was visual and non-mutating.
- Current Figma APP frames were compared for Profile, first/list/rated/reviewed
  feedback states, feedback detail and attachment/error states. Profile card
  radii, Preferences and Quick Links icons, notification rows, Pending Reviews
  entry and Safe Area behavior remain consistent with the previously accepted
  DL-16311 implementation.
- Two additional rendered-detail mismatches were independently confirmed:
  1. `FeedbackOrderCard` adds a `mono300` one-pixel outer border, while the
     current Figma card uses a white fill on the gray list background without
     that border.
  2. The feedback attachment sheet renders
     `Up to 5 files, total size up to 200MB: 200MB` because the feedback screen
     supplies a complete limit sentence and the reused chat sheet appends its
     generic `: 200MB` suffix.
- Existing filed QA observations were also reproduced or confirmed without
  fixing them: native header/tab spacing and background (DL-16324), the 16px
  tab-to-info-banner gap (DL-16325), the full spinner on a cold tab query
  (DL-16330), and API `categoryThumbnailUrl` rendering for the category-image
  report (DL-16322). WebView-owned order-detail copy/button cards remain in the
  Clinic web workstream.
- iOS was retried beyond the earlier `No script URL provided` screen. An arm64
  Simulator build reaches final linking but fails because the vendored
  `MLImage.framework` arm64 object is built for physical iOS, not
  `iOS-simulator`. The repository's intended x86_64 Simulator build succeeds,
  but the installed iOS 26.5 arm64 Simulator rejects the x86_64 app because it
  has no matching architecture. Therefore Android runtime is proven at this
  checkpoint, but iOS runtime is not; resolving that requires a compatible
  Simulator-native MLImage binary/project maintenance or a compatible runtime,
  not a DL-15828 JS/TS feature change.
- Next safe starting point: when the user explicitly asks to begin QA-card
  handling, refresh Git and source documents again, then process the direct app
  cards individually. Also triage the two independent visual mismatches above
  alongside the QA queue. Do not describe iOS Simulator runtime as verified
  until the native architecture constraint is resolved and the actual app
  screen is inspected.

## DL-15828 Pre-QA Runtime and Design Audit Completion - 2026-09-07 17:28 KST

- Revalidated the exact workspace and runtime combination at
  `/Users/parkjongsun/Repository/dentlink-app`, branch `feature/DL-16061`, HEAD
  `6856bcd455c8cbcebd7fc4329cee806378822dc5`. The branch and upstream are
  synchronized and the product worktree remains clean. No product code, PR or
  Jira mutation was made during this pass.
- Used the exact `dentlink-app` Cursor window and its visible terminals. Metro
  ran from this checkout, Android Studio stayed closed, and the
  `Dentlink_API_36` emulator was started directly. `android-office:dev` built,
  installed and launched successfully on Android 16 / API 36.
- iOS runtime is now proven for the normal JS/TS loop: the already-installed
  `Dentlink-Dev` Development app on the iPhone 17 Pro / iOS 26.5 Simulator
  connected to Metro from this feature checkout and rendered the current
  feedback screens. This does not overturn the separate fresh native-build
  architecture constraint recorded above; it proves the intended installed
  app + Metro workflow only.
- Reactotron simultaneously showed two live connections: iOS 26.5 and Android
  16. Android used `adb reverse tcp:9090 tcp:9090`; iOS connected through its
  existing local configuration. No tracked Reactotron configuration was
  changed.
- Runtime visual coverage on both platforms included Profile, notification
  rows, Quick Links / Pending Reviews, To Review, Reviewed, feedback detail and
  the Photo / Camera / File picker. Android also loaded the Clinic Order Details
  WebView. The Dev web deployment did not expose a feedback banner on the
  inspected order, so the WebView-to-native feedback click could not be
  re-proven in this environment; this is a runtime-data/deployed-web limitation,
  not evidence of an app bridge defect.
- Current Figma APP frames were rechecked. Profile layout, 12px cards,
  Preferences and Quick Links icons, notification rows and Safe Area behavior
  match the accepted implementation. No new large structural mismatch was
  found.
- Confirmed visual follow-ups before Jira QA-card handling:
  1. List cards still show a one-pixel `mono300` outer border while the current
     Figma To Review/Reviewed cards appear borderless.
  2. The attachment picker duplicates the limit suffix as
     `Up to 5 files, total size up to 200MB: 200MB`; the complete feedback
     sentence is followed by the reused chat sheet's generic suffix.
  3. Figma node `160:42255` models compact rating chips and an order-summary
     OptionCard that also contains rating actions, while the runtime detail uses
     two full-width rating buttons and a summary-only card. Treat this as a
     design-product reconciliation item before changing code because the same
     Figma node also retains the stale copy `How was this order?`, whereas the
     confirmed app/API wording is `How was your experience?`.
- Focused feedback tests passed: two suites and 18 tests. `git diff --check`
  passed. `yarn typecheck:apps` still reports the repository's known errors in
  unrelated shared files; none of those error files differs from the feature
  branch's merge base, so this audit introduced no new type error.
- Next safe starting point: when the user explicitly starts QA-card work,
  refresh Git and source documents, reconcile the detail-layout design item,
  then process direct app cards and the two confirmed minor visual defects one
  at a time. Keep the current Metro / Simulator / emulator / Reactotron setup if
  the session is still active; use CodePush and physical devices only for the
  later staging QA gate.

## DL-15828 App QA Fixes and Staging CodePush - 2026-09-07 18:29 KST

- Completed the direct app QA queue and the two confirmed pre-QA visual
  findings on `/Users/parkjongsun/Repository/dentlink-app`, branch
  `feature/DL-16061`. The remote head is
  `eab70df808b49db05801c83bffd1ba2d055b8dc6` and the worktree/upstream are
  clean and synchronized.
- Pushed two scoped commits:
  - `1460303`: feedback design and tab-transition fixes.
  - `eab70df`: feedback attachment helper-copy deduplication.
- App changes now:
  - Resolve the original category `imageUrl` from the existing catalog query by
    `categoryId` once per list/detail screen, with the purple artwork fallback.
  - Remove the Figma-absent feedback-card outer border, use the gray tab
    background, and remove only the To Review tab-to-banner top gap while
    preserving the banner-to-card spacing.
  - Keep both To Review and Reviewed infinite-query caches prepared, show the
    full loader only for initial entry, use only the selected tab's data, and
    perform later tab refreshes in the background. The existing rating overlay,
    pagination synchronization and server-canonical cache contracts remain.
  - Do not append the shared chat sheet's generic `: 200MB` suffix when the
    feedback screen already supplies its complete custom limit sentence;
    default chat behavior is unchanged.
- Verification: focused feedback suites pass 18/18; the broader non-E2E/non-App
  unit set passes 16 suites / 128 tests; changed-file ESLint, Prettier and
  `git diff --check` pass. `yarn typecheck:apps` still reports 11 diagnostics,
  all in unchanged baseline files and none in this change set.
- The package-owned command `yarn codepush-force-office:staging` ran from the
  exact `dentlink-app` Cursor terminal. Office 2.2.3 was released successfully
  to both iOS and Android Staging as mandatory enabled label `v316`; the
  standard Slack staging notification also succeeded. This proves command and
  Revopush history, not physical-device uptake or runtime QA.
- Jira child cards `DL-16321`, `DL-16322`, `DL-16324`, `DL-16325`, and
  `DL-16330` have implementation/verification comments and are all
  `Ready for Deploy`. `DL-15828` was deliberately not commented on or changed.
  The WebView-owned `DL-16321` was closed to deploy-ready based on verified web
  commit `0c7f95a64`; no duplicate native order-detail banner was added.
- PR #286 automatically points to `eab70df`; it is open, non-draft,
  mergeable/CLEAN, has successful CodeRabbit status, and has zero unresolved
  review threads. No PR-body mutation was authorized in this checkpoint.
- `origin/develop` currently points at release merge `967ba71`, which is not a
  graph ancestor of the feature head, but that merge's tree equals its
  `aa82c4c` parent already contained by this feature. There is no missing
  develop product-code delta for this CodePush; avoid a graph-only merge unless
  a later integration gate requires it.
- Remaining design reconciliation only: Figma node `160:42255` contains
  internally conflicting duplicate rating controls and stale question copy.
  It was intentionally not copied into code; keep the current server-canonical
  question/answer UI until design/product clarifies that node. The next product
  step is staging/physical-device QA and any newly filed QA cards.

### Jira QA Comment Convention Correction - 2026-09-07 18:39 KST

- The user confirmed that the web session already corrected the seven DL-15828
  child-card comments handled today. Do not repeat that Jira mutation from the
  app session.
- Going forward, a QA/development child-card comment should briefly describe
  only the implemented work and any durable verification evidence. Do not add
  time-sensitive statements such as deployment pending, not yet deployed,
  staging deployed, or a CodePush/PR deployment state.
- The card's current workflow status and live deployment evidence are the
  source of truth for deployment progress. Personal checkpoints may retain
  deployment history for recovery, but that history must not be copied into a
  normal implementation comment. The only exception is when deployment itself
  is the reported defect or the card's explicit investigation scope.
- QA comments are answers to the nondeveloper reporter rather than engineering
  changelogs. State the confirmed resolution, cite a familiar comparable app
  behavior when it helps explain the decision, and describe what the reporter
  should now see. Avoid query, cache, hook, file and pagination terminology
  unless a remaining limitation cannot be explained without it.

## DL-15828 App FE Closeout And Rating Design Resolution - 2026-09-07 18:48 KST

- Rechecked the previously unresolved feedback-detail rating design directly in
  Figma Dev Mode. Older nodes `160:42255` and `160:42284` retain both the list
  card's Bad/Good actions and the form's rating question, including a visibly
  inconsistent state where the form rating is selected while the card actions
  remain unselected.
- The adjacent, newer feedback-detail/upload state at node `160:42313` removes
  the order-card rating actions and keeps one rating question in the form. This
  resolves the apparent contradiction without a product-code change.
- The current app already follows that resolved structure:
  `FeedbackDetailsScreen` renders `FeedbackOrderSummary` as information only
  and renders the server-canonical `RATING` question once in the form. The
  Bad/Good card actions remain only in `FeedbackOrderCard` on the feedback
  list, where they belong.
- Therefore the duplicate rating controls are stale Figma-frame residue, not an
  app defect. No app source, Jira card, PR or deployment was changed during
  this reconciliation. If the design file is curated later, remove or mark the
  older duplicate-control frames as obsolete.
- Live app Git at closeout: `feature/DL-16061`, HEAD/upstream
  `eab70df808b49db05801c83bffd1ba2d055b8dc6`, clean and synchronized. The
  currently confirmed app FE scope is complete. Resume only for a newly filed
  QA defect, a confirmed API/product/design change, or the remaining normal QA
  and delivery gates.
- The user confirmed that the web session owns the cleanup of today's seven
  DL-15828 child-card comments. Do not repeat those Jira edits in the app
  session.

## DL-15828 QA Follow-up Closeout - 2026-09-08

- Live app Git is `feature/DL-16061` at
  `943a29038603f6b815477498efa0a5addb7fb3b2`, clean, synchronized with
  `origin/feature/DL-16061`, and ahead/behind `0/0`.
- Commit `943a290` (`fix: 프로필과 피드백 화면 디자인 보정`) contains
  three Office-only style corrections: Profile header-to-content spacing to
  20px, Share Feedback tab background to white, and info-banner-to-first-card
  spacing to 20px.
- PR #286 is open and non-draft with head `943a290`, target `develop`,
  `MERGEABLE/CLEAN`, and successful Auto PR Labels and CodeRabbit checks.
- Changed-file ESLint, Prettier check, `git diff --check`, and the two focused
  feedback Jest suites passed; 18/18 tests passed. Review found no functional
  or native-boundary side effect in this three-line style delta.
- The user directly ran the Office Staging CodePush and confirmed successful
  completion. This is user-confirmed publication evidence; the exact release
  labels and physical-device uptake were not independently captured in this
  checkpoint.
- Jira `DL-16352` and `DL-16353` now contain durable implementation-only
  comments and are `Ready for Deploy`. Their comments intentionally omit
  time-sensitive deployment language.
- The existing `DL-16330` comment was rewritten for its QA audience: it now
  explains that Feedback tabs follow the familiar GNB behavior, previously
  loaded content appears immediately, background refresh continues, and the
  full-screen spinner is limited to the first load. Its `READY FOR QA` status
  was left unchanged.
- `DL-16349` required no code change. The app order detail is WebView-owned and
  comparable existing web-owned actions such as patient information save,
  dentist change, order cancellation and approval already display web Toasts
  inside the app. A concise evidence-based Jira comment records that precedent,
  and the card is `Complete`.
- Computer-use text injection into the Cursor terminal dropped the `h` from
  `codepush` twice, while the repository script itself was valid and the user's
  directly entered command completed successfully. Treat this as an observed
  UI-input failure with an unconfirmed root cause, not as a Yarn or repository
  defect.
- New standing terminal rule supersedes the older IDE-terminal preference:
  Codex runs commands in a visible Codex-managed terminal rooted at the exact
  checkout, opens it only while commands are executing, and closes it after
  command work. The user manages the IDE separately; Codex must not control or
  depend on the IDE terminal.

## DL-15828 Feedback Detail Deep-Link Direct Entry - 2026-09-08

- The reported UX issue was that a feedback-detail push link visibly mounted
  the native feedback list before opening detail. This looked like an
  intermediate-screen bug and was not required by a confirmed product policy;
  the earlier list-first implementation only supplied list fallback/back
  behavior when detail loading failed.
- Commit `21ba68a80646ac4293962e1c4e2263f109a2802d`
  (`fix: 피드백 상세 딥링크 직접 진입`) is pushed to
  `feature/DL-16061`. A valid external feedback URL with `orderId` now builds
  the navigation stack as `BottomTabNavigator -> FeedbackDetailsScreen`, so
  the list is neither mounted nor shown between Home and detail.
- This applies to every valid external feedback-detail URL, not only URLs that
  already contain `landBy=push`. On Android the raw Intent URL can be handled
  before the matching FCM event adds `landBy=push`; the later FCM event is
  deduplicated and only completes analytics. Restricting direct entry to
  `landBy=push` would therefore leave the original list flash possible.
- Feedback list links still open `FeedbackListScreen`. Missing, invalid or
  non-positive detail `orderId` leaves the user on Home. The existing
  employee/employer context switch still completes before feedback navigation
  and the canonical detail query.
- Direct detail entry is identified as `entryPoint: "deep-link"`. Back, close,
  successful Submit and detail-load failure all return to Home for this entry
  context; load failure also keeps the existing error Toast. Normal
  Profile-to-list-to-detail navigation and order-detail WebView-to-native
  detail navigation retain their existing return targets and behavior.
- Focused feedback/deep-link/WebView suites pass 4 suites and 46/46 tests.
  Changed-file ESLint, Prettier and `git diff --check` pass. Office/Lab
  typecheck still reports 11 diagnostics, all in unchanged baseline files and
  none in the five changed files. An independent diff review found no defect;
  actual push lifecycle/back-stack behavior remains physical-device QA rather
  than code-level proof.
- The package-owned `yarn codepush-force-office:staging` command completed
  successfully for Office 2.2.3 on both platforms. Revopush history confirms
  mandatory enabled Staging label `v318` for both Dentlink-Office-iOS and
  Dentlink-Office-Android. The known forced-release warning remains for
  `shared/assets/videos/isv.mp4` (1.48 MiB over the 500 KiB recommendation);
  publication does not prove physical-device receipt or runtime behavior.
- No Jira or PR text mutation was part of this closeout. The session audit
  found no additional durable feedback/runtime/QA convention that was missing
  from this project checkpoint.
- After the `v318` Staging publication, the user confirmed on a deployed app
  that the changed feedback deep-link behavior works normally. This closes the
  user-owned runtime confirmation for this checkpoint. The user did not state
  a platform-by-platform evidence split, so retain the iOS/Android publication
  proof separately and do not infer separate device coverage.

## DL-16353 Header-To-Tab Follow-Up QA Closeout - 2026-09-11

- Jira follow-up comment `43967` clarified the remaining visual issue: remove
  the gap between the Share Feedback header and its tabs. The previously
  delivered white tab background and 20px info-banner-to-card spacing were
  already correct and remain unchanged.
- The remaining gap came directly from `FeedbackTabs` having
  `margin-top: 20px` while its parent screen background is gray. Commit
  `a8f3a6cbb81c218b7ab16bed8e7d4b71fab45dd7`
  (`fix: 피드백 탭 상단 간격 제거`) removes only that margin and is pushed
  to `feature/DL-16061`.
- Changed-file ESLint, Prettier and `git diff --check` pass. The app worktree
  was clean and synchronized with its upstream after the push.
- `yarn codepush-force-office:staging` published Office 2.2.3 mandatory enabled
  label `v319` to both iOS and Android Staging. The standard 1.48 MiB `isv.mp4`
  forced-release warning did not block either publication.
- The user subsequently confirmed that the deployed app reflects the corrected
  header-to-tab layout. The platform-by-platform device evidence was not
  separately stated, so preserve the two-platform publication proof and the
  user runtime confirmation as distinct facts.
- Jira was inspected but not mutated in this follow-up. Its live state was
  `CHECK REQUEST` at inspection; re-read the card before any future comment or
  workflow transition.

## Dentlink App Session Final Handoff - 2026-09-11 15:07 KST

- Live product repository verification used
  `/Users/parkjongsun/Repository/dentlink-app` after an origin fetch. The
  checkout is `feature/DL-16061` at
  `a8f3a6cbb81c218b7ab16bed8e7d4b71fab45dd7`, tracks
  `origin/feature/DL-16061`, is ahead/behind `0/0`, and has no tracked or
  untracked change. The remote branch resolves to the same commit.
- The repository has one registered worktree, the main checkout above. Local
  branches are the active feature and `main`; local `main` has no unique commit
  but is nine commits behind `origin/main`. Preserve both branches and the sole
  worktree. The feature is still open in PR #286 and is not contained by
  `develop`, `main`, or a release branch, so there is no safe cleanup target at
  this handoff.
- `origin/develop` and `origin/main` are both
  `967ba71b1f864ce581c999950dd74fbb28eff046`. The feature is 56 commits ahead
  and one release-merge commit behind `origin/develop`. That develop-only merge
  has the same tree as its already-contained parent `aa82c4c`, so the graph is
  behind without a missing product tree delta. Reconcile again at the actual
  merge gate rather than merging only to remove that graph count.
- GitHub PR #286 is open, non-draft, targets `develop`, and points to exact head
  `a8f3a6c`. GitHub reports `MERGEABLE/CLEAN`; Auto PR Labels and the current
  CodeRabbit status check pass, and all 16 review threads are resolved. There
  is no formal human approval. The latest human review is `COMMENTED`, and a
  green latest-head CodeRabbit status must not be overstated as a new formal
  full review of every commit after its last submitted review.
- The confirmed Office app scope is implemented: Profile entry/count and push
  preferences; native feedback infinite list and shared detail screen;
  immediate Good/Bad POST with current-screen presentation state; complete
  detail PUT; server-canonical questions/options; maximum five attachments and
  200 MB total using the existing upload stack; feedback analytics; employer
  switching and feedback list/detail deep links; direct detail deep-link entry;
  order-detail WebView-to-native navigation and successful-submit refresh; and
  the accepted Profile, Safe Area, icon, card, tab, loading, image, spacing and
  attachment-copy QA corrections. No confirmed in-scope app FE implementation
  remains at this handoff.
- Live Jira read-only verification: DL-16061, DL-16064, DL-16066, DL-16311,
  DL-16322, DL-16324, DL-16325, DL-16330, DL-16349, DL-16352 and DL-16362 are
  complete. DL-16229 and DL-16353 are `READY FOR QA`; DL-16353's code and user
  Staging check are complete but its Jira workflow is not closed. Parent
  DL-15828 remains in progress at 76% because it includes BE and wider QA
  scope; that is not evidence of unfinished app FE implementation. DL-16385 is
  an order-detail WebView/BE `isReviewable` contract item, not a missing native
  implementation.
- Current-HEAD code checks: six focused Jest suites pass 53/53 tests;
  branch-changed non-generated JS/TS ESLint has zero errors and 15 warnings;
  relevant non-generated Prettier checks and `git diff --check` pass. Office
  and Lab typechecks each report the same 11 known repository diagnostics in
  unchanged non-feedback files. Full-repository `yarn lint` is not a clean gate
  because it also scans generated Android assets and existing repository lint
  debt; do not misreport the focused pass as a whole-repository pass.
- Current runtime state at handoff is intentionally idle: no Metro listener,
  Reactotron listener/app, connected Android device/emulator, or booted iOS
  Simulator. The latest reusable runtime evidence remains the 2026-09-07
  current-feature Android build/install and installed iOS Development app plus
  Metro checks, with Reactotron connected on both. A fresh iOS native build
  still has the documented MLImage Simulator-architecture constraint; this
  does not block the installed-app plus Metro JS/TS loop.
- Revopush live history confirms Office 2.2.3 Staging mandatory/enabled label
  `v319` on both iOS and Android at 100% rollout. Live metrics show installs on
  both platforms. The user separately confirmed the deployed header-to-tab fix
  and previously confirmed the v318 direct-detail behavior, but did not state a
  platform-by-platform functional QA split. This proves publication, uptake,
  and user-observed behavior separately; it does not prove every mutation,
  camera/file picker, FCM lifecycle, or production runtime path.
- The feature head is not in a Git release branch, and no evidence ties this
  exact feature head to the current Production CodePush. Review/approval,
  merge, release integration and wider device QA therefore remain normal
  delivery gates rather than missing implementation.
- Next starting point for the projectless Dentlink FE management session:
  pull personal context, fetch the app repository, verify PR #286 and live Jira,
  then resume app code only for a new QA card, reviewer finding, or confirmed
  API/design/product change. For the present work, finish DL-16229 and DL-16353
  QA workflow as evidence allows, obtain app review approval, and coordinate
  merge/release without deleting `feature/DL-16061` beforehand.

## FE Handoff Acceptance And Develop Integration - 2026-09-11

- The FE top-level session accepted the final app handoff after pulling the
  clean personal-context `main` at `7eb5368` and reading this checkpoint and
  `projects/dentlink-fe.md`.
- Live verification found a change after the 15:07 handoff: PR
  [#286](https://github.com/Innvoaid/dentlink-app/pull/286) was merged by
  `jongsunP` at 15:09:46 KST. Its squash commit is
  `c205fe0752e06c17866bc3873c94a5b6e2e492c2`; a direct tree diff against
  `a8f3a6cbb81c218b7ab16bed8e7d4b71fab45dd7` is empty. The original feature
  SHA is not an ancestor of develop because of squash integration, not because
  its product changes were omitted.
- After fetch, both the tracking ref and live remote `develop` resolve to
  `f75d7d9b27a3bb32e69726dd6e6f8792c756a710`, which also contains subsequent
  PR #295. `main` and `release/office/v2.2.3` remain at
  `967ba71b1f864ce581c999950dd74fbb28eff046`; release and Production inclusion
  are not established by the develop merge.
- The local feature checkout remains clean, synchronized with its feature
  upstream at `0/0`, and is the sole worktree. No product file, local branch,
  worktree, PR, Jira issue, or deployment was changed by the accepting session.
  Cleanup still requires an explicit user request and fresh preservation and
  ownership checks; new work must not reuse the completed feature branch.
- All 16 CodeRabbit threads remain resolved. No formal human `APPROVED`
  review is recorded; PR merge and formal approval are separate facts.
- Live Jira rechecks confirm DL-16061 is complete, while DL-16229 and DL-16353
  remain `READY FOR QA`. The other implementation, test, Staging publication,
  installation and runtime evidence is accepted from the final handoff above;
  it was not rerun during acceptance.
- Next work is the remaining QA workflow, release/Production coordination,
  or a newly confirmed defect or requirement. Use the feature-based session
  model in the common guidance, retaining separate Git boundaries for web/app.

## Native E2E Inventory Audit - 2026-09-11

- Read-only inspection at clean `feature/DL-16061` / `a8f3a6c` found Detox in
  five files with 21 test declarations: Profile 5, order list 2, ISV order 6,
  LinkTalk 5, Support 3. Office iOS/Android configurations exist; dedicated
  feedback native UI E2E and Lab build configurations do not.
- Feedback repository tests mock HTTP; deep-link tests inspect returned routes
  rather than executing native screens. The handoff's six suites / 53 tests
  are Jest code-level proof, not a native E2E pass.
- Static Detox mismatch: Android development commands select
  `android.dev.debug`, but configurations define `android.att.dev.debug`.
  Emulator configurations also reference absent `android.debug` and
  `android.release` app entries. Current successful execution is not established.
- Tracked workflows do not run Jest/Detox. Existing root/package Jest config
  overlap and historical App/Detox worker failures remain separate from the
  focused feedback results. No tests, builds or devices were run in this audit;
  product files were unchanged. Repairs/new E2E require their own work scope.
