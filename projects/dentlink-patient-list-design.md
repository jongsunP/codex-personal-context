# 기공소 환자목록 디자인·API 대응 — DL-16652

## 현재 상태 — 2026-10-07 자율 재점검·iOS 확인

- 사용자 최신 지시: 스스로 처리 가능한 후속 작업은 처리하고, 없으면 대기한다. 불가한 항목은
  이유를 알리고 대기한다. 기존 commit/push·PR·Jira·개인 Git 기록 승인은 유지하며 병합·배포는 제외한다.
- 23:50 KST Figma 재검토에서 카드12px·전역 Remake primary600·관련 댓글 답변은 동일했다.
  00:34 PR head/자동검사와 00:39 세 PR 리뷰 스레드를 재조회해 추가 요구·미해결 의견0개를 확인했다.
- 두 전용 worktree에 잠금 버전의 독립 Ruby/gems/Pods를 준비했다.
  Office 정식 Debug arm64 빌드·iOS26.5 새 시뮬레이터 설치/실행·미인증 알림 안내 화면을 확인했다.
  Lab도 정식 Debug 빌드·iOS26.5 새 SE3 설치/실행·미인증 KO 알림 안내 화면을 확인했다.
  DeviceHub UI 연결 제한은 아래 검증 결과에서 구분한다.

