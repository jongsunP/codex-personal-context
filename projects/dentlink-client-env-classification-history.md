# Dentlink 환경변수 최초 이전 분류 이력

2026-10-20 회의 후 사람 수동 관리로 전환하면서 프로젝트에서 제거한 이전 조사 기록입니다. 실제 값은 포함하지 않습니다. 아래 상세 분류와 옛 도구·manifest 링크는 **과거 판단 근거**이며 현재 팀 운영 절차가 아닙니다. 현재 상태는 [프로젝트 체크포인트](dentlink-client-env-management.md)를 따릅니다.

아래 코드·문서 경로는 당시 `dentlink-client` 저장소 기준입니다. 개인 컨텍스트의
상대 링크가 아니며 현재 파일 존재나 이전 도구의 사용 가능성을 보장하지 않습니다.

---

# 환경변수 분류표

값은 기록하지 않습니다. `scripts/env/manifest.json`이 서비스·환경별 공급 허용 목록이며, 이 문서는 분류 이유를 설명합니다.

## 공급 기준

이번 범위는 기존 FE 값을 유지하고 보관·공급 위치를 옮기는 것입니다. Google 검색은 공식 브라우저 SDK를 사용합니다. Secrets 보관과 브라우저 비밀값 제거는 별개이며, 아래 보안 조치를 완료하기 전 전체 보안 문제가 해결됐다고 판단하지 않습니다.

| 분류 | 공급 방법 |
| ----------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| `public-build` | 공개 설정을 GitHub Environment Variables에 저장하고 빌드에 전달합니다. |
| `build-secret` | 기존 빌드에 필요한 비공개 값입니다. 로컬 build private 파일과 GitHub `DENTLINK_BUILD_ENV`로 공급합니다. 기존 브라우저 노출까지 해결되지는 않습니다. |
| `server-config` | 비밀이 아닌 서버 설정입니다. Variables에 저장하며 공개 빌드 입력과 구분합니다. |
| `server-secret` | 서버 인증값·내부 webhook입니다. 기존 Secrets → ECS 공급을 유지하며 로컬은 runtime private 파일을 사용합니다. |
| `test-config` / `test-secret` | 테스트 설정·계정·비밀번호입니다. 로컬 E2E private 파일과 GitHub `DENTLINK_E2E_ENV`로 공급하며 앱 빌드에 넣지 않습니다. |
| `blocked` | 기존 env에 없는 추가 발견 항목 중 자동 공급하지 않는 값입니다. 기존 9개 env의 값 보존을 막는 항목은 아닙니다. |

`NEXT_PUBLIC_`라는 이름만으로 공개 가능 여부를 결정하지 않습니다. 다만 기존 브라우저 소비 방식은 이번 작업에서 바꾸지 않습니다. 각 SDK의 도메인·권한 제한과 키 교체는 별도 검토 사항입니다.

## 값 보존과 전환 기준

- `NEXT_PUBLIC_EXIMBAY_SECRET_KEY`와 `NEXT_PUBLIC_MEDITLINK_KEY`는 `build-secret`으로 기존 값을 보존합니다. Variables에는 넣지 않습니다. Eximbay 브라우저 서명과 Medit의 현재 소비 여부를 근거로 값을 임의로 삭제하거나 기능을 바꾸지 않습니다.
- Admin·Clinic DEV/STAGE/PRD는 `DENTLINK_BUILD_ENV`, Clinic DEV/STAGE는 `DENTLINK_E2E_ENV`를 사용합니다. 묶음에는 서비스·환경·종류 헤더를 포함합니다.
- 새 PC에는 `env:pack`으로 암호화한 파일을 기존 팀 DM으로 보내고 비밀번호를 별도 통화·대면으로 공유합니다. 수신자는 `env:unpack`합니다. 당시 사용법은 제품 저장소의 `docs/environment-variables.md`에 있었습니다.
- 기존 env 9개의 Git 추적은 아직 유지합니다. 설정값 보존과 로컬·빌드·E2E 공급 검증을 마친 뒤 전환합니다. PRD 값의 준비·복원은 권한 있는 기존 값으로만 진행하며 자동 배포하지 않습니다.

## 범위와 manifest 읽는 법

