# 기공소 환자목록 디자인·API 대응 — DL-16652

## 최신 확인 — 2026-10-08 Lab 사용자 병합·양 플랫폼 Staging CodePush 완료

- 사용자가 Lab 문서 #5와 기능 #6을 병합했고 직접 Staging CodePush iOS/Android 배포를 승인했다.
  live MERGED: #5 `768814e1b5a9642df1979998cc89289c4d5f0759`/15:21:32 KST,
  #6 `f000ae2c2974068f3ceb0bb914b19c2a23a305ac`/15:22:06 KST다. root는 PR을 병합하지 않았다.
- 배포 소스는 최신 origin/release/v1.0.4의 **f000ae2c**, tree는31a50be7이다.
  검증한 기능+문서 모의 통합 tree와 실제 병합 tree가 동일하고 55bc143 대비 실행코드/native/deps diff0이다.
  기존 patient-list worktree를 clean 상태에서 **detached f000ae2c**로 전환해 배포했다.
  feature/lab/DL-16652-release@55bc143와 문서 feature@9e04b395, 원격/source/백업은 보존했다.
- 기존 인증의 Revopush CLI0.0.15와 앱의 플랫폼별 Staging 명령을 사용했다.
  `yarn codepush-force-ios:staging --description 'DL-16652 patient list and remake; release/v1.0.4 f000ae2'`
  이후 Android 명령을 순차 실행했다. Slack 호출 없는 명령이며 entry index.js·Hermes release bundle,
  대상 바이너리 **1.0.4**·mandatory·rollout100%·isDisabled=false다. 버전일치/clean/원격SHA를 확인했다.

| 제품/OS | deployment/실제 label | 업로드 KST | packageHash |
| --- | --- | --- | --- |
| Dentlink-Lab-iOS | Staging / **v31** | 15:25:36 | 540a59c6d7973a2ebfde5a7b1af2f67d9ab40b6a6e9f9dec8346311ff8f2ec7d |
| Dentlink-Lab-Android | Staging / **v31** | 15:26:36 | 5c135f9e7f93b6021c133ff3a08f9c40b561630a3bbb63d309a09f90ba97f332 |

- 양 CLI exit0/Successful release 이후 서버 history를 각각 재조회해 label·description·1.0.4·
  active·mandatory·rollout100%를 검증했다. 직전 Staging은 양쪽 v30이었고 이번에 각각 v31이 됐다.
  upload/활성화가 완료됐으며 실기기의 OTA 다운로드·적용·재실행/화면 QA는 이번에 확인하지 않았다.
- Production/Development·태그·native 빌드·스토어·클리닉 앱에는 이번 배포를 실행하지 않았다.
  STG Swagger와 4시간 재점검 취소·메인 세션 메시지 제외를 유지했다. 소스 변경/추가 제품 커밋은 없다.
- 담당 Jira44342를 Staging 배포 결과로 갱신하고 READY FOR QA를 유지했다. 다음 시작점은
  Lab Staging 1.0.4 Release 설치본에서 v31 적용과 환자 목록/검색/최근 주문/Remake를 확인하는 것이다.
  Git 준비·PR 사용자 병합·양 플랫폼 Staging 업로드와 실기기 적용 QA는 별도 상태다.

## 이전 확인 — 2026-10-08 클리닉 사용자 병합·Lab 릴리스 충돌 해결

- 사용자가 웹 병합·배포 완료와 클리닉 병합을 알렸다. 클리닉 #318의 실제 MERGED도 확인했다.
  merge `bf9e897ef72d37190cc52c84cd796ce2ec6a0e3c`, 15:02:42 KST다. 웹 배포 완료는 사용자 보고이며
  이번에는 배포 Actions/화면을 재검증하지 않았다. 아래 웹 IN_PROGRESS와 Office OPEN은 이전 조회 이력이다.
- Lab release가 밀링센터 #7 반영으로 `96cc94a0cf0166eebcd5d7bf1553135df0b1904a`의
  `src` 단독 구조로 바뀌어 #5/#6 모두 충돌했다. 사용자가 Lab 후속 처리를 승인했고 기존 두 PR을
  최신 release에 동기화·일반 push했다. 실제 PR 병합·CodePush·태그·스토어·메인 보고는 하지 않았다.
