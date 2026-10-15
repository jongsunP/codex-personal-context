# DL-16796 Billing Statement 명칭 변경

## 현재 상태 — 2026-10-15 조사·브리핑 완료, 구현 지시 대기

- 상위 [DL-16795](https://innovaid.atlassian.net/browse/DL-16795), Frankie 담당 하위 [DL-16796](https://innovaid.atlassian.net/browse/DL-16796).
- 담당 채팅: `01a1395f-5658-7b31-9e82-d285d572f186` / `DL-16796 Billing Statement 명칭 변경`.
- 개인 폴더 `/Users/parkjongsun/Documents/ChatGPT/메인 프로젝트`, 제품 저장소 `/Users/parkjongsun/Repository/dentlink-client` 기존 기본 checkout을 사용한다. 새 제품 폴더·worktree는 만들지 않는다.
- 이번 요청은 현황 파악·사용자 브리핑·개인 Git 컨텍스트 저장이다. 제품 구현, 브랜치 생성/전환, 제품 commit/push/PR, Jira 변경, 배포는 수행하지 않았다. 제품 QA·테스트도 실행하지 않았다.
- 메인세션은 전달만 마쳤으며, 이후 이 담당 세션에서 사용자 지시를 받아 이어간다. 메인세션에 자동 진행/완료 메시지를 보내지 않는다.

## 확정 범위와 해석 정정

- 기존 개별 문서 `Billing Statement` → `Invoice`.
- 기존 통합 문서 `Consolidated Billing Statement` → `Consolidated Statement`.
- `Commercial Invoice`는 유지한다.
- 기존 케이스별 문서 발행 방식, 결제 구조, 문서 묶음 단위, 금액, 문서번호 값, 발행 시점은 변경하지 않는다. 여러 케이스의 결제 건별 Invoice 신규 발행은 범위 밖이다.
- 2026-10-14 메인세션이 고객 확인 댓글을 전체 작업의 필수 선행조건처럼 과도하게 해석했고 사용자가 정정했다. 명칭 변경을 불필요한 PM 재질문으로 막지 않는다. 실제 새 요구가 확정될 때만 범위 변경으로 판단한다.
- 버튼·번호 라벨·파일명·관리자 ZIP의 명칭 정합성은 본문·첨부·코드와 대조할 세부 구현 사항이다. 모든 표시를 사전에 확정 변경으로 단정하거나 PM 질문 목록으로 확대하지 않는다. API/라우트/DTO/컴포넌트명 일괄 치환은 하지 않는다.
- 현재 범위라면 복잡하거나 오래 걸리는 작업은 아니며, 관련 표시 수정과 PDF·다운로드 결과 검증이 중심이다. 과거 시간 구간은 잠정 추정이며 실측·납기 확약이 아니다.

## 최신 Jira 근거 — 2026-10-15 직접 조회

- 상위 댓글 13개, 첨부 3개(31649/31650/31651). 하위 카드는 Frankie 담당·해야 할 일, 본문/댓글/첨부 없음.
- [댓글44431](https://innovaid.atlassian.net/browse/DL-16795?focusedCommentId=44431): 위 세 문서 명칭 변경/유지 구분. 과거 Commercial Invoice와의 혼동 방지 이력과 FA팀 확인 제안은 배경이며, FA 확인 완료 증거를 임의로 만들지 않는다.
- [댓글44439](https://innovaid.atlassian.net/browse/DL-16795?focusedCommentId=44439): 핫픽스가 아닌 정기배포 포함. 상위 fixVersion `v1.89.0`, Jira 계획일 2026-10-26, unreleased. 하위 fixVersion은 비어 있다. 일정은 구현 기준 브랜치나 실제 배포 완료 증거가 아니다.
- [댓글44441](https://innovaid.atlassian.net/browse/DL-16795?focusedCommentId=44441), 10/14 17:21 KST: Jeanna가 각 케이스별 Invoice가 맞다고 답변했다. 여러 케이스를 함께 결제하더라도 각 건의 Invoice를 원한다는 설명으로, 44440의 추가 확인에는 답변이 도착했다.
- [댓글44442](https://innovaid.atlassian.net/browse/DL-16795?focusedCommentId=44442), 10/15 08:21 KST: Jun이 관리자 결제 목록 버튼명도 챙겨 달라고 요청하며 첨부31651을 추가했다.
- [댓글44443](https://innovaid.atlassian.net/browse/DL-16795?focusedCommentId=44443), 10/15 10:59 KST: Mina가 Jun 첨부 이미지의 `statement 다운로드` 버튼을 `invoice 다운로드`로 변경하도록 Frankie에게 명시했다. 해당 버튼명 변경은 확정 요구사항이다. 이번 재조회에서도 발행 방식 변경 지시는 없으며 상위/하위 모두 해야 할 일 상태다.
- 본문·댓글 전체는 직접 읽었다. 이미지 픽셀은 아직 검증하지 못했다. 10/14 IAB에서 첫 첨부 미리보기 실패 후 다운로드 대기 중 턴이 중단됐고, 10/15 새 첨부도 미리보기 로딩 상태였다. 첨부 확인 완료로 보고하지 않는다. 이미지 미확인은 현재 문구 변경 전체의 PM 승인 선행조건이 아니다.

## 코드 조사 근거와 영향 범위

조사 기준은 10/14 및 10/15 fetch한 `origin/master@8772d68825cac6e23792d86a715153a67dc71078`이며, 제품 checkout을 바꾸지 않고 읽었다.

- Clinic 개별 PDF: `clinic/src/components/Pdf/BillingStatement/BillingStatementPDF.tsx`의 `BILLING STATEMENT`(209행), 문서번호 라벨(222행), 파일명(85행). 서버 JSON을 받아 `@react-pdf/renderer`로 FE에서 생성한다.
- Admin 개별 PDF: `admin/src/components/Pdf/BillingStatementPDF.tsx`의 `BILLING STATEMENT`(195행), 문서번호 라벨(208행), 파일명(79행). 동일하게 FE 생성이다.
- Clinic 통합 PDF: `clinic/src/components/Pdf/ConsolidatedBillingStatement/ConsolidatedBillingStatementPDF.tsx`의 `CONSOLIDATED BILLING STATEMENT`(220행). JSON 기반 FE 생성이다.
- 관리자 요청 버튼의 코드상 위치는 결제 조회 상세 `admin/src/pages/payments/[payment_id].tsx:56`의 `Statement 다운로드`다. 결제 목록 index 자체에는 같은 버튼이 없다. 첨부 픽셀과 최종 위치 대조는 남아 있다.
- 위 버튼 → `admin/src/lib/Payment/usePaymentFinanceUrl.tsx:29`의 `/pdf/billing-statement?paymentId=` → `admin/src/pages/pdf/billing-statement.tsx:59`의 `ReportApisAdmin.getInvoiceByPaymentId` JSON 조회 → 같은 파일98행 `BillingStatementPDF` → `admin/src/components/Pdf/BillingStatementPDF.tsx:30`의 `usePDF` 및79행 Blob 다운로드. 이 경로 역시 BE 생성 PDF를 받는 방식이 아니다. 환불 때 originId를 사용하는 현재 데이터 선택도 보존한다.
- 관리자 매출 목록 ZIP은 별도 `BulkStatementDownload` 경로로, 개별 PDFUI를 FE에서 생성해 묶는다. 버튼·ZIP/내부 파일명은 정합성 검토 대상이며 결제 조회 버튼과 구분한다.
- 확인된 문서 명칭 변경 자체에는 BE 구현이 필요하지 않다. 제품 전체의 모든 문서가 FE 생성이라고 일반화하지 않는다.
- 10/14 앱 조사 중간 결과: Office/Lab 주문 상세는 웹뷰와 `DOWNLOAD_FILES` 브리지를 사용하며, 검색 범위에서 해당 문서명의 네이티브 UI 직접 사용은 발견하지 못했다. 당시 앱 기본 checkout이 오래돼 로컬 원격 ref도 대조 중이었다. 최신 앱 원격 대조·실제 사용 경로 전체·실기기 검증 완료는 확인되지 않았으므로 네이티브 수정 불필요를 최종 확정하지 않는다. 앱에서 웹 문서를 표시하는 영향과 네이티브 코드 수정을 구분한다.

## Git와 소유권 — 2026-10-15 확인

- 개인 컨텍스트는 clean `main`에서 `git pull --ff-only` 완료, 이번 기록 전 HEAD `f6cf68811de54eefa0db676ea71d12cfe63515cc`. 기존 Billing 체크포인트는 없었다. 다른 세션 기록을 보존하고 이 업무 문서·색인·변경 이력만 추가한다.
- 제품 기본 checkout: `master@693b8b4c4d247716db05ea415bc7bd1d33dab4cc`, upstream `origin/master`, ahead0/behind6, dirty/untracked 없음.
- 제품 `git fetch origin` 완료. 최신 원격 `8772d68825cac6e23792d86a715153a67dc71078`. HEAD와의 차이는 패키지 배포 관련8파일이며 조사한 청구 문서 소스는 같다.
- `feature/DL-16796` 로컬/원격 ref는 없다. 이 세션이 제품 코드·브랜치·PR·Jira를 변경한 이력도 없다.
- 기존 DLDS, DLDS integration, permission worktree는 보존했다. 조회 당시 메인·권한관리 채팅은 idle, 권한관리는 별도 worktree다. 기본 checkout에 다른 활성 작성 충돌은 확인되지 않았으나 실제 구현 시작 직전 다시 확인한다.

## 남은 작업과 다음 시작점

1. 사용자 구현 재개 지시를 기다린다. 자동 모니터링·PM 재질문·Jira 수정·배포를 시작하지 않는다.
2. 재개 시 개인 컨텍스트 pull → 이 문서 → 최신 Jira 차이 → 정확한 제품 clean/소유권/ref 확인 순서로 이어간다. 이미 완료한 조사 전체를 반복하지 않는다.
3. 구현이 승인되면 기존 checkout에서 최신 `origin/master` 기준 `feature/DL-16796`을 준비한다. 예정 release 유무 때문에 master 기준을 다시 묻거나 release를 만들지 않는다. 제품 commit/push/PR/merge/배포는 별도 승인 범위를 따른다.
4. 첨부 이미지와 해당 표시를 대조하고 앱 직접 수정 필요 여부를 좁게 확인한다. 영향 없는 앱 카드를 만들지 않는다.
5. 문서 제목 및 실제 필요한 연결 표시만 수정한다. 기존 데이터·API·문서번호 값·발행 단위와 Commercial Invoice는 보존한다.
6. 영향 화면과 PDF/인쇄/다운로드·ZIP의 명칭, 내용/금액/문서번호 유지, 레이아웃을 확인하고 관련 타입·린트 등 비례 검증을 수행한다. 실제 앱 확인은 웹 코드 검사와 별도로 보고한다.
7. 향후 Jira 정리는 기존 담당 하위 DL-16796에 한다. 상위 댓글은 사용자 명시 요청 때만 작성한다.
