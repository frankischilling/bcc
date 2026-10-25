#!/bin/sh
# Keep the existing host check names as gates for all parallel host lanes.
set -eu
if [ "$#" -ne 3 ]; then
    echo 'expected host, B-bootstrap, and assembly results' >&2
    exit 2
fi
printf 'host=%s B-bootstrap=%s assembly=%s\n' "$1" "$2" "$3"
for result in "$@"; do
    if [ "$result" != success ]; then
        echo 'all host lanes must finish successfully' >&2
        exit 1
    fi
done
