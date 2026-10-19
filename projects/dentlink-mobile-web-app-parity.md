# Dentlink 모바일웹 대비 앱 기능 차이 조사

## 현재 상태 — 2026-10-19 코드 조사 완료

사용자 요청은 모바일웹에 있지만 앱에 없는 기능을 **치과 앱·기공소 앱 각각 앱 관점에서 조사**하는 것이다.
제품 코드·브랜치·PR·Jira·배포·서버 데이터는 변경하지 않았다. 정적 소스/메뉴/화면/요청 연결 대조를 완료했으며
실계정·실기기 QA 또는 현재 설치된 OTA의 기능을 검증한 결과는 아니다.

### 비교 기준

fetch 후 고정한 소스를 조사용 임시 사본에서 읽었다. 기존 제품 checkout 및 활성 작업은 유지했다.
웹의 데스크톱 기능 전체와 비교하지 않고 모바일 노출·반응형 조건·모바일 브라우저 차단 여부를 확인했다.

| 제품 | 기준 | 정확한 SHA |
| --- | --- | --- |
| Clinic/Lab 모바일웹 | origin/master | 8772d68825cac6e23792d86a715153a67dc71078 |
| Office 앱 | origin/main | 62e5864dca89e8218a45eaa9ce83f414082747a9 |
| Lab 앱 | origin/main | bb619010b25419b724a5f6acded6f5760bb9af15 |

- Office release/v2.2.4(cdfdb904)와 develop은 위 main과 `src` 차이가 없다.
- 진행 중 Office feature/DL-16317(13b28d680)은 권한·예외 복구 변경이며 아래 관리 화면을 추가한 것은 아니다.
- Lab develop(56cba674)은 main과 `src` 차이가 없다. release/v1.0.5(a32acb02)는 자재 관리 등 64개 소스 파일 변경이 있어 별도 구분했다.
- 웹 release/v1.89.0(162422ab9)은 별도 진행 버전이다. 권한·청구 명칭·밀링 메뉴 확대 등을 main에 이미 배포된 기능으로 취급하지 않았다.
- 위 SHA는 조사 시점의 고정 기준이다. 개발 브랜치·현재 설치 앱·환경별 웹 배포는 서로 같다고 가정하지 않는다.

### 핵심 결과

| 대상 | 모바일웹 대비 앱에서 빠지거나 제한된 사용자 흐름 |
| --- | --- |
| 양쪽 공통 | 알림 이력함의 조회·읽음·삭제, 신규 가입·비밀번호 찾기/변경·회원탈퇴의 앱 내 진입 |
| 치과 | 청구서·결제 내역·미납 결제 관리; Pickup 전용 목록/예약 관리; 치과·구성원·청구 담당자·가격표·Scanner Setup 페이지; 개인 프로필 편집·Promotional SMS 동의; 크레딧 이력/자동사용 설정·추천 관리; 신규 치과 소속 신청/연결 |
| 기공소 | 전체 배송목록·배송 라벨 생성; 직원 초대/관리; 주문목록 카테고리·치과명·날짜 조건; 긴급/지연 주문 집계·모아보기; 소속 기공소 직접 선택 진입(구현 일부 있으나 현재 UI 비활성) |

이 목록은 모든 항목을 버그 또는 추가 개발 확정 요구사항으로 선언하는 것이 아니다. 주로 **앱의 정상 메뉴·화면 진입 부재**이며,
앱 내 임의 채팅/CMS 링크를 통한 우회까지 불가능하다는 뜻은 아니다. 권한에 따른 웹 기능은 같은 권한의 사용자를 기준으로 비교한다.

### 누락으로 세지 않은 것

