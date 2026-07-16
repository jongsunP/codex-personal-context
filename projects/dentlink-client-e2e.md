# Dentlink E2E Stabilization

## Repository

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- Local worktree: `/Users/parkjongsun/Repository/dentlink-client-e2e`
- Jira: `DL-15560`
- Release target: `release/v1.78.0`

## E2E Policy

- 원래 통과하는 시나리오는 실행 시점이나 반복 횟수와 무관하게 안정적으로 통과해야 한다.
- 원래 실패해야 하는 시나리오는 계속 실패해야 한다.
- 버전업 이후 실패는 버전 회귀, 기존 문제, 신규 시나리오, 환경 세팅 문제로 구분한다.
- 기존 문제는 바로 수정하고, 버전 회귀는 대응하며, 신규 시나리오에 세팅이 필요하면 사용자에게 보고한다.
- 최종 완결 기준은 로컬 전체 2회 연속 통과와 스테이징 전체 2회 연속 통과다.

## Current Checkpoint — 2026-07-16

### Integration State

- PR [#4387](https://github.com/Innvoaid/dentlink-client/pull/4387)이 `release/v1.78.0`에 머지됐다.
- 릴리즈 머지 커밋: `619b1c22b0683d6b489193f1c1c45d503adfb05d`
- 사용자 확인 기준 현재 스테이징 배포 진행 중이다. 실제 배포 완료 여부는 다음 재개 시 다시 확인한다.
- 작업 브랜치: `feature/DL-15560-1`
- 작업 커밋: `b61c2a1fc56410f9adf10a809caf6c98e0313060`

### Completed Changes

- Google Place 상세 API 응답이 `null`일 때 좌표를 읽으며 발생하던 온보딩 병원 등록 예외를 방지했다.
- 로컬에서 병원이 자동 승인돼 승인 PATCH가 HTTP 400을 반환하면 온보딩 계정의 employee 목록으로 employer를 찾는 기존 fallback을 사용하도록 했다.
- 회원가입 전체 플로우의 테스트 상한을 내부 90초 리다이렉트 대기보다 긴 120초로 맞췄다.
- ISV Step4 진입 테스트의 실행 상한을 로컬 90초, 스테이징 5분으로 조정했다.
- Clinic/Lab/Admin 로컬 E2E 서버가 고정 E2E 포트에서 안정적으로 기동되도록 Playwright webServer 설정을 보완했다.
- 수동 서버를 재사용해야 하는 진단 실행을 위해 `E2E_SKIP_WEB_SERVER=true` 옵션을 추가했다.

### Verification

- 정상 Playwright 관리 서버 실행 경로에서 로컬 전체 E2E 2회 연속 통과:
  - 1차: `94 passed`, `5 skipped`, `0 failed`
  - 2차: `94 passed`, `5 skipped`, `0 failed`
- 의도적 스킵 5건:
  - Referral 코드 세팅 대기 1건
  - BP 파트너 키 세팅 대기 1건
  - Default Scanner 미설정 전용 계정 세팅 대기 3건
- Clinic 타입 검사와 `git diff --check` 통과.
- push hook의 Clinic/Lab/Admin 타입 검사와 coverage 검사는 통과했다.
- lint는 기존 경고 419건, 오류 0건으로 성공했다.

### Remaining Work

1. 스테이징 배포 완료를 확인한다.
2. 배포된 `release/v1.78.0` 기준으로 스테이징 전체 E2E를 2회 연속 실행한다.
3. 두 실행 모두 의도적 스킵 외 실패 0건이면 E2E 안정화 작업을 완결한다.
4. 실패가 있으면 버전 회귀, 기존 문제, 신규 시나리오, 환경 세팅 문제로 다시 분류한 뒤 대응한다.

### Separate Backlog

- styled-components v6에서 style-only props가 DOM으로 전달되는 경고가 대량 발생한다.
- 현재 E2E 실패와 직접 연결되지는 않았으며 별도 범위로 조사한다.
- Default Scanner 미설정 상태는 기존 계정을 변경하거나 API로 모킹하지 않고, 추후 전용 계정을 만든 뒤 의도적 스킵 3건을 활성화한다.

## Next Start Point

1. `codex-personal-context`와 공유 저장소를 pull한다.
2. PR #4387의 머지 커밋이 스테이징에 실제 배포됐는지 확인한다.
3. 스테이징 전체 E2E 1차와 2차를 순차 실행한다.
4. 각 실행 결과를 `passed / intentional skipped / failed`로 기록하고 실패 원인을 정책에 따라 분류한다.
