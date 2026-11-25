# Dentlink 주문 피드백 수집 — DL-15828

치과 주문 피드백과 관리자 피드백 조회의 개인 체크포인트다. 2026-10-27 문서 정리에서
원문을 [이력 문서](archive/dentlink-client-order-feedback-history-through-2026-10-27.md)로
보존했다. 2026-09-28 구현·배포 이력과 아래 후속 코드 검토는 구분한다.
재개 시 live Git과 필요한 Jira·Figma·Swagger를 우선하고, 기획·구현·검증·병합·배포를 구분한다.

## 관리자 피드백 썸네일 QA 접수 — DL-17615 / 2026-11-25

- 등록·전달 완료: `관리자 피드백 썸네일 수정 · DL-17615`, ID `01a2115e-9fc6-7062-9a3f-3f7d626a20e0`, 메인 프로젝트 폴더/local. 생성 당시 사용자 요청과 일치하는 메인 turn의 `gpt-6-astra`/`xhigh`를 확인해 명시 적용했고 새 세션 실제 첫 turn 동일 설정을 확인했다. 첨부와 표시 기준 확인·전용 worktree 구현 준비 시작을 확인했으며 메인 추가 폴링은 없다.
- 사용자 요청: [DL-17615](https://innovaid.atlassian.net/browse/DL-17615)를 확인하고 별도 세션·별도 worktree에서 처리한다. 기존 출력·알림 후속·배송 패널 작업 공간은 보존한다. 구현·검증 및 branch/worktree 준비 범위이며 제품 commit/push/PR/merge/배포는 별도 지시 경계다.
- 카드: `[QA] 피드백 썸네일 수정`, Frankie 담당·해야 할 일·댓글 없음. 설명은 ‘관리자에서만 잘못 반영된 피드백 썸네일 수정’, 재현 URL은 `https://stg-admin.dentlink.io/feedbacks`. 상위는 DL-17290이며 DL-17612 Sample Case 키워드 검토와 별도 QA다. 현재 이 카드/상위에서 수정버전은 확인되지 않았으므로 이전 별도 작업의 v1.95.0을 이번 건의 확정 PR 대상으로 단정하지 않는다.
- 첨부: 이미지32046 `screenshot-1795507947115.png`, 이미지32048 `image-20261124-081236.png`, 콘솔 로그32047. 메인은 메타데이터·본문까지만 확인했고 실제 이미지는 아직 열람하지 않았다. 담당 세션이 두 이미지를 반드시 보고 기대 썸네일과 문제 화면을 먼저 대조한다. 첨부를 못 보면 추정으로 교체하지 않는다.
- 코드 시작점: `admin/src/components/Feedback/AdminFeedbackOrderSummary.tsx`는 `feedback.order.categoryThumbnailUrl`을 58px 이미지로 렌더하고 값이 없으면 문서 아이콘을 사용한다. 실제 원인이 필드/매핑/서버값/표현 중 어디인지는 미확정. `/feedbacks` 목록·상세와 공용 소비처, 치과의 정상 표시/기존 제품 이미지를 대조하고 원인에 맞는 최소 수정·검증을 한다. 공통 API/기공소앱/치과앱까지 임의 확장하지 않는다.
- 준비 계획: `dentlink-client` 최신 `origin/master`에서 새 `feat/DL-17615`, 전용 managed worktree `dl-17615-feedback-thumbnail`. 확인 당시 master `9084878eaa93ea4fe39df0f376afa4456c5fec55`, release/v1.95.0 `b0e04eafe00e86836f472bea114e5fce867b4cad`, 피드백 경로 diff 없음·새 작업 branch 원격 없음. 실제 QA가 특정 미병합 release 차이에 속한다는 근거가 나오면 담당 세션에서 base를 재판단한다.
- 새 worktree는 동일 저장소 주 worktree의 eligible ignored/untracked `.env*`를 내용 열람 없이 상속·동일성/ignore 확인한다. 기존 사용자 작업 창/서버·미커밋 변경을 보존하며 기능 결과는 새 세션에서 사용자에게 직접 보고한다. 메인은 등록·전달 이후 폴링하지 않는다.

### 담당 세션 준비 확인 — 2026-11-25

- managed worktree `/Users/parkjongsun/.codex/worktrees/dl-17615-feedback-thumbnail/dentlink-client` 생성·현재 채팅 연결 완료, branch `feat/DL-17615`, base `origin/master@9084878eaa93ea4fe39df0f376afa4456c5fec55`. 다른 worktree는 변경하지 않았다.
- main의 eligible ignored/untracked env 6개를 불투명 복사하고 byte equality·ignore를 확인했다. 대상 권한 0600, 값 열람·변경 없음. 의존성 frozen/offline 설치 완료.
- 첨부32046/32048 실제 열람: 파란색 category thumbnail 대신 카테고리 관리의 보라색 `이미지`가 기대값이다. Clinic 피드백도 catalog의 `categoryId → imageUrl`로 표시한다. Admin에 이미 있는 `useCatalogCategoryQuery`를 공용 summary에 재사용하는 최소 수정 진행 중이다.
- 초기 체크포인트이며 아직 구현·브라우저 검증 완료를 뜻하지 않는다. 제품 commit/push/PR/merge/배포 없음.

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
