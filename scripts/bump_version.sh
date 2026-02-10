#!/usr/bin/env bash
set -euo pipefail

# Usage:
# ./scripts/bump_version.sh release 1.2.3    -> set VERSION.txt to 1.2.3 and tag v1.2.3
# ./scripts/bump_version.sh feature         -> bump patch (x.y.z -> x.y.(z+1)) and update VERSION.txt

REPO_DIR="$(pwd)"
VERSION_FILE="$REPO_DIR/VERSION.txt"

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 <release|feature> [version]"
  exit 2
fi

MODE="$1"

git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"

if [ "$MODE" = "release" ]; then
  if [ -z "${2:-}" ]; then
    echo "Release mode requires a version argument, e.g. ./bump_version.sh release 1.2.3"
    exit 2
  fi
  NEW_VER="$2"
  echo "$NEW_VER" > "$VERSION_FILE"
  git add "$VERSION_FILE"
  git commit -m "chore(release): set version to $NEW_VER [ci skip]" || echo "No changes to commit"
  git tag -a "v$NEW_VER" -m "Release v$NEW_VER"
  git push origin --follow-tags
  echo "Released v$NEW_VER"
  exit 0
fi

if [ "$MODE" = "feature" ]; then
  if [ ! -f "$VERSION_FILE" ]; then
    echo "0.1.0" > "$VERSION_FILE"
  fi
  CUR_VER="$(cat "$VERSION_FILE" | tr -d ' \n\r')"
  IFS='.' read -r MAJOR MINOR PATCH <<< "$CUR_VER"
  if [ -z "$PATCH" ]; then
    PATCH=0
  fi
  PATCH=$((PATCH+1))
  NEW_VER="$MAJOR.$MINOR.$PATCH"
  echo "$NEW_VER" > "$VERSION_FILE"
  git add "$VERSION_FILE"
  git commit -m "chore(version): bump patch to $NEW_VER [ci skip]" || echo "No changes to commit"
  git push origin HEAD
  echo "Bumped version to $NEW_VER"
  exit 0
fi

echo "Unknown mode: $MODE"
exit 2
