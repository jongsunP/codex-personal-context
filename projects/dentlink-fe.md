# Dentlink Frontend Coordination

웹·관리자, 치과 앱, 기공소 앱을 조율하는 최상위 개인 체크포인트입니다.
상세 구현·SHA·PR·QA·배포 증거는 각 담당 문서를 정본으로 사용합니다.
업무 색인은 **2026-10-27 개인 문서 대조 결과**이며, 별도로 명시한 배포 기준 실조회 기록과 구분합니다.

## DL-17138 치과 지연 라벨 구현·전달 진행 — 2026-11-05

- **사용자 승인:** 아래 범위 구현을 승인했고 웹은 release/v1.92.0 대상 PR까지, 치과앱은 PR 및 iOS·Android **Staging CodePush**까지 요청했다. 배포 환경은 추가 답변으로 확정했다. PR merge·Production·스토어 출시는 포함하지 않는다. 다른 IDE/로컬 실행 환경은 이번 작업에서 제외한다.
- **제품별 카드/세션:** 기존 [웹 DL-17141](https://innovaid.atlassian.net/browse/DL-17141)의 제목·본문을 정리하고 [치과앱 DL-17248](https://innovaid.atlassian.net/browse/DL-17248)을 같은 부모 아래 Frankie 담당 하위 카드로 생성했다. 부모 댓글은 작성하지 않았다. 같은 메인 프로젝트/local Mac에 웹 `01a1aa21-0ebc-75c0-9791-e5b21e524224`, 앱 `01a1aa21-103b-7e82-b530-9b203c18cfe9` 세션을 생성했으며 등록·초기 실행·실제 gpt-6-astra/ultra 설정을 확인했다. 웹은 기존 checkout의 feat/DL-17141, 앱은 main 기반 임시 worktree의 feat/DL-17248로 준비하도록 맡겼다. 실제 생성 결과·검증·PR·CodePush는 각 세션에서 확인 후 종합한다.

- [상위 DL-17138](https://innovaid.atlassian.net/browse/DL-17138), Frankie 담당 [하위 DL-17141](https://innovaid.atlassian.net/browse/DL-17141)의 본문 및 모든 댓글을 현재 Atlassian 연결로 읽었다. 확정 기준은 Frankie 댓글44828: **치과 웹·앱에서 지연 true + 완료/취소 주문의 라벨을 숨긴다.** 실제 코드 필드/enum은 `isDelayed`, `COMPLETED`, `CANCELED`다. 기공소는 대상이 아니며 기존 정상/진행 중 표시나 날짜·상태값 자체를 바꾸지 않는다. 사용자 요청은 먼저 이해·브리핑 후 승인이다. 제품/Jira/브랜치/작업 세션 생성은 아직 하지 않았다.
- 코드 대조: 웹 최신 master c5a4b5e37 및 release/v1.92.0 05243d50c의 PC/모바일 주문목록은 이미 완료·취소에서 badge를 표시하지 않는다. 공통 주문상세 `OrderDetailBoxDeliverySchedule`는 날짜 조건만으로 표시하므로 OFFICE에 한정해 요구 조건을 추가할 대상이다. Office 앱 main7f586790e/release/v2.2.4 ed1d03fa의 `OrderStatusBadge`는 완료 제외가 없어 홈 Track Your Order·주문목록이 영향 대상이다. 취소는 두 호출부에서 이미 제외된다. 앱 주문상세는 웹 `/orders/{id}` WebView로 웹 수정을 소비한다.
- 작업 배치 제안: 승인 후 현재 메인 프로젝트 폴더에 웹·치과앱 세션을 각각 분리한다. 웹 기본 checkout은 기존 E2E 세션 마감 후 clean이므로 재사용 가능하며 신규 작업은 최신 origin/master 기반이다. 앱 기본 checkout은 통합알림센터 `feature/DL-17059@09a777ad9`·clean/upstream동일·worktree1개이므로 별도 임시 worktree를 최신 origin/main에서 준비한다. 기존 하위 카드와 별도 Office 카드로 제품 범위를 구분하며 빈 Lab 카드는 만들지 않는다. 아직 카드 분리·branch/worktree 준비 권한을 실행한 것이 아니다.
- 다음: 최종 코드로 완료/취소/진행 중 × 지연/정상, 웹 PC/모바일 상세·기존 목록, 앱 홈/목록·상세 WebView 진입/복귀 및 영향 권한을 검증한다. 앱은 에이전트 시뮬레이터/에뮬레이터 선검증 후 사용자 QA 목록을 전달한다. 웹 PR·앱 PR/Staging CodePush 결과를 메인에서 종합하며, 검증·merge·환경 반영을 구분한다. 아래 접수 당시 승인 대기 문구는 위 최신 승인으로 대체됐다.

## v1.92.0 스테이징 병합·사용자 배포 보고 후 마감 — 2026-11-05

- **완료:** 원격 stage 삭제 → 최신 master에서 재생성 → [PR #4833 release/v1.92.0 → stage](https://github.com/Innvoaid/dentlink-client/pull/4833) 준비 후 사용자가 직접 머지·배포했다고 보고하고 정리·대기를 지시했다. GitHub에서 13:53:20 KST merged:true, merge `aa01dd4d6bb354b8d8bab28daf62cb2f80a67b3d`를 확인했다. 준비 당시 실제 diff·서비스별 배포 조건·병합 결과=릴리즈 tree를 검증했다. 상세 SHA·복구 참조·가드 근거는 [E2E 정본](dentlink-client-e2e.md)에 기록한다.
- **현재 영향:** v1.92.0과 E2E 분리 변경의 stage 통합은 확인됐으며 배포는 사용자 완료 보고로 기록한다. 이번 마감에서는 Actions 최종 결과·실제 서빙 BUILD_ID·독립 E2E 실행/성공을 별도 조회하지 않았다. 사용자 배포 보고를 E2E 통과나 런타임 연결 검증 완료로 확대하지 않는다.
- **세션 마감:** `웹 배포·E2E 결과 분리` 담당 세션은 개인 정본을 5919c6f로 저장·푸시하고 마감했다. 메인이 `01a1a9c1-bd30-7de3-963d-b548000fa550`의 보관 완료를 도구 응답으로 확인했다. 메인세션은 유지하며 원본 작업 브랜치·checkout은 보존했다.
- **마감/재개점:** 개인 기록을 commit/push하고 메인세션은 보관하지 않은 채 대기한다. 이번 요청의 정리는 완료이며 추가 조회·수정·배포·브랜치 삭제·자동 감시를 시작하지 않는다. 추후 결과 확인 요청 시 위 merge SHA의 서비스별 배포와 부모 run/attempt·BUILD_ID에 연결된 독립 E2E 결과부터 대조한다. DEV 전파·운영 배포는 이번 완료 범위가 아니다.

## 웹 배포·E2E 결과 분리 master·v1.92.0 병합 완료 — 2026-11-05

- **완료:** 최종 소스 `feat/e2e-deploy-status@65dd71ddf`의 [PR #4831 → master](https://github.com/Innvoaid/dentlink-client/pull/4831), [PR #4832 → release/v1.92.0](https://github.com/Innvoaid/dentlink-client/pull/4832)를 사용자가 순서대로 머지했다. 메인에서 GitHub API의 merged:true 및 13:43:44 → 13:44:07 KST 순서를 확인했다.
- **현재 영향/검증:** 기본 브랜치의 독립 E2E 수신 workflow와 v1.92.0의 배포/E2E 분리 코드 통합이 완료됐다. 새 버전 반영 확인과 E2E 실패 판정은 유지한다. 기존 검증은 브라우저 없는 회귀 247/247, 후속 알림 보완 관련 14/14, 타입·actionlint·Prettier·정상 Git hook·독립 리뷰 통과다. 실제 배포·실계정 E2E·GitHub 자동 연결/부분 재실행은 미검증이다.
- **남은 일:** 승인된 release의 stage 전파·배포 후 독립 E2E 연결을 확인한다. DEV 적용은 develop 전파도 별도로 필요하다. 이번 병합 보고로 배포/테스트·브랜치 정리·추가 감시를 시작하지 않으며 기록만 갱신한다. 상세 merge SHA·증거·재개점은 [E2E 정본](dentlink-client-e2e.md)에 기록했다.

- [Slack 요청](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793846894550259): 배포가 성공했는데 E2E 실패 때문에 배포 실행까지 실패로 보이는 혼동을 없앤다. [실행41950270234](https://github.com/Innvoaid/dentlink-client/actions/runs/41950270234)는 빌드·서울/오하이오 배포·롤백 방지·새 버전 반영 확인이 성공했고 E2E와 최종 gate만 실패했다. 기능 검증 성공으로 해석하지 않는다.
- 사용자 승인: 최신 `origin/master` 기반 신규 브랜치에서 구현·검증·커밋·푸시 후 **master 대상 PR**까지 진행한다. 별도 질문에 master 대상을 명시 확인했으며 merge·배포·실계정 테스트 재실행·CodeRabbit 대응은 포함하지 않는다.
- 같은 메인 프로젝트·기존 Mac에 **웹 배포·E2E 결과 분리** 세션 `01a1a9c1-bd30-7de3-963d-b548000fa550`을 생성했다. 프로젝트 등록·초기 작업 시작·실제 `gpt-6-astra / ultra` 적용을 확인했다. 새 폴더/worktree 없이 clean인 `/Users/parkjongsun/Repository/dentlink-client`를 맡겼으며 기존 `feature/DL-17125`는 보존했다. `feat/e2e-deploy-status`를 착수 기준 origin/master `5452871ea`에서 생성한 결과도 확인했다.
- 배포 성공과 독립 E2E 실패를 구분하며 기존 실패 판정·리포트·Slack·동시성 및 배포 SHA/BUILD_ID 검증을 보존했다. 메인세션은 코드 작성 없이 인계·독립 리뷰·최종 결과 확인을 맡았다.

## 브랜치명·스토리포인트 지침 갱신 — 2026-11-04

- Slack [브랜치 공지](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793765529562549), [Frankie의 범위 질문](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793765593806349), 채널 후속 [Tom의 확인](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793765642512149)을 읽었다. 신규 작업 브랜치는 Dentlink Web/Admin·Office·Lab 모두 **`feat/<Jira>`**를 사용한다. PR 제목 prefix 변경은 아니며 기존 feature 브랜치/PR과 역사적 이름은 보존한다. 13:15의 “길어서요”는 브랜치명 축약 이유이지 스토리포인트 산정 비판의 근거가 아니다.
- [스토리포인트 피드백](https://innovaidhq.slack.com/archives/C09613TBE5A/p1793765218878199)은 AI 카드 생성 자체는 괜찮지만 점수 점검이 필요하다는 내용이다. 특정 업무·수치·과다 산정 이유는 언급하지 않았다. 통합알림센터일 가능성은 사용자 추측으로 구분한다.
- 공통 정본 `DEVELOPMENT_STYLE.md`의 명명/산정 규칙과 `AGENTS.md`, `SESSION_WORKFLOW.md`, `AI_WORKFLOW.md`, 앱 온보딩의 현행 예시를 맞췄다. **1SP=6시간 유지**, AI 점수는 초안, 카드별 실제 시간·재사용/완료분·중복 버퍼·AI 활용 근거 검토, 공수/병행 일정 구분, 사용자 검토 및 Jira 쓰기 권한을 명확히 한다. 카드 분할 시 합계 보존과 근거가 바뀐 재산정을 구분한다.
- 이후 사용자 요청으로 통합알림센터의 실제 Jira 13개·공통 설계·상위 일정 댓글과 과거 산정 과정을 읽기 전용 대조했다. 31SP 합산은 맞고 재사용도 반영됐지만, 1명+Codex의 13작업일로 연결하는 공수 단위·병행 근거, 카드별 시간의 검증 근거, QA 차감 후 필수 개발 검증 배분이 약했다. 이것이 Tom의 실제 의도이거나 31SP가 명백히 과다하다고 확정하지 않는다. 상세는 [통합알림센터 정본](dentlink-unified-notification-center.md)에 기록했다.
- **사용자 최종 지시/마감:** 원문과 기존 Jira 점수는 유지하고 오늘 확인한 내용을 앞으로의 공통 지침에 반영한다. SP/사람 투입시간/경과 일정의 단위 일치, 최장 제품 기간만 사용하는 병행 계산 금지 조건, 별도QA 제외 시 필수 개발 검증 공수 보존을 보완했다. 개인 기록 저장·동기화 후 메인세션은 보관하지 않고 대기하며, 기존 추정치 재작성·원문 수정·제품 변경·추가 조사나 재산정을 자동으로 시작하지 않는다.

## 알림센터·추가 앱 목록·이메일 범위 분리 — 2026-11-03

- 사용자 확정: [통합알림센터](dentlink-unified-notification-center.md)는 웹/앱 알림함·설정, 노티/푸시 클릭 처리와 합의한 추가 앱 목록(DL-17202)을 담당한다. 추가 목록은 전용 메뉴 없이 노티·푸시 진입만으로 진행하며 메뉴 개선은 후속이다.
- 이메일 CTA·설치 여부 연결·SES·이메일 분석은 DL-17183/17187과 [별도 이메일 정본](dentlink-email-cta-tracking.md)에 분리한다. 알림센터의 검토·개발·검증·완료 조건에 포함하지 않는다.
- 작업 개념별로 원 앱 미지원 조사·앱 추가 항목·이메일을 같은 상위 위치로 분류했다. 앱 추가 항목은 기존 단일 문서를 직접 두고 이메일은 대문 아래 자료 3개를 묶는다. 불필요한 중간 대문·획일적 규격을 만들지 않고 본문·공유 링크를 유지한다. 기존 공통 코드와 이메일 전용 변경이 같은 feature에 남아 있으므로 문서 정리를 제품 코드 분리/배포 완료로 해석하지 않는다. 상세 이력은 각 기능 정본을 따른다.

## v1.91.0 + LBX 스테이징 반영·Admin 배포 시작 — 2026-10-30

- **마감:** 사용자가 배포 진행과 기존 Admin 취소 → LBX만 스쿼시 머지 → 새 Admin 배포 순서를 확인하고 정리·대기를 지시했다. 개인 기록을 정리해 요청 처리를 마감한다. 추가 결과 조회·감시·QA·제품 변경 없이 메인세션을 보관하지 않고 대기하며, 최종 배포 성공을 확인한 것으로 기록하지 않는다.
- 아래 준비한 [PR #4810](https://github.com/Innvoaid/dentlink-client/pull/4810)은 사용자가 **16:41:47 KST 병합**했다. release/v1.91.0 코드가 stage에 반영됐고 서비스별 배포가 시작됐다. 이후 사용자가 **어드민 배포만 취소하고 LBX를 재추가한 코드로 어드민 배포**를 명시했다.
- 기존 Admin run `41021662707`은 `completed/cancelled` 확인 완료. LBX 원본을 그대로 사용한 [PR #4811](https://github.com/Innvoaid/dentlink-client/pull/4811)을 생성·검사 후 병합했다. 현재 stage `155acfbfe3c301727c4b5c25380e6ae05e9e0b99`는 **v1.91.0 + 기존 LBX만 포함**하며 예상 tree와 일치한다. release/master/LBX 원본은 유지하고 Clinic/Lab 배포는 취소·재실행하지 않았다.
- **Admin 새 배포:** [run 41022675810](https://github.com/Innvoaid/dentlink-client/actions/runs/41022675810), **16:51:42 KST 시작**, source SHA는 위 stage와 같다. 시작 시 `in_progress`이며 최종 성공·실제 서비스 반영·QA 완료는 아직 확인하지 않았다. 결과 확인 가능 시각은 17:06:42 KST 이후다.
- 상세 증거·배포 재개점은 [LBX 정본](dentlink-client-lbx.md)의 최신 체크포인트에 기록했다. LBX 추가분 가드는 `NO_IMPACT`지만 아래 릴리스 전체 `NEEDS_RUN`은 유지한다. LBX 운영 릴리스 홀드도 유지한다.

## 앞선 v1.91.0 스테이징 PR 준비 — 2026-10-30

- 사용자 목적은 **11월 2일 월요일 운영 배포 예정인 release/v1.91.0을 먼저 스테이징에 반영**하는 것이다. 이후 필요하면 LBX만 별도 추가한다. 마지막으로 사용자가 말한 배포 프로세스를 `원격 stage 삭제 → 최신 master에서 stage 재생성 → release PR`로 명확히 했으므로 이번 실행은 PR 준비에서 멈췄다.
- 원격 master `57bb759ca08e3752140ceffdae2a5421934ec242`, release/v1.91.0 `4dd8f4097bde14838c2fab5b8a706c0609d4fc84`, 이전 stage `dcc32cd5dc73cc32c8118ce5bf8729f0b4c7c9ba`를 실조회했다. stage 보호·유효 ruleset·열린 base/head PR은 없었다. 이전 stage를 로컬 `refs/recovery/stage-before-v1.91.0-20261030`에 보존하고 SHA lease로 삭제, nonexistence lease로 정확한 master에서 재생성했다. 원격 stage=master를 확인했으며 로컬 feature/DL-17125@e8e15ed66·clean은 유지했다.
- [PR #4810](https://github.com/Innvoaid/dentlink-client/pull/4810) **release/v1.91.0 → stage** 생성·세션 첨부 완료. 실제 base/head SHA와 6커밋·54파일(+2750/-83), 전체 경로 일치를 확인했다. 충돌 없이 예상 병합 트리 `6715064b3d96d24417b5dba281e35faab45dfb9c`가 release 트리와 같다. PR은 OPEN·일반 PR·미병합이며 생성 직후 CodeRabbit/add-reviews 성공, guard 진행 중으로 최종 CI 통과를 선언하지 않는다.
- 기존 stage의 master 대비 차이는 LBX PR4804였다. 이번 릴리스에는 해당 변경이 없고 사용자도 후속 별도 반영을 명확히 했다. LBX 원본 branch/worktree는 변경하지 않았으며 자동 재추가하지 않는다.
- 저장소 E2E 가드의 전체 릴리스 정적 판정은 **NEEDS_RUN**으로 기록하고 PR 생성 전 check를 통과했다. 확정 파손은 발견하지 못했으나 출고일 수정으로 `04_labShipment`의 첫 valid 날짜가 오늘로 바뀔 수 있어 실행 검증이 필요하다. 05 상태 전환·08 피드백도 공통 모달 회귀 후보다. 별도 E2E 실행/수정은 하지 않았다. 정상 push hook 성공은 현 checkout 검사이며 release 전체 런타임 검증과 구분한다.
- **남은 일:** 사용자 병합/배포 지시 후 최신 PR·release·stage를 재확인하고 Clinic/Lab/Admin 배포 및 전체 STG E2E·QA를 각각 확인한다. 서비스별 변경 경로는 이번 diff에 모두 포함됐고 workflow 변경은 없다. stage 재생성 직후 조회에는 새 push 배포 실행이 없었지만 이후 실행 여부·서비스 반영까지 확인한 것은 아니다. 이번 PR 병합·workflow dispatch·LBX 반영·배포 결과 감시는 수행하지 않았다.

## DL-17124 / DL-17125 출고 예정일 수정 인계 — 2026-10-30

- 사용자 승인: 상위 [DL-17124](https://innovaid.atlassian.net/browse/DL-17124)의 기존 Frankie 하위 [DL-17125](https://innovaid.atlassian.net/browse/DL-17125)를 재사용해 제목·본문을 정리하고 구현·검증한다. 접수 당시 하위 제목은 `[Bug] d`, 본문·댓글 없음이었다. 상위 댓글 4개를 확인했으며 과거 출고 예정일 선택은 의도된 동작이 아니고 FE 수정 대상이다. 제작 단계별 알림·치과 노출 정책 변경은 범위에 넣지 않는다.
- **DL-17125 기공소 출고 예정일 수정** 세션(`01a18af5-8028-71b1-a8ce-83ee0aadfee0`)을 메인 프로젝트 폴더·Mac local에 생성했다. 프로젝트 등록·초기 작업 시작·메인과 같은 `gpt-6-astra / ultra` 적용을 확인했다.
- 기공소 웹의 작은 수정으로 분류했다. 기본 `/Users/parkjongsun/Repository/dentlink-client`는 접수 시 master@57bb759ca·clean이며 다른 작업은 별도 worktree에 있다. 새 폴더/worktree 없이 이 checkout에서 최신 원격과 소유권을 재확인하고 `feature/DL-17125`로 준비하도록 인계했다. 아직 branch 준비·카드 수정·구현 완료의 증거는 아니다.
- 담당 세션은 첨부·입력 경로·날짜 제약을 확인해 하위 카드 정리 → 최소 수정 → 실제 화면 및 관련 검증을 진행한다. 로컬 env 상속은 공통 지침을 따른다. 결과는 해당 세션에서 사용자에게 보고하며 제품 commit/push/PR/merge/배포는 별도 지시를 기다린다.

## 공유기공소·밀링센터 세션 준비 — 2026-10-29

- **릴리스 병합·마감(2026-10-30):** 원본 `feature/DL-17101@a7aa540a2`의 [PR4817](https://github.com/Innvoaid/dentlink-client/pull/4817)이19:39:37 KST `release/v1.91.0`에 병합됐다(merge `1d99edfdeba28d9aaa23e3a904c3b1c43495a67d`, GitHub 조회 및 사용자 확인). 개발/스테이징으로의 릴리스 통합·배포는 사용자가 직접 진행한다. 에이전트의 추가 구현/PR/병합/배포/감시는 없고 이번 릴리스의 배포 결과는 미확인이다. 원본·기존 배포 브랜치/worktree를 보존하고 후속 피드백까지 대기한다. Jira는 이번 마감에 변경하지 않았다.
- **릴리스 전달 이력(2026-10-30):** 사용자가 개발배포용과 분리해 원본 기준 release/v1.91.0 PR을 요청했다. `feature/DL-17101@a7aa540a2` → `release/v1.91.0@ffd4f05c8` PR4817을 생성했다. 원본5커밋/32파일만 포함, merge결과 기능파일=원본, E2E NO_IMPACT mark/check 통과. 추가코드/브랜치/서버 없이 하위댓글44751을 남겼으며 상태 Ready for Deploy·Fix Version·상위는 변경하지 않았다. 이 준비 당시 미병합 상태는 위 병합 확인으로 대체됐다.
- **최종 배포 확인(2026-10-30):** PR4805 merge80411ee78의 Lab DEV [배포run40999077849](https://github.com/Innvoaid/dentlink-client/actions/runs/40999077849)가12:53:04 KST success, Docker build/push와 ECS deploy 단계도 success임을 사용자 요청으로 확인했다. 최종 패치 후 제품 변경/열린 관련PR이 없어 추가PR은 필요 없다. 실물 프린터/전체QA/staging·운영은 별도이며 사용자 요청대로 메모리 정리 후 추가작업·감시 없이 대기한다. 아래 배포미확인은 이 확인 이전 이력이다.
- **검토 종료(2026-10-30):** 모델 변경 후 최종 출력 구성을 읽기 전용 재검토했고 신규 회귀 finding 없음·120tests 재통과·원본/배포 패치동일을 확인했다. PR4805는12:44:42 KST develop 병합(80411ee78)을 실조회했으며 배포 성공은 미확인이다. 사용자는 기존 단건/일괄 수출코드 문구 차이도 그대로 두고 병합·배포를 직접 진행한다고 확정했다. 제품/Jira/PR 추가 변경 없이 기록 정리 후 대기한다. 두전용worktree clean·보존, 메인worktree의 다른3005서버는 종료하지 않았다.
- **최신 변경(2026-10-30):** 사용자가 최종 범위를 공통 라벨·스티커 + INTERNAL 부착용 추가로 바꾸고 구현·개발용PR을 승인했다. 신규 설정 패널/미리보기는 부착용에만 유지한다. 원본 `feature/DL-17101@a7aa540a2`와 별도 `feature/DL-17101-common-print-develop@46bb74fd6`를 푸시하고 [PR4805](https://github.com/Innvoaid/dentlink-client/pull/4805) 하나를 develop 대상 OPEN·미병합으로 준비했다. 양쪽120tests/타입/정상훅·원본Chrome 부착용2건2장/공통2건4장·상세스티커 확인, 하위설명/댓글44725 갱신·Ready for Deploy 유지·상위무변경. 검증서버/탭종료, 브랜치/worktree보존. 아래3종 분리/유지결정은 이전 이력이며 [전용 최신 체크포인트](dentlink-lab-shipping-print.md)가 우선한다.
- 후속 논의 종료(2026-10-30): 설정 패널·미리보기 공통 적용은 검토만 하고 보류했다. 일반적인 출력 UX 사례와 이번 요구를 대조한 뒤 사용자가 **추가 수정 없이 현재 구현 유지, 실제 프린터 확인 후 문제 전달**로 확정했다. 프리셋/고급 설정은 선택 후보이며 필수 후속 작업이 아니다. 실물 출력 검증은 미완료로 구분하고 추가 요청까지 대기한다. 제품/Jira/PR 변경 없이 [전용 체크포인트](dentlink-lab-shipping-print.md)에 근거·영향·재개점을 보존했다.
- 최종 정리(2026-10-30): DL-17101 사용자 로컬 확인 완료, PR #4802 develop 병합(61da80eae) 확인 후 작업 종료. 로컬3005 서버를 종료했고 원본/배포용 브랜치·worktree는 보존했다. 하위 Ready for Deploy 상태는 임의 변경 없이 사용자 확인/종료 댓글44710 추가. 배포 결과·실물 인쇄·번역 시트는 별도 후속이며 자동 재개/감시 없음.
- 사용자가 질문을 별도 세션에서 이어가기 위해 **공유기공소·밀링센터 세션**(`01a18682-0535-7aa3-9d30-9440b0b90a01`)을 요청했다. 기존 메인 프로젝트 폴더·Mac `local` 호스트에 정상 등록했으며 메인과 같은 `gpt-6-astra / ultra` 적용 및 초기 지침 읽기 시작을 확인했다.
- 기본 지침·제품 저장소 분리·검증 및 승인 경계·기공소 번역/i18n·개인 컨텍스트 관리 방법을 전달했다. 별도 프로젝트/worktree/branch는 만들지 않았다. 초기 등록 기록은 메인에서 저장하며 휴대폰 표시 자체를 확인한 것은 아니다.
- DL-17101 출력 분리 PR4801은 사용자 배포 전달을 받았다. 후속3종 독립 설정·용지·정렬·실시간 미리보기·새 창 확대는 원본 `feature/DL-17101@3132e836f`, 배포 `feature/DL-17101-print-settings-develop@9e64614a8`에 커밋·푸시했고 [PR #4802](https://github.com/Innvoaid/dentlink-client/pull/4802) 하나를 갱신한 뒤 사용자가 로컬 확인을 마쳤다. PR4802 develop 병합을 실조회하고 실행 작업을 종료했다. 형식별 저장/취소·회전·3종각1건1장/2건2장 native 미리보기, 타입/82tests/양쪽push훅 통과. 실물 인쇄·운영 번역 시트는 남았다. 하위 설명/댓글44709·44710만 갱신, 상위DL-17099 무변경. [전용 체크포인트](dentlink-lab-shipping-print.md)가 정본이다.
- 원본 워크트리 `/Users/parkjongsun/Repository/dentlink-client-dl-17101`과 원본 브랜치를 함께 유지한다. 메인은master clean, 기존배포브랜치도보존했다. 사용자 명시 승인으로 새세션/워크트리의 로컬준비는 메인의 해당서비스 env를 값조회 없이 그대로 상속하며, 이번Lab에 적용해3005서버를 원본경로에서 실행했으며 사용자 최종확인 후 종료했다.

## DL-14899 헬프센터 News 수정·스테이징 및 웹뷰 사용자 확인 완료·대기 — 2026-10-30

- **최종 판단/대기 지시:** 사용자가 스테이징 배포 후 모바일 모드·새로고침 조건에서 상용과 배포된 스테이징의 차이를 확인했다고 전달했고, 처리 완료로 정리·대기를 요청했다. 이어 사용자 관찰뿐 아니라 에이전트도 마감에 동의하는지 확인했다. 기존 운영 재현(CSS 누락과 화면 밖 카드), 한 줄 수정, Clinic·Lab 로컬 표시 확인, 이번 사용자 비교 결과가 일치하므로 **이번 News 미노출 수정 범위는 마감 가능**하다고 판단했다. 확인한 범위에 추가 수정이 필요한 문제는 발견되지 않았다. 아래 미검증 항목을 전체 QA 완료로 바꾸지는 않는다. 사용자 재개 지시 전 추가 구현·검증·리뷰 조회·병합·배포·브랜치 정리·감시를 자동 실행하지 않는다.
- **웹뷰 추가 확인:** 마감 중 사용자가 "내가 웹뷰도 방금 확인했어"라고 전달했다. 이번 News 미노출 건의 웹뷰 사용자 확인 완료로 반영하고 완료·대기 판단을 유지한다. 제품(Office/Lab), OS, 세부 조작은 특정하지 않았으므로 양쪽 앱·모든 OS·좌우 스와이프 전체 검증 완료로 확대하지 않는다. 아래 에이전트 검증 제한은 사용자 웹뷰 확인과 구분한 이력이다.
- **최신 전달 상태:** [PR #4806](https://github.com/Innvoaid/dentlink-client/pull/4806)은 GitHub 현재 커넥터 조회에서 **MERGED**, base `release/v1.91.0`, merge SHA `cd75b97a9a8aac8aff08f9854f14116b032d3c22`, 병합 시각 2026-10-30 16:19 KST를 확인했다. 갱신한 `origin/stage@155acfbfe`에도 `swiper/css` import가 포함돼 있다. 스테이징 배포와 수정 전후 차이는 사용자 확인이며, 에이전트가 스테이징 모바일 화면이나 배포 Actions 성공을 독립 검증했다는 뜻은 아니다. 상용 반영 완료는 주장하지 않는다. 아래 OPEN·PR 유지 기록은 이 병합 전 이력이다.
- **재현 조건 재확인:** 사용자가 처음에는 PC 브라우저 창 너비만 줄여 상용과 차이가 없다고 보았다. 현재 코드의 `react-device-detect.isMobile` 분기는 너비만으로 바뀌지 않으며, 모바일 기기 모드로 전환한 뒤 새로고침해야 모바일 슬라이더가 적용됨을 설명했다. 이후 사용자가 해당 조건에서 상용과 스테이징의 차이가 보인다고 확인했다. 이번 변경은 카드 디자인·내용 변경이 아니라 모바일 슬라이더 기본 CSS 누락 보완이다. 이번 후속 조사에서 제품 코드·PR·Jira를 변경하거나 로컬 서버를 재시작하지 않았다.
- **사용자 승인/완료 범위:** 10/29 사전조사·저장 후 대기에서, 10/30 사용자가 브랜치 생성·구현·커밋·푸시·PR과 대상 `release/v1.91.0`을 명시 승인했다. 이어 이번 작은 변경의 별도 화면 검증은 생략하고 본인이 확인하겠다고 명시했다. 이는 이번 작업의 검증 범위 조정이며 다른 앱 작업의 검증 원칙을 완화하는 일반 규칙은 아니다.
- **구현/전달:** 최신 `origin/master@57bb759ca`에서 `feature/DL-14899`를 생성하고 `/Users/parkjongsun/Repository/dentlink-client-dl-14899`에 분리했다. 메인 checkout의 다른 활성 세션 `feature/DL-17125`는 보존했다. `shared/ui/src/HelpCenterUI/Main/ThumbnailListSwiper.tsx`에 `import "swiper/css";` 한 줄 추가. 커밋 `6996623ddfe7d558c479aae1cde61bfd1de11da2`, [PR #4806](https://github.com/Innvoaid/dentlink-client/pull/4806) OPEN/일반 PR, base `release/v1.91.0`, head `feature/DL-14899`, 변경 1파일/+1줄을 실조회했다. 로컬 clean·원격 0/0. 앱 네이티브·API·카드 동작은 변경하지 않았다.
- **검증/로컬 준비:** Clinic·Lab·Admin 타입 및 커밋/푸시 훅 통과. 기존 lint warning은 남음. 훅의 Admin DLOS 9개, 공용 config 21개·hook 32개 테스트 통과. 새 worktree의 Next 타입 선언을 정상 생성했으며, 최초 push는 로컬 coverage baseline 부재로 중단되어 메인 worktree의 기존 ignored 기준 파일을 그대로 상속하고 재실행했다(기준 재작성·훅 우회 없음, 커버리지 개선 주장 아님). E2E 영향 가드 `NO_IMPACT`, 기존 결제·배너·팝업은 동일 CSS를 이미 로드함을 대조. E2E 파일 변경·실제 E2E 실행 없음.
- **10/30 추가 코드 점검:** 사용자가 수정 확인 후 다른 사용처의 import 누락 조사를 요청했다. web Clinic·Lab·Admin·shared 및 최신 master/release의 Swiper 직접 사용 5곳을 대조했다. 이번 ThumbnailListSwiper 외 공용 배너·팝업과 Clinic 결제 슬라이더 2곳에는 기본/필요 pagination CSS가 이미 있다. 추가 코드 수정 없음. 이는 CSS 누락 감사이며 모든 화면 기능의 무결함 선언은 아니다.
- **10/30 로컬 재검증:** 사용자가 이후 로컬 실행 확인을 명시 요청해 앞선 화면 검증 생략을 이번 범위에서 재개했다. 사용자 직접 로그인 후 exact SHA `6996623dd`의 Clinic 3210·Lab 3215에서 Chrome iPhone SE(375×667, 모바일 UA)로 `/help` 직접 진입·새로고침을 확인했다. News는 Clinic 4개, Lab 3개가 DOM에 있으며 두 `.swiper-wrapper` 모두 `display:flex`, 카드 영역 높이 191px로 실제 가운데 카드가 표시된다. Clinic `/help/articles/55`, Lab `/help/articles/44` 상세 연결도 관찰했다. 데스크톱 모드로 복귀·새로고침 후 목록 표시도 유지된다.
- **에이전트 검증 제한:** 좌우 스와이프는 자동 입력의 timeout/클릭 처리 때문에 실제 전환 증거를 확보하지 못했다. 제품 동작 이상 또는 정상 어느 쪽으로도 확정하지 않는다. 양쪽 DEV 계정의 Release Note 목록은 비어 있어 게시물이 있는 상태의 표시·스와이프 검증은 미완료. 실제 iOS/Android 앱 WebView는 에이전트의 로컬 브라우저 검증 범위가 아니며, 이후 사용자 웹뷰 확인은 위 최신 기록을 따른다. 검증 도중 사용자의 로그인 입력과 충돌해 즉시 조작 중지했고, 사용자가 재개를 지시한 뒤 이어갔다.
- **검증 산출물/실행 상태:** `/Users/parkjongsun/.codex/visualizations/2026/10/30/dl-14899/lab-news-mobile.jpg`, `clinic-article-mobile.jpg`, `lab-article-mobile.jpg`에 화면 증거가 있다. 임시 모바일 모드·추가 device type 옵션·DevTools는 복구/종료했다. 사용자 마감 지시에 따라 exact worktree cwd를 재확인한 Clinic 3210(PID 31823)·Lab 3215(PID 31791)를 종료했다. lsof의 두 포트 LISTEN 없음과 ps의 두 PID 없음으로 종료를 확인했고, 해당 localhost 검증 탭도 남아 있지 않다. 제품 코드 clean, PR/커밋 추가 변경 없음. 원본 branch/worktree와 ignored env는 보존한다. 이후 실행 시 포트/cwd를 다시 확인한다.
- **Jira 마지막 확인 상태:** [DL-14899](https://innovaid.atlassian.net/browse/DL-14899)는 Frankie 담당 하위 작업이다. 사용자의 상태만 변경 요청으로 허용된 workflow `해야 할 일 → 진행 중 → Ready for Deploy`를 적용했고, 당시 마감 재조회에서도 **Ready for Deploy(개발 완료·배포 대기)**를 확인했다. 이번 스테이징 확인 후에는 Jira를 재조회·변경하지 않았다. 본문·댓글은 추가/수정하지 않았고 상위 DL-14898도 변경하지 않았다. 카드 상태는 배포 완료를 뜻하지 않는다.
- [2026-05-25 Slack 원문](https://innovaidhq.slack.com/archives/C09613TBE5A/p1779715031187929)과 첨부 `F0B5TUUBCP5`를 실제로 읽었다. 카드의 ‘New’는 화면상 **News 게시물 목록**을 뜻한다. Order/Shipping·View More 아래 News 제목만 있고 회색 콘텐츠 영역이 비어 있다. 당시 앱 담당자는 웹뷰 영역이라고 설명했고 제보자는 모바일 웹에서도 동일 현상을 확인했다. 두 Jira 카드의 댓글 0개와 Slack 답글 7개는 별개다.
- 사용자 요청에 따라 같은 **메인 프로젝트 폴더**, 기존 Mac `local` 호스트에 **DL-14899 헬프센터 New 영역 조사** 세션(`01a18601-2719-77a3-8d2a-1962bc49e5b8`)을 생성했다. 프로젝트 연결과 초기 조사 턴, 메인과 같은 `gpt-6-astra / ultra` 적용을 확인했다. 실제 휴대폰 목록 노출은 별도 확인 대상이다.
- **10/29 운영 재현:** 로그인된 Chrome에서 `https://portal.dentlink.io/help` 직접 진입. 데스크톱에는 News 4개가 표시됐지만 DevTools iPhone SE(375×667, 모바일 UA)로 새로고침하면 원문과 같은 빈 News 영역이 재현됐다. Release Note도 동일했다. 이는 Chrome 기기 에뮬레이션 관찰이며 실제 iOS/Android 앱·실기기 검증은 아니다. 단순 viewport 축소는 UA 기반 분기를 타지 않아 이 재현을 대신하지 못한다. 임시 viewport·기기 모드·DevTools 필터는 조사 후 복구했다.
- **10/29 수정 전 원인 근거:** 모바일 전용 `shared/ui/src/HelpCenterUI/Main/ThumbnailListSwiper.tsx`는 `swiper/react`만 import하며 `swiper/css`가 없다. 운영 DOM에는 섹션별 카드 4개가 존재하고 관련 게시글 GET은 200이었다. `.swiper-wrapper`는 `display:block`, 높이 764px, translateX(-440px)이고 모든 카드의 x 범위가 -440~-205px로 화면 밖이었다. 부모 overflow:hidden으로 가려진다. 실제 로드된 v1.90.0 CSS(`435cb33a3ae9e4d0.css`)에도 swiper 규칙이 없고 inline에는 부분 스타일만 있다. **모바일 슬라이더 기본 CSS 누락으로 인한 레이아웃 문제**를 확인했다. 5월 당시 서버·브라우저 상태까지 같은 원인이었다고 소급 확정하지 않는다.
- **담당 범위:** 자체 Next `/help`와 `/office/contents/boards`·게시글 API이며 외부 헬프센터/iframe 설정이 아니다. Clinic·Lab의 `HelpCenterMainContents.tsx`가 `react-device-detect.isMobile`로 공용 Swiper를 선택한다. Office·Lab 앱은 각각 portal/lab의 `/auth/redirect?next=/help`를 WebView로 열고 모바일 UA에 `-DentlinkAppWebView-`를 붙인다. News 렌더링은 웹 소유다. 공용 웹 스타일 로드 보완이 작은 수정 후보이며 앱 네이티브 코드 변경 필요 근거는 없다.
- **10/29 조사 당시 코드 기준/보존:** web `origin/master@57bb759ca08e3752140ceffdae2a5421934ec242`; checkout `feature/DL-17011@9dcb644d566cee06fa0019c16b7f47cdf10e8d36` clean, 관련 파일은 master와 동일. Office `origin/main@7f586790e0bbd7b288458e29f00654d38ba68da2`, Lab `origin/main@51441039751b63a08c82a1be9695c805c8af1539`를 읽었다. 앱 checkout의 알림센터 작업 변경(`feature/DL-17059`, `feature/DL-17060`)은 보존했다. 필요한 fetch 외 제품 코드·checkout·branch·worktree·commit/push·PR·Jira 변경 없음.
- **남은 일/재개점:** 이번 News 미노출 수정에 추가 구현 예정은 없다. PR은 위 최신 기록대로 이미 병합되었으며 별도 PR 조작은 하지 않는다. 원본 `feature/DL-14899@6996623dd`와 `/Users/parkjongsun/Repository/dentlink-client-dl-14899`는 clean 상태로 보존하고, 종료한 로컬 3210·3215는 마지막 정리에서도 LISTEN 없음으로 확인했다. 사용자 요청까지 대기하며, 이후 요청이 오면 개인 컨텍스트와 PR/exact worktree 및 요청한 환경을 갱신하고 해당 범위만 재개한다. 상용 배포·추가 QA는 별도 요청 사항이다. 사용자 웹뷰 확인을 보존하되, 미검증인 실제 좌우 스와이프·게시물이 있는 Release Note·모든 제품/OS 조합까지 전체 QA 완료로 승격하지 않는다. 데이터 없는 상태 개선이나 UA 분기 재설계는 이번 범위가 아니다.

## 앱 공통 브랜치 전략 변경 — 2026-10-29

- 통합알림센터 세션에서 사용자가 **Office·Lab 앱 모두 `main → feature → release → main`** 전략으로 변경했다고 확정했다. 신규 `feature/<Jira>`는 최신 origin/main에서 시작하며 develop은 더 이상 운용하지 않는다. 남은 develop은 점진적 정리 대상이고 이번 지시만으로 삭제하지 않는다.
- 공통 AGENTS/SESSION_WORKFLOW와 [앱 온보딩 지침](dentlink-app-onboarding.md)에 반영했다. 과거 develop 기준·PR 대상·release→develop 동기화 기록은 현재 전략으로 사용하지 않는다. 구현 상세는 기능 정본에 유지한다.

## 웹 v1.90.0 배포 기준 확인 — 2026-10-27

- 사용자 요청으로 원격 refs와 실행 대상을 한 번 확인했다. `release/v1.90.0`과 `prd/clinic/v1.90.0`, `prd/clinic-ohio/v1.90.0`, `prd/lab/v1.90.0`, `prd/admin/v1.90.0`은 모두 **`4168fba5aad347e6958412057b4bf35d856f4473`**를 가리킨다. 릴리스 커밋에서 태그를 만들어 배포한다는 목적과 일치한다.
- 아래 Actions는 해당 태그 push로 시작했고 실행 `head_sha`도 모두 위 커밋이다. **18:06 KST 메타데이터 조회 당시 진행 중**이었으며 완료 결과는 재조회하지 않았다.

| 서비스 | 시작 시각 KST | 실행 |
| --- | --- | --- |
| Clinic | 18:02:09 | [40477752750](https://github.com/Innvoaid/dentlink-client/actions/runs/40477752750) |
| Lab | 18:03:13 | [40477879968](https://github.com/Innvoaid/dentlink-client/actions/runs/40477879968) |
| Admin | 18:03:48 | [40477951931](https://github.com/Innvoaid/dentlink-client/actions/runs/40477951931) |

- 같은 exact SHA의 PRD workflow·Dockerfile을 대조했다. 태그 커밋 checkout → 해당 소스 build context → `prd-${github.sha}` 이미지로 전달하며 다른 브랜치 재checkout은 없다. Clinic workflow 하나가 서울·Ohio 양쪽을 처리한다.
- 이번 확인은 **배포 기준/실행 대상 일치**다. 최종 성공·serving revision·서비스 안정화·사용자 QA의 증거는 아니다. 특히 Lab/Admin은 workflow에서 안정화를 기다리지 않으므로 성공 상태만으로 확대하지 않는다. 자동 후속 감시는 시작하지 않으며 결과 확인은 사용자 요청과 공통 배포 확인 주기를 따른다.
- 제품 코드·branch·tag·배포 설정은 변경하지 않았다. 기본 checkout은 `feature/DL-17011@9dcb644d5`·clean·upstream0/0 그대로이며 로컬 checkout과 원격 태그 배포 기준을 혼동하지 않는다.
- **마감:** 사용자가 기준 일치 설명을 확인했으며 이번 확인 요청은 완료했다. 기록을 정리하고 추가 변경·배포 결과 재조회 없이 대기한다. 최종 배포 성공은 확인 완료로 승격하지 않으며, 사용자가 별도로 결과 확인을 요청할 때 위 실행부터 대조한다.

## 현재 업무 색인 — 2026-10-27

| 업무 | 담당 정본에 기록된 단계·재개 경계 | 상세 정본 |
| --- | --- | --- |
| 메인세션 | 상시 중앙 조율·개인 컨텍스트 관리. 보관하지 않고 유지 | 이 문서의 Session Ownership |
| LBX / DL-16387 | 원본 수정·별도 develop 전달 및 사용자 개발 배포 완료 기록. 원본 보존·운영 홀드 유지 | [LBX](dentlink-client-lbx.md) |
| 디자인시스템정비 | 원천/통합 운영 반영 완료. DL-17046 Studio 갤러리는 관련 동료 코드와 사용자 재개 지시 대기. 하네스는 별도 판단 | [DLDS](dentlink-fe-opportunities.md) |
| 통합알림센터 | 웹·앱 알림함/설정, 노티·푸시 처리, 추가 앱 목록. 이메일 제외·메뉴 후속 | [통합알림센터](dentlink-unified-notification-center.md) |
| 이메일 CTA / DL-17183·17187 | 별도 연결·분석·SES 검토. 알림센터 완료 조건에 포함하지 않음 | [이메일](dentlink-email-cta-tracking.md) |
| DL-17012 앱 미지원 기능 우선순위 | Notion 최종 표 정리·검토 완료, 추가 요청 대기. 제품 구현 아님 | [모바일웹·앱 비교](dentlink-mobile-web-app-parity.md) |
| 권한관리 / DL-16317 | 배포·정리 완료 기록. 이후 발견된 회귀·후속 QA는 개별 근거로 구분 | [권한관리](dentlink-permission-management.md) |
| 후속 QA / DL-17011 | 구현·PR 병합 후 10/27 사용자 배포 완료·추가 QA 없음 확인. 업무 종료·세션 보관 요청 기록 | [권한관리](dentlink-permission-management.md) |
| Office 컨펌 오류 / DL-17038 | 수정 전 Render Error 재현·수정본 한정 검증·임시 브랜치/런타임 정리 완료 | [Office 앱](dentlink-app.md) |
| Office LinkTalk SIGSEGV | 확보 가능한 범위 조사 마감. 일치 dSYM 부재로 정확 원인 미확정, 증거 확보와 별도 재개 요청 대기 | [전용 조사](dentlink-app-linktalk-sigsegv-investigation.md) |
| Billing Statement / DL-16796 | 운영 포함·정리 완료 기록, 추가 예정 작업 없음 | [Billing](dentlink-client-billing-statement.md) |
| 웹 env / DL-16821 | 운영 반영·기본 로컬 실행 준비·정리 완료 기록. 별도 보안/DEV 후속 자동 재개 금지 | [환경변수](dentlink-client-env-management.md) |

- 세션 보관 요청과 실제 앱 보관 상태, Git 병합과 서버 배포, 에이전트 검증과 사용자 QA를 구분합니다.
- 제품 저장소의 현재 branch/worktree/env·배포 상태는 필요할 때 live 확인합니다. 이 표에 변동 SHA나 개수를 중복 기록하지 않습니다.
- 담당 문서가 이후 갱신되면 그 최신 기록을 따르며, 이 색인의 오래된 단계로 되돌리지 않습니다.

## 담당 세션 식별자

기존 세션을 찾기 위한 기록입니다. 다른 PC에 프로젝트/대화를 자동 복원하거나 현재 실행·보관 상태를 보증하지 않습니다.

| 업무 | 기록된 세션 이름 | ID |
| --- | --- | --- |
| 메인 | 메인세션 | `01a08f0c-2057-7852-ae8d-0cf950a91fd3` |
| 디자인시스템 | 디자인시스템정비세션 | `01a0a2eb-da08-7131-aaaf-6c14f0cfc204` |
| DL-17012 | DL-17012 기공소 앱 미지원 기능 우선순위 | `01a17657-caad-70f1-9a40-dbde874a3d42` |
| DL-17011 | DL-17011 관리자 그룹 회원 권한 수정 이력 조사 | `01a17658-54e4-7b42-bd92-d0f790d7f2bd` |
| SIGSEGV | 앱 SIGSEGV 오류 원인 조사 | `01a17c4f-57cb-7592-8b7e-b8b937ee7d32` |
| API 조회 | API 사용처 확인 세션 | `01a17b41-6ead-7fc1-9387-42f68aaa86e2` |
| DL-14899 | DL-14899 헬프센터 New 영역 조사 | `01a18601-2719-77a3-8d2a-1962bc49e5b8` |
| 공유기공소·밀링센터 | 공유기공소·밀링센터 세션 | `01a18682-0535-7aa3-9d30-9440b0b90a01` |
| DL-17125 | DL-17125 기공소 출고 예정일 수정 | `01a18af5-8028-71b1-a8ce-83ee0aadfee0` |

## Scope

- Web/Admin repository: `/Users/parkjongsun/Repository/dentlink-client`
- Office app repository: `/Users/parkjongsun/Repository/dentlink-app`
- Lab app repository: `/Users/parkjongsun/Repository/dentlink-lab-app`
  (https://github.com/Innvoaid/dentlink-lab-app)
- 2026-10-06 사용자 확정: 앱은 최근 Office/Lab 저장소로 분리됐다. 앞으로 앱 업무는
  제품을 먼저 구분하고 [Office 앱](dentlink-app.md) 또는 [Lab 앱](dentlink-lab-app.md)의
  정본과 실제 Git을 확인한다. 웹 반응형과 네이티브 앱 적용도 구분한다.
- Durable context: `/Users/parkjongsun/Repository/codex-personal-context`
- Active AI workflow: Codex only. The remote `claude-personal-context`
  repository is retained only as an archive and is not loaded by default.

## Session Ownership

- **원격화 구분(2026-10-27):** 기본 의미는 켜진 이 Mac의 기존 세션을 휴대폰에서 그대로 이어 쓰는 것이다. 다른 PC로 실행 환경을 옮겨 Git 기반 컨텍스트를 복구하는 경우와 구분하고, 각 세션에서 같은 의미를 다시 묻지 않는다. 신규 세션은 정상 등록·프로젝트·호스트·초기 턴 확인과 초기 개인 기록 저장/푸시를 기본으로 챙긴다. 연결 설정은 사용자가 관리한다. 사용자의 '메모리화 후 휴대폰에서 보였다'는 경험은 관찰로 기록하며 Git 저장이 모바일 표시를 유발한다는 인과나 현재 표시 완료를 단정하지 않는다. 정본은 [Phone Remote Continuity](../SESSION_WORKFLOW.md#phone-remote-continuity)이다.
- **메인세션 유지 규칙(2026-10-27):** 이 최상위 세션 `01a08f0c-2057-7852-ae8d-0cf950a91fd3`는 보관하지 않고 계속 유지·대기한다. 보관/영구 종료 요청이나 다른 작업 세션용으로 보이는 대상 불명확 마감 지시가 들어오면 사용자에게 대상을 먼저 되묻는다. 메인 자체가 대상임을 재확인하기 전에는 보관하지 않으며, 일반적인 기록 정리·대기는 그대로 수행한다. 이 추가 확인은 다른 기능 세션 전체에 적용하지 않는다. 정본은 [Dentlink FE Main Session Retention](../SESSION_WORKFLOW.md#dentlink-fe-main-session-retention)이다.
- 직전의 'QA 없이 배포 완료, 정리 후 세션 보관' 메시지는 사용자가 다른 세션에 쓸 내용을 잘못 보낸 것으로 철회했다. 그 메시지를 근거로 SIGSEGV 조사나 다른 업무의 배포/완료 상태를 변경하지 않는다.
- 2026-10-27 **API 사용처 확인 세션** (`01a17b41-6ead-7fc1-9387-42f68aaa86e2`,
  local·메인 프로젝트)은 단순 API 사용처 확인용으로 계속 유지한다.
  원격에서도 찾을 수 있도록 이름·ID·용도만 기록하며, 조회 과정과 개별 결과는
  매번 저장하지 않고 재사용할 결정이나 원칙만 필요할 때 짧게 남긴다.
  Git 원격의 이 기록은 Codex 모바일 목록 동기화 완료를 확인한 근거는 아니다.
- 메인세션은 항상 Dentlink FE 전체를 감독·조율하는 최상위 세션이다.
  신규 업무 접수, 웹·앱 영향 범위, 공통 결정·우선순위, 진행 상태,
  release·배포 단계, 구현 세션 인계와 마무리를 관리한다.
- Git-backed `codex-personal-context`를 관리하며 세션 간 결정·진행 기록을
  정제·동기화한다. 상세 이력은 기능별 문서에, 공통 결정과 조율 상태는 이 문서에 둔다.
  의미 있는 정리 시 개인 컨텍스트를 커밋·푸시한다.
- 필요한 경우 프로젝트 폴더와 세션의 설정·연결·이동·정리를 맡는다.
  실제 폴더, 앱의 표시 이름·연결 경로, 기존 세션 소속·실행 경로를 각각 확인하고
  기존 세션 이력과 진행 중인 제품 작업을 보존한다.
- 메인세션의 폴더는 `/Users/parkjongsun/Documents/ChatGPT/메인 프로젝트`다.
  개인 조율·자료용 폴더이며 전용 제품 저장소나 worktree를 연결하지 않는다.
  위 상시 역할은 2026-09-28 사용자가 재확인한 운영 원칙이다.
- Sessions are created primarily for a feature or responsibility, not for a
  device or repository. One feature session may inspect and implement both its
  web and app portions across the relevant separate product repositories.
- Every code or Git mutation must still name and confirm the exact product
  repository, branch, and worktree. A shared feature scope does not combine Git
  histories or permit writing from an ambiguous directory.
- 2026-10-06 사용자 지침: 구현은 작은 작업도 별도 기능 세션이 기본이며,
  메인세션은 접수·분류·조율·마감을 맡는다. 짧은 작업은 현재 폴더에서 세션만,
  규모가 있고 여러 차례 이어갈 작업은 전용 폴더·worktree·세션으로 분리한다.
  판단이 불명확하거나 작업 충돌·필수 결정이 있을 때만 사용자에게 확인한다.
  상세 운영 정본은 [SESSION_WORKFLOW.md](../SESSION_WORKFLOW.md#new-work-intake-and-session-routing)이며,
  메인세션 직접 구현은 사용자가 선택하는 예외다. 기존 작업 이력은 이 지침으로 재배치하지 않는다.
- 2026-10-06 사용자 추가 지침: 새 작업 세션은 별도 지정이 없으면 메인세션과 같은
  모델·추론 수준을 명시하고 실제 적용값도 확인한다. 같은 설정을 사용할 수 없으면
  사용 가능한 최고 등급을 선택하며, 상세 정본은
  [모델·추론 기본값](../AI_WORKFLOW.md#new-session-model-and-reasoning-default)이다.
- Keep one active writing session per worktree. Repository main-checkout
  sessions are optional helpers for branch/worktree/release administration,
  not permanent web-versus-app session boundaries.
- Shared repository mutations still require the user's explicit authorization.
- 웹 신규 작업의 기준은 최신 `origin/master`로 확정돼 있다. Jira 예정 릴리즈나
  현재 checkout이 release라는 이유로 master 기준을 다시 묻지 않는다. 해당 release에
  이미 반영한 작업의 후속 수정·QA만 release 기반 예외이며, 상세 정본은
  [브랜치 전략](../SESSION_WORKFLOW.md#dentlink-release-train-branch-strategy)을 따른다.

## Top-Level Session Start

1. Pull `codex-personal-context` and read the common guidance plus this file.
2. Read the relevant web and app checkpoints before relying on prior chat.
3. Fetch/pull the relevant product repositories only as required by the current task,
   then verify exact path, branch, HEAD, upstream, dirty state, and worktree.
4. Classify each new request as web, app, or shared before deciding the owning
   implementation session and release target.
5. Apply the canonical size/continuation routing rule: separate feature session
   by default, with a dedicated folder/worktree for substantial continuing
   work. Resolve unclear scope or ownership only when necessary, and do not
   reuse a completed feature branch.
6. Reconcile Jira, Notion, Figma, Swagger, and live code when the new request
   depends on them; do not re-fetch every external source without a task-driven
   reason.

## 상시 작업 지침의 정본

- 앱의 최종 코드·영향 화면·권한별 에이전트 실행 검증 → 결과/확인표 전달 → 사람의 최종 QA: [앱 검증 지침](../DEVELOPMENT_STYLE.md#app-screen-runtime-verification-before-merge).
- 앱 PR·release·CodePush·스토어 경계와 개발자 참고 흐름: [앱 온보딩](dentlink-app-onboarding.md), [공통 앱 전달 정책](../SESSION_WORKFLOW.md#dentlink-app-release-and-delivery-policy). 참고 흐름으로 확정 정책을 조용히 바꾸지 않습니다.
- 제품별 Jira 카드·상위 댓글 제한: [AI_WORKFLOW](../AI_WORKFLOW.md#jira-work-updates).
- 기공소 정적 문구 변경 시 i18n·시트·검증: [공통 기준](../SESSION_WORKFLOW.md#dentlink-lab-translation-work), [웹](dentlink-client-i18n.md), [Lab 앱](dentlink-lab-app-i18n.md).
- 완료 브랜치 정리 시 현재 진행 중 release 원본 보존: [브랜치 정리 이력과 기준](dentlink-branch-cleanup-20261016.md). 제품 Git 정리는 별도 승인과 live 근거가 필요합니다.

## 다른 기기에서 이어가기

- **휴대폰 또는 다른 PC에서 같은 Mac에 원격 접속:** 기존 세션·프로젝트·코드 환경을 그대로 사용합니다. [Phone Remote Continuity](../SESSION_WORKFLOW.md#phone-remote-continuity)를 따르며 다른 PC로 실행 환경을 옮기는 경우와 혼동하지 않습니다.
- **2026-11-04 연결 완료:** 현재 Mac의 설정 → 연결 → 이 Mac 제어 → 추가 → 컴퓨터 화면에서 임시 PIN을 확인해 전달했고, 사용자가 다른 PC 연결 완료를 확인했습니다. 실행 호스트는 기존 Mac으로 유지하며 PIN·QR 값은 저장하지 않습니다. 제품 변경이나 작업 재개 없이 메인세션은 보관하지 않고 대기합니다.
- **다른 PC로 실행 환경 변경:** 개인 컨텍스트 clone/pull → [BOOTSTRAP](../BOOTSTRAP.md#read-order) → 이 색인에서 해당 정본을 읽고 목적·결정·남은 일·재개 조건을 복구합니다.
- 기존 대화 전체·앱의 프로젝트 등록·인증·env·의존성·서버·임시 증거는 개인 컨텍스트 pull만으로 복원되지 않습니다. 절대 경로는 당시 기기 기록이며 실제 대상 경로를 확인합니다.
- 문서 복구만으로 구현·QA·서버 실행·배포·보류 해제가 승인되지 않습니다. 실제 재개 시 제품 Git과 작업 소유권을 다시 확인합니다.
- 여러 세션이 개인 컨텍스트 checkout을 공유하면 수정 파일을 나누고 stage/commit/push는 조율합니다. 다른 세션 변경을 임의로 포함하지 않습니다.

## 과거 조율 이력

[2026-10-27 정리 전 전체 이력](archive/dentlink-fe-history-through-2026-10-27.md)에 이전 세션 배정, 브랜치·폴더·env 정리, 피드백/E2E·release 전환, 웹/앱 초기 인계와 상세 PR 기록을 보존했습니다.
보관본의 '현재·대기·다음 시작점'은 당시 상태이며 위 최신 색인이나 담당 정본을 대체하지 않습니다. 정확한 과거 경위가 필요할 때만 읽습니다.
