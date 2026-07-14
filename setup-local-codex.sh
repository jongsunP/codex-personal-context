#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
SYNC_PATHS=(
  "AGENTS.md"
  "AI_WORKFLOW.md"
  "BOOTSTRAP.md"
  "DECISION_FRAMEWORK.md"
  "DEVELOPMENT_STYLE.md"
  "FITNESS.md"
  "HANDOFF.md"
  "MEMORY_CHANGELOG.md"
  "PROFILE.md"
  "PROJECTS.md"
  "README.md"
  "SESSION_WORKFLOW.md"
  "VEHICLE.md"
  "projects/action-sports-journal-app.md"
  "projects/dentlink-client-invite.md"
  "projects/README.md"
)

if [[ ! -f "$REPO_ROOT/AGENTS.md" ]]; then
  echo "Missing AGENTS.md at $REPO_ROOT" >&2
  exit 1
fi

mkdir -p "$CODEX_HOME"

if git -C "$REPO_ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git -C "$REPO_ROOT" pull --ff-only
fi

for rel_path in "${SYNC_PATHS[@]}"; do
  source_path="$REPO_ROOT/$rel_path"
  target_path="$CODEX_HOME/$rel_path"

  if [[ ! -e "$source_path" ]]; then
    echo "Skipping missing $source_path"
    continue
  fi

  mkdir -p "$(dirname "$target_path")"

  if [[ "$source_path" == "$target_path" ]]; then
    echo "$rel_path already lives in $CODEX_HOME"
    continue
  fi

  if [[ -e "$target_path" ]] && ! cmp -s "$source_path" "$target_path"; then
    backup="$target_path.backup.$(date +%Y%m%d-%H%M%S)"
    cp -p "$target_path" "$backup"
    echo "Backed up existing $target_path to $backup"
  fi

  cp -p "$source_path" "$target_path"
  echo "Synced $rel_path to $CODEX_HOME"
done

echo "Codex personal context synced from $REPO_ROOT to $CODEX_HOME"
