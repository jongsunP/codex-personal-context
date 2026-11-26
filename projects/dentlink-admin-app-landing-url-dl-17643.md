# DL-17643 댓글 45364 — 관리자 웹 알림의 앱 랜딩 URL

## 현재 상태 — 2026-11-26 조사·준비 완료, 구현 지시 대기

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

## 최소 수정안 — 미적용

- `message.types.ts`: 확인된 명세를 바탕으로 기존 FE 파생 타입에 `appLandingUrl?: string`을 반영한다. 생성 파일 수동 수정·광범위 재생성은 하지 않는다. 구현 시 현재 생성 타입에 이미 반영됐는지 먼저 확인한다.
- `useMessageNotificationFields.tsx`: 기존 `랜딩 URL` 바로 다음에 `앱 랜딩 URL`(`appLandingUrl`) 텍스트 열을 같은 260px 방식으로 추가한다. API/query/page/공통 표 로직 변경은 필요 없다.
- 기존 DataGrid는 null/undefined/빈 문자열을 `-`로 표시하고 줄바꿈·가로 스크롤을 처리한다. 앱 실행 링크·클릭 동작을 새로 넣지 않는다.
- 화면과 CSV가 같은 `columns`를 사용하므로 이 열은 기존 Export에도 자동 포함된다. CSV 전용 기능 추가는 없다.
- 구현 승인 후 변경 파일 정적 검사와 필수 Admin DLOS guard 등 변경 크기에 맞는 확인을 수행한다. 현재 조사에서는 실행하지 않았다.

## 기존 작업과 접점·다음 시작점

- [DL-16140 정본](dentlink-unified-notification-center.md) 최신 기록상 PR #4953은 11/26 release/v1.95.0에 병합됐다. `git show origin/release/v1.95.0`으로 이번에 직접 본 범위는 동일 웹 알림 컬럼과 소비 타입뿐이며 읽음일시/이벤트 코드 확장이 있다. 해당 release에서도 appLandingUrl 표시는 없다.
- 현재 master에는 그 확장이 없으나 이번 appLandingUrl 열 추가의 선행 조건은 아니다. release/다른 기능을 임의로 합치지 않고 별도 작업 상태를 유지한다. 추후 PR 통합 시 같은 파일의 추가 필드/열을 보존한다. 다른 소유 worktree는 수정하지 않았다.
- 다음: 사용자가 구현을 요청하면 이 worktree에서 위 두 지점만 최소 반영한다. 실제 STG 응답 확인 여부와 FE 구현/검증/배포 상태는 별도로 보고한다.
