# Dentlink Lab App

## 최신 인계 확인·대기 — 2026-10-21 Slack 본문/댓글 확인

- 사용자 요청은 아래 Slack 본문·댓글을 읽고 판단·기록만 하는 것이며, 여기서는 더 진행하지 않는 방향이다. [인계 스레드](https://innovaidhq.slack.com/archives/C09613TBE5A/p1792574567701379)의 본문과 댓글6개를 전체 조회했고 더 이상 페이지 없음까지 확인했다(마지막18:25:54 KST). Slack/Jira/제품 코드·Git refs·배포 설정은 변경하지 않았다.
- 사용자는 우리 수정이 release/v1.0.5에 이미 병합됐으며, 별도 밀링센터 작업이 빠지지 않도록 배포 전에 두 작업을 합쳐야 한다는 내용을 Daniel에게 전달했다. Daniel은 현재 계속 개발 중이라고 답했고, 마지막으로 “곧 커밋하고 말씀드릴게요”라고 했다. 커밋·통합·배포가 이미 완료됐다는 답은 아니다.
- 판단: 이 세션에서 추가 cherry-pick/병합/CodePush를 진행하지 않고 동료의 커밋 완료 안내 및 배포 전 통합 확인을 기다리는 것이 맞다. 동료의 개발 중 branch를 임의로 통합하거나 앞서 확인한 release를 다시게시하지 않는다. 새 사용자 요청이나 QA 결과 전까지 모니터링도 하지 않는다.
- 현재 기존 상태는 유지: PR19 릴리즈 병합, iOS/Android Staging v38(target1.0.4)은 사용자 요청으로 복구된 활성 상태다.1.0.5 대상으로 이번 세션이 CodePush한 적은 없다.
- 별도 미해결: 사용자가 보고한1.0.4 실행불가 증상은 이 Slack 스레드에 언급돼 있지 않다. 설치본/native/OTA 호환은 원인 후보일 뿐이며 해결·개발자 확인 완료로 표시하지 않는다. 개발자 진단 결과나 사용자 지시가 오면 재개한다. 현 스레드의 통합 인계와 crash 원인 확인을 혼동하지 않는다.

## 최종 중단·앱 개발자 인계 — 2026-10-21 실행 불가 제보

- 사용자가 “1.0.5는 실행되지만1.0.4는 설치 후 아예 실행되지 않는다”고 제보했다. 이어 “여기서 종료하고 대기, 다음은 앱 개발자와 진행”을 명시했으므로 진단을 중단한다. 플랫폼/첫 실행 또는 재실행 시점 질문은 미응답이며 후속 답변을 재촉하지 않는다.
- **현재 배포 상태는 유지:** 기공소 iOS/Android Staging v38, target1.0.4, active/mandatory100%. 앞서 비활성화했던 것은 사용자 요청으로 복구했으며 이번 실행 불가 제보 이후 다시 끄거나 롤백하지 않았다. PR19/release b04be101 및 동료 feature 브랜치·제품 코드·Jira 상태도 변경하지 않았다.
- 읽기 전용 재확인에서 release b04be101은 VisionCamera5.2.3/Nitro0.37.1/haptic3.0.0을 사용하고 App→RootNavigator→AllScreens→HomeLabScanScreen에서 초기 import된다. 기존main bb619010은 Camera4.7.3이며 Nitro/haptic 의존성이 없다. 따라서 구형 native1.0.4와 v38 JS의 호환 문제가 유력 후보지만 설치본의 실제native/source·기기 로그를 확보하지 않았으므로 **원인 확정 아님**이다. 권한 수정2파일 자체의 확정 결함으로 보고하지 않는다.
- 마지막 Revopush 조회에서 iOS v38 downloaded1/installed0/active0/failed0, v37 installed3/active2/failed0이었다. Android metrics는 응답에 없었다. 이 수치는 특정 사용자 기기의 crash 증명이나 실패없음 증명이 아니다. 추가 기기 QA·앱 재설치·자동 rollback/비활성화는 실행하지 않았다.
- 다음은 사용자가 앱 개발자와 설치본 빌드source·native 구성·시작 오류 및 올바른 OTA기준을 확인하는 단계다. 이번 세션은 개인 기록 commit/push 후 대기하고, 새 명시 요청 전 제품 변경·배포·코드푸시·Jira/Slack/Figma 쓰기·추가조사·모니터링을 하지 않는다.

## 최종 합의·대기 — 2026-10-21 현재 병합/배포 유지

- 사용자는 코드가 릴리즈에 합쳐진 현재 상태를 유지하고, 배포 관련만 앱 개발자와 직접 재확인하기로 했다. 앱 버전을 이유로 추가 코드 이동·병합·재배포를 자율 진행하지 않는다. 앞서 agent가 수동 비활성화했던 v38은 사용자 요청으로 원복됐으며 현재 양OS 활성이다.
- 완료 상태: 우리 권한 QA 수정2파일 PR19 → release/v1.0.5@b04be101 병합, 해당 소스로 기공소 iOS/Android Staging v38 게시. 적용 대상 앱 버전1.0.4/mandatory100%/active(isDisabled=false)를 재조회했다. 복구는 활성화 플래그만 변경했고 소스·패키지·대상 버전·기타 metadata는 유지했다. 동료 별도 feature/DL-16833은 건드리지 않았으며 그 미병합 작업까지 release에 모두 합쳐졌다는 뜻은 아니다.
- 앱 개발자에게 사용자가 확인할 항목: 현재 QA용 설치 앱을 어느 브랜치/커밋으로 빌드했는지, 현재 release 수정(PR19)을 QA하려면 게시된 Staging v38의 대상 앱 버전1.0.4가 맞는지 또는 설치본/배포 대상을 어떻게 맞춰야 하는지. 설치본 확인 결과에 따라 필요한 배포 후속을 사용자와 결정한다. 지금 임의로 source 변경/target 재지정하지 않는다.
- 기능 QA는 미실시다. 사용자 앱 실행 확인은 기능 검증과 구분한다. Jira16881 READY FOR QA는 유지하고 이번 마감에서는 Jira/Slack/Figma·제품 코드·PR·배포를 변경하지 않았다. 개인 기록 commit/push 후 질문 답변 또는 QA 결과가 오기 전까지 추가 작업·모니터링 없이 대기한다. 기존 branch/worktree는 유지한다.

## 현재 상태 정정 — 2026-10-21 v38 재활성화·추가 작업 중단

- 실제 소스는 release/v1.0.5@b04be101(우리 PR19 병합)이고, 해당 소스 package/native와 CodePush v38 대상은1.0.4다. 사용자는 별도로 설치한1.0.5 앱 실행만 확인했으며 우리 수정/OTA 수신은 미확인이다.
- 후속 live 조사에서 동료의 feature/DL-16833@41a57ad에 release 미포함25커밋과 package/Android/iOS1.0.5 변경(fd9d508)이 있음을 확인했다. 공통조상a32acb02, 동료 변경259파일, 우리 수정2파일은 동료branch에서 공통조상 대비 변경0이다. “릴리즈가 동료 최신 작업을 전부 포함”한다는 앞선 설명은 잘못됐다. 실제1.0.5 설치본의 빌드source는 사용자도 모르며 Slack Fastlane 공지에는1.0.5/배포시각만 있다. 미확인 source에 대상버전만1.0.5로 바꿔 배포하지 않는다.
- agent가 잘못된 대상 배포라고 판단해 양OS Staging v38만 수동 disabled=true로 바꿨고, 사용자가 중단을 지시했다. 이후 사용자가 “조치한 건 다시 복구”를 명시하여 **동일 v38을 양OS 모두 disabled=false로 재활성화 완료**했다. 서버 read-back에서1.0.4/mandatory/100% 활성 확인, label/appVersion/mandatory/rollout/description/packageHash/uploadTime 불변이다. 앱1.0.4 전체나 다른label/Production을 끈 것이 아니다.
- 현재: PR19는release에 병합 유지, Staging v38은 다시활성,1.0.5 대상 재배포없음. 동료branch/코드는 손대지 않았다. Jira16881은 기존READY FOR QA에서 추가변경하지 않았다. 사용자 중단 지시는 활성화 복구 외에는 유지한다. 앱 개발자에게1.0.5 실제빌드 브랜치/커밋·원격반영 여부를 확인받은 뒤 그 기준에 우리2파일만 추가하는경로를 논의한다. 자동추가병합/재배포/QA/모니터링 금지.

## 사용자 실행 확인·QA 대기 — 2026-10-21

- 사용자가 기공소 앱1.0.5를 준비해 배포 후 앱이 실행되는 것을 확인했다고 보고했다. 이번 권한/cut-off 기능 자체를 검수한 것은 아니라고 명확히 구분했고, QA가 나오면 다시 전달하겠다고 정리·대기를 요청했다.
- 설치본 준비/앱 실행 확인은 사용자 보고 기준으로 기록하며, 이를 추가 작업을 막는 확인 요청으로 반복하지 않는다. 기능 QA 통과나 양OS별 검수 완료로 확대하지 않는다.
- 이전에 직접 확인한 Staging CodePush v38의 targetBinaryVersion은1.0.4다. 사용자가 보고한1.0.5 실행을 v38 OTA 수신/적용 증거로 간주하지 않으며,1.0.5 바이너리의 내장 소스 SHA도 이 턴에서 확인하지 않았다. 자동으로 대상 버전 변경·재배포·추가 조사를 하지 않는다. 필요 시 후속 QA에서 실제 내장 소스/적용 라벨을 구분한다.
- 이번에는 개인 기록만 갱신한다. 제품 코드·PR·배포·Jira/Slack/Figma·모니터링은 변경하지 않고 사용자 QA 결과를 기다린다. 기존 브랜치/worktree는 보존한다.

## 최신 전달 완료 — 2026-10-21 PR19 병합·Staging v38

- 사용자가 “기기적 문제 말고 코드적이나 배포적 문제없으면, 실기기 앱 버전은 알아서 맞추겠다”고 명시했다. 앞서 승인한 안전 시 병합·Staging CodePush를 재개했으며, 설치본 확인을 반복 승인 조건으로 두지 않는다. 이 지시는 이번 전달 범위에 한정한다.
- 새로 pull/fetch한 PR19는 기존 HEAD cd46b7cd/base a32acb02 그대로 OPEN/CLEAN/MERGEABLE, 새 리뷰·코멘트·스레드0이다. 독립 검토에서도 코드·병합을 막을 확정 문제0, 두 파일(+84/-9) 외 동료 코드/의존성/native 설정 변경0을 재확인했다. 기존 테스트를 불필요하게 반복하지 않았고 `yarn validate:versions`는 package/Android/Xcode 모두1.0.4로 통과했다.
- 2026-10-21 17:18:48 KST PR19를 expected head 확인 후 squash 병합했다. 대상 release/v1.0.5, merge b04be10111e70f20ec3c6151c521907009edd5df. 원격release와 검증된 QA HEAD의 전체tree 동일을 확인했다. main/develop 동기화·버전 변경·태그·스토어 배포는 하지 않았다.
- 병합 커밋을 detached checkout하여 양OS `revopush release-react`를 순차 실행했다. index.js/mandatory/Staging/targetBinaryVersion1.0.4/force는 기존 프로젝트 명령과 동일하며, Slack 쓰기 금지 때문에 알림 wrapper를 사용하지 않았다. source 전체 SHA/PR19를 description에 기록했다. 양OS Metro/Hermes 번들·업로드가 성공했다.
- 서버 history 재조회: **Dentlink-Lab-iOS Staging v38**, **Dentlink-Lab-Android Staging v38**, 모두1.0.4/active(isDisabled=false)/mandatory/rollout100%, description의 source b04be101… 일치. 이 결과는 OTA 배포 완료이며 기기 수신·재실행·기능 QA 완료는 아니다. 실제 설치본 버전/네이티브 구성은 사용자가 맞추기로 했다.
- Jira DL-16881을 Ready for Deploy → READY FOR QA로 상태만 변경했다. 댓글·본문·Slack 쓰기 없음. 전달 후 원래 QA/DL-16881@cd46b7c로 복귀해 clean·원격동일 및 release 전체tree 동일을 확인했고 branch/worktree는 보존했다. 추가 코드 변경은 없어 제품 새 커밋/푸시는 없다.
- 다음은 사용자의 설치본 준비와 QA 결과다. 웹 재배포·추가 QA·모니터링 없이 대기한다. 웹 번역 Sheet의 기존 별도 보류와 이번 앱 CodePush 완료는 구분한다. 아래 설치본 미확인으로 PR/CodePush 보류한 기록은 이전 상태다.

## 이전 대기 확정 — 2026-10-21

- 사용자가 최종 보고 후 정리·대기를 요청했다. PR19/QA 브랜치는 보존하고 추가 병합·CodePush·QA를 진행하지 않는다. 최신 native 설치본 확인 또는 새 사용자 요청이 오면 아래 호환성 확인 지점에서 재개한다.

## 최종 정리 — 2026-10-21 PR19 검토 완료·설치본 호환 확인 대기

- 사용자가 이후 요청에서 “앱개발자 검토가 필요하면 PR 유지, 영향이 작아 안전하면 병합 후 최종 버전 Staging CodePush”를 승인했다. 따라서 아래 오전의 PR까지만 경계는 이 조건부 범위에서 대체된다. Jira는 상태만 변경하며 댓글/본문은 쓰지 않는다.
- PR19 HEAD cd46b7c, base release/v1.0.5 a32acb02, OPEN/MERGEABLE 및 리뷰/스레드0을 재확인했다. 독립 검토에서 두 파일의403/1018 처리·현재 주문 메시지 식별·기존 WebView 공통 핸들러 유지에 확정 결함이 없었고, 이번 diff가 동료 QR/밀링/native 작업을 바꾸지 않음을 확인했다. 기존22tests/계약8건·타입 진단5→5 기록은 같은HEAD에 해당한다.
- **병합 안전성과 OTA 호환은 별개다.** 기반 release의 VisionCamera5/Nitro/Bluetooth native와 구형 설치본의 호환이 확인되지 않았다. 같은1.0.4 표시만으로 판정할 수 없어 사용자에게 최근 native 포함 설치본인지 질문했다. 확인 전 PR19를 유지하고 CodePush를 실행하지 않는다. 전체release를 구형develop/main으로 임의 변경하거나 동료 코드를 빼서 배포하지 않는다.
- 웹 대응 PR4747과 영문 Figma 복원 PR4750은 release에 병합했고 최종 stage 전달 PR4751도 병합했다. Lab 웹 배포 run39555735124 SUCCESS 및 공개 번들의 PM 국문/접근 제한 연결을 확인했다. 국문은 PM 지정 그대로, 영문은 Figma 기존 문구다. Jira DL-16881은 진행 중으로만 변경했고 댓글/본문은 쓰지 않았다. 마감 시 PR19 OPEN/MERGEABLE, checkout clean·원격 동일이다. 설치본 확인 질문은 미응답이며 오늘 앱 병합·CodePush·기기 QA는 실행하지 않았다. 웹 배포/접수 감사 전체 결과는 [권한관리 체크포인트](dentlink-permission-management.md)의 최상단 기록을 따른다.

## 이전 확정 — 2026-10-21 최신 동료 작업 보존·PR까지만

- 사용자가 CodePush 요청을 철회하고 **최신 동료 작업을 유지한 채 필요한 코드만 추가하여 PR까지만** 하도록 명시했다. 앱 업데이트/배포는 사용자 진행이다. 업로드·활성화·실제 QA는 하지 않았고 기존 배포 승인을 재사용하지 않는다.
- 최신 동료 QR/태블릿/Bluetooth 작업은 develop56cba674보다 release/v1.0.5 a32acb02에 더 반영되어 있다. 원래 QA/DL-16881@cd46b7c·PR19→release/v1.0.5를 유지하며 PR은 OPEN/2파일(+84/-9)이다. 중간에 develop 기준으로 만든 임시 feature/DL-16881은 푸시/새PR 없이 정리하고 원래 checkout으로 복귀했다.
- release 이름은1.0.5지만 package/native 버전은1.0.4이고, 기존 main보다 새로운 Nitro/카메라/Bluetooth native를 포함한다. Staging은 양OS v37/1.0.4이며 설치본 native 포함 여부는 미확인이다. 사용자 배포 시 native 호환을 고려해야 하며 이 세션에서 새 바이너리/CodePush를 자동 진행하지 않는다.
- 상세 호환성 근거와 치과앱 PR331 develop 병합 확인은 [권한관리 체크포인트](dentlink-permission-management.md)의 최신 확정 기록을 따른다.

## 현재 QA 작업 — 2026-10-21 cut-off 주문 접근 제한 PR19

- 사용자가 권한관리 2차 QA를 **release에서 새 QA 브랜치 → FE 코드 수정 → 커밋·푸시·PR**까지 승인했으며 실제 서버/화면/기기 QA와 배포는 제외했다.
- 기본 checkout `/Users/parkjongsun/Repository/dentlink-lab-app`은 현재 `QA/DL-16881`이다. 기준 `release/v1.0.5@a32acb02eea73c7771efa803a99709cf06a5e5a7`, HEAD/원격 `cd46b7cd2a4710d8690251620a40d773009475a0`, clean. 아래 main 단일 checkout 기록은 10/16 당시 이력이다.
- [PR19](https://github.com/Innvoaid/dentlink-lab-app/pull/19)는 OPEN/비Draft, `release/v1.0.5` 대상으로 자동화 후 다시 확인했다. `ae7c787`/`cd46b7c`, 2파일만 수정했다. 일반 feature의 develop 정책을 바꾼 것이 아니라 사용자 명시 release QA 요청이다.
- `GET /lab/orders/{id}`의 HTTP403/code1018만 인증 만료와 분리하여 세션을 유지하고 차단 WebView에 진입한다. 현재 주문에 대한 네이티브/웹 접근 거절 시 LinkTalk를 숨긴다. 웹 대응은 [dentlink-client PR4747](https://github.com/Innvoaid/dentlink-client/pull/4747)의 ORDER_DETAIL_ACCESS 메시지이며 별도 Office 앱 변경은 없다.
- 기존 Jest22개·임시 계약 검증8개·변경 lint/포맷/diff는 통과했다. 전체 타입 진단은 release의 기존5개 그대로, 신규0이며 전체 타입 통과나 실제 QA 완료를 뜻하지 않는다. 새 파일/의존성/native 설정은 추가하지 않았다.
- 병합·CodePush·스토어 전달·실기기 QA·CodeRabbit 후속 검토는 이번에 진행하지 않았다. 다음은 사용자 리뷰/병합 이후 승인된 전달·연동 QA다. 상세 계약·제외 범위와 검증은 [권한관리 체크포인트](dentlink-permission-management.md)의 2026-10-21 구현 기록을 따른다.

## 현재 로컬 상태 — 2026-10-16 출시 후 정리

- 기본 checkout은 `main / bb619010b25419b724a5f6acded6f5760bb9af15`, origin/main과 동일·clean이다.
  로컬 브랜치와 등록 worktree는 기본 main checkout 하나씩만 남았다.
- 이미 운영 전달된 DL-16652·번역 지침의 원격 브랜치 6개, 잔여 로컬 브랜치 3개와
  문서용 `dentlink-lab-app-i18n-release` worktree를 삭제했다. main·develop·release는 보존했다.
- 삭제 전 검증한 Git bundle과 manifest는 공용 Git 디렉터리의
  `codex-closeout/released-branch-cleanup-20261016/`에 있다. 자세한 삭제·보존 기준은
  [FE 정리 기록](dentlink-fe.md)을 따른다. 아래 날짜별 보존 상태는 당시 이력이다.

## 역할과 저장소 — 2026-10-06 사용자 확정

- 기공소 네이티브 앱의 정본이다. Office 앱은 별도 `dentlink-app`과
  [Office 체크포인트](dentlink-app.md)를 사용한다.
- 원격: https://github.com/Innvoaid/dentlink-lab-app
- 기본 checkout: `/Users/parkjongsun/Repository/dentlink-lab-app`, `main`.
- React Native·TypeScript Lab 전용 저장소다. `src/configs/constants/environment.ts`의
  `APP_SERVICE_TYPE=LAB`, 환자목록은 `/lab/patients/consolidate`를 호출한다.
- 신규 작업은 정확한 앱을 먼저 구분하고 제품별 branch·worktree·API·runtime·release를 확인한다.
  웹의 `origin/master` 전략이나 Office 설정을 그대로 적용하지 않는다.

## 앱 공통 작업 정책 — 2026-10-08

- [앱 온보딩·작업·배포 정본](dentlink-app-onboarding.md)을 함께 읽는다.
  후속 사용자 정정으로 일반 feature PR은 `develop`이 기본 대상이며 CodePush마다 release를 새로 만들지 않는다.
- 정책 조사 당시 `release/v1.0.4 / cb585775ca21e27949e67758a5933139cfc567d8`에 #2·#3이 향해 있었다.
  이 release는 분리 전 트리라 당시 PR에 다른 작업이 섞여 있었다. 분리 전체를 필수 기반으로 보았던
  판단은 수정했다. 당시 명시 승인된 release 전달 정리는 요청한 변경만 옮기고 전체 diff·실제 의존성을 검증했다.
  일반 신규 feature는 develop 기준이며, 이 release 전달 이력을 일반 시작 기준으로 재사용하지 않는다.
  단순 MERGEABLE/CLEAN이나 레이아웃 차이를 범위/필수 통합 증거로 쓰지 않는다.
- 최신 번역 지침 전달은 문서 전용 #5이며 [전달 기록](dentlink-lab-app-i18n.md)을 따른다.
  온보딩 최초 조사 당시 제품 변경은 없었으며 아래 후속 사용자 승인 작업과 구분한다.

## 최종 종결 — 2026-10-12 사용자 앱 확인 완료·세션 보관

- 사용자가 앱 확인 완료와 전체 작업 종결을 요청했다. Lab 양OS Productionv13/1.0.4/active/mandatory/100%와
  main→develop15 사용자병합/전체tree동일의 전달 근거를 보존하며 필요한 앱 업무는 모두 끝났다.
- 웹 배포는 사용자 진행 중이고 root의 추가 배포 조회·실기기 QA·브랜치 동기화는 요청되지 않았다.
  Jira 완료 상태/댓글44407과 개인 기능 기록을 최종 정리한다.
- 전용 로컬 작업 복사본을 정리하고 새 요청 전 작업을 재개하지 않는다.
  상세 정리 결과와 복구 위치는 [DL-16652 최종 정본](dentlink-patient-list-design.md)을 따른다.

## 이전 완료 — 2026-10-12 Production v13·main → develop 최종 동기화

- 사용자 명시 요청으로 main bb619010 소스에서 iOS·Android Production CodePush를 각각 **v13**으로 업로드 후 활성화했다.
  바이너리1.0.4·mandatory·rollout100%·isDisabled=false를 각 서버 history로 확인했고 양 bundle hash는 Staging v36과 같다.
  iOS upload18:20:25/활성확인18:21:31, Android upload18:21:05/활성확인18:22:06 KST다.
- [PR #15 main → develop](https://github.com/Innvoaid/dentlink-lab-app/pull/15)를 생성·연결하고 자동화 후 base/diff를 확인했다.
  전체 diff1파일-21·merge-tree충돌0이며, 사용자 jongsunP 병합18:22:23 KST/56cba67454ea9f7c1ff028231c26df1568a87928을 확인했다.
  live main/develop의 전체 tree8bd4226ce43b5dc8108ba0762327e20fa443adbd가 동일·최종diff0이다. root가 병합하지 않았다.
- 요청된 운영 전달·동기화는 완료했다. 코드/native/API/번역/새binary 수정은 없고 제품 작업 복사본은 clean detachedbb619010이다.
  실제 운영 기기의 OTA 적용·재실행·화면/운영 건강은 별도 미검증이며 웹은 사용자 직접 배포다.
  이번 명시 요청을 공통 전달 정책 변경으로 확대하지 않는다. Jira44407/완료 상태와 [기능 정본](dentlink-patient-list-design.md)을 정리했다.

## 이전 완료 — 2026-10-12 총 주문 수 숨김·main Staging v36

- 사용자 요청으로 총수label/number/뒤구분선만 제거한1파일-21을 QA branch e6c4f89로 commit/push/PR13 전달했다.
  사용자병합으로release8eeac898, 이어 main PR14=bb619010으로 반영됐다. 우리Lab count/API/i18n은 보존했다.
- 사용자의 명시 요청대로 main bb619010의 검증QA동일tree·1.0.4/native/deps/entry보존을 확인하고
  양플랫폼 Staging CodePush를 실행했다. iOS **v36/18:03:16**, Android **v36/18:03:48** KST,
  CLIexit0+서버history에서1.0.4·active·mandatory·rollout100%·description/hash변경을 검증했다.
- 사용자가 앱 배포를 확인했다고 보고했다. root 실기기 OTA 적용/총수제거 화면 QA는 별도 미검증이다.
  worktree는 clean detachedmain이며 QA/source refs를 보존했다. Production/native/store/tag/main→develop추가작업은 없다.
- 앱 개발자 전달 흐름은 최신 온보딩의 참고·합의 대기 자료로 구분하며 이번 main배포 명시 권한과 혼용하지 않는다.
  웹은 최신사용자보고상배포진행중, 요청된 앱업무는 완료하고 새 요청 전 대기한다. [기능 정본](dentlink-patient-list-design.md).

## 이전 release → develop 동기화 — 2026-10-08

- 사용자 승인으로 [PR #9](https://github.com/Innvoaid/dentlink-lab-app/pull/9)을 생성했다.
  `release/v1.0.4 / 59e6a56cd39981c5c8e69166680794f8bf0f4593` → `develop`이며
  생성 당시 develop `96cc94a0` 대비 3커밋·22파일(+661/-153), native·package·lock 변경은 없다.
  기존 문서 #5·환자목록 #6·아이콘 QA #8의 release 반영 내용을 개발 기준으로 동기화한다.
- GitHub에서 `jongsunP`의 병합을 확인했다: 16:07:37 KST,
  merge commit `e6fec379adbac1e1753834caa436dc006866e760`.
  메인 세션은 PR 생성까지만 실행했으며 병합·추가 배포는 실행하지 않았다.
- 이후 작업은 별도 세션에서 진행한다는 사용자 지시에 따라 메인에서는 지침 정리만 마무리한다.
  이 동기화 준비에서 새 기능 QA·네이티브 빌드는 실행하지 않았으며 아래 Staging 배포·실기기 QA와 구분한다.

## DL-16652 현재 확인 — 2026-10-08 아이콘 수정 Staging v32 배포

- PR8은 사용자 병합으로 release/v1.0.4@59e6a56c에 반영됐다(15:59:08 KST).
  전체tree가 검증한 bb2df333과 동일하고 native/deps/버전1.0.4는 보존됐다.
- 승인된 양 플랫폼 Staging CodePush 재배포 완료: iOS **v32/16:01:35**, Android **v32/16:02:26** KST.
  서버 history에서 기존v31→v32·packageHash 변경·59e6a56 description·1.0.4·active·mandatory·100%를 확인했다.
- 기존 patient-list worktree는 clean detached59e6a56이며 QA branch/원격 source는 보존했다.
  Jira44342/READY FOR QA와 개인기록을 정리했고 Clinic/Production/native/store/tag·메인메시지는 추가 실행하지 않았다.
- 실제 Staging 앱의 v32 적용·재실행/NEW 회색14px 치아 표시는 아직 별도 확인이 필요하다.
  다음 시작점과 packageHash 근거는 [DL-16652 정본](dentlink-patient-list-design.md)을 따른다.

## 이전 확인 — 2026-10-08 검토 중 아이콘 수정 PR8

- 사용자 승인으로 Lab 카드 NEW에 최종 Figma 원본14px/#959595 치아를 적용했다.
  전용 SVG·export·NEW 매핑3파일(+11/-1)이며 공용 white teeth/기존 주문목록·native·deps는 보존했다.
- 최신 release/v1.0.4@f000ae2c에서 QA/lab/DL-16652-review-icon@bb2df333으로 준비·push했다.
  [PR8](https://github.com/Innvoaid/dentlink-lab-app/pull/8)은 같은 release 대상 OPEN/non-Draft/CLEAN/MERGEABLE,
  미해결리뷰0·사람승인0·autoMerge=null이다. PR 자동화 후 실제 base와 전체diff를 재확인했다.
- lint/format/export/버전·양플랫폼 배포용JS bundle·실제SVG transform과bundle색/치수 PASS,
  full typecheck는 전후기존오류5개 byte동일/신규0이다. 독립검토 blocker0·실제화면픽셀은미검증이다.
- Jira44342/READY FOR QA를 정리했다. PR병합·추가CodePush·새native/store·메인메시지는없다.
  현재 Staging v31은수정전이며 다음은 PR8 반영 후1.0.4 양플랫폼 Staging 재배포/실제NEW표시QA다.
  자세한 Figma/검증/전달 근거는 [DL-16652 정본](dentlink-patient-list-design.md)을 따른다.

## 이전 확인 — 2026-10-08 검토 중 아이콘 결함 조사

- 사용자 iOS Staging 실물 제보의 ‘검토 중’ NEW 아이콘 누락은 환자 카드의 흰 배경과
  SvgTeethFilled path 고정 white가 원인이다. root color를 SVG 변환/native renderer가 덮어쓰지 않는다.
  같은 카드 코드의 Android도 영향을 받는다. 다른 상태 SVG12개 확인에서 같은 white 대비 원인은 없다.
- Lab/Office 일반 주문목록은 보라색 원 위 white라 같은 문제가 없고 Office #318은 Remake만 변경했다.
  실제 양 제품 기기 화면은 사용자 확인과 구분한다. 이전 QA에서 NEW 실색 확인을 놓쳤다.
- 제품 수정/PR/배포/Jira는 아직 하지 않았다. Staging v31은 배포 완료지만 이 결함은 미수정이다.
  공용 teeth를 보존하고 Lab 환자 카드 범위에 한정해 앱 Figma 근거대로 보정하는 것이 다음 시작점이다.
  정본은 [DL-16652](dentlink-patient-list-design.md)다.

## 이전 확인 — 2026-10-08 Staging CodePush 양 플랫폼 배포

- 사용자 병합 #5=768814e1/15:21:32·#6=f000ae2c/15:22:06 KST를 확인했다.
  최신 release/v1.0.4@f000ae2c의 tree31a50be7은 기존 모의통합과 동일하며 소스 새 변경은 없다.
- 기존 patient-list worktree를 clean **detached f000ae2c**로 바꿔 사용자 승인 Staging 배포를 실행했다.
  feature55bc143·문서9e04b395·source/원격branches는 보존했다. 다음 코드작업 전 checkout을 다시 확인한다.
- **Dentlink-Lab-iOS Staging v31(15:25:36)**, **Dentlink-Lab-Android Staging v31(15:26:36)** 업로드 성공이다.
  서버 history로 대상1.0.4·활성·mandatory·rollout100%·description f000ae2c를 각각 검증했다.
  index.js·Hermes release bundle·플랫폼별 Staging 명령을 사용했고 Slack/Production/Development 호출은 없다.
- Jira44342/READY FOR QA 유지와 개인기록을 정리했다. 실제 Staging 설치본의 v31 OTA 적용/재실행·기능QA는
  아직 미검증이다. 상세 hash·확인경계·다음 시작점은 [DL-16652](dentlink-patient-list-design.md) 정본을 따른다.

## 이전 확인 — 2026-10-08 최신 릴리스 충돌 해결

- 밀링센터 #7 반영 후 release/v1.0.4@96cc94a0가 src 단독 구조로 바뀌었다. 사용자 승인으로
  기존 #6을 동기화한 HEAD55bc14377104b294a424d30a5fe135c946e2655d를 일반 push했다.
  최종 diff18파일(+579/-150)·behind0·clean/원격0/0이며 MERGEABLE/CLEAN이다.
- 승인14949c6의 카드/탭/조회/번역을 연결했고 최신 생성API·밀링·인증·캐시·navigation은 보존했다.
  밀링 Lab SVG2개를 유지하고 환자 전용 SvgPatientLabFilled를 추가했다. native/설정/deps/버전 변경0이다.
- 기존13테스트·scope lint/format·버전1.0.4·diff PASS, 양 플랫폼 index.js 배포용JS bundle 성공이다.
  최신release/feature fulltsc5오류·3228bytes 로그 byte 동일/신규0이며 전체통과가 아니다.
  이전 카드9개는 변경 전 icon mock이라 이번 재실행 제외다. 새 기기/native/OTA 검증은 하지 않았다.
- 문서 #5도9e04b395로 동기화해3파일(+72/-3)·CLEAN이다. 함께 모의통합 충돌0/21파일이며 순서독립이다.
  두PR의 미해결0·검사pending0·사람승인0, 실제merge/태그/CodePush/메인보고는없다.
  이전20파일/apps-lab 진입점은 당시 이력이며 최신 정본은 [DL-16652](dentlink-patient-list-design.md)다.

## 이전 확인 — 2026-10-08 분리 전 릴리스에서 기능만 전달

- [기능 PR #6](https://github.com/Innvoaid/dentlink-lab-app/pull/6)은 `release/v1.0.4 / cb585775`에서 직접
  시작한 `feature/lab/DL-16652-release / e3bf33567c5fde6e526e38b237d2b21f416b4476`이다.
  기존 환자목록 worktree를 재사용했고 source/origin clean·0/0, behind0/ahead1·20파일(+1037/-19)이다.
  분리·다른 기능·native·의존성·버전·설정 변경 없이 요청한 카드/API/번역/SVG/Remake만 옮겼다.
- 이 릴리스의 `apps/lab`·`shared` 구조와 Office 기존 환자 화면을 보존한다. Lab 전용 typed query·
  새 탭을 분기하고 최신 DEV Swagger에서 필요한 DTO/endpoint만 별도 생성했다.
  배포용 JS entry는 **`apps/lab/index.js`**이며 modern split `index.js` 증거와 혼용하지 않는다.
- renderer10·연결 흐름4·버전/immutable install/diff/변경 lint·format PASS, iOS/Android release-mode
  JS bundle 성공. 전체 Lab/Office 타입검사 각각 baseline/final6진단 동일·신규0이며 full pass가 아니다.
  독립 코드 리뷰 결함0·release/#5 모의통합 충돌0이다. 새 포트의 실제 기기·native build·OTA는 미실행이다.
- #6·독립 문서 #5는 OPEN/non-Draft/MERGEABLE/CLEAN, 올바른release·전체diff·자동화 완료·미해결0이다.
  대체된 #2·#3·#4는 CLOSED/미병합이다. foundation 병합은 불필요하며 옛 source branch는 보존했다.
  Jira44342와 PR본문을 최신 결과로 갱신했다. 실제 PR merge·태그·CodePush·메인 보고는 하지 않았다.
- 전체 정본·검증 한계·다음 시작점은 [DL-16652](dentlink-patient-list-design.md), 앱 전달 원칙은
  [SESSION_WORKFLOW](../SESSION_WORKFLOW.md#dentlink-app-release-and-delivery-policy)다.
  아래 실제 기기 결과는 이전14949c6에 대한 이력이며 새e3bf335 기기검증으로 계산하지 않는다.

## 이전 확인 — 2026-10-08 기반 통합 준비·기기 QA

- 리뷰전최종점검에서19파일전체코드/호출부추가검토·새확정결함0, 현재실행할준비잔여0을확인했다.
  merge-tree순차통합은충돌0·최종tree14949c6와동일이며실제refs/PR은미병합이다.
  PR#4/#2본문의검증/한계와Jira44342를갱신했고메인세션에는보고하지않았다.
- 최신 사용자 지시는 Lab 앱만 **리뷰 가능한 미병합 상태까지 완료**, 웹·Office 추가 처리와 메인세션 보고 제외다.
  이번 기능은 기존1.0.4 호환 CodePush 작업이며 새 release/버전/심사를 만들지 않는다.
- [기반 #4](https://github.com/Innvoaid/dentlink-lab-app/pull/4)는 기존분리 f332833 그대로6커밋·981파일→release/v1.0.4,
  [기능 #2](https://github.com/Innvoaid/dentlink-lab-app/pull/2)는 그 기반branch를 임시base로4커밋·19파일이다.
  둘다OPEN/non-Draft/MERGEABLE/CLEAN이며 실제merge·태그·OTA업로드/활성화는 하지 않았다.
  기반Merge commit→기능base를release로변경→19파일재확인 순서를 각 PR과 [작업 정본](dentlink-patient-list-design.md)에 기록했다.
- 새 버전 검사/두diff검사/기존 서비스·주문상세9테스트 통과. source14949c6 clean/원격동일·네이티브/의존성변경0이다.
  실제Release설치본OTA QA는 이후배포단계이며 Debug/Metro결과와 구분한다. Jira44342에 Lab 준비를 기록했다.

- PR #2는 OPEN/non-Draft/MERGEABLE/CLEAN, HEAD `14949c6afd`는 소스·원격 동일하며 새 제품 수정은 없다.
- DeviceHub 정상 입력이 회복돼 정식 cached Debug 앱 1.0.4(151)+최신 Metro를 own SE3/iOS 26.5에서
  확인했다. 실제 DEV 로그인·환자 770명/첫 페이지 10명·이름 검색 1명·recentOrderId 기반 상세 이동,
  WebView mounted/loading=false/errorPage=false까지 정상이다. 웹 상세 내부 조작은 별도다.
- 별도 iOS 합성 KO/EN에서 카드 343×248pt·목록 간격 14pt·내부 12pt·두 9자리 주문 수 보존,
  긴 라벨·생일 없음·Remake primary600·6개 상태를 확인했다. iOS pressed·지정 QA 그룹 ID 대조·
  실물 기기·배포 바이너리·최종 Android APK 재빌드는 미검증이며 이전 Android 증거와 구분한다.
- 공식 Sheet connector의 신규 6키/en·ko 12값은 현재 생성 파일과 모두 일치했다.
  CLI 403은 10월 6일 결과이며 오늘 CLI는 재실행하지 않았다. DEV는 새 API, STG는 이전 API다.
- PR 본문에 새 iOS 결과와 STG 선배포 조건을 반영했다. 전체 정본과 다음 시작점은
  [DL-16652](dentlink-patient-list-design.md)에 둔다. fixture/언어·own sim/Metro8088을 정리했고 .env 부재·
  Git clean/원격 동일·본문 readback/자동 검사 SUCCESS를 확인했다. 아래 DeviceHub 실패는 이전 확인 이력이다.

## DL-16652 최종 디자인 전달 — 2026-10-06~07 이력

- [PR #2](https://github.com/Innvoaid/dentlink-lab-app/pull/2), feature/DL-16652→develop,
  OPEN/non-draft/MERGEABLE/CLEAN 및 자동 제목/본문/라벨 검사 성공 확인.
- worktree `/Users/parkjongsun/Repository/dentlink-lab-app-patient-list`, base f33283339,
  Remake `0b7a94a288bcc1bdfbc26c1be3a2c4f9fff9cd8e` + 환자/API/i18n
  `5debbe0d3edd692fa96022db568b338e5fe08efb` + 최종 색상 `4f4e9c1` + 주문수 한줄 보정
  `14949c6afd77530852c166b317a667f4b30dd049`,4커밋·19파일. HEAD/원격 일치·clean·0/0 확인.
- 최종 카드의3정보줄·두 주문 수·생일 숨김·header Remake·상태/카테고리/의사·내부12px,
  실제 SVG 원본과 전역 Remake 배지3사용처를 반영했다. DEV 배포12필드와 최근 주문 이동을 연결했다.
- 23시 최신 Figma에서 문구/icon primary600을 확인해 공용 Remake를 최소 보정했다.
  실제375dp 기기에서 주문 수 라벨 두줄/긴EN 잘림을 발견해 환자 화면 전용으로 보정했다.
  한국어14px 한줄·343×248 카드/목록gap14를 유지하며 긴EN은 라벨만 말줄임하고 두9자리 숫자를 보존한다.
- 앱 번역 시트 양 영역314~319행에 신규6문구를 등록해 en/ko/registry를 생성했다.
  기존313행과 PM 이름/요청 상태를 보존했다. connector readback 및 승인 liveCSV283문구 검사 통과.
  CLI live check는 ADC scope403으로 실패했으며 시트 등록 실패와 구분한다.
- renderer10·변경 lint/Prettier/diff·최신 Android Metro bundle 통과. type4오류는 baseline/final SHA동일·신규0.
  fresh Android36 AVD와 기존 development APK+최신Metro에서 이전 system timeout을 재현하지 않았고
  정상 로그인·DEV763건 중10행 카드·검색1행·recentOrderId 기반 실제 주문 상세 이동/로딩을 확인했다.
  한국어 기본 실데이터와 긴문구/EN/9자리/Remake 기기 합성 fixture를 구분한다.
  최종 native APK 재빌드나 STG 통합 QA 완료로 표현하지 않는다. STG 실제 응답은10월7일00:36에도 이전 계약이다.
- 10월7일 잠금 버전 immutable deps·Ruby3.4.10/Bundler2.6.9/CocoaPods1.16.2와 독립 공식 index/cache로
  canonical deployment Pods를 설치했다(124dependencies/163Pods·lock byte동일·설정 hash 불변).
  정식 DentlinkLabDevelopment Debug simulator 빌드1.0.4(151) 성공 후 신규 SE3/iOS26.5에서 정상 설치·실행·
  Metro8088 연결·미인증 KO 알림 안내 렌더(375×667pt)를 확인했다. 제품 코드 수정은 필요하지 않았다.
- Xcode27 DeviceHub의 자동 제어 연결 실패/공식 simctl 입력 기능 부재로 iOS 실제 환자·검색·이동과
  합성 카드 UI는 미검증이다. 기존 Android 실제/합성 확인 결과와 구분하며 실제 기기도 연결0대다.
  비공식 입력/SDK/인증 우회 없이 own sim·Metro·본인 생성 root.env를 정리했고14949c6 clean/원격 동일하다.
  PR2 본문 검증 결과 갱신/readback·자동 검사 SUCCESS·artifact 연결까지 확인했다.
- 사용자 후속 승인으로 앱 PR까지 생성했다. merge/배포는 제외한다. 전체 정본은
  [DL-16652](dentlink-patient-list-design.md)이며 아래 초기 준비/번역 절차는 당시에 확인한 이력이다.

## 초기 로컬 준비 — 2026-10-06 (전달 전 이력)

- DL-16652 웹·기공소 앱 작업 요청으로 원격을 새로 clone했다. 기본 `main`은
  `f33283339d339b3c6d39fe2735a8420f2c1a5ae1`, `origin/main`과 동기화·clean이다.
- 조회 당시 `origin/develop`도 동일 HEAD다. 기존 앱 기능 기준에 맞춰 DL-16652를
  `origin/develop`에서 준비했으며 이후 기능 시작/전달 시 최신 base와 실제 PR 대상을 재확인한다.
- 작업 worktree: `/Users/parkjongsun/Repository/dentlink-lab-app-patient-list`.
  branch `feature/DL-16652`, 기준 대비 0/0·clean, upstream·원격 feature·PR 없음.
  기본 main과 기존 Office·권한관리 checkout을 변경하지 않았다.
- 의존성 설치·Metro·네이티브 빌드·시뮬레이터·실기기·테스트·배포는 아직 수행하지 않았다.
  Office 앱의 설치 앱·빌드 증거를 Lab 앱 검증으로 대체하지 않는다.

## 번역과 스프레드시트 작업 — 2026-10-06

- 승인된 Lab 앱 기능 구현에서 정적 UI 문구가 바뀌면 i18n과 운영 스프레드시트까지
  기본 작업 범위에 포함한다. 공통 정본은
  [SESSION_WORKFLOW.md](../SESSION_WORKFLOW.md#dentlink-lab-translation-work)다.
- 실제 절차는 저장소 `README.md`의 번역 동기화 (Lab), `package.json`,
  `scripts/sync-lab-i18n.js`, `scripts/lab-i18n-code-scanner.js`를 확인한다.
- 앱 시트는 `src/configs/i18n/index.ts`의 `LAB_I18N_SPREADSHEET_ID`를 따른다.
  확인 당시 기본값은 [기공소 앱 번역 시트](https://docs.google.com/spreadsheets/d/1ZnPl5a3P3dKtxDTadLX56aTmuJ58TrpZiRcXDexdLbw)이며
  `개발자 영역`·`비개발자 영역`을 함께 관리한다. 웹 Lab 번역 시트와 혼용하지 않는다.
- 신규 문구 절차: 실제 변경 문구·기존 key 대조 → `yarn i18n-google-sheet:dry-run`
  → 누락·충돌 확인 후 `yarn i18n-google-sheet`로 시트 반영 → PM 문구 확인
  → `yarn i18n`으로 `src/configs/i18n/locales/{en,ko}.ts`·`textRegistry.ts` 생성
  → `yarn i18n:check`와 변경 문구·화면 검증. 기존 문구 수정은 대응하는 시트 행과
  PM 검토 절차를 확인하며, 삭제는 다른 사용처가 없는지 먼저 대조한다.
- 새 문구 스캐너는 미커밋·미추적 `src` 변경의 일부 literal만 수집한다.
  `t(key, { defaultValue })` 또는 변수·Map 문구가 누락될 수 있으므로 실제 diff와
  시트 행을 직접 대조해 보완한다. 스캐너가 0개를 찾았다고 번역 완료로 판단하지 않는다.
- 생성은 `PM 확인여부=확인`인 행만 포함한다. 미확인 문구를 임의 승인하지 않으며
  새 key가 제외되어도 `i18n:check`가 성공할 수 있으므로 대상 문구의 생성 여부를 별도로 확인한다.
- iOS·Android 실행 명령의 자동 `i18n` 호출은 시트에서 리소스를 생성하는 단계다.
  코드의 신규 문구를 시트에 등록하거나 PM 확인을 대신하는 자동화는 아니다.
- 시트 편집 인증, PM 검토 또는 충돌 해결이 필요하면 해당 단계는 미완료로 남긴다.
  `yarn i18n`은 인증이 있을 때 시트의 정리·검수 상태도 갱신할 수 있으므로 결과를 확인한다.
  생성 리소스만 수동 변경한 상태를 시트 동기화 완료로 보고하지 않는다.
- 이번 확인에서는 제품 파일·시트를 수정하거나 번역 명령을 실행하지 않았다.

## 규칙과 다음 시작점

- 작업 checkout의 `AGENTS.md`를 읽고 선택한 release의 실제 구조와 Styled Components 규칙을 따른다.
  main/develop의 `src`와 이번 #6 release의 `apps/lab`·`shared`를 혼용하거나 구조 변경을 자동 포함하지 않는다.
- 작업 branch의 생성 모델은 직접 수정하지 않고 확인된 Swagger로 생성한다.
  #6의 Lab DTO는 `shared/models/LabPatientApi.ts`이며 기존 공통 모델 재생성으로 범위를 넓히지 않는다.
  백엔드 미완성 상태와 예정 계약·실제 연동 완료를 구분한다.
- 환경·서명·CodePush·스토어 배포는 별도 사용자 지시를 따른다.
- 환자목록의 첫 작업은 [DL-16652 정본](dentlink-patient-list-design.md)에서 이어간다.
  현재 #6 API 경로는 `shared/services/lab.service.ts`, query는 `shared/queries/useLabQueries.ts`,
  화면은 `shared/features/orderList/tabs/OrderLabPatientTabScreen.tsx`와
  `shared/features/orderList/components/OrderLabPatientListItem.tsx`다. 원래 Office 탭은 공통 wrapper가 유지한다.
