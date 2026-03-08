#!/bin/bash

git remote set-url origin git@github.com:mikeninerbravog/POC_ML_AI-in-Finance.git

# Caminho para o script retroativo
RETRO_SCRIPT="./retroat.sh"
REPO_DIR="."
WORKDIR="$REPO_DIR/logs"
mkdir -p "$WORKDIR"

# Datas
START_DATE="2026-02-22"
END_DATE=$(date -d "yesterday" +%Y-%m-%d)
current="$START_DATE"

# Mensagens variadas de commit
MESSAGES=(
  "chore: update logic core"
  "fix: adjusted validation rules"
  "docs: improve readme"
  "refactor: cleanup helpers"
  "feat: add experimental mode"
  "test: add mock case"
  "build: update pipeline config"
  "ci: adjust deploy flow"
  "style: reindent script"
  "perf: improve response time"
)

# Loop até ontem
while [[ "$current" < "$END_DATE" ]]; do
  # Horário aleatório
  HOUR=$(shuf -i 8-18 -n 1)
  MIN=$(shuf -i 0-59 -n 1)
  SEC=$(shuf -i 0-59 -n 1)
  TIMESTAMP="${current}T$(printf "%02d:%02d:%02d" "$HOUR" "$MIN" "$SEC")"

  # Mensagem de commit aleatória
  COMMIT_MSG="${MESSAGES[$RANDOM % ${#MESSAGES[@]}]}"

  # Arquivo simulado
  FILE_NAME="update-$(echo "$current" | tr -d '-').txt"
  FILE_PATH="$WORKDIR/$FILE_NAME"

  echo "log: simulated change on $current" > "$FILE_PATH"

  echo "📅 Commit for $TIMESTAMP → $COMMIT_MSG"
  $RETRO_SCRIPT "$COMMIT_MSG" "$TIMESTAMP"
  sleep 1

  # Pular entre 2 e 10 dias
  SKIP_DAYS=$(shuf -i 2-10 -n 1)
  current=$(date -I -d "$current + $SKIP_DAYS days")
done
