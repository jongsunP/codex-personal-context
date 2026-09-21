# Dentlink Admin LBX — DL-16279 / DL-16387

## 현재 체크포인트 — 2026-09-21, 구현 시작 전

- **요구사항·화면·재사용 기준 정리 완료, FE 구현 미착수.** 사용자는 작업을
  시작하기 전에 이 기능만의 별도 메모리를 요청했다. 이번 요청은 개인 컨텍스트
  저장이며 제품 구현 착수나 제품 Git 변경의 승인이 아니다.
- `GET /admin/shipments`의 `isConsolidated` 필터는 개발 서버 Swagger와 로컬
  생성 코드 모두에서 확인됐다. 남은 백엔드 보충은 **Baby 생성 대상 주문 조회용
  별도 신규 API**다. 기존 `POST /admin/orders/search`를 확장하는 방식은 채택하지 않는다.
- 신규 API 실제 연결을 제외한 화면·폼·성공 흐름은 작업 가능한 상태다. 주문 선택
  UI도 모의 데이터로 먼저 구성할 수 있다. 추가 기획·디자인 결정을 기다리는 상태는 아니다.
- 구현이 승인되더라도 당분간 **실제 업무 네트워크 요청을 보내지 않는다.**
  합의된 요청·응답 계약을 기준으로 성공을 가정한 모의 흐름을 만든다.
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
- 이번까지 제품 코드 수정, 브랜치/worktree 생성, 제품 commit/push, PR/Jira 변경,
  테스트·빌드·배포는 수행하지 않았다. 이후 구현 요청과 Git/배포 권한을 구분한다.

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
   여러 주문을 선택한다. API 전에는 모의 목록을 쓸 수 있으며 미확정 경로·응답을
   합의된 계약인 것처럼 만들지 않는다.
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

## 실제 요청을 보내지 않는 구현 기준

- 계약에 맞는 모의 응답으로 입력 → 선택 → 생성 성공 → 모달 닫기/화면 이동 →
  목록·상세 표시까지 일관되게 구성한다. 생성 버튼의 요청만 차단해서는 부족하다.
- 이 기능 흐름의 이름 검색·목록 자동 조회·재조회·픽업 후 도착 화면까지 실제 요청이
  나가지 않도록 기존 데이터 경계에서 모의 응답을 적용한다.
- `EmployerFindDropdownList`는 mount/검색어 변경 때 자동 조회한다. UI `disabled`만으로
  네트워크가 차단되지 않는다. Lab 픽업 hook의 API/SSE도 그대로 실행하지 않는다.
- 새 주문 API가 나오면 이름·필드·대상 주문 조건을 확인해 해당 연결부를 맞춘다.
  API가 배포됐다는 이유만으로 모의 응답을 실요청으로 전환하지 않는다.
- 업무 API 실요청 금지와 공개 Swagger 명세의 읽기 확인은 구분한다. 이번 대화에서
  사용자가 요청한 배포 확인은 명세만 조회했다.

## 제품 Git 상태와 검증 경계

- 2026-09-21 저장 시점에 로컬 제품 checkout은 `master`, HEAD
  `de2ffdd9e3025cb758632788cd6086c170e4974e`였다. 저장 턴에서 제품 원격을 fetch/pull한
  것은 아니므로 이를 최신 원격 배포 SHA로 간주하지 않는다.
- 사용자는 Swagger 생성 스크립트를 실행했다고 알렸다. 현재 수정된 제품 파일은
  `shared/models/src/Admin.ts`, `Lab.ts`, `Office.ts`, `data-contracts.ts` 4개다.
  생성 diff에는 LBX 외 변경도 섞여 있으며 이 변경을 FE 구현 완료로 보지 않는다.
- 생성 파일을 덮어쓰거나 되돌리지 않았고, 이 작업의 feature branch/worktree도
  만들지 않았다. 개인 메모리 작업 때문에 제품 저장소를 commit/push하지 않는다.
- 확인한 것은 Jira/사용자 요구사항, 기존 UI/코드 구조, 생성된 모델,
  개발 Swagger 계약이다. 제품 FE 코드 수정·테스트·빌드·LBX 생성 호출·연동 QA·
  배포 완료 증거는 없다.

## 남은 일과 다음 시작점

1. 사용자가 구현을 지시하면 개인 컨텍스트를 먼저 동기화하고 이 파일을 읽는다.
   제품의 정확한 branch/worktree와 사용자 생성 변경을 확인하고 보존한다.
2. Baby 대상 주문용 별도 API가 나왔는지 최신 명세를 확인한다. 아직 없어도 그
   연결부 외 화면·폼·모의 성공 흐름은 진행할 수 있다.
3. 기존 Admin 코드 구조와 기공소 픽업 UI를 재사용해 위 목록·상세·모달을 구현한다.
   새로운 UI 설계, 픽업 Office 선택, Mother 무상 대체 사유서를 다시 요구하지 않는다.
4. prd IDS 고정/비운영 기공소 선택, Mother 번호 상태 필터, 값 없는 칸의 빈 표시,
   배송 다중 선택, 기존 픽업 목록·상세 이동을 모의 응답으로 검증한다.
5. 구현 범위에 맞는 검사와 화면 검증에서 실제 업무 요청이 나가지 않는지도 확인한다.
   제품 commit/push/PR/실연동/배포는 각각 사용자가 허용한 범위에서 진행한다.

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
