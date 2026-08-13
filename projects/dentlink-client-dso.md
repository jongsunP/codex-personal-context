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

## 최신 체크포인트 — 2026-08-13

- 마지막으로 확인된 추가 FE 카드 `DL-15964`를 구현하고 Jira를
  `Ready for Deploy`로 이동했다.
  - Organization Dashboard, Office Managed Dashboard, Advanced Export의 최대 날짜
    범위를 백엔드 계약과 동일한 92일로 확장했다.
  - 통계·결제내역 조회 목적에 맞게 세 화면 모두 미래 날짜를 선택할 수 없고 오늘까지
    선택할 수 있도록 통일했다.
  - Advanced Export의 안내, FE 검증, 오류 문구도 92일 기준으로 맞췄다.
- 날짜 경계 판단은 별도 국가 타임존 계산을 추가하지 않고 기존 Dentlink 흐름을
  유지했다.
  - Office API는 브라우저의 IANA 타임존을 `zone-id` 헤더로 이미 전달한다.
  - Organization의 `countryCode`는 날짜 표시 형식에는 유효하지만 US처럼 복수
    타임존인 국가의 현재 날짜를 결정하기에는 부족하므로 브라우저 현지 날짜가 현재
    계약에 더 정확하다.
  - 공용 Calendar의 `enabledEndDate`는 제외 경계다. UI에서 오늘까지 허용하려면
    기존 사용처처럼 다음 날을 경계값으로 전달한다. 이는 내일을 선택 가능하게 하는
    처리가 아니다.
  - 공용 Calendar나 신규 날짜 util은 수정·추가하지 않았다.
