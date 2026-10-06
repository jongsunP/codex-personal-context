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

## 초기 로컬 준비 — 2026-10-06

- DL-16652 웹·기공소 앱 작업 요청으로 원격을 새로 clone했다. 기본 `main`은
  `f33283339d339b3c6d39fe2735a8420f2c1a5ae1`, `origin/main`과 동기화·clean이다.
- 조회 당시 `origin/develop`도 동일 HEAD다. 기존 앱 기능 기준에 맞춰 DL-16652를
  `origin/develop`에서 준비했으며 이후 기능 시작/전달 시 최신 base와 실제 PR 대상을 재확인한다.
- 작업 worktree: `/Users/parkjongsun/Repository/dentlink-lab-app-patient-list`.
  branch `feature/DL-16652`, 기준 대비 0/0·clean, upstream·원격 feature·PR 없음.
  기본 main과 기존 Office·권한관리 checkout을 변경하지 않았다.
- 의존성 설치·Metro·네이티브 빌드·시뮬레이터·실기기·테스트·배포는 아직 수행하지 않았다.
  Office 앱의 설치 앱·빌드 증거를 Lab 앱 검증으로 대체하지 않는다.

## 규칙과 다음 시작점

- 작업 checkout의 `AGENTS.md`를 읽고 기존 `src` 구조와 Styled Components 규칙을 따른다.
- `src/models/Api.ts` 등 생성 모델은 직접 수정하지 않고 확인된 Swagger로 생성한다.
  백엔드 미완성 상태와 예정 계약·실제 연동 완료를 구분한다.
- 환경·서명·CodePush·스토어 배포는 별도 사용자 지시를 따른다.
- 환자목록의 첫 작업은 [DL-16652 정본](dentlink-patient-list-design.md)에서 이어간다.
  API 경로: `src/services/patient.service.ts`, 화면:
  `src/features/orderList/tabs/OrderPatientTabScreen.tsx` 및 `OrderPatientListItem`.
