# 추가 앱 크레딧·청구서의 모바일웹 기능 대조 — 2026-11-06

상태: **조사·사용자 목적 재정리 완료, 보완 구현은 사용자 승인 대기.** 제품 코드·Jira·Notion은 변경하지 않았다. 알림센터 본체의 BE/정책 대기와 이 추가 화면의 FE 보완을 구분한다.

## 사용자가 다시 명확히 한 목적

- 이번에 선정한 모바일웹 기능을 앱에서도 사용할 수 있게 하는 작업이다. 단순한 목록 표시·READ API 연결만으로 완료를 판단하지 않는다.
- 기존 모바일웹의 API·정책·디자인·사용 가능한 동작을 먼저 활용한다. 앱의 내비게이션·안전영역·터치·복귀 특성에 맞게 옮기되 기본 기능을 임의로 생략하지 않는다.
- 새 BE API·디자인·기획을 별도로 요구하거나 큰 기능 개발로 확장하기보다 FE가 기존 자원으로 가능한 부분을 보완한다. PDF처럼 큰 별도 작업과 앱에서 그대로 제공하기 어려운 부분은 이유와 영향 범위를 구분한다.
- ‘가능한 것’은 무조건 전부 네이티브로 새로 개발한다는 뜻도, 임의로 조회만 남긴다는 뜻도 아니다. 재사용 가능성과 앱에서의 실제 동작을 근거로 판단한다.
- 이번 요청은 정리·저장·브리핑이며, **실제 구현은 다음 사용자 승인 이후**다.

## 앞선 판단 정정

이 세션은 기존 ‘추가 목록’ 범위를 지나치게 조회 전용으로 해석했고, 모바일웹의 조작과 상세 표현을 충분히 대조하지 않은 채 ‘FE 추가 작업 없음’이라고 보고했다. 자동사용 토글·Learn More·아이콘 차이는 BE 미제공이나 앱의 기술적 제약 때문에 빠진 것이 아니다. ‘웹 부가기능은 모두 합의상 제외’와 ‘기능은 현재로 충분’이라는 앞선 답변은 이 사용자 목적을 기준으로 정정한다.

PDF·결제내역·Pay Now 제외는 기존 기록에 있으나 Auto-apply·Learn More 각각을 명시적으로 제외한 근거는 없었다. Statements의 View는 청구서 상세가 아니라 **해당 청구서 번호로 검색한 결제내역 목록**으로 연결된다. 이 목적지를 확인하지 않은 과거 설명도 정정한다.

## 직접 대조한 범위와 확인 상태

- Office `/Users/parkjongsun/Repository/dentlink-app`, `feature/DL-17059@1f956ae2971654159e01accfcb26350a4711da9b`, clean.
- 웹 코드 `/Users/parkjongsun/Repository/dentlink-client-notification-center`, `feature/DL-17058@dea89193f78e4004b8fb260ddd709b48ffd5b139`, clean.
- 실제 화면은 사용자가 켜 둔 Android User Credits, iPhone Statements와 일반 Chrome의 DEV 모바일웹 `/credit`, `/billing/statement` 두 탭을 비교했다. 웹은375px viewport이며 기기창 확대율 차이를 디자인 오류로 간주하지 않았다. 앱 화면/창 배치는 유지하고 웹 탭·스크롤은 원위치로 복원했다.
- 두 앱 화면은 기존 REST 실데이터다. 당시 실행 중 Query 상태는 Android 크레딧 잔액·이력 success(이력2페이지12건), iOS 청구서 success(1페이지10건)였다. 알림의 DEV 진입용 행과 목적지의 실데이터를 구분한다. 금액·기간 등 동일한 청구서 표시값도 대조했다.
- 빈 목록/로딩/오류·Retry/추가 페이지/당겨서 새로고침/계정·소속별 캐시와 요청 guard는 구현되어 있다. 청구서는 웹과 같은 OWNER/PAYMENT_MANAGER 제한, 크레딧은 별도 역할 제한 없음. 이번 조사는 전체 역할·네트워크 실패 조건을 새로 실기 QA한 것이 아니다.

## 확인된 차이

| 구분 | 모바일웹 | 현재 앱 |
| --- | --- | --- |
| User Credits 잔액 아이콘 | 사람+크레딧 전용 아이콘 | 알림용 C 코인 아이콘 재사용 |
| Office Credits 잔액 아이콘 | 병원 전용 아이콘 | 같은 C 코인 아이콘 사용(코드 대조) |
| Auto-apply User Credits | 서버값 조회·ON/OFF 저장·설명 펼침/접힘 | 없음 |
| User/Office Learn More | 기존 크레딧 정책 안내 링크 | 없음 |
| 잔액 카드 | 은은한 그림자, 잔액 제목/값 간격1 | 그림자 없음, 간격2 |
| 크레딧 Available 유효기간 | 글자12, 라벨만 bold | 글자14, 전체 medium |
| 크레딧 이력 제목색 | gray800 | mono900으로 더 진함 |
| 기본 텍스트 | Pretendard 기본400, 본문 자간−0.1 | Pretendard Medium500, 일반 자간 별도 지정 없음; 필터 자간+0.15 |
| Statements Paid 배지 | 체크 아이콘·파란 테두리·14 크기 | 아이콘/테두리 없는 옅은 배경·12 크기 |
| Statements View | `/billing/payment-history?keyword={invoiceNo}` 이동 | 버튼/연결 없음 |
| Statements PDF | `/pdf/statement?invoiceId={id}` | 없음(기존 제외) |
| Statements 통화색 | 통화는 연하게, 금액과 구분 | 통화·금액 같은 색 |
| 긴 청구서 텍스트 | 값/청구서번호 한 줄 말줄임 | 일부 값은 줄바꿈 가능(코드 대조; 현재 짧은 값의 오류 아님) |
| 추가 조회 | 스크롤 자동 조회와 View more(페이지) 표시·클릭 | 스크롤 자동 조회·로더, 페이지/더보기 버튼 없음 |
| 맨 위로 | 두 웹 화면에 제공 | 별도 버튼 없음 |
| 새로고침 | 브라우저 새로고침 | 당겨서 새로고침 제공 |

