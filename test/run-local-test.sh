#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR/.."

# Load .env from repo root
if [ -f "$REPO_ROOT/.env" ]; then
  # Read .env file and export variables to child processes
  # shellcheck disable=SC1090
  set -a
  source "$REPO_ROOT/.env"
  set +a
else
  echo ".env not found at $REPO_ROOT/.env — continuing, relying on environment variables"
fi

# Build Docker image using Dockerfile from repo root
docker build -t publish-module-action -f "$REPO_ROOT/Dockerfile" "$REPO_ROOT"

# Run simple test
echo "Running simple test..."
bash "$SCRIPT_DIR/run-simple-test.sh"

# Run overwrite test
echo "Running overwrite test..."
bash "$SCRIPT_DIR/run-overwrite-test.sh"