# 기공소 환자목록 디자인·API 대응 — DL-16652

## 현재 상태 — 2026-10-06 로컬 구현 완료·일부 연동 QA 대기

- 사용자 요청은 기공소 웹·기공소 네이티브 앱만 대상이다. Office 웹·Office 앱은 제외한다.
- Jira: https://innovaid.atlassian.net/browse/DL-16652
  제목 `[FE] 기공소 환자 목록 디자인 변경`, 본문 없음·해야 할 일·fixVersion 미지정.
  부모 DL-16596은 참고 관계다. 타기공소 주문 가드 수정과 별도 기능/브랜치로 진행한다.
- 기존 메인 프로젝트 폴더에서 새 기능 세션을 시작한다. 새 프로젝트 폴더는 만들지 않는다.
  세션 이름·ID는 [FE 조율 색인](dentlink-fe.md)의 DL-16652 절에서 확인한다.
- 기능 세션에서 웹 Lab 표와 Lab 앱 카드를 구현하고 DEV API 계약·호출·화면 흐름을 대조했다.
  제품 코드는 양 worktree의 미커밋 변경으로 남아 있다. 제품 commit/push·PR·merge·배포는 미실행이다.
  웹 브라우저 검증과 Android 개발 빌드는 통과했으며, 앱 실제 화면·검색·이동 QA와 iOS 빌드는 미확인이다.
- 사용자 지시: 기능 세션에서 직접 진행하며 메인세션으로 자동 진행/완료 메시지를 보내지 않는다.
  의미 있는 체크포인트는 이 Git-backed 정본에 저장한다.

## 사용자 확정 UI 범위

- Figma: https://www.figma.com/design/2OR0Gj7NUFEEeYBjQg5Y6v/0108.-%EC%B9%98%EA%B3%BC-%EB%8B%B4%EB%8B%B9-%ED%99%98%EC%9E%90-%EC%A0%9C%ED%95%9C-%EA%B6%8C%ED%95%9C-%EC%B6%94%EA%B0%80?node-id=325-31483&m=dev
- 지정 Section `325:31483`의 실제 이름은 `기공소 Patients`다. Asis와 Tobe를 구분한다.
  웹 Tobe `325:31918`, hover `325:32058`, 앱 `Patient_Tobe / 325:32222`가 있다.
  카드 UI 비교 Section은 `325:34735`다. 상세 동작·폰트·간격·색은 원본 디자인 컨텍스트에서 확인한다.
- Figma 변경 설명: 전체 케이스/케이스 상태 대신 전체 주문수·내 기공소 주문수와 주문상태를 표시하고
  케이스 관련 정보를 제거한다. 주문목록의 상태 표시 개념을 가져간다.
- 새 표/카드 모양은 **이번 화면에서만 사용**한다. 필요하면 `ui` 경로에 둘 수 있지만
  공식 공통 컴포넌트화·디자인시스템 등록·기존 테이블의 전역 변경을 작업 목표로 삼지 않는다.
  적합한 기존 토큰·기본 UI는 재사용하며 요구 범위 밖 화면/동작을 추가하지 않는다.
- 앱 주문 수 배치는 사용자가 **우선 권장안으로 진행하고 디자인은 추후 변경될 수 있다**고 확정했다.
  질문 당시 `Patient_Tobe`는 최근 주문 제목 오른쪽에 `주문 수`를 표시했고, 비교안은 본문 별도 행이었다.
  구현은 제목 오른쪽 `labOrderCount`, 상단 치과명 행 오른쪽 `totalOrderCount`를 유지한다.
  작업 중 Figma가 변경됐다. 17:16 KST 재확인한 main에는 환자 정보 외부 세 번째 줄에 두 주문 수가 있으며
  header 주문 수가 없다. 이는 당시 승인 배치와 다르므로 실시간 디자인을 따라 추가 UI를 넣지 않았다.
  다음 디자인 요청 때 승인된 당시안과 최신 원본을 대조한다.

## 백엔드 계약 — 2026-10-06 DEV 실확인·STG 이전 응답

`PatientConsolidateListLabDto`는 DEV Swagger와 실제 인증 응답에서 확인한 12개 필드다.
초기 캡처 정보와 배포 상태를 분리해서 확인했다.

| 필드 | 캡처의 의미 |
| --- | --- |
| `officeId`, `officeName` | 치과 ID·이름 |
| `patientName`, `birthDate` | 환자명·생년월일 |
| `totalOrderCount` | 타기공소 주문 포함 전체 주문수, DRAFT·DELETED 제외 |
| `labOrderCount` | 우리 기공소 주문수, DRAFT·DELETED 제외 |
| `recentOrderId` | 우리 기공소 최근 주문 ID |
| `recentOrderStatus` | 최근 주문 기본 상태 |
| `recentOrderDetailStatus` | 최근 주문 상세 상태, IN_PROGRESS 하위 구분 |
| `recentCategoryName` | 최근 주문 카테고리명 |
| `recentDentistName` | 최근 주문 담당 의사명 |
| `isRemake` | 최근 주문 리메이크 여부 |

