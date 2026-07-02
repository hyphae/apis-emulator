#!/usr/bin/env bash

set -e

cd "$(dirname "$0")/.."

echo "Setting up APIS Emulator..."

if ! command -v uv >/dev/null 2>&1; then
    echo "uv is not installed."
    exit 1
fi

uv python install 3.12

uv python pin 3.12

uv venv

uv sync

echo
echo "Setup completed."