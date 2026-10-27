# Dentlink 권한관리 — DL-16317

## 최신 체크포인트 — 2026-10-27

- **DL-17011 종료:** 사용자가 배포 완료·추가 QA 없음·최종 종료를 확인했습니다. 요청된 개발·리뷰·전달의 남은 작업은 없습니다. 이는 사용자 확인이며 이번 문서 정리에서 배포·QA를 새로 검증한 것은 아닙니다. 이전 '조사만 완료·구현 대기'는 과거 상태입니다.
- **결과:** Clinic/Lab/Admin의 회원 권한 선택·표시와 등록/수정·초대 관련 누락을 보완하고 높은 권한 순서로 정렬했으며 Viewer를 선택·표시에서 제외했습니다. [PR #4784](https://github.com/Innvoaid/dentlink-client/pull/4784)는 10/26 `release/v1.90.0`에 병합됐습니다. 당시 stage의 병합 결과 포함·코드 동일성도 확인했습니다.
- **증거 경계:** 10/26에는 STG 배포 완료를 사용자에게 전달받았고, 10/27 최종 종료 확인이 추가됐습니다. 최신 사용자 메시지만으로 운영 환경·serving SHA·전 기능 실계정 QA까지 새로 확인했다고 확장하지 않습니다.
- **종료 지시:** Jira 상태·댓글은 사용자가 처리하므로 변경하지 않습니다. 담당 기능 세션의 보관 요청이 기록돼 있으며 이 문서 정리 자체로 앱의 실제 보관 상태를 확인하거나 다른 세션을 보관하지 않습니다. 제품 코드·브랜치·PR·배포 변경과 자동 모니터링은 하지 않습니다.

## 제품 범위와 현재 정책

- 독립 저장소: 웹·관리자 `dentlink-client`, 치과 앱 `dentlink-app`, 기공소 앱 `dentlink-lab-app`. 최신 코드/환경은 재개 시 정확한 저장소에서 확인합니다.
- DL-17011의 확정 옵션 순서는 **`OWNER → PAYMENT_MANAGER → EDITOR → MEMBER`**이며 각 서비스의 실제 코드 API/옵션에 존재하는 값만 사용합니다. API에 없는 권한을 새로 추가하지 않습니다. OFFICE는 Admin/Billing Manager/Manager/Member, LAB은 당시 제공된 권한과 기존 Owner/Billing Manager/Member 명칭을 유지합니다. 일반 가입의 직업 roleType과 별개입니다.
- **Viewer는 백엔드가 반환해도 회원 권한 선택·표시에서 제외**합니다. 기존 Viewer는 `-`로 표시하고 새 부여/재저장을 막으며 자동 변환하지 않습니다. 사용자가 유효 권한을 선택하면 처리할 수 있습니다. 거절·취소·삭제 경로는 유지합니다.
- 기존 서버 값과의 호환 때문에 DTO의 VIEWER 타입 및 기존 로그인·HOC 접근제어·조회 guard를 일괄 삭제한 것은 아닙니다. 기존 계정 접근 권한 철회나 서버 데이터 마이그레이션으로 해석하지 않습니다.
- 원래 Admin OFFICE 권한 선택지는 최초 구현에서 누락돼 있었습니다. 보존 원본→운영/master/stage 비교에서 구현 후 병합 누락·삭제의 근거는 없었습니다. 기획 TC의 체크 표시는 당시 빌드/실제 저장 검증 증거와 구분합니다. [요구·이력 조사](archive/dentlink-permission-management-history-through-2026-10-27.md#후속-qa-조사-완료구현-대기--2026-10-26-dl-17011-admin-그룹-회원-권한)에 경위를 보존합니다.
- 권한 제품 계약과 화면별 상세는 [권한관리 기획](https://app.notion.com/p/3eace072e82f81aa955dc21cba5cf127) 및 구현 당시 이력을 참고합니다. 새 변경 요청 시 필요한 최신 자료를 다시 확인합니다.

## 검증·전달 기록

- 최종 feature HEAD는 `9dcb644d566cee06fa0019c16b7f47cdf10e8d36`, PR4784 merge는 `f7d65d6eb9831cade4ac8092a594fca4298c0683`입니다. 당시 local/origin/PR 일치·clean을 확인했으며 현재 checkout 상태를 뜻하지 않습니다.
- 관련 옵션 순열·서비스별 입력/표시·mutation 검증, Clinic/Lab/Admin 타입, 필수 commit/push 검사와 변경 lint를 통과했습니다. 최종 CodeRabbit 실제 리뷰 완료·미해결0을 확인했습니다.
- E2E 영향은 `NO_IMPACT`; 실제 브라우저 E2E·실계정 쓰기 QA는 이 검증에서 실행하지 않았습니다. 기존 shared UI lint 오류 및 Lab 번역 audit/stale 진단은 이번 변경과 분리해 남겼습니다.
- 앞선 DL-16317은 10/25 웹 v1.89.0 운영 SHA `a5e465561b953270b2925b2082845ba753f0572f`의 권한 관련 PR 포함과 배포 workflow 성공을 확인했습니다. Office Production v84/2.2.4, Lab Production v17/1.0.5 활성은 **당시** 관찰이며 OTA exact SHA·모든 기기 QA를 증명하지 않습니다.
- 이후 10/27 Office 컨펌 Render Error가 권한관리 변경에서 유입됐음을 확인하고 동료 수정본을 한정 검증했습니다. 과거 '업무 완료'가 모든 화면의 무결함 근거는 아닙니다. [Office 현재 기록](dentlink-app.md)의 원인·검증 한계와 [필수 앱 검증 지침](../DEVELOPMENT_STYLE.md#app-screen-runtime-verification-before-merge)을 따릅니다.

## 정리·보존과 다음 시작점

- 10/25 완료 웹 refs 정리와 복구 bundle, 10/26 웹/Office/리뷰 worktree 3개 제거를 기록했습니다. 설정 보존 위치·bundle 검증값·삭제 전 SHA는 [보관본](archive/dentlink-permission-management-history-through-2026-10-27.md)에 그대로 남아 있습니다. 그때 보존한 ref/폴더를 현재도 존재한다고 단정하지 않습니다.
- 기본 제품 경로와 최신 정리 상태는 [FE 조율](dentlink-fe.md), [웹 env](dentlink-client-env-management.md), 각 앱 정본을 함께 확인합니다. 개인 문서 Git만으로 로컬 설정·복구 bundle·임시 증거가 복원되지는 않습니다.
- Lab 웹 번역 Sheet 보류, 앱 기존 타입 진단, BE 권한 변경 시 세션 폐기 정책, 실제 화면/기기 QA의 과거 미확인 사항은 이력에 남깁니다. 문서 정리로 해결 처리하거나 새 필수 업무로 자동 재개하지 않습니다.
- 새 이슈/사용자 요청이 오면 개인 컨텍스트 pull → 제품 범위·요구사항 → 해당 checkout/Git/PR/환경·active writer를 확인하고 새 후속 범위로 시작합니다. 최종 앱 코드의 영향 화면·권한별 에이전트 검증을 완료한 뒤 사용자 QA로 넘깁니다.

## 과거 이력

[2026-10-27 정리 전 전체 이력](archive/dentlink-permission-management-history-through-2026-10-27.md)에 초기 기획, 10월 구현/QA/배포, DL-17011 조사와 정책 정정, 정확한 commit·PR·테스트·복구 정보를 보존했습니다.
보관본의 당시 승인·'현재 상태'·'다음 시작점'은 현재 작업 지시가 아닙니다. 신규 구현이나 배포를 다시 시작하지 않습니다.
