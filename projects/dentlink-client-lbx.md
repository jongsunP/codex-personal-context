# Dentlink Admin LBX — DL-16279 / DL-16387

## 현재 체크포인트 — 2026-09-21, 로컬 구현

- **사용자의 구현 지시 후 기존 Admin 목록·상세와 Baby/Mother/LBX 픽업 모달을
  구현했다.** 제품 코드는 아직 로컬 미커밋 상태이며 제품 commit/push/PR/배포는
  하지 않았다. 이전의 구현 미착수 체크포인트보다 이 상태가 우선한다.
- `GET /admin/shipments`의 `isConsolidated` 필터는 개발 서버 Swagger와 로컬
  생성 코드 모두에서 확인됐다. 남은 백엔드 보충은 **Baby 생성 대상 주문 조회용
  별도 신규 API**다. 기존 `POST /admin/orders/search`를 확장하는 방식은 채택하지 않는다.
- 신규 주문 API의 단일 연결부는
  `admin/src/services/shipment/consolidation.orders.ts`다. 현재 빈 목록과 준비 중
  상태를 제공하며 미확정 endpoint를 만들거나 가짜 주문 ID를 생성 요청에 넣지 않는다.
  주문 다중 선택과 제출 payload는 구현되어 해당 함수와 준비 상태만 교체하면 된다.
- **사용자가 요청 금지의 의미를 명확히 정정했다:** 제품의 조회·생성·수정 코드는
  실제 API에 정상 연결한다. Codex가 테스트를 위해 생성·수정 요청을 실제 서버에
  보내지 말라는 뜻이다. 조회는 정상 수행하고 제품 코드에서 API를 막지 않는다.
  임시 처리는 **아직 없는 Baby 생성 대상 주문 조회 API 한 곳뿐**이다.
- 초기에 이 제한을 넓게 해석해 만든 제품 모의 transport/fixtures는 모두 제거했다.
  별도 QA 스크립트의 네트워크 fixture는 `/tmp`에만 두며 제품에 포함하지 않는다.
- 현재 범위는 Admin이다. 별도 Lab/Clinic 페이지나 네이티브 앱 기능은 추가하지 않는다.

## 출처, 작업 위치와 권한

