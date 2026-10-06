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

## DL-16652 최종 디자인 전달 — 2026-10-06

- [PR #2](https://github.com/Innvoaid/dentlink-lab-app/pull/2), feature/DL-16652→develop,
  OPEN/non-draft/MERGEABLE/CLEAN 및 자동 제목/본문/라벨 검사 성공 확인.
- worktree `/Users/parkjongsun/Repository/dentlink-lab-app-patient-list`, base f33283339,
  Remake `0b7a94a288bcc1bdfbc26c1be3a2c4f9fff9cd8e` + 환자/API/i18n
  `5debbe0d3edd692fa96022db568b338e5fe08efb`,2커밋·19파일. HEAD/원격 일치·clean 확인.
- 최종 카드의3정보줄·두 주문 수·생일 숨김·header Remake·상태/카테고리/의사·내부12px,
  실제 SVG 원본과 전역 Remake 배지3사용처를 반영했다. DEV 배포12필드와 최근 주문 이동을 연결했다.
- 앱 번역 시트 양 영역314~319행에 신규6문구를 등록해 en/ko/registry를 생성했다.
  기존313행과 PM 이름/요청 상태를 보존했다. connector readback 및 승인 liveCSV283문구 검사 통과.
  CLI live check는 ADC scope403으로 실패했으며 시트 등록 실패와 구분한다.
- renderer10·변경 lint/Prettier/diff·최신 Android Metro bundle 통과. type4오류는 baseline/final SHA동일·신규0.
  이전 Android 개발 빌드/설치는 성공했으나 AVD system service timeout으로 최종 실화면 QA는 미검증이다.
  다음에는 실제 기기의 긴 문구/그림자/검색/최근 주문 이동 및 STG 새 계약을 검증한다.
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