- 기존 9개 env의 서로 다른 키 **105개**를 빠짐없이 분류했습니다. 서비스가 같아도 DEV·STAGE·PRD의 키 목록은 다를 수 있습니다.
- `scopes`: 현재 그 키가 존재하는 서비스·환경입니다. 예: `clinic-stage`. `environments`는 이를 `development/staging/production` 파일 이름과 연결합니다.
- `optionalScopes`: 현재 빈 값인 환경입니다. 비어 있지 않은 기존 값의 누락은 오류로 처리하고, 비어 있던 값은 없는 Variables를 빈 값으로 정규화할 수 있습니다. 기능 전체가 선택이라는 뜻은 아닙니다.
- `detectedOnly: true`: 소스나 도구에서 추가로 발견한 설정입니다. 실제 사용 값·필수 여부는 미확정이므로 자동 등록하지 않습니다. 모든 해당 scope가 선택 항목입니다.
- `NODE_ENV`, GitHub/Playwright의 실행 제어 변수, 생성된 출력 경로는 앱 설정 이관 대상에 포함하지 않았습니다.
- 소비처는 대표 경로만 아래에 표시합니다. 전체 경로와 정확한 환경별 목록은 manifest에서 확인합니다. 직접 참조가 없거나 주석에만 있는 키는 별도로 표시했으며, 이번 준비에서 임의로 삭제하지 않습니다.

| 서비스·환경 | 기존 키 수 | 공개 빌드 | 빌드 비공개 | 서버 일반 | 서버 비밀 | 테스트 일반/비밀 | 보류 |
| -------------- | ---------: | --------: | ----------: | --------: | --------: | ---------------: | ---: |
| `admin-dev` | 29 | 18 | 1 | 2 | 8 | 0/0 | 0 |
| `admin-stage` | 29 | 18 | 1 | 2 | 8 | 0/0 | 0 |
| `admin-prd` | 29 | 18 | 1 | 2 | 8 | 0/0 | 0 |
| `clinic-dev` | 86 | 36 | 2 | 0 | 1 | 39/8 | 0 |
| `clinic-stage` | 88 | 38 | 2 | 0 | 1 | 39/8 | 0 |
| `clinic-prd` | 42 | 39 | 2 | 0 | 1 | 0/0 | 0 |
| `lab-dev` | 25 | 24 | 0 | 0 | 1 | 0/0 | 0 |
| `lab-stage` | 25 | 24 | 0 | 0 | 1 | 0/0 | 0 |
| `lab-prd` | 25 | 24 | 0 | 0 | 1 | 0/0 | 0 |

## 기존 env 키 전체 목록

