# 기공소 환자목록 디자인·API 대응 — DL-16652

## 현재 상태 — 2026-10-06 최종 디자인 구현·3개 저장소 PR 전달

- [Jira DL-16652](https://innovaid.atlassian.net/browse/DL-16652): `[FE] 기공소 환자 목록 디자인 변경`.
  확정 요구사항 본문과 fixVersion `v1.88.0`을 등록했다. 부모 DL-16596에는 댓글을 남기지 않는다.
  댓글44299에 세 PR·확인 결과·검토/배포/실기QA 대기를 남겼다. status는 진행 중으로 유지해
  개발·PR 전달을 배포/QA 완료로 표시하지 않았고 본문·댓글·버전·상태 readback을 확인했다.
- 환자 목록은 웹 Lab·Lab 앱에 구현했다. 추가 구두 확정으로 **Remake 배지만 웹 전체·Lab 앱·
  Office 앱의 모든 사용처**에 적용했다. Office 환자 목록과 기존 공통 테이블은 변경하지 않았다.
- 세 제품의 독립 Git에서 commit/push와 PR 생성을 완료했다. OPEN/non-draft·MERGEABLE 및
  해당 기능 diff만 포함함을 확인했고 기능 세션에 artifact로 연결했다. 병합·배포는 하지 않았다.
- 기능 세션 `01a11038-d621-7fb3-ad4e-58d01fbb9a6a`(local), `gpt-6.1-sol / ultra`.
  결과는 이 Git 정본에 저장하며 메인세션으로 자동 진행/완료 메시지를 보내지 않는다.

| 제품 | branch / HEAD | PR / base |
| --- | --- | --- |
| 웹 | `feature/DL-16652` / `b29821879bbd3c33aa6cfedca34e9f2516fd8cef` | [#4665](https://github.com/Innvoaid/dentlink-client/pull/4665) → `release/v1.88.0` |
| Lab 앱 | `feature/DL-16652` / `5debbe0d3edd692fa96022db568b338e5fe08efb` | [#2](https://github.com/Innvoaid/dentlink-lab-app/pull/2) → `develop` |
| Office 앱 | `feature/DL-16652` / `ed604e6b1671714499afcd14f628f00591105f8e` | [#318](https://github.com/Innvoaid/dentlink-app/pull/318) → `develop` |

## 사용자 확정 디자인·댓글·승인

- [Figma 기공소 Patients](https://www.figma.com/design/2OR0Gj7NUFEEeYBjQg5Y6v?node-id=325-31483&m=dev):
  웹 main `325:31918`, hover `325:32058`, row `325:29068`, header `325:32003`.
  앱 main `325:32222`의 새 카드 `395:61562`, `395:61691`, `395:62320`, `395:62507`, `395:62568`
  및 Patient set `325:26018`을 기준으로 했다. 예전 main 카드·중간 배치는 역사적 기준이다.
- 새 표/카드는 **이번 환자 화면 전용**이다. 다른 테이블/상태 UI의 전역 변경·공식 디자인시스템 편입은
  요청 범위가 아니다. Remake의 전역 변경만 사용자 구두 확정으로 추가 승인됐다.
- 환자명/생일, 전체 주문 수·우리 기공소 주문 수와 최근 주문의 상태·카테고리·담당 의사를 표시한다.
  생일이 없으면 날짜와 구분선을 숨긴다. 항목 선택은 `recentOrderId`로 이동하며 ID가 없으면 이동하지 않는다.
- 앱 정보는 왼쪽4×64px 선과 환자·치과·두 주문 수의3줄이다. 총 수 mono800/우리 수 primary600 bold14.
  최근 주문 header 오른쪽 Remake, 본문 상태·카테고리·담당 의사3줄로 최종 배치를 반영했다.
- 카드 width343 기준/padding14/radius12/카드 간 gap14/**내부 gap12**/높이248px,
  최근 주문 section radius8/header padding12 12 8/body padding10 12/gap6, pressed primary100.
  기본·긴 문구·생일 없음·눌림에 gap12을 적용해 누를 때 크기가 변하지 않는다.
- 웹 열260/250/120/130/KO150/240/240+남는 공간, EN 상태200. 행70/header35+34/상태23/Remake21,
  footer64/검색 offset44/표시 개수 body1 16·icon18, 생일 없음·긴 문구·hover·가로 스크롤을 맞췄다.
  main/hover 문구 충돌은 main을 기준으로 두고 hover 때 문구 변경 동작을 만들지 않았다.
- 실제 원본 SVG 형상을 대조했다. 웹 local SVG5개와 일치하는 기존 아이콘, Lab 원본 SVG8개와
  화면 local adapter를 사용한다. 완료/제작 대기 등의 fractional root·회전·색을 보존했다.
- Remake는 배경/테두리/여백 없는 reset16+문구14/21+gap4다. 웹 text/icon primary600,
  앱 text primary700/icon primary600. 회차 선택 탭·버튼·필터·인쇄 설명은 배지가 아니므로 제외했다.
- IN_PROGRESS일 때만 DESIGN/READY_FOR_FABRICATION/IN_FABRICATION 상세 상태를 적용하고
  Remake는 `isRemake`로 독립 표시한다. detailStatus의 REMAKE만으로 배지를 추론하지 않는다.
- 관련 Figma 댓글 #15~#19와 작업 댓글을 읽기 전용 검토했다. #15 최근 주문 이동, #16 우리 기공소의
  최근 접수 주문, #17 취소 표시·Remake 병행을 확인했다. 스캐너 임시 주문 제외 정책 답변은 없어
  프런트에서 제외 필터를 만들지 않았다. 댓글 작성/해결은 하지 않았다.
- [#18](https://www.figma.com/design/2OR0Gj7NUFEEeYBjQg5Y6v?node-id=325-31918&m=dev#1954124763)의
  전역 Remake와 #19 gap8/12는 이후 사용자가 구두 답변으로 **모든 사용처·12px**를 확정했다.
  서면 답변 대기 상태를 유지하지 않는다. 반복되는 최종 값을 우선하는 원칙과 작은 모호함을
  자율 처리한 뒤 모아서 설명하는 선호를 `DEVELOPMENT_STYLE.md`에 저장했다.
- 최초4시간 후 확인 heartbeat `dl-16652-4`는 취소 지시로 **PAUSED**다. STG Swagger 재조회도 제외했다.
- 웹 commit/push·메모리·Jira·release PR과 앱 commit/push 승인 뒤 사용자가 **앱도 PR 생성**으로
  확대했다. merge·배포·환경/서명 변경은 승인 범위가 아니다.

## API 확인 — 2026-10-06 18:02 KST

- DEV Swagger HTTP200, 실제 인증 `/lab/patients/consolidate` HTTP200/code0000·763행에서 새12필드를
  확인했다. endpoint는 유지한다. `officeId`, `officeName`, `patientName`, `birthDate`, `totalOrderCount`,
  `labOrderCount`, `recentOrderId`, `recentOrderStatus`, `recentOrderDetailStatus`, `recentCategoryName`,
  `recentDentistName`, `isRemake`다.
- 전체 주문 수는 타기공소 포함, 우리 주문 수는 해당 Lab만이며 DRAFT·DELETED 제외 설명은 주문 수에만
  있다. 최근 주문 제외 정책으로 확대 해석하지 않는다. 실제 birthDate null(DEV57/STG66)도 숨김 처리했다.
- STG **실제 인증 endpoint** HTTP200·686행은 이전10필드·orderId/케이스 계약이며 새7필드가 없다.
  배포 완료로 보고하지 않는다. 이전 필드를 임의 fallback하지 않았다. STG Swagger는 재조회하지 않았다.
- 공식 Swagger generator 임시 생성 결과에서 해당 Lab 선언/alias만 자동 추출했다.
  Office/Admin 기존 DTO 및 release의 무관한 생성 선언을 보존했다.

## 번역 시트와 생성 파일

- 웹 [i18n 시트](https://docs.google.com/spreadsheets/d/1iuncwk8EIi8ycbc36a0dMn-ZkxaqqMHy1jvyT6ubpq0):
  양 영역1591~1600행에 patients fields7+status3을 등록했다. 환자 화면의 검토중/디자인 진행중 문구를
  분리했다. 기존 PM 값·수식·서식·검증은 보존했고 bounded readback 및 en/ko patients 생성 일치를 확인했다.
- 전체 `pnpm check:i18n`은 **기존 en/ko orders.json만 stale**로 실패한다. 환자 리소스는 일치한다.
  기존 제작 자동 진행 문구 차이·사용 중 orders.filters.category 시트 누락은 다른 작업이므로
  기존 행/키를 삭제·덮어써 이번 검사를 억지로 통과시키지 않았다.
- Lab [앱 번역 시트](https://docs.google.com/spreadsheets/d/1ZnPl5a3P3dKtxDTadLX56aTmuJ58TrpZiRcXDexdLbw):
  양 영역314~319행에 총/우리 주문 수·우리 최근 주문·담당 의사·디자인 진행중·카테고리6개 등록.
  기존1~313행·PM 확인자·요청/개발 상태를 보존했다. 사용자 확정 Figma 문구 승인 근거를 사용하되
  PM 이름은 만들지 않았다. live connector readback→CSV snapshot→공식 generator로 en/ko/registry 생성,
  로컬 snapshot의283문구 검사는 통과했다.
- 기존 Category 미확인 행과 Design in Progress 기존 번역은 유지하고 신규 영문은 Order Category,
  Design In Progress로 구분했다. t() 문구는 스캐너가 놓쳐 직접 대조·등록했다.
- live `yarn i18n:check`는 ADC `403 ACCESS_TOKEN_SCOPE_INSUFFICIENT`로 읽기 단계에서 실패했다.
  CLI 검사가 통과했다고 보고하지 않는다. connector의 실제 시트 등록·readback은 완료했다.
- Office는 기존 Remake 문구/registry/ko 리소스를 사용하므로 신규 번역 행이 없다.

## 작업 공간·커밋

- 웹 `/Users/parkjongsun/Repository/dentlink-client-patient-list`, base origin/master `6b79c9756`.
  공용 Remake `51f891f93` + 환자/API/i18n `b29821879`,2커밋·14파일.
  PR은 release `faaa1498189e3e584cfc6fce215ce97feca156f7`을 향한 해당14파일만 포함한다.
- Lab `/Users/parkjongsun/Repository/dentlink-lab-app-patient-list`, base origin/develop `f33283339`.
  공용 Remake `0b7a94a288bcc1bdfbc26c1be3a2c4f9fff9cd8e` + 환자/API/i18n `5debbe0`,2커밋·19파일.
- Office `/Users/parkjongsun/Repository/dentlink-app-patient-remake`, base origin/develop
  `52966b80f7b5fae20b14ad530f2ae7e0ce79a1d3`. `ed604e6`,1커밋·3파일(공통 배지·16원본SVG·자동export).
- 각 HEAD·원격 SHA 일치/clean을 확인했다. 기존 main·권한관리·가드·DLDS checkout은 보존했다.
  앱 feature→develop 규칙 및 각 release 통합 상태를 확인했다. 웹 일정이 앱 base를 바꾸지 않는다.

## 검증·한계

- 웹 Lab·Clinic·Admin 타입 및2커밋의 필수 pre-commit 검사 통과. Clinic ignored next-env는
  표준 next typegen으로 준비했고 tracked 설정 변경은 없다. 변경 lint 오류0/기존 any경고1·Prettier·diff 통과.
- 필수 push hook 전체 제품 lint는 기존 warnings/오류0, config21+hook24 테스트 통과.
  baseline 누락으로 최초 push 중단 후 검사 패키지가 origin/master와 동일함을 확인해 공식
  coverage:baseline으로 ignored 로컬 기준을 생성했다. delta0·재검사/push 성공, hook bypass 없음.
- 최종 synthetic11상태:70px행, 상세 gating/isRemake, 누락 생일/ID·0건·긴 문구, 검색 초기화·페이지·
  표시 개수·키보드 이동·1100px 스크롤·EN geometry 통과. count null/undefined는 소스 ?? 확인,
  fixture count는0건이다. 실제 DEV10행은7표시 필드를 응답과 대조했고 상태/detail/ID/DOB는 synthetic으로 보완했다.
  pageerror0은 console warning0을 뜻하지 않으며 정식 staging 전체 E2E 판정은 아니다.
- Remake default/dark/desktop/mobile/shipping5맥락은 임시 페이지의 실제 컴포넌트 측정이다.
  업무 화면 전체 이동 QA가 아니다. Remake21/icon16/gap4·다른 상태25 유지 확인.
  독립 read-only 리뷰에서 웹14파일의 추가 확정 결함·요구 누락은 발견되지 않았다.
- Lab renderer10·변경 lint/Prettier/diff·최신 Android Metro bundle 통과. type4오류는 기준/최종
  SHA 동일(Icon2/Tooltip1/MessageText1), 신규0. 이전 Android 개발 빌드/설치는 성공했으나 AVD
  system service timeout으로 splash 이후 카드/검색/이동 QA 실패. 최종 기기 font/ellipsis/shadow/navigation은 미검증이다.
- Office renderer3·lint0/Prettier/diff·Android/iOS Metro bundle 통과. type18오류는 기준/최종 byte동일,
  신규0. 기기/native build·배포는 미실행이다. Metro 성공을 실제 기기 화면 실행으로 대체하지 않는다.
- 앱 PR 자동 제목/본문/라벨 검사는 성공. 웹 Vercel은 **작성자 jongsunP의 innovaid 팀 접근 확인**으로
  차단됐다([봇 댓글](https://github.com/Innvoaid/dentlink-client/pull/4665#issuecomment-6013252346)).
  실제 팀 미가입인지 GitHub 계정 연결 미인식인지는 미확인이다. 코드 빌드 실패로 단정하지 않는다.
  접근 신청·프로젝트 설정·배포 재시도는 하지 않았다. CodeRabbit은 마지막 확인에서 pending이다.

## 다음 시작점·보존

- 4시간 예약 재확인은 취소됐다. 사용자가 재개하면 세 PR/head/CI를 live 확인하고 요청된 디자인
  수정에 대응한다. STG 새 계약 전환 후 실제 연동, 두 앱 기기 화면 QA, 웹 Vercel 접근 확인이 남는다.
- 기존 orders 번역 차이와 ADC scope는 별도 기존 문구/인증 문제다. 신규 기능의 시트 등록을
  다시 미완료로 되돌리지 않는다. 다른 작업/PM 원문을 확인해 처리한다.
- 자료는 현재 기기 `/Users/parkjongsun/.codex/visualizations/2026/10/06/01a11038-d621-7fb3-ad4e-58d01fbb9a6a/DL-16652/`
  의 final-review/final-delivery에 원본 캡처·합성 화면·집계·검사 로그로 보존했다. 실환자 화면/토큰/
  비밀번호를 Git에 저장하지 않는다. local-only 자료이며 Git 정본은 결과·링크·다음 시작점을 전달한다.
- Root QA Next3007과 이번 Lab Metro/AVD는 종료했고 다른 세션 runtime은 보존했다.