- 주문목록과 같은 의미: status를 기본으로 하고 IN_PROGRESS일 때만 detailStatus의
  DESIGN/READY_FOR_FABRICATION/IN_FABRICATION 표시를 적용한다. 추가 Remake는 `isRemake`로 표시한다.
  detailStatus의 REMAKE/REMAKE_ROLLBACK만으로 Remake 표시를 추론하지 않는다.
- DEV `/v3/api-docs` 및 인증한 `/lab/patients/consolidate`가 HTTP 200이며 새 DTO를 반환했다.
  DEV 전체 763행에서 새 필드 계약을 확인했다. 현재 데이터에는 DRAFT/DELETED가 없지만
  최근 주문에서 두 상태를 제외한다는 계약은 없다. 제외 설명은 주문 수 필드에만 있다.
- STG 인증 endpoint는 HTTP 200이지만 orderId·totalCaseCount·recentCaseTitle·caseStatus·
  latestAssignedDentistName이 있는 이전 DTO를 반환했다(686행). STG Swagger는 404였다.
  이전 필드를 새 필드로 임의 fallback하지 않는다. STG 전환 후 별도 실연동 QA가 필요하다.
- 모델 생성·서비스/쿼리·화면 데이터 흐름을 각각 확인한다. UI 검증·fixture 검증·실제 API 연동 QA를 구분한다.

## 작업 공간과 승인

| 제품 | worktree | branch | 초기 기준/HEAD |
| --- | --- | --- | --- |
| 웹 Lab | `/Users/parkjongsun/Repository/dentlink-client-patient-list` | `feature/DL-16652` | `origin/master / 6b79c9756cc56313fe833aad463bddb1f8c385fa` |
| Lab 앱 | `/Users/parkjongsun/Repository/dentlink-lab-app-patient-list` | `feature/DL-16652` | `origin/develop / f33283339d339b3c6d39fe2735a8420f2c1a5ae1` |

- 준비 당시 양 worktree 모두 초기 기준 대비 0/0·clean이었다. 현재도 초기 HEAD를 유지하며
  각 worktree에 8개 파일의 미커밋 변경만 있다. upstream·원격 feature·PR 없음.
  저장소별 Git은 독립이며 작성 세션은 신규 기능 세션 하나다. 기존 가드·권한관리·DLDS checkout은 보존한다.
- 사용자가 승인한 것은 신규 세션/worktree 준비와 디자인·API 대응 구현·검증이다.
  제품 commit·push·PR·merge·환경 branch 변경·배포는 별도 지시를 받아 수행한다.
- 새 세션 모델·추론은 메인과 같은 `gpt-6.1-sol / ultra`를 명시하고 생성 후 실제 적용값을 확인한다.

## 구현과 변경 파일

- 웹: `lab/src/components/PatientList/PatientListLayerDesktop.tsx`를 화면 전용으로 추가했다.
  그룹 header·전체/우리 기공소 주문 수·환자명/생년월일·최근 주문 상태/카테고리/담당의사·hover를 적용했다.
  공용 기본 UI·StatusChip을 재사용하고 Remake는 `isRemake`일 때만 표시한다.
  DELETED는 공용 chip이 지원하지 않아 이 화면에서 기존 `orderStatusDisplayName` 용어로 표시한다.
  KO 표 폭과 70px 행을 유지하고, EN 상세 상태가 옆 열을 침범하지 않도록 EN 상태 열만 넓혔다.
  기존 검색·페이지 이동을 유지하며 클릭/Enter/Space는 `recentOrderId`로 이동한다.
- 웹 나머지 변경: `lab/src/pages/patients/index.tsx`, `lab/src/lib/PatientList/usePatientList.tsx`,
  `lab/src/i18n/locales/{en,ko}/patients.json`, `shared/models/src/data-contracts.ts`,
  `shared/models/src/patient/{patient.types.ts,patient.apis.lab.ts}`.
  공용 기존 Patient DTO와 Office/Admin API 응답 alias는 보존했다.
- 앱: `src/features/orderList/components/OrderPatientListItem.tsx`를 승인된 카드 배치로 변경했다.
  화면 전용 상태 구성에서 기존 OrderStatusLabelMap·Icon·Typography·theme을 재사용한다.
  IN_PROGRESS 상세 상태 gating, isRemake, 0·누락값, 긴 데이터 ellipsis, pressed 색, 최근 주문 이동을 적용했다.