| 서비스 | 키 | 분류 | 근거·대표 소비처 |
| ---------------- | ------------------------------------------------------- | --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| admin | `GEMINI_RAG_API_KEY` | `server-secret` | Admin 서버 API의 Gemini 인증값. `.github/workflows/admin_dev_build_and_deploy.yml` 외 |
| admin/clinic/lab | `JIRA_API_TOKEN` | `server-secret` | 서버 QA 위젯의 Jira API 인증값. `.github/workflows/admin_dev_build_and_deploy.yml` 외 |
| admin | `N8N_COPILOT_LOG_WEBHOOK_URL` | `server-secret` | 내부 webhook URL. URL 자체가 접근 정보를 포함할 수 있어 비밀값으로 관리. `.github/workflows/admin_dev_build_and_deploy.yml` 외 |
| admin | `N8N_EMPLOYER_ADDRESS_WEBHOOK_TOKEN` | `server-secret` | 서버 webhook 인증 토큰. `.github/workflows/admin_dev_build_and_deploy.yml` 외 |
| admin | `N8N_EMPLOYER_ADDRESS_WEBHOOK_URL` | `server-secret` | 서버에서 호출하는 내부 webhook URL. 공개 빌드에서 제외. `.github/workflows/admin_dev_build_and_deploy.yml` 외 |
| admin | `N8N_LINKTALK_INSIGHT_WEBHOOK_URL` | `server-secret` | 서버에서 호출하는 내부 webhook URL. 공개 빌드에서 제외. `.github/workflows/admin_dev_build_and_deploy.yml` 외 |
| clinic | `NEXT_PUBLIC_AMPLITUDE_DOMAIN` | `public-build` | 브라우저 분석 SDK의 쿠키 도메인 설정. `clinic/src/common/hooks/useAmplitudeInit.ts` |
| clinic/lab | `NEXT_PUBLIC_AMPLITUDE_ENABLED` | `public-build` | 브라우저 기능 활성화 여부. `shared/configs/utils/amplitude.ts` |
| clinic/lab | `NEXT_PUBLIC_AMPLITUDE_ID` | `public-build` | Amplitude Browser SDK의 수집용 프로젝트 API key. 조회용 secret key와 구분. `clinic/src/common/hooks/useAmplitudeInit.ts` 외 |
| clinic/lab | `NEXT_PUBLIC_AMPLITUDE_SESSION_REPLAY_ENABLED` | `public-build` | 브라우저 기능 활성화 여부. `shared/configs/utils/amplitude.ts` |
| admin/clinic/lab | `NEXT_PUBLIC_API` | `public-build` | 화면과 웹 빌드에 사용하는 공개 서비스/CDN 주소. `.github/workflows/clinic_stg_build_and_deploy.yml` 외 |
| clinic | `NEXT_PUBLIC_ASSET_PREFIX` | `public-build` | 화면과 웹 빌드에 사용하는 공개 서비스/CDN 주소. `clinic/next.config.js` |
| clinic | `NEXT_PUBLIC_ASSET_PREFIX_OHIO` | `public-build` | 지역별 공개 CDN 주소. 현재 소스에서 직접 참조는 찾지 못함. 직접 참조 미발견 |
| admin/clinic/lab | `NEXT_PUBLIC_AWESOME_LAB_ID` | `public-build` | 화면 휴일 정책에 사용하는 Lab 식별자. 인증 수단이 아님. `shared/configs/constants/holiday.ts` |
| admin/clinic/lab | `NEXT_PUBLIC_CDN_ASSET_URL` | `public-build` | 화면과 웹 빌드에 사용하는 공개 서비스/CDN 주소. `clinic/src/pages/_document.tsx` 외 |
| admin/clinic/lab | `NEXT_PUBLIC_CDN_URL` | `public-build` | 화면과 웹 빌드에 사용하는 공개 서비스/CDN 주소. `admin/src/pages/api/download/files/index.ts` 외 |
| clinic | `NEXT_PUBLIC_CHANNEL_TALK_PLUGIN_KEY` | `public-build` | ChannelTalk 브라우저 SDK의 pluginKey. 사용자 인증 memberHash와 구분. `clinic/src/pages/_app.tsx` |
| clinic | `NEXT_PUBLIC_CREDIT_HELP_CENTER_URL` | `public-build` | 사용자에게 표시하거나 화면에서 이동하는 공개 링크. `clinic/src/lib/Dashboard/useDashboardBubble.ts` |
| clinic | `NEXT_PUBLIC_CREDIT_POLICY_HELP_CENTER_URL` | `public-build` | 사용자에게 표시하거나 화면에서 이동하는 공개 링크. `clinic/src/pages/credit/index.tsx` 외 |
| admin | `NEXT_PUBLIC_DENTLINK_EMPLOYER_ID` | `public-build` | Admin 화면과 메뉴에 사용하는 업체 식별자. 인증 수단이 아님. `admin/src/components/CRM/CrmManagerEditor.tsx` 외 |
| clinic | `NEXT_PUBLIC_E2E_ACCOUNT_ID` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup_step4_office_find.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_ACCOUNT_PASSWORD` | `test-secret` | Playwright 전용 인증값. 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup_step4_office_find.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_ADMIN_ACCOUNT_ID` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup_step4_office_find.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_ADMIN_ACCOUNT_PASSWORD` | `test-secret` | Playwright 전용 인증값. 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup_step4_office_find.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_BASE_ADMIN_URL` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `.github/workflows/clinic_dev_build_and_deploy.yml` 외 |
| clinic | `NEXT_PUBLIC_E2E_BASE_LAB_URL` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `.github/workflows/clinic_dev_build_and_deploy.yml` 외 |
| clinic | `NEXT_PUBLIC_E2E_BASE_URL` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `.github/workflows/clinic_dev_build_and_deploy.yml` 외 |
| clinic | `NEXT_PUBLIC_E2E_BP_PARTNER_KEY` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup_validation.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_CREATE_OFFICE_NAME` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup.spec.ts` |
| clinic | `NEXT_PUBLIC_E2E_CREATE_OWNER_NAME` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup.spec.ts` |
| clinic | `NEXT_PUBLIC_E2E_CREATE_PHONE_NUMBER` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup.spec.ts` |
| clinic | `NEXT_PUBLIC_E2E_CREATE_STREET_ADDRESS1` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup.spec.ts` |
| clinic | `NEXT_PUBLIC_E2E_CREATE_STREET_CITY` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup.spec.ts` |
| clinic | `NEXT_PUBLIC_E2E_CREATE_STREET_STATE` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup.spec.ts` |
| clinic | `NEXT_PUBLIC_E2E_CREATE_STREET_ZIP_CODE` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup.spec.ts` |
| clinic | `NEXT_PUBLIC_E2E_EMPLOYEE_ID` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/07_billing.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_EMPLOYER_ID` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup_step4_office_find.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_EMPLOYER_NAME` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup_step4_office_find.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_LAB_ACCOUNT_ID` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/04_labShipment.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_LAB_ACCOUNT_PASSWORD` | `test-secret` | Playwright 전용 인증값. 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/04_labShipment.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_ONBOARD_ACCOUNT_ID` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/setup/global-setup.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_ONBOARD_ACCOUNT_PASSWORD` | `test-secret` | Playwright 전용 인증값. 공개 빌드와 GitHub Variables에서 제외. `e2e/setup/global-setup.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_ONBOARD_NEW_OFFICE_NAME` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/setup/global-setup.ts` |
| clinic | `NEXT_PUBLIC_E2E_ONBOARD_OFFICE_CITY` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/setup/global-setup.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_ONBOARD_OFFICE_GOOGLE_PLACE_ID` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/setup/global-setup.ts` |
| clinic | `NEXT_PUBLIC_E2E_ONBOARD_OFFICE_OWNER_NAME` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/setup/global-setup.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_ONBOARD_OFFICE_PHONE_NUMBER` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/setup/global-setup.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_ONBOARD_OFFICE_STATE` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/setup/global-setup.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_ONBOARD_OFFICE_STREET_ADDRESS1` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/setup/global-setup.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_ONBOARD_OFFICE_STREET_ADDRESS2` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. 직접 참조 미발견 |
| clinic | `NEXT_PUBLIC_E2E_ONBOARD_OFFICE_ZIP_CODE` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/setup/global-setup.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_OTHER_ACCOUNT_ID` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup_step4_office_find.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_OTHER_ACCOUNT_PASSWORD` | `test-secret` | Playwright 전용 인증값. 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup_step4_office_find.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_REFERRAL_GROUP_CODE` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup_validation.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_REQUEST_ACCESS_ADDRESS1` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. 직접 참조 미발견 |
| clinic | `NEXT_PUBLIC_E2E_REQUEST_ACCESS_CITY` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. 직접 참조 미발견 |
| clinic | `NEXT_PUBLIC_E2E_REQUEST_ACCESS_COUNTRY_CODE` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. 직접 참조 미발견 |
| clinic | `NEXT_PUBLIC_E2E_REQUEST_ACCESS_OFFICE_NAME` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. 직접 참조 미발견 |
| clinic | `NEXT_PUBLIC_E2E_REQUEST_ACCESS_SETUP_ACCOUNT_ID` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/scripts/setup-request-access-office.spec.ts` |
| clinic | `NEXT_PUBLIC_E2E_REQUEST_ACCESS_SETUP_ACCOUNT_PASSWORD` | `test-secret` | Playwright 전용 인증값. 공개 빌드와 GitHub Variables에서 제외. `e2e/scripts/setup-request-access-office.spec.ts` |
| clinic | `NEXT_PUBLIC_E2E_SHIPMENT_TARGET_CATEGORY` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/04_labShipment.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_SHIPMENT_TARGET_ITEM` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/04_labShipment.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_SHIPMENT_TARGET_OFFICE` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/04_labShipment.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_SHIPMENT_TARGET_OFFICE_EMPLOYER` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/08_orderFeedback.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_SIGNUP_TEST_ACCOUNT_ID` | `test-config` | Playwright 전용 계정·주소·대상 설정. 계정/개인정보가 포함될 수 있어 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_E2E_SIGNUP_TEST_ACCOUNT_PASSWORD` | `test-secret` | Playwright 전용 인증값. 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup.spec.ts` 외 |
| clinic | `NEXT_PUBLIC_EMAIL_VERIFICATION_CODE` | `test-secret` | Playwright 전용 인증값. 공개 빌드와 GitHub Variables에서 제외. `e2e/clinic/specs/00_signup.spec.ts` 외 |
| admin/clinic/lab | `NEXT_PUBLIC_ENV` | `public-build` | 화면과 분석 SDK의 실행 환경 구분값. `admin/src/pages/orders/[order_id]/old.tsx` 외 |
| clinic | `NEXT_PUBLIC_EXIMBAY_MID` | `public-build` | 브라우저 결제 등록 요청의 가맹점 식별자. 서명 비밀키와 구분. `clinic/src/lib/Card/eximbayCardRegistrationParams.ts` |
| clinic | `NEXT_PUBLIC_EXIMBAY_REDIRECT_URL` | `public-build` | 결제 후 이동할 공개 URL. 현재 소스에서 직접 참조는 찾지 못함. 직접 참조 미발견 |
| clinic | `NEXT_PUBLIC_EXIMBAY_SECRET_KEY` | `build-secret` | 기존 브라우저 결제 서명 값 보존. Variables가 아닌 build private/Secret으로 공급하며 브라우저 노출은 남음. `clinic/src/lib/Card/eximbayCardRegistrationParams.ts` |
| clinic | `NEXT_PUBLIC_EXIMBAY_UI_URL` | `public-build` | 브라우저 결제 UI를 여는 공개 URL. `clinic/src/lib/Card/useAddCardEximbayUI.ts` 외 |
| clinic | `NEXT_PUBLIC_GA4_MARKETING_ID` | `public-build` | 브라우저 Google Analytics 측정 ID. `clinic/src/lib/gtag/gtag.ts` |
| clinic/lab | `NEXT_PUBLIC_GA_TRACKING_ID` | `public-build` | 브라우저 Google Analytics 측정 ID. `clinic/src/lib/gtag/gtag.ts` 외 |
| admin | `NEXT_PUBLIC_GOOGLE_MAP_API_KEY` | `build-secret` | Maps JavaScript·Places 검색의 기존 키를 비공개 보관. 공식 브라우저 SDK에서도 키는 보이므로 웹사이트·API 제한 필요. 실제 제한 설정은 미확인. `admin/src/components/GoogleMap/GoogleMap.tsx` |
| clinic | `NEXT_PUBLIC_GTM_TRACKING_ID` | `public-build` | 태그 관리자 컨테이너 ID. 현재 소스에서 직접 참조는 찾지 못함. 직접 참조 미발견 |
| admin/clinic/lab | `NEXT_PUBLIC_HOMEPAGE_URL` | `public-build` | 사용자에게 표시하거나 화면에서 이동하는 공개 링크. `shared/configs/constants/links.ts` |
| clinic/lab | `NEXT_PUBLIC_HOTJAR_ID` | `public-build` | Hotjar 사이트 식별자. 현재 소스에서 직접 참조는 찾지 못함. 직접 참조 미발견 |
| clinic/lab | `NEXT_PUBLIC_HOTJAR_VERSION` | `public-build` | Hotjar 스크립트 버전. 현재 소스에서 직접 참조는 찾지 못함. 직접 참조 미발견 |
| admin/clinic/lab | `NEXT_PUBLIC_LAB_HYOWON_ID` | `public-build` | 화면 휴일 정책에 사용하는 Lab 식별자. 인증 수단이 아님. `shared/configs/constants/holiday.ts` |
| admin/clinic/lab | `NEXT_PUBLIC_LAB_SI_ID` | `public-build` | 화면 휴일 정책에 사용하는 Lab 식별자. 인증 수단이 아님. `shared/configs/constants/holiday.ts` |
| admin/clinic/lab | `NEXT_PUBLIC_LAB_TOS_ID` | `public-build` | 화면 휴일 정책에 사용하는 Lab 식별자. 인증 수단이 아님. `shared/configs/constants/holiday.ts` |
| admin | `NEXT_PUBLIC_LAB_URL` | `public-build` | 사용자에게 표시하거나 화면에서 이동하는 공개 링크. `shared/configs/constants/links.ts` |
| admin/clinic/lab | `NEXT_PUBLIC_LAB_WITH_ID` | `public-build` | 화면 휴일 정책에 사용하는 Lab 식별자. 인증 수단이 아님. `shared/configs/constants/holiday.ts` |
| admin | `NEXT_PUBLIC_LINKTALK_LAB_URL` | `public-build` | 사용자에게 표시하거나 화면에서 이동하는 공개 링크. `shared/ui/src/LinkTalkUI/LinkTalkHeader.tsx` |
| admin | `NEXT_PUBLIC_LINKTALK_OFFICE_URL` | `public-build` | 사용자에게 표시하거나 화면에서 이동하는 공개 링크. `shared/ui/src/LinkTalkUI/LinkTalkHeader.tsx` |
| clinic | `NEXT_PUBLIC_MEDITLINK_ID` | `public-build` | Medit OAuth client ID. 소스 참조는 주석에만 있으며 현재 사용 여부는 미확인. `clinic/src/pages/link/medit.tsx` |
| clinic | `NEXT_PUBLIC_MEDITLINK_KEY` | `build-secret` | 현재 웹 직접 소비처는 발견하지 못했지만 기존 env 값을 보존해 build private/Secret으로 공급. 이번 작업에서 임의 삭제·키 폐기·연동 변경하지 않음. |
| clinic | `NEXT_PUBLIC_MEDITLINK_REDIRECT_URL` | `public-build` | Medit OAuth 후 이동할 공개 URL. 현재 소스에서 직접 참조는 찾지 못함. 직접 참조 미발견 |
| clinic | `NEXT_PUBLIC_META_PIXEL_ID` | `public-build` | 브라우저 Meta Pixel 측정 ID. `clinic/src/lib/gtag/gtag.ts` |
| clinic/lab | `NEXT_PUBLIC_ORDER_NUMBER_FIRST_DIGIT` | `public-build` | 화면 주문/배송 번호 검색에 사용하는 접두 번호. `clinic/src/lib/Remake/select/useRemakeList.tsx` 외 |
| clinic | `NEXT_PUBLIC_PICKUP_HELP_CENTER_URL` | `public-build` | 사용자에게 표시하거나 화면에서 이동하는 공개 링크. `clinic/src/lib/OrderForm/useOrderAdditionalInfoForm.tsx` 외 |
| clinic/lab | `NEXT_PUBLIC_PORTAL_URL` | `public-build` | 사용자에게 표시하거나 화면에서 이동하는 공개 링크. `shared/configs/constants/links.ts` |
| clinic/lab | `NEXT_PUBLIC_RUM_APPLICATION_ID` | `public-build` | Datadog 브라우저 RUM application ID. `clinic/src/common/hooks/useDatadogRUMInit.ts` |
| clinic/lab | `NEXT_PUBLIC_RUM_CLIENT_TOKEN` | `public-build` | Datadog 브라우저 RUM 수집용 client token. 서버 API key와 구분. `clinic/src/common/hooks/useDatadogRUMInit.ts` |
| admin | `NEXT_PUBLIC_SCANNERS_FILE_DOWNLOAD_ALLOWED_DOMAINS` | `public-build` | 파일 URL 검증용 도메인 목록. 비밀값이 아닌 제한 설정. `admin/src/pages/api/download/files/index.ts` 외 |
| lab | `NEXT_PUBLIC_SHIPMENT_NUMBER_FIRST_DIGIT` | `public-build` | 화면 주문/배송 번호 검색에 사용하는 접두 번호. `lab/src/lib/Shipment/useShippingListInfiniteScroll.tsx` 외 |
| admin/clinic/lab | `NEXT_PUBLIC_SHOW_QA_WIDGET` | `public-build` | 브라우저 기능 활성화 여부. `admin/src/components/CRM/CrmUserInfo.tsx` 외 |
| clinic | `NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY` | `public-build` | Stripe.js에 넘기는 공개 publishable key. 서버 secret key와 구분. `clinic/src/components/PaymentMethod/PaymentMethodStripeCardModal/PaymentMethodStripeCardModal.tsx` |
| admin/clinic/lab | `NEXT_PUBLIC_TITLE` | `public-build` | 화면과 페이지 메타데이터에 표시하는 제목. `admin/src/pages/_app.tsx` 외 |
| admin/clinic/lab | `NEXT_PUBLIC_URL` | `public-build` | 화면과 웹 빌드에 사용하는 공개 서비스/CDN 주소. `admin/src/lib/Scanner/useScannerRegister.ts` 외 |
| admin | `NOTION_API_KEY` | `server-secret` | Admin 서버 API의 Notion 인증값. `.github/workflows/admin_dev_build_and_deploy.yml` 외 |
| admin | `NOTION_ISV_POC_DATA_SOURCE_ID` | `server-config` | 서버 Notion 저장 대상 ID. 인증 토큰이 아니며 브라우저 입력에서 제외. `.github/workflows/admin_dev_build_and_deploy.yml` 외 |
| admin | `NOTION_ISV_POC_TITLE_PROPERTY_NAME` | `server-config` | 서버 Notion 저장 시 사용하는 속성 이름. 브라우저 입력에서 제외. `.github/workflows/admin_dev_build_and_deploy.yml` 외 |
| admin | `OPENAI_API_KEY` | `server-secret` | Admin 서버 API의 OpenAI 인증값. `.github/workflows/admin_dev_build_and_deploy.yml` 외 |

