# Dentlink Lab App

## 역할과 저장소 — 2026-10-06 사용자 확정

- 기공소 네이티브 앱의 정본이다. Office 앱은 별도 `dentlink-app`과
  [Office 체크포인트](dentlink-app.md)를 사용한다.
- 원격: https://github.com/Innvoaid/dentlink-lab-app
- 기본 checkout: `/Users/parkjongsun/Repository/dentlink-lab-app`, `main`.
- React Native·TypeScript Lab 전용 저장소다. `src/configs/constants/environment.ts`의
  `APP_SERVICE_TYPE=LAB`, 환자목록은 `/lab/patients/consolidate`를 호출한다.
- 신규 작업은 정확한 앱을 먼저 구분하고 제품별 branch·worktree·API·runtime·release를 확인한다.
  웹의 `origin/master` 전략이나 Office 설정을 그대로 적용하지 않는다.

## DL-16652 현재 확인 — 2026-10-08

- PR #2는 OPEN/non-Draft/MERGEABLE/CLEAN, HEAD `14949c6afd`는 소스·원격 동일하며 새 제품 수정은 없다.
- DeviceHub 정상 입력이 회복돼 정식 cached Debug 앱 1.0.4(151)+최신 Metro를 own SE3/iOS 26.5에서
  확인했다. 실제 DEV 로그인·환자 770명/첫 페이지 10명·이름 검색 1명·recentOrderId 기반 상세 이동,
  WebView mounted/loading=false/errorPage=false까지 정상이다. 웹 상세 내부 조작은 별도다.
- 별도 iOS 합성 KO/EN에서 카드 343×248pt·목록 간격 14pt·내부 12pt·두 9자리 주문 수 보존,
  긴 라벨·생일 없음·Remake primary600·6개 상태를 확인했다. iOS pressed·지정 QA 그룹 ID 대조·
  실물 기기·배포 바이너리·최종 Android APK 재빌드는 미검증이며 이전 Android 증거와 구분한다.
- 공식 Sheet connector의 신규 6키/en·ko 12값은 현재 생성 파일과 모두 일치했다.
  CLI 403은 10월 6일 결과이며 오늘 CLI는 재실행하지 않았다. DEV는 새 API, STG는 이전 API다.
- PR 본문에 새 iOS 결과와 STG 선배포 조건을 반영했다. 전체 정본과 다음 시작점은
  [DL-16652](dentlink-patient-list-design.md)에 둔다. fixture/언어·own sim/Metro8088을 정리했고 .env 부재·
  Git clean/원격 동일·본문 readback/자동 검사 SUCCESS를 확인했다. 아래 DeviceHub 실패는 이전 확인 이력이다.

## DL-16652 최종 디자인 전달 — 2026-10-06~07 이력

