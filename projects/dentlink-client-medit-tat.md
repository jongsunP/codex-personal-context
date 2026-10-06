# DL-16615 MEDIT TAT 수정

## 범위와 작업 위치

- 기능 세션: `01a10eae-2ff7-7b43-a9e2-11a3b93cc782`.
- 개인 세션 폴더는 기존 `메인 프로젝트`를 유지한다. 새 폴더/worktree는 만들지 않는다.
- 제품 조사 경로: `/Users/parkjongsun/Repository/dentlink-client`.
- 상위 조율 정본: [Dentlink FE](dentlink-fe.md). 제품 저장소에 개인 인계문을 추가하지 않는다.
- Jira/Notion 댓글 작성·상태 변경, 제품 branch 생성·commit·push·PR·merge·배포는 별도 명시 승인 범위를 따른다.

## 현재 체크포인트 — 2026-10-06: Admin 폼 보정 구현·로컬 검증

### 사용자 재검토 요청 후 보완

- 사용자가 기존 방향을 유지한 주석 추가, 이후 구현 재검토·직접 보완과 PM용 댓글 재정리를 요청했다. Notion 본문과 전체 댓글을 다시 읽었고, 현재 토론은 같은 iTero 확인 요청 1건이다. 외부 댓글은 등록하지 않았다.
- 초기 구현의 `formOrder` 복제로 RX 원본이 늦게 도착하면 날짜 외 comment·플랫폼명·디자인 선택도 초기화될 수 있어, 원본 `order`를 유지하고 `initialDeliveryRequestAt` prop과 Admin 날짜 전용 effect로 분리했다.
- RHF dirty 판정 대신 주문 ID·사용자 편집 여부를 추적한다. 날짜 선택·비우기·impression 변경 뒤 원본이 도착해도 선택을 보존하며, 다른 주문으로 이동하거나 재진입하면 해당 주문 초기값을 사용한다. 최소일 제한은 유지한다. OFFICE/LAB의 최소일 비교는 기존 watch 값 사용을 유지했다.
- 이전 주문의 플랫폼 원본을 사용하지 않도록 주문 ID와 MEDIT 여부를 확인한다. SSR 경로의 orderId는 실제로 문자열이므로 `Number(orderId)`와 API의 숫자 ID를 비교한다. 날짜 보정 memo에도 플랫폼 주문 ID를 dependency로 포함했다.
- Medit 미리보기 한국 날짜 적용도 미국 OFFICE_SCANNER 범위로 제한했다. 다른 Medit 주문은 기존 표시 기준을 사용한다. US 조건의 Notion 근거, 한국 날짜 기준, 비동기 초기화 분리 이유를 주석으로 기록했다.
- 최신 소스에서 날짜 함수를 추출하고 실제 React/RHF를 JSDOM에 mount해 **73건**을 통과했다. 브라우저 시간대 4종, 잘못된/누락된 원본, US/플랫폼/상태 제외, 늦은 원본과 다른 입력값 보호, 날짜 선택·비우기, 최소일, 주문 이동·재진입, SSR 문자열 ID, 미리보기 US/기존 표시를 포함한다. 화면 leaf는 대체했으므로 전체 앱 제출·재조회 QA 증거는 아니다. 이전 60건 기록은 아래 조사 이력이다.
- PM 댓글의 정확한 범위: 기존 FE에는 Medit/iTero의 `delivery_request_at`을 병원 국가코드에 맞춰 별도 보정하는 처리가 없었다. 이번 미국 Medit Admin 초기값·미리보기에만 US 조건과 RX 날짜 보정을 추가했다. iTero의 국가코드별 초기 저장 정책은 FE 코드에서 보장할 수 없어 서버 확인 대상이다. 기존 캘린더 조회에는 국가코드, 현재 날짜 기준에는 officeZoneId가 사용되므로 "국가코드 관련 처리 자체가 전혀 없었다"고 쓰지 않는다. Admin KR 또는 서버 오류를 원인으로 단정하지 않는다.

