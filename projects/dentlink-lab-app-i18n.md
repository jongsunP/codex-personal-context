# Dentlink Lab 앱 번역 지침 전달

## 현재 전달 — 2026-10-08 최신 릴리스 충돌 해결

- 최신 release/v1.0.4@96cc94a0의 src 단독 구조에 기존 PR #5를 동기화·일반 push했다.
  HEAD9e04b395275a870bf3bf74b42c155eafb9f41d89, 부모2fb6e8b+96cc94a0,
  feature/lab-i18n-workflow-release·기존 i18n-release worktree clean·원격0/0다.
- 실제 전체diff AGENTS·CLAUDE·README 문서3개(+72/-3)이며 최신 src/configs/i18n과
  src scanner·i18n:optional 경로/실행방식을 반영했다. 밀링/분리 코드·리소스·시트는 변경하지 않았다.
- README/변경구간 format·명령/경로/CSV/optional 대조·diff PASS. AGENTS/CLAUDE 전체format은
  release에도 있는 기존 불일치라 전체재포맷하지 않았다. 생성·시트쓰기·앱빌드·OTA·PRmerge는미실행이다.
- live OPEN/non-Draft/MERGEABLE/CLEAN, release/v1.0.4@96cc94a0 대상이다.
  미해결0·pending0·사람승인0·autoMergeRequest=null, 라벨 자동화 COMPLETED/SKIPPED다.
  본문도 최신 범위로 갱신했다. 기능 #6과 모의통합 충돌0이며 독립이므로 필수순서가 없다.
- 다음 시작점은 현재 #5 HEAD/base 확인이다. 옛 #3/#4는 닫힌 이력이며 다시 반영하지 않는다.

## 이전 전달 — 2026-10-08 분리 전 릴리스에서 문서만 옮긴 PR #5

