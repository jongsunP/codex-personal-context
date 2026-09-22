# Dentlink Admin LBX — DL-16279 / DL-16387

## 현재 체크포인트 — 2026-09-22, 릴리스·개발 대상 PR 각각 생성 / 배포 전 전체 검토 대기

- `feature/DL-16387`를 `release/v1.87.0`에 맞춰 갱신하고
  [PR #4623](https://github.com/Innvoaid/dentlink-client/pull/4623)을 열었다.
  원격과 로컬 HEAD는 `a7c45172d51f98fb837b52551bbd2c9aa4106a1d`로 일치하며
  제품 작업 트리는 clean이다. PR은 열려 있고 병합·배포는 하지 않았다.
- 개발 서버 검증용으로 `origin/develop`에서 별도 `feature/DL-16387-develop`
  브랜치를 만들고 [PR #4624](https://github.com/Innvoaid/dentlink-client/pull/4624)를
  열었다. HEAD `5beef2133946c97df8bc18856c35d4684cddc860`, 원격과 일치하며
  작업 트리는 clean이다. 릴리스 PR #4623과 개발 PR #4624 모두 OPEN이다.
- 2026-09-21 구현 후 요청받은 배송 필터 위치·LBX 명칭·픽업 연락처 초기 오류
  표시를 수정했다. 전체 UI·UX/실제 흐름 검토는 여전히 배포 전 필수 다음 작업이다.
  실제 서버로 LBX 생성·수정 테스트 요청을 보내지 않는 조건도 유지한다.
- `isConsolidated`에 이어 Baby 대상 주문 API도 개발 Swagger에서 확인했다.
  사용자 안내대로 **`GET /admin/orders/shippable`**이며 `labId`와 `officeId`가
  모두 필수다. Lab의 shippable DTO와 페이지 응답 구조를 재사용한다.
- `admin/src/services/shipment/consolidation.orders.ts`를 실제 Admin GET으로
  교체하고 예시 주문 5개를 제거했다. 여러 페이지를 모두 모아 기존 로컬 검색과
  복수 선택 UI에 제공하며 기공소/Office 변경 시 진행 중 조회를 취소한다.
  기존 임시 주문 캐시가 남지 않도록 query key도 분리했다.
- **사용자가 요청 금지의 의미를 명확히 정정했다:** 제품의 조회·생성·수정 코드는
  실제 API에 정상 연결한다. Codex가 테스트를 위해 생성·수정 요청을 실제 서버에
  보내지 말라는 뜻이다. 조회는 정상 수행하고 제품 코드에서 API를 막지 않는다.
  신규 주문 조회까지 연결해 현재 제품에 임시 주문 데이터는 없다.
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
- 사용자는 코드 구현/로컬 검증에 이어 종료 시 **별도 브랜치 생성과 commit/push**를
  명시적으로 승인했다. `codex/` 접두사를 지적했으므로 저장소 관례인 `feature/`를 따른다.
  별도 worktree, PR/Jira 변경, 병합/배포는 이번 범위에 포함하지 않는다.

## 환경별 기공소 정책

- **prd: IDS, `labId=129` 하드코딩·고정.** UI도 IDS 선택 상태로 사용한다.
- Baby/픽업 모두 운영에서는 같은 검색 입력 UI에 **`IDS (129)`를 disabled로 고정**한다.
  초기의 일반 텍스트 표시를 후속 사용성 요청에 따라 입력 UI로 맞췄다.
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
   여러 주문을 선택한다. 현재 `GET /admin/orders/shippable?labId=...&officeId=...`에
   연결됐으며 대상 여부는 서버 응답을 따른다.
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
실동작 검증이나 운영 배포 확인은 아니다. 신규 shippable 연결 시 명세를 재조회했다.

| 기능 | 계약 | 핵심 내용 |
| --- | --- | --- |
| 배송 목록 | `GET /admin/shipments` | 선택적 boolean query `isConsolidated`; `shipperId`, `receiverId`, `motherNumber` 등 기존 필터 유지 |
| Mother 번호 조회 | `GET /admin/shipments/consolidations/mother-numbers` | query 이름은 복수형 `statuses`; `AVAILABLE`, `BABY_REGISTERED`, `USED` |
| Baby 생성 | `POST /admin/shipments/consolidations/babies` | `motherNumber`, `labId`, `officeId`, `orderIds`; 응답에 `shipmentId`, `trackingCode`, `pieceTrackingNumber` |
| Mother 생성 | `POST /admin/shipments/consolidations/mothers/{motherNumber}/waybill` | body 없음; 응답에 `motherNumber`, `closedAt`, `documents` |
| Baby 픽업 | `POST /admin/shipments/consolidations/pickups` | `labId`, `shipmentIds`, `pickup`; 응답에 `pickupRequestNumber` |
| Baby 생성 대상 주문 | `GET /admin/orders/shippable` | 필수 `labId`, `officeId`; 선택 `patientName`, `orderId`, `page`, `size`, `sort`; `ShippableOrderDto[]`와 페이지 메타데이터 |

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
- 주문 조회도 실제 shippable GET으로 연결했다. 기존 `/admin/orders/search`는 사용하지
  않는다. 빈 목록·오류를 예시 데이터로 대체하지 않는다.
- 로컬 자동 UI 검증은 별도 Playwright context에서 요청을 관측하고 테스트 fixture로
  응답한다. 이는 테스트 도구에만 있는 처리이며 실제 서버 연동 QA 증거는 아니다.
- Lab 픽업 hook을 통째로 가져오면 Lab API/SSE가 실행되므로 UI primitive와 검증
  패턴만 재사용하고 데이터/생성은 Admin 계약으로 연결했다.

## 구현 파일과 동작

- 기존 변경: `admin/src/pages/shipments/index.tsx`,
  `admin/src/lib/Shipment/useShipmentFields.tsx`,
  `admin/src/components/DataGrid/DataFilters.tsx`,
  `shared/models/src/shipment/shipment.apis.admin.ts`,
  `shared/models/src/shipment/shipment.types.ts`,
  `shared/models/src/order/order.apis.admin.ts`, `order.types.ts`.
- 신규: `admin/src/components/Shipment/ConsolidationBabyForm.tsx`,
  `ConsolidationMotherForm.tsx`, `ConsolidationPickupForm.tsx`,
  `admin/src/lib/Shipment/useConsolidationForm.ts`,
  `admin/src/services/shipment/consolidation.query.ts`, `consolidation.orders.ts`.
- 후속 모달 보완으로 `admin/src/components/EmployerFindDropdownList/EmployerFindDropdownList.tsx`와
  `shared/ui/src/ShippingPickupUI/CommonUI/`의 DatePicker/Email/PhoneNumber/PickupPlace
  4개 컴포넌트도 수정했다. `isLabel` 선택 prop의 기본값은 기존과 같고 Admin LBX에서만
  false를 전달해 표의 항목명과 내부 라벨/placeholder가 겹치지 않게 했다.
- 모달 3개는 기존 DataForm/검색/ComboboxDropdown을 재사용한다. 기공소·Office
  변경 시 하위 선택을 초기화하고 필수값/선택 목록 검증, 중복 클릭 방지와 오류
  표시를 적용했다. 제출 중에는 모달 닫기와 재진입에 의한 중복 요청도 방지한다.
- 기존 공유 filter switch가 검색 전 입력값을 반영하지 않는 문제를 수정했다.
  switch만 현재 입력 state를 읽도록 최소 변경했고 다른 필터 형식은 유지했다.
- 후속 사용자 제보의 React 중복 key 경고도 수정했다. 펼친 배송 필터의 ID 입력과
  이름 검색이 동일한 `shipperId`/`receiverId`를 사용하므로 렌더 key를
  `field + label`로 구분했다. API 검색 field와 요청 파라미터는 유지한다.
  별도 브라우저 검증에서 필터 펼침/접기 반복, ID 검색, 초기화, 입력란 중복/누락
  없음과 duplicate-key console 경고 0건을 확인했다. GET 6개를 테스트에서만
  응답했고 생성·수정 요청은 0건이었다. 증거는
  `/tmp/dentlink-lbx-qa/2026-09-21T09-26-25-469Z-development-95210/report.json`이다.
- Mother 목록 컬럼은 너비 140px와 빈 React fragment로 값 없는 칸의 기본 `-`
  대체 표시를 피했다. 상세에는 기존 필드 정의를 통해 네 항목이 표시된다.
- Mother 상태 배열은 `statuses=AVAILABLE&statuses=BABY_REGISTERED`처럼 반복
  쿼리로 직렬화한다. 성공 시 관련 목록/상세/query cache를 재조회하고 픽업은 기존
  `/pickup/outbound`로 이동한다. 기존 픽업 페이지 자체를 새로 작성하지 않았다.
- 모달 3개는 폭 900px, 최소 높이 720px 기준으로 통일했다. 높이는 화면 높이에서
  108px을 뺀 값으로 제한해 작은 화면에서는 본문을 스크롤할 수 있다.
- Baby/Mother 번호 선택은 API 응답 목록을 쓰는 **검색 없는 SelectDropdown**이다.
  최신 UX 정정으로 **빈 목록·조회 상태·선행 선택 안내는 드롭다운 밖에 한 번만
  표시**하고, 선택할 수 없는 상태에서는 드롭다운을 비활성화한다. Baby의 Mother와
  Mother 생성 모달도 동일하다. 검색어 불일치만 목록 안에서 검색 결과 없음으로 표시한다.

## 제품 Git 상태와 검증 경계

- 2026-09-21 구현 시 로컬 제품 checkout은 `master`, HEAD
  `de2ffdd9e3025cb758632788cd6086c170e4974e`였다. 시작 시 개인 컨텍스트와 제품
  저장소를 `git pull --ff-only`로 갱신했고 당시 제품은 Already up to date였다.
- 사용자는 Swagger 생성 스크립트를 실행했다고 알렸다. 현재 수정된 제품 파일은
  `shared/models/src/Admin.ts`, `Lab.ts`, `Office.ts`, `data-contracts.ts` 4개다.
  생성 diff에는 LBX 외 변경도 섞여 있다. 위 4개 생성 파일의 사용자 변경
  1968 insertions / 268 deletions를 보존했고 FE 구현/모달 보완은 별도 21개 파일에 있다.
- 생성 파일을 덮어쓰거나 되돌리지 않았다. 종료 시 사용자의 명시적 요청으로
  `master`에서 `feature/DL-16387`을 만들고 25개 파일(사용자 생성 4개 + 구현 21개)을
  한 커밋에 보존했다. 별도 worktree는 만들지 않았으며 master와 다른 DLDS worktree는 유지했다.
- 코드/타입/로컬 UI 검증과 실제 백엔드 연동·배포 증거를 구분한다. 테스트에서
  실제 서버로 LBX 생성·수정 요청을 보내지 않았다. 운영 build/배포/실연동 QA는
  이번 완료 범위가 아니다.

### 초기 로컬 검증 — 모달 사용성 보완 전

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
- 이 초기 검증 당시에는 주문 연결부가 빈 목록이어서 Baby 생성 성공을 확인하지
  못했다. 이후 사용자 요청으로 목데이터를 제공하고 아래 후속 UI 검증을 완료했다.
  실제 적격 주문 API 연동 검증은 계속 대기다.
- 로컬 증거:
  `/tmp/dentlink-lbx-qa/2026-09-21T09-10-46-220Z-development-81988/report.json`,
  `/tmp/dentlink-lbx-qa/2026-09-21T09-10-46-220Z-production-81989/report.json`.
  테스트 스크립트/fixture/스크린샷은 `/tmp/dentlink-lbx-qa/`에만 있으며 다른 장치로
  전송되는 체크포인트가 아니다. 제품 저장소에 테스트 전용 모의 코드가 들어있지 않다.
- 검증용 Next 서버 3004/3005와 테스트 브라우저는 종료했다. 기존 사용자 3002
  서버와 다른 DLDS worktree는 건드리지 않았다.

### 후속 모달 사용성 검증 — 2026-09-21

- Admin 전체 타입 검사 exit 0. 수정한 Admin 6개 및 공유 UI 4개 파일 ESLint 오류·경고 0,
  Prettier/diff 검사 통과. 루트와 공유 UI의 Storybook lint plugin 중복 로딩 때문에
  각 영역의 설정으로 나누어 검사했다. 공유 UI는 `--no-eslintrc --config shared/ui/.eslintrc.cjs`
  사용. DatePicker에 남아 있던 불필요한 string 타입 표기 3개도 제거했다.
- 개발/운영 조건 각 5개 + 기타 픽업 위치 1개, **후속 UI 검증 11개 통과**.
  세 모달 공통 크기, 검색 focus 시 라벨 겹침 없음, 운영 고정 입력, Office 후
  예시 주문 복수 선택, Mother 검색 입력 없음/상태별 목록/빈 안내 제거를 확인했다.
- Baby 생성 payload, Mother 생성, 픽업의 Office 제외/기공소 Baby 복수 선택/날짜시간/
  전화/이메일/기타 위치와 기존 목록·상세 이동을 테스트 응답으로 검증했다.
  실제 서버 생성·수정 요청은 0건, 런타임 예외와 중복 key 경고도 0건이다.
- 최종 증거:
  `/tmp/dentlink-lbx-qa/2026-09-21T09-48-09-829Z-development-14109/report.json`,
  `/tmp/dentlink-lbx-qa/2026-09-21T09-48-11-543Z-production-14140/report.json`,
  `/tmp/dentlink-lbx-qa/2026-09-21T09-50-02-216Z-development-15747/report.json`.
- 예시 주문은 실제 적격 주문이 아니다. 생성 wrapper에 별도 요청 차단을 추가하지
  않았으며, 테스트의 POST 성공 응답만 브라우저 외부 QA route에서 대체했다.

### 신규 shippable 연결 검증 — 2026-09-21

- 개발 OpenAPI 읽기 전용 조회로 실제 Admin 경로, 필수 labId/officeId 및 Lab과
  동일한 DTO/페이지 응답을 확인했다. 업무 주문 API의 서버 결과를 검증한 것은 아니다.
- Admin 전체 타입 검사 통과. 변경 5개 파일 ESLint 오류 0, 기존 수기 order wrapper의
  미사용 import 경고 2개는 그대로다. Prettier 및 diff 검사도 통과했다.
- 네트워크 없는 wrapper/adapter 검증: GET 경로·필수 query·모든 페이지·중복 제거·
  이름 없는 주문·빈 응답·오류·AbortSignal 전달을 확인했다.
- 브라우저 fixture 검증 3개 통과: 3페이지 5개 주문 전체 표시와 마지막 페이지 검색/선택,
  Office 변경 시 선택 초기화/빈 목록, 생성·수정 요청 및 런타임 오류/중복 key 경고 0건.
  첫 실행은 입력 value를 텍스트 노드로 찾은 테스트 locator만 실패했고 이를 수정했다.
- 증거: `/tmp/dentlink-lbx-qa/2026-09-21T10-02-25-971Z-development-26827/report.json`.
  검사 스크립트는 `/tmp/dentlink-lbx-qa/shippable-unit.cjs`, `shippable-browser.cjs`다.
  테스트용 서버 3004는 종료했고 기존 사용자 서버 3002는 건드리지 않았다.

### 모달 상태·제출 조건 통일 — 2026-09-21 (빈 안내 위치는 아래 최신 UX 정정 우선)

- Baby/Mother 번호 목록이 비면 드롭다운 내부에 '선택할 수 있는 Mother 번호가
  없습니다.'를 표시한다. 조회 중/오류와 빈 목록을 구분하고 검색 없는 선택 UI를 유지한다.
- Baby는 기공소·Office·복수 주문·Mother가 현재 조회 목록에 존재하고 필수 조회가
  완료됐을 때만 활성화된다. Mother는 현재 목록에 존재하는 번호 선택 후 활성화된다.
- 픽업은 배송 선택과 기존 일시/위치/연락처 검증이 모두 유효해야 활성화된다.
  기타 위치·연락처를 비우면 다시 비활성화한다. 조회/더 보기 중에는 제출을 막고
  불러오는 상태를 표시한다. 제출 중 spinner/중복 방지/실패 시 입력 유지 흐름은 유지한다.
- `DataForm.confirmDisabled`를 기존 BaseForm disabled로 전달하고 공용
  SelectDropdown/ComboboxDropdown에 선택적 `emptyMessage`를 추가했다. 데스크톱
  빈 목록은 두 드롭다운 모두 짧은 안내 영역으로 표시한다. 모바일 기존 간격은 유지한다.
- Admin 전체 타입 검사, 변경 6개 파일 ESLint, Prettier와 diff 검사 통과.
  생성 코드 4개 사용자 변경은 그대로 보존했다. 제품 commit/push/배포는 하지 않았다.
- 별도 브라우저 fixture 검증 7개 통과: 두 Mother 빈 목록, Baby 필수 선택/초기화,
  Mother 선택 전후 버튼, 조회 중/오류, 픽업 빈 목록, 픽업 필수값 입력/삭제,
  생성·수정 요청과 런타임 예외/중복 key 경고 0건. 실제 백엔드 QA는 아니다.
- 초기 테스트 2회는 기존 영문 Others와 readonly input을 잘못 찾은 locator 실패였고
  테스트만 정확한 레이블/placeholder로 수정했다. 최종 증거:
  `/tmp/dentlink-lbx-qa/2026-09-21T10-08-28-243Z-development-32099/report.json`.
  스크립트는 `/tmp/dentlink-lbx-qa/form-state-browser.cjs`에만 있다.

### 최신 UX 정정 — 빈 안내 중복 제거, 모든 모달 동일 기준

- 사용자는 주문/Baby 배송 안내가 드롭다운 밖과 안에 중복되는 점을 지적했고,
  Mother 생성까지 같은 UX로 맞추라는 의도임을 재차 명확히 했다. 일부 필드만
  맞추지 말고 세 모달에서 같은 상태를 같은 방식으로 처리한다.
- Baby Office/주문/Mother, Mother 생성의 번호, 픽업 Baby 배송 모두 선행 선택/조회 중/
  오류/빈 목록은 **밖의 caption 한 번 + 선택 불가능 시 드롭다운 disabled**로 통일했다.
- 검색 가능한 실제 목록에서 검색어만 일치하지 않을 때는 내부에 '검색 결과가 없습니다.'를
  표시한다. 전체 대상 없음과 검색 결과 없음을 구분한다. 필수값 충족 시 제출 활성화 유지.
- 변경 3개 모달 타입·ESLint·Prettier/diff 검사 통과. 별도 fixture 브라우저 검증은
  안내 중복 제거/선행 선택/빈 Office·주문·배송/검색 불일치 3개, Mother 포함 통일된
  상태/정상 선택/필수값 검증 7개 통과. 실제 생성·수정 요청 0건.
- 증거: `/tmp/dentlink-lbx-qa/2026-09-21T10-15-03-192Z-development-37793/report.json`,
  `/tmp/dentlink-lbx-qa/2026-09-21T10-15-55-393Z-development-38564/report.json`.
  Mother 빈 상태 스크린샷에서 외부 안내 1개, 비활성 드롭다운/버튼도 확인했다.
- 검증 서버 3004는 종료했고 사용자 서버 3002는 건드리지 않았다. 제품은 계속 미커밋이다.

## 오늘 종료 시 Git 저장과 필수 검사

- 원격: `origin/feature/DL-16387`, commit `458ca7153cb17400ea4a3c2b18acb71da7f0e201`.
  25 files, 3372 insertions / 303 deletions. 사용자 Swagger 생성 변경도 함께 보존했다.
- 최초 만들었던 로컬 `codex/dl-16387-admin-lbx`는 사용자의 접두사 정정에 따라
  `feature/DL-16387`로 이름을 바꿨다. `codex/` 브랜치는 원격에 푸시하지 않았다.
- commit hook의 Clinic/Lab/Admin 타입 검사 모두 통과. push hook의 각 앱 린트는
  오류 0, 경고 Clinic 229/Lab 189/Admin 410이었다. 기존 경고와 변경 검증을 구분한다.
- push hook의 공용 coverage 검사 통과: configs 3개, hooks 24개 테스트 통과.
  coverage diff 기준 파일은 2026-04-23 baseline이며 이번 기능 전체의 UI 검증을 뜻하지 않는다.
- hook을 끄거나 우회하지 않았다. push 성공 후 origin ref와 작업 트리 clean을 확인했다.
  로그는 `/tmp/dentlink-lbx-commit.log`, `/tmp/dentlink-lbx-push.log`로 로컬에만 있다.
- 제품 PR/병합/배포는 하지 않았다. 오늘 추가 구현은 종료하고 아래 전체 검토를 다음 시작점으로 둔다.

## 2026-09-22 후속 수정과 PR

- 배송 목록의 `LBX Mother 번호`와 `LBX Baby만 보기`를 접힌 필터로 배치했다.
  배송 목록·상세와 세 모달에서 Baby/Mother 사용자 표시 앞에 `LBX `를 붙였다.
  픽업 모달의 기공소 연락처 초기값 적용 시 검증을 강제로 실행하지 않도록 바꿔,
  진입 직후 빨간 필수 오류가 뜨지 않게 했다. 로컬 Chrome 화면에서 확인했다.
- 후속 수정 커밋 `b815f4e7c690bd19154b1c3ceef687b2714235c0`
  (`fix: LBX 배송 필터와 생성 화면 표시 정리`).
- `origin/release/v1.87.0`의 5개 선행 커밋을 병합했다. Swagger 생성
  `shared/models/src/data-contracts.ts`의 충돌 두 곳은 feature의 신규 타입을 유지해
  해결했고 병합 커밋은 `a7c45172d51f98fb837b52551bbd2c9aa4106a1d`이다.
- 변경 파일 ESLint·Prettier, Clinic/Lab/Admin 타입 검사, commit/push hook이 통과했다.
  전체 린트에는 기존 경고가 있었지만 실패하지 않았다. push hook 공용 coverage도 통과.
  실제 생성·수정 API 요청과 배포 전 전체 UI·UX 검토는 수행하지 않았다.
- [PR #4623](https://github.com/Innvoaid/dentlink-client/pull/4623)은
  `feature/DL-16387` → `release/v1.87.0`, OPEN. 원격 HEAD와 작업 트리 clean 확인.

## 2026-09-22 개발 서버 검증용 develop PR

- 이후 사용자 요청으로 개발용 worktree는 clean 상태와 원격 HEAD 일치를 확인한 뒤 제거했다.
  로컬 `feature/DL-16387-develop` 브랜치, 원격 브랜치, PR #4624는 유지한다.
  이후 개발용 수정은 필요 시 기존 제품 checkout에서 해당 브랜치로 전환해 작업한다.
- 원래 `release/v1.87.0` 대상 PR #4623은 변경하지 않았다. 개발용 브랜치는
  별도 worktree `/Users/parkjongsun/Repository/dentlink-client-lbx-develop`에서
  `origin/develop` (`b15c2c492`)을 출발점으로 만들었다.
- 릴리스 병합 커밋은 제외하고 LBX 기능/후속 수정 커밋만 cherry-pick했다.
  `develop`의 생성 API 파일은 필요한 타입이 이미 있어 대량 생성 diff가 PR에 남지 않았다.
  `Admin.ts`에는 `isConsolidated` 필드만 추가하고, `data-contracts.ts`는
  기존 예시 주석을 유지해 충돌을 해결했다.
- `develop`의 DLOS Button API에 맞게 배송 문서 다운로드 버튼을 조정했다.
  새 worktree의 Clinic/Lab 타입 검사를 위해 PNG ambient 타입 선언을 보완했다.
  개발용 브랜치 커밋: `044dea007`, `f7e384e6d`, `5beef2133`.
- Clinic/Lab/Admin 타입 검사, 변경 파일 ESLint/Prettier, pre-push 전체 lint와
  공용 coverage 검사가 통과했다. 기존 전체 lint 경고는 남아 있지만 오류 0이다.
  worktree에 없는 Git 제외 `coverage-baseline.json`은 기존 checkout의 같은
  기준 파일(2026-04-23)을 복사해 검사했고 새 기준을 생성하지 않았다.
- [PR #4624](https://github.com/Innvoaid/dentlink-client/pull/4624)는
  `feature/DL-16387-develop` → `develop`, OPEN. 실제 개발 서버 배포,
  DLOS 리디자인 UI 전체 확인, LBX 생성·수정 API 실제 요청은 수행하지 않았다.
  두 PR의 향후 보완을 혼동하지 않도록 대상 브랜치별로 갱신해야 한다.

## 남은 일과 다음 시작점 — 배포 전 전체 검토부터

1. 재개 시 개인 컨텍스트를 pull하고 제품 `feature/DL-16387`의 원격/HEAD/작업 트리를
   확인한다. 다른 기기의 로컬 인증·의존성·실행 서버·`/tmp` 테스트 파일은 별도 준비다.
2. **전체 구현을 사용자 관점에서 UI·UX까지 다시 검토한다.** 배송 목록/상세와
   Baby/Mother/LBX 픽업 3개 모달, 기존 픽업 목록/상세를 한 흐름으로 비교한다.
   오늘 고친 필드만 재확인하고 끝내지 않는다. 점검 범위:
   - 모달 크기, 화면 높이별 배치, 스크롤/드롭다운 겹침, 라벨/placeholder, 키보드·닫기 동작.
   - 선행 선택, 조회 중, 실패, 빈 목록, 검색 결과 없음, 선택/초기화가 모달 사이에서 일관되는지.
   - 필수값/제출 활성화, 중복 제출 방지, 처리 중 표시, 성공 후 목록/상세 이동과 재조회.
   - 운영 IDS 129 고정/다른 환경 선택, 기존 배송 값 없는 칸, 공유 UI 소비 화면의 회귀.
   - 조회/재조회 도중 disabled로 바뀔 때 이미 열린 메뉴가 적절히 닫히는지도 실제 확인한다.
3. 코드와 현재 API 규약/실제 읽기 결과를 대조하고 발견된 문제를 보완한 뒤 관련 회귀를
   확인한다. 지금까지의 브라우저 검증은 fixture 기반이며 실제 업무 서버 성공을 뜻하지 않는다.
   실제 생성·수정 테스트 전송은 기존 금지 조건을 유지한다. 제품 API를 임시로 막지 않는다.
4. 전체 검토/보완 후 PR #4623을 갱신하고 필요한 리뷰·QA를 진행한다. 병합·배포는
   별도 승인과 검증 이후에만 진행한다. 이번 commit/push/PR 요청을 생성·수정 테스트 허용으로
   확대하지 않는다.

## 결정 이력 — 2026-09-21

- 초기 예시 화면 대신 Jira 텍스트를 우선하고 별도 Admin 디자인은 만들지 않기로 했다.
- 사용자의 Swagger 생성 후 Baby/Mother/픽업/번호 목록 계약을 확인했다.
- 기공소 고정은 모든 환경이 아니라 **prd IDS 129만**, 나머지 환경은 제한을 풀었다.
- Baby 필터의 임시 명칭 `isLbxBaby`는 **`isConsolidated`**로 확정·명세 반영됐다.
- Mother 무상 대체 사유서 공백은 추가 요구가 아니라 **범위 제외**로 해소됐다.
- 주문 목록은 기존 Admin 검색도 검토했으나 최종적으로 별도 신규
  `GET /admin/orders/shippable`로 확정해 연결했다.
- 픽업의 Office 선택/받는 그룹 필터 제안은 사용자 정정으로 폐기했다. 기존 기공소
  픽업 UI와 `isConsolidated + shipperId` 조회를 사용하고 기존 outbound 화면으로 이어진다.
- 따라서 초기의 필터명·문서 종류·픽업 Office/독자 규칙 관련 미결 기록보다 이 파일의
  최신 합의가 우선한다. 마지막으로 기다리던 Baby 대상 주문 API도 명세와 연결이 확인됐다.
- 구현 중 사용자가 실제 요청 제한을 세 차례 정정했다. **제품 API는 정상 연결,
  테스트 시 생성·수정 실전송만 피함, 임시는 미완성 주문 API 한 곳뿐**이라는 최종
  지시가 이전의 모든 요청 차단/모의 성공 흐름 해석보다 우선한다.
- 후속 모달 피드백: 크기 통일/확대, 내부 라벨 겹침 제거, 운영 IDS를 검색 UI와
  같은 고정 입력 형태로 표시, 주문 조회는 빈 응답 대신 목데이터, Mother는 검색 없는
  선택형 드롭다운, 불필요한 빈 목록 안내 제거. 이 요청에 맞춰 수정/검증했다.

- 신규 API 사용자 안내 후 개발 OpenAPI를 확인해 `labId`/`officeId` 필수 query와
  페이지 응답을 확인했다. 기존 generated 변경은 보존하고 수기 Admin wrapper와
  params type을 추가해 주문 예시 데이터를 실제 GET으로 교체했다.
