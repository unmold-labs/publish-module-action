#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR/.."

# Load .env from repo root
if [ -f "$REPO_ROOT/.env" ]; then
  # shellcheck disable=SC1090
  source "$REPO_ROOT/.env"
else
  echo ".env not found at $REPO_ROOT/.env — continuing, relying on environment variables"
fi

# Build Docker image using Dockerfile from repo root
docker build -t publish-module-action -f "$REPO_ROOT/Dockerfile" "$REPO_ROOT"

# Generate a short random suffix for the module name
RAND=$(date +%s%N | sed 's/[^0-9]*//g' | cut -c1-8)
MODULE_NAME="test-module-${RAND}"

# Run Docker container
docker run --rm \
  -e UNMOLD_API_TOKEN="$UNMOLD_API_TOKEN" \
  -v "$REPO_ROOT/test/modules":/modules:ro \
  publish-module-action "$MODULE_NAME" 1.0.0 --namespace=publish-module-action-e2e-test --system=test --module-path=/modules