- 앱 나머지 변경: `src/features/orderList/tabs/OrderPatientTabScreen.tsx`, `src/models/Api.ts`,
  `src/queries/useCommonServiceQueries.ts`, `src/services/{patient.service.ts,patient.types.ts}`,
  `src/assets/svg/{index.ts,SvgObjectLabFilled.svg}`. stale myPatientOnly 전달을 제거하고 officeId 계약을 연결했다.
- 양 제품의 생성 모델은 공식 Swagger generator를 임시 경로에 실행한 결과에서 해당 Lab 선언/alias만
  자동 추출했다. 무관한 전체 생성 drift나 생성 파일의 수기 필드 편집은 넣지 않았다.
- 앱 신규 문구는 Figma Korean을 좁은 `useTranslation` defaultValue로 사용했다.
  Google 번역 시트·생성 registry·환경·서명·lockfile·공식 공용 디자인시스템은 변경하지 않았다.

## 검증·미확인·다음 작업

- 웹 확인: DEV 인증 조회·실제 브라우저 10행 표시, 열 폭/hover·콘솔 pageerror 없음.
  임시 합성 데이터 브라우저 검증에서 IN_PROGRESS 3종 상세상태, 다른 기본 상태의 상세값 무시,
  isRemake 독립 표시, DELETED, 0/누락값·긴문자열, 표시 개수 변경, 페이지 이동, 검색 시 page/size 초기화,
  검색 결과 없음, 1100px viewport의 표 가로스크롤, 키보드 recentOrderId 이동을 확인했다.
  Remake 포함 행 높이 70px, EN Show100rows 문구/아이콘과 상태 칩의 열 내부 표시도 실측했다.
- 웹 검사: Lab·Clinic·Admin `tsc --noEmit` 통과, 변경 파일 ESLint/Prettier·diffcheck 통과.
  전체 Lab lint는 error 0·기존 warning 189다. 정식 staging E2E 전체 suite 판정은 아니다.
- 번역: `pnpm check:i18n`은 en/ko orders와 patients가 원본 시트와 다르다고 실패했다.
  orders는 이번 변경 파일이 아니며, patients는 신규 문구의 시트 반영이 남아 있다.
  PM 시트나 무관한 번역을 자동 덮어쓰지 않았다. 시트 반영 후 재생성·check가 필요하다.
- 앱 검사: 변경 파일 ESLint/Prettier·diffcheck와 임시 renderer 3개 검사가 통과했다.
  전체 typecheck의 Icon 2개·Tooltip 1개·MessageText 1개 오류는 변경 전후 출력이 완전히 동일하다.
- Android `assembleDevelopmentDebug` arm64가 3분 2초·1084 tasks로 성공했고 APK 설치도 성공했다.
  이번 생성 AVD의 splash까지 관찰했으나 activity/screencap system service timeout이 cold boot 뒤에도
  반복됐고 Metro bundle 요청이 없어 실제 카드·검색·이동 실연동 QA는 확인하지 못했다.
  이번 Metro 8088·AVD는 종료했으며 기존 Office runtime은 보존했다. iOS 빌드는 미실행이다.
- 다음 시작: 현재 기기에서 두 feature worktree의 미커밋 diff를 먼저 확인한다.
  앱 실행 가능한 device에서 DEV 실화면 QA, STG 새 DTO 전환 확인, 번역 시트 반영을 진행한다.
  디자인 변경은 새 승인 기준을 대조하며 적용한다. 제품 commit/push/PR은 사용자 지시 후 수행한다.
  개인 정본 Git 기록은 코드 자체를 원격으로 보존하지 않는다.

## 참고 자료와 다음 시작점

- 보존한 API 캡처: `/Users/parkjongsun/.codex/visualizations/2026/10/06/01a08f0c-2057-7852-ae8d-0cf950a91fd3/DL-16652-backend-fields.png`
- Figma 개요 캡처: 같은 경로의 `DL-16652-figma-reference.png`. 파일은 현재 기기 자료이며 Git은 위 필드·링크를 전달한다.
- 현재 기기 QA 자료: `/Users/parkjongsun/.codex/visualizations/2026/10/06/01a11038-d621-7fb3-ad4e-58d01fbb9a6a/DL-16652/`.
  웹 fixture 캡처/측정, 타입/lint/i18n log, 최초·변경 후 Figma 앱 캡처, Android build/renderer/type log를 보존했다.
  최초 Figma 캡처의 파일 저장 시각은 최초 취득 시각이 아니며, 최초 취득은 17:06 변경 관찰 이전이다.
  자료는 local-only이며 Git은 확인 결과와 다음 시작점만 전달한다.
