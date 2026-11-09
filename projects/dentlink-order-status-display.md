# Dentlink 주문 상태 표시 정합성 — DL-17303

## 현재 상태 — 2026-11-09

- **접수·조사 완료, 구현 대기.** 사용자는 이번 릴리즈에 포함할 작업으로 지정했지만, 다른 세션이 사용 중인 checkout을 보존하고 기존 작업이 끝난 후 진행하도록 했다. 새 임시 worktree 3개를 즉시 만드는 제안은 채택하지 않았다.
- 메인 프로젝트 폴더의 별도 기능 세션에 웹·Office·Lab의 조사 결과를 함께 인계했다. 신규 폴더·branch·worktree, 제품 코드·Jira 변경, 제품 commit/push/PR·배포는 아직 없다.
- 현재 QA 릴리즈 후보는 Web `release/v1.92.0`, Office `release/v2.2.4`, Lab `release/v1.0.5`다. 사용자는 이번 릴리즈 포함을 요구했으며, 실제 재개 때 최신 ref와 대상 제품·카드를 다시 대조한다.
- **재개 조건:** 사용자가 기존 작업 완료와 재개를 알리면 실행한다. 기존 세션 완료를 자동 조회하거나 폴링하지 않는다. 등록·인계가 끝나면 메인도 추가 감독 없이 대기한다.
- 세션 ID·모델·등록 증거는 아래 세션 등록 항목에 기록한다. 이 문서가 조사 상세 정본이며 메인 문서는 배정·대기 상태만 유지한다.

## 작업 정의와 근거

- 정본: [DL-17303](https://innovaid.atlassian.net/browse/DL-17303), 상위 [DL-17302](https://innovaid.atlassian.net/browse/DL-17302). 확인 당시 Frankie 담당 하위 카드이며 해야 할 일 상태다. 상위에 생성된 하위 카드는 DL-17303 하나였다.
- 원 제보는 [DL-17138 댓글44920](https://innovaid.atlassian.net/browse/DL-17138?focusedCommentId=44920)이다. 기존 지연 라벨 작업과 다른 문제여서 새 카드로 분리됐다. 앞으로 해당 댓글은 출처로만 사용하며 완료된 지연 라벨 카드에 신규 범위를 다시 묶지 않는다.
- 제보: 주문 `7000012592`를 Completed로 변경했지만 Office 앱 홈·목록은 In Fabrication, 상세는 Completed로 보인다. 원 댓글 첨부는 앱 홈·목록이며, 통합알림센터 세션에서 전달한 STG 웹 상세 화면은 `COMPLETED` 응답과 Completed 표시가 일치했다.
- **확인된 코드 결함과 제보의 직접 원인은 구분한다.** 두 앱의 잘못된 상태 우선순위는 코드로 확인했다. 제보 주문의 실제 앱 목록 응답·캐시까지 확보한 것은 아니므로 그 주문의 직접 원인을 확정하지 않는다.
- `status`가 1차 상태다. 제작 하위 상태 `DESIGN`, `READY_FOR_FABRICATION`, `IN_FABRICATION`은 `IN_PROGRESS` 안에서만 표시를 결정한다. 완료·취소·배송·승인 대기·신규·초안을 덮어쓰면 안 된다.
- `DRAFT + SYSTEM_DRAFT`, `OFFICE_APPROVAL_PENDING + PLANNING/DESIGN`은 기존 정책대로 보존한다. `isDelayed` 판정·라벨 정책은 별도 작업이며 변경하지 않는다.
- 조사 범위는 Clinic/Lab/Admin 웹과 Office/Lab 앱의 홈·목록·상세·환자·칸반·대시보드·케이스 등 실제 상태 사용처다. 전수 검색은 이미 수행했으므로 재개 시 전부 반복하지 말고 변경 대상과 최신 차이만 확인한다.

## 구현 후보 — 현재는 수정하지 않음

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

## 재개 시 확인·검증 계획

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
