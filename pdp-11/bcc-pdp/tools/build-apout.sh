#!/bin/sh
set -eu
HERE="$(cd "$(dirname "$0")/.." && pwd)"
. "$HERE/tools/native-lock.sh"
cd "$HERE/../unix-v1/tools/apout"
make
