# Dentlink 웹 환경변수 관리

## 현재 상태 — 2026-10-15 읽기 전용 조사 완료·구현안 검토 대기

- 요청 출처: [Tom의 env Git 제외·관리 방법 정리 요청](https://innovaidhq.slack.com/archives/C09613TBE5A/p1792024421500669). 원문과 전체 답글을 확인했다.
- 이 세션은 메인 프로젝트 폴더의 별도 기능 세션이다. 제품 저장소는 `/Users/parkjongsun/Repository/dentlink-client`이며 조율 폴더에 제품 코드를 만들지 않는다.
- 현재 승인 범위는 실제 파일·추적·사용처·로컬/CI/Docker/E2E 공급 경로 조사와 구체적인 구현안 보고다. 제품 코드 수정·env 삭제·브랜치/worktree 생성·커밋/푸시/PR·배포·Secret 변경은 하지 않았다.
- DLDS npm Trusted Publisher의 GitHub Environment 선택과 별개다. DLDS PR에 이 작업을 섞지 않는다. 기존 Slack의 1.89 발언은 DLDS 전달에 관한 문맥이며 이번 env 작업의 fixVersion으로 전용하지 않는다.
- Web Admin/Clinic/Lab이 대상이다. 별도 Office/Lab 네이티브 저장소의 env 정리는 이번 범위에 없다. Eximbay 웹뷰 경로는 아래 별도 협업 항목이다.

## 확인한 Git 기준과 보존 상태

- 개인 컨텍스트는 `git pull --ff-only` 후 읽었다. 시작 당시 다른 세션의 권한관리 체크포인트 변경을 보존했다.
- 제품 저장소는 `git fetch origin` 후 고정 `origin/master` `8772d68825cac6e23792d86a715153a67dc71078`의 Git 객체를 읽었다. 다른 작업 checkout을 pull/전환하거나 변경하지 않았다.
- 기본 checkout: `feature/DL-16796` / `3aac1dff0005706e78015cb5f23f255712696911`, clean.
- DLDS 기존: `dentlink-client-dlds`, `feature/DL-16471` / `12fb96a4e32c6a5e9abb4f61c235d9c2c1e53a14`, clean.
- DLDS 통합: `dentlink-client-dlds-integration`, `feature/DL-16471-dlds-dlos-integration` / `c5679107d278315861f171da482bab551c57dff1`, clean.
- 권한관리: `dentlink-client-permission`, `feature/DL-16317` / `7c724ad0afdd9b5c0e6ba30693fa2abefedd33ff`, clean. 과거 체크포인트 SHA보다 진행된 live 상태다.
- 통합 DLDS branch와 master의 diff에서도 서비스 env9개·서비스 ignore 규칙 변경은 없다. 루트 `.gitignore`의 패키지 출력/`.npmrc` 표기 정리만 있다.
- 구현 승인 후 최신 `origin/master`에서 `feature/<Jira>`와 격리 checkout을 준비한다. Jira 카드·최종 PR 대상은 아직 확정하지 않았다.

## 확인한 env 공급 경로

| 구간 | 현재 상태와 제거 영향 |
| --- | --- |
| Git | Admin/Clinic/Lab의 `.env.development`, `.env.staging`, `.env.production` 총9개가 추적 중이다. 서비스 `.gitignore`는 `.env*.local`만 제외한다. |
| 일반 로컬 | 서비스별 Next 실행이 env 파일을 읽는다. 값 없는 예제·값 전달 위치·필수/선택 키·설치 후 실행 안내를 함께 마련해야 한다. |
| Docker DEV/STG | 6개 Dockerfile은 `COPY . .` 후 대상 `.env.development`/`.env.staging`을 `.env.production`으로 이동한다. 파일만 추적 제외하면 fresh CI에서 `mv`가 실패한다. 대표 `dockerfiles/Dockerfile.admin.dev:26-28`. |
| Docker PRD | 3개 Dockerfile은 복사된 `.env.production`으로 빌드하며 별도 빌드값 공급이 없다. 삭제 시 동일 설정의 빌드를 보장할 수 없다. |
| Docker context | `.dockerignore`에 env 제외 규칙이 없다. Git ignore와 Docker 제외를 함께 바꿔야 개발자 로컬 env가 `COPY . .`에 섞이지 않는다. |
| 서버 runtime | 기존 workflow에서 GitHub Secrets를 ECS task definition의 `environment-variables`에 주입한다. Admin11개, Clinic/Lab은 JIRA 토큰. 이 경로를 유지한다. 대표 `.github/workflows/admin_dev_build_and_deploy.yml:112-138`. Clinic STG/PRD는 서울·오하이오 양쪽이다. |
| E2E runner | `scripts/e2e-run.js:161-172`가 Clinic `.env.<development|staging>`를 `readFileSync`로 필수 읽고 `{...parsed, ...baseEnv}`로 합친다. 파일이 없으면 shell/CI 값이 있어도 실패한다. |
| Playwright | `playwright.config.ts:14-26`에서도 같은 파일을 별도 로딩한다. 이름/경로 변경 시 runner와 함께 수정해야 한다. |

- tracked env의 서버 credential 항목은 빈칸이다. 비공개 이름 중 nonempty 항목은 Admin의 Notion title-property 설정뿐이다. 키 이름만으로 서버 비밀값이 Git에 저장돼 있다고 결론 내리지 않는다.
- GitHub repository Secret의 이름 메타데이터로 GEMINI/JIRA/N8N/OPENAI/NOTION 관련 기존 키 등록을 확인했다. 값·유효성·실제 AWS task definition은 조회하지 않았다. workflow의 `OPENAI_IMAGE_MODEL`은 repository Secret 목록에 없으며 다른 scope/기본값 적용 여부는 이번 조사에서 미확인이다.
- existing GitHub Environments 목록 조회는 이름만 수행했다. 이 작업을 위해 새 Environment를 만들 필요가 확정된 것은 아니다.
- `.aws/appspec-*.yml`9개는 ECS task definition placeholder와 서비스/LB 설정이며 별도 env hook은 없다.
- DEV/STG workflow의 제품 경로 필터 때문에 Dockerfile/공통 스크립트/workflow만 바꾼 후속 수정은 자동 배포를 촉발하지 않을 수 있다. 검증 실행과 실제 배포 승인은 분리한다.

## 공개 설정·테스트 설정 분류

- `NEXT_PUBLIC_*` 중 앱에서 정적으로 참조하는 값은 Next 빌드 때 브라우저 코드에 포함된다. Git 제외나 GitHub Secret 보관으로 브라우저 값이 비밀이 되지는 않는다. [Next 공식 문서](https://nextjs.org/docs/pages/guides/environment-variables)
- Clinic DEV/STG에는 nonempty E2E password 항목이 각각7개 있다. 값은 읽기 도구 출력·기록에 남기지 않았고 유효성도 시험하지 않았다.
- `NEXT_PUBLIC_E2E_*` 사용처는 E2E·scripts·Playwright·문서·CI이며 서비스 앱 src/shared 직접 참조는 발견하지 못했다. 현재 배포 브라우저 번들에 E2E 계정이 포함됐다고 단정하지 않는다. 테스트 전용 파일/CI 주입과 비공개 접두사로 정리하는 것이 제안이다.
- 접두사를 바꾸면 E2E test/helper뿐 아니라 `e2e/setup/onboard-artifacts.ts:46`의 계정 잠금 수집 정규식, CI 환경변수도 함께 바꿔야 한다.
- 접두사 정리를 선택할 경우 `scripts/e2e-verdict.js:17,23`의 허용 제외 오류문구, global-setup의 필수 키 검사, runner/lifecycle/signup 회귀와 관련 문서도 함께 대조한다. 단순 문자열 변경으로 계정 잠금/판정 계약을 깨뜨리지 않는다.
- `NEXT_PUBLIC_EXIMBAY_SECRET_KEY`는 세 환경에 nonempty이며 `clinic/src/lib/Card/eximbayCardRegistrationParams.ts:90`에서 서명 계산에 사용한다. `useAddCardEximbayUI.ts:125-126`와 `pages/cards/add/[request_id]/redirect.tsx:37-38`의 브라우저/웹뷰 흐름으로 연결된다. 키 유효성·운영 번들은 미검증이다. Git 제외와 별개로 결제 담당자/BE와 공개 허용 여부 및 서버 서명 전환을 검토해야 한다. 임의 키 회전·결제 로직 변경은 하지 않는다.

## 제안하는 최소 이행안 — 아직 미승인·미구현

1. 기존 서버 Secrets→ECS runtime 계약은 유지한다. 서비스·환경별 공개 빌드 설정, 서버 키, E2E 계정을 구분하고 소유자·승인된 보관소·개발자 전달 경로를 정한다.
2. Git에는 서비스별 값 없는 `.env.example`과 필수/선택 키 설명을 남긴다. 초기 전환에서 로컬 기존 `.env.development` 등 파일명 유지도 가능하며 Git에서만 제외한다. `.env.development.local`로 바꾸는 경우 E2E의 명시적 환경 선택과 별도 loader를 함께 조정한다. `.env.staging`은 Next 표준 자동 로딩 환경이 아니므로 `NODE_ENV=staging`으로 일반화하지 않는다.
3. CI 빌드 설정은 서비스/환경별 GitHub Actions 설정에서 공급하도록 9개 workflow/Dockerfile을 함께 변경한다. 공개 빌드값만 빌드로 전달하고 서버 키·E2E 계정을 빌드 env 묶음에 넣지 않는다.
4. BuildKit을 사용할 경우 `/run/secrets/...`에서 공개 빌드값만 parser로 읽어 빌드 자식 프로세스의 env로 전달하는 안을 검토한다. `.env.production` 직접 mount는 Next standalone에 파일이 복사될 수 있다. 현재 설치된 Next16.2.7 `dist/build/index.js:268-284`에서 해당 복사 동작을 확인했다.
5. Secret mount 내용 변경은 Docker 캐시 키가 아니므로 builder 캐시 무효화 또는 별도 설정 revision을 포함한다. [Docker secret 문서](https://docs.docker.com/build/building/secrets/)와 [캐시 문서](https://docs.docker.com/build/cache/invalidation/) 기준이다.
6. E2E 계정은 제품 env에서 분리하고 runner·Playwright·CI가 같은 선택 환경을 읽도록 정리한다. 기존 shell/CI 우선순위·환경 선택·계정 잠금을 보존한다. 누락 시 값 없이 키/파일명만 알리는 검증이 필요하다.
   파일 없이 CI 환경변수만 주입하는 경로를 지원하고, E2E_ENV가 선택한 환경의 로컬 파일만 읽는다. 일반 Next env loader로 E2E 환경 선택을 대체하지 않는다.
7. 새 공급 경로와 개발자 복원 절차를 마련한 뒤 Git 추적을 해제한다. 기존 로컬 파일을 보존하고, 다른 브랜치에서 전환 커밋을 받을 때 tracked 파일 삭제가 적용될 수 있으므로 개발자별 사전 보관/재공급 순서를 안내한다. `.dockerignore`도 같이 적용한다.
8. fresh checkout 로컬3서비스, 3제품×3환경 Docker 빌드, E2E 설정 로딩/기존 테스트, env만 변경한 재빌드, standalone/이미지의 서버키·E2E 값 비포함을 검증한다. 실제 계정 쓰기 E2E·CI 배포·운영 검증은 승인 범위 안에서 별도로 한다.

## 다음 시작점

- 사용자에게 조사 결과와 위 안을 보고한 뒤 구현 지시를 기다린다.
- 필요한 협업 결정: 환경별 설정의 보관/갱신 담당자와 개발자 전달 채널, CI 설정 등록 담당자, Eximbay 키 공개 허용/서버 서명 처리의 책임자.
- 제품 구현·커밋/푸시/PR·배포·Git 이력 재작성·키 회전·CI 자격 변경은 별도 승인 없이 진행하지 않는다. Slack/Jira 메시지도 게시하지 않았다.
- 이번 검증은 live Git/Slack/Secret 이름과 소스의 정적 조사다. 테스트·빌드·실계정·배포·운영 증거는 없다.
