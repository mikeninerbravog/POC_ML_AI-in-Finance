#!/bin/bash

REVIEW_SCRIPT="./retroreview.sh"
START_DATE="2025-03-03"
END_DATE=$(date -d "yesterday" +%Y-%m-%d)
current="$START_DATE"

MESSAGES=(
  "Looks good overall"
  "Approved with minor suggestions"
  "Clear structure, no blockers"
  "LGTM"
  "Can merge. Well done!"
)

while [[ "$current" < "$END_DATE" ]]; do
  HOUR=$(shuf -i 8-18 -n 1)
  MIN=$(shuf -i 0-59 -n 1)
  SEC=$(shuf -i 0-59 -n 1)
  TIMESTAMP="${current}T$(printf "%02d:%02d:%02d" "$HOUR" "$MIN" "$SEC")"
  REVIEW_MSG="${MESSAGES[$RANDOM % ${#MESSAGES[@]}]}"

  echo "📄 Review at $TIMESTAMP → $REVIEW_MSG"
  $REVIEW_SCRIPT "$REVIEW_MSG" "$TIMESTAMP"

  SKIP_DAYS=$(shuf -i 2-6 -n 1)
  current=$(date -I -d "$current + $SKIP_DAYS days")
  sleep 2
done
