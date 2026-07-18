#!/usr/bin/env bash

set -e

cd "$(dirname "$0")/.."

echo "Starting emulator..."

NUM=${1:-4}
exec uv run python startEmul.py "$NUM"