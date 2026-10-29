# Dentlink Lab Shipping Print UX — DL-17101

## Current checkpoint — 2026-10-29

- **정리 완료·사용자 로컬 QA 대기:** 사용자가 로컬에서 계속 확인하는 동안 추가 구현·QA·배포 감시를 중단한다. localhost:3005 PID76183의 cwd가 원본 워크트리의 lab임을 재확인했으며 서버·브라우저·원본/배포 워크트리를 유지했다. PR #4802는 마감 조회 시 open/unmerged였다.
- 사용자 요청으로 Jira DL-17101을 **Ready for Deploy**(요구사항 개발 완료)로 전환하고 기존 후속 댓글44707에 사용자 로컬 확인 중·최종 QA/병합/배포 미완료를 명시했다. 아래 구현 시점의 진행 중 상태보다 이 최신 상태를 우선한다. 상위 DL-17099는 변경하지 않았다.
- 새 세션/워크트리의 env 상속 규칙을 공통 AGENTS와 SESSION_WORKFLOW의 **Local Env Inheritance**에 정리하고 기존 setup-local-codex.sh로 전역 ~/.codex 지침 동기화를 완료했다. 두 파일의 정본 일치를 cmp로 확인했고 이 세션에도 새 AGENTS가 다시 제공됐다. 다른 실행 중 세션의 자동 재로드까지 확인한 것은 아니다. 기존 사용자 설정 보존, Git 제외, 실제 실행 cwd/port 확인까지 포함하며 값 관리/외부 전송/배포 설정 변경 권한으로 확대하지 않는다.