- 주문·환자 목록/상세, LinkTalk·지원 채팅, Help Center, 파일 다운로드/미리보기, 디자인 승인은 네이티브 또는 WebView/브리지 경로가 있다.
- 치과 앱의 피드백, Case Preference, 결제수단 관리·카드 등록, 주문 작성 과정의 픽업 예약·크레딧 적용, 기존 치과 전환도 제공된다.
- 기공소의 주문별 배송 조회와 프로필 이미지/표시명/전화번호/소개 편집은 제공된다. 전체 배송 관리나 직원 관리와 구분한다.
- Remake 및 전체 웹 주문작성 폼은 모바일웹 자체에도 제한이 있다. 이를 앱만의 누락으로 분류하지 않는다.
- Clinic Order Board/Organization Dashboard, Lab 주문목록 Excel 및 일반 Lab의 데스크톱 메뉴만 있는 정산/보드 등은 핵심 비교에서 제외했다.
- Lab의 PaymentMethodScreen은 등록돼 있지만 실제 Forbidden 처리된다. 파일 존재를 지원 증거로 사용하지 않았고,
  일반 Lab 모바일웹 대응 기능도 확인되지 않아 누락 항목으로 추가하지 않았다.

### WebView 대조 근거

- [파일 다운로드 브리지](https://github.com/Innvoaid/dentlink-client/blob/8772d68825cac6e23792d86a715153a67dc71078/clinic/src/common/hooks/useFileMultipleDownload.tsx#L21),
  [Office 수신 처리](https://github.com/Innvoaid/dentlink-app/blob/62e5864dca89e8218a45eaa9ce83f414082747a9/src/features/common/components/DentlinkWebView.tsx#L691).
- [Office 결제수단 WebView](https://github.com/Innvoaid/dentlink-app/blob/62e5864dca89e8218a45eaa9ce83f414082747a9/src/features/common/screens/PaymentMethodScreen.tsx#L205),
  [피드백 네이티브 이동](https://github.com/Innvoaid/dentlink-client/blob/8772d68825cac6e23792d86a715153a67dc71078/clinic/src/pages/orders/%5Border_id%5D/index.tsx#L178).
- 정상 주문상세·결제수단 WebView는 웹 전역 헤더를 숨기고 Help는 nonLayout을 사용한다.
  따라서 이들 화면이 빠진 관리 메뉴를 자동으로 제공한다는 근거는 없다.
- 창 열기·외부 링크의 WebView 처리는 존재하므로 외부 링크 전체 차단으로 설명하지 않는다.

## 근거를 읽는 방법

아래 각 파일 경로·줄 번호는 위 고정 SHA의 소스 기준이다. 실제 구현 중인 로컬 checkout의 줄 번호와 다를 수 있다.
치과 절의 `web`은 dentlink-client, `office`는 dentlink-app이다. 기공소 절의 웹은 dentlink-client,
앱은 별도 dentlink-lab-app이다. 생성 API 선언·화면 등록만으로 기능이 있다고 판정하지 않고 실제 호출·진입을 확인했다.

## 치과 앱 상세


| 영역 | 모바일웹 근거 | Office 앱 상태 및 근거 |
|---|---|---|
| 알림 이력함 | web `clinic/src/components/Layout/Header.tsx:98-105` 종 버튼; `shared/ui/src/NotificationUI/NotificationUI.tsx:272-320` 모바일 포털; `clinic/src/components/Notifications/useNotificationsPagination.tsx:33-61,88-123` 목록/필터/삭제/모두읽음 | 전용 화면·진입 없음. office `src/navigations/AllScreens.ts:27-51` 전체 등록화면에 알림함 없음. `ProfileNotificationSection.tsx:77-120,246-320`은 푸시 설정만이며 이력함이 아님. OS 푸시 자체는 제공. |
| Billing Statements·Payment History·미납 결제 관리 | web `clinic/src/common/constants/menus.ts:74-97`, `HeaderHamburgerMenu.tsx:44-53` OWNER/PAYMENT_MANAGER 모바일 Billing. `clinic/src/pages/billing/statement/index.tsx:45-47` 모바일 다운로드, `billing/payment-history/index.tsx:184-201` 모바일 내역·선택·PayNow | 앱 기본 진입 없음. AllScreens:27-51에는 PaymentMethod/Eximbay/BillingPolicy만. `src/features/common/components/EmployeeSelectBottomSheet.tsx:60-87`에도 Payment Method만. **결제수단 자체는 앱 제공:** `PaymentMethodScreen.tsx:93-96` `/billing/payment-method` WebView. |
| Pickup 전용 관리(오늘·예정·과거 목록, 별도 예약/재예약·확정) | web `menus.ts:48-55`, `clinic/src/pages/pickup/index.tsx:30-177`, `shared/ui/src/PickupUI/PickupUI.tsx:87-111` | 전용 목록·관리 화면 진입 없음(AllScreens:27-51). **주문 작성 과정의 PVS/픽업 예약은 있음:** `src/libs/useUpdateOrderAdditional.ts:200-208,270-281`, `src/services/office.service.ts:220-242`. 픽업 전체 불가로 표현 금지. |
| Office 운영관리(구성원 목록·상세, 치과정보 수정, 청구 담당자, Office dashboard·scanner 계약정보) | web `menus.ts:100-128`; `clinic/src/pages/office/managed/index.tsx:123-219` 모바일 탭/목록; `clinic/src/components/OfficeMemberList/OfficeMemberMobileList.tsx:39-75` 상세; `OfficeManaged/OfficeManagedEmployerInfo.tsx:60-63,92-102` OWNER 수정 | 앱 기본 진입 없음. `EmployeeSelectBottomSheet.tsx:54-87` 기존 소속 전환·결제수단만. 앱 치과 전환은 제공. 구성원 초대/권한 수정의 세부 모바일 허용 여부까지 일괄 확정하지 않음. |
| Fee Schedule / Scanner Setup | web `menus.ts:110-118` 모바일 메뉴에 hide 플래그 없음; `clinic/src/pages/office/pricing/index.tsx:39-63`, `office/scanners/index.tsx:34-69` | 앱 기본 진입 없음(AllScreens/profile/치과선택). 스캐너 draft 주문 수신과 스캐너 연결 설정은 별개. |
| 개인 프로필 편집·계정 삭제·암호 변경 | web `clinic/src/pages/my/index.tsx:138-158` 사진 편집, `clinic/src/components/My/MyProfileSection.tsx:46-57` 전화번호 수정, `clinic/src/pages/my/SettingButton.tsx:10-17,36-59` Reset Password/Delete Account | 앱 편집 UI 없음. `src/features/profile/sections/ProfileOfficeSection.tsx:26-43` 읽기 표시, :45-66 설정·알림·링크·로그아웃. `src/features/profile/screens/ProfileScreen.tsx:78-94` 이동 콜백에도 없음. |
| Promotional SMS 동의 | web `clinic/src/components/My/UserSetting.tsx:167-192` 모바일 스위치 | 앱 없음. ProfileNotificationSection:77-120의 푸시 설정과 SMS 동의는 별개. |
| User/Office Credits 이력·User Credit 자동사용 설정 | web `HeaderProfilePopupMenu.tsx:44-87`; `clinic/src/pages/credit/index.tsx:107-118,140-151` 모바일 자동사용·내역; `OfficeManagedEmployerInfo.tsx:115-131` Office Credits 진입 | 관리 페이지 진입 없음/일부 제공. 앱 `src/features/order/steps/step4OrderDetailsAndSubmit/OrderSummarySection.tsx:79-106,210-248,272-302`에 주문별 크레딧 적용과 Office 자동적용 존재. credit 사용 전체 누락 아님. |
| Referrals 추천 초대·내역 | web `HeaderProfilePopupMenu.tsx:89-117`, `clinic/src/pages/my/referrals/index.tsx:54-81` mobile layout·초대 | 앱 기본 진입 없음. `ProfileQuickLinksSection.tsx:32-44` Pending Reviews/Help Center만. |
| My Office 신규 소속 찾기·가입 신청·신청 취소/연결 관리 | web `MyQuickLinks.tsx:58-64`, `clinic/src/components/My/MyOffice.tsx:47-65,80-98` office/find·신청취소·추가 | 앱 기본 진입 없음. `EmployeeProfile.tsx:119-129`, `EmployeeSelectBottomSheet.tsx:54-87`은 이미 소속된 치과 전환. 새 치과 가입/연결과 기존 소속 전환을 구분. |
| 신규 회원가입·로그인 전 비밀번호 찾기 | web `clinic/src/pages/auth/signin.tsx:15-33`, `clinic/src/lib/AuthSigninForm/useSigninForm.tsx:33-60` 가입·암호찾기 이동. signup에는 모바일 flow 있음(root 교차확인) | 앱 로그인에 없음. `src/features/auth/screens/SigninScreen.tsx:31-134` 이메일/암호/Sign In만, signup/forgot/reset 등록화면·외부 이동 버튼 없음. 초대수락·치과등록까지 앱내 온보딩이 있다고 볼 근거 없음. |

## 누락에서 제외 / 반증

- 홈 Action Required/주문 추적, 주문 생성·ISV, 주문/환자목록·상세, LinkTalk, 피드백, Case Preference, Design Approval, Help Center는 앱 제공.
- 앱 주문상세 `src/features/orderList/screens/OrderDetailScreen.tsx:46-49`는 `/orders/:id` WebView. 네이티브 코드 부재만으로 웹 공유 기능을 누락으로 세지 않음.
- 주문 검색(환자명/주문번호), 상태·담당의사·주문일 필터, My Orders Only는 앱 `OrderSearchForm.tsx:203-265`, `OrderFilterBottomSheet.tsx:132-146`, `OrderListTabScreen.tsx:107-127`에 존재. 웹 `clinic/src/pages/orders/index.tsx:56-82` 및 `shared/ui/src/OrderListUI/OrderListLayer/OrderListLayerMobile.tsx:88-139`와 대조: 명확한 필터 누락 발견되지 않음.
- 환자명 검색·My Patients Only·최근 주문 상세이동은 양쪽 존재(web `clinic/src/pages/patients/index.tsx:48-71`, app `OrderPatientTabScreen.tsx:60-64`, `OrderPatientListItem.tsx:63-69`). case status/recent case/dentist/total case/order 필드도 양쪽 제공.
- Order Board/Organization Dashboard는 web menus.ts:42-46,130-134에서 모바일 숨김: 누락 제외. Office Overview 내 owner dashboard는 별도 모바일 지원.
- 모바일 주문 목록에는 desktop export·일괄 행액션이 없어 앱 누락으로 추가하지 않음.
- Remake는 모바일웹도 RemakeMobileNotSupport로 차단(index100/additional124/info286), 일반 웹 주문작성도 `clinic/src/components/Order/OrderForm.tsx:129-132` isMobile 차단. 앱만 누락으로 세지 않음(guard agent 교차확인).
- 파일 다운로드·미리보기·디자인승인은 native bridge/viewer가 있어 전체 누락 아님. 실제 OS 동작 QA는 미실행.

## 앱 기본 진입 부재와 완전 차단은 구분

- 주문상세 web `clinic/src/pages/orders/[order_id]/index.tsx:485` headerShown !isDentlinkApp, PaymentMethod web `billing/payment-method/index.tsx:245` 동일.
- Help `clinic/src/components/Help/HelpCenter.tsx:59` Layout nonLayout, Layout.tsx:65-66 children만; HelpCenterLayout.tsx:19 앱 헤더 감춤. 기본 Help에서 전역메뉴 우회는 없음(guard agent 교차확인).
- CasePreference는 native screen(`src/features/casePreference/screens/CasePreferenceScreen.tsx:1-25,158+`)이므로 웹 공통헤더 진입이 아님.
- 단 임의 CMS Help article/배너/채팅 링크까지 수집하지 않았으므로 ‘어떤 방법으로도 앱에서 불가’는 과장. 기본 앱 메뉴/화면 진입 없음으로 표현.

## release/진행 branch 보조 점검

- origin/release/v2.2.4 `cdfdb90457985e19738400a5125519eb77f46783`.
- origin/feature/DL-16317 `13b28d680d4003f20a4dc1bfdcd9bf2ad67eaef3`.
- `git diff origin/main origin/release/v2.2.4 -- src`: 차이 없음.
- permission feature vs main의 navigation/profile/EmployeeSelectBottomSheet에 새 관리화면 차이 없음. 주문/환자 권한·필터 조건 차이는 있으나 위 관리메뉴를 추가한 것은 아님. feature를 main의 단순 상위 버전으로 취급하지 않음.
- 배포/QA 완료 판단은 별개.

## 기공소 앱 상세


### 1. 전체 배송 관리 및 배송 라벨 생성 — 앱 정상 진입 없음

- 모바일웹 하단 Shipping 메뉴: `lab/src/components/Layout/NavigationMobile.tsx:111-122`.
- 실제 배송목록·필터·등록: `lab/src/pages/shipping/index.tsx:103-168`.
- Create Label 버튼은 DataGrid의 데스크톱 전용 영역이 아니라 직접 렌더링됩니다(`shipping/index.tsx:107-110`, `shared/ui/src/ShippingPickupUI/ShippingRegisterUI/ShippingRegisterUI.tsx:198-230`).
- 배송 상세, 배송에 연결된 픽업 상세도 웹에서 이동 가능합니다: `lab/src/lib/Shipment/useShippingList.tsx:65-82,149-167`.
- 앱은 Home / Orders / LinkTalk / Profile만 주요 탭이며 배송목록/등록 route가 없습니다: `src/navigations/BottomTabNavigator.tsx`, `src/configs/types/navigation.ts:15-112`, `src/navigations/RootNavigator.tsx:180-282`, `src/configs/constants/deepLink.ts:19-139`.
- 단, **주문별 배송 조회는 앱 주문 상세 WebView로 제공**됩니다. 앱 `src/features/orderList/screens/OrderDetailScreen.tsx:39-43,165-199`; 웹 주문 상세 `lab/src/pages/orders/[order_id]/index.tsx:424`에서 앱이면 전역 헤더 숨김. 주문 상세에서 /shipping으로 직접 이동하는 코드도 미발견입니다.
- 표현: “배송 기능 전체가 없다”가 아니라 “전체 배송목록·라벨 생성 등 배송 관리 진입이 없다”.

### 2. 알림 이력함 — 앱 미제공

- 모바일웹 하단 Notifications: `lab/src/components/Layout/NavigationMobile.tsx:153-157`.
- 알림 리스트·종류 필터: `lab/src/components/Notifications/useNotificationsPagination.tsx:24-63,78-82`.
- 삭제·모두 읽음·부분 읽음·알림 대상 이동: 같은 파일 `85-143`.
- 앱은 관련 화면/route가 없으며 models를 제외한 실제 코드에 findNotifications / markAllNotificationsAsRead / notification history 호출도 없습니다.
- **푸시 수신·설정과 LinkTalk 안읽음 기능은 있습니다.** 앱 `src/features/profile/sections/ProfileNotificationSection.tsx:72-102`, `src/configs/utils/fcmHandler.ts`. 이를 알림 이력함과 혼동하지 않아야 합니다.

### 3. 직원 초대·직원 관리 — 앱 정상 진입 없음

- 모바일웹 Header는 AccountMenu를 모바일에서도 렌더링: `lab/src/components/Layout/Header.tsx:122-145`.
- Owner 계정 초대/관리 메뉴: `lab/src/components/Layout/AccountMenu.tsx:204-228`.
- 목록·역할/권한·퇴사 등 관리: `lab/src/pages/members/index.tsx:27-38,70-98`; 초대 목록/폼 `lab/src/pages/members/invites/index.tsx:60-73`.
- 앱 Profile은 개인 정보·알림 설정·로그아웃으로 구성: `src/features/profile/screens/ProfileScreen.tsx:94-118`, `src/features/profile/sections/ProfileLabSection.tsx:216-309`.
- 앱 route/types/deepLink 전체에 members/invites 화면 또는 웹 이동이 없습니다.
- 계정 권한에 따른 조건부 웹 기능이며 모든 직원에게 항상 노출되는 기능은 아닙니다.

### 4. 회원가입·비밀번호 찾기 — 앱 로그인 화면에 진입 없음

- 웹 Lab 로그인: `lab/src/pages/auth/signin.tsx:26-32`; 실제 Lab 전용 Create Account / Forgot Password 링크 `shared/ui/src/AuthUI/Signin/SigninForm.tsx:122-148`.
- 가입은 기공소 소장 확인 팝업 이후 가입 경로, 비밀번호 찾기 이동은 `lab/src/lib/AuthSigninForm/useSigninForm.tsx:34-66`.
- 앱 로그인은 이메일·비밀번호·Sign In뿐: `src/features/auth/screens/SigninScreen.tsx:48-133`.
- RootStack와 AuthNavigator에 signup/forgot/change password 화면 및 외부 웹 연결이 없습니다.
- 앱 내에서 해당 절차를 시작할 수 없다는 의미이며 사용자가 별도 브라우저에서 웹을 열어 수행하는 것은 가능합니다.

### 5. 로그인 후 비밀번호 변경·회원탈퇴 — 앱 Profile에 진입 없음

- 웹 My Profile Security 영역: `lab/src/pages/my/index.tsx:163-206`.
- 앱 개인 프로필 편집은 displayName, telephoneNumber, 소개, 이미지 변경으로 한정: `src/features/profile/screens/ProfileLabEditScreen.tsx:54-90,184-217`.
- 앱 Footer는 앱 버전·Sign Out 및 개발/스테이징 간편 로그인뿐: `src/features/profile/sections/ProfileFooterSection.tsx:63-99`.
- 비밀번호 변경 및 계정 삭제의 화면/route/web 링크는 미발견입니다. 프로필 편집 기능 전체가 없는 것은 아닙니다.

### 6. 주문목록의 상세 검색·날짜 조건 — 앱 일부 제한

- 모바일웹 주문목록은 `DataGrid.Filters`를 숨김 없이 렌더링: `lab/src/pages/orders/index.tsx:67-78`.
- 웹 추가 검색조건: categoryIds(카테고리), officeName(치과명), 주문일·출고예정일·취소일 범위: `lab/src/lib/OrderList/useOrderList.tsx:568-629`.
- 모바일 필터/날짜 토글 실제 렌더: `shared/ui/src/DataGrid/DataGridFilters/DataGridFilters.tsx:195-285`; 기본 display:flex `303`.
- 앱 실제 주문목록 요청은 orderStatuses, inProgressDetailStatuses, patientName, orderId만 전달: `src/features/orderList/tabs/OrderListTabScreen.tsx:88-109`.
- 앱 필터 UI 파일 안에 Date/Dentist 관련 잔여 코드가 있어도 실제 Lab 목록 요청에 해당 조건이 전달되지 않으므로 웹과 동등 지원으로 간주할 수 없습니다.
- 앱 `release/v1.0.5`의 필터 차이는 화면 높이/스크롤 보완이며 위 검색조건 추가는 없습니다.
- 환자명/주문번호/주문상태 필터는 있으므로 “검색·필터 미지원”이 아니라 누락 조건을 특정해야 합니다.

### 7. 긴급 주문·지연 주문의 집계 및 모아보기 — 앱 일부 제한

- 모바일웹 홈은 Order Issues 영역 렌더: `lab/src/components/Dashboard/Dashboard.tsx:92-109`.
- 긴급·지연 건수 및 각각 progressEndAt / delayBaseAt 필터 연결: `lab/src/lib/Dashboard/useDashboardIssueCount.tsx:17-49`.
- 앱 Home Action Required는 In Review 및 Ready for Fabrication만: `src/features/home/sections/HomeLabActionRequiredSection.tsx:64-76`.
- 앱 홈 조회는 전체 주문/NEW/READY_FOR_FABRICATION: `src/libs/useHomeOrdersData.ts:26-73`.
- 비생성 코드에 urgentCount/delayCount/progressEndAt/delayBaseAt를 이용한 조회/집계가 없습니다.
- 개별 주문 Delayed 상태 배지 코드는 있습니다(`src/features/orderList/components/OrderStatusBadge.tsx:17-48`). 따라서 지연 표시 자체가 없다는 뜻은 아닙니다.

### 8. 로그인 상태에서 소속 기공소 전환 — 코드 있으나 정상 진입 비활성

- 모바일웹 햄버거 메뉴 Profile: `lab/src/components/Layout/Header.tsx:247-255`; Profile 버튼이 전환 패널을 엶: `lab/src/components/Layout/Profile.tsx:40-65`; 다중 소속 여부에 따른 전환 UI.
- 앱 현재 Home은 EmployeeProfile만 실제 렌더: `src/features/home/screens/HomeScreen.tsx:333-342`.
- EmployeeProfile에는 전환 BottomSheet/handler가 있지만 실제 프로필 영역은 View이고 BottomSheet.present를 호출하는 버튼이 없습니다: `src/features/common/components/EmployeeProfile.tsx:121-168`.
- 새 HomeProfileHeader 및 밀링 경로는 `10/26 배포일에 해제` 주석으로 비활성: `HomeScreen.tsx:336-342`, `src/navigations/RootNavigator.tsx:183-203`.
- 딥링크는 employerId 전환 처리를 가지므로 “소속 전환 기능 완전 미구현”이 아닙니다. **직접 선택 UI 진입 비활성**으로 분류합니다.
- Lab release/v1.0.5도 HomeScreen/EmployeeProfile의 이 부분은 main과 같습니다. 새 Header의 재료QR 추가만 있으며 정상 홈의 전환 진입 활성화 증거는 없습니다.

## 누락으로 세면 안 되는 항목

- 주문 목록/상세: 앱 목록 네이티브 + 상세 WebView 제공. 상세에서 파일, 메모, 주문 상태 관련 기능은 shared web 화면을 사용하므로 개별 차단 근거 없이는 누락으로 적지 않습니다.
- 환자 목록 및 환자별 주문 이동: 앱 `src/features/orderList/screens/OrderListScreen.tsx:91-114`, `tabs/OrderPatientTabScreen.tsx:43-59,146-153`, `components/OrderPatientListItem.tsx`에 구현되어 있습니다.
- 채팅/LinkTalk, Dentlink Support, Help Center: 네이티브 또는 WebView 경로 제공. Support → HelpCenter 연결(`features/common/components/DentlinkSupportBanner.tsx`)도 있습니다.
- 프로필 이미지·표시명·전화번호·소개 수정, 알림 수신 설정: 네이티브 제공.
- 주문목록 Excel 내보내기: 웹 `InvoiceExcel`는 `DataGrid.FunctionTab` customButtons이고 right-section이 모바일에서 display:none. `shared/ui/src/DataGrid/DataGridFunctionTab/DataGridFunctionTab.tsx:172-175`. **모바일웹 전용 격차에서 제외**.
- 일반 Lab 주문보드·정산 전체메뉴·독립 픽업 스케줄 메뉴: 코드가 있지만 데스크톱 Aside에서만 노출됩니다(`Aside.tsx:80-99`, `Menus.tsx:124-163`). 일반 모바일웹 기본 메뉴에 없으므로 이번 핵심 확정 목록에서 제외합니다. 단 배송목록에 연결된 픽업 상세는 모바일에서도 접근 코드가 있습니다.
- 리메이크: Lab 모바일웹도 isMobile일 때 RemakeMobileNotSupport로 차단하므로 앱만의 누락이 아닙니다(guards 담당과 교차검증).
- 결제 수단: 앱 PaymentMethodScreen는 route만 있고 canManagePaymentMethod=false로 막지만, 일반 Lab 모바일웹에서 대응하는 정상 메뉴 진입을 확인하지 못했으므로 누락 목록에서 제외합니다.
- 인쇄/Excel/고정 폭 표처럼 데스크톱 전용 컨트롤을 모바일웹 기능으로 포함하지 않습니다.

## 밀링/공유기공소 계정 및 진행중 release 차이 — 별도 범위

- 웹 SHARED 계정은 `/mc` 공유기공소 관리 메뉴를 모바일 햄버거에서도 렌더합니다: `lab/src/components/Layout/SharedLabAside.tsx:44-104,194-219`.
- 설비, 제품·옵션, 자재목록/입고/출고/재고, 정산(권한조건)이 존재합니다. 외부기공소는 `/milling` 흐름이며 일반Lab과 다른 계정 범위입니다.
- 앱 main에는 MillingOrderList/Detail 화면 자체가 있으나 RootNavigator의 등록과 Home 진입이 10/26 주석으로 꺼져 있습니다. 미구현이라고 단정하면 안 됩니다.
- 앱 `release/v1.0.5`에는 MillingMaterialForm/Entry/Stock/Detail/QrScan 5개 화면 및 query/service가 추가됐습니다. RootNavigator에 위 5개는 등록돼 있지만 기존 밀링 주문 진입 블록은 여전히 주석입니다. 구현 존재·정상 진입·배포를 분리해야 합니다.
- 웹 `release/v1.89.0`에는 INTERNAL 계정의 모바일 햄버거 `SiteResourceMenus`가 추가되어 설비·자재 메뉴 진입이 확대됩니다(`Header.tsx` diff 신규 3줄, 신규 SiteResourceMenus.tsx의 labType INTERNAL 조건).
- 같은 웹 release에는 SHARED 생산/공정/생산품/검사/공급사 메뉴도 추가됩니다. 앱의 일부 자재구현과 전체를 단순 1:1 비교하거나 이번 일반 Lab 미지원 목록에 합산하지 않습니다.
- 두 release 모두 저장소 구현상 비교일 뿐, 실사용자에게 활성화/배포됐다는 증거로 사용하지 않습니다.

## 확인 한계 / 다음 단계

- UI 코드의 정상 메뉴·route·query 연결 기준으로 비교했습니다. 로그인된 실기기에서 버튼 활성 상태, 서버 권한, 특정 알림/배너 링크, 모든 파일 유형 및 OS별 동작을 검증하지 않았습니다.
- 서버가 보내는 임의 배너/Help 문서의 링크를 따라 우회 접근이 가능할 수 있지만 이를 정상 제공 기능으로 계산하지 않았습니다.
- 구현 착수 또는 API 쓰기, 테스트 실행, 브랜치/PR 변경은 하지 않았습니다.

## 다음 시작점

- 조사 요청은 완료됐다. 사용자 결정 전 기능 구현·Jira 신규 카드·추가 세션·QA·배포를 시작하지 않는다.
- 앱 보완을 진행한다면 위 항목에서 대상과 우선순위를 정한 후 제품별 담당 카드/세션으로 전달한다.
- 특정 항목의 실제 앱 제공 여부를 확정해야 할 때는 동일 계정·권한·서버 환경으로 모바일웹과
  iOS/Android 설치 앱을 대조하고 바이너리·OTA 버전을 기록한다. 이는 이번 정적 조사와 별도 단계다.
- 밀링/공유기공소 계정은 기공소 세부 절의 release 구현과 진입 비활성 상태부터 다시 확인한다.
