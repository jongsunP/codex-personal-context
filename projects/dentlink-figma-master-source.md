# Figma master 독립 시험 · 업로드 사본 복구 정보

**현재 상태 — 2026-10-02:** FE 회의는 완료됐으며 Figma는 이번 작업에 사용하지 않고 참고만 합니다. master 기반 시험은 종료했고 추가 진행 대상이 아닙니다. 다음은 `projects/dentlink-fe-opportunities.md` 최신 체크포인트의 **빈 페이지 → 자연어 요청 → 실제 DLDS 기반 화면·FE가 활용할 코드 생성** 검증을 구체화하는 단계입니다. 아래 내용은 기존 시험의 출처·복구·검증 기록이며 Figma 시험 재개 지시가 아닙니다.

**로컬 자료 정리 — 2026-10-02:** 사용자 요청으로 `figma-code-layers/` 전체를 휴지통으로 옮겼습니다. 아래 destination·ZIP·검증 파일 경로는 당시 기록이며 현재 작업 폴더에 존재하지 않습니다. 출처 메타데이터와 검증 결과는 이 문서 및 프로젝트 체크포인트에 보존합니다. 현재 AI 작업 재개에 사본 복구나 master 재시험은 필요 없습니다.

기준 SHA를 git archive로 새 개인 폴더에 추출하고 아래 excluded_paths만 제외합니다. 로컬 실행 코드나 클라우드 설정이 아닌, 사본 재생성에 필요한 출처·제외 목록입니다. 로그인·설치·생성 결과는 별도로 확인합니다.

