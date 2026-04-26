#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR/.."

RAND=$(openssl rand -hex 4)
MODULE_NAME="simple-test-module-${RAND}"

# Run Docker container
docker run --rm \
  -e UNMOLD_API_TOKEN="$UNMOLD_API_TOKEN" \
  -v "$REPO_ROOT/test/fixture-module":/module:ro \
  publish-module-action "$MODULE_NAME" 1.0.0 --system=test --module-path=/module