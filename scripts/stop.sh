#!/usr/bin/env bash

set -e

echo "Stopping emulator..."

PIDS=$(pgrep -f "python.*startEmul.py" || true)

if [ -z "$PIDS" ]; then
    echo "No emulator running."
    exit 0
fi

echo "$PIDS" | xargs kill

echo "Stopped."