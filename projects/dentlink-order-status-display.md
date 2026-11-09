# Dentlink 주문 상태 표시 정합성 — DL-17303

## 현재 상태 — 2026-11-09 재개

- **세 제품 커밋·푸시·이번 릴리즈 대상 PR 생성 완료.** 사용자가 다른 작업 완료를 알리고 시작을 요청했으며, 기본 Office/Lab checkout의 통합알림센터 미커밋 변경을 확인한 뒤 앱 두 개, 이어 웹까지 **새 worktree** 사용을 명시했다. 기존 기본 checkout은 편집/정리하지 않는다.
- 이번 QA 후속은 기존 지연 라벨/서버 isDelayed 변경을 포함한 최신 대상 release에서 각각 새 `feat/<Jira>`를 만들었다. 후속 사용자 지시로 세 제품 commit/push/각 release 대상 PR 생성을 승인받았다. merge·CodePush·배포는 승인 범위에 포함하지 않는다.
- Office [DL-17303](https://innovaid.atlassian.net/browse/DL-17303)을 유지하고, 중복 검색 후 Web [DL-17309](https://innovaid.atlassian.net/browse/DL-17309)·Lab [DL-17310](https://innovaid.atlassian.net/browse/DL-17310)을 DL-17302의 별도 하위 작업으로 생성했다. 모두 Frankie 담당. 작업 정의를 설명에 보존했고 부모 댓글/본문·상태·포인트·fixVersion은 변경하지 않았다.
- 제보 주문 `7000012592`의 실제 STG 앱 목록 응답·캐시는 아직 확보하지 못했다. 코드 결함 수정 및 합성 데이터 표시 검증과 해당 주문의 직접 원인 확정은 구분한다.
- 다른 기존 세션을 조회/폴링하지 않는다. 이 기능 채팅 안에서 제품별 subagent를 사용해 구현·정적 리뷰·검증을 분담하며, 같은 기기 쌍은 Office 다음 Lab 순서로 함께 전환한다.

### 현재 작업 위치

| 제품 | 작업 worktree | 브랜치 | 기준 release / HEAD |
| --- | --- | --- | --- |
| Web | `/Users/parkjongsun/.codex/worktrees/order-status-web/dentlink-client` | `feat/DL-17309` | `release/v1.92.0` / `ae80d3218498a6d98e39dca5e93505cb70ab2684` |
| Office | `/Users/parkjongsun/.codex/worktrees/order-status-office/dentlink-app` | `feat/DL-17303` | `release/v2.2.4` / `4892f1c1849833054453f01145b2f012782bb9da` |
| Lab | `/Users/parkjongsun/.codex/worktrees/order-status-lab/dentlink-lab-app` | `feat/DL-17310` | `release/v1.0.5` / `907832d990a59b8a26a4c06e8df6663166a6f7f6` |

### PR 전달 — 2026-11-09

| 제품 | PR / 실제 대상 | 전달 커밋 | 확인된 변경 |
| --- | --- | --- | --- |
| Web | [#4854](https://github.com/Innvoaid/dentlink-client/pull/4854) / `release/v1.92.0` | `9c6b411bcf9c226e66e13ce1da32ef7ada0114a0` | 공용 상세2파일 +5/-2 |
| Office | [#343](https://github.com/Innvoaid/dentlink-app/pull/343) / `release/v2.2.4` | `5d3daf702d49417767856fff23803ab8b57455ce` | `OrderProgressStatus.tsx` 1파일 +11/-6 |
| Lab | [#37](https://github.com/Innvoaid/dentlink-lab-app/pull/37) / `release/v1.0.5` | `49b997d5e2fb746707a2a1977fd828931c07c2e3` | `OrderProgressStatus.tsx` 1파일 +11/-6 |

- 세 제품 모두 OPEN·일반 PR·실제 base/head·변경 파일을 생성 후 재조회했다. 웹은 reviewer `inkyookoh`/`chajju`, assignee `jongsunP`의 자동 설정도 확인했다. 로컬 clean/upstream 동일. Office release가 `8df7c7e`로 전진했지만 기존 검증 head를 그대로 전달했으며 PR에는 상태파일만 포함된다. 서로 다른 배지 정리 파일과 충돌은 없다.
- 앱 default main의 title/body/label 자동화는 `feature/` 패턴만 인식해 이번 `feat/`에 retarget하지 않는다. 배포 워크플로는 main대상·배포라벨 조건이며 이번 release PR에서 배포를 시작하지 않았다. CodeRabbit/CI 진행 조회나 리뷰 처리도 하지 않는다.
- 웹 커밋 메시지: `fix: 주문 주 상태 기준으로 상세 표시 정합성 수정`. Office 커밋 메시지: `fix: 주문 상태 표시에서 주 상태 우선 적용`. Lab: `fix: 주문 주 상태 기준으로 제작 단계 표시 제한`. 로컬 최종 검증 blob은 이전과 같아 양OS 검증을 반복하지 않았다.
- 웹 E2E guard는 관련 배송준비/상태변경/피드백 시나리오의 실제 helper·selector 검토 후 `NO_IMPACT`를 기록했다. 사용자에게 새로운 영구 E2E 테스트나 제품 파일을 추가하지 않았다. commit hook의 Clinic/Lab/Admin 타입과 pre-push lint·공용 테스트·coverage 비교를 우회 없이 통과했다.
- 첫 웹 push는 새 worktree의 ignored coverage baseline 부재로 중단됐다. 원본 baseline의 출처/구조를 확인해 수정 없이 상속한 뒤 통과했다. 기준 수치·threshold 변경이나 hook bypass는 하지 않았다. 이 로컬 준비 파일은 PR에 포함되지 않는다.

### 구현과 확보한 검증

- 앱 각각 `OrderProgressStatus.tsx` 한 파일의 라벨 및 제작 시각 분기 두 곳에 `IN_PROGRESS` 가드만 추가했다. Scanner Draft·승인 세부 표시·날짜·Remake·Delayed 및 Lab Ready for Fabrication 색상은 유지한다.
- 웹은 아래 두 후보 파일에 주 상태 가드와 모바일 상세 상태원천 정합성을 반영했다. 변경 파일 2개이며 사용자에게 보이는 새로운 문구·UI는 추가하지 않았다.
- 독립 코드리뷰에서 새 결함은 발견하지 못했다. 웹 Clinic/Lab 타입·변경 파일 ESLint/Prettier/diff 검사 통과. 두 앱 변경 파일 ESLint/Prettier/diff 검사 통과. 전체 타입은 Office 6개·Lab 5개 기존 진단이며 기준 코드와 최종 코드의 진단이 동일하다.
- 웹 실제 변경 컴포넌트·공용 상태칩을 격리 Chromium에서 합성 props 48조건으로 렌더해 통과(pageerror 0). 이는 서비스 로그인/API 통합 QA와 다르다. 로컬 증거 `/tmp/dl17309-web-qa/results.json`, `office-completed.png`, `lab-in-fabrication.png`. 검증 브라우저와 임시 Vite3199는 종료했다.
- 앱은 설치된 Development Debug 바이너리 Office2.2.4(151)/Lab1.0.5(151)와 기존 로그인 재사용. iOS `iPhone 17 Pro`/iOS26.5(`5C0E7639-2345-4B3F-9979-56AFDDA1C708`), Android `emulator-5554`/Dentlink_API_36. iOS XCTest/Maestro는 기존 충돌 이력을 따라 사용하지 않고 실제 앱의 Hermes/React 렌더와 native scroll·화면을 확인한다.
- 각 앱 Metro는 새 worktree를 사용한다(Office8081, Lab8082). 이 실행은 Codex 단독 검증용이며 독립 실행 생존성/사용자 직접 preview 구성을 검증한 것은 아니다. 기존 앱 checkout의 통합알림센터 미커밋 변경은 보존한다.
- 필요한 로컬 `.env`는 값 출력 없이 독립 복사·일치·ignore/untracked를 확인했다. Lab의 `env/.env.development`는 release에 이미 tracked되어 있어 상속 사전검사를 중단하고 기존 destination을 그대로 사용했다(원본과 내용 일치 여부만 확인, 값 관리나 tracked env 정리는 하지 않음).
- **앱 최종 런타임 통과:** Office/Lab 각각 양OS의 홈·Orders에서 관련13조건(제작3종, 완료·취소·배송·승인대기·NEW·DRAFT·Scanner Draft·Planning/Design·Pending Order)을 실제 앱 조회캐시 fixture로 렌더 검증했다. 라벨·아이콘·색·막대 및 주변 날짜/Remake/기존 지연 정책을 확인했다. Lab Ready for Fabrication의 warning/red200 및 완료+잔여IN_FABRICATION에서 기존 Lab Delayed 표시도 양OS에서 확인했다. 상태 fixture는 서버 응답을 대체하는 로컬 검증 데이터이며 실제 STG 원 제보 재현은 아니다.
- 양 앱 각 기기 조회캐시2개 데이터/옵션을 원복하고 fixture0·저장 로그인 유지·최종 Metro 연결을 확인했다. Office 검증을 끝낸 후 기기쌍을 Lab으로 함께 전환했으며 최종 화면은 양OS Lab 홈이다. Lab 구간에서 새 Dentlink/SpringBoard iOS 진단보고서0·Android crash buffer 변화 없음. 사용자 실제 계정/운영 crash-free 보장은 아니다.
- Office 최종 파일 blob `66ab1b92b22059db00d8f34cd258bd55c571828e`, 증거 `/tmp/dl-17303-office-runtime/report.json` 및 PNG/렌더 JSON. Lab blob `220a5c258fd45e2ebe2746068cd5dbff74fd07ba`, 증거 `/tmp/dl17310-runtime/report.json`, `*-results.json`, `*-home-completed.png`, `*-orders-completed.png`, `*-home-ready.png`. 이 `/tmp` 증거는 현재 Mac의 임시 파일이며 Git 저장된 지속 기록과 구분한다.
- 화면은 실제 최종 코드·설치된 호환 DEV Debug 앱으로 확인했다. 새 native build, 실제 STG 앱 수신·서비스 통합 QA·원 주문 응답·릴리즈 반영·CodePush·배포는 수행하지 않았다. PR 전달은 위 별도 기록을 따른다. 웹 synthetic48조건 및 앱 캐시 fixture 검증을 각 서비스 실데이터/배포 검증으로 확대 해석하지 않는다.

### 남은 일과 다음 시작점

1. 요청한 세 제품 커밋·푸시·각 release 대상 일반 PR 생성까지 완료했다. PR 검토/병합과 이후 릴리즈 QA·배포 지시를 기다린다. 자동 CodeRabbit 리뷰 처리·CI 모니터링은 하지 않는다.
2. 대상은 Web `release/v1.92.0`, Office `release/v2.2.4`, Lab `release/v1.0.5`다. 병합·CodePush·배포는 아직 수행하지 않았으므로 실제 릴리즈 포함이나 서비스 반영 완료로 해석하지 않는다.
3. 실제 STG 원 주문의 목록 응답·캐시와 서비스 통합 결과는 배포/QA 승인 범위에서 확인한다. 현재 코드 결함 해결이 그 주문의 직접 원인까지 입증한 것은 아니다.
4. 메인/통합알림센터에 자동 회신하지 않았다. 후속 수정이 없으면 기존 최종코드 런타임 증거를 재사용하며 무관한 검증을 늘리지 않는다.

## 작업 정의와 근거

- 정본: [DL-17303](https://innovaid.atlassian.net/browse/DL-17303), 상위 [DL-17302](https://innovaid.atlassian.net/browse/DL-17302). 최초 조사 당시 Frankie 담당 하위 카드이며 해야 할 일 상태였고 자식은 DL-17303 하나였다. 재개 후 추가한 제품 카드와 상태는 위 현재 기록을 따른다.
- 원 제보는 [DL-17138 댓글44920](https://innovaid.atlassian.net/browse/DL-17138?focusedCommentId=44920)이다. 기존 지연 라벨 작업과 다른 문제여서 새 카드로 분리됐다. 앞으로 해당 댓글은 출처로만 사용하며 완료된 지연 라벨 카드에 신규 범위를 다시 묶지 않는다.
- 제보: 주문 `7000012592`를 Completed로 변경했지만 Office 앱 홈·목록은 In Fabrication, 상세는 Completed로 보인다. 원 댓글 첨부는 앱 홈·목록이며, 통합알림센터 세션에서 전달한 STG 웹 상세 화면은 `COMPLETED` 응답과 Completed 표시가 일치했다.
- **확인된 코드 결함과 제보의 직접 원인은 구분한다.** 두 앱의 잘못된 상태 우선순위는 코드로 확인했다. 제보 주문의 실제 앱 목록 응답·캐시까지 확보한 것은 아니므로 그 주문의 직접 원인을 확정하지 않는다.
- `status`가 1차 상태다. 제작 하위 상태 `DESIGN`, `READY_FOR_FABRICATION`, `IN_FABRICATION`은 `IN_PROGRESS` 안에서만 표시를 결정한다. 완료·취소·배송·승인 대기·신규·초안을 덮어쓰면 안 된다.
- `DRAFT + SYSTEM_DRAFT`, `OFFICE_APPROVAL_PENDING + PLANNING/DESIGN`은 기존 정책대로 보존한다. `isDelayed` 판정·라벨 정책은 별도 작업이며 변경하지 않는다.
- 조사 범위는 Clinic/Lab/Admin 웹과 Office/Lab 앱의 홈·목록·상세·환자·칸반·대시보드·케이스 등 실제 상태 사용처다. 전수 검색은 이미 수행했으므로 재개 시 전부 반복하지 말고 변경 대상과 최신 차이만 확인한다.

## 최초 조사에서 정한 수정 후보 — 아래는 조사 당시 기록

### Office·Lab 앱

각 저장소의 `src/features/orderList/components/OrderProgressStatus.tsx`:

- 제작 detailStatus 라벨과 아이콘·색상·진행 막대 분기가 주 상태 확인 없이 먼저 적용된다. 제작 하위 분기에 `status === IN_PROGRESS` 조건을 붙이는 것이 확인된 수정 후보다.
- Office 조사 위치: 라벨 45–50, 시각 분기 103–127. Lab: 라벨 48–53, 시각 분기 106–129. 행 번호는 조사 당시 기준이다.
- 소비 화면은 `HomeTrackOrderCard`와 `OrderOfficeListItem`/`OrderLabListItem`이다. Lab 목록은 `isShowStatusBar={false}`라 텍스트·색상이 영향 대상이며 홈에서는 아이콘·막대까지 본다.
- 승인 대기 PLANNING/DESIGN과 Scanner Draft는 이미 주 상태 조건이 있다. 날짜·Remake·OrderStatusBadge·isDelayed는 유지한다.

### 웹 공용 주문 상세

1. `shared/ui/src/OrderDetailUI/parts/BoxComponent/OrderDetailBoxDeliverySchedule.tsx`
   - `isHideEstimatedDeliveryDateValue`: OFFICE + DESIGN/READY_FOR_FABRICATION 조건에 IN_PROGRESS 가드가 없어 다른 상태에서도 예상 배송일을 숨길 수 있다.
   - `isShowProgressEndDateEditButton`: IN_FABRICATION + 날짜만 확인해 완료/취소/배송 상태에도 기공소 편집 버튼이 남을 수 있다. IN_PROGRESS 가드가 필요하다.
2. `shared/ui/src/OrderDetailUI/parts/BoxComponent/OrderDetailBoxTitle/OrderDetailBoxTitleMobile.tsx`
   - 모바일 제목의 StatusChip이 케이스 목록의 `currentOrder.orderStatus`와 상세의 `order.detailStatus`를 혼합한다. 상세의 `order.status` + `order.detailStatus`를 한 응답 기준으로 전달하는 후보를 검토한다.
   - 혼합 입력은 코드로 확인했지만 실제 서로 다른 응답의 런타임 재현은 아직 하지 않았다.

공용 상세의 실제 소비자는 Clinic/Lab이며 Admin 직접 사용처는 발견하지 못했다. 기존 `getOrderDelayBadgeStatus` 정책은 변경하지 않는다.

### 조사에서 정상으로 확인한 사용처

- 공용 StatusChip, StatusChipOrderGraph, OrderKanbanTitle은 IN_PROGRESS 아래에서 detailStatus를 처리한다.
- Clinic PC/모바일 목록·대시보드, 데스크톱 상세·케이스 목록, Clinic/Lab/Admin 칸반의 주 상태 분기는 정상이다.
- Lab 환자 목록 recentOrderStatus 가드, ReadyForFabricationNotice·단계 집계, Admin 상태 라벨·주문 필드·요약·환자 케이스 카드도 주 상태를 먼저 처리한다.
- 필터 payload, 승인 단계, 결제 상태, 밀링 제작 상태는 별도 개념이다. 문자열 일괄 치환이나 무관한 리팩토링은 하지 않는다.

## 조사 당시 저장소 상태 — 2026-11-09

아래는 읽기 전용 조사 시점의 기록이며 향후 작업 공간 배정이나 최신 상태의 보장이 아니다. 세 기본 checkout은 다른 세션이 소유한다.

| 제품 | 저장소 | 당시 checkout | QA 릴리즈 원격 HEAD |
| --- | --- | --- | --- |
| Web/Admin | `/Users/parkjongsun/Repository/dentlink-client` | `feat/DL-17141-delay-cleanup@a4f70d33c5d4fb61767512530c8783067132d7e7` | `release/v1.92.0@33b47b677b09aa20447f97e3e927681f29905a88` |
| Office | `/Users/parkjongsun/Repository/dentlink-app` | `feature/DL-17059@1f956ae2971654159e01accfcb26350a4711da9b` | `release/v2.2.4@4892f1c1849833054453f01145b2f012782bb9da` |
| Lab | `/Users/parkjongsun/Repository/dentlink-lab-app` | `feature/DL-17060@a119ba8b3a1b09e1dbd611b90ab18ef351b628a1` | `release/v1.0.5@907832d990a59b8a26a4c06e8df6663166a6f7f6` |

- 당시 모두 clean·upstream 0/0. Web 기본 checkout은 지연 라벨, 앱 기본 checkout은 통합알림센터에서 사용 중이다. Lab 별도 `lab-delayed-api` worktree도 기존 세션 소유다.
- Web master `c5a4b5e372fb7734c72a5faec6807e7b554c1dd6`, stage `0647581382808ba19cbe75cf32d5ce0f6dd6ecdd`. 수정 후보 두 파일은 release/stage의 blob이 같았다. release의 기존 지연 관련 수정은 보존해야 한다.
- Office main `7f586790e0bbd7b288458e29f00654d38ba68da2`. 관련 컴포넌트 blob은 checkout/main/release에서 동일했다. main/release의 iOS·Android·yarn.lock은 같고 package 변경은 CodePush 스크립트였다.
- Lab main `26623e0afb80f90791de2958cbb63c96e1c93b2b`, release는 main보다 3커밋 앞섰다. DTO 타입 차이는 있으나 같은 상태 분기 문제가 확인됐다.
- 실제 화면 검증·런타임 실행은 하지 않았다. 읽기 전용 `adb devices`가 ADB daemon만 시작했으며 에뮬레이터·Metro·앱을 실행한 것은 아니다.

## 초기 인계 시 재개 계획 — 현재 결과는 위 기록을 우선

1. 개인 컨텍스트를 갱신하고 사용자가 기존 작업 종료·재개를 확인했는지 확인한다. 점유 checkout의 pull/checkout/정리부터 하지 않는다.
2. 각 저장소 live Git·작성 세션 소유권·QA 릴리즈를 다시 대조하고 필요한 작업 공간을 배정한다. 새 branch는 최신 지침의 `feat/<Jira>`이며 agent prefix는 금지다.
3. DL-17303의 Office 범위와 Web/Lab 후속 범위를 현재 Jira에서 대조한다. 필요한 제품 카드는 재개 승인 범위에서 분리하고, 부모 댓글이나 빈 카드 생성은 하지 않는다.
4. 실제 제보 주문의 목록 응답·캐시를 확인해 직접 원인을 구분하고, 위 후보 중 필요한 수정만 수행한다.
5. 앱 최종 코드로 양OS의 홈·목록을 실행한다. IN_PROGRESS + 제작 하위 상태, 완료/취소/배송/승인 대기 + 남은 제작 detailStatus, NEW/DRAFT 등의 필요한 조건에서 라벨·색상·아이콘·막대를 확인한다. Scanner Draft/승인 세부 표시·날짜·Remake·Delayed 보존도 관련 범위만 확인한다. 무관한 역할·전체 주문 경로를 늘리지 않는다.
6. 웹은 치과 날짜 숨김 조건, 기공소 편집 버튼 조건, 모바일 상세 제목/본문 상태 일치를 확인한다. 실제 날짜 수정 API 호출은 표시 확인에 필수적이지 않다. 적정 타입·린트·렌더 검사를 하고 무관한 영구 테스트/리팩토링을 추가하지 않는다.
7. 이번 릴리즈 포함을 목표로 검증 결과와 남은 위험을 보고하되, commit/push/PR·merge·CodePush·배포는 실제 승인 범위를 확인해 진행한다. 현 시점에는 이 전달 단계의 승인으로 간주하지 않는다.

## 세션 등록

- **생성·인계 완료:** `주문 상태 표시 정합성 · DL-17303`, 세션 `01a1be36-dd23-7390-b373-27275f777d4b`.
- 메인 프로젝트 폴더(`4a13e754-960d-4ca3-b716-8f7a19311b64`), 기존 Mac `local`에 등록했다. cwd는 `/Users/parkjongsun/Documents/ChatGPT/메인 프로젝트`이며 새 제품 폴더·worktree는 만들지 않았다.
- 메인 실제 설정과 같은 **gpt-6-astra / ultra**를 명시해 생성했고 새 세션의 turn_context에서 실제 적용을 확인했다. 한 번의 등록 조회에서 초기 프롬프트와 “개인 지침·인계 문서만 읽고 제품 작업·추가 조사 없이 대기”라는 초기 응답을 확인했다. 이후 진행 조회는 하지 않는다.
- 초기 개인 체크포인트·색인·메인 조율 기록의 저장과 commit/push는 메인세션이 맡는다. 새 세션은 같은 파일을 중복 편집하지 않고 인계 이해 후 대기한다.
- 초기 등록과 Git-backed 기록 보존은 확인하며, 휴대폰에서의 실제 목록 노출은 사용자 확인과 구분한다.
