#!/bin/bash

# Usage: ./retroat.sh "Your commit message" "2025-05-10T08:00:00"

# CONFIG
REPO_DIR="."
BRANCH="master"
AUTHOR_NAME="Mike Niner"
AUTHOR_EMAIL="bravog.bot2@gmail.com"

# PARAMS
COMMIT_MSG="$1"
COMMIT_DATE="$2"

# VALIDATE
if [ -z "$COMMIT_MSG" ] || [ -z "$COMMIT_DATE" ]; then
  echo "Usage: $0 \"Commit message\" \"YYYY-MM-DDTHH:MM:SS\""
  exit 1
fi

# EXECUTION
cd "$REPO_DIR" || { echo "❌ Repo not found: $REPO_DIR"; exit 1; }

echo "📁 Inside repo: $REPO_DIR"
echo "🕰️  Commit date: $COMMIT_DATE"
echo "📝 Message: $COMMIT_MSG"

# STAGE CHANGES
git add .

# FORCE COMMIT (even if nothing changed)
GIT_AUTHOR_DATE="$COMMIT_DATE" \
GIT_COMMITTER_DATE="$COMMIT_DATE" \
git commit --allow-empty -m "$COMMIT_MSG" --author="$AUTHOR_NAME <$AUTHOR_EMAIL>"

# FORCE PUSH
git push origin "$BRANCH" --force
