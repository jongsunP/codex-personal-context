# DL-16796 Billing Statement 명칭 변경

## 완료 업무 폴더 확인 — 2026-10-26

- 사용자 요청으로 Repository의 별도 Billing clone/worktree가 없음을 확인했다. 원래 기본 `dentlink-client`에서 작업했으므로 이 업무 때문에 삭제할 폴더는 없다. 기본 제품 저장소와 10/25 복구 bundle을 유지했다.
- feature/DL-16796은 10/25 로컬·원격 정리 완료 상태이며 추가 삭제·제품/Jira 변경은 없다. 세션 보관·추가 예정 작업 없음 상태를 유지한다. 같은 요청의 권한관리 공간 정리는 해당 정본에 기록했다.

## 현재 상태 — 2026-10-25 운영 배포 포함 확인·본인 브랜치 정리 완료

- 메인 세션을 통해 전달된 사용자 승인으로 배포 후 정리를 한시 재개했다. 1단계는 읽기 전용 확인, 2단계는 지정 순번에서 본인 브랜치·담당 체크포인트만 정리했다. 추가 제품 구현·병합·배포·쓰기 QA/E2E는 하지 않았다. 개인 기록 commit/push 후 이 세션을 다시 보관한다.
- 원격 운영 태그 `prd/clinic/v1.89.0`, `prd/lab/v1.89.0`, `prd/admin/v1.89.0`이 모두 `a5e465561b953270b2925b2082845ba753f0572f`를 가리킴을 직접 확인했다. 메인 세션에서 확인한 당일 성공 Actions는 Clinic `40180395283`, Lab `40180309291`, Admin `40180269225`이며 마지막 완료는 18:51 KST다. 이 세션은 해당 배포 SHA에 본인 변경이 포함됐는지를 별도로 검증했다.
- [PR #4699](https://github.com/Innvoaid/dentlink-client/pull/4699)은 `MERGED → release/v1.89.0`, source `3aac1dff0005706e78015cb5f23f255712696911`, squash merge `a065b39e48afbeff4ef6b2e052ed2d82d6966f25`다. merge SHA가 운영 SHA의 조상임을 확인했다. source/merge의 stable patch-id는 `c767dec4f3deb8e1af6e6520608b62b303f600e7`로 동일하고, PR의 11파일·18개 추가 문구가 운영 커밋에 모두 유지된다. Admin 5파일은 source와 blob도 같고 Clinic 6파일은 후속 변경에도 해당 문구를 유지한다.
- Jira 현재 상태: 담당 [DL-16796](https://innovaid.atlassian.net/browse/DL-16796), 상위 [DL-16795](https://innovaid.atlassian.net/browse/DL-16795), Mina 담당 QA [DL-16836](https://innovaid.atlassian.net/browse/DL-16836) 모두 완료다. 담당/QA 하위 댓글은 각각 0개, 상위 댓글은 22개 전체를 확인했다. 상위 44483에서 치과·Admin 프론트 완료 확인, 44492/44497/44498에서 이메일은 Consolidated Statement이고 View PDF는 FE 화면을 열므로 별도 백엔드 수정 불필요로 종결됐다. 이미 완료여서 Jira 댓글·본문·상태를 변경하지 않았다.
- 상위 카드의 fixVersion `v1.89.0`은 조회 당시 `released=false`, releaseDate `2026-10-25`였다. 이 공통 Jira 버전 메타데이터는 본인 카드/브랜치 정리 범위에서 변경하지 않았으며 실제 운영 태그·배포 결과와 구분한다.
- 삭제 전 본인 local/remote `feature/DL-16796`이 모두 source SHA와 정확히 일치하고, checkout한 worktree와 해당 branch를 head/base로 쓰는 열린 PR이 없음을 재확인했다. 아래 복구 bundle/manifest를 보존한 뒤 원격은 exact-SHA lease를 사용한 normal push로 삭제하고 로컬 브랜치도 삭제했다. 원격·로컬·remote-tracking ref의 부재를 확인했다.
- 공유 checkout `/Users/parkjongsun/Repository/dentlink-client`는 clean `master@8772d68825cac6e23792d86a715153a67dc71078`로 보존했다. 다른 로컬/remote-tracking refs와 6개 checkout의 worktree 목록·HEAD는 전후 동일하다. 다른 5개 worktree·기존 백업·실제 env/인증 파일은 정리하지 않았다. 과거 `/tmp/dl-16796-pdf-validation`은 이미 없어 추가 로컬 삭제 대상이 없었다.
- 원격 브랜치 삭제 때 저장소의 normal pre-push hook이 실행돼 3서비스 lint(기존 경고 있음), Admin DLOS guard 60/60·테스트 6건, shared coverage 검사를 통과했다. 이는 공유 master checkout의 삭제 push 검사이며 운영 SHA의 새 기능 QA로 해석하지 않는다. 제품 소스 변경·신규 제품 커밋은 없다.
- 이 작업의 추가 개발·정리 항목은 없다. Jira QA 카드의 완료 상태와 실제 운영 실계정/앱 다운로드 검증, 앱 배포는 별개다. 이번에는 운영 화면을 통한 기능 QA나 앱 배포를 수행하지 않았다.

### 복구 자료 — 이 기기의 Git 공용 디렉터리에 보존

- 폴더: `/Users/parkjongsun/Repository/dentlink-client/.git/codex-closeout/DL-16796-20261025/`
- `feature-DL-16796.bundle`와 `manifest.json`을 보존했다. manifest에는 삭제 전/후 SHA·refs·worktree·검증 결과와 복구 조건이 있다.
- bundle은 10,001 bytes, SHA-256 `b472a91a91570e19a81c6b4692f52dbff3119633e1e8266d7025d63f7d30114f`다. `git bundle verify`와 `list-heads`로 원본 source/ref 보존을 확인했다.
- 증분 bundle이므로 보존된 base commit `8772d68825cac6e23792d86a715153a67dc71078`이 필요하다. 복구 요청 시 해당 base 보유 여부와 bundle을 검증한 뒤 bundle의 `refs/heads/feature/DL-16796`을 같은 이름의 로컬 브랜치로 fetch한다. 원격 복원은 별도 요청 때만 수행한다.
- 백업 파일 자체는 이 기기에 있고, 경로·hash·복구 조건은 이 Git-backed 개인 체크포인트에 기록한다. 공통 `PROJECTS.md`/`MEMORY_CHANGELOG.md`/`dentlink-fe.md` 종합은 메인 세션 담당이다.

## 이전 상태 — 2026-10-20 개발 작업 완료·세션 종료

- 사용자가 현재 작업을 완료 처리하기로 하고 내용 정리 후 세션 보관을 요청했다. 10/19의 QA 대기 상태를 종료하며, 이 세션에서 예정된 추가 작업은 없다. 개인 Git 기록을 commit/push한 뒤 세션을 보관한다.
- 완료 결과: 개별 `Billing Statement → Invoice`, 통합 `Consolidated Billing Statement → Consolidated Statement`와 Clinic/Admin 버튼·PDF/ZIP 파일명·번호 라벨·안내 문구를 총 11파일에 반영했다. Jira 댓글의 Admin `Invoice 다운로드` 요청도 포함했다. `Commercial Invoice`와 발행·결제 구조, 금액·문서번호 값은 유지했다. 앱 네이티브 추가 수정은 소스 확인상 필요하지 않았다.
- 10/20 GitHub 1회 읽기 전용 조회로 [PR #4699](https://github.com/Innvoaid/dentlink-client/pull/4699)의 `MERGED → release/v1.89.0`, 11파일을 재확인했다. source `3aac1dff0005706e78015cb5f23f255712696911`, merge `a065b39e48afbeff4ef6b2e052ed2d82d6966f25`, 병합 시각 2026-10-16 10:58:21 KST는 기존 기록과 같다.
- 검증 이력: 10/15 타입·lint·관련 guard/테스트와 합성 PDF 8사례를 통과했고 CodeRabbit SUCCESS·미해결 0건으로 마쳤다. 상세 범위와 한계는 아래 검증 기록을 유지한다. 종료 정리 중 제품 변경이나 테스트 재실행은 없었다.
- 스테이징 배포 완료는 10/19 사용자 보고 기준이다. 이번 종료 요청에 새 QA 이슈는 전달되지 않았으며, 실제 QA 통과·실계정/앱 다운로드·운영 배포 완료를 별도로 확인한 것은 아니다. 사용자의 작업 완료 결정과 이 검증 범위를 구분한다.
- Jira 댓글은 남기지 않고 상태는 사용자가 관리한다. 이번에는 개인 기록만 정리하며 제품 코드·브랜치·PR·배포·Jira를 변경하거나 브랜치를 정리하지 않는다. 새 요청이 있을 때만 아래 재개 절차로 이어간다.

## 이전 상태 — 2026-10-19 스테이징 배포 완료·QA 대기

- 사용자가 스테이징 배포 완료를 알렸다. 배포 완료는 사용자 보고 기준이며, 이번에는 배포 workflow/SHA/실제 서비스 상태를 별도로 조회하지 않았다.
- QA 이슈가 전달되면 해당 내용을 확인하고 대응한다. 이슈가 없으면 현재 구현을 유지하고 마무리할 예정이며, 종료 기한을 임의로 정하지 않는다.
- 현재는 사용자 지시에 따라 대기한다. 추가 구현·QA 실행·조회·자동 모니터링·Jira 변경·배포는 시작하지 않는다. Jira 댓글은 남기지 않고 카드 상태는 사용자가 직접 관리한다.
- 스테이징 배포와 실제 QA 통과·운영 배포 완료를 구분한다. 아래 구현·검증·병합 기록은 당시 확인 이력이다.

## 이전 확인 — 2026-10-16 Git 정리 중 병합 상태 갱신

- [PR #4699](https://github.com/Innvoaid/dentlink-client/pull/4699)은 GitHub에서
  **MERGED → release/v1.89.0**, 10:58:21 KST로 확인했다.
  merge `a065b39e48afbeff4ef6b2e052ed2d82d6966f25`, source `3aac1dff0005706e78015cb5f23f255712696911`이다.
- 운영 출시 완료 근거는 없어 기본 checkout의 `feature/DL-16796`과 원격 브랜치를 보존했다.
  이번 작업은 Git 정리용 조회이며 추가 구현·QA·배포·Jira 변경은 하지 않았다.
- 아래 2026-10-15 팀 리뷰·병합 대기 기록은 당시 이력이다. 병합 완료를 실제 QA·운영 반영 완료로 확대하지 않는다.


## 이전 상태 — 2026-10-15 개발 완료·메모리화 후 사용자 요청 대기

- 상위 [DL-16795](https://innovaid.atlassian.net/browse/DL-16795), Frankie 담당 하위 [DL-16796](https://innovaid.atlassian.net/browse/DL-16796).
- 담당 채팅: `01a1395f-5658-7b31-9e82-d285d572f186` / `DL-16796 Billing Statement 명칭 변경`.
- 개인 폴더 `/Users/parkjongsun/Documents/ChatGPT/메인 프로젝트`, 제품 저장소 `/Users/parkjongsun/Repository/dentlink-client` 기존 기본 checkout을 사용한다. 새 제품 폴더·worktree는 만들지 않는다.
- 사용자가 최신 master에서 브랜치를 만들어 구현·commit·push하고 `release/v1.89.0` 배포용 PR까지 만드는 것을 승인했다. 기존 checkout에서 `feature/DL-16796`을 준비해 11파일·18문구를 수정했다.
- 제품 커밋 `3aac1dff0005706e78015cb5f23f255712696911` (`fix: 청구 문서와 다운로드 명칭을 Invoice로 변경`), 원격 branch와 일치·clean.
- [PR #4699](https://github.com/Innvoaid/dentlink-client/pull/4699): `feature/DL-16796` → `release/v1.89.0`, OPEN/non-draft, 1커밋·11파일, MERGEABLE. 채팅에 PR 연결 완료. 사용자 후속 요청으로 CodeRabbit 완료/SUCCESS와 미해결 스레드0건을 확인했다. Admin DLOS Guard/Auto Assign도 SUCCESS이며 팀 리뷰는 REVIEW_REQUIRED다.
- Codex가 실제 병합·배포, Jira 상태 변경·댓글 작성, 실계정 화면/PDF·ZIP 다운로드·실기기 QA를 수행하지 않았다. CodeRabbit 검토 후 추가 수정이 없어 제품 신규 커밋·푸시는 없다.
- 메인세션은 전달만 마쳤으며, 이후 이 담당 세션에서 사용자 지시를 받아 이어간다. 메인세션에 자동 진행/완료 메시지를 보내지 않는다.
- 사용자 요청으로 Jira 댓글은 작성하지 않고 카드 상태는 사용자가 직접 옮긴다. 10/15 후속 조회에서 상위 DL-16795는 진행 중, 하위 DL-16796은 Ready for Deploy였다. 이 카드 상태는 팀 리뷰 승인·병합·배포 증거와 구분한다.
- 사용자가 Admin 포함 모든 확정 개발 요청의 완료를 재확인한 뒤 `메모리화 하고 대기해줘`라고 지시했다. 구현·로컬 검증·commit/push·PR·CodeRabbit 확인을 완료 상태로 저장하고, 재개 요청 전 추가 개발/조회/모니터링/메시지/병합/배포 없이 대기한다.

## 확정 범위와 해석 정정

- 기존 개별 문서 `Billing Statement` → `Invoice`.
- 기존 통합 문서 `Consolidated Billing Statement` → `Consolidated Statement`.
- `Commercial Invoice`는 유지한다.
- 기존 케이스별 문서 발행 방식, 결제 구조, 문서 묶음 단위, 금액, 문서번호 값, 발행 시점은 변경하지 않는다. 여러 케이스의 결제 건별 Invoice 신규 발행은 범위 밖이다.
- 2026-10-14 메인세션이 고객 확인 댓글을 전체 작업의 필수 선행조건처럼 과도하게 해석했고 사용자가 정정했다. 명칭 변경을 불필요한 PM 재질문으로 막지 않는다. 실제 새 요구가 확정될 때만 범위 변경으로 판단한다.
- 같은 문서를 가리키는 Clinic 결제 내역 데스크톱/모바일 버튼, Admin 결제 조회 버튼·매출 ZIP 버튼과 완료 문구, 개별/통합 PDF 파일명, ZIP 및 내부 파일명, 개별 PDF/영수증 번호 라벨, 통합 문서 수신 안내 문구를 함께 맞췄다. API/라우트/DTO/컴포넌트/컬럼 key 등 내부 식별자는 그대로다. 약관과 결제방법 안내의 일반적인 billing statement 표현 및 Payment History 보고서는 변경하지 않았다.
- 현재 범위라면 복잡하거나 오래 걸리는 작업은 아니며, 관련 표시 수정과 PDF·다운로드 결과 검증이 중심이다. 과거 시간 구간은 잠정 추정이며 실측·납기 확약이 아니다.

## 최신 Jira 근거 — 2026-10-15 직접 조회

- 상위 댓글 13개, 첨부 3개(31649/31650/31651). 하위 카드는 Frankie 담당, 본문/댓글/첨부 없음. 마지막 조회 상태는 상위 진행 중, 하위 Ready for Deploy다.
- [댓글44431](https://innovaid.atlassian.net/browse/DL-16795?focusedCommentId=44431): 위 세 문서 명칭 변경/유지 구분. 과거 Commercial Invoice와의 혼동 방지 이력과 FA팀 확인 제안은 배경이며, FA 확인 완료 증거를 임의로 만들지 않는다.
- [댓글44439](https://innovaid.atlassian.net/browse/DL-16795?focusedCommentId=44439): 핫픽스가 아닌 정기배포 포함. 상위 fixVersion `v1.89.0`, Jira 계획일 2026-10-26, unreleased. 하위 fixVersion은 비어 있다. 일정은 구현 기준 브랜치나 실제 배포 완료 증거가 아니다.
- [댓글44441](https://innovaid.atlassian.net/browse/DL-16795?focusedCommentId=44441), 10/14 17:21 KST: Jeanna가 각 케이스별 Invoice가 맞다고 답변했다. 여러 케이스를 함께 결제하더라도 각 건의 Invoice를 원한다는 설명으로, 44440의 추가 확인에는 답변이 도착했다.
- [댓글44442](https://innovaid.atlassian.net/browse/DL-16795?focusedCommentId=44442), 10/15 08:21 KST: Jun이 관리자 결제 목록 버튼명도 챙겨 달라고 요청하며 첨부31651을 추가했다.
- [댓글44443](https://innovaid.atlassian.net/browse/DL-16795?focusedCommentId=44443), 10/15 10:59 KST: Mina가 Jun 첨부 이미지의 `statement 다운로드` 버튼을 `invoice 다운로드`로 변경하도록 Frankie에게 명시했다. 해당 버튼명 변경은 확정 요구사항이며 후속 재조회에서도 발행 방식 변경 지시는 없었다.
- 본문·댓글 전체는 직접 읽었다. 이미지 픽셀은 아직 검증하지 못했다. 10/14~15 IAB 미리보기 실패에 이어 10/15 pageAssets로 관찰된 첨부 3개를 읽었지만 이미지 응답이 없어 실패했다. 임시 Jira 탭은 종료했다. 첨부 확인 완료로 보고하지 않으며 본문·댓글·실제 연결 코드 기준으로 구현했다. 이미지 미확인은 현재 문구 변경 전체의 PM 승인 선행조건이 아니다.
- 10/15 사용자 Admin 포함 여부 재확인 요청으로 상위 댓글13개/하위0개 전체를 다시 읽었다. 마지막 댓글은 여전히44443이며 새 코드 요구는 없었다. 원격 PR4699 head3aac1dff0의 Admin5파일(결제 조회 버튼, 개별PDF, Receipt, ZIPUI/hook)을 다시 대조해 `Statement 다운로드 → Invoice 다운로드`와 제목/번호라벨/ZIP·PDF 파일명 반영을 확인했다. 모든 확정된 개발 요청은 PR에 포함돼 있고 신규 제품 수정/Jira 댓글은 하지 않았다. FA 확인 제안이나 첨부·실환경 QA 완료를 주장하지 않는다.

## 코드 조사 근거와 영향 범위

조사·구현 base는 10/15 fetch한 `origin/master@8772d68825cac6e23792d86a715153a67dc71078`이다. 아래 파일 경로는 내부 식별자를 보존한 상태이며 줄 번호의 문구는 위 구현으로 바뀌었다.

- Clinic 개별 PDF: `clinic/src/components/Pdf/BillingStatement/BillingStatementPDF.tsx`의 `BILLING STATEMENT`(209행), 문서번호 라벨(222행), 파일명(85행). 서버 JSON을 받아 `@react-pdf/renderer`로 FE에서 생성한다.
- Admin 개별 PDF: `admin/src/components/Pdf/BillingStatementPDF.tsx`의 `BILLING STATEMENT`(195행), 문서번호 라벨(208행), 파일명(79행). 동일하게 FE 생성이다.
- Clinic 통합 PDF: `clinic/src/components/Pdf/ConsolidatedBillingStatement/ConsolidatedBillingStatementPDF.tsx`의 `CONSOLIDATED BILLING STATEMENT`(220행). JSON 기반 FE 생성이다.
- 관리자 요청 버튼의 코드상 위치는 결제 조회 상세 `admin/src/pages/payments/[payment_id].tsx:56`의 `Statement 다운로드`다. 결제 목록 index 자체에는 같은 버튼이 없다. 첨부 픽셀과 최종 위치 대조는 남아 있다.
- 위 버튼 → `admin/src/lib/Payment/usePaymentFinanceUrl.tsx:29`의 `/pdf/billing-statement?paymentId=` → `admin/src/pages/pdf/billing-statement.tsx:59`의 `ReportApisAdmin.getInvoiceByPaymentId` JSON 조회 → 같은 파일98행 `BillingStatementPDF` → `admin/src/components/Pdf/BillingStatementPDF.tsx:30`의 `usePDF` 및79행 Blob 다운로드. 이 경로 역시 BE 생성 PDF를 받는 방식이 아니다. 환불 때 originId를 사용하는 현재 데이터 선택도 보존한다.
- 관리자 매출 목록 ZIP은 별도 `BulkStatementDownload` 경로로, 개별 PDFUI를 FE에서 생성해 묶는다. 버튼·ZIP/내부 파일명을 Invoice에 맞게 바꿨으며 결제 조회 버튼과 구분한다.
- 확인된 문서 명칭 변경 자체에는 BE 구현이 필요하지 않다. 제품 전체의 모든 문서가 FE 생성이라고 일반화하지 않는다.
- 10/15 앱 최종 소스 대조: Office `origin/develop@2bc7d04d`/`origin/main@897a0929`, Lab `origin/develop@56cba674`/`origin/main@bb619010`을 fetch 후 확인했다. 해당 문서명 직접 표시/PDF 생성 네이티브 코드가 없고 주문 상세 WebView는 각 제품 웹을 연다. `DentlinkWebView.tsx`의 DOWNLOAD_FILES → `useFileDownload.ts`는 웹에서 전달한 파일명을 그대로 사용한다. 양 앱 네이티브 수정·별도 카드 생성은 불필요하다는 소스 판정이며, 실기기 다운로드 성공을 검증한 것은 아니다. 앱 checkout은 변경하지 않았다.

## Git와 소유권 — 2026-10-15 최종 확인

- 개인 컨텍스트는 clean `main`에서 `git pull --ff-only` 완료. 이번 대기 기록 전 HEAD `249f7bd`. 다른 세션의 권한관리/DLDS 기록을 보존하고 이 업무 문서·색인·변경 이력만 수정한다.
- 제품 기본 checkout의 master를 `git pull --ff-only`로 `693b8b4c4` → `8772d68825`로 갱신한 뒤 `git switch -c feature/DL-16796 origin/master`로 시작했다. 새 checkout/worktree를 만들지 않았다.
- `origin/release/v1.89.0@af636cac8d6f1939dda7c628b1d4873cf86c89c0`은 시작 master보다 1커밋 앞이었다(DL-16787 #4697). 해당 변경을 feature에 섞지 않았고 PR diff는 이번 11파일만이다.
- 제품 최종 `feature/DL-16796@3aac1dff0`, upstream `origin/feature/DL-16796`, ahead0/behind0·dirty/untracked 없음. 일반 hook을 거쳐 commit/push했다.
- 기존 DLDS, DLDS integration, permission worktree는 보존했다. 구현 직전 기본 checkout에 다른 활성 작성 충돌은 확인되지 않았다. 메인·디자인은 idle, 활성 권한관리는 별도 permission worktree를 사용했다.

## 검증과 중단 복구

- 작업 도중 사용량 제한으로 PDF/리뷰 보조 작업이 중단됐다. 사용자 재확인 요청 후 11파일 변경·브랜치·PR 미생성 상태를 확인하고 루트가 직접 남은 검증과 리뷰를 수행했다. 별도 에이전트 리뷰 완료로 기록하지 않는다.
- 첫 normal commit은 최신 master의 `@innvoaid/icons`/`@innvoaid/dlos` 패키지 링크가 로컬 node_modules에 없어 Lab 타입 검사에서 중단됐다. `pnpm install --frozen-lockfile` 성공으로 복구했으며 잠금파일/제품 소스 추가 변경 없이 재시도했다.
- normal pre-commit: Clinic/Lab/Admin `tsc --noEmit` 모두 통과. normal pre-push: 3서비스 전체 eslint, Admin DLOS guard(60/60), guard 테스트6건, shared config21건+hooks32건과 coverage:check 종료0. lint에 기존 경고가 있었지만 hook은 성공했다. coverage 결과는 현재 스크립트 범위/정책 통과이며 전체 제품 커버리지나 실서비스 QA 증거로 확대하지 않는다.
- 실제 PDF UI 5종을 TypeScript AST로 임시 추출하고 실제 공통 PDF UI·폰트·포맷터와 합성 데이터로 전후 렌더링했다. Clinic/Admin Invoice2, Clinic 통합 일반/다중페이지2, Clinic/Admin 일반/환불 Receipt4로 총8쌍(16PDF)이다. 최종 파일 hash와 렌더링 source hash도 일치한다.
- PDF8사례 모두 문서명/번호 라벨 치환 외 추출 텍스트가 동일하고 모든 숫자 및 페이지 수가 유지됐다. 생성된 after11페이지를 이미지로 시각 확인했다. 검증물은 `/tmp/dl-16796-pdf-validation`의 manifest/render.cjs/check.py/validation-results.json/PDF/PNG에 있으며 제품 repo에 추가하지 않았다.
- PDF 검증은 합성 로컬 렌더링이며 Clinic locale은 en-US fixture다. viewer/download wrapper, 실제 API 응답, 실계정 화면, ZIP 다운로드, 인쇄, 앱 실기기, release 서버/상용 반영은 미검증이다.

## 종료 후 재개 조건

1. 2026-10-25 운영 포함 검증과 승인된 본인 브랜치 정리까지 완료했다. 이 세션의 예정된 추가 작업은 없으며 추가 개발·조회·QA 실행·모니터링·배포·Jira 변경·메인세션 메시지를 자동으로 시작하지 않는다.
2. 향후 QA 이슈나 변경 요청이 전달되면 개인 컨텍스트 pull → 이 문서 → 해당 제품 저장소와 실제 배포 기준·재현 조건을 확인하고 요청 범위에서 재개한다. 원본 feature는 정리됐으므로 자동 복원하거나 기존 구현/PR을 중복 생성하지 않는다. 원본 복구가 필요하면 위 bundle 조건을 따른다.
3. 관련 Clinic/Admin 화면, 개별/통합/Receipt 문서 및 다운로드 검증은 새 요청에 필요한 범위로 수행한다. 과거 합성 PDF 검증을 실계정·앱 QA 통과 근거로 확대하지 않는다.
4. Jira 댓글은 남기지 않고 카드 상태는 사용자가 관리한다. 향후 명시적으로 요청된 Jira 업데이트는 담당 하위 DL-16796에 하며, 상위 댓글은 별도 명시 요청 때만 작성한다.

## CodeRabbit 후속 확인 — 2026-10-15

- 사용자 요청: PR4699 CodeRabbit 의견을 확인하고 필요한 수정이 있으면 commit/push까지 처리.
- 개인 컨텍스트와 feature를 pull한 뒤 원격/로컬/PR head `3aac1dff0` 일치·clean을 확인했다. CodeRabbit run `fb9f98ad-7ec7-43d4-8ad7-c1d961a8d3fd`는 11파일 전체를 처리했으며 02:53:49 UTC에 Review completed/SUCCESS다.
- [CodeRabbit 결과](https://github.com/Innvoaid/dentlink-client/pull/4699#issuecomment-6183290997)는 actionable comment 없음, GraphQL reviewThreads 전체0건(hasNextPage=false). 일반 review 제출 객체는 없지만 상세 요약과 commit status로 실제 리뷰 완료를 확인했다.
- 유일한 pre-merge 경고는 Docstring Coverage 50%/권장80%(분석 함수2개). 신규 함수·로직 변경 없는 표시명/파일명 치환이며 기능 결함 지적이 아니므로 주석 비율만 맞추는 추가 수정을 하지 않았다. [처리 근거 댓글](https://github.com/Innvoaid/dentlink-client/pull/4699#issuecomment-6183353072)을 남겼다.
- 독립 읽기 전용 보조 검토에서도 결제 버튼→Invoice API/PDF, ZIP→같은 개별 PDFUI, Receipt→item.invoiceNo 연결과 Commercial Invoice 보존을 확인했으며 적용할 실제 결함은 없었다.
- 신규 제품 변경이 없어 기존 통과 검사를 반복하지 않았다. git diff --check 통과·clean, 댓글 후 CodeRabbit SUCCESS/미해결0/동일 head를 다시 확인했다. 기존 3aac1dff0과 PR 대상은 유지되며 팀 리뷰·실계정 다운로드 QA·병합·배포와 구분한다.
