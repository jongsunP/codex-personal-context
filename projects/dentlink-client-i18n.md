# Dentlink i18n and typography delivery checkpoint — 2026-08-25

This is the durable delivery checkpoint for the Dentlink Lab i18n, operational
Sheet, and cross-service Pretendard work. Live Git and Google Sheet state still
take precedence if later work changes them.

## 사용자 머지 준비 확인 — 2026-10-07 11:25 KST

- 사용자 요청에 따라 [PR #4666](https://github.com/Innvoaid/dentlink-client/pull/4666)이
  현재 HEAD 그대로 일반 머지 가능한 상태임을 live GitHub 정책과 merge 후보로 확인했다.
  OPEN·non-Draft·MERGEABLE·reviewDecision APPROVED, CodeRabbit 최신 HEAD 검토 완료·미해결 0건이다.
- feature HEAD는 `67e95af9f8b15bf251ec06ed063578941c97ebf5`, 최신 release/v1.88.0 base는
  `19c91c49691bdcf161e4610aa3e43b158f9de5c2`다. feature는 base보다 2 ahead/4 behind이나
  GitHub가 두 SHA를 부모로 하는 정상 merge 후보 `defabd81dc2c16f5c583516088dd177c946e5313`을 생성했다.
  최신 base와 merge 후보 차이는 동일한 지침 7개 파일·41 추가/4 삭제뿐이고 새 release 커밋은 이 경로와 겹치지 않는다.
- release 보호 규칙은 승인 1명·Code Owner 승인 설정이며 기존 승인을 취소하지 않는다
  (`dismiss_stale_reviews=false`, `require_last_push_approval=false`). 현재 release에는 CODEOWNERS 정의가 없고
  기존 `chajju` 승인과 aggregate APPROVED가 유효하다. 최신 HEAD에 대한 별도 사람 재승인을 받은 것으로 기록하지 않는다.
- required status 설정은 strict=true지만 `contexts=[]`, `checks=[]`이고 적용되는 branch rules/rulesets도 없다.
  배포 환경 승인 요구도 없다. 실패한 Vercel은 현재 필수 머지 검사가 아니므로 일반 머지를 막지 않는다.
  GitHub 상태 UNSTABLE은 live schema상 실패한 commit status가 있지만 머지 가능한 상태이며
  BEHIND·BLOCKED와 구분한다. 모든 검사가 성공한 CLEAN 상태라고 보고하지 않는다.
- Vercel의 `Deployment was blocked` 경고는 남아 있다. 상세 원인은 GitHub 제공 진단에 없으며
  이전 작성자 접근 권한 실패 이력과 구분한다. 실패 상태를 성공으로 바꾸거나 보호 규칙을 완화하지 않았다.
- 추가 제품 수정·feature 갱신·CI 재실행은 필요하지 않아 수행하지 않았다. 기존 검증 결과와 현재
  머지 후보·정책을 확인했으며 실제 merge·배포는 사용자에게 남기고 대기한다.
  머지 시점에 base·HEAD·승인·필수 조건이 바뀌면 다시 확인한다.

## CodeRabbit 리뷰 처리 — 2026-10-07

- 사용자 요청으로 [PR #4666](https://github.com/Innvoaid/dentlink-client/pull/4666)의
  모든 리뷰·댓글·스레드를 확인했다. 미해결 CodeRabbit 지적 1건을 실제 export·audit 코드와 대조해 반영했다.
- `writeCanonicalSheet`는 최초에 읽은 두 운영 탭으로 전체 값을 작성하며, 실패하면 같은
  이전 스냅샷으로 복구한다. 현재 잠금·동시 변경 감지가 없어 작업 도중 생긴 PM 편집을
  사후 read-back·스냅샷 복구만으로 보호하지 못한다는 지적이 타당했다.
- `lab/i18n/catalog/README.md`에 export `--write`와 audit `--write-sheet` 실행 전 최초 조회부터
  최종 검증·필요한 복구 결과 확인까지 양쪽 운영 탭의 편집·다른 동기화를 중지하는 기준을 추가했다.
  중지 구간을 확보할 수 없으면 쓰기를 보류하고, 복구 실패 시에도 대조·복구·검증 완료 전까지
  편집 중지를 유지한다. 없는 자동 잠금 기능을 있는 것으로 안내하지 않는다.
- 수정 commit/HEAD: `67e95af9f8b15bf251ec06ed063578941c97ebf5`,
  `docs: 번역 시트 동기화 중 동시 편집 방지 절차 보완`.
  `feature/lab-i18n-workflow`와 원격은 0/0·clean이며 worktree는 기존
  `/Users/parkjongsun/Repository/dentlink-client-i18n-guide`를 유지한다.
  PR 전체는 release 대비 지침 7개 파일·41 추가/4 삭제이고, 이번 수정은 운영 가이드 2개 항목뿐이다.
- Clinic·Lab·Admin 타입 검사, 기존 commit/push hook, 세 앱 lint 오류 0,
  Admin DLOS guard와 공유 테스트 53개(21+32), coverage 비교, diff --check를 통과했다.
  기존 lint 경고 223/186/393개는 유지된다. 이번에는 스킬·제품 코드·번역 리소스·실제 시트를
  수정하지 않았으며 별도 기능/E2E 테스트나 Sheet 동기화는 수행하지 않았다.
- 해당 스레드에 수정 근거를 답변하고 해결 처리했으며 PR 본문도 현재 보호 기준에 맞췄다.
  Draft 상태를 유지한 채 `@coderabbitai review`로 최신 커밋의 리뷰를 요청했다.
  2026-10-07 11:21 KST에 최신 HEAD의 CodeRabbit SUCCESS·Review finished와
  최종 검토 coverage의 해당 HEAD·reviewed 표기를 확인했다. 새 지적은 없고 모든 미해결 스레드는 0개다.
- 재리뷰 요청 당시 Draft였고 후속 조회에서는 OPEN·non-Draft·미병합을 확인했다.
  이 세션은 Draft 전환 명령을 수행하지 않았다. `chajju`의 승인 리뷰는 이전 HEAD `99da42b6`에
  2026-10-07 09:34 KST에 제출되었으며 최신 수정 커밋에 대한 별도 사람 승인을 뜻하지 않는다.
  최신 Vercel 실패는 `Deployment was blocked`이며 GitHub 진단에 상세 원인은 제공되지 않는다.
  이전 HEAD에는 작성자의 Vercel 팀 접근 권한 실패 이력이 있다. Auto Assign·Vercel Preview Comments는 성공했다.
  merge·배포·branch/worktree 삭제는 하지 않았다.
- 다음 시작점: 최신 PR HEAD·CodeRabbit 완료/미해결 스레드·사람 리뷰·Vercel 접근 상태를
  구분해 확인한다. 현재 branch에 팀 지침이 존재하는 것과 release/master 반영·운영 적용은 별개다.

## 저장소 에이전트 지침 PR — 2026-10-06

- 사용자 후속 지시로 개인 지침을 공유 웹 저장소의 기본 에이전트 진입점에도 반영했다.
  승인된 Lab 정적 문구·i18n 변경에는 별도 번역 요청 없이 리소스·해당 시트·검증을 포함한다.
- [PR #4666](https://github.com/Innvoaid/dentlink-client/pull/4666):
  `feature/lab-i18n-workflow` → `release/v1.88.0`, OPEN·non-Draft·미병합.
  HEAD는 `99da42b65016523eec5953bbf4c1743dcc86fa9d`, 원격 feature와 local이 동일·clean이다.
- 작업 worktree: `/Users/parkjongsun/Repository/dentlink-client-i18n-guide`.
  최초 구현은 최신 `origin/master` `6b79c9756` 기준이며, master에만 있던 관리자 변경을
  PR에 섞지 않도록 이번 지침 커밋만 전달 기준 `origin/release/v1.88.0` `faaa1498189e3e584cfc6fce215ce97feca156f7`에 재배치했다.
  최종 release 대비 0 behind/1 ahead, 지침 7개 파일·39 추가/4 삭제만 포함한다.
- 팀 정본은 `lab/i18n/catalog/README.md` 한 곳이다. `AGENTS.md`, `claude.md`,
  `.cursorrules`, `lab/README.md`, Codex·Claude i18n 스킬이 자동 적용 계기와 정본으로 연결된다.
  기존 PM 검토·번역·다른 미병합 feature의 Sheet 행 보존, 인증·충돌·필수 검토가 남은 경우의
  미완료 보고, 웹·앱 분리와 단순 확인·문서 작업의 쓰기 예외를 명시했다.
- 두 스킬 quick_validate, 지침 파일·상대 링크 검사, diff --check, 최종 전달 기준의
  Clinic·Lab·Admin 타입 검사와 기존 push hook을 모두 통과했다.
  hook의 세 앱 lint는 오류 0·기존 경고 223/186/393개이며, Admin DLOS guard와 공유 테스트
  53개(21+32), coverage 비교도 통과했다. 별도 기능/E2E 실행이나 실제 Sheet 쓰기는 하지 않았다.
- 최초 commit hook은 새 worktree의 Next 생성 타입 파일이 없어 PNG 선언 해석에 실패했다.
  각 앱의 설치된 Next CLI `typegen`으로 ignored 생성 파일을 준비한 뒤 같은 검사를 통과했다.
  테스트 준비를 위해 기존 checkout의 ignored coverage baseline을 복사했다.
  최종 의존성은 release의 frozen lockfile로 설치했으며 lockfile·제품 코드·번역 JSON·시트는 변경하지 않았다.
- PR 조회 시 REVIEW_REQUIRED/BLOCKED, CodeRabbit PENDING이다. Vercel은
  `Git author jongsunP must have access to the project on Vercel to create deployments.`로
  실패했다. 로컬 검증 성공과 원격 preview·사람 승인·리뷰·merge·배포를 구분한다.
- 이번 변경은 웹 저장소의 팀 지침에 한정된다. Lab 앱 저장소의 지침 수정·앱 PR은 하지 않았다.
  merge·배포·제품 branch 삭제는 수행하지 않았고 worktree·feature를 보존했다.
- 다음 시작점: 최신 release·PR HEAD와 리뷰를 재확인한다. 실제로 지침이 들어 있는
  branch/checkout을 동기화해야 새 기본 규칙이 적용된다. 기존 작업 브랜치에 자동으로 전파됐다고
  보지 않으며, 완료된 feature는 새 업무에 재사용하지 않는다.

## 기공소 번역 작업 기본 범위 — 2026-10-06

- 사용자 확정: 승인된 기공소 기능 구현에 정적 UI 문구의 추가·변경·삭제가 있으면
  코드의 번역 적용, 영문·한국어 리소스, 해당 운영 스프레드시트 반영과 검증을
  한 작업으로 처리한다. 통상 시트 동기화를 별도 요청이 있을 때까지 미루지 않는다.
  공통 정본은 [SESSION_WORKFLOW.md](../SESSION_WORKFLOW.md#dentlink-lab-translation-work)다.
- 확인한 웹 정본은 `lab/README.md`, `lab/i18n/catalog/README.md`,
  `.codex/skills/i18n/SKILL.md`, `lab/i18n/i18n.manifest.json`과 연결된 스크립트다.
  기존 팀 가이드에 절차와 도구는 있지만, 모든 기능 세션에서 끝까지 수행하는
  개인 공통 지침은 불명확해 명시했다. 이 최초 확인 단계에서는 제품 파일·실제 시트를 변경하지 않았다.
- 웹 절차: 기존 key·문구 확인 → 코드와 `en`/`ko` JSON 반영 → `pnpm audit:i18n`과
  `pnpm export:i18n` 미리보기 → `pnpm export:i18n -- --write` 실제 반영·read-back
  → PM 문구 검토 → `pnpm generate:i18n` → `pnpm check:i18n`·사용처 감사·화면 검증.
  변경 JSON과 생성 resource map은 기능 코드와 함께 관리한다.
- 웹 기본 시트는 manifest의 `1iuncwk8EIi8ycbc36a0dMn-ZkxaqqMHy1jvyT6ubpq0`이며,
  `개발자 영역`·`비개발자 영역`을 같은 문구 ID로 유지한다. 각 작업 때 live 설정을 다시 확인한다.
  신규 key의 코드 사용처 메타데이터는 기존 export 경로가 자동 생성한다.
- 기존 PM 수정과 로컬 값이 충돌하면 Sheet 정본과 작업 요구를 먼저 대조한다.
  일상 작업에서 `--overwrite-existing`으로 강제 덮어쓰지 않는다.
  preview의 stale 항목에 다른 미병합 기능의 key가 있으면 일괄 삭제하지 않는다.
- 시트 쓰기에는 편집 인증이 필요하다. 인증·충돌·필요한 PM 검토 때문에 막힌 단계는
  미완료로 보고한다. 로컬 JSON 반영, 시트 반영, PM 검토, 재생성·검증 완료를 구분한다.
- 적용은 웹 Lab과 Lab에서 쓰는 공유 UI 정적 문구 범위다. 실제 데이터·서버 응답을
  새로 번역하는 범위로 확대하지 않는다. 공유 UI 변경 시 Clinic·Admin 영어 fallback도 확인한다.
- 기공소 네이티브 앱은 별도 저장소·시트·명령을 사용하므로
  [Lab 앱 번역 지침](dentlink-lab-app.md#번역과-스프레드시트-작업--2026-10-06)을 따른다.

## Current Delivery State

- Shared repository: `https://github.com/Innvoaid/dentlink-client`
- On 2026-08-25, live Git verification found local `master` clean and exactly
  synchronized with `origin/master` at `8e05cbb84`
  (`Release/v1.84.0 -> master (#4528)`).
- `master` contains the primary i18n merge `7a7c0138b`
  (`[DL-15676] Lab 다국어 및 디자인 QA 반영 (#4518)`) and the operating-doc
  follow-up `6e28e4d75` (`i18n 후속 운영 절차 정리 (#4522)`).
- Required runtime and operating files are present on `master`, including the
  Lab locale/provider, `i18n.manifest.json`, Sheet client, and repository i18n
  skill. The final local maintenance files had no diff against `master`.
- The user confirmed that this i18n release has been deployed to production.
  This deployment statement is user-confirmed; the Git integration above was
  independently verified locally.
- Local cleanup is complete: the dedicated
  `/Users/parkjongsun/Repository/dentlink-client-i18n` worktree and local
  `feature/i18n` / `feature/i18n-maintenance` branches were deleted. Their
  matching remote branches remain intentionally untouched.
- Removing the worktree also removed its ignored local-only
  `lab/.env.local` and `lab/scripts/i18n/service-account.json`. These files
  were never part of the shared repository.
- There is no active dedicated i18n worktree. Any later i18n work must use a
  fresh feature branch from the current release-plan base rather than either
  historical branch.

## Sheet Environment Setup

- Normal Lab development and builds use the committed locale JSON and do not
  require Google Sheet credentials or Sheet environment variables.
- The default spreadsheet ID and operational tab names are tracked in
  `lab/i18n/i18n.manifest.json`. `SHEETS_SPREADSHEET_ID` and
  `SHEETS_SHEET_NAME` are optional overrides for a temporary test Sheet.
- `generate:i18n`, `check:i18n`, `export:i18n` preview, and `audit:i18n`
  preview use the public read path and need no local credentials.
- Authentication priority is `GOOGLE_SERVICE_ACCOUNT_KEY`, then the ignored
  local `lab/scripts/i18n/service-account.json`, then gcloud Application
  Default Credentials. Only `export:i18n -- --write` and
  `audit:i18n -- --write-sheet` need editor authentication. Credentials remain
  local or in CI secrets and must not be committed.

## Automatic Sheet Metadata Rule — 2026-09-01

- `pnpm export:i18n -- --write` is the canonical new-key write command. It
  validates the static usage audit before any write, then updates locale values
  and both operational tabs through one controlled write path with the same
  canonical key order and metadata.
- Every new key receives every field the repository can derive from code:
  representative page, screen state, route, usage status, namespace, key, and
  usage ID. Screenshot and marker remain empty until a real runtime observation
  exists; this is intentional rather than incomplete data.
- Existing screenshot and marker data are preserved when the automatic static
  audit runs. A runtime observation may be supplied explicitly when those
  fields must be added or refreshed.
- If a write or final verification fails, the command attempts to restore both
  operational tabs independently from the rows fetched before the write. A
  failure restoring one tab does not prevent restoration of the other, and all
  failures are aggregated for diagnosis.
- English/Korean and the two role-owned review-request columns keep their
  documented human ownership. Generated/read-only metadata must not be edited
  manually. If the documented command is used and generated columns are not
  manually overridden, the same workflow applies regardless of developer,
  device, worktree, or AI session.
- The shared project owns and enforces this rule in
  `lab/scripts/i18n/export-locales-to-sheet.js` and
  `lab/i18n/catalog/README.md`; this personal checkpoint records the decision
  but is not the implementation source of truth.

### Delivery split from Warranty

- The shared implementation was separated from DL-16258 so a later Warranty
  hold or product change cannot block the generic i18n operating improvement.
- Branch/upstream: `feature/i18n-sheet-workflow` /
  `origin/feature/i18n-sheet-workflow`
- Latest commit: `eebf35db3d44cc3e4d586ab452e48baf70a58033`
  (`fix: i18n 시트 최종 검증 복구 범위 보완`)
  - initial consolidated commit: `6cc94d0d5a312fe6c02395375685c9ba5722d467`
- Release PR: [#4557](https://github.com/Innvoaid/dentlink-client/pull/4557)
  targets `release/v1.85.1`; the base was changed from `release/v1.86.0` after
  confirming both release refs were the same commit with `0/0` divergence and
  a clean merge simulation. The PR merged on 2026-09-01 as merge commit
  `4fa8ce400f889630152f7e1fa6cb7b51b4f98fa6`. CodeRabbit passed with zero
  unresolved review threads before merge.
- The PR changes only `lab/i18n/catalog/README.md`,
  `lab/scripts/i18n/audit-usage.js`, and
  `lab/scripts/i18n/export-locales-to-sheet.js`.
- Final verification includes catalog read-back, role-view formula links, and
  misplaced review-request checks inside the same rollback boundary. A mocked
  failure confirmed that final validation failure restores both tabs.
- On this independent branch, static usage audit passes with 1,581 local keys,
  zero unknown literals, and the existing eight unresolved indirect keys. Live
  Sheet preview reports exactly three stale keys because the still-open
  Warranty PR's three keys were already exported. This is external shared-Sheet
  state, not a product-code dependency. If Warranty is actually put on hold,
  reconcile those three Sheet rows separately before treating `check:i18n` on
  the release-only tree as green.

## Historical Delivery Checkpoint — 2026-08-21

Current release integration plan:

- The production train is `release/v1.84.0`; it has not yet been merged into
  `master`, so production completion must not be inferred from the staging
  deployment.
- PR #4522 is already in `release/v1.84.0`, and PR #4523 has merged that current
  release tree into `stage` for staging deployment.
- If the QA fixes in `095f503bc` must ship, first merge them into
  `release/v1.84.0` through a separate follow-up PR and then refresh the
  release-to-stage deployment. Do not assume PR #4523 contains that commit.
- The historical direct `feature/i18n -> stage` PRs are no longer the active
  delivery path. The assembled release itself is the staging source:
  `release/v1.84.0 -> stage`.
- If implementation has already entered an active release and a follow-up is
  needed, create a fresh feature branch from the latest remote release and PR
  back to that release. Do not append commits to the already-merged historical
  feature branch.
- `release/v1.85.0` is the following release train, planned for Monday,
  2026-08-31.
- After i18n is finalized as `release/v1.84.0`, propagate the finalized release
  forward into both `master` and `release/v1.85.0`. Do not use the historical
  `feature/i18n` branch as the propagation source after release finalization.
- Continue `v1.85.0` feature integration on its release branch. After that
  release is finalized and deployed, propagate `release/v1.85.0` back into
  `master`.
- PR [#4512](https://github.com/Innvoaid/dentlink-client/pull/4512) is the
  concrete current example of the normal delivery flow: the small DL-16004
  implementation branch was created from current `origin/master`, while its
  PR targets `release/v1.85.0` because that is its intended deployment train.
  It is one feature in that release, not evidence that the 1.85 contents are
  complete.

## Preliminary Parallel-Release Risk Check — 2026-08-20

This check was intentionally performed before either the i18n work for 1.84 or
the complete 1.85 feature set was finalized. It is a planning checkpoint only,
not merge approval or a request to integrate branches now.

- At the check time, `origin/master` and `origin/release/v1.85.0` both pointed
  to `9b57bec96`, while remote `feature/i18n` contained that master plus 22
  commits.
- PR #4512 has no overlapping files or Git conflict with remote i18n.
- A simulated aggregate of the then-open 1.85 PRs followed by remote i18n
  predicted four semantic conflict surfaces:
  - `shared/ui/src/Order/OrderForm/OrderAdditionalInfoComponent/PatientPhotoConfirm.tsx`
  - `shared/ui/src/OrderDetailUI/parts/BoxComponent/OrderDetailBoxAdditionalInfo.tsx`
  - `shared/ui/src/OrderDetailUI/parts/BoxComponent/OrderDetailBoxTitle/OrderDetailBoxTitleDesktop.tsx`
  - `shared/ui/src/OrderDetailUI/parts/BoxComponent/OrderDetailBoxTitle/OrderDetailBoxTitleMobile.tsx`
- These conflicts appeared manageable, but resolving text conflicts alone is
  not final proof. Preserve newer feature behavior, reapply translations only
  to surviving UI, confirm the 1.85 version bump, and run integration QA after
  the finalized 1.84 release is propagated into the finalized 1.85 contents.
- Because both release contents and the local i18n work are still changing,
  repeat the live graph, overlap, merge simulation, and QA assessment at the
  actual integration point rather than relying on this snapshot.

Final follow-up commits:

- `b47ef8cb0` — `fix: 다국어 시트 역할별 인터페이스 정리`
- `8a337bd13` — `chore: 서비스 버전 1.84.0 반영`
- `1d1b2fda1` — `ui: Clinic과 Admin Pretendard 폰트 정책 적용`
- `dc44bc492` — `fix: 다국어 시트 정합성과 누락 문구 보완`
- `9c0b48ef3` — `[DL-15676] fix: 다국어 QA 수정사항 반영`
- `1aa72be08` — `[DL-16013] ui: 주문 상태 뱃지 너비를 유동형으로 변경`
- `61d6f7c55` — `[DL-16013] fix: 상태 뱃지 모드별 스타일 호환성 보완`
- `d14fa1435` — `[DL-16083] ui: 상태 뱃지 콘텐츠 너비 유지`
- `c6b3ae200` — `docs: i18n 후속 운영 절차 정리` (open PR #4522;
  later merged into release by PR #4522)
- `095f503bc` — `[DL-15676] fix: i18n 디자인 QA 후속 이슈 수정`
  (pushed after PR #4522 merged; not yet in release)

## Lab i18n Runtime

- Lab displays Korean by default. English remains the source language,
  fallback, and future expansion resource.
- Runtime uses `i18next@22.5.1` and `react-i18next@12.3.1` with statically
  bundled locale JSON.
- `lab/i18n/i18n.manifest.json` is the schema source for languages,
  namespaces, keys, and Sheet columns.
- Current catalog: 1,528 keys across 20 files under
  `lab/src/i18n/locales/{en,ko}`.
- Current namespaces: `gnb`, `sharedUi`, `dashboard`, `account`, `orders`,
  `shipping`, `settlements`, `patients`, `help`, and `linkTalk`.
- There is no language selector or persisted language choice in the current
  scope.

## Canonical Google Sheet

- Sheet:
  `https://docs.google.com/spreadsheets/d/1iuncwk8EIi8ycbc36a0dMn-ZkxaqqMHy1jvyT6ubpq0/edit`
- Operational tabs: `비개발자 영역`, `개발자 영역`
- Preserved backup tabs: `백업_작업전_2026-08-13`,
  `백업_2탭전환_2026-08-18`
- Backup tabs were not changed during the final structural correction.

The two operational tabs are role-specific views of the same canonical message
table, not independent datasets:

- Both tabs contain exactly 1,528 data rows after the latest design-QA export.
- Every message ID is unique and the ID sequence is identical in both tabs.
- Shared fields are connected by formulas and have one owning tab rather than
  duplicated manual input.
- `페이지`, `화면 상태`, and `페이지 경로` expose one representative use site
  only. They never expose a multiline list of all routes.
- Multiple technical use-site identifiers remain aggregated only in the hidden
  developer `사용처 ID` column.
- The previously problematic row 24 representative path is `/` in both tabs.

Nondeveloper columns:

`영문 | 한글 | 개발자에게 확인 요청 | PM·디자이너에게 확인 요청 | 페이지 |
화면 상태 | 위치 번호 | 캡처 | 페이지 경로 | 문구 ID`

Developer columns:

`PM·디자이너에게 확인 요청 | 영문 | 한글 | 페이지 | 화면 상태 | 위치 번호 |
캡처 | 페이지 경로 | 개발자에게 확인 요청 | 문구 ID | namespace | key |
사용 상태 | 사용처 ID`

`비개발자 영역` owns English, Korean, and `개발자에게 확인 요청`.
`개발자 영역` owns `PM·디자이너에게 확인 요청`. Every other shared field is
formula-linked or generated. Writable columns are yellow; generated/read-only
columns are gray and protected with warning-only ranges.

Request ownership is explicit:

- `개발자에게 확인 요청`: PM or designer asks a developer about wording, context,
  or exposure conditions.
- `PM·디자이너에게 확인 요청`: a developer or automated audit asks PM/design for
  a product or wording decision, including screen-versus-JSON differences.
- Current unresolved counts are nine PM/design-to-developer requests and one
  developer-to-PM/design request. The user intentionally deferred all ten on
  2026-08-20 rather than treating them as code blockers.

Final Sheet read-back verified:

- 1,528 unique IDs in each tab and identical row order
- zero missing, stale, translation conflicts, misplaced requests, or role-view
  formula-link issues
- nine developer requests and one PM/designer request preserved in both views
- a duplicate `페이지 경로` header found during final closeout was restored to
  `개발자에게 확인 요청`; a full export then passed read-back verification
- hidden use status and use-site IDs preserved
- capture expansion is paused by user decision; existing links remain and no
  new captures are required before design QA

## Typography Policy

All three projects now use Pretendard and the same Dentlink letter-spacing
policy:

- heading and title variants: `0px`
- body variants: `-0.1px`
- shared UI reads `--dentlink-letter-spacing-heading` and
  `--dentlink-letter-spacing-body`, with legacy theme values only as fallback.

Service details:

- Lab: local Pretendard Medium/Bold WOFF2 via `next/font/local`.
- Clinic: local Pretendard Medium/Bold WOFF2 via `next/font/local`; all previous
  Clinic Lato source references and font assets were removed.
- Clinic PDF: five PDF routes and five PDF document components now use
  Pretendard Regular/SemiBold/Bold TTF.
- Admin: its existing full Pretendard web and PDF setup remains; its theme and
  root variables now use the same heading/body letter spacing as Lab/Clinic.

## Verification And Known Environment Limits

Completed verification:

- `pnpm audit:i18n`: 1,528 keys, 1,528 reachable, zero unresolved keys, zero
  unknown literal keys, and zero review rows.
- `pnpm export:i18n`: 1,528 local keys with zero missing, stale, conflicts,
  role-view link issues, or misplaced review requests.
- `pnpm check:i18n`: 1,528 keys verified across 20 locale files.
- Font asset hashes match their existing Lab/Admin source files.
- Clinic source and public assets contain zero remaining Lato references.
- Clinic and Admin development roots returned HTTP 200.
- Runtime computed styles confirmed Pretendard, heading `0px`, and body
  `-0.1px` in both projects.
- All five Clinic PDF routes and all five new Clinic font asset URLs returned
  HTTP 200 without font compilation errors.
- Lab, Clinic, and Admin typechecks passed before commit and in the commit hook.
- The push hook completed Clinic/Lab/Admin lint with zero errors and 418
  existing warnings, and shared config/hook coverage tests passed (27 tests).
- Prettier and `git diff --check` passed before the final commit.

Known local verification limit:

- `pnpm --filter @dentlink/ui build` still fails on broad pre-existing package
  errors including generated icon unused imports, stale stories, and missing
  legacy modules. All three consuming app typechecks pass, so no error was
  traced to the changed shared order-title component.

## Design QA Follow-up — 2026-08-21

The initial fifteen directly actionable DL-15676 child items are implemented,
committed, and pushed. Their translation source has been exported to the
canonical Sheet. The first eight are:

- DL-16010: translate the order-list status dropdown from known order-status
  enum keys while retaining the API display name as the fallback.
- DL-16011 and DL-16022: translate the shipping print menu, label/sticker
  selection modal, control buttons, empty/search/list labels, unavailable-label
  toast, and sticker size-setting modal. Printed label/sticker document content
  remains excluded from this scope.
- DL-16012: add the confirmed Korean line break to the shipping notice and make
  the common popup description honor intentional newlines.
- DL-16018: use the requested `mono.400` equivalent icon color for Lab's
  Add New Patient action while preserving Clinic/Admin behavior.
- DL-16020 and DL-16021: apply the requested Lab-only Change Status width and
  Design Upload View left padding without changing Clinic/Admin rendering.
- DL-16023: translate the remaining hardcoded Back action in the skip-design
  flow.

Jira status was initially changed to `진행 중` for all eight implemented cards:
DL-16010, DL-16011, DL-16012, DL-16018, DL-16020, DL-16021, DL-16022, and
DL-16023.

Seven additional directly actionable cards were then implemented:

- DL-16048: keep Pending Approval and Pending Order on one line in the Lab
  order-board copy while preserving the shared English fallback.
- DL-16049: translate the print button, menu, and tooltip.
- DL-16050: translate pickup status and weekday labels; the new
  `lab/src/i18n/formatUiWeekday.ts` centralizes English/Korean weekday
  formatting and safely handles invalid dates.
- DL-16051: translate settlement-status dropdown labels.
- DL-16052: keep the delivery-date label and icon adjacent and correct the
  Korean Pending Order graph alignment. This remains a visual re-QA item.
- DL-16055: vertically center the settlement currency badge.
- DL-16059: translate invitation authority and role labels while leaving the
  backend code values unchanged.

Jira status was also initially changed to `진행 중` for DL-16048, DL-16049,
DL-16050, DL-16051, DL-16052, DL-16055, and DL-16059.

On 2026-08-21, all fifteen implemented cards were moved to
`Ready for Deploy`: DL-16010, DL-16011, DL-16012, DL-16018, DL-16020,
DL-16021, DL-16022, DL-16023, DL-16048, DL-16049, DL-16050, DL-16051,
DL-16052, DL-16055, and DL-16059. Do not mark them complete until the pushed
revision is deployed and visually rechecked.

The latest Sheet export synchronized 1,528 local keys. The final follow-up
added four Scan-platform keys for DL-16019 and appended the earlier 12 new
rows missing from the Sheet. It reported zero stale rows, translation
conflicts, role-view link issues, or misplaced review requests. Current
verification:

- Lab, Clinic, and Admin typechecks pass.
- `pnpm check:i18n` verifies 1,528 keys across 20 locale files.
- `pnpm audit:i18n` reports all 1,528 keys reachable with zero unresolved or
  unknown literal keys and zero Clinic regression candidates.
- `git diff --check` passes.
- Targeted Lab ESLint passes with zero errors. The shared-UI lint command is
  blocked by the repository's existing duplicate Storybook ESLint plugin
  resolution, not by a confirmed error in this patch.
- `@dentlink/ui` full build remains blocked only by the broad pre-existing
  generated-icon, story, missing legacy-module, and unused-code errors; no new
  error was reported in the changed files.

The full draft PR comparison was also reviewed through structural audit and
targeted inspection of risk-heavy changes. No confirmed business-logic, API
payload, or Clinic/Admin localization regression was found. Shared UI still
uses Lab's provider bridge, while consumers without the provider retain their
English `defaultValue`. This is not a claim that every state in the 553-file
PR was visually inspected; final assembled-release and visual QA remain
required.

Current design or policy follow-up:

- DL-16083 is implemented and `Ready for Deploy`. A shared flex-column parent
  stretched multiple status chips to the full status-cell width. The common
  `StatusChip` full-text wrapper now uses content width, so Lab, Clinic, Admin,
  and shared call sites receive the same behavior while icon-only and
  text-only modes keep their existing contracts. This change is included in
  `release/v1.84.0` and the currently deployed stage tree.
- DL-16013 is implemented and `Ready for Deploy`. The shared `StatusChip` no
  longer has per-status fixed widths. It uses content-based width, 6px
  horizontal and 1px vertical padding, a 4px icon-text gap, and keeps the 25px
  height, 1px border, and 6px radius. Clinic, Lab, and Admin typechecks and the
  1,528-key i18n check pass. A local Lab order-list check confirmed the exact
  computed spacing and distinct widths for `임시 주문서` and `완료`. A second
  cross-service review confirmed normal and dark modes use the new intrinsic
  width while flat, icon, and text modes preserve their prior overflow and
  spacing behavior.
- DL-16053: timeline title and description are complete prose strings from the
  API. The agreed i18n scope changes only static frontend strings, so the API
  text remains unchanged; confirm that this scope is acceptable.
- DL-16072: the common product term is decided as `리메이크`. Web already uses
  it, app issues are tracked on separate cards, and this card is `Ready for
  Deploy`.
- DL-16080: the LinkTalk case-preference template renders API `message` and
  button `label` values directly. It is `진행 중` pending a decision to either
  localize the API template or explicitly exempt this template type for
  frontend translation. A frontend exception also needs the confirmed Korean
  label for `Set Preferences`.

DL-16019 was resolved by adding the four missing Scan-platform keys and was
visually verified in the local Others state. DL-16024 received the specified
Korean line break. DL-16054 was confirmed as an existing transition-state bug
outside the i18n change; its static wording is correct and its explanatory
comment is retained. These cards are `Ready for Deploy`.

Nine new QA cards were added under DL-15676 on 2026-08-21. All are mobile-app
issues or a web/app terminology decision and cannot be implemented in this
web-only worktree:

- DL-16067 through DL-16071 and DL-16073 through DL-16075: mobile Lab or
  Clinic app copy/layout fixes owned by the app repository.
- DL-16072 is complete in this web QA queue; any app wording changes remain on
  their own app QA cards.

Mobile-app cards are outside this web worktree and are not part of the remaining
web delivery queue. The DL-16072 terminology decision and card handling are
complete.

## Durable Operating Rules

- Do not edit, delete, or include tabs whose names start with `백업_` in Sheet
  automation.
- Keep one canonical row per full key in both operational tabs.
- Do not expand representative page/state/path cells into multiline use-site
  lists.
- Keep PM/design-to-developer and developer-to-PM/design requests in separate
  columns.
- Translation changes are made in `비개발자 영역`; generated technical fields
  and hidden IDs are not manually duplicated across tabs.
- Runtime observation JSON may contain real account or patient data. Keep it
  temporary, local, ignored, and never upload it unmasked.
- `service-account.json` remains local and ignored. Grant Sheet edit permission
  only for an explicitly authorized write.

### Staging release deployment

- The deployment branch is `stage`, never `staging`.
- To deploy an assembled release, delete remote `stage`, recreate remote
  `stage` from the exact current `origin/master`, and open
  `release/vX.Y.Z -> stage`. Merge that PR to trigger staging deployment.
- This reset-and-PR flow is intentional. The Lab, Clinic, and Admin staging
  workflows listen to pushes on `stage` but each has a path filter limited to
  its own top-level service directory. A commit that changes only `shared/**`
  does not by itself trigger those consuming-service deployments. Comparing
  the full release against a fresh master-based `stage` preserves the relevant
  service-level release diff and starts the upper-service workflows.
- Recheck remote refs and ensure no open PR still targets the old `stage` before
  deleting it. Never infer deployment success from the PR merge alone; verify
  the applicable GitHub Actions runs separately.

## Capture Progress Snapshot — 2026-08-20

Capture expansion is temporarily paused, not cancelled. The current priority is
to preserve existing work and respond to design QA; the user may resume and
complete the capture catalog later.

- 27 actual capture images exist.
- 201 of the then-current 1,497 message keys were connected to a capture
  (about 13%). The catalog has since grown to 1,528 keys, so refresh this
  denominator before resuming capture work.
- 27 of 110 currently identified page/state groups have a capture (about 25%).
- 83 currently identified page/state groups show `캡처 준비 중`.
- A conservative overall completion estimate is 15–20% because modal,
  permission, error, and data-dependent states may reveal additional groups and
  increase the current total of 110.

This snapshot came from a read-only Sheet inspection; no capture or Sheet data
was changed during the measurement.

## Remaining Delivery Work

PR #4523 (`release/v1.84.0 -> stage`) is merged after recreating remote `stage`
from `origin/master`. The Lab, Clinic/Office, and Admin stage workflows started
for merge SHA `3607210d0` and were still running at this checkpoint. This is
still not production-closeout complete: verify those workflow results and
assembled-release staging QA before merging the final release into `master`,
then propagate the finalized 1.84 release into `release/v1.85.0`.

The QA follow-up commit `095f503bc` is clean and pushed on
`feature/i18n-maintenance`, but it was created after PR #4522 was merged. It
contains the DL-16018, DL-16048, DL-16085, and DL-16086 fixes and is not part of
the current release or PR #4523. A separate PR into `release/v1.84.0` is the
next required integration step if those fixes must be included in staging.
Capture expansion remains paused. Record the actual master commit and
production result only after those events occur.
