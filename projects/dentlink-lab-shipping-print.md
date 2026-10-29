# Dentlink Lab Shipping Print UX — DL-17101

## Current checkpoint — 2026-10-29 23:12 KST

- **추가 구현·원본/배포용 커밋·푸시·PR 정리 완료, 사용자 병합/배포 및 실물 QA 대기.** 열린 DL-17101 PR은 [#4802](https://github.com/Innvoaid/dentlink-client/pull/4802) 1개다. 최신 제목은 `[DL-17101] 자체기공소 출력물별 용지·회전·배치 설정`, open/non-draft/unmerged/mergeable이며 develop 대상 2커밋·14파일(+1469/-55). CI 완료나 배포 성공을 뜻하지 않는다. 사용자 요청 없이 병합·배포·추가 구현·반복 감시는 하지 않는다.
- 사용자 최종 목적: 여러 프린터를 사용하는 사람이 자기 환경에 맞는 값을 넣고 **출력물 3종별로 독립 기억하는 기반**이다. 특정 프린터/용지 규격을 고정하거나 프린터 자동 선택/서버 공유 기능을 만드는 것이 아니다.
- 원본 전용 `/Users/parkjongsun/Repository/dentlink-client-dl-17101`: `feature/DL-17101@3a1efad6fbb4ac23fcbd250373fc6667587ab2dc`, origin 일치·clean. `origin/master@57bb759ca` 직계 0 behind/3 ahead. 이후 구현도 이 경로와 원본 브랜치를 사용한다.
- 별도 배포 checkout `/Users/parkjongsun/Repository/dentlink-client-dl-17101-develop`: `feature/DL-17101-print-settings-develop@e34c1b805fa8387feb6eb18a7922a9385ed52adc`, origin 일치·clean. 최신 `origin/develop@9a745cfb2` 위 설정2커밋이다. 새 추가 커밋과 원본 patch-id `cd61b2591f381d33c2afbeeacc1cf33b318c3635` 일치, 14개 변경 파일 내용도 동일하다. 이전 설정 patch-id `6203bc4d50c253f1ffd66117477d35596d4695c4` 일치 기록 유지.
- 이전 배포 `feature/DL-17101-develop@8ee2b9ec7`와 원본·배포 워크트리를 보존한다. 메인 master 및 다른 작업 checkout은 건드리지 않았다. 두 작업 checkout은 수동 Git worktree이므로 명령 cwd를 매번 명시한다.
- 설정 모달에 용지 너비/높이(mm/cm), 상하좌우 공통 여백, 회전0/90/180/270°, 배율1–300%, 가로·세로 signed 이동을 제공한다. mm/cm 변경은 치수·여백·이동값을 함께 환산한다. 기본 새 설정은 A4·여백10mm이나 모두 사용자가 바꿀 수 있다.
- `shipmentPrintSettings:ATTACHMENT/SHIPPING/ORDER_SHEET` 각각 저장한다. 같은 브라우저+origin+같은 형식의 다른 창에는 storage event로 전달되지만 형식끼리 섞이지 않으며 PC/브라우저/서버 계정 동기화는 없다. version2에서 width/height는 **용지 크기**이며 구버전 저장값은 크기·회전·배율 유지, 여백/이동0으로 읽기 변환한다(자동 저장 덮어쓰기 없음).
- 콘텐츠100%는 여백과 배송 안내 공간을 제외한 영역 안에 비율을 유지해 맞춘다. 기본은 왼쪽 위이며 강제 가로 중앙정렬을 제거했다. 회전 내부 중앙 transform은 콘텐츠의 회전 경계를 맞추는 용도다. 용지·여백을 화면에 표시하고 `@page size/margin`과 동일 배치를 인쇄한다. 확대/이동으로 실제 용지 밖으로 벗어나면 화면에서 잘림 경고와 잘린 결과를 보여준다.
- 배송용 안내 문구는 회전하지 않고 같은 용지 안에 폭/높이를 맞춰 확보하며 운송장은 남은 공간을 사용한다. 주문서는 기존 페이지별 내용을 조정한다. 설정 없음/비INTERNAL/스티커/배송 API·업무 규칙은 기존 경로를 유지한다. 실물 프린터·대응 용지·인쇄 배율 선택은 브라우저 대화상자에서 사용자 담당이다.
- 원본·배포 반영 코드 Clinic/Lab/Admin 타입 검사 통과, 설정/레이아웃 Jest **56개** 통과. 양쪽 정상 push 훅의 lint·Admin DLOS 가드·공유 테스트/coverage 통과(기존 lint 경고 유지, 훅 우회 없음). 독립 코드 리뷰 지적1건(print display:block이 비INTERNAL까지 적용)은 설정 있는 INTERNAL에만 제한해 반영했다.
- 최종 원본 Chrome: 기존 A4210×297mm·100%·270° 부착용은 **1장**(기존2장 밀림 해소), 이미지 왼쪽 위 좌표=용지 원점 확인. 100×150mm·여백3mm·80%·90°·X2/Y3mm, cm 환산/새로고침 저장 유지,150% 확대 잘림 경고를 확인했다. 배송용 안내 포함1장,90°회전 주문서1장, 3형식 각2건=각2장 native 인쇄 미리보기 확인. 일괄 검증 URL은 배송목록의 실제 두 링크에서 구성했으며 목록 선택 UI를 이번에 재검증한 것은 아니다.
- 사용자 원래 부착용 값은 이 재개 시210×297mm·100%·270°였으며 최종 해당값+여백0/이동0으로 복원했다. 배송용과 주문서는 새 기본 A4·여백10·100%·0°·이동0 설정을 저장해 확인했다. 다른 창으로 옮겨도 형식별 설정을 유지했다. 임시 일괄검증 탭만 닫고 사용자 기존 부착용 출력창과 배송목록을 유지했다.
- localhost:3005 PID76183 cwd는 원본 `/lab`임을 최종 재확인했고 서버를 유지했다. 설정 UI 증거 `/tmp/dl17101-paper-settings.png`; 타입/테스트/commit/push/i18n 로그 `/tmp/dl17101-paper-*`. 임시 로그 존재와 코드 일치는 재개 시 확인한다.
- E2E 가드 `NO_IMPACT`: 04_labShipment/05_labStatus/원본08_orderFeedback helper의 locator·API 대기·업무 단계 계약 보존. 원본 mark/커밋 후 check, 배포 mark/열린 PR push check 통과. E2E 수정·실행은 없으며 브라우저 인쇄 증거와 구분한다.
- 하위 [DL-17101](https://innovaid.atlassian.net/browse/DL-17101) 설명의 설정 범위를 최종 목적/용지 기준으로 갱신하고 댓글 **44708**에 PR·검증·남은 범위를 기록했다. **Ready for Deploy** 유지 및 설명 read-back 일치 확인. 상위 DL-17099는 수정/댓글 없음.
- **남은 확인:** 실제 라벨/A4 프린터의 용지 지원·인쇄 불가 여백/드라이버 설정, 배송 수정부터 SSE 자동창까지 전체 흐름, 비INTERNAL 실제 계정 런타임, 대량 행 주문서의 실제 다페이지 데이터. 배포 checkout 별도 서버 런타임은 실행하지 않았고 파일 동일성·타입/테스트로 확인했다. 운영 번역 시트 동기화/PM 검토는 아래 조건으로 보류다.
- env 상속 지침은 이미 공통 AGENTS/SESSION_WORKFLOW의 **Local Env Inheritance** 및 전역 ~/.codex에 반영·일치 확인했다. 새 세션/워크트리의 승인된 로컬 준비는 메인의 해당 서비스 env를 값 열람 없이 상속하고 기존 대상 보존·Git ignore·실제 cwd/port를 확인한다. 이번 추가 작업은 env/전역 지침을 다시 변경하지 않았다.

## Previous checkpoint — content-size settings (superseded)

- 최초 출력물별 설정은 원본 `2945333b9`/배포 `025919c0a`와 PR4802로 준비했고 회전/저장 테스트27개를 통과했다. 이때 width/height는 콘텐츠 영역이었으며 A4100%에서 실제 여백 때문에2장으로 나뉘었다. 현재 용지 기준 구현과56개 검증이 이 한계를 대체한다.
- 라벨 세로 원본을 자동90° 정렬하던 기존 화면을0°로 보고 사용자 회전을 합산한다. 이 기준은 현재도 유지된다. 샘플 PDF는270°가 정방향이며 다른 원본의 방향을 강제로 정방향이라 보장하지 않는다.

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

- 기존 출력 분리4키와 설정23키(최초12+이번 용지 관련11키)를 shipping en/ko에 반영했다. 신규 설정 문구는 로컬 화면에서 확인했으며 운영 시트는 아직 미동기화다.
- 최신 읽기 전용 export preview: 로컬3367키, missing1771/stale2/conflicts3. 충돌은 labHeadline(ko), readyInHours(en/ko), stale2는 기존 master 삭제가 시트에 남은 것이다.
- audit:i18n은 기존 OFFICE 분기 account.auth.actions.logIn 누락으로 실패했고 이번 신규 누락은 없다. check:i18n은10파일 stale이며 shipping2개에 설정23키와 문구 변경 차이가 있고 나머지8개는 기존 불일치다.
- 운영 가이드의 동시편집 중단 조건을 확보하지 못해 시트 쓰기/전체 덮어쓰기/강제 생성을 하지 않았다. 번역 완료로 보고하지 않는다. 승인 범위27키를 기존 타 작업·PM 문구를 보존하며 동기화할 방법과 편집중단 조건을 다음에 정리한다.

## Resume point

1. 사용자가 후속 작업을 요청하면 개인 컨텍스트와 원본 `feature/DL-17101`의 live Git을 갱신하고 정확한 전용 cwd에서 QA 피드백을 처리한다. 원본·이전 배포·새 배포 브랜치를 유지한다. 요청 없이 PR 병합/배포/CI 반복 조회/CodeRabbit 대응을 하지 않는다.
2. PR #4802의 사용자 병합·배포 여부는 전달과 실제 확인을 구분한다. 로컬 테스트는 해당 서비스 메인 env를 값 열람 없이 상속하는 위 승인 원칙을 따른다. 기존 대상 설정이 있으면 덮어쓰기 전에 보존한다.
3. 최종 코드의 3종/각2건 인쇄 미리보기와 회전/크기/저장 검증은 위 현재 체크포인트를 따른다. 사용자에게 남은 것은 실제 라벨/A4 프린터별 용지·인쇄 불가 여백·배율 확인이다. 기존2장 밀림 관찰은 수정 전 이력이며 현재 재현 사실로 취급하지 않는다.
4. 번역 시트 동시편집·충돌 조건이 해결되면 승인 범위 동기화를 진행한다. Jira 기록은DL-17101에만 남기며 상위DL-17099는 수정하지 않는다.

## Session identity


- 공유기공소·밀링센터 세션 `01a18682-0535-7aa3-9d30-9440b0b90a01`, 기존 Mac local 호스트. FE 메인 `01a08f0c-2057-7852-ae8d-0cf950a91fd3`와 분리해 구현한다.
- 코드 변경 범위는 Lab 출력 컴포넌트/훅/배송목록·상세/주문상세, 공용 일괄선택 UI의 optional props, shipping 번역 리소스다. 개인 체크포인트는 제품 저장소에 추가하지 않았다.
