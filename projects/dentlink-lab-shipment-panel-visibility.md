# 기공소 배송 업데이트 내역 패널 노출 제한 — DL-17625

## 현재 상태 — 2026-11-25 PR 생성 및 작업 폴더 이동 완료

- 세션 `기공소 배송 업데이트 패널 노출 · DL-17625` (`01a21141-e9b6-7ab0-becc-65412540bce1`), 메인 프로젝트 폴더/local. 메인이 등록·최초 turn과 생성 시점 모델/추론 `gpt-6-astra`/`xhigh` 일치를 확인했다. 이 세션이 구현과 후속 작업을 소유하며 사용자에게 직접 보고한다. 메인은 추가 폴링하지 않는다.
- 사용자 요청: [DL-17625](https://innovaid.atlassian.net/browse/DL-17625)를 별도 세션·worktree에서 구현·검증. 결과 브리핑 후 사용자가 커밋·push·`release/v1.95.0` 대상 PR 생성을 추가 승인했다. merge·배포·자동 리뷰 대응은 승인 범위가 아니다.
- [PR #4951](https://github.com/Innvoaid/dentlink-client/pull/4951) 생성 완료, Open·일반 PR(Draft 아님). base=`release/v1.95.0`, head=`feat/DL-17625-release-v1.95.0`, 커밋=`42b0e38be2c880404beeaca3ee35dfdab298d042`. GitHub의 base/head SHA·실제 변경 파일 2개를 확인했다. 운영 서비스 미반영이며 리뷰·merge·배포는 미진행이다.
- 테스트 22개, 변경 파일 ESLint, Lab 전체 타입 검사, `git diff --check` 통과. 전달용 release 기반에서도 재검증했다. E2E 정적 영향 가드 `NO_IMPACT` 및 PR 직전 guard check 통과. 실제 브라우저 E2E는 미실행이다.
- Jira 본인 하위카드에 작업 정의·구현 검증 댓글 `45313`을 정리했고 동일 댓글에 PR 링크를 추가했다. 상태 `Ready for Deploy`는 개발 완료 의미이며 리뷰·통합·배포 완료 의미가 아니다. 상위 댓글·Slack 쓰기는 하지 않았다.

## 요구사항 근거

- 접수 시 본인 하위 DL-17625는 Frankie 담당·해야 할 일·본문/댓글 없음이었다. 상위 [DL-17624](https://innovaid.atlassian.net/browse/DL-17624)에 ‘배송 + 픽업 페이지에서만 노출’이 명시되어 있다. 상위 댓글45287에서 Tom이 1.95.0 연결 및 라벨 작업과 함께 진행 요청을 남겼다. 사용자는 별도 작업 세션/worktree를 지시했으므로 라벨 브랜치에 합치지 않는다.
- [Slack 원문](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794386830573219): 모든 페이지에 패널이 나타나 CTA를 가리는 문제. 최종 Tom 답변은 배송·픽업 페이지만 노출. 패널 제거·알림으로 대체는 사용성 확인 이후 고려할 별도 제안이며 이번 구현 요구가 아니다.

## 제품·작업 공간

- 대상은 `dentlink-client`의 기공소 웹 전역 `FloatShipmentCreateController`다. 현행 mobile 제외 조건이 있고 `_app.tsx`에서 인증 후 전역으로 렌더한다. 치과/어드민/네이티브 앱 변경은 현재 확인된 범위가 아니다. 기존 모바일 미노출을 임의로 확장하지 않는다.
- 구현 시작 당시 주 checkout의 `feat/DL-17583`에는 출력 세션의 미커밋 작업이 있었다. 출력과 알림 후속 `feat/DL-16140-history-followup`은 다른 세션 소유이며 재사용·수정하지 않았다. 다른 세션의 현재 경로는 각 소유 세션에서 관리한다.
- 현재 실제 worktree: `/Users/parkjongsun/Repository/dentlink-client-dl-17625`. 생성 시 `feat/DL-17625`에서 구현했고 현재 checkout은 전달용 `feat/DL-17625-release-v1.95.0`, upstream은 `origin/feat/DL-17625-release-v1.95.0`, HEAD는 `42b0e38be2c880404beeaca3ee35dfdab298d042`이며 clean이다.
- 원본 작업은 최신 `origin/master`=`9084878eaa93ea4fe39df0f376afa4456c5fec55`에서 시작했고 로컬 `feat/DL-17625`의 커밋 `0e9041aa4b81ed244a30de98e2e4ac9ad7b14ccc`로 보존했다. 원본 브랜치 원격은 없다(초기 push가 로컬 커버리지 기준 파일 부재로 중단됨).
- PR 전체 비교에서 release에 없는 master의 DL-17620 핫픽스·패키지 버전 등 4파일이 추가되는 것을 확인했다. 개인 SESSION_WORKFLOW의 clean delivery branch 규칙에 따라 `origin/release/v1.95.0`=`b0e04eafe00e86836f472bea114e5fce867b4cad`에서 `feat/DL-17625-release-v1.95.0`을 만들고 원본 작업 커밋만 cherry-pick했다. 충돌 없음, 원본과 전달용의 작업 2파일 내용 동일, PR에는 1커밋·2파일·+156/-28만 포함된다. 새 worktree를 추가하지 않았다.
- 주 checkout은 타 세션의 dirty 작업이므로 pull/checkout/stash/reset 대신 원격 fetch만 했다. 개인 컨텍스트는 `git pull --ff-only`로 동기화했다.
- 같은 저장소 주 worktree의 env 6개(admin·clinic 각 development, e2e development/staging, lab development/local)를 공식 로컬 스크립트로 값 열람 없이 복사했다. 목적지 0600 권한, `cmp` 동일성, ignored/untracked 확인. 원본 env 및 다른 작업의 서버/창/포트는 변경하지 않았다.
- `pnpm install --offline --frozen-lockfile --ignore-scripts` 완료. 서버나 외부 브라우저는 띄우지 않았다.

## 구현과 검증

- `lab/src/components/FloatShipmentCreateController/FloatShipmentCreateController.tsx`: 기존 제외 경로 방식에서 배송·픽업의 5개 Next `pathname` 허용 방식으로 변경했다. `/shipping`, `/shipping/[shipping_id]`, `/shipping/scan`, `/pickup`, `/pickup/[pickup_id]`. 기존 `Layout/Menus.tsx`의 배송·픽업 메뉴 활성 경로와 실제 페이지 역할이 일치하므로 목록·상세·스캔을 포함했다. `LINKS`를 재사용한다.
- 기존 `isShowFloatShipmentUI`, 모바일 제외, `useMillingLayout`의 외부기공소/밀링 제한은 유지했다. 허용 경로로 대체되어 불필요해진 `isSiteResourceRoute` import만 제거했다. 해당 설비·자재 경로는 계속 숨긴다.
- 조건은 렌더링에만 적용했다. `_app.tsx`의 전역 mount, `ServerSentEvent`, `useShipment`/`useLabel`/`usePickup`, 조회/갱신/비우기/타이머/토글 상태 처리에는 변경이 없다. 일반 페이지에서도 hook이 유지되며 되돌아올 때 상태를 재사용한다. UI 문구·번역 변경 없음.
- `FloatShipmentCreateController.test.tsx`: 기존 주문 화면 노출 기대를 새 요구에 맞게 수정. 허용 5경로, 일반/설비·자재/유사 이름 경로 숨김, 모바일·밀링 제한, 빈 내역, 배송→주문→픽업→주문상세→배송 이동 시 토글/hook 유지, 숨긴 상태에서 업데이트 콜백 후 재진입을 확인한다.
- Red→Green: 수정 전 요구와 충돌하는 9케이스 실패(13통과), 수정 후 22/22 통과. 명령: `pnpm --filter dentlink-lab-web exec jest --runInBand --runTestsByPath src/components/FloatShipmentCreateController/FloatShipmentCreateController.test.tsx`.
- 변경 2파일 ESLint 통과, 테스트 파일 Prettier check 통과, `git diff --check` 통과. 전체 Lab `tsc --noEmit --incremental false` 최종 통과. 새 worktree의 `next-env.d.ts` 부재로 최초 PNG 선언 오류가 발생해 `pnpm --filter dentlink-lab-web exec next typegen`으로 공식 타입을 생성한 뒤 해결했다. 생성 파일은 ignored이며 제품 변경 2파일 외 추적 파일 변경 없음. 기존 Next/TS 5.0.4 권장버전 경고, Prettier 설정 옵션 경고는 별도다.
- PR 준비 시 새 worktree의 Husky runtime과 Clinic/Admin Next 타입 선언도 공식 명령으로 준비했다. 원본 커밋의 pre-commit Clinic/Lab/Admin 타입 검사 통과. 전달용 브랜치에 맞춰 offline frozen dependency 설치·Lab typegen 후 테스트 22개·변경 파일 lint·Lab 전체 tsc를 다시 통과했다.
- 처음 push는 `coverage-baseline.json` 부재로 로컬 훅이 실패했다. 전달용의 `shared/`·커버리지 스크립트가 release base와 동일함을 확인하고 shared tests(config 77 + hooks 92)를 실행, 정식 `pnpm coverage:baseline`으로 ignored 로컬 기준을 준비했다. 최종 전달용 push는 pre-push의 세 서비스 lint(기존 경고 있음), Admin DLOS guard 및 9개 테스트, shared 169개 테스트·커버리지 비교(변화 없음)를 정상 통과했다. 훅 생략·제품 설정 변경·protected branch 직접 push는 없었다.
- PR 스킬에 따른 E2E 영향 agent는 `origin/release/v1.95.0...42b0e38be`를 읽기 전용으로 검사해 `NO_IMPACT` 판정. `04_labShipment.spec.ts`의 배송·픽업 경로는 허용 목록에 있고, `utils/lab.ts:229-231`의 `commonHideUpdateHistory`는 패널이 없으면 반환하므로 홈·주문에서 사용하는 04/05/08 흐름에도 E2E 변경이 필요하지 않다. root가 핵심 경로/helper 근거를 대조했다. `mark.sh NO_IMPACT release/v1.95.0 feat/DL-17625-release-v1.95.0` 및 `check.sh --base release/v1.95.0 --head feat/DL-17625-release-v1.95.0` 통과. 실제 E2E를 실행하거나 통과했다고 보고하지 않았다.
- 검증 한계: 컴포넌트 테스트는 조회/SSE hook·하위 UI를 mock한다. 실제 계정 브라우저, 서버 SSE 수신, 실배송·픽업 처리, 시각적 가림 여부 E2E는 실행하지 않았다. 코드 검토와 DOM 테스트 결과를 실제 운영/QA 검증으로 확대하지 않는다.
- 통합 접점: 출력 세션은 인접 `FloatShipmentCreateControllerLabelItem.tsx`, `shipping/index.tsx`, `Shipping/Scan/ShippingScan.tsx` 등을 수정 중이다. 이 세션은 해당 내용을 가져오거나 수정하지 않았다. 통합 때 배송/스캔에서 출력 패널과 함께 쓰는 동작을 확인한다.

## 2026-11-25 Repository 경로 이동

- 사용자의 필수 위치 지침에 따라 본인 소유 worktree를 `/Users/parkjongsun/.codex/worktrees/dl-17625-shipment-panel/dentlink-client`에서 `/Users/parkjongsun/Repository/dentlink-client-dl-17625`로 `git worktree move`했다. 실제 폴더 이동이며 symlink나 복제 checkout을 남기지 않았다.
- 이동 전후 HEAD·branch·upstream·index·staged/unstaged diff·untracked 상태가 동일하다. 전체 164,181개 항목의 inode/권한/크기/mtime/symlink metadata와 ignored 파일 133,393개의 목록도 동일하다. env 6개는 값 열람 없이 불투명 동일성 및 ignored 상태를 확인했다.
- 해당 경로를 cwd로 사용하던 실행 프로세스는 없었다. 본인 경로의 watchman watch만 해제했다. 다른 세션의 프로세스·파일·브랜치는 변경하지 않았다. 이동을 위한 제품 커밋·push·PR 변경·테스트 재실행은 하지 않았다.
- Git worktree 등록과 채팅 attachment는 새 경로만 가리키고 이전 checkout/attachment는 없다. `attach_worktree`는 성공했으나 `read_thread`의 기본 cwd 메타데이터는 옛 경로에 남아 있다. 재연결로도 갱신되지 않았고 UI 도구는 helper 시작 오류로 사용할 수 없었다. 런타임 DB를 직접 수정하지 않았으며 후속 명령은 새 경로를 명시한다. 앱 기본 cwd 갱신은 미확인/남은 한계다.
- PR #4951의 리뷰·merge·배포 대기 상태는 유지한다. 기존 코드 검증 결과는 위 기록이며 경로 이동을 새 런타임 검증으로 간주하지 않는다.

## 다음 시작점

- 요청한 커밋·푸시·PR 생성 완료. PR #4951에서 사용자/팀 리뷰와 후속 지시를 기다린다. CodeRabbit 대기·폴링·자동 수정, merge·배포는 하지 않는다.
- 후속 명령은 반드시 `/Users/parkjongsun/Repository/dentlink-client-dl-17625`를 명시한다. 채팅 기본 cwd가 새 경로로 갱신됐는지는 다음 작업 시작 시 확인한다. 후속 수정은 현재 전달용 checkout/PR의 head를 확인한 뒤 수행한다. 원본 `feat/DL-17625`는 master 기반 구현 보존용이다. 활성 릴리즈 작업이므로 원본/전달용 branch·worktree를 임의 정리하지 않는다.
- 필요 사용자 QA: 내역이 있는 기공소 PC에서 배송/픽업의 목록·상세·배송 스캔 노출, 주문 이동 시 숨김, 배송/픽업 재진입 시 내역 유지. 실제 이벤트 갱신과 출력 작업 통합 확인은 수행 여부를 구분해 기록한다.