## 소스에서 추가로 발견한 선택 설정

아래 14개는 현재 env의 필수 키로 추가하거나 GitHub에 자동 등록하지 않습니다. 빌드 도구·i18n 관리용 변수도 별도로 구분해 기록했습니다.

| 서비스 | 키 | 분류 | 근거·대표 소비처 |
| ---------------- | ------------------------------------------- | --------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| clinic | `ANALYZE` | `server-config` | Next 빌드 분석 활성화용 선택 설정. 배포 필수값이 아님. `clinic/next.config.js` |
| lab | `GOOGLE_SERVICE_ACCOUNT_KEY` | `server-secret` | Lab i18n 관리 스크립트의 서비스 계정 인증. 앱 빌드/실행 공급 대상이 아님. `lab/scripts/i18n/sheets-client.js` |
| admin | `N8N_LINKTALK_INSIGHT_WEBHOOK_TOKEN` | `server-secret` | 서버 webhook의 선택적 인증 토큰. 기존 9개 env에는 없음. `admin/src/pages/api/linktalk/insight.ts` |
| admin | `NEXT_DISABLE_PWA` | `server-config` | Next PWA 생성 제어용 선택 설정. 배포 필수값이 아님. `admin/next.config.js` 외 |
| admin/clinic/lab | `NEXT_DIST_DIR` | `server-config` | Next 출력 폴더를 바꾸는 로컬/검증용 선택 설정. 배포 필수값이 아님. `admin/next.config.js` 외 |
| clinic | `NEXT_PUBLIC_E2E_ZONE_ID` | `test-config` | Playwright scanner API의 선택적 zone ID. 웹 빌드에서 제외. `e2e/clinic/utils/scanner-api.ts` |
| admin/clinic/lab | `NEXT_PUBLIC_FILE_DOWNLOAD_ALLOWED_DOMAINS` | `public-build` | 서버 파일 URL 검증용 공개 가능한 도메인 목록. 기존 NEXT_PUBLIC 소비 방식은 유지하되 자동 추가하지 않음. `admin/src/pages/api/download/files/index.ts` 외 |
| admin | `NEXT_PUBLIC_SCANN_UPLOAD_ADMIN_IDS` | `blocked` | Next 설정에서 ARRAY_VARIABLE로 노출하는 사용자 ID 목록. 실제 값과 필요성을 확인하기 전 공개 공급에서 제외. `admin/next.config.js` |
| admin | `NOTION_ISV_POC_PARENT_PAGE_ID` | `server-config` | Notion 서버 저장 대상의 선택적 대체 page ID. 기존 env에는 없음. `admin/src/pages/api/insta-smile-vision-poc/save.ts` |
| admin | `OPENAI_IMAGE_MODEL` | `server-config` | 배포 workflow에서 전달하지만 현재 앱 소스 소비처는 찾지 못한 모델명. 자동 추가하지 않음. `.github/workflows/admin_dev_build_and_deploy.yml` 외 |
| admin | `OPENAI_VISION_MODEL` | `server-config` | 서버 이미지 분석 모델의 선택 설정. 기존 env에는 없음. `admin/src/pages/api/insta-smile-vision-poc/analyze.ts` |
| admin | `OPEN_AI_API_KEY` | `server-secret` | OPENAI_API_KEY의 서버 호환 대체 이름. 새 표준 키로 자동 추가하지 않음. `admin/src/pages/api/insta-smile-vision-poc/analyze.ts` 외 |
| lab | `SHEETS_SHEET_NAME` | `server-config` | Lab i18n 관리 스크립트용 시트명. 앱 빌드/실행 공급 대상이 아님. `lab/scripts/i18n/sheets-client.js` |
| lab | `SHEETS_SPREADSHEET_ID` | `server-config` | Lab i18n 관리 스크립트용 문서 ID. 앱 빌드/실행 공급 대상이 아님. `lab/scripts/i18n/sheets-client.js` |