- [PR #2](https://github.com/Innvoaid/dentlink-lab-app/pull/2), feature/DL-16652→develop,
  OPEN/non-draft/MERGEABLE/CLEAN 및 자동 제목/본문/라벨 검사 성공 확인.
- worktree `/Users/parkjongsun/Repository/dentlink-lab-app-patient-list`, base f33283339,
  Remake `0b7a94a288bcc1bdfbc26c1be3a2c4f9fff9cd8e` + 환자/API/i18n
  `5debbe0d3edd692fa96022db568b338e5fe08efb` + 최종 색상 `4f4e9c1` + 주문수 한줄 보정
  `14949c6afd77530852c166b317a667f4b30dd049`,4커밋·19파일. HEAD/원격 일치·clean·0/0 확인.
- 최종 카드의3정보줄·두 주문 수·생일 숨김·header Remake·상태/카테고리/의사·내부12px,
  실제 SVG 원본과 전역 Remake 배지3사용처를 반영했다. DEV 배포12필드와 최근 주문 이동을 연결했다.
- 23시 최신 Figma에서 문구/icon primary600을 확인해 공용 Remake를 최소 보정했다.
  실제375dp 기기에서 주문 수 라벨 두줄/긴EN 잘림을 발견해 환자 화면 전용으로 보정했다.
  한국어14px 한줄·343×248 카드/목록gap14를 유지하며 긴EN은 라벨만 말줄임하고 두9자리 숫자를 보존한다.
- 앱 번역 시트 양 영역314~319행에 신규6문구를 등록해 en/ko/registry를 생성했다.
  기존313행과 PM 이름/요청 상태를 보존했다. connector readback 및 승인 liveCSV283문구 검사 통과.
  CLI live check는 ADC scope403으로 실패했으며 시트 등록 실패와 구분한다.
- renderer10·변경 lint/Prettier/diff·최신 Android Metro bundle 통과. type4오류는 baseline/final SHA동일·신규0.
  fresh Android36 AVD와 기존 development APK+최신Metro에서 이전 system timeout을 재현하지 않았고
  정상 로그인·DEV763건 중10행 카드·검색1행·recentOrderId 기반 실제 주문 상세 이동/로딩을 확인했다.
  한국어 기본 실데이터와 긴문구/EN/9자리/Remake 기기 합성 fixture를 구분한다.
  최종 native APK 재빌드나 STG 통합 QA 완료로 표현하지 않는다. STG 실제 응답은10월7일00:36에도 이전 계약이다.
- 10월7일 잠금 버전 immutable deps·Ruby3.4.10/Bundler2.6.9/CocoaPods1.16.2와 독립 공식 index/cache로
  canonical deployment Pods를 설치했다(124dependencies/163Pods·lock byte동일·설정 hash 불변).
  정식 DentlinkLabDevelopment Debug simulator 빌드1.0.4(151) 성공 후 신규 SE3/iOS26.5에서 정상 설치·실행·
  Metro8088 연결·미인증 KO 알림 안내 렌더(375×667pt)를 확인했다. 제품 코드 수정은 필요하지 않았다.
- Xcode27 DeviceHub의 자동 제어 연결 실패/공식 simctl 입력 기능 부재로 iOS 실제 환자·검색·이동과
  합성 카드 UI는 미검증이다. 기존 Android 실제/합성 확인 결과와 구분하며 실제 기기도 연결0대다.
  비공식 입력/SDK/인증 우회 없이 own sim·Metro·본인 생성 root.env를 정리했고14949c6 clean/원격 동일하다.
  PR2 본문 검증 결과 갱신/readback·자동 검사 SUCCESS·artifact 연결까지 확인했다.
- 사용자 후속 승인으로 앱 PR까지 생성했다. merge/배포는 제외한다. 전체 정본은
  [DL-16652](dentlink-patient-list-design.md)이며 아래 초기 준비/번역 절차는 당시에 확인한 이력이다.

## 초기 로컬 준비 — 2026-10-06 (전달 전 이력)

- DL-16652 웹·기공소 앱 작업 요청으로 원격을 새로 clone했다. 기본 `main`은
  `f33283339d339b3c6d39fe2735a8420f2c1a5ae1`, `origin/main`과 동기화·clean이다.
- 조회 당시 `origin/develop`도 동일 HEAD다. 기존 앱 기능 기준에 맞춰 DL-16652를
  `origin/develop`에서 준비했으며 이후 기능 시작/전달 시 최신 base와 실제 PR 대상을 재확인한다.
- 작업 worktree: `/Users/parkjongsun/Repository/dentlink-lab-app-patient-list`.
  branch `feature/DL-16652`, 기준 대비 0/0·clean, upstream·원격 feature·PR 없음.
  기본 main과 기존 Office·권한관리 checkout을 변경하지 않았다.
- 의존성 설치·Metro·네이티브 빌드·시뮬레이터·실기기·테스트·배포는 아직 수행하지 않았다.
  Office 앱의 설치 앱·빌드 증거를 Lab 앱 검증으로 대체하지 않는다.

## 번역과 스프레드시트 작업 — 2026-10-06

- 승인된 Lab 앱 기능 구현에서 정적 UI 문구가 바뀌면 i18n과 운영 스프레드시트까지
  기본 작업 범위에 포함한다. 공통 정본은
  [SESSION_WORKFLOW.md](../SESSION_WORKFLOW.md#dentlink-lab-translation-work)다.
- 실제 절차는 저장소 `README.md`의 번역 동기화 (Lab), `package.json`,
  `scripts/sync-lab-i18n.js`, `scripts/lab-i18n-code-scanner.js`를 확인한다.
- 앱 시트는 `src/configs/i18n/index.ts`의 `LAB_I18N_SPREADSHEET_ID`를 따른다.
  확인 당시 기본값은 [기공소 앱 번역 시트](https://docs.google.com/spreadsheets/d/1ZnPl5a3P3dKtxDTadLX56aTmuJ58TrpZiRcXDexdLbw)이며
  `개발자 영역`·`비개발자 영역`을 함께 관리한다. 웹 Lab 번역 시트와 혼용하지 않는다.
- 신규 문구 절차: 실제 변경 문구·기존 key 대조 → `yarn i18n-google-sheet:dry-run`
  → 누락·충돌 확인 후 `yarn i18n-google-sheet`로 시트 반영 → PM 문구 확인
  → `yarn i18n`으로 `src/configs/i18n/locales/{en,ko}.ts`·`textRegistry.ts` 생성
  → `yarn i18n:check`와 변경 문구·화면 검증. 기존 문구 수정은 대응하는 시트 행과
  PM 검토 절차를 확인하며, 삭제는 다른 사용처가 없는지 먼저 대조한다.
- 새 문구 스캐너는 미커밋·미추적 `src` 변경의 일부 literal만 수집한다.
  `t(key, { defaultValue })` 또는 변수·Map 문구가 누락될 수 있으므로 실제 diff와
  시트 행을 직접 대조해 보완한다. 스캐너가 0개를 찾았다고 번역 완료로 판단하지 않는다.
- 생성은 `PM 확인여부=확인`인 행만 포함한다. 미확인 문구를 임의 승인하지 않으며
  새 key가 제외되어도 `i18n:check`가 성공할 수 있으므로 대상 문구의 생성 여부를 별도로 확인한다.
- iOS·Android 실행 명령의 자동 `i18n` 호출은 시트에서 리소스를 생성하는 단계다.
  코드의 신규 문구를 시트에 등록하거나 PM 확인을 대신하는 자동화는 아니다.
- 시트 편집 인증, PM 검토 또는 충돌 해결이 필요하면 해당 단계는 미완료로 남긴다.
  `yarn i18n`은 인증이 있을 때 시트의 정리·검수 상태도 갱신할 수 있으므로 결과를 확인한다.
  생성 리소스만 수동 변경한 상태를 시트 동기화 완료로 보고하지 않는다.
- 이번 확인에서는 제품 파일·시트를 수정하거나 번역 명령을 실행하지 않았다.

## 규칙과 다음 시작점

- 작업 checkout의 `AGENTS.md`를 읽고 기존 `src` 구조와 Styled Components 규칙을 따른다.
- `src/models/Api.ts` 등 생성 모델은 직접 수정하지 않고 확인된 Swagger로 생성한다.
  백엔드 미완성 상태와 예정 계약·실제 연동 완료를 구분한다.
- 환경·서명·CodePush·스토어 배포는 별도 사용자 지시를 따른다.
- 환자목록의 첫 작업은 [DL-16652 정본](dentlink-patient-list-design.md)에서 이어간다.
  API 경로: `src/services/patient.service.ts`, 화면:
  `src/features/orderList/tabs/OrderPatientTabScreen.tsx` 및 `OrderPatientListItem`.