```json
{
  "created_at": "2026-10-02T02:43:44.065136+00:00",
  "source_repository": "/Users/parkjongsun/Repository/dentlink-client-dlds",
  "source_ref": "origin/master",
  "source_commit": "9bed1f7bd753e229478302413c0ec9a7e7a11dc2",
  "source_commit_subject": "Release/v1.87.0 -> master (#4641)",
  "destination": "/Users/parkjongsun/Documents/ChatGPT/디자인시스템정비 프로젝트/figma-code-layers/master-trial/dentlink-client-master",
  "copied_files": 3460,
  "bytes": 58314729,
  "tree_sha256": "53e4a5f28de4f51dca033571909d8bcbdf85f246a5f81e8c250f20eee79b4fef",
  "purpose": "Independent Figma Code layers trial based on original master. No existing Codex AI preview or DLDS cleanup changes included. Product repository unchanged.",
  "copy_method": "Read-only git archive of pinned master commit; safe regular files only; no branch checkout, dependency install, or UI scaffolding.",
  "excluded_paths": [
    {
      "path": ".claude/agents/code-reviewer.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/agents/side-effect-checker.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/commands/refactor-polling.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/commands/update-packages.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/commands/validate-rq-migration.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/api-setup/SKILL.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/commit-work/SKILL.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/e2e/SKILL.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/e2e/references/01-function-inventory.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/e2e/references/02-spec-writer.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/e2e/references/03-scenario-backlog.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/i18n/SKILL.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/pr-create/SKILL.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/pr-create/references/01-pr-builder.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/pr-review/SKILL.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/pr-review/references/01-diff-analyzer.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/pr-review/references/02-convention-check.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/pr-review/references/03-comment-writer.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/start/SKILL.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/test/SKILL.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/test/references/01-test-writer.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/ticket-plan/SKILL.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/ticket-tdd/SKILL.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/ticket-tdd/references/01-ticket-analyzer.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/ticket-tdd/references/02-tdd-planner.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/ticket-tdd/references/03-test-writer.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/ticket-verify/SKILL.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/ticket-verify/references/01-ac-extractor.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/ticket-verify/references/02-code-verifier.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/ticket-verify/references/03-comment-writer.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".claude/skills/ticket-work/SKILL.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".codex/agents/code-reviewer.toml",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".codex/agents/side-effect-checker.toml",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".codex/skills/commit-work/SKILL.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".codex/skills/commit-work/agents/openai.yaml",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".codex/skills/github-pr/SKILL.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".codex/skills/i18n/SKILL.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".github/PULL_REQUEST_TEMPLATE.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".github/auto_assign.yml",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".github/workflows/admin_dev_build_and_deploy.yml",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".github/workflows/admin_prd_build_and_deploy.yml",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".github/workflows/admin_stg_build_and_deploy.yml",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".github/workflows/auto_assign_action.yml",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".github/workflows/chromatic.yml",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".github/workflows/clinic_dev_build_and_deploy.yml",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".github/workflows/clinic_prd_build_and_deploy.yml",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".github/workflows/clinic_stg_build_and_deploy.yml",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".github/workflows/clinic_stg_e2e.yml",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".github/workflows/lab_dev_build_and_deploy.yml",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".github/workflows/lab_prd_build_and_deploy.yml",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".github/workflows/lab_stg_build_and_deploy.yml",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".github/workflows/ui_s3_build_and_deploy.yml",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".husky/pre-commit",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".husky/pre-push",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": ".mcp.json",
      "reason": "local_connector_configuration_not_uploaded"
    },
    {
      "path": "admin/.env.development",
      "reason": "environment_configuration_not_uploaded"
    },
    {
      "path": "admin/.env.production",
      "reason": "environment_configuration_not_uploaded"
    },
    {
      "path": "admin/.env.staging",
      "reason": "environment_configuration_not_uploaded"
    },
    {
      "path": "clinic/.env.development",
      "reason": "environment_configuration_not_uploaded"
    },
    {
      "path": "clinic/.env.production",
      "reason": "environment_configuration_not_uploaded"
    },
    {
      "path": "clinic/.env.staging",
      "reason": "environment_configuration_not_uploaded"
    },
    {
      "path": "e2e/README.md",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/assets/Cat03.jpg",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/assets/dentlink.png",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/assets/xlsx_sample1.xlsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/fixtures.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/fixtures/.gitkeep",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/specs/00_signup.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/specs/00_signup_step2_3_validation.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/specs/00_signup_step4_office_find.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/specs/00_signup_validation.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/specs/01_signin.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/specs/02_onboarding.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/specs/03_orders/crown.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/specs/03_orders/denture.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/specs/03_orders/instasmile.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/specs/03_orders/step4-ui-state.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/specs/03_orders/veneer.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/specs/04_labShipment.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/specs/05_labStatus.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/specs/06_linkTalk.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/specs/07_billing.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/specs/08_orderFeedback.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/auth/signup-assert.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/auth/signup-compose.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/auth/signup-step0.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/auth/signup-step1.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/auth/signup-step2.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/auth/signup-step3.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/auth/signup-types.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/feedback/create-feedback-order.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/feedback/feedback-test-helpers.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/lab/shipment-create.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/lab/shipment-order.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/lab/shipment-pickup.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/office/find.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/office/register.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/onboard/onboard-helpers.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/onboard/onboard-setup.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/order/order-assert.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/order/order-cases/crown.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/order/order-cases/denture.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/order/order-cases/instasmile.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/order/order-cases/veneer.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/order/order-setup.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/order/order-step1-profile.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/order/order-step2-product.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/order/order-step3-option.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/order/order-step4-additional.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/order/order-types.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/steps/user/withdrawal.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/utils/admin-api.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/utils/api-monitor.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/utils/lab.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/utils/localized-text.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/utils/login.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/utils/scanner-api.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/utils/session.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/utils/signin.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/utils/timeouts.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/clinic/utils/wait.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/package-lock.json",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/scripts/setup-other-account.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/scripts/setup-request-access-office.spec.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/setup/global-setup.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/setup/global-teardown.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/setup/onboard-artifacts.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "e2e/tsconfig.json",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "lab/.env.development",
      "reason": "environment_configuration_not_uploaded"
    },
    {
      "path": "lab/.env.production",
      "reason": "environment_configuration_not_uploaded"
    },
    {
      "path": "lab/.env.staging",
      "reason": "environment_configuration_not_uploaded"
    },
    {
      "path": "shared/icons/dist/3ShapeLogo.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/ArrowDiagonaLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/Bank.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/BoxCloseFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/Card.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/CheckInShieldFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/ClinicLogo.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/CreditLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/DentsplySironaLogo.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/DesignPreferenceAggressive.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/DesignPreferenceDominant.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/DesignPreferenceEnhanced.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/DesignPreferenceFocused.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/DesignPreferenceFunctional.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/DesignPreferenceHollywood.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/DesignPreferenceMature.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/DesignPreferenceNatural.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/DesignPreferenceOval.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/DesignPreferenceSoften.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/DesignPreferenceVigorous.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/DesignPreferenceYouthful.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/DirectionCaretDownSmall.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/DirectionCaretUpSmall.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/DsCoreLogo.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/EmptyCategory.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/EximbayWarning.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/IC/DirectionCaretDownSmall.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/IC/DirectionCaretUpSmall.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/IC/index.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/LoadingAnimation.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/MeditLink.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/ObjectPaperDallorLined.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/ObjectReceiptLinedV2.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/ObjectSortLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/OnboardingDesktop1.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/OnboardingDesktop2.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/OnboardingDesktop3.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/OnboardingDesktop4.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/OnboardingDesktop5.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/OnboardingMobileDesktop1.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/OnboardingMobileDesktop2.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/OnboardingMobileDesktop3.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/OnboardingMobileDesktop4.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/OnboardingMobileDesktop5.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/OnboardingMobileStep1.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/OnboardingMobileStep2.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/OnboardingMobileStep3.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/OnboardingMobileStep4.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/OnboardingMobileStep5.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/PaletteFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/PersonDoctor2Line.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/PonticDesignConical.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/PonticDesignModifiedRidgeLap.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/PonticDesignOvate.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/PonticDesignRidgeLap.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/PonticDesignSanitaryHygienic.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/PromotionIcon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowArrowBackLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowArrowDownLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowArrowDownRightAndArrowUpLeftSquareFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowArrowDownSmallLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowArrowForwardLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowArrowLeftLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowArrowRightAndOutLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowArrowRightLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowArrowRightLint.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowArrowUpInCircleFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowArrowUpLeftAndArrowDownRightSquareFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowArrowUpLeftAndArrowDownRightSquareFilledCopy.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowArrowUpLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowArrowUpTopLineLIne.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowCaretDown.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowCaretLeft.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowCaretRight.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowCaretSmallDown.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowCaretSmallRight.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowCaretSmallUp.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowCaretUp.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowCaretUpAndDown.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowDiagonalLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowDownLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowDownRightLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowDownSmallLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowLeft2LeftLIne.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowLeftInCircleFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowLeftLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowLeftPanel.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowLeftRotate.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowLeftSmallLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowResetLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowReturnLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowRight2RightLIne.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowRightInCircleFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowRightLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowRightLineLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowRightPanel.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowRightRotate.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowRightSmallLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowSendLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowUpLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgArrowUpSmallLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgAuthorityCheckInBadgeLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgAuthorityCheckInShieldFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgBadgeFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgBox.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCardIconAmax.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCardIconDiners.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCardIconDiscover.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCardIconJcb.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCardIconMaster.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCardIconUnionpay.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCardIconVisa.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCaseFinishPreference.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCaseSetPreference.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCaseViewPreference.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgChartAverageBubbleTail.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgChartAverageDot.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgChartAverageLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCheckMark.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCloseInCircleFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgContactChatFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgContactChatLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgContactHelpcenterFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgContactPhoneFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgContactServiceFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgContactServiceLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgContactTranslateLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgContactTranslateWithSquareLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCountryAu.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCountryCa.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCountryDefault.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCountryGb.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCountryIe.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCountryKr.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCountryMy.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCountryNz.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCountrySg.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCountryToothNumberSystemFlagFdi.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCountryToothNumberSystemFlagUns.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCountryUs.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCoupon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgCreditHistory.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgDashboardTitleDividerDot.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgDentlinkSupportLogo.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgDocLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgDuplicateCard.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgEditorArrowLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgEditorCloseChat.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgEditorCropLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgEditorDrawingLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgEditorEraserFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgEditorEraserLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgEditorOpenChat.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgEditorPencilFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgEditorPencilLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgEmptyContentDocumentLogo.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgEmptyExtraFee.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgEmptyFiles.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgExclamationMark.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgExclamationSignCircleFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgEye.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgEyeClosed.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileAllowUpDocFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileAllowUpDocLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileAllowUpDocLineDemo.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileBookFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileCaptureDrawingFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileCopyFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileCopyLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileDocApprovalFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileDocBadgeCancelFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileDocBadgeCancelLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileDocBadgePlusFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileDocFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileDocLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileDocPendingFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileDownloadLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileExportLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileFolderClosedFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileLinkCrossLineLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileLinkLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileMemoWrittenFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileOrderCompletedFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFilePagesFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFilePaperContextFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFilePaperContextLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFilePaperDollorFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFilePaperDollorLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFilePaperDollorPlusFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFilePaperDollorWarningFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFilePaperDollorXFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFilePaperclipLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFilePhotoFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFilePresentFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileUploadCloudLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFileUploadLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgFindOfficeEmptyIcon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgHamburgerMenu.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgHelpCenter.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgHelpCenterMenuIcon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgIc3D.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgIcFile.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgInvalidCard.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgLabProfileBadge.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgLabProfileLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgLabelFail.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgLinkTalk.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgLinkTalkEmpty.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgLoadingAnimationGray.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgLoadingAnimationPrimary.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgLoadingAnimationWhite.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgLogo.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgLogoHelpCenter.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgLogoMonoBlack.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgLogoText.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgLogoTextWh.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgLogoTwoColorLight.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgLogoWhite.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgLogoWithText.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgManageOfficesText.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMapsMappinFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMapsMappinLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathCloseInCircleFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathCloseInCircleLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathCloseLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathMinusInCircleFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathMinusLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn1Filled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn1Line.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn2Filled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn2Line.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn3Filled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn3Line.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn4Filled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn4Line.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn5Filled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn5Line.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn6Filled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn6Line.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn7Filled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn7Line.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn8Filled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn8Line.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn9Filled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusIn9Line.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusInCircleFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathPlusLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathSmallCloseLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathSmallPlusLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMathZoomPlusLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgMoreContents.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgNewMessage.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObject3DScannerFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObject3DScannerLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectAirplainLined.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectAirplaneLined.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectAlertFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectAlertLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectBellFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectBellLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectBellWithCircleLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectBoxCheckFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectBoxFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectBoxLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectBurgerMenuLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectCalendarLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectCameraFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectChartLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectClockFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectClockLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectCoinFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectCoinPartialPaidLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectCoinRefundLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectCoinSlashLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectCouponFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectCouponLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectCreditCardLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectCreditFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectCreditLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectCreditcardFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectDashboardFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectDeliveryAirplainLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectDeliveryTruckFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectDeliveryTruckLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectDentlink.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectDots3.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectEyeClosedLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectEyeLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectFilterFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectFilterHorizontalLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectHomeFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectHomeLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectHornFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectImplantFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectLabFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectLabLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectLetterFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectLetterLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectLoadingAltLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectLockLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectMagnifyingglassLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectMessagLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectNoteFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectNoteLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectOfficeFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectOfficeLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectOfflineLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectPaletteFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectPinFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectPrintFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectPrintLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectReceiptFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectReceiptLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectSandclockFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectSandclockLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectSend.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectTeethAndPlusFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectTeethAndPlusLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectTeethBrushFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectTeethBrushLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectTeethCheck.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectTeethFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectTeethHospitalFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectTeethHospitalLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectTeethLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectTeethfFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectToolFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectTooth2Line.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectToothSystem.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectTrashcanFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectTrashcanLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgObjectTteethAnd3DotFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgOnGradient.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgOrderCloseIcon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgOrderCreatedFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgOwner.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPersonDoctor2Line.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPersonLab2Filled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPersonLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPersonPatienOfficetFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPersonPatientFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPersonPersonAndPlusFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPersonPersonAndPlusLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPersonPersonDoctor2Filled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPersonPersonDoctor2FilledColor.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPersonPersonDoctorFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPersonPersonDoctorLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPersonPersonFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPersonPersonLabFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPersonPersonLabLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPersonPersonLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPersonPersonPatientFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPersonPersonPatientFilledColor.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPhoneLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPickupFail.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPickupNotificationOfficeToCenter.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPickupNotificationOfficeToLab.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgPresent.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgQuoteFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgScannerLogo3Shape.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgScannerLogoAlliedstar.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgScannerLogoCarestream.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgScannerLogoDexis.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgScannerLogoDscore.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgScannerLogoItero.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgScannerLogoMedit.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgScannerLogoPlanmeca.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgScannerLogoShining3D.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgScannerLogoStraumann.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgShapeCircleLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSignAsterisk.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSignCheck.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSignCheckMarkSignCircleFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSignCheckMarkSignCircleIsigne.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSignCheckMarkSignCircleIsignePrimary.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSignCheckMarkSignCircleLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSignCheckMarkSignCircleLsigne.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSignExclamationPosigntSignCircleFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSignExclamationPosigntSignCircleIine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSignExclamationPosigntSignTriangleFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSignExclamationPosigntSignTriangleLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSignExclamationPosigntsignCircleLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSignQuestionMarkSignCircleFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSignQuestionMarkSignCircleLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSignSignfoSignCirclLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSignSignfoSignCircleFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSignSignfoSignCircleLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSocialIconInstagram.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSpinner.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgStarFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSymbolLogo.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSymbolLogoText.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSymbolPrimaryLogo.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSystemSettingFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgSystemSettingLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgTeethBrushLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgTeethWithGums.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgTooltipRectangle.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgTooltipRectangle2.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgTossfaceFlyingMoney.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgTossfacePresent.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgTrackingDetailsPcType5.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgTrophyFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgTruck.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgTruckDark.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgTruckMarkImage.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgUserCrdeitFilledGray.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgUserCrdeitFilledWhite.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgUserCreditFilled.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/SvgUserHappyLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/ThreeShapeLogo.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/ToothShadeMultipleImage.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/ToothShadeSingleImage.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/TranslateWithSquareLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/icon-type.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/index.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/object/CreditLine.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/icons/dist/object/index.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgLower.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT1Default.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT1Disable.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT1Horizon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT1Select.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT1Solid.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT25Default.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT25Disable.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT25Horizon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT25Select.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT25Solid.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT26Default.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT26Disable.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT26Horizon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT26Select.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT26Solid.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT27Default.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT27Disable.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT27Horizon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT27Select.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT27Solid.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT28Default.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT28Disable.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT28Horizon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT28Select.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT28Solid.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT29Default.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT29Disable.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT29Horizon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT29Select.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT29Solid.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT2Default.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT2Disable.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT2Horizon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT2Select.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT2Solid.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT30Default.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT30Disable.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT30Horizon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT30Select.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT30Solid.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT31Default.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT31Disable.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT31Horizon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT31Select.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT31Solid.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT32Default.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT32Disable.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT32Horizon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT32Select.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT32Solid.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT3Default.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT3Disable.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT3Horizon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT3Select.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT3Solid.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT4Default.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT4Disable.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT4Horizon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT4Select.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT4Solid.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT5Default.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT5Disable.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT5Horizon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT5Select.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT5Solid.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT6Default.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT6Disable.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT6Horizon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT6Select.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT6Solid.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT7Default.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT7Disable.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT7Horizon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT7Select.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT7Solid.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT8Default.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT8Disable.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT8Horizon.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT8Select.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgT8Solid.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/SvgUpper.tsx",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/teeth-icons/dist/index.ts",
      "reason": "agent_settings_tests_deployment_or_generated_directory"
    },
    {
      "path": "shared/ui/tsconfig.node.tsbuildinfo",
      "reason": "generated_typescript_output"
    },
    {
      "path": "shared/ui/vite.config.d.ts",
      "reason": "generated_typescript_output"
    },
    {
      "path": "shared/ui/vite.config.js",
      "reason": "generated_typescript_output"
    }
  ],
  "excluded_directory_names": [
    ".cache",
    ".claude",
    ".codex",
    ".git",
    ".github",
    ".husky",
    ".next",
    ".vite",
    "copilot",
    "coverage",
    "dist",
    "e2e",
    "e2e-runs",
    "node_modules",
    "playwright-report",
    "storybook-static",
    "test-results"
  ],
  "secret_screening": "High-confidence embedded credential formats checked without printing values. Environment files and local connector settings excluded. This is not a guarantee of a complete security audit.",
  "baseline_has_ai_preview": false,
  "baseline_has_dlds_gallery": false,
  "baseline_has_dlds_public_entrypoint": false,
  "further_setup": "Figma must create the blank React preview entrypoint and cloud-only execution configuration. Existing shared/ui/index.html references an absent src/main.tsx.",
  "tree_sha256_algorithm": "Sort relative paths; concatenate each relative path + NUL + SHA256(file bytes) + newline using UTF-8; SHA256 the complete bytes."
}
```

