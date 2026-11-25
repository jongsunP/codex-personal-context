# 기공소 배송 업데이트 내역 패널 노출 제한 — DL-17625

## 현재 상태 — 2026-11-25 구현·검증 완료, 제품 미커밋

- 세션 `기공소 배송 업데이트 패널 노출 · DL-17625` (`01a21141-e9b6-7ab0-becc-65412540bce1`), 메인 프로젝트 폴더/local. 메인이 등록·최초 turn과 생성 시점 모델/추론 `gpt-6-astra`/`xhigh` 일치를 확인했다. 이 세션이 구현과 후속 작업을 소유하며 사용자에게 직접 보고한다. 메인은 추가 폴링하지 않는다.
- 사용자 요청: [DL-17625](https://innovaid.atlassian.net/browse/DL-17625)를 확인하고 별도 세션·별도 worktree에서 작업한다. 다른 작업 공간은 사용 중이므로 보존한다. 구현·검증 및 작업 공간 준비 승인, 제품 commit/push/PR/merge/배포는 별도 지시 범위로 구분한다.
- 전용 worktree의 `feat/DL-17625`에서 패널 및 기존 테스트 2파일을 수정했다. 테스트 22개, 변경 파일 ESLint, Lab 전체 타입 검사, `git diff --check` 통과. 제품 commit/push/PR/merge/배포는 하지 않았다. 현 운영 서비스에는 아직 반영되지 않았다.
- Jira 본인 하위카드에 작업 정의를 정리하고 구현·검증 범위 댓글 `45313`을 기록했다. 실제 작업 중 `진행 중`으로, 구현 검증 완료 후 `Ready for Deploy`로 전환했다. 이는 개발 완료 의미이며 리뷰·통합·배포 완료 의미가 아니다. 상위 댓글·Slack 쓰기는 하지 않았다.

## 요구사항 근거

- 접수 시 본인 하위 DL-17625는 Frankie 담당·해야 할 일·본문/댓글 없음이었다. 상위 [DL-17624](https://innovaid.atlassian.net/browse/DL-17624)에 ‘배송 + 픽업 페이지에서만 노출’이 명시되어 있다. 상위 댓글45287에서 Tom이 1.95.0 연결 및 라벨 작업과 함께 진행 요청을 남겼다. 사용자는 별도 작업 세션/worktree를 지시했으므로 라벨 브랜치에 합치지 않는다.
- [Slack 원문](https://innovaidhq.slack.com/archives/C04T5SU6A2U/p1794386830573219): 모든 페이지에 패널이 나타나 CTA를 가리는 문제. 최종 Tom 답변은 배송·픽업 페이지만 노출. 패널 제거·알림으로 대체는 사용성 확인 이후 고려할 별도 제안이며 이번 구현 요구가 아니다.

## 제품·작업 공간

- 대상은 `dentlink-client`의 기공소 웹 전역 `FloatShipmentCreateController`다. 현행 mobile 제외 조건이 있고 `_app.tsx`에서 인증 후 전역으로 렌더한다. 치과/어드민/네이티브 앱 변경은 현재 확인된 범위가 아니다. 기존 모바일 미노출을 임의로 확장하지 않는다.
- 원본 `/Users/parkjongsun/Repository/dentlink-client`의 `feat/DL-17583`는 출력 세션이 사용 중이며 미커밋 변경이 있다. `notification-history-followup` worktree의 `feat/DL-16140-history-followup`도 다른 세션 소유다. 어느 쪽도 재사용·수정하지 않는다.
- 실제 managed worktree: `/Users/parkjongsun/.codex/worktrees/dl-17625-shipment-panel/dentlink-client`. `create_worktree`의 등록 오류 없음 확인 후 정확히 `feat/DL-17625`를 생성·검증했다. 이 경로에서만 제품 파일을 수정했다.
- 최신 원격 fetch 후 base/HEAD=`9084878eaa93ea4fe39df0f376afa4456c5fec55` (`origin/master`), 예정 PR 대상 `origin/release/v1.95.0`=`b0e04eafe00e86836f472bea114e5fce867b4cad`. 작업 브랜치 원격·upstream 없음. 패널/테스트/배송 hook/`_app.tsx`는 두 ref 간 diff 없음. PR 생성 승인이 나면 전체 diff와 E2E 가드는 별도 확인한다.
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
- 검증 한계: 컴포넌트 테스트는 조회/SSE hook·하위 UI를 mock한다. 실제 계정 브라우저, 서버 SSE 수신, 실배송·픽업 처리, 시각적 가림 여부 E2E는 실행하지 않았다. 코드 검토와 DOM 테스트 결과를 실제 운영/QA 검증으로 확대하지 않는다.
- 통합 접점: 출력 세션은 인접 `FloatShipmentCreateControllerLabelItem.tsx`, `shipping/index.tsx`, `Shipping/Scan/ShippingScan.tsx` 등을 수정 중이다. 이 세션은 해당 내용을 가져오거나 수정하지 않았다. 통합 때 배송/스캔에서 출력 패널과 함께 쓰는 동작을 확인한다.

## 다음 시작점

- 사용자에게 현재 미커밋 구현 결과를 보고하고 다음 지시를 기다린다. 제품 커밋·push·PR·merge·배포는 승인되지 않았다.
- 커밋/PR 요청 시 이 worktree의 2파일과 현재 원격 release 전체 diff를 확인한다. 저장소 PR 스킬·E2E 영향 가드를 수행하고 예정 대상 `release/v1.95.0`을 검증한다. PR 생성 후 자동 리뷰/merge/deploy는 하지 않는다.
- 필요 사용자 QA: 내역이 있는 기공소 PC에서 배송/픽업의 목록·상세·배송 스캔 노출, 주문 이동 시 숨김, 배송/픽업 재진입 시 내역 유지. 실제 이벤트 갱신과 출력 작업 통합 확인은 수행 여부를 구분해 기록한다.
