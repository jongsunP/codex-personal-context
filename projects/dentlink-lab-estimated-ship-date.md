# Dentlink 기공소 출고 예정일 — DL-17125

## 현재 체크포인트 — 2026-10-30

- 상위 [DL-17124](https://innovaid.atlassian.net/browse/DL-17124), Frankie 하위 [DL-17125](https://innovaid.atlassian.net/browse/DL-17125). 제목을 `[FE] 기공소 출고 예정일의 과거 날짜 선택 방지`로 변경하고 증상·수정 범위·완료 조건을 작성했다. 결과 댓글 `44732`를 하위에만 남겼다. 상위 댓글·카드 상태는 변경하지 않았다.
- 사용자 지시로 제품 commit/push 및 [PR #4807](https://github.com/Innvoaid/dentlink-client/pull/4807) 생성을 완료했다. 실제 base `release/v1.91.0`, head `feature/DL-17125`, 일반 Open PR이며 변경은 1커밋·2파일·36 additions / 7 deletions로 확인했다. 리뷰 대기이며 merge/배포는 하지 않았다. 현재 운영/STG에는 이 수정이 반영되지 않았다.
- 작업 위치 `/Users/parkjongsun/Repository/dentlink-client`, 브랜치 `feature/DL-17125`, HEAD `e8e15ed66629f3aa389e484215116ed90fa21f13`, upstream `origin/feature/DL-17125`와 0/0이고 clean. 시작 base는 `57bb759ca08e3752140ceffdae2a5421934ec242`(origin/master), PR base SHA는 `fc23d9084dbc4e0b375960481e692b350c08001d`. 기존 기본 checkout을 단독 작성 위치로 사용했고 새 worktree/프로젝트는 만들지 않았다.
- 세션 `01a18af5-8028-71b1-a8ce-83ee0aadfee0`, 이름 `DL-17125 기공소 출고 예정일 수정`, Mac local·메인 프로젝트 폴더 등록 확인. 같은 Mac 세션을 원격에서 이어간다. 실제 휴대폰 목록 노출까지 확인한 것은 아니다.

## 요구·원인·최종 수정

- Jira 상위 본문·댓글 4개·스크린샷 31822·콘솔 로그 31823을 확인했다. 첨부는 제작 대기중 → 제작 중 전환창에 과거 출고 예정일이 채워져 변경 버튼이 활성화된 상황이다. 로그는 해당 주문의 배송일 조회를 보여주며 과거값 저장 성공의 증거까지는 아니다.
- 현재 master와 stage의 해당 코드가 동일하다. 기존 `DateField`는 `onlyCalendar/readOnly`이고 캘린더 날짜 셀은 이미 하한을 제한하지만, 제작 전환의 기존값 주입은 과거 출고일을 그대로 넣고 IN_FABRICATION 버튼과 제출은 과거 여부를 검사하지 않았다. 로컬 실제 화면에서도 같은 형태를 재현했다.
- 사용자 최종 해석: **오늘을 포함해 선택 가능한 가장 이른 날짜**가 맞다. 오늘이 영업일이면 오늘부터, 휴무일이면 다음 영업일부터 선택한다. 기존 주말·공휴일·직원 시간대 기준을 유지한다. PM에게 추가 정책 질문이 필요한 상태는 아니다.
- 사용자는 기존 캘린더 props 활용과 최소 변경을 선호하되, 근거 있는 추가 수정은 맡겼다. 최종 변경은 아래 2개 기존 컴포넌트(36 additions / 7 deletions)에 한정했다. 날짜 포맷·팝업·API hook까지 확장했던 중간 변경은 모두 제거했다.
  - `shared/ui/src/OrderDetailUI/parts/OrderDetailStatusChange/OrderDetailStatusChangeModal/OrderDetailStatusChangeModal.tsx`: 실제 폼 값의 과거 여부를 공통 DateUtils와 직원 시간대로 판정. 버튼·제출 직전에 차단하고 오류 표시용 prop 전달.
  - 같은 디렉터리 `OrderDetailStatusChangeModalItemInProgress.tsx`: 기존 enabledStartDate 계산을 LAB 배송 상품에 한해 오늘 포함 첫 영업일로 조정. 과거 비교를 날짜 단위로 맞추고 기존 invalidDate 문구로 표시.
- 기존 과거값은 그대로 보여주고 유효 날짜를 직접 선택하도록 한다. 저장된 이력 자동 변경, 신규 문구, 번역 key/리소스/시트 변경, 알림·치과 노출 정책, 앱 코드, 공용 캘린더 구현은 변경하지 않았다.

## 검증

- 최종 2파일 diff로 Lab `pnpm --filter dentlink-lab-web type` 통과, Prettier·`git diff --check` 통과.
- 커밋·푸시 훅도 우회 없이 통과했다. Clinic/Lab/Admin 타입 검사·앱 lint(기존 warning 있음), Admin DLOS guard 9개, shared config 21개·hooks 32개 테스트 및 coverage 검사 통과. 기존 shared/ui 직접 lint 제약은 아래와 구별한다.
- PR 생성 전 E2E guard는 `NO_IMPACT`로 기록하고 `check.sh --base release/v1.91.0 --head feature/DL-17125` exit 0을 확인했다. 04 배송 spec은 새 주문에서 `.calendar-table [data-date].valid` 첫 날짜를 선택하며 날짜 고정값에 의존하지 않는다. 05 상태 변경·08 피드백은 배송 없는 Design 상품 및 동일 유효 날짜 helper를 사용한다. locator·route·API 대기·기존 assertion 변경 없음. E2E 파일 수정 및 실제 E2E 실행은 하지 않았다.
- 일반 ESLint는 기존 root/shared-ui의 Storybook 플러그인 버전 중복(ESLint 8.57.1 / 8.38.0)으로 실행 전 실패. 저장소 설정을 수정하지 않았다. `--no-eslintrc --config .eslintrc.json --env browser,es2020`로 해당 두 파일을 검사해 오류 0, 기존 hook 의존성 경고 5개를 확인했다. 일반 lint 전체 통과로 표현하지 않는다.
- 일회성 합성 데이터 검증 17/17 통과. 실제 Modal/DateField/Calendar/DLDS와 RHF 사용, 서버 경계는 spy. 과거 프리필 보존·오류·disabled·요청 0회, 오늘/미래 선택 후 정상 callback, 과거 클릭/Enter·월 이동·주말/공휴일·readonly, 빈 제작일/NEW 빈값 기존 동작, 검토→디자인·디자인 생략→제작·출고일 편집, LA/서울 기준일, 오늘 휴무 시 다음 영업일, 비배송/Admin 기본값 보존을 확인했다.
- Chrome 실제 localhost:3005 (기존 DEV 연결·로그인 유지) 주문 상세에서 제작 전환을 열어 과거값과 활성 변경 버튼을 수정 전에 확인했다. 최종 코드에서 과거값 오류/변경 disabled → 오늘 선택 활성 → 다음 달 미래 영업일 선택 활성 → 닫고 다시 열면 원래 과거값 보존/차단을 확인했다. 실제 서버의 주문 날짜/상태 변경을 제출하지 않았다.
- 실서버 저장 성공·배포 QA는 미검증이다. 기존 dd/MM/yyyy의 전반적인 문자열 재해석 및 확인 팝업을 자정 넘게 유지하는 경계 사례는 이번 최소 수정에 포함하지 않았으며 해결됐다고 표현하지 않는다.
- 관련 독립 코드 리뷰에서 최종 2파일 수정에 추가 차단 이슈 없음. 중간 확대 구현 검증은 최종 결과로 혼용하지 않았다.
- 기존 메인 checkout의 ignored/untracked `lab/.env.local`, `lab/.env.development`를 그대로 사용했으며 값을 읽거나 변경하지 않았다. server cwd=`dentlink-client/lab`, port3005 확인. 이 세션의 서버 PID23854와 테스트 탭은 검증 후 종료했다.

## 로컬 증거와 재개점

- 테스트: `/private/tmp/dl17125-check/status-date.test.tsx`, `vitest.config.mjs`(일회성 파일, 제품 branch에 미포함). 재실행은 설치된 shared/dlds의 Vitest로 이 config를 지정한다.
- 실제 브라우저 화면: `/private/tmp/dl17125-verified-screen.png`. Jira 원본 첨부는 세션의 메인 프로젝트 폴더에 다운로드했다. 임시 파일·브라우저 인증은 Git으로 다른 기기에 복원되지 않는다.
- 최종 파일 SHA256: Modal `1e50af0c32520c1f7ffe07d6b2a3e972549d0bc57b79302649764b253ca757f9`; Item `ca7e046ffa8a9eb941fa22a2eef20a62586613cb4f913ae69c4bb224d1f2eb19`.
- 다음 시작: 개인 컨텍스트 pull → 정확한 checkout/branch/원격 HEAD와 PR #4807 상태를 새로 확인한다. 현재 동료 리뷰 대기. CodeRabbit 대응은 사용자 요청 시 수행하고, merge·배포는 별도 지시 후 진행한다. 구현은 원격 feature 브랜치에서 복원 가능하며 임시 테스트·로컬 화면 증거는 같은 Mac에만 남아 있다.
