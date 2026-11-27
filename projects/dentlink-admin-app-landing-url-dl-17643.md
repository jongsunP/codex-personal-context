# DL-17650 — 관리자 웹 알림의 앱 랜딩 URL (DL-17643 댓글 45364 후속)

## 현재 상태 — 2026-11-27 최종 정리·메모리 동기화·대기

- 사용자가 PR4990 병합·배포 완료에 이어 Jira 카드 상태도 직접 변경했다고 확인했다. 정확한 최종 Jira 상태명과 배포 환경은 별도로 조회하지 않았으며 사용자 완료 확인으로 기록한다. 아래 Ready for Deploy는 이전 직접 관찰 상태로, 현재 상태로 해석하지 않는다.
- “정리하고 메모리하고 대기” 요청에 따라 작업을 마감한다. DL-17650 앱 랜딩 URL 표시 및 DL-17644 회원 상세 읽음 표시의 구현·PR 기록이 보존됐고, DL-17644 병합·배포·Jira 상태 정리는 사용자 확인으로 완료됐다. 남은 승인된 작업 없음.
- 최종 로컬 확인: 기존 worktree `/Users/parkjongsun/Repository/dentlink-client-dl-17643-app-landing-url/dentlink-client`, branch `feat/DL-17644`, HEAD `d745b8626c2fe89ce3d29ba096b48d46f4086b05`, clean. 작업 폴더·브랜치를 보존한다. 제품 코드/원격 branch 삭제, archive, 추가 Jira 쓰기는 하지 않는다.
- 사용자 검증 생략 유지. 실제 화면/실응답 검증, 리뷰·CI·배포 모니터링, 메인 세션 보고 없이 다음 명시 요청까지 대기한다. 재개 시 이 체크포인트에서 요청 범위에 필요한 현재 상태만 확인한다.
- 개인 Git 정본과 Claude 메모리에 동일 마감 내용을 반영하고, Codex 보조 메모리에는 별도 업데이트 노트를 남긴다.

## 이전 상태 — 2026-11-27 사용자 병합·배포 완료 확인

- 사용자가 “머지 및 배포했음”으로 DL-17644 / PR4990의 병합·배포 완료를 알려 주었다. 사용자 확인 기준으로 완료 기록한다. 배포 환경·배포 SHA·실제 화면 동작은 이번 턴에 독립 확인하지 않았으며 추정하지 않는다.
- 구현·커밋·push·PR·Jira 정리에 이어 사용자 병합·배포까지 완료. 추가 구현 요청이나 남은 승인된 실행 없음. 검증 생략 지시 유지, 자동 GitHub/CI/서버 조회·테스트·리뷰 추적 없이 대기한다.
- 기존 worktree와 feat/DL-17644는 유지한다. 제품 Git·Jira를 이번 턴에 변경하지 않았으며, Jira의 마지막 직접 확인 상태는 Ready for Deploy이다. 다음 명시 요청 때 필요한 상태만 갱신한다.

## 이전 상태 — 2026-11-27 DL-17644 커밋·푸시·PR 및 Jira 정리 완료

