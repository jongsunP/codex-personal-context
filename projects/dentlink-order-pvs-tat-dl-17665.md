# 주문 PVS·픽업 변경 시 TAT 요구 조사 — DL-17665

## 현재 체크포인트 — 2026-11-27

- 사용자 요청: 새 업무의 뜻부터 조사해 설명한다. 구현 전 요구 해석 단계다.
- Jira: [DL-17665](https://innovaid.atlassian.net/browse/DL-17665), 상위 [DL-17654](https://innovaid.atlassian.net/browse/DL-17654).
- 담당 채팅: `주문 PVS·픽업 변경 시 TAT 요구 조사 · DL-17665`, `01a21b8e-7123-75b0-9688-08e7c882c406` (local). 실제 turn `gpt-6-astra / xhigh` 확인.
- 조사 worktree: `/Users/parkjongsun/Repository/dentlink-client-dl-17665/dentlink-client`, detached `023057ab6109e54d263079a6c64c139407f02a6b` (fetch한 origin/master). 실제 경로·Git 등록·채팅 persisted cwd 일치. 제품 clean.
- 주 checkout의 master `96bdacda6`와 타 작업은 그대로 유지. 동일 저장소 main의 eligible ignored/untracked env6개를 opaque 복사, 동일성·ignore 확인. 설치·서버·브라우저·테스트 실행 없음.
- 권한: 조사와 위 worktree 준비만. 제품 코드/branch·commit/push/PR·Jira 쓰기·배포는 미승인. 개인 기록만 유지한다.
- 조사 완료: Jira 원문·현재 웹 코드·관련 Git 이력·DEV Swagger·앱 진입 경로를 읽었다. 제품 변경/테스트/서버/브라우저/실계정 주문·API 쓰기 없음. 다음 구현 지시 전 대기한다.
- 최초 준비 기록은 개인 정본 `c64a5b5`로 commit/push 완료. 아래는 이후 확인된 조사 결과다.

## 원문에서 구분할 사항

- 하위 제목은 픽업 날짜 수정, 본문은 PVS 추가·해제 시 기존 TAT 초기화와 서버가 준 가장 빠른 날짜를 선택하는 UI다. Frankie 담당/해야 할 일/댓글0.
- 상위는 새 주문4단계 정상(Scan 12/10, PVS 11/27 추가 시12/17), 접수 후 주문 수정은 기존12/10 유지가 문제라 재선택을 요구한다.
- 상위의 별도 픽업 추가는 기존 납기가 새 계산보다 빠른 경우만 자동 지연·+3/+5 영업일·안내 팝업이라는 별도 흐름이다. 하위 범위에 자동 포함하지 않는다.
- “예전에 테스트했다”는 작성자 기억이다. 실제 회귀와 현재 서버 응답·운영 재현은 아직 확인하지 않았다.

## 요청의 뜻

여기서 TAT는 화면의 `Turnaround Date`, 즉 사용자가 선택하는 납기 날짜다. Scan은 스캔 데이터를 보내는 방식, PVS(Pickup)는 실물 인상물을 픽업해 보내는 방식이다. 실물을 추가하면 운송을 포함한 일정이 달라지므로, 기존 날짜를 지우고 서버가 안내하는 가장 빠른 날짜부터 다시 고르게 해 달라는 요청으로 해석한다.

카드의 예시: Scan 주문에서12/10을 선택 → 11/27 PVS 픽업 추가 → 새 최소일12/17 → 기존12/10을 미선택으로 바꾸고 사용자가12/17 또는 이후 가능한 날을 선택한다. 이 예시 날짜는 카드에 적힌 값이며 이번 세션의 실제 서버 계산 결과가 아니다. 하위 카드는 자동으로12/17을 저장하라는 요구가 아니다. PVS 해제도 본문상 재선택 대상이다.

## 확인된 코드 흐름과 원인

아래 웹 경로는 조사 worktree의 상대경로, 기준 SHA는 위와 같다.

1. **새 주문과 주문 수정은 같은4단계 화면을 쓴다.**
   - `clinic/src/pages/orders/[order_id]/[step].tsx:32`는 DRAFT이면 Place Order, 이후 상태면 Edit Order로 제목만 구분한다.
   - `clinic/src/components/Order/OrderForm.tsx:198`는 ADDITIONAL 단계에 `OrderAdditional`을 렌더한다.
   - `clinic/src/lib/Order/useOrderDetail.ts:177`은 접수된 일반 주문 수정 시 같은 `/orders/{id}/additional`로, DRAFT는 저장된 단계로 들어간다. 리메이크 수정은 별도 경로다.
2. **PVS 체크/해제 시 날짜 초기화 자체는 이미 있다.**
   - `shared/ui/src/Order/OrderForm/OrderAdditionalInfoForm.tsx:236`에서 `deliveryRequestAt`을 undefined로 비우고 픽업일도 비운다. 기존 픽업일이 있으면 삭제 요청을 보낸다.
   - 같은 파일`:200`의 픽업일만 변경하는 handler는 픽업일 설정·API 호출만 하고 납기를 직접 비우지 않는다. 따라서 체크 변경과 날짜 변경을 같은 이벤트라고 볼 수 없다.
3. **접수된 주문에서는 기존 날짜를 되살리는 분기가 있다.**
   - 같은 파일`:400`의 effect는 `order` 또는 서버 최소일이 바뀌면 실행된다. `:411–417`에서 DRAFT 이후이며 기존 납기가 있으면 기존 `order.officeDeliveryRequestAt`을 무조건 다시 넣고 종료한다.
   - DRAFT는 이후 분기에서 현재 날짜와 서버 최소일을 비교해 너무 이른 날짜를 비운다(OFFICE_SCANNER DRAFT는 별도 자동 대체 예외). 그래서 상위의 신규 정상/수정 문제 구분과 코드가 부합한다.
   - PVS 변경 직후 잠시 비워져도, 서버 최소일 재조회 결과가 달라져 effect가 실행되면 접수 주문의 예전 납기를 다시 넣는 구조다. 실제 환경 재현은 하지 않았으므로 모든 조건에서 같은 증상이 난다고 단정하지 않는다.
4. **서버 계산 재조회와 날짜 선택 UI도 이미 있다.**
   - `clinic/src/lib/Pickup/usePickupOrders.tsx:27`의 POST/DELETE 후 `onSettled`에서 주문 요약·예약 목록·납기 계산을 재조회한다.
   - 픽업 예약 API는 `/office/shipments/pickups/reservations/orders/{orderId}`(POST 날짜 payload/DELETE)다. 체크만 하고 픽업일을 아직 선택하지 않으면 예약 생성은 안 된다.
   - `clinic/src/components/Order/OrderAdditional.tsx:140,194,234,254` → `clinic/src/services/calendars/calendars.query.ts:19` → `shared/models/src/holidays/holidays.apis.clinic.ts:40`: GET `/office/calendars/orders/{orderId}/turnaround-date`. 현재4단계 호출은 orderId만 설정하며 로컬 타입의 optional pickupDate는 전달하지 않는다.
   - 응답의 turnaroundDate를 `calendarsEnabledStartDate`로 넘긴다. `DeliveryInfo.tsx:73,148`는 그 날짜부터 달력을 열고 주말·휴일 제한을 적용한다. 비어 있으면 `Not selected` 표시, 날짜 선택은 사용자가 확정한다. API 최소일이 없을 때10영업일 fallback이 있으나 이 작업에서 새 계산을 넣을 근거는 아니다.
   - `useOrderAdditionalInfoForm.tsx:109` 및 `shared/configs/utils/orderAdditionalValidation.ts:26`은 납기 값의 존재·날짜 파싱 여부를 확인하며 최신 서버 최소일과 비교하지 않는다. 따라서 오래된 유효한 날짜가 되살아나면 FE 저장 검증은 통과할 수 있다. 서버 수락 여부는 실제 요청으로 확인하지 않았다.

## 과거 요구와 회귀 판단

- [DL-16239](https://innovaid.atlassian.net/browse/DL-16239), 2026-08-31 완료: “Draft 상태는 초기화 로직 유지, Draft 이후는 기존 Turnaround Date를 수정 시에도 유지”라는 명시 요구가 있었다.
- Git `1113de8b84fd6da7140acf9211bf88a4743e1e2e`, 2026-08-31, PR4551에서 위 접수 주문 보존 분기7줄이 추가됐다. 현재까지 남아 있다. PVS 체크 시 비우는 로직은 `7b0c501b90`(2025-12-29)부터 남아 있다.
- 따라서 “초기화 코드가 통째로 사라졌다”는 설명은 맞지 않는다. 기존 납기 유지 요구와 이번 PVS 변경 시 재선택 요구를 구분하지 못하는 분기가 확인됐다. 과거 사용자가 테스트한 버전/정확한 운영 회귀 시점은 미확인이다.
- 일반 주문 수정에서 납기가 지워지지 않게 하는 기존 정책을 없애면 안 된다. 픽업 조건을 바꾼 상황만 재선택 예외로 처리하는 최소안이 적절하다.

## API 계약 확인 범위

- 2026-11-27 [DEV Swagger](https://dev-api.dentlink.io/v3/api-docs) HTTP200 직접 조회. GET `/office/calendars/orders/{orderId}/turnaround-date`와 `CalendarTurnaroundResponseDto`의 `turnaroundDate`(string/date), `affectedScopes`(string array)를 확인했다. required/nullability는 명시되지 않았다.
- 현 DEV 해당 operation의 query에는 pickupDate가 없으며, FE 로컬 wrapper에는 optional pickupDate 잔여 선언이 있다. 실제4단계는 orderId만 사용한다. 이 차이만으로 이번 수정에 모델 변경/API 신규 작업이 필요하다고 단정하지 않는다.
- 주문 ID를 넣은 업무 데이터 응답·STG/운영 API·브라우저는 조회/실행하지 않았다. PVS 저장 후 서버가 실제로 어떤 최소일을 주는지는 구현/재현 시 확인할 사항이다. 현재 근거상 FE에서 +3/+5 영업일 계산을 새로 만드는 작업은 아니다.

## 제품·화면 범위

| 화면 | 확인한 경로와 영향 |
| --- | --- |
| 치과 PC 웹 주문 작성/수정4단계 | 이번 현상과 기대 UI의 직접 대상. 동일 컴포넌트, 주문 상태별 분기 |
| 치과 모바일 웹 주문 폼 | `OrderForm.tsx:131`에서 react-device-detect의 isMobile이면 Mobile Not Supported 팝업 반환. PC 웹4단계를 모바일 지원으로 확장할 근거 없음 |
| 치과앱 주문 작성/수정 | 웹 상세의 `OrderDetailBoxTitleMobile.tsx:126`에서 수정 버튼은 RN NAVIGATION으로 네이티브 OrderScreen 진입. 웹 폼 재사용 아님 |
| 기공소 웹 | 공통 폼을 소비하지만 PVS 체크 disabled, 픽업일 UI 없음(`SelectImpressionType.tsx:172,204`). 공통 effect 변경 시 일반 날짜 보존 회귀는 점검하되 신규 픽업 기능으로 확대하지 않음 |
| 관리자 웹 | 같은 공통 폼 소비, ADMIN 날짜 초기화·최소일 예외가 별도. 이번 치과 요구 때문에 관리자 특례까지 바꾸지 않음 |
| 접수 후 별도 픽업 추가 | `/pickup/create`, `usePickupCreate` → createReservation(payload의 date/orderIds) 후 목록 이동. 주문4단계 날짜 선택 UI를 거치지 않는 별도 흐름. 상위 시나리오3의 자동 납기 조정/팝업은 하위 범위로 편입하지 않음 |

### 앱 관련성만 확인한 결과

- 추가 worktree/변경 없이 기존 Office repo를 읽었다. 2026-11-27 fetch 확인: 현재 checkout `release/v2.2.7@0317f39c`, origin/main `dd9fc9a2`. checkout 전환/pull/실행 없음. 조사한 `OrderScreen.tsx`와 `OrderAdditionalInfoSection.tsx`는 origin/main과 동일하다. 앱 배포/실기기 상태는 확인하지 않았다.
- `src/features/order/screens/OrderScreen.tsx:1352` → 네이티브 `OrderAdditionalInfoSection`이다. 같은 서버 납기 API를 사용하지만 웹과 별도 상태 처리다.
- 해당 파일`:374` 픽업 저장 성공 후 최소일 재조회, `:398` 픽업 삭제 성공 시 납기 초기화, `:475` 체크만 추가할 때는 납기를 비우지 않는다. `:792`는 기존 선택일이 새 최소일보다 빠르면 **새 최소일로 자동 대체**한다. 주문 초기값은 order ID당1회 설정(`:701`)된다.
- 따라서 웹의 “접수 주문의 이전 날짜 재주입”과 같은 구현이라고 단정할 수 없다. 앱은 사용자 재선택 대신 일부 자동 대체 동작이 있으므로 이번 요구를 앱에도 적용할지는 범위 확인이 필요하다. 네이티브 수정은 아직 승인/착수하지 않았다. Lab 앱 확대 근거가 없어 추가 조사하지 않았다.

## 남은 확인·최소 작업안

정책 확인은 다음 두 가지로 좁힌다.

1. **PVS 체크를 그대로 둔 채 픽업 날짜만 바꿔도 기존 납기를 비우고 다시 선택하는가?** 제목은 포함하나 본문은 추가·해제만 명시한다. 포함하는 방향을 권장하되 확정 요구로 쓰지 않는다. 하위 본문 기준 PVS 해제 때에도 기존의 늦은 납기를 유지하지 않고 재선택한다는 점은 상위 시나리오3의 유지 정책과 구분한다.
2. **이번 재선택 정책은 치과 PC 웹만인가, 별도 네이티브 치과앱에도 적용하는가?** 앱은 다른 흐름이므로 웹 수정에 자동 포함되지 않는다. 관리자 신규 정책/기공소 픽업 지원은 현재 범위 밖이다.

구현 승인 후 최소안: 기존 달력/UI/API 재사용, PVS 추가·해제(날짜 변경은 답변에 따라)로 비운 납기를 서버 재조회 뒤 이전값으로 복구하지 않도록 상태 초기화 경계를 구분한다. 일반 수정은 기존 날짜 유지. 새 최소일 조회 완료 전/실패 시 기존 에러·로딩 흐름을 보존하고 잘못된 날짜를 확정하지 않게 실제 흐름을 확인한다. 단순히 non-DRAFT 보존 분기를 삭제하거나 부모의 +3/+5·팝업을 추가하지 않는다.

향후 검증 범위: 새 주문/접수 주문 각각 PVS 추가·해제·픽업일 변경, 일반 코멘트 수정 시 납기 유지, 새 최소일보다 기존 선택일이 빠른/늦은 경우, 픽업 실패·재조회 중 화면, 기공소/관리자 기존 공통 폼 특례. 이번 조사에서는 어떤 테스트나 제품 실행도 하지 않았다.

메인 공통 파일은 편집하거나 자동 보고/폴링하지 않는다. 조사 결과는 사용자에게 직접 설명하고 후속 지시를 기다린다.
