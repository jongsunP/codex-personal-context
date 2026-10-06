# 기공소 환자목록 디자인·API 대응 — DL-16652

## 현재 상태 — 2026-10-06 신규 세션 인계 준비

- 사용자 요청은 기공소 웹·기공소 네이티브 앱만 대상이다. Office 웹·Office 앱은 제외한다.
- Jira: https://innovaid.atlassian.net/browse/DL-16652
  제목 `[FE] 기공소 환자 목록 디자인 변경`, 본문 없음·해야 할 일·fixVersion 미지정.
  부모 DL-16596은 참고 관계다. 타기공소 주문 가드 수정과 별도 기능/브랜치로 진행한다.
- 기존 메인 프로젝트 폴더에서 새 기능 세션을 시작한다. 새 프로젝트 폴더는 만들지 않는다.
  세션 이름·ID는 [FE 조율 색인](dentlink-fe.md)의 DL-16652 절에서 확인한다.
- 메인세션은 접수·worktree·인계를 준비했다. 제품 기능 코드·QA·commit/push·PR·배포는 미실행이다.
  실제 구현·디자인 및 API 대조·검증은 신규 기능 세션에서 이어간다.
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

## 백엔드 변경 예정 계약 — 사용자 캡처, 아직 작업 중

`PatientConsolidateListLabDto` 캡처에 나온 필드다. 배포된 Swagger나 실제 응답 확인을 대체하지 않는다.

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
- 기존 생성 DTO에는 orderId·totalCaseCount·recentCaseTitle·caseStatus·latestAssignedDentistName이 있다.
  기존 계약과 예정 계약을 섞거나 현재 서버가 새 필드를 제공한다고 단정하지 않는다.
- 모델 생성·서비스/쿼리·화면 데이터 흐름을 각각 확인한다. UI 검증·fixture 검증·실제 API 연동 QA를 구분한다.

## 작업 공간과 승인

| 제품 | worktree | branch | 초기 기준/HEAD |
| --- | --- | --- | --- |
| 웹 Lab | `/Users/parkjongsun/Repository/dentlink-client-patient-list` | `feature/DL-16652` | `origin/master / 6b79c9756cc56313fe833aad463bddb1f8c385fa` |
| Lab 앱 | `/Users/parkjongsun/Repository/dentlink-lab-app-patient-list` | `feature/DL-16652` | `origin/develop / f33283339d339b3c6d39fe2735a8420f2c1a5ae1` |

- 양 worktree 모두 초기 기준 대비 0/0·clean. upstream·원격 feature·PR 없음.
  저장소별 Git은 독립이며 작성 세션은 신규 기능 세션 하나다. 기존 가드·권한관리·DLDS checkout은 보존한다.
- 사용자가 승인한 것은 신규 세션/worktree 준비와 디자인·API 대응 구현·검증이다.
  제품 commit·push·PR·merge·환경 branch 변경·배포는 별도 지시를 받아 수행한다.
- 새 세션 모델·추론은 메인과 같은 `gpt-6.1-sol / ultra`를 명시하고 생성 후 실제 적용값을 확인한다.

## 참고 자료와 다음 시작점

- 보존한 API 캡처: `/Users/parkjongsun/.codex/visualizations/2026/10/06/01a08f0c-2057-7852-ae8d-0cf950a91fd3/DL-16652-backend-fields.png`
- Figma 개요 캡처: 같은 경로의 `DL-16652-figma-reference.png`. 파일은 현재 기기 자료이며 Git은 위 필드·링크를 전달한다.
- 개인 컨텍스트 pull 후 BOOTSTRAP·공통 지침·이 문서·Lab 앱 정본과 각 worktree AGENTS를 읽는다.
  Figma MCP의 `skill://figma/figma-design-to-code/SKILL.md`를 읽고 고해상도 get_design_context/스크린샷을 대조한다.
  웹 `/patients`와 앱 Order Patients 탭의 현재 API·라우팅·표시를 확인한 뒤 승인된 범위만 구현한다.