- 사용자 “커밋푸쉬 PR 진행해줘”, “지라도 상태 및 제목등 정리 다시해줘” 승인으로 진행했다.
- 제품 commit `d745b8626c2fe89ce3d29ba096b48d46f4086b05` (`fix: 회원 상세 알림 타임라인 읽음 여부 표시`), branch `feat/DL-17644`, 원격 동일·clean. [PR4990](https://github.com/Innvoaid/dentlink-client/pull/4990): `feat/DL-17644` → `release/v1.95.0`, 일반 OPEN, 한 파일 +3/-6. 같은 checkout/cwd 유지. 병합·배포 없음.
- 사용자 검증 생략에 따라 commit/push 명령에만 HUSKY=0 적용. E2E 가드 SKIPPED 기록 및 PR 생성 전 마커 검사 통과. 타입·테스트·브라우저 실검증을 수행했다는 의미는 아니며, 미실행 항목을 PR 본문에 명시했다.
- DL-17644 제목을 `[FE] 관리자 회원 상세 알림 읽음 여부 표시`로 정리하고, 관리자 웹 범위·기대 표시·별도 DL-17650 구분을 본문에 반영했다. 기존 요청과 두 첨부 이미지는 보존했다. HTML 도구가 목록 내부 이미지를 누락하는 문제가 있어, 원래 media ID 그대로 최상위 figure로 복원했고 반환 HTML에서 두 참조를 확인했다. ADF 형식은 도구 안내와 달리 현재 connector schema가 거절하여 사용하지 않았다.
- 상태는 개발 완료 transition12에 따라 `Ready for Deploy`. [댓글45394](https://innovaid.atlassian.net/browse/DL-17644?focusedCommentId=45394)에 PR·변경 결과·미병합/미배포·검증 생략 기록. Frankie 담당·상위 DL-17643 관계는 유지, 다른 카드·상위 본문/댓글 무변경.
- 남은 일: PR 리뷰/병합 및 배포는 별도 요청 시 진행. 자동 리뷰/CI/배포 폴링 없음.

## 이전 상태 — 2026-11-27 DL-17644 읽음 표시 로컬 구현 완료

- 사용자 지시로 상위 DL-17643 및 하위 DL-17644/17648/17650을 읽기 전용 확인한 뒤, “작업 진행해줘”에 따라 FE 읽음 표시를 구현했다. Jira 본문·댓글·부모 관계는 변경하지 않았다.
- Jira 근거: DL-17643 댓글45392(Leo, 11/27 18:32 KST)는 알림 로그 메뉴와 유저 상세 알림 히스토리 모두 BE 반영 완료라고 확인한다. DL-17648은 완료. Frankie 담당 DL-17644 본문에는 읽음 상태 업데이트와 앱푸시 SENT 대신 읽음 표시가 있고, 댓글45359는 회원 상세 발송 이력에도 적용 검토를 요청한다. 본문 첨부32064/32063을 직접 열어 두 화면 모두 회원 상세 Activity timeline임을 확인했다. 서버 완료 댓글과 실제 환경 응답 관찰은 구분한다.
- 기존 PR4969는 GitHub 직접 조회 결과 11/26 18:25:52 KST 병합 완료(merge 4aeb7beef04d6364a0fe539497b14d8e7f0189ba). 아래 11/26의 미병합 기록은 당시 상태다.
- 같은 worktree·채팅 cwd를 유지하고, 별도 미완료 FE 카드용 `feat/DL-17644`를 최신 `origin/release/v1.95.0@64fbf80fb8c7464dbb56784b4c8e4a482826df7b`에서 생성했다. 동일 로컬/원격 브랜치 및 다른 worktree 소유 없음 확인. 기존 feat/DL-17650 보존. 새 branch의 release 추적 설정은 제거하여 의도치 않은 release push를 방지했다.
- 현재 제품 변경은 `admin/src/components/CRM/CrmNotificationTimeline.tsx` 한 파일, 미커밋이다. 앱푸시 `push.status` 대신 `formatMessageReadStatus(push.isRead)`를 표시하고 웹알림도 같은 기존 함수를 재사용한다. boolean true=읽음, false=안읽음, 누락/null/비boolean='-'. 기존 표시 위치·스타일과 그 외 메시지 상태는 유지한다.
- release의 알림 로그 목록에는 웹/앱푸시 읽음 여부·읽음일시가 이미 있어 추가 수정하지 않았다. 타입과 API 호출 경로도 기존 것으로 충분하다. 웹알림의 정상 boolean 표시는 원래 있었으므로 이번 수정이 BE의 읽음 상태 갱신 자체를 해결했다는 주장은 하지 않는다.
- 사용자 “e2e나 검증 그냥 넘겨줘” 지시를 유지해 E2E·타입/정적 검사·브라우저·실응답 확인을 실행하지 않았다. 변경 diff와 호출 경로만 읽었다. 제품 커밋·push·PR 생성·병합·배포는 하지 않았다. DL-17650의 기존 PR 승인과 이번 새 카드 범위를 구분한다.
- 다음 시작점: 같은 checkout의 feat/DL-17644에 로컬 수정이 있다. 사용자 후속 지시에 따라 이 변경의 commit/push 및 release/v1.95.0 대상 PR을 진행한다. 테스트 생략 유지, 자동 모니터링 없음.

## 이전 상태 — 2026-11-26 구현·PR·리뷰 처리 완료, 사용자 요청으로 정리·대기

- 사용자 “메모리하고 정리하고 대기” 지시로 요청 범위를 마감한다. 구현·PR4969 생성·CodeRabbit 오탐1건 근거 회신/resolve 완료이며, 리뷰 마감 시 한 차례 재확인한 미해결 스레드는 0건이다. 이번 저장 턴에서는 외부 상태를 다시 조회하지 않았다.
- 현재 재개 위치는 `/Users/parkjongsun/Repository/dentlink-client-dl-17643-app-landing-url/dentlink-client`, branch `feat/DL-17650`, 마지막 확인 HEAD `5b06dc1624bfd3cede405b5963f3eca06f31cc8a`. 미병합 PR 후속을 위해 worktree·branch·env를 보존하며 채팅을 보관하거나 작업 폴더를 삭제하지 않는다.
- 병합/배포 및 STG 실응답·화면·CSV 확인은 완료 범위 밖이다. 사용자 검증 생략 지시를 유지하고 추가 실행·리뷰/CI 추적·메인 보고 없이 대기한다. 다음 명시적 요청이 오면 필요한 현재 상태만 확인해 이어간다. 개인 Git 정본·Claude 메모리·Codex 보조 메모리에 마감 상태를 기록한다.

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

## 최초 세션·작업 공간 준비 이력 — 현재 브랜치는 위 재개 위치 참조

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