- API 조정 및 스테이징 전달 상태도 live Git/GitHub에서 재확인했다.
  - PR [#4493](https://github.com/Innvoaid/dentlink-client/pull/4493):
    기본 기공소 조회 API 변경을 `release/v1.83.0`에 merge,
    `327047c54`
  - PR [#4494](https://github.com/Innvoaid/dentlink-client/pull/4494):
    같은 변경을 `develop`에 merge, `34f4fb6b8`
  - PR [#4495](https://github.com/Innvoaid/dentlink-client/pull/4495):
    master 기준으로 재생성한 `stage`에 `release/v1.83.0`을 merge,
    `ced4ede7f`
- `DL-15964`는 release와 develop의 DSO 레이아웃 차이를 보존하기 위해 각 base에서
  별도 커밋과 PR로 준비했다.
  - PR [#4496](https://github.com/Innvoaid/dentlink-client/pull/4496):
    `feature/v1.83.0-follow-up -> release/v1.83.0`, commit `f2d348c30`, open.
    마지막 확인 시 CodeRabbit이 pending이라 merge state는 blocked다.
  - PR [#4497](https://github.com/Innvoaid/dentlink-client/pull/4497):
    `feature/DL-15964-develop -> develop`, commit `dad54cc00`, open.
    마지막 확인 시 CodeRabbit 성공, merge state clean이다.
  - release 커밋을 develop에 그대로 cherry-pick하면 세 DSO 파일의 기존 구조 차이로
    충돌하므로, cherry-pick을 중단하고 develop의 기존 레이아웃을 보존한 채 날짜
    정책 변경만 적용했다.
- 검증 결과:
  - release/develop 양쪽 Clinic TypeScript, 대상 파일 ESLint, Prettier 통과
  - commit hook의 Clinic, Lab, Admin TypeScript 통과
  - push hook 성공, 전체 lint 오류 0건과 기존 warning만 존재
  - shared hooks 24건 및 release shared configs 3건 통과
  - develop push hook의 coverage report는 base와 baseline 차이로 큰 delta를
    출력했지만 hook 자체는 성공했다. 기능 변경이 shared package를 수정하지는 않았다.
- 현재 worktree `/Users/parkjongsun/Repository/dentlink-client-dso`는
  `feature/DL-15964-develop` (`dad54cc00`)이고 원격과 일치하며 clean이다.
- 다음 시작점은 PR #4496의 CodeRabbit 완료/리뷰 처리 요청과 두 PR merge 여부
  확인이다. 두 PR이 merge되고 신규 QA가 없다면 현재 알려진 DSO FE 개발 범위는
  종료다. PR merge, 배포 revision, 스테이징·실데이터 QA는 구현 완료와 구분한다.

## 최신 체크포인트 — 2026-08-11

- 백엔드 대기였던 두 API를 배포 계약 기준으로 반영해 현재 알려진 FE 개발 범위를
  완료했다.
  - `DL-15906`: Admin Organization의 카테고리별 기본 기공소 관계 조회,
    `appliedOffices` 표시와 선택 Office 적용 API를 연결했다.
  - `DL-15937`: Clinic Advanced Export의 Dentist source를 Organization 전용 조회
    API로 교체했다.
- 최종 전달 PR은 모두 merge됐다.
  - [#4490](https://github.com/Innvoaid/dentlink-client/pull/4490):
    `feature/DL-15906-DL-15937 -> release/v1.83.0`, merge commit
    `fc7f9b977`, 2026-08-11 merge
  - [#4491](https://github.com/Innvoaid/dentlink-client/pull/4491):
    `feature/DL-15906-DL-15937-develop -> develop`, merge commit
    `8a3168ca2`, 2026-08-11 merge
  - [#4492](https://github.com/Innvoaid/dentlink-client/pull/4492):
    `release/v1.83.0 -> stage`, merge commit `dd1be88bf`, 2026-08-11 merge
- PR #4490 CodeRabbit 리뷰에서는 유효한 오류 처리 3건을 `81aaf2d35`로 반영하고,
  생성 계약과 실제 렌더 경로에 맞지 않는 지적은 근거를 답변한 뒤 모든 thread를
  resolve했다. 같은 수정은 develop용 브랜치에 `8924d54bc`로 반영했다.
- `stage`는 기존 원격 브랜치를 삭제한 뒤 당시 `origin/master`
  `064b02790`에서 다시 생성하고 PR #4492를 merge했다. 2026-08-11 live 확인 HEAD는
  `origin/release/v1.83.0` `fc7f9b977`, `origin/develop` `8a3168ca2`,
  `origin/stage` `dd1be88bf`다.
- 사용자 확인 기준 현재 릴리즈 준비와 스테이징·개발서버 배포가 진행 중이다.
  배포 revision과 실데이터 결과는 아직 별도 확인 전이며, 구현 완료와 구분한다.
- 다음 단계는 배포 완료 후 Clinic/Admin DSO 전체의 최종 QA 1회다. 회귀나 신규
  요구가 발견되지 않으면 DL-15223 개발을 종료한다. 현재 알려진 추가 FE 개발 및
  백엔드 대기 항목은 없다.
- 전용 worktree `/Users/parkjongsun/Repository/dentlink-client-dso`는 clean하며 현재
  `feature/DL-15906-DL-15937-develop`을 checkout한 상태다. 두 feature PR은 merge됐지만
  로컬·원격 branch 정리는 아직 요청받지 않았으므로 유지한다.

## 이전 체크포인트 — 2026-08-10

- release QA 후속 전달과 로컬 정리를 완료했다.
  - PR head: `8c2eae5cf` (`[DL-15223] fix: 대시보드 필터 복수 선택 복원`)
  - merge commit: `41de67a8f` (`[DL-15223] DSO 대시보드 및 QA 반영 (#4484)`)
  - 전용 worktree `/Users/parkjongsun/Repository/dentlink-client-dso`는 clean 상태를
    확인한 뒤 제거했다.
  - 로컬 `DL-15223-qa` 브랜치는 삭제했고 `origin/DL-15223-qa`는 보존했다.
  - prefix가 없던 이 브랜치는 종료된 예외다. 이후 신규 작업 브랜치는 기본적으로
    `feature/` prefix를 사용한다.
- release 전달용 PR
  [#4484](https://github.com/Innvoaid/dentlink-client/pull/4484)를
  `DL-15223-qa`에서 `release/v1.83.0` 대상으로 생성했고 2026-08-10에 merge했다.
  GitHub merge 결과는 단일 parent의 squash commit `41de67a8f`다.
- 이번 QA 브랜치에 반영한 주요 커밋은 다음과 같다.
  - `0e634e3ca` `[DL-15223] DSO QA 및 미수금 조회 기능 반영`
  - `1bb4daa4e` `[DL-15223] DSO 최종 QA 누락사항 수정`
  - `f4309d4f1` `[DL-15223] fix: Export 모달 외부 클릭 방지`
  - `51d37649b` `[DL-15223] fix: 대시보드 최종 QA 수정`
  - `fddf3a4eb` `[DL-15223] fix: 로그인 및 대시보드 QA 수정`
  - `ce216f58b` `chore: 앱 버전 1.83.0 반영`
  - `1365a631a` `[DL-15223] fix: CodeRabbit 리뷰 지적사항 반영`
  - `24ed762a7` `[DL-15223] fix: 치과의사 주문 표 헤더 정렬 수정`
  - `8c2eae5cf` `[DL-15223] fix: 대시보드 필터 복수 선택 복원`
- QA에서 확정된 FE 범위는 현재 브랜치에 반영했다.
  - Organization 미수금 전용 탭과 서버의 `isOutstandingOnly` 계약
  - 관리 치과 Dashboard의 데스크톱·모바일 레이아웃과 필터
  - Dashboard/Billing 텍스트, 동적 통화 헤더, Export modal의 고정 footer와
    validation caption 전환
  - Default View가 Dashboard인 Organization ADMIN만 신규 로그인 이동의 영향을
    받고 그 외 로그인·로그아웃·명시적 이동은 기존 흐름을 유지하도록 좁힌 처리
  - 기존 Typography, SegmentControl, modal, date-range 등 가장 가까운 운영
    컴포넌트 재사용과 공용 UI의 기존 기본 동작 보존
  - Dashboard/Billing Office 필터와 Billing status 필터의 복수 선택 및 `All`
    상호배타 동작 보존
- 마지막 Jira 정리 기준 Frankie 담당 하위 카드 중 바로 구현 가능한 13건은
  `Ready for Deploy`이며, 아래 두 건만 백엔드 계약 대기로 `To Do`에 유지한다.
  - `DL-15906`: 카테고리 활성화 신규 API 배포 대기
  - `DL-15937`: Advanced Export 전용 Dentist 조회 API 배포 대기
  - `DL-15888`은 이번 DSO QA 범위와 별도 작업이다.
- 검증 및 전달 상태:
  - commit hook의 Clinic, Lab, Admin TypeScript 통과
  - push hook의 lint 오류 0건, 저장소 기존 warning 418건
  - shared config test 3건, shared hook test 24건과 coverage check 통과
  - 실제 브라우저에서 Dashboard Office 2개, Billing Office 2개 및 상태 2개 복수
    선택과 `All` 복원을 확인했다.
  - 구현·코드 QA와 PR 전달은 완료했지만 release 실데이터 QA와 배포 결과는 별도다.
- 로컬 정리 결과 DSO 전용 worktree와 `DL-15223-qa` 브랜치는 제거됐다. 별도 i18n
  worktree는 유지하며, 원격 DSO head 브랜치는 별도 삭제 요청 전까지 보존한다.

2026-08-10 최종 QA에서 `51d37649b`의 필터 helper 공통화가 기존 복수 선택 배열을
마지막 한 값으로 축소한 회귀를 확인했다. 이는 Jira·Figma·API 요구가 아니라 기존
동작의 cardinality를 보존하지 못한 구현 실수였다. `8c2eae5cf`에서 helper가 모든
선택값을 유지하고 `All`만 상호배타적으로 처리하도록 복원했으며, 실행되지 않는 검증용
신규 test 파일은 제품 브랜치에 남기지 않았다. 이후 selection helper를 공통화할 때는
empty/All/single/multiple 동작표와 모든 호출부를 함께 검증한다.

다음 시작점은 release 실데이터 QA 결과 또는 백엔드 대기 카드의 계약 배포다.
DL-15906 또는 DL-15937 배포를 알린 경우 종료된 브랜치를 되살리지 않고, 요청받은
base에서 `feature/` prefix의 새 전용 worktree를 만든 뒤 `generate:api-type` 결과
diff를 먼저 확인해 해당 카드만 연결한다. PR merge와 release 실데이터 QA를 FE 구현
완료와 혼동하지 않는다.

## 최신 체크포인트 — 2026-08-06

- 전용 worktree는 release 확인용으로 전환했다.
  - `/Users/parkjongsun/Repository/dentlink-client-dso`
  - `release/v1.83.0`
  - `origin/release/v1.83.0`
- local/remote release HEAD는
  `ec792ab5ae0755cdaffe224aa54da790286cdc95`로 일치하며 worktree는 clean이다.
  로컬 `feature/DL-15223` 브랜치는 삭제했고 원격 feature 브랜치는 보존했다.
- 이번에 원격 반영된 커밋:
  - `0742be5d2` `[DL-15801] feat: 대시보드 필터 Amplitude 이벤트 추가`
  - `65705d322` `[DL-15223] chore: 최신 API 스펙 동기화`
  - `9d82d144b` `[DL-15223] feat: Organization Advanced Export API 연동`
  - `8829beab8` `[DL-15223] fix: CodeRabbit 리뷰 지적사항 반영`
  - `9eab1b3c3` `[DL-15223] fix: 모바일 팝업 저장소 접근 예외 처리`
  - `44990b0ec` `[DL-15223] fix: 대시보드 모바일 판별 및 카드 너비 수정`
  - `d324dc559` `[DL-15223] chore: 최신 master 반영`
- release 전달용 PR
  [#4469](https://github.com/Innvoaid/dentlink-client/pull/4469)는
  `feature/DL-15223`에서 `release/v1.83.0`으로 merge 완료됐으며 release merge
  commit은 `ec792ab5a`다.
  CodeRabbit 리뷰 19건을 모두 검토해 12건은 코드로 반영하고 7건은 현재 계약과 제품
  정책에 따른 유지 사유를 답변했으며, 19개 thread를 모두 resolve했다. 후속 리뷰의
  `localStorage` 접근 예외도 `9eab1b3c3`에 반영했다. 마지막 live 확인에서 미해결
  CodeRabbit thread는 0개였으므로 PR을 현재 상태로 유지한다. 이후 새 리뷰가 다시
  추가될 때만 해당 내용을 재검토한다.
- 배포된 Advanced Export 계약을 생성 타입으로 확인하고
  `GET /office/organizations/{organizationId}/billings/payment-histories`를 실제
  modal과 별도 인증 PDF route에 연결했다.
  - Office ID 1~5개, 선택 Dentist ID, payment status, 시작·종료일을 계약 형태로
    전달한다.
  - 목 Dentist 목록을 제거하고 기존 Clinic의 활성 Dentist 조회를 재사용한다.
  - API의 `paymentHistories`와 `priceSummary`를 별도 수기 domain type/API wrapper
    경계로 받아 기존 PDF header, publication, table, price primitive에 전달한다.
  - Office 이름은 `branchName` 우선·`employerName` fallback, 결제수단과 상태는
    기존 enum/status formatter를 사용한다.
  - 행 순서는 서버 소유로 두며 FE 정렬이나 목데이터 가공을 추가하지 않았다.
- Figma PDF 노드 `92-106286`을 Chrome에서 다시 확인했다. 행과 Subtotal, Tax,
  Total, Amount Paid, Amount Refunded에는 통화 심볼을 표시하지 않고 `Total Due`에만
  `AUD 720.00`처럼 통화 코드를 표시한다. Advanced Export 응답에는 별도 통화 필드가
  필요하지 않으며, 기존 활성 병원 profile의 locale과 currency code를 사용한다.
- Organization Billing은 응답 행의 currency를 우선해 `Amount (AUD)` 같은 동적
  header와 금액 포맷을 사용하고, 데이터가 아직 없을 때는 활성 병원 currency를
  fallback으로 사용한다. Sidebar Outstanding Balance도 같은 기존 활성 병원 통화로
  표시한다. 추가 백엔드 문의 없이 현재 확정된 FE 범위는 구현 완료다.
- 검증 결과:
  - 변경 Clinic 파일 ESLint 오류 0건
  - Clinic/Admin/Lab TypeScript 통과
  - Clinic production build 통과 및 신규 PDF route 생성 확인
  - `git diff --check` 통과
  - push hook 전체 lint 오류 0건, 저장소 기존 warning 418건
  - shared hook test 24건 및 coverage check 통과
- 구현 완료와 별개로 실제 로그인 데이터의 Advanced Export, 배포 revision,
  실데이터 회귀, 실제 Amplitude 수신은 QA·배포 단계이며 이번 FE 미완료로 분류하지
  않는다.

아래 2026-08-04 이하 체크포인트는 진행 경과를 보존한 역사 기록이다. 현재 상태와
충돌하면 이 2026-08-06 체크포인트와 live Git을 우선한다.

## 저장소와 현재 Git 상태 — 2026-08-04

- 공유 저장소: `https://github.com/Innvoaid/dentlink-client`
- 전용 worktree: `/Users/parkjongsun/Repository/dentlink-client-dso`
- 브랜치: `feature/DL-15223`
- upstream: `origin/feature/DL-15223`
- 현재 `origin/master`:
  `6bb4119c137921a23f724819781b6a59004b4e03`
  (`Release/v1.82.0 -> master (#4457)`)
- 현재 feature HEAD:
  `67f0f40174053136147296f010c88fafce965933`
  (`[DL-15223] ui: Advanced Export 선택 UI 개선`)
- local feature HEAD와 `origin/feature/DL-15223`는 일치하며 worktree는 clean이다.
- `origin/master...feature/DL-15223`은 master 쪽 0개, feature 쪽 18개다.
  `origin/master`는 merge parent로 포함돼 있다.
- PR [#4443](https://github.com/Innvoaid/dentlink-client/pull/4443)은
  `40bfd9526`까지 `develop`에 머지한 과거 PR이다. 이후 feature 작업과 최신 master
  merge commit은 이 PR의 범위가 아니다.
- PR 머지 뒤 추가된 커밋:
  - `96106b5cd` `[DL-15223] ui: 날짜 범위 필터 최대 기간 옵션 추가`
  - `95a64e5db` `[DL-15223] feat: DSO 대시보드 디자인 및 필터 개선`
  - `6d0f4e133` `[DL-15223] chore: 배포 API 스펙 동기화`
  - `628594828` `[DL-15223] ui: 날짜 범위 선택 기능 확장`
  - `f6cf0b8ec` `[DL-15223] feat: DSO 대시보드 및 기본 화면 설정 개선`
  - `3dbb8d93c` `[DL-15223] fix: Organization 아이콘 디자인 반영`
  - `b389ce2d2` `[DL-15223] feat: DSO 대시보드 디자인 정합성 개선`
  - `5eb162832` `[DL-15223] feat: DSO 대시보드 API 및 화면 개선`
  - `a140d32af` `[DL-15223] feat: DSO 대시보드 및 설정 화면 개선`
  - `d4b4e01d0` `[DL-15223] feat: Organization 청구 및 접근 제어 기능 반영`
  - `345699e4d` `[DL-15801] feat: DSO 대시보드 Amplitude 이벤트 추가`
  - `47b0537c2` `[DL-15223] feat: Organization 관리 및 PDF 기능 보완`
  - `98e541732` `[DL-15223] fix: Organization 화면 안정성 보완`
  - `d86e4cea2` `[DL-15223] chore: 최신 master 반영`
  - `fe961e329` `[DL-15223] fix: Organization 지점명 기본값 설정`
  - `67f0f4017` `[DL-15223] ui: Advanced Export 선택 UI 개선`
- `67f0f4017`까지 local feature HEAD와 remote가 일치하고 worktree는 clean이다.
- 최신 commit hook은 Clinic, Lab, Admin TypeScript를 통과했다. 최신 push
  hook은 전체 lint 오류 0건, 기존 warning만 존재하고 shared coverage baseline
  변화 없음으로 성공했다. 변경 파일 Prettier, ESLint와 `git diff --check`도
  통과했다.
- 최신 `origin/master`를 merge하면서 My의 Design Approval, links, 생성 아이콘과
  API/user 파일 충돌을 해결했다. My/DSO 화면과 최신 Organization transport 계약은
  feature의 후속 구현을 유지하고, Case Preference entry point 정규화, Pickup 링크와
  새 아이콘은 master를 반영했다. 생성 파일은 전체를 한쪽으로 덮지 않고 충돌한
  Organization 계약만 더 최신 feature 결과를 유지해 master의 비충돌 API 변경을
  보존했다.

이 worktree에서 `master`로 이동하거나 다른 Dentlink worktree를 수정하지 않는다.
`origin/master` 동기화, merge, rebase, 추가 push, PR 변경은 현재 live 상태를 확인한
뒤 사용자의 명시적 지시로만 수행한다.

## 이 브랜치에서 일반화한 작업 방식

이 항목은 DL-15801 Amplitude 구현만의 회고가 아니다. `feature/DL-15223`에서
Admin Organization CRUD부터 Clinic DSO 화면, API 전환, 인증·권한, My Profile,
PDF 재사용, Figma 재검토와 계측까지 진행하며 확인한 방법을 이후의 다른
`dentlink-client` 신규 기능에도 적용하기 위한 기록이다. 공통 규칙은
`DEVELOPMENT_STYLE.md`의 `Dentlink Client Implementation Defaults`에 반영했다.

- 요구사항은 Jira 상위 카드만 보지 않고 관련 FE 카드·댓글, FigJam 흐름, Figma의
  대상 노드·sibling variant·댓글, 배포된 Swagger, live Git과 같은 앱의 가장 가까운
  운영 구현을 함께 대조한다. 접근하지 못했거나 결정되지 않은 내용은 추측하지 않는다.
- Clinic은 Clinic의 컴포넌트·hook·service·query·routing을, Admin은 기존 Admin
  CRUD·공용 폼·테이블·mutation 흐름을 따른다. 같은 모노레포라는 이유로 다른 앱의
  구현 방식을 섞지 않는다.
- 디자인 차이는 기존 공용 UI의 사용 조합이나 기본 동작을 보존하는 선택적 prop으로
  먼저 해결한다. 실제로 반복되는 새로운 책임이 없으면 전용 wrapper나 helper,
  화면별 복제 컴포넌트를 만들지 않는다.
- API가 늦게 나오는 기능은 교체 가능한 UI/data 경계를 유지하고, 배포 뒤 Swagger를
  다시 생성해 diff를 검토한 다음 기존 domain type·API wrapper·query 계층으로
  연결한다. 생성 코드는 generator 소유 형식을 유지하고 수기 기능 코드에서
  `data-contracts`를 직접 소비하지 않는다.
- 인증 후 기본 랜딩, 명시적 `next`, 메뉴 노출, 직접 URL 접근 방어를 서로 다른
  책임으로 다룬다. 전역 Auth redirect처럼 기존 탐색 흐름을 침범하는 방식보다 실제
  lifecycle의 가장 좁은 소유 지점에서 처리한다.
- Figma는 픽셀 복제보다 정보 구조·상태·상호작용·의도된 세부 표현을 확인하는
  기준으로 사용한다. 전체 반영을 말하려면 대표 화면뿐 아니라 관련 variant와 댓글을
  읽고 실제 브라우저의 화면·DOM·네트워크 또는 조건부 코드를 필요한 범위에서
  검증한다.
- 기존 Billing statement처럼 제품에 이미 검증된 흐름은 신규 기능에서도 재사용하고,
  삭제 UI 숨김이나 미출시 export처럼 보류된 동작은 서버 계약과 복구 가능성을
  보존한 채 현재 요구 범위만 제한한다.
- 구현·로컬 검증·사용자 시각 QA·통합·배포 revision·실데이터·Amplitude 수신을
  각각 별도 상태로 기록한다. 코드가 commit·push됐다는 이유만으로 배포나 운영
  수신까지 완료됐다고 표현하지 않는다.

## 현재 완료 수준

### 2026-08-04 마무리 점검 결과

- 백엔드 API가 나오기 전에 할 수 있는 Organization Advanced Export 범위를
  구현했다. 신규 payment history PDF는 기존 Payment History PDF를 수정하지 않고
  별도 인증 route와 컴포넌트로 분리했으며 공용 PDF header, publication, table,
  price primitive를 재사용한다.
- Advanced Export용 화면 모델은 생성 transport DTO를 추측하지 않고 shared
  Organization presentation type으로만 정의했다. 행 순서는 서버 소유로 두어 FE에서
  임의 정렬하지 않는다.
- 임시 sample data로 실제 PDF blob을 생성하고 A4 한 페이지를 렌더링해 9개 열,
  금액·summary·footer의 배치를 시각 확인한 뒤 sample 연결은 제거했다.
- Admin 생성은 선택한 국가 기반 catalog category 조회를 사용한다. 수정은
  Organization 상세 응답의 category-lab 관계만 사용하며 별도 category-labs 조회를
  추가하지 않는다. 향후 `labId: null`인 미설정 category도 폼 선택값에서 제외하고,
  payload에는 매핑된 category-lab만 보낸다.
- Admin Organization 생성 폼에서 치과를 추가하면 해당 치과 이름을 필수 지점명의
  기본값으로 넣고 사용자가 수정할 수 있게 했다. 수정 모드에서 서버가 준 기존
  `branchName`은 덮어쓰지 않으며, 치과 이름이 없으면 빈 값과 기존 필수 검증을
  유지한다.
- Dashboard 날짜를 지우면 필수 API 파라미터가 비는 대신 기존 30일 기본 범위로
  복원되도록 Organization과 Office Managed 양쪽을 맞췄다.
- 기존 page shell이 이미 `main`을 소유하는 My Design Approval 하위 화면은 중첩
  `main`을 `div`로 수정했다.
- Advanced Export의 최신 Figma 선택 UI를 API와 분리된 입력 경계까지 구현했다.
  - Office는 검색 가능한 다중 선택이며 최대 5개로 제한하고 안내 문구를 표시한다.
  - Office 표시는 기존 우선순위대로 `branchName`을 사용하고, 선택 요약은 첫 지점명과
    추가 개수로 표시한다.
  - 날짜는 기존 `DateRangeFieldV2`를 사용한 단일 범위 입력으로 통합하고 90일 제한과
    공용 아이콘을 유지한다.
  - 드롭다운은 기존 modal body의 overflow 해제 옵션을 사용해 아래 필드 위로
    겹쳐 열리며, modal 높이를 늘리거나 body에 이중 스크롤을 만들지 않고 menu 내부만
    스크롤한다.
  - shared UI 변경은 기존 기본 동작을 보존하는 optional prop과 multiple mode로
    제한했다. Figma 대상 노드와 실제 Chrome 화면에서 열림 방향·겹침을 재확인했다.
- 최신 Figma 댓글에서 Organization/Office 소속이 없는 사용자도 My Profile의
  Case Preferences와 Design Approval을 그대로 노출하는 것으로 확정됐다. 현재
  desktop/mobile 구현은 두 항목을 소속 여부와 관계없이 노출하고 Default View만
  Organization ADMIN에게 제한하므로 추가 수정이 필요 없다.
- master 비교용 draft PR
  [#4459](https://github.com/Innvoaid/dentlink-client/pull/4459)를 기준으로
  `origin/master...feature/DL-15223`의 92개 변경 파일을 최종 코드 검토했다. 권한 우회,
  데이터 손상, 기존 흐름을 깨는 치명적 문제와 명확한 불필요 수기 변경은 발견하지
  않았다. 생성 API diff는 generator 소유 결과로 유지한다.
- 최종 검토에서 Clinic/Admin/Lab TypeScript, 변경 파일 lint, Clinic/Admin production
  build와 `git diff --check`가 통과했다. Clinic Jest는 기능 assertion 실패가 아니라
  기존 `next/jest` module 해석 문제로 테스트 실행 자체가 시작되지 않았다.
- 공용 `getCurrencyNumberFormat`은 이 프로젝트에서 country code를 받도록 사용하며
  `CA`를 US 표기 방식으로 보정한다. `US`/`CA` 전달 자체는 신규 버그로 분류하지
  않는다. 미수금과 Billing의 실제 통화 표시는 백엔드가 추가하기로 한 통화 심볼
  계약이 배포된 뒤 해당 필드를 연결한다.

현재 기능상 남은 범위는 다음 두 가지다.

1. Organization Advanced Export API가 배포되면 modal query, 실제 dentist source,
   다운로드/실패 흐름을 신규 PDF route에 연결한다.
2. 백엔드 통화 심볼 필드가 배포되면 API 타입을 다시 생성하고 미수금, Billing 금액과
   `Amount (USD)` 고정 헤더, 필요 시 신규 PDF 금액 표시에 연결한다. 기존 화면과
   포맷터 구조를 유지할 수 있는 작은 연동 범위이며 대대적인 재구현은 필요하지 않다.

Admin category-lab의 nullable 처리와 미설정 payload 제외는 이미 준비돼 있으며 현재
남은 FE 기능으로 분류하지 않는다. PR #4459는 draft라 CodeRabbit이 실제 리뷰를
건너뛴 상태이며, 이는 제품 기능 미완료가 아니라 PR을 전달할 때 수행할 별도 리뷰
게이트다.

`Visit Office`는 기존 active employee 전환 구현을 사용하며, 사용자가 실제로
버튼을 눌러 대상 병원으로 진입되는 것을 수동 확인했다.

최신 master 통합과 충돌 조정도 `d86e4cea2`로 완료해 원격 feature 브랜치에
push했다.

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

### Clinic — 주요 API 연동 완료, export API 대기

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
  - Figma 댓글 `#26`에서 확인을 요청한 경과시간 문구는 Organization과 단일병원
    Dashboard 모두 기존 60초 interval로 브라우저 새로고침 없이 갱신된다.
    `currentTime` 표시 상태만 변경하며 API를 다시 호출하지 않는다.
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
- Dashboard 지표, Office·Category·Dentist 주문 집계, Office 목록, Billing 목록과
  명세서 PDF를 배포된 Organization API에 연결했다.
- 단일병원 `/office/managed` Dashboard도 배포된 Office dashboard API에 연결했다.
- Organization 목록의 `countryCode`를 카테고리 조회와 날짜·통화 형식에 사용한다.
  백엔드와 합의한 현재 범위는 응답 배열에 Organization이 항상 하나이므로
  `organizations[0]`을 사용한다. 다중 선택은 현재 미완료가 아니라 정책 변경 시
  다시 다룰 향후 범위다.
- `Visit Office`는 기존 Office 선택 흐름과 같이 `activeEmployeeId` 설정,
  `activateEmployee`, query invalidation, 기본 홈 이동을 사용한다. 실패 시 이전
  employee ID로 복원하고 성공 응답으로 `activeEmployee`도 갱신한다.
- Office 표시 이름은 `branchName`을 우선하고 없으면 `employerName`을 사용한다.
- Organization Billing은 서버 목록, Office·상태 필터, 서버 페이지네이션을 사용하고
  기존 `/billing/statement`와 동일한 PDF 화면을 Organization statement API로
  재사용한다.
- 실제 청구서 `E186-2026-03-001`로 기존 Billing과 Organization 양쪽 PDF가 같은
  `Consolidated Billing Statement`를 렌더링하고 Download blob을 만드는 것을
  Chrome에서 확인했다.
- `outstandingBalance > 0`이면 Organization sidebar에 미수금과 `Check Now`를
  표시하고 UNPAID·PARTIALLY_PAID Billing 필터로 이동한다.
- Organization 경로에서는 기존 Clinic 전역 배너와 지원 토글을 숨긴다.
- `OfficeUserProfileDto.defaultLandingView`가 `ORGANIZATION`이면 로그인 직후 기본
  경로를 `/organizations`로 결정한다.
- 명시적인 `next` 경로가 있으면 그 경로를 우선하며, 인증된 사용자가 주소창으로
  다른 기존 페이지에 직접 접근하는 흐름을 전역 Auth redirect로 막지 않는다.
- `/organizations` 계열은 `organizations[0].authority === "ADMIN"` 사용자만
  접근하며 직접 URL 접근도 403으로 방어한다. 모바일 진입과 데스크톱에서 모바일
  크기로 바뀌는 경우에는 기존 주문하기 흐름과 같은 `react-device-detect` 및
  viewport hook 조합으로 `Mobile Not Supported` popup을 표시한다.
- My Profile은 기존 화면 내부 구조를 재사용해 Settings 레이아웃, Design Approval,
  Case Preferences, Promotional SMS와 Organization 관리자용 Default View를
  데스크톱·모바일 디자인에 맞게 재배치했다.
- Admin Organization 상세의 Delete UI는 사용자 요청에 따라 현재 숨겨 두었으며
  API와 복구 가능한 기존 구현은 유지한다.
- Swagger 생성 파일은 generator format을 유지하도록 Prettier 대상에서 제외해
  저장 시 `Office.ts` 등에 대량 포맷 diff가 재발하지 않게 했다.

현재 서버 API가 없는 `Advanced Export`는 modal, 유효성, 별도 PDF 화면·렌더러까지
준비했다. 실제 query·dentist source·다운로드 연결은 배포 계약 대기다. develop
통합·배포 확인도 별도 대기다.

### 공유 모델과 API

- 배포된 Swagger 기준으로 `generate:api-type`을 실행하고 생성 파일을 동기화했다.
- Organization dashboard, own, billing list, billing statement와 Office dashboard
  API 변경을 수기 domain wrapper·타입 계층에 반영했다.
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

### Amplitude — DL-15801 구현 완료

- Jira [DL-15801](https://innovaid.atlassian.net/browse/DL-15801)과 연결된
  [Notion 기획](https://app.notion.com/p/3b1ce072e82f8056ac51fcb02d4a1bc5)을
  직접 확인했다. Jira 카드에는 별도 댓글·첨부가 없었다.
- 기존 `AMP_Track`을 소유 컴포넌트에 직접 추가했으며 별도 analytics helper나
  mapper 파일을 만들지 않았다.
  - 단일병원·DSO Dashboard refresh: `refresh_data_button_click`
  - Billing Advanced Export: `advanced_export_button_click`
  - Export Payment History CTA: `export_button_click`
  - My Profile Default View: `default_view_click`
    - `defaultviewType: "Office" | "Dashboard"`
- `export_button_click`은 기획의 CTA 클릭 정의에 따라 날짜 유효성 검사 결과와
  무관하게 실제 클릭 시 기록한다. 성공 이벤트로 해석하지 않는다.
- Dashboard 체류시간은 운영 환경의 기존 Amplitude page view/session autocapture를
  사용하고 명세에 없는 수기 duration 이벤트는 추가하지 않았다.
- 구현 커밋 `345699e4d`를 `origin/feature/DL-15223`에 push했다. 배포 및 Amplitude
  수신 확인 전에는 live 이벤트 완료로 간주하지 않는다.

DL-15801은 위 브랜치 전체 작업 방식의 한 적용 사례이자 완료 현황이다. 공통으로
재사용할 방법의 범위를 Amplitude 계측에만 한정하지 않는다.

## 확정된 구현 결정

- 한 사용자는 여러 Organization에 소속될 수 있다.
- Clinic Organization 라우트는 URL에 Organization ID를 넣지 않는다.
- Clinic은 배포된 API만 연결하고, 아직 API가 없는 기능만 교체 가능한 UI 상태로
  유지한다.
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
UI/UX 범위는 공유 프로젝트에 반영하고 `b389ce2d2`까지 커밋·push했다.

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

다음은 2026-07-31 당시의 대기 판단이다. 2026-08-03 현재 상태는 문서 상단의
`Clinic — 주요 API 연동 완료, export API 대기`를 우선한다.

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
- 지표 카드 tooltip은 기존 공용 `Tooltip`을 사용하며, Figma 댓글의 변경된 hover
  영역에 맞춰 카드 padding을 제외한 콘텐츠에서만 하단 중앙에 표시되도록 했다.
  Chrome에서 콘텐츠 hover 시 노출되고 padding hover 시 노출되지 않는 것을 확인했다.
- 최신 생성 API 타입 변경은 CRM, 배송지 연락 이메일, 주문 상세 상태 관련이며
  DSO 전용 API 변경은 없다. `organizations[].countryCode`도 아직 추가되지 않았다.
- Figma 댓글 `#1866490807`에 맞춰 상단 Organization 이름의 Office 아이콘을 기존
  `SvgObjectOfficeLine`에서 `SvgObjectOfficeFilled`로 교체했다. 기존 공용 아이콘을
  22px로 재사용했으며 Chrome 실제 화면에서 Filled 형상과 크기를 확인했다.
- Dashboard 전체 프레임, 1280·1440·1920 레이아웃, 사이드바 확장·축소 상태,
  지표 hover, 5개·12개 Office 주문 그래프 variant와 댓글 1~19를 다시 전수
  대조했다. 대표 화면만 확인하고 전체 확인으로 과장하지 않으며, sibling variant와
  댓글 상태까지 확인한 경우에만 전체 검토로 기록한다.
- 전수 대조에서 확정된 UI 차이를 `b389ce2d2`에 반영했다.
  - Office 필터는 `All Offices` 또는 단일 Office만 유지하며 새 Office를 선택하면
    기존 선택을 교체한다.
  - Orders 제목의 4px 구분점, 날짜 16px·medium 표현, 헤더와 데이터 간격,
    Office 이름과 footer 글꼴, 평균 이상 건수 색상과 평균선 자산을 맞췄다.
  - Orders 카드는 Office 수에 따라 내용 높이가 자연스럽게 달라지며, Category와
    Dentist 카드는 608px 높이와 최신 내부 간격·색상·그림자를 따른다.
  - 사이드바 hover 시 아이콘과 텍스트가 함께 변경되고, 확장 상태의 우측 띠와
    축소 상태의 띠 제거, 패널 화살표와 상단 Organization 표시를 최신 디자인에
    맞췄다.
  - 평균선, 패널 화살표와 제목 구분점은 저장소의 기존 SVG assets/dist 생성 방식으로
    추가했고, 공용 `SegmentControl`은 기본 동작을 유지하는 선택적 text variant만
    확장했다.
- 최종 Chrome 검증에서 Office를 `East Harlem`에서 `Upper West Side`로 바꿨을 때
  하나만 선택되고 `All Offices`로 복원되는 것을 확인했다. Orders 날짜는
  16px/500/gray600, Category·Dentist 카드는 각각 608px, Dentist 그림자는 Figma 값으로
  렌더링되는 것을 computed style과 실제 화면으로 확인했다.

### 2026-07-31 당시 미완료·대기

- Clinic DSO의 실제 지표, 주문, 지점, Billing, export API와 실데이터 연동
- `office/users/own.organizations[].countryCode` 배포 뒤 현재 `US` fallback 교체
- 여러 Organization 중 현재 Organization을 선택·유지하는 서버·전역 상태 계약
- `Visit Office`가 선택 지점 employer context를 실제로 전환하는 연동
- 실데이터 기준 loading, empty, error, 권한 없음과 부분 응답 상태
- 비활성·퇴사 의사 포함 규칙, 국가별 통화, 단일병원 Dashboard의 Admin 권한 범위
- 댓글에서 답이 확정되지 않은 새로고침 elapsed label의 최대 기간·자동 갱신 규칙
- 일곱 신규 feature 커밋의 `develop` 통합과 개발서버 배포 revision 확인

이 목록은 이후 API 배포 전의 역사 기록이며 현재 TODO로 사용하지 않는다.

## 검증된 내용

- `47b0537c2`, `98e541732` commit hook에서 Clinic, Lab, Admin TypeScript 통과
- `98e541732` push hook에서 전체 lint 오류 0건, 기존 warning만 존재하고 shared
  coverage baseline 변화 없음으로 성공
- 최신 변경 파일 Prettier·ESLint와 `git diff --check` 통과
- Organization Advanced Export PDF를 임시 sample route에서 실제 blob/A4 PNG로
  렌더링해 한 페이지 레이아웃을 확인한 뒤 검증용 연결 제거
- 최신 `origin/master`와 merge-tree 점검에서 겹치는 My·generated 영역의 실제 충돌
  확인; 통합 작업 전에는 merge-ready로 분류하지 않음
- `d86e4cea2`에서 최신 `origin/master`를 merge하고 충돌을 파일별 책임과 변경
  시간순으로 조정한 뒤 Clinic, Admin, Lab TypeScript·전체 lint·production build와
  `git diff --check` 통과
- merge push hook에서 세 앱 lint 오류 0건, 기존 warning만 존재했으며 shared hook
  테스트 24건과 coverage check 통과
- 신규 Case Preference Jest 단독 실행은 로컬 Next 16의 `next/jest` module resolution
  문제로 테스트 코드 실행 전에 중단됨; TypeScript, build와 master의 동일 테스트
  코드는 보존됐으나 로컬 Jest 성공으로 기록하지 않음

- Admin TypeScript 통과
- Clinic TypeScript 통과
- commit hook의 Clinic, Lab, Admin TypeScript 통과
- Admin, Clinic, Lab production build 통과
- Admin lint 오류 0건; 기존 warning만 존재
- pre-push의 서비스 lint는 기존 warning만 출력하고 성공
- shared coverage는 baseline 대비 변화 없음
- Prettier와 `git diff --check` 통과
- 최신 변경 대상 Clinic 파일 ESLint 통과
- 최신 네 커밋의 commit hook에서 Clinic, Lab, Admin TypeScript 통과
- 최신 push hook에서 전체 lint 오류 0건, 기존 warning 420건과 shared coverage
  baseline 대비 변화 없음으로 성공
- `345699e4d` 대상 Clinic TypeScript, 네 변경 파일 lint, Prettier와
  `git diff --check`가 통과했다.
- `345699e4d` commit hook에서 Clinic, Lab, Admin TypeScript가 모두 통과했다.
- `345699e4d` push hook에서 전체 lint 오류 0건, 기존 warning 420건과 shared
  coverage baseline 대비 변화 없음으로 성공했다.
- `b389ce2d2` commit hook에서 Clinic, Lab, Admin TypeScript가 모두 통과했다.
- `b389ce2d2` push hook에서 전체 lint 오류 0건, 기존 warning 420건과 shared coverage
  baseline 대비 변화 없음으로 성공했다.
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
- PR #4443은 `40bfd9526`까지만 포함하므로 이후 feature 작업과 `d86e4cea2`를 기존
  개발 배포에 자동 포함된 것으로 간주하지 않는다.
- `DL-15801` 이벤트는 코드와 push까지만 완료했다. 배포 revision 및 실제 Amplitude
  수신은 확인하지 않았으므로 live 완료로 분류하지 않는다.
- Advanced Export API 연동과 별도 PDF 렌더러 구현은 완료했다. 실제 로그인
  실데이터 조회·다운로드는 아직 수동 검증하지 않았으며 구현과 구분되는 QA 상태다.
- shared UI 전체 lint는 저장소에 동시에 해석되는 `eslint-plugin-storybook`
  `8.38.0`과 `8.57.1` 충돌로 실행되지 않았다. Clinic TypeScript와 실제 호출부
  대상 lint는 통과했으므로 이번 변경의 lint 실패로 분류하지 않는다.
- Admin의 사용자 화면 검토는 완료됐지만 모든 mutation을 별도 테스트 데이터로
  반복하는 정형 E2E는 실행하지 않았다.
- 기존 lint warning, Next 권장 TypeScript 버전 경고, 오래된 Browserslist 데이터
  경고는 이번 범위에서 수정하지 않았다.
- `67f0f4017` commit hook에서 Clinic, Lab, Admin TypeScript가 통과했다. push hook은
  lint 오류 0건(기존 warning 418건), shared hook test 24건과 coverage baseline을
  통과했다. 변경한 Clinic/shared 파일의 직접 lint, Prettier와 `git diff --check`도
  통과했다.

## 우선순위 TODO

### P0 — 백엔드 계약 반영 완료

- [x] Organization Advanced Export API를 modal과 신규 PDF route에 연결하고 query,
  Dentist source, 로딩·오류·빈 결과와 다운로드 흐름을 구현했다.
- [x] 생성 API diff를 검토하고 Organization Billing header·금액과 미수금 통화를
  기존 profile/공용 formatter 구조로 반영했다. 신규 PDF는 확정 디자인대로 행·요약에
  심볼을 붙이지 않고 Total Due에만 기존 profile의 통화 코드를 표시한다.

### P1 — 전달 전 최종 게이트

- [x] 최신 `origin/master`를 feature에 merge하고 충돌·회귀를 검토해
  `d86e4cea2`로 push했다.
- [x] PR #4459를 이용해 master 대비 전체 코드 diff와 불필요 변경을 검토했다.
- [x] 최신 Figma의 관련 화면·댓글과 Jira 요구사항 기준 FE 누락을 재검토했다.
- [x] release 전달용 PR #4469에서 CodeRabbit 실제 리뷰 18건을 검토했다. 유효한
  11건은 `8829beab8`에 반영하고 나머지 7건은 유지 사유를 답변했으며, 기존 thread는
  모두 resolve했다.
- [x] 후속 CodeRabbit 리뷰 1건의 `localStorage` 접근 예외를 `9eab1b3c3`에 반영하고
  답변·resolve했다. 마지막 live 확인에서 미해결 thread는 0개다.
- [x] 대시보드 모바일 차단을 실제 기기 판별로 제한하고 하단 카드 너비를
  475~745px 균등 분할로 보정한 `44990b0ec`와 최신 master 병합 `d324dc559`까지
  push한 뒤 PR #4469를 `release/v1.83.0`에 merge했다.
- [x] DL-15906·DL-15937 API 연결 후 Clinic, Lab, Admin TypeScript와 push hook의
  전체 lint, shared test·coverage를 다시 수행했다. lint 오류는 0건이고 저장소 기존
  warning만 존재했다.

### 별도 검증 상태

- `Visit Office`는 사용자가 실제 대상 병원 진입을 수동 확인했다.
- Clinic/Admin production build와 Clinic/Admin/Lab TypeScript는 최종 검토에서
  통과했다.
- Clinic Jest는 기존 `next/jest` 설정 문제로 실행되지 않았으며 기능 테스트 실패로
  분류하지 않는다.
- PR #4490·#4491·#4492가 각각 release, develop, stage에 merge됐다. 사용자 확인
  기준 릴리즈 준비와 스테이징·개발서버 배포가 진행 중이며, 실제 배포 revision과
  최종 실데이터 QA는 별도 검증 상태다.

## 다음 시작점

1. `codex-personal-context`를 pull하고 이 문서를 읽는다.
2. DSO 전용 worktree는 현재 `feature/DL-15906-DL-15937-develop`이며 두 feature PR은
   merge된 상태다. 작업 전에 clean 상태와 live branch를 다시 확인한다.
3. 릴리즈 준비와 스테이징·개발서버 배포 완료를 확인한 뒤 Clinic/Admin DSO 전체의
   최종 QA를 1회 진행한다.
4. 최종 QA가 통과하면 DL-15223 개발 완료로 종료하고, 사용자가 요청하면 merge된
   feature branch와 worktree를 안전하게 정리한다. 회귀가 확인된 경우에만 사용자가
   지정한 base에서 `feature/` prefix의 후속 브랜치를 준비한다.
5. `origin/stage`, `origin/develop`, `release/v1.83.0`, 배포 revision과 Jira 상태는
   재개 시 live 상태를 다시 확인한다.
6. 공유 저장소 commit, push, PR 수정, merge는 각 단계에서 사용자의 명시적
   승인을 받는다.
