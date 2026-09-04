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
| iOS | `yarn ios-office:dev` | `yarn ios-office:staging` | `yarn ios-office:production` |
| Android | `yarn android-office:dev` | `yarn android-office:staging` | `yarn android-office:production` |

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
4. Use the IDE opened for that exact project. Run Metro and launch commands in
   its integrated terminal; if the IDE is not prepared, ask before starting
   them elsewhere.
5. Check whether Metro is already listening on 8081. Reuse it when it belongs
   to this checkout; do not start a duplicate server.
6. Open Reactotron as part of the normal local workspace.

## iOS Office

1. Boot or select the intended iOS Simulator.
2. In an integrated terminal, start visible Metro logs when Metro is not
   already running:

   ```bash
   yarn metro-log
   ```

3. In another integrated terminal, run the team's Office Development command:

   ```bash
   yarn ios-office:dev
   ```

4. Confirm the Development app launches in Simulator and renders the currently
   checked-out branch's Metro bundle.
5. Confirm Reactotron shows an iOS connection and Timeline/network traffic.
   If it does not connect, check the current Mac LAN address used by the iOS
   Reactotron configuration, reload the app and verify again.
6. Leave Simulator, Metro and Reactotron running for the development loop unless
   the user asks to close them.

## Android Office

1. Boot or select the intended Android emulator and confirm it appears in
   `adb devices`.
2. Apply the Reactotron reverse tunnel after the emulator connects:

   ```bash
   adb reverse tcp:9090 tcp:9090
   ```

3. In an integrated terminal, start `yarn metro-log` when the correct Metro is
   not already running.
4. In another integrated terminal, run:

   ```bash
   yarn android-office:dev
   ```

5. Confirm the Development app launches and Reactotron shows an Android
   connection plus Timeline/network traffic. Build success alone is not runtime
   proof.
6. Repeat the 9090 reverse command after an emulator reboot or reconnect.

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
도구: 프로젝트 IDE 터미널 + Simulator + Reactotron
명령: yarn metro-log, yarn ios-office:dev
```

The expected result is the Development Office app rendering the current local
branch in Simulator, with Metro connected and Reactotron receiving iOS
Timeline/network traffic. Do not report completion until those observable
parts have been checked.
