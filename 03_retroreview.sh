#!/bin/bash

# Usage: ./retroreview.sh "Review message" "2025-05-10T08:00:00"

REPO_DIR="."
BASE_BRANCH="master"
AUTHOR_NAME="Mike Niner"
AUTHOR_EMAIL="bravog.bot2@gmail.com"

REVIEW_MSG="$1"
REVIEW_DATE="$2"

if [ -z "$REVIEW_MSG" ] || [ -z "$REVIEW_DATE" ]; then
  echo "Usage: $0 \"Review message\" \"YYYY-MM-DDTHH:MM:SS\""
  exit 1
fi

cd "$REPO_DIR" || exit 1

# Nome da branch com timestamp
BRANCH_NAME="review-$(date +%s)"

# Cria branch e faz um commit vazio com data retroativa
git checkout -b "$BRANCH_NAME"
touch "reviewfile-$(date +%s).txt"
git add .
GIT_AUTHOR_DATE="$REVIEW_DATE" \
GIT_COMMITTER_DATE="$REVIEW_DATE" \
git commit -m "feat: add file for review" --author="$AUTHOR_NAME <$AUTHOR_EMAIL>"

git push origin "$BRANCH_NAME"

# Cria PR via GitHub CLI
gh pr create --base "$BASE_BRANCH" --head "$BRANCH_NAME" --title "$REVIEW_MSG" --body "$REVIEW_MSG"

# Aguarda a PR existir antes do review
sleep 3

# Aprova a PR (review) — será registrado no gráfico do GitHub
PR_NUMBER=$(gh pr list --head "$BRANCH_NAME" --json number -q '.[0].number')
if [ -n "$PR_NUMBER" ]; then
  echo "🔍 Reviewing PR #$PR_NUMBER..."
  gh pr review "$PR_NUMBER" --approve --body "$REVIEW_MSG"
else
  echo "❌ PR not found."
  exit 1
fi
