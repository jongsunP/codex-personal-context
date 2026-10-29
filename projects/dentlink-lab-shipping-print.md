# Dentlink Lab Shipping Print UX — DL-17101

## Current checkpoint — 2026-10-29

- 사용자 승인 범위는 자체기공소의 배송 출력 UX 구현과 **기존 IDE/로컬 서버에서 사용자 확인 준비**다. 제품 commit/push/PR/merge/deploy는 승인받지 않았으며 실행하지 않았다.
- 상위 [DL-17099](https://innovaid.atlassian.net/browse/DL-17099), Frankie 담당 하위 [DL-17101](https://innovaid.atlassian.net/browse/DL-17101)을 실제 조회했다. 상위 설명의 협력기공소 확장보다 이번 대화의 **INTERNAL만 변경, 다른 타입 유지** 범위가 우선한다. Jira 변경·댓글 없음.
- 제품 checkout `/Users/parkjongsun/Repository/dentlink-client`, 로컬 `feature/DL-17101`, 기반 `origin/master@57bb759ca08e3752140ceffdae2a5421934ec242`. 원래 Cursor checkout과 localhost:3005 서버를 그대로 사용했다. 새 worktree 없음. 제품 변경 19파일은 미커밋 상태다.
- 로컬 브라우저의 frankieDevLab은 사용자가 Admin에서 변경한 **INTERNAL**이며 employee own 응답의 employer.labType으로 확인했다. 타입/권한/배송 상태/API 비즈니스 규칙은 이번 코드에서 변경하지 않았다.
- 구현과 로컬 런타임 검증을 마쳤으며 **사용자 로컬 QA 대기**다. 번역 운영 시트 동기화는 아래 별도 미완료 항목이다.

## Confirmed behavior

- INTERNAL 배송 목록의 기존 라벨·스티커를 `라벨(부착용)`, `라벨(배송용)`, `주문서(배송용)` 3열로 바꾸고 상단 일괄 출력 메뉴와 배송 상세 상단에도 같은 선택지를 제공한다.
- 부착용은 운송장 이미지/PDF만, 배송용은 운송장과 기존 인쇄 전용 수출신고 안내, 주문서용은 기존 Order List만 출력한다.
- 기존 `printType=LABEL/STICKER`와 URL/API 구조를 유지하고 INTERNAL LABEL에만 optional `labelFormat=ATTACHMENT/SHIPPING/ORDER_SHEET`를 추가했다. 출력창에서 같은 창의 메뉴로 바꾸며 URL에 선택이 남는다. 다른 타입은 format을 무시하여 기존 통합 라벨·스티커 동작을 유지한다.
- INTERNAL 배송 상세의 주문별 스티커, 주문 상세의 기존 스티커만 숨긴다. 주문 상세의 별도 QR `라벨 출력`과 `Order` 출력은 유지한다.
- 배송 주문 구성 수정 후 자동 출력창을 여는 기존 SSE 조건을 유지한다. INTERNAL 기본은 부착용이고 새 라벨 안내 및 3종 전환을 제공한다. 화면 선택에 필요한 기존 exportTradeCodes를 INTERNAL 경로에만 전달했다.
- LABEL 최대10건/STICKER 최대30건, labelUrl 필수, CREATING_WAYBILL 비활성화, PRE_DELIVERY 재시도 조건을 유지한다. INTERNAL 재시도는 첫 열/상세 상단에 한 번만 노출한다.
- INTERNAL 출력에서는 QA·TanStack 개발 버튼이 종이에 찍히지 않게 인쇄 CSS로 숨겼다. 출력 메뉴는 PopupMenu customToggleUI를 사용해 실제 800px 팝업에서 정렬을 확인했다.

## Verification

- 최종 Lab TypeScript exit0, 공유 UI를 소비하는 Clinic TypeScript exit0. 변경 파일 ESLint 오류0, 경고13개는 HEAD 원본과 동일. 기존 root/shared Storybook 플러그인 중복 문제로 Lab/shared 검사를 분리했다. Prettier와 git diff --check 통과.
- 저장소 밖 `/tmp` Jest/jsdom 검증 **13개 통과**: 실제 URL 훅·LabelList/Item의 INTERNAL 기본/3형식, 비INTERNAL 기존 URL/통합 문서, 자동출력 플래그, 스티커 URL, 2건 순번, 안내 포함/제외, PDF 분기. API와 이미지/PDF leaf는 mock이며 실제 브라우저 증거와 구분한다.
- Chrome localhost 실제 INTERNAL: 목록3열·일괄3메뉴, 개별 부착용, 각 형식 2건 일괄 열기, 선택 초기화, 11건 선택 시 출력 비활성화(기존 동작), 배송 상세3버튼/스티커 제외, 주문 상세 QR·Order 유지/스티커 제외를 확인했다.
- Chrome native 인쇄 미리보기: 부착용1건=운송장1페이지/안내없음, 부착용2건=운송장2페이지, 배송용2건=기존 통관안내 포함2페이지, 주문서2건=Order List2페이지/첫 빈페이지없음. 최종 부착용과 주문서에서 개발 버튼 미출력도 확인했다. 실제 종이 인쇄는 하지 않았다.
- 출력창 내3종 전환·새로고침 유지 확인. 기존 형식 URL에 isUpdateShipping 플래그를 넣어 INTERNAL 부착용 기본/새 라벨 안내를 확인했다. **실제 배송 수정 요청/SSE 전체 시나리오는 실행하지 않았다.**
- 비INTERNAL 실제 계정 전환/브라우저 실측은 없으며 기존 동작 보존은 diff 리뷰·타입검사·13개 회귀테스트로 확인했다. 동일 계정의 Admin 타입을 바꿔 시험하지 않았다.
- 실행 로그: `/tmp/dl17101-lab-final-types.log`, `/tmp/dl17101-clinic-types.log`, `/tmp/dl17101-eslint-lab.log`, `/tmp/dl17101-eslint-shared-ui.log`, `/tmp/dl-17101-print-regression.log`. 임시 파일이므로 다음 세션에는 존재와 소스 일치를 다시 확인한다.

## Translation pending

- shipping en/ko에 `print.menu.attachmentLabel`, `shippingLabel`, `shippingOrder`, `print.modal.documentTitle` 4키를 추가했고 실제 화면에서 정상 표시했다.
- 공개 CSV 읽기 전용 export preview: 로컬3344키, 시트1598행, missing1748/stale2/conflicts3. 이번4키 외에도 큰 차이가 있다. stale2는 master에 반영된 #4652 삭제가 시트에 남아 있다. 충돌은 labHeadline(ko), readyInHours(en/ko).
- `audit:i18n`은 기존 OFFICE 분기의 account.auth.actions.logIn 누락으로 실패(이번 신규 누락 없음). `check:i18n`은 총10파일 stale: shipping2파일에는 이번4키가 영향을 주며 다른8파일은 기존 불일치다.
- 운영 두 탭 동시편집 중단이 확보되지 않았고 전체 덮어쓰기의 영향이 이번 범위를 넘으므로 시트 쓰기/강제 생성은 하지 않았다. **번역 시트 작업 완료로 보고하지 않는다.** 로컬 QA는 현재 리소스로 가능하다. 이후 승인 범위 내4키 동기화 방법·시트 충돌/동시편집 조건부터 정리한다.

## Resume point

1. 개인 컨텍스트와 exact checkout의 branch/dirty diff를 확인한다. 현재 미커밋 작업을 보존하며 사용자 QA 피드백부터 처리한다.
2. 필요시 localhost:3005/shipping에서 각 형식의 개별·일괄 출력과 프린터 용지/배율을 사용자와 확인한다. 실제 배송 수정·물리 프린터·다른 타입 실제 계정은 아직 별도 확인 범위다.
3. 시트 동기화 미완료를 해결하고 최종 영향 범위만 재검증한다. 제품 commit/push/PR 요청 전까지 로컬 상태로 유지한다.

## Session identity

- 공유기공소·밀링센터 세션 `01a18682-0535-7aa3-9d30-9440b0b90a01`, 기존 Mac local 호스트. FE 메인 `01a08f0c-2057-7852-ae8d-0cf950a91fd3`와 분리해 구현한다.
- 코드 변경 범위는 Lab 출력 컴포넌트/훅/배송목록·상세/주문상세, 공용 일괄선택 UI의 optional props, shipping 번역 리소스다. 개인 체크포인트는 제품 저장소에 추가하지 않았다.
