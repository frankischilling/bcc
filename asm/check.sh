#!/usr/bin/env bash
set -eu
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
exec python3 "$ROOT/tests/run_suite.py" --compiler "${BCC:-$ROOT/asm/bccasm}"
