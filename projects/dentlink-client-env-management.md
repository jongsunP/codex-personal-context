# Dentlink 웹 환경변수 관리

## 현재 상태 — 2026-10-15 팀 공유용 Notion 문서 작성 완료

- 사용자가 아래 내용을 팀 공유용 최종 요약으로 확인하고 Git 메모리 저장과 Notion 문서 작성을 요청했다. Tom에게 보내는 질문이나 개인 메시지가 아니라 **현재 상황과 개선안을 팀에 공유할 문서**다.
- [웹 환경변수 관리: 현재 상황과 개선안](https://app.notion.com/p/3face072e82f814b9a6ceaa36e5638af): 사용자가 승인한 현재 상황 3개·개선안 4개 항목만 담은 문서다. 사용자가 공유 위치를 지정하지 않아 workspace-level **개인 비공개 초안**으로 생성했다. 팀 접근 권한 부여·이동은 하지 않았으며 사용자가 위치를 지정하면 처리한다.
- 작성 직전 원격 master를 fetch하여 `8772d68825cac6e23792d86a715153a67dc71078`과 추적 env9개가 동일함을 재확인했다.
- 최초 문서에 공식 근거·세부 적용 순서·미정사항을 추가해 과하게 길어졌다는 사용자 정정을 받았다. 이후 사용자는 원문을 반드시 그대로 쓰라는 뜻이 아니라, Codex가 판단해 적절하고 쉽게 정리하라고 명확히 했다. Notion은 짧은 현황·개선안 구조를 유지하면서 로컬·CI·Git 추적 해제 등의 표현을 풀어 썼다. 조사 근거와 상세 검토는 개인 체크포인트에 보존한다. 로컬 비밀값 보관소는 여전히 미정이다.
- 완료 범위는 조사·제안·문서화다. 제품 코드/env/Git 추적/외부 설정은 바꾸지 않았고 빌드·테스트·배포는 수행하지 않았다. Slack 메시지도 보내지 않았다.

### 확정한 팀 공유 요약

**현재 상황**

- Admin·Clinic·Lab의 env9개를 코드와 함께 Git에서 관리하고 있다.
- 로컬 실행·Docker 빌드·E2E가 이 파일에 의존한다.
- 서버 비밀값 일부는 이미 GitHub Secrets → ECS로 별도 공급하고 있다.

**개선안**

- Git에는 필요한 변수 목록과 설정 방법만 남기고 실제 값은 분리해 관리한다.
- 공개 가능한 공통 설정은 GitHub Variables에서 로컬·CI가 함께 가져오도록 제안한다.
- 서버 비밀값의 기존 공급 방식은 유지하고 로컬 개발·테스트용 비밀값의 공유 경로를 마련한다.
- 기존 실행·배포·테스트가 유지되도록 공급 경로를 먼저 연결하고 검증한 뒤 Git 추적을 해제한다.

### 남은 결정과 다음 작업

- 로컬 개발·테스트 비밀값 보관소, 접근 권한, 관리 담당자, 변경 반영 절차는 적용 전에 확정한다. 이전 검토의 AWS Secrets Manager는 후보였으며 팀 공유 문서에서 확정안으로 제시하지 않았다.
- 사용자가 문서를 팀에 공유한다. 팀 문서 위치가 지정되면 Notion 페이지를 이동할 수 있다. 현재 링크만으로 팀원이 접근 가능하다고 안내하지 않는다.
- 구현 지시를 받으면 최신 master에서 상태를 다시 확인하고 새 공급 경로를 준비한다. 현재 문서화 요청을 구현·Git 추적 해제·배포 승인으로 확대하지 않는다.

## 이전 상세 검토 — 최종 공유 내용은 위 요약과 Notion 문서 기준

- 사용자가 원하는 답변 순서는 **Tom 원문의 의도 파악 → 실제 코드/Git 현황 → 현황에 맞는 대안 → 공식 문서나 일반적인 관리 관행의 근거**다. Tom에게 관리안을 정해 달라는 질문 문안으로 돌려주지 않는다.
- 이번 `진행해줘`는 위 검토와 제안 수행을 뜻한다. 제품 구현·외부 설정 변경·Slack 실제 전송을 시작하지 않았다.
- 원문 스레드를 다시 읽고 origin을 fetch했다. 분석 기준 master는 `8772d68825cac6e23792d86a715153a67dc71078`로 동일하다. 원격 tree의 env9개, DEV Docker의 파일 이동, E2E 파일 필수 로딩, Secrets→ECS 주입 코드를 재확인했다.
- 다른 세션의 DLDS 통합 checkout은 `fcbf17a9aedd88f29bee7f0925208dda7b0fc654`로 진행돼 있었다. 아래 최초 조사 시점의 SHA와 구분하며 어떤 변경도 가하지 않았다.
- 추가 공개 Slack 검색에서는 관련 없는 결과가 섞여 반환되어 팀 공용 보관소의 존재 여부를 판정하는 근거로 사용하지 않았다. 해당 검색은 중단했으며 인증정보 원문은 기록하지 않는다.

### 원문에서 확인되는 의도

- 명시된 요청은 기존 env의 Git 추적 제외와 이후 관리 방법 정리·공유다. 로컬·배포·테스트 공급을 마련하는 것은 현재 의존성상 필요한 구현 범위다.
- 원문은 특정 보관 제품이나 Secrets Manager 전면 도입을 지정하지 않는다. 보안/환경 일관성 개선은 제안의 기술적 이유로 설명할 수 있지만 Tom이 그 목적을 명시했다고 쓰지 않는다.
- `89 버전`은 DLDS 전달에 관한 발언이다. env 작업의 fixVersion으로 해석하지 않는다.

### 검토한 상세 권장안 — 기존 GitHub 기반 공급을 보완

1. **Git:** 실제값이 있는 env9개를 추적에서 제외하고, 서비스별 값 없는 `.env.example`·필수/선택 항목·가져오는 방법만 관리한다. `.gitignore`만 추가해서는 이미 추적된 파일이 빠지지 않으므로 index 제외도 필요하다. 개발자 기존 파일 보관/재공급 절차를 먼저 준비한다.
2. **공개 가능한 설정:** API 주소 등 공개 가능성이 검증된 값만 제품/환경별 GitHub Variables에 둔다. CI와 GitHub 인증된 개발자 모두 같은 원본에서 값을 읽도록 한다. 로컬 도구는 기본 DEV 설정을 받아 ignored env를 생성하고 개인 override를 보존한다. `NEXT_PUBLIC_` 접두사만으로 공개 가능하다고 분류하지 않는다.
3. **서버 비밀값:** 기존 GitHub Secrets→ECS runtime 주입을 유지한다. Variables에 비밀값을 넣지 않는다. GitHub Secrets는 설정된 값을 개발자가 다시 내려받는 공유 저장소가 아니므로 로컬 공급처라고 안내하면 안 된다.
4. **로컬 비밀값:** 개발·E2E에 필요한 비밀값은 접근 제한된 별도 보관소에서 공급한다. 기존 팀 보관소는 확인되지 않았다. 새 보관소가 필요하면 이미 사용하는 AWS와 연계 가능한 **AWS Secrets Manager**를 구체적인 후보로 제안한다. 이것은 도입 완료 사실이 아니며 접근 권한·운영 담당·비용을 결정해야 한다. 로컬은 필요한 DEV/테스트 값만 배포한다. 기존 CI Secret 복사본과 값이 달라지지 않도록 원본·변경 담당·반영 절차를 문서화한다.
5. **E2E:** 계정/테스트 설정은 앱 빌드 입력에 섞이지 않게 공급 대상을 분리한다. 초기에는 기존 키 이름을 유지해도 된다. runner와 Playwright가 선택한 환경의 파일/CI 값을 읽고 기존 우선순위·계정 잠금을 유지하도록 필요한 부분만 변경한다.
6. **Docker:** 로컬 env를 `.dockerignore`로 제외하고 공개 빌드 설정을 명시적으로 전달한다. 빌드에 실제 비밀값이 필요한 경우 BuildKit secret mount를 사용한다. 파일을 `.env.production`으로 직접 mount하면 Next standalone에 복사될 수 있으므로 결과물 검증도 필요하다. mount를 쓰는 경우 설정 변경 시 캐시 갱신을 포함한다.
7. **적용 순서:** 공급 원본과 로컬 복원 절차 준비 → Docker/CI/E2E 연결 → fresh checkout 로컬/빌드/설정 로딩 검증 → env 추적 해제와 팀 안내. 공개 설정 변경 시 Next 재빌드, runtime 키 변경 시 해당 배포 반영 절차를 구분해 문서화한다.

### 대안 비교와 범위

- **권장 이유:** 이미 GitHub Actions와 GitHub Secrets→ECS가 있으므로 기존 공급 구조를 유지하면서 빠진 공개 빌드 설정·로컬 공유 경로를 보완할 수 있다. Variables의 조회 기능을 이용하면 공개 설정을 Git 밖에서 로컬과 CI에 함께 공급할 수 있다. 이 선택은 공식 기능과 현재 구조를 바탕으로 한 판단이다.
- **중앙 AWS 대안:** 모든 일반 설정을 SSM Parameter Store로 모으고 비밀값을 Secrets Manager로 관리하면 로컬/CI의 중앙 조회·권한·버전 관리를 할 수 있다. 다만 개발자 AWS 로그인·IAM·계정/리전·운영 책임과 workflow 조회 단계를 추가해야 한다. 현재 그 체계는 확인되지 않아 env9개 제외의 필수 선행 작업으로 제안하지 않는다.
- **E2E 전면 변경 제외:** 접두사 전면 변경, 신규 공용 loader, 전체 테스트 리팩터링은 필수가 아니다. 최소 전환의 정확성에 필요한 소비부 변경과 별도 개선을 구분한다.
- **Eximbay 별도:** 브라우저 서명키 사용 경로는 별도 검토 항목이다. Variables에 무조건 옮기거나 Git 제외로 브라우저 노출도 해결됐다고 주장하지 않는다. 기존 동작을 바꾸는 서버 서명 전환·키 회전은 이 조사에서 수행하지 않는다.

### 공식 근거

- [Next.js env 관리](https://nextjs.org/docs/pages/guides/environment-variables): env Git 제외, 환경별 local 파일, public 값의 빌드 시 고정. 특정 보관 도구를 강제하는 문서는 아니다.
- [Git ignore](https://git-scm.com/docs/gitignore): 이미 추적 중인 파일은 ignore만으로 제외되지 않는다.
- [GitHub Variables](https://docs.github.com/en/actions/concepts/workflows-and-actions/variables)와 [조회 CLI](https://cli.github.com/manual/gh_variable_get): 비민감 설정 관리와 값 조회 기능. 이를 로컬 설정 생성에 사용하는 것은 프로젝트에 맞춘 제안이다.
- [GitHub Secrets](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-secrets), [Secrets API](https://docs.github.com/en/rest/actions/secrets#get-a-repository-secret): workflow 비밀값 주입과 값 재조회 불가.
- [Docker build secrets](https://docs.docker.com/build/building/secrets/), [cache invalidation](https://docs.docker.com/build/cache/invalidation/): 비밀값의 build ARG/ENV 노출을 피하는 mount와 캐시 특성.
- [AWS Parameter Store](https://docs.aws.amazon.com/systems-manager/latest/userguide/systems-manager-parameter-store.html), [Secrets Manager](https://docs.aws.amazon.com/secretsmanager/latest/userguide/intro.html): 중앙 설정과 비밀값의 보관/조회·권한 관리. 현재 팀 도입 상태는 미확인이다.

### 이전 Tom 공유 초안 — 미전송·팀 공유 문서로 대체

> Tom, 현재 Admin·Clinic·Lab의 환경별 env9개가 Git에 올라가 있고 Docker 빌드와 E2E가 이 파일을 직접 사용하고 있습니다. Git에는 값 없는 예제와 설정 방법만 남기고, 공개 가능한 설정은 GitHub Variables에서 로컬·CI가 함께 가져오며 비밀값은 기존 Secrets 주입을 유지하는 방식을 제안드립니다. 로컬에서 필요한 개발·테스트 비밀값은 권한이 있는 별도 보관소에서 공유하고, 기존 보관소가 없다면 AWS Secrets Manager를 후보로 보겠습니다. 현재 GitHub Actions/ECS 구조를 유지하면서 정리할 수 있는 방식이며, 대체 공급 경로와 신규 checkout 동작을 검증한 뒤 Git 추적을 해제하는 순서가 적절합니다.

## 이전 상태 — 원문 뜻 재확인·질문형 문안 정정 전

- 사용자 추가 설명: Slack 요청 자체의 뜻을 정확히 이해하지 못해 Codex가 작업을 제대로 이해·검토했는지 먼저 확인하려는 것이다. 현재 상태를 Git 메모리에 저장하고 직접 보낼 짧은 Slack 문안을 요청했다. 구현이나 Slack 실제 전송 요청은 아니다.
- Slack 전체 스레드를 다시 읽고 `git fetch origin`으로 master `8772d68825cac6e23792d86a715153a67dc71078`가 동일함을 확인했다. 기존 조사 기준과 작업 범위는 유효하다.
- 원문 뜻: 기존 env 파일을 Git 추적에서 제외하고, 개발자 로컬·배포·테스트에 필요한 설정을 앞으로 어떻게 보관·전달할지 정리해 팀에 공유하는 작업이다. 값이나 기능을 없애라는 뜻이 아니다.
- `89 버전에`는 앞서 이야기한 DLDS 릴리스 전달을 가리킨다. env 정리의 출시 버전 지정이나 DLDS의 env 실수 수정 요구가 아니다.
- 현재는 요구 이해와 소스/공급 경로 사전 검토 완료다. 구현·실행 검증·배포 완료가 아니다.
- 이전 답변에서 보관소·관리 담당자를 Tom이 먼저 정해야 진행 가능한 것처럼 강조한 부분을 정정한다. 기존 팀 방식이 있는지 확인하면 되고, 없다면 Codex와 사용자가 현재 구조에 맞는 관리안을 제안하면 된다. 구현의 세부 선택 전부를 Tom에게 넘기지 않는다.
- Eximbay 서버 서명 전환은 조사 중 발견한 별도 검토 항목이다. 이번 짧은 원문 확인 문안이나 모든 env 정리의 선행 조건으로 확대하지 않는다.

### 사용자에게 제공한 Slack 초안 — 미전송

> Tom, 기존 env 파일을 Git에서 제외하고, 개발·배포·테스트에 필요한 설정의 관리·공유 방법까지 정리하는 것으로 이해했습니다. 혹시 팀에서 이미 사용하는 env 보관·공유 방식이 있나요? 없다면 현재 구조에 맞는 관리안을 정리해서 공유드리겠습니다.

## 조사 범위와 승인 경계

- 요청 출처: [Tom의 env Git 제외·관리 방법 정리 요청](https://innovaidhq.slack.com/archives/C09613TBE5A/p1792024421500669). 원문과 전체 답글을 확인했다.
- 이 세션은 메인 프로젝트 폴더의 별도 기능 세션이다. 제품 저장소는 `/Users/parkjongsun/Repository/dentlink-client`이며 조율 폴더에 제품 코드를 만들지 않는다.
- 현재 승인 범위는 실제 파일·추적·사용처·로컬/CI/Docker/E2E 공급 경로 조사, 구체적인 관리안 보고, 개인 Git 메모리 기록과 팀 공유용 Notion 문서 작성이다. 제품 코드 수정·env 삭제·브랜치/worktree 생성·커밋/푸시/PR·배포·Secret 변경은 하지 않았다.
- DLDS npm Trusted Publisher의 GitHub Environment 선택과 별개다. DLDS PR에 이 작업을 섞지 않는다. 기존 Slack의 1.89 발언은 DLDS 전달에 관한 문맥이며 이번 env 작업의 fixVersion으로 전용하지 않는다.
- Web Admin/Clinic/Lab이 대상이다. 별도 Office/Lab 네이티브 저장소의 env 정리는 이번 범위에 없다. Eximbay 웹뷰 경로는 아래 별도 협업 항목이다.

## 최초 조사 시점 Git 기준과 보존 상태

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

## 최초 이행안 검토 이력 — 위 현재 권장안이 우선

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

- 팀 공유용 Notion 문서 작성과 read-back은 완료했다. 사용자가 내용을 공유하며, 팀 공유 위치를 지정하면 해당 페이지로 이동한다. Tom에게 보낼 Slack 문안 작성은 후속 작업이 아니다.
- 구현 지시를 받으면 최신 master에서 격리 환경을 준비하고 공개/비밀 설정을 분류한다. Variables 읽기 권한과 로컬 비밀값의 실제 보관소·접근 경로를 확정하고 새 공급 경로를 검증한다. Tom에게 기술안 전체를 결정해 달라고 돌려주지 않는다.
- Eximbay 공개 허용/서버 서명은 별도 범위로 검토한다.
- 제품 구현·커밋/푸시/PR·배포·Git 이력 재작성·키 회전·CI 자격 변경은 별도 승인 없이 진행하지 않는다. Slack/Jira 메시지도 게시하지 않았다.
- 이번 검증은 live Git/Slack/Secret 이름과 소스의 정적 조사다. 테스트·빌드·실계정·배포·운영 증거는 없다.
