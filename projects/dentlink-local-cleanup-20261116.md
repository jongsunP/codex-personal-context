# Dentlink 로컬 브랜치·워크트리 정리 — 2026-11-16
## 완료와 범위

- 사용자가 확인 후 가능한 로컬 항목 정리를 승인했다. **로컬 브랜치 28개, 연결 worktree 4개를 삭제**했다. 원격 branch/tag/PR, 제품 코드, 현재 checkout, stash, 기존 복구 자료, 실행 중 서비스, 사용자 세션은 변경하지 않았다.
- 삭제 전 clean/미추적 파일, 실제 원격 SHA, PR squash 결과·tree/patch 동등성, 과거 배포 또는 완료된 임시 통합 여부를 확인했다. 각 저장소 Git 공통 디렉터리에 검증한 증분 bundle과 삭제 전 SHA manifest를 남겼다.
- 최종 확인은 네 저장소의 로컬 branch·worktree 목록과 각 기본 checkout clean 상태다. 새 기능 검증이나 배포 실행을 한 것은 아니다.
- **최종 사용자 지시:** 알림센터용 또는 진행 중인 다른 세션 소유는 그대로 둔다. 따라서 `feat/DL-17058-develop` 및 알림센터 임시 DEV worktree는 삭제하지 않았다. 다른 세션 소유라 attach 도구가 거절했으며 이후 사용자 지시에 따라 그 세션에 정리 요청도 보내지 않았다.

| 저장소 | 삭제한 로컬 브랜치 | 삭제한 worktree | 남은 로컬 브랜치 | 남은 worktree |
| --- | ---: | ---: | ---: | ---: |
| Web/Admin | 15 | 4 | 6 | 4 |
| Office 앱 | 8 | 0 | 4 | 2 |
| Lab 앱 | 4 | 0 | 7 | 1 |
| Studio | 1 | 0 | 2 | 1 |

## 삭제한 worktree

- `/Users/parkjongsun/Repository/dentlink-client-dl-14899`
- `/Users/parkjongsun/Repository/dentlink-client-dl-17101`
- `/Users/parkjongsun/Repository/dentlink-client-dl-17101-develop`
- `/Users/parkjongsun/Repository/dentlink-client-dlds`

DLDS는 담당 디자인시스템정비세션이 보관 불필요를 확인한 detached `c597f1fb3` 준비용 사본이다. 수정/미추적/ignored/고유 커밋이 없으며 Studio는 이 경로에 의존하지 않는다. 다른 삭제 사본의 ignored 항목은 의존성·빌드/테스트 산출물 및 로컬 env 사본이었다. 필요한 env 파일명은 기본 worktree에도 존재함을 확인했으며 값은 열람·변경하거나 별도 백업하지 않았다.

## 보존한 작업

- 웹: `master`, 현재 `release/v1.94.0`, 원본 알림센터 `feature/DL-17058`, 마케팅 동의 `feat/DL-17231`, LBX `feature/DL-16387`, 알림센터 임시 DEV `feat/DL-17058-develop`.
- Office: `main`, `release/v2.2.5`, 원본 알림센터 `feature/DL-17059`, 마케팅 동의 `feat/DL-17423`.
- Lab: `main`, `release/v1.0.6`, 원본 알림센터 `feature/DL-17060`; 추가로 `feat/DL-17262`, `feat/DL-17262-api-cleanup`, `feat/DL-17310`, `release/v1.0.5` 보존. 뒤의 4개는 main 병합은 확인했으나 실제 Production CodePush의 정확한 소스/패키지 대조가 부족하므로 삭제하지 않았다.
- Studio: `main`, 현재 `feat/DL-17046-gallery-examples`, 미병합 PR #62, 저장소와 기존 복구 자료 유지.
- 기본 checkout은 웹 `release/v1.94.0@32853e794`, Office `feature/DL-17059@91b8531b`, Lab `feature/DL-17060@cfa1022406`, Studio `feat/DL-17046-gallery-examples@c804254` 그대로다. 이 정리는 branch pull/전환이나 신규 작업 재개가 아니다.

## 판정 근거