카드 외곽/내부 여백·모서리·선, 크레딧 주요 글자 크기와 행 간격은 상당 부분 같다. 웹의 로고·메뉴·하단 내비게이션과 앱의 뒤로가기·제목은 기존 플랫폼 외곽 구조 차이로 구분한다. 앱에 웹의 전역 UI를 그대로 복제해야 한다는 요구는 아니다. 웹도 IntersectionObserver로 자동 추가 조회하므로 ‘웹은 버튼만, 앱은 자동’이라는 앞선 설명은 잘못이었다.

## 승인 후 보완 제안과 경계

1. **Office 크레딧:** 기존 `GET/PATCH /office/users/own/auto-credit-usage`와 `{ autoCreditUsageEnabled: boolean }`을 이용한 자동사용 조회/저장, 설명 펼침/접힘, 저장 중 중복 조작 및 실패 시 값 복구를 보완한다. 개인 사용자 설정이며 Office Credits에 별도 토글을 만들지 않는다. 기존 웹은 이 API를 실제 사용한다; 앱에서의 실제 권한/응답/저장 검증은 구현 때 한다.
2. **Office 크레딧 안내:** User/Office의 기존 Learn More 목적지와 앱의 기존 Help Center/외부링크 방식을 대조해 연결한다. 환경변수 값을 임의로 바꾸거나 새 정책 페이지를 만들지 않는다.
3. **두 화면 표시:** User/Office별 아이콘, 잔액 카드, 유효기간 타이포, 상태 배지, 통화색 등 명백한 웹 기준 차이를 기존 앱 컴포넌트로 맞춘다. 더보기·맨 위로 같은 편의 동작은 앱의 기존 목록 패턴과 함께 판단하며 앱 공통 타이포/전역 컴포넌트를 광범위하게 바꾸지 않는다.
4. **Statements View는 별도 연결 판단:** 기존 결제내역 화면의 안전한 재사용으로 끝낼 수 있는지 확인한다. 새 네이티브 결제내역 전체 구현이 반드시 필요한 것은 아니다. 기존 WebView 재사용은 후보지만 로그인·소속·keyword·복귀와 목적지의 결제/영수증/PDF 노출을 확인하기 전 간단히 완성된다고 단정하지 않는다. 기존 결제내역/Pay Now 제외를 자동 해제하지 않는다. 큰 확장이나 새 정책이 필요하면 분리한다.
5. **PDF 및 큰 확장:** 기존 제외를 유지한다. 신규 BE·디자인·기획 리소스가 필요한 항목은 임의로 구현하지 않고 구체적인 필요/영향만 제시한다. 이메일 CTA 작업은 여전히 별도다.

위는 다음 작업 제안이며 아직 구현/검증/배포 완료가 아니다. 사용자 승인 시 정확한 Git·작업 범위를 확인하고 작은 변경부터 적용한 뒤 양 OS의 영향 화면과 저장 실패·복귀 등을 비례 검증한다. 기존 알림센터의 BE 대기는 이 FE 보완을 기다려야 할 이유가 아니다.

## 코드·화면 근거

- 웹 `clinic/src/components/Credit/CreditAvailableMobile.tsx`, `CreditItem.tsx`, `clinic/src/services/user/hooks/useUserAutoCredit.ts`, `shared/models/src/user/user.apis.clinic.ts:402–426`.
- 웹 `clinic/src/components/Statement/StatementListMobile.tsx`, `clinic/src/lib/Billing/useBillingStatement.tsx:214–223`, `shared/ui/src/Chip/StatusChip.tsx`, `shared/dlds/src/components/PaginationUI/PaginationInfiniteUI.tsx`.
- 앱 `src/features/credit/screens/CreditScreen.tsx`, `src/features/billing/screens/StatementListScreen.tsx`, `src/queries/useOfficeFinanceQueries.ts`, `src/services/credit.service.ts`, `src/services/billing.service.ts`.
- 로컬 임시 캡처 `/tmp/finance-visible-compare-current.png`, `/tmp/finance-billing-comparison-top.png`, `/tmp/finance-billing-comparison-bottom.png`, `/tmp/finance-credit-comparison-history.png`, `/tmp/finance-credit-comparison-bottom.png`. 장기 보존은 보장하지 않으며 판단 근거를 위에 기록했다.