- 사용자 앱 PR 전체 정리 지시로 기존 #3의 분리·타기능 이력을 제거한 새
  [PR #5](https://github.com/Innvoaid/dentlink-lab-app/pull/5)를 만들고 #3을 CLOSED/미병합 처리했다.
  대체 링크를 남겼으며 기존 branch/default checkout은 복구용으로 보존했다.
- 기준 `origin/release/v1.0.4 / cb585775ca21e27949e67758a5933139cfc567d8`, 새 branch
  `feature/lab-i18n-workflow-release / 2fb6e8b3a0840255796b29ad5000cbabfc8a71b3`이다.
  worktree `/Users/parkjongsun/Repository/dentlink-lab-app-i18n-release`, clean·원격0/0, 1커밋이다.
  커밋 제목은 `docs: Lab 번역과 운영 시트 기본 작업 지침 추가`다.
- 실제 전체 diff는 **AGENTS.md·CLAUDE.md·README.md 문서3개(+86/-1)**다.
  기존 릴리스의 `shared/configs/i18n`, scanner `apps/lab/src`·`shared` 및 실제 명령을 사용한다.
  새 기능PR #6과 독립적으로 적용 가능하며 foundation/저장소분리/다른기능 변경을 포함하지 않는다.
- 문서 변경구간 format·diff·실제 명령/경로/CSV 대조 및 독립 검토 PASS. 전체문서 format은
  기준과 최종 모두 같은 기존3파일 실패여서 전체 통과로 보고하지 않는다.
  번역 문구·실제Sheet·생성리소스·앱실행/native/OTA는 변경하거나 수행하지 않았다.
- 자동화 완료 후 OPEN/non-Draft/MERGEABLE/CLEAN, base `release/v1.0.4`, 전체3파일·HEAD를 확인했다.
  title/body SUCCESS·label SKIPPED·검사pending/미해결0·autoMergeRequest=null, PR artifact 연결 완료다.
  실제 merge/배포는 하지 않았다. 다음 시작점은 #5 현재 리뷰/HEAD/base 확인이며 옛 #3/#4 반영이 아니다.

## 이전 확인 — 2026-10-08 분리 이력으로 diff 확대 (새 #5로 대체)

- 사용자 앱 release 정책 확인 중 live [PR #3](https://github.com/Innvoaid/dentlink-lab-app/pull/3)을 재조회했다.
  현재 base는 `release/v1.0.4`, HEAD `5844ba5348901aa435ef522e47f5f1d91e00de86`, OPEN·non-Draft·MERGEABLE/CLEAN이다.
  아래 develop 대상 기록은 최초 생성 당시 이력이다. 이번 조사에서 PR base나 제품 코드는 변경하지 않았다.
- release HEAD `cb585775ca21e27949e67758a5933139cfc567d8`는 분리 이전 monorepo 트리다.
  현재 main/develop `f33283339d339b3c6d39fe2735a8420f2c1a5ae1`의 분리·기존 수정 6커밋이 release에 없다.
- 따라서 PR 전체 diff는 **981파일·7커밋·+2740/-39781**이며, 아래 개별 문서 커밋의 3파일과 다르다.
  저장소 분리·기존 DL-16548/DL-16556 변경이 함께 포함돼 ‘문서 3개만 머지하는 PR’으로 보고하지 않는다.
  #2도 같은 release 대상으로 991파일·10커밋이다. release 선행 통합과 의도한 전달 범위를 별도 판단해야 한다.
- 새 [앱 공통 지침](dentlink-app-onboarding.md)에 기존 최신 유효 release·CodePush/바이너리·태그/실제 배포,
  자동화 후 실제 base/diff 확인을 저장했다. 이번 정책 정리에서 재베이스·통합·머지·배포는 수행하지 않았다.
- 다음 시작점: 사용자/앱 개발자의 release 분리 반영 계획과 두 PR 전체 diff를 대조하고 선행 통합 방식을 확정한다.
  리뷰 성공·MERGEABLE만으로 위 범위 문제를 완료 처리하지 않는다. 원격 feature와 현재 checkout은 보존한다.

## 프로젝트 지침 최초 반영 이력 — 2026-10-08

- 사용자가 웹 PR #4666과 같은 기본 작업 지침을 Lab 앱 프로젝트에도 반영하도록 승인했다.
  FE 메인세션이 직접 처리하며 Office 앱·웹 제품 코드는 이번 작업 범위가 아니다.
- 저장소: `/Users/parkjongsun/Repository/dentlink-lab-app`, 원격 `Innvoaid/dentlink-lab-app`.
  최신 `origin/develop`과 `origin/main`은 `f33283339d339b3c6d39fe2735a8420f2c1a5ae1`로 같았다.
  기존 clean 기본 checkout에 `feature/lab-i18n-workflow`를 준비했으며 새 폴더·worktree는 만들지 않았다.
  환자목록 worktree와 그 세션의 변경은 보존했다.
- 커밋 `5844ba5348901aa435ef522e47f5f1d91e00de86`
  (`docs: Lab 번역과 스프레드시트 기본 작업 지침 추가`), 원격 feature와 0/0·clean.
- [앱 PR #3](https://github.com/Innvoaid/dentlink-lab-app/pull/3):
  최초 생성 시 `feature/lab-i18n-workflow` → `develop`, OPEN·non-Draft·MERGEABLE/CLEAN.
  자동 제목·본문·라벨 검사 3개 SUCCESS, 사람 리뷰·merge·배포는 아직 하지 않았다.
  웹 `release/v1.88.0`이나 PR #4666과 앱 전달 브랜치를 혼용하지 않는다.
- 팀 정본은 앱 `README.md`의 **번역 동기화 (Lab)**이다. `AGENTS.md`·`CLAUDE.md`가
  승인된 정적 문구·번역 호출·키·리소스 변경 시 i18n·앱 운영 Sheet·검증을
  별도 요청 없이 기본 작업 범위로 포함하도록 연결한다.
- 기존 생성 파일 변경 금지에는 승인된 Lab 문구·i18n 작업의 생성 번역 파일 예외를 명시했다.
  앱 시트·명령, 스캐너의 HEAD 대비 미커밋 변경 제한, PM 확인·부분 실패·범위 밖 변경 보존을 설명했다.
  등록 단계와 생성 단계별로 최초 조회 전부터 재조회 검증·복구까지 편집을 멈추고,
  등록 검증 후에는 중지를 해제해 PM 검토를 진행한다. 생성 단계 시작 전에 다시 편집을 멈춘다.
- `yarn i18n`도 시트의 빈 행 삭제·수정요청·검수 상태 갱신을 하므로 전체 쓰기 범위를 먼저 확인한다.
  범위 밖 변경이 있으면 대상 셀 처리 또는 두 탭의 최신 전체 스냅샷·PM 확인 열을 보존한
  로컬 CSV 생성으로 분리하며, 시트 반영·PM 확인을 완료한 것으로 간주하지 않는다.
- 변경은 안내 문서 3개, +71/-3이다. 실제 번역 문구·시트·생성 리소스·앱 실행 코드는 변경하지 않았다.
- 검증: 변경 문서 구간의 Prettier 포맷, 실제 package 명령·스크립트·생성 파일 경로와 CSV 입력명,
  `git diff --check`, 독립 문서 리뷰와 수정 반영, PR 본문·파일 범위 read-back.
  전체 문서 Prettier 검사는 기준/최종 모두 같은 3개 파일의 기존 포맷 불일치로 실패했다.
  문서 작업이므로 번역 쓰기 명령·앱 실행·네이티브 빌드는 수행하지 않았다.
- 기존 [Lab 앱 정본](dentlink-lab-app.md)은 앱의 제품 경계·기능 상태·번역 절차를 담는다.
  그 파일의 다른 세션 미커밋 변경은 이번 기록에서 수정·스테이징·커밋하지 않았다.
- 최초 인계의 다음 시작점은 PR #3 최신 HEAD·리뷰·merge 확인이었다. 이 순서는 현재 #5로 대체됐다.
  앱 신규 문구 작업에서는 feature를 보존하며,
  개인 컨텍스트뿐 아니라 작업 branch의 팀 번역 지침도 읽는다.
