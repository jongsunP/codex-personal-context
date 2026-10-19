# Dentlink 웹 환경변수 관리

## 현재 상태 — 2026-10-19 Notion 문서 모음·Jira 연결 정리 완료, 회의 후 전환 대기

- 사용자 요청으로 기존 공유 위치 `DEV Team / Development Documents`에 [웹 환경변수 관리 — 문서 모음](https://app.notion.com/p/3fece072e82f81bf9edfe7a5b959a03c)을 만들고 기존 문서 3개를 실제 하위 페이지로 옮겼다. 내용 문서는 여전히 3개이며, 목차 역할의 모음 1개를 포함하면 총 4개다. 문서 복제·삭제는 하지 않았다.
- 하위 순서: ① [현재 상황과 개선안](https://app.notion.com/p/3face072e82f814b9a6ceaa36e5638af) — 이전 회의 기록, ② [설정 화면과 연결 흐름](https://app.notion.com/p/3fbce072e82f81119615e41b7c1195eb) — 회의 참고자료, ③ [팀 사용 가이드](https://app.notion.com/p/3fbce072e82f81578c76d458c0a01c22) — 전환 후 실제 사용. 모음에는 각 문서와 한 줄 용도, Jira 상위 링크만 넣었다.
- 이동 후 3개 문서의 동일 ID·직접 URL·새 상위 경로를 조회했다. 이동 전후 본문과 discussion 표시를 문자열 비교하여 모두 동일함을 확인했다. 기존 회의 댓글 1개와 사용 가이드의 접힌 최소 명령도 보존했다.
- Jira DL-16818의 문서 목록은 새 모음 링크와 한 줄 안내로 통합했다. DL-16819는 이전 회의 직접 링크와 모음 링크를, DL-16821은 팀 가이드 바로가기·모음·상위 카드 링크를 제공한다. 제목·담당자·상태(진행 중/완료/진행 중)·댓글 수(0/0/4)는 변경 전후 조회로 유지 확인했다. 댓글은 추가하지 않았다.
- 이번 정리는 Notion 구조와 Jira 문서 링크만 변경한 것이다. 제품 코드·GitHub 설정·실제 환경 적용·배포·전환은 수행하지 않았다. 다음 시작점은 회의 결과와 사용자 재개 요청을 받은 뒤 기존 남은 검증·전환 순서를 진행하는 것이다. 아래 Git/PR 상태는 직전 확인 기록이며 재개 시 다시 조회한다.

## 직전 정리 — 2026-10-19 문서·운영 개념 정리 확정

- 사용자는 최종 정리를 이해·확인했다. **회의용 문서는 이 대화에서 이해한 저장 위치·분류 기준·연결 흐름을 실제 화면과 함께 팀에 설명하는 자료이고, 운영용 문서는 에이전트가 프로젝트 공통 지침·스크립트로 로컬 설정·새 키 추가·갱신을 처리하도록 요청하는 사용법**이다. 팀원은 용도·서비스·환경을 알려주고 본인 로그인·권한·필요한 비밀값 준비를 담당한다. 개인 메모리나 개인용 스킬 설정을 따로 요구하지 않는다.
- 사용자는 “지금 정리한 내용까지 메모리하고 대기, 회의 후 실제 전환 작업은 다시 같이 진행”을 명시했다. **문서·Jira 정리는 완료이며 다음 요청 전까지 제품 코드·GitHub 설정·검증 확장·배포·전환을 진행하지 않는다.** 회의 결과를 받은 뒤 Git/PR/설정 상태를 새로 확인하고 남은 Docker·팀원 전달/실제 사용/복구 검증, env Git 추적 해제와 전환 순서를 함께 재개한다. 이번 대기는 자동 재개·알림·모니터링 요청이 아니다.
- 마감 시 제품 worktree clean, HEAD와 PR head `5cbac9f82d17d0956347403c8371f77b321b31c0` 일치, PR #4713 OPEN Draft/base master·DRAFT label·[WIP] 제목 유지 확인. 이번 마감에서는 개인 context만 갱신한다.
- 후속 카드 간소화 요청으로 DL-16818/16819/16821을 다시 읽었다. 상위 DL-16818은 이미 정리된 목차·연결을 유지했다. 완료 DL-16819는 회의 기록을 보존하고 이전 ‘사용·운영 가이드’ 링크 표시명만 ‘후속 회의 참고: 설정 화면과 연결 흐름’으로 맞췄다. 구현 DL-16821 본문은 작업 내용·현재 단계와 남은 일·팀 가이드/상위 자료 링크로 축약했다. 기존 범위와 보존/검증 조건은 유지했다.
- 카드 변경 후 3개를 read-back해 제목·담당자·상태(상위/구현 진행 중, 회의 완료)와 댓글 수(0/0/4)가 유지됨을 확인했다. 이번에는 댓글·노션·제품 코드·GitHub 설정을 추가 변경하지 않았으며 회의 후 전환 재개 대기를 유지한다.

- 사용자는 문서를 무조건 합치라는 뜻이 아니라, 공통 지침·스크립트가 준비된 현재 수준에 맞게 사용법을 간단히 하되 회의용 개념 설명은 실제 화면·코드 정보 중심으로 별도 유지하라고 명확히 했다.
- 기존 Notion 두 가이드를 새 페이지 생성 없이 재구성했다. [팀 사용 가이드](https://app.notion.com/p/3fbce072e82f81578c76d458c0a01c22)는 로컬 설정·새 키 추가·갱신 요청 예문, 본인이 준비할 로그인/권한/비밀값 파일을 중심으로 통합했다. 직접 실행할 최소 명령은 접힌 토글에 남기고, 상세 전달·복구 절차는 제품 `docs/environment-variables.md` 정본으로 연결한다.
- [설정 화면과 연결 흐름](https://app.notion.com/p/3fbce072e82f81119615e41b7c1195eb)은 회의 참고용으로 역할을 바꿨다. 실제 Environments 목록 → Clinic DEV 상세 → 분류표 → workflow 환경 선택/설정 읽기 링크 순서로 설명한다. GitHub 공식 기능과 프로젝트 스크립트/에이전트 역할도 구분한다. 기존 ‘운영 가이드 + 로컬 따라하기’ 두 사용 문서를 따로 읽을 필요가 없도록 바꾼 것이다.
- 라이브 읽기 확인: 새 서비스×환경 9개와 기존5환경, Clinic DEV Variables34·Secrets 묶음2(`DENTLINK_BUILD_ENV`, `DENTLINK_E2E_ENV`), workflow 환경선택34~36행·조회72~82행. 실제 값은 출력하지 않았다. 제품은 `5cbac9f82` clean·원격 일치, PR4713 OPEN Draft/base master 유지.
- [이전 회의 개요](https://app.notion.com/p/3face072e82f814b9a6ceaa36e5638af) 본문·수정시각은 그대로 보존했고 다시 읽어 확인했다. 완료 카드 DL-16819도 변경하지 않았다. 문서가 새로 추가되거나 삭제되지는 않았다.
- Jira 상위 DL-16818의 문서 목차를 ‘실제 사용 / 회의 설명 / 이전 회의 기록’으로 정리했다. 구현 DL-16821은 요구 범위·완료 기준을 보존하며 문서 링크와 공통 에이전트 절차를 반영하고 댓글44485로 변경을 안내했다. 제목·담당자·상태는 유지하며 상위 댓글은 추가하지 않았다. 두 Notion 제목/본문/토글/링크와 세 Jira 카드의 내용·상태를 read-back 확인했다.
- 이번 후속에서는 제품 코드·GitHub 설정·실제 env 준비/적용·배포를 변경하지 않았다. 공통 지침·도구 준비는 완전 무인화나 Secrets 원문 다운로드를 뜻하지 않는다. 기존 Docker·팀원 전달/실제 사용/복구 검증과 운영 전환은 사용자 재개 후 진행한다.

## 직전 작업 — 2026-10-19 새 키 추가·로컬 설정의 팀 공통 지침 보완

- 사용자는 안건을 **새 키 추가와 로컬 설정** 두 가지로 한정했다. 설명만이 아니라 팀원이 바로 쓸 수 있는 짧은 안내가 목표다. 새 키 추가는 Lab i18n처럼 개인 메모리 대신 제품 저장소의 공통 문서와 에이전트 지침·스킬에서 같은 절차를 따르도록 요청했다.
- 제품 `feature/DL-16821`의 문서 커밋 `5cbac9f82`에서 `docs/environment-variables.md`를 정본으로 보완했다. `AGENTS.md`·`claude.md`·`.cursorrules`와 `.codex/.claude/skills/environment-variables/SKILL.md`가 같은 정본을 가리킨다. 런타임 스크립트·manifest·실제 값·workflow 변경은 없다.
- 새 키 절차: 실제 사용처/서비스/환경 확인 → 공개/비공개 분류 → manifest·분류표·필요한 예제/사용처 갱신 → 기존 브랜치/로컬 도구와 호환되는 등록·반영 순서 → 승인된 값 공급 및 로컬 전달 → 검증·값 없는 안내. 정의를 먼저 필수화하면 누락, 원격 키를 먼저 추가하면 이전 로컬 도구의 허용 목록 오류가 가능하다. 비공개 묶음은 이전 코드도 새 키를 거부하므로 기존 소비 중인 묶음을 즉시 교체하지 않는다. 지침은 모든 수동 GitHub 변경을 차단하는 기능이 아니다.
- 로컬 개념: GitHub 공식 저장/CLI/API + 프로젝트 전용 `env:pull/bootstrap/pack/unpack/prepare/apply` 조합이다. Secrets 원문은 다시 내려받을 수 없고 기존 private 또는 팀원이 전달한 암호화 묶음을 사용한다. 로그인·전달 비밀번호는 사용자 터미널에서 직접 입력한다.
- 공통 요청 예문: “환경변수 운영 가이드에 따라 Clinic DEV 로컬 실행 환경을 준비해줘. 기존 파일을 보존하고, 내 로그인이나 비밀번호 입력이 필요한 단계만 안내해줘.” 새 키는 용도·이름·서비스/환경·승인된 로컬 값 파일 위치를 전달하며 실제 비밀값은 채팅에 붙이지 않는다.
- 전환 후 일반 공개값 갱신은 `pull → apply → dev:clinic`이며 apply가 prepare를 내부 실행하므로 중복 단계가 필요 없다. 새 키 안내 시 코드부터 갱신한다. 비공개 값이 바뀐 경우만 새 묶음을 받는다.
- 첫 이관에서는 준비 명령이 있는 코드를 확보한 뒤 env 추적 해제 커밋을 받기 전에 원본을 bootstrap/백업한다. 순서가 불가능하면 원본을 먼저 Git 밖에 보관한다. 첫 apply가 남은 기존 env를 보존하며 중단하면 개인값을 `.env.local`로 옮기고 대상 파일을 ignored backups에 보관한다. 생성 앱 env에는 E2E가 없으므로 이후 bootstrap을 완전 복구 도구로 사용하지 않는다.
- [Notion 운영 가이드](https://app.notion.com/p/3fbce072e82f81119615e41b7c1195eb)에 새 키 요청 예문·공통 절차·공식 기능/전용 스크립트 구분을, [로컬 따라하기](https://app.notion.com/p/3fbce072e82f81578c76d458c0a01c22)에 에이전트 요청 예문·일상 최소 순서·최초 백업·Clinic DEV 통일 예시를 반영하고 다시 읽어 확인했다. 개요/기존 댓글·Jira는 수정하지 않았다.
- 독립 읽기 검토의 최초 bootstrap 순서 보완 1건을 반영했다. 스킬 YAML·이름·본문·링크와 문서 명령/링크 및 diff check 통과. Python skill validator는 PyYAML 부재로 실행 불가하여 설치 없이 기존 js-yaml로 형식·참조를 확인했다. 정상 pre-commit의 Clinic/Lab/Admin 타입 검사 통과. 실제 env CLI·등록·복원·배포는 실행하지 않았다.
- 정상 pre-push의 3서비스 lint·DLOS guard·coverage 검사가 exit0으로 끝났고 기존 lint 경고는 남는다. `5cbac9f82d17d0956347403c8371f77b321b31c0`을 기존 SSH 경로로 push했고 local/remote/PR head 일치·clean을 확인했다. 기존 Draft PR #4713(base master, `DRAFT` label, `[WIP] ` 제목)을 유지한다. master 병합·GitHub 설정 변경·배포·env 추적 해제는 하지 않았다. 다음은 사용자가 요청하면 두 사용법을 안내하거나 기존 미검증 범위/전환을 재개한다.

## 이전 기준 — 2026-10-16 FE 범위 보완·검증·푸시 완료, Draft PR #4713에서 다음 전환 대기

아래 이전 이력의 Eximbay 차단·Medit 제외·PRD 불허·구현 미착수 표현은 현재 기준이 아닙니다. **기존 FE 값·변수명·서비스 동작을 보존하고 보관·공급 위치만 옮깁니다. 준비 구현과 운영 전환은 별개이며, env 9개는 아직 Git에서 관리합니다.**

### 짧은 현황 브리핑

- 코드: 별도 `feature/DL-16821`에 완료했으며 master 미병합, Draft PR4713 유지.
- GitHub 설정: Variables·Secrets 등록 완료. 2026-10-16 확인한 master/develop/stage/release 배포 코드는 새 환경·Secret을 참조하지 않아 이번 등록이 기존 서비스 동작을 바꾸지는 않는다. 연결 코드는 별도 브랜치에 있다.
- 남은 일: 회의에서 Notion 공유 → 사용자 재개 후 Docker·팀원 설정 사용·복구 검증 → 기존 env Git 추적 해제·실제 전환. 그때까지 추가 변경 없이 대기한다.

### 확정 범위와 승인

- 사용자는 이번 일을 FE 단독 env 분리로 재확정했다. 신기능·BE API·결제 로직·배포 체계 개편을 추가하지 않는다. 애매한 구현은 Codex가 적합한 방식으로 정하며 기존 팀 정책을 다시 받아오라고 요구하지 않는다.
- 코드·새 GitHub 설정·문서·설치 없는 검증·커밋·푸시·Draft PR·Jira·메모리까지 승인했다. 실제 배포·merge·운영 전환·env 추적 해제·키 회전·Git 이력 재작성·실계정 쓰기 E2E는 이번 마감 범위가 아니다. 다음 단계는 사용자가 재개할 때 함께 진행한다.
- Docker/Colima 설치는 사용자가 보류했다. Vercel은 전체 프로젝트 필수가 아니라는 사용자 설명에 따라 키 참조는 조사했지만 Dashboard·미리보기 성공을 완료 조건으로 추가하지 않았다. Vault·Infisical 도입은 없다.
- Eximbay 서버 서명 변경을 선행 조건으로 요구했던 이전 판단은 철회했다. Eximbay·Medit 기존 값 모두 private build 입력으로 보존한다. Secrets 보관만으로 기존 브라우저 노출이 사라지지는 않으며 이 개선은 별도다.

### Git·PR와 작업 위치

- 제품 worktree: `/Users/parkjongsun/Repository/dentlink-client-env-management`, 브랜치 `feature/DL-16821`.
- 기준 master: `8772d68825cac6e23792d86a715153a67dc71078`. 준비 커밋 `6cca7323d`, 환경 표시 보완 `c1f424d06`, 외부 공급 연결 `89b051664`, 최신 **`8d29f043ee367556a24c3803f5e48212b49d0e10`** (`fix: 환경설정 전달 명령의 터미널 종료 처리`). 정상 commit/push와 원격 SHA 일치·clean 확인.
- [Draft PR #4713](https://github.com/Innvoaid/dentlink-client/pull/4713), base master / head feature/DL-16821. 비교용 Draft 유지, 이 대화에 첨부. 제목·본문을 최종 FE 범위·검증·남은 전환 항목 기준으로 갱신했다. CI 상태와 사람 리뷰·실제 배포 증거를 구분한다.
- 기존 checkout `/Users/parkjongsun/Repository/dentlink-client`는 `feature/DL-16796` / `3aac1dff0005706e78015cb5f23f255712696911` clean으로 보존했다. 다른 기능 worktree 변경 없음.
- 작업 폴더는 일반 `git worktree add`로 생성했다. 조정 폴더가 Git repo가 아니어서 managed 생성은 실패했으므로 Codex managed worktree로 가정하지 않는다.
- HTTPS OAuth에는 workflow push scope가 없어 기존 동일 사용자 SSH 인증으로 이번 push만 `git -c remote.origin.pushurl=git@github.com:Innvoaid/dentlink-client.git push origin feature/DL-16821`을 사용했다. 권한 확대·영구 remote 변경·hook 우회 없음.

### 구현과 GitHub 설정

- manifest는 기존 9개 env의 105개 변수명을 분류한다. 공개 빌드·서버 설정, 빌드 비공개(build-secret), 서버 비밀값, E2E 설정·비밀값을 구분한다. 실제 값은 새 코드·문서·예제에 추가하지 않았다.
- 새 GitHub Environment 9개와 공개 Variables 238개를 준비했다. admin dev/stage/prd=20/20/19, clinic=34/36/38, lab=24/24/23. 페이지네이션 포함 조회로 원본과 일치 확인. 빈 선택값은 등록하지 않는다.
- 이번 후속에서 **새 Environment Secrets 5개**를 추가했다: Clinic dev/stage/prd의 `DENTLINK_BUILD_ENV` 각2키, Clinic dev/stage의 `DENTLINK_E2E_ENV` 각47키. 기존 env 값과 환경·종류 헤더를 stdin으로 저장했다. 성공·메타데이터 확인이며 Secrets 원문은 재조회할 수 없고 실제 CI 소비는 미검증이다.
- 기존 Repository Secrets22/Variables0·기존5환경·ECS 공급은 변경하지 않았다. 새 환경 생성 전 기존 원격 branch tip270개/workflow3647개에서 같은 환경 이름 미참조 확인. 새 설정을 쓰는 코드는 작업 브랜치에만 있으며 기존 운영 브랜치에서 소비하지 않는다.
- 로컬 명령은 `pnpm env:pull clinic dev` 형식이다. `pnpm env pull`은 pnpm 자체 명령과 충돌한다. Node20.12+·pnpm8.6.9·gh·Variables 읽기 권한 필요.
- `pull/diff`: GitHub 공개 설정을 `.env-management/public/<scope>.json`으로 받거나 변경 키만 확인. `bootstrap/import`: 기존 private 값을 `.env-management/private/<scope>.build.env`, `.runtime.env`, `.e2e.env`로 분리·수신. PRD도 기존 권한 범위 내 준비·복원 가능하며 배포를 실행하지 않는다.
- `prepare`: 공개+build+runtime으로 `.env-management/generated/<scope>.env` 초안 생성, E2E 제외. `apply`: env Git 추적이 남아 있으면 차단. 전환 후 dev/stage는 `.env.development`, prd는 `.env.production`에 적용한다. `.env.local`·개인 수동 수정·기존 파일 보호와 대상별 상태 기록 유지.
- `ci-private`: Secrets 원문은 `DENTLINK_ENV_PRIVATE`로만 받고 scope/kind/필수 항목 검증 후 파일 생성, 값 비출력. Clinic build는 Eximbay·Medit2키를 요구하고 Admin/Lab은 헤더만 있는 build 파일을 쓴다. build에는 public-build+build-secret만 전달하며 runtime/E2E 제외.
- `env:pack/unpack`: Node 기본 crypto의 AES-256-GCM+scrypt, 숨김 TTY 비밀번호(12자 이상·pack재입력), 환경 인증·크기 제한·전체 사전검사·symlink 거부·0600·기존 파일 보호/명시적 --replace·부분 실패 복구. 있는 private 종류만 묶고 빠진 종류 안내. 파일은 기존 팀 DM, 비밀번호는 별도 통화·대면 전달. 실제 DM 전송은 하지 않았다.
- 기존9개 배포 workflow/Dockerfile의 설정 공급 연결을 변경했다. job별9Environment, public JSON+build secret BuildKit mount, 설정 revision+run_id+attempt 캐시 분리·파일 cleanup. 기존 triggers·이미지 이름/태그·AWS/S3/ECS 대상·runtime secrets·Slack 단계 보존. 배포 체계/CDN 정책 개편 없음.
- Clinic DEV/STG 후속 E2E·수동STG E2E는 환경별 public+E2E Secret을 사용한다. 수동 checkout_ref에서 새 loader가 없고 legacy `.env.staging`이 있으면 기존 경로 유지; 둘 다 없거나 새 설정 검증 실패는 명확히 실패한다.
- 수동 비배포 `web_env_validate.yml`/`Dockerfile.web`은 이미지 publish 없이 검증하도록 준비했지만 실행하지 않았다. 여기만 build network 차단, 실제 배포 Docker의 기존 네트워크 동작은 유지했다.
- `.env*`·private 폴더·암호화 `.envbundle`은 새 Docker context에서 제외하고 Git ignore 추가. 기존 tracked env9개 내용·추적은 그대로다. 제품 UI·업무/결제 코드 수정 없음.

### 확인한 검증 / 확인하지 않은 범위

- 최종 환경설정 **74/74**, E2E 실행 도구 **220/220**, E2E 타입 검사 통과. 최종 전체 diff check 통과. 정상 pre-commit Clinic/Lab/Admin 타입, pre-push3서비스 lint·DLOSguard6·shared configs21/hooks32·coverage 변화0 통과. 기존 lint 경고는 남는다.
- 실제 TTY에서 pack/unpack 완료 후 명령이 종료되지 않는 문제를 발견했다. CLI finally에서 stdin.pause로 수정하고 Node child-process 회귀검사와 실제 PTY 합성검사에서 양쪽 exit0·3종 내용 일치·0600·비밀번호/값 비출력을 확인했다. 실제 팀원 전달과는 별개다.
- 독립 검토에서 수동STG E2E의 과거 ref 호환 결함을 발견해 수정하고, 실제 shell fixture로 새 loader 우선·기존 env fallback·둘 다 없음·검증 실패 시 우회 금지를 검사했다.
- 실제9환경 공개값을 GitHub에서 받아 private와 합친 전체 키·값이 원본과 모두 일치했다. 앱 초안은 E2E 항목만 제외하며 그 외 값은 일치한다. CLI 실제값 검증은 Git 제외 위치에서만 수행했다.
- 외부 네트워크를 차단한 별도 소스 복사본·macOS Node24.4.1에서 Admin/Lab 및 후속 Clinic DEV native 빌드 성공. 실제 env 파일 없이 외부 공급으로 빌드했다. 각 standalone 로그인 페이지·로컬 JS HTTP200, 인증 이후 업무 동작/CDN 확인은 아님.
- Clinic standalone 파일5474개 검사에서 실제 env 파일0·대상 runtime/E2E 비밀값 일치0. Eximbay 등 기존 browser build 값은 이 비노출 주장에 포함하지 않는다. 이전 Admin/Lab도 같은 범위의 파일/비밀값 격리를 확인했다. 새 코드 추가분에서 기존 비밀값 일치0.
- DEV/STAGE E2E 목록 각각109개 수집·오류0. 합성 계정·외부 네트워크 차단으로 test body/global setup·실계정 쓰기는 실행하지 않았다.
- Vercel 전용 키는 tracked env9개·소스/workflow·manifest·Repository 및14Environment 메타데이터에서 발견하지 못했다. 조직 수준 설정·Vercel Dashboard 확인으로 확대하지 않는다.
- Docker/Alpine 빌드·실계정 E2E·결제·다른 팀원의 실제 권한/설정 수신·운영 전환/복구는 미검증이다. 새 수동 비배포 workflow도 미실행이며 설치를 우회하지 않는다.
- 검증 JSON·로그는 `.env-management/audit/`에 Git 제외·0600으로 보존한다. 원래 빈 server-secret 값을 임의로 채우거나 계정 유효성을 새로 보장하지 않는다. 격리 native 복사본과 합성 전달 fixture를 삭제했고 제품 worktree/보고서는 보존했다.

### Jira·Notion과 다음 시작점

- 사용자는 2026-10-16 마감 후 **회의에서 정리된 Notion 문서를 먼저 공유하고, 그 이후 후속 작업을 진행**한다고 확정했다. 현재 회의 전 준비 범위는 완료이며 회의 결과·사용자 재개 지시 전까지 코드/GitHub 추가 변경·검증 확장·배포를 진행하지 않는다. 기존 Draft PR·worktree와 등록된 새 설정은 보존한다.
- 전체 목차: [DL-16818](https://innovaid.atlassian.net/browse/DL-16818), 진행 중. 조사·회의 [DL-16819](https://innovaid.atlassian.net/browse/DL-16819) 완료 유지. 구현 [DL-16821](https://innovaid.atlassian.net/browse/DL-16821) Frankie·진행 중, 최종 댓글44467로 결과·Eximbay 선행 조건 정정·다음 단계 기록. 상위 카드 중복 댓글 없음.
- Notion3개 모두 `DEV Team / Development Documents`, data source `26366594-1ec5-423c-b7c3-35abe1e047f2` 같은 계층이며 상단DL16818 링크 유지:
  1. [현재 상황과 개선안](https://app.notion.com/p/3face072e82f814b9a6ceaa36e5638af)
  2. [사용·운영 가이드](https://app.notion.com/p/3fbce072e82f81119615e41b7c1195eb)
  3. [로컬 설정·갱신 따라하기](https://app.notion.com/p/3fbce072e82f81578c76d458c0a01c22)
- 운영/따라하기에 FE 기존값 보존·PRD 준비·pack/unpack 실제 명령·파일/비밀번호 분리 전달·갱신·전환 전 apply차단을 반영하고 read-back했다. 개요 사용자 본문·댓글은 불필요하게 재작성하지 않았다. 짧더라도 gh로그인·실제 명령을 빼지 않고 개념/운영과 따라하기를 분리한다.
- **지금 사용자나 팀에 반드시 새로 물어올 정책·BE 계약은 없다.** 다음은 사용자 재개 후 Docker 사용 가능한 환경에서 이미지 검증 → 실제 팀원 설정 수신/권한·필요한 계정 실행·복구 확인 → 팀 적용 안내와 env Git 추적 해제/전환이다. 실서버 쓰기·배포 승인은 그 단계에서 유지한다.
- 기존 SHA 기반 이미지 태그/Clinic CDN 덮어쓰기 제약은 사실로 남지만 이번 이관에 배포 체계 개편을 추가하지 않는다. 전환 시 기존 방법으로 돌아갈 경로를 확인한다. 키 회전·Git 과거 이력 정리·Eximbay 서버화는 별도 개선이며 env 추적 해제만으로 과거값이 삭제되지는 않는다.
- 다음 재개 시 개인 context·제품 원격을 갱신하고 PRbase/head/draft,9환경 값·Secrets 이름과 미배포 상태, 기존 tracked env9개를 다시 확인한다. 지금은 작업 종료·대기이며 자동 배포·모니터링·계속 실행은 하지 않는다.

## 이전 상태 — 2026-10-16 착수 전 최종 검토·브리핑 완료, 실제 구현 미착수

- 사용자는 실제 작업과 플래닝을 전적으로 맡았고, 두 Notion 문서는 아직 팀에 공유하지 않았으며 화요일에 공유할 예정이라고 밝혔다. 회의 전에는 **1 변수 분류 → 2 별도 브랜치 코드 작업 → 3 새 GitHub 환경/값 준비**를 진행할 수 있고, **4 배포 없는 기술 검증 → 회의 의견 반영·사용자 결과 확인 → 실제 운영 전환**으로 구분해 설명했다. 수동 QA 전체를 사용자에게 요구하는 뜻이 아니며 기술 검증은 Codex가 수행한다.
- 최신 요청은 진행 전에 필요한 문서·코드·GitHub 상태를 최종 검토하고 간단한 단계별 브리핑을 달라는 것이다. **이번 턴은 검토와 문구 보완만 수행했다.** 새 작업 브랜치/환경/값 생성, 제품 코드 변경, 테스트·빌드·배포 실행은 하지 않았다.
- 최종 읽기 확인: 원격 master `8772d68825cac6e23792d86a715153a67dc71078`, tracked env9개·변수명105개 동일. master/develop/stage 각15개 workflow에서 `environment:`/`vars` 참조 없음. GitHub Repository Variables0, 기존 Environment5개 유지, 현재 인증 admin/push/pull=true. 기존 checkout은 다른 작업 `feature/DL-16796`/`3aac1dff...`로 clean이고 다른 worktree도 사용 중이므로 실제 구현은 별도 checkout/브랜치에 격리한다.
- 기존 개요와 최신 가이드의 위치·본문·방향을 재확인했고 모순되는 운영 원칙은 없었다. 가이드 끝에 **별도 브랜치의 코드·새 GitHub 설정 준비 → 배포 없는 검증 → 팀 공유 후 운영 전환**, 준비 단계의 기존 설정/배포 유지를 짧게 보완하고 read-back했다. 기존 개요 본문·댓글은 수정하지 않았다.
- 준비 단계가 기존 서비스에 영향을 주지 않으려면 기존 Secrets/Variables/Environment/보호규칙을 수정·삭제하지 않고, 새 이름의 참조/충돌을 생성 직전에 재확인해야 한다. 별도 브랜치도 실제 배포 workflow를 실행하면 격리되지 않는다. 검증은 AWS 배포 자격·ECR push·S3 업로드·ECS 배포 없이 빌드하며, 기존 workflow_dispatch와 배포 태그를 검증용으로 사용하지 않는다. 공용 DEV API 쓰기·실계정 E2E도 별도 범위로 둔다.
- 준비 착수를 위해 사용자/팀에 다시 물어올 질문은 없다. 로컬 비밀값 전달 경로는 1~3에서 구체화할 구현 항목이며 외부 도구 채택을 확정하지 않는다. Eximbay와 공개 여부 미확인 키는 Variables 등록 대상으로 처리하지 않고 개별 확인/협업 항목으로 유지한다. 이들 항목이 실제로 해결되기 전 전체 이관·운영 검증 완료로 보고하지 않는다.

- 사용자가 재개하며 **기존에 정해진 로컬·접근·운영 정책은 없고, 이번 세션에서 Codex와 함께 정해 팀에 가이드하는 것이 목적**이라고 답했다. 기존 공유 수단/정책을 사용자에게 다시 받아오라고 묻지 않는다. Codex가 구체안을 제안하고 실제 권한·비용·접근 불가능한 키 상태 등만 필요한 시점에 좁혀 확인한다.
- 사용자는 실제 변경보다 가이드를 먼저 작성하도록 요청했다. **기존 문서와 같은 위치에 별도 문서를 만들며 쉽고 읽기 편하게 작성**하는 것이 현재 완료 범위다. 제품 코드·설정·배포는 변경하지 않았다.
- 신규 [웹 환경변수 관리: 사용·운영 가이드](https://app.notion.com/p/3fbce072e82f81119615e41b7c1195eb)를 생성했다. 기존 문서와 동일한 `DEV Team / Development Documents`, data source `26366594-1ec5-423c-b7c3-35abe1e047f2`의 별도 페이지이며 Tags는 FE/Guides다. 생성 후 부모·제목·표·토글·본문을 read-back으로 확인했다. 기존 문서의 수정 시간과 내용은 그대로다.
- 사용자는 회의 메모에 대한 답변이 아니라 **팀의 최종 사용법**을 원하며 긴 설명을 줄이라고 했다. 최신 문서는 약1814자로 **1. 운영법 / 2. 개념·설정 방법** 두 부분으로 정리했다. 운영에는 최초 설정·갱신·공통 변경·배포·공동 관리, 개념에는 Variables/Secrets·NEXT_PUBLIC·기존 저장소의 서비스별 환경 공간·GitHub 메뉴 위치·Docker 전달 흐름·로컬 비밀값 전달 경계를 담았다. 수정 후 두 섹션·본문·같은 위치를 read-back했다.
- 사용자는 Vault·Infisical 링크를 **참고 자료로만 준 것이며 실제 도입 의사가 아니었다**고 정정했다. 기존 문서에 넣었던 Infisical 추천·요금제·도입·연동 설명을 모두 제거했다. 공개 설정 GitHub Variables와 기존 서버 Secrets 유지가 현재 방향이며, 특정 외부 도구를 채택한 것으로 진행하지 않는다. 신규 가입·연동·비용 지출도 없다.
- 개념과 사용·운영 흐름은 문서화했지만 실제 실행 명령·설정은 구현·검증 후 추가해야 한다. GitHub Secrets 원문은 로컬로 내려받을 수 없으므로 개발·테스트 비밀값의 별도 전달 경로를 실제 구성 시 정하고 연결해야 한다는 한 줄을 남겼다. 현재 사용자에게 기존 정책을 다시 정해오라고 요구할 질문은 없다. 외부 키 상태/Eximbay 서버 처리 검토는 실제 적용 때 마무리하며, 모든 운영 문제와 실행 검증이 끝났다고 설명하지 않는다.
- 이번 문서 작성에서 원격 master `8772d68825cac6e23792d86a715153a67dc71078` 및 tracked env9개가 동일함을 다시 확인했다. GitHub·Next·Infisical 공식 자료를 재확인했고 제품 실행·빌드·배포 테스트는 수행하지 않았다.
- **팀은 GitHub 기반 환경변수 관리로 전환하기로 했다.** 사용자의 “깃에서 관리”는 이전 제안의 GitHub Variables/Secrets를 활용한다는 문맥이며, 실제 env 파일을 계속 Git에 커밋한다는 뜻으로 해석하지 않는다.
- 관리 주체는 별도 개인 담당자가 아닌 **팀 공동 관리**다. 회의 후 작업하면서 전환 시점을 맞춘다. 담당자 지정이나 적용 여부를 다시 질문하지 않는다.
- 이전 회의 메모의 의도 파악·운영 가이드 작성은 완료했으며 현재는 실제 착수 전 최종 검토 단계다. 제품 코드·env 파일·GitHub Variables/Secrets·권한·배포 변경은 이번 검토에 포함하지 않았다.
- 기존 [팀 공유용 Notion](https://app.notion.com/p/3face072e82f814b9a6ceaa36e5638af)은 방향 설명 문서로 유지했다. 회의 질문에 답하는 운영안은 위 신규 문서에 작성했으며, 기존 본문·댓글은 수정하지 않았다.
- “조사가 끝났는지”라는 사용자의 질문은 회의 메모의 내용·의도를 충분히 이해했는지에 관한 것이었다. 회의 의도는 이해 완료이고 추가 해석 질문은 없다. 이를 제품 검증·구현 완료 질문으로 바꾸지 않는다. 앞서 “로컬 최초 세팅만 남았다”고 좁혀 설명했던 것은 부정확했다. 환경 분리·동기화·설정 변경 반영까지 운영 상세로 구체화해야 하며, 기술 선택 전체를 사용자가 다시 회의에서 정해 와야 하는 선행 조건으로 제시하지 않는다.

### 회의 메모의 의미

1. GitHub 기반 적용은 결정됐으므로 실제로 어떻게 운영할지 정한다.
2. 팀원이 클라우드 설정을 로컬로 가져오기·갱신하기, 로컬 변경을 공통값에 반영하기, 개인 설정 보존과 동기화 기준을 정한다.
3. 기존 변수명을 유지하면서 dev/stage/prd 및 Admin/Clinic/Lab에 올바른 값을 전달하는 방법을 설명한다.
4. `clinic_prd_build_and_deploy.yml`의 기존 `secrets.*` 사용을 기준으로 Variables/Secrets 역할과 등록 위치를 정한다.
5. 현재 env 항목의 실제 용도·공개 가능성을 검토한다. `NEXT_PUBLIC_`만 보고 안전하다고 분류하지 않으며 Variables 저장 여부와 접두사 정책을 구분한다.
6. Vault·Infisical은 팀원이 과거 인턴 경험에서 소개한 참고 후보다. 회사의 현재 사용 도구나 신규 도입 확정으로 해석하지 않는다.

### 2026-10-16 읽기 전용 조사 결과

- 개인 컨텍스트는 pull 후 읽었다. 제품 checkout은 다른 기능 `feature/DL-16796` / `3aac1dff0005706e78015cb5f23f255712696911`로 clean이어서 변경하지 않고 fetch한 고정 `origin/master` **`8772d68825cac6e23792d86a715153a67dc71078`**의 Git 객체를 조사했다.
- Git 추적 env는 9개, 중복을 제외한 변수명은 **105개**이며 그중 95개에 `NEXT_PUBLIC_`가 붙어 있다. 값 원문은 출력·기록하지 않았다. 소스 정적 분류이며 실제 키 유효성·운영 번들·서비스 콘솔 제한 설정을 검증한 것은 아니다.
- 공개 설정 관리 후보는 API/CDN/서비스 URL·제목·기능 설정이다. Stripe 값은 publishable prefix임을 값 비노출로 확인했고 브라우저 `loadStripe` 경로와 대조했다. Google Maps·Amplitude·Datadog RUM의 브라우저용 키/토큰은 서버 인증키와 구분한다. 실제 도메인·API 제한은 아직 확인하지 않았다.
- Clinic DEV/STG에는 각각 nonempty E2E password 항목 7개가 있다. 접두사는 `NEXT_PUBLIC_`지만 테스트 비밀값이므로 제품 빌드 입력과 분리해야 한다. 직접 사용처는 E2E/Node 측에서 확인했으며 이것만으로 실제 브라우저 유출을 단정하지 않는다.
- `NEXT_PUBLIC_EXIMBAY_SECRET_KEY`는 `clinic/src/lib/Card/eximbayCardRegistrationParams.ts:90`에서 fgkey를 만들며 웹 팝업과 WebView redirect 코드에서 호출한다. 공식 v2.3 가이드는 해당 secretkey의 비밀 유지를 요구한다. Variables로 이동할 대상이 아니고, Secrets에 보관해도 현재 브라우저 소비 경로를 유지하면 비밀이 되지 않는다. 서버 서명 전환·실제 키 유효성/노출·회전 판단은 별도 검토 대상으로 둔다. 결제 코드나 키를 임의로 변경하지 않는다.
- `NEXT_PUBLIC_MEDITLINK_KEY`의 직접 사용처는 찾지 못했고 관련 Medit 페이지의 ID 참조도 주석 코드다. 미사용 후보이지 삭제·공개 가능성이 확정된 것은 아니다. 코드에 있으나 현재 env에 없는 선택 설정도 있어, env 이름 목록만으로 필수항목을 확정하지 않는다.
- 현재 DEV는 `develop` push, STG는 `stage` push 또는 `stg/{제품}/**` tag, PRD는 `prd/{제품}/**` tag를 중심으로 실행되며 9개 workflow 모두 수동 실행이 있다. 제품 경로 필터가 있다. DEV/STG Docker는 대상 env를 `.env.production`으로 옮겨 build한다. Clinic STG/PRD는 한 빌드 결과를 서울·오하이오에 배포한다.
- 제품 배포 workflow 9개에 `job.environment` 선언은 없다. `clinic_prd_build_and_deploy.yml:205-206`의 `JIRA_API_TOKEN` 등 GitHub Secrets→ECS 공급을 확인했다. AWS/Slack 인증 Secret과 앱 서버 Secret의 역할을 구분하며 기존 공급을 임의로 대체하지 않는다.
- 당시 GitHub 조회: Repository Variables 0개. 기존 Environments 5개(`develop`, `Preview`, `Preview – dentlink-client-ui`, `Production`, `Production – dentlink-dlos`)는 Variables/Secrets 0개였다. 제품용 환경으로 간주해 덮어쓰지 않는다. 현재 `gh` 인증의 저장소 Admin 권한은 확인했지만 팀원 전원의 권한까지 확인한 것은 아니다.
- workflow가 참조하는 `S3_AWS_ACCESS_KEY_ID`, `S3_AWS_SECRET_ACCESS_KEY`, `OPENAI_IMAGE_MODEL`은 repository Secret 목록에 없었다. 조직 scope 조회가 불가해 전체 부재·배포 고장으로 단정하지 않는다.
- GitHub Variables는 환경별 CLI/API 조회가 가능하지만 Secrets API는 값 재조회가 불가능하다. Secrets를 Actions 로그/artifact로 내보내 로컬에 전달하는 우회는 사용하지 않는다.
- 설정값만 바꾸고 재빌드할 때 현재 `{env}-${github.sha}` 이미지 태그가 재사용된다. Clinic CDN 업로드는 `${PACKAGE_VERSION}/_next/static --delete`여서 같은 버전의 이전 정적 파일이 제거될 수 있다. 설정 revision·빌드 식별자·이전 정적 파일 보존까지 복원 설계에 포함해야 한다. 현재 동작을 변경하거나 배포 복원을 검증하지 않았다.

### 조사에 따른 운영안 — 제안이며 아직 구현·팀 확정 전

- **서비스×환경 9개 GitHub Environment**로 현재 9개 env와 대응시키는 안을 우선 제안한다. 예시 `clinic-dev`, `clinic-stage`, `clinic-prd` 등. 기존 `NEXT_PUBLIC_API` 같은 이름을 그대로 각각 저장하며 앱 코드에 DEV_/STAGE_를 붙이지 않는다. 각 workflow가 해당 환경을 명시적으로 선택하고 빌드·배포 단계에 값을 연결한다. Region별 설정은 현재 동일하므로 지역까지 추가 분리할 근거는 없다.
- GitHub Variables/Secrets는 보관 방식, `NEXT_PUBLIC_`는 Next의 브라우저 노출 규칙으로 서로 다른 기준이다. Variables에 넣기 위해 PUBLIC을 추가하지 않는다. 서버 일반 설정에는 PUBLIC이 필요하지 않고 실제 서버 인증키는 Secrets를 사용한다.
- 공개 설정은 **GitHub를 원본으로 하는 로컬 단방향 사본**을 기본으로 한다. 로그인→서비스/환경 선택→필수항목 검사→ignored env 생성, 변경 키 확인→명시적 갱신, 개인 override 보존을 지원한다. 공통값 변경은 대상·키를 명시해 GitHub에서 변경하고 팀에 알린다. 완성된 개인 env 전체의 자동 업로드/자동 삭제는 제안하지 않는다.
- 기존 `.env.development/staging/production` 이름을 생성 파일로 유지하는 안이 소비부 변경을 줄인다. Next 개인 override와 별도로 E2E는 선택한 환경만 명시적으로 로딩하도록 맞춘다. `.env.staging` 다운로드는 Next 실행 환경이 저절로 바뀌는 뜻이 아니며, `NODE_ENV=staging`으로 처리하지 않는다. DEV 기본·STG QA 선택·PRD 명시 선택은 제안 운영 규칙이다.
- 로컬 개발·테스트 비밀값의 전달 경로는 실제 구성에서 구체화한다. 사용자가 소개한 외부 도구는 참고 자료이며 특정 도구 도입을 전제로 하지 않는다. 같은 값을 로컬/CI에서 쓰면 원본과 전달 방향을 하나로 정한다.
- Variables 저장만으로 서버가 갱신되지 않는다. 로컬 갱신/재시작, 공개 빌드값 변경 후 재빌드·배포, 현재 runtime Secret 변경 후 배포를 구분한다. 설정만 바뀐 빌드의 캐시·image 식별·정적 파일 보존·복원을 설계한다.

### 착수 전 정보·운영 정책 점검 이력 — 기존 정책 없음은 위 재개 답변으로 확인

- 사용자는 현재까지의 내용을 메모리한 뒤, 실제 작업을 시작한다고 가정했을 때 필요한 정보·정책·질문을 먼저 모두 검토하려고 한다. **이번 요청도 구현 착수 지시가 아니다.** 팀 답이 필요한 사실/정책과 Codex가 설계할 기술 사항, 운영 적용 전에 확인할 조건을 구분해 설명한다.
- 이미 확정된 GitHub 기반 방향·팀 공동 관리·진행 중 전환 일정 조율을 다시 묻지 않는다. 아래 기본안은 제안이며 사용자/팀이 승인한 세부 정책으로 기록하지 않는다.

**팀 확인이 필요한 정보/범위**

1. **로컬 개발·E2E 비밀값의 공유 경로:** 현재 Git 밖에 팀이 사용하는 승인된 보관·공유 수단이 있는지 확인한다. 있으면 재사용한다. 없으면 Codex가 필요한 기능·비용·운영 부담을 비교한 구체안을 제시하고 신규 서비스/비용 허용 여부를 확인한다. Vault/Infisical 중 하나를 사용자가 근거 없이 먼저 고르도록 요구하지 않는다. GitHub Secrets에서 원문을 내려받는 방식은 불가능하므로 이 공급 경로는 실제 로컬 연동 완료 전에 필요하다.
2. **접근 범위:** DEV/STG/PRD별로 일반 설정을 읽고 수정할 사람과 비밀값을 받을 사람의 범위를 확인한다. 팀 공동 관리는 모든 운영 비밀값을 모든 PC에 배포한다는 뜻이 아니다. 제안은 개발·테스트에 필요한 값만 로컬에 제공하고 운영 비밀값은 기존 운영 접근 범위를 유지하는 것이다. GitHub의 실제 권한 구조와 팀원 접근 가능 여부는 Codex가 확인하고 맞춘다. 별도 단독 담당자 지정을 다시 요구하지 않는다.
3. **코드만으로 확정할 수 없는 키의 검증 접근:** 필요한 외부 서비스 콘솔을 직접 읽을 수 있는지, 불가하면 해당 연동을 아는 팀원의 확인을 받을 수 있는지 확인한다. 실제 키 종류·사용 여부·제한 설정이 대상이다. 특히 Eximbay는 브라우저 서명 경로와 공식 비밀 유지 요구를 이미 확인했으므로 단순 Variables/Secrets 이관으로 해결했다고 처리하지 않는다. 서버 측 서명 등 별도 보완이 필요하면 구체적 범위와 BE 협업을 제안한다. 미확인 키 하나를 이유로 다른 설정의 설계/이관 준비 전체를 중단하지 않는다.

**Codex가 제시하고 합의할 운영 기본안**

- **로컬 동기화:** GitHub 공통 설정을 원본으로 두고 명령으로 명시적으로 내려받는다. 실행 전 차이/누락을 확인하고 개인 override는 보존한다. 개인 env 전체 자동 업로드나 조용한 덮어쓰기는 하지 않는다. 항상 자동 최신화가 꼭 필요한 팀 요구가 없다면 이 기본안으로 상세 설계한다.
- **공통값 변경·운영 반영:** 공통값은 대상 서비스/환경과 키를 명시해 변경하고 팀에 알린다. PRD는 기존 배포 확인 절차를 유지하며 새 승인 단계를 임의로 만들지 않는다. 기존 설정 변경 절차나 특별한 제약이 있는지만 확인한다. Variables 수정만으로 재배포되지 않으므로 변경 알림·재빌드/배포·복원 절차를 함께 문서화한다.

**질문으로 넘기지 않고 Codex가 할 일 / 적용 전 검증**

- 서비스×환경 매핑, 기존 변수명 유지, 공개/비밀/테스트 구분표, env 생성·확인·갱신 명령, Docker/CI/E2E 연결, 개인 설정 보존, 빌드 식별·캐시·복원 방식은 조사에 근거해 구체적으로 설계한다. 사용자가 이 구현 방법을 다시 회의에서 결정해 올 필요는 없다.
- 구현 요청을 받으면 기존 Git/설정/권한 상태를 새로 확인한다. 공급 경로 준비 → DEV 검증 → STG 검증 → 합의된 PRD 전환을 제안하며, 단계별 실제 실행은 승인 범위를 따른다. 기존 clone 갱신 시 추적 해제로 로컬 파일이 사라질 수 있는 상황도 백업/재생성 안내와 fresh checkout 검증에 포함한다.
- 실제 키 유효성·운영 상태를 확인한 결과 회전이나 Git 이력 정리가 필요하면 영향과 구체 조치를 별도로 제안한다. Git 추적 해제만으로 과거 이력이 삭제되거나 이미 공개된 비밀값이 보호됐다고 주장하지 않는다. 이력 재작성·키 회전은 이번 요청으로 실행하지 않는다.
- 위 질문 전부의 답을 받아야 설계나 구현 준비를 시작할 수 있다는 뜻은 아니다. 공급처·접근 범위는 해당 값의 실제 연결 전에, 외부 키 판정은 해당 항목 이관 전에, 운영 반영·복원 확인은 운영 전환 전에 필요하다. 이번에는 개인 메모리만 수정하고 Notion·제품 코드·GitHub 설정·배포는 유지한다.

**사용자에게 최종 설명한 질문 구분과 재개 지점**

- 사용자는 질문만 나열하지 말고, Codex가 대안을 제시할 수 있는 항목과 사용자/팀의 실제 답이 필요한 항목을 구분해 달라고 했다. 현재 검토 범위에서 제안할 방법 자체가 없는 항목은 없다. 다만 제안은 기존 운영 사실이나 팀의 의사결정을 대신하지 않는다.
- 로컬 공유 수단이 없다면 도구·사용법·비용을 비교해 제안할 수 있다. 기존 수단 유무는 아직 답변받지 않았으며, 신규 서비스/비용이 발생하면 구체안을 제시한 뒤 도입 여부를 확인한다.
- 환경별 접근 범위의 기본안을 제안할 수 있지만 실제 허용 범위는 팀 확인이 필요하다. 로컬 동기화·공통값 변경은 위 기본안으로 설계할 수 있고, 반드시 따라야 하는 기존 팀 규칙이 있으면 반영한다.
- 키의 용도·공개 가능성은 직접 조사하되 접근할 수 없는 관리 화면의 실제 상태는 팀 확인이 필요하다. Eximbay 등 별도 서버 변경이 필요하면 구체적 영향과 협업 범위를 제시한다.
- 가장 먼저 받으면 유용한 답은 **“Git 외에 이미 사용하는 비밀값 공유 수단이 있는지”**다. 나머지는 사용자 재개 요청 후 구체안을 만들고 실제 결정이 필요한 부분만 묶어 확인한다. 사용자에게 모든 기술 세부를 먼저 결정해 오라고 요구하지 않는다. 이번 대기 요청은 질문에 대한 답이나 세부 정책 승인으로 간주하지 않는다.

### 다음 조치와 남은 확인

1. 회의 메모→조사 근거→추천 운영 규칙으로 운영 상세안을 정리한다. 적용 여부·관리 주체를 다시 묻지 않는다.
2. 변수별 서비스/환경·사용처·공개 가능성·필수/선택·빌드/서버/테스트 소비부·보관 위치 표를 완성한다. 공개 키와 테스트 자격, Eximbay 등 보안 검토 항목을 구분한다.
3. 최초 로컬 세팅·차이 확인·갱신·개인 override·공통값 수정·설정 변경 후 배포/복원을 구체화한다. 파일명·명령·환경 연결의 기술적 선택은 Codex가 제안한다.
4. 기존 로컬/운영 정책이 없으므로 이번에 제안한다는 답변을 받았다. 신규 가이드의 구체안을 기준으로 검토를 이어간다. 외부 키 유효성·Google Maps 제한·Eximbay 실운영 상태 등 코드만으로 확정할 수 없는 사실은 실제 적용 시 필요한 범위만 확인한다.
5. **실제 구현 요청을 받기 전에는 코드·GitHub 설정·권한·배포를 변경하지 않는다.** 구현 시 최신 Git/권한/외부 설정을 재확인하고, 새 공급 경로와 로컬·빌드·E2E 검증 뒤 Git 추적을 해제한다. PR/merge/배포/키 회전/이력 재작성은 해당 승인 범위를 따른다.

### 추가 근거

- [GitHub 환경별 Variables](https://docs.github.com/en/actions/how-tos/write-workflows/choose-what-workflows-do/use-variables#creating-configuration-variables-for-an-environment), [CLI 조회](https://cli.github.com/manual/gh_variable_list), [Secrets 값 조회 불가](https://docs.github.com/en/rest/actions/secrets#get-a-repository-secret)
- [Next 환경변수·브라우저 노출](https://nextjs.org/docs/pages/guides/environment-variables), [Stripe 키 종류](https://docs.stripe.com/keys), [Google Maps 제한](https://developers.google.com/maps/api-security-best-practices)
- [Eximbay 공식 v2.3 가이드](https://developer.eximbay.com/eng/eximbay/pdf/Eximbay_Global_Payment_Integration_guide_kr.pdf)
- [Infisical 프로젝트·환경·로컬 사용](https://infisical.com/docs/documentation/platform/secrets-mgmt/project), [Vault](https://developer.hashicorp.com/vault)

## 이전 상태 — 2026-10-15 본문·댓글 최종 확정, 회의 전 대기 이력

- 사용자 최종 지시: **최종 댓글 내용까지 메모리하고 대기하며, 사용자가 팀 의견을 받은 뒤 다시 진행한다.** 본문과 댓글 3개를 다시 읽어 추가 수정·병합이 필요하지 않음을 확인했다. Notion은 현재 상태를 유지하며 제품 구현·Git 추적 해제·Variables/Secrets 설정·배포는 시작하지 않는다. 자동 후속 작업이나 팀 의견 모니터링도 설정하지 않는다.
- 최종 문서는 **현재 상황 3항목 → 대체안: GitHub 기반 환경변수 관리 4항목 → 선정 사유 3항목 → 개인 사이드프로젝트 참고 예시**로 구성한다. 사용자가 최상단의 '관리안 제안 단계' 안내문, 참고 예시의 프로젝트 이름 소개와 말미 중복 공식 링크 등을 직접 정리한 최신 본문을 유지했다. 안내문 삭제는 구현 승인이나 적용 완료를 뜻하지 않는다.
- 마지막 검토에서 공개 설정/비밀값 구분, 로컬 스크립트의 추가 구현 필요, Render와의 전달 방식 차이가 명확함을 확인했다. Variables 외에 기존 Secrets와 로컬 설정 관리까지 포함하는 안이므로 제목을 **대체안: GitHub 기반 환경변수 관리**로 제안했고 사용자가 승인했다. 최신 문서 본문은 Notion을 기준으로 하며, 아래 조사 이력이나 이전 문구를 되돌려 넣지 않는다.
- [환경변수 문서](https://app.notion.com/p/3face072e82f814b9a6ceaa36e5638af)를 **DEV Team / Docs / Development Documents**로 이동했다. 비교 기준인 [Dentlink 치과 앱 주문 상세 403 오류 조사](https://app.notion.com/p/3f7ce072e82f8110b047f4bb06c829b4)와 같은 data source `26366594-1ec5-423c-b7c3-35abe1e047f2`에 속하는 별도 문서이며, 403 문서 안에 넣지 않았다. 이동 후 부모·제목·기존 URL과 본문 동일성을 read-back으로 확인했다. 개별 팀원 접근 여부까지 시험한 것은 아니다.
- 문서 완료·구현 가능성 설명은 구현 승인과 다르다. 다음 사용자 요청까지 대기하며 추가 문서 수정도 요청이 있을 때만 한다.

- 사용자가 아래 내용을 팀 공유용 최종 요약으로 확인하고 Git 메모리 저장과 Notion 문서 작성을 요청했다. Tom에게 보내는 질문이나 개인 메시지가 아니라 **현재 상황과 개선안을 팀에 공유할 문서**다.
- [웹 환경변수 관리: 현재 상황과 개선안](https://app.notion.com/p/3face072e82f814b9a6ceaa36e5638af)은 처음에는 공유 위치 미지정으로 개인 비공개 초안으로 생성했다. 최종 사용자가 위치를 지정해 위 팀 문서함으로 이동한 상태가 현재 기준이다.
- 작성 직전 원격 master를 fetch하여 `8772d68825cac6e23792d86a715153a67dc71078`과 추적 env9개가 동일함을 재확인했다.
- 최초 문서에 공식 근거·세부 적용 순서·미정사항을 추가해 과하게 길어졌다는 사용자 정정을 받았다. 이후 사용자는 원문을 반드시 그대로 쓰라는 뜻이 아니라, Codex가 판단해 적절하고 쉽게 정리하라고 명확히 했다. Notion은 짧은 현황·개선안 구조를 유지하면서 로컬·CI·Git 추적 해제 등의 표현을 풀어 썼다. 조사 근거와 상세 검토는 개인 체크포인트에 보존한다. 로컬 비밀값 보관소는 여전히 미정이다.
- 사용자의 '선정 사유' 질문은 단순 기능상 장점이 아니라 일반적으로 권장·사용되는 방식인지에 대한 근거를 요구한 것이다. 실제 env Git 제외는 Next.js의 공식 권장에 근거한다. Actions에서 비민감 설정 Variables/비밀값 Secrets 사용은 GitHub가 안내하는 용도다. **Variables를 로컬까지 조회해 사용하는 것이 널리 쓰이는 표준이라고 확인한 근거는 없다.** 로컬 연동은 기존 Actions 구조와 같은 원본 사용을 고려한 프로젝트 맞춤 제안으로 명시했고 별도 env 생성 스크립트가 필요함을 문서에 적었다.
- 선정 사유를 다시 확인해 달라는 후속 요청으로 master `8772d68825cac6e23792d86a715153a67dc71078`의 Actions Docker 빌드와 Secrets→ECS 주입을 재확인했다. Notion에는 '이미 GitHub Actions·Secrets를 쓰므로 공개 설정은 Variables를 우선 추천하며, 별도 설정 관리 서비스 없이 연결할 수 있어 도입·운영 부담이 적다는 판단'을 명시했다. 이는 현재 구조와 범위에 대한 추천이지 업계 사용률이나 절대적 최선에 대한 주장과 구분한다.
- 완료 범위는 조사·제안·문서화다. 제품 코드/env/Git 추적/외부 설정은 바꾸지 않았고 빌드·테스트·배포는 수행하지 않았다. Slack 메시지도 보내지 않았다.

### 현재 팀 공유 요약

**현재 상황**

- Admin·Clinic·Lab의 env9개를 코드와 함께 Git에서 관리하고 있다.
- 로컬 웹 개발 서버 실행·배포용 Docker 빌드·자동 테스트(E2E)에 이 파일을 사용한다.
- 서버 비밀값 일부는 이미 GitHub Secrets → ECS로 별도 공급하고 있다.

**대체안: GitHub 기반 환경변수 관리**

- Git에는 필요한 변수 목록과 설정 방법만 남기고 실제 값은 분리해 관리한다.
- 공개 가능한 공통 설정은 GitHub Variables에서 로컬·CI가 함께 가져오도록 제안한다.
- 서버 비밀값의 기존 공급 방식은 유지하고 로컬 개발·테스트용 비밀값의 공유 경로를 마련한다.
- 기존 실행·배포·테스트가 유지되도록 공급 경로를 먼저 연결하고 검증한 뒤 Git 추적을 해제한다.

**선정 사유**

- 실제 env Git 제외는 설정과 코드 분리 및 Next.js 공식 안내에 근거한다.
- GitHub Variables는 비민감 설정용 공식 기능이다. 이미 사용하는 GitHub Actions·Secrets를 활용할 수 있어 별도 설정 관리 서비스 도입 부담이 적다는 이유로 공개 설정 분리의 우선안으로 추천한다.
- 로컬에서도 같은 원본을 조회하면 설정 불일치를 줄일 수 있다는 프로젝트 맞춤 제안이다. 로컬 env 생성 스크립트 구현이 필요하며, 업계 표준이라고 단정하지 않는다.

### 최종 설명용 댓글 — 본문과 별도로 유지

- 사용자가 구두 설명용 요약을 넣은 곳은 본문이 아니라 **페이지 댓글**이었다. 이후 Codex가 본문 끝에 추가했던 '쉽게 설명하면' 단락은 사용자 정정에 따라 제거하고, 기존 '한줄요약' 댓글에 로컬 관리 내용을 짧은 답글로 남겼다. 원래 본문 복원과 댓글 등록을 read-back으로 확인했다.
- [최종 댓글 스레드](https://app.notion.com/p/3face072e82f814b9a6ceaa36e5638af?d=ed5ce072e82f8336a69183b8148d4197&pvs=42)에 댓글 3개가 있다. 전체 개념 → 로컬 사용/관리 → Variables/Secrets 구분으로 읽히며 기술적으로 수정할 내용은 없다. 마지막 문장은 짧은 핵심 재강조이므로 사용자 요청의 최종 검토에서 병합·축약 없이 유지했다. 설명을 본문에 다시 늘려 넣지 않는다.

1. **한줄요약:** 설정값을 코드와 함께 Git에 올리지 않고, GitHub의 별도 설정 공간에서 관리하자는 겁니다. API 주소 같은 공개 설정은 Variables에 저장하고, 빌드할 때 가져와 넣어서 배포합니다. 비밀키·비밀번호는 암호화해서 보관하는 Secrets에 저장하고, 필요한 서버에 전달합니다. 로컬 개발에서는 필요한 설정을 받아 env 파일을 만들어 쓰되, 그 파일은 Git에 올리지 않습니다.
2. **로컬 관리:** 로컬 env는 각자 PC에 받아 쓰고, Git에는 올리지 않는 겁니다. 설정이 달라지면 원본에서 다시 받아 맞추고, 필요한 값과 재생성 절차가 준비되면 지웠다가 다시 만들 수 있습니다. 각자 추가한 설정은 따로 챙기고, 비밀값이 들어 있는 파일은 외부에 함부로 올리거나 공유하지 않습니다.
3. **핵심 구분:** 두 가지만 구분하시면 됩니다. Variables는 공개 가능한 설정용이고, 암호화된 비밀값 보관은 Secrets 쪽입니다.

- 위 설명은 제안할 관리 방식의 개념이다. GitHub Secrets를 개발자가 다운로드하는 저장소로 해석하지 않는다. 로컬 공개 설정 조회·env 생성 스크립트는 미구현이며, 개발/테스트 비밀값은 별도로 정할 승인된 공유처에서 받아야 한다. 삭제 후 재생성에는 원본 값과 공급 절차가 필요하고 개인 설정은 별도 보존한다.

### ASJ 참고 예시와 실제 Render 위치 — 2026-10-15 확인

- 비교 대상은 [Action Sports Journal](https://github.com/jongsunP/action-sports-journal-app)이다. 원격 master `c755d6fa9d0a33e00347aef792819c9afd2d0410`에서 `.gitignore:38-40`의 `.env*.local`/`.env` 제외, tracked `.env.example`, `dev-server/index.ts:3054`의 `apiKey: process.env.GEMINI_API_KEY`를 확인했다. 당시 `/Users/parkjongsun/Repository/action-sports-journal-app`은 존재하지 않아 원격 소스를 읽었으며 제품 변경은 하지 않았다.
- 열린 Chrome에서 실제 경로 **App → action-sports-journal-api-sg → Manage / Environment → Environment Variables**를 확인했다. `Web Service`는 첫 화면의 메뉴명이 아니라 서비스 유형이다. [실제 환경변수 관리 화면](https://dashboard.render.com/web/srv-d933jfurnols7388htq0/env)을 요청대로 Notion에 넣었다. 화면 탐색만 수행했으며 값 표시 버튼·설정 수정·저장·배포·결제 재개는 하지 않았다. 비밀값 원문이나 유효성을 확인·기록한 것이 아니다.
- 참고 예시는 **Render에 GEMINI_API_KEY 값 저장 → 배포된 서버에 환경변수로 전달 → 코드에서 읽어 사용** 흐름으로 설명한다. `process.env`는 Node.js가 제공하는 실행 중인 서버의 환경변수 객체이고, `process.env.GEMINI_API_KEY`는 해당 값을 읽는 표현이다. `apiKey`는 읽은 값을 전달받는 라이브러리 설정 항목이다. 실제 값 보관 위치와 코드 파일/행 링크를 함께 제공했다.
- ASJ와 이번 안은 **실제 설정값을 Git 코드와 분리하는 원칙은 같고 전달 방식은 다르다.** Render는 호스팅 중인 서버에 값을 전달한다. Dentlink 제안은 GitHub Variables에 공개 가능한 설정을 저장하고 Actions에서 읽어 빌드에 전달하도록 연결하며, 로컬에는 조회·env 생성 스크립트를 추가하는 방식이다. 저장만 하면 로컬·서버가 자동 연결되는 것으로 설명하지 않는다.
- **GEMINI_API_KEY는 비밀값이므로 GitHub Variables 대상이 아니다.** 공개 여부를 확인한 설정에 Variables를 쓰고, 기존 서버 GitHub Secrets → ECS 공급을 유지한다. 로컬 비밀값 공유처는 여전히 미정이다. Variables 추천은 기존 Actions를 활용할 수 있다는 현재 구조에 대한 판단이며, Render와 완전히 동일하거나 업계의 유일한 정답이라는 주장이 아니다.
- 최종 Notion 참고 예시에서는 중복 설명과 `.gitignore` 코드 블록을 줄이고 Git 제외/예제 링크, Render 실제 주소, 서버 코드 한 줄·위치·의미, 공통점/차이, Variables 선정 이유와 비밀값 구분만 남겼다. 본문의 현재 상황·대체안·선정 사유가 보존된 것을 확인했다. 이 closeout에서는 Dentlink 제품 Git을 재조사하지 않았으며 기존 SHA·env9개 기록은 앞선 조사 시점의 근거다.

### 남은 결정과 다음 작업

- 문서대로 env 분류·값 없는 예제·ignore 규칙·로컬 env 생성 스크립트·Docker/CI/E2E 연결·검증 후 추적 해제를 구현할 수 있는 수준으로 소비 경로를 조사했다. 아직 구현·실행 검증을 수행한 것은 아니므로 성공을 보장하거나 배포 완료로 표현하지 않는다.
- 실제 착수 시 GitHub Variables 등록/수정 권한과 필요한 테스트 계정·값의 승인된 접근 경로를 확인한다. 로컬 비밀값 보관소 선택과 팀 권한 설정은 사용자/팀 결정이 필요하며, 선택한 방식과 접근 권한이 확보되면 연동을 구현한다. 기존 서버 Secrets→ECS 공급은 유지한다.
- 로컬 개발·테스트 비밀값 보관소, 접근 권한, 관리 담당자, 변경 반영 절차는 적용 전에 확정한다. 이전 검토의 AWS Secrets Manager는 후보였으며 팀 공유 문서에서 확정안으로 제시하지 않았다.
- 팀 문서함으로의 이동은 완료했다. 사용자가 문서를 팀에 공유하며, 이번 세션은 별도 Slack/Jira 게시나 개인별 권한 변경을 하지 않았다.
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

## 이전 이력의 다음 시작점 — 현재는 문서 상단을 따름

- 사용자 가이드 확인과 착수 전 최종 검토까지 완료했다. 다음 작업은 위1~3의 준비 범위이며 현재는 미착수다. 최신 Git/설정 충돌을 확인한 뒤 별도 브랜치와 새 환경에 한정해 준비하고 기존 배포는 실행하지 않는다. 기존 정책이 없다는 답을 다시 묻지 않는다.
- 상단 **2026-10-16 현재 상태**부터 읽는다. 팀은 GitHub 기반 적용 방향을 결정했으며 현재는 회의에서 나온 운영 상세를 정리하는 단계다. 회의 전 “팀 의견 대기” 기록으로 되돌아가지 않는다.
- 회의 내용은 이해 완료다. 서비스/환경 분리·로컬 동기화·변수 분류·변경 반영/복원에 대한 구체적인 안을 제시하고, 실제로 알 수 없는 사실만 좁혀 확인한다. 팀 공동 관리와 회의 후 진행 원칙을 재질문하지 않는다.
- 제품 구현은 여전히 보류다. 명시적 구현 요청 시 최신 master·작업 위치·권한·설정 상태를 재확인한다. 기존 Notion은 요청 없이 변경하지 않는다.
- Eximbay의 서버 서명·키 유효성/노출/회전은 구분해 검토하고, 모든 공개 설정 분리를 중단하는 포괄적 선행 조건으로 확대하지 않는다. 공개 가능성이 확인되지 않은 키를 Variables로 옮기지 않는다.
- 제품 구현·커밋/푸시/PR·배포·Git 이력 재작성·키 회전·CI 자격 변경은 해당 승인 없이 진행하지 않는다. Slack/Jira 게시도 하지 않았다. 현재 증거는 코드·GitHub 메타데이터·공식 문서 조사이며 실제 빌드·테스트·실계정·운영 검증은 없다.