## 최종 Version6 코드의 로컬 재현 — 2026-10-02

- Figma file `2OR0Gj7NUFEEeYBjQg5Y6v`, Code layer `234:4`, Cloud main /Version6. Files→File actions→Download code로 받는다. 최종 ZIP32,724,721bytes /SHA256 `d0df2a57d1e936907bb47d6392eb8a3e7453fd3bec4f449ed56ac81a352bed52`다. 같은 버전의 재다운로드라도 ZIP 메타데이터에 따라 파일 컨테이너 해시는 달라질 수 있으니 최종 제목/소스와 버전도 확인한다.
- ZIP3,477파일이며 원본 master3,460파일이 바이트 동일하다. 로컬 `export-v5/`의 이름과 달리 내용은 최종V6다. V5→V6는 App.tsx 제목 한 줄만 변경했다. 제품 worktree로 덮어쓰지 않고 별도 개인 폴더에 추출한다.
- Node22.23.3 /pnpm8.6.9 /Vite4.3.2로 frozen install·56modules Vite build·아래 설정의 타입 검사·실제 UI 저장을 확인했다. `.git`가 없는 추출본의 husky prepare 때문에 설치에만 HUSKY=0을 적용했다. optional canvas 바이너리 실패가 있었으며 이 폼에서 canvas는 사용하지 않는다.
- 타입 설정은 **다운로드에 기본 포함된 것이 아니라 FE가 검증용으로 보완한 것**이다. App/main/bridge와 도달하는 import를 검사하며 제품 전체 검사와 다르다. `__EXPORT_ROOT__`를 추출 폴더의 절대 경로로 치환한 JSON을 추출 폴더의 바로 위에 `typecheck-v6.config.json`로 저장하면 아래 명령과 같다. 환경과 의존성이 바뀌면 그대로 통과한다고 보장하지 않는다.
- Figma deploy/deploy-preview는 외부 업로드 스크립트여서 로컬에서 실행하지 않았다. 아래 Vite build/dev만 사용했다. private5180 서버는 검증 후 종료했고 기존 사용자 서버는 유지했다.

