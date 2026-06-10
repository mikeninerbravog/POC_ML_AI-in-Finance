#!/bin/bash

set -e

echo "=================================="
echo "START"
echo "=================================="

if [ ! -f start_date.txt ]; then
    echo "ERROR: start_date.txt not found"
    exit 1
fi

echo "START_DATE: $(cat start_date.txt)"
echo

echo "[1/2] Generating contribution history..."
./02_contrib-m.sh

echo
echo "[2/2] Generating review history..."
./04_review-m.sh

echo
echo "DONE"
