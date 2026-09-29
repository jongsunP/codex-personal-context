# DLDS PR 자동 검사 참고 코드

이 워크플로는 2026-09-29 사용자 결정으로 제품 저장소에서 제거했습니다. 나중에 팀이 PR 검사를 도입하기로 하면 범위와 실행 시간을 검토한 뒤 참고하세요. 이 문서는 실행되지 않습니다.

```yaml
name: DLDS regression

on:
  pull_request:
    paths:
      - "shared/**"
      - "package.json"
      - "pnpm-lock.yaml"
      - "pnpm-workspace.yaml"
      - ".github/workflows/ui_regression.yml"
  workflow_dispatch:

permissions:
  contents: read

concurrency:
  group: dlds-regression-${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true

jobs:
  ui-regression:
    runs-on: ubuntu-latest
    timeout-minutes: 15
    steps:
      - uses: actions/checkout@v4
      - uses: pnpm/action-setup@v4
        with:
          version: 8.6.9
      - uses: actions/setup-node@v4
        with:
          node-version: "24"
          cache: pnpm
      - run: pnpm install --frozen-lockfile
      - name: Icon generation regression
        run: pnpm --filter @dentlink/icons test
      - name: Component regression tests
        run: pnpm test:ui
      - name: DLDS gallery types and lint
        run: |
          pnpm --filter @dentlink/ui exec tsc -p tsconfig.dlds-gallery.json --noEmit
          pnpm --filter @dentlink/ui exec eslint --no-eslintrc --config .eslintrc.cjs dlds-gallery tests vitest.config.ts
      - name: DLDS gallery build
        run: pnpm --filter @dentlink/ui exec vite build
```