- [기능 #6](https://github.com/Innvoaid/dentlink-lab-app/pull/6)의 HEAD는
  `55bc14377104b294a424d30a5fe135c946e2655d`, 부모 e3bf335+96cc94a0다.
  branch `feature/lab/DL-16652-release`, 기존 patient-list worktree, clean·원격 0/0다.
  최종 diff는 **18파일 +579/-150**이며 최신 release가 ancestor다. 새 PR/force push는 없다.
- 승인된 14949c6의 표준 환자 카드·탭·서비스·Common query·번역·SVG를 현대 구조에 연결했다.
  기존 분리 전 포트의 Office wrapper·별도 Lab 카드/탭/query/model은 제거했다. 최신 생성 API는
  새 환자 DTO 12필드가 이미 있어 파일 전체를 유지했다. 기존 밀링센터 service/query·계정 전환·
  fetcher/navigation/native/의존성/lock/환경/버전/빌드 스크립트는 release와 byte 동일하다.
- 밀링센터의 SvgObjectLabFilled/Small을 보존하고 환자 원본을 **SvgPatientLabFilled**로 추가했다.
  아이콘 이름 외 카드 내용은 승인본과 byte 동일하며 SVG export를 재생성했다. 12px·상태/detail 조건·
  recentOrderId·isRemake·주문 수·생일 없음·전역 Remake·번역 6키를 독립 검토했고 새 결함 0이다.
- 새 검증: immutable install·버전 1.0.4·diff·손작성 TS6파일 ESLint/Prettier PASS.
  기존 서비스 격리6·주문 상세3·번역3·공용 배지 renderer1 **13개 PASS**다. 테스트 소스는 수정하지 않았다.
  예전 카드9개는 변경 전 아이콘 mock이어서 재실행 범위에서 제외했다. 이전 카드10/기기 결과는 원본의 이력이다.
  iOS/Android 각각 **index.js·dev false JS bundle 성공**이며 새 native 빌드/기기/OTA 검증은 아니다.
  동일 deps의 최신 release와 full typecheck는 각 오류5/exit2·로그3228bytes byte 동일, 신규 오류0이다.
- [독립 문서 #5](https://github.com/Innvoaid/dentlink-lab-app/pull/5)의 HEAD는
  `9e04b395275a870bf3bf74b42c155eafb9f41d89`, 부모2fb6e8b+96cc94a0다. 최신 src 경로와
  i18n:optional을 보존한 문서3개 **+72/-3**이며 생성 리소스·시트·실행코드 변경은 없다.
- 두 PR 모두 release/v1.0.4@96cc94a0 대상으로 OPEN/non-Draft/MERGEABLE/CLEAN,
  미해결 리뷰0·사람승인0·autoMergeRequest=null이다. 최신 라벨 자동화는 COMPLETED/SKIPPED이고
  pending0이다. Lab CodeRabbit 실제 리뷰 완료 근거는 없으며 자동화 종료와 구분한다.
  둘의 merge-tree 모의 통합은 충돌0/tree `31a50be704fa918455c7661b68184eae5d5b685c`,
  release 대비21파일(+651/-153)이다. 문서와 기능은 독립이어서 필수 병합 순서는 없다.
- 담당 Jira 기존44342를 갱신했다. live 카드가 READY FOR QA로 바뀐 사실을 확인해 그대로 유지했다.
  기존 담당자·fixVersion/상위카드는 변경하지 않았다. 기존 Sheet 승인값을 그대로 유지했고 이번에는 쓰지 않았다.
  STG Swagger/4시간 재점검 취소도 유지한다. 기존 source/원격 branch와 동기화 전 백업 ref를 보존했다.
- 다음 시작점은 두 PR의 최신 HEAD/base/diff를 다시 확인하는 것이다. 현재 리뷰 전 Git 준비는 완료이며
  사용자 실제 병합 후 배포용 앱/CodePush 적용 QA는 별도다. 옛 #2/#3/#4 재오픈·foundation 통합은 필요 없다.

## 최신 웹 전달·세션 정리 — 2026-10-08 스테이징 PR #4677

- **현재:** 사용자jongsunP가 #4677을 14:50:42 KST에 병합했다. 실제stage SHA는
  `d37956611815ac17f2095c05fa6392b57c55f736`, tree는release cb38bfbfc87865f97dae9bc6c39f9c9d30c7203f와 동일하다.
  14:50:45에 같은SHA로 시작한 치과웹37734431427·Lab웹37734431389·Admin37734431594 배포Actions는
  최종조회당시 모두 IN_PROGRESS다. root가 PR병합/배포명령을 실행한 것은 아니며 배포·통합QA 완료는 아직 아니다.
  아래 OPEN/새stage=master/새run미관측은 생성직후 증거로 보존한다.
- 사용자가 앞선 앱 PR 구성이 본인 의도와 맞다고 확인했다. 최종release에서 본인작업만 전달한다는
  정책과 아래 #318유지/#6기능/#5독립문서 구성을 확정한다. 앱source·PR을 이번에는 추가 변경하지 않았다.
- 이어 사용자 승인으로 **웹 원격 stage 삭제 → 최신 원격 master에서 stage 생성 → release/v1.88.0 PR**을 실행했다.
  이전 stage248e4028b8f89484bd3be1e627affb5200b3d3b9를 로컬
  `refs/codex-backup/stage-20261008-248e4028b8f8`에 보존했다. 열린stage PR0·보호/rules0을 확인했고
  삭제시 oldSHA lease·생성시 nonexistence lease로 다른 작업의 원격 변경을 덮어쓰지 않게 했다.
- 새stage=현재master **6b79c9756cc56313fe833aad463bddb1f8c385fa**, head release는
  **eca577a6e67e4f23aa3c4742a12e23f261298233**다.
  [PR #4677](https://github.com/Innvoaid/dentlink-client/pull/4677) `release/v1.88.0 → stage`,
  OPEN/non-Draft/MERGEABLE/UNSTABLE·21커밋/985파일(+86260/-9948)·autoMergeRequest=null을 readback하고 artifact에 연결했다.
  환자목록만의 PR이 아니라 최신 1.88.0 전체 릴리스다. 제품코드/추가커밋/로컬checkout 전환은 없다.
- #4665 사용자병합3e428d847·#4666 지침dd9f1f544의 릴리스 포함을 확인했다.
  모의병합은 충돌0이고 결과tree cb38bfbfc87865f97dae9bc6c39f9c9d30c7203f=release tree다.
  master-only #4657은 release #4658과 같은코드결과로 통합된다. 전체diff 기존EOF빈줄3건은 PR본문에 남기고 수정하지 않았다.
- 원격 삭제/생성 normal push 훅이 성공했고 lint의 기존경고/coverage변화0은 별도로 구분했다.
  훅은 기존feature1c829807 checkout에서 실행되어 최신전체릴리스 런타임/타입검증으로 확대하지 않는다.
  PR 생성 후 DLOS guard·리뷰어자동할당 SUCCESS, CodeRabbit은stage대상비활성화 SKIP,
  Vercel은 최신release작성자chajju 프로젝트접근권한 FAILURE다. 전체CI통과로 보고하지 않는다.
  stage최신run조회에서 새master기반ref 배포실행은 관측되지 않았고 옛stage배포만 조회됐다.
- 담당Jira44342를 웹stage준비/앱최종PR 링크로 갱신/readback했다. 상태진행중·상위카드/fixVersion은 유지한다.
  tracked clean·원격동일, task개발서버 잔류0을 확인했다. 실제stagePR병합·수동배포·통합QA는 미실행이며
  원격sourcebranches·앱unmergedworktrees·웹QA자료를 보존했다. 메인세션 메시지는 보내지 않았다.
- 다음 시작점은 현재stage/릴리스SHA를 확인하고 위 사용자병합SHA의 Clinic/Lab/Admin Stage Actions 결과와
  최신릴리스 통합QA를 확인하는 것이다. 앱의 구현/문서 PR 전달은 아래 기준이며 병합/CodePush 적용은 별도다.

## 현재 상태 — 2026-10-08 요청한 변경만 릴리스 PR로 정리 완료

- 사용자 최종 지시: 본인이 올린 클리닉·기공소 앱 PR 전체를 확인하고, **최종 대상 릴리스에서
  이번 작업만 반영**하도록 정리한다. 필요하면 새 feature에 작업만 옮기고 불필요한 PR은 닫는다.
  실제 PR 병합·태그·CodePush·스토어 작업·메인세션 보고는 계속 제외한다. 웹은 사용자 병합 완료다.
- 이전 기반 #4 → 기능 #2 순차 통합안은 폐기했다. 분리 이력은 이번 기능의 필수 의존성이 아니며
  해당 릴리스의 기존 구조에 기능만 옮길 수 있었다. 기존 앱 분리·DL-16548·DL-16556을 함께 반영하지 않는다.
  이전 `codex/` 기반 이름도 개인 feature 규칙에 맞지 않았으며 새 브랜치는 `feature/` 규칙을 따른다.

| 제품·범위 | 현재 PR → 최종 릴리스 | 브랜치·푸시 HEAD | 실제 전체 diff |
| --- | --- | --- | --- |
| 클리닉 Remake | [#318](https://github.com/Innvoaid/dentlink-app/pull/318) → `release/v2.2.4` | `feature/DL-16652` / `81584b8201edffd00b2261aaa5d7322be493bd1e` | 3파일, +16/-14 |
| 기공소 환자 목록·Remake | [#6](https://github.com/Innvoaid/dentlink-lab-app/pull/6) → `release/v1.0.4` | `feature/lab/DL-16652-release` / `e3bf33567c5fde6e526e38b237d2b21f416b4476` | 1커밋·20파일, +1037/-19 |
| 기공소 번역 운영 지침 | [#5](https://github.com/Innvoaid/dentlink-lab-app/pull/5) → `release/v1.0.4` | `feature/lab-i18n-workflow-release` / `2fb6e8b3a0840255796b29ad5000cbabfc8a71b3` | 1커밋·문서 3파일, +86/-1 |

- 클리닉 #318은 릴리스에 없는 실제 변경이 배지 3파일뿐이고 그 외 tracked 파일이 릴리스와 동일하다.
  커밋 수가 많다는 이유로 재작성하지 않았다. 최종 live 확인에서 OPEN/non-Draft/MERGEABLE/CLEAN,
  **APPROVED**, CodeRabbit SUCCESS·미해결 0·검사 pending 0·autoMergeRequest=null이다.
  이 승인 완료 상태는 앞선 승인 대기 기록보다 최신이며 사용자의 실제 병합 결정은 대신 실행하지 않았다.
- 기공소 #6은 `origin/release/v1.0.4`의 `cb585775ca21e27949e67758a5933139cfc567d8`에서 직접 분기했다.
  worktree는 기존 `/Users/parkjongsun/Repository/dentlink-lab-app-patient-list`를 재사용했고 source/origin clean·0/0,
  릴리스 대비 behind 0/ahead 1이다. 전체 20파일은 카드·Lab 탭·최소 공통 분기·Lab 조회/타입·SVG8개·
  6개 번역키·Remake 배지다. native/SDK/의존성/lock/버전/env/진입점/워크플로·다른 기능 변경은 없다.
- 기존 릴리스의 `apps/lab`·`shared`를 유지한다. Lab만 새 탭·typed query와 `/lab/patients/consolidate`
  4개 조회 인자를 사용하고, Office의 기존 카드·조회·서비스는 그대로 보존했다.
  최신 DEV Swagger에서 해당 경로·DTO 2개만 생성한 별도 `shared/models/LabPatientApi.ts`를 연결해
  전체 공통 API 재생성을 피했다. 새 DTO 12필드·페이지 7필드·enum은 실제 spec과 대조했다.
  확정 디자인 12px·전역 Remake·recentOrderId 이동·상태/주문 수 표시와 기존 번역·SVG를 옮겼다.
- 새 검증: immutable install·앱 버전·diff PASS, 변경 손작성 TS 7파일 ESLint 0오류/경고,
  해당 TS와 새 DTO Prettier PASS, 카드 renderer 10개·실제 연결 흐름 4개 **총 14개 PASS**,
  정식 `apps/lab/index.js`를 사용한 iOS/Android `--dev false` JS bundle 모두 성공했다.
  Lab/Office 전체 타입검사는 각각 릴리스와 새 포트가 6진단/exit 2·로그 byte 동일해서 신규 오류 0이다.
  클리닉 별도 저장소의 기존 8진단과 구분하며 전체 타입검사 성공이라고 보고하지 않는다.
- 20파일 독립 코드 검토에서 새 확정 결함 0건이다. 실제 merge 없이 merge-tree로 릴리스 → #6
  충돌 0과 tree `115c0e1ca3cc12708296780470357fa994ac8b32`를 확인했다. #6과 #5를 함께 적용하는
  모의 통합도 충돌 0/tree `09fdb7563738b4d19a0e294ff54f0652ec0051a4`이며 실제 ref는 변경하지 않았다.
- #5는 기존 릴리스에서 별도 문서만 옮겼다. AGENTS·CLAUDE·README의 번역·운영 시트 지침을
  해당 릴리스 경로·명령에 맞췄으며 실제 번역·시트·생성 리소스를 새로 수정하지 않았다.
  #6 기능 반영과 독립이며 별도 순서·기반 PR이 필요하지 않다. 상세는 [번역 지침 전달](dentlink-lab-app-i18n.md)이다.
- Lab #5·#6은 자동화 완료 후에도 대상 `release/v1.0.4`와 전체 3/20파일 diff를 유지한다.
  OPEN/non-Draft/MERGEABLE/CLEAN·미해결 0·검사 pending 0·autoMergeRequest=null이다.
  Lab 저장소에서 CodeRabbit 실제 리뷰 완료 근거는 없으며 일반 PR 자동화 성공과 구분한다.
- 기존 **#2·#3·#4는 CLOSED/미병합**이며 각각 #6·#5·#6 대체 링크를 남겼다. task artifact의
  #2·#4 연결도 제거하고 #5·#6을 연결했다. 옛 원격/source branch는 복구용으로 보존했다.
  최종 14:23 KST 작성자 `jongsunP` 기준 두 저장소 OPEN PR 전체 조회에서 #318·#5·#6만 남았다.
  담당 Jira DL-16652 기존 댓글44342를 새 PR·범위·검증 결과로 갱신/readback했다.
  부모 카드·제목·상태(진행 중)·fixVersion은 변경하지 않았다.
- 이전 실제 기기 QA는 `14949c6` 구현에 대한 증거로 보존한다. 새 `e3bf335`의 확인은
  위 renderer/흐름/배포용 bundle이며 새 native 빌드·실제 기기·OTA 적용 완료로 확대하지 않는다.
  STG Swagger 재조회·4시간 재점검은 하지 않으며 취소 상태를 유지한다.
- 다음 시작점: 위 세 PR의 실제 HEAD/base/diff/검사/리뷰를 다시 확인하고 사용자 요청에 대응한다.
  #318은 현재 승인 완료, #5·#6은 리뷰 가능한 상태다. 기존 foundation을 병합하거나 옛 PR을 재오픈하지 않는다.
  실제 PR 병합·배포는 별도 사용자 결정이며 새 포트의 기기/OTA QA와 배포 환경 API는 별도 검증이다.

## 이전 상태 — 2026-10-08 기반 통합안의 리뷰 전 점검 (새 #6으로 대체)

- 사용자 최종 목표는 **지금 가능한 모든 준비를 리뷰 전에 완료**하는 것이다. 앱 두 제품의 코드·브랜치·
  PR 범위·검사·본문을 최종 점검했고 현재 자율 처리할 추가 코드/브랜치 준비 항목은0건이다.
  실제PR merge·태그·CodePush·스토어 작업과 메인세션 보고는 계속 제외한다. 웹 추가 처리도 하지 않았다.
- 클리닉 #318은81584b82→release/v2.2.4(14557194c), behind0·배지3파일(+16/-14),
  CodeRabbit 완료·추가actionable0/미해결0·사람승인1개대기다. 기존PR 그대로 승인 후 반영 가능하다.
- Lab 기반 #4는f332833→release/v1.0.4(cb585775),6커밋·981파일·version검사SUCCESS,
  기능 #2는14949c6→임시foundationbase(f332833),4커밋·19파일(+705/-152)이다.
  세PR 모두OPEN/non-Draft·미해결0·검사pending0·autoMergeRequest=null을 live 재확인했다.
- Lab19파일 전체diff·호출부를 추가 검토해 카드상태/주문수/생일누락/recentOrderId/Remake,
  API12필드/조회/페이지·번역6키/SVG8개 연결에 새 확정 결함을 발견하지 못했다.
  source가 동일해 기존기능/기기검사를 반복하지 않았다. 형식검사범위를명확히할때 손작성6개TS파일의
  Prettier를명시해확인했고모두PASS다(기존importOrder옵션경고는있으며source변경없음).
- 실제merge 없이 `git merge-tree --write-tree`로 현재release→foundation→feature 순차통합을 확인했다.
  충돌0, 기반tree f4e77ddd=현재f332833 tree, 최종tree24d55034=현재14949c6 tree다.
  branch/ref/worktree는 변경하지 않았다. #4 Merge commit→#2base를release로변경→19파일재확인
  순서는 현재 미병합 조건에서 미리 실행할 수 없는 실제반영 단계이며 두PR에명시했다.
- Lab PR #4/#2에 모의통합·전체코드검토 결과를 추가하고 본문readback했다. Lab 형식검사 문구는
  손작성변경TS의ESLint/Prettier로 범위를명확히해 생성파일전체포맷통과로 오해하지않게했다.
- 추가QA는완료로표시하지않는다. iOS누름유지/캡처는 현재Mac공식입력지원근거가없고,
  Office실제Remake는 가시행에서사례를못찾은검증한계다. 둘은배포전에도가능한플랫폼UI QA지만
  현재추가코드결함근거는없다. OTA는실제Release설치본에update적용·재실행을확인하는배포QA다.
  이경계들은각PR본문에보존했고기기/계정/서버/환경을임의변경하지않았다.
- Jira 담당자식DL-16652 기존댓글44342를 양앱의최종리뷰준비결과/3PR링크로통합갱신하고readback했다.
  새댓글중복·부모카드·제목/status/fixVersion변경은없다. Office/Lab HEAD와source/origin clean은그대로다.

## 이전 확인 — 2026-10-08 Office 릴리스 동기화

- 최신 사용자 지시로 Office/클리닉 PR #318의 **승인 외 준비를 지금 처리**했다. 앞선 Office 추가 처리 제외는
  이 동기화 범위에 한해 변경됐다. 제품 PR 실제 merge·태그·배포는 계속 금지이며 메인세션에도 보고하지 않는다.
  Lab의 기반 #4/기능 #2는 아래 미병합 준비 상태로 유지하고 웹에는 추가 처리하지 않았다.
- Office 기존 worktree `dentlink-app-patient-remake / feature/DL-16652`를 pull/fetch한 뒤
  최신 `origin/release/v2.2.4` `14557194c12f8836362d3663b27ab3b621c0478a`를 동기화했다.
  이전 feature `ffcdc736`은 release보다2커밋 뒤처졌고 strict 최신화 규칙/승인1개가 적용됐다.
- 기존 release 커밋 #316 `939ae95`와 #314 `1455719`의20파일(주문화면 수정·Denture 흐름 등)을
  충돌 없이 포함한 Merge commit **`81584b8201edffd00b2261aaa5d7322be493bd1e`**을 생성·기존 feature에 push했다.
  부모는 ffcdc736+14557194c다. 새 branch·기반PR·이력재작성·forcepush는 없으며 실제release ref는 그대로다.
- 현재 [PR #318](https://github.com/Innvoaid/dentlink-app/pull/318)은 `release/v2.2.4` 대상으로 OPEN/non-Draft,
  MERGEABLE/REVIEW_REQUIRED/BLOCKED다. HEAD는81584b82이며 source/origin 동일·clean이다.
  release 대비 behind0/ahead8, 최종diff **3파일(+16/-14)**다. 기존Remake patch3958bytes가 동기화 전후
  완전히 같고3파일blob도 ffcdc736과 동일해 새 배지 코드 변경은 없다.
- 새검증: 버전2.2.4(package/Android/Xcode)·diff검사·TS2파일ESLint0·badgePrettier·기존renderer3/3 PASS.
  생성 SVG index의 Prettier 실패는 release 원본에서도 같은 기존generator형식 문제라 파일을 수정하지 않았다.
- 최신release와동기화HEAD의 package/yarn/tsconfig byte동일·동일deps/TS5.9.3으로 fulltsc를 비교했다.
  양쪽exit2/진단8개·로그5765bytes byte동일이어서 신규오류0이다. 이전develop기준6개 검사와 구분하며
  전체타입검사통과로 표현하지 않는다. 이번release동기화로native/SDK/Pod/권한/JS의존성을 새로 변경하지 않았다.
  base의iOS프로젝트직렬화/Ruby도구lock갱신을 기능PR의새native변경으로 확대하지 않는다.
- 새HEAD CodeRabbit SUCCESS/Review completed·추가actionable0·미해결thread0을 확인했다.
  [봇댓글](https://github.com/Innvoaid/dentlink-app/pull/318#issuecomment-6013195506)의 target_branch_merge_carry_forward는
  이전ffcdc736 리뷰를 동일변경의merge동기화결과에 승계한 것이며 새전체소스리뷰로 주장하지 않는다.
  SVG는pathfilter제외, TS2파일처리다. add-labelsSKIPPED는release조건에 맞으며 새배포workflow는 없다.
- PR본문에 동기화·최신타입baseline·검증한계·실제PRmerge미실행을 반영/readback했다.
  pureGit준비라 이번에는 Jira의기능결과댓글/상태를 추가변경하지 않았다. 실물/실제OfficeRemake·OTA QA는
  기존미검증경계로 유지하며 새nativebuild/기기QA/환경/서명/서버변경은 하지 않았다.
- **현재 남은Git반영조건은 사람승인1개**다. 승인되면새branch·재작업·별도기반PR 없이현재#318을그대로merge할수있다.
  실제merge는사용자별도결정이며이번에는승인요청/auto-merge설정도하지않았다(autoMergeRequest=null).

## 이전안 — 2026-10-08 Lab 기반·기능 분리 준비 (폐기)

- 사용자 확정: 앱 분리는 완료됐고 DL-16652는 기존 `1.0.4` 대상 CodePush 작업이다.
  스토어 심사·새 버전·새 release는 이번 범위가 아니다. 이명제님 리뷰 도착을 선행 조건으로 삼지 않고
  리뷰 가능한 상태까지 준비하되 **모든 PR의 실제 머지는 금지**한다. 태그·OTA 업로드/활성화도 하지 않는다.
  웹·Office 앱 추가 처리와 메인세션 보고는 제외한다. 기존 4시간 재점검 취소도 유지한다.
- 이전의 ‘이명제님 확인이 필수’ 판단을 수정했다. 최신 앱 정책과 메인세션의 읽기 전용 의견은
  기존 `release/v1.0.4` 유지·분리 기반 별도 통합·기능 검토·CodePush 방향으로 일치했다.
  이 상담은 직전 사용자 요청에 따른 것이며 이번 준비 결과는 메인세션에 추가 전송하지 않았다.
- 이미 `main`/`develop`에 있는 분리 기준 `f33283339d339b3c6d39fe2735a8420f2c1a5ae1`을 그대로
  `codex/lab-release-v1.0.4-foundation` 원격 branch로 push해 [기반 PR #4](https://github.com/Innvoaid/dentlink-lab-app/pull/4)를 생성·artifact 연결했다.
  `release/v1.0.4`의 `cb585775ca21e27949e67758a5933139cfc567d8` 대비 **6커밋·981파일(+2671/-39780)**다.
  DL-16548·DL-16556 기존 수정, 문서/PR 규칙, DL-16313 분리 PR #1 및 통합 이력까지 포함한다.
  기반의 기존 네이티브/환경 정리는 이번 기능의 새 native 변경이나 새 바이너리 요구와 구분한다.
- [기능 PR #2](https://github.com/Innvoaid/dentlink-lab-app/pull/2)의 base를 위 기반 branch로 임시 변경했다.
  live GitHub diff는 **4커밋·19파일(+705/-152)**이며 로컬 `f332833...14949c6` 파일 집합과 정확히 일치한다.
  최종 대상은 계속 `release/v1.0.4`다. 기반이 미병합이므로 현재 release를 대상으로 한 19파일 PR이라고 보고하지 않는다.
- 두 PR 모두 OPEN/non-Draft/MERGEABLE/CLEAN·미해결 리뷰0, 사람 리뷰/승인0이다. #2에는 기존
  add-labels SUCCESS만 있으며 CodeRabbit 리뷰 완료 근거는 없다. #4의 새 Validate Lab/version 검사와
  title/body 자동화 SUCCESS·label SKIPPED를 완료 후 확인했다. 두 본문에 의존 관계·검증·한계를 기록했다.
- 새 검증: `yarn validate:versions` 통과(package·Android·Xcode 모두1.0.4), 기반/기능 각각
  `git diff --check` 통과. 서비스 격리 기존 테스트6개와 주문 상세 조회·이동·실패 처리3개를
  canonical jest.config.js로 실행해 **9개 PASS**, 나머지15개는 범위 제외했다. 신규 코드 결함은 확인되지 않았다.
  이전 renderer10·변경 lint/Prettier·번역·기기 QA는 아래 해당 일자의 결과를 재사용한다.
  전체 타입 오류4개는 기존과 동일하며 전체 타입검사 통과로 보고하지 않는다.
- 분리 전 `apps/lab/package.json`도1.0.4이고 기존 Lab CodePush 스크립트는 해당 파일을 읽었다.
  이전 루트0.0.1은 monorepo 버전이며 실제 Lab 버전 불일치 근거가 아니다. 현재 대상은
  Dentlink-Lab-iOS/Android·targetBinaryVersion1.0.4·entry index.js다. 이번19파일에는
  package/lock/native/환경 변경0이며 source HEAD `14949c6afd77530852c166b317a667f4b30dd049`와 원격이 그대로다.
- 사용자 담당 자식 Jira DL-16652 댓글44342에 Lab 리뷰 준비 결과와 두 PR 링크를 기록하고 readback했다.
  기존 title/status 진행 중/fixVersion과 부모 카드는 변경하지 않았다. 기존 여러 제품 기록의 일괄 재분류는 하지 않았다.
- 웹 PR #4665는 직전 live 확인에서 사용자 merge(2026-10-08 12:00:32 KST,
  merge `3e428d847b7410697520fb9026d181c558dddb46`)가 확인됐다. 이번에는 웹·Office checkout/PR을 추가 처리하지 않았다.
  Office merge 여부를 웹 merge나 사용자 ‘추가 처리 불필요’ 판단으로 추론하지 않는다.

### 이전안의 다음 시작점 — 실행하지 않음, 새 #6으로 대체

1. PR #4를 **Merge commit**으로 기존 release에 반영해 f332833의 조상 관계를 보존한다.
   저장소에서 merge commit 방식이 허용됨을 확인했다. Squash/rebase로 기반을 복제하면 feature diff가 다시 커질 수 있다.
2. PR #2 base를 `release/v1.0.4`로 변경하고19파일·HEAD·충돌·검사를 재확인한 뒤 기능을 머지한다.
   임시 기반 branch로 기능을 바로 머지하지 않는다. 기능 PR을 close/reopen하면 자동화가 base를
   develop으로 돌리므로 재오픈하지 말고 필요한 base만 변경한다.
3. 기존 번역 지침 PR #3은 이번 작업 밖이라 미변경이다. 기반 반영 후 해당 담당자가 별도 범위를 확인한다.
4. 새 API가 준비된 대상 환경에서 실제1.0.4 Release 설치본의 iOS/Android CodePush 적용·재실행을 확인한다.
   Debug/Metro는 OTA를 건너뛰므로 이전 기기 QA가 OTA 증거가 아니다. Production 업로드는 disabled이며
   활성화는 별도다. Development/Staging 명령은 disabled가 없어 사전 승인 없이 실행하지 않는다.

## 이전 확인 — 2026-10-08 FE 메인 전달 대상 조사

- 제품 코드·PR를 변경하지 않고 현재 base를 재조회했다. Lab #2는 `release/v1.0.4`,
  Office #318은 `release/v2.2.4` 대상이며 HEAD는 아래 표와 동일하다. 이전 develop 대상 기록은 당시 이력이다.
- Lab release는 저장소 분리 이전 트리라 #2의 전체 diff가 991파일·10커밋으로 확대돼 있다.
  이전 ‘해당 기능 diff만 포함’ 확인을 현재 base에 재사용하지 않는다. 선행 분리 통합 여부·전체 PR 범위는 미해결이다.
  공통 원칙과 근거는 [앱 온보딩·배포 지침](dentlink-app-onboarding.md)에 둔다.
  아래 기능 QA·API·번역 결과는 그대로 보존하며 실제 merge·배포 근거로 확대하지 않는다.

## 이전 확인 — 2026-10-08 재점검·iOS 후속 QA

- 사용자 현재 상황 확인 요청으로 개인 Git과 세 feature checkout을 pull하고 PR/API/Figma/시트를 live 확인했다.
  세 feature HEAD는 아래 표와 동일하며 소스 clean·원격 일치다. 코드 수정·PR Draft 전환·병합·배포는 하지 않았다.
- 웹 #4665는 OPEN/Draft/MERGEABLE/UNSTABLE, reviewDecision APPROVED다. chajju가 10월 7일 09:34:41 KST에
  승인했고 jongsunP 계정의 ConvertToDraftEvent가 같은 날 10:04:09 KST에 있다. 전환 이유는 확인되지 않았으며
  현재 Draft를 임의 해제하지 않는다. Vercel FAILURE·CodeRabbit SUCCESS, 세 PR 미해결 리뷰 0개다.
  release/v1.88.0 보호 규칙은 승인 1개·required contexts/checks[]·effective rules[]여서 Vercel은 필수 머지 검사가 아니다.
- Lab #2·Office #318은 OPEN/non-Draft/MERGEABLE/CLEAN·자동 검사 SUCCESS·추가 사람 리뷰 0개다.
  11:16 세 PR HEAD/미해결 리뷰 0개를 다시 확인했다. Jira는 진행 중/v1.88.0이며 댓글 44341에 새 iOS 결과와
  남은 조건을 기록하고 readback했다. 개인 checkpoint 6792b9e를 pull한 뒤 확인했으며 다른 작업 이력은 보존했다.
- 10:40:12 KST 실제 API: DEV 770행 새 7필드 모두 존재/정상 타입·null 0/recentOrderId 양수,
  old orderId 0행이다. STG 694행은 old orderId 694행·새 7필드 각 0행으로 이전 계약을 유지한다.
  STG Swagger는 조회하지 않았다. STG 신규 계약 선배포 조건은 아직 해소되지 않았다.
- 10:39~48 최종 Figma의 카드 12px·Remake text/icon primary600 및 관련 댓글 #15~#20은 그대로다.
  10:48 공식 Sheets connector에서 웹 10키×en/ko 20값·Lab 6키×en/ko 12값이 현재 생성 파일과 정확히 일치했다.
  PM 이름/상태나 셀은 변경하지 않았고 i18n CLI는 재실행하지 않아 이전 403을 오늘 결과로 재사용하지 않는다.
- DeviceHub 읽기 연결이 2.264초에 성공해 기존 timeout이 달라졌다. 정식 cached Debug 앱+최신 Metro를
  own Lab SE3/iOS 26.5에 연결해 정상 tap/setValue·로그인·serviceType LAB, 실제 770명/첫 페이지 10명,
  이름 검색 1명·선택 환자 recentOrderId와 OrderDetail route/WebView source 일치를 확인했다.
  상세 WebView mounted·isPreparing=false·loading=false·errorPage=false까지이며 웹 내부 조작 QA는 아니다.
- 별도 iOS 합성 KO/EN 카드에서 343×248pt·간격 14pt·내부 12pt·두 9자리 수치 보존/경계 내·긴 라벨,
  생일 없음·Remake primary600·6종 상태를 확인했다. 이번 iOS pressed 및 지정 QA 그룹 ID 대조는
  미검증으로 구분한다. current employee/employer는 auth/profile과 boolean 일치했으나 독립 승인 group ID는
  정본에 없다. Lab fixture/언어를 원복하고 own sim·Metro8088을 정리했다. HEAD14949c6 clean·원격 동일,
  오늘 native 재빌드/제품 수정은 없다. PR #2 본문에 새 결과/한계를 반영하고 readback 및 자동 검사 SUCCESS를
  확인했다. Lab UI 점유 해제 후 Office iOS를 순차 확인했다.
- Office iOS 로그인은 loggedIn=true/serviceType OFFICE 및 승인 QA 계정 일치로 성공했다.
  현재 자동 활성 employee/employer와 clinic QA 지정 ID는 dotenv의 inline 주석을 제외하고 정규화해
  비교하면 모두 일치한다. 최초 검사 false는 주석을 값에 포함한 helper 오류여서 그룹 blocker가 아니다.
  Home/Orders 및 초기 대기 필터 8건 중 가시 2행을 확인했으나 실제 Remake는 미발견이다.
  Reset/Done 두 좌표 tap과 5회 wheel은 수행 확증/행 변화가 없어 필터 초기화·paging 성공으로 계산하지 않는다.
  계정 전체/8행 전체의 Remake 0건으로 일반화하지 않는다. 별도 iOS local 배지 fixture는 실행하지 않았고
  기존 renderer 3/3 증거와 실제 서버 사례를 구분한다. PR #318 본문에 반영하고 readback했다.
  own sim/Metro8090/root.env를 정리했고 원본 env/설정/lock·ffcdc73 clean/원격 동일을 보존했다.
  두 앱 모두 오늘 새 native build/제품 수정은 없다. 그룹/주문/권한·SDK/서명 변경이나 병합/배포는 하지 않았다.
  현재 CoreDevice 3개는 모두 simulated이며 연결된 실물기기는 0대다. 기존 22개 sim은 초기 확인 시 모두 Shutdown이다.

## 이전 확인 — 2026-10-07 자율 재점검·iOS 확인

- 사용자 최신 지시: 스스로 처리 가능한 후속 작업은 처리하고, 없으면 대기한다. 불가한 항목은
  이유를 알리고 대기한다. 기존 commit/push·PR·Jira·개인 Git 기록 승인은 유지하며 병합·배포는 제외한다.
- 23:50 KST Figma 재검토에서 카드12px·전역 Remake primary600·관련 댓글 답변은 동일했다.
  00:34 PR head/자동검사와 00:39 세 PR 리뷰 스레드를 재조회해 추가 요구·미해결 의견0개를 확인했다.
- 두 전용 worktree에 잠금 버전의 독립 Ruby/gems/Pods를 준비했다.
  Office 정식 Debug arm64 빌드·iOS26.5 새 시뮬레이터 설치/실행·미인증 알림 안내 화면을 확인했다.
  Lab도 정식 Debug 빌드·iOS26.5 새 SE3 설치/실행·미인증 KO 알림 안내 화면을 확인했다.
  DeviceHub UI 연결 제한은 아래 검증 결과에서 구분한다.

- [Jira DL-16652](https://innovaid.atlassian.net/browse/DL-16652): `[FE] 기공소 환자 목록 디자인 변경`.
  확정 요구사항 본문과 fixVersion `v1.88.0`을 등록했다. 부모 DL-16596에는 댓글을 남기지 않는다.
  댓글44299에 최초 세 PR·확인 결과·검토/배포/실기QA 대기를 남겼다. status는 진행 중으로 유지해
  개발·PR 전달을 배포/QA 완료로 표시하지 않았고 본문·댓글·버전·상태 readback을 확인했다.
  23:43 댓글44302에 최신 보정·Android 실화면 결과·Office 실제 Remake 사례 미확인·STG 선배포/
  Vercel 조건을 추가했다. 부모 카드에는 쓰지 않았다.
  10월7일00:50 댓글44303에 두 앱 iOS 정식 빌드 성공·자동 제어 연결 제한·STG00:36 응답·
  외부 조건 대기를 기록했다. 댓글44302의 Office 설명은 가시 화면의 확인 범위로 정정했고
  status 진행 중/fixVersion v1.88.0 및 두 댓글 readback을 확인했다.
- 환자 목록은 웹 Lab·Lab 앱에 구현했다. 추가 구두 확정으로 **Remake 배지만 웹 전체·Lab 앱·
  Office 앱의 모든 사용처**에 적용했다. Office 환자 목록과 기존 공통 테이블은 변경하지 않았다.
- 세 제품의 독립 Git에서 commit/push와 PR 생성을 완료했다. OPEN/non-draft·MERGEABLE 및
  해당 기능 diff만 포함함을 확인했고 기능 세션에 artifact로 연결했다. 병합·배포는 하지 않았다.
- 기능 세션 `01a11038-d621-7fb3-ad4e-58d01fbb9a6a`(local), `gpt-6.1-sol / ultra`.
  결과는 이 Git 정본에 저장하며 메인세션으로 자동 진행/완료 메시지를 보내지 않는다.

| 제품 | branch / HEAD | PR / base |
| --- | --- | --- |
| 웹 | `feature/DL-16652` / `1c82980797fc0cf8e728f0aed77250e956336f8d` | [#4665](https://github.com/Innvoaid/dentlink-client/pull/4665) → `release/v1.88.0` |
| Lab 앱 | `feature/DL-16652` / `14949c6afd77530852c166b317a667f4b30dd049` | [#2](https://github.com/Innvoaid/dentlink-lab-app/pull/2) → `release/v1.0.4` |
| Office 앱 | `feature/DL-16652` / `ffcdc736a327e0fbe0293aa0d4d868ca6561b216` | [#318](https://github.com/Innvoaid/dentlink-app/pull/318) → `release/v2.2.4` |

- 사용자 재점검 지시에 따라 최신 API·Figma 댓글/속성·시트·PR을 직접 다시 확인했다.
  웹 리뷰의 자체 DOM 클래스 스타일을 styled component로 분리해 동작/수치는 보존했다.
  실제 DEV 계약과 STG 배포 전제에 답변한 리뷰 thread를 해결했고 최신 head CodeRabbit SUCCESS·
  미해결0개를 확인했다. 사람 리뷰는 REVIEW_REQUIRED이며 병합하지 않았다.
- 최신 Figma는 앱 Remake 문구도 primary600으로 바뀌어 두 앱의 공용 배지 한 속성씩 보정했다.
  18시의 앱 primary700 기록은 아래 최신 값으로 대체한다. 웹은 이미 primary600이었다.

## 사용자 확정 디자인·댓글·승인

- [Figma 기공소 Patients](https://www.figma.com/design/2OR0Gj7NUFEEeYBjQg5Y6v?node-id=325-31483&m=dev):
  웹 main `325:31918`, hover `325:32058`, row `325:29068`, header `325:32003`.
  앱 main `325:32222`의 새 카드 `395:61562`, `395:61691`, `395:62320`, `395:62507`, `395:62568`
  및 Patient set `325:26018`을 기준으로 했다. 예전 main 카드·중간 배치는 역사적 기준이다.
- 새 표/카드는 **이번 환자 화면 전용**이다. 다른 테이블/상태 UI의 전역 변경·공식 디자인시스템 편입은
  요청 범위가 아니다. Remake의 전역 변경만 사용자 구두 확정으로 추가 승인됐다.
- 환자명/생일, 전체 주문 수·우리 기공소 주문 수와 최근 주문의 상태·카테고리·담당 의사를 표시한다.
  생일이 없으면 날짜와 구분선을 숨긴다. 항목 선택은 `recentOrderId`로 이동하며 ID가 없으면 이동하지 않는다.
- 앱 정보는 왼쪽4×64px 선과 환자·치과·두 주문 수의3줄이다. 총 수 mono800/우리 수 primary600 bold14.
  최근 주문 header 오른쪽 Remake, 본문 상태·카테고리·담당 의사3줄로 최종 배치를 반영했다.
- 카드 width343 기준/padding14/radius12/카드 간 gap14/**내부 gap12**/높이248px,
  최근 주문 section radius8/header padding12 12 8/body padding10 12/gap6, pressed primary100.
  기본·긴 문구·생일 없음·눌림에 gap12을 적용해 누를 때 크기가 변하지 않는다.
- 웹 열260/250/120/130/KO150/240/240+남는 공간, EN 상태200. 행70/header35+34/상태23/Remake21,
  footer64/검색 offset44/표시 개수 body1 16·icon18, 생일 없음·긴 문구·hover·가로 스크롤을 맞췄다.
  main/hover 문구 충돌은 main을 기준으로 두고 hover 때 문구 변경 동작을 만들지 않았다.
- 실제 원본 SVG 형상을 대조했다. 웹 local SVG5개와 일치하는 기존 아이콘, Lab 원본 SVG8개와
  화면 local adapter를 사용한다. 완료/제작 대기 등의 fractional root·회전·색을 보존했다.
- Remake는 배경/테두리/여백 없는 reset16+문구14/21+gap4다. **웹·두 앱 text/icon 모두 primary600**이다.
  23:09 KST 원본에서 Default/Pressed/Long/Short/main의 문구가 #8D6EFF로 일치하고 기본형 내부
  간격도12로 수정됐음을 확인했다. 회차 선택 탭·버튼·필터·인쇄 설명은 배지가 아니므로 제외했다.
- IN_PROGRESS일 때만 DESIGN/READY_FOR_FABRICATION/IN_FABRICATION 상세 상태를 적용하고
  Remake는 `isRemake`로 독립 표시한다. detailStatus의 REMAKE만으로 배지를 추론하지 않는다.
- 관련 Figma 댓글 #15~#19와 작업 댓글을 읽기 전용 검토했다. #15 최근 주문 이동, #16 우리 기공소의
  최근 접수 주문, #17 취소 표시·Remake 병행을 확인했다. 스캐너 임시 주문 제외 정책 답변은 없어
  프런트에서 제외 필터를 만들지 않았다. 댓글 작성/해결은 하지 않았다.
- [#18](https://www.figma.com/design/2OR0Gj7NUFEEeYBjQg5Y6v?node-id=325-31918&m=dev#1954124763)의
  전역 Remake와 #19 gap8/12는 이후 사용자가 구두 답변으로 **모든 사용처·12px**를 확정했다.
  서면 답변 대기 상태를 유지하지 않는다. 반복되는 최종 값을 우선하는 원칙과 작은 모호함을
  자율 처리한 뒤 모아서 설명하는 선호를 `DEVELOPMENT_STYLE.md`에 저장했다.
- 23시 댓글 재검토에서 #18 디자이너 답변은 모든 사용처를 재확인했고 #19는 답글 없이 원본12px가
  반영됐다. 새 #20 Member/담당 의사 권한 질문은 다른 작업 범위여서 환자 디자인 변경에 추가하지 않았다.
- 최초4시간 후 확인 heartbeat `dl-16652-4`는 취소 지시로 **PAUSED**다. STG Swagger 재조회도 제외했다.
- 웹 commit/push·메모리·Jira·release PR과 앱 commit/push 승인 뒤 사용자가 **앱도 PR 생성**으로
  확대했다. merge·배포·환경/서명 변경은 승인 범위가 아니다.

## API 확인 — DEV 2026-10-06 23:03~04·STG 2026-10-07 00:36 KST

- DEV Swagger HTTP200, 실제 인증 `/lab/patients/consolidate` HTTP200/code0000·763행에서 새12필드를
  확인했다. endpoint는 유지한다. `officeId`, `officeName`, `patientName`, `birthDate`, `totalOrderCount`,
  `labOrderCount`, `recentOrderId`, `recentOrderStatus`, `recentOrderDetailStatus`, `recentCategoryName`,
  `recentDentistName`, `isRemake`다.
- 전체 주문 수는 타기공소 포함, 우리 주문 수는 해당 Lab만이며 DRAFT·DELETED 제외 설명은 주문 수에만
  있다. 최근 주문 제외 정책으로 확대 해석하지 않는다. 실제 birthDate null(DEV57/STG66)도 숨김 처리했다.
- STG **실제 인증 endpoint** HTTP200·686행은 이전10필드·orderId/케이스 계약이며 새7필드가 없다.
  배포 완료로 보고하지 않는다. 이전 필드를 임의 fallback하지 않았다. STG Swagger는 재조회하지 않았다.
  2026-10-07 00:36:55 KST 실제 endpoint 한 번 재확인에서도 HTTP200/code0000·686행,
  old orderId686행·새7필드 각0행/new7Complete0행으로 동일했다. Swagger/DEV 재조회는 하지 않았다.
- DEV recentOrderId는763행 모두 양수/nonnull이고 이전orderId는0행이다. 새7필드는 전체 행에
  존재하며 null이 없다. DEV Swagger의 DTO12필드·상태/상세 enum·응답 alias와 생성 선언이 일치한다.
  **STG/운영 새 API 선배포 및 실제 응답 검증 후 UI를 배포해야 한다.** PR 본문과
  [리뷰 답변](https://github.com/Innvoaid/dentlink-client/pull/4665#discussion_r4196245137)에 남겼다.
- 공식 Swagger generator 임시 생성 결과에서 해당 Lab 선언/alias만 자동 추출했다.
  Office/Admin 기존 DTO 및 release의 무관한 생성 선언을 보존했다.

## 번역 시트와 생성 파일

- 웹 [i18n 시트](https://docs.google.com/spreadsheets/d/1iuncwk8EIi8ycbc36a0dMn-ZkxaqqMHy1jvyT6ubpq0):
  양 영역1591~1600행에 patients fields7+status3을 등록했다. 환자 화면의 검토중/디자인 진행중 문구를
  분리했다. 기존 PM 값·수식·서식·검증은 보존했고 bounded readback 및 en/ko patients 생성 일치를 확인했다.
- 전체 `pnpm check:i18n`은 **기존 en/ko orders.json만 stale**로 실패한다. 환자 리소스는 일치한다.
  기존 제작 자동 진행 문구 차이·사용 중 orders.filters.category 시트 누락은 다른 작업이므로
  기존 행/키를 삭제·덮어써 이번 검사를 억지로 통과시키지 않았다.
- Lab [앱 번역 시트](https://docs.google.com/spreadsheets/d/1ZnPl5a3P3dKtxDTadLX56aTmuJ58TrpZiRcXDexdLbw):
  양 영역314~319행에 총/우리 주문 수·우리 최근 주문·담당 의사·디자인 진행중·카테고리6개 등록.
  기존1~313행·PM 확인자·요청/개발 상태를 보존했다. 사용자 확정 Figma 문구 승인 근거를 사용하되
  PM 이름은 만들지 않았다. live connector readback→CSV snapshot→공식 generator로 en/ko/registry 생성,
  로컬 snapshot의283문구 검사는 통과했다.
- 기존 Category 미확인 행과 Design in Progress 기존 번역은 유지하고 신규 영문은 Order Category,
  Design In Progress로 구분했다. t() 문구는 스캐너가 놓쳐 직접 대조·등록했다.
- live `yarn i18n:check`는 ADC `403 ACCESS_TOKEN_SCOPE_INSUFFICIENT`로 읽기 단계에서 실패했다.
  CLI 검사가 통과했다고 보고하지 않는다. connector의 실제 시트 등록·readback은 완료했다.
- 23시 connector bounded readback에서 웹10개/앱6개의 en/ko 값이 생성 리소스와 정확히 일치했다.
  읽기 전용 CLI GET도 403 scope 부족을 재현했다. 인증 scope를 변경하거나 재로그인하지 않았다.
- Office는 기존 Remake 문구/registry/ko 리소스를 사용하므로 신규 번역 행이 없다.

## 작업 공간·커밋

- 웹 `/Users/parkjongsun/Repository/dentlink-client-patient-list`, base origin/master `6b79c9756`.
  공용 Remake `51f891f93` + 환자/API/i18n `b29821879` + pagination 스타일 분리 `1c8298079`,3커밋·14파일.
  PR은 release `faaa1498189e3e584cfc6fce215ce97feca156f7`을 향한 해당14파일만 포함한다.
- Lab `/Users/parkjongsun/Repository/dentlink-lab-app-patient-list`, base origin/develop `f33283339`.
  공용 Remake `0b7a94a288bcc1bdfbc26c1be3a2c4f9fff9cd8e` + 환자/API/i18n `5debbe0` +
  최종 색상 `4f4e9c1` + 실제 기기 주문수 배치 보정 `14949c6`,4커밋·19파일.
- Office `/Users/parkjongsun/Repository/dentlink-app-patient-remake`, base origin/develop
  `52966b80f7b5fae20b14ad530f2ae7e0ce79a1d3`. `ed604e6` + 최종 색상 `ffcdc73`,
  2커밋·3파일(공통 배지·16원본SVG·자동export).
- 각 HEAD·원격 SHA 일치/clean을 확인했다. 기존 main·권한관리·가드·DLDS checkout은 보존했다.
  앱 feature→develop 규칙 및 각 release 통합 상태를 확인했다. 웹 일정이 앱 base를 바꾸지 않는다.

## 검증 이력·한계 — 2026-10-06~07

- 웹 Lab·Clinic·Admin 타입 및3커밋의 필수 pre-commit 검사 통과. Clinic ignored next-env는
  표준 next typegen으로 준비했고 tracked 설정 변경은 없다. 변경 lint 오류0/기존 any경고1·Prettier·diff 통과.
- 필수 push hook 전체 제품 lint는 기존 warnings/오류0, config21+hook24 테스트 통과.
  baseline 누락으로 최초 push 중단 후 검사 패키지가 origin/master와 동일함을 확인해 공식
  coverage:baseline으로 ignored 로컬 기준을 생성했다. delta0·재검사/push 성공, hook bypass 없음.
- 최종 synthetic11상태:70px행, 상세 gating/isRemake, 누락 생일/ID·0건·긴 문구, 검색 초기화·페이지·
  표시 개수·키보드 이동·1100px 스크롤·EN geometry 통과. count null/undefined는 소스 ?? 확인,
  fixture count는0건이다. 실제 DEV10행은7표시 필드를 응답과 대조했고 상태/detail/ID/DOB는 synthetic으로 보완했다.
  pageerror0은 console warning0을 뜻하지 않으며 정식 staging 전체 E2E 판정은 아니다.
- Remake default/dark/desktop/mobile/shipping5맥락은 임시 페이지의 실제 컴포넌트 측정이다.
  업무 화면 전체 이동 QA가 아니다. Remake21/icon16/gap4·다른 상태25 유지 확인.
  독립 read-only 리뷰에서 웹14파일의 추가 확정 결함·요구 누락은 발견되지 않았다.
- Lab renderer10·변경 lint/Prettier/diff·최신 Android Metro bundle 통과. type4오류는 기준/최종
  SHA 동일(Icon2/Tooltip1/MessageText1), 신규0. fresh Android36 AVD5580으로 이전 system timeout을
  해소했고 기존 development APK+최신Metro8088에서 정상 로그인·실제 DEV10행/전체763명·검색1행·
  recentOrderId 기반 OrderDetailScreen/WebView 주문 상세 로딩을 확인했다.
- 실제375dp 화면에서 주문수 라벨 두줄로 높이가 늘어나는 결함을 찾아 환자 전용 배치를 보정했다.
  KO14px/21dp 한줄·카드343×248·목록gap14를 확인했고 EN/양쪽9자리 fixture는 라벨만말줄임,
  숫자153px 자연폭 보존/카드 내부 오른쪽 경계690px를 확인했다. 공용 Typography/API는 그대로다.
  실제 데이터 QA와 긴문구/EN/Remake 등의 기기 합성 fixture를 구분하며 독립 리뷰에서 추가 확정
  결함은 없었다. 최종 native APK 재빌드나 실물 iOS/기기 전체 QA 완료로 표현하지 않는다.
- 10월7일 Lab canonical immutable JS deps·Ruby3.4.10/Bundler2.6.9/CocoaPods1.16.2를 독립 준비하고
  `pod install --deployment --repo-update`로124dependencies/163Pods를 설치했다. 공식 index/cache만
  준비했으며 source/7개 config/lock hash 불변·Podfile.lock=Manifest.lock byte동일이다.
  정식 DentlinkLabDevelopment Debug generic simulator 빌드가 성공했다(1.0.4/151·arm64+x86_64).
  신규 SE3/iOS26.5에
  boot/install/launch·표준 RCT_jsLocation localhost:8088/최신 Metro·미인증 KO 알림 안내 렌더를
  확인했다(750×1334px/375×667pt). iOS 실제 환자·검색·이동/합성 카드 UI는 미검증이다.
  이미 확인된 DeviceHub 연결 실패를 반복하거나 비공식 입력/인증 주입을 하지 않았다.
  own app/Metro8088/새 sim을 정리하고 본인 생성 root.env만 원복했다. HEAD14949c6 clean/원격 동일하다.
  PR2 본문에 native 성공/로그인 이후 UI 미검증을 반영하고 readback·develop/OPEN/MERGEABLE/CLEAN·
  자동 검사 SUCCESS·artifact 연결을 확인했다. 추가 제품 커밋은 필요하지 않았다.
- Office renderer3·lint0/Prettier/diff·Android/iOS Metro bundle 통과. 최초 shared deps의 type18오류는
  기준/최종 byte동일이었다. 실제 실행 조사에서 설치 Datadog2.14.8과 manifest3.7.0 불일치를 확인해
  own worktree에 immutable 의존성을 설치하고 primary 공유 deps·제품 설정을 보존했다.
  새 deps Datadog3.7.0/RN0.82.1에서 기준/최종 타입6개 byte동일·신규0, renderer3/lint0 재검증 통과다.
  정상 개발APK2.2.4/code134 재빌드·AVD5582 설치 후 표준index.bundle으로 로그인 화면을 확인했다.
  이전APK의 apps/office/index.bundle404·낡은deps의 Datadog 오류는 최신 정상 환경에서 해소됐다.
- Office 실제 로그인·Home·주문 목록5회 scroll까지 정상, 가시Remake0여서 실제 주문의 새 배지
  표시 자체는 미검증이다. renderer3/3과 Lab 기기 합성 배지 검증을 Office 실제 사례로 바꾸어
  표현하지 않는다. 10월6일 새 deps iOS Metro bundle exit0/75assets를 확인했고,
  아래10월7일 정식 native build/startup 결과와 구분한다. 실물/로그인 이후 iOS UI·배포는 미실행이다.
- 10월7일 Office canonical Pods 설치·정식 DentlinkDevelopment Debug arm64 빌드가 성공했다.
  iOS26.5 own iPhone16에 2.2.4(151)을 설치/실행하고 표준 Metro8090 bundle 오류0,
  미인증 EN 알림 안내 화면 렌더를 공식 simctl screenshot으로 확인했다. 로그인 이후 UI는 미검증이다.
  현재 Xcode27은 DeviceHub(com.apple.dt.Devices)를 사용한다. Cua 공식 앱 경로 선택35초 timeout,
  running bundle ID 재선택5초 timeout/window0이며 공식 simctl io에는 tap/type 기능이 없다.
  비공식 HID·추가 UI 라이브러리·SDK/설정 패치 없이 현재 도구로 로그인 진행은 불가하다.
  authstore notfound/loggedIn false여서 iOS QA group binding·실제 Office Remake도 미확인이다.
  등록된 실물 iPhone2대는 tunnel disconnected/shutdown이라 연결된 물리 기기0대다.
- Office의 정상 Pods/build가 생성한 pbxproj와 원래 없던 ignored root.env만 원복했다.
  own iOS sim 삭제·Metro8090 종료/포트 free, 원본 env/lock/설정 불변·ffcdc73 clean/원격 동일이다.
  PR318 본문에 native 성공과 UI 제한을 반영/readback했으며 미해결 리뷰0개·실제 CodeRabbit skip이다.
- 앱 PR 자동 제목/본문/라벨 검사는 성공. 웹 Vercel은 **작성자 jongsunP의 innovaid 팀 접근 확인**으로
  차단됐다([봇 댓글](https://github.com/Innvoaid/dentlink-client/pull/4665#issuecomment-6013252346)).
  실제 팀 미가입인지 GitHub 계정 연결 미인식인지는 미확인이다. 코드 빌드 실패로 단정하지 않는다.
  접근 신청·프로젝트 설정·배포 재시도는 하지 않았다. 최신 웹 head도23:05 Vercel
  `Deployment was blocked`다. 최신 상세 원인은 인증 없이 확인할 수 없었으며 기존 팀 접근/계정
  연결 안내와 같은 원인이라고 단정하지 않는다. 웹 CodeRabbit은 최신 head23:12 SUCCESS·
  미해결0개다. Office CodeRabbit SUCCESS는 develop 자동 리뷰 제외에 따른 skip이며 실제 리뷰
  완료로 해석하지 않는다. 앱 자동 라벨은 최신 head 성공이다.

## 이전 전달의 다음 시작점·보존 — 최신 PR 구성은 문서 맨 위 참조

- 4시간 예약 재확인은 취소됐다. 사용자가 재개하면 세 PR/head/CI를 live 확인하고 요청된 디자인
  수정에 대응한다. STG/운영 새 계약 선배포 후 실제 통합 연동, Office 실제 Remake 사례,
  실물 기기/배포 바이너리 및 웹 Vercel 프리뷰 접근 확인이 남는다. 완료된 Android 실행과 Lab iOS
  목록/검색/최근 주문 이동은 다시 미완료로 되돌리지 않는다. 웹은 사람 승인 완료/현재 Draft이며
  임의 해제하지 않는다. 앱 사람 검토와 병합/배포는 별도 승인·전제 확인 단계다.
- 기존 orders 번역 차이와 ADC scope는 별도 기존 문구/인증 문제다. 신규 기능의 시트 등록을
  다시 미완료로 되돌리지 않는다. 다른 작업/PM 원문을 확인해 처리한다.
- 직접 처리 가능한 리뷰·최신 디자인·이 화면의 실제 실행 결함은 승인 범위에서 수정한다.
  STG/운영 backend 선배포, Vercel 팀 접근/계정 연결, ADC scope 변경은 외부 담당/계정 조치가 필요하다.
  기존 앱 타입 오류·다른 기능 orders 시트 차이는 기술적 불가능이 아니라 이번 작업 범위 밖이다.
  미검증 runtime과 실제 실패한 CLI 검사를 완료라고 표현하지 않는다.
- 10월 8일 DeviceHub 정상 입력 회복 뒤 Lab iOS 실제 흐름과 합성 카드 QA를 추가 확인했다.
  Office iOS는 정상 로그인·QA 지정 그룹/홈/가시 주문 목록까지 확인했다. 실제 Remake 사례는 미검증이다.
  Mac Cua에는 누름 유지 중 별도 관찰을 보장하는 공식 API 근거가 없어 iOS held-pressed는 미검증이다.
  ClickOptions.durationMs의 누름 유지 설명은 Linux에만 명시되며 Mac 전체 불가능으로 단정하지 않는다. 웹 내부 상세 조작·
  실물 기기는 완료된 확인 범위와 구분한다. 추가 제품 결함이 없으면 새 코드 커밋을 만들지 않는다.
  외부 API 선배포/프리뷰 접근·사람 검토와 별도 병합/배포 승인 전에는 예약 작업을 만들지 않고 대기한다.
- 자료는 현재 기기 `/Users/parkjongsun/.codex/visualizations/2026/10/06/01a11038-d621-7fb3-ad4e-58d01fbb9a6a/DL-16652/`
  의 final-review/final-delivery/current-review에 원본 캡처·합성 화면·집계·검사 로그로 보존했다. 실환자 화면/토큰/
  비밀번호를 Git에 저장하지 않는다. local-only 자료이며 Git 정본은 결과·링크·다음 시작점을 전달한다.
- Root QA Next3007·Lab8088/AVD5580·Office8090/AVD5582를 종료했다. 두 임시 AVD userdata는
  삭제했고 기존 adb 서버·다른 세션 runtime·primary 공유 의존성은 보존했다. Office own node_modules는
  manifest/lock과 맞는 독립 설치다. 실제 데이터 캡처/XML은 삭제했고 보존한 앱 화면은 합성 자료다.
- 10월7일 두 own iOS sim·Metro8088/8090도 정리했다. 기존 simulator/adb/shared deps/DeviceHub·
  CoreSimulator service는 보존했다. 두 앱 iOS startup 캡처는 인증 전 공개 안내 화면이며 PHI가 없다.
  보존한 iOS build log는 env dictionary를 가리고 민감 env값 잔존0을 내부 확인한 것이다.
- 10월 8일 두 own iOS sim/Metro8088·8090/root.env도 정리했다. Lab fixture·ko를 원복했고 source clean을
  확인했다. current-review의 20261008 증거는 공개 Figma·합성 Lab 화면·API/번역/PR 집계·safe report다.
  실제 환자 화면/AX 원문/토큰/credential/서버 원응답은 보존하지 않는다. 현재 실물 기기 QA는 수행하지 않았다.