- 사용자가 출력물별 설정 구현 후 커밋·푸시와 별도 develop PR 생성을 다시 승인했다. **원본 커밋·푸시 및 [PR #4802](https://github.com/Innvoaid/dentlink-client/pull/4802) 생성 완료**, 병합·배포는 사용자 담당이다. PR은 open/non-draft/unmerged, develop 대상·충돌 없음으로 확인했다. CI 완료·배포 완료를 뜻하지 않는다.
- 원본 전용 `/Users/parkjongsun/Repository/dentlink-client-dl-17101`: `feature/DL-17101@2945333b9cc765906384ada4674710441f749106`, origin과 일치하고 clean. 최신 확인 master `57bb759ca` → 기존 출력 분리 `ee59a7e2a` → 이번 설정 `2945333b9` 직계이며 master 대비 0 behind/2 ahead다. 이후 구현은 계속 이 경로·원본 브랜치에서 한다.
- 배포 checkout `/Users/parkjongsun/Repository/dentlink-client-dl-17101-develop`: 새 `feature/DL-17101-print-settings-develop@025919c0ac28af1e7f9bb805ab56437f7b495343`, origin과 일치하고 clean. 최신 develop `9a745cfb22aae22a621ea8542d0c8e9f5f55cafa`에서 새 설정 커밋만 cherry-pick했다. 원본과 14개 파일 내용 및 patch-id `6203bc4d50c253f1ffd66117477d35596d4695c4`가 동일하다. PR은 1커밋·14파일(+860/-25).
- 이전 배포 브랜치 `feature/DL-17101-develop@8ee2b9ec76faf84aa406b8be2ee14dc67e097ae5`는 보존했다. 메인 `/Users/parkjongsun/Repository/dentlink-client`는 `master@57bb759ca` clean이며 다른 작업 워크트리는 건드리지 않았다. 두 작업 checkout은 수동 Git worktree이므로 도구 cwd를 매번 명시한다.
- 3종별 콘텐츠 너비·높이(mm/cm), 배율1–300%, 회전0/90/180/270°을 출력창 설정 모달에서 각각 localStorage에 저장한다. 설정 없음은 기존 경로, 비INTERNAL·스티커·API·배송 업무 로직은 유지한다. 크기는 콘텐츠 영역이며 프린터·용지는 브라우저 인쇄창에서 고른다.
- 사용자 제보로 실제 Chrome에서 회전 기준 불일치를 재현했다. 기존 세로 이미지 자동90° 정렬과 새 원본 기준90°가 같아 보였으며, 기존 화면을0° 기준으로 사용자 회전을 더하도록 수정했다. 이미지/PDF에만 적용하며 주문서 HTML은 사용자 각도를 그대로 적용한다.
- 최종 원본·반영 코드 Clinic/Lab/Admin 타입 통과. 설정 저장/검증/치수/회전 테스트27개 통과. 양쪽 push 훅 lint·Admin DLOS 가드·공유 테스트/coverage 통과, 기존 lint 경고 있음. coverage 기준선은 이전 develop에서 생성한 것을 공유 코드 동일성 확인 후 원본 새 checkout으로 복사했으며 훅 우회 없음.
- 최종 코드 로컬 INTERNAL 부착용 PDF: 90°/270°에서 세로 표시, 50% 축소 확인. Chrome native 인쇄 미리보기에서90°·50%는1페이지로 정상 유지됐다. 해당 샘플은270°에서 글자가 정방향이다. 검증 후 사용자 기존210×297mm·100%·90°를 복원했다. 210×297mm·100%는 현재 프린터 여백 포함 영역을 넘어2페이지가 되는 것을 관찰했다. 실제 용지에 맞춘 크기/배율 조정이 필요하며 자동 용지/프린터 설정 기능은 없다.
- **남은 QA:** 실물 인쇄, 설정 적용 후3종 전체·일괄 출력·다른 기공소 실제 계정 런타임은 미완료다. 사용자가 로컬 검증을 직접 하겠다고 했으며, 이번 에이전트 브라우저 확인은 회전 제보 재현·수정 범위다. 아래 기존 출력 분리 런타임 기록을 새 설정 전체 검증으로 재사용하지 않는다.
- E2E 가드 `NO_IMPACT`: 04_labShipment/05_labStatus의 실제 helper·locator·API 대기·업무 단계는 변경되지 않으며, E2E는 출력 팝업 설정을 조작하지 않는다. 최종 develop diff 동일성 확인 및 mark/check 완료. E2E 수정·실행 없음.
- 하위 [DL-17101](https://innovaid.atlassian.net/browse/DL-17101)의 설명에 추가 설정 범위를 반영하고 댓글44707에 PR·회전 확인·미완료 QA/번역을 기록했다. 상태 진행 중 유지. 동료 상위 [DL-17099](https://innovaid.atlassian.net/browse/DL-17099)는 읽기 전용이며 수정·댓글 없음.
- 로그: `/tmp/dl17101-settings-rotation-tests.log`, `dl17101-settings-source-commit.log`, `dl17101-settings-source-push.log`, `dl17101-settings-delivery-types.log`, `dl17101-settings-delivery-push.log` (모두 /tmp). 회전 화면 `/tmp/dl17101-rotation-proof.png`. 임시 증거이므로 재개 시 존재와 해당 코드 일치를 확인한다.

## Local environment decision

- 새 원본 워크트리에 env가 없어 로그인 요청이 localhost로 향했던 것을 확인했다. 비밀번호 표시의 기존 `sharedUi.password.show/hide/clear` 번역 누락은 별도 표시 문제다.
- 사용자가 현재와 앞으로 새 세션/워크트리의 로컬 준비 시 **메인 워크트리의 해당 서비스 env를 그대로 상속**하도록 명시 승인했다. 메인 Lab `.env.local`·`.env.development`를 값 조회/노출 없이 복사했고 Git ignore를 확인했다. 값 변경·문서 기록·GitHub Variables/Secrets 변경 허가는 아니다. SESSION_WORKFLOW.md에 이 원칙을 반영했다.
- source Lab에서3005 서버를 재시작했고 로그인 페이지HTTP200 확인 후 사용자가 실제 로그인해 출력 화면을 열었다. 이후 에이전트는 로그인된 로컬 출력 화면에서 회전 문제를 검증했다. 서버 재개 시 해당 cwd/port를 다시 확인하며 비밀값을 조회하지 않는다.

## Previous delivery — print separation

- 원본 `ee59a7e2a`, 이전 배포 `8ee2b9ec7`, [PR #4801](https://github.com/Innvoaid/dentlink-client/pull/4801)은2026-10-29 17:58:21 KST에 develop으로 병합됐다. merge SHA `9a745cfb2`,19파일(+412/-148). 원본·반영 patch-id `66016ba691ee96fd21576e4c2b2af0720ec7c8b2` 일치.
- 사용자가 개발서버 배포를 진행했다고 전달했다. 에이전트는 병합만 실조회했고 배포 결과·서빙 revision·배포 후 QA는 확인하지 않았다. 하위 댓글44705/44706에 기록했다.
- 이후 사용자 요청으로 원본 브랜치를 전용 워크트리로 옮기고 메인 checkout을 master로 돌렸다. 분리 당시 실행 환경이 없었지만 이후 위 명시 승인으로 env 상속/의존성 준비를 완료했다.

## Confirmed behavior — original print separation


- INTERNAL 배송 목록의 기존 라벨·스티커를 `라벨(부착용)`, `라벨(배송용)`, `주문서(배송용)` 3열로 바꾸고 상단 일괄 출력 메뉴와 배송 상세 상단에도 같은 선택지를 제공한다.
- 부착용은 운송장 이미지/PDF만, 배송용은 운송장과 기존 인쇄 전용 수출신고 안내, 주문서용은 기존 Order List만 출력한다.
- 기존 `printType=LABEL/STICKER`와 URL/API 구조를 유지하고 INTERNAL LABEL에만 optional `labelFormat=ATTACHMENT/SHIPPING/ORDER_SHEET`를 추가했다. 출력창에서 같은 창의 메뉴로 바꾸며 URL에 선택이 남는다. 다른 타입은 format을 무시하여 기존 통합 라벨·스티커 동작을 유지한다.
- INTERNAL 배송 상세의 주문별 스티커, 주문 상세의 기존 스티커만 숨긴다. 주문 상세의 별도 QR `라벨 출력`과 `Order` 출력은 유지한다.
- 배송 주문 구성 수정 후 자동 출력창을 여는 기존 SSE 조건을 유지한다. INTERNAL 기본은 부착용이고 새 라벨 안내 및 3종 전환을 제공한다. 화면 선택에 필요한 기존 exportTradeCodes를 INTERNAL 경로에만 전달했다.
- LABEL 최대10건/STICKER 최대30건, labelUrl 필수, CREATING_WAYBILL 비활성화, PRE_DELIVERY 재시도 조건을 유지한다. INTERNAL 재시도는 첫 열/상세 상단에 한 번만 노출한다.
- INTERNAL 출력에서는 QA·TanStack 개발 버튼이 종이에 찍히지 않게 인쇄 CSS로 숨겼다. 출력 메뉴는 PopupMenu customToggleUI를 사용해 실제 800px 팝업에서 정렬을 확인했다.

## Verification — original print separation only


- 원본 commit 훅과 별도 배포 checkout에서 Clinic·Lab·Admin 타입 검사 통과. 양쪽 push 전 lint·test·coverage 검사도 통과했으며 기존 경고는 남아 있다. 배포 checkout의 누락된 Next 타입 선언/Husky 설치/coverage 기준선을 정상 생성한 뒤 검사했다. coverage 기준선은 실제 미변경 origin/develop에서 생성했으며 훅을 우회하지 않았다.
- 배포 diff 독립 리뷰 결과 원본 19파일과 동일하고 develop 인접 코드와 충돌하지 않는다. E2E 영향 가드 **NO_IMPACT**: 04_labShipment·05_labStatus·08_orderFeedback의 locator·경로·API 대기·업무 단계 계약을 유지한다. E2E 수정·실행은 없으며 PR 직전 guard check 통과. 배포 checkout의 별도 브라우저 런타임은 실행하지 않았고 아래 런타임 증거는 최종 원본 코드 기준이다.
- 최종 Lab TypeScript exit0, 공유 UI를 소비하는 Clinic TypeScript exit0. 변경 파일 ESLint 오류0, 경고13개는 HEAD 원본과 동일. 기존 root/shared Storybook 플러그인 중복 문제로 Lab/shared 검사를 분리했다. Prettier와 git diff --check 통과.
- 저장소 밖 `/tmp` Jest/jsdom 검증 **13개 통과**: 실제 URL 훅·LabelList/Item의 INTERNAL 기본/3형식, 비INTERNAL 기존 URL/통합 문서, 자동출력 플래그, 스티커 URL, 2건 순번, 안내 포함/제외, PDF 분기. API와 이미지/PDF leaf는 mock이며 실제 브라우저 증거와 구분한다.
- Chrome localhost 실제 INTERNAL: 목록3열·일괄3메뉴, 개별 부착용, 각 형식 2건 일괄 열기, 선택 초기화, 11건 선택 시 출력 비활성화(기존 동작), 배송 상세3버튼/스티커 제외, 주문 상세 QR·Order 유지/스티커 제외를 확인했다.
- Chrome native 인쇄 미리보기: 부착용1건=운송장1페이지/안내없음, 부착용2건=운송장2페이지, 배송용2건=기존 통관안내 포함2페이지, 주문서2건=Order List2페이지/첫 빈페이지없음. 최종 부착용과 주문서에서 개발 버튼 미출력도 확인했다. 실제 종이 인쇄는 하지 않았다.
- 출력창 내3종 전환·새로고침 유지 확인. 기존 형식 URL에 isUpdateShipping 플래그를 넣어 INTERNAL 부착용 기본/새 라벨 안내를 확인했다. **실제 배송 수정 요청/SSE 전체 시나리오는 실행하지 않았다.**
- 비INTERNAL 실제 계정 전환/브라우저 실측은 없으며 기존 동작 보존은 diff 리뷰·타입검사·13개 회귀테스트로 확인했다. 동일 계정의 Admin 타입을 바꿔 시험하지 않았다.
- 실행 로그: `/tmp/dl17101-lab-final-types.log`, `/tmp/dl17101-clinic-types.log`, `/tmp/dl17101-eslint-lab.log`, `/tmp/dl17101-eslint-shared-ui.log`, `/tmp/dl-17101-print-regression.log`, `/tmp/dl17101-source-commit.log`, `/tmp/dl17101-source-push.log`, `/tmp/dl17101-delivery-push.log`. 임시 파일이므로 다음 세션에는 존재와 소스 일치를 다시 확인한다.

## Translation pending

- 기존 출력 분리4키와 이번 설정12키를 shipping en/ko에 반영했다. 신규 설정 문구는 로컬 화면에서 확인했으며 운영 시트는 아직 미동기화다.
- 최신 읽기 전용 export preview: 로컬3356키, missing1760/stale2/conflicts3. 충돌은 labHeadline(ko), readyInHours(en/ko), stale2는 기존 master 삭제가 시트에 남은 것이다.
- audit:i18n은 기존 OFFICE 분기 account.auth.actions.logIn 누락으로 실패했고 이번 신규 누락은 없다. check:i18n은10파일 stale이며 shipping2개에 추가 설정12키 차이가 있고 나머지8개는 기존 불일치다.
- 운영 가이드의 동시편집 중단 조건을 확보하지 못해 시트 쓰기/전체 덮어쓰기/강제 생성을 하지 않았다. 번역 완료로 보고하지 않는다. 승인 범위16키를 기존 타 작업·PM 문구를 보존하며 동기화할 방법과 편집중단 조건을 다음에 정리한다.

## Resume point

1. 사용자가 후속 작업을 요청하면 개인 컨텍스트와 원본 `feature/DL-17101`의 live Git을 갱신하고 정확한 전용 cwd에서 QA 피드백을 처리한다. 원본·이전 배포·새 배포 브랜치를 유지한다. 요청 없이 PR 병합/배포/CI 반복 조회/CodeRabbit 대응을 하지 않는다.
2. PR #4802의 사용자 병합·배포 여부는 전달과 실제 확인을 구분한다. 로컬 테스트는 해당 서비스 메인 env를 값 열람 없이 상속하는 위 승인 원칙을 따른다. 기존 대상 설정이 있으면 덮어쓰기 전에 보존한다.
3. 3종 개별/일괄 출력,90/270회전,크기/배율,새로고침/다른출력창 저장독립, 실제 라벨프린터와A4 인쇄 가능영역을 확인한다. 현재210×297mm·100%가 인쇄영역을 넘어2페이지가 되는 관찰을 고려한다.
4. 번역 시트 동시편집·충돌 조건이 해결되면 승인 범위 동기화를 진행한다. Jira 기록은DL-17101에만 남기며 상위DL-17099는 수정하지 않는다.

## Session identity


- 공유기공소·밀링센터 세션 `01a18682-0535-7aa3-9d30-9440b0b90a01`, 기존 Mac local 호스트. FE 메인 `01a08f0c-2057-7852-ae8d-0cf950a91fd3`와 분리해 구현한다.
- 코드 변경 범위는 Lab 출력 컴포넌트/훅/배송목록·상세/주문상세, 공용 일괄선택 UI의 optional props, shipping 번역 리소스다. 개인 체크포인트는 제품 저장소에 추가하지 않았다.