- 웹 제품 변경은 각 PR의 squash 결과와 변경 파일이 동일하고 Production `v1.92.0@194869637`에 포함됨을 확인했다. 성공한 배포: [Clinic 42592263606](https://github.com/Innvoaid/dentlink-client/actions/runs/42592263606), [Lab 42592420900](https://github.com/Innvoaid/dentlink-client/actions/runs/42592420900), [Admin 42592489912](https://github.com/Innvoaid/dentlink-client/actions/runs/42592489912). `release/v1.92.0` 로컬에는 원격에 없는 고유 커밋이 없었다.
- 웹 예전 develop 통합 3개는 당시 PR 병합 tree와 동일한 완료 사본이다. develop이 이후 재생성되어 현재 조상 관계만으로는 판단하지 않았다. LBX stage 파생 2개는 보존한 원본 `feature/DL-16387@04934b153`에 제품 변경이 남아 있다. 미출시 원본 LBX는 삭제하지 않았다.
- Office: 권한 QA PR #329/#331/#332/#333의 Production v84 기록, 지연 라벨/상태 PR #340/#342/#343의 Production v87 소스 `caa7ed68` 기록 및 main 병합·tree/patch를 확인했다. 태그 CI PR #345는 main 반영 완료이며 별도 앱 런타임 배포 대상이 아니다.
- Lab: QA PR #19/#21/#23은 Production v17 기록 및 main 반영을 확인했다. 태그 CI PR #41은 main 반영 완료다. 불확실한 후속 4개는 보존했다.
- Studio: 원본 PR #56은 closed지만 대체 PR #60으로 반영됐다. 로컬 커밋과 main의 대응 커밋 patch-id 및 Production 배포 `7818134281` 성공을 확인했다.

## 삭제한 로컬 브랜치와 삭제 전 SHA

### Web/Admin

| 브랜치 | 삭제 전 SHA |
| --- | --- |
| `feat/DL-17141` | `488575e8fb53fd85d31efa58dc2828d1948e8244` |
| `feat/DL-17141-delay-cleanup` | `a4f70d33c5d4fb61767512530c8783067132d7e7` |
| `feat/DL-17141-delay-label` | `0b01b1427ca92f64515e86fc3d09b81063eead71` |
| `feat/DL-17309` | `9c6b411bcf9c226e66e13ce1da32ef7ada0114a0` |
| `feat/e2e-deploy-status` | `65dd71ddf7da0d275da34eddc1e90f3a56a58acb` |
| `feature/DL-14899` | `6996623ddfe7d558c479aae1cde61bfd1de11da2` |
| `feature/DL-16387-stage-20261103` | `d7d31e4b0bc7be61e4ed3708ef2f66a89cb62219` |
| `feature/DL-16387-stage-offices-20261030` | `3617d914654863776af4f3a1b8533f02e944bd0d` |
| `feature/DL-17011` | `9dcb644d566cee06fa0019c16b7f47cdf10e8d36` |
| `feature/DL-17101` | `a7aa540a268d63b5d9fafc13e4b3d7f85d499c1b` |
| `feature/DL-17101-common-print-develop` | `46bb74fd65dc7409be5541e15d625f48108c9d28` |
| `feature/DL-17101-develop` | `8ee2b9ec76faf84aa406b8be2ee14dc67e097ae5` |
| `feature/DL-17101-print-settings-develop` | `9e64614a88483113a97156facba4c155910739aa` |
| `feature/DL-17125` | `e8e15ed66629f3aa389e484215116ed90fa21f13` |
| `release/v1.92.0` | `c7e7c130d154bde49a465a4740c60374d5dc2265` |

### Office 앱

| 브랜치 | 삭제 전 SHA |
| --- | --- |
| `feature/DL-16317` | `f037c80153b328bbb14fcafd5fb756a59fd4cc8e` |
| `feature/DL-16317-qa` | `1fa59edf58f8d2dc8fc4ac8af17a9016be3a6149` |
| `feature/DL-16927` | `b2e29d324ce95ae27c61dfa9fee3b5abe6bb9134` |
| `feature/DL-16929` | `e4fb1aca264e14987acac8f1752d52ad9ed54e68` |
| `feat/DL-17248` | `7f325896e3ed0a862a7f8a2099d50c809e576ba1` |
| `feat/DL-17248-delay-cleanup` | `6a19b3fe110e21af2962470d67e2f54a614e50cf` |
| `feat/DL-17303` | `5d3daf702d49417767856fff23803ab8b57455ce` |
| `feat/v2.2.4-codepush-tag` | `57b8eabb713ec019f49fc7614a960b35302ef29f` |

### Lab 앱

| 브랜치 | 삭제 전 SHA |
| --- | --- |
| `QA/DL-16881` | `cd46b7cd2a4710d8690251620a40d773009475a0` |
| `QA/DL-16907` | `093cc67c4721b637a766387f5cbc6f5dc752c88e` |
| `QA/DL-16917` | `06e8dfde967502a4830e9a93c018ce150702dc7c` |
| `feat/v1.0.5-codepush-tag` | `e910945ca8b51010df741f97f877ea2118805575` |

### Studio

| 브랜치 | 삭제 전 SHA |
| --- | --- |
| `feat/dlds-gallery` | `39069b9dd8587eb7ceec175111bc1bc4a1203d8f` |

## 복구 자료와 다음 시작점

각 저장소의 `.git/codex-closeout/local-cleanup-20261116/` 안에 자료가 있다(디렉터리 0700, 파일 0600). 별도 backup branch는 만들지 않았다.

- Web: `web-local-branches.bundle`, `manifest.json`, `bundle-verify.txt`.
- Office: `office-172235/office-local-branches.bundle`, `manifest.json`, `bundle-verify.txt`.
- Lab: `lab-local-branches-20261116-172225.bundle`, 같은 이름 `.json` manifest.
- Studio: `feat-dlds-gallery.bundle`, `feat-dlds-gallery.manifest.json`.

모든 bundle의 `git bundle verify`가 통과했다. 증분 bundle은 manifest의 기준 커밋 이력이 있는 저장소에서 복구한다. 웹의 삭제한 15개 중 `release/v1.92.0`은 기준 master의 조상이므로 bundle ref 목록 대신 기준 이력과 위 SHA로 복구 가능하다. 웹 bundle에는 삭제하지 않은 알림센터 임시 DEV ref도 사전 후보 백업으로 포함되어 있다.

이번 승인 범위의 정리는 완료다. 알림센터/진행 세션 소유, 현재 릴리즈·원본, 근거가 부족한 Lab 4개를 자동으로 다시 정리하지 않는다. 새로운 정리 요청이 있을 때 live Git/소유/배포 근거부터 확인한다. 기능 구현·세션 보관·원격 정리·배포를 이어서 실행하지 않는다.
