# 치과 웹 완료·취소 주문 지연 라벨 — DL-17141

## 현재 체크포인트 — 2026-11-05

- **완료:** [일반 PR #4835](https://github.com/Innvoaid/dentlink-client/pull/4835)을 `feat/DL-17141 → release/v1.92.0`으로 생성·첨부했다. 실제 base/head/isDraft:false/변경 한 파일을 재조회했다. 사용자 최종 지시도 v1.92.0 PR까지이며 이후 직접 확인 예정이다.
- **현재 영향:** 구현은 feature branch와 PR에만 존재한다. merge·웹 배포·Staging/운영 서빙 검증·자동 CodeRabbit 대응은 하지 않았다. 앱 네이티브 PR/CodePush와 웹 상세 전달을 혼동하지 않는다.
- 세션: `치과 웹 완료·취소 주문 지연 라벨`, `01a1aa21-0ebc-75c0-9791-e5b21e524224`. local Mac / 메인 프로젝트 등록과 초기 실행 확인. 메인 세션이 gpt-6-astra/ultra 적용 확인을 기록했다.
- 승인: 웹 구현·검증·commit/push·`release/v1.92.0` 대상 일반 PR까지. merge·배포·자동 CodeRabbit 대응은 제외한다. 앱은 별도 DL-17248 세션 담당이다.
- 요구: OFFICE 서비스의 `isDelayed === true`이면서 `COMPLETED` 또는 `CANCELED`이면 Delayed 라벨만 숨긴다. 기존 false/undefined의 On Time, 날짜·진행 중 표시, LAB 동작 유지.
- 정본: [DL-17141](https://innovaid.atlassian.net/browse/DL-17141), [DL-17138](https://innovaid.atlassian.net/browse/DL-17138). 현재 원문 기준 Frankie 확정 댓글은 부모의 `44831`이다(접수 인계의 44828 참조와 다름). 원문·본문·댓글 실조회 완료.
- checkout: `/Users/parkjongsun/Repository/dentlink-client`. 기존 `feat/e2e-deploy-status@65dd71ddf` clean/upstream 동일 확인 후 보존. 최신 `origin/master@c5a4b5e372fb7734c72a5faec6807e7b554c1dd6`에서 `feat/DL-17141` 생성 확인. 시작 시 동명 local/remote 없음. PR 대상 최신 조회 `origin/release/v1.92.0@05243d50c4125166d723a4c3ed683bdd17cf75f3`.
- 최종 HEAD/upstream: `488575e8fb53fd85d31efa58dc2828d1948e8244`, clean·origin/feat/DL-17141 동일. 구현 커밋 `d80e110eb` + release 이력 통합 커밋 `488575e8f`. 기존 master 배포/E2E 작업과 release의 별도 squash 이력 때문에 보이던 선행 7파일을 제거하기 위해 대상 release를 feature에 merge했다. master 기반 출발과 기존 브랜치는 보존했다.
- 실제 변경: `shared/ui/src/OrderDetailUI/parts/BoxComponent/OrderDetailBoxDeliverySchedule.tsx` 한 파일 6줄 추가·1줄 삭제. PC/모바일 주문목록은 변경 없이 회귀 확인했다.
- 비파괴 통합 확인: 최신 release `05243d50c4125166d723a4c3ed683bdd17cf75f3` 기준 `git merge-tree --write-tree` 결과 `496080f224add315fa115383600c68e5a86905d5`가 HEAD tree와 동일하다.
- 남은 일: 사용자 PR 확인 및 별도 승인 시 merge/웹 배포. 앱 상세 WebView는 웹 배포 후 변경을 소비하므로 현재 Staging/운영 상세가 수정됐다고 보고하지 않는다. 자동 리뷰/배포 감시나 브랜치 정리를 시작하지 않는다.

## 검증·전달 — 최종 코드 기준

- 실제 소스의 조건식을 추출해 OFFICE/LAB/서비스 누락 × 완료/취소/진행/배송/승인대기/신규/상태 누락 × true/false/undefined × 날짜 유무 × 제작 전 예외를 조합한 567건을 확인했다. 기존 대비 변경되는 케이스는 OFFICE·지연 true·완료/취소뿐이었다.
- 실제 Next 로컬 페이지에서 저장된 DEV OWNER 로그인 재사용을 확인했다. 원본 완료·On Time 상세를 읽은 뒤, 브라우저 내부 GET 응답만 대체해 PC1440/모바일390 상세 14개 고유 조건과 목록8행(각 4행)을 검증했다. 완료·취소 true는 두 라벨 모두 없음, false/undefined는 기존 On Time, 진행중 true는 Delayed, 날짜없음/제작전은 기존 미표시. 날짜·상태 그래프 유지. uncaught page error 0.
- 업무 쓰기 요청은 테스트 context에서 차단했다(상세 자동 채팅 읽음 POST 포함). 인증 refresh만 정상 허용했다. 실제 서버 데이터를 바꾸거나 실제 계정 E2E를 실행하지 않았다. 브라우저 응답 대체는 해당 테스트 context에만 적용되므로 앱/다른 브라우저에는 적용되지 않는다. 실제 LAB 화면·앱 기기 WebView·다른 실제 권한 계정 검증은 이번 웹 화면 결과에 포함하지 않는다.
- 최종 Clinic/Lab/Admin 타입 검사 통과. `pnpm install --frozen-lockfile`로 release의 jszip 의존성을 설치한 뒤 재검증했다(설치 전 Clinic의 누락 모듈 오류 해소, 추적 파일 변화 없음).
- 관련 Jest: OrderDetailPage, useOrderDetailPermissions, useOrderShowQuery 3 suite·32 tests 통과. 독립 코드리뷰에서 조치 필요 결함 없음.
- 변경 파일 lint는 shared/ui의 기존 parent 설정 중복 플러그인 충돌을 확인한 뒤 해당 패키지 명시 설정으로 실행(`eslint <file> --no-eslintrc -c .eslintrc.cjs`)하여 통과. format/diff-check 통과. 전역 lint 설정은 수정하지 않았다.
- 정상 pre-commit 3서비스 타입 검사 통과. 정상 pre-push Clinic/Lab/Admin lint 통과(기존 warning 225/185/393, error0), Admin DLOS guard·shared coverage 검사 통과(config21+hook32 tests). hook 생략 없음.
- E2E 독립 영향 판정 최종 `NO_IMPACT`: 주문 상태 변경·피드백·링크톡의 기존 버튼/문구/API 접점 유지. E2E 파일 변경·실행 없음. `mark.sh NO_IMPACT release/v1.92.0 feat/DL-17141` 및 PR 생성 직전 check 통과.
- Jira 하위 DL-17141 댓글 `44832`에 비개발자용 결과·PR·미배포 사실을 남겼다. 부모 댓글·원문 수정은 하지 않았다. Jira 상태는 CHECK REQUEST를 유지했다.
- 로컬 증거(임시): `/tmp/dl-17141-qa/detail-results.json`, `list-results.json`, 영역 캡처 PNG, `push.log`. 화면 캡처는 배송 일정/합성 목록 영역만이며 인증자료를 포함하지 않는다.

## 로컬 연결·다음 시작점

- 개발 서버 cwd `/Users/parkjongsun/Repository/dentlink-client/clinic`, `pnpm --filter dentlink-clinic-web dev --port 3000`. 최종 확인 프로세스 PID39356, 로그 `/tmp/dl-17141-qa/clinic-server.log`. 필요한 앱 WebView 확인을 위해 유지했다. PID는 재사용 전에 소유/cwd/port를 다시 확인한다.
- Mac/iOS simulator: `http://localhost:3000/orders/{id}`. Android emulator: `http://10.0.2.2:3000/orders/{id}`. 로컬 웹은 기존 DEV env를 사용하며 Staging 토큰/계정과 별개다. 브라우저 fixture를 앱 실검증으로 확대하지 않는다.
- 에이전트 테스트 browser는 종료했다. 사용자의 기존 IDE·서버·창배치를 바꾸지 않았다. 초기 개인 기록 `d3e1e8b` 이후 이번 완료 기록도 이 파일만 commit/push한다.