- 사용자가 기존 checkout에서 `origin/master` 기준 `feature/DL-16615` 생성 후 구현·검증을 승인했다.
- 기본 checkout에 해당 브랜치를 만들었다. HEAD/base는 `6b79c9756cc56313fe833aad463bddb1f8c385fa`, 수정 파일 4개, 제품 commit/push/PR 없음이다. 원격 feature/upstream은 아직 없다.
- **재현:** 신규 미국 Medit DRAFT의 원본 `2026-10-28T22:45:00Z`는 한국 날짜 10/29이나 운영 저장·표시는 10/28이다. 원본과 운영 상세를 읽기 대조했다. 사례 주문/환자의 사적인 정보는 개인 정본에 저장하지 않는다.
- Admin 신규 미국 OFFICE_SCANNER/MEDIT DRAFT에서 현재 저장일이 원본의 병원 시간대 날짜와 같을 때만 RX 한국 날짜로 보정한다. 다른 선택일·최소일로 보정된 저장값·DRAFT 이후·iTero·미국 외·누락/잘못된 원본은 보존한다.
- 원본은 이미 Admin 주문 단계 페이지가 조회하던 `platformOrder.rawOrder`를 사용한다. 새 API나 공유 전역 타임존 변경은 없다. 원본의 늦은 도착이 사용자가 현재 선택한 날짜를 덮지 않도록 dirty를 기록하고, 같은 초기화 사이클에서 최소일 비교가 최신 폼값을 읽도록 수정했다.
- Medit RX 미리보기 Delivery도 한국 날짜로 표시한다. 표시 형식은 기존 `MM/dd/yyyy`를 유지한다. 다른 Created/Scanned 날짜에는 이 정책을 확대하지 않았다.
- **검증:** Admin/Clinic/Lab 타입 검사 성공, Admin 전체 lint 오류 0/기존 경고 410, 수정 Admin 파일 lint 신규 경고 없음, 포맷/diff 검사 성공. 실제 소스에서 함수/초기화 effect를 추출해 시간대 4종과 정책 제외 조건을 검증했다. 초기 58건 중 초기화 6건은 마지막 소스의 8건으로 다시 검증해 최종 조건 수는 **60건**이다. 비동기 초기화·수동 입력 보호·최소일 비교와 다른 주문으로 이동한 뒤 이전 dirty가 남아도 새 주문 날짜를 초기화하는 경우를 포함한다. 영구 테스트/helper 파일을 추가하지 않았다.
- **화면 검증 한계:** 실제 MeditPreview 소스의 SSR을 LA 시간대에서 격리 렌더링하고 브라우저에서 Delivery 10/29/2026을 확인했다. Typography/DataTable leaf는 대체했으므로 전체 앱 UI/캘린더 상호작용 QA는 아니다. 임시 서버는 종료했다. 운영 주문 수정·제출은 하지 않았다.
- **남은 범위:** 이 보정은 Admin 폼값이며 Admin 제출 시 서버 저장 요청으로 연결된다. 서버 자동수집 초기값을 직접 고치지 않는다. Clinic은 Medit 원본 조회 계약이 현재 없어 이 Admin 보정을 직접 사용할 수 없다. 전체 수집값/Clinic 직접 제출까지 요청한다면 서버 수집 매핑 또는 Clinic 원본 제공 계약을 확인해야 한다. 신규 원본 조회 API를 임의로 만들지 않았다.

### 변경 제품 파일

- `admin/src/components/Order/OrderAdditional.tsx`: 원본 기반 납기 보정과 공용 폼 연결.
- `admin/src/components/Order/OrderForm.tsx`: 기존 플랫폼 원본을 추가정보 단계로 전달.
- `admin/src/components/Order/MeditPreview.tsx`: RX Delivery 날짜 표시.
- `shared/ui/src/Order/OrderForm/OrderAdditionalInfoForm.tsx`: 입력값 보호 및 최신값으로 최소일 비교.

### 확인된 요구와 자료

