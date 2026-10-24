#!/bin/sh
# Force a clean rebuild of pdp-11/unix-v1 disk images so newly-installed
# binaries under fs/ make it onto the rk0.dsk / rf0.dsk filesystems.
set -eu
HERE="$(cd "$(dirname "$0")/.." && pwd)"
. "$HERE/tools/native-lock.sh"
cd "$HERE/../unix-v1/build"
rm -rf root usr protofs rk0.dsk rf0.dsk
make protofs unix
python3 "$HERE/tools/prepare_v1_tools.py" root
make install

# The pinned mkfs leaves swap/kernel bits free. Refuse file overlap, then
# reserve those blocks before publishing the image used by SIMH.
python3 "$HERE/tools/v1_image.py" rf0.dsk --reserve
cp rf0.dsk ../images/rf0.dsk
