---
name: dentlink-local-app-development
kind: personal-memory-playbook
description: Prepare and verify the repeatable Dentlink local iOS or Android development workspace when the user asks to start app development, a simulator, an emulator, Metro, or Reactotron.
---

# Dentlink Local App Development Playbook

This is a personal executable memory, not product code. The user may follow it
manually, or Codex may perform the same sequence with the available computer
controls. The team's package scripts remain the canonical launch commands.
Use `projects/dentlink-app-development-guideline.md` for the master progression
from the iOS local loop through Android verification and Development CodePush.

Read [App onboarding and delivery](dentlink-app-onboarding.md) for the current
app release/PR policy. Confirm Office or Lab's separate repository and live
scripts before using older monorepo command examples from this playbook.

This playbook prepares the runtime; launching the app and connecting Metro or
Reactotron do not complete feature verification. Before handing work to the
user for final QA, the agent must test the final code in the simulator/emulator
on affected screens with checks scoped to actual code impact and plausible
failures under
[App Screen Runtime Verification Before Merge](../DEVELOPMENT_STYLE.md#app-screen-runtime-verification-before-merge).
For simple display changes, use a representative account and verify the changed
conditions; add role/route coverage only when the code can affect those behaviors.
Manual environment setup or user QA does not replace that agent verification.

## Configuration Model

Treat a local app session as a combination of independent axes rather than one
fixed mode:

| Axis | Choices |
| --- | --- |
| App | Office / Lab |
| Platform | iOS / Android |
| Server environment | Development / Staging / Production |
| Device | Simulator or emulator / physical device |
| Code source | current local branch through Metro / installed bundle / CodePush |
| Build | Debug / Release |
| Debugging | Reactotron / React Native DevTools / native logs |

Unless the user overrides an axis, use:

```text
Office + requested platform + Development + simulator/emulator
+ current local branch through Metro + Debug + Reactotron
```

Debug is the normal development build. Do not choose Release unless the user
explicitly requests it or a verified task truly requires release-only proof.
Likewise, do not infer CodePush, a physical device, Staging, Production or a
deployment merely because the user asks to see local code.

Interpret the user's web-style shorthand by expanding only the axes they name:

- “iOS 시뮬레이터에서 해줘” means Office + iOS + Development + Simulator +
  local Metro + Debug + Reactotron.
- “위 조건에서 staging으로” changes only Development to Staging.
- “실기기로 확인해줘” changes only the device axis; Debug remains the default.
- “Release로 확인해줘” is the explicit instruction required to select Release.
- “CodePush로 올려줘” selects remote OTA deployment and still requires the
  user's explicit deployment authorization.

The ordinary Office Debug commands are:

| Platform | Development | Staging | Production |
| --- | --- | --- | --- |
| iOS | `yarn ios:dev` | `yarn ios:staging` | `yarn ios:production` |
| Android | `yarn android:dev` | `yarn android:staging` | `yarn android:production` |

The corresponding `*-release` commands are exceptional paths. Production
environment and any deployment remain explicit high-risk choices even though a
local Debug script exists.

Before execution, briefly state the expanded combination and commands. After
execution, report branch/dirty state, selected combination, device screen,
Metro, Reactotron/network evidence and unresolved errors separately.

## Shared Preflight

1. Work only in `/Users/parkjongsun/Repository/dentlink-app` or the explicitly
   selected Dentlink app worktree.
2. Verify the exact Git branch, upstream, HEAD and dirty files. Preserve all
   existing local changes.
3. Confirm Office versus Lab. Use Development and Debug unless the user
   explicitly requests another environment or Release.
4. Follow [Local Development And User Preview](../SESSION_WORKFLOW.md#local-development-and-user-preview).
   Use the selected repository/worktree in a Codex-managed terminal for solo
   work, or the IDE's bottom integrated service terminals for direct user
   inspection unless the user explicitly allows internal app execution.
   In the commands below, "selected terminal" means the terminal for this mode.
5. Check whether Metro is already listening on 8081. Reuse it when it belongs
   to this checkout; do not start a duplicate server.
6. Open Reactotron as part of the normal local workspace.
7. Treat `ReactotronConfig.js` host edits as temporary per-developer local
   setup. Set the current developer's Mac address only while needed, never
   stage/commit/push it, and ensure it is excluded from product commits. Do not
   introduce a shared environment-based host mechanism unless the team later
   requests that maintenance.

## iOS Office

### 2026-10-27 확인된 로컬 준비 사항

- 현재 Office 팀 스크립트는 `yarn ios:dev` / `yarn android:dev`다. 이 문서의 명령도 분리된 Office 저장소 기준으로 갱신했다. 실행 전 대상 저장소의 package scripts를 우선한다.
- 기존 node_modules가 있더라도 lock과 일치한다고 가정하지 않는다. 이번에는 Datadog만2.14.8로 남아 현재 지정3.7.0의 `addAttributes` 호출에서 시작 오류가 발생했다. `yarn install --immutable`로 정렬 후 코드 변경 없이 홈 진입을 확인했다.
- 이 Mac의 Xcode27.1은 GUI 경로가 `/Applications/Xcode.app/Contents/Applications/DeviceHub.app`다. Simulator.app이 없으면 앱 설치 손상으로 단정하지 말고 실제 설치된 도구를 확인한다. boot된 기기는 `open 'devices://device/open?id=<UDID>'`로 열 수 있으며 실제 기기창을 확인했다. 관리창은 `devices://manage/open?new_window=true`로 별도 열 수 있으나 중복 창이 필요하지 않으면 호출하지 않는다. 이 경로를 구버전 Xcode에 무조건 적용하지 않는다.
- 10/27 재사용 기기는 iPhone17 Pro/iOS26.5, `5C0E7639-2345-4B3F-9979-56AFDDA1C708`다. 설치 Development 앱+로컬 Metro로 실행했으며 깨끗한 네이티브 재빌드의 증거는 아니다.

1. Boot or select the intended iOS Simulator.
2. In the selected terminal, start Metro logs when Metro is not
   already running:

   ```bash
   yarn metro-log
   ```

3. For ordinary JS/TypeScript work, first reuse the already installed
   `com.innovaid.dentlink.development` Simulator app and load the current
   branch through Metro. Launch it from Simulator or, when useful, run:

   ```bash
   xcrun simctl launch booted com.innovaid.dentlink.development
   ```

4. Run the team's native Office Development command only when a compatible app
   is not installed or a native rebuild is actually required:

   ```bash
   yarn ios:dev
   ```

   On this Apple Silicon Mac, do not assume this is currently a reliable clean
   rebuild path. The committed Podfile excludes arm64 from Simulator builds,
   while MLImage's arm64 slice is an iOS-device binary and its x86_64 slice is
   the Simulator binary. The installed proof app can support the Metro JS loop,
   but a fresh native Simulator build remains a separate maintenance boundary.
5. Confirm the Development app launches in Simulator and renders the currently
   checked-out branch's Metro bundle.
6. Confirm Reactotron shows an iOS connection and Timeline/network traffic.
   If it does not connect, check the current Mac LAN address used by the iOS
   Reactotron configuration, temporarily set the developer's address locally,
   reload the app and verify again. Do not publish that personal address.
7. Leave Simulator, Metro and Reactotron running for the development loop unless
   the user asks to close them.

## Android Office

1. For ordinary JS/TS work, boot or select the intended Android emulator from
   the selected terminal rooted at `dentlink-app`. Prefer launching the AVD
   directly so the full Android Studio UI does not open unnecessarily:

   ```bash
   "$ANDROID_HOME/emulator/emulator" -avd Dentlink_API_36
   ```

   Open Android Studio only when AVD management, native Android code, Gradle
   configuration or another Android-specific tool is actually required. After
   boot, confirm the emulator appears in `adb devices`.
2. Apply the Reactotron reverse tunnel after the emulator connects:

   ```bash
   adb reverse tcp:9090 tcp:9090
   ```

3. In the selected terminal, start `yarn metro-log` when the correct Metro is
   not already running.
4. In another terminal for the same execution mode, run:

   ```bash
   yarn android:dev
   ```

5. Confirm the Development app launches and Reactotron shows an Android
   connection plus Timeline/network traffic. Build success alone is not runtime
   proof.
6. Repeat the 9090 reverse command after an emulator reboot or reconnect.

## 집 Mac(보조) 준비 — 2026-11-11

다른 Mac에 처음 세팅할 때 실제로 막혔던 지점과 해결책이다. 값·비밀은 기록하지 않는다.

- **Ruby:** `.tool-versions`는 3.2.2지만 두 앱의 `Gemfile.lock`은 Ruby 3.4.5에서 생성됐다. brew `ruby@3.4`를 PATH 앞에 두고 bundler를 설치했다. 시스템 Ruby 2.6으로는 진행하지 않는다.
- **네이티브 gem 빌드 실패:** Command Line Tools의 macOS SDK(27.2)가 Xcode 26.6 링커가 모르는 tbd 포맷이라 json 등 C 확장 빌드가 `unknown architecture arm64e.x1`로 실패했다. `SDKROOT=$(xcrun --sdk macosx --show-sdk-path)`(Xcode SDK)로 해결했다. **같은 날 오후 Xcode가 27.2로 올라가 CLT와 버전이 맞은 뒤에는 우회 없이 컴파일·링크가 정상이라, 전역 `SDKROOT` export를 `.zshrc`에서 제거했다**(전역 SDKROOT는 iOS 빌드를 방해할 수 있음). 다시 불일치가 생길 때만 해당 명령에 한정해 붙인다.
- **Xcode 라이선스:** 새 Mac에서는 `sudo xcodebuild -license accept`가 필요하다(관리자 비밀번호라 사용자가 직접). 미동의 상태에서는 `/usr/bin/python3` 등 Xcode 도구가 exit 69로 막힌다.
- **pod install:** 비대화형 셸에서는 `LANG=en_US.UTF-8`이 없으면 `RNFastImage.podspec`의 UTF-8 파싱이 실패한다. 실패가 `| tail`에 가려지지 않게 `pipefail`로 확인한다. Lab은 pod install 후 `project.pbxproj` 주석 정규화 diff가 생길 수 있어 의미 없는 변경이면 되돌린다.
- **Android:** JDK는 brew `openjdk@17`. SDK는 `~/Library/Android/sdk`에 platform-tools, platforms;android-36, build-tools;36.0.0, ndk;27.1.12297006, emulator, system-images;android-36;google_apis;arm64-v8a, cmdline-tools;latest. brew의 `avdmanager`는 자기 설치 폴더를 SDK로 착각하므로 `$ANDROID_HOME/cmdline-tools/latest/bin/avdmanager`를 쓴다. AVD 이름은 이 문서 기준 `Dentlink_API_36`.
- **iOS 시뮬레이터 새 빌드 성공(2026-11-11, Xcode 27.2):** 현재 두 앱의 Podfile은 시뮬레이터 `EXCLUDED_ARCHS`를 비워 arm64를 제외하지 않는다. `xcodebuild -workspace <앱>.xcworkspace -scheme DentlinkDevelopment|DentlinkLabDevelopment -configuration Debug -sdk iphonesimulator -destination id=<UDID> -derivedDataPath build build`로 Office·Lab 모두 BUILD SUCCEEDED, iPhone 17 Pro(iOS 26.5)에 설치했고 Office는 Metro 번들로 첫 화면까지 확인했다. 위 iOS Office 절의 "Apple Silicon에서 깨끗한 재빌드 경로가 불확실" 경고는 이 기기·현재 Podfile 기준으로는 해소됐다(사무실 Mac은 별도 확인). `ios/build`는 Git 무시 대상이라 작업트리 변경이 없다.
- **16GB Mac 부하 주의:** iOS 빌드 직후 load가 100을 넘으면 Android 에뮬레이터 런처가 ANR을 낸다. 빌드가 끝나고 부하가 내려간 뒤 런처 "Close app"→앱 재실행으로 회복했다. 빌드와 에뮬레이터 확인을 겹치지 않는다.
- 셸 설정(`~/.zshrc`): ruby@3.4 PATH, `JAVA_HOME`, `ANDROID_HOME`, platform-tools/emulator PATH. (`SDKROOT`는 위 사유로 제거)

## Working Rules

- Local Debug renders the currently checked-out Git branch through Metro.
- `dev`, `staging` and `production` select API/environment and native variant;
  they do not select a Git branch.
- `codepush-force-*` commands publish a remote OTA deployment. Never use them
  merely to preview local code.
- Reactotron is available only when its `__DEV__` configuration is loaded.
- Use Simulator/emulator for the ordinary development loop and distinguish it
  from later physical-device QA.
- Do not commit, push, publish CodePush, change environment, or mutate unrelated
  native configuration unless the user separately authorizes it.
- Report observable results separately: device screen, Metro connection,
  Reactotron connection, network traffic and any unresolved platform error.

## Invocation Intent

Apply this playbook when the user says, for example, “iOS 개발 환경 띄워줘”,
“Android 에뮬레이터로 작업 시작하자”, “Reactotron까지 연결해줘”, or asks to
resume local Dentlink app work. If the user is doing the steps manually, guide
them through this same order and wait at the step where they need to act.

For example, before “iOS 시뮬레이터에서 작업하자”, state:

```text
실행 조합: Office + iOS + Development + Simulator + Debug
코드: 현재 체크아웃 브랜치 via Metro
도구: 단독 개발은 Codex 터미널 / 사용자 확인은 IDE 하단 터미널(명시적 예외 허용)
화면: Simulator + Reactotron, 사용자 배치 유지
명령: yarn metro-log, 설치된 Development 앱 실행/Reload
네이티브 재빌드 필요 시에만: yarn ios:dev
```

The expected result is the Development Office app rendering the current local
branch in Simulator, with Metro connected and Reactotron receiving iOS
Timeline/network traffic. Do not report completion until those observable
parts have been checked. Do not rebuild merely to follow the example literally.
