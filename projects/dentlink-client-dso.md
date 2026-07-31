# Dentlink DSO 대시보드 — DL-15223

이 문서는 DL-15223 DSO 대시보드 작업의 개인 체크포인트와 투두리스트다.
다음 세션에서는 채팅 기억보다 이 문서와 live Git, Jira, Figma를 우선하고,
시간에 따라 달라질 수 있는 Git·배포 상태는 반드시 다시 확인한다.

## 작업 범위와 참고 자료

- 사용자 역할: FE
- 작업자: Frankie(박종선)
- Jira 전체 카드:
  [DL-15223](https://innovaid.atlassian.net/browse/DL-15223)
  - 댓글과 다른 작업자 카드에도 FE 요구사항이 있을 수 있으므로 후속 범위 확인 시
    Jira 본문만 보지 않는다.
- FigJam 기획:
  [치과 DSO UX 개선 — 복수 지점 치과 플로우](https://www.figma.com/board/Y1vzeie6wyhHpae3gR5Bkp/-%EC%B9%98%EA%B3%BC--DSO-UX-%EA%B0%9C%EC%84%A0?node-id=662-12577&t=isbn5IPdn1ha7RJb-1)
- Figma 디자인:
  [0100. 치과 DSO대시보드](https://www.figma.com/design/49O3r9Ynug2J3LkgANtR3S/0100.-%EC%B9%98%EA%B3%BC-DSO%EB%8C%80%EC%8B%9C%EB%B3%B4%EB%93%9C?node-id=40-3388&m=dev)
- 제품 범위:
  - Clinic: 별도 DSO 대시보드 페이지와 관련 하위 화면
  - Admin: 내부 운영용 Organization CRUD

Jira·FigJam·Figma의 실제 내용은 접근 가능한 도구로 다시 읽은 경우에만 최신으로
간주한다. 이 체크포인트는 사용자가 제공한 범위와 현재 코드·Git에서 검증한 사실을
기록한다.

## 저장소와 현재 Git 상태 — 2026-07-31

- 공유 저장소: `https://github.com/Innvoaid/dentlink-client`
- 전용 worktree: `/Users/parkjongsun/Repository/dentlink-client-dso`
- 브랜치: `feature/DL-15223`
- upstream: `origin/feature/DL-15223`
- 분기 기준 및 현재 `origin/master`:
  `833a5b40498e1673d082dd4439cb4ada3658952c`
  (`release/v1.81.0 -> master (#4435)`)
- 현재 feature HEAD:
  `95a64e5dbcaf78d4931c33c2cf00e13a49df01ab`
  (`[DL-15223] feat: DSO 대시보드 디자인 및 필터 개선`)
- local feature HEAD와 upstream commit은 일치한다. 다만 최신 Figma·댓글 재검토 뒤
  가능한 Clinic UI/UX 보완을 진행해 현재 worktree에는 19개 미커밋 경로가 있다.
  - tracked 변경 16개: 수정 15개, 삭제 1개
  - untracked 3개
  - staged 파일 0개
  - 공유 저장소 commit·push·merge는 하지 않았다.
- feature는 현재 `origin/master` 대비 `4 ahead / 0 behind`다.
- 작업 커밋:
  - `e8c65d3f2` `[DL-15223] chore: 배포 API 스펙 동기화`
  - `40bfd9526` `[DL-15223] feat: 치과 그룹 관리 및 대시보드 추가`
  - `96106b5cd` `[DL-15223] ui: 날짜 범위 필터 최대 기간 옵션 추가`
  - `95a64e5db` `[DL-15223] feat: DSO 대시보드 디자인 및 필터 개선`
- PR [#4443](https://github.com/Innvoaid/dentlink-client/pull/4443)
  (`Feature/dl 15223`)이 `feature/DL-15223 -> develop`으로 머지됐다.
- 현재 `origin/develop`:
  `43218771e2e5e89188ebc400635cbc96fa3f6497`
  - 부모는 `origin/master` 기준 커밋 `833a5b404`와 feature HEAD
    `40bfd9526`이다.
  - 기존 Admin과 1차 Clinic 구현의 개발 브랜치 통합은 확인됐다.
  - `96106b5cd`, `95a64e5db`는 PR 머지 뒤 추가된 커밋이라 현재
    `origin/develop`에는 없다. `origin/develop...feature/DL-15223`은 develop 쪽
    1개, feature 쪽 2개로 갈라져 있다.
  - 최신 Clinic 디자인 변경의 개발서버 배포 revision과 완료 여부는 아직
    확인하지 않았다.

이 worktree에서 `master`로 이동하거나 다른 Dentlink worktree를 수정하지 않는다.
`origin/master` 동기화, merge, rebase, 추가 push, PR 변경은 현재 live 상태를 확인한
뒤 사용자의 명시적 지시로만 수행한다.

## 현재 완료 수준

### Admin — 1차 구현 완료

내부 운영 화면의 목적에 맞게 별도 디자인을 만들지 않고 기존 Admin의 목록, 상세,
공용 생성·수정 폼, 삭제 흐름을 따랐다.

- Organization 목록과 API 스펙 기반 필터를 추가했다.
  - Organization ID
  - 이름
  - 국가
  - 유형
  - 정렬·페이지네이션
- 목록에서 ID로 상세 이동하며 Organization 이름에는 불필요한 링크 밑줄을 두지
  않았다.
- 상세에서 기본 정보와 아래 관계 목록을 확인할 수 있다.
  - 연결 치과
  - 연결 계정
  - 카테고리별 기본 기공소
- 생성과 수정은 같은 폼을 모드만 달리해 사용한다.
  - 생성은 빈 관계 목록으로 시작한다.
  - 수정은 상세 GET 결과를 기본값으로 넣고 전체 목록을 다시 PUT한다.
  - 국가 코드는 생성 시 선택하고 수정 시에는 API 스펙에 따라 변경하지 않는다.
- 기존 데이터 검색 후 관계를 추가·제거할 수 있다.
  - 연결 계정: 기존 사용자 검색, 현재 권한 `ADMIN`
  - 연결 치과: 기존 Office employer 검색
  - 기본 기공소: 카테고리를 선택한 뒤 기존 Lab employer 검색 및 매핑
- 상세의 수정·삭제와 관련 사용자·기공소 링크를 연결했다.
- create, read/list, detail, update, delete를 신규 Admin Organization API에 연결했다.
- query key, 목록 갱신, 상세 invalidation과 기존 Admin mutation 흐름을 사용했다.
- 사용자 화면 검토에서 목록, 필터, 상세의 중첩 목록, 링크, 공용 폼, 국가 수정 제한,
  삭제 API 연결 및 관계 선택 흐름을 확인했다.

Admin은 현재 요구된 1차 범위에서 완료로 분류한다. 개발서버 실데이터를 이용한
안전한 CRUD 스모크와 배포 revision 확인은 별도 QA 단계다.

### Clinic — 디자인 우선 구현 및 Figma 재조정, 데이터 연동 미완료

- Organization 전용 라우트를 추가했다.
  - `/organizations`
  - `/organizations/offices`
  - `/organizations/billings`
- URL에는 `[organizationId]`를 넣지 않는 것으로 결정했다.
- Figma 기준 별도 레이아웃과 Dashboard, Offices, Billings 화면을 추가했다.
- 카드, 필터, 표, 내비게이션, Billing export modal 등 현재 디자인 화면을 구성했다.
- Figma의 DSO Dashboard 화면을 기준으로 Dashboard를 재조정했다.
  - Office 필터와 날짜 필터의 크기, 간격, chip, 아이콘을 화면 전용 스타일로
    맞췄다.
  - `Data from ... ago` 버튼은 글자 크기를 줄이지 않고 디자인 패딩을 유지한
    가변 너비로 변경했다.
  - `ManageOffices` 텍스트 SVG를 기존 icon 생성 설정과 같은 방식으로 추가했다.
  - 주문·매출·카테고리·의사 카드의 아이콘, tooltip, 표, 정렬, skeleton과
    목 지표를 최신 디자인에 맞춰 보완했다.
- 기존 `DateRangeFieldV2`를 별도 Organization 전용 컴포넌트로 복제하지 않고
  선택 옵션으로 확장했다.
  - 기본 구분자와 기존 동작은 유지한다.
  - Organization 화면만 `rangeSeparator="-"`, `maxRangeDays={90}`을 사용한다.
  - 90일 초과 시 기존 공용 오류 아이콘과 Figma 문구 위치를 사용하고 날짜를 다시
    선택하면 오류가 즉시 갱신된다.
- 기존 프로젝트 컴포넌트와 스타일 구조를 우선 사용하고 DSO 화면에 필요한
  컴포넌트만 새로 만들었다.
- 현재 지표와 목록 데이터 대부분은 `organization.fixtures.ts`의 목데이터다.
- `Orders by Category`의 카테고리 이름은 배포된
  `/catalogs/category?countryCode=US` API를 사용한다.
  - `office/users/own`의 Organization에 `countryCode`가 추가될 예정이므로 현재는
    `US` fallback을 사용한다.
- Organization 경로에서는 기존 Clinic 전역 배너와 지원 토글을 숨긴다.
- `OfficeUserProfileDto.defaultLandingView`가 `ORGANIZATION`이면 로그인 직후 기본
  경로를 `/organizations`로 결정한다.
- 명시적인 `next` 경로가 있으면 그 경로를 우선하며, 인증된 사용자가 주소창으로
  다른 기존 페이지에 직접 접근하는 흐름을 전역 Auth redirect로 막지 않는다.

Clinic은 화면 뼈대와 랜딩 흐름까지 구현됐지만 실제 DSO 데이터·API가 연결되지
않았으므로 기능 완료로 분류하지 않는다.

### 공유 모델과 API

- 배포된 Swagger 기준으로 `generate:api-type`을 실행하고 생성 파일을 동기화했다.
- Admin Organization용 수기 API wrapper와 서비스별 타입을 추가했다.
- 신규 수기 Organization 모델은 `data-contracts`를 직접 참조하지 않는다.
  생성된 API client 내부의 `data-contracts` 참조와 수기 모델 계층을 구분한다.
- 수정 폼 상세 query는 `refetchOnWindowFocus: false`로 설정해 포커스 복귀 시
  작성 중 값이 reset되지 않게 했다.
- 카테고리 선택 전 기본 기공소 검색 API가 불필요하게 실행되던 활성화 옵션을
  제거했다. 공용 검색 hook의 기존 의미는 변경하지 않았다.
- 공용 날짜 범위 컴포넌트는 새 컴포넌트를 만들지 않고 선택적 props로 확장했다.
  기존 호출부가 props를 주지 않으면 표시와 동작이 바뀌지 않는다.
- `SvgManageOfficesText` 생성 컴포넌트는 저장소의 SVGR 설정으로 다시 생성한
  결과와 byte-level diff가 없는 것을 확인했다.

## 확정된 구현 결정

- 한 사용자는 여러 Organization에 소속될 수 있다.
- Clinic Organization 라우트는 URL에 Organization ID를 넣지 않는다.
- Clinic은 백엔드 API가 준비되기 전까지 디자인 우선, 목데이터 기반으로 진행한다.
- 존재하지 않는 API를 추측해 만들지 않고 실제 배포된 스펙만 사용한다.
- 디자인과 세부 요구사항은 변경될 수 있으므로 데이터 계층과 화면 표현을 분리한다.
- Figma는 제품 요구와 UI/UX 의도를 확인하는 기준이며 임의의 픽셀 차이를 맞추는
  것이 목적이 아니다. 기능, 정보 구조, 상태, 상호작용은 반영하되 기존 프로젝트의
  공용 UI, 디자인 토큰, 레이아웃, 반응형 규칙과 운영 패턴을 우선한다.
- 기존 프로젝트와 가장 가까운 운영 컴포넌트, hook, query/cache, routing 방식을
  우선하며 코드량과 추상화를 무조건 늘리지 않는다.
- Admin은 별도 디자인보다 기존 내부 CRUD 사용성을 따른다.
- 생성과 수정은 공용 폼을 사용하되 API 스펙상 수정 가능 필드가 다르면 모드에서
  제한한다.
- Organization 기본 랜딩 판단은 로그인 후 기본 목적지가 필요한 경우에만 한다.
  모든 인증 페이지 이동에 전역 redirect를 추가하지 않는다.

## 최신 Figma 전체 재검토 — 2026-07-31

Figma 원본 화면과 최신 명세, 공개 댓글 1~19를 현재 Clinic 구현 및 브라우저
렌더링과 다시 대조했다. 1차 검토 뒤 백엔드나 제품 결정 없이 처리할 수 있는
UI/UX 범위는 공유 프로젝트의 로컬 변경으로 반영했으며, 사용자의 지시대로 아직
커밋하거나 push하지 않았다.

현재 DSO 데스크톱 화면은 기존 디자인의 큰 구조와 주요 상태를 따른다. 90일 날짜
제한, 이전 동일 기간 비교, 주문 오름차순·의사 내림차순 기본값, 카테고리 0건의
그래프 제외·목록 유지, hover 시 이름·건수·비율과 다른 조각 opacity 처리,
Sample Case 및 Partially Paid 반영, Office 정렬, Billing 단일 선택 필터와
페이지네이션은 최신 Figma 및 댓글의 최종 합의와 일치한다.

백엔드 DSO 데이터 API가 없어도 다음 UI·UX 및 기존 API 범위는 구현할 수 있다.

- 기존 `/office/managed` 레이아웃과 탭 구조에 단일병원 Admin Dashboard를 추가한다.
  별도 페이지 레이아웃을 복제하지 않고 기존 좌측 Office 정보 카드와 데스크톱·모바일
  반응형 구조를 그대로 사용한다.
- 단일병원 Dashboard는 Office 필터 없이 날짜와 새로고침, 주문·청구 2개 지표,
  카테고리와 의사 목록을 보여준다. 기존 Organization Dashboard의 지표·차트·목록
  단위를 실제 두 번째 사용처에 맞게 제한적으로 공용화한다.
- Organization 관리자에게만 Clinic 데스크톱 GNB의 `Dashboard ↗` 진입점을 추가하고
  모바일에서는 숨긴다.
- My Profile에 `Default View`의 `Dashboard | Office` 제어를 추가한다. 생성 API 타입에
  이미 있는 `/office/users/own/default-view`를 기존 수기 API wrapper, mutation,
  사용자 cache·atom 갱신 패턴에 연결하고 기존 `SegmentControl`을 사용한다.
- Dashboard 기본 날짜를 실행일 기준 최근 30일로 만들고 최초 새로고침 표시는
  `Data from 1min ago`로 맞춘다.
- 같은 시작일·종료일 선택은 공용 날짜 컴포넌트에 기본값이 기존 동작을 유지하는
  선택적 prop으로 확장하고 Dashboard와 export에서만 활성화한다.
- 지표 이전 기간 tooltip의 hover trigger를 비교 문구가 아니라 전체 지표 행 또는
  카드로 넓힌다.
- Dashboard의 수기 정렬 제어는 기존 `SegmentControl`로 교체한다.
- Billing 목록·차트의 최소 높이는 300px 기준으로 조정한다. Advanced Export는
  기존 공용 입력·드롭다운·날짜 범위 컴포넌트와 목 옵션으로 실제 로컬 선택 및
  90일 검증이 되게 만들고, 현재의 raw input/select 기반 임시 동작을 제거한다.
- Organization shell의 inline Dashboard SVG는 적합한 기존 아이콘이 없으면 저장소의
  기존 SVGR 생성 방식으로 추가한다.

다음 항목은 실제 API 또는 제품 결정 전에는 완료로 처리하지 않는다.

- 실제 지표·주문·Billing·export 데이터, loading·empty·error 상태
- 국가·통화와 비활성·퇴사 의사 포함 여부를 반영하는 실제 응답
- Office 방문 시 선택 Office의 active employer 전환에 필요한 실데이터 매핑
- 단일병원 디자인에서 말하는 `Admin`을 Clinic의 `OWNER`, `PAYMENT_MANAGER`,
  `EDITOR`, `VIEWER` 중 어떤 권한으로 제한할지에 대한 확정
- 댓글의 미해결 질문인 새로고침 elapsed label의 `days` 최대 기간 또는 30일 단위
  자동 갱신 규칙

## 오늘 최종 체크포인트 — 2026-07-31

### 완료한 개발·디자인 범위

- Chrome Default 프로필의 실제 로그인 세션으로 다음 화면을 직접 확인했다.
  - `/organizations`
  - `/organizations/offices`
  - `/organizations/billings`
  - Advanced Export modal과 필수 입력 오류
  - `/my`의 `Default View`
- Figma 원본의 Dashboard, Offices, Billings 노드를 다시 렌더링해 실제 화면과
  대조했다. 화면에 보이는 댓글 그룹은 `4 + 2 + 2 + 3 + 2 + 3`개와 단독 댓글
  1개로 총 17개였고, 앞서 모든 본문과 답글을 읽어 반영 여부를 분류한 상태와
  동일해 새 댓글 누락은 확인되지 않았다.
- Dashboard에서 아래 항목을 실제 렌더링으로 확인했다.
  - `Manage Offices` 로고, Organization 전용 navigation과 GNB
  - 잘리지 않는 `All Offices`, 날짜 범위, 디자인 패딩을 유지한 가변 너비
    `Data from 1min ago`
  - `Order Counts` 표기와 Orders 오름차순·Dentist 내림차순 기본값
  - 지표 카드 전체 hover 시 실제 이전 기간
    `2026/05/31-2026/06/30` 표시
  - 카테고리 hover의 이름·건수·반올림 비율과 다른 segment opacity 30%
  - API 카테고리 이름 기반 목 지표 매핑, `Sample case` 0건 목록 유지,
    14개 응답을 위한 412px 내부 스크롤
- Offices에서 목록, `Visit Office`, `Not an Employee` 상태를 확인했다.
- Billings에서 `All Offices`, `All Statuses`, `Partially paid`, pagination,
  PDF 버튼, Advanced Export modal을 확인했다.
- Advanced Export는 기존 공용 입력·필터·날짜 컴포넌트를 사용하며 dentist와
  date 미선택 시 실제 required error가 표시되는 것을 확인했다.
- My Profile에서 Organization 관리자에게 `Dashboard ↗` GNB 진입점과
  `Default View: Dashboard | Office`가 표시되는 것을 확인했다. 값 변경은 실제
  PATCH이므로 최종 시각 검토에서는 mutation을 실행하지 않았다.
- Organization 화면 전용 보정은 공용 필터 컴포넌트의 전역 스타일을 바꾸지 않고
  해당 화면의 아이콘 크기·간격만 조정했다. 별도
  `OrganizationDateRangeFilter`/`DateRangeFieldV2` 복제본은 만들지 않았고 공용
  컴포넌트를 선택적 prop으로 확장해 기존 호출부 기본 동작을 유지했다.
- Dashboard 아이콘은 저장소의 기존 생성 방식과 동일한 assets/dist 구조로
  추가했다.

### 오늘 기준 미완료·대기

- Clinic DSO의 실제 지표, 주문, 지점, Billing, export API와 실데이터 연동
- `office/users/own.organizations[].countryCode` 배포 뒤 현재 `US` fallback 교체
- 여러 Organization 중 현재 Organization을 선택·유지하는 서버·전역 상태 계약
- `Visit Office`가 선택 지점 employer context를 실제로 전환하는 연동
- 실데이터 기준 loading, empty, error, 권한 없음과 부분 응답 상태
- 비활성·퇴사 의사 포함 규칙, 국가별 통화, 단일병원 Dashboard의 Admin 권한 범위
- 댓글에서 답이 확정되지 않은 새로고침 elapsed label의 최대 기간·자동 갱신 규칙
- 현재 로컬 변경의 공유 저장소 commit·push·PR 반영과 개발서버 배포 revision 확인

현재 처리 가능한 디자인·UI·UX 범위에서는 알려진 추가 작업이 없다. Clinic 전체
기능 완료라고 부를 수 없는 이유는 위 API·실데이터·제품 결정 대기 항목 때문이며,
Admin 1차 구현 완료 판단과는 구분한다.

## 검증된 내용

- Admin TypeScript 통과
- Clinic TypeScript 통과
- commit hook의 Clinic, Lab, Admin TypeScript 통과
- Admin, Clinic, Lab production build 통과
- Admin lint 오류 0건; 기존 warning만 존재
- pre-push의 서비스 lint는 기존 warning만 출력하고 성공
- shared coverage는 baseline 대비 변화 없음
- Prettier와 `git diff --check` 통과
- 최신 변경 대상 Clinic 파일 ESLint 통과
- 최신 두 커밋의 commit hook에서 Clinic, Lab, Admin TypeScript 통과
- 최신 push hook에서 전체 lint 오류 0건, 기존 warning 420건과 shared coverage
  baseline 대비 변화 없음으로 성공
- Admin과 Clinic production build route 목록에 Organization 페이지 생성 확인
- 신규 Organization 수기 코드의 `data-contracts` 직접 참조 0건 확인
- Clinic unauthenticated `/organizations` 접근 시 signin의 `next` 경로로 이동하는
  기존 인증 흐름 확인
- 2026-07-31 최신 로컬 변경에서 Clinic TypeScript 통과
- 최신 Dashboard·Billings·fixture 대상 ESLint 통과
- Clinic 전체 lint 오류 0건, 기존 warning 234건으로 성공
- `git diff --check` 통과
- 로컬 HTTP route smoke에서 `/organizations`, `/organizations/offices`,
  `/organizations/billings`, `/my` 모두 200 확인
- Chrome 실제 화면과 Figma 원본 노드의 Dashboard, Offices, Billings 최종 대조 완료

제한 사항:

- Clinic Jest는 기존 Next/Jest module 설정 문제로 실행 시작 단계에서 실패했으며,
  이번 변경의 테스트 실패로 확정하지 않았다.
- 실제 개발서버 배포 완료와 배포 revision은 아직 확인하지 않았다.
- 최신 두 커밋은 `origin/develop`에 아직 없으므로 기존 개발 배포에 자동 포함된
  것으로 간주하지 않는다.
- Clinic 실데이터, loading, empty, error 상태와 다중 Organization 선택 동작은
  백엔드 계약이 아직 연결되지 않아 검증하지 않았다.
- shared UI 전체 lint는 저장소에 동시에 해석되는 `eslint-plugin-storybook`
  `8.38.0`과 `8.57.1` 충돌로 실행되지 않았다. Clinic TypeScript와 실제 호출부
  대상 lint는 통과했으므로 이번 변경의 lint 실패로 분류하지 않는다.
- Admin의 사용자 화면 검토는 완료됐지만 모든 mutation을 별도 테스트 데이터로
  반복하는 정형 E2E는 실행하지 않았다.
- 기존 lint warning, Next 권장 TypeScript 버전 경고, 오래된 Browserslist 데이터
  경고는 이번 범위에서 수정하지 않았다.

## 우선순위 TODO

### P0 — 최신 Clinic 변경 통합과 개발 배포 확인

- [ ] 최신 두 커밋을 `develop`에 반영할 PR 또는 통합 방법은 사용자의 명시적
  지시 후 진행한다.
- [ ] 통합 뒤 개발서버가 최신 Clinic HEAD를 포함하는 revision인지 확인한다.
- [ ] Admin과 Clinic의 실제 배포 URL 및 health 상태를 확인한다.
- [ ] 배포 실패 시 코드 문제, 환경 문제, 배포 revision 불일치를 먼저 구분한다.
- [ ] 배포 확인 결과를 이 문서의 현재 체크포인트에 갱신한다.

### P1 — Admin 개발서버 실데이터 스모크

- [ ] 목록 조회, 페이지네이션과 ID·이름·국가·유형 필터를 실제 응답으로 확인한다.
- [ ] 상세에서 연결 치과·멤버·기본 기공소 목록과 사용자·기공소 링크를 확인한다.
- [ ] 안전한 테스트 Organization으로 생성 → 조회 → 수정 → 삭제를 확인한다.
- [ ] 수정 폼에서 국가가 유지되고 다른 필드와 세 관계 전체 목록이 PUT되는지
  payload를 확인한다.
- [ ] 기존 사용자 검색과 `ADMIN` 권한 추가·제거를 확인한다.
- [ ] 기존 Office 검색과 연결·해제를 확인한다.
- [ ] 카테고리 선택 후 Lab 검색·매핑·제거를 확인하고, 카테고리 선택 전 Lab 요청이
  나가지 않는지 확인한다.
- [ ] 수정 중 창 포커스를 이동했다가 돌아와도 입력값이 초기화되지 않는지 확인한다.
- [ ] create/update/delete 이후 목록·상세 cache와 이동 경로가 정상인지 확인한다.

### P1 — Clinic 실제 데이터와 API 연동

- [ ] 백엔드에서 제공할 Clinic DSO API 목록과 DTO를 실제 Swagger로 확인한다.
- [ ] `office/users/own` Organization의 `countryCode` 배포를 확인하고 카테고리
  요청의 `US` fallback을 실제 값으로 교체한다.
- [ ] 여러 Organization 소속 사용자의 현재 Organization 선택·유지 계약을 확정한다.
- [ ] `organization.fixtures.ts`의 각 데이터 묶음을 실제 query와 응답 모델로 교체한다.
  - 대시보드 지표와 주문·카테고리·의사 데이터
  - 지점 목록
  - Billing 목록, 필터, 페이지네이션과 export
- [ ] 화면별 loading, empty, error와 부분 응답 상태를 추가한다.
- [ ] 필터와 기간 선택이 실제 query parameter 및 cache key에 반영되는지 확인한다.
- [ ] Organization 변경 시 화면 데이터와 URL·전역 상태의 책임을 확정한다.
- [ ] 권한이 없거나 Organization 소속이 없는 사용자 동작을 확정하고 구현한다.

### P2 — 디자인과 사용자 경험 재QA

- [ ] `/organizations`를 다시 실행해 최신 Figma와 desktop 기준으로 최종 대조한다.
- [ ] 날짜 범위 90일 초과 오류, 재선택 시 오류 해제, 구분자와 footer 배치를
  브라우저에서 확인한다.
- [ ] 관련 sibling variant와 반응형·긴 텍스트·빈 데이터·loading 상태를 확인한다.
- [ ] Dashboard, Offices, Billings의 간격, typography, 표, 카드, modal을 재확인한다.
- [ ] 디자인 또는 기획 변경이 생기면 기존 컴포넌트 재사용 가능성을 먼저 검토한다.
- [ ] 로그인 후 `defaultLandingView=ORGANIZATION`과 명시적 `next` 우선순위를
  개발서버에서 재확인한다.
- [ ] 기존 OFFICE 사용자의 기본 홈, 직접 URL 이동, 로그아웃·재로그인 회귀를
  확인한다.

### P3 — 통합과 완료 조건

- [ ] 개발서버 QA 결과에 따른 최소 수정만 feature 브랜치에서 진행한다.
- [ ] 추가 변경 시 TypeScript, lint, build, `git diff --check`와 관련 브라우저 QA를
  다시 수행한다.
- [ ] Jira 본문·댓글·관련 카드에서 누락된 FE 범위가 없는지 최종 확인한다.
- [ ] Clinic API·실데이터·디자인 QA가 끝난 뒤에만 Clinic 구현 완료로 변경한다.
- [ ] production 대상 PR, release 반영 및 merge-ready 여부는 별도 승인과 검증으로
  판단한다.

## 다음 시작점

1. `codex-personal-context`를 pull하고 이 문서를 읽는다.
2. 정확한 worktree가
   `/Users/parkjongsun/Repository/dentlink-client-dso`인지 확인한다.
3. `feature/DL-15223`, HEAD, upstream, `origin/master`, `origin/develop`, PR #4443과
   worktree 상태를 live Git에서 다시 확인한다.
4. 현재 19개 미커밋 경로의 diff와 이 체크포인트를 확인하고, 사용자가 명시적으로
   요청한 경우에만 공유 저장소 commit·push를 진행한다.
5. 그 뒤 `develop` 통합 방법과 개발서버 revision을 확인한다.
6. 배포가 정상이라면 Admin P1 실데이터 스모크를 수행한다.
7. Admin 결과와 별개로 Clinic은 실제 API 계약을 확인한 뒤 목데이터 교체 작업을
   시작한다.
8. 공유 저장소 commit, push, PR 수정, merge는 각 단계에서 사용자의 명시적
   승인을 받는다.
