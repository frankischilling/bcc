#!/usr/bin/env bash
# Keep the historical entry point; the Python runner checks every suite status.
set -eu
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
exec python3 "$ROOT/tests/run_suite.py" "$@"