- 상위 Jira: [DL-16279 — LBX 작업](https://innovaid.atlassian.net/browse/DL-16279)
- 우선 요구사항: [DL-16387 — 어드민 UI 초안 작업](https://innovaid.atlassian.net/browse/DL-16387)
- **사용자의 최신 합의 → Jira에 적힌 텍스트 → 참고 화면** 순으로 해석한다.
  PM의 예시 화면은 실제 사양이 아니며 Office나 픽업 흐름이 빠질 수 있다.
- 별도 Admin 디자인을 기다리지 않는다. 기존 Admin의 UI와 코드 작성 방식 모두를
  따른다. 실제로 없는 기능만 새로 만들고 폼·모달·검색·테이블을 최대한 재사용한다.
- 제품 저장소: `https://github.com/Innvoaid/dentlink-client`
- 읽기 검토한 제품 체크아웃: `/Users/parkjongsun/Repository/dentlink-client`
- 현재 작업 폴더: `/Users/parkjongsun/Documents/ChatGPT/FE` — 제품 저장소가 아니다.
- 기능 작업: `DL-16279 요구사항 검토`, task ID
  `01a0c2c0-3e4d-7a42-867d-9c80f3fee241`.
- 개인 기록의 정본은 이 파일이다. FE 전체 기록은 [dentlink-fe.md](dentlink-fe.md)에
  연결만 유지한다. 공유 제품 저장소에 개인 세션 기록을 만들지 않는다.
- 사용자는 코드 구현과 로컬 검증을 승인했다. 브랜치/worktree 생성, 제품
  commit/push, PR/Jira 변경과 배포는 하지 않았다. 구현과 Git/배포 권한을 구분한다.

## 환경별 기공소 정책

- **prd: IDS, `labId=129` 하드코딩·고정.** UI도 IDS 선택 상태로 사용한다.
- **그 외 환경: 기공소 제한 없음.** 기존 이름 검색·선택 UI로 기공소를 선택한다.
- 코드의 운영 환경 구분 관례는 `NEXT_PUBLIC_ENV === "production"`이다.
- 선택/고정한 기공소 ID가 Baby 생성과 픽업 조회·요청에 반영된다.
- `129=IDS`는 사용자가 지정한 값이다. 실제 기공소 데이터를 조회해 검증한 것은 아니다.

## 페이지와 표시 규칙

| 기존 페이지 | 추가/재사용할 내용 |
| --- | --- |
| `/shipments` | Baby 생성, Mother 생성, **LBX 픽업생성** 버튼과 각각의 폼 모달; Baby만 보기 필터; Mother 번호 컬럼 |
| `/shipments/[shipment_id]` | 기존 상세 폼에 Mother 번호·문서·생성 시각·연결 Baby 항목 추가 |
| `/pickup/outbound` | LBX 픽업 생성 성공 후 이동할 기존 픽업 목록 |
| `/pickup/outbound/[pickup_outbound_id]` | 이후 픽업 상세를 조회할 기존 화면 |

- 신규 독립 페이지를 만들지 않는다. 신규 UI 단위는 배송 목록에서 여는 폼 모달 3개다.
- 목록은 기존 Layout/DataFilters/DataList/DataPagination, 상세는 기존 DataForm
  항목 형식을 따른다. 버튼·검색·다운로드·ID 링크도 기존 방식에 맞춘다.
- Mother 관련 값이 있으면 기존 UI 방식으로 표시하고 **없으면 해당 칸은 빈칸**이다.
  일반 배송과 LBX 배송은 같은 목록·상세 화면을 사용한다.
- **Mother 무상 대체 사유서는 사용자 지시로 범위에서 제외했다.** 문서 타입에
  없다는 점을 미결 질문이나 구현 차단 사유로 다시 올리지 않는다.
- 기존 상세의 주문 ID 표시와 기존 배송 자체 문서는 그대로 활용한다. 기존 배송의
  무상 대체 사유서를 Mother 문서로 바꿔 표시해서는 안 된다.

## 모달별 확정 흐름

### Baby 생성

1. 환경 정책에 따른 기공소와 해당 Office를 선택한다. Office는 ID 직접 입력이
   아니라 **이름 검색/선택 → ID 보관** 방식이다.
2. 선택한 기공소·Office의 **Baby 생성 가능 주문**을 별도 신규 API로 조회하고
   여러 주문을 선택한다. API 전에는 연결부에서 빈 목록을 반환하고 준비 중임을
   표시한다. 미확정 경로·응답을 합의된 계약인 것처럼 만들지 않는다.
3. Mother 번호 목록 조회에 `statuses: ["AVAILABLE", "BABY_REGISTERED"]`를 적용한다.
4. `motherNumber`, `labId`, `officeId`, `orderIds`로 Baby 생성 계약을 구성한다.
5. 성공 흐름은 모달을 닫고 기존 배송 목록으로 돌아간다. 목록 반영은 기존 재조회
   패턴과 Jira의 생성 후 새로고침 안내를 기준으로 구성한다.

### Mother 생성

1. Mother 번호 목록 조회에 `statuses: ["BABY_REGISTERED"]`만 적용한다.
2. 선택한 Mother 번호로 운송장을 생성한다. 요청 body는 없다.
3. 성공 흐름은 모달을 닫고 기존 배송 목록으로 돌아간다.

### LBX 픽업생성

1. 기존 배송 목록의 버튼 이름은 정확히 **`LBX 픽업생성`**이다. 현재 이 기능은
   LBX 전용이며 일반 픽업 생성 기능으로 범위를 넓히지 않는다.
2. **기존 기공소에서 쓰는 픽업 UI/폼을 재사용**한다. Office 선택은 필요하지 않다.
3. 기존 배송 목록 API에 **`isConsolidated=true` + `shipperId=labId`**를 적용해
   해당 기공소의 Baby 배송을 조회한다. **`receiverId`/Office 필터는 넣지 않는다.**
4. 배송을 여러 개 선택하고 기존 픽업 폼의 날짜·시간·픽업 위치·연락처를 사용한다.
   연락처는 기존 기공소 픽업 UI의 전화번호 초기값/동작을 따른다.
5. `labId`, `shipmentIds`, `pickup`으로 요청 계약을 구성한다. Office ID는 없다.
6. 성공 후 **`/pickup/outbound`로 이동**한다. 이후 목록·상세 조회는 현재 화면과
   흐름을 사용하며 LBX 전용 픽업 목록·상세 페이지를 만들지 않는다.

## API 계약과 확인 범위

2026-09-21 이 대화에서 개발 서버의
[OpenAPI 명세](https://dev-api.dentlink.io/v3/api-docs)를 읽기 전용 GET으로 조회해
HTTP 200과 아래 계약을 확인했다. 이는 **명세 반영 확인**이며 업무 API를 호출한
실동작 검증이나 운영 배포 확인은 아니다. 이 메모리 저장 턴에서는 재호출하지 않았다.

| 기능 | 계약 | 핵심 내용 |
| --- | --- | --- |
| 배송 목록 | `GET /admin/shipments` | 선택적 boolean query `isConsolidated`; `shipperId`, `receiverId`, `motherNumber` 등 기존 필터 유지 |
| Mother 번호 조회 | `GET /admin/shipments/consolidations/mother-numbers` | query 이름은 복수형 `statuses`; `AVAILABLE`, `BABY_REGISTERED`, `USED` |
| Baby 생성 | `POST /admin/shipments/consolidations/babies` | `motherNumber`, `labId`, `officeId`, `orderIds`; 응답에 `shipmentId`, `trackingCode`, `pieceTrackingNumber` |
| Mother 생성 | `POST /admin/shipments/consolidations/mothers/{motherNumber}/waybill` | body 없음; 응답에 `motherNumber`, `closedAt`, `documents` |
| Baby 픽업 | `POST /admin/shipments/consolidations/pickups` | `labId`, `shipmentIds`, `pickup`; 응답에 `pickupRequestNumber` |
| Baby 생성 대상 주문 | **별도 신규 API 대기** | 정확한 경로·method·입출력은 미확인; 기존 `/admin/orders/search` 확장안은 사용하지 않음 |

- `isConsolidated`는 로컬 `shared/models/src/Admin.ts`에도
  `isConsolidated?: boolean`으로 반영됐다. 일반 목록의 Baby만 보기와 픽업 대상
  조회에서 재사용한다. boolean `false`의 서버 의미를 추가로 추정하지 않는다.
- `statuses`를 생략하면 전체 상태를 조회하는 계약이므로 각 생성 모달에서 위 조건을
  명시한다. `USED`는 두 생성 모달의 선택 목록에 포함하지 않는다.
- 목록 DTO의 `motherNumber`와 상세 DTO의 `consolidation`이 추가됐다.
  상세 `consolidation`에는 `motherNumber`, `status`, `waybillCreatedAt`,
  `documents`, `shipmentIds`가 있다. 일반 배송의 consolidation은 null이다.
- 상세의 `consolidation.shipmentIds`는 같은 Mother에 연결된 **다른 배송 ID**이며
  조회 중인 배송 자체는 제외한다. 화면에서 현재 배송을 임의로 중복 추가하지 않는다.
- Mother 문서 타입은 `LABEL`, `COMMERCIAL_INVOICE`, `PACKING_LIST`, `DECLARATION`이다.
  생성 전 문서 목록은 비어 있고 생성 시각은 null일 수 있다.
- `PickupDto`는 `pickupDate`, `pickupTime`, `locationType`, `location`,
  `contactPhone`, `contactEmail` 필드를 가진다. 현재 타입의 optional/null 선언과
  UI 검증은 구분하고 기존 기공소 폼을 참고한다.
- 기존 `POST /admin/orders/search`는 `labId`, `officeId`, 상태 검색과 배송 주문
  추가에 쓰인다. 그러나 Baby 생성 적격 여부를 보장하는 계약은 아니다. 예전
  `NEW/IN_PROGRESS` 조건이나 일반 `isShippable` 응답을 LBX 정책으로 임의 채택하지 않는다.

## 재사용할 코드 출발점

아래 경로는 모두 `/Users/parkjongsun/Repository/dentlink-client` 기준이다.
재개 시 실제 코드와 최신 계약을 다시 대조하며 generated 이름 변경을 수기 wrapper의
자동 변경으로 오해하지 않는다.

- Admin 화면: `admin/src/pages/shipments/index.tsx`,
  `admin/src/pages/shipments/[shipment_id].tsx`,
  `admin/src/lib/Shipment/useShipmentFields.tsx`.
- 기공소/Office 이름 검색: `admin/src/components/EmployerFindDropdownList/`,
  `admin/src/lib/EmployerFindDropdownList/`. LAB/OFFICE 이름을 표시하고 ID를 값으로 보관한다.
- 기공소 기준 Office 목록 후보:
  `admin/src/lib/OfficeFindDropdownList/useEmployerFindDropdownList.ts`와
  `shared/models/src/order/order.apis.admin.ts`의 `getOrderOffices1`
  (`GET /admin/orders/offices?labId=...`, 주문 이력 있는 Office 목록).
- 기존 주문 추가 사례: `admin/src/components/Shipment/ShipmentAddOrderForm.tsx`,
  `admin/src/queries/order.queries.ts`. 다중 선택 primitive는
  `shared/ui/src/DropdownUI/ComboboxDropdown.tsx`의 `multiple`을 참고한다.
- 기존 픽업 폼 본문:
  `shared/ui/src/ShippingPickupUI/PickupRegisterUI/PickupRegisterUIModalBody.tsx`.
  배송 복수 선택·날짜시간·위치·연락처를 조합하며 Office는 `officeList`가 있을 때만 표시한다.
- 픽업 날짜·연락처:
  `shared/ui/src/ShippingPickupUI/CommonUI/ShippingPickupRegisterDatePicker.tsx`,
  `shared/ui/src/ShippingPickupUI/CommonUI/ShippingPickupRegisterPhoneNumber.tsx`.
  전화번호 초기값은 `PickupRegisterUI/PickupRegisterUI.tsx`의 기존 동작을 참고한다.
- 기공소 픽업 폼 검증과 payload 변환: `lab/src/lib/Pickup/usePickupList.tsx`.
  `pickupTime`은 `HH:mm`; 선택값 `{id, orderIds}[]`에서 전송용 `shipmentIds:number[]`로
  맞추는 기존 흐름을 참고한다. **Lab hook을 그대로 가져오면 Lab API/SSE가 실행되므로
  UI/폼 패턴을 재사용하고 데이터 연결은 Admin 계약에 맞춘다.**
- 기존 Admin 픽업 화면: `admin/src/pages/pickup/outbound/index.tsx`,
  `admin/src/pages/pickup/outbound/[pickup_outbound_id]/index.tsx`.
- API/모델 연결은 현재 프로젝트의 `shared/models/src/shipment/`와 Admin query/hook
  패턴을 따른다. 생성 파일에 필드가 있다고 수기 API wrapper/types까지 연결된 것은 아니다.

## 제품 연결과 테스트 기준 — 사용자 정정 반영

- 제품의 기공소/Office 조회, Mother 번호 조회, 배송 조회와 상세/픽업 조회는 기존
  실제 API에 연결한다. Baby/Mother/픽업 생성 wrapper도 정상 HTTP 호출 코드다.
- 제품에 요청 차단용 Axios interceptor/adapter, fixture 데이터나 모의 저장소를
  넣지 않는다. 테스트를 수행할 때만 생성·수정 요청의 실제 서버 전송을 피한다.
- 아직 없는 주문 조회 API만 임시 연결부를 둔다. API가 나오면 정확한 계약을
  확인해 이 함수를 실제 조회로 교체한다. 기존 `/admin/orders/search`로 대체하지 않는다.
- 로컬 자동 UI 검증은 별도 Playwright context에서 요청을 관측하고 테스트 fixture로
  응답한다. 이는 테스트 도구에만 있는 처리이며 실제 서버 연동 QA 증거는 아니다.
- Lab 픽업 hook을 통째로 가져오면 Lab API/SSE가 실행되므로 UI primitive와 검증
  패턴만 재사용하고 데이터/생성은 Admin 계약으로 연결했다.

## 구현 파일과 동작

- 기존 변경: `admin/src/pages/shipments/index.tsx`,
  `admin/src/lib/Shipment/useShipmentFields.tsx`,
  `admin/src/components/DataGrid/DataFilters.tsx`,
  `shared/models/src/shipment/shipment.apis.admin.ts`,
  `shared/models/src/shipment/shipment.types.ts`.
- 신규: `admin/src/components/Shipment/ConsolidationBabyForm.tsx`,
  `ConsolidationMotherForm.tsx`, `ConsolidationPickupForm.tsx`,
  `admin/src/lib/Shipment/useConsolidationForm.ts`,
  `admin/src/services/shipment/consolidation.query.ts`, `consolidation.orders.ts`.
- 모달 3개는 기존 DataForm/검색/ComboboxDropdown을 재사용한다. 기공소·Office
  변경 시 하위 선택을 초기화하고 필수값/선택 목록 검증, 중복 클릭 방지와 오류
  표시를 적용했다. 제출 중에는 모달 닫기와 재진입에 의한 중복 요청도 방지한다.
- 기존 공유 filter switch가 검색 전 입력값을 반영하지 않는 문제를 수정했다.
  switch만 현재 입력 state를 읽도록 최소 변경했고 다른 필터 형식은 유지했다.
- Mother 목록 컬럼은 너비 140px와 빈 React fragment로 값 없는 칸의 기본 `-`
  대체 표시를 피했다. 상세에는 기존 필드 정의를 통해 네 항목이 표시된다.
- Mother 상태 배열은 `statuses=AVAILABLE&statuses=BABY_REGISTERED`처럼 반복
  쿼리로 직렬화한다. 성공 시 관련 목록/상세/query cache를 재조회하고 픽업은 기존
  `/pickup/outbound`로 이동한다. 기존 픽업 페이지 자체를 새로 작성하지 않았다.

## 제품 Git 상태와 검증 경계

- 2026-09-21 구현 시 로컬 제품 checkout은 `master`, HEAD
  `de2ffdd9e3025cb758632788cd6086c170e4974e`였다. 시작 시 개인 컨텍스트와 제품
  저장소를 `git pull --ff-only`로 갱신했고 당시 제품은 Already up to date였다.
- 사용자는 Swagger 생성 스크립트를 실행했다고 알렸다. 현재 수정된 제품 파일은
  `shared/models/src/Admin.ts`, `Lab.ts`, `Office.ts`, `data-contracts.ts` 4개다.
  생성 diff에는 LBX 외 변경도 섞여 있다. 위 4개 생성 파일의 사용자 변경
  1968 insertions / 268 deletions를 보존했고 FE 구현은 별도 11개 파일에 있다.
- 생성 파일을 덮어쓰거나 되돌리지 않았고, 이 작업의 feature branch/worktree도
  만들지 않았다. 개인 메모리 작업 때문에 제품 저장소를 commit/push하지 않는다.
- 코드/타입/로컬 UI 검증과 실제 백엔드 연동·배포 증거를 구분한다. 테스트에서
  실제 서버로 LBX 생성·수정 요청을 보내지 않았다. 운영 build/배포/실연동 QA는
  이번 완료 범위가 아니다.

### 최종 로컬 검증

- Admin 전체 `tsc --noEmit --incremental false --pretty false`: exit 0, 진단 0.
- 구현 11개 파일 ESLint: exit 0, 오류 0. 기존 `DataFilters.tsx`의 미사용 변수와
  effect dependency 경고 5개는 남아 있으며 이번 변경이 만든 경고는 없다.
- 구현 파일 Prettier 검사와 `git diff --check`: 통과. 사용자의 generated 파일은
  포맷팅·재생성하지 않았다.
- 별도 Playwright 테스트의 개발 조건 10개 + 운영 환경 변수 조건 10개, **20개 통과**.
  목록/상세 빈칸, Mother 번호 표시, 필터 on/off/Reset/URL 복원, IDS 고정/다른
  기공소 선택, 주문 API 준비 안내/빈 선택/필수 검증, Mother 상태 필터와 문서,
  픽업 Office 없음/복수 선택/기존 목록·상세/새로고침 재조회를 확인했다.
- Mother POST 응답을 테스트에서 잠시 보류하고 Esc/X/취소와 연속 클릭을 확인했다.
  처리 중 모달은 유지됐으며 POST는 한 번만 발생했다. 테스트 PDF 4종도 다운로드했다.
- 제품 코드의 정상 GET/POST 요청을 테스트 route에서만 응답했다. 개발 38회,
  운영 조건 35회를 테스트 내부 처리했고 실제 업무 서버 전송과 런타임 예외는 0건이다.
  운영 서버·실사용자 데이터에 대한 검증이 아니다. 외부 폰트 CSS는 테스트에서 차단했다.
- **Baby 생성 성공의 최종 UI 검증은 미완성 주문 API 때문에 대기**다. 주문 다중 선택과
  payload는 구현되어 있지만 실제 적격 주문을 조회할 수 없어 완료로 표시하지 않는다.
- 로컬 증거:
  `/tmp/dentlink-lbx-qa/2026-09-21T09-10-46-220Z-development-81988/report.json`,
  `/tmp/dentlink-lbx-qa/2026-09-21T09-10-46-220Z-production-81989/report.json`.
  테스트 스크립트/fixture/스크린샷은 `/tmp/dentlink-lbx-qa/`에만 있으며 다른 장치로
  전송되는 체크포인트가 아니다. 제품 저장소에 테스트 전용 모의 코드가 들어있지 않다.
- 검증용 Next 서버 3004/3005와 테스트 브라우저는 종료했다. 기존 사용자 3002
  서버와 다른 DLDS worktree는 건드리지 않았다.

## 남은 일과 다음 시작점

1. 재개 시 개인 컨텍스트와 제품 Git을 갱신하되 현재 사용자 생성 변경과 구현
   미커밋 변경을 보존한다. 이 기능을 아직 미착수로 취급하지 않는다.
2. Baby 대상 주문용 별도 API가 나오면 명세/생성 코드를 확인하고
   `consolidation.orders.ts`의 함수와 준비 상태만 교체한다. 미완성이라 현재
   Baby 생성의 전체 실제 주문 선택 흐름은 완료되지 않았다.
3. 조회·생성 wrapper에 임시 차단을 다시 넣지 않는다. Codex의 검증에서 생성·수정
   실전송을 피하라는 조건을 제품 기능 제한으로 확대하지 않는다.
4. 실제 연동 확인과 제품 commit/push/PR/배포는 각각 허용된 범위에서 진행한다.

## 결정 이력 — 2026-09-21

- 초기 예시 화면 대신 Jira 텍스트를 우선하고 별도 Admin 디자인은 만들지 않기로 했다.
- 사용자의 Swagger 생성 후 Baby/Mother/픽업/번호 목록 계약을 확인했다.
- 기공소 고정은 모든 환경이 아니라 **prd IDS 129만**, 나머지 환경은 제한을 풀었다.
- Baby 필터의 임시 명칭 `isLbxBaby`는 **`isConsolidated`**로 확정·명세 반영됐다.
- Mother 무상 대체 사유서 공백은 추가 요구가 아니라 **범위 제외**로 해소됐다.
- 주문 목록은 기존 Admin 검색도 검토했으나 최종적으로 **별도 신규 API**를 기다린다.
- 픽업의 Office 선택/받는 그룹 필터 제안은 사용자 정정으로 폐기했다. 기존 기공소
  픽업 UI와 `isConsolidated + shipperId` 조회를 사용하고 기존 outbound 화면으로 이어진다.
- 따라서 초기의 필터명·문서 종류·픽업 Office/독자 규칙 관련 미결 기록보다 이 파일의
  최신 합의가 우선한다. 현재 남은 백엔드 보충은 Baby 생성 대상 주문 조회 하나다.
- 구현 중 사용자가 실제 요청 제한을 세 차례 정정했다. **제품 API는 정상 연결,
  테스트 시 생성·수정 실전송만 피함, 임시는 미완성 주문 API 한 곳뿐**이라는 최종
  지시가 이전의 모든 요청 차단/모의 성공 흐름 해석보다 우선한다.