추출 폴더에서 실행한 명령:

```sh
HUSKY=0 npx --yes --package=node@22 -c 'pnpm install --frozen-lockfile'
npx --yes --package=node@22 node scripts/generate-icon-type.js
npx --yes --package=node@22 -c 'pnpm --dir shared/ui exec vite build --config ../../.figma/make/vite.config.mjs'
npx --yes --package=node@22 -c 'pnpm --dir shared/ui exec tsc --project ../../../typecheck-v6.config.json --pretty false'
PORT=5180 npx --yes --package=node@22 -c 'bash .figma/make/dev'
```

Portable 타입 검사 설정(경로 치환 후 사용):

```json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "ESNext",
    "moduleResolution": "Bundler",
    "jsx": "react-jsx",
    "noEmit": true,
    "strict": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "baseUrl": "__EXPORT_ROOT__",
    "typeRoots": [
      "__EXPORT_ROOT__/shared/ui/node_modules/@types",
      "__EXPORT_ROOT__/node_modules/@types"
    ],
    "types": [
      "node"
    ],
    "paths": {
      "react": [
        "__EXPORT_ROOT__/shared/ui/node_modules/@types/react/index.d.ts"
      ],
      "react/*": [
        "__EXPORT_ROOT__/shared/ui/node_modules/@types/react/*"
      ],
      "react-dom": [
        "__EXPORT_ROOT__/shared/ui/node_modules/@types/react-dom/index.d.ts"
      ],
      "react-dom/*": [
        "__EXPORT_ROOT__/shared/ui/node_modules/@types/react-dom/*"
      ],
      "styled-components": [
        "__EXPORT_ROOT__/shared/ui/node_modules/styled-components/dist/index.d.ts"
      ],
      "@dentlink/config": [
        "__EXPORT_ROOT__/shared/configs/index.ts"
      ],
      "@dentlink/config/*": [
        "__EXPORT_ROOT__/shared/configs/*"
      ],
      "@ui/*": [
        "__EXPORT_ROOT__/shared/ui/src/*"
      ]
    },
    "lib": [
      "DOM",
      "DOM.Iterable",
      "ESNext"
    ]
  },
  "files": [
    "__EXPORT_ROOT__/.figma/make/preview/src/App.tsx",
    "__EXPORT_ROOT__/.figma/make/preview/src/main.tsx",
    "__EXPORT_ROOT__/.figma/make/preview/src/ui-bridge.ts",
    "__EXPORT_ROOT__/shared/ui/node_modules/vite/client.d.ts"
  ]
}
```
