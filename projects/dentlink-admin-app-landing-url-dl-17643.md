# DL-17650 — 관리자 웹 알림의 앱 랜딩 URL (DL-17643 댓글 45364 후속)

## 현재 상태 — 2026-11-26 구현·PR 완료

- **CodeRabbit 리뷰 처리 완료(11/26):** PR4969 HEAD `5b06dc1`의 actionable 1건(빈 값이 undefined/빈 셀로 표시된다는 지적)은 오탐이다. 실제 `/notifications/web` → DataGrid.DataList는 tooltip 컬럼이 없어 DLOS `toDataTableColumns` 경로를 사용한다. `dataList.utils.ts:30-43,64-70`에서 null/undefined/문자열 undefined/빈 문자열·공백을 이미 `-`로 처리하고 정상 URL은 그대로 표시한다. 레거시 `DataTableRow.tsx:150-156`에도 동일 후처리가 있어 그 경로 설명도 잘못됐다. [근거 회신](https://github.com/Innvoaid/dentlink-client/pull/4969#discussion_r4704932731) 후 스레드 `PRRT_kwDOJnA7-868QPE4` resolve. 제품 코드·커밋 변경 없이 유지했고 사용자 검증 생략 지시대로 테스트/브라우저는 실행하지 않았다. 팀 승인·병합·배포와 구분한다.

- 사용자가 직접 만든 [DL-17650](https://innovaid.atlassian.net/browse/DL-17650)의 브랜치로 변경하고 1.95.0 대상 PR까지 승인했다. 현재 카드 제목은 `[FE] 관리자 알림로그에 appLandingUrl 컬럼추가`, 사용자 담당 하위 카드이며 상위는 DL-17643이다.
- **[PR #4969](https://github.com/Innvoaid/dentlink-client/pull/4969)** 생성 완료: `feat/DL-17650` → `release/v1.95.0`, 일반 Open PR, commit **`5b06dc1624bfd3cede405b5963f3eca06f31cc8a`**, 1커밋·2파일·6줄 추가. merge/deploy는 하지 않았다.
- 기존 미커밋/미푸시 준비 브랜치를 `feat/DL-17650`으로 이름 변경했다. master가 release보다 앞서 있던 무관한 4커밋/8파일을 제외하기 위해 변경 전 빈 브랜치를 `origin/release/v1.95.0@e5a880cb13153a491668cb10e5f404c8abe9564d`로 정렬했다. 사용자도 “릴리즈에서 따서 수정해서 릴리즈로 향하게” 하는 방식을 명시 확인했다. 기존 worktree 실경로·채팅 cwd는 유지, 다른 checkout/remote release 변경 없음.
- 변경: `admin/src/lib/Message/useMessageNotificationFields.tsx`에서 기존 `랜딩 URL` 바로 다음에 `앱 랜딩 URL` 텍스트 열(260px) 추가. `shared/models/src/message/message.types.ts`의 기존 FE 파생 타입에 `appLandingUrl?: string` 추가. 빈 값은 기존 `-`, 동일 컬럼 사용 CSV에 자동 포함. API·query·공통 표·생성 타입·앱 랜딩 동작 변경 없음. release의 읽음일시·이벤트 코드는 그대로 보존했다.
- 완료된 검증: Clinic/Lab/Admin 타입 검사(pre-commit), Admin DLOS guard(60/60), 두 파일 Prettier·diff-check. E2E 가드 스킬의 읽기 전용 서브에이전트는 **NO_IMPACT** 판정, 마커 기록 및 check 통과. 현재 E2E는 관리자 알림 표를 사용하지 않으며 이 열·선택 타입 추가는 기존 흐름에 영향을 주지 않는다. 실제 E2E는 실행하지 않았다.
- **사용자 검증 생략 지시:** 커밋 완료·최초 push hook 실행 도중 “e2e나 검증 그냥 넘겨줘” 요청. 진행 중인 shared coverage를 SIGINT로 중단하고 같은 검사를 재시도하지 않았다. 이후 `HUSKY=0`을 해당 push 한 번에만 적용해 정상 push했다. 영구 훅/설정은 변경하지 않았다. 이미 완료된 검사와 중단·미실행 검사를 구분하며 추가 테스트/리뷰 폴링은 하지 않는다.
- 로컬 준비: offline/frozen-lockfile/ignore-scripts 의존성 설치(잠금파일 변경 없음), 기존 Husky 설치. 첫 pre-commit은 새 checkout의 ignored `next-env.d.ts` 부재로 PNG 타입 해석 실패했다. 설치된 Next의 기본 타입 생성 함수로 세 서비스의 ignored `next-env.d.ts`만 생성한 뒤 정상 통과했다. 실제 env 값 열람/변경·서버/브라우저 실행 없음. 상세 로그 `/tmp/dl17650-commit.log`, `/tmp/dl17650-push.log`는 로컬 임시 증거다.
- DL-17650에 [진행 댓글 45365](https://innovaid.atlassian.net/browse/DL-17650?focusedCommentId=45365)로 표시 변화·PR·완료한 검사·중단한 검사를 기록했다. 상위 댓글·카드 제목/본문/상태는 변경하지 않았다.
- 현재 영향: 코드/원격 feature/PR에만 존재하며 아직 release 병합·환경 반영 없음. STG 실응답·실제 화면·CSV 다운로드 검증은 미실행이다. 사용자 요청대로 PR 준비에서 멈추고 다음 명시 지시를 기다린다. 자동 리뷰·CI·배포 추적 없음.

## 이전 상태 — 2026-11-26 조사·준비 완료, 구현 전

- 대상: [Leo 댓글 45364](https://innovaid.atlassian.net/browse/DL-17643?focusedCommentId=45364). 관리자 `/notifications/web?page=1`에 기존 랜딩 URL과 함께 `appLandingUrl`도 표시해 달라는 제안이다. 댓글 원문은 메인이 같은 날 직접 읽어 인계했다.
- 사용자 후속 요청: 서버가 주는 `appLandingUrl`이 표시되지 않던 것인지 먼저 조사하고, 맞으면 기존 랜딩 URL 옆에 적절하게 추가 가능한지 순서대로 확인. 현재는 조사·별도 worktree/branch 준비만 승인됐다. 제품 코드 수정·테스트·commit/push/PR·Jira 쓰기·배포는 수행하지 않았다.
- 읽음 개선, 전체 알림센터, 네이티브 앱, 발송/딥링크 정책은 범위 밖이다. 조사 후 사용자에게 직접 보고하고 다음 구현 지시를 기다린다. 메인에 자동 진행 전달·폴링하지 않는다.

## 세션·작업 공간

- 채팅: `01a2169c-f4aa-7d40-a5cf-1141de706c9a`, **관리자 앱 랜딩 URL 표시 · DL-17643 후속**, host `local`, 메인과 같은 프로젝트 `4a13e754-960d-4ca3-b716-8f7a19311b64` 등록 확인.
- 현재 turn 실행 메타데이터에서 `gpt-6-astra` / `xhigh` 확인.
- 원본 `/Users/parkjongsun/Repository/dentlink-client`는 clean master 유지. fetch만 수행했고 checkout을 전환하거나 pull로 이동하지 않았다.
- `create_worktree`로 만든 실제 checkout: `/Users/parkjongsun/Repository/dentlink-client-dl-17643-app-landing-url/dentlink-client`.
- 브랜치: **feat/DL-17643-app-landing-url**, 생성 시 최신 `origin/master`인 `023057ab6109e54d263079a6c64c139407f02a6b`에서 시작. 같은 이름의 기존 로컬/원격 branch가 없음을 먼저 확인했다. upstream 없음, clean.
- 실제 폴더, Git worktree 등록, `read_thread`의 persisted cwd가 모두 위 checkout을 가리킨다. main chat cwd는 변경하지 않았다.
- 같은 저장소 main의 ignored/untracked 로컬 env 6개를 승인된 스크립트로 복사·동일성/ignore 확인: admin/clinic/lab `.env.development`, lab `.env.local`, e2e `.env.development`·`.env.staging`. 값 열람/출력/변경 없음. 의존성 설치·서버·테스트 실행 없음.

## 확인한 데이터·화면 경로

1. `admin/src/pages/notifications/web/index.tsx` → `useNotificationListQuery` → `MessageApisAdmin.findNotificationList` → `GET /admin/messages/notifications`. API wrapper는 `res.data`를 그대로 반환하므로 `appLandingUrl`을 제거하는 변환은 없다.
2. `admin/src/lib/Message/useMessageNotificationFields.tsx`에는 `landingUrl`/`랜딩 URL`/260px 열만 있다. `appLandingUrl` 열이 없어 응답에 있더라도 표에 표시되지 않는다. 기존 URL은 클릭 링크가 아닌 텍스트다.
3. 소비 타입 `shared/models/src/message/message.types.ts`의 `NotificationListDto`는 생성된 `NotificationListAdminDto`의 별칭이다. 현재 master의 `shared/models/src/data-contracts.ts` 해당 DTO에는 `landingUrl`만 있고 `appLandingUrl`은 없다. 다른 DTO의 같은 이름 필드는 이 목록의 계약으로 대체하지 않았다.
4. **11/26 직접 HTTP GET한 [DEV Swagger](https://dev-api.dentlink.io/v3/api-docs)는 200**. 해당 GET의 200 response는 `ApiPageResponseListNotificationListAdminDto`, `NotificationListAdminDto.appLandingUrl`은 `type: string`, 설명 `앱 딥링크`, 예시 `dentlink://order/20/123`. required 목록 및 명시적인 nullable 선언 없음. checked-in 생성 타입보다 현재 DEV 명세가 앞서 있다.
5. **STG 실제 목록 응답의 필드/값은 미확인**이다. 명세에 필드가 있다는 사실과 실제 STG row에 값이 내려온다는 관찰을 구분한다. 현재 연결된 브라우저에는 관리자 탭이 없었고, 재사용용 로컬 저장 계정은 DEV Clinic/Lab/Office/Lab뿐으로 STG Admin 인증을 찾지 못했다. 일반 브라우저 쿠키/비밀번호 추출·화면 점유·새 로그인 시도는 하지 않았다. 재확인이 필요하면 사용자 확인하의 STG 관리자 세션 또는 승인된 인증으로 목록 GET만 읽는다.

## 최초 최소 수정안 — 위 구현으로 완료

- `message.types.ts`: 확인된 명세를 바탕으로 기존 FE 파생 타입에 `appLandingUrl?: string`을 반영한다. 생성 파일 수동 수정·광범위 재생성은 하지 않는다. 구현 시 현재 생성 타입에 이미 반영됐는지 먼저 확인한다.
- `useMessageNotificationFields.tsx`: 기존 `랜딩 URL` 바로 다음에 `앱 랜딩 URL`(`appLandingUrl`) 텍스트 열을 같은 260px 방식으로 추가한다. API/query/page/공통 표 로직 변경은 필요 없다.
- 기존 DataGrid는 null/undefined/빈 문자열을 `-`로 표시하고 줄바꿈·가로 스크롤을 처리한다. 앱 실행 링크·클릭 동작을 새로 넣지 않는다.
- 화면과 CSV가 같은 `columns`를 사용하므로 이 열은 기존 Export에도 자동 포함된다. CSV 전용 기능 추가는 없다.
- 구현 승인 후 변경 파일 정적 검사와 필수 Admin DLOS guard 등 변경 크기에 맞는 확인을 수행한다. 현재 조사에서는 실행하지 않았다.

## 기존 작업과 접점·다음 시작점

- [DL-16140 정본](dentlink-unified-notification-center.md) 최신 기록상 PR #4953은 11/26 release/v1.95.0에 병합됐다. `git show origin/release/v1.95.0`으로 이번에 직접 본 범위는 동일 웹 알림 컬럼과 소비 타입뿐이며 읽음일시/이벤트 코드 확장이 있다. 해당 release에서도 appLandingUrl 표시는 없다.
- 현재 master에는 그 확장이 없으나 이번 appLandingUrl 열 추가의 선행 조건은 아니다. release/다른 기능을 임의로 합치지 않고 별도 작업 상태를 유지한다. 추후 PR 통합 시 같은 파일의 추가 필드/열을 보존한다. 다른 소유 worktree는 수정하지 않았다.
- 당시 다음 단계였던 구현·PR은 위 현재 상태대로 완료했다. 이후 사용자 지시에 따라 PR 리뷰/병합/배포 또는 필요한 검증만 재개한다.
