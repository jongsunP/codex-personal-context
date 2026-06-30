#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
TARGET="$REPO_ROOT/AGENTS.md"
LINK="$CODEX_HOME/AGENTS.md"

if [[ ! -f "$TARGET" ]]; then
  echo "Missing AGENTS.md at $TARGET" >&2
  exit 1
fi

mkdir -p "$CODEX_HOME"

if git -C "$REPO_ROOT" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  git -C "$REPO_ROOT" pull --ff-only
fi

if [[ -L "$LINK" ]]; then
  current_target="$(readlink "$LINK")"
  if [[ "$current_target" == "$TARGET" ]]; then
    echo "$LINK already points to $TARGET"
    exit 0
  fi
  backup="$LINK.backup.$(date +%Y%m%d-%H%M%S)"
  mv "$LINK" "$backup"
  echo "Backed up existing symlink to $backup"
elif [[ -e "$LINK" ]]; then
  backup="$LINK.backup.$(date +%Y%m%d-%H%M%S)"
  mv "$LINK" "$backup"
  echo "Backed up existing file to $backup"
fi

ln -s "$TARGET" "$LINK"
echo "Linked $LINK -> $TARGET"