- [Jira DL-16652](https://innovaid.atlassian.net/browse/DL-16652): `[FE] 기공소 환자 목록 디자인 변경`.
  확정 요구사항 본문과 fixVersion `v1.88.0`을 등록했다. 부모 DL-16596에는 댓글을 남기지 않는다.
  댓글44299에 최초 세 PR·확인 결과·검토/배포/실기QA 대기를 남겼다. status는 진행 중으로 유지해
  개발·PR 전달을 배포/QA 완료로 표시하지 않았고 본문·댓글·버전·상태 readback을 확인했다.
  23:43 댓글44302에 최신 보정·Android 실화면 결과·Office 실제 Remake 사례 미확인·STG 선배포/
  Vercel 조건을 추가했다. 부모 카드에는 쓰지 않았다.
  10월7일00:50 댓글44303에 두 앱 iOS 정식 빌드 성공·자동 제어 연결 제한·STG00:36 응답·
  외부 조건 대기를 기록했다. 댓글44302의 Office 설명은 가시 화면의 확인 범위로 정정했고
  status 진행 중/fixVersion v1.88.0 및 두 댓글 readback을 확인했다.
- 환자 목록은 웹 Lab·Lab 앱에 구현했다. 추가 구두 확정으로 **Remake 배지만 웹 전체·Lab 앱·
  Office 앱의 모든 사용처**에 적용했다. Office 환자 목록과 기존 공통 테이블은 변경하지 않았다.
- 세 제품의 독립 Git에서 commit/push와 PR 생성을 완료했다. OPEN/non-draft·MERGEABLE 및
  해당 기능 diff만 포함함을 확인했고 기능 세션에 artifact로 연결했다. 병합·배포는 하지 않았다.
- 기능 세션 `01a11038-d621-7fb3-ad4e-58d01fbb9a6a`(local), `gpt-6.1-sol / ultra`.
  결과는 이 Git 정본에 저장하며 메인세션으로 자동 진행/완료 메시지를 보내지 않는다.

| 제품 | branch / HEAD | PR / base |
| --- | --- | --- |
| 웹 | `feature/DL-16652` / `1c82980797fc0cf8e728f0aed77250e956336f8d` | [#4665](https://github.com/Innvoaid/dentlink-client/pull/4665) → `release/v1.88.0` |
| Lab 앱 | `feature/DL-16652` / `14949c6afd77530852c166b317a667f4b30dd049` | [#2](https://github.com/Innvoaid/dentlink-lab-app/pull/2) → `develop` |
| Office 앱 | `feature/DL-16652` / `ffcdc736a327e0fbe0293aa0d4d868ca6561b216` | [#318](https://github.com/Innvoaid/dentlink-app/pull/318) → `develop` |

- 사용자 재점검 지시에 따라 최신 API·Figma 댓글/속성·시트·PR을 직접 다시 확인했다.
  웹 리뷰의 자체 DOM 클래스 스타일을 styled component로 분리해 동작/수치는 보존했다.
  실제 DEV 계약과 STG 배포 전제에 답변한 리뷰 thread를 해결했고 최신 head CodeRabbit SUCCESS·
  미해결0개를 확인했다. 사람 리뷰는 REVIEW_REQUIRED이며 병합하지 않았다.
- 최신 Figma는 앱 Remake 문구도 primary600으로 바뀌어 두 앱의 공용 배지 한 속성씩 보정했다.
  18시의 앱 primary700 기록은 아래 최신 값으로 대체한다. 웹은 이미 primary600이었다.

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
- Remake는 배경/테두리/여백 없는 reset16+문구14/21+gap4다. **웹·두 앱 text/icon 모두 primary600**이다.
  23:09 KST 원본에서 Default/Pressed/Long/Short/main의 문구가 #8D6EFF로 일치하고 기본형 내부
  간격도12로 수정됐음을 확인했다. 회차 선택 탭·버튼·필터·인쇄 설명은 배지가 아니므로 제외했다.
- IN_PROGRESS일 때만 DESIGN/READY_FOR_FABRICATION/IN_FABRICATION 상세 상태를 적용하고
  Remake는 `isRemake`로 독립 표시한다. detailStatus의 REMAKE만으로 배지를 추론하지 않는다.
- 관련 Figma 댓글 #15~#19와 작업 댓글을 읽기 전용 검토했다. #15 최근 주문 이동, #16 우리 기공소의
  최근 접수 주문, #17 취소 표시·Remake 병행을 확인했다. 스캐너 임시 주문 제외 정책 답변은 없어
  프런트에서 제외 필터를 만들지 않았다. 댓글 작성/해결은 하지 않았다.
- [#18](https://www.figma.com/design/2OR0Gj7NUFEEeYBjQg5Y6v?node-id=325-31918&m=dev#1954124763)의
  전역 Remake와 #19 gap8/12는 이후 사용자가 구두 답변으로 **모든 사용처·12px**를 확정했다.
  서면 답변 대기 상태를 유지하지 않는다. 반복되는 최종 값을 우선하는 원칙과 작은 모호함을
  자율 처리한 뒤 모아서 설명하는 선호를 `DEVELOPMENT_STYLE.md`에 저장했다.
- 23시 댓글 재검토에서 #18 디자이너 답변은 모든 사용처를 재확인했고 #19는 답글 없이 원본12px가
  반영됐다. 새 #20 Member/담당 의사 권한 질문은 다른 작업 범위여서 환자 디자인 변경에 추가하지 않았다.
- 최초4시간 후 확인 heartbeat `dl-16652-4`는 취소 지시로 **PAUSED**다. STG Swagger 재조회도 제외했다.
- 웹 commit/push·메모리·Jira·release PR과 앱 commit/push 승인 뒤 사용자가 **앱도 PR 생성**으로
  확대했다. merge·배포·환경/서명 변경은 승인 범위가 아니다.

## API 확인 — DEV 2026-10-06 23:03~04·STG 2026-10-07 00:36 KST

- DEV Swagger HTTP200, 실제 인증 `/lab/patients/consolidate` HTTP200/code0000·763행에서 새12필드를
  확인했다. endpoint는 유지한다. `officeId`, `officeName`, `patientName`, `birthDate`, `totalOrderCount`,
  `labOrderCount`, `recentOrderId`, `recentOrderStatus`, `recentOrderDetailStatus`, `recentCategoryName`,
  `recentDentistName`, `isRemake`다.
- 전체 주문 수는 타기공소 포함, 우리 주문 수는 해당 Lab만이며 DRAFT·DELETED 제외 설명은 주문 수에만
  있다. 최근 주문 제외 정책으로 확대 해석하지 않는다. 실제 birthDate null(DEV57/STG66)도 숨김 처리했다.
- STG **실제 인증 endpoint** HTTP200·686행은 이전10필드·orderId/케이스 계약이며 새7필드가 없다.
  배포 완료로 보고하지 않는다. 이전 필드를 임의 fallback하지 않았다. STG Swagger는 재조회하지 않았다.
  2026-10-07 00:36:55 KST 실제 endpoint 한 번 재확인에서도 HTTP200/code0000·686행,
  old orderId686행·새7필드 각0행/new7Complete0행으로 동일했다. Swagger/DEV 재조회는 하지 않았다.
- DEV recentOrderId는763행 모두 양수/nonnull이고 이전orderId는0행이다. 새7필드는 전체 행에
  존재하며 null이 없다. DEV Swagger의 DTO12필드·상태/상세 enum·응답 alias와 생성 선언이 일치한다.
  **STG/운영 새 API 선배포 및 실제 응답 검증 후 UI를 배포해야 한다.** PR 본문과
  [리뷰 답변](https://github.com/Innvoaid/dentlink-client/pull/4665#discussion_r4196245137)에 남겼다.
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
- 23시 connector bounded readback에서 웹10개/앱6개의 en/ko 값이 생성 리소스와 정확히 일치했다.
  읽기 전용 CLI GET도 403 scope 부족을 재현했다. 인증 scope를 변경하거나 재로그인하지 않았다.
- Office는 기존 Remake 문구/registry/ko 리소스를 사용하므로 신규 번역 행이 없다.

## 작업 공간·커밋

- 웹 `/Users/parkjongsun/Repository/dentlink-client-patient-list`, base origin/master `6b79c9756`.
  공용 Remake `51f891f93` + 환자/API/i18n `b29821879` + pagination 스타일 분리 `1c8298079`,3커밋·14파일.
  PR은 release `faaa1498189e3e584cfc6fce215ce97feca156f7`을 향한 해당14파일만 포함한다.
- Lab `/Users/parkjongsun/Repository/dentlink-lab-app-patient-list`, base origin/develop `f33283339`.
  공용 Remake `0b7a94a288bcc1bdfbc26c1be3a2c4f9fff9cd8e` + 환자/API/i18n `5debbe0` +
  최종 색상 `4f4e9c1` + 실제 기기 주문수 배치 보정 `14949c6`,4커밋·19파일.
- Office `/Users/parkjongsun/Repository/dentlink-app-patient-remake`, base origin/develop
  `52966b80f7b5fae20b14ad530f2ae7e0ce79a1d3`. `ed604e6` + 최종 색상 `ffcdc73`,
  2커밋·3파일(공통 배지·16원본SVG·자동export).
- 각 HEAD·원격 SHA 일치/clean을 확인했다. 기존 main·권한관리·가드·DLDS checkout은 보존했다.
  앱 feature→develop 규칙 및 각 release 통합 상태를 확인했다. 웹 일정이 앱 base를 바꾸지 않는다.

## 검증·한계

- 웹 Lab·Clinic·Admin 타입 및3커밋의 필수 pre-commit 검사 통과. Clinic ignored next-env는
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
  SHA 동일(Icon2/Tooltip1/MessageText1), 신규0. fresh Android36 AVD5580으로 이전 system timeout을
  해소했고 기존 development APK+최신Metro8088에서 정상 로그인·실제 DEV10행/전체763명·검색1행·
  recentOrderId 기반 OrderDetailScreen/WebView 주문 상세 로딩을 확인했다.
- 실제375dp 화면에서 주문수 라벨 두줄로 높이가 늘어나는 결함을 찾아 환자 전용 배치를 보정했다.
  KO14px/21dp 한줄·카드343×248·목록gap14를 확인했고 EN/양쪽9자리 fixture는 라벨만말줄임,
  숫자153px 자연폭 보존/카드 내부 오른쪽 경계690px를 확인했다. 공용 Typography/API는 그대로다.
  실제 데이터 QA와 긴문구/EN/Remake 등의 기기 합성 fixture를 구분하며 독립 리뷰에서 추가 확정
  결함은 없었다. 최종 native APK 재빌드나 실물 iOS/기기 전체 QA 완료로 표현하지 않는다.
- 10월7일 Lab canonical immutable JS deps·Ruby3.4.10/Bundler2.6.9/CocoaPods1.16.2를 독립 준비하고
  `pod install --deployment --repo-update`로124dependencies/163Pods를 설치했다. 공식 index/cache만
  준비했으며 source/7개 config/lock hash 불변·Podfile.lock=Manifest.lock byte동일이다.
  정식 DentlinkLabDevelopment Debug generic simulator 빌드가 성공했다(1.0.4/151·arm64+x86_64).
  신규 SE3/iOS26.5에
  boot/install/launch·표준 RCT_jsLocation localhost:8088/최신 Metro·미인증 KO 알림 안내 렌더를
  확인했다(750×1334px/375×667pt). iOS 실제 환자·검색·이동/합성 카드 UI는 미검증이다.
  이미 확인된 DeviceHub 연결 실패를 반복하거나 비공식 입력/인증 주입을 하지 않았다.
  own app/Metro8088/새 sim을 정리하고 본인 생성 root.env만 원복했다. HEAD14949c6 clean/원격 동일하다.
  PR2 본문에 native 성공/로그인 이후 UI 미검증을 반영하고 readback·develop/OPEN/MERGEABLE/CLEAN·
  자동 검사 SUCCESS·artifact 연결을 확인했다. 추가 제품 커밋은 필요하지 않았다.
- Office renderer3·lint0/Prettier/diff·Android/iOS Metro bundle 통과. 최초 shared deps의 type18오류는
  기준/최종 byte동일이었다. 실제 실행 조사에서 설치 Datadog2.14.8과 manifest3.7.0 불일치를 확인해
  own worktree에 immutable 의존성을 설치하고 primary 공유 deps·제품 설정을 보존했다.
  새 deps Datadog3.7.0/RN0.82.1에서 기준/최종 타입6개 byte동일·신규0, renderer3/lint0 재검증 통과다.
  정상 개발APK2.2.4/code134 재빌드·AVD5582 설치 후 표준index.bundle으로 로그인 화면을 확인했다.
  이전APK의 apps/office/index.bundle404·낡은deps의 Datadog 오류는 최신 정상 환경에서 해소됐다.
- Office 실제 로그인·Home·주문 목록5회 scroll까지 정상, 가시Remake0여서 실제 주문의 새 배지
  표시 자체는 미검증이다. renderer3/3과 Lab 기기 합성 배지 검증을 Office 실제 사례로 바꾸어
  표현하지 않는다. 10월6일 새 deps iOS Metro bundle exit0/75assets를 확인했고,
  아래10월7일 정식 native build/startup 결과와 구분한다. 실물/로그인 이후 iOS UI·배포는 미실행이다.
- 10월7일 Office canonical Pods 설치·정식 DentlinkDevelopment Debug arm64 빌드가 성공했다.
  iOS26.5 own iPhone16에 2.2.4(151)을 설치/실행하고 표준 Metro8090 bundle 오류0,
  미인증 EN 알림 안내 화면 렌더를 공식 simctl screenshot으로 확인했다. 로그인 이후 UI는 미검증이다.
  현재 Xcode27은 DeviceHub(com.apple.dt.Devices)를 사용한다. Cua 공식 앱 경로 선택35초 timeout,
  running bundle ID 재선택5초 timeout/window0이며 공식 simctl io에는 tap/type 기능이 없다.
  비공식 HID·추가 UI 라이브러리·SDK/설정 패치 없이 현재 도구로 로그인 진행은 불가하다.
  authstore notfound/loggedIn false여서 iOS QA group binding·실제 Office Remake도 미확인이다.
  등록된 실물 iPhone2대는 tunnel disconnected/shutdown이라 연결된 물리 기기0대다.
- Office의 정상 Pods/build가 생성한 pbxproj와 원래 없던 ignored root.env만 원복했다.
  own iOS sim 삭제·Metro8090 종료/포트 free, 원본 env/lock/설정 불변·ffcdc73 clean/원격 동일이다.
  PR318 본문에 native 성공과 UI 제한을 반영/readback했으며 미해결 리뷰0개·실제 CodeRabbit skip이다.
- 앱 PR 자동 제목/본문/라벨 검사는 성공. 웹 Vercel은 **작성자 jongsunP의 innovaid 팀 접근 확인**으로
  차단됐다([봇 댓글](https://github.com/Innvoaid/dentlink-client/pull/4665#issuecomment-6013252346)).
  실제 팀 미가입인지 GitHub 계정 연결 미인식인지는 미확인이다. 코드 빌드 실패로 단정하지 않는다.
  접근 신청·프로젝트 설정·배포 재시도는 하지 않았다. 최신 웹 head도23:05 Vercel
  `Deployment was blocked`다. 최신 상세 원인은 인증 없이 확인할 수 없었으며 기존 팀 접근/계정
  연결 안내와 같은 원인이라고 단정하지 않는다. 웹 CodeRabbit은 최신 head23:12 SUCCESS·
  미해결0개다. Office CodeRabbit SUCCESS는 develop 자동 리뷰 제외에 따른 skip이며 실제 리뷰
  완료로 해석하지 않는다. 앱 자동 라벨은 최신 head 성공이다.

## 다음 시작점·보존

- 4시간 예약 재확인은 취소됐다. 사용자가 재개하면 세 PR/head/CI를 live 확인하고 요청된 디자인
  수정에 대응한다. STG/운영 새 계약 선배포 후 실제 통합 연동, Office 실제 Remake 사례,
  실물/iOS 로그인 이후 UI 및 웹 Vercel 접근 확인이 남는다. 완료된 Android 실행·Lab 검색/이동 QA는 다시
  미완료로 되돌리지 않는다. 사람 리뷰 후 병합/배포는 별도 승인·전제 확인 단계다.
- 기존 orders 번역 차이와 ADC scope는 별도 기존 문구/인증 문제다. 신규 기능의 시트 등록을
  다시 미완료로 되돌리지 않는다. 다른 작업/PM 원문을 확인해 처리한다.
- 직접 처리 가능한 리뷰·최신 디자인·이 화면의 실제 실행 결함은 승인 범위에서 수정한다.
  STG/운영 backend 선배포, Vercel 팀 접근/계정 연결, ADC scope 변경은 외부 담당/계정 조치가 필요하다.
  기존 앱 타입 오류·다른 기능 orders 시트 차이는 기술적 불가능이 아니라 이번 작업 범위 밖이다.
  미검증 runtime과 실제 실패한 CLI 검사를 완료라고 표현하지 않는다.
- 10월7일 자율 재점검에서는 추가 제품 수정이 필요하지 않았다. 정식 iOS native 빌드는 두 앱에서
  성공했지만 로그인 이후 UI는 DeviceHub 자동 제어 연결 제한으로 미검증이다. 정상 입력 도구 연결
  또는 실제 기기 연결이 가능해지면 이어간다. STG 새 계약·Vercel·사람 리뷰 조건이 해결될 때까지
  예약 재점검이나 미승인 병합/배포를 진행하지 않고 대기한다.
- 자료는 현재 기기 `/Users/parkjongsun/.codex/visualizations/2026/10/06/01a11038-d621-7fb3-ad4e-58d01fbb9a6a/DL-16652/`
  의 final-review/final-delivery/current-review에 원본 캡처·합성 화면·집계·검사 로그로 보존했다. 실환자 화면/토큰/
  비밀번호를 Git에 저장하지 않는다. local-only 자료이며 Git 정본은 결과·링크·다음 시작점을 전달한다.
- Root QA Next3007·Lab8088/AVD5580·Office8090/AVD5582를 종료했다. 두 임시 AVD userdata는
  삭제했고 기존 adb 서버·다른 세션 runtime·primary 공유 의존성은 보존했다. Office own node_modules는
  manifest/lock과 맞는 독립 설치다. 실제 데이터 캡처/XML은 삭제했고 보존한 앱 화면은 합성 자료다.
- 10월7일 두 own iOS sim·Metro8088/8090도 정리했다. 기존 simulator/adb/shared deps/DeviceHub·
  CoreSimulator service는 보존했다. 두 앱 iOS startup 캡처는 인증 전 공개 안내 화면이며 PHI가 없다.
  보존한 iOS build log는 env dictionary를 가리고 민감 env값 잔존0을 내부 확인한 것이다.