- [DL-16615](https://innovaid.atlassian.net/browse/DL-16615): 해야 할 일, fixVersions 없음, 하위 작업/이슈 링크 없음.
- [상위 DL-16613](https://innovaid.atlassian.net/browse/DL-16613)은 **v1.89.0 / 2026-10-26** 대상이다. 상위의 iTero 환자명·Medit 설명 수정은 이 기능의 구현 범위에 포함하지 않는다.
- [Notion Medit TAT](https://app.notion.com/p/3ecce072e82f80bca54ffcb137f57c97) 본문과 전체 블록·해결된 토론 포함 댓글을 읽었다. 조회 결과 토론 1개, 댓글 1개, 답변 없음이다.
- 본문: 미국 Medit 주문의 요청일이 최소 영업일 10일보다 이후일 때 RX 표시일보다 하루 앞서 매핑됨. RX 날짜와 맞추기를 요청한다.
- 원본 예시 `dateDesiredDelivery = 2026-10-19T19:00:39Z`. 한국 10/20 04:00, LA 10/19 12:00이다. 본문은 Medit RX가 한국 시간 기준으로 보인다고 설명하며 FE 수정 필요라고 적었다.
- 10/2 댓글: `request_type=OFFICE_SCANNER`, `upload_platform_name=ITERO` 주문의 `delivery_request_at`이 병원 국가코드에 맞게 설정되는지 확인 요청. iTero 날짜 수정 정책이 결정됐다는 답변은 없다.
- DL-16615 Jira 댓글에서도 Notion 댓글 확인을 요청했다.

### 실제 코드와 화면

- 공용 `shared/ui/src/Order/OrderForm/OrderAdditionalInfoForm.tsx`: 서버의 `officeDeliveryRequestAt`을 폼에 사용. OFFICE_SCANNER DRAFT는 최소 turnaroundDate보다 빠를 때 최소일로 대체. DRAFT 이후는 저장값을 유지한다.
- `DeliveryInfo.tsx`: `officeZoneId`는 현재 날짜/캘린더 기준에 사용. 납기 표시 자체는 `DateFormat.formatDate`와 `new Date`를 사용한다.
- Admin/Clinic의 `useOrderAdditionalInfoForm.tsx`: 선택값을 브라우저 날짜로 format/parse하여 `toISOString()`으로 제출한다. iTero 전용 변환은 없다.
- `shared/models/src/common/axiosInstance.ts`: `zone-id`는 브라우저 IANA timezone이다. 국가코드만으로 시간대를 선택하지 않는다. 서버의 실제 수집/정규화 정책은 FE 코드만으로 확인할 수 없다.
- Admin 주문 단계 페이지는 Medit 플랫폼 원본을 별도 조회하지만 현재 TAT 초기화와 연결돼 있지 않다. `MeditPreview.tsx`는 원본 Delivery에 공용 `formatDate`를 사용한다.
- Chrome의 인증된 운영 Admin 사례 주문을 읽기 조회했다. 현재 희망 배송일 표시는 **2026/10/20 (America/Los_Angeles)**, 데이터 보기의 `officeDeliveryRequestAt`은 **2026-10-20T00:00**다. 상태는 DRAFT 이후다.
- 현재 사례가 원본 수집 당시부터 올바른지, 제출/수동 수정으로 보정됐는지는 확인하지 못했다. 현재 표시가 맞는 것만으로 신규 DRAFT 결함 해결을 주장하지 않는다. 주문 변경/제출을 하지 않았다.
- Node Intl로 원본 UTC의 한국/LA 날짜 차이와, timezone 없는 서버값 `2026-10-20T00:00`이 한국/LA 브라우저에서 모두 20일이지만 제출 ISO는 달라지는 것을 확인했다. 제품 수정 후 회귀 테스트가 아니다.

### 시작 시 Git·전달 조사 이력

- 시작 시 웹 기본 checkout은 clean `release/v1.88.0 / 3a4b1b2cf`, 원격 갱신 후 behind 3이었다.
- 시작 지침에 따라 `git pull --ff-only`로 **94ffc8a9d6248c90ac6fc25f80573eb8400f7264**까지 동기화했다. clean, upstream과 ahead/behind 0/0이다.
- `origin/master = 6b79c9756cc56313fe833aad463bddb1f8c385fa`. 원격 `feature/DL-16615`, `release/v1.89.0`은 조회 시 없다. 이 업무 PR도 없다.
- 기존 DLDS·권한관리 worktree는 각각 다른 기능 소유이므로 사용하지 않는다. 조사 이후 사용자가 branch 생성·구현·검증을 승인해 최상단 상태로 진행했다. commit/push/PR/merge/배포는 실행하지 않았다.
- 최근 Admin Production Actions 성공은 `prd/admin/v1.87.1 / 307752030...`에 대한 것이다. DL-16615 전달이나 실제 배포 artifact 일치를 뜻하지 않는다.
- 앱 저장소는 이번 단계에서 조사/변경하지 않았다. 웹 공용 UI의 native webview 영향은 구현 범위 확정 후 판단한다.

## 다음 시작점

1. 변경 파일 4개를 보존하고 원격/base/checkout 소유권을 재확인한다. 사용자 요청 없는 제품 commit/push/PR은 진행하지 않는다. 2026-10-06 갱신한 AGENTS/SESSION_WORKFLOW에 따라 승인된 일반 신규 구현의 master 기준/로컬 feature 준비는 다시 질문하지 않는다.
2. Admin 실제 앱의 테스트 데이터로 RX·TAT·수동 변경·최소일·재진입 상호작용을 QA한다. 운영 주문 수정/제출은 검증용으로 실행하지 않는다.
3. 전체 자동매핑/Clinic까지 목표라면 서버 측 스캐너 수집 계약·수정 담당을 확인한다. 현재 코드를 전체 결함 해결/운영 반영으로 보고하지 않는다.
4. iTero는 국가코드가 표시 형식에 쓰이는 것, 실제 IANA 타임존과 서버 정규화를 구분한다. 이 댓글의 서버 보장 여부는 미확인이다.
5. v1.89.0 release 브랜치와 전달 대상이 확정되면 최신 target diff·병합 결과를 검증하고 별도 승인 범위의 전달을 진행한다.
