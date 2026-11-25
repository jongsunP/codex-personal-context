# Dentlink 주문 피드백 수집 — DL-15828

치과 주문 피드백과 관리자 피드백 조회의 개인 체크포인트다. 2026-10-27 문서 정리에서
원문을 [이력 문서](archive/dentlink-client-order-feedback-history-through-2026-10-27.md)로
보존했다. 2026-09-28 구현·배포 이력과 아래 후속 코드 검토는 구분한다.
재개 시 live Git과 필요한 Jira·Figma·Swagger를 우선하고, 기획·구현·검증·병합·배포를 구분한다.

## 관리자 피드백 썸네일 QA — DL-17615 / 2026-11-25

- **커밋·push·PR 생성 완료, 리뷰/병합 대기.** [PR #4952](https://github.com/Innvoaid/dentlink-client/pull/4952): `feat/DL-17615 → release/v1.95.0`, OPEN/Ready for review/생성 직후 MERGEABLE. HEAD·remote `1e98dbf147e57f69ba1e976ef34d6895475b249b`, `fix: 관리자 피드백 썸네일 이미지 수정`, 관리자 summary 한 파일/한 커밋이다. 작업 트리는 clean, upstream은 `origin/feat/DL-17615`. 사용자가 FE 한 파일·기존 API 재사용·BE/데이터 변경 없음을 확인한 뒤 릴리즈 대상을 두 차례 확정했다. merge/배포·CodeRabbit 확인은 하지 않았으며 이번 요청은 PR 생성에서 종료한다.
- 소유 세션: `관리자 피드백 썸네일 수정 · DL-17615`, `01a2115e-9fc6-7062-9a3f-3f7d626a20e0`, 메인 프로젝트 폴더/local. 메인이 등록·최초 turn의 `gpt-6-astra`/`xhigh` 일치를 확인했다. 담당 세션에서 사용자에게 직접 보고하며 메인은 추가 폴링하지 않는다.
- 작업 공간: linked worktree `/Users/parkjongsun/Repository/dentlink-client-dl-17615`, branch `feat/DL-17615`, 초기 base `origin/master@9084878eaa93ea4fe39df0f376afa4456c5fec55`, 현재 base `origin/release/v1.95.0@b0e04eafe00e86836f472bea114e5fce867b4cad` 및 HEAD `1e98dbf147e57f69ba1e976ef34d6895475b249b`. `feat/DL-17583` main 및 알림 후속/배송 패널 worktree의 미커밋 변경·서버는 보존했다. 새 worktree에 eligible ignored/untracked env 6개를 불투명 복사하고 byte equality·ignore 및 대상 0600 권한을 확인했다. 값은 열람·변경하지 않았다. `pnpm install --frozen-lockfile --offline --ignore-scripts` 완료, lockfile 변경 없음.
- 2026-11-25 위치 이전: 사용자 지시에 따라 `git worktree move`로 위 Repository 경로에 물리적으로 이동했다. HEAD/branch/upstream(없음)/index/staged(없음)/unstaged diff/비ignore untracked(없음)/ignored 목록과 env 6개의 불투명 해시 동일성을 확인했다. 파일 메타데이터 차이는 Git이 갱신한 `.git` 연결 파일뿐이다. 제품 미커밋 수정 1개와 ignored 의존성/빌드 파일은 보존했고 실행 중인 전용 서버는 없었다. 새 경로 attachment·Git 등록을 확인하고 이전 attachment·빈 관리 폴더를 제거했다. **도구 한계:** `attach_worktree`는 새 첨부를 만들었으나 채팅 `cwd`는 이전 경로로 남았고 기본 경로 exec가 실패한다. CUA도 helper 시작 실패로 UI 갱신을 확인하지 못했다. 런타임 DB는 변경하지 않았다. 지원 도구/UI로 기본 cwd를 갱신하기 전까지 모든 명령에 새 절대 경로를 명시한다. 이동 당시 제품 미커밋/PR 대상 미확정 상태를 유지했으며 이후 진행은 최상단 기록을 따른다.
- 2026-11-25 경로 경고 후속: 재첨부 후에도 persisted cwd는 옛 경로였다. 앱 UI의 채팅 액션에는 경로 변경 항목이 없었다. 설치된 Codex CLI의 공식 app-server 스키마에서 `thread/settings/update.cwd`를 확인했지만 별도 연결의 설정 변경은 thread 미로드로 거부됐고 `thread/resume`은 기존 active writer 때문에 거부됐다. DB 직접 수정·빈 옛 폴더·symlink·새 세션은 만들지 않았다. 사용자가 오래 걸리면 코드 사용에 지장이 없는 범위에서 이번 건을 넘어가라고 하여 추가 복구 시도를 중단했다. 새 workdir 명시로 코드 작업은 가능하나 기본 cwd 실행과 CUA helper의 오류/앱 경고는 남는다. 사용자 재요청 전 자동 재시도하지 않는다.
- PR 범위·검증: master의 미통합 Lab hotfix 4파일이 diff에 섞여 본인 수정 커밋만 release 위로 rebase했다. 파일 blob 동일성과 최종 PR 한 파일/한 커밋/base·head 확인. 최종 Clinic/Lab/Admin 전체 타입·린트(오류 0, 기존 경고 있음), 파일 포맷, DLOS 가드60/60 및 가드 테스트9개, 공용 config77+hook92=169개 테스트 통과. release 원본에서 생성한 로컬 baseline 대비 커버리지 변화 없음. worktree의 Husky helper·Clinic/Lab Next 타입·coverage baseline 누락은 공식 로컬 준비로 해결했고 훅을 우회하지 않았다. 추가 제품 수정/lockfile 변경 없음.
- E2E 영향 가드: 스킬의 읽기 전용 agent가 최종 diff를 NO_IMPACT로 판정했다. Clinic 피드백은 별도 컴포넌트를, Billing은 Admin payments API를 사용해 해당 summary를 소비하지 않는다. mark 및 PR 생성 직전 check 통과. E2E 코드 수정·실제 실행 없음, 관리자 API/권한/STG 통합 검증과 구분. PR attachment 연결 완료, Actions/CodeRabbit 조회·자동 폴링하지 않았다.
- 요구 근거: [DL-17615](https://innovaid.atlassian.net/browse/DL-17615), Frankie 담당 하위 QA, 상위 DL-17290. 첨부32046/32048 원본을 현재 Atlassian 커넥터로 내려받아 실제 열람했다. 파란색 카테고리 `섬네일 이미지` 대신 보라색 `이미지` 표시 요청이다. 콘솔 로그32047은 원인 판별에 불필요하여 열지 않았다. DL-17612 키워드 건은 재개하지 않았다.
- 실제 STG 재현: Chrome 작업 전용 탭에서 로그인된 관리자 계정으로 `/feedbacks`의 보고 주문 `7000012905` 상세를 열어 파란 이미지 표시를 확인했다. `/categories/1203` Restorations의 `thumbnailFileId=38`, `imageFileId=225`를 첨부와 대조했다. 피드백 이미지 src와 카테고리 thumbnail src가 일치하고, 기대 이미지가 별도 `imageUrl`임을 확인했다. API 원문/고객 데이터/인증값은 저장하지 않았다.
- 원인·수정: Admin 공용 summary가 `feedback.order.categoryThumbnailUrl`을 직접 사용한 것이 원인이다. Clinic은 이미 catalog `categoryId → imageUrl`을 사용하며 Admin에도 같은 `useCatalogCategoryQuery`가 기존 주문/상품 가격 화면에 있다. 이 hook을 summary에 재사용해 해당 카테고리 `imageUrl`을 표시한다. API/DTO/질문/상태/저장 정책·공용 디자인시스템·다른 제품은 변경하지 않았다. 이미지가 없으면 기존 문서 아이콘, 70px 배경/58px 이미지 크기와 메타 정보는 유지한다.
- 영향 확인: `AdminUserFeedbackList`의 카드와 `AdminFeedbackDetailDrawer`가 summary를 공유한다. `/feedbacks`, 사용자/CRM 피드백, 주문 피드백에서 상세 drawer를 여는 경로도 같은 수정이 적용된다. `/feedbacks`의 표 자체는 이미지 열이 없으므로 수정하지 않았다.
- 검증: Admin 전체 `pnpm --filter dentlink-admin-web type`, 변경 파일 ESLint/Prettier, `pnpm check:admin-dlos`(60/60), `git diff --check` 통과. 초기 implicit-any 오류는 `ProductTypes.CategoryListSimpleDto` 명시로 해결한 뒤 최종 전체 타입 검사를 통과했다. 불필요한 복제 단위 테스트는 추가하지 않았다.
- 브라우저 검증: 임시 로컬 페이지에서 실제 summary·사용자별 목록·상세 drawer와 React Query 캐시의 합성 피드백을 사용했다. 올바른 카테고리가 배열 첫 항목이 아닌 경우에도 실제 STG 보라색 자산 선택/이미지 로드/58×58 표시를 확인했다. categoryId 누락, imageUrl 누락, 카테고리 미일치에서는 대체 아이콘을 표시했고 정상 데이터 복구·상세 열기/닫기·날짜/Rating 표시를 확인했다. 마지막 정상 상세 screenshot을 첨부 기대 이미지와 시각 대조했다.
- 검증 한계: 수정 코드를 STG 실데이터 API와 연결한 통합 검증·권한별 계정 확인·전체 E2E/배포는 수행하지 않았다. 로컬 catalog/피드백 데이터는 합성이며 실제 API 응답 성공 검증과 구분한다. 해당 임시 페이지와 localhost:3035 서버는 제거/종료했다(cwd도 전용 worktree/admin 확인). 기존 QA widget의 로컬 Jira 설정 누락 500, Next/TypeScript 권장 버전 및 공용 styled-components prop 경고는 관찰했으며 이번 변경에서 수정하지 않았다.
- Jira: [댓글45318](https://innovaid.atlassian.net/browse/DL-17615?focusedCommentId=45318)에 표시 기준과 로컬 확인 범위를 간단히 기록했다. 기존 본문·첨부·상태는 보존했고 상위 댓글/Slack 쓰기는 하지 않았다. Claude 메모리 `project_dl17615_admin_feedback_thumbnail.md`에도 동일 최종 상태를 기록했다.

## Sample Case 키워드 추가 영향 검토 — 2026-11-24

- **마감:** 사용자가 검토 내용을 담당자에게 전달했고 이번 건을 검토 완료로 확정했다. 현재 요청 범위에서 FE 추가 구현·배포·후속 작업은 없다. 새 요청이나 API 구조 변경이 있을 때만 재개하며 자동 QA·조회·폴링하지 않는다.
- 요청: [DL-17612 댓글45277](https://innovaid.atlassian.net/browse/DL-17612?focusedCommentId=45277)의 Sample Case 상품 키워드 연결 추가 시 FE 수정 필요 여부를 읽기 전용으로 검토했다. 상위 DL-17290, 담당 BE Leo. Jira·시트·제품 코드 변경은 하지 않았다.
- [키워드 표 상품 탭](https://docs.google.com/spreadsheets/d/1lpHDglPRv20gUy-mOZvYAdPDXi-IYEMF0Kv7bl7tHVo/edit#gid=188159333) 15행 Sample Case: `Seating / Fit`, `Proximal Contact`, `Occlusion`, `Shade`.
- **결론:** 기존 `KEYWORD` 문항의 `feedbackCategories[].keywords[]`에 연결 항목을 추가하고 API 구조를 유지한다면 FE 코드 변경은 필요하지 않다. 서버가 주문 조건별 선택지·label을 결정하고 웹/치과앱은 전부 펼쳐 표시하며 선택한 `keywordCode`를 `answers[].optionCodes`로 저장한다. Sample Case 제외·PRODUCT/SERVICE 허용 목록·개별 키워드 enum 제한은 해당 경로에 없다.
- 치과 웹 PC/모바일: `feedback.adapter.ts:29,158,169` → `FeedbackDetailDrawer.tsx:323,440`, 조회·저장은 `feedback.query.ts:108,133` 및 `order-feedback.apis.clinic.ts`. 상세 `GET /office/orders/{orderId}/feedback`, 신규 POST(서버 templateVersion), 기존 PUT(answers) 구조다.
- Office native: `feedback.repository.ts:40,159,232,247` → `configs/utils/feedback.ts:128` → `FeedbackDetailsScreen.tsx:186,811`. 코드/label은 string이며 동일 서버 계약을 소비한다. 웹·앱 키워드 버튼은 개수 고정 없이 map 및 wrap 처리한다.
- Admin 목록·상세: `adminFeedback.utils.ts:36,59`가 서버 키워드 코드/label로 표시하므로 함께 반영 가능하다. 기공소 웹/앱에서는 이번 치과 피드백 키워드 선택 폼을 찾지 못했으며 기존 알림 enum/asset/상수와 실제 폼 구현을 구분했다.
- 근거 기준: Web 현재 `feat/DL-17604@220694014`, 관련 피드백 경로는 실제 원격 master `96bdacda6`와 diff 없음. Office main `8d620786`, Lab main `12cd290`는 각각 실조회 원격 main과 동일. 다른 세션의 branch를 전환하거나 제품을 pull하지 않았다.
- 검증 범위: BE 구현·실제 변경 응답·런타임·배포는 검증하지 않았다. BE 반영 후 노출·선택·저장·재조회 확인은 일반 QA 참고이며 이번 FE 검토의 미완료 항목이나 자동 실행 작업으로 남기지 않는다. 기존 피드백 적용 범위는 서버 templateVersion/응답 정책에 달려 있다.

## 이전 구현 체크포인트 — 2026-09-28

- FE 구현·PR 전달·로컬 작업 공간 정리는 완료됐다. 사용자가 PR #4637 병합 후
  재배포 실행을 알렸으나, 직접 조회한 배포 workflow는 당시 진행 중이었다.
  **배포 성공·새 화면 반영은 이 기록만으로 확정하지 않는다.** 자동 감시·추가 구현은 시작하지 않는다.
- [PR #4637](https://github.com/Innvoaid/dentlink-client/pull/4637)은 9/28 14:44 KST에
  stage `bf955dfe2ee0dfbe8a41e9a51da354c5149e0c85`로 병합됐다. release/v1.87.0
  `bb5bff410760e462acdff77583f82e98e8b06b56`(추가 Popup QA #4639 포함)과 tree
  `442d7d29d27e773b40db147e98c7f20c717c2d04`가 같았고 피드백 페이지는 최종 QA
  `9aea3d0e0`와 blob이 같아 수정 보존을 확인했다.
- 당시 [Admin 36383203554](https://github.com/Innvoaid/dentlink-client/actions/runs/36383203554),
  [Office 36383203565](https://github.com/Innvoaid/dentlink-client/actions/runs/36383203565),
  [Lab 36383203608](https://github.com/Innvoaid/dentlink-client/actions/runs/36383203608)은
  모두 `in_progress`였다. STG `/feedbacks`도 기존 숫자 작성자ID 필터와 Rating 표시여서
  새 UI 반영은 확인하지 못했다. 과거 run 상태를 현재 배포 실패·현재 진행 중이라고 표현하지 않는다.
- PM [댓글 44192](https://innovaid.atlassian.net/browse/DL-16534?focusedCommentId=44192)는
  현재 공유 스펙으로 우선 운영하고 이후 피드백에 따라 개선하기로 확정했다.
  당시 Jira는 `Ready for Deploy`이며 Codex가 상태·댓글을 변경하지 않았다.

## 완료한 관리자 목록 범위와 제외 항목

- DL-16443의 `/feedbacks` 목록·필터·기존 상세 연결 후 DL-16534로 작성자 이름 검색과
  Rating 진입을 보완했다. [PR #4636](https://github.com/Innvoaid/dentlink-client/pull/4636)은
  release/v1.87.0에 병합됐고 stage 전달은 위 #4637로 추적한다.
- Rating은 밑줄 있는 native button이며 클릭·Enter/Space로 기존 상세 패널을 연다.
  일반 셀·여백 클릭으로 패널이 열리지 않는다. 주문번호·작성자 링크와 페이지네이션은 유지한다.
- 작성자 표시는 유지한다. 기존 관리자 공통 `searchFilterType: USER`로 이름을 검색해
  계정 한 명을 선택하고 `userId` 조건에 연결한다. 이름이 같은 모든 사용자를 통합 검색하는 기능은 아니다.
- 최초 작성일 기간 필터는 기존 기능이다. **전체 키워드 선택지, 담당 기공소 정보/필터,
  주문 완료일 기간 조건**은 BE 계약이 필요한 후속 후보이며 이번 배포 필수가 아니다.
  의사명 추가 요청은 PM [댓글 44186](https://innovaid.atlassian.net/browse/DL-16534?focusedCommentId=44186)에서 철회됐다.
- 최신 관리자 수정은 타입·lint·format·diff 검사와 정상 commit/push hook 검증을 통과했다.
  공통 USER 필터의 이름 검색·계정 선택·새로고침 label 복원은 STG CRM에서 확인했지만,
  수정된 피드백 페이지 자체의 배포 후 브라우저 QA를 완료한 것은 아니다.

## 제품 정책과 웹·앱 계약

아래는 보존된 기록을 후속 정정까지 반영한 기준이다. 새 확정 API·디자인 변경이 있으면
그 근거와 실제 코드를 대조해 갱신한다.

- 피드백 단위는 주문이며 Good/Bad 선택만으로 응답 완료 처리한다. 상세 사유·자유서술은
  선택 사항이며 등록 후 수정할 수 있다. 삭제는 지원하지 않는다.
- Good/Bad 저장 성공 직후 현재 To Review 화면의 카드·탭 count는 유지하며 toast와
  상세 입력 CTA를 보여준다. 실제 탭·페이지 전환, 이탈·새로고침·재진입 또는 상세 제출 후
  서버 목록·count를 다시 조회해 Reviewed로 표시한다. Good/Bad만으로 상세를 자동으로 열지 않는다.
- 상세 drawer는 To Review 후속 입력·Reviewed 수정·주문상세 진입이 공유한다.
  열기만으로 탭을 강제 변경하지 않는다. To Review는 주문 완료 최신순,
  Reviewed는 최초 리뷰 작성 최신순이며 수정으로 정렬을 바꾸지 않는다.
- **주문 상세 조회·노출 gate는 `OrderDto.isReviewable === true`다.** 9/11 DL-16385에서
  과거 `status === "COMPLETED"` 조건을 대체했고 status fallback은 두지 않는다.
  당시 BE 확인상 작성 후에도 true를 유지하며 true 주문의 상세 GET은200을 보장한다.
  [PR #4600](https://github.com/Innvoaid/dentlink-client/pull/4600) 및
  [보존된 9/11 계약·검증 기록](archive/dentlink-client-order-feedback-history-through-2026-10-27.md#isreviewable-반영과-세션-최종-종료--2026-09-11)을 따른다.
- 주문 상세 유도 영역·작성 권한은 Assigned Dentist 기준이며 담당 의사 변경 시
  Assigned Dentist별 피드백과 실제 제출 user ID를 구분한다. 피드백 목록은 이후 주문 상태가
  바뀌어도 계속 조회·수정할 수 있다. 과거 '완료 상태 동안만 노출' 문구를 새 gate 대신 사용하지 않는다.
- 상세 사유·옵션·label은 서버가 주문 조건에 맞춰 내려주는 정본을 사용한다.
  과거 Notion의 Shade/Fit/Material/Service를 별도 FE 매핑으로 만들지 않는다.
- 첨부는 **최대5개·총200MB·파일명100자** 정책을 사용하며 완료된 file ID로 연결한다.
  앱 촬영은1개씩 추가하는 흐름이다. 과거 Figma `2G`·Notion 10개/5MB 문구를 현재 기준으로 되돌리지 않는다.
- 서버·React Query cache가 기준 상태다. 현재 화면에서 카드만 유지하는 표현 상태와 구분한다.
  웹·앱은 같은 서버 계약을 각각 소비하며 TypeScript hook을 공유한다는 뜻은 아니다. 사용자 문구는 영어다.
- 일반 웹의 주문 상세는 기존 `FeedbackDetailDrawer`를 연다. 앱 WebView에서는 기존 RN
  `NAVIGATION` 메시지로 `FeedbackDetailsScreen`에 `orderId`, `entryPoint: order-detail`을 전달한다.
  Good/Bad 즉시 저장은 웹 동작을 유지하고 상세 진입 이벤트는 한 번 전송한다.
- native 상세 Submit 성공 시 `completedFeedbackOrderId`를 부모에 반환하고 부모 focus 시
  기존 WebView를 reload해 `hasDetails`를 다시 조회한다. 취소·뒤로가기·Submit 실패에는 reload하지 않는다.
  앱 구현·QA·전달의 현재 상태는 [Office 앱 정본](dentlink-app.md)이 담당한다.

## 범위와 참고 자료

- 상위 [DL-15828](https://innovaid.atlassian.net/browse/DL-15828),
  [기획 문서](https://app.notion.com/p/innovaid/3b1ce072e82f8105aec7e513995abc18).
- Figma [전체](https://www.figma.com/design/Lu8GEh1TUU5hOfj2FCPRYn/0101.-%EC%B9%98%EA%B3%BC--%EC%A3%BC%EB%AC%B8-%ED%94%BC%EB%93%9C%EB%B0%B1-%EC%88%98%EC%A7%91?node-id=60-9606&p=f&m=dev),
  [목록·상세](https://www.figma.com/design/Lu8GEh1TUU5hOfj2FCPRYn/0101.-%EC%B9%98%EA%B3%BC--%EC%A3%BC%EB%AC%B8-%ED%94%BC%EB%93%9C%EB%B0%B1-%EC%88%98%EC%A7%91?node-id=160-40593&m=dev),
  [주문 상세](https://www.figma.com/design/Lu8GEh1TUU5hOfj2FCPRYn/0101.-%EC%B9%98%EA%B3%BC--%EC%A3%BC%EB%AC%B8-%ED%94%BC%EB%93%9C%EB%B0%B1-%EC%88%98%EC%A7%91?node-id=160-38179&m=dev).
- Clinic PC·모바일 웹과 Office 앱 피드백, 관리자 조회가 기능 범위다.
  통합알림센터·ChannelTalk 중앙 진입점 대체는 [별도 기능](dentlink-unified-notification-center.md)이다.
  피드백 알림의 구현 이력과 일반 알림센터 미착수를 혼동하지 않는다.
- E2E 운영 기준·현재 실행 증거는 [웹 E2E 정본](dentlink-client-e2e.md)을 따른다.
  9/11 로컬10/10이나 9/8 STG 결과는 당시 증거이며 현재 전체 suite·native E2E 통과가 아니다.
  실제 FCM lifecycle·파일 선택·플랫폼별 실기기 QA도 별도 범위다.

## 작업 공간과 다음 시작점

- 기록상 전용 `dentlink-client-order-feedback`, `dentlink-client-feedback-review`,
  `dentlink-client-feedback-qa` worktree와 관련 로컬 작업 branch는 각 종료 단계에서 제거됐다.
  삭제된 경로에 세션을 새로 연결하라는 과거 `다음 시작점`은 현재 지시가 아니다.
  원격 refs·복구 자료의 마지막 보존 상태는 전체 이력에 있으며 이번 정리로 새로 확인하지 않았다.
- 재개할 새 QA·요구사항·API/디자인 변경이 있을 때만 [FE 조율 정본](dentlink-fe.md)과
  정확한 제품 checkout·live Git·실제 전달 대상을 먼저 확인한다. 완료한 feature를 재사용하지 않는다.
- 배포 상태를 다시 확인하라는 요청이면 위 정확한 run·실제 serving 상태부터 대조하고,
  작성자 이름 검색→계정/userId 선택·Rating 상세·일반 셀 미열림·주문번호 이동을 확인한다.
  이 문서 정리를 배포 성공이나 QA 완료의 새 증거로 사용하지 않는다.
- 확인된 현재 범위의 추가 웹 FE 구현은 없다는 마지막 결론을 유지한다. 후속 후보나 오래된
  대기 목록을 새 필수 작업으로 자동 재개하지 않는다. 제품 변경·PR·배포는 요청별 권한을 따른다.
- 구체적인 과거 커밋·QA·회귀 조사 시에만 [정리 전 전체 기록](archive/dentlink-client-order-feedback-history-through-2026-10-27.md)을
  읽는다. 과거 단계의 완료/미완료·정책은 날짜와 이후 정정을 함께 적용한다.