## SDK 키 분류 근거

- Stripe publishable key는 클라이언트용입니다. `loadStripe` 소비처 `clinic/src/components/PaymentMethod/PaymentMethodStripeCardModal/PaymentMethodStripeCardModal.tsx`와 [Stripe API keys 문서](https://docs.stripe.com/keys)를 확인했습니다.
- Amplitude API key는 수집 대상 프로젝트를 지정하며, 조회·관리용 secret key와 다릅니다. 브라우저 초기화 `clinic/src/common/hooks/useAmplitudeInit.ts`, [공식 키 설명](https://www.amplitude.com/docs/admin/account-management/manage-your-api-keys-and-secret-keys).
- Datadog RUM client token은 브라우저에서 보이는 수집용 토큰입니다. RUM 초기화 `clinic/src/common/hooks/useDatadogRUMInit.ts`, [공식 보안 설명](https://docs.datadoghq.com/data_security/real_user_monitoring/).
- Google Maps JavaScript 키는 브라우저 사용과 도메인/API 제한을 함께 고려해야 합니다. GoogleMap 소비처 `admin/src/components/GoogleMap/GoogleMap.tsx`, [공식 보안 지침](https://developers.google.com/maps/api-security-best-practices).
- ChannelTalk pluginKey는 JavaScript SDK 초기화 입력이며 memberHash와 다릅니다. [공식 Quickstart](https://developers.channel.io/en/articles/Quickstart-d27c51d1).
- Medit은 client ID와 client secret을 구분합니다. 현 키가 어느 역할인지는 이름만으로 확정하지 않습니다. [Medit OAuth 문서](https://api-doc.meditlink.com/OpenAPI/stage/guide.html).
- Eximbay 서명키는 비밀값으로 취급해야 합니다. 당시 브라우저 서명 코드 `clinic/src/lib/Card/eximbayCardRegistrationParams.ts`, [Eximbay 결제 연동 문서](https://developer.eximbay.com/eng/eximbay/pdf/Eximbay_Global_Payment_Integration_guide_kr.pdf).

## 브라우저에서 사용하는 키의 보안 조치

저장 위치와 실행 중 노출을 구분합니다. `NEXT_PUBLIC_`를 브라우저 코드에서 읽으면 빌드 결과에 값이 들어가므로, Secrets로 옮기는 것만으로 비밀이 되지는 않습니다.

| 대상 | 보관 | 실제 보호 방법 |
| --- | --- | --- |
| Google Maps·Places 키 | Admin의 build private / `DENTLINK_BUILD_ENV` | 공식 Maps JavaScript SDK로 호출하고 Google Cloud에서 허용 웹사이트·API를 제한합니다. 브라우저에서 키가 보이는 것은 정상이며 제한 설정이 보호 수단입니다. |
| Eximbay 서명 비밀키 | Clinic의 build private / `DENTLINK_BUILD_ENV`로 기존 값 보존 | 최종적으로 서버에서만 서명하고 브라우저의 비밀키 참조를 제거해야 합니다. 기존 공개 번들에 담긴 키도 교체해야 합니다. |
| Medit 키 | Clinic의 build private / `DENTLINK_BUILD_ENV` | 현재 직접 소비처를 찾지 못했으므로 공개 가능으로 추정하거나 삭제하지 않고 비공개 보존합니다. 다시 사용할 때 공식 인증 방식을 확인합니다. |

### Google 제한 확인

[Google Cloud → API 및 서비스 → 사용자 인증 정보](https://console.cloud.google.com/apis/credentials)에서 **기존 키가 속한 프로젝트와 해당 키**를 선택합니다. 같은 이름의 다른 키를 변경하지 않습니다.

- 애플리케이션 제한: 웹사이트. 실제 Admin DEV·STAGE·PRD 도메인과 필요한 로컬 개발 주소만 허용합니다. 앱 등 다른 사용처와 키를 공유한다면 영향부터 확인하고 분리합니다.
- API 제한: 현재 사용하는 Maps JavaScript API와 Places API (New)를 확인합니다. 다른 사용처가 확인되지 않은 상태에서 제한을 바로 저장하거나 키를 폐기하지 않습니다.
- 적용 후 각 환경에서 지도 로딩·주변 치과 검색이 되는지 확인합니다. 예산 알림은 과금 차단을 보장하지 않으며, 필요하면 사용량·쿼터도 함께 관리합니다.

### Eximbay 서버 서명에 필요한 계약

웹 팝업과 앱 WebView의 `/cards/add/[request_id]/redirect`가 현재 같은 브라우저 서명 함수를 사용합니다. 기존 FE env 분리 준비는 유지하되, **결제 키 노출 해소는 아래 조건을 갖춘 별도 서버 연계 변경으로 완료**합니다.

1. 서버가 로그인 사용자·직원 권한과 **본인 병원의 미완료 Eximbay 등록 요청**임을 검증해야 합니다. 기존 요청 조회 API가 이 조건을 보장하는지 확인하거나, 이를 검증하며 서명해 주는 BE API를 준비합니다. 현재 DEV API 명세만으로는 이 보장을 확인할 수 없습니다.
2. 서버는 `requestId`와 허용한 화면 유형(P/R)만 받아 MID·금액·통화·거래 유형·콜백 주소를 구성합니다. 브라우저가 보낸 임의 파라미터를 그대로 서명하는 API는 만들지 않습니다. 웹 팝업·앱 WebView 모두 서버가 만든 파라미터·서명을 사용합니다.
3. 키는 `NEXT_PUBLIC_` 없는 서버 전용 Secret으로 공급합니다. Next API에서 서명한다면 Clinic ECS 런타임 주입도 연결합니다. 브라우저 참조 제거, 다른 병원 요청 거부, 만료·완료 요청 처리, 앱 인증 전달·등록 완료를 검증한 뒤 전환합니다. 기존 공개 키 교체와 이전 키 무효화는 공급자·운영 전환에 맞춰 진행합니다.

[Google 보안 지침](https://developers.google.com/maps/api-security-best-practices) · [공식 Places Nearby Search](https://developers.google.com/maps/documentation/javascript/nearby-search) · [Next.js 브라우저 환경변수](https://nextjs.org/docs/pages/guides/environment-variables#bundling-environment-variables-for-the-browser) · [Eximbay 연동 가이드](https://developer.eximbay.com/eng/eximbay/pdf/Eximbay_Global_Payment_Integration_guide_kr.pdf)
