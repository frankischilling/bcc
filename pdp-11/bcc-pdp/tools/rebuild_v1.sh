#!/bin/sh
# Force a clean rebuild of pdp-11/unix-v1 disk images so newly-installed
# binaries under fs/ make it onto the rk0.dsk / rf0.dsk filesystems.
set -eu
HERE="$(cd "$(dirname "$0")/.." && pwd)"
cd "$HERE/../unix-v1/build"
rm -rf root usr protofs rk0.dsk rf0.dsk
make install
