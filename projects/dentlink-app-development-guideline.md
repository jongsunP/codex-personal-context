---
name: dentlink-app-development-guideline
kind: personal-memory-playbook
description: Interpret the user's web-style requests and guide repeatable Dentlink app work from local iOS development through Android verification and explicitly authorized Development CodePush physical-device checking.
---

# Dentlink App Personal Development Guideline

This is the user's master app-development workflow. It is personal memory, not
product code. Use the team's package scripts as reliable environment/build
primitives, then arrange them with the user's preferred IDE, device, Metro and
Reactotron workflow.

Read `projects/dentlink-app-local-development.md` for the detailed runtime
matrix and per-platform launch checklist.

## Default Combination

When the user asks to work on the app without specifying every axis, expand it
to:

```text
Office + requested platform + Development + Simulator/Emulator
+ current local branch through Metro + Debug + Reactotron
```

- Debug is the ordinary build. Release is exceptional and requires an explicit
  request or a verified release-only need.
- Development is the ordinary server environment. Staging and Production are
  independent overrides; they do not mean a different Git branch.
- Local source means the currently checked-out worktree through Metro.
- Simulator/emulator is the ordinary development device. Physical device is a
  later verification target unless the feature itself requires hardware.

## Recommended Daily Flow

### 1. Preflight

1. Refresh/read the Git-backed personal context when resuming prior work.
2. Verify the exact app checkout, branch, upstream, HEAD and dirty files.
3. Preserve existing local changes and confirm Office versus Lab.
4. Use the IDE opened for that exact checkout and its integrated terminals.
5. State the expanded execution combination before starting.

### 2. Primary Development Loop: iOS

For shared React/TypeScript/UI/API work, use iOS Simulator as the user's fast
primary loop:

```text
iOS Simulator + Development + Debug + local Metro + Reactotron
```

Start or reuse `yarn metro-log`, run `yarn ios-office:dev`, and iterate with
Metro/Fast Refresh. Verify the visible screen and Reactotron network/timeline.
Do not rebuild Android after every small edit.

Start on Android instead when the change is Android-specific, and start on iOS
when it is iOS-specific. The affected platform outranks the personal default.

### 3. Cross-Platform Checkpoint: Android

When the feature reaches a sensible breakpoint, keep the same branch,
Development environment, local source and Debug build, then change only the
platform/device axes:

```text
Android Emulator + Development + Debug + same local Metro + Reactotron
```

Confirm the emulator in ADB, apply `adb reverse tcp:9090 tcp:9090`, run
`yarn android-office:dev`, and verify both the screen and Reactotron traffic.
Fix cross-platform differences before remote deployment.

### 4. Pre-CodePush Checkpoint

Before CodePush:

1. Run proportionate changed-file/static checks.
2. Review the full diff and identify native-boundary changes.
3. Confirm iOS and Android local results separately for a cross-platform
   feature.
4. Recheck branch, HEAD, upstream and dirty files. Prefer a clean, committed
   and pushed commit for a reproducible deployment. Never commit or push merely
   to satisfy this preference without the user's explicit authorization.
5. If the worktree is dirty, show exactly what would be bundled and obtain an
   explicit decision before deployment.

### 5. Choose the Physical-Device Path

Use Development CodePush when all of these are true:

- The change is compatible JavaScript/TypeScript or bundle asset work.
- No native dependency, Pod/Gradle, permission, entitlement, plist/manifest,
  signing or native module change is required.
- The matching Development binary is already installed on the physical device.
- The user explicitly asks to publish CodePush.

The routine Office command is:

```bash
yarn codepush-force-office:dev
```

It publishes both iOS and Android bundles to the shared Development deployment;
it is not a private cable transfer to one phone. Confirm scope and current
source immediately before running it. Do not infer this authorization from
“실기기에서 보고 싶다”.

Use a direct local Debug build on the physical device instead when live Metro,
Reactotron/network debugging, native-code validation or hardware debugging is
needed. Use an app-developer/native delivery path when signing, store builds or
deep native changes are involved.

### 6. Physical-Device Verification

After an authorized successful Development CodePush, verify update receipt and
the target flow separately on iOS and Android physical devices as available.
A CodePush bundle is normally built with `__DEV__` disabled, so do not expect
Reactotron to provide the same evidence as the local Debug loop. Use visible
behavior and the available non-DEV observability instead.

## Natural-Language Progression

Interpret a normal user sequence as follows:

1. “iOS 시뮬레이터에서 작업하자”
   - Office + iOS + Development + Simulator + Debug + local Metro + Reactotron.
2. “이제 Android 에뮬레이터에서도 확인하자”
   - Retain branch/environment/build/code source; change platform and device.
3. “둘 다 확인했으니 실기기에서 보게 CodePush 하자”
   - Run the pre-CodePush checkpoint, then publish to Development only because
     this sentence explicitly authorizes CodePush.
4. “실기기에서 네트워크까지 디버깅하자”
   - Prefer a directly connected local Debug build rather than CodePush.

If the user adds “staging”, change only the environment and corresponding team
script. Keep Debug unless Release is also explicitly requested. Production,
Release, store submission and production CodePush are never implied defaults.

## Team Scripts And Personal Orchestration

- Package scripts remain the source of truth for schemes, flavors, environment
  files, app IDs, target binary versions and Revopush deployments.
- Personalization changes the surrounding order and verification: exact IDE,
  Metro visibility, Reactotron, ADB reverse, device selection and briefings.
- Do not duplicate or bypass a package script merely to make the workflow look
  custom. Add a wrapper or change a script only when repeated verified friction
  justifies a team-visible maintenance change and the user authorizes it.

## Completion Briefing

After each stage, report only observable state:

```text
- Git: branch / HEAD / upstream / dirty state
- Combination: app / platform / environment / device / build / code source
- Runtime: device screen / Metro / Reactotron and network
- Checks: executed / passed / baseline or new failures
- Deployment: not performed, or exact Development CodePush result
- Remaining: only unresolved work or evidence gaps
```

Do not conflate local runtime, CodePush publication, update receipt, physical
device QA, teammate review, merge and production delivery.
