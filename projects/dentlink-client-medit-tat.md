# DL-16615 MEDIT TAT 수정

## 범위와 작업 위치

- 기능 세션: `01a10eae-2ff7-7b43-a9e2-11a3b93cc782`.
- 개인 세션 폴더는 기존 `메인 프로젝트`를 유지한다. 새 폴더/worktree는 만들지 않는다.
- 제품 조사 경로: `/Users/parkjongsun/Repository/dentlink-client`.
- 상위 조율 정본: [Dentlink FE](dentlink-fe.md). 제품 저장소에 개인 인계문을 추가하지 않는다.
- Jira/Notion 댓글 작성·상태 변경, 제품 branch 생성·commit·push·PR·merge·배포는 별도 명시 승인 범위를 따른다.

## 현재 체크포인트 — 2026-10-06: v1.88.0 PR 전달

- 사용자가 개발 완료 여부를 확인한 뒤 제품 commit/push 및 `release/v1.88.0` 대상 PR 생성을 명시 승인했고, "1.88.0으로 그대로 진행해"라고 재확정했다. 상위 Jira DL-16613의 v1.89.0 일정은 변경하지 않았다. merge·배포는 승인 범위에 없다.
- 제품 `feature/DL-16615`의 최종 commit은 **`1b0c7a44d9d8f39c55e741c30c1521e4dad75e0e`**, 메시지는 `fix: 미국 Medit 주문의 RX 날짜 보정`이다. 원격 push 완료, upstream과 ahead/behind **0/0**, checkout clean이다.
- [PR #4660](https://github.com/Innvoaid/dentlink-client/pull/4660): **OPEN / 일반 PR**, base `release/v1.88.0`, head `feature/DL-16615`. 이번 commit 1개, 수정 파일 4개만 포함하며 로컬 Codex 작업에 PR artifact를 연결했다. merge 충돌은 없으나 자동 체크·팀 리뷰가 남아 있다.
- 원본 Medit RX 미리보기는 [#3752](https://github.com/Innvoaid/dentlink-client/pull/3752) / `8e030bdc4`로 master와 v1.88.0 모두에 들어 있다. API·원본 의존성 차이는 없으며 v1.88.0의 추가 차이는 MeditPreview DLOS 전환이다. master 고유 LinkTalk hotfix #4657은 release #4658과 동일 patch다.
- master 기준 최초 구현 commit `eb8ba45a5`를 전달 단계에서 최신 `origin/release/v1.88.0` **`faaa1498189e3e584cfc6fce215ce97feca156f7`** 위로 옮겼다. `MeditPreview.tsx` 첫 import 충돌만 DataGrid와 DateFormat을 함께 유지해 해결했다. DLOS Typography/colors, DataGrid.DataList 및 기존 스타일·표 동작을 보존했고 무관한 master commit은 PR에 포함하지 않았다.
- release 기준 최종 검증: Admin·Clinic·Lab `pnpm type`, `pnpm check:admin-dlos`(현재 60/baseline 60), 실제 소스 날짜 함수·React/RHF 기반 **73건**, 변경 Admin 파일 lint 오류 0/기존 경고 3, Prettier/diff 검사 모두 성공. 독립 리뷰에서도 추가 수정이 필요한 문제를 발견하지 못했다.
- push hook도 성공했다. Clinic·Lab·Admin 전체 lint는 오류 없이 기존 경고가 있으며, DLOS guard 테스트 **5건**, shared/configs **21건**과 shared/hooks **32건**, coverage 검사 통과다. 생성된 coverage는 제품 commit에 포함하지 않았고 checkout은 clean이다.
- 생성 직후 GitHub Admin DLOS guard·CodeRabbit은 진행 중, Auto Assign/Vercel Preview Comments는 성공이다. `dentlink-dlos` Vercel preview 상태는 **Deployment was blocked**로 실패다. GitHub 상태·봇 댓글에서 이 상태를 확인했고 배포 상세는 비로그인 상태에서 404/로그인 안내라 세부 차단 사유는 확인하지 못했다. 코드 빌드 실패나 권한 문제로 단정하지 않는다.
- 개발·로컬 검증·사용자 PM 댓글·PR 전달까지 완료했다. **실제 Admin 테스트 주문 제출·재조회와 조립된 릴리즈 QA는 남아 있다.** 운영 주문 변경, Jira/Notion 추가 댓글·상태 변경, merge·배포는 실행하지 않았다.

## 이전 체크포인트 — 2026-10-06: 사용자 댓글 등록 후 최종 확인

- 사용자가 최종 댓글을 직접 등록했다고 알려 Jira·Notion을 다시 조회했다. [Notion 토론](https://app.notion.com/p/3ecce072e82f80bca54ffcb137f57c97?d=b21ce072e82f83e8b1a383f5b767255c&pvs=42)에 **2026-10-06 11:47 KST** Frankie의 답변이 등록돼 있다. 기존 질문과 답변 총 2개이며 추가 요청·답변은 없다. fetch 본문은 댓글 1개라는 이전 요약을 반환했지만 get_comments의 실제 토론 조회에서 2개를 확인했다.
- 등록된 댓글: "기존 FE에는 `delivery_request_at`을 병원 국가코드별로 보정하는 처리가 없었습니다. 이번에는 본문에서 요청한 미국 Medit 주문에만 US 조건을 추가해, Admin 초기값과 미리보기 날짜를 RX에 맞췄습니다." 기존 처리와 이번 변경의 히스토리를 유지하고 BE 확인 요청 문장은 사용자 판단으로 제외했다. 실제 코드의 범위와 일치한다.
- Jira DL-16615는 여전히 **해야 할 일**, fixVersions 없음이며 기존 Notion 댓글 확인 요청 1개다. 상위 DL-16613은 **v1.89.0 / 2026-10-26** 대상이다. Codex는 Jira·Notion 댓글·상태를 변경하지 않았다.
- 제품은 `feature/DL-16615`, HEAD/base `6b79c9756cc56313fe833aad463bddb1f8c385fa`, 아래 4개 파일의 미커밋 변경이다. 미국 Medit OFFICE_SCANNER DRAFT의 원본 RX 날짜를 Admin 초기값에 적용하고, 미국 Medit 미리보기를 같은 날짜 기준으로 맞춘다. iTero 날짜 변환은 추가하지 않았다.
- 최종 코드·독립 리뷰와 검증을 다시 수행했다. Admin/Clinic/Lab 타입 검사 성공, 소스 날짜 함수·실제 React/RHF 기반 **73건** 성공, 변경 Admin 파일 lint 오류 0/기존 경고 3, 포맷/diff 검사 성공이다. 테스트의 leaf 컴포넌트는 대체했으므로 전체 앱 제출·재조회 QA는 여전히 미확인이다.
- 현재 단계는 **승인된 FE 구현·로컬 검증 및 PM 댓글 답변 완료**다. 남은 것은 실제 Admin 테스트 주문 제출·재조회 QA와 별도 승인 범위의 제품 commit/push/PR 전달이다. 서버 자동수집·Clinic 보정 확대는 이번 Admin 구현에 포함하지 않았다.

### 사용자 재검토 요청 후 보완 이력

- 사용자가 기존 방향을 유지한 주석 추가, 이후 구현 재검토·직접 보완과 PM용 댓글 재정리를 요청했다. 이 시점에 Notion 본문과 전체 댓글을 다시 읽었고, 토론은 iTero 확인 요청 1건이었다. Codex는 외부 댓글을 등록하지 않았다.
- 초기 구현의 `formOrder` 복제로 RX 원본이 늦게 도착하면 날짜 외 comment·플랫폼명·디자인 선택도 초기화될 수 있어, 원본 `order`를 유지하고 `initialDeliveryRequestAt` prop과 Admin 날짜 전용 effect로 분리했다.
- RHF dirty 판정 대신 주문 ID·사용자 편집 여부를 추적한다. 날짜 선택·비우기·impression 변경 뒤 원본이 도착해도 선택을 보존하며, 다른 주문으로 이동하거나 재진입하면 해당 주문 초기값을 사용한다. 최소일 제한은 유지한다. OFFICE/LAB의 최소일 비교는 기존 watch 값 사용을 유지했다.
- 이전 주문의 플랫폼 원본을 사용하지 않도록 주문 ID와 MEDIT 여부를 확인한다. SSR 경로의 orderId는 실제로 문자열이므로 `Number(orderId)`와 API의 숫자 ID를 비교한다. 날짜 보정 memo에도 플랫폼 원본 객체를 dependency로 포함했다.
- Medit 미리보기 한국 날짜 적용도 미국 OFFICE_SCANNER 범위로 제한했다. 다른 Medit 주문은 기존 표시 기준을 사용한다. US 조건의 Notion 근거, 한국 날짜 기준, 비동기 초기화 분리 이유를 주석으로 기록했다.
- 최신 소스에서 날짜 함수를 추출하고 실제 React/RHF를 JSDOM에 mount해 **73건**을 통과했다. 브라우저 시간대 4종, 잘못된/누락된 원본, US/플랫폼/상태 제외, 늦은 원본과 다른 입력값 보호, 날짜 선택·비우기, 최소일, 주문 이동·재진입, SSR 문자열 ID, 미리보기 US/기존 표시를 포함한다. 화면 leaf는 대체했으므로 전체 앱 제출·재조회 QA 증거는 아니다. 이전 60건 기록은 아래 조사 이력이다.
- 재검토 후 Admin/Clinic/Lab 타입 검사 성공, 변경 Admin 파일 lint 오류 0/기존 경고 3, 포맷/diff 검사 성공이다. 제품 commit/push/PR은 실행하지 않았다.
- PM 댓글의 정확한 범위: 기존 FE에는 Medit/iTero의 `delivery_request_at`을 병원 국가코드에 맞춰 별도 보정하는 처리가 없었다. 이번 미국 Medit Admin 초기값·미리보기에만 US 조건과 RX 날짜 보정을 추가했다. iTero의 국가코드별 초기 저장 정책은 FE 코드에서 보장할 수 없어 서버 확인 대상이다. 기존 캘린더 조회에는 국가코드, 현재 날짜 기준에는 officeZoneId가 사용되므로 "국가코드 관련 처리 자체가 전혀 없었다"고 쓰지 않는다. Admin KR 또는 서버 오류를 원인으로 단정하지 않는다.

### 최초 구현·검증 이력

- 사용자가 기존 checkout에서 `origin/master` 기준 `feature/DL-16615` 생성 후 구현·검증을 승인했다.
- 기본 checkout에 해당 브랜치를 만들었다. HEAD/base는 `6b79c9756cc56313fe833aad463bddb1f8c385fa`, 수정 파일 4개, 제품 commit/push/PR 없음이다. 원격 feature/upstream은 아직 없다.
- **재현:** 신규 미국 Medit DRAFT의 원본 `2026-10-28T22:45:00Z`는 한국 날짜 10/29이나 운영 저장·표시는 10/28이다. 원본과 운영 상세를 읽기 대조했다. 사례 주문/환자의 사적인 정보는 개인 정본에 저장하지 않는다.
- Admin 신규 미국 OFFICE_SCANNER/MEDIT DRAFT에서 현재 저장일이 원본의 병원 시간대 날짜와 같을 때만 RX 한국 날짜로 보정한다. 다른 선택일·최소일로 보정된 저장값·DRAFT 이후·iTero·미국 외·누락/잘못된 원본은 보존한다.
- 원본은 이미 Admin 주문 단계 페이지가 조회하던 `platformOrder.rawOrder`를 사용한다. 새 API나 공유 전역 타임존 변경은 없다. 원본의 늦은 도착이 사용자가 현재 선택한 날짜를 덮지 않도록 dirty를 기록하고, 같은 초기화 사이클에서 최소일 비교가 최신 폼값을 읽도록 수정했다.
- Medit RX 미리보기 Delivery도 한국 날짜로 표시한다. 표시 형식은 기존 `MM/dd/yyyy`를 유지한다. 다른 Created/Scanned 날짜에는 이 정책을 확대하지 않았다.
- **검증:** Admin/Clinic/Lab 타입 검사 성공, Admin 전체 lint 오류 0/기존 경고 410, 수정 Admin 파일 lint 신규 경고 없음, 포맷/diff 검사 성공. 실제 소스에서 함수/초기화 effect를 추출해 시간대 4종과 정책 제외 조건을 검증했다. 초기 58건 중 초기화 6건은 마지막 소스의 8건으로 다시 검증해 최종 조건 수는 **60건**이다. 비동기 초기화·수동 입력 보호·최소일 비교와 다른 주문으로 이동한 뒤 이전 dirty가 남아도 새 주문 날짜를 초기화하는 경우를 포함한다. 영구 테스트/helper 파일을 추가하지 않았다.
- **화면 검증 한계:** 실제 MeditPreview 소스의 SSR을 LA 시간대에서 격리 렌더링하고 브라우저에서 Delivery 10/29/2026을 확인했다. Typography/DataTable leaf는 대체했으므로 전체 앱 UI/캘린더 상호작용 QA는 아니다. 임시 서버는 종료했다. 운영 주문 수정·제출은 하지 않았다.
- **남은 범위:** 이 보정은 Admin 폼값이며 Admin 제출 시 서버 저장 요청으로 연결된다. 서버 자동수집 초기값을 직접 고치지 않는다. Clinic은 Medit 원본 조회 계약이 현재 없어 이 Admin 보정을 직접 사용할 수 없다. 전체 수집값/Clinic 직접 제출까지 요청한다면 서버 수집 매핑 또는 Clinic 원본 제공 계약을 확인해야 한다. 신규 원본 조회 API를 임의로 만들지 않았다.

### 변경 제품 파일

- `admin/src/components/Order/OrderAdditional.tsx`: 원본 기반 날짜 보정과 공용 폼 연결.
- `admin/src/components/Order/OrderForm.tsx`: 기존 플랫폼 원본을 추가정보 단계로 전달.
- `admin/src/components/Order/MeditPreview.tsx`: RX Delivery 날짜 표시.
- `shared/ui/src/Order/OrderForm/OrderAdditionalInfoForm.tsx`: 입력값 보호 및 최신값으로 최소일 비교.

### 확인된 요구와 자료

- [DL-16615](https://innovaid.atlassian.net/browse/DL-16615): 해야 할 일, fixVersions 없음, 하위 작업/이슈 링크 없음.
- [상위 DL-16613](https://innovaid.atlassian.net/browse/DL-16613)은 **v1.89.0 / 2026-10-26** 대상이다. 상위의 iTero 환자명·Medit 설명 수정은 이 기능의 구현 범위에 포함하지 않는다.
- [Notion Medit TAT](https://app.notion.com/p/3ecce072e82f80bca54ffcb137f57c97) 본문과 전체 블록·해결된 토론 포함 댓글을 읽었다. 최초 조회 결과는 토론 1개, 댓글 1개, 답변 없음이었다. 현재 사용자 답변 등록은 최상단 체크포인트를 따른다.
- 본문: 미국 Medit 주문의 요청일이 최소 영업일 10일보다 이후일 때 RX 표시일보다 하루 앞서 매핑됨. RX 날짜와 맞추기를 요청한다.
- 원본 예시 `dateDesiredDelivery = 2026-10-19T19:00:39Z`. 한국 10/20 04:00, LA 10/19 12:00이다. 본문은 Medit RX가 한국 시간 기준으로 보인다고 설명하며 FE 수정 필요라고 적었다.
- 10/2 댓글: `request_type=OFFICE_SCANNER`, `upload_platform_name=ITERO` 주문의 `delivery_request_at`이 병원 국가코드에 맞게 설정되는지 확인 요청. iTero 날짜 수정 정책이 결정됐다는 답변은 없다.
- DL-16615 Jira 댓글에서도 Notion 댓글 확인을 요청했다.

### 실제 코드와 화면

- 공용 `shared/ui/src/Order/OrderForm/OrderAdditionalInfoForm.tsx`: 서버의 `officeDeliveryRequestAt`을 폼에 사용. OFFICE_SCANNER DRAFT는 최소 turnaroundDate보다 빠를 때 최소일로 대체. DRAFT 이후는 저장값을 유지한다.
- `DeliveryInfo.tsx`: `officeZoneId`는 현재 날짜/캘린더 기준에 사용. 납기 표시 자체는 `DateFormat.formatDate`와 `new Date`를 사용한다.
- Admin/Clinic의 `useOrderAdditionalInfoForm.tsx`: 선택값을 브라우저 날짜로 format/parse하여 `toISOString()`으로 제출한다. iTero 전용 변환은 없다.
- `shared/models/src/common/axiosInstance.ts`: `zone-id`는 브라우저 IANA timezone이다. 국가코드만으로 시간대를 선택하지 않는다. 서버의 실제 수집/정규화 정책은 FE 코드만으로 확인할 수 없다.
- Admin 주문 단계 페이지는 Medit 플랫폼 원본을 별도 조회하지만 현재 TAT 초기화와 연결돼 있지 않다. `MeditPreview.tsx`는 원본 Delivery에 공용 `formatDate`를 사용한다.
- Chrome의 인증된 운영 Admin 사례 주문을 읽기 조회했다. 현재 희망 배송일 표시는 **2026/10/20 (America/Los_Angeles)**, 데이터 보기의 `officeDeliveryRequestAt`은 **2026-10-20T00:00**다. 상태는 DRAFT 이후다.
- 현재 사례가 원본 수집 당시부터 올바른지, 제출/수동 수정으로 보정됐는지는 확인하지 못했다. 현재 표시가 맞는 것만으로 신규 DRAFT 결함 해결을 주장하지 않는다. 주문 변경/제출을 하지 않았다.
- Node Intl로 원본 UTC의 한국/LA 날짜 차이와, timezone 없는 서버값 `2026-10-20T00:00`이 한국/LA 브라우저에서 모두 20일이지만 제출 ISO는 달라지는 것을 확인했다. 제품 수정 후 회귀 테스트가 아니다.

### 시작 시 Git·전달 조사 이력

- 시작 시 웹 기본 checkout은 clean `release/v1.88.0 / 3a4b1b2cf`, 원격 갱신 후 behind 3이었다.
- 시작 지침에 따라 `git pull --ff-only`로 **94ffc8a9d6248c90ac6fc25f80573eb8400f7264**까지 동기화했다. clean, upstream과 ahead/behind 0/0이다.
- `origin/master = 6b79c9756cc56313fe833aad463bddb1f8c385fa`. 원격 `feature/DL-16615`, `release/v1.89.0`은 조회 시 없다. 이 업무 PR도 없다.
- 기존 DLDS·권한관리 worktree는 각각 다른 기능 소유이므로 사용하지 않는다. 조사 이후 사용자가 branch 생성·구현·검증을 승인해 최상단 상태로 진행했다. commit/push/PR/merge/배포는 실행하지 않았다.
- 최근 Admin Production Actions 성공은 `prd/admin/v1.87.1 / 307752030...`에 대한 것이다. DL-16615 전달이나 실제 배포 artifact 일치를 뜻하지 않는다.
- 앱 저장소는 이번 단계에서 조사/변경하지 않았다. 웹 공용 UI의 native webview 영향은 구현 범위 확정 후 판단한다.

## 다음 시작점

1. 제품 `feature/DL-16615` / `1b0c7a44d9d8f39c55e741c30c1521e4dad75e0e`와 [PR #4660](https://github.com/Innvoaid/dentlink-client/pull/4660)의 원격 head·target·check·리뷰 상태를 다시 확인한다. 목표 릴리즈는 사용자 확정 **v1.88.0**이다.
2. Admin 실제 앱의 테스트 데이터로 RX·TAT·수동 변경·최소일·재진입·제출·재조회를 QA한다. 운영 주문 수정/제출을 검증용으로 실행하지 않는다. 73건의 격리 검증을 전체 앱 QA로 취급하지 않는다.
3. CodeRabbit 리뷰 처리 요청이 오면 AGENTS의 전체 리뷰 사이클 권한을 적용한다. 그 외에는 팀 리뷰·승인을 기다린다. merge·배포는 별도 승인 범위다.
4. Vercel `dentlink-dlos` preview 차단은 로그인이 필요한 상세 확인 사항이다. 현재 상태를 코드 실패로 단정하거나 사용자 승인 없이 배포 설정을 바꾸지 않는다.
5. 팀이 PR을 v1.88.0에 병합한 뒤 조립된 staging 릴리즈에서 QA한다. 서버 자동수집·Clinic 보정 확대와 iTero 변경은 이번 PR 범위에 포함하지 않는다.
