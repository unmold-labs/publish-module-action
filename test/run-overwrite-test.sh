#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR/.."

RAND=$(openssl rand -hex 4)
MODULE_NAME="overwrite-test-module-${RAND}"

# Create a fixture module
docker run --rm \
  -e UNMOLD_API_TOKEN="$UNMOLD_API_TOKEN" \
  -v "$REPO_ROOT/test/fixture-module":/module:ro \
  publish-module-action "$MODULE_NAME" 1.0.0 --system=test --module-path=/module

# Overwrite the module with the same version
docker run --rm \
  -e UNMOLD_API_TOKEN="$UNMOLD_API_TOKEN" \
  -v "$REPO_ROOT/test/fixture-module":/module:ro \
  publish-module-action "$MODULE_NAME" 1.0.0 --system=test --module-path=/module --overwrite=